#include "../../define.as"
#include "../../unit.as"
#include "../../task.as"
#include "../../global.as"
#include "../../settings/shared/stealth_scout.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/spatial/map_helpers.as"

// Stealth land scouts (owner, 2026-11-16). Spy bots (armspy Ghost, corspy
// Spectre, legaspy Eidolon) and Gremlins (armgremlin) are radar-stealthy and
// cloak; native CScoutTask sends them at enemy contacts and into turrets.
// Here each one goes where the ally team has not looked for the longest:
//
//  - a last-seen map: the ally team's line of sight (allied air scouts and
//    sweeps, spam units, everyone's units) sampled per SectorElmos sector,
//    every sector every ScanSeconds;
//  - targets on the enemy side only, weighted to the back (beyond their
//    starts) and to the map border behind them, spread between our scouts;
//  - only land the unit's own move type reaches (aiTerrainMgr.CanMoveTo);
//  - routes from aiBattle.GetUnitRaidRoute with observed armed coverage and
//    unidentified radar dots hard-avoided (ScoutRaid's threat-aware router),
//    a hold and replan when coverage appears ahead, an escape when inside;
//  - hold fire; the native finish rule keeps the cloak on (logged).
//
// Cost per AI: last-seen scan O(sectors*5/ScanSeconds) LOS lookups per second
// (a 24x24 map: ~480/s); per scout per second O(G) contact checks and
// O(lookahead) hazard lookups; at most MaxRoutesPerSecond route solves.
// Commands: one compacted MOVE window per replan/window, a fire state every
// FireResendSeconds when the task changed. No cross-AI messages.
namespace StealthScout {
    final class Scout {
        int id = -1;
        CRouteTask@ task;
        int defIndex = -1;          // index in Global::StealthScout::Units
        int sector = -1;            // goal sector, -1 = none
        AIFloat3 goal;
        int goalFrame = 0;          // when the goal was given
        array<AIFloat3> route;
        uint cursor = 0, issuedEnd = 0;
        int lastWindow = -100000;
        AIFloat3 lastPos;
        int lastMove = 0;
        int nextReplan = 0;
        bool queued = false;
        bool escaping = false, inside = false, holding = false;
        float lastHealth = 1.0f;
        int admitted = 0;
        int goalsReached = 0;
        int lastRisk = -100000;
        int lastTrack = -100000;
        int fireSent = -100000;
        IUnitTask@ fireTask;
        int routeFailures = 0;
        int holdSince = -1;         // waiting for a contact ahead to move on
        int retreatUntil = 0;       // after a hit: pull back at least until this frame
        int lastDetourLog = -100000;
    }

    array<Scout@> scouts;
    array<int> replanQueue;
    int lastTick = -100000, lastSummary = 0;
    bool unitsReady = false;
    dictionary unitIndex;

    // Last-seen map.
    int cols = 0, rows = 0, scanCursor = 0;
    array<int> lastSeen;        // frame the sector was last in ally LOS, -1 never
    array<int> unreachableUntil;
    int reached = 0, lost = 0, hits = 0, risks = 0, planned = 0;

    bool Active() { return Global::StealthScout::Enabled; }

    int DefIndex(const CCircuitDef@ d)
    {
        if (d is null) return -1;
        if (!unitsReady) {
            for (uint i = 0; i < Global::StealthScout::Units.length(); ++i) unitIndex.set(Global::StealthScout::Units[i], int(i));
            unitsReady = true;
        }
        int i = -1;
        return unitIndex.get(d.GetName(), i) ? i : -1;
    }

    bool Owns(int id)
    {
        for (uint i = 0; i < scouts.length(); ++i) if (scouts[i].id == id) return true;
        return false;
    }

    Scout@ Find(int id)
    {
        for (uint i = 0; i < scouts.length(); ++i) if (scouts[i].id == id) return scouts[i];
        return null;
    }

    // ---------------- last-seen map ----------------

    void InitGrid()
    {
        if (cols > 0) return;
        const float s = Global::StealthScout::SectorElmos;
        const int si = AiMax(64, int(s));
        cols = AiMax(1, (int(AiTerrainWidth()) + si - 1) / si);
        rows = AiMax(1, (int(AiTerrainHeight()) + si - 1) / si);
        lastSeen.resize(cols * rows);
        unreachableUntil.resize(cols * rows);
        for (uint i = 0; i < lastSeen.length(); ++i) { lastSeen[i] = -1; unreachableUntil[i] = 0; }
        GenericHelpers::LogUtil("[StealthScout] last-seen map " + cols + "x" + rows + " sectors of " + int(s), 1);
    }

    AIFloat3 Centre(int sector)
    {
        const float s = Global::StealthScout::SectorElmos;
        AIFloat3 p(AiMin(float(AiTerrainWidth()) - 64.0f, (float(sector % cols) + 0.5f) * s), 0.0f,
                   AiMin(float(AiTerrainHeight()) - 64.0f, (float(sector / cols) + 0.5f) * s));
        p.y = aiBattle.Height(p);
        return p;
    }

    int SectorAt(const AIFloat3& in p)
    {
        if (cols <= 0) return -1;
        const float s = Global::StealthScout::SectorElmos;
        const int x = AiMax(0, AiMin(cols - 1, int(p.x / s)));
        const int z = AiMax(0, AiMin(rows - 1, int(p.z / s)));
        return z * cols + x;
    }

    // Centre and 4 points at a quarter sector: a sector partly in sight counts.
    void Scan()
    {
        const int n = cols * rows;
        const int per = AiMax(1, (n + Global::StealthScout::ScanSeconds - 1) / AiMax(1, Global::StealthScout::ScanSeconds));
        const float q = Global::StealthScout::SectorElmos * 0.25f;
        for (int k = 0; k < per; ++k) {
            const int i = scanCursor;
            scanCursor = (scanCursor + 1) % n;
            const AIFloat3 c = Centre(i);
            if (aiBattle.InLos(c) || aiBattle.InLos(c + AIFloat3(q, 0.0f, q)) || aiBattle.InLos(c + AIFloat3(-q, 0.0f, q))
                || aiBattle.InLos(c + AIFloat3(q, 0.0f, -q)) || aiBattle.InLos(c + AIFloat3(-q, 0.0f, -q)))
                lastSeen[i] = ai.frame;
        }
    }

    float StaleSeconds(int sector)
    {
        const int cap = Global::StealthScout::StaleCapSeconds;
        if (lastSeen[sector] < 0) return float(cap);
        return AiMin(float(cap), float(ai.frame - lastSeen[sector]) / float(SECOND));
    }

    // ---------------- targets ----------------

    AIFloat3 Mean(const array<AIFloat3>& in pts)
    {
        AIFloat3 m(0.0f, 0.0f, 0.0f);
        if (pts.length() == 0) return AIFloat3(-1.0f, 0.0f, -1.0f);
        for (uint i = 0; i < pts.length(); ++i) m = m + pts[i];
        return m * (1.0f / float(pts.length()));
    }

    float BorderDistance(const AIFloat3& in p)
    {
        return AiMin(AiMin(p.x, float(AiTerrainWidth()) - p.x), AiMin(p.z, float(AiTerrainHeight()) - p.z));
    }

    bool NearContact(const AIFloat3& in p, float radius)
    {
        const int n = aiBattle.GetGroundContactCount();
        for (int i = 0; i < n; ++i)
            if (MapHelpers::SqDist(p, aiBattle.GetGroundContactPos(i)) <= radius * radius) return true;
        return false;
    }

    bool Safe(const AIFloat3& in p)
    {
        return !NearContact(p, Global::StealthScout::ContactKeepOut);
    }

    // Observed enemy ground contacts within r of p (O(G)); reused buffer.
    array<AIFloat3> nearBuf;
    void Collect(const AIFloat3& in p, float r)
    {
        nearBuf.resize(0);
        const int n = aiBattle.GetGroundContactCount();
        for (int i = 0; i < n; ++i) {
            const AIFloat3 c = aiBattle.GetGroundContactPos(i);
            if (MapHelpers::SqDist(p, c) <= r * r) nearBuf.insertLast(c);
        }
    }

    float NearestIn(const AIFloat3& in p, int& out index)
    {
        float best = 1e30f;
        index = -1;
        for (uint i = 0; i < nearBuf.length(); ++i) {
            const float d = MapHelpers::SqDist(p, nearBuf[i]);
            if (d < best) { best = d; index = int(i); }
        }
        return index >= 0 ? sqrt(best) : 1e30f;
    }

    // Straight leg a->b keeps r from every collected contact (samples every 64 elmos).
    bool LegClear(const AIFloat3& in a, const AIFloat3& in b, float r)
    {
        const int steps = AiMax(1, int(a.distance2D(b) / 64.0f));
        int k;
        for (int i = 1; i <= steps; ++i) {
            const AIFloat3 p = a + (b - a) * (float(i) / float(steps));
            if (NearestIn(p, k) < r) return false;
        }
        return true;
    }

    bool InMap(const AIFloat3& in p)
    {
        return p.x >= 64.0f && p.z >= 64.0f && p.x <= float(AiTerrainWidth()) - 64.0f && p.z <= float(AiTerrainHeight()) - 64.0f;
    }

    // A reachable, safe point of the sector for this unit's move type: the
    // centre, else rings of 96 elmos (16 bearings) inside the sector.
    bool SnapInSector(CCircuitUnit@ u, int sector, AIFloat3& out p)
    {
        const AIFloat3 c = Centre(sector);
        p = c;
        if (InMap(c) && aiTerrainMgr.CanMoveTo(u, c) && Safe(c)) return true;
        const int rings = AiMax(1, int(Global::StealthScout::SectorElmos * 0.5f / 96.0f));
        for (int ring = 1; ring <= rings; ++ring) {
            for (int k = 0; k < 16; ++k) {
                const float a = float(k) * 0.392699f;
                AIFloat3 q = c + AIFloat3(cos(a), 0.0f, sin(a)) * float(ring * 96);
                if (!InMap(q) || !aiTerrainMgr.CanMoveTo(u, q) || !Safe(q)) continue;
                q.y = aiBattle.Height(q);
                p = q;
                return true;
            }
        }
        return false;
    }

    // Best stale enemy-side sector this scout can reach; -1 none.
    int ChooseSector(Scout@ s, CCircuitUnit@ u, const AIFloat3& in pos, AIFloat3& out goal, float& out score, float& out stale)
    {
        goal = pos; score = 0.0f; stale = 0.0f;
        const array<AIFloat3> enemy = Lanes::EnemyStarts();
        const array<AIFloat3> ours = Lanes::AllyStarts();
        const AIFloat3 e = Mean(enemy);
        AIFloat3 a = Mean(ours);
        if (e.x < 0.0f) return -1;
        if (a.x < 0.0f) a = Global::Map::StartPos;
        AIFloat3 axis = e - a; axis.y = 0.0f;
        const float len = AiMax(1.0f, axis.Length2D());
        axis = axis * (1.0f / len);
        const int n = cols * rows;
        // Top Candidates by score; reach and threat are checked only for them.
        const int want = AiMax(1, Global::StealthScout::Candidates);
        array<int> bestIdx;
        array<float> bestScore;
        for (int i = 0; i < n; ++i) {
            if (i == s.sector && s.routeFailures > 0) continue;
            if (ai.frame < unreachableUntil[i]) continue;
            if (int(hotUntil.length()) == n && ai.frame < hotUntil[i]) continue;
            const float st = StaleSeconds(i);
            if (st < float(Global::StealthScout::MinStaleSeconds)) continue;
            const AIFloat3 c = Centre(i);
            AIFloat3 rel = c - a; rel.y = 0.0f;
            const float side = (rel.x * axis.x + rel.z * axis.z) / len;
            if (side < Global::StealthScout::SideMin) continue;
            float w = st;
            const float back = AiMax(0.0f, AiMin(1.0f, (side - 1.0f) * 2.0f));
            w *= 1.0f + Global::StealthScout::BackWeight * AiMax(0.0f, AiMin(1.0f, (side - 0.8f) / 0.7f));
            if (back > 0.0f) {
                const float edge = 1.0f - AiMin(1.0f, BorderDistance(c) / AiMax(1.0f, Global::StealthScout::EdgeElmos));
                w *= 1.0f + Global::StealthScout::EdgeWeight * edge;
            }
            w /= 1.0f + pos.distance2D(c) / AiMax(1.0f, Global::StealthScout::DistanceElmos);
            const float cr = Global::StealthScout::ClaimRadius;
            for (uint k = 0; k < scouts.length(); ++k) {
                if (scouts[k] is s || scouts[k].sector < 0) continue;
                if (MapHelpers::SqDist(scouts[k].goal, c) <= cr * cr) { w *= Global::StealthScout::ClaimFactor; break; }
            }
            // keep the list sorted, best first
            uint at = bestScore.length();
            while (at > 0 && bestScore[at - 1] < w) --at;
            if (int(at) >= want) continue;
            bestIdx.insertAt(at, i); bestScore.insertAt(at, w);
            if (int(bestIdx.length()) > want) { bestIdx.removeLast(); bestScore.removeLast(); }
        }
        for (uint k = 0; k < bestIdx.length(); ++k) {
            AIFloat3 p;
            if (!SnapInSector(u, bestIdx[k], p)) continue;
            goal = p; score = bestScore[k]; stale = StaleSeconds(bestIdx[k]);
            return bestIdx[k];
        }
        return -1;
    }

    // Nearest clear ground (no coverage, no contact) for an escape; rings of
    // 128 elmos, 16 bearings, starting away from the nearest contact.
    bool EscapePoint(CCircuitUnit@ u, const AIFloat3& in pos, AIFloat3& out p)
    {
        p = pos;
        float base = 0.0f, best = 1e30f;
        const int n = aiBattle.GetGroundContactCount();
        for (int i = 0; i < n; ++i) {
            const AIFloat3 c = aiBattle.GetGroundContactPos(i);
            const float d = MapHelpers::SqDist(pos, c);
            if (d < best) { best = d; base = atan2(pos.z - c.z, pos.x - c.x); }
        }
        for (int ring = 1; ring <= 12; ++ring) {
            for (int k = 0; k < 16; ++k) {
                const int j = (k % 2 == 0) ? k / 2 : -(k + 1) / 2;   // 0, -1, 1, -2, 2 ... around the away bearing
                const float a = base + float(j) * 0.392699f;
                AIFloat3 q = pos + AIFloat3(cos(a), 0.0f, sin(a)) * float(ring * 128);
                if (!InMap(q) || !aiTerrainMgr.CanMoveTo(u, q) || NearContact(q, Global::StealthScout::ProxRadius * 1.5f)) continue;
                q.y = aiBattle.Height(q);
                p = q;
                return true;
            }
        }
        return false;
    }

    // Step round the contact c nearest waypoint k: corners either side of it at
    // 1.4-3x ProxRadius (also pushed along the route), the first whose legs from
    // the scout and on to waypoint k+1 keep the gap. O(24 * leg/64 * nearby contacts).
    bool Detour(Scout@ s, CCircuitUnit@ u, const AIFloat3& in pos, uint k, int c)
    {
        const float r = Global::StealthScout::ProxRadius;
        const AIFloat3 blocker = nearBuf[uint(c)];
        const AIFloat3 next = (k + 1 < s.route.length()) ? s.route[k + 1] : s.route[k];
        AIFloat3 dir = next - pos; dir.y = 0.0f;
        const float len = dir.Length2D();
        if (len < 1.0f) return false;
        dir = dir * (1.0f / len);
        const AIFloat3 side(-dir.z, 0.0f, dir.x);
        for (int m = 0; m < 4; ++m) for (int sgn = -1; sgn <= 1; sgn += 2) for (int f = 0; f <= 2; ++f) {
            AIFloat3 d = blocker + side * (float(sgn) * r * (1.4f + 0.55f * float(m))) + dir * (float(f) * r * 0.6f);
            if (!InMap(d) || !aiTerrainMgr.CanMoveTo(u, d)) continue;
            if (!LegClear(pos, d, r) || !LegClear(d, next, r)) continue;
            d.y = aiBattle.Height(d);
            array<AIFloat3> route = {d};
            for (uint i = k + 1; i < s.route.length(); ++i) route.insertLast(s.route[i]);
            s.route = route; s.cursor = 0;
            IssueWindow(s);
            return true;
        }
        return false;
    }

    // ---------------- routes ----------------

    CRouteTask@ NewRoute()
    {
        IUnitTask@ task = aiMilitaryMgr.Enqueue(TaskF::Route());
        CRouteTask@ route = cast<CRouteTask>(cast<IFighterTask>(task));
        if (route is null) return null;
        route.SetTraversal(true, 48.0f, false);
        route.SetHoldPosition(true);   // never chase anything
        route.SetLanes(1, 0, 0);
        return route;
    }

    void IssueWindow(Scout@ s)
    {
        const int cap = Global::StealthScout::MaxIssuedWaypoints;
        const uint total = s.route.length();
        array<AIFloat3> window;
        uint end = total;
        if (cap > 0 && s.cursor + uint(cap) < total) end = s.cursor + uint(cap);
        for (uint i = s.cursor; i < end; ++i) window.insertLast(s.route[i]);
        if (window.length() == 0) return;
        s.task.SetRoute(window);
        s.issuedEnd = end;
        s.lastWindow = ai.frame;
    }

    void Hold(Scout@ s, const AIFloat3& in pos)
    {
        array<AIFloat3> hold = {pos};
        s.task.SetRoute(hold);
        s.route.resize(0); s.cursor = 0; s.issuedEnd = 0;
    }

    void Queue(Scout@ s)
    {
        if (s.queued) return;
        s.queued = true;
        replanQueue.insertLast(s.id);
    }

    // ---------------- flank routes ----------------
    // Headless 11-16 v2: scouts crossing the middle of an 8v8 front were walked
    // into (decloaked) and killed within 1-2 min. A route via the map's lateral
    // border (both sides tried) is taken when its enemy density is lower.
    // density[]: observed enemy ground contacts per sector, rebuilt once per
    // second while this AI has scouts (O(G)); hotUntil[]: sectors where one of
    // our scouts was hit, avoided by routes and targets for HotSeconds.
    array<int> density;
    array<int> hotUntil;

    void RebuildDensity()
    {
        const int n = cols * rows;
        if (int(density.length()) != n) { density.resize(n); hotUntil.resize(n); for (int i = 0; i < n; ++i) hotUntil[i] = 0; }
        for (int i = 0; i < n; ++i) density[i] = 0;
        const int g = aiBattle.GetGroundContactCount();
        for (int i = 0; i < g; ++i) {
            const int s = SectorAt(aiBattle.GetGroundContactPos(i));
            if (s >= 0) ++density[s];
        }
    }

    float CellRisk(const AIFloat3& in p)
    {
        const int s = SectorAt(p);
        if (s < 0) return 0.0f;
        const int x = s % cols, z = s / cols;
        float r = 0.0f;
        for (int dz = -1; dz <= 1; ++dz) for (int dx = -1; dx <= 1; ++dx) {
            const int xx = x + dx, zz = z + dz;
            if (xx < 0 || zz < 0 || xx >= cols || zz >= rows) continue;
            const int k = zz * cols + xx;
            r += float(density[k]) * ((dx == 0 && dz == 0) ? 1.0f : 0.35f);
            if (ai.frame < hotUntil[k]) r += (dx == 0 && dz == 0) ? 20.0f : 6.0f;
        }
        if (aiBattle.GroundHazard(p, 0.0f) > 0.0f) r += 2.0f;
        return r;
    }

    float LineRisk(const array<AIFloat3>& in pts)
    {
        float r = 0.0f, len = 0.0f;
        for (uint i = 1; i < pts.length(); ++i) {
            const float d = pts[i - 1].distance2D(pts[i]);
            len += d;
            const int steps = AiMax(1, int(d / 256.0f));
            for (int k = 1; k <= steps; ++k) r += CellRisk(pts[i - 1] + (pts[i] - pts[i - 1]) * (float(k) / float(steps)));
        }
        return r + len / Global::StealthScout::FlankLengthElmos;
    }

    bool SnapNear(CCircuitUnit@ u, const AIFloat3& in at, AIFloat3& out p)
    {
        p = at;
        for (int ring = 0; ring <= 6; ++ring) for (int k = 0; k < (ring == 0 ? 1 : 12); ++k) {
            const float a = float(k) * 0.523599f;
            AIFloat3 q = at + AIFloat3(cos(a), 0.0f, sin(a)) * float(ring * 128);
            if (!InMap(q) || !aiTerrainMgr.CanMoveTo(u, q)) continue;
            q.y = aiBattle.Height(q);
            p = q;
            return true;
        }
        return false;
    }

    // Our starts' centre -> theirs, unit length; false when the starts are unknown.
    bool Axis(AIFloat3& out ours, AIFloat3& out axis, float& out len)
    {
        const array<AIFloat3> enemy = Lanes::EnemyStarts();
        const AIFloat3 e = Mean(enemy);
        ours = Mean(Lanes::AllyStarts());
        if (ours.x < 0.0f) ours = Global::Map::StartPos;
        axis = e - ours; axis.y = 0.0f;
        len = axis.Length2D();
        if (e.x < 0.0f || len < 1.0f) return false;
        axis = axis * (1.0f / len);
        return true;
    }

    // A flank path pos -> border -> border -> goal when it is clearly safer than
    // the straight line; null keeps the direct route. Up to 3 route solves.
    array<AIFloat3>@ FlankRoute(CCircuitUnit@ u, const AIFloat3& in pos, const AIFloat3& in goal, string& out via)
    {
        via = "direct";
        if (!Global::StealthScout::FlankEnabled || int(density.length()) != cols * rows) return null;
        AIFloat3 ours, axis; float len;
        if (!Axis(ours, axis, len)) return null;
        const AIFloat3 c(float(AiTerrainWidth()) * 0.5f, 0.0f, float(AiTerrainHeight()) * 0.5f);
        const AIFloat3 perp(-axis.z, 0.0f, axis.x);
        const float lp = (pos.x - c.x) * axis.x + (pos.z - c.z) * axis.z;
        const float lg = (goal.x - c.x) * axis.x + (goal.z - c.z) * axis.z;
        if (abs(lg - lp) < Global::StealthScout::FlankMinElmos) return null;
        array<AIFloat3> direct = {pos, goal};
        const float directRisk = LineRisk(direct);
        float best = directRisk * Global::StealthScout::FlankRatio;
        array<AIFloat3> chosen;
        for (int sgn = -1; sgn <= 1; sgn += 2) {
            float t = 0.0f;
            while (t < 30000.0f && InMap(c + perp * (float(sgn) * (t + 256.0f)))) t += 256.0f;
            const float lat = AiMax(0.0f, t - Global::StealthScout::FlankInsetElmos) * float(sgn);
            AIFloat3 v1, v2;
            if (!SnapNear(u, c + axis * lp + perp * lat, v1) || !SnapNear(u, c + axis * lg + perp * lat, v2)) continue;
            array<AIFloat3> line = {pos, v1, v2, goal};
            const float risk = LineRisk(line);
            if (risk < best) { best = risk; chosen = line; via = sgn < 0 ? "flank-a" : "flank-b"; }
        }
        if (chosen.length() == 0) { via = "direct"; return null; }
        array<AIFloat3> path;
        for (uint i = 1; i < chosen.length(); ++i) {
            array<AIFloat3>@ leg = aiBattle.GetUnitRaidRoute(u.circuitDef, chosen[i - 1], chosen[i],
                Global::StealthScout::HazardMargin, Global::StealthScout::HazardWeight, false);
            if (leg is null || leg.length() < 2) { via = "direct"; return null; }
            for (uint k = (i == 1 ? 0 : 1); k < leg.length(); ++k) path.insertLast(leg[k]);
        }
        via += " risk=" + int(best) + "/" + int(directRisk);
        return path;
    }

    void MarkHot(const AIFloat3& in p, int seconds)
    {
        const int s = SectorAt(p);
        if (s < 0 || int(hotUntil.length()) != cols * rows) return;
        const int x = s % cols, z = s / cols;
        for (int dz = -1; dz <= 1; ++dz) for (int dx = -1; dx <= 1; ++dx) {
            const int xx = x + dx, zz = z + dz;
            if (xx < 0 || zz < 0 || xx >= cols || zz >= rows) continue;
            hotUntil[zz * cols + xx] = AiMax(hotUntil[zz * cols + xx], ai.frame + seconds * SECOND);
        }
    }

    void Plan(Scout@ s, CCircuitUnit@ u)
    {
        s.queued = false;
        const AIFloat3 pos = u.GetPos(ai.frame);
        s.lastPos = pos; s.lastMove = ai.frame;
        const float margin = Global::StealthScout::HazardMargin;
        s.escaping = false; s.holdSince = -1;   // an evade or a wait ends with a plan
        AIFloat3 goal;
        string why;
        if (s.escaping) {
            if (!EscapePoint(u, pos, goal)) { s.nextReplan = ai.frame + 2 * SECOND; return; }
            why = "escape";
        } else {
            float score = 0.0f, stale = 0.0f;
            const bool keep = s.sector >= 0 && s.routeFailures == 0
                && ai.frame - s.goalFrame < Global::StealthScout::GoalTimeoutSeconds * SECOND
                && (lastSeen[s.sector] < s.goalFrame) && Safe(s.goal);
            if (keep) { goal = s.goal; why = "resume"; }
            else {
                const int sector = ChooseSector(s, u, pos, goal, score, stale);
                if (sector < 0) {
                    if (s.sector >= 0 || s.holding == false)
                        GenericHelpers::LogUtil("[StealthScout] no target unit=" + s.id + " at (" + int(pos.x) + "," + int(pos.z) + "); holding", 1);
                    s.sector = -1; s.holding = true;
                    Hold(s, pos);
                    s.nextReplan = ai.frame + 15 * SECOND;
                    return;
                }
                s.holding = false;
                s.sector = sector; s.goal = goal; s.goalFrame = ai.frame;
                why = "target sector=" + sector + " stale=" + int(stale) + "s score=" + int(score);
            }
        }
        const bool hard = Global::StealthScout::HardAvoid;
        string via = "direct";
        array<AIFloat3>@ path = FlankRoute(u, pos, goal, via);
        if (path is null) @path = aiBattle.GetUnitRaidRoute(u.circuitDef, pos, goal, margin, Global::StealthScout::HazardWeight, hard);
        bool soft = !hard;
        if (hard && (path is null || path.length() < 2)) {
            // Hard avoidance found no way round: cost coverage instead of
            // forbidding it. Still nothing: the sector is put aside.
            @path = aiBattle.GetUnitRaidRoute(u.circuitDef, pos, goal, margin, Global::StealthScout::HazardWeight, false);
            soft = true;
        }
        why += " via=" + via;
        if (path is null || path.length() < 2) {
            ++s.routeFailures;
            if (s.sector >= 0) unreachableUntil[s.sector] = ai.frame + Global::StealthScout::UnreachableForgetSeconds * SECOND;
            GenericHelpers::LogUtil("[StealthScout] no route unit=" + s.id + " " + why + " goal=(" + int(goal.x) + "," + int(goal.z)
                + "); sector put aside", 1);
            s.sector = -1;
            Hold(s, pos);
            s.nextReplan = ai.frame + AiMin(60, Global::StealthScout::ReplanCooldownSeconds * (1 << AiMin(4, s.routeFailures))) * SECOND;
            return;
        }
        s.routeFailures = 0;
        s.route = ScoutRaid::Compact(path);
        s.cursor = 0;
        IssueWindow(s);
        s.nextReplan = ai.frame + Global::StealthScout::ReplanCooldownSeconds * SECOND;
        ++planned;
        GenericHelpers::LogUtil("[StealthScout] route unit=" + s.id + " def=" + u.circuitDef.GetName() + " " + why
            + " from=(" + int(pos.x) + "," + int(pos.z) + ") goal=(" + int(goal.x) + "," + int(goal.z) + ") points=" + s.route.length()
            + " dist=" + int(pos.distance2D(goal)) + (soft ? "" : " hard"), 1);
    }

    // ---------------- admission ----------------

    void HoldFire(Scout@ s, CCircuitUnit@ u, bool force)
    {
        if (!Global::StealthScout::HoldFire) return;
        if (!force && u.task is s.fireTask && ai.frame - s.fireSent < Global::StealthScout::FireResendSeconds * SECOND) return;
        u.SetFireState(0);
        s.fireSent = ai.frame; @s.fireTask = u.task;
    }

    // Military::AiMakeTask, before ScoutRaid.
    IUnitTask@ MilitaryMakeTask(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null || !Active()) return null;
        const int di = DefIndex(u.circuitDef);
        if (di < 0) return null;
        InitGrid();
        Scout@ old = Find(u.id);
        const bool readmit = old !is null;
        if (readmit) Drop(uint(scouts.findByRef(old)));
        if (int(scouts.length()) >= Global::StealthScout::MaxScouts) return null;
        CRouteTask@ task = NewRoute();
        if (task is null) return null;
        Scout s;
        s.id = u.id; @s.task = task; s.defIndex = di;
        s.lastPos = u.GetPos(ai.frame); s.lastMove = ai.frame; s.admitted = ai.frame;
        s.lastHealth = u.GetHealthPercent();
        array<AIFloat3> hold = {s.lastPos};
        task.SetRoute(hold);
        scouts.insertLast(s);
        Queue(s);
        const float cost = (di < int(Global::StealthScout::CloakCost.length())) ? Global::StealthScout::CloakCost[di] : 0.0f;
        const float energy = Economy::GetMinEnergyIncomeLast10s();
        GenericHelpers::LogUtil("[StealthScout] admit unit=" + u.id + " def=" + u.circuitDef.GetName() + " scouts=" + scouts.length()
            + " cloakCost=" + int(cost) + " energyIncome=" + int(energy) + (cost < energy * 0.1f ? " cloak=native-on" : " cloak=LIKELY-OFF")
            + (readmit ? " (re-admit)" : ""), 1);
        return task;
    }

    void Drop(uint index, bool abort = true)
    {
        Scout@ s = scouts[index];
        const int q = replanQueue.find(s.id);
        if (q >= 0) replanQueue.removeAt(uint(q));
        CRouteTask@ task = s.task;
        scouts.removeAt(index);
        if (abort && task !is null && !task.IsDead()) task.Abort();
    }

    void TaskRemoved(IUnitTask@ task)
    {
        for (uint i = 0; i < scouts.length(); ++i) if (scouts[i].task is task) @scouts[i].task = null;
    }

    void UnitRemoved(CCircuitUnit@ unit)
    {
        if (unit is null) return;
        for (int i = int(scouts.length()) - 1; i >= 0; --i) {
            if (scouts[i].id != unit.id) continue;
            Scout@ s = scouts[i];
            const AIFloat3 pos = unit.GetPos(ai.frame);
            ++lost;
            GenericHelpers::LogUtil("[StealthScout] lost unit=" + s.id + " def=" + unit.circuitDef.GetName() + " at (" + int(pos.x) + ","
                + int(pos.z) + ") alive=" + (ai.frame - s.admitted) / SECOND + "s goals=" + s.goalsReached
                + " hazard=" + (aiBattle.GroundHazard(pos, 0.0f) > 0.0f) + " sector=" + s.sector, 1);
            Drop(uint(i));
        }
    }

    void Reset()
    {
        array<Scout@> old = scouts;
        scouts.resize(0); replanQueue.resize(0);
        for (uint i = 0; i < old.length(); ++i)
            if (old[i].task !is null && !old[i].task.IsDead()) old[i].task.Abort();
    }

    // ---------------- tick ----------------

    // Main::AiUpdate (every 30 frames); self-limited to once per second.
    void Tick()
    {
        if (ai.frame < lastTick + SECOND) return;
        lastTick = ai.frame;
        if (!Active()) { if (scouts.length() > 0) Reset(); return; }
        InitGrid();
        Scan();
        if (scouts.length() > 0) RebuildDensity();
        for (int i = int(scouts.length()) - 1; i >= 0; --i) {
            Scout@ s = scouts[i];
            CCircuitUnit@ u = ai.GetTeamUnit(s.id);
            if (u is null || s.task is null || s.task.IsDead() || u.task !is s.task) { Drop(uint(i)); continue; }
            const AIFloat3 pos = u.GetPos(ai.frame);
            HoldFire(s, u, false);
            // Discovery signals: damage, and an enemy contact inside cloak-break distance.
            const float hp = u.GetHealthPercent();
            if (hp < s.lastHealth - 0.01f) {
                ++hits;
                GenericHelpers::LogUtil("[StealthScout] hit unit=" + s.id + " hp=" + int(hp * 100.0f) + "% at (" + int(pos.x) + "," + int(pos.z)
                    + ") inCoverage=" + (aiBattle.GroundHazard(pos, 0.0f) > 0.0f), 1);
                // Discovered here: every scout of ours avoids this area for HotSeconds;
                // this one drops its goal and replans (the hot sectors push the route away).
                MarkHot(pos, Global::StealthScout::HotSeconds);
                // Pull back away from the shooter before anything else (v4: v3 replanned
                // straight on toward the goal and died in the same spot).
                AIFloat3 back;
                if (EscapePoint(u, pos, back)) {
                    array<AIFloat3> leg = {back};
                    s.task.SetRoute(leg);
                    s.escaping = true; s.holdSince = -1; s.sector = -1;
                    s.retreatUntil = ai.frame + Global::StealthScout::RetreatSeconds * SECOND;
                }
            }
            s.lastHealth = hp;
            if (ai.frame - s.lastRisk >= 20 * SECOND && NearContact(pos, Global::StealthScout::DecloakRisk)) {
                s.lastRisk = ai.frame; ++risks;
                GenericHelpers::LogUtil("[StealthScout] decloak risk unit=" + s.id + " contact within " + int(Global::StealthScout::DecloakRisk)
                    + " at (" + int(pos.x) + "," + int(pos.z) + ")", 1);
            }
            if (ai.frame - s.lastTrack >= 30 * SECOND) {
                s.lastTrack = ai.frame;
                GenericHelpers::LogUtil("[StealthScout] at unit=" + s.id + " (" + int(pos.x) + "," + int(pos.z) + ") goal=(" + int(s.goal.x) + ","
                    + int(s.goal.z) + ") sector=" + s.sector + " hp=" + int(hp * 100.0f) + "%", 1);
            }
            while (s.cursor < s.route.length() && MapHelpers::SqDist(pos, s.route[s.cursor]) < 128.0f * 128.0f) ++s.cursor;
            if (MapHelpers::SqDist(pos, s.lastPos) > 64.0f * 64.0f) { s.lastPos = pos; s.lastMove = ai.frame; }
            const bool windowEnd = s.issuedEnd < s.route.length() && (s.cursor + 2 >= s.issuedEnd || s.task.IsAtEnd(u));
            if (windowEnd && !s.escaping && s.holdSince < 0 && ai.frame - s.lastWindow >= Global::StealthScout::WindowSeconds * SECOND) IssueWindow(s);
            if (s.queued) continue;
            // Discovery avoidance (see settings): contacts near the scout and near
            // the waypoints ahead, collected once per scout per second, O(G).
            const float prox = Global::StealthScout::ProxRadius;
            Collect(pos, Global::StealthScout::LookaheadElmos + prox);
            int ci;
            const float nearest = NearestIn(pos, ci);
            const bool covered = aiBattle.GroundHazard(pos, 0.0f) > 0.0f;
            if (covered != s.inside) {
                s.inside = covered;   // logged only: weapon coverage does not see a cloaked scout
                GenericHelpers::LogUtil("[StealthScout] " + (covered ? "inside coverage" : "clear of coverage") + " unit=" + s.id
                    + " at (" + int(pos.x) + "," + int(pos.z) + ")", 1);
            }
            if (nearest < Global::StealthScout::EvadeRadius) {
                // Something is about to walk into us: step away (one MOVE), resume after.
                AIFloat3 away;
                if (!s.escaping && EscapePoint(u, pos, away)) {
                    array<AIFloat3> leg = {away};
                    s.task.SetRoute(leg);
                    s.escaping = true; s.holdSince = -1;
                    // the contact's area costs routes for a while, so the resume goes round it
                    MarkHot(nearBuf[uint(ci)], Global::StealthScout::EvadeHotSeconds);
                    GenericHelpers::LogUtil("[StealthScout] evade unit=" + s.id + " contact " + int(nearest) + " at (" + int(pos.x) + ","
                        + int(pos.z) + ") to (" + int(away.x) + "," + int(away.z) + ")", 1);
                }
                s.lastMove = ai.frame;
                continue;
            }
            if (s.escaping) {
                // Clear again: resume (the plan keeps the goal unless it was seen meanwhile).
                if (ai.frame >= s.retreatUntil && (nearest >= prox || s.task.IsAtEnd(u))) Queue(s);
                continue;
            }
            // A contact near a waypoint ahead: step round it, else wait for it to pass.
            int blockK = -1, blockC = -1;
            float run = 0.0f;
            AIFloat3 prev = pos;
            for (uint k = s.cursor; k < s.route.length() && (run < Global::StealthScout::LookaheadElmos || k < s.cursor + 2); ++k) {
                int c;
                if (NearestIn(s.route[k], c) < prox) { blockK = int(k); blockC = c; break; }
                run += prev.distance2D(s.route[k]); prev = s.route[k];
            }
            if (blockK >= 0) {
                const AIFloat3 b = nearBuf[uint(blockC)];
                if (Detour(s, u, pos, uint(blockK), blockC)) {
                    s.holdSince = -1;
                    if (ai.frame - s.lastDetourLog >= 10 * SECOND) {
                        s.lastDetourLog = ai.frame;
                        GenericHelpers::LogUtil("[StealthScout] detour unit=" + s.id + " round (" + int(b.x) + "," + int(b.z)
                            + ") at (" + int(pos.x) + "," + int(pos.z) + ")", 1);
                    }
                } else if (s.holdSince < 0) {
                    s.holdSince = ai.frame;
                    array<AIFloat3> hold = {pos};
                    s.task.SetRoute(hold);   // s.route kept: resume when the contact moves on
                    s.issuedEnd = s.cursor;
                    GenericHelpers::LogUtil("[StealthScout] wait unit=" + s.id + " contact ahead (" + int(b.x) + "," + int(b.z)
                        + ") at (" + int(pos.x) + "," + int(pos.z) + ")", 1);
                } else if (ai.frame - s.holdSince > Global::StealthScout::HoldMaxSeconds * SECOND) {
                    s.holdSince = -1;
                    if (s.sector >= 0) unreachableUntil[s.sector] = ai.frame + 60 * SECOND;
                    GenericHelpers::LogUtil("[StealthScout] give way unit=" + s.id + " sector=" + s.sector + "; new target", 1);
                    s.sector = -1;
                    Queue(s);
                }
                s.lastMove = ai.frame;   // waiting is not stuck
                continue;
            }
            if (s.holdSince >= 0) { s.holdSince = -1; IssueWindow(s); }
            // Arrival / goal already seen by someone else / timeout / stuck.
            if (s.sector >= 0) {
                const bool seenMeanwhile = lastSeen[s.sector] > s.goalFrame;
                const float d = pos.distance2D(s.goal);
                // Our own scout sees the sector before standing on it.
                const bool arrived = d <= Global::StealthScout::ArriveElmos
                    || (s.task.IsAtEnd(u) && s.issuedEnd >= s.route.length())
                    || (seenMeanwhile && d <= u.circuitDef.GetLosRadius() + Global::StealthScout::SectorElmos * 0.5f);
                if (arrived || seenMeanwhile) {
                    if (arrived) { ++s.goalsReached; ++reached; }
                    GenericHelpers::LogUtil("[StealthScout] " + (arrived ? "reached" : "seen meanwhile") + " unit=" + s.id + " sector=" + s.sector
                        + " at (" + int(pos.x) + "," + int(pos.z) + ") after " + (ai.frame - s.goalFrame) / SECOND + "s", 1);
                    s.sector = -1;
                    Queue(s);
                    continue;
                }
                if (ai.frame - s.goalFrame > Global::StealthScout::GoalTimeoutSeconds * SECOND) {
                    unreachableUntil[s.sector] = ai.frame + Global::StealthScout::UnreachableForgetSeconds * SECOND;
                    GenericHelpers::LogUtil("[StealthScout] goal timeout unit=" + s.id + " sector=" + s.sector, 1);
                    s.sector = -1;
                    Queue(s);
                    continue;
                }
            }
            const bool stuck = ai.frame - s.lastMove > Global::StealthScout::StuckSeconds * SECOND;
            if ((stuck || s.sector < 0) && ai.frame >= s.nextReplan) {
                if (stuck && s.sector >= 0 && !s.holding) {
                    GenericHelpers::LogUtil("[StealthScout] stuck unit=" + s.id + " at (" + int(pos.x) + "," + int(pos.z) + ")", 1);
                    ++s.routeFailures;
                    if (s.routeFailures >= 2) { unreachableUntil[s.sector] = ai.frame + Global::StealthScout::UnreachableForgetSeconds * SECOND; s.sector = -1; }
                }
                Queue(s);
            }
        }
        int budget = Global::StealthScout::MaxRoutesPerSecond;
        while (budget > 0 && replanQueue.length() > 0) {
            const int id = replanQueue[0];
            replanQueue.removeAt(0);
            Scout@ s = Find(id);
            if (s is null) continue;
            CCircuitUnit@ u = ai.GetTeamUnit(id);
            if (u is null || s.task is null) { s.queued = false; continue; }
            Plan(s, u);
            --budget;
        }
        if (scouts.length() > 0 && ai.frame - lastSummary >= Global::StealthScout::SummarySeconds * SECOND) {
            lastSummary = ai.frame;
            int never = 0, old = 0;
            for (uint k = 0; k < lastSeen.length(); ++k) {
                if (lastSeen[k] < 0) ++never;
                else if (ai.frame - lastSeen[k] > Global::StealthScout::MinStaleSeconds * SECOND) ++old;
            }
            GenericHelpers::LogUtil("[StealthScout] summary scouts=" + scouts.length() + " routes=" + planned + " reached=" + reached
                + " lost=" + lost + " hits=" + hits + " risks=" + risks + " sectors never=" + never + " stale=" + old + " of " + lastSeen.length(), 1);
        }
    }
}

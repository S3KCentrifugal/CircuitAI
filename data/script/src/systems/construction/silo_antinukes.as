#include "../../define.as"
#include "../../unit.as"
#include "../../task.as"
#include "../../global.as"
#include "../../settings/shared/silo_antinukes.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/units/unit_helpers.as"
#include "../../helpers/construction/economy_helpers.as"
#include "../../helpers/spatial/map_helpers.as"
#include "../../helpers/spatial/layout_helpers.as"
#include "../world/lanes.as"

// Antinukes against scouted enemy nuclear silos (owner, 2026-11-15; Global::SiloAntiNukes).
//
// Why (owner report, All That Simmers on GreenParrots: a FRONT with no antinuke in 30 min):
// before this, FRONT's only antinuke came from the commander group's defence planner
// (defense_planner.as slot 7, CommanderDefense.cpp). That rule is centred on the commander
// (+-192 elmos), needs a free seat of the group that can build it, +50 metal / +1000 energy and
// a nuclear demand that fades over strategic_memory (600 s) after the silo was last seen; FRONT's
// own builders never ordered one and the factory-layout pocket (FrontLayout "utilities") was
// reserved but never built.
//
// Silos: identified enemy silos (armsilo / corsilo / legsilo; frames count) seen now or remembered
// where they stood (CBattleAnalysis ground contacts + ghosts). Antinukes, Paralyzers, Catalysts
// and Perditions are not counted (EnemyCount(NUKE) counts every stockpiling super). One antinuke
// per known silo, at most Max, ours only (frames count).
//
// FRONT (FrontWork): the first antinuke covers the main base and the front together: a block
// whose centre is within CoverShare x coverage of our start and as near as it can be to the
// front point too, off every allied start-to-enemy line (LaneClear preferred), accepted by every
// layout (CanReserveArea: TECH/AIR layouts, lab corridors and exit cones) and buildable at every
// slot. The block is a tight grid (Shapes: 3x2, 2x2, 2x1, 1x1, each also turned); later
// antinukes fill it, side by side. One order at a time, pinned to its slot.
//
// TECH / AIR (PeripheryWork): after the role's own first antinuke, one more per known silo on a
// ring round the start, spread away from our other antinukes and from the enemy, every pad on the
// map (MapEdgeMargin beyond half its footprint) and still covering the core.
//
// Cost: the silo count once per CountSeconds (one pass over the published contacts/ghosts);
// a FRONT site search once per block (backs off after a failure); a periphery search
// (rings x spokes probes, cheap tests first) only while an antinuke is owed. Log [SiloAntiNuke].
namespace SiloAntiNukes {
    array<int> siloIds;
    bool idsReady = false;
    int known = 0;
    int countedAt = -1000000;
    int firstSeen = -1;          // the frame a silo was first known (relaxes FRONT's first gate)
    int lastLogged = -1;
    AIFloat3 lastSilo(-1.0f, 0.0f, -1.0f);

    string Tag()
    {
        const AiRole r = Global::AISettings::Role;
        return r == AiRole::FRONT ? "[FRONT]" : r == AiRole::AIR ? "[AIR]" : r == AiRole::TECH ? "[TECH]" : "[ROLE " + int(r) + "]";
    }

    bool IsSilo(int defId)
    {
        if (!idsReady) {
            idsReady = true;
            array<string> names = UnitHelpers::GetAllNukeSilos();
            for (uint i = 0; i < names.length(); ++i) {
                CCircuitDef@ d = ai.GetCircuitDef(names[i]);
                if (d !is null) siloIds.insertLast(d.id);
            }
        }
        if (defId < 0) return false;
        for (uint i = 0; i < siloIds.length(); ++i) if (siloIds[i] == defId) return true;
        return false;
    }

    // Known enemy silos (seen now, or remembered where they stood).
    int KnownSilos()
    {
        if (ai.frame - countedAt < Global::SiloAntiNukes::CountSeconds * SECOND) return known;
        countedAt = ai.frame;
        int n = 0;
        const int contacts = aiBattle.GetGroundContactCount();
        for (int i = 0; i < contacts; ++i) {
            if (!IsSilo(aiBattle.GetGroundContactDefId(i))) continue;
            ++n; lastSilo = aiBattle.GetGroundContactPos(i);
        }
        const int ghosts = aiBattle.GetGhostCount();
        for (int i = 0; i < ghosts; ++i) {
            if (!IsSilo(aiBattle.GetGhostDefId(i))) continue;
            ++n; lastSilo = aiBattle.GetGhostPos(i);
        }
        if (n > 0 && firstSeen < 0) firstSeen = ai.frame;
        if (n != lastLogged) {
            lastLogged = n;
            GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] enemy silos known: " + n
                + (n > 0 ? " (one at " + int(lastSilo.x) + ", " + int(lastSilo.z) + ")" : "")
                + "; own antinukes " + EconomyHelpers::GetAntiNukeCount(), 1);
        }
        known = n;
        return n;
    }

    // Antinukes owed: one per known silo, at most Max.
    int Wanted()
    {
        if (!Global::SiloAntiNukes::Enabled) return 0;
        return AiMin(Global::SiloAntiNukes::Max, KnownSilos());
    }

    // Raise (never lower) every antinuke's unit cap to n (corfmd / legabm ship with limit 5).
    void RaiseCaps(int n)
    {
        array<string> names = UnitHelpers::GetAllAntiNukes();
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d !is null && d.maxThisUnit < n) d.maxThisUnit = n;
        }
    }

    float Coverage(CCircuitDef@ d)
    {
        const float r = d is null ? 0.0f : aiBattle.InterceptorCoverage(d);
        return r > 0.0f ? r : 2000.0f;
    }

    // Inside the map with `margin` to spare on every side.
    bool OnMap(const AIFloat3 &in p, float margin)
    {
        return p.x >= margin && p.z >= margin
            && p.x <= float(AiTerrainWidth()) - margin && p.z <= float(AiTerrainHeight()) - margin;
    }

    float Dist(const AIFloat3 &in a, const AIFloat3 &in b) { return sqrt(MapHelpers::SqDist(a, b)); }

    float SqDistSegment(const AIFloat3 &in p, const AIFloat3 &in a, const AIFloat3 &in b)
    {
        const float dx = b.x - a.x, dz = b.z - a.z;
        const float len = dx * dx + dz * dz;
        float t = len > 0.0f ? ((p.x - a.x) * dx + (p.z - a.z) * dz) / len : 0.0f;
        t = t < 0.0f ? 0.0f : (t > 1.0f ? 1.0f : t);
        const float qx = a.x + t * dx - p.x, qz = a.z + t * dz - p.z;
        return qx * qx + qz * qz;
    }

    AIFloat3 NearestOf(const array<AIFloat3> &in pts, const AIFloat3 &in from)
    {
        AIFloat3 best(-1.0f, 0.0f, -1.0f);
        float bestD = 1e30f;
        for (uint i = 0; i < pts.length(); ++i) {
            if (pts[i].x < 0.0f || pts[i].z < 0.0f) continue;
            const float d = MapHelpers::SqDist(pts[i], from);
            if (d < bestD) { bestD = d; best = pts[i]; }
        }
        return best;
    }

    // Unit vector from home toward the nearest enemy start (map centre without one).
    AIFloat3 EnemyAxis(const AIFloat3 &in home, AIFloat3 &out enemy)
    {
        enemy = NearestOf(Lanes::EnemyStarts(), home);
        AIFloat3 to = enemy.x >= 0.0f ? enemy : AIFloat3(float(AiTerrainWidth()) * 0.5f, 0.0f, float(AiTerrainHeight()) * 0.5f);
        float dx = to.x - home.x, dz = to.z - home.z;
        const float len = sqrt(dx * dx + dz * dz);
        if (len < 1.0f) return AIFloat3(0.0f, 0.0f, 0.0f);
        return AIFloat3(dx / len, 0.0f, dz / len);
    }

    // Our antinukes (frames included).
    array<AIFloat3>@ OwnAntiNukes()
    {
        array<AIFloat3> r;
        array<string> names = UnitHelpers::GetAllAntiNukes();
        array<int> defs;
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d !is null) defs.insertLast(d.id);
        }
        array<Id>@ ids = ai.GetOwnedUnitIds();
        if (ids is null) return r;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || defs.find(u.circuitDef.id) < 0) continue;
            r.insertLast(u.GetPos(ai.frame));
        }
        return r;
    }

    // Our antinuke for the builder's side (the AI's own side first: a gift may help, not claim).
    CCircuitDef@ AntiNukeFor(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null) return null;
        CCircuitDef@ d = ai.GetCircuitDef(UnitHelpers::GetAntiNukeNameForSide(Global::AISettings::Side));
        if (d !is null && u.circuitDef.CanBuild(d)) return d;
        @d = ai.GetCircuitDef(UnitHelpers::GetAntiNukeNameForSide(UnitHelpers::GetSideForUnitName(u.circuitDef.GetName())));
        return (d !is null && u.circuitDef.CanBuild(d)) ? d : null;
    }

    IUnitTask@ Order(CCircuitUnit@ u, CCircuitDef@ d, int slot)
    {
        const AIFloat3 at = aiTerrainMgr.GetReservationPos(slot);
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, at, 0.0f, true, 300 * SECOND));
        if (t is null) return null;
        if (!AiPinReservation(t, slot)) { aiBuilderMgr.AbortTask(t); return null; }
        return t;
    }

    /**************************************************************************
     FRONT: one block covering the main base and the front
    **************************************************************************/
    array<int> slots;
    array<int> zones;
    array<int> slotWait;
    array<int> slotDeaths;
    AIFloat3 centre(-1.0f, 0.0f, -1.0f);
    string gridDef = "";
    IUnitTask@ pending = null;
    int pendingSlot = -1, pendingFrame = 0;
    int nextSearch = 0, searchFails = 0, nextHeld = -1000000, nextRecruit = -1000000, nearFrom = -1;
    int recruitId = -1, recruitTries = 0, nextNote = -1000000;
    // a note with its own rate limit, so it never hides the Held reason that follows
    void Note(const string &in why)
    {
        if (ai.frame - nextNote < 120 * SECOND) return;
        nextNote = ai.frame;
        GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] note: " + why, 1);
    }

    // The nearest finished builder of ours (no commander, no player-held unit, none on a factory,
    // silo or antinuke order) that can build d and reach `near`; null when there is none.
    CCircuitUnit@ Capable(CCircuitDef@ d, const AIFloat3 &in near)
    {
        if (d is null) return null;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        if (ids is null) return null;
        CCircuitUnit@ best = null;
        float bestD = 1e30f;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ w = ai.GetTeamUnit(ids[i]);
            if (w is null || w.circuitDef is null || w.GetBuildProgress() < 1.0f) continue;
            if (UnitHelpers::IsCommander(w.circuitDef) || !w.circuitDef.CanBuild(d)) continue;
            if (w.task !is null) {
                if (w.task.GetType() == int(Task::Type::PLAYER)) continue;
                if (w.task is pending || w.task is padPending) continue;
                IBuilderTask@ bt = cast<IBuilderTask>(w.task);
                // played (v3): a builder taken off a frame went straight back to it
                if (bt !is null && (bt.GetBuildType() == int(Task::BuildType::FACTORY) || bt.GetBuildType() == int(Task::BuildType::BIG_GUN)
                    || (bt.buildDef !is null && bt.buildDef is d) || bt.target !is null)) continue;
            }
            const float dd = MapHelpers::SqDist(w.GetPos(ai.frame), near);
            if (dd >= bestD || !aiTerrainMgr.CanReachAt(w, near, w.circuitDef.GetBuildDistance())) continue;
            bestD = dd; @best = w;
        }
        return best;
    }

    // The builder on our antinuke order keeps it when native re-asks (played: orders swapped off
    // and dropped unframed after 120 s). FRONT asks this first.
    IUnitTask@ Keep(CCircuitUnit@ u)
    {
        if (u is null) return null;
        // played (v3): a recruit was handed back by native within 20 s (77 recruits, 21 started);
        // a recruit returns to its order whatever native gave it meanwhile
        if (pending !is null && !pending.IsDead() && ((u.task !is null && u.task is pending) || u.id == recruitId)) return pending;
        if (padPending !is null && !padPending.IsDead() && ((u.task !is null && u.task is padPending) || u.id == padRecruitId)) return padPending;
        return null;
    }

    // A builder on, or recruited for, one of our antinuke orders: other rules leave it alone
    // (played, v5: 38 of 83 recruits taken by PorcCluster, MexUpT2, FrontRadar ...).
    bool Owns(CCircuitUnit@ u)
    {
        if (u is null) return false;
        if (pending !is null && !pending.IsDead() && ((u.task !is null && u.task is pending) || u.id == recruitId)) return true;
        if (padPending !is null && !padPending.IsDead() && ((u.task !is null && u.task is padPending) || u.id == padRecruitId)) return true;
        return false;
    }

    void Held(const string &in why)
    {
        if (ai.frame - nextHeld < 60 * SECOND) return;
        nextHeld = ai.frame;
        GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] held: " + why, 1);
    }

    void Park(int s, const string &in why)
    {
        if (s < 0 || s >= int(slots.length())) return;
        if (slotWait.length() < slots.length()) { slotWait.resize(slots.length()); slotDeaths.resize(slots.length()); }
        const int wait = AiMin(600, Global::SiloAntiNukes::SlotBackoffSeconds * (1 << AiMin(slotDeaths[s], 2)));
        ++slotDeaths[s];
        slotWait[s] = ai.frame + wait * SECOND;
        GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] slot " + s + ": " + why + "; parked " + wait + " s", 1);
    }

    array<AIFloat3>@ SlotsAt(const AIFloat3 &in c, int f, int cols, int rows, float w, float dep)
    {
        array<AIFloat3> r;
        const AIFloat3 origin = LayoutHelpers::Offset(c, f, -w * float(cols - 1) * 0.5f, -dep * float(rows - 1) * 0.5f);
        for (int s = 0; s < cols * rows; ++s) r.insertLast(LayoutHelpers::Offset(origin, f, float(s % cols) * w, float(s / cols) * dep));
        return r;
    }

    int FacingToward(const AIFloat3 &in axis)
    {
        if (abs(axis.x) > abs(axis.z)) return axis.x > 0.0f ? 1 : 3;
        return axis.z > 0.0f ? 0 : 2;
    }

    // One cols x rows block, or nothing. True when reserved.
    bool Reserve(CCircuitUnit@ u, CCircuitDef@ d, int cols, int rows, bool relax)
    {
        const AIFloat3 home = Global::Map::StartPos;
        if (home.x < 0.0f || home.z < 0.0f) return false;
        AIFloat3 enemy(-1.0f, 0.0f, -1.0f);
        const AIFloat3 axis = EnemyAxis(home, enemy);
        const float R = Coverage(d);
        const float share = Global::SiloAntiNukes::CoverShare;
        const float enemyD = enemy.x >= 0.0f ? Dist(home, enemy) : float(AiMax(AiTerrainWidth(), AiTerrainHeight())) * 0.5f;
        const float reach = AiMin(enemyD * Global::SiloAntiNukes::FrontFraction, 2.0f * share * R);
        const AIFloat3 front(home.x + axis.x * reach, 0.0f, home.z + axis.z * reach);
        // a later block stands round the first one
        const AIFloat3 target = centre.x >= 0.0f ? centre : AIFloat3((home.x + front.x) * 0.5f, 0.0f, (home.z + front.z) * 0.5f);
        array<AIFloat3> allies = Lanes::AllyStarts(), enemies = Lanes::EnemyStarts();
        array<AIFloat3> laneA, laneB;
        for (uint i = 0; i < allies.length(); ++i) {
            const AIFloat3 e = NearestOf(enemies, allies[i]);
            if (e.x >= 0.0f && allies[i].x >= 0.0f) { laneA.insertLast(allies[i]); laneB.insertLast(e); }
        }
        const float margin = Global::SiloAntiNukes::Margin;
        const int f0 = FacingToward(axis);
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) {
            Held("the profile's layout gate is closed");
            return false;
        }
        array<AIFloat3> candC; array<int> candF; array<float> candScore, candLane;
        int offMap = 0, uncovered = 0, unreachable = 0, refused = 0, unbuildable = 0, onLane = 0, forwardCut = 0, hazard = 0;
        const float step = centre.x >= 0.0f ? Global::SiloAntiNukes::SearchStep * 0.75f : Global::SiloAntiNukes::SearchStep;
        for (int turn = 0; turn < 2; ++turn) {
            const int f = (f0 + turn) % 4;
            const float w = float(Layout::Across(d, f)) * SQUARE_SIZE * 2.0f, dep = float(Layout::Along(d, f)) * SQUARE_SIZE * 2.0f;
            const float halfAcross = w * float(cols) * 0.5f + margin, halfAlong = dep * float(rows) * 0.5f + margin;
            const float own = sqrt(halfAcross * halfAcross + halfAlong * halfAlong);
            for (int ring = 0; ring <= Global::SiloAntiNukes::SearchRings; ++ring) {
                const int spokes = ring == 0 ? 1 : Global::SiloAntiNukes::SearchSpokes;
                for (int k = 0; k < spokes; ++k) {
                    const float ang = 6.2831853f * (float(k) + 0.5f * float(ring % 2)) / float(spokes);
                    const AIFloat3 c(target.x + cos(ang) * step * float(ring), 0.0f, target.z + sin(ang) * step * float(ring));
                    if (!OnMap(c, own + 32.0f)) { ++offMap; continue; }
                    const float dHome = Dist(c, home), dFront = Dist(c, front);
                    // the main base is always inside the cover
                    if (dHome > share * R) { ++uncovered; continue; }
                    // played (v1): blocks 1.1-1.5 km out toward the enemy; half-built frames shot down.
                    // Not past ForwardShare x coverage along the enemy axis, never in observed enemy reach.
                    const float along = (c.x - home.x) * axis.x + (c.z - home.z) * axis.z;
                    if (along > (relax ? 1.5f : 1.0f) * Global::SiloAntiNukes::ForwardShare * R) { ++forwardCut; continue; }
                    if (aiBattle.GroundHazard(c, Global::SiloAntiNukes::HazardMargin) > 0.0f) { ++hazard; continue; }
                    float laneD = 1e9f;
                    for (uint l = 0; l < laneA.length(); ++l) laneD = AiMin(laneD, sqrt(SqDistSegment(c, laneA[l], laneB[l])));
                    if (laneD < own && !relax) { ++onLane; continue; }   // the block itself would stand on a lane line (relaxed: penalised)
                    float score = AiMax(dHome, dFront * Global::SiloAntiNukes::FrontWeight) + dHome * Global::SiloAntiNukes::HomeWeight;
                    if (laneD < own) score += 2.0f * Global::SiloAntiNukes::LanePenalty;
                    if (laneD < own + Global::SiloAntiNukes::LaneClear) score += Global::SiloAntiNukes::LanePenalty;
                    if (!aiTerrainMgr.CanReachAt(u, c, u.circuitDef.GetBuildDistance() + halfAcross)) { ++unreachable; continue; }
                    if (!aiTerrainMgr.CanReserveArea(c, f, halfAcross, halfAlong)) { ++refused; continue; }
                    array<AIFloat3>@ at = SlotsAt(c, f, cols, rows, w, dep);
                    bool ok = true;
                    for (uint s = 0; s < at.length() && ok; ++s) ok = OnMap(at[s], 32.0f) && aiTerrainMgr.CanReserveBuilding(d, at[s], f);
                    if (!ok) { ++unbuildable; continue; }
                    uint pos = 0;
                    while (pos < candScore.length() && candScore[pos] <= score) ++pos;
                    candC.insertAt(pos, c); candF.insertAt(pos, f); candScore.insertAt(pos, score); candLane.insertAt(pos, laneD);
                }
            }
        }
        bool found = false;
        int tried = 0;
        for (uint i = 0; i < candC.length() && !found && tried < Global::SiloAntiNukes::MaxTries; ++i) {
            ++tried;
            const int f = candF[i];
            const float w = float(Layout::Across(d, f)) * SQUARE_SIZE * 2.0f, dep = float(Layout::Along(d, f)) * SQUARE_SIZE * 2.0f;
            const float halfAcross = w * float(cols) * 0.5f + margin, halfAlong = dep * float(rows) * 0.5f + margin;
            array<AIFloat3>@ at = SlotsAt(candC[i], f, cols, rows, w, dep);
            array<int> block;
            for (uint s = 0; s < at.length(); ++s) {
                const int id = aiTerrainMgr.ReservePersistentBuilding(d, at[s], f);
                if (id < 0) break;
                block.insertLast(id);
            }
            int zone = -1;
            if (block.length() == at.length() && LayoutHelpers::CheckGrid(block, 0, cols, f, w, dep)) {
                zone = aiTerrainMgr.ReserveZone(candC[i], f, halfAcross, halfAlong, false);
                found = zone > 0;
            }
            if (!found) {
                for (uint s = 0; s < block.length(); ++s) aiTerrainMgr.ReleasePersistentBuilding(block[s]);
                continue;
            }
            for (uint s = 0; s < block.length(); ++s) slots.insertLast(block[s]);
            zones.insertLast(zone);
            if (centre.x < 0.0f) centre = candC[i];
            GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] reserved " + cols + "x" + rows + " " + d.GetName() + " block at ("
                + int(candC[i].x) + ", " + int(candC[i].z) + ") facing " + f + ": " + int(Dist(candC[i], home)) + " from start, "
                + int(Dist(candC[i], front)) + " from the front point (" + int(front.x) + ", " + int(front.z) + "), coverage " + int(R)
                + ", " + int(candLane[i]) + " from the nearest allied lane; " + candC.length() + " candidates (skipped " + offMap
                + " off map, " + uncovered + " not covering the base, " + forwardCut + " too far forward, " + hazard + " in enemy reach, " + onLane + " on lanes, " + unreachable + " unreachable, "
                + refused + " refused by layouts, " + unbuildable + " unbuildable), " + tried + " tried", 1);
        }
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
        if (!found)
            GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] no " + cols + "x" + rows + " site: " + candC.length() + " candidates (skipped " + offMap
                + " off map, " + uncovered + " not covering the base, " + forwardCut + " too far forward, " + hazard + " in enemy reach, " + onLane + " on lanes, " + unreachable + " unreachable, "
                + refused + " refused by layouts, " + unbuildable + " unbuildable), " + tried + " tried" + (relax ? " (relaxed)" : ""), 1);
        return found;
    }

    IUnitTask@ FrontWork(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null) return null;
        if (!Global::SiloAntiNukes::Enabled || !Global::SiloAntiNukes::Front || Global::AISettings::Role != AiRole::FRONT) return null;
        const int want = Wanted();
        if (want <= 0) return null;
        CCircuitDef@ d = gridDef.length() > 0 ? ai.GetCircuitDef(gridDef) : AntiNukeFor(u);
        if (d is null) @d = ai.GetCircuitDef(UnitHelpers::GetAntiNukeNameForSide(Global::AISettings::Side));
        if (d is null) return null;
        // played (v2): on some FRONTs only rez bots and T1 constructors ever asked (their T2
        // constructors stayed on long jobs); the asker then recruits the nearest capable builder
        CCircuitUnit@ b = u;
        if (!u.circuitDef.CanBuild(d)) {
            if (UnitHelpers::IsCommander(u.circuitDef) || ai.frame < nextRecruit) return null;
            nextRecruit = ai.frame + Global::SiloAntiNukes::RecruitSeconds * SECOND;
            @b = Capable(d, centre.x >= 0.0f ? centre : Global::Map::StartPos);
            if (b is null) {
                GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] " + u.circuitDef.GetName() + " " + u.id + " cannot build an antinuke and no free builder can ("
                    + EconomyHelpers::GetAntiNukeCount() + " of " + want + " owed)", 1);
                return null;
            }
        }
        // one order at a time, pinned to its slot
        const bool tracked = pendingSlot >= 0 && pendingSlot < int(slots.length());
        if (pending !is null && !pending.IsDead()) {
            if (!tracked || ai.frame - pendingFrame < Global::SiloAntiNukes::SlotStallSeconds * SECOND
                    || aiTerrainMgr.GetReservationState(slots[pendingSlot]) >= 2) {
                // nobody on it for RecruitSeconds: the nearest capable builder joins
                if (pending.GetUnits().length() == 0 && tracked && ai.frame - pendingFrame >= Global::SiloAntiNukes::RecruitSeconds * SECOND
                        && ai.frame >= nextRecruit) {
                    nextRecruit = ai.frame + Global::SiloAntiNukes::RecruitSeconds * SECOND;
                    CCircuitUnit@ w = recruitId >= 0 ? ai.GetTeamUnit(recruitId) : null;
                    if (w is null || ++recruitTries > 3) { @w = Capable(d, aiTerrainMgr.GetReservationPos(slots[pendingSlot])); recruitTries = 0; }
                    if (w !is null) {
                        recruitId = w.id;
                        aiBuilderMgr.AssignTask(w, pending);
                        GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] unattended order on slot " + pendingSlot + ": recruited "
                            + w.circuitDef.GetName() + " " + w.id, 1);
                    }
                }
                Held("antinuke order on slot " + pendingSlot + " in flight " + ((ai.frame - pendingFrame) / SECOND) + " s, builders "
                    + pending.GetUnits().length());
                return null;
            }
            aiBuilderMgr.AbortTask(pending);
            Park(pendingSlot, "no frame after " + ((ai.frame - pendingFrame) / SECOND) + " s; order aborted");
        } else if (pending !is null && tracked) {
            if (aiTerrainMgr.GetReservationState(slots[pendingSlot]) == 0) Park(pendingSlot, "the order ended with no antinuke");
            else if (uint(pendingSlot) < slotDeaths.length()) slotDeaths[pendingSlot] = 0;
        }
        @pending = null;
        pendingSlot = -1;
        const int have = EconomyHelpers::GetAntiNukeCount();
        if (have >= want) return null;
        // played (v2): another rule's antinuke order sat queued for minutes and held this one
        // (first antinuke 25 min after the silo). Ours goes ahead; a late finish of the other
        // overshoots by at most one.
        if (aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::DEFENCE), d) > 0)
            Note(d.GetName() + " also queued by another rule; ordering ours anyway (" + have + " of " + want + ")");
        const float mi = Economy::GetMinMetalIncomeLast10s(), ei = Economy::GetMinEnergyIncomeLast10s();
        float gm = have == 0 ? Global::SiloAntiNukes::FirstMetalIncome : Global::SiloAntiNukes::ExtraMetalIncome;
        float ge = have == 0 ? Global::SiloAntiNukes::FirstEnergyIncome : Global::SiloAntiNukes::ExtraEnergyIncome;
        const bool relaxed = have == 0 && firstSeen >= 0 && ai.frame - firstSeen >= Global::SiloAntiNukes::RelaxSeconds * SECOND;
        if (relaxed) { gm *= 0.5f; ge *= 0.5f; }
        if (mi < gm || ei < ge) {
            Held("antinuke " + (have + 1) + " of " + want + ": 10 s min income +" + int(mi) + " metal of " + int(gm)
                + ", +" + int(ei) + " energy of " + int(ge) + (relaxed ? " (relaxed)" : ""));
            return null;
        }
        if (!d.IsAvailable(ai.frame)) { Held(d.GetName() + " not available"); return null; }
        RaiseCaps(want);
        bool freeSlot = false;
        for (uint s = 0; s < slots.length() && !freeSlot; ++s) freeSlot = aiTerrainMgr.GetReservationState(slots[s]) == 0;
        if (!freeSlot && int(slots.length()) < Global::SiloAntiNukes::Max) {
            if (ai.frame < nextSearch) { Held("block site search backing off " + ((nextSearch - ai.frame) / SECOND) + " s"); return null; }
            bool reserved = false;
            const array<int>@ shapes = @Global::SiloAntiNukes::Shapes;
            // Owner 2026-11-16: one silo known reserves only the first pad; the block (3x2 .. 1x1)
            // is reserved beside it once more silos are scouted (Reserve stands round `centre`).
            const int room = want <= 1 && slots.length() == 0 ? 1 : Global::SiloAntiNukes::Max - int(slots.length());
            for (uint k = 0; k + 1 < shapes.length() && !reserved; k += 2) {
                if (shapes[k] * shapes[k + 1] > room) continue;
                reserved = Reserve(b, d, shapes[k], shapes[k + 1], searchFails >= 2);
            }
            if (!reserved) {
                nextSearch = ai.frame + AiMin(Global::SiloAntiNukes::RetryMaxSeconds,
                    Global::SiloAntiNukes::RetrySeconds * (1 << AiMin(searchFails, 3))) * SECOND;
                ++searchFails;
                Held("no block site for " + d.GetName());
                return null;
            }
            searchFails = 0;
            gridDef = d.GetName();
        }
        for (uint s = 0; s < slots.length(); ++s) {
            if (aiTerrainMgr.GetReservationState(slots[s]) != 0) continue;
            if (s < slotWait.length() && ai.frame < slotWait[s]) continue;
            const AIFloat3 at = aiTerrainMgr.GetReservationPos(slots[s]);
            if (!aiTerrainMgr.CanReachAt(b, at, b.circuitDef.GetBuildDistance())) continue;
            // played (v1): far builders' orders died unframed after 120 s; a near one first
            // (nearFrom: the first frame this slot was offered), any after NearOnlySeconds
            if (nearFrom < 0) nearFrom = ai.frame;
            const float near = Global::SiloAntiNukes::OrderRadius;
            if (ai.frame - nearFrom < Global::SiloAntiNukes::NearOnlySeconds * SECOND
                && MapHelpers::SqDist(b.GetPos(ai.frame), at) > near * near) return null;
            IUnitTask@ t = Order(b, d, slots[s]);
            if (t is null) { Park(int(s), "could not pin " + d.GetName()); return null; }
            @pending = t;
            nearFrom = -1;
            recruitId = b is u ? -1 : b.id; recruitTries = 0;
            pendingSlot = int(s); pendingFrame = ai.frame;
            GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] antinuke " + (have + 1) + " of " + want + " (" + known
                + " silos known) on block slot " + s + " at (" + int(at.x) + ", " + int(at.z) + "); income +" + int(mi) + "/+" + int(ei)
                + (relaxed ? " (relaxed gate)" : "") + (b is u ? "" : "; recruited " + b.circuitDef.GetName() + " " + b.id), 1);
            if (b is u) return t;
            aiBuilderMgr.AssignTask(b, t);
            return null;
        }
        Held("no free block slot the constructor can reach (" + slots.length() + " slots)");
        return null;
    }

    /**************************************************************************
     TECH / AIR: further antinukes at the base periphery
    **************************************************************************/
    array<int> padSlots;
    IUnitTask@ padPending = null;
    int padNextSearch = 0, padHeldAt = -1000000, padNextRecruit = -1000000, padRecruitId = -1, padOrderedAt = 0, padNextOrder = 0;
    void PadHeld(const string &in why)
    {
        if (ai.frame - padHeldAt < 60 * SECOND) return;
        padHeldAt = ai.frame;
        GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] periphery held: " + why, 1);
    }

    // The best periphery pad for d, or -1. Never off the map; every pad covers the core.
    int ReservePeriphery(CCircuitUnit@ u, CCircuitDef@ d, float maxRadius, float coreRadius)
    {
        const AIFloat3 home = Global::Map::StartPos;
        if (home.x < 0.0f || home.z < 0.0f) return -1;
        AIFloat3 enemy(-1.0f, 0.0f, -1.0f);
        const AIFloat3 axis = EnemyAxis(home, enemy);
        const float R = Coverage(d);
        const float outer = AiMin(maxRadius, R - coreRadius);
        const float inner = AiMin(Global::SiloAntiNukes::PeripheryMinRadius, outer);
        if (outer <= 0.0f) return -1;
        array<AIFloat3>@ others = OwnAntiNukes();
        const float half = float(AiMax(d.GetFootprintX(), d.GetFootprintZ())) * SQUARE_SIZE;
        const float edge = half + Global::SiloAntiNukes::MapEdgeMargin;
        AIFloat3 best(-1.0f, 0.0f, -1.0f);
        float bestScore = -1e30f, bestForward = 0.0f;
        int bestPass = 0;
        int offMap = 0, ally = 0, refused = 0;
        const int spokes = AiMax(8, Global::SiloAntiNukes::PeripherySpokes);
        // played (v3): an AIR pad 1,081 straight toward the enemy lost its frames for 10 min.
        // First pass: no pad on the enemy-facing side (forward share above PeripheryMaxForward).
        for (int pass = 0; pass < 2 && best.x < 0.0f; ++pass)
        for (float r = outer; r >= inner - 1.0f; r -= Global::SiloAntiNukes::PeripheryStep) {
            for (int k = 0; k < spokes; ++k) {
                const float ang = 6.2831853f * float(k) / float(spokes);
                const float cx = cos(ang), cz = sin(ang);
                const AIFloat3 c(home.x + cx * r, 0.0f, home.z + cz * r);
                if (!OnMap(c, edge)) { ++offMap; continue; }
                if (aiTerrainMgr.IsZoneAlly(c)) { ++ally; continue; }
                // spread: the farthest from our other antinukes, capped (all still cover the core)
                float spread = R;
                for (uint i = 0; i < others.length(); ++i) spread = AiMin(spread, Dist(c, others[i]));
                // away from the enemy: a pad on the rear or flank lives longer
                const float forward = cx * axis.x + cz * axis.z;
                if (pass == 0 && forward > Global::SiloAntiNukes::PeripheryMaxForward) continue;
                const float score = spread - forward * 400.0f + r * 0.1f;
                if (score <= bestScore) continue;
                if (!aiTerrainMgr.CanReserveArea(c, 0, half + 32.0f, half + 32.0f)
                    || !aiTerrainMgr.CanReserveBuilding(d, c, 0)
                    || !aiTerrainMgr.CanReachAt(u, c, u.circuitDef.GetBuildDistance())) { ++refused; continue; }
                bestScore = score; best = c; bestPass = pass; bestForward = forward;
            }
        }
        if (best.x < 0.0f) {
            GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] no periphery pad within " + int(inner) + "-" + int(outer)
                + " of start (skipped " + offMap + " off map, " + ally + " in ally zones, " + refused + " refused/unbuildable/unreachable)", 2);
            return -1;
        }
        const int slot = aiTerrainMgr.ReservePersistentBuilding(d, best, 0);
        if (slot < 0) return -1;
        const AIFloat3 p = aiTerrainMgr.GetReservationPos(slot);
        // the snapped pad must still be on the map and still cover the core
        if (!OnMap(p, half) || Dist(p, home) > R - coreRadius) {
            aiTerrainMgr.ReleasePersistentBuilding(slot);
            return -1;
        }
        padSlots.insertLast(slot);
        GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] periphery pad " + slot + " at (" + int(p.x) + ", " + int(p.z) + "), forward "
            + int(bestForward * 100.0f) + "%" + (bestPass > 0 ? " (fallback: no pad off the enemy side)" : "") + ", "
            + int(Dist(p, home)) + " from start, " + others.length() + " own antinukes, coverage " + int(R), 1);
        return slot;
    }

    // After the role's own first antinuke: one more per known silo. mi / ei: the role's income view.
    IUnitTask@ PeripheryWork(CCircuitUnit@ u, float mi, float ei, float metalGate, float energyGate, float maxRadius, float coreRadius)
    {
        if (u is null || u.circuitDef is null) return null;
        if (!Global::SiloAntiNukes::Enabled || !Global::SiloAntiNukes::Periphery) return null;
        const int want = Wanted();
        if (want <= 1) return null;           // the first is the role's own rule
        const int have = EconomyHelpers::GetAntiNukeCount();
        if (have >= want) return null;
        if (have < 1) { PadHeld("waiting for the role's own first antinuke (" + want + " owed)"); return null; }
        if (padPending !is null && !padPending.IsDead()) return null;
        // played (v4): an AIR periphery order died at once and was placed again every 1-2 s for 77 s
        if (padPending !is null && ai.frame - padOrderedAt < 10 * SECOND) {
            padNextOrder = ai.frame + 30 * SECOND;
            PadHeld("the last order died within 10 s; next in 30 s");
        }
        @padPending = null;
        if (ai.frame < padNextOrder) return null;
        CCircuitDef@ d = AntiNukeFor(u);
        if (d is null) @d = ai.GetCircuitDef(UnitHelpers::GetAntiNukeNameForSide(Global::AISettings::Side));
        if (d is null || !d.IsAvailable(ai.frame)) { PadHeld("no available antinuke"); return null; }
        if (aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::DEFENCE), d) > 0)
            Note(d.GetName() + " also queued by another rule; ordering ours anyway (periphery)");
        if (mi < metalGate || ei < energyGate) {
            PadHeld("antinuke " + (have + 1) + " of " + want + ": income +" + int(mi) + "/+" + int(ei) + " below +" + int(metalGate) + "/+" + int(energyGate));
            return null;
        }
        CCircuitUnit@ b = u;
        if (!u.circuitDef.CanBuild(d)) {
            if (UnitHelpers::IsCommander(u.circuitDef) || ai.frame < padNextRecruit) return null;
            padNextRecruit = ai.frame + Global::SiloAntiNukes::RecruitSeconds * SECOND;
            @b = Capable(d, Global::Map::StartPos);
            if (b is null) { PadHeld(u.circuitDef.GetName() + " cannot build an antinuke and no free builder can"); return null; }
        }
        RaiseCaps(want);
        int slot = -1;
        for (uint s = 0; s < padSlots.length() && slot < 0; ++s)
            if (aiTerrainMgr.GetReservationState(padSlots[s]) == 0
                && aiTerrainMgr.CanReachAt(b, aiTerrainMgr.GetReservationPos(padSlots[s]), b.circuitDef.GetBuildDistance())) slot = padSlots[s];
        if (slot < 0) {
            if (ai.frame < padNextSearch) { PadHeld("periphery search backing off"); return null; }
            padNextSearch = ai.frame + 15 * SECOND;
            slot = ReservePeriphery(b, d, maxRadius, coreRadius);
            if (slot < 0) return null;
        }
        IUnitTask@ t = Order(b, d, slot);
        if (t is null) return null;
        @padPending = t;
        padOrderedAt = ai.frame;
        padRecruitId = b is u ? -1 : b.id;
        const AIFloat3 at = aiTerrainMgr.GetReservationPos(slot);
        GenericHelpers::LogUtil(Tag() + "[SiloAntiNuke] antinuke " + (have + 1) + " of " + want + " (" + known
            + " silos known) on periphery pad " + slot + " at (" + int(at.x) + ", " + int(at.z) + "); income +" + int(mi) + "/+" + int(ei)
            + (b is u ? "" : "; recruited " + b.circuitDef.GetName() + " " + b.id), 1);
        if (b is u) return t;
        aiBuilderMgr.AssignTask(b, t);
        return null;
    }
}

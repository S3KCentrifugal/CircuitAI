// FRONT gantry site clearing (owner, 2026-11-18).
#include "../../define.as"
#include "../../global.as"
#include "../../task.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/units/unit_helpers.as"
#include "../../helpers/units/unitdef_helpers.as"
#include "../../helpers/spatial/layout_helpers.as"
#include "../world/lanes.as"
#include "../world/porc_front_line.as"
#include "../team/ally_clear.as"

/******************************************************************************

FRONT GANTRY CLEAR

Played (11-15, 11-18 VENGEANCE infologs): a FRONT whose base had filled up
found no reservable gantry footprint within 2048 of its gantry anchors, so
every order was engine-sited and died with "CBFactoryTask: no site for
<gantry> at all"; one FRONT reached try 40 without a gantry.

Now, when Front_TryLadderGantry (roles/front/front.as) finds no reservable
site, Try() searches the same rings round FrontEcoLadder::GantryAnchors,
nearest ring first, for a site whose rectangle (the 12x12 footprint, the strip
of Front::GantryClearExitLength in front of its exit side, Margin round both)
holds only our own clearable structures, one to GantryClearMaxBlockers of
them and at most GantryClearMaxMetal, on flat buildable ground (sector,
water depth and builder threat: CanUpgradeTerrain; slope: FlatFraction; no
mex or geo spot; no allied layout).

Clearable (Kind): T1 porc (Global::Team::AllyClearPorc), T1 eco
(AllyClearEco), T1 construction turrets, walls and dragon's teeth, T2 radar
and jammer. Never (Critical): fusions and advanced fusions, antinukes,
long-range AA, tactical and EMP launchers, nukes, long-range plasma and
lolcannons, factories, energy storage; mexes and geos are not on the list.
Porc (and walls) must also be LEFT BEHIND (owner, 2026-11-18): at least
Global::PorcFrontLine::BehindMargin (500) behind our porc front line there,
the furthest-forward point where our defensive buildings have stood 2+
minutes (systems/world/porc_front_line.as); porc on or near the line, or
with no line known round it, is kept. Porc within GantryClearFactoryRadius of one of our factories that
has GantryClearFactoryCluster porc round it is that factory's cluster: kept.

A round (as T3Unstick's, t3_unstick.as): one native reclaim per blocker,
construction turrets in reach pulled onto it every 10 s, mobile constructors
within BuilderRange join from Builder::AiMakeTask (BuilderTask, at most
BuildersPerBlocker each) and the ladder's own T2 constructor is handed one
from Front_TryLadderGantry. Allied SMRTBARbs are asked through
Team::AllyClear with an "fg." key over the same rectangle: each gives its own
buildings there that pass the same rules on its side (Judge), then our
builders reclaim them (trade, then reclaim). When the blockers are gone (or
GantryClearReclaimSeconds pass) the reclaims still open are aborted, which
idles their builders, and the site is tested again with CanReserveBuilding.
Reservable: Front_TryLadderGantry orders the gantry there facing the cleared
exit (AiPreferFactoryFacing). Still blocked: the site is dropped and the
next round may pick another, GantryClearMaxSites in all; meanwhile the old
engine-sited order runs as before. Every unit is held as a handle for
identity and checked with ai.IsOwnedUnit before use; every task is checked
for null / IsDead before it is returned, compared or aborted.

Log [GantryClear]: search, round (each blocker with its rear depth), allied
gifts, verified / still blocked, ordered, framed (RESCUED), finished, died.

Cost: a search is one pass over our units to index structures in a 256-elmo
cell dictionary, then <= 17 rings x 12 angles x anchors candidates, each
O(structures in 2-6 cells) plus, for the few that pass, 4 native terrain
reads; at most once per GantryClearRetrySeconds, only while a FRONT wants a
gantry and has no reservable site. A round's Busy is O(blockers) per ask.
Tick is O(blockers) every second while clearing and one def-count read
(plus one owned-unit pass once a gantry appears) every 2 s after an order.

******************************************************************************/
namespace FrontGantryClear {
    const int IDLE = 0, CLEARING = 1, READY = 2, ORDERED = 3, DONE = 4;
    const float Cell = 256.0f;

    // Never cleared (owner, 2026-11-18): advanced fusions, antinukes, long-range AA, tactical / EMP launchers,
    // nukes, long-range plasma and lolcannons. Fusions, energy storage and factories are tested by helper.
    const array<string> CriticalNames = {
        "armafus", "corafus", "legafus",
        "armamd", "corfmd", "legabm",
        "armmercury", "corscreamer", "leglraa",
        "armemp", "cortron", "legperdition",
        "armsilo", "corsilo", "legsilo",
        "armbrtha", "corint", "leglrpc", "armvulc", "corbuzz", "legstarfall" };

    int state = IDLE;
    AIFloat3 site;
    int facing = 0;
    AIFloat3 rectCentre;
    float rectHX = 0.0f, rectHZ = 0.0f;
    int roundStart = -1;
    int rounds = 0;
    int nextSearch = 0;
    int lastPull = -100000;
    int lastHold = -100000;
    string allyKey = "";
    array<int> blockers;
    dictionary blockerUnit;     // id -> CCircuitUnit@ (identity of the round's blocker)
    dictionary reclaimTask;     // id -> IUnitTask@
    array<AIFloat3> failed;     // sites still blocked after a round
    IUnitTask@ order = null;
    int reservation = -1;       // the cleared site's native reservation, pinned to the gantry order
    CCircuitDef@ gantryDef = null;
    int lastReserveTry = -100000;
    int orderFrame = -1;
    int gantryId = -1;
    CCircuitUnit@ gantryUnit = null;
    int lastWatch = -100000;
    // report counters
    int nSearch = 0, nNoSite = 0, nRound = 0, nVerified = 0, nBlocked = 0, nOrdered = 0, nFramed = 0, nFinished = 0, nDied = 0;

    bool On() { return Global::AISettings::Role == AiRole::FRONT && Global::RoleSettings::Front::GantryClear; }
    void Log(const string &in s) { GenericHelpers::LogUtil("[GantryClear] " + s, 1); }
    string At(const AIFloat3 &in p) { return "(" + int(p.x) + "," + int(p.z) + ")"; }

    // ------------------------------------------------------------------ the rules

    float Half(const CCircuitDef@ d)   // half the footprint, elmos (as T3Unstick::HalfSize)
    {
        if (d is null) return 0.0f;
        return float(AiMax(d.GetFootprintX(), d.GetFootprintZ())) * SQUARE_SIZE * 0.5f;
    }
    bool IsFactory(const string &in n)
    {
        return UnitHelpers::IsT1BotLab(n) || UnitHelpers::IsT2BotLab(n) || UnitHelpers::IsT1VehicleLab(n) || UnitHelpers::IsT2VehicleLab(n)
            || UnitHelpers::IsT1AircraftPlant(n) || UnitHelpers::IsT2AircraftPlant(n) || UnitHelpers::IsGantryLab(n)
            || UnitHelpers::IsT1HoverPlant(n) || UnitHelpers::IsFloatingHoverPlant(n);
    }
    bool IsPorc(const string &in n) { return Global::Team::AllyClearPorc.find(n) >= 0; }
    bool IsWall(const string &in n) { return Global::T3Unstick::WallClear.find(n) >= 0; }
    // "" when the structure is not one of the owner's never-reclaim kinds
    string Critical(const string &in n)
    {
        if (UnitHelpers::IsAnyFusionReactor(n)) return "fusion";
        if (CriticalNames.find(n) >= 0) return "critical";
        if (UnitHelpers::IsEnergyStorage(n)) return "energy storage";
        if (IsFactory(n)) return "factory";
        return "";
    }
    // The kinds a gantry site may be cleared of (before the rear and factory-cluster tests)
    bool Kind(const string &in n)
    {
        if (Critical(n).length() > 0) return false;
        return IsPorc(n) || Global::Team::AllyClearEco.find(n) >= 0 || UnitHelpers::IsT1Nano(n) || IsWall(n)
            || Global::Team::AllyClearIntel.find(n) >= 0;
    }

    // Judge context: our factories' porc counts, loaded once per search (or per allied request)
    array<AIFloat3> facPos;
    array<int> facPorc;
    int judgeFrame = -1;

    // How far p stands behind our porc front line there (PorcFrontLine, owner 2026-11-18); no line known: -1e9 (kept)
    float RearDepth(const AIFloat3 &in p)
    {
        bool known = false;
        const float b = PorcFrontLine::Behind(p, known);
        return known ? b : -1.0e9f;
    }

    // O(units) once, then O(factories x porc)
    void PrepareJudge()
    {
        if (judgeFrame == ai.frame) return;
        judgeFrame = ai.frame;
        PorcFrontLine::Ensure();
        facPos.resize(0); facPorc.resize(0);
        array<AIFloat3> porc;
        array<Id>@ own = ai.GetOwnedUnitIds();
        for (uint i = 0; i < own.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(own[i]);
            if (!ai.IsOwnedUnit(u) || u.circuitDef.IsMobile()) continue;
            const string n = u.circuitDef.GetName();
            if (IsFactory(n)) facPos.insertLast(u.GetPos(ai.frame));
            else if (IsPorc(n)) porc.insertLast(u.GetPos(ai.frame));
        }
        const float r = Global::RoleSettings::Front::GantryClearFactoryRadius;
        const float rsq = r * r;
        for (uint f = 0; f < facPos.length(); ++f) {
            int n = 0;
            for (uint k = 0; k < porc.length(); ++k) if (facPos[f].SqDistance2D(porc[k]) <= rsq) ++n;
            facPorc.insertLast(n);
        }
    }
    bool InFactoryCluster(const AIFloat3 &in p)
    {
        const float r = Global::RoleSettings::Front::GantryClearFactoryRadius;
        for (uint f = 0; f < facPos.length(); ++f)
            if (facPorc[f] >= Global::RoleSettings::Front::GantryClearFactoryCluster && facPos[f].SqDistance2D(p) <= r * r) return true;
        return false;
    }
    // A structure of ours that may be cleared for a gantry; why: the reason it is kept. Needs PrepareJudge.
    bool Judge(CCircuitUnit@ u, string &out why)
    {
        why = "";
        if (!ai.IsOwnedUnit(u) || u.circuitDef is null || u.circuitDef.IsMobile()) { why = "gone"; return false; }
        const string n = u.circuitDef.GetName();
        const string crit = Critical(n);
        if (crit.length() > 0) { why = crit; return false; }
        if (!Kind(n)) { why = "not on the list"; return false; }
        if (aiBuilderMgr.IsReclaimProtected(u.circuitDef)) { why = "protected"; return false; }
        if (IsPorc(n) || IsWall(n)) {
            const AIFloat3 p = u.GetPos(ai.frame);
            if (RearDepth(p) < Global::PorcFrontLine::BehindMargin) { why = "front porc"; return false; }
            if (IsPorc(n) && InFactoryCluster(p)) { why = "factory cluster"; return false; }
        }
        return true;
    }

    // ------------------------------------------------------------------ geometry

    AIFloat3 Fwd(int f)
    {
        if (f == 1) return AIFloat3(1.0f, 0.0f, 0.0f);    // east
        if (f == 2) return AIFloat3(0.0f, 0.0f, -1.0f);   // north
        if (f == 3) return AIFloat3(-1.0f, 0.0f, 0.0f);   // west
        return AIFloat3(0.0f, 0.0f, 1.0f);                // south
    }
    // The footprint, the exit strip in front of it and the margin round both, as one axis-aligned rectangle
    void Rect(const AIFloat3 &in p, int f, float gh, AIFloat3 &out c, float &out hx, float &out hz)
    {
        const float exitLen = Global::RoleSettings::Front::GantryClearExitLength;
        const float m = Global::RoleSettings::Front::GantryClearMargin;
        const float along = gh + m + exitLen * 0.5f, across = gh + m;
        const AIFloat3 fw = Fwd(f);
        c = AIFloat3(p.x + fw.x * exitLen * 0.5f, p.y, p.z + fw.z * exitLen * 0.5f);
        hx = ((f & 1) == 0) ? across : along;
        hz = ((f & 1) == 0) ? along : across;
    }

    // ------------------------------------------------------------------ search

    // structure index of one search (parallel arrays)
    array<CCircuitUnit@> sUnit;
    array<AIFloat3> sPos;
    array<float> sHalf, sCost;
    array<bool> sOk;
    array<string> sWhy;
    dictionary grid;   // "cx:cz" -> array<int>@

    string CellKey(int cx, int cz) { return "" + cx + ":" + cz; }
    void Index()
    {
        sUnit.resize(0); sPos.resize(0); sHalf.resize(0); sCost.resize(0); sOk.resize(0); sWhy.resize(0);
        grid.deleteAll();
        array<Id>@ own = ai.GetOwnedUnitIds();
        for (uint i = 0; i < own.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(own[i]);
            if (!ai.IsOwnedUnit(u) || u.circuitDef.IsMobile()) continue;
            string why;
            const bool ok = Judge(u, why);
            const int k = int(sUnit.length());
            sUnit.insertLast(u);
            const AIFloat3 p = u.GetPos(ai.frame);
            sPos.insertLast(p);
            const float h = Half(u.circuitDef);
            sHalf.insertLast(h);
            sCost.insertLast(u.circuitDef.costM);
            sOk.insertLast(ok);
            sWhy.insertLast(ok ? "" : u.circuitDef.GetName() + " " + why);
            // a structure goes in every cell its footprint touches
            const int x0 = int((p.x - h) / Cell), x1 = int((p.x + h) / Cell);
            const int z0 = int((p.z - h) / Cell), z1 = int((p.z + h) / Cell);
            for (int cx = x0; cx <= x1; ++cx) for (int cz = z0; cz <= z1; ++cz) {
                const string key = CellKey(cx, cz);
                array<int>@ list = null;
                if (!grid.get(key, @list) || list is null) { @list = array<int>(); grid.set(key, @list); }
                list.insertLast(k);
            }
        }
    }
    // Our structures overlapping the rectangle (each once). O(structures in its cells).
    void Blockers(const AIFloat3 &in c, float hx, float hz, array<int>@ res)
    {
        res.resize(0);
        const int x0 = int((c.x - hx) / Cell), x1 = int((c.x + hx) / Cell);
        const int z0 = int((c.z - hz) / Cell), z1 = int((c.z + hz) / Cell);
        for (int cx = x0; cx <= x1; ++cx) for (int cz = z0; cz <= z1; ++cz) {
            array<int>@ list = null;
            if (!grid.get(CellKey(cx, cz), @list) || list is null) continue;
            for (uint i = 0; i < list.length(); ++i) {
                const int k = list[i];
                const float h = sHalf[k];
                if (abs(sPos[k].x - c.x) >= hx + h || abs(sPos[k].z - c.z) >= hz + h) continue;
                if (res.find(k) < 0) res.insertLast(k);
            }
        }
    }
    bool Failed(const AIFloat3 &in p)
    {
        for (uint i = 0; i < failed.length(); ++i) if (p.SqDistance2D(failed[i]) < 200.0f * 200.0f) return true;
        return false;
    }

    // Cells of the footprint (+ Margin) that none of `hit` covers, sampled every 16 elmos: each must be free for
    // a reservation (no factory corridor, layout zone mark, allied layout or other structure: CanReserveArea on
    // one cell), else clearing `hit` cannot make the site reservable. Returns the blocked count of `total`.
    int OutsideBlocked(const AIFloat3 &in p, float gh, array<int>@ hit, int &out total)
    {
        total = 0;
        int blocked = 0;
        const float h = gh + Global::RoleSettings::Front::GantryClearMargin;
        for (float dz = -h + 8.0f; dz < h; dz += 16.0f) {
            for (float dx = -h + 8.0f; dx < h; dx += 16.0f) {
                const AIFloat3 q(p.x + dx, p.y, p.z + dz);
                bool covered = false;
                for (uint i = 0; i < hit.length() && !covered; ++i) {
                    const int k = hit[i];
                    covered = abs(sPos[k].x - q.x) < sHalf[k] + 8.0f && abs(sPos[k].z - q.z) < sHalf[k] + 8.0f;
                }
                if (covered) continue;
                ++total;
                if (!aiTerrainMgr.CanReserveArea(q, 0, 7.0f, 7.0f)) ++blocked;
            }
        }
        return blocked;
    }

    // The nearest clearable site round the anchors (rings outward, every anchor per ring); false: none.
    bool Search(CCircuitDef@ gantry, int f, AIFloat3 &out best, array<int>@ found)
    {
        // reservation tests read the native layout: opened for the search only when off (as FrontGantryNanos)
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) { Log("search: native layout refused; no search"); return false; }
        const bool any = SearchIn(gantry, f, best, found);
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
        return any;
    }
    bool SearchIn(CCircuitDef@ gantry, int f, AIFloat3 &out best, array<int>@ found)
    {
        PrepareJudge();
        Index();
        array<AIFloat3>@ anchors = FrontEcoLadder::GantryAnchors();
        const float gh = Half(gantry);
        const float W = float(aiTerrainMgr.GetTerrainWidth()), H = float(aiTerrainMgr.GetTerrainHeight());
        array<int> hit;
        int tested = 0, keptBy = 0, tooMany = 0, terrain = 0, empty = 0, other = 0;
        string firstKept = "";
        for (int ring = 0; ring <= 16; ++ring) {
            for (uint a = 0; a < anchors.length(); ++a) {
                for (int k = 0; k < (ring == 0 ? 1 : 12); ++k) {
                    const float ang = 0.5236f * float(k);
                    const AIFloat3 p(anchors[a].x + cos(ang) * 128.0f * float(ring), 0.0f, anchors[a].z + sin(ang) * 128.0f * float(ring));
                    if (p.x < 200.0f || p.z < 200.0f || p.x > W - 200.0f || p.z > H - 200.0f) continue;
                    if (Failed(p) || RoleFront::Front_GantrySiteFailed(p)) continue;
                    ++tested;
                    AIFloat3 c; float hx, hz;
                    Rect(p, f, gh, c, hx, hz);
                    Blockers(c, hx, hz, hit);
                    if (hit.length() == 0) { ++empty; continue; }   // not blocked by anything of ours: terrain, a reservation or an ally
                    bool ok = true;
                    float metal = 0.0f;
                    for (uint i = 0; i < hit.length() && ok; ++i) {
                        if (!sOk[hit[i]]) { ok = false; if (firstKept.length() == 0) firstKept = sWhy[hit[i]]; }
                        metal += sCost[hit[i]];
                    }
                    if (!ok) { ++keptBy; continue; }
                    if (int(hit.length()) > Global::RoleSettings::Front::GantryClearMaxBlockers
                        || metal > Global::RoleSettings::Front::GantryClearMaxMetal) { ++tooMany; continue; }
                    if (!aiTerrainMgr.CanUpgradeTerrain(gantry, p)
                        || aiTerrainMgr.FlatFraction(p, f, gh, gh, Global::RoleSettings::Front::GantryClearMaxSlope) < Global::RoleSettings::Front::GantryClearMinFlat
                        || aiTerrainMgr.IsResourceAreaBlocked(p, f, gh, gh) || aiTerrainMgr.IsAllyLayoutBlocked(gantry, p, f)) { ++terrain; continue; }
                    int cells = 0;
                    if (OutsideBlocked(p, gh, hit, cells) > 0) { ++other; continue; }   // a corridor, a zone or an ally there too
                    best = p;
                    found.resize(0);
                    for (uint i = 0; i < hit.length(); ++i) found.insertLast(hit[i]);
                    Log("search " + (nSearch + 1) + ": site " + At(p) + " ring " + ring + " of anchor " + a + " facing " + f + ", "
                        + hit.length() + " blocker(s) " + int(metal) + " M (" + tested + " tested, " + empty + " free of ours, "
                        + keptBy + " with a kept structure, " + tooMany + " too many, " + terrain + " terrain, " + other + " blocked by more than ours)");
                    return true;
                }
            }
        }
        Log("search " + (nSearch + 1) + ": no clearable site (" + tested + " tested, " + empty + " free of ours, " + keptBy
            + " with a kept structure" + (firstKept.length() > 0 ? " e.g. " + firstKept : "") + ", " + tooMany + " too many, " + terrain + " terrain, "
            + other + " blocked by more than ours)");
        return false;
    }

    // ------------------------------------------------------------------ the round

    // Front_TryLadderGantry, no reservable site: start a round. True: a round is running (hold the gantry).
    bool Try(CCircuitDef@ gantry, int f)
    {
        if (!On() || state != IDLE || gantry is null) return false;
        if (rounds >= Global::RoleSettings::Front::GantryClearMaxSites || ai.frame < nextSearch) return false;
        AIFloat3 p;
        array<int> found;
        const bool any = Search(gantry, f, p, found);
        ++nSearch;
        if (!any) {
            ++nNoSite;
            nextSearch = ai.frame + int(Global::RoleSettings::Front::GantryClearRetrySeconds) * SECOND;
            return false;
        }
        site = p; facing = f;
        @gantryDef = gantry;
        ReleaseReservation();
        Rect(p, f, Half(gantry), rectCentre, rectHX, rectHZ);
        ReleaseRound(false);
        string list = "";
        const int timeout = int(Global::RoleSettings::Front::GantryClearReclaimSeconds) * SECOND;
        for (uint i = 0; i < found.length(); ++i) {
            CCircuitUnit@ b = sUnit[found[i]];
            if (!ai.IsOwnedUnit(b)) continue;
            const string name = b.circuitDef.GetName();
            const AIFloat3 bp = b.GetPos(ai.frame);
            const int bid = b.id;
            IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, b, timeout));
            if (t is null || t.IsDead()) { list += " " + name + "(no task)"; continue; }
            @b = ai.GetTeamUnit(bid);   // Enqueue may dispatch callbacks: read the blocker again by id
            if (!ai.IsOwnedUnit(b)) { aiBuilderMgr.AbortTask(t); continue; }
            const string key = "" + bid;
            blockers.insertLast(bid);
            blockerUnit.set(key, @b);
            reclaimTask.set(key, @t);
            const bool porc = IsPorc(name) || IsWall(name);
            list += " " + name + " " + bid + " " + At(bp) + (porc ? " behind line +" + int(RearDepth(bp)) : "");
        }
        ++rounds; ++nRound;
        roundStart = ai.frame;
        lastPull = -100000;
        state = CLEARING;
        allyKey = "fg." + ai.teamId + "." + rounds;
        lastHold = ai.frame;
        const bool asked = Team::AllyClear::Hold(allyKey, rectCentre, rectHX, rectHZ);
        Log("round " + rounds + " at " + At(site) + " facing " + facing + ": reclaiming [" + list + " ]"
            + (asked ? ", allied SMRTBARbs asked" : ""));
        if (blockers.length() == 0 && !asked) { state = IDLE; failed.insertLast(site); Log("round " + rounds + ": nothing could be ordered; site dropped"); return false; }
        return true;
    }

    // Abort the round's reclaims still open (their builders go idle) and forget its blockers
    void ReleaseRound(bool abort)
    {
        for (uint i = 0; i < blockers.length(); ++i) {
            const string key = "" + blockers[i];
            IUnitTask@ t = null;
            if (abort && reclaimTask.get(key, @t) && t !is null && !t.IsDead()) aiBuilderMgr.AbortTask(t);
        }
        blockers.resize(0);
        blockerUnit.deleteAll();
        reclaimTask.deleteAll();
    }

    CCircuitUnit@ Live(int id)
    {
        CCircuitUnit@ b = null;
        if (!blockerUnit.get("" + id, @b) || !ai.IsOwnedUnit(b)) return null;
        return b;
    }

    bool Busy()
    {
        if (ai.frame - roundStart >= int(Global::RoleSettings::Front::GantryClearReclaimSeconds) * SECOND) return false;
        for (uint i = 0; i < blockers.length(); ++i) if (Live(blockers[i]) !is null) return true;
        return Team::AllyClear::Busy(allyKey);
    }

    // The site, else the nearest of the 24 points 32 / 64 round it (the build position snaps to the footprint
    // grid; the cleared rectangle has Margin to spare), same facing. Needs the native layout on.
    bool Reservable(CCircuitDef@ gantry, AIFloat3 &out at)
    {
        at = site;
        if (gantry is null) return false;
        for (int r = 0; r <= 2; ++r) {
            for (int dx = -r; dx <= r; ++dx) for (int dz = -r; dz <= r; ++dz) {
                if (AiMax(AiMax(dx, -dx), AiMax(dz, -dz)) != r) continue;
                const AIFloat3 q(site.x + 32.0f * float(dx), site.y, site.z + 32.0f * float(dz));
                if (aiTerrainMgr.CanReserveBuilding(gantry, q, facing)) { at = q; return true; }
            }
        }
        return false;
    }
    // Reserve the gantry at `at`: our facing first, then the other three. Native ReserveBuilding also routes the
    // gantry's own factory corridor (EnsureFactoryCorridor), which CanReserveBuilding does not: played (f5 11-18)
    // two cleared sites were reservable but refused for the cleared facing. -1: none took.
    int ReserveAt(CCircuitDef@ gantry, const AIFloat3 &in at)
    {
        for (int k = 0; k < 4; ++k) {
            const int f = (facing + (k == 0 ? 0 : k == 1 ? 1 : k == 2 ? 3 : 2)) % 4;
            const int id = aiTerrainMgr.ReserveBuilding(gantry, at, f, 0);
            if (id >= 0) {
                if (f != facing) Log("slot " + id + " at " + At(at) + " faces " + f + " (facing " + facing + " refused: its factory corridor)");
                facing = f;
                return id;
            }
        }
        return -1;
    }

    // While clearing (Tick, every 2 s): the moment the footprint itself is reservable (exit-strip blockers may
    // still stand) it is reserved, so no other builder fills the hole. Played (f4 11-18): 35-64 of 64 cells
    // were taken again during 2-4 minute rounds.
    void TryReserveEarly()
    {
        if (reservation >= 0 || gantryDef is null || ai.frame - lastReserveTry < 2 * SECOND) return;
        lastReserveTry = ai.frame;
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) return;
        AIFloat3 at;
        if (Reservable(gantryDef, at)) {
            reservation = ReserveAt(gantryDef, at);
            if (reservation < 0) lastReserveTry = ai.frame + 8 * SECOND;   // refused (corridor): try again in 10 s
            if (reservation >= 0) Log("round " + rounds + ": footprint free at " + At(at) + " after " + ((ai.frame - roundStart) / SECOND)
                + " s, reserved (slot " + reservation + ") while the rest clears");
        }
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
    }

    void EndRound(CCircuitDef@ gantry)
    {
        string left = "";
        for (uint i = 0; i < blockers.length(); ++i) {
            CCircuitUnit@ b = Live(blockers[i]);
            if (b !is null) left += " " + b.circuitDef.GetName() + " " + b.id;
        }
        ReleaseRound(true);
        // the site itself, else the nearest of the 24 points 32 / 64 round it (the build position snaps to the
        // footprint grid; the cleared rectangle has Margin to spare), same facing
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        const bool opened = !layoutOn && aiTerrainMgr.SetLayoutEnabled(true);
        AIFloat3 at = site;
        bool ok = reservation >= 0;   // reserved early, as soon as the footprint was free (Tick)
        if (ok) at = aiTerrainMgr.GetReservationPos(reservation);
        else ok = Reservable(gantry, at);
        const int secs = (ai.frame - roundStart) / SECOND;
        if (ok) {
            // Reserved at once, so no other builder fills the hole, and pinned to the order: played (f4 11-18) an
            // unpinned order at a reservable cleared site died at once ("CBFactoryTask: no site ... at all")
            if (reservation < 0) reservation = ReserveAt(gantry, at);
            if (opened) aiTerrainMgr.SetLayoutEnabled(false);
            ++nVerified;
            state = READY;
            Log("round " + rounds + " at " + At(site) + ": cleared in " + secs + " s, site reservable at " + At(at)
                + (reservation >= 0 ? ", reserved (slot " + reservation + ")" : ", reservation refused") + "; ordering the gantry there"
                + (left.length() > 0 ? " (still standing:" + left + ")" : ""));
            site = at;
            return;
        }
        // what still refuses it (diagnostics, no side effects)
        const float gh = Half(gantry);
        array<int> none;
        int cells = 0;
        const int cellsBlocked = OutsideBlocked(site, gh, none, cells);
        string diag = " | footprint cells blocked " + cellsBlocked + "/" + cells
            + " area " + (aiTerrainMgr.CanReserveArea(site, facing, gh, gh) ? "free" : "blocked")
            + " allyLayout " + (aiTerrainMgr.IsAllyLayoutBlocked(gantry, site, facing) ? "blocked" : "free")
            + " exit " + (aiTerrainMgr.IsExitClear(gantry, site, facing, Global::RoleSettings::Front::GantryClearExitLength, 16.0f) ? "clear" : "blocked")
            + " buildable " + int(100.0f * aiTerrainMgr.BuildableFraction(gantry, site, gh, gh, facing)) + "%"
            + " flat " + int(100.0f * aiTerrainMgr.FlatFraction(site, facing, gh, gh, Global::RoleSettings::Front::GantryClearMaxSlope)) + "%";
        if (opened) aiTerrainMgr.SetLayoutEnabled(false);
        diag += layoutOn ? "" : " (layout opened for the test)";
        ++nBlocked;
        ReleaseReservation();
        failed.insertLast(site);
        state = IDLE;
        nextSearch = ai.frame + 5 * SECOND;
        Log("round " + rounds + " at " + At(site) + ": still not reservable after " + secs + " s"
            + (left.length() > 0 ? " (still standing:" + left + ")" : " (nothing of ours left: a reservation, an ally or the ground)")
            + "; site dropped" + (rounds >= Global::RoleSettings::Front::GantryClearMaxSites ? ", no rounds left" : "") + diag);
    }

    // Front_TryLadderGantry, before its own site search: 1 a round is clearing (hold), 2 a cleared site is ready
    int Pending(CCircuitDef@ gantry, AIFloat3 &out at, int &out f)
    {
        at = site; f = facing;
        if (!On()) return 0;
        if (state == CLEARING) {
            if (Busy()) return 1;
            EndRound(gantry);
        }
        if (state == READY) { at = site; f = facing; return 2; }
        return 0;
    }

    // Front_TryLadderGantry ordered the gantry at the ready site
    void ReleaseReservation()
    {
        if (reservation >= 0) aiTerrainMgr.ReleaseReservation(reservation);
        reservation = -1;
    }
    void Ordered(IUnitTask@ t)
    {
        if (state != READY || t is null) return;
        // the pinned slot carries its facing; without one, ask for that facing (it skips native's direct site)
        const bool pinned = reservation >= 0 && AiPinReservation(t, reservation);
        if (!pinned) {
            if (reservation >= 0) Log("could not pin slot " + reservation + " to the gantry order");
            AiPreferFactoryFacing(t, facing);
        }
        @order = t;
        orderFrame = ai.frame;
        state = ORDERED;
        ++nOrdered;
        Log("gantry ordered at cleared site " + At(site) + " facing " + facing + (pinned ? " on slot " + reservation : " unpinned") + " (round " + rounds + ")");
    }
    // ... or could not order it there
    void OrderFailed()
    {
        if (state != READY) return;
        ReleaseReservation();
        failed.insertLast(site);
        state = IDLE;
        Log("gantry could not be ordered at cleared site " + At(site) + "; site dropped");
    }

    // A mobile constructor near a running round's blocker reclaims it (Builder::AiMakeTask, and the
    // ladder's T2 constructor from Front_TryLadderGantry)
    IUnitTask@ BuilderTask(CCircuitUnit@ u)
    {
        if (!On() || state != CLEARING || blockers.length() == 0 || !ai.IsOwnedUnit(u)) return null;
        if (!u.circuitDef.IsMobile() || UnitHelpers::IsCommander(u.circuitDef)) return null;
        IBuilderTask@ current = u.task is null ? null : cast<IBuilderTask>(u.task);
        if (current !is null && Task::BuildType(current.GetBuildType()) < Task::BuildType::REPAIR) return null;
        const AIFloat3 upos = u.GetPos(ai.frame);
        const float range = Global::RoleSettings::Front::GantryClearBuilderRange;
        float bestSq = range * range;
        CCircuitUnit@ best = null;
        for (uint i = 0; i < blockers.length(); ++i) {
            CCircuitUnit@ b = Live(blockers[i]);
            if (b is null || b is u) continue;
            const AIFloat3 bpos = b.GetPos(ai.frame);
            const float sq = upos.SqDistance2D(bpos);
            if (sq > bestSq) continue;
            IUnitTask@ live = null;
            if (reclaimTask.get("" + b.id, @live) && Team::AllyClear::LiveReclaim(live, b)) {
                if (live is u.task) return live;
                if (int(live.GetUnits().length()) >= Global::RoleSettings::Front::GantryClearBuildersPerBlocker) continue;
            }
            if (!aiTerrainMgr.CanReachAt(u, bpos, u.circuitDef.GetBuildDistance())) continue;
            bestSq = sq;
            @best = b;
        }
        if (best is null) return null;
        const int bid = best.id, uid = u.id;
        IUnitTask@ live = null;
        if (reclaimTask.get("" + bid, @live) && Team::AllyClear::LiveReclaim(live, best)) return live;
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, best,
            int(Global::RoleSettings::Front::GantryClearReclaimSeconds) * SECOND));
        if (t is null || t.IsDead()) return null;
        @best = ai.GetTeamUnit(bid);
        if (!ai.IsOwnedUnit(best)) { aiBuilderMgr.AbortTask(t); return null; }
        reclaimTask.set("" + bid, @t);
        blockerUnit.set("" + bid, @best);
        @u = ai.GetTeamUnit(uid);
        return ai.IsOwnedUnit(u) ? t : null;
    }

    // Front_MainUpdate, every second
    void Tick()
    {
        if (!On()) return;
        if (state == CLEARING) {
            if (ai.frame - lastPull >= 10 * SECOND && UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllGantries()) > 0) {
                // a gantry of ours came up meanwhile (Front_TryLadderGantry no longer asks): the round is not needed
                ReleaseRound(true);
                ReleaseReservation();
                state = DONE;
                Log("round " + rounds + " at " + At(site) + " stopped: a gantry of ours stands or is framed elsewhere");
                return;
            }
            TryReserveEarly();
            if (ai.frame - lastPull >= 10 * SECOND) {
                lastPull = ai.frame;
                for (uint i = 0; i < blockers.length(); ++i)
                    if (Live(blockers[i]) !is null) aiBuilderMgr.TurretsOnReclaim(blockers[i], Global::T3Unstick::TurretMargin, true, false);
            }
            return;
        }
        if (state != ORDERED || ai.frame - lastWatch < 2 * SECOND) return;
        lastWatch = ai.frame;
        if (gantryId < 0) {
            if (UnitDefHelpers::SumUnitDefCounts(UnitHelpers::GetAllGantries()) > 0) {
                // a gantry of ours stands or is framed: ours at the cleared site?
                CCircuitUnit@ g = null;
                float bestSq = 1.0e30f;
                array<Id>@ own = ai.GetOwnedUnitIds();
                for (uint i = 0; i < own.length(); ++i) {
                    CCircuitUnit@ x = ai.GetTeamUnit(own[i]);
                    if (!ai.IsOwnedUnit(x) || x.circuitDef.IsMobile() || !UnitHelpers::IsGantryLab(x.circuitDef.GetName())) continue;
                    const float sq = x.GetPos(ai.frame).SqDistance2D(site);
                    if (sq < bestSq) { bestSq = sq; @g = x; }
                }
                if (g !is null && bestSq <= 256.0f * 256.0f) {
                    gantryId = g.id; @gantryUnit = g;
                    reservation = -1;   // consumed by the gantry
                    ++nFramed;
                    Log("RESCUED: " + g.circuitDef.GetName() + " " + g.id + " framed at cleared site " + At(site) + " "
                        + ((ai.frame - orderFrame) / SECOND) + " s after the order (round " + rounds + ")");
                    return;
                }
                ReleaseReservation();
                state = DONE;
                Log("a gantry stands elsewhere" + (g !is null ? " (" + g.circuitDef.GetName() + " " + g.id + " at " + At(g.GetPos(ai.frame)) + ")" : "")
                    + "; the cleared site " + At(site) + " was not used");
                return;
            }
            if (order is null || order.IsDead()) {
                ReleaseReservation();
                ++nDied;
                @order = null;
                failed.insertLast(site);
                state = IDLE;
                nextSearch = ai.frame + 5 * SECOND;
                Log("order at cleared site " + At(site) + " died with no frame after " + ((ai.frame - orderFrame) / SECOND) + " s; site dropped");
            }
            return;
        }
        CCircuitUnit@ g = ai.GetTeamUnit(gantryId);
        if (!ai.IsOwnedUnit(g) || g !is gantryUnit) {
            state = DONE;
            Log("gantry " + gantryId + " at cleared site " + At(site) + " lost before it finished");
            return;
        }
        if (g.GetBuildProgress() >= 1.0f) {
            ++nFinished;
            state = DONE;
            Log("gantry " + g.circuitDef.GetName() + " " + g.id + " at cleared site " + At(site) + " finished "
                + ((ai.frame - orderFrame) / SECOND) + " s after the order | searches " + nSearch + " (" + nNoSite + " none), rounds "
                + nRound + ", verified " + nVerified + ", still blocked " + nBlocked + ", ordered " + nOrdered + ", died " + nDied);
        }
    }
}  // namespace FrontGantryClear

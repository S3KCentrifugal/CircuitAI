// TECH heavy LRPC block (owner, 2026-11-02).
#include "../../global.as"
#include "../../task.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/spatial/map_helpers.as"
#include "../../helpers/units/unit_helpers.as"
#include "../../helpers/math/lolcannon_math.as"

/******************************************************************************

HEAVY LRPC BLOCK

Owner, 2026-11-02: a TECH that won its roll (experimental_balanced main.as,
60%) builds, once it makes MetalIncomeGate (500) metal/s, a tight cluster of
Guns (6) long range plasma cannons (Basilica armbrtha, Intimidator corint,
Olympus leglrpc) within reach of the enemy heavy defences in front, between
RangeFar (80%) and RangeNear (50%) of the cannon's range away. Modelled on
the lolcannon program (lolcannon.as), TECH only:

  anchor  the frontmost enemy heavy defence: the one nearest our base of the
          enemy structures armed against the ground, not super weapons, of
          HeavyMinMetal (1200) metal or more (Pulsar, Bulwark, Bastion,
          Rattlesnake, ...), in sight (aiBattle ground contacts) or a ghost
          (out of sight, its spot not seen empty since). With none known
          FallbackSeconds (300) after the gate opened, the nearest known enemy
          armed structure, else the nearest enemy start. While none is known
          the allied AIR scouts the nearest enemy start every ScoutSeconds.
  site    rings round the anchor that keep the whole GunCols x GunRows (3x2)
          grid between the two fractions of the range, the candidate nearest
          our base first, facing the anchor; the ground must score
          SiteMinScore (flat x buildable) over the grid and the turret block
          beside it, every cannon footprint must reserve and MinTurrets of
          the turret slots. TECH keeps the reservations and pins its orders.
  crew    CrewShare (75%) of our T1 and T2 constructors, ground and air (not
          commanders, not a lolcannon crew, not a player's unit), nearest the
          site first, taken off every other task (Builder AiMakeTask asks here
          right after the lolcannon). T2 constructors order the cannons and
          the cover; T1 build the turrets and help every frame.
  order   Turrets (6) construction turrets first; the cannons once
          TurretsBeforeGuns (4) stand or TurretWaitSeconds (120) passed,
          GunsAtOnce (3) orders in flight, the crew helping.
  cover   once the cannons stand, the same crew builds Shields (2) of the
          side's shield just ahead of the block, HeavyPorc (2) heavy porc
          PorcAhead further towards the anchor, PorcSpread apart, and Flak (1)
          T2 flak behind (as the lolcannon's cover); then the crew is
          released. One block a game; GiveUpSeconds (1800) without it done
          releases the crew and tries a new site after RetrySeconds.

Cost: Tick once a second, nothing while off or done. The anchor scan walks
aiBattle's ground contacts and ghosts once every 10 s while waiting for a
site. The site search runs at most every 30 s until one is found: rings x
SiteAngles candidates, SiteProbes ground scores and reservation tries. The
crew scan walks our units every CrewOrderSeconds while the program runs.

******************************************************************************/
namespace LrpcBlock {

    const int IDLE = 0, BUILD = 1, COVER = 2, DONE = 3;
    const array<string> SHIELDS = { "armgate", "corgate", "legdeflector" };
    const array<string> HEAVY_PORC = { "armanni", "cordoom", "legbastion" };
    const array<string> T2_FLAK = { "armflak", "corflak", "legflak" };
    const array<string> T1_CONS = { "armck", "corck", "legck", "armcv", "corcv", "legcv", "armch", "corch", "legch",
        "armca", "corca", "legca", "armbeaver", "cormuskrat", "legotter" };
    const array<string> T2_CONS = { "armack", "corack", "legack", "armacv", "coracv", "legacv", "armaca", "coraca", "legaca" };

    int phase = IDLE;
    int started = -1;
    int gateOpenAt = -1;
    int nextTick = 0, nextPlan = 0, nextCrew = 0, nextLog = 0, nextGateLog = 0, nextScout = 0, nextAnchor = 0;
    dictionary crew;                 // unit id -> true
    int crewCount = 0;

    AIFloat3 anchor(-1.0f, 0.0f, -1.0f);
    string anchorWhat = "";
    AIFloat3 site(-1.0f, 0.0f, -1.0f);
    int facing = 0;
    AIFloat3 blockCentre(-1.0f, 0.0f, -1.0f);
    array<AIFloat3> failedSites;

    // slot groups: 0 cannons, 1 turrets, 2 shields, 3 heavy porc, 4 flak
    const int GUN = 0, NANO = 1, SHIELD = 2, PORC = 3, FLAK = 4;
    array<array<AIFloat3>> pos(5);
    array<array<int>> res(5);
    array<array<IUnitTask@>> tasks(5);
    array<array<int>> miss(5);
    int coverStarted = -1;

    bool On() { return Global::LrpcBlock::Enabled && Global::AISettings::Role == AiRole::TECH; }
    string Key(int id) { return "" + id; }
    string Side() { return Global::AISettings::Side; }
    int SideIndex() { const string s = Side(); return (s == "legion") ? 2 : (s == "cortex" ? 1 : 0); }

    // Public: a block crew member (other programs leave these alone).
    bool IsCrew(int id) { return (phase == BUILD || phase == COVER) && crew.exists(Key(id)); }

    CCircuitDef@ Def(int g)
    {
        if (g == GUN) return ai.GetCircuitDef(UnitHelpers::GetLRPCNameForSide(Side()));
        if (g == NANO) return ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Side()));
        if (g == SHIELD) return ai.GetCircuitDef(SHIELDS[SideIndex()]);
        if (g == PORC) return ai.GetCircuitDef(HEAVY_PORC[SideIndex()]);
        return ai.GetCircuitDef(T2_FLAK[SideIndex()]);
    }
    string What(int g)
    {
        return g == GUN ? "LRPC" : (g == NANO ? "turret" : (g == SHIELD ? "shield" : (g == PORC ? "heavy porc" : "T2 flak")));
    }
    Task::BuildType TypeOf(int g)
    {
        if (g == GUN) return Task::BuildType::BIG_GUN;
        if (g == NANO) return Task::BuildType::NANO;
        if (g == PORC) return Task::BuildType::BUNKER;
        return Task::BuildType::DEFENCE;
    }
    float Range()
    {
        CCircuitDef@ gun = Def(GUN);
        return (gun is null) ? 0.0f : gun.GetMaxRange();
    }

    AIFloat3 Home()
    {
        return Layout::HasComplex() ? Layout::BaseCentre() : Global::Map::StartPos;
    }

    AIFloat3 At(const AIFloat3 &in c, const AIFloat3 &in side, float across, const AIFloat3 &in fwd, float along)
    {
        return AIFloat3(c.x + side.x * across + fwd.x * along, 0.0f, c.z + side.z * across + fwd.z * along);
    }

    void ReleaseAll(array<int>@ ids)
    {
        for (uint i = 0; i < ids.length(); ++i) if (ids[i] >= 0) { aiTerrainMgr.ReleaseReservation(ids[i]); ids[i] = -1; }
    }

    void ClearSlots()
    {
        for (int g = 0; g < 5; ++g) {
            ReleaseAll(res[g]);
            pos[g].resize(0); res[g].resize(0); tasks[g].resize(0); miss[g].resize(0);
        }
    }

    void FillTasks(int g)
    {
        tasks[g].resize(0); miss[g].resize(0);
        for (uint k = 0; k < pos[g].length(); ++k) { tasks[g].insertLast(null); miss[g].insertLast(0); }
    }

    // ---------------------------------------------------------------- the anchor

    bool IsHeavy(CCircuitDef@ d)
    {
        return d !is null && !d.IsMobile() && d.HasSurfToLand() && !d.IsRoleAny(Unit::Role::SUPER.mask)
            && d.costM >= Global::LrpcBlock::HeavyMinMetal;
    }
    bool IsArmedStatic(CCircuitDef@ d)
    {
        return d !is null && !d.IsMobile() && d.HasSurfToLand() && !d.IsRoleAny(Unit::Role::SUPER.mask);
    }

    // ai.GetCircuitDef(Id) indexes without a bounds check
    CCircuitDef@ DefOf(int id) { return (id >= 1 && id <= ai.GetDefCount()) ? ai.GetCircuitDef(id) : null; }

    // The enemy structure nearest home that passes `heavy` (else any armed one),
    // in sight or a ghost. O(ground contacts + ghosts), every 10 s while waiting.
    bool NearestEnemy(bool heavy, AIFloat3 &out at, string &out what)
    {
        const AIFloat3 home = Home();
        float best = -1.0f;
        const int nc = aiBattle.GetGroundContactCount();
        for (int i = 0; i < nc; ++i) {
            CCircuitDef@ d = DefOf(aiBattle.GetGroundContactDefId(i));
            if (heavy ? !IsHeavy(d) : !IsArmedStatic(d)) continue;
            const AIFloat3 p = aiBattle.GetGroundContactPos(i);
            const float sq = MapHelpers::SqDist(p, home);
            if (best >= 0.0f && sq >= best) continue;
            best = sq; at = p; what = d.GetName() + " in sight";
        }
        const int ng = aiBattle.GetGhostCount();
        for (int i = 0; i < ng; ++i) {
            CCircuitDef@ d = DefOf(aiBattle.GetGhostDefId(i));
            if (heavy ? !IsHeavy(d) : !IsArmedStatic(d)) continue;
            const AIFloat3 p = aiBattle.GetGhostPos(i);
            if (p.x < 0.0f) continue;
            const float sq = MapHelpers::SqDist(p, home);
            if (best >= 0.0f && sq >= best) continue;
            best = sq; at = p; what = d.GetName() + " last seen";
        }
        return best >= 0.0f;
    }

    bool FindAnchor()
    {
        AIFloat3 at;
        string what;
        if (NearestEnemy(true, at, what)) { anchor = at; anchorWhat = "heavy defence " + what; return true; }
        const bool fallback = gateOpenAt >= 0 && ai.frame - gateOpenAt >= Global::LrpcBlock::FallbackSeconds * SECOND;
        if (ai.frame >= nextScout) {
            nextScout = ai.frame + Global::LrpcBlock::ScoutSeconds * SECOND;
            const AIFloat3 start = NearestStart();
            if (start.x >= 0.0f && Global::LrpcBlock::ScoutT1 + Global::LrpcBlock::ScoutRadar > 0)
                LolCannonRecon::Send(Global::LrpcBlock::ScoutT1, Global::LrpcBlock::ScoutRadar, start, Global::LrpcBlock::ScoutSpread,
                    "LRPC block: no enemy heavy defence known");
        }
        if (!fallback) return false;
        if (NearestEnemy(false, at, what)) { anchor = at; anchorWhat = "armed structure " + what + " (no heavy defence known)"; return true; }
        const AIFloat3 start = NearestStart();
        if (start.x < 0.0f) return false;
        anchor = start; anchorWhat = "enemy start (no enemy defence known)";
        return true;
    }

    AIFloat3 NearestStart()
    {
        const array<AIFloat3> starts = Lanes::EnemyStarts();
        const AIFloat3 home = Home();
        AIFloat3 best(-1.0f, 0.0f, -1.0f);
        float bd = -1.0f;
        for (uint i = 0; i < starts.length(); ++i) {
            const float sq = MapHelpers::SqDist(starts[i], home);
            if (bd < 0.0f || sq < bd) { bd = sq; best = starts[i]; }
        }
        return best;
    }

    // ---------------------------------------------------------------- the site

    // Half extents of the cannon grid (across, along) at facing f.
    void GridHalf(CCircuitDef@ gun, int f, float &out hA, float &out hL)
    {
        const float pA = LolCannonMath::Pitch(Layout::Across(gun, f)) + Global::LrpcBlock::GunGap;
        const float pL = LolCannonMath::Pitch(Layout::Along(gun, f)) + Global::LrpcBlock::GunGap;
        hA = (float(AiMax(1, Global::LrpcBlock::GunCols)) * pA - Global::LrpcBlock::GunGap) * 0.5f;
        hL = (float(AiMax(1, Global::LrpcBlock::GunRows)) * pL - Global::LrpcBlock::GunGap) * 0.5f;
    }

    int TurretRowsAll() { return Global::LrpcBlock::TurretRows + AiMax(0, Global::LrpcBlock::TurretSpareRows); }

    float GroundScore(CCircuitDef@ gun, CCircuitDef@ nano, const AIFloat3 &in p, int f)
    {
        float hA, hL;
        GridHalf(gun, f, hA, hL);
        const float blockW = float(Global::LrpcBlock::TurretCols) * LolCannonMath::Pitch(Layout::Across(nano, f));
        const float blockL = float(TurretRowsAll()) * LolCannonMath::Pitch(Layout::Along(nano, f));
        const float halfAcross = hA + 16.0f + blockW;   // the block may go either side
        const float halfAlong = AiMax(hL, blockL * 0.5f);
        return aiTerrainMgr.FlatFraction(p, f, halfAcross, halfAlong, Global::RoleSettings::Tech::LayoutBoxMaxSlope)
            * aiTerrainMgr.BuildableFraction(nano, p, halfAcross, halfAlong, f);
    }

    // The cannon grid and the turret block on side `hand` at p, facing f: every
    // cannon must reserve and MinTurrets turrets. Keeps the reservations on success.
    bool TrySite(CCircuitDef@ gun, CCircuitDef@ nano, const AIFloat3 &in p, int f)
    {
        const AIFloat3 fwd = Layout::Fwd(f), side = Layout::Side(f);
        const int cols = AiMax(1, Global::LrpcBlock::GunCols), rows = AiMax(1, Global::LrpcBlock::GunRows);
        const float pA = LolCannonMath::Pitch(Layout::Across(gun, f)) + Global::LrpcBlock::GunGap;
        const float pL = LolCannonMath::Pitch(Layout::Along(gun, f)) + Global::LrpcBlock::GunGap;
        array<AIFloat3> gp; array<int> gr;
        const int guns = AiMin(Global::LrpcBlock::Guns, cols * rows);
        for (int r = 0; r < rows && int(gp.length()) < guns; ++r)
            for (int c = 0; c < cols && int(gp.length()) < guns; ++c) {
                const AIFloat3 q = At(p, side, LolCannonMath::Offset(c, cols, pA), fwd, LolCannonMath::Offset(r, rows, pL));
                const int id = aiTerrainMgr.CanReserveBuilding(gun, q, f) ? aiTerrainMgr.ReserveBuilding(gun, q, f) : -1;
                if (id < 0) { ReleaseAll(gr); return false; }
                gp.insertLast(aiTerrainMgr.GetReservationPos(id)); gr.insertLast(id);
            }
        float hA, hL;
        GridHalf(gun, f, hA, hL);
        const int tc = AiMax(1, Global::LrpcBlock::TurretCols), tr = TurretRowsAll();
        const float nA = LolCannonMath::Pitch(Layout::Across(nano, f)), nL = LolCannonMath::Pitch(Layout::Along(nano, f));
        const int want = AiMin(tc * tr, AiMax(Global::LrpcBlock::MinTurrets, Global::LrpcBlock::Turrets));
        for (int h = 0; h < 2; ++h) {
            const float hand = (h == 0) ? 1.0f : -1.0f;
            const AIFloat3 bc = At(p, side, hand * (hA + 16.0f + float(tc) * nA * 0.5f), fwd, 0.0f);
            array<AIFloat3> np; array<int> nr;
            for (int i = 0; i < tr && int(np.length()) < want; ++i) {
                const int r = LolCannonMath::CentreOut(i, tr);
                for (int c = 0; c < tc && int(np.length()) < want; ++c) {
                    const AIFloat3 q = At(bc, side, LolCannonMath::Offset(c, tc, nA), fwd, LolCannonMath::Offset(r, tr, nL));
                    const int id = aiTerrainMgr.CanReserveBuilding(nano, q, f) ? aiTerrainMgr.ReserveBuilding(nano, q, f) : -1;
                    if (id < 0) continue;
                    np.insertLast(aiTerrainMgr.GetReservationPos(id)); nr.insertLast(id);
                }
            }
            if (int(np.length()) < Global::LrpcBlock::MinTurrets) { ReleaseAll(nr); continue; }
            ClearSlots();
            pos[GUN] = gp; res[GUN] = gr; pos[NANO] = np; res[NANO] = nr;
            FillTasks(GUN); FillTasks(NANO);
            site = p; facing = f; blockCentre = bc;
            return true;
        }
        ReleaseAll(gr);
        return false;
    }

    bool NearFailed(const AIFloat3 &in p)
    {
        const float r = Global::LrpcBlock::SiteAvoidRadius;
        for (uint i = 0; i < failedSites.length(); ++i) if (MapHelpers::SqDist(failedSites[i], p) < r * r) return true;
        return false;
    }

    bool Plan()
    {
        CCircuitDef@ gun = Def(GUN);
        CCircuitDef@ nano = Def(NANO);
        if (gun is null || nano is null || anchor.x < 0.0f) return false;
        const float range = gun.GetMaxRange();
        const AIFloat3 home = Home();
        // the grid's own depth stays inside the band: the far row within RangeFar,
        // the near row outside RangeNear (its corners a little further, within the slack)
        float hA0, hL0;
        GridHalf(gun, 0, hA0, hL0);
        const float depth = AiMax(hA0, hL0);
        const float rMax = range * Global::LrpcBlock::RangeFar - depth, rMin = range * Global::LrpcBlock::RangeNear + depth;
        const float w = float(AiTerrainWidth()), h = float(AiTerrainHeight()), margin = 160.0f;
        const int probes = AiMax(1, Global::LrpcBlock::SiteProbes);
        array<AIFloat3> best; array<float> bestD; array<int> bestF;
        const float step = AiMax(32.0f, Global::LrpcBlock::SiteRingStep);
        for (float r = rMax; r >= rMin; r -= step) {
            for (int a = 0; a < Global::LrpcBlock::SiteAngles; ++a) {
                const float ang = float(a) * 6.2831853f / float(AiMax(1, Global::LrpcBlock::SiteAngles));
                const AIFloat3 p(anchor.x + cos(ang) * r, 0.0f, anchor.z + sin(ang) * r);
                if (p.x < margin || p.z < margin || p.x > w - margin || p.z > h - margin) continue;
                const float d = MapHelpers::SqDist(p, home);
                if (int(best.length()) >= probes * 2 && d >= bestD[best.length() - 1]) continue;
                uint at = best.length();
                while (at > 0 && bestD[at - 1] > d) --at;
                best.insertAt(at, p); bestD.insertAt(at, d);
                bestF.insertAt(at, LolCannonMath::Facing(anchor.x - p.x, anchor.z - p.z));
                if (int(best.length()) > probes * 2) { best.removeLast(); bestD.removeLast(); bestF.removeLast(); }
            }
        }
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) {
            GenericHelpers::LogUtil("[LrpcBlock] the profile's layout gate is closed; no site can be measured", 1);
            return false;
        }
        int tried = 0, scored = 0, avoided = 0;
        bool found = false;
        for (uint i = 0; i < best.length() && !found && tried < probes; ++i) {
            if (NearFailed(best[i])) { ++avoided; continue; }
            if (aiTerrainMgr.IsZoneAlly(best[i])) continue;
            ++scored;
            const float score = GroundScore(gun, nano, best[i], bestF[i]);
            if (score < Global::LrpcBlock::SiteMinScore) continue;
            ++tried;
            found = TrySite(gun, nano, best[i], bestF[i]);
            if (found)
                GenericHelpers::LogUtil("[LrpcBlock] site for " + pos[GUN].length() + " " + gun.GetName() + " (range " + int(range) + ") at ("
                    + int(site.x) + ", " + int(site.z) + "), facing " + facing + ", " + int(site.distance2D(anchor)) + " from the anchor ("
                    + int(range * Global::LrpcBlock::RangeNear) + ".." + int(range * Global::LrpcBlock::RangeFar) + "), "
                    + int(sqrt(bestD[i])) + " from home, ground " + int(score * 100.0f) + "%, " + pos[NANO].length() + " turret slots; anchor "
                    + anchorWhat + " at (" + int(anchor.x) + ", " + int(anchor.z) + ")", 1);
        }
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
        if (!found)
            GenericHelpers::LogUtil("[LrpcBlock] no site " + int(rMin) + ".." + int(rMax) + " from the anchor " + anchorWhat + " at (" + int(anchor.x)
                + ", " + int(anchor.z) + "): " + best.length() + " candidates, " + scored + " scored, " + tried + " tried, " + avoided
                + " near a failed site; retry in 30 s", 1);
        return found;
    }

    // ---------------------------------------------------------------- the crew

    int Tier(const CCircuitDef@ d)
    {
        if (d is null) return 0;
        const string n = d.GetName();
        if (T2_CONS.find(n) >= 0) return 2;
        if (T1_CONS.find(n) >= 0) return 1;
        return 0;
    }

    bool Free(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null || u.GetBuildProgress() < 1.0f || Tier(u.circuitDef) == 0) return false;
        if (u.task !is null && u.task.GetType() == int(Task::Type::PLAYER)) return false;
        return !LolCannon::IsCrew(u.id) && !Team::Ferry::IsGift(u.id) && !Team::Recovery::IsGift(u.id);
    }

    // CrewShare of our T1 and T2 constructors, nearest the site first. O(our units)
    // plus an insertion sort of the free constructors, every CrewOrderSeconds.
    void ClaimCrew()
    {
        if (ai.frame < nextCrew) return;
        nextCrew = ai.frame + Global::LrpcBlock::CrewOrderSeconds * SECOND;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        array<CCircuitUnit@> cand; array<float> cd;
        int total = 0;
        crewCount = 0;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null || Tier(u.circuitDef) == 0 || u.GetBuildProgress() < 1.0f) continue;
            ++total;
            if (crew.exists(Key(u.id))) { ++crewCount; continue; }
            if (!Free(u)) continue;
            const float d = MapHelpers::SqDist(u.GetPos(ai.frame), site);
            uint at = cand.length();
            while (at > 0 && cd[at - 1] > d) --at;
            cand.insertAt(at, u); cd.insertAt(at, d);
        }
        const int want = int(float(total) * Global::LrpcBlock::CrewShare + 0.5f);
        int taken = 0;
        for (uint i = 0; i < cand.length() && crewCount < want; ++i) {
            crew.set(Key(cand[i].id), true);
            ++crewCount; ++taken;
            IUnitTask@ t = BuilderTask(cand[i]);
            if (t !is null) aiBuilderMgr.AssignTask(cand[i], t);
        }
        if (taken > 0)
            GenericHelpers::LogUtil("[LrpcBlock] " + taken + " constructors taken for the crew: " + crewCount + " of " + total
                + " T1/T2 constructors (" + int(Global::LrpcBlock::CrewShare * 100.0f) + "% wanted)", 1);
    }

    void ReleaseCrew(const string &in why)
    {
        GenericHelpers::LogUtil("[LrpcBlock] crew of " + crewCount + " released: " + why, 1);
        crew.deleteAll();
        crewCount = 0;
    }

    void UnitRemoved(CCircuitUnit@ unit)
    {
        if (unit is null || !crew.exists(Key(unit.id))) return;
        crew.delete(Key(unit.id));
        if (crewCount > 0) --crewCount;
    }

    // ---------------------------------------------------------------- orders

    IUnitTask@ OrderAt(Task::BuildType type, CCircuitDef@ d, const AIFloat3 &in p, int id)
    {
        if (d is null) return null;
        if (d.maxThisUnit <= d.count + 1) d.maxThisUnit = d.count + 2;   // a role cap yields to the program
        const bool pin = id >= 0 && aiTerrainMgr.GetReservationState(id) == 0;
        const AIFloat3 at = pin ? aiTerrainMgr.GetReservationPos(id) : p;
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(type, Task::Priority::HIGH, d, at, 0.0f, true, 180 * SECOND));
        if (t is null) return null;
        if (pin && !AiPinReservation(t, id)) {
            aiBuilderMgr.AbortTask(t);
            GenericHelpers::LogUtil("[LrpcBlock] could not pin " + d.GetName() + " to slot " + id, 1);
            return null;
        }
        return t;
    }

    IUnitTask@ Wait(int seconds) { return aiBuilderMgr.Enqueue(TaskB::Wait(seconds * SECOND)); }

    int Flying(int g)
    {
        int n = 0;
        for (uint k = 0; k < tasks[g].length(); ++k) if (tasks[g][k] !is null && !tasks[g][k].IsDead()) ++n;
        return n;
    }

    // Our units of group g round the block: finished, and all (frames too).
    void Count(int g, int &out done, int &out all)
    {
        done = 0; all = 0;
        CCircuitDef@ d = Def(g);
        if (d is null || site.x < 0.0f) return;
        const float r = Global::LrpcBlock::CountRadius;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef !is d || MapHelpers::SqDist(u.GetPos(ai.frame), site) > r * r) continue;
            ++all;
            if (u.GetBuildProgress() >= 1.0f) ++done;
        }
    }

    // A slot group's next piece of work for u: a free slot ordered (T2 for what
    // only T2 can build), at most atOnce in flight; null when nothing is left to order.
    IUnitTask@ Order(CCircuitUnit@ u, int g, int atOnce)
    {
        CCircuitDef@ d = Def(g);
        if (d is null || !u.circuitDef.CanBuild(d)) return null;
        int done, all;
        Count(g, done, all);
        int flying = Flying(g);
        if (all + flying >= int(pos[g].length())) return null;
        for (uint k = 0; k < pos[g].length() && flying < atOnce; ++k) {
            if ((tasks[g][k] !is null && !tasks[g][k].IsDead()) || miss[g][k] >= 3) continue;
            if (aiBuilderMgr.FindOwnNear(pos[g][k], 40.0f, d) !is null) continue;
            if (tasks[g][k] !is null) { ++miss[g][k]; @tasks[g][k] = null; }   // its last order ended with nothing standing
            if (miss[g][k] >= 3) continue;
            // held back while the spot is under threat or out of reach (not a miss: the
            // front moves); GiveUpSeconds bounds the wait
            string unsafe;
            if (!Safe(u, pos[g][k], unsafe)) { NoteUnsafe(g, k, u, unsafe); continue; }
            @tasks[g][k] = OrderAt(TypeOf(g), d, pos[g][k], res[g][k]);
            if (tasks[g][k] is null) { ++miss[g][k]; continue; }
            res[g][k] = -1;   // pinned: the order owns the spot now
            GenericHelpers::LogUtil("[LrpcBlock] " + u.circuitDef.GetName() + " " + u.id + " orders " + What(g) + " " + d.GetName() + " "
                + (k + 1) + " of " + pos[g].length() + " at (" + int(pos[g][k].x) + ", " + int(pos[g][k].z) + ")", 1);
            return tasks[g][k];
        }
        return null;
    }

    int nextUnsafeLog = 0;
    void NoteUnsafe(int g, uint k, CCircuitUnit@ u, const string &in why)
    {
        if (ai.frame < nextUnsafeLog) return;
        nextUnsafeLog = ai.frame + 60 * SECOND;
        GenericHelpers::LogUtil("[LrpcBlock] " + What(g) + " " + (k + 1) + " at (" + int(pos[g][k].x) + ", " + int(pos[g][k].z) + ") held back: "
            + why + " for " + u.circuitDef.GetName() + " " + u.id, 1);
    }

    // The engine's own site test (IBuilderTask::FindBuildSite): no enemy threat on
    // it, and the builder can reach it; else the order is dropped silently.
    bool Safe(CCircuitUnit@ u, const AIFloat3 &in p, string &out why)
    {
        const float bd = u.circuitDef.GetBuildDistance();
        if (aiTerrainMgr.CanReachAtSafe(u, p, bd)) return true;
        why = aiTerrainMgr.CanReachAt(u, p, bd) ? "under enemy threat" : "out of reach";
        return false;
    }

    // A frame of group g round the block to help, or an order in flight u can join.
    IUnitTask@ Help(CCircuitUnit@ u, int g)
    {
        CCircuitDef@ d = Def(g);
        if (d is null) return null;
        CCircuitUnit@ unf = aiBuilderMgr.FindUnfinishedNear(site, Global::LrpcBlock::CountRadius, d);
        if (unf !is null) return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, unf, 30 * SECOND));
        if (!u.circuitDef.CanBuild(d)) return null;
        for (uint k = 0; k < tasks[g].length(); ++k)
            if (tasks[g][k] !is null && !tasks[g][k].IsDead()) return tasks[g][k];
        return null;
    }

    bool GunsMayStart()
    {
        int done, all;
        Count(NANO, done, all);
        return done >= AiMin(Global::LrpcBlock::TurretsBeforeGuns, int(pos[NANO].length()))
            || ai.frame - started >= Global::LrpcBlock::TurretWaitSeconds * SECOND;
    }

    // Builder AiMakeTask (after the lolcannon): a crew member's next piece of work.
    IUnitTask@ BuilderTask(CCircuitUnit@ u)
    {
        if (!On() || (phase != BUILD && phase != COVER) || u is null || u.circuitDef is null || !crew.exists(Key(u.id))) return null;
        IUnitTask@ t = null;
        if (phase == BUILD) {
            const bool guns = GunsMayStart();
            // T2 constructors order the cannons once the turrets allow, the turrets
            // before that; T1 the turrets; then everyone helps the frames
            if (guns) @t = Order(u, GUN, Global::LrpcBlock::GunsAtOnce);
            if (t is null) @t = Order(u, NANO, 3);
            if (t is null) @t = Help(u, NANO);
            if (t is null && guns) @t = Help(u, GUN);
        } else {
            for (int g = SHIELD; g <= FLAK && t is null; ++g) @t = Order(u, g, 2);
            for (int g = SHIELD; g <= FLAK && t is null; ++g) @t = Help(u, g);
            if (t is null) @t = Help(u, GUN);   // a damaged or rebuilt cannon frame
        }
        return (t is null) ? Wait(3) : t;
    }

    // ---------------------------------------------------------------- the cover

    void PlaceOne(CCircuitDef@ d, const AIFloat3 &in base, int g, const AIFloat3 &in side, const AIFloat3 &in fwd, bool ahead)
    {
        const float limit = ahead ? site.distance2D(anchor) - 64.0f : -1.0f;
        const float step = AiMax(LolCannonMath::Pitch(Layout::Across(d, facing)), LolCannonMath::Pitch(Layout::Along(d, facing))) + 16.0f;
        const float w = float(AiTerrainWidth()), h = float(AiTerrainHeight());
        for (int r = 0; r <= 3; ++r)
            for (int a = -r; a <= r; ++a)
                for (int b = -r; b <= r; ++b) {
                    if (AiMax(a, -a) != r && AiMax(b, -b) != r) continue;   // the ring only
                    const AIFloat3 q = At(base, side, float(a) * step, fwd, float(b) * step);
                    if (q.x < 64.0f || q.z < 64.0f || q.x > w - 64.0f || q.z > h - 64.0f) continue;
                    if (limit >= 0.0f && q.distance2D(anchor) > limit) continue;
                    if (!aiTerrainMgr.CanReserveBuilding(d, q, facing)) continue;
                    const int id = aiTerrainMgr.ReserveBuilding(d, q, facing);
                    if (id < 0) continue;
                    pos[g].insertLast(aiTerrainMgr.GetReservationPos(id));
                    res[g].insertLast(id);
                    return;
                }
        pos[g].insertLast(base);
        res[g].insertLast(-1);
    }

    // Shields just ahead of the block along the true line to the anchor, the heavy
    // porc PorcAhead past them, both spread across it; the flak behind the block.
    void PlaceCover()
    {
        CCircuitDef@ gun = Def(GUN);
        CCircuitDef@ nano = Def(NANO);
        for (int g = SHIELD; g <= FLAK; ++g) { ReleaseAll(res[g]); pos[g].resize(0); res[g].resize(0); }
        if (gun is null) return;
        float hA, hL;
        GridHalf(gun, facing, hA, hL);
        const float blockHalfL = (nano is null) ? 0.0f : float(TurretRowsAll()) * LolCannonMath::Pitch(Layout::Along(nano, facing)) * 0.5f;
        const float front = AiMax(hL, blockHalfL) + 32.0f;
        const AIFloat3 side = Layout::Side(facing), fwd = Layout::Fwd(facing);
        AIFloat3 tFwd = fwd, tSide = side;
        float cosT = 1.0f;
        const float dx = anchor.x - site.x, dz = anchor.z - site.z, len = sqrt(dx * dx + dz * dz);
        if (len > 1.0f) {
            tFwd = AIFloat3(dx / len, 0.0f, dz / len);
            tSide = AIFloat3(-tFwd.z, 0.0f, tFwd.x);
            cosT = AiMax(0.7f, tFwd.x * fwd.x + tFwd.z * fwd.z);
        }
        const float frontT = front / cosT;
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(true);
        CCircuitDef@ shield = Def(SHIELD);
        CCircuitDef@ porc = Def(PORC);
        CCircuitDef@ flak = Def(FLAK);
        float ahead = frontT;
        if (shield !is null) {
            const float half = LolCannonMath::Pitch(Layout::Along(shield, facing)) * 0.5f;
            ahead = frontT + half;
            const int n = AiMax(0, Global::LrpcBlock::Shields);
            for (int k = 0; k < n; ++k)
                PlaceOne(shield, At(site, tSide, LolCannonMath::Offset(k, n, n > 1 ? Global::LrpcBlock::ShieldSpread / float(n - 1) : 0.0f), tFwd, ahead), SHIELD, tSide, tFwd, true);
            ahead += half;
        }
        if (porc !is null) {
            const float half = LolCannonMath::Pitch(Layout::Along(porc, facing)) * 0.5f;
            const float along = ahead + Global::LrpcBlock::PorcAhead + half;
            const int n = AiMax(0, Global::LrpcBlock::HeavyPorc);
            for (int k = 0; k < n; ++k)
                PlaceOne(porc, At(site, tSide, LolCannonMath::Offset(k, n, n > 1 ? Global::LrpcBlock::PorcSpread / float(n - 1) : 0.0f), tFwd, along), PORC, tSide, tFwd, true);
        }
        if (flak !is null) {
            const float half = LolCannonMath::Pitch(Layout::Along(flak, facing)) * 0.5f;
            const int n = AiMax(0, Global::LrpcBlock::Flak);
            for (int k = 0; k < n; ++k)
                PlaceOne(flak, At(site, side, LolCannonMath::Offset(k, n, 160.0f), fwd, -(front + half)), FLAK, side, fwd, false);
        }
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
        for (int g = SHIELD; g <= FLAK; ++g) FillTasks(g);
    }

    // Group g stands, or every short slot failed three orders and nothing of it is on its way.
    bool GroupDone(int g, int &out done)
    {
        int all;
        Count(g, done, all);
        if (done >= int(pos[g].length())) return true;
        CCircuitDef@ d = Def(g);
        if (Flying(g) > 0 || (d !is null && aiBuilderMgr.FindUnfinishedNear(site, Global::LrpcBlock::CountRadius, d) !is null)) return false;
        for (uint k = 0; k < miss[g].length(); ++k) if (miss[g][k] < 3) return false;
        return true;
    }

    // ---------------------------------------------------------------- the program

    void GiveUp(const string &in why)
    {
        for (int g = 0; g < 5; ++g)
            for (uint k = 0; k < tasks[g].length(); ++k)
                if (tasks[g][k] !is null && !tasks[g][k].IsDead()) aiBuilderMgr.AbortTask(tasks[g][k]);
        ClearSlots();
        if (site.x >= 0.0f) failedSites.insertLast(site);
        ReleaseCrew(why);
        phase = IDLE;
        nextPlan = ai.frame + Global::LrpcBlock::RetrySeconds * SECOND;
        GenericHelpers::LogUtil("[LrpcBlock] REPORT given up at=" + (ai.frame / SECOND) + "s: " + why + "; a new site in "
            + Global::LrpcBlock::RetrySeconds + " s", 1);
    }

    string Tally()
    {
        string s = "";
        for (int g = 0; g < 5; ++g) {
            int done, all;
            Count(g, done, all);
            s += (g == 0 ? "" : " ") + (g == GUN ? "lrpc" : (g == NANO ? "nanos" : (g == SHIELD ? "shields" : (g == PORC ? "heavy" : "flak"))))
                + "=" + done + "/" + pos[g].length();
        }
        return s;
    }

    void Advance()
    {
        if (phase == DONE) return;
        if (phase == IDLE) {
            if (ai.frame < nextPlan) return;
            const float m = Economy::GetMinMetalIncomeLast10s(), e = Economy::GetMinEnergyIncomeLast10s();
            if (!Economy::IncomeWindowReady() || m < Global::LrpcBlock::MetalIncomeGate || e < Global::LrpcBlock::MinEnergyIncome) {
                if (ai.frame >= nextGateLog && m >= Global::LrpcBlock::MetalIncomeGate * 0.5f) {
                    nextGateLog = ai.frame + 60 * SECOND;
                    GenericHelpers::LogUtil("[LrpcBlock] waiting for the gate: metal " + int(m) + "/" + int(Global::LrpcBlock::MetalIncomeGate)
                        + ", energy " + int(e) + "/" + int(Global::LrpcBlock::MinEnergyIncome) + " (10 s minima)", 1);
                }
                return;
            }
            if (gateOpenAt < 0) {
                gateOpenAt = ai.frame;
                GenericHelpers::LogUtil("[LrpcBlock] gate open: metal " + int(m) + "/" + int(Global::LrpcBlock::MetalIncomeGate) + " metal/s", 1);
            }
            if (ai.frame < nextAnchor) return;
            nextAnchor = ai.frame + 10 * SECOND;
            if (!FindAnchor()) {
                if (ai.frame >= nextLog) {
                    nextLog = ai.frame + 60 * SECOND;
                    GenericHelpers::LogUtil("[LrpcBlock] no enemy heavy defence known yet (" + ((ai.frame - gateOpenAt) / SECOND) + " s; fallback after "
                        + Global::LrpcBlock::FallbackSeconds + " s)", 1);
                }
                return;
            }
            nextPlan = ai.frame + 30 * SECOND;
            if (!Plan()) return;
            started = ai.frame;
            nextCrew = 0;
            phase = BUILD;
            GenericHelpers::LogUtil("[LrpcBlock] program starts: " + pos[GUN].length() + " " + Def(GUN).GetName() + ", " + pos[NANO].length()
                + " turrets, crew " + int(Global::LrpcBlock::CrewShare * 100.0f) + "% of our T1/T2 constructors", 1);
            ClaimCrew();
            return;
        }
        ClaimCrew();
        if (ai.frame - started >= Global::LrpcBlock::GiveUpSeconds * SECOND) {
            GiveUp(Tally() + " after " + Global::LrpcBlock::GiveUpSeconds + " s");
            return;
        }
        if (phase == BUILD) {
            int done;
            const bool gunsDone = GroupDone(GUN, done);
            if (gunsDone && done == 0) { GiveUp("no cannon could be ordered (" + Tally() + ")"); return; }
            if (gunsDone) {
                int nanos, all;
                Count(NANO, nanos, all);
                GenericHelpers::LogUtil("[LrpcBlock] REPORT cannons lrpc=" + done + "/" + pos[GUN].length() + " nanos=" + nanos + "/" + pos[NANO].length()
                    + " at=" + (ai.frame / SECOND) + "s took=" + ((ai.frame - started) / SECOND) + "s metal=" + int(Economy::GetMinMetalIncomeLast10s()), 1);
                PlaceCover();
                phase = COVER;
                coverStarted = ai.frame;
                GenericHelpers::LogUtil("[LrpcBlock] cover begins: " + pos[SHIELD].length() + " shields, " + pos[PORC].length() + " heavy porc, "
                    + pos[FLAK].length() + " T2 flak towards (" + int(anchor.x) + ", " + int(anchor.z) + "); crew " + crewCount + " kept", 1);
                return;
            }
        } else if (phase == COVER) {
            bool all = true;
            for (int g = SHIELD; g <= FLAK; ++g) { int d; if (!GroupDone(g, d)) all = false; }
            if (all) {
                GenericHelpers::LogUtil("[LrpcBlock] REPORT done " + Tally() + " at=" + (ai.frame / SECOND) + "s took=" + ((ai.frame - started) / SECOND)
                    + "s (cover " + ((ai.frame - coverStarted) / SECOND) + " s)", 1);
                for (int g = 0; g < 5; ++g) ReleaseAll(res[g]);
                ReleaseCrew("the block stands");
                phase = DONE;
                return;
            }
        }
        if (ai.frame >= nextLog) {
            nextLog = ai.frame + 60 * SECOND;
            GenericHelpers::LogUtil("[LrpcBlock] " + (phase == BUILD ? "building" : "cover") + ": " + Tally() + ", crew " + crewCount
                + ", orders in flight " + Flying(GUN) + "+" + Flying(NANO) + "+" + (Flying(SHIELD) + Flying(PORC) + Flying(FLAK)), 1);
        }
    }

    // Economy AiUpdateEconomy: once a second
    void Tick()
    {
        if (!On() || phase == DONE || ai.frame < nextTick) return;
        nextTick = ai.frame + SECOND;
        Advance();
    }
}

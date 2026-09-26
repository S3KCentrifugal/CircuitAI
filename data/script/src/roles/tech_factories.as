// TECH D-114: land factories move toward the front. From +200 metal every new
// land factory (T1 / T2 bot or vehicle lab, T3 gantry) stands in its own front
// factory cluster: the factory plus a block of construction turrets directly
// behind it (T1 2, T2 4, T3 6), turrets built first. A cluster is placed on the
// first spot, at least FrontMinShare of the way from the base toward the front
// and further forward as needed, where the factory and its turret block fit on
// flat, buildable ground with a clear exit lane; away from allied buildings when
// possible, close to them when nothing else fits. Clusters never move back: the
// search starts where the furthest one stands. With FrontReclaimAtCount land
// factories on the map, the land factories at the main base are reclaimed and
// their ground goes back to the economy; with none on the map, the base may
// hold one again.
// Design and evidence: doc/decisions.md D-114; roles/tech_factories.md.
#include "../define.as"
#include "../unit.as"
#include "../task.as"
#include "../global.as"
#include "../helpers/generic_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/unitdef_helpers.as"
#include "../helpers/map_helpers.as"
#include "../helpers/guard_helpers.as"
#include "../manager/builder.as"
#include "../manager/layout.as"
#include "../manager/lifecycle.as"
#include "tech_build.as"

namespace TechFactories {

    float Sq(float v) { return v * v; }

    // ---------------------------------------------------------------- land factories

    array<string> LandFactoryNames()
    {
        array<string> names;
        array<array<string>> lists = { UnitHelpers::GetAllT1BotLabs(), UnitHelpers::GetAllT1VehicleLabs(),
            UnitHelpers::GetAllT2BotLabs(), UnitHelpers::GetAllT2VehicleLabs(), UnitHelpers::GetAllLandGantries() };
        for (uint i = 0; i < lists.length(); ++i)
            for (uint k = 0; k < lists[i].length(); ++k)
                if (lists[i][k].length() > 0) names.insertLast(lists[i][k]);
        return names;
    }
    bool IsLandFactory(const string &in name) { return LandFactoryNames().find(name) >= 0; }
    bool IsLandFactory(const CCircuitDef@ d) { return d !is null && IsLandFactory(d.GetName()); }
    // every land factory of ours on the map, frames included
    int LandFactoryCount() { return UnitDefHelpers::SumUnitDefCounts(LandFactoryNames()); }
    int TierOf(const string &in name)
    {
        if (UnitHelpers::IsLandGantry(name)) return 3;
        if (UnitHelpers::GetAllT2BotLabs().find(name) >= 0 || UnitHelpers::GetAllT2VehicleLabs().find(name) >= 0) return 2;
        return 1;
    }
    void TurretBlock(int tier, int &out cols, int &out rows)
    {
        if (tier >= 3) { cols = Global::RoleSettings::Tech::FrontT3TurretCols; rows = Global::RoleSettings::Tech::FrontT3TurretRows; }
        else if (tier == 2) { cols = Global::RoleSettings::Tech::FrontT2TurretCols; rows = Global::RoleSettings::Tech::FrontT2TurretRows; }
        else { cols = Global::RoleSettings::Tech::FrontT1TurretCols; rows = Global::RoleSettings::Tech::FrontT1TurretRows; }
    }

    // Front placement applies from the economy's +200 (EcoOnline) while a land
    // factory stands anywhere; with none on the map the base may hold one again
    bool Active() { return TechBuild::EcoOnline() && LandFactoryCount() > 0; }

    // ---------------------------------------------------------------- clusters

    class Cluster {
        string defName;
        int tier = 1;
        int labRes = -1;             // the factory's reservation (forgotten by native once built)
        AIFloat3 pos;                // the factory's site
        int facing = 0;
        int nanoGroup = 0;           // its turret block
        array<AIFloat3> turretPos;   // the turret slots ordered so far (script's record: built slots are forgotten)
        int slots = 0;               // the block's size
        float share = 0.0f;          // how far toward the front, 0..1
        int labId = -1;
        int orderedFrame = -100000;
        int standFrame = -1;         // first seen finished (INV-038)
        int invLog = -100000;
        bool labSeen = false;        // its factory (a frame or finished) seen (INV-045)
        int turretFrame = -1;        // the last turret order or frame seen
        int plannedFrame = -1;       // INV-046
        bool built = false;          // its factory stood once: native forgot labRes, a rebuild re-reserves
        IUnitTask@ labTask;          // the factory's order while it lives (builders join it)
        int invOpenLog = -100000;    // INV-046
    }
    array<Cluster@> clusters;
    float reachShare = 0.0f;         // the furthest cluster's share: the search never goes back
    dictionary searchTry;            // def name -> frame of the last failed search
    int searchLog = -100000;

    // D-102 (owner): the advanced lab goes back up before any T1 lab. Once the
    // economy is online a T1 front lab waits for a finished advanced lab (INV-025);
    // with none, rule lab.front plans and builds a T2 front cluster
    // a finished advanced lab that is not retiring (played: a T1 lab ordered while
    // the rezoned base advanced lab was being reclaimed started after it was gone)
    bool AdvancedLabUp()
    {
        const array<string> t2 = UnitHelpers::GetAllT2BotLabs();
        array<string>@ keys = Factory::allFactories.getKeys();
        for (uint i = 0; keys !is null && i < keys.length(); ++i) {
            CCircuitUnit@ f = null;
            if (!Factory::allFactories.get(keys[i], @f) || f is null || f.circuitDef is null) continue;
            if (ai.GetTeamUnit(f.id) is null || t2.find(f.circuitDef.GetName()) < 0) continue;
            if (f.GetBuildProgress() >= 1.0f && !Lifecycle::IsRetiring(f)) return true;
        }
        return false;
    }
    CCircuitDef@ AdvancedLabDef()
    {
        CCircuitDef@ d = ai.GetCircuitDef(UnitHelpers::GetT2BotLabForSide(Global::AISettings::Side));
        return d;   // no IsAvailable: TECH's start caps hide it; Work lifts the cap
    }
    // any advanced lab of ours not retiring, a frame included (played on build96:
    // the base's new advanced lab was a frame, so a second was planned at the front)
    bool AdvancedLabAny()
    {
        const array<string> t2 = UnitHelpers::GetAllT2BotLabs();
        array<string>@ keys = Factory::allFactories.getKeys();
        for (uint i = 0; keys !is null && i < keys.length(); ++i) {
            CCircuitUnit@ f = null;
            if (!Factory::allFactories.get(keys[i], @f) || f is null || f.circuitDef is null) continue;
            if (ai.GetTeamUnit(f.id) is null || t2.find(f.circuitDef.GetName()) < 0) continue;
            if (!Lifecycle::IsRetiring(f)) return true;
        }
        CCircuitDef@ d = AdvancedLabDef();
        return d !is null && aiBuilderMgr.GetUnfinishedCount(d) > 0;
    }
    bool NeedAdvancedLab()
    {
        if (!Active() || AdvancedLabAny() || AdvancedLabDef() is null) return false;
        for (uint i = 0; i < clusters.length(); ++i)
            if (clusters[i].tier == 2 && clusters[i].labRes >= 0 && LabAt(clusters[i]) is null) return false;   // one open already: OpenAbove carries it
        return true;
    }

    CCircuitDef@ Nano() { return ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side)); }

    CCircuitUnit@ LabAt(Cluster@ c)
    {
        if (c.labId >= 0) {
            CCircuitUnit@ u = ai.GetTeamUnit(c.labId);
            if (u !is null) {
                if (u.GetBuildProgress() >= 1.0f) c.built = true;
                return u;
            }
            c.labId = -1;
        }
        CCircuitDef@ d = ai.GetCircuitDef(c.defName);
        if (d is null) return null;
        CCircuitUnit@ f = aiBuilderMgr.FindOwnNear(c.pos, 48.0f, d);
        if (f is null) @f = aiBuilderMgr.FindUnfinishedNear(c.pos, 48.0f, d);
        if (f !is null) c.labId = f.id;
        return f;
    }
    CCircuitUnit@ TurretAt(const AIFloat3& in p)
    {
        CCircuitDef@ nano = Nano();
        if (nano is null) return null;
        CCircuitUnit@ t = aiBuilderMgr.FindOwnNear(p, 32.0f, nano);
        if (t is null) @t = aiBuilderMgr.FindUnfinishedNear(p, 32.0f, nano);
        return t;
    }
    int TurretsOf(Cluster@ c)
    {
        int n = 0;
        for (uint k = 0; k < c.turretPos.length(); ++k) if (TurretAt(c.turretPos[k]) !is null) ++n;
        return n;
    }
    int FinishedTurrets(Cluster@ c)
    {
        CCircuitDef@ nano = Nano();
        if (nano is null) return 0;
        int n = 0;
        for (uint k = 0; k < c.turretPos.length(); ++k) {
            CCircuitUnit@ t = aiBuilderMgr.FindOwnNear(c.turretPos[k], 32.0f, nano);
            if (t !is null) ++n;
        }
        return n;
    }
    bool IsClusterLab(CCircuitUnit@ u)
    {
        if (u is null) return false;
        for (uint i = 0; i < clusters.length(); ++i) {
            CCircuitUnit@ l = LabAt(clusters[i]);
            if (l !is null && l.id == u.id) return true;
        }
        return false;
    }
    int CountTier(int tier)
    {
        int n = 0;
        for (uint i = 0; i < clusters.length(); ++i) if (clusters[i].tier == tier) ++n;
        return n;
    }

    // ---------------------------------------------------------------- the search

    // Is the cluster at p (factory site, its turret block behind it) on flat,
    // buildable ground with its exit clear; `roomy`: also clear of other
    // buildings (ours and allies') by FrontClearCells all round
    bool Fits(CCircuitDef@ lab, CCircuitDef@ nano, const AIFloat3& in p, int facing, int rows, bool roomy)
    {
        const float cell = SQUARE_SIZE * 2;
        const float halfAcross = float(Layout::Across(lab, facing)) * 0.5f * cell;
        const float depth = float(Layout::Along(lab, facing) + rows * Layout::Along(nano, facing));
        const float halfAlong = depth * 0.5f * cell;
        // the cluster's centre: half the turret block behind the factory's centre
        const AIFloat3 centre = p - Layout::Fwd(facing) * (float(rows * Layout::Along(nano, facing)) * 0.5f * cell);
        const float m = 64.0f;
        if (p.x < m || p.z < m || p.x > float(AiTerrainWidth()) - m || p.z > float(AiTerrainHeight()) - m) return false;
        if (aiTerrainMgr.FlatFraction(centre, facing, halfAcross, halfAlong, Global::RoleSettings::Tech::LayoutBoxMaxSlope)
            < Global::RoleSettings::Tech::FrontMinFlat) return false;
        if (roomy) {
            if (aiTerrainMgr.IsZoneAlly(p)) return false;
            const float clear = float(Global::RoleSettings::Tech::FrontClearCells) * cell;
            if (aiTerrainMgr.BuildableFraction(lab, centre, halfAcross + clear, halfAlong + clear, facing) < Global::RoleSettings::Tech::FrontRoomyShare)
                return false;
        }
        return aiTerrainMgr.CanReserveBuilding(lab, p, facing) && aiTerrainMgr.IsExitClear(lab, p, facing, 320.0f, 32.0f);
    }

    // The first spot, at least FrontMinShare of the way toward the front (and no
    // nearer than the furthest cluster), where the cluster fits: along the line
    // from the home centre to the front, FrontShareStep at a time, and across it
    // at each step; roomy spots first (away from other buildings), then any
    Cluster@ Plan(CCircuitDef@ lab)
    {
        CCircuitDef@ nano = Nano();
        if (lab is null || nano is null) return null;
        int64 t;
        if (searchTry.get(lab.GetName(), t) && ai.frame - t < 10 * SECOND) return null;
        const int tier = TierOf(lab.GetName());
        int cols, rows;
        TurretBlock(tier, cols, rows);
        const AIFloat3 home = Layout::HomeCentre();
        const AIFloat3 front = Layout::FrontTarget();
        const float dx = front.x - home.x, dz = front.z - home.z;
        const float dist = sqrt(dx * dx + dz * dz);
        if (dist < 1.0f) return null;
        const float ux = dx / dist, uz = dz / dist;
        const int facing = Layout::LabFacing();
        // one cluster's width (the factory or its turret block, whichever is wider) and a lane
        const int wide = (Layout::Across(lab, facing) > cols * Layout::Across(nano, facing)) ? Layout::Across(lab, facing) : cols * Layout::Across(nano, facing);
        const float pitch = float(wide + Global::RoleSettings::Tech::SpamLabGapCells) * SQUARE_SIZE * 2;
        const float start = (reachShare > Global::RoleSettings::Tech::FrontMinShare) ? reachShare : Global::RoleSettings::Tech::FrontMinShare;
        for (int pass = 0; pass < 2; ++pass) {
            const bool roomy = (pass == 0);
            for (float s = start; s <= Global::RoleSettings::Tech::FrontMaxShare + 0.001f; s += Global::RoleSettings::Tech::FrontShareStep) {
                const float bx = home.x + ux * s * dist, bz = home.z + uz * s * dist;
                for (int k = 0; k <= 2 * Global::RoleSettings::Tech::FrontLateralTries; ++k) {
                    const float off = (k == 0) ? 0.0f : float((k + 1) / 2) * pitch * ((k % 2 == 1) ? 1.0f : -1.0f);
                    const AIFloat3 p(bx - uz * off, home.y, bz + ux * off);
                    if (!Fits(lab, nano, p, facing, rows, roomy)) continue;
                    const int id = aiTerrainMgr.ReserveBuilding(lab, p, facing);
                    if (id < 0) continue;
                    const AIFloat3 lp = aiTerrainMgr.GetReservationPos(id);
                    const int g = aiTerrainMgr.ReserveNanoBlockAt(nano, lab, lp, facing, cols, rows, 0);
                    if (g <= 0 || aiTerrainMgr.GetGroupCount(g, false) < cols * rows) {
                        if (g > 0) aiTerrainMgr.ReleaseGroup(g);
                        aiTerrainMgr.ReleaseReservation(id);
                        continue;
                    }
                    Cluster@ c = Cluster();
                    c.defName = lab.GetName();
                    c.tier = tier;
                    c.labRes = id;
                    c.pos = lp;
                    c.facing = facing;
                    c.nanoGroup = g;
                    c.share = s;
                    c.slots = cols * rows;   // turretPos is filled as each slot's turret is ordered
                    c.plannedFrame = ai.frame;
                    if (tier >= 3) Builder::MarkGantryEnqueued();
                    clusters.insertLast(c);
                    if (s > reachShare) reachShare = s;
                    GenericHelpers::LogUtil("[TECH][Factories] T" + tier + " cluster " + clusters.length() + " for " + lab.GetName() + " at (" + int(lp.x) + ", " + int(lp.z)
                        + "), " + int(s * 100.0f) + "% toward the front, " + (cols * rows) + " turrets behind it" + (roomy ? "" : " (close to other buildings: no roomier spot)") + " (D-114)", 1);
                    return c;
                }
            }
        }
        searchTry.set(lab.GetName(), ai.frame);
        if (ai.frame - searchLog > 60 * SECOND) {
            searchLog = ai.frame;
            GenericHelpers::LogUtil("[TECH][Factories] no spot for a " + lab.GetName() + " cluster between " + int(start * 100.0f) + "% and "
                + int(Global::RoleSettings::Tech::FrontMaxShare * 100.0f) + "% toward the front (D-114)", 1);
        }
        return null;
    }

    // ---------------------------------------------------------------- orders

    int lastOrder = -1;   // INV-039 input (T1 forward work)
    IUnitTask@ OrderPinned(CCircuitUnit@ u, Task::BuildType type, CCircuitDef@ d, int id, const string &in what)
    {
        const AIFloat3 p = aiTerrainMgr.GetReservationPos(id);
        IUnitTask@ t = (type == Task::BuildType::FACTORY)
            ? aiBuilderMgr.Enqueue(TaskB::Factory(Task::Priority::HIGH, d, p, null, 0.0f, false, true, 300 * SECOND))
            : aiBuilderMgr.Enqueue(TaskB::Common(type, Task::Priority::HIGH, d, p, 0.0f, true, 120 * SECOND));
        if (t is null) return null;
        if (!AiPinReservation(t, id)) GenericHelpers::LogUtil("[TECH][Factories] could not pin " + what + " to slot " + id, 1);
        lastOrder = ai.frame;
        GenericHelpers::LogUtil("[TECH][Factories] " + ((u is null) ? "order" : (u.circuitDef.GetName() + " " + u.id + " orders")) + " " + what
            + " at (" + int(p.x) + ", " + int(p.z) + ") (D-114)", 1);
        return t;
    }

    // The cluster a new `def` goes into: one of that def whose factory does not
    // stand yet, else a new one
    Cluster@ OpenCluster(CCircuitDef@ def, bool planNew)
    {
        for (uint i = 0; i < clusters.length(); ++i) {
            Cluster@ c = clusters[i];
            if (c.defName == def.GetName() && LabAt(c) is null && c.labRes >= 0) return c;
        }
        return planNew ? Plan(def) : null;
    }

    // Owner's rule: the turret block first, then the factory. Returns the next
    // piece of work for the cluster of `def` (a turret, the factory, or help on
    // either going up), or null
    IUnitTask@ Work(CCircuitDef@ def, CCircuitUnit@ u, bool planNew = true)
    {
        if (def is null) return null;
        if (TechForward::Recalled(u)) return null;   // its tier is recalled to the eco clusters (D-109)
        CCircuitDef@ nano = Nano();
        if (nano is null) return null;
        Cluster@ c = OpenCluster(def, planNew && MayPlan(def));
        if (c is null) return null;
        const int idx = clusters.findByRef(c) + 1;
        // 1. the turrets
        const int sid = aiTerrainMgr.NextSlotAny(c.nanoGroup, c.pos);
        if (sid >= 0 && (u is null || u.circuitDef.CanBuild(nano))) {
            const AIFloat3 sp = aiTerrainMgr.GetReservationPos(sid);
            bool known = false;
            for (uint q = 0; q < c.turretPos.length(); ++q) if (MapHelpers::SqDist(c.turretPos[q], sp) < 16.0f) known = true;
            if (!known) c.turretPos.insertLast(sp);
            c.turretFrame = ai.frame;
            return OrderPinned(u, Task::BuildType::NANO, nano, sid, "a turret for front cluster " + idx + " (" + c.defName + ")");
        }
        CCircuitUnit@ tf = aiBuilderMgr.FindUnfinishedNear(c.pos, 200.0f, nano);
        if (tf !is null) { c.turretFrame = ai.frame; return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, tf, 30 * SECOND)); }
        // 2. the factory, once its whole turret block stands finished (played: the
        // factory was ordered with the turrets, "its 0 turrets stand"); while a
        // turret is ordered but not started, the cluster waits (INV-045)
        const int done = FinishedTurrets(c);
        if (done < c.slots) {
            // a slot the engine refused (a dead slot) never fills: with no turret
            // work for 240 s, the factory goes up behind the turrets that stand
            if (done == 0 || c.turretFrame < 0 || ai.frame - c.turretFrame < 240 * SECOND) return null;
            if (ai.frame - c.orderedFrame >= 120 * SECOND)
                GenericHelpers::LogUtil("[TECH][Factories] front cluster " + idx + ": " + (c.slots - done) + " turret slot(s) will not fill; the factory goes up behind "
                    + done + " (D-114)", 1);
        }
        if (u !is null && !u.circuitDef.CanBuild(def)) return null;
        // the factory's order still lives: a builder joins it (at most two), never
        // a second order (played: the re-order after 120 s could not pin the slot
        // the first order still held)
        if (c.labTask !is null && !c.labTask.IsDead()
            && ai.frame - c.orderedFrame >= Global::RoleSettings::Tech::FrontClusterStallSeconds * SECOND)
        {
            // the order never became a frame (played on build96: builders cycled
            // round an advanced lab site for 12 minutes): the cluster is given up,
            // its factory ground released; the next order plans another
            aiBuilderMgr.AbortTask(c.labTask);
            @c.labTask = null;
            if (c.labRes >= 0) aiTerrainMgr.ReleaseReservation(c.labRes);
            c.labRes = -1;
            GenericHelpers::LogUtil("[TECH][Factories] front cluster " + idx + " (" + c.defName + "): its factory order made no frame in "
                + Global::RoleSettings::Tech::FrontClusterStallSeconds + " s; given up (D-114)", 1);
            return null;
        }
        if (c.labTask !is null) {
            if (!c.labTask.IsDead()) {
                if (c.labTask.GetUnits().length() < 2) return c.labTask;
                return null;
            }
            @c.labTask = null;
        }
        if (c.tier == 1 && TechBuild::EcoOnline() && !AdvancedLabUp()) return null;   // D-102: the advanced lab first
        if (c.built) {
            // the factory stood and was lost: native forgot its reservation (played:
            // a lab ordered at (-1, 0)); the footprint is reserved again, or the
            // cluster is given up
            const int id = aiTerrainMgr.ReserveBuilding(def, c.pos, c.facing);
            if (id < 0) {
                c.labRes = -1;
                GenericHelpers::LogUtil("[TECH][Factories] front cluster " + idx + " (" + c.defName + ") lost its factory and the ground is taken: given up (D-114)", 1);
                return null;
            }
            c.labRes = id;
            c.built = false;
            c.plannedFrame = ai.frame;
            c.labSeen = false;
        }
        // TECH's start caps: lifted for the spam labs (fwd.t1 counts them) and the
        // advanced lab; never for a gantry (MayPlan kept its cap)
        if (c.tier <= 2 && def.maxThisUnit <= def.count) def.maxThisUnit = def.count + 1;
        IUnitTask@ t = OrderPinned(u, Task::BuildType::FACTORY, def, c.labRes, c.defName + " for front cluster " + idx + " (its " + done + " of " + c.slots + " turrets stand)");
        if (t !is null) { c.orderedFrame = ai.frame; @c.labTask = t; }
        return t;
    }

    // Rule lab.front: the open T2 and T3 clusters (planned, their factory not up)
    // are carried to the end by any constructor that reaches the row (played: the
    // only caller was row lab.t2, far down the table; with the metal floating the
    // T2 constructors never reached it and the block stood half-built for minutes).
    // The T1 clusters are fwd.t1's.
    bool OpenAbove(int tier)
    {
        if (tier <= 2 && NeedAdvancedLab()) return true;
        for (uint i = 0; i < clusters.length(); ++i)
            if (clusters[i].tier >= tier && clusters[i].labRes >= 0 && LabAt(clusters[i]) is null) return true;
        return false;
    }
    // A standing factory's lost turret is rebuilt (played: INV-038, a cluster 56%
    // toward the front lost both turrets and nothing rebuilt them while its lab
    // stood). `minTier`/`maxTier` pick the clusters.
    bool RefillWanted(int minTier, int maxTier)
    {
        for (uint i = 0; i < clusters.length(); ++i) {
            Cluster@ c = clusters[i];
            if (c.tier < minTier || c.tier > maxTier || LabAt(c) is null) continue;
            if (aiTerrainMgr.NextSlotAny(c.nanoGroup, c.pos) >= 0) return true;
        }
        return false;
    }
    IUnitTask@ Refill(CCircuitUnit@ u, int minTier, int maxTier)
    {
        if (TechForward::Recalled(u)) return null;   // D-109: its tier is recalled
        CCircuitDef@ nano = Nano();
        if (nano is null || (u !is null && !u.circuitDef.CanBuild(nano))) return null;
        for (uint i = 0; i < clusters.length(); ++i) {
            Cluster@ c = clusters[i];
            if (c.tier < minTier || c.tier > maxTier || LabAt(c) is null) continue;
            const int sid = aiTerrainMgr.NextSlotAny(c.nanoGroup, c.pos);
            if (sid < 0) continue;
            return OrderPinned(u, Task::BuildType::NANO, nano, sid, "a lost turret of front cluster " + (i + 1) + " (" + c.defName + ")");
        }
        return null;
    }
    IUnitTask@ OpenWork(CCircuitUnit@ u)
    {
        IUnitTask@ r = Refill(u, 1, 3);
        if (r !is null) return r;
        if (NeedAdvancedLab()) {
            IUnitTask@ a = Work(AdvancedLabDef(), u, true);   // plans the T2 cluster
            if (a !is null) return a;
        }
        for (uint i = 0; i < clusters.length(); ++i) {
            Cluster@ c = clusters[i];
            if (c.tier < 2 || c.labRes < 0 || LabAt(c) !is null) continue;
            IUnitTask@ t = Work(ai.GetCircuitDef(c.defName), u, false);
            if (t !is null) return t;
        }
        return null;
    }

    // A NEW cluster only when the path it replaces would have ordered the factory
    // (played on build95: four gantry clusters in 20 minutes; the routing had
    // bypassed EnqueueLandGantry's cap and cooldown and Work lifted the cap). The
    // T1 labs: fwd.t1 counts them by income. An advanced lab: available, or none
    // standing after the rezoning. A gantry: available and off the gantry cooldown,
    // which planning it starts.
    bool MayPlan(CCircuitDef@ def)
    {
        const int tier = TierOf(def.GetName());
        if (tier <= 1) return true;
        if (tier == 2) return def.IsAvailable(ai.frame) || NeedAdvancedLab();
        return def.IsAvailable(ai.frame) && Builder::IsGantryOffCooldown();
    }

    // D-114: every land factory order of TECH passes here first. `routed` is true
    // when front placement applies (the caller then returns the result, null
    // included: never the base's placement)
    IUnitTask@ Route(const string &in defName, CCircuitUnit@ u, bool &out routed)
    {
        routed = false;
        if (!IsLandFactory(defName) || !Active()) return null;
        routed = true;
        return Work(ai.GetCircuitDef(defName), u);
    }

    // The two turrets (or the block) behind a front factory always work for it
    IUnitTask@ TurretFocus(CCircuitUnit@ u)
    {
        if (u is null || clusters.length() == 0) return null;
        const AIFloat3 p = u.GetPos(ai.frame);
        for (uint i = 0; i < clusters.length(); ++i) {
            Cluster@ c = clusters[i];
            bool mine = false;
            for (uint k = 0; k < c.turretPos.length(); ++k) {
                if (MapHelpers::SqDist(c.turretPos[k], p) <= Sq(32.0f)) { mine = true; break; }
            }
            if (!mine) continue;
            CCircuitUnit@ l = LabAt(c);
            if (l is null) return null;   // the factory is not up yet: the table's other turret rows
            if (l.GetBuildProgress() < 1.0f) return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, l, 30 * SECOND));
            return GuardHelpers::AssignWorkerGuard(u, l, Task::Priority::HIGH, true, 60 * SECOND);
        }
        return null;
    }

    // ---------------------------------------------------------------- the base's land factories

    // Owner's rule: with FrontReclaimAtCount land factories on the map, the land
    // factories in reach of the main turret cluster are reclaimed and never
    // rebuilt there; their ground becomes economic ground
    bool baseGroundReleased = false;
    CCircuitUnit@ BaseLandFactory()
    {
        if (LandFactoryCount() < Global::RoleSettings::Tech::FrontReclaimAtCount) return null;
        const AIFloat3 base = Layout::BaseCentre();
        const float r2 = Sq(Global::RoleSettings::Tech::FrontBaseRadius);
        array<string>@ keys = Factory::allFactories.getKeys();
        CCircuitUnit@ best = null;
        float bestSq = 1.0e30f;
        for (uint i = 0; keys !is null && i < keys.length(); ++i) {
            CCircuitUnit@ f = null;
            if (!Factory::allFactories.get(keys[i], @f) || f is null || f.circuitDef is null) continue;
            if (ai.GetTeamUnit(f.id) is null || !IsLandFactory(f.circuitDef) || IsClusterLab(f)) continue;
            const float sq = MapHelpers::SqDist(f.GetPos(ai.frame), base);
            if (sq <= r2 && sq < bestSq) { bestSq = sq; @best = f; }
        }
        return best;
    }
    dictionary baseRetired;          // factory id -> frame: retired by the rezoning, not for metal (INV-026)
    IUnitTask@ ReclaimBaseFactory(CCircuitUnit@ u)
    {
        CCircuitUnit@ f = BaseLandFactory();
        if (f is null || f is u) return null;
        if (!Lifecycle::IsRetiring(f)) {
            baseRetired.set("" + f.id, ai.frame);
            Lifecycle::Retire(f, LandFactoryCount() + " land factories on the map: the base's land factories go back to the economy (D-114)");
            ReleaseBaseFactoryGround();
        }
        if (MapHelpers::SqDist(u.GetPos(ai.frame), f.GetPos(ai.frame)) > Sq(Global::RoleSettings::Tech::ExpAssistRadius)) return null;
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, f, 180 * SECOND));
        if (t !is null) TechBuild::PullTurrets(f);
        return t;
    }
    // the base's planned factory footprints (the pair's slots, the advanced lab's)
    // go back to the pool: economic ground from now on
    void ReleaseBaseFactoryGround()
    {
        if (baseGroundReleased) return;
        baseGroundReleased = true;
        array<int> ids = { aiTerrainMgr.GetLayoutInt(Layout::FACTORY_ROOT + ".t1_slot", -1), aiTerrainMgr.GetLayoutInt(Layout::FACTORY_ROOT + ".t2_slot", -1), Layout::labSlot };
        int n = 0;
        for (uint i = 0; i < ids.length(); ++i) {
            if (ids[i] < 0) continue;
            aiTerrainMgr.ReleaseReservation(ids[i]);
            ++n;
        }
        Layout::labSlot = -1;
        GenericHelpers::LogUtil("[TECH][Factories] the base's factory ground (" + n + " footprint(s)) is economic ground now (D-114)", 1);
    }
}

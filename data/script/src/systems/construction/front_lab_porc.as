// FRONT forward T2 lab porc and corridors (owner, 2026-10-30; Front::LabCorridor, Front::LabPorc).
//
// Corridor: every T2 bot lab and vehicle plant of ours, from the moment it is framed, reserves a
// corridor from itself to the nearest enemy start: the lab's exit cone (ReserveExitCone), then the
// terrain route of the largest unit it makes (aiBattle.GetUnitTerrainRoute, dry, no threat) cut into
// short native corridor zones (ReserveZone(..., true)) LabCorridorWidthFactor x that unit's movement
// footprint wide. A corridor zone is never laid, so no structure of ours or of an allied BARb is
// placed on it (native placement and IsAllyLayoutBlocked); metal and geo spots are holes in every
// zone, so T1 and T2 mexes still go up there. Cells already built on, or touching an ally's
// reservation, are left out (a tile touching one is refused whole): it is an attempt, not a promise.
// FRONT runs no layout, so the gate is opened for the reservation and closed again (as LolCannon).
// The corridor stops LabCorridorStopShort before the enemy start. It is released when the lab dies.
//
// Porc: a lab standing more than LabPorcMinDistance from our start gets its own cluster, built by
// FRONT T2 constructors: LabPorcTier in order (default the two pop-ups, the heavy plasma, then one T2 flak;
// Pit Bull / Scorpion / Chimera, Rattlesnake / Persecutor / Eviscerator, armflak / corflak / legflak: the edge porc names).
// The pop-ups stand LabPorcPopupForward along the corridor toward the enemy, one each side of it
// LabPorcPopupSide beyond its edge; the heavy LabPorcHeavyForward along, beside the corridor, and the flak
// there on the corridor's other side (owner, 2026-10-30: "add one t2 flak ... with the same restrictions"). The
// corridor and the exit cone are reserved first, so native placement keeps the guns off the
// exits and off the path. Guns of those kinds within LabPorcRadius count for the nearest far lab,
// finished or not, so a lost gun is rebuilt. One order per lab, joined by at most one more
// constructor; an order that dies with no gun widens the search, three in a row hold the lab 90 s.
//
// Cost: one owned-unit scan every LabPorcScanSeconds, or when our T2 lab count changes; one route
// and up to ~(route length / width) zone reservations per lab, once. Work reads the cache.
// Log [FRONT][LabCorridor], [FRONT][LabPorc].
namespace FrontLabPorc {
    const int HoldSeconds = 90;
    const int OrderTimeoutSeconds = 240;

    class Lab {
        int id = -1;
        string defName;
        AIFloat3 pos;
        AIFloat3 target(-1.0f, 0.0f, -1.0f);   // the enemy start the corridor leads to
        float width = 64.0f;
        array<AIFloat3> route;                 // lab to the corridor's end
        array<int> zones;                      // corridor tiles and the exit cone
        bool planned = false;
        bool far = false;
        array<int> standing = { 0, 0, 0, 0 };  // tier 0 unused, 1 mid, 2 heavy, 3 flak
        array<CCircuitUnit@> frames(4);
        IUnitTask@ order;
        int orderTier = -1;
        int orderBefore = 0;
        bool orderRepair = false;
        int fails = 0;
        int shift = 0;
        int holdUntil = -1;
        int lastStep = -1;
    }
    array<Lab@> labs;
    array<CCircuitDef@> labDefs;
    int lastScan = -100000;
    int lastLabCount = -1;
    bool defsDone = false;

    bool CorridorOn() { return Global::RoleSettings::Front::LabCorridor && Global::AISettings::Role == AiRole::FRONT; }
    bool PorcOn() { return Global::RoleSettings::Front::LabPorc && Global::AISettings::Role == AiRole::FRONT; }

    void Reset() {
        for (uint i = 0; i < labs.length(); ++i) Release(labs[i]);
        labs.resize(0); labDefs.resize(0);
        lastScan = -100000; lastLabCount = -1; defsDone = false;
    }

    void Defs() {
        if (defsDone) return;
        defsDone = true;
        array<string> names = UnitHelpers::GetAllT2BotLabs();
        array<string> veh = UnitHelpers::GetAllT2VehicleLabs();
        for (uint i = 0; i < veh.length(); ++i) names.insertLast(veh[i]);
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ d = ai.GetCircuitDef(names[i]);
            if (d !is null) labDefs.insertLast(d);
        }
    }

    int LabCount() {
        int n = 0;
        for (uint i = 0; i < labDefs.length(); ++i) n += labDefs[i].count;
        return n;
    }

    CCircuitDef@ GunDef(int tier) {
        string n = "";
        if (tier == 1) Global::Spam::EdgePorcMid.get(Global::AISettings::Side, n);
        else if (tier == 2) Global::Spam::EdgePorcHeavy.get(Global::AISettings::Side, n);
        else if (tier == 3) Global::Spam::EdgePorcFlak.get(Global::AISettings::Side, n);
        return (n == "") ? null : ai.GetCircuitDef(n);
    }

    // The largest unit a lab makes and its movement footprint (squares), from settings
    bool Biggest(const string &in lab, string &out unit, int &out squares) {
        const array<string>@ labsList = Global::RoleSettings::Front::LabCorridorLabs;
        for (uint i = 0; i < labsList.length(); ++i) {
            if (labsList[i] != lab) continue;
            unit = Global::RoleSettings::Front::LabCorridorUnits[i];
            squares = Global::RoleSettings::Front::LabCorridorSquares[i];
            return true;
        }
        return false;
    }

    void Release(Lab@ l) {
        for (uint z = 0; z < l.zones.length(); ++z) aiTerrainMgr.ReleaseZone(l.zones[z]);
        if (l.zones.length() > 0)
            GenericHelpers::LogUtil("[FRONT][LabCorridor] " + l.defName + " " + l.id + " gone: " + l.zones.length() + " corridor zones released", 1);
        l.zones.resize(0);
    }

    AIFloat3 NearestEnemyStart(const AIFloat3 &in p) {
        array<AIFloat3> starts = Lanes::EnemyStarts();
        AIFloat3 best(-1.0f, 0.0f, -1.0f);
        float bestSq = 1e30f;
        for (uint i = 0; i < starts.length(); ++i) {
            const float sq = MapHelpers::SqDist(p, starts[i]);
            if (sq < bestSq) { bestSq = sq; best = starts[i]; }
        }
        return best;
    }

    // The point `along` elmos down the route, and the route's direction there
    AIFloat3 Along(Lab@ l, float along, float &out ux, float &out uz) {
        ux = 0.0f; uz = 0.0f;
        if (l.route.length() < 2) {
            const float dx = l.target.x - l.pos.x, dz = l.target.z - l.pos.z;
            const float d = sqrt(dx * dx + dz * dz);
            if (d > 1.0f) { ux = dx / d; uz = dz / d; }
            return AIFloat3(l.pos.x + ux * along, 0.0f, l.pos.z + uz * along);
        }
        float left = along;
        for (uint i = 1; i < l.route.length(); ++i) {
            const AIFloat3 a = l.route[i - 1], b = l.route[i];
            const float dx = b.x - a.x, dz = b.z - a.z;
            const float d = sqrt(dx * dx + dz * dz);
            if (d < 1.0f) continue;
            ux = dx / d; uz = dz / d;
            if (left <= d) return AIFloat3(a.x + ux * left, 0.0f, a.z + uz * left);
            left -= d;
        }
        return l.route[l.route.length() - 1];
    }

    // The lab's exit cone and its corridor to the nearest enemy start, once
    void Plan(Lab@ l, CCircuitUnit@ lab) {
        l.planned = true;
        l.far = PorcOn() && sqrt(MapHelpers::SqDist(l.pos, Global::Map::StartPos)) > Global::RoleSettings::Front::LabPorcMinDistance;
        l.target = NearestEnemyStart(l.pos);
        string unit = ""; int squares = 4;
        if (!Biggest(l.defName, unit, squares)) unit = "";
        l.width = float(squares) * SQUARE_SIZE * Global::RoleSettings::Front::LabCorridorWidthFactor;
        CCircuitDef@ walker = (unit == "") ? null : ai.GetCircuitDef(unit);
        if (l.target.x >= 0.0f && walker !is null) {
            array<AIFloat3>@ r = aiBattle.GetUnitTerrainRoute(walker, l.pos, l.target, true, 1.0f, 6.0f, 0.0f, 0.0f);
            if (r !is null) l.route = r;
        }
        if (!CorridorOn()) return;
        if (l.target.x < 0.0f || l.route.length() < 2) {
            GenericHelpers::LogUtil("[FRONT][LabCorridor] " + l.defName + " " + l.id + ": no route to an enemy start ("
                + (walker is null ? "no unit " + unit : "route of " + l.route.length() + " points") + "); no corridor", 1);
            return;
        }
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) {
            GenericHelpers::LogUtil("[FRONT][LabCorridor] the profile's layout gate is closed; no corridor", 1);
            return;
        }
        const int exitZone = aiTerrainMgr.ReserveExitCone(lab, Global::RoleSettings::Front::LabCorridorExitLength, 16.0f);
        if (exitZone > 0) l.zones.insertLast(exitZone);
        // Tiles of `step` along the route, each holding the corridor's full width there: in route
        // coordinates a tile must cover |along| <= step/2 and |across| <= width/2, so its world
        // half-sizes are step/2 |u| + width/2 |n| per axis (exact on straight axis runs).
        float length = 0.0f;
        for (uint i = 1; i < l.route.length(); ++i) length += sqrt(MapHelpers::SqDist(l.route[i - 1], l.route[i]));
        const float stop = length - Global::RoleSettings::Front::LabCorridorStopShort;
        const float step = l.width;
        int tiles = 0, held = 0;
        for (float s = 0.0f; s <= stop; s += step) {
            float ux, uz;
            const AIFloat3 c = Along(l, s + step * 0.5f, ux, uz);
            const float ax = abs(ux), az = abs(uz);
            const float hx = step * 0.5f * ax + l.width * 0.5f * az + SQUARE_SIZE;
            const float hz = step * 0.5f * az + l.width * 0.5f * ax + SQUARE_SIZE;
            ++tiles;
            const int z = aiTerrainMgr.ReserveZone(c, 0, hx, hz, true);
            if (z > 0) { l.zones.insertLast(z); ++held; }
        }
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
        GenericHelpers::LogUtil("[FRONT][LabCorridor] " + l.defName + " " + l.id + " at (" + int(l.pos.x) + "," + int(l.pos.z)
            + "): corridor " + int(l.width) + " wide (" + unit + ", " + squares + " squares) to the enemy start at ("
            + int(l.target.x) + "," + int(l.target.z) + "), " + int(length) + " long, " + held + " of " + tiles + " tiles held"
            + (exitZone > 0 ? ", exit cone held" : ", no exit cone") + (l.far ? "; forward lab, porc cluster due" : ""), 1);
    }

    Lab@ Find(int id) {
        for (uint i = 0; i < labs.length(); ++i) if (labs[i].id == id) return labs[i];
        return null;
    }

    void Scan() {
        lastScan = ai.frame;
        lastLabCount = LabCount();
        array<Lab@> seen;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        CCircuitDef@ mid = GunDef(1);
        CCircuitDef@ heavy = GunDef(2);
        CCircuitDef@ flak = GunDef(3);
        array<CCircuitUnit@> guns;
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u is null || u.circuitDef is null) continue;
            if (u.circuitDef is mid || u.circuitDef is heavy || u.circuitDef is flak) { guns.insertLast(u); continue; }
            bool isLab = false;
            for (uint d = 0; d < labDefs.length() && !isLab; ++d) isLab = u.circuitDef is labDefs[d];
            if (!isLab) continue;
            Lab@ l = Find(u.id);
            if (l is null) {
                @l = Lab();
                l.id = u.id;
                l.defName = u.circuitDef.GetName();
                l.pos = u.GetPos(ai.frame);
                Plan(l, u);
            }
            seen.insertLast(l);
        }
        for (uint i = 0; i < labs.length(); ++i) if (seen.findByRef(labs[i]) < 0) Release(labs[i]);
        labs = seen;
        // each gun counts for the nearest far lab within LabPorcRadius
        const float r = Global::RoleSettings::Front::LabPorcRadius;
        for (uint i = 0; i < labs.length(); ++i)
            for (int t = 0; t < 4; ++t) { labs[i].standing[t] = 0; @labs[i].frames[t] = null; }
        for (uint g = 0; g < guns.length(); ++g) {
            const AIFloat3 p = guns[g].GetPos(ai.frame);
            Lab@ best = null;
            float bestSq = r * r;
            for (uint i = 0; i < labs.length(); ++i) {
                if (!labs[i].far) continue;
                const float sq = MapHelpers::SqDist(p, labs[i].pos);
                if (sq <= bestSq) { bestSq = sq; @best = labs[i]; }
            }
            if (best is null) continue;
            const int t = (guns[g].circuitDef is heavy) ? 2 : (guns[g].circuitDef is flak) ? 3 : 1;
            best.standing[t] += 1;
            if (guns[g].GetBuildProgress() < 1.0f) @best.frames[t] = guns[g];
        }
        // a lab's order that died: did it leave a gun?
        for (uint i = 0; i < labs.length(); ++i) {
            Lab@ l = labs[i];
            if (l.order is null || !l.order.IsDead()) continue;
            if (l.standing[l.orderTier] > l.orderBefore || (l.orderRepair && l.standing[l.orderTier] >= l.orderBefore)) { l.fails = 0; l.shift = 0; }
            else {
                l.shift += 1;
                l.fails += 1;
                if (l.fails >= 3) {
                    l.holdUntil = ai.frame + HoldSeconds * SECOND;
                    l.fails = 0;
                    GenericHelpers::LogUtil("[FRONT][LabPorc] " + l.defName + " " + l.id + ": three orders died with no gun; waiting " + HoldSeconds + " s", 1);
                }
            }
            @l.order = null;
        }
    }

    void Refresh() {
        if (!CorridorOn() && !PorcOn()) return;
        Defs();
        if (ai.frame - lastScan >= Global::RoleSettings::Front::LabPorcScanSeconds * SECOND || LabCount() != lastLabCount) Scan();
    }

    bool IsOurs(IUnitTask@ t) {
        if (t is null || t.IsDead()) return false;
        for (uint i = 0; i < labs.length(); ++i) if (labs[i].order is t) return true;
        return false;
    }

    // Slot of the k-th gun of a tier at a far lab: pop-ups either side of the corridor ahead of the
    // lab, the heavy beside the corridor nearer the lab, the flak across the corridor from the heavy
    AIFloat3 Slot(Lab@ l, int tier, int k) {
        float ux, uz;
        const bool back = tier >= 2;
        const float along = back ? Global::RoleSettings::Front::LabPorcHeavyForward : Global::RoleSettings::Front::LabPorcPopupForward;
        if (tier == 3) ++k;   // the side the heavy does not take
        const AIFloat3 c = Along(l, along, ux, uz);
        const float nx = -uz, nz = ux;
        const float side = ((k % 2) == 0 ? 1.0f : -1.0f)
            * (l.width * 0.5f + (back ? Global::RoleSettings::Front::LabPorcHeavySide : Global::RoleSettings::Front::LabPorcPopupSide));
        return AIFloat3(c.x + nx * side, 0.0f, c.z + nz * side);
    }

    // Front_BuilderAiMakeTask: FRONT T2 constructors build the far labs' clusters
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (u is null || u.circuitDef is null) return null;
        Refresh();
        if (!PorcOn() || FrontRecovery::Active()) return null;
        if (IsOurs(u.task)) return u.task;
        if (UnitHelpers::IsCommander(u.circuitDef) || UnitHelpers::GetConstructorTier(u.circuitDef) != 2) return null;
        const bool free = FrontFactoryNanos::Free(u);
        if (!free && !FrontFactoryNanos::Takeable(u)) return null;
        const float reach = free ? Global::RoleSettings::Front::LabPorcReach : Global::RoleSettings::Front::LabPorcTakeRadius;
        const AIFloat3 wp = u.GetPos(ai.frame);
        const float mi = Economy::GetMinMetalIncomeLast10s();
        const array<int>@ tiers = Global::RoleSettings::Front::LabPorcTier;
        for (uint i = 0; i < labs.length(); ++i) {
            Lab@ l = labs[i];
            if (!l.far || MapHelpers::SqDist(wp, l.pos) > reach * reach) continue;
            // an open order: join it (two constructors at most)
            if (l.order !is null && !l.order.IsDead()) {
                array<CCircuitUnit@>@ on = l.order.GetUnits();
                IBuilderTask@ b = cast<IBuilderTask>(l.order);
                if ((on is null || on.length() < 2) && (b is null || b.buildDef is null || u.circuitDef.CanBuild(b.buildDef))) return l.order;
                continue;
            }
            if (ai.frame < l.holdUntil) continue;
            CCircuitUnit@ labUnit = ai.GetTeamUnit(l.id);
            if (labUnit is null || labUnit.GetBuildProgress() < 1.0f) continue;   // the guns follow a standing lab
            // the first step of the ladder not yet met
            array<int> need = { 0, 0, 0, 0 };
            int step = -1, tier = -1;
            for (uint s = 0; s < tiers.length(); ++s) {
                const int t = tiers[s];
                if (t < 1 || t > 3) continue;
                need[t] += 1;
                if (l.standing[t] < need[t]) { step = int(s); tier = t; break; }
            }
            if (tier < 0) continue;
            const float minIncome = (tier == 2) ? Global::RoleSettings::Front::LabPorcHeavyMetalIncome
                : (tier == 3) ? Global::RoleSettings::Front::LabPorcFlakMetalIncome : Global::RoleSettings::Front::LabPorcPopupMetalIncome;
            if (mi < minIncome) continue;
            CCircuitDef@ d = GunDef(tier);
            if (d is null || !u.circuitDef.CanBuild(d)) continue;
            if (!aiTerrainMgr.CanReachAt(u, l.pos, u.circuitDef.GetBuildDistance())) continue;
            if (step != l.lastStep) {
                l.lastStep = step;
                GenericHelpers::LogUtil("[FRONT][LabPorc] " + l.defName + " " + l.id + " step " + (step + 1) + " of " + tiers.length() + ": "
                    + d.GetName() + " (stand: mid " + l.standing[1] + ", heavy " + l.standing[2] + ", flak " + l.standing[3] + "; M +" + int(mi) + ", "
                    + int(sqrt(MapHelpers::SqDist(l.pos, Global::Map::StartPos))) + " from our start)", 1);
            }
            if (l.frames[tier] !is null && ai.GetTeamUnit(l.frames[tier].id) !is null) {
                @l.order = aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH, l.frames[tier], 120 * SECOND));
                l.orderRepair = true;
            } else {
                if (d.maxThisUnit >= 0 && d.maxThisUnit <= d.count) d.maxThisUnit = d.count + 1;
                if (!d.IsAvailable(ai.frame)) continue;
                const int k = l.standing[tier] + l.shift;
                const AIFloat3 p = Slot(l, tier, k);
                const float shake = Global::RoleSettings::Front::LabPorcShake + 80.0f * float(AiMin(l.shift, 4));
                @l.order = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::HIGH, d, p, shake, true,
                    OrderTimeoutSeconds * SECOND));
                l.orderRepair = false;
                if (l.order !is null)
                    GenericHelpers::LogUtil("[FRONT][LabPorc] " + u.circuitDef.GetName() + " " + u.id + " orders " + d.GetName()
                        + " " + (l.standing[tier] + 1) + " at " + l.defName + " " + l.id + " (" + int(p.x) + "," + int(p.z) + ")", 1);
            }
            if (l.order is null) { l.holdUntil = ai.frame + 15 * SECOND; continue; }
            l.orderTier = tier;
            l.orderBefore = l.standing[tier];
            return l.order;
        }
        return null;
    }
}

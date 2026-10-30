// FRONT forward T2 lab porc and corridors (owner, 2026-10-30; Front::LabCorridor, Front::LabPorc).
//
// Corridor: every T2 bot lab and vehicle plant of ours, from the moment it is framed, reserves a
// corridor from itself to the nearest enemy start: the lab's exit cone (ReserveExitCone), then the
// coarse terrain route of its movement class (aiBattle.GetTerrainRoute: bots or vehicles, no threat)
// cut into native corridor zones (ReserveZone(..., true)) LabCorridorWidthFactor x the movement
// footprint of the largest unit it makes wide, a few per frame (ReserveTiles). A corridor zone is never laid, so no structure of ours or of an allied BARb is
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
// Cost: one owned-unit scan every LabPorcScanSeconds, or when our T2 lab count changes; one coarse
// route per lab, once; its zone reservations at most LabCorridorTilesPerFrame a frame. No engine
// message or unit command comes from a corridor. Work reads the cache.
// Log [FRONT][LabCorridor], [FRONT][LabPorc].
namespace FrontLabPorc {
    const int HoldSeconds = 90;
    const int OrderTimeoutSeconds = 240;
    const int FailHoldSeconds = 10;

    class Lab {
        int id = -1;
        string defName;
        AIFloat3 pos;
        AIFloat3 target(-1.0f, 0.0f, -1.0f);   // the enemy start the corridor leads to
        float width = 64.0f;
        string unit;                           // the largest unit it makes
        int squares = 4;                       // ... and its movement footprint
        array<AIFloat3> route;                 // lab to the corridor's end
        float length = 0.0f;
        float tileAt = -1.0f;                  // ReserveTiles' cursor along the route; -1 when done or none
        float tileStop = 0.0f;
        int tilesTried = 0, tilesHeld = 0, exitHeld = 0;
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

    // The largest unit a lab makes, its movement footprint (squares) and lane class, from settings
    bool Biggest(const string &in lab, string &out unit, int &out squares, int &out cls) {
        const array<string>@ labsList = Global::RoleSettings::Front::LabCorridorLabs;
        for (uint i = 0; i < labsList.length(); ++i) {
            if (labsList[i] != lab) continue;
            unit = Global::RoleSettings::Front::LabCorridorUnits[i];
            squares = Global::RoleSettings::Front::LabCorridorSquares[i];
            cls = Global::RoleSettings::Front::LabCorridorClass[i];
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

    // The lab's exit cone now, and its corridor route to the nearest enemy start; the corridor's
    // tiles are reserved a few per frame by ReserveTiles.
    // Performance (owner, 2026-10-30: "all 8 AI get to t2 usually"; the first build froze every
    // client ~1 s per corridor on Proving Grounds): the route is the coarse lane-class route
    // (aiBattle.GetTerrainRoute on the AI's shared terrain grid, the one Spam and the raids use), not
    // GetUnitTerrainRoute, whose first call per unit def built a whole-map fine terrain for that def.
    // Reservations stay inside this AI: ShareZone writes the ally team's in-process rectangle index
    // (no engine message, no network, no unit command); allies only read it when they place a
    // building, and a queued ally build whose cached site is now covered re-searches once.
    void Plan(Lab@ l, CCircuitUnit@ lab) {
        l.planned = true;
        l.far = PorcOn() && sqrt(MapHelpers::SqDist(l.pos, Global::Map::StartPos)) > Global::RoleSettings::Front::LabPorcMinDistance;
        l.target = NearestEnemyStart(l.pos);
        int cls = Lanes::BOT;
        if (!Biggest(l.defName, l.unit, l.squares, cls)) { l.unit = ""; l.squares = 4; }
        l.width = float(l.squares) * SQUARE_SIZE * Global::RoleSettings::Front::LabCorridorWidthFactor;
        if (l.target.x >= 0.0f) {
            array<AIFloat3>@ r = aiBattle.GetTerrainRoute(l.pos, l.target, cls, 1.0f, 6.0f, 0.0f, 0.0f);
            if (r !is null) l.route = r;
            // played 2026-10-30: from a few lab centres the route search finds nothing; start it a
            // little out from the lab toward the target, on each side, and put the lab in front
            const float dx = l.target.x - l.pos.x, dz = l.target.z - l.pos.z;
            const float d = sqrt(dx * dx + dz * dz);
            for (int k = 0; k < 4 && l.route.length() < 2 && d > 1.0f; ++k) {
                const float a = float(k) * 1.5708f;   // ahead, left, back, right
                const float ux = dx / d, uz = dz / d;
                const float ox = ux * cos(a) - uz * sin(a), oz = ux * sin(a) + uz * cos(a);
                const AIFloat3 from(l.pos.x + ox * 160.0f, l.pos.y, l.pos.z + oz * 160.0f);
                @r = aiBattle.GetTerrainRoute(from, l.target, cls, 1.0f, 6.0f, 0.0f, 0.0f);
                if (r !is null && r.length() >= 2) { l.route = r; l.route.insertAt(0, l.pos); }
            }
        }
        if (!CorridorOn()) return;
        if (l.target.x < 0.0f || l.route.length() < 2) {
            GenericHelpers::LogUtil("[FRONT][LabCorridor] " + l.defName + " " + l.id + ": no route to an enemy start; no corridor", 1);
            return;
        }
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) {
            GenericHelpers::LogUtil("[FRONT][LabCorridor] the profile's layout gate is closed; no corridor", 1);
            return;
        }
        l.exitHeld = aiTerrainMgr.ReserveExitCone(lab, Global::RoleSettings::Front::LabCorridorExitLength, 16.0f);
        if (l.exitHeld > 0) l.zones.insertLast(l.exitHeld);
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
        l.length = 0.0f;
        for (uint i = 1; i < l.route.length(); ++i) l.length += sqrt(MapHelpers::SqDist(l.route[i - 1], l.route[i]));
        l.tileStop = l.length - Global::RoleSettings::Front::LabCorridorStopShort;
        l.tileAt = 0.0f;
    }

    // At most LabCorridorTilesPerFrame corridor tiles per frame over all labs, so a lab's ~50-100
    // reservations spread over a few seconds instead of one frame. A tile is the bounding box of
    // route samples `width` apart, grown while the samples stay within half a width of one axis
    // (one rectangle for a straight axis run, up to LabCorridorMaxRun), then widened by half the
    // corridor's width on every side: any route point is at least width/2 from the tile's edge.
    // Mex and geo spots inside are holes (see the header). O(tiles x route points) per lab, once.
    int tileFrame = -1;
    void ReserveTiles() {
        if (!CorridorOn() || tileFrame == ai.frame) return;
        tileFrame = ai.frame;
        int budget = Global::RoleSettings::Front::LabCorridorTilesPerFrame;
        bool layoutOn = true, opened = false;
        for (uint i = 0; i < labs.length() && budget > 0; ++i) {
            Lab@ l = labs[i];
            if (l.route.length() < 2 || l.tileAt < 0.0f) continue;
            if (!opened) {
                opened = true;
                layoutOn = aiTerrainMgr.IsLayoutEnabled();
                if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) return;
            }
            const float step = l.width, pad = l.width * 0.5f + SQUARE_SIZE;
            while (budget > 0 && l.tileAt >= 0.0f) {
                if (l.tileAt >= l.tileStop) { Done(l); break; }
                float ux, uz;
                AIFloat3 p = Along(l, l.tileAt, ux, uz);
                float x1 = p.x, x2 = p.x, z1 = p.z, z2 = p.z;
                float s = l.tileAt;
                while (s < l.tileStop) {
                    const float next = AiMin(s + step, l.tileStop);
                    p = Along(l, next, ux, uz);
                    const float nx1 = AiMin(x1, p.x), nx2 = AiMax(x2, p.x), nz1 = AiMin(z1, p.z), nz2 = AiMax(z2, p.z);
                    const bool first = (s == l.tileAt);
                    if (!first && (AiMin(nx2 - nx1, nz2 - nz1) > l.width * 0.5f
                        || AiMax(nx2 - nx1, nz2 - nz1) > Global::RoleSettings::Front::LabCorridorMaxRun)) break;
                    x1 = nx1; x2 = nx2; z1 = nz1; z2 = nz2;
                    s = next;
                    if (first && AiMin(x2 - x1, z2 - z1) > l.width * 0.5f) break;   // a diagonal step: one tile
                }
                const AIFloat3 c((x1 + x2) * 0.5f, 0.0f, (z1 + z2) * 0.5f);
                const int z = aiTerrainMgr.ReserveZone(c, 0, (x2 - x1) * 0.5f + pad, (z2 - z1) * 0.5f + pad, true);
                ++l.tilesTried; --budget;
                if (z > 0) { l.zones.insertLast(z); ++l.tilesHeld; }
                l.tileAt = (s > l.tileAt) ? s : l.tileStop + 1.0f;
            }
        }
        if (opened && !layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
    }

    void Done(Lab@ l) {
        l.tileAt = -1.0f;
        GenericHelpers::LogUtil("[FRONT][LabCorridor] " + l.defName + " " + l.id + " at (" + int(l.pos.x) + "," + int(l.pos.z)
            + "): corridor " + int(l.width) + " wide (" + l.unit + ", " + l.squares + " squares) to the enemy start at ("
            + int(l.target.x) + "," + int(l.target.z) + "), " + int(l.length) + " long, " + l.tilesHeld + " of " + l.tilesTried + " tiles held"
            + (l.exitHeld > 0 ? ", exit cone held" : ", no exit cone") + (l.far ? "; forward lab, porc cluster due" : ""), 1);
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
        // an order that died without TaskRemoved (none expected): forget it; the counts above decide
        for (uint i = 0; i < labs.length(); ++i)
            if (labs[i].order !is null && labs[i].order.IsDead()) @labs[i].order = null;
    }

    void Refresh() {
        if (!CorridorOn() && !PorcOn()) return;
        Defs();
        if (ai.frame - lastScan >= Global::RoleSettings::Front::LabPorcScanSeconds * SECOND || LabCount() != lastLabCount) Scan();
        ReserveTiles();
    }

    // Front_BuilderAiTaskRemoved: our order's end settles the lab at once. Played 2026-10-30
    // (live, an armavp): with the bookkeeping only in the 5 s scan, an order that died at once was
    // re-placed by the next ask 9 times in 20 s. A finished gun counts at once; an order that dies
    // with no gun waits FailHoldSeconds x the failures in a row, three of them HoldSeconds.
    void TaskRemoved(IUnitTask@ task, bool done) {
        if (task is null) return;
        for (uint i = 0; i < labs.length(); ++i) {
            Lab@ l = labs[i];
            if (l.order !is task) continue;
            @l.order = null;
            if (done) {
                if (l.orderTier >= 1 && l.orderTier <= 3 && !l.orderRepair) l.standing[l.orderTier] += 1;
                l.fails = 0; l.shift = 0;
                return;
            }
            l.shift += 1;
            l.fails += 1;
            if (l.fails >= 3) {
                l.holdUntil = ai.frame + HoldSeconds * SECOND;
                l.fails = 0;
                GenericHelpers::LogUtil("[FRONT][LabPorc] " + l.defName + " " + l.id + ": three orders died with no gun; waiting " + HoldSeconds + " s", 1);
            } else {
                l.holdUntil = ai.frame + FailHoldSeconds * l.fails * SECOND;
            }
            return;
        }
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

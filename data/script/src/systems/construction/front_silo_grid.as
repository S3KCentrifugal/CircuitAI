// FRONT nuclear silos in one tight grid (owner, 2026-10-30; Front::SiloGrid).
//
// When: from NukeMinSeconds of game time, once the 10 s minimum metal and energy income have
// stayed at or above NukeMetalIncome / NukeEnergyIncome for NukeSustainSeconds without a break,
// FRONT asks the shared silo gate (EconomyHelpers::ShouldRushNuke, the same helper TECH asks)
// for one more silo, up to NukeLimit, one at a time (none while one of ours is queued).
//
// Where: the first silo reserves the whole grid at once: SiloGridColumns across x enough rows
// for NukeLimit, side by side with no gap (ReservePersistentBuilding per slot, LayoutHelpers::
// CheckGrid confirms the pitch survived snapping), inside one envelope zone SiloGridMargin wider
// on every side, so nothing of ours or an ally's is packed against it and units walk round it.
// The site is the nearest to our start that (a) the native layout accepts (CanReserveArea, so
// TECH's and AIR's layouts, lab corridors and exit cones are respected), (b) keeps the envelope
// at least SiloGridLaneClear from every allied start's straight line to its nearest enemy start
// (the paths the back AIs' units take to the front go round the block, not into it; played
// before this: FRONT's large structures cut that flow), and (c) the asking constructor can reach.
// The grid faces the nearest enemy start, long side across the line of advance.
// FRONT runs no layout, so the gate is opened for the reservation and closed again (as LolCannon,
// FrontLabPorc); every order is pinned to its slot, so the engine's site search (which wants a
// yard round each silo) never spreads the grid.
//
// Cost: the site search runs once (then at most once per SiloGridRetrySeconds after a failure),
// SiloGridSearchRings rings of 16 probes; each later ask reads NukeLimit reservation states.
// Log [FRONT][SiloGrid].
namespace FrontSiloGrid {
    int sustainedSince = -1;     // first frame of the current unbroken run above both incomes
    int nextSearch = 0;
    int searchFails = 0;         // a failed site search backs off: retry x 2^fails, at most SiloGridRetryMaxSeconds
    int nextOrder = 0;           // one order at a time: Builder's queued count lags the frame the order is made
    int nextLog = -100000;
    bool capsRaised = false;
    array<int> slots;            // grid reservations, row by row
    int zone = -1;
    AIFloat3 centre(-1.0f, 0.0f, -1.0f);
    string gridDef = "";        // the def the grid was reserved for; builders of another faction leave it alone

    CCircuitDef@ SiloDef(CCircuitUnit@ u)
    {
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        const string name = side == "cortex" ? "corsilo" : (side == "legion" ? "legsilo" : "armsilo");
        return ai.GetCircuitDef(name);
    }

    void Held(const string &in why)
    {
        if (ai.frame - nextLog < 60 * SECOND) return;
        nextLog = ai.frame;
        GenericHelpers::LogUtil("[FRONT][SiloGrid] held: " + why, 1);
    }

    // Unbroken run above both incomes, in frames; 0 when below now.
    int Sustained()
    {
        const bool ok = Economy::GetMinMetalIncomeLast10s() >= Global::RoleSettings::Front::NukeMetalIncome
            && Economy::GetMinEnergyIncomeLast10s() >= Global::RoleSettings::Front::NukeEnergyIncome;
        if (!ok) { sustainedSince = -1; return 0; }
        if (sustainedSince < 0) sustainedSince = ai.frame;
        return ai.frame - sustainedSince;
    }

    // Squared distance from p to the segment a-b, on the ground plane.
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
            const float d = MapHelpers::SqDist(pts[i], from);
            if (d < bestD) { bestD = d; best = pts[i]; }
        }
        return best;
    }

    int FacingToward(const AIFloat3 &in from, const AIFloat3 &in to)
    {
        const float dx = to.x - from.x, dz = to.z - from.z;
        if (abs(dx) > abs(dz)) return dx > 0.0f ? 1 : 3;
        return dz > 0.0f ? 0 : 2;
    }

    void Release()
    {
        for (uint i = 0; i < slots.length(); ++i) aiTerrainMgr.ReleasePersistentBuilding(slots[i]);
        slots.resize(0);
        if (zone > 0) aiTerrainMgr.ReleaseZone(zone);
        zone = -1;
    }

    // The slot centres of a cols x rows grid round c facing f, pitch one silo (w across, dep along).
    array<AIFloat3>@ SlotsAt(const AIFloat3 &in c, int f, int cols, int rows, int limit, float w, float dep)
    {
        array<AIFloat3> r;
        const AIFloat3 origin = LayoutHelpers::Offset(c, f, -w * float(cols - 1) * 0.5f, -dep * float(rows - 1) * 0.5f);
        for (int s = 0; s < limit; ++s) r.insertLast(LayoutHelpers::Offset(origin, f, float(s % cols) * w, float(s / cols) * dep));
        return r;
    }

    // The whole grid at one site, or nothing. True when reserved.
    // Candidates: SiloGridSearchRings rings of SiloGridSearchSpokes round our start, the grid facing the enemy and
    // turned a quarter. Each must be on the map, reachable, accepted by the layouts (CanReserveArea)
    // and buildable at every slot (CanReserveBuilding: slope, water, structures). Those clear of
    // every allied lane by SiloGridLaneClear go first, nearest home first; when none is (a FRONT's
    // base is crossed by the lanes of the allies behind it; played: 8 lanes left no site), the one
    // farthest from any lane that still keeps the grid itself off every lane line. At most
    // SiloGridMaxTries reservations are attempted.
    bool Reserve(CCircuitUnit@ u, CCircuitDef@ d)
    {
        const int limit = Global::RoleSettings::Front::NukeLimit;
        const int cols = AiMax(1, AiMin(Global::RoleSettings::Front::SiloGridColumns, limit));
        const int rows = (limit + cols - 1) / cols;
        array<AIFloat3> allies = Lanes::AllyStarts(), enemies = Lanes::EnemyStarts();
        const AIFloat3 home = Global::Map::StartPos;
        const AIFloat3 enemy = NearestOf(enemies, home);
        const int f0 = enemy.x < 0.0f ? 0 : FacingToward(home, enemy);
        const float margin = Global::RoleSettings::Front::SiloGridMargin;
        // every allied start's line to its nearest enemy start
        array<AIFloat3> laneA, laneB;
        for (uint i = 0; i < allies.length(); ++i) {
            const AIFloat3 e = NearestOf(enemies, allies[i]);
            if (e.x >= 0.0f) { laneA.insertLast(allies[i]); laneB.insertLast(e); }
        }
        const bool layoutOn = aiTerrainMgr.IsLayoutEnabled();
        if (!layoutOn && !aiTerrainMgr.SetLayoutEnabled(true)) {
            GenericHelpers::LogUtil("[FRONT][SiloGrid] the profile's layout gate is closed; no grid", 1);
            return false;
        }
        // candidates: centre, facing, lane distance, squared home distance, lane-clear
        array<AIFloat3> candC; array<int> candF; array<float> candLane, candHome; array<bool> candClear;
        int offMap = 0, onLane = 0, refused = 0, unbuildable = 0, unreachable = 0;
        const float step = Global::RoleSettings::Front::SiloGridSearchStep;
        for (int turn = 0; turn < 2; ++turn) {
            const int f = (f0 + turn) % 4;
            // footprints count 16-elmo cells (GetFootprintX = xsize / 2): the pitch is one silo, side by side
            const float w = float(Layout::Across(d, f)) * SQUARE_SIZE * 2.0f, dep = float(Layout::Along(d, f)) * SQUARE_SIZE * 2.0f;
            const float halfAcross = w * float(cols) * 0.5f + margin, halfAlong = dep * float(rows) * 0.5f + margin;
            const float own = sqrt(halfAcross * halfAcross + halfAlong * halfAlong);
            const float clear = Global::RoleSettings::Front::SiloGridLaneClear + own;
            for (int ring = 1; ring <= Global::RoleSettings::Front::SiloGridSearchRings; ++ring) {
                const int spokes = Global::RoleSettings::Front::SiloGridSearchSpokes;
                for (int k = 0; k < spokes; ++k) {
                    const float ang = 6.2831853f * (float(k) + 0.5f * float(ring % 2)) / float(spokes);
                    const AIFloat3 c(home.x + cos(ang) * step * float(ring), 0.0f, home.z + sin(ang) * step * float(ring));
                    if (c.x < own || c.z < own || c.x >= AiTerrainWidth() - own || c.z >= AiTerrainHeight() - own) { ++offMap; continue; }
                    float laneD = 1e9f;
                    for (uint l = 0; l < laneA.length(); ++l) laneD = AiMin(laneD, sqrt(SqDistSegment(c, laneA[l], laneB[l])));
                    if (laneD < own) { ++onLane; continue; }   // the grid itself would stand on a lane line
                    if (!aiTerrainMgr.CanReachAt(u, c, u.circuitDef.GetBuildDistance() + halfAcross)) { ++unreachable; continue; }
                    if (!aiTerrainMgr.CanReserveArea(c, f, halfAcross, halfAlong)) { ++refused; continue; }
                    array<AIFloat3>@ at = SlotsAt(c, f, cols, rows, limit, w, dep);
                    bool ok = true;
                    for (uint s = 0; s < at.length() && ok; ++s) ok = aiTerrainMgr.CanReserveBuilding(d, at[s], f);
                    if (!ok) { ++unbuildable; continue; }
                    candC.insertLast(c); candF.insertLast(f); candLane.insertLast(laneD);
                    candHome.insertLast(MapHelpers::SqDist(c, home)); candClear.insertLast(laneD >= clear);
                }
            }
        }
        // order: lane-clear ones nearest home first, then the rest farthest from a lane first
        array<int> order;
        for (uint i = 0; i < candC.length(); ++i) {
            uint at = 0;
            while (at < order.length()) {
                const int j = order[at];
                const bool before = (candClear[i] != candClear[j]) ? candClear[i]
                    : (candClear[i] ? candHome[i] < candHome[j] : candLane[i] > candLane[j]);
                if (before) break;
                ++at;
            }
            order.insertAt(at, int(i));
        }
        bool found = false;
        int tried = 0;
        for (uint o = 0; o < order.length() && !found && tried < Global::RoleSettings::Front::SiloGridMaxTries; ++o) {
            const int i = order[o];
            ++tried;
            const int f = candF[i];
            const float w = float(Layout::Across(d, f)) * SQUARE_SIZE * 2.0f, dep = float(Layout::Along(d, f)) * SQUARE_SIZE * 2.0f;
            const float halfAcross = w * float(cols) * 0.5f + margin, halfAlong = dep * float(rows) * 0.5f + margin;
            array<AIFloat3>@ at = SlotsAt(candC[i], f, cols, rows, limit, w, dep);
            for (uint s = 0; s < at.length(); ++s) {
                const int id = aiTerrainMgr.ReservePersistentBuilding(d, at[s], f);
                if (id < 0) break;
                slots.insertLast(id);
            }
            if (int(slots.length()) == limit && LayoutHelpers::CheckGrid(slots, 0, cols, f, w, dep)) {
                zone = aiTerrainMgr.ReserveZone(candC[i], f, halfAcross, halfAlong, false);
                found = zone > 0;
            }
            if (!found) { Release(); continue; }
            centre = candC[i];
            GenericHelpers::LogUtil("[FRONT][SiloGrid] reserved " + cols + "x" + rows + " " + d.GetName() + " grid at ("
                + int(centre.x) + ", " + int(centre.z) + ") facing " + f + ", " + int(sqrt(candHome[i]))
                + " from home, " + int(candLane[i]) + " from the nearest allied lane"
                + (candClear[i] ? "" : " (no lane-clear site: the farthest)") + ", zone " + zone + "; "
                + candC.length() + " candidates (skipped " + offMap + " off map, " + onLane + " on lanes, "
                + unreachable + " unreachable, " + refused + " refused by layouts, " + unbuildable + " unbuildable), "
                + tried + " tried", 1);
        }
        if (!layoutOn) aiTerrainMgr.SetLayoutEnabled(false);
        if (!found)
            GenericHelpers::LogUtil("[FRONT][SiloGrid] no grid site: " + candC.length() + " candidates (skipped " + offMap
                + " off map, " + onLane + " on lanes, " + unreachable + " unreachable, " + refused + " refused by layouts, "
                + unbuildable + " unbuildable), " + tried + " tried; retry in " + Global::RoleSettings::Front::SiloGridRetrySeconds + " s", 1);
        return found;
    }

    IUnitTask@ Work(CCircuitUnit@ u)
    {
        if (!Global::RoleSettings::Front::SiloGrid || u is null || u.circuitDef is null) return null;
        if (ai.frame < Global::RoleSettings::Front::NukeMinSeconds * SECOND) return null;
        // the grid's own def once reserved (played: a gifted builder of another faction ordered its own
        // silo onto a legsilo slot, "another def", and the order was aborted every ask)
        CCircuitDef@ d = gridDef.length() > 0 ? ai.GetCircuitDef(gridDef) : SiloDef(u);
        if (d is null || !u.circuitDef.CanBuild(d)) return null;
        const int sustained = Sustained();
        if (sustained < Global::RoleSettings::Front::NukeSustainSeconds * SECOND) return null;
        const int total = EconomyHelpers::GetNukeSiloCount(), queued = Builder::NukeSiloQueuedCount;
        if (queued > 0 || ai.frame < nextOrder) return null;   // one at a time
        if (!EconomyHelpers::ShouldRushNuke(Economy::GetMinMetalIncomeLast10s(), Economy::GetMinEnergyIncomeLast10s(),
                queued, total, Global::RoleSettings::Front::NukeLimit,
                Global::RoleSettings::Front::NukeMetalIncome, Global::RoleSettings::Front::NukeEnergyIncome)) return null;
        if (!capsRaised) {
            UnitHelpers::BatchApplyUnitCaps(UnitHelpers::GetAllNukeSilos(), Global::RoleSettings::Front::NukeLimit);
            capsRaised = true;
        }
        if (!d.IsAvailable(ai.frame)) { Held(d.GetName() + " not available"); return null; }
        if (slots.length() == 0) {
            if (ai.frame < nextSearch) return null;
            if (!Reserve(u, d)) {
                nextSearch = ai.frame + AiMin(Global::RoleSettings::Front::SiloGridRetryMaxSeconds,
                    Global::RoleSettings::Front::SiloGridRetrySeconds * (1 << AiMin(searchFails, 4))) * SECOND;
                ++searchFails;
                return null;
            }
            searchFails = 0;
            gridDef = d.GetName();
        }
        for (uint s = 0; s < slots.length(); ++s) {
            if (aiTerrainMgr.GetReservationState(slots[s]) != 0) continue;
            const AIFloat3 at = aiTerrainMgr.GetReservationPos(slots[s]);
            if (!aiTerrainMgr.CanReachAt(u, at, u.circuitDef.GetBuildDistance())) continue;
            IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::BIG_GUN, Task::Priority::HIGH, d, at, 0.0f, true, 300 * SECOND));
            if (t is null) return null;
            if (!AiPinReservation(t, slots[s])) {
                aiBuilderMgr.AbortTask(t);
                Held("could not pin " + d.GetName() + " to grid slot " + s);
                return null;
            }
            nextOrder = ai.frame + 10 * SECOND;
            GenericHelpers::LogUtil("[FRONT][SiloGrid] silo " + (total + 1) + " of " + Global::RoleSettings::Front::NukeLimit
                + " on grid slot " + s + " at (" + int(at.x) + ", " + int(at.z) + "); income sustained "
                + (sustained / SECOND) + " s", 1);
            return t;
        }
        Held("no free grid slot the constructor can reach (" + slots.length() + " slots)");
        return null;
    }
}

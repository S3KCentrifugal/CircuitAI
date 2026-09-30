#include "../helpers/production_math.as"
#include "../helpers/layout_helpers.as"
#include "lifecycle.as"

// AIR sites use native reservation/claim/frame ownership. No TECH controller calls.
namespace AirLayout {
    class Bay {
        string key;
        string defName;
        int slot = -1;
        int factoryId = -1;
        int facing = 0;
        AIFloat3 centre;
        array<int> nanos;
    }
    array<Bay@> bays;
    class WindCluster {
        string defName;
        AIFloat3 centre;
        int facing = 0;
        array<int> slots;
    }
    array<WindCluster@> windClusters;
    bool enabled = false;
    int searchAfter = 0;
    int facing = 0;
    bool overlay = false;
    int overlayFrame = -1;
    dictionary placeRetry;

    void SetOverlay(bool on) { overlay = on; overlayFrame = -1; Draw(); }
    void Draw()
    {
        if (!enabled || !overlay || (overlayFrame >= 0 && ai.frame - overlayFrame < 4 * SECOND)) return;
        overlayFrame = ai.frame;
        const string all = "complex:" + facing + ":0:0:" + facing + ":0:0:c;" + aiTerrainMgr.DescribeLayout();
        const uint parts = (all.length() + 2999) / 3000;
        for (uint i = 0; i < parts; ++i) WidgetLink::Send("layout", "" + (i + 1) + "|" + parts + "|" + all.substr(i * 3000, 3000));
    }

    bool Inside(const AIFloat3 &in p, float margin)
    {
        return ProductionMath::Inside(p.x, p.z, float(AiTerrainWidth()), float(AiTerrainHeight()), margin);
    }

    AIFloat3 Offset(const AIFloat3 &in p, int f, float across, float along)
    {
        return LayoutHelpers::Offset(p, f, across, along);
    }
    string Key(int i) { return "air.bay." + i; }
    void Save(Bay@ b)
    {
        aiTerrainMgr.SetLayoutInt(b.key + ".slot", b.slot);
        aiTerrainMgr.SetLayoutInt(b.key + ".facing", b.facing);
        aiTerrainMgr.SetLayoutInt(b.key + ".tier", UnitHelpers::IsT2AircraftPlant(b.defName) ? 2 : 1);
        aiTerrainMgr.SetLayoutInt(b.key + ".x", int(b.centre.x));
        aiTerrainMgr.SetLayoutInt(b.key + ".z", int(b.centre.z));
        aiTerrainMgr.SetLayoutInt(b.key + ".n", int(b.nanos.length()));
        for (uint i = 0; i < b.nanos.length(); ++i) aiTerrainMgr.SetLayoutInt(b.key + ".nano." + i, b.nanos[i]);
        aiTerrainMgr.SetLayoutInt("air.bays", int(bays.length()));
    }
    void Init(const string &in side)
    {
        enabled = Global::RoleSettings::Air::ExperimentalBuild && aiTerrainMgr.SetLayoutEnabled(true);
        if (!enabled) return;
        AirEconomy::Reset(); AirProduction::Reset();
        aiBuilderMgr.experimentalBuild = true;
        aiBuilderMgr.experimentalAirDirect = true;
        aiEconomyMgr.assistNanoEnabled = false; // one owner: native queued nanos cannot obstruct AIR slots
        bays.resize(0);
        windClusters.resize(0);
        placeRetry.deleteAll();
        facing = LayoutHelpers::FacingToward(Global::Map::StartPos, LayoutHelpers::TerrainCentre());
        const int count = aiTerrainMgr.GetLayoutInt("air.bays", 0);
        for (int i = 0; i < count; ++i) {
            Bay b;
            b.key = Key(i);
            b.slot = aiTerrainMgr.GetLayoutInt(b.key + ".slot", -1);
            b.facing = aiTerrainMgr.GetLayoutInt(b.key + ".facing", facing);
            b.defName = aiTerrainMgr.GetLayoutInt(b.key + ".tier", 1) == 2 ? UnitHelpers::GetT2AirPlantForSide(side) : UnitHelpers::GetT1AirPlantForSide(side);
            b.centre = AIFloat3(float(aiTerrainMgr.GetLayoutInt(b.key + ".x", 0)), 0.0f, float(aiTerrainMgr.GetLayoutInt(b.key + ".z", 0)));
            const int n = aiTerrainMgr.GetLayoutInt(b.key + ".n", 0);
            for (int j = 0; j < n; ++j) b.nanos.insertLast(aiTerrainMgr.GetLayoutInt(b.key + ".nano." + j, -1));
            bays.insertLast(b);
        }
        const int winds = aiTerrainMgr.GetLayoutInt("air.winds", 0);
        for (int i = 0; i < winds; ++i) {
            const string key = "air.wind." + i;
            WindCluster c;
            const int faction = aiTerrainMgr.GetLayoutInt(key + ".side", 0);
            c.defName = UnitHelpers::GetWindNameForSide(faction == 1 ? "cortex" : faction == 2 ? "legion" : "armada");
            c.facing = aiTerrainMgr.GetLayoutInt(key + ".facing", facing);
            c.centre = AIFloat3(float(aiTerrainMgr.GetLayoutInt(key + ".x", 0)), 0.0f, float(aiTerrainMgr.GetLayoutInt(key + ".z", 0)));
            for (int s = 0; s < 6; ++s) c.slots.insertLast(aiTerrainMgr.GetLayoutInt(key + ".slot." + s, -1));
            windClusters.insertLast(c);
        }
        GenericHelpers::LogUtil("[AIR][Layout] enabled; adopted " + bays.length() + " bays, " + windClusters.length() + " wind clusters", 1);
    }
    // A compound plan is synchronous: publish only after every reservation succeeds.
    Bay@ Reserve(CCircuitDef@ plant, const AIFloat3 &in anchor, bool complete = false)
    {
        if (!enabled || plant is null || ai.frame < searchAfter) return null;
        CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if (nano is null) return null;
        const bool t2 = UnitHelpers::IsT2AircraftPlant(plant.GetName());
        const int wanted = t2 ? 20 : AiMin(5, Global::RoleSettings::Air::T1NanoLimit);
        const float nw = float(nano.GetFootprintX()) * SQUARE_SIZE * 2.0f;
        const float half = float(plant.GetFootprintX()) * SQUARE_SIZE; // local across; Offset applies facing
        for (int ring = 0; ring < 17; ++ring) {
            const int points = ring == 0 ? 1 : 16;
            for (int k = 0; k < points; ++k) {
                const float angle = 6.2831853f * float(k) / float(points);
                AIFloat3 at(anchor.x + cos(angle) * float(ring) * 128.0f, 0.0f, anchor.z + sin(angle) * float(ring) * 128.0f);
                bool near = false;
                for (uint j = 0; j < bays.length(); ++j)
                    if (MapHelpers::SqDist(at, bays[j].centre) < Global::RoleSettings::Air::BaySpacing * Global::RoleSettings::Air::BaySpacing) near = true;
                if (near || !Inside(at, 240.0f) || aiTerrainMgr.IsZoneAlly(at) || !aiTerrainMgr.CanReserveBuilding(plant, at, facing)) continue;
                const int id = aiTerrainMgr.ReservePersistentBuilding(plant, at, facing);
                if (id < 0) continue;
                at = aiTerrainMgr.GetReservationPos(id);
                array<int> slots;
                for (int s = 0; s < wanted; ++s) {
                    // T1 grows a rear row; T2 has independent side banks.
                    const float x = t2 ? ProductionMath::BayAcross(s, half, nw, 32.0f) : float(s - 2) * nw;
                    const float z = t2 ? ProductionMath::BayAlong(s, nw) : -half - nw;
                    const AIFloat3 p = Offset(at, facing, x, z);
                    if (MapHelpers::SqDist(p, at) > nano.GetBuildDistance() * nano.GetBuildDistance()) break;
                    const int ns = aiTerrainMgr.ReservePersistentBuilding(nano, p, facing);
                    if (ns < 0) break;
                    slots.insertLast(ns);
                }
                // A cramped site can start with a partial bank. The capacity
                // calculation uses the slots actually published, never phantom BP.
                if (int(slots.length()) < (complete ? wanted : AiMin(2, wanted))) {
                    for (uint s = 0; s < slots.length(); ++s) aiTerrainMgr.ReleasePersistentBuilding(slots[s]);
                    aiTerrainMgr.ReleasePersistentBuilding(id);
                    continue;
                }
                Bay b;
                b.key = Key(int(bays.length())); b.defName = plant.GetName(); b.slot = id;
                b.centre = at; b.facing = facing; b.nanos = slots;
                bays.insertLast(b); Save(b);
                GenericHelpers::LogUtil("[AIR][Layout] reserved " + b.key + " " + b.defName + " at " + int(at.x) + "," + int(at.z) + " support=" + slots.length(), 1);
                return b;
            }
        }
        searchAfter = ai.frame + 10 * SECOND;
        return null;
    }
    int aheadFrame = -100000;
    void PlanAhead()
    {
        if (!enabled || bays.length() == 0 || ai.frame - aheadFrame < SECOND) return;
        aheadFrame = ai.frame;
        const string side = Global::AISettings::Side;
        const array<string> names = {UnitHelpers::GetT2AirPlantForSide(side), UnitHelpers::GetT1AirPlantForSide(side)};
        const array<int> wants = {AiMin(Global::RoleSettings::Air::PlannedT2Bays, Global::RoleSettings::Air::MaxProductionBays), Global::RoleSettings::Air::PlannedT1Bays};
        for (uint t = 0; t < names.length(); ++t) {
            int have = 0;
            for (uint i = 0; i < bays.length(); ++i) if (bays[i].defName == names[t]) ++have;
            if (have >= wants[t]) continue;
            Bay@ b = Reserve(ai.GetCircuitDef(names[t]), Global::Map::StartPos, true);
            if (b !is null && t == 0 && b.nanos.length() != 20)
                Invariants::Violation("INV-084", b.key, "speculative T2 air bay lacks twenty turret slots");
            return; // one compound search per second
        }
    }
    void AdoptSupport(Bay@ bay)
    {
        CCircuitDef@ plant = ai.GetCircuitDef(bay.defName);
        CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if (plant is null || nano is null) return;
        const bool t2 = UnitHelpers::IsT2AircraftPlant(bay.defName);
        const float nw = float(nano.GetFootprintX()) * SQUARE_SIZE * 2.0f;
        const float half = float(plant.GetFootprintX()) * SQUARE_SIZE;
        for (int s = 0; s < (t2 ? 20 : 5); ++s) {
            const float x = t2 ? ProductionMath::BayAcross(s, half, nw, 32.0f) : float(s - 2) * nw;
            const float z = t2 ? ProductionMath::BayAlong(s, nw) : -half - nw;
            const AIFloat3 p = Offset(bay.centre, bay.facing, x, z);
            if (!Inside(p, nw) || MapHelpers::SqDist(p, bay.centre) > nano.GetBuildDistance() * nano.GetBuildDistance()) continue;
            const int slot = aiTerrainMgr.ReservePersistentBuilding(nano, p, bay.facing);
            if (slot >= 0) bay.nanos.insertLast(slot);
        }
        Save(bay);
    }
    // Required pins already have the complete native claim/retry/serialization contract.
    IUnitTask@ Pinned(Task::BuildType type, Task::Priority priority, CCircuitDef@ d, int slot)
    {
        if (slot < 0 || d is null || aiTerrainMgr.GetReservationState(slot) != 0) return null;
        const AIFloat3 pos = aiTerrainMgr.GetReservationPos(slot);
        IUnitTask@ t = type == Task::BuildType::FACTORY
            ? aiBuilderMgr.Enqueue(TaskB::Factory(priority, d, pos, null, 0.0f, false, true, 300 * SECOND))
            : aiBuilderMgr.Enqueue(TaskB::Common(type, priority, d, pos, 0.0f, true, 180 * SECOND));
        if (t is null) return null;
        if (!AiPinReservation(t, slot)) { aiBuilderMgr.AbortTask(t); return null; }
        return t;
    }
    IUnitTask@ Place(CCircuitUnit@ u, CCircuitDef@ d, Task::BuildType type, Task::Priority priority, bool reactor = false, float walkRadius = 0.0f)
    {
        if (d is null || !d.IsAvailable(ai.frame) || !u.circuitDef.CanBuild(d)) return null;
        if (d.GetName() == UnitHelpers::GetWindNameForSide(UnitHelpers::GetSideForUnitName(d.GetName())))
            return PlaceWind(u, d, priority, walkRadius);
        const bool commander = UnitHelpers::IsCommander(u.circuitDef);
        const bool local = commander && walkRadius <= 0.0f;
        const string key = d.GetName() + (reactor ? ".reactor" : ".field") + (commander ? (local ? ".local." : ".walk.") + u.id : "");
        int64 retry = 0;
        if (placeRetry.get(key, retry) && ai.frame < retry) return null;
        AIFloat3 anchor = commander ? u.GetPos(ai.frame) : Global::Map::StartPos;
        if (reactor) anchor = Offset(anchor, facing, 0.0f, -900.0f);
        // Deterministic spaced patches, outside every reserved production bank.
        for (int ring = 1; ring <= Global::RoleSettings::Air::EconomySearchRings; ++ring) {
            for (int k = 0; k < 24; ++k) {
                const float a = 6.2831853f * float(k) / 24.0f;
                AIFloat3 p(anchor.x + cos(a) * float(ring) * 96.0f, 0.0f, anchor.z + sin(a) * float(ring) * 96.0f);
                if (local && !ProductionMath::WithinReach(MapHelpers::SqDist(anchor, p), u.circuitDef.GetBuildDistance())) continue;
                if (walkRadius > 0.0f && !ProductionMath::WithinReach(MapHelpers::SqDist(u.GetPos(ai.frame), p), walkRadius)) continue;
                bool near = false;
                for (uint b = 0; b < bays.length(); ++b)
                    if (MapHelpers::SqDist(p, bays[b].centre) < (reactor ? 700.0f * 700.0f : 250.0f * 250.0f)) near = true;
                if (near || !Inside(p, 96.0f) || aiTerrainMgr.IsZoneAlly(p) || !aiTerrainMgr.CanReachAt(u, p, u.circuitDef.GetBuildDistance())
                    || !aiTerrainMgr.CanReserveBuilding(d, p, facing)) continue;
                const int slot = aiTerrainMgr.ReserveBuilding(d, p, facing);
                if (slot < 0) continue;
                IUnitTask@ t = Pinned(type, priority, d, slot);
                if (t is null) aiTerrainMgr.ReleaseReservation(slot);
                return t;
            }
        }
        placeRetry.set(key, int64(ai.frame + 3 * SECOND));
        GenericHelpers::LogUtil("[AIR][Layout] no economy site for " + d.GetName() + "; retry in 3s", 2);
        return null;
    }
    void SaveWind(uint index)
    {
        WindCluster@ c = windClusters[index];
        const string key = "air.wind." + index;
        const string side = UnitHelpers::GetSideForUnitName(c.defName);
        aiTerrainMgr.SetLayoutInt(key + ".side", side == "cortex" ? 1 : side == "legion" ? 2 : 0);
        aiTerrainMgr.SetLayoutInt(key + ".facing", c.facing);
        aiTerrainMgr.SetLayoutInt(key + ".x", int(c.centre.x));
        aiTerrainMgr.SetLayoutInt(key + ".z", int(c.centre.z));
        for (uint s = 0; s < c.slots.length(); ++s) aiTerrainMgr.SetLayoutInt(key + ".slot." + s, c.slots[s]);
        aiTerrainMgr.SetLayoutInt("air.winds", int(windClusters.length()));
    }
    AIFloat3 WindPos(WindCluster@ c, CCircuitDef@ d, int s)
    {
        return Offset(c.centre, c.facing, ProductionMath::ClusterAcross(s, float(d.GetFootprintX()) * 16.0f),
            ProductionMath::ClusterAlong(s, float(d.GetFootprintZ()) * 16.0f));
    }
    IUnitTask@ PlaceWind(CCircuitUnit@ u, CCircuitDef@ d, Task::Priority priority, float walkRadius = 0.0f)
    {
        if (UnitHelpers::IsCommander(u.circuitDef)) {
            IUnitTask@ t = WindPass(u, d, priority, true);
            if (t !is null || (AirEconomy::CompletedConstructors() > 0 && walkRadius <= 0.0f)) return t;
        }
        return WindPass(u, d, priority, false, walkRadius);
    }
    IUnitTask@ WindPass(CCircuitUnit@ u, CCircuitDef@ d, Task::Priority priority, bool local, float walkRadius = 0.0f)
    {
        const AIFloat3 origin = u.GetPos(ai.frame);
        // Native states own occupied, claimed and destroyed slots. Fill holes first.
        for (uint i = 0; i < windClusters.length(); ++i) {
            WindCluster@ c = windClusters[i];
            if (c.defName != d.GetName()) continue;
            for (uint s = 0; s < c.slots.length(); ++s) {
                const AIFloat3 p = WindPos(c, d, int(s));
                if (local && !ProductionMath::WithinReach(MapHelpers::SqDist(origin, p), u.circuitDef.GetBuildDistance())) continue;
                if (walkRadius > 0.0f && !ProductionMath::WithinReach(MapHelpers::SqDist(origin, p), walkRadius)) continue;
                if (!Inside(p, 32.0f) || !aiTerrainMgr.CanReachAt(u, p, u.circuitDef.GetBuildDistance())) continue;
                int state = aiTerrainMgr.GetReservationState(c.slots[s]);
                if (state < 0 || state == 4) {
                    aiTerrainMgr.ReleasePersistentBuilding(c.slots[s]);
                    c.slots[s] = aiTerrainMgr.ReservePersistentBuilding(d, p, c.facing);
                    SaveWind(i);
                    state = aiTerrainMgr.GetReservationState(c.slots[s]);
                }
                if (state != 0) continue;
                IUnitTask@ task = Pinned(Task::BuildType::ENERGY, priority, d, c.slots[s]);
                if (task !is null) return task;
            }
        }
        const string key = d.GetName() + ".cluster" + (local ? ".local." + u.id : walkRadius > 0.0f ? ".walk." + u.id : "");
        int64 retry = 0;
        if (placeRetry.get(key, retry) && ai.frame < retry) return null;
        const float diameter = sqrt(ProductionMath::ClusterDiameterSquared(float(d.GetFootprintX()) * 16.0f, float(d.GetFootprintZ()) * 16.0f));
        const AIFloat3 anchor = local || walkRadius > 0.0f ? origin : Global::Map::StartPos;
        const int rings = local ? int(u.circuitDef.GetBuildDistance() / 32.0f) : walkRadius > 0.0f ? int(walkRadius / 96.0f) : Global::RoleSettings::Air::EconomySearchRings;
        const float step = local ? 32.0f : 96.0f;
        for (int ring = 1; ring <= rings; ++ring) {
            for (int k = 0; k < 24; ++k) {
                const float angle = 6.2831853f * float(k) / 24.0f;
                WindCluster c; c.defName = d.GetName(); c.facing = facing;
                c.centre = AIFloat3(anchor.x + cos(angle) * float(ring) * step, 0.0f,
                    anchor.z + sin(angle) * float(ring) * step);
                bool near = false;
                for (uint b = 0; b < bays.length(); ++b)
                    if (MapHelpers::SqDist(c.centre, bays[b].centre) < 250.0f * 250.0f) near = true;
                for (uint i = 0; i < windClusters.length(); ++i) {
                    CCircuitDef@ other = ai.GetCircuitDef(windClusters[i].defName);
                    if (other is null) continue;
                    const float separation = 0.5f * (diameter + sqrt(ProductionMath::ClusterDiameterSquared(float(other.GetFootprintX()) * 16.0f,
                        float(other.GetFootprintZ()) * 16.0f))) + Global::RoleSettings::Air::WindClusterGap + 16.0f;
                    if (MapHelpers::SqDist(c.centre, windClusters[i].centre) < separation * separation) near = true;
                }
                if (near || !Inside(c.centre, diameter) || aiTerrainMgr.IsZoneAlly(c.centre)) continue;
                for (int s = 0; s < 6; ++s) {
                    const AIFloat3 p = WindPos(c, d, s);
                    if (local && !ProductionMath::WithinReach(MapHelpers::SqDist(origin, p), u.circuitDef.GetBuildDistance())) break;
                    if (walkRadius > 0.0f && !ProductionMath::WithinReach(MapHelpers::SqDist(origin, p), walkRadius)) break;
                    if (!aiTerrainMgr.CanReachAt(u, p, u.circuitDef.GetBuildDistance())) break;
                    const int id = aiTerrainMgr.ReservePersistentBuilding(d, p, facing);
                    if (id < 0) break;
                    c.slots.insertLast(id);
                    // Anchor the grid to the first snapped slot, avoiding accumulated rounding.
                    if (s == 0) {
                        const AIFloat3 snapped = aiTerrainMgr.GetReservationPos(id);
                        c.centre.x += snapped.x - p.x; c.centre.z += snapped.z - p.z;
                    }
                }
                if (c.slots.length() != 6) {
                    for (uint s = 0; s < c.slots.length(); ++s) aiTerrainMgr.ReleasePersistentBuilding(c.slots[s]);
                    continue;
                }
                windClusters.insertLast(c); SaveWind(windClusters.length() - 1);
                GenericHelpers::LogUtil("[AIR][Wind] cluster=" + (windClusters.length() - 1) + " slots=6 at=" + int(c.centre.x) + "," + int(c.centre.z)
                    + " local=" + local + " builder=" + u.id, 1);
                return Pinned(Task::BuildType::ENERGY, priority, d, c.slots[0]);
            }
        }
        placeRetry.set(key, int64(ai.frame + 3 * SECOND));
        return null;
    }
    void Leave()
    {
        if (!enabled) return;
        aiTerrainMgr.ResetLayout(); aiTerrainMgr.SetLayoutEnabled(false);
        aiBuilderMgr.experimentalAirDirect = false;
        enabled = false; bays.resize(0); windClusters.resize(0); searchAfter = 0; overlay = false;
        placeRetry.deleteAll();
    }
}

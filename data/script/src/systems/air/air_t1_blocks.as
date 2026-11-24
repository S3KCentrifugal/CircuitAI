#include "../../helpers/math/front_constructor_math.as"
// Owner 2026-11-24 (Moonshine Run, AI 8): AIR's advanced solars and T1 energy
// converters go into dense blocks (T1BlockColumns x T1BlockRows, footprints
// touching), the way construction turrets and advanced converters already sit
// in blocks. Before this they took AirLayout::PlaceField's ring search, whose
// block_map yards (converter yard 8 = 128 elmos, advanced solar circle 6) spread
// them across the home disc. Same mechanism as FrontEcoBlocks (D-463): native
// ReserveGrid with no gap, one open block per kind, slots served nearest first
// and pinned so native placement never moves them; a new block when full.
// Cost: a block search is at most (2R+1)^2 area preflights (R = T1BlockSearchRings)
// and ReserveGrid calls of cols x rows reservations, throttled by
// T1BlockRetrySeconds; serving a slot is one NextSlotAny scan of the group.
// Ownership: native layout owns the reservations; this file keeps the open
// block's group id and centre per kind, persisted in layout state.
namespace AirT1Blocks {
    const int ADVSOLAR = 0, CONVERTER = 1;
    const array<string> NAMES = {"advsolar", "converter"};
    array<int> groups = {-1, -1};
    array<AIFloat3> centres(2);
    array<int> retryAfter = {0, 0};
    array<int> failSince = {-1, -1};    // first frame of the current run of failed block searches
    dictionary slotAskedUntil;          // slot id -> frame it may be ordered again
    bool loaded = false;

    int Abs(int v) { return v < 0 ? -v : v; }
    string Key(int kind) { return "air.t1block." + NAMES[kind]; }
    int Kind(const CCircuitDef@ d) {
        if (d is null || !Global::RoleSettings::Air::T1Blocks) return -1;
        const string side = UnitHelpers::GetSideForUnitName(d.GetName());
        if (d.GetName() == UnitHelpers::GetAdvSolarNameForSide(side)) return ADVSOLAR;
        if (d.GetName() == UnitHelpers::GetEnergyConverterNameForSide(side)) return CONVERTER;
        return -1;
    }
    void Load() {
        if (loaded) return;
        loaded = true;
        for (int kind = 0; kind < 2; ++kind) {
            groups[kind] = aiTerrainMgr.GetLayoutInt(Key(kind) + ".group", -1);
            centres[kind] = AIFloat3(float(aiTerrainMgr.GetLayoutInt(Key(kind) + ".x", 0)), 0.f,
                float(aiTerrainMgr.GetLayoutInt(Key(kind) + ".z", 0)));
        }
    }
    void Save(int kind) {
        aiTerrainMgr.SetLayoutInt(Key(kind) + ".group", groups[kind]);
        aiTerrainMgr.SetLayoutInt(Key(kind) + ".x", int(centres[kind].x));
        aiTerrainMgr.SetLayoutInt(Key(kind) + ".z", int(centres[kind].z));
    }
    bool Open(int kind) {
        return groups[kind] > 0 && aiTerrainMgr.GetGroupCount(groups[kind], true) > 0;
    }
    bool NearBay(const AIFloat3 &in p, float halfDiagonal) {
        const float r = Global::RoleSettings::Air::T1BlockBaySeparation + halfDiagonal;
        for (uint b = 0; b < AirLayout::bays.length(); ++b)
            if ((AirLayout::bays[b].slot >= 0 || AirLayout::bays[b].factoryId >= 0)
                && MapHelpers::SqDist(p, AirLayout::bays[b].centre) < r * r) return true;
        return false;
    }
    // Reserve a whole block near the start, nearest lattice cell first, the
    // lattice anchored T1BlockRearOffset behind the start.
    bool Reserve(int kind, CCircuitUnit@ worker, CCircuitDef@ def) {
        const int cols = AiMax(1, Global::RoleSettings::Air::T1BlockColumns);
        const int rows = AiMax(1, Global::RoleSettings::Air::T1BlockRows);
        if (ai.frame < retryAfter[kind]) return false;
        retryAfter[kind] = ai.frame + int(Global::RoleSettings::Air::T1BlockRetrySeconds * SECOND);
        int facing = AirLayout::facing;
        if (facing < 0 || facing > 3) facing = 0;
        // GetFootprint is in half-cells: one footprint square is 2 * SQUARE_SIZE.
        const float size = float(AiMax(def.GetFootprintX(), def.GetFootprintZ())) * SQUARE_SIZE * 2.0f;
        const float across = float(cols) * size, along = float(rows) * size;
        const float halfDiagonal = 0.5f * sqrt(across * across + along * along);
        const AIFloat3 start = Global::Map::StartPos;
        const AIFloat3 anchor = AirLayout::Offset(start, facing, 0.0f, -(Global::RoleSettings::Air::T1BlockRearOffset + along * 0.5f));
        const float radius = Global::RoleSettings::Air::T1BlockMaxRadius;
        const float reach = worker.circuitDef.GetBuildDistance();
        // Step a little over a block so neighbouring blocks keep a walking lane.
        const float stepX = across + 32.0f, stepZ = along + 32.0f;
        const int rings = AiMax(0, Global::RoleSettings::Air::T1BlockSearchRings);
        for (int ring = 0; ring <= rings; ++ring) {
            for (int z = -ring; z <= ring; ++z) for (int x = -ring; x <= ring; ++x) {
                if (AiMax(Abs(x), Abs(z)) != ring) continue;   // ring perimeter only
                const AIFloat3 centre = AirLayout::Offset(anchor, facing, float(x) * stepX, -float(z) * stepZ);
                if (MapHelpers::SqDist(centre, start) > radius * radius
                    || !AirLayout::Inside(centre, halfDiagonal + 16.0f)
                    || !AirHome::EconomySite(centre) || aiTerrainMgr.IsZoneAlly(centre)
                    || NearBay(centre, halfDiagonal)) continue;
                bool home = true;
                for (int corner = 0; corner < 4 && home; ++corner)
                    if (!AirHome::EconomySite(AirLayout::Offset(centre, facing, corner % 2 == 0 ? -across * 0.5f : across * 0.5f,
                        corner < 2 ? -along * 0.5f : along * 0.5f))) home = false;
                if (!home || !aiTerrainMgr.CanReserveArea(centre, facing, across * 0.5f, along * 0.5f)
                    || !aiTerrainMgr.CanReachAtSafe(worker, centre, reach + across)) continue;
                const int group = aiTerrainMgr.ReserveGrid(def, AirLayout::Offset(centre, facing, 0.0f, along * 0.5f), facing, cols, rows, 0);
                if (group <= 0) continue;
                if (!FrontConstructorMath::BlockAccepted(aiTerrainMgr.GetGroupCount(group, false), cols, rows,
                    Global::RoleSettings::Air::T1BlockMinimumFill)) {
                    aiTerrainMgr.ReleaseGroup(group);
                    continue;
                }
                groups[kind] = group; centres[kind] = centre; Save(kind);
                failSince[kind] = -1;
                GenericHelpers::LogUtil("[AIR][T1Block] " + NAMES[kind] + " block group=" + group + " slots="
                    + aiTerrainMgr.GetGroupCount(group, false) + " at " + int(centre.x) + "," + int(centre.z)
                    + " dist=" + int(sqrt(MapHelpers::SqDist(centre, start))), 1);
                return true;
            }
        }
        if (failSince[kind] < 0) failSince[kind] = ai.frame;
        GenericHelpers::LogUtil("[AIR][T1Block] no room for a " + NAMES[kind] + " block; retry in "
            + int(Global::RoleSettings::Air::T1BlockRetrySeconds) + " s", 2);
        return false;
    }
    // The field search (AirLayout::PlaceField) only after no block fitted for
    // T1BlockFallbackSeconds in a row, so a crowded home never stops the power.
    bool FallbackDue(const CCircuitDef@ d) {
        const int kind = Kind(d);
        if (kind < 0) return true;
        if (Open(kind)) return false;
        return failSince[kind] >= 0 && ai.frame - failSince[kind] >= int(Global::RoleSettings::Air::T1BlockFallbackSeconds * SECOND);
    }
    // The next free slot of the open block, reserving a new block when it is full.
    // A commander building locally (walkRadius 0) only takes a slot within its
    // reach and otherwise leaves the order to the field search.
    IUnitTask@ Place(CCircuitUnit@ u, CCircuitDef@ d, Task::BuildType type, Task::Priority priority, float walkRadius) {
        const int kind = Kind(d);
        if (kind < 0) return null;
        Load();
        if (!Open(kind) && !Reserve(kind, u, d)) return null;
        const int slot = aiTerrainMgr.NextSlotAny(groups[kind], centres[kind]);
        if (slot < 0 || aiTerrainMgr.GetReservationState(slot) != 0 || !aiTerrainMgr.IsReservationBuildable(slot)) return null;
        int askedUntil = 0;
        if (slotAskedUntil.get("" + slot, askedUntil) && ai.frame < askedUntil) return null;
        const AIFloat3 pos = aiTerrainMgr.GetReservationPos(slot);
        const AIFloat3 at = u.GetPos(ai.frame);
        if (UnitHelpers::IsCommander(u.circuitDef) && walkRadius <= 0.0f
            && !ProductionMath::WithinReach(MapHelpers::SqDist(at, pos), u.circuitDef.GetBuildDistance())) return null;
        if (walkRadius > 0.0f && !ProductionMath::WithinReach(MapHelpers::SqDist(at, pos), walkRadius)) return null;
        if (!aiTerrainMgr.CanReachAt(u, pos, u.circuitDef.GetBuildDistance())) return null;
        IUnitTask@ t = AirLayout::Pinned(type, priority, d, slot);
        if (t is null) return null;
        // A pin marks its slot only on first assignment: hold the slot so the
        // next idle builder does not order the same one again meanwhile.
        slotAskedUntil.set("" + slot, ai.frame + int(Global::RoleSettings::Air::T1BlockSlotHoldSeconds * SECOND));
        return t;
    }
    // The commander's local pass found no slot within reach: let it use the field.
    bool CommanderLocal(CCircuitUnit@ u, float walkRadius) {
        return UnitHelpers::IsCommander(u.circuitDef) && walkRadius <= 0.0f;
    }
}

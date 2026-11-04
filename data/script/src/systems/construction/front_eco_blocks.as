#include "../../helpers/math/front_constructor_math.as"
// D-463: FRONT's dense economy blocks. One open block per kind (wind
// turbines, T1 energy converters), reserved by native ReserveGrid with no gap
// between footprints so the base keeps its space. A block is searched once,
// on a bounded lattice behind the start position; its slots are then served
// nearest first and pinned, so native placement never spreads them out.
// Cost: a search is at most (EcoBlockSearchRings + 1) * (2 * EcoBlockSearchRings + 1) area preflights
// and ReserveGrid calls of columns x rows reservations, throttled by
// EcoBlockRetrySeconds; serving a slot is one NextSlotAny scan of the
// reservation table. Ownership: the native layout owns the reservations; this
// file keeps only the open block's group id and centre, persisted in layout
// state. A block whose group has no unconsumed slot left is replaced.
namespace FrontEcoBlocks {
    const int WIND = 0, CONVERTER = 1;
    const array<string> NAMES = {"wind", "converter"};
    array<int> groups = {-1, -1};
    array<AIFloat3> centres(2);
    array<int> retryAfter = {0, 0};
    bool loaded = false;

    int Abs(int v) { return v < 0 ? -v : v; }
    string Key(int kind) { return "front.eco." + NAMES[kind]; }
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
    // Native facing convention: SOUTH 0 +z, EAST 1 +x, NORTH 2 -z, WEST 3 -x,
    // with ReserveGrid's columns along these side vectors.
    AIFloat3 Forward(int facing) {
        return facing == 1 ? AIFloat3(1.f, 0.f, 0.f) : facing == 2 ? AIFloat3(0.f, 0.f, -1.f)
            : facing == 3 ? AIFloat3(-1.f, 0.f, 0.f) : AIFloat3(0.f, 0.f, 1.f);
    }
    AIFloat3 Side(int facing) {
        return facing == 1 ? AIFloat3(0.f, 0.f, -1.f) : facing == 2 ? AIFloat3(-1.f, 0.f, 0.f)
            : facing == 3 ? AIFloat3(0.f, 0.f, 1.f) : AIFloat3(1.f, 0.f, 0.f);
    }
    bool Open(int kind) {
        return groups[kind] > 0 && aiTerrainMgr.GetGroupCount(groups[kind], true) > 0;
    }
    // Reserve a whole block behind the start, nearest lattice cell first.
    bool Reserve(int kind, CCircuitUnit@ worker, CCircuitDef@ def, int cols, int rows) {
        if (ai.frame < retryAfter[kind] || cols <= 0 || rows <= 0) return false;
        retryAfter[kind] = ai.frame + int(Global::RoleSettings::Front::EcoBlockRetrySeconds * SECOND);
        int facing = FrontLayout::ForwardFacing();
        if (facing < 0 || facing > 3) facing = 0;
        const AIFloat3 fwd = Forward(facing), side = Side(facing);
        // GetFootprint is in half-cells: one footprint square is 2 * SQUARE_SIZE.
        const float size = float(AiMax(def.GetFootprintX(), def.GetFootprintZ())) * SQUARE_SIZE * 2.0f;
        const float across = float(cols) * size, along = float(rows) * size;
        const AIFloat3 start = Global::Map::StartPos;
        const AIFloat3 anchor = start - fwd * (Global::RoleSettings::Front::EcoBlockRearOffset + along * 0.5f);
        const float radius = Global::RoleSettings::Front::BaseSupportRadius;
        const float reach = worker.circuitDef.GetBuildDistance();
        const int rings = AiMax(0, Global::RoleSettings::Front::EcoBlockSearchRings);
        for (int ring = 0; ring <= rings; ++ring) {
            // Half rings: z only steps further behind the start, never ahead.
            for (int z = 0; z <= ring; ++z) for (int x = -ring; x <= ring; ++x) {
                if (AiMax(Abs(x), z) != ring) continue;   // ring perimeter only
                const AIFloat3 centre = anchor + side * (float(x) * across) - fwd * (float(z) * along);
                if (MapHelpers::SqDist(centre, start) > radius * radius
                    || !aiTerrainMgr.CanReserveArea(centre, facing, across * 0.5f, along * 0.5f)
                    || !aiTerrainMgr.CanReachAtSafe(worker, centre, reach + across)) continue;
                const int group = aiTerrainMgr.ReserveGrid(def, centre + fwd * (along * 0.5f), facing, cols, rows, 0);
                if (group <= 0) continue;
                if (!FrontConstructorMath::BlockAccepted(aiTerrainMgr.GetGroupCount(group, false), cols, rows,
                    Global::RoleSettings::Front::EcoBlockMinimumFill)) {
                    aiTerrainMgr.ReleaseGroup(group);
                    continue;
                }
                groups[kind] = group; centres[kind] = centre; Save(kind);
                GenericHelpers::LogUtil("[FrontEco] " + NAMES[kind] + " block group=" + group + " slots="
                    + aiTerrainMgr.GetGroupCount(group, false) + " at " + int(centre.x) + "," + int(centre.z), 1);
                return true;
            }
        }
        GenericHelpers::LogUtil("[FrontEco] no room for a " + NAMES[kind] + " block; retry in "
            + int(Global::RoleSettings::Front::EcoBlockRetrySeconds) + " s", 2);
        return false;
    }
    // The next free slot of the open block, reserving a new block when it is
    // full. Pinned so the structure goes exactly on the slot.
    IUnitTask@ Order(int kind, CCircuitUnit@ worker, CCircuitDef@ def, Task::BuildType type, int cols, int rows) {
        Load();
        if (!Open(kind) && !Reserve(kind, worker, def, cols, rows)) return null;
        const int slot = aiTerrainMgr.NextSlotAny(groups[kind], centres[kind]);
        if (slot < 0) return null;
        IUnitTask@ task = aiBuilderMgr.Enqueue(TaskB::Common(type, Task::Priority::HIGH, def,
            aiTerrainMgr.GetReservationPos(slot), 0.f, true,
            int(Global::RoleSettings::Front::EcoBlockOrderSeconds * SECOND)));
        if (task !is null && !AiPinReservation(task, slot)) { aiBuilderMgr.AbortTask(task); return null; }
        return task;
    }
}

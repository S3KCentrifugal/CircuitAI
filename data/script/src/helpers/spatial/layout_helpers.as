// Base layout policy entry point and facing selection. Canonical footprint,
// orientation and slot geometry lives in native BaseLayoutGeometry.h.
#include "../../define.as"
#include "../../global.as"
#include "../../types/role_config.as"
#include "../common/generic_helpers.as"

/******************************************************************************

LAYOUT HELPERS

A role's plan is a handful of reservations pushed at setup, before the first
factory is placed (Setup runs from AiGetFactoryToBuild, the same frame the
native chooser picks the start factory). Native holds the ground
(aiTerrainMgr.ReserveBuilding / ReserveGrid) and serves each site back to the
first construction of that def; everything else is placed around it
(D-043). The helpers below only do the geometry: a facing, its forward and
side unit vectors, offsets in elmos, and footprint extents.

Facing is the engine's: SOUTH 0 = +z, EAST 1 = +x, NORTH 2 = -z, WEST 3 = -x.
A factory's exit is on its facing side. Native's ReserveGrid uses the same
side vectors as Side() here, so a grid and an offset agree on left and right.

******************************************************************************/
#include "wall_helpers.as"

namespace LayoutHelpers {
    int alliedCheckFrame = -100000;
    // Validate snapped sites once at reservation time, not every simulation tick.
    bool CheckGrid(const array<int> &in slots, uint first, int columns, int facing, float width, float depth) {
        if (columns<=0 || first>=slots.length()) return false;
        const AIFloat3 origin=aiTerrainMgr.GetReservationPos(slots[first]);
        for (uint i=first+1; i<slots.length(); ++i) {
            const int cell=int(i-first);
            const AIFloat3 expected=Offset(origin,facing,float(cell%columns)*width,float(cell/columns)*depth);
            if (MapHelpers::SqDist(expected,aiTerrainMgr.GetReservationPos(slots[i]))>1.0f) {
                Invariants::Violation("INV-136",""+slots[i],"dense economy grid pitch changed after engine snapping");
                return false;
            }
        }
        return true;
    }
    void CheckAlliedPlacements()
    {
        if (ai.frame - alliedCheckFrame < SECOND) return;
        alliedCheckFrame = ai.frame;
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            IBuilderTask@ task = u is null ? null : cast<IBuilderTask>(u.task);
            if (task is null || task.buildDef is null || task.GetBuildType() >= int(Task::BuildType::REPAIR)) continue;
            if (!WallHelpers::Allowed(task.buildDef, task.GetBuildPos()))
                Invariants::Violation("INV-089", "" + u.id, "wall construction overlaps an allied start base area");
            const int slot = AiTaskReservationId(task);
            if (slot < 0) continue;
            if (aiTerrainMgr.IsAllyLayoutBlocked(task.buildDef, aiTerrainMgr.GetReservationPos(slot), aiTerrainMgr.GetReservationFacing(slot)))
                Invariants::Violation("INV-088", "" + u.id, "building task overlaps another allied layout reservation");
        }
    }
    // State is aggregated before checking buildability: one live claim locks a cluster.
    int ActivationState(const array<int> &in slots)
    {
        bool blocked = slots.length() == 0;
        for (uint i = 0; i < slots.length(); ++i) {
            const int state = aiTerrainMgr.GetReservationState(slots[i]);
            if (state >= 1 && state <= 3) return 2;
            if (!aiTerrainMgr.IsReservationBuildable(slots[i])) blocked = true;
        }
        return blocked ? 1 : 0;
    }

    AIFloat3 Offset(const AIFloat3 &in p, int f, float across, float along)
    {
        if (f == 1) return AIFloat3(p.x + along, 0.0f, p.z - across);
        if (f == 2) return AIFloat3(p.x - across, 0.0f, p.z - along);
        if (f == 3) return AIFloat3(p.x - along, 0.0f, p.z + across);
        return AIFloat3(p.x + across, 0.0f, p.z + along);
    }


    const int FACING_SOUTH = 0;
    const int FACING_EAST = 1;
    const int FACING_NORTH = 2;
    const int FACING_WEST = 3;
    // The facing whose forward points most nearly from `from` to `to`.
    int FacingToward(const AIFloat3& in from, const AIFloat3& in to)
    {
        const float dx = to.x - from.x;
        const float dz = to.z - from.z;
        const float ax = (dx < 0.0f) ? -dx : dx;
        const float az = (dz < 0.0f) ? -dz : dz;
        if (ax > az) return (dx > 0.0f) ? FACING_EAST : FACING_WEST;
        return (dz > 0.0f) ? FACING_SOUTH : FACING_NORTH;
    }

    AIFloat3 TerrainCentre()
    {
        return AIFloat3(float(AiTerrainWidth()) * 0.5f, 0.0f, float(AiTerrainHeight()) * 0.5f);
    }

    // D-451/C1: corridors are a per-role opt-in. Roles with played evidence
    // (FRONT, TACTICAL) default on; the others keep their smrt-test placement
    // until a layout run clears them. JSON factory_corridors/roles/<ROLE>.
    bool CorridorsForRole(AiRole role)
    {
        const bool played = role == AiRole::FRONT || role == AiRole::TACTICAL;
        return aiSetupMgr.ConfigBool("factory_corridors/enabled", true)
            && aiSetupMgr.ConfigBool("factory_corridors/roles/" + Team::Roster::RoleName(role), played);
    }

    // C1: the start factory a role actually chose is the one it may exempt
    // (TECH's disposable T1 lab). Native lifts it once a non-T1 factory stands.
    void ExemptStartFactory(const string& in name)
    {
        CCircuitDef@ def = ai.GetCircuitDef(name);
        aiTerrainMgr.SetFactoryCorridorExempt(def is null ? -1 : def.id);
    }

    void ApplyFactoryCorridors()
    {
        const AiRole role = Global::AISettings::Role;
        aiTerrainMgr.SetFactoryCorridorPolicy(CorridorsForRole(role), role == AiRole::FRONT);
        aiTerrainMgr.SetFactoryCorridorExempt(-1);
        aiTerrainMgr.SetFactoryCorridorOptions(
            aiSetupMgr.ConfigInt("factory_corridors/probes", 4),
            aiSetupMgr.ConfigInt("factory_corridors/background_probes", 1),
            aiSetupMgr.ConfigInt("factory_corridors/visits", 32768),
            aiSetupMgr.ConfigFloat("factory_corridors/goal_start", 768.f),
            aiSetupMgr.ConfigFloat("factory_corridors/goal_end", 2048.f),
            aiSetupMgr.ConfigFloat("factory_corridors/lane_wait_seconds", 30.f));
    }

    // Setup: run the role's plan once, after its caps and porc chain are in.
    void ApplyForRole()
    {
        ApplyFactoryCorridors();
        const bool frontDistrict=Global::AISettings::Role == AiRole::FRONT && Global::RoleSettings::Front::FactoryLayoutsEnabled;
        const bool tacticalDistrict=Global::AISettings::Role == AiRole::TACTICAL && Global::RoleSettings::Tactical::FactoryLayoutsEnabled;
        // C3 (D-453): a district role places factories only through its plan
        // or the reserved search; the legacy shortcuts stay on for the rest.
        const bool legacyPlacement = !frontDistrict && !tacticalDistrict;
        aiTerrainMgr.SetFactoryReservationOnActivate(legacyPlacement);
        aiTerrainMgr.SetFactoryFlushPacking(legacyPlacement);
        aiTerrainMgr.SetFactoryDirectSite(legacyPlacement);
        // D-460 (KI-743): district roles' factories never face away from the
        // enemy. FRONT moves the goal onto its lane once the lane is claimed
        // (CoverageLanes::Claim); x < 0 leaves the native search unchanged.
        aiTerrainMgr.SetFactoryFacingGoal(legacyPlacement ? AIFloat3(-1.f,0.f,-1.f)
            : Lanes::NearestEnemyStart(Global::Map::StartPos));
        if (!tacticalDistrict) aiTerrainMgr.ReleaseUnusedLayout(TacticalLayout::ROOT);
        if (!frontDistrict) FrontLayout::Release();
        aiTerrainMgr.SetLayoutPriority(Global::AISettings::Role == AiRole::TECH ? 2
            : Global::AISettings::Role == AiRole::AIR ? 1 : 0);
        // Share ordinary sites without enabling factory packing or a role plan.
        // Every accepted ordinary build becomes non-preemptible, including an
        // AIR opening or TECH's freely placed first T1 factory.
        aiTerrainMgr.SetBuildSiteReservations(true);
        RoleConfig@ cfg = (Global::profileController is null) ? null : Global::profileController.RoleCfg;
        if (cfg is null || cfg.LayoutPlanHandler is null) {
            GenericHelpers::LogUtil("[Layout] no plan for this role; placement is the native spiral", 2);
            return;
        }
        if (!Global::Map::HasStart) {
            GenericHelpers::LogUtil("[Layout] start position unknown at setup; no plan pushed", 1);
            return;
        }
        cfg.LayoutPlanHandler(Global::AISettings::Side);
    }
}

#include "../../helpers/spatial/layout_helpers.as"
#include "../../helpers/units/unit_helpers.as"
#include "../../helpers/math/front_factory_math.as"
#include "../world/lanes.as"

// Placement policy only. Existing TACTICAL economy, production, assistance and
// objective chains decide what to build. No tick, worker scan or extra RNG draw.
namespace TacticalLayout {
    const string ROOT = "tactical.factory";

    bool Enabled() {
        return Global::AISettings::Role == AiRole::TACTICAL
            && Global::RoleSettings::Tactical::FactoryLayoutsEnabled;
    }

    void Init(const string& in side) {
        if (Enabled()) aiTerrainMgr.SetLayoutEnabled(true);
    }

    bool Supported(const string& in name) {
        return UnitHelpers::IsT1HoverPlant(name) || UnitHelpers::IsT1BotLab(name)
            || UnitHelpers::IsT2BotLab(name) || UnitHelpers::IsT1VehicleLab(name)
            || UnitHelpers::IsT2VehicleLab(name);
    }

    void Arm(const string& in key) {
        aiTerrainMgr.ArmGroup(aiTerrainMgr.GetNamedLayoutGroup(key + ".factory"), true);
        aiTerrainMgr.ArmGroup(aiTerrainMgr.GetNamedLayoutGroup(key + ".nano"), true);
    }

    bool Plan(const string& in name, const AIFloat3& in anchor) {
        if (!Enabled() || !Global::Map::HasStart || !Supported(name)) return false;
        CCircuitDef@ factory = ai.GetCircuitDef(name);
        CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if (factory is null || nano is null || !aiTerrainMgr.SetLayoutEnabled(true)) return false;
        if (aiTerrainMgr.GetReservationCount(factory) > 0) return true;
        const string stem = ROOT + "." + factory.id;
        // One bounded search per new factory request, throttled on failure.
        // Persistent serials prevent a completed cluster serving a second lab.
        if (ai.frame < aiTerrainMgr.GetLayoutInt(stem + ".retry", -5 * SECOND) + 5 * SECOND) return false;
        aiTerrainMgr.SetLayoutInt(stem + ".retry", ai.frame);
        const int serial = aiTerrainMgr.GetLayoutInt(stem + ".serial", 0);
        const string key = stem + "." + serial;
        // D-460 (KI-743): face the nearest enemy start (the native facing goal
        // for TACTICAL); sideways passes take the side toward it first and
        // never one pointing away. Setup's lane position is an expansion
        // anchor, not the combat direction.
        const AIFloat3 goal = Lanes::NearestEnemyStart(anchor), centre = LayoutHelpers::TerrainCentre();
        const int primary = LayoutHelpers::FacingToward(anchor, goal);
        const array<float> offsets = {0.f, 128.f, -128.f, 256.f, -256.f};
        const int maxRows = AiMax(1, AiMin(4, Global::RoleSettings::Tactical::FactorySupportRows));
        // LayoutFacing's passes are (full, compact) per direction; TACTICAL
        // has no compact form, so every second pass is used.
        for (uint pass = 0; pass < FrontFactoryMath::LAYOUT_PASSES; pass += 2) {
            const int facing = FrontFactoryMath::LayoutFacing(primary, pass, goal.x - anchor.x, goal.z - anchor.z,
                centre.x - anchor.x, centre.z - anchor.z);
            if (facing < 0) continue;
            for (uint offset = 0; offset < offsets.length(); ++offset) {
                const AIFloat3 site = LayoutHelpers::Offset(anchor, facing, offsets[offset], 128.f);
                for (int rows = maxRows; rows >= 1; --rows) {
                    const int slot = aiTerrainMgr.PlanFactoryCluster(key, factory, nano, site, facing, 2, rows);
                    if (slot < 0) continue;
                    Arm(key);
                    aiTerrainMgr.SetLayoutInt(stem + ".serial", serial + 1);
                    GenericHelpers::LogUtil("[TacticalLayout] reserved factory=" + name + " rows=" + rows, 1);
                    return true;
                }
            }
        }
        GenericHelpers::LogUtil("[TacticalLayout] no usable cluster for " + name + "; ordinary reserved placement", 2);
        return false;
    }

    void Prepare(IUnitTask@ task) {
        IBuilderTask@ build = cast<IBuilderTask>(task);
        if (build is null || build.buildDef is null || build.GetBuildType() != int(Task::BuildType::FACTORY)) return;
        // Remote objectives keep their own anchor and ordinary shared claims.
        // A home plan must never redirect a remote expansion request.
        const AIFloat3 anchor = build.GetBuildPos();
        if (anchor.x < 0.f || anchor.z < 0.f
            || MapHelpers::SqDist(anchor, Global::Map::StartPos) > 1024.f * 1024.f) return;
        Plan(build.buildDef.GetName(), anchor);
    }

    void FactoryAdded(CCircuitUnit@ unit, Unit::UseAs usage) {
        if (!Enabled() || unit is null || usage != Unit::UseAs::FACTORY
            || !Supported(unit.circuitDef.GetName())) return;
        const string stem = ROOT + "." + unit.circuitDef.id;
        const int serial = aiTerrainMgr.GetLayoutInt(stem + ".serial", 0);
        if (serial == 0) return;
        const string key = stem + "." + (serial - 1);
        const int slot = aiTerrainMgr.GetLayoutInt(key + ".factory_slot", -1);
        if (slot >= 0 && MapHelpers::SqDist(unit.GetPos(ai.frame), aiTerrainMgr.GetReservationPos(slot)) < 64.f) return;
        if (!aiTerrainMgr.ReleaseUnusedLayout(key)) return;
        CCircuitDef@ nano = ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if (nano is null) return;
        for (int rows = AiMax(1, AiMin(4, Global::RoleSettings::Tactical::FactorySupportRows)); rows > 0; --rows) {
            const int group = aiTerrainMgr.ReserveNanoBlock(unit, nano, 2, rows, 0);
            if (group <= 0) continue;
            aiTerrainMgr.ArmGroup(group, true);
            GenericHelpers::LogUtil("[TacticalLayout] adopted fallback factory=" + unit.circuitDef.GetName(), 1);
            return;
        }
    }
}

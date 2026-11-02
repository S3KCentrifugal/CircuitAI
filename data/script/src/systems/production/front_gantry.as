// FRONT T3 gantry production (owner, 2026-11-01).
#include "../../define.as"
#include "../../unit.as"
#include "../../global.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/units/unit_helpers.as"
#include "../world/strategic_sites.as"

/******************************************************************************

FRONT GANTRY

FRONT had no gantry policy: its gantries fell through to the native picker
(DefaultMakeTask), which returned only waits on Carrot Mountains 2026-11-01,
so four finished FRONT gantries with 14k-39k metal banked never built a unit.
Without a first product the GantryFallback repeat had nothing to repeat and
the lane waypoints had no unit to send.

FRONT now builds TECH's late heavies, one unit per ask: HeavyPair<Side>
(Armada Thor, Titan, Vanguard), rotating per gantry; on a moated start
HeavyMoated<Side> (Armada: Titans). An empty pair falls back to the side's
signature unit. Each candidate still passes the gantry's CanBuild and the
unit cap in Factory::EnqueueGantryBatchFrom. With no candidate buildable the
native picker runs as before.

******************************************************************************/
namespace FrontGantry {
    dictionary lastUnit;     // gantry id -> the unit its last order built
    array<string> order;     // reused candidate order

    array<string>@ List(const string &in side, bool moated)
    {
        if (side == "cortex")
            return (moated && Global::RoleSettings::Tech::HeavyMoatedCortex.length() > 0)
                ? Global::RoleSettings::Tech::HeavyMoatedCortex : Global::RoleSettings::Tech::HeavyPairCortex;
        if (side == "legion")
            return (moated && Global::RoleSettings::Tech::HeavyMoatedLegion.length() > 0)
                ? Global::RoleSettings::Tech::HeavyMoatedLegion : Global::RoleSettings::Tech::HeavyPairLegion;
        return (moated && Global::RoleSettings::Tech::HeavyMoatedArmada.length() > 0)
            ? Global::RoleSettings::Tech::HeavyMoatedArmada : Global::RoleSettings::Tech::HeavyPairArmada;
    }

    // The gantry's candidates, starting with the unit after the one it built last
    array<string>@ Order(CCircuitUnit@ g, const string &in side)
    {
        const bool moated = StrategicSites::Moated();
        array<string>@ list = List(side, moated);
        order.resize(0);
        if (list.length() == 0) {
            const string signature = UnitHelpers::GetGantrySignatureUnitForSide(side);
            if (signature.length() > 0) order.insertLast(signature);
            return @order;
        }
        string last;
        lastUnit.get("" + g.id, last);
        const int at = moated ? -1 : list.find(last);   // a moated list never rotates
        for (uint i = 1; i <= list.length(); ++i)
            order.insertLast(list[(uint(at + int(list.length())) + i) % list.length()]);
        return @order;
    }

    IUnitTask@ Produce(CCircuitUnit@ g, const string &in side)
    {
        if (!Global::RoleSettings::Front::GantryHeavies || g is null || g.circuitDef is null) return null;
        if (!UnitHelpers::IsGantryLab(g.circuitDef.GetName()) || g.GetBuildProgress() < 1.0f) return null;
        IUnitTask@ pending = aiFactoryMgr.GetPendingFactoryTask(g);
        if (pending !is null) return pending;
        IUnitTask@ task = Factory::EnqueueGantryBatchFrom(g, Order(g, side), 1, Task::Priority::HIGH);
        if (task is null) return null;
        lastUnit.set("" + g.id, Factory::lastGantryBatchUnit);
        GenericHelpers::LogUtil("[FRONT][Gantry] gantry=" + g.circuitDef.GetName() + " " + g.id
            + " unit=" + Factory::lastGantryBatchUnit + (StrategicSites::Moated() ? " (moated)" : ""), 1);
        return task;
    }
}  // namespace FrontGantry

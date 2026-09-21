// TECH's experimental build system: the whole builder sequence (D-066).
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
#include "../manager/factory.as"
#include "../manager/layout.as"
#include "../manager/eco_planner.as"

/******************************************************************************

TECH BUILD (experimental build system, D-066)

When Global::RoleSettings::Tech::ExperimentalBuild is on, this namespace is
the only source of work for TECH's builders. Native's own chooser
(DefaultMakeTask) returns nothing for this AI instance, its start-factory and
storage jobs are silent, and its site search never spirals: a task's site is
a planned slot (the factory pair, the turret box), an exact spot (a mex, a
geo) or the free footprint nearest the anchor the script asked for
(PackNearPoint). Every other role, and TECH with the flag off, runs the
stock ladder and the stock placement untouched.

MakeTask never returns null: a builder with nothing to build assists,
guards the factory or waits, and is asked again.

The sequence, per asking builder:

  turret        reclaim in reach, then the economy under construction by the
                owner's order, then any structure under construction in
                reach, then wait
  any builder   keeps the construction it is on (native re-asks while it walks)
  commander     the opening (the nearest OpeningMexCap mexes), then the start
                factory on its reserved slot, then the planner
  constructor   the start factory if it is still missing, mex expansion while
                metal income is under EcoMexExpandUntilIncome, the T2 lab
                gate, the planner, the role's strategic rungs (nukes,
                anti-nuke, gantry, water factories, donations - their sites
                are packed near the anchor they name), native's queued orders
                (defence, sensors, repairs) when the script reaches them,
                then assist the nearest structure under construction, then
                guard the primary factory, then wait

******************************************************************************/
namespace TechBuild {

    // ---------------------------------------------------------------- pieces

    IUnitTask@ Wait(int frames)
    {
        return aiBuilderMgr.Enqueue(TaskB::Wait(frames));
    }

    // The construction the builder is on, when native re-asks (D-063 follow-up 3).
    IUnitTask@ KeepCurrent(CCircuitUnit@ u)
    {
        IBuilderTask@ cur = (u.task is null) ? null : cast<IBuilderTask>(u.task);
        if (cur !is null && Task::BuildType(cur.GetBuildType()) < Task::BuildType::REPAIR)
            return u.task;
        return null;
    }

    // The start factory on its reserved slot (the pair's T1 slot is served
    // by native's reserved search). Native's own start-factory job is off.
    IUnitTask@ StartFactory(CCircuitUnit@ u)
    {
        if (!RoleTech::Opening::complete) return null;
        const string side = Global::AISettings::Side;
        CCircuitDef@ lab = ai.GetCircuitDef(UnitHelpers::GetT1BotLabForSide(side));
        if (lab is null || !u.circuitDef.CanBuild(lab)) return null;
        if (lab.count > 0 || aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::FACTORY), lab) > 0) return null;
        IUnitTask@ t = Builder::EnqueueT1BotLab(side, Global::Map::StartPos, 0.0f, 300 * SECOND, Task::Priority::NOW);
        if (t !is null) GenericHelpers::LogUtil("[TECH][Build] start factory ordered on the reserved slot", 1);
        return t;
    }

    // Mex expansion for constructors: the nearest open spot the builder can
    // reach within EcoMexExpandRadius, outside allied ground, while metal
    // income is the bottleneck. The commander never expands after the opening.
    int lastNoSpotLog = -100000;

    IUnitTask@ ExpandMex(CCircuitUnit@ u, float metalIncome)
    {
        if (metalIncome >= Global::RoleSettings::Tech::EcoMexExpandUntilIncome) return null;
        // Cap 0: every spot inside the radius is considered, nearest the
        // builder first, until an open one is found. Played with cap 1 the
        // call looked at the single nearest spot, found it taken, and the base
        // sat on two mexes all game.
        IUnitTask@ t = aiEconomyMgr.EnqueueMexWithin(u, u.GetPos(ai.frame),
            Global::RoleSettings::Tech::EcoMexExpandRadius, 0, true);
        if (t !is null) {
            IBuilderTask@ order = cast<IBuilderTask>(t);
            AIFloat3 at = u.GetPos(ai.frame);
            if (order !is null) at = order.GetBuildPos();
            GenericHelpers::LogUtil("[TECH][Build] " + u.circuitDef.GetName() + " " + u.id + " expands to a mex at ("
                + int(at.x) + ", " + int(at.z) + ") at +" + int(metalIncome) + " metal", 1);
        } else if (ai.frame - lastNoSpotLog > 60 * SECOND) {
            lastNoSpotLog = ai.frame;
            GenericHelpers::LogUtil("[TECH][Build] no open mex spot within " + int(Global::RoleSettings::Tech::EcoMexExpandRadius)
                + " of " + u.circuitDef.GetName() + " " + u.id + " at +" + int(metalIncome) + " metal", 1);
        }
        return t;
    }

    // Native's queued orders the script chooses to honour, nearest first.
    IUnitTask@ QueuedOrder(CCircuitUnit@ u)
    {
        array<int> types = {
            int(Task::BuildType::DEFENCE), int(Task::BuildType::RADAR), int(Task::BuildType::SONAR),
            int(Task::BuildType::REPAIR), int(Task::BuildType::BUNKER) };
        for (uint i = 0; i < types.length(); ++i) {
            IUnitTask@ t = aiBuilderMgr.FindQueuedTask(u, types[i]);
            if (t !is null) return t;
        }
        return null;
    }

    IUnitTask@ AssistAny(CCircuitUnit@ u, float radius)
    {
        CCircuitUnit@ target = aiBuilderMgr.FindUnfinishedNear(u.GetPos(ai.frame), radius, null);
        if (target is null) return null;
        return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::NORMAL, target, 60 * SECOND));
    }

    IUnitTask@ GuardFactory(CCircuitUnit@ u)
    {
        CCircuitUnit@ fac = Factory::primaryT1BotLab;
        if (fac is null || fac is u) return null;
        return GuardHelpers::AssignWorkerGuard(u, fac, Task::Priority::LOW, true, 20 * SECOND);
    }

    IUnitTask@ Planner(CCircuitUnit@ u, float metalIncome, float energyIncome)
    {
        const string key = EcoPlanner::Next(u, metalIncome, energyIncome);
        if (key.length() == 0) return null;
        IUnitTask@ redirect = RoleTech::Tech_RedirectEnergyToReactor("eco planner: " + key, u);
        if (redirect !is null) return redirect;
        return EcoPlanner::Execute(key, u);
    }

    // The role's strategic rungs (nukes, anti-nuke, gantry, water factories,
    // T2 constructor policy) as they stand; with no default task to fall
    // back to they return null when they have nothing.
    IUnitTask@ Strategic(CCircuitUnit@ u, float metalIncome, float energyIncome)
    {
        const CCircuitDef@ d = u.circuitDef;
        const int tier = UnitHelpers::GetConstructorTier(d);
        if (tier == 1) {
            if (UnitHelpers::IsAirConstructor(d))
                return RoleTech::Tech_T1AirConstructor_AiMakeTask(u, metalIncome, energyIncome, null);
            if (UnitHelpers::IsT1BotConstructor(d.GetName()))
                return RoleTech::Tech_T1BotConstructor_AiMakeTask(u, metalIncome, energyIncome, null);
            return null;
        }
        if (tier == 2) {
            const bool isEnergyFull = aiEconomyMgr.isEnergyFull;
            const bool energyLow = aiEconomyMgr.energy.current < aiEconomyMgr.energy.storage * Global::RoleSettings::Tech::EnergyStorageLowPercent;
            const float metalCurrent = aiEconomyMgr.metal.current;
            if (UnitHelpers::IsAirConstructor(d))
                return RoleTech::Tech_T2AirConstructor_AiMakeTask(u, isEnergyFull, metalIncome, energyIncome, metalCurrent, energyLow, null);
            if (UnitHelpers::IsT2BotConstructor(d.GetName()))
                return RoleTech::Tech_T2BotConstructor_AiMakeTask(u, isEnergyFull, metalIncome, energyIncome, metalCurrent, energyLow, null);
            if (UnitHelpers::IsFastAssistBot(d.GetName()))
                return RoleTech::Tech_T2FastAssistBotConstructor_AiMakeTask(u, isEnergyFull, metalIncome, energyIncome, metalCurrent, energyLow, null);
        }
        return null;
    }

    // ---------------------------------------------------------------- the sequence

    IUnitTask@ MakeTask(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null) return null;
        const CCircuitDef@ d = u.circuitDef;
        IUnitTask@ t;

        // Construction turrets (D-065).
        if (!d.IsMobile()) {
            @t = RoleTech::Tech_TurretAssist(u);
            if (t !is null) return t;
            @t = AssistAny(u, 0.0f + 700.0f);
            if (t !is null) return t;
            return Wait(5 * SECOND);
        }

        @t = KeepCurrent(u);
        if (t !is null) return t;

        const float metalIncome = Economy::GetMinMetalIncomeLast10s();
        const float energyIncome = Economy::GetMinEnergyIncomeLast10s();
        const bool isCommander = UnitHelpers::IsCommander(d);

        if (isCommander) {
            @t = RoleTech::Opening::MakeTask(u);
            if (t !is null) return t;
        }

        @t = StartFactory(u);
        if (t !is null) return t;

        if (!isCommander) {
            @t = ExpandMex(u, metalIncome);
            if (t !is null) return t;
        }

        @t = Planner(u, metalIncome, energyIncome);
        if (t !is null) return t;

        if (isCommander) {
            @t = RoleTech::Tech_Commander_AiMakeTask(u, null, metalIncome);
        } else {
            @t = Strategic(u, metalIncome, energyIncome);
        }
        if (t !is null) return t;

        @t = QueuedOrder(u);
        if (t !is null) return t;

        @t = AssistAny(u, Global::RoleSettings::Tech::ExpAssistRadius);
        if (t !is null) return t;

        @t = GuardFactory(u);
        if (t !is null) return t;

        return Wait(3 * SECOND);
    }
}

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
    dictionary keepTrace;
    IUnitTask@ KeepCurrent(CCircuitUnit@ u)
    {
        IBuilderTask@ cur = (u.task is null) ? null : cast<IBuilderTask>(u.task);
        const bool keep = (cur !is null && Task::BuildType(cur.GetBuildType()) < Task::BuildType::REPAIR);
        // diagnostic (D-070 benchmarks): what a re-asked builder holds, on change
        {
            const string sig = (u.task is null) ? "nothing" : (cur is null ? "a non-builder task" : ("build type " + int(cur.GetBuildType())
                + (cur.buildDef is null ? "" : " " + cur.buildDef.GetName()) + (keep ? " (kept)" : " (not kept)")));
            const string id = "" + u.id;
            string last; keepTrace.get(id, last);
            if (last != sig) { keepTrace.set(id, sig); GenericHelpers::LogUtil("[TECH][Keep] " + u.circuitDef.GetName() + " " + u.id + " asked holding " + sig, 3); }
        }
        if (keep) return u.task;
        return null;
    }

    // The first T1 bot lab is a throwaway (owner's rule: it is always
    // reclaimed once the advanced lab begins), so it goes where the commander
    // stands - the nearest buildable footprint within its build range -
    // rather than on the pair's planned slot, and no time is spent walking.
    // The footprint is reserved and the task pinned to it; once the lab
    // stands, an exit cone in front of it is held (Tick) until it is gone,
    // so nothing is packed where its units come out. A constructor building
    // the first lab (commander lost) takes the pair's reserved slot instead.
    int firstLabExitZone = 0;

    // Progressing into T2: the advanced lab is ordered, framed or standing.
    // No T1 lab is ordered from then on - the first one is being reclaimed
    // to pay for it (played: the commander rebuilt the T1 lab beside the
    // advanced lab's frame the moment the reclaim emptied the count).
    bool IntoT2()
    {
        CCircuitDef@ t2 = ai.GetCircuitDef(UnitHelpers::GetT2BotLabForSide(Global::AISettings::Side));
        if (t2 is null) return false;
        return t2.count > 0 || aiBuilderMgr.GetUnfinishedCount(t2) > 0
            || aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::FACTORY), t2) > 0;
    }

    IUnitTask@ StartFactory(CCircuitUnit@ u)
    {
        if (!RoleTech::Opening::complete || IntoT2()) return null;
        const string side = Global::AISettings::Side;
        CCircuitDef@ lab = ai.GetCircuitDef(UnitHelpers::GetT1BotLabForSide(side));
        if (lab is null || !u.circuitDef.CanBuild(lab)) return null;
        if (lab.count > 0 || aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::FACTORY), lab) > 0) return null;
        if (UnitHelpers::IsCommander(u.circuitDef) && Layout::HasComplex()) {
            const AIFloat3 at = u.GetPos(ai.frame);
            const int facing = Layout::facing;
            const float step = SQUARE_SIZE * 2;
            const int rings = int(Global::RoleSettings::Tech::ExpFirstLabRadius / step);
            // Never under the commander itself: a factory ordered on top of its
            // builder has its command dropped by the engine on every try (the
            // builder is in the way), which looked like a glitching commander.
            // The footprint's half-extent plus the commander's body, so the
            // nearest ring keeps the whole footprint clear of it.
            const float clear = float(lab.GetFootprintX() > lab.GetFootprintZ() ? lab.GetFootprintX() : lab.GetFootprintZ()) * 0.5f * step
                + Global::RoleSettings::Tech::ExpFirstLabClearance;
            const int firstRing = int(clear / step) + 1;
            for (int r = firstRing; r <= rings; ++r) {
                const int n = 8 * r;
                for (int k = 0; k < n; ++k) {
                    const float a = 6.2831853f * float(k) / float(n);
                    AIFloat3 p = AIFloat3(at.x + cos(a) * float(r) * step, 0.0f, at.z + sin(a) * float(r) * step);
                    if (!aiTerrainMgr.CanReserveBuilding(lab, p, facing)) continue;
                    const int id = aiTerrainMgr.ReserveBuilding(lab, p, facing, 0);
                    if (id < 0) continue;
                    p = aiTerrainMgr.GetReservationPos(id);
                    IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Factory(Task::Priority::NOW, lab, p, null, 0.0f, false, true, 300 * SECOND));
                    if (t is null) { aiTerrainMgr.ReleaseReservation(id); return null; }
                    if (!AiPinReservation(t, id)) GenericHelpers::LogUtil("[TECH][Build] could not pin the first lab to slot " + id, 1);
                    GenericHelpers::LogUtil("[TECH][Build] first lab at the commander: (" + int(p.x) + ", " + int(p.z) + "), "
                        + int(sqrt(MapHelpers::SqDist(p, at))) + " from it; the pair's slot stays planned", 1);
                    return t;
                }
            }
            GenericHelpers::LogUtil("[TECH][Build] no footprint for the first lab within " + int(Global::RoleSettings::Tech::ExpFirstLabRadius)
                + " of the commander; the pair's slot is used", 1);
        }
        IUnitTask@ t = Builder::EnqueueT1BotLab(side, Global::Map::StartPos, 0.0f, 300 * SECOND, Task::Priority::NOW);
        if (t !is null) GenericHelpers::LogUtil("[TECH][Build] start factory ordered on the reserved slot", 1);
        return t;
    }

    // From Tech_EconomyUpdate: the first lab's exit cone, held while it stands.
    void Tick()
    {
        if (!Global::RoleSettings::Tech::ExperimentalBuild) return;
        CCircuitUnit@ lab = Factory::primaryT1BotLab;
        if (firstLabExitZone == 0 && lab !is null && Layout::HasComplex()) {
            firstLabExitZone = aiTerrainMgr.ReserveExitCone(lab, 320.0f, 32.0f);
            if (firstLabExitZone > 0) GenericHelpers::LogUtil("[TECH][Build] first lab's exit held (zone " + firstLabExitZone + ") until it is reclaimed", 1);
        } else if (firstLabExitZone > 0 && lab is null) {
            aiTerrainMgr.ReleaseZone(firstLabExitZone);
            GenericHelpers::LogUtil("[TECH][Build] first lab gone: its exit (zone " + firstLabExitZone + ") released", 1);
            firstLabExitZone = 0;
        }
    }

    // The T1 bot lab is reclaimed the moment the advanced lab's frame exists
    // (owner's rule): every idle builder within `radius` of it joins the one
    // native reclaim task, turrets in reach put it before anything else
    // (Tech_TurretAssist), and the metal pays for the T2 lab.
    int t1LabReclaimId = -1;
    int reclaimDeferLog = -100000;

    IUnitTask@ ReclaimT1Lab(CCircuitUnit@ u, float radius)
    {
        CCircuitUnit@ lab = Factory::primaryT1BotLab;
        if (lab is null || lab is u) return null;
        CCircuitDef@ t2 = ai.GetCircuitDef(UnitHelpers::GetT2BotLabForSide(Global::AISettings::Side));
        if (t2 is null) return null;
        if (!IntoT2()) return null;   // not begun yet
        // D-072: reclaimed metal past the storage cap is lost, so the reclaim
        // waits until the bank has room for the lab's metal (the advanced lab's
        // build makes that room; it is part-built by then, as intended)
        {
            const float labMetal = (lab.circuitDef is null) ? 500.0f : lab.circuitDef.costM;
            if (aiEconomyMgr.metal.current + labMetal > aiEconomyMgr.metal.storage) {
                if (ai.frame - reclaimDeferLog > 30 * SECOND) {
                    reclaimDeferLog = ai.frame;
                    GenericHelpers::LogUtil("[TECH][Build] T1 lab reclaim deferred: metal " + int(aiEconomyMgr.metal.current) + " of "
                        + int(aiEconomyMgr.metal.storage) + " leaves no room for its " + int(labMetal), 1);
                }
                return null;
            }
        }
        if (MapHelpers::SqDist(u.GetPos(ai.frame), lab.GetPos(ai.frame)) > radius * radius) return null;
        IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, lab, 180 * SECOND));
        if (t !is null && t1LabReclaimId != lab.id) {
            t1LabReclaimId = lab.id;
            GenericHelpers::LogUtil("[TECH][Build] the advanced lab is under way: reclaiming the T1 bot lab " + lab.id
                + "; idle build power in range joins", 1);
        }
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

    // Native's queued orders the script chooses to honour: only the watchdog's
    // repairs of our own unfinished structures, nearest first and within
    // ExpOrderRadius of the base. Defence, radar and sonar orders native
    // queues on its own schedule are left alone (played: three junos, radars
    // 4,000 elmos out); TECH's base defence is the Defence rung below.
    IUnitTask@ QueuedOrder(CCircuitUnit@ u)
    {
        array<int> types = { int(Task::BuildType::REPAIR) };
        const AIFloat3 home = Layout::BaseCentre();
        const float radius = Global::RoleSettings::Tech::ExpOrderRadius;
        for (uint i = 0; i < types.length(); ++i) {
            IUnitTask@ t = aiBuilderMgr.FindQueuedTask(u, types[i]);
            if (t is null) continue;
            IBuilderTask@ bt = cast<IBuilderTask>(t);
            if (bt !is null) {
                const AIFloat3 at = bt.GetBuildPos();
                if (at.x >= 0.0f && MapHelpers::SqDist(at, home) > radius * radius) continue;
            }
            return t;
        }
        return null;
    }

    // Base defence (D-066 follow-up 9): once the first construction turret
    // stands, one light laser turret and one light AA turret near the
    // factories, packed by native nearest that anchor outside the planned
    // zones. Nothing more: TECH is a back-line role and the rest is the
    // team's.
    IUnitTask@ Defence(CCircuitUnit@ u)
    {
        if (aiBuilderMgr.GetStaticBuildPowerNear(Layout::BaseCentre(), Global::RoleSettings::Tech::EcoBuildPowerRadius) <= 0.0f)
            return null;   // the first turret first
        const string side = Global::AISettings::Side;
        array<string> names = { UnitHelpers::GetStaticLLTNameForSide(side), UnitHelpers::GetStaticAALightNameForSide(side) };
        array<int> wanted = { Global::RoleSettings::Tech::ExpDefenceLLT, Global::RoleSettings::Tech::ExpDefenceAA };
        for (uint i = 0; i < names.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(names[i]);
            if (def is null || !def.IsAvailable(ai.frame) || !u.circuitDef.CanBuild(def)) continue;
            if (def.count + aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::DEFENCE), def) >= wanted[i]) continue;
            AIFloat3 anchor = Layout::factoryCentre;
            if (anchor.x < 0.0f) anchor = Global::Map::StartPos;
            IUnitTask@ t = aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE, Task::Priority::NORMAL, def, anchor, 0.0f, true, 120 * SECOND));
            if (t !is null) GenericHelpers::LogUtil("[TECH][Build] base defence: " + names[i] + " near the factories", 1);
            return t;
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

    // The sequence is the rule table (roles/tech_rules.as, D-067); the
    // functions above are its acts. Never null: the table ends in "wait".
    IUnitTask@ MakeTask(CCircuitUnit@ u)
    {
        IUnitTask@ t = TechRules::Evaluate(u);
        if (t !is null) return t;
        return Wait(3 * SECOND);
    }
}

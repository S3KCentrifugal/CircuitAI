#include "air_build.as"

// Ordered, total dispatcher. Each action rechecks mutable claims before enqueue.
namespace AirRules {
    IUnitTask@ MakeTask(CCircuitUnit@ u)
    {
        if (u is null || u.circuitDef is null) return null;
        AirEconomy::Tick();
        IBuilderTask@ current = cast<IBuilderTask>(u.task);
        if (current !is null && current.GetBuildType() < int(Task::BuildType::REPAIR)) return u.task;
        const string side = UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        const bool commander = UnitHelpers::IsCommander(u.circuitDef);
        IUnitTask@ t = null;
        if (AirEconomy::recovery) {
            @t = AirBuild::Resume(u, true);
            if (t !is null) return AirBuild::Record(t, "recovery.resume", u);
            @t = AirBuild::Assist(u, true);
            if (t !is null) return AirBuild::Record(t, "recovery.assist", u);
            @t = AirBuild::Energy(u, true);
            if (t !is null) return AirBuild::Record(t, "recovery.energy", u);
        }
        @t = AirBuild::Resume(u);
        if (t !is null) return AirBuild::Record(t, "project.resume", u);
        // Home spots precede the starter. Recovery never repeats a paid opening.
        if (AirEconomy::t1 + AirEconomy::t2 == 0) {
            @t = aiEconomyMgr.EnqueueMexWithin(u, Global::Map::StartPos, 700.0f, 3, true);
            if (t !is null) return AirBuild::Record(t, "opening.mex", u);
            if (AirEconomy::energy < 80.0f) {
                @t = AirBuild::Energy(u, false);
                if (t !is null) return AirBuild::Record(t, "opening.energy", u);
            }
        }
        @t = AirBuild::Factory(u, false);
        if (t !is null) return AirBuild::Record(t, Team::Ferry::requestPending ? "transport.plant" : "opening.plant", u);
        // T2 builders, including gifts, upgrade mexes without requiring a T2 plant.
        CCircuitDef@ upgrade = ai.GetCircuitDef(UnitHelpers::GetT2MexNameForSide(side));
        if (AirEconomy::energy >= 350.0f && !AirEconomy::recovery && AirBuild::Can(u, upgrade)) {
            @t = EconomyHelpers::EnqueueMexUpgradeIfFirst(u, Global::Map::StartPos, 3500.0f, 1, "AIR");
            if (t !is null) return AirBuild::Record(t, "mex.upgrade", u);
        }
        if (!commander && AirEconomy::metal < 80.0f && aiEconomyMgr.GetMexTaskCountWithin(Global::Map::StartPos, 5000.0f) < 1) {
            @t = aiEconomyMgr.EnqueueMexWithin(u, u.GetPos(ai.frame), 2400.0f, 0, true);
            if (t !is null) return AirBuild::Record(t, "mex.expand", u);
        }
        // Affordable production support and the first wind buffer must not starve
        // behind an aspirational energy target that moves upward with mex income.
        @t = AirBuild::Nano(u);
        if (t !is null) return AirBuild::Record(t, "production.support", u);
        if (AirEconomy::energy >= 250.0f) {
            @t = AirBuild::Utility(u, UnitHelpers::GetEnergyStorageNameForSide(side), Task::BuildType::STORE, 1);
            if (t !is null) return AirBuild::Record(t, "storage.buffer", u);
        }
        // A funded first T2 package must not wait for the aspirational T1 energy
        // target to catch up with distant mex income. Transition checks its own
        // energy floor and reserves; later bays still follow ordinary growth.
        if (AirEconomy::t2 == 0) {
            @t = AirBuild::Factory(u, true);
            if (t !is null) return AirBuild::Record(t, "transition.bay", u);
        }
        // Production demand is a floor, plus energy for the next stage of T1 growth.
        const float targetE = AiMax(160.0f, AiMax(AirEconomy::metal * 45.0f, AirEconomy::demandE * 1.3f));
        if (AirEconomy::energy < targetE || AirEconomy::recovery) {
            @t = AirBuild::Assist(u, true);
            if (t !is null) return AirBuild::Record(t, "energy.assist", u);
            @t = AirBuild::Energy(u, AirEconomy::recovery);
            if (t !is null) return AirBuild::Record(t, "energy.grow", u);
        }
        @t = AirBuild::Utility(u, UnitHelpers::GetStaticRadarNameForSide(side), Task::BuildType::RADAR, 1);
        if (t !is null) return AirBuild::Record(t, "intel.radar", u);
        if (AirEconomy::EnemyAir() >= 500.0f && AirEconomy::bankM > 200.0f) {
            @t = AirBuild::Utility(u, UnitHelpers::GetStaticT2AAFlakNameForSide(side), Task::BuildType::DEFENCE, 2 + AirEconomy::t2);
            if (t !is null) return AirBuild::Record(t, "defence.flak", u);
        }
        if (AirEconomy::bankM > aiEconomyMgr.metal.storage * 0.85f && aiEconomyMgr.metal.storage < AirEconomy::metal * 60.0f) {
            @t = AirBuild::Utility(u, UnitHelpers::GetMetalStorageNameForSide(side), Task::BuildType::STORE, 4);
            if (t !is null) return AirBuild::Record(t, "storage.metal", u);
        }
        @t = AirBuild::Factory(u, true);
        if (t !is null) return AirBuild::Record(t, "production.bay", u);
        if (AirEconomy::energy > 250.0f && aiEconomyMgr.energy.storage < AirEconomy::energy * 10.0f) {
            @t = AirBuild::Utility(u, UnitHelpers::GetEnergyStorageNameForSide(side), Task::BuildType::STORE, AiMin(8, 1 + int(AirEconomy::energy / 2000.0f)));
            if (t !is null) return AirBuild::Record(t, "storage.energy", u);
        }
        if (!AirEconomy::recovery && AirEconomy::bankE > aiEconomyMgr.energy.storage * 0.85f && AirEconomy::bankM < aiEconomyMgr.metal.storage * 0.8f
            && AirEconomy::energy > AirEconomy::demandE * 1.25f + 150.0f) {
            CCircuitDef@ d = ai.GetCircuitDef(UnitHelpers::GetAdvEnergyConverterNameForSide(side));
            if (!AirBuild::Can(u, d)) @d = ai.GetCircuitDef(UnitHelpers::GetEnergyConverterNameForSide(side));
            if (d !is null && !AirBuild::Busy(d, Task::BuildType::CONVERT)) {
                @t = AirLayout::Place(u, d, Task::BuildType::CONVERT, Task::Priority::LOW);
                if (t !is null) return AirBuild::Record(t, "surplus.convert", u);
            }
        }
        // Native defence chain, repairs and sensors remain capabilities, explicitly admitted.
        array<int> services = { int(Task::BuildType::REPAIR), int(Task::BuildType::DEFENCE), int(Task::BuildType::RADAR) };
        for (uint i = 0; i < services.length(); ++i) {
            @t = aiBuilderMgr.FindQueuedTask(u, services[i]);
            if (t !is null) return AirBuild::Record(t, "service.queued", u);
        }
        @t = AirBuild::Assist(u);
        if (t !is null) return AirBuild::Record(t, "project.assist", u);
        // Short guard renewals keep the commander useful without starving economy rechecks.
        CCircuitUnit@ plant = Factory::primaryT1AirPlant;
        if (plant !is null && !Lifecycle::IsRetiring(plant)) {
            @t = GuardHelpers::AssignWorkerGuard(u, plant, Task::Priority::NORMAL, true, 5 * SECOND);
            if (t !is null) return AirBuild::Record(t, "production.assist", u);
        }
        return AirBuild::Record(aiBuilderMgr.Enqueue(TaskB::Wait(3 * SECOND)), "wait", u);
    }
}

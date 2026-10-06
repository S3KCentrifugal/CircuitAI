#include "sea_factories.as"
#include "../manager/sea_eco_layout.as"
#include "../manager/sea_expansion.as"

namespace SeaBuild {
    int lastTick=-1;
    dictionary supportRetry;
    int placementLog=-100000;
    IUnitTask@ Wait() { return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND)); }
    IUnitTask@ OpeningMex(CCircuitUnit@ u) {
        if (SeaExpansion::Active()) return SeaExpansion::Make(u);
        if (u is null || u !is Builder::primaryT1SeaConstructor || !SeaConstructor::IsT1(u.circuitDef)) return null;
        if (u.task !is null && (u.task.IsEnemyReclaim() || u.task.GetType()==int(Task::Type::PLAYER))) return u.task;
        IBuilderTask@ current=cast<IBuilderTask>(u.task);
        if (current !is null && !current.IsDead() && current.GetBuildType()<int(Task::BuildType::REPAIR)) return current;
        // A ship's safe reachability query rejects routes across land/other
        // ponds and accepts reachable coastal mexes. Native owns spot claims,
        // allied occupancy and duplicate orders; do not duplicate its scan.
        const AIFloat3 home=Factory::primaryT1Shipyard is null ? Global::Map::StartPos : Factory::primaryT1Shipyard.GetPos(ai.frame);
        IUnitTask@ task=aiEconomyMgr.EnqueueMexWithin(u,home,Global::RoleSettings::Sea::NearbyMexRadius,0,true);
        if (task !is null) {
            IBuilderTask@ mex=cast<IBuilderTask>(task);
            if (mex is null || mex.GetBuildType()!=int(Task::BuildType::MEX))
                Invariants::Violation("INV-150",""+u.id,"SEA opening mex priority returned non-mex work");
            GenericHelpers::LogUtil("[SEA][Mex] first ship="+u.id+" takes nearby metal",1);
        }
        return task;
    }
    IUnitTask@ Seaplane(CCircuitUnit@ u) {
        if (u is null || !u.circuitDef.IsMobile()) return null;
        const string side=UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        if (!SeaFactories::NeedSeaplane(side)) return null;
        CCircuitDef@ d=ai.GetCircuitDef(UnitHelpers::GetSeaplanePlatformNameForSide(side));
        if (!u.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame) || !SeaEconomy::SeaplaneReady(d)
            || !SeaEconomy::Fund(d,u.circuitDef.GetBuildSpeed(),0,0,
                Global::RoleSettings::Sea::SeaplaneMetalReserve,Global::RoleSettings::Sea::SeaplaneEnergyReserve)) return null;
        IUnitTask@ task=SeaLayout::Enabled() ? SeaLayout::Factory(u,d.GetName())
            : Builder::EnqueueSeaplanePlatform(side,Factory::GetT2ShipyardPos(),SQUARE_SIZE*24,600*SECOND);
        if (task !is null) {
            // The compact census resets admissions; with layouts explicitly
            // disabled native owns the order and its commitment accounting.
            if (SeaLayout::Enabled()) SeaEconomy::Admit(d,false,true);
            GenericHelpers::LogUtil("[SEA][Factory] post-T2 seaplane admitted "+d.GetName()
                +" minM="+Economy::GetMinMetalIncomeLast10s()+" minE="+Economy::GetMinEnergyIncomeLast10s()
                +" bankM="+aiEconomyMgr.metal.current+" bankE="+aiEconomyMgr.energy.current,1);
        }
        return task;
    }
    int SupportFootprint(CCircuitDef@ nano, const AIFloat3 &in centre, int stopAt=0) {
        if (nano is null) return 0;
        int count=0;
        // Placement-only query over reserved slots, never per-unit micro.
        // Include valid consumed slots: completed turrets still own footprint.
        for (uint p=0;p<SeaLayout::patches.length();++p) {
            SeaLayout::Patch@ patch=SeaLayout::patches[p];
            if (patch.name!=nano.GetName()) continue;
            for (uint s=0;s<patch.slots.length();++s) {
                const int state=aiTerrainMgr.GetReservationState(patch.slots[s]);
                if (state>=0 && state<4 && MapHelpers::SqDist(aiTerrainMgr.GetReservationPos(patch.slots[s]),centre)
                    <=nano.GetBuildDistance()*nano.GetBuildDistance()) {
                    ++count;
                    if (stopAt>0 && count>=stopAt) return count;
                }
            }
        }
        return count;
    }
    Task::BuildType PlacementKind(CCircuitDef@ d, int kind) {
        if (d is null) return Task::BuildType(kind);
        const string name=d.GetName(), side=UnitHelpers::GetSideForUnitName(name);
        if (name==UnitHelpers::GetT1NavalNanoNameForSide(side)) return Task::BuildType::NANO;
        if (name==UnitHelpers::GetTidalNameForSide(side) || name==UnitHelpers::GetNavalFusionNameForSide(side)) return Task::BuildType::ENERGY;
        if (SeaEcoLayout::Managed(d)) return Task::BuildType::CONVERT;
        return Task::BuildType(kind);
    }
    bool ControlledEconomy(CCircuitDef@ d) {
        if (d is null) return false;
        const string name=d.GetName(), side=UnitHelpers::GetSideForUnitName(name);
        return SeaEcoLayout::Managed(d) || name==UnitHelpers::GetTidalNameForSide(side)
            || name==UnitHelpers::GetT1NavalNanoNameForSide(side);
    }
    void Leave() {
        SeaCoast::Leave();
        SeaExpansion::Reset();
        SeaInvasion::Leave();
        SeaRecovery::Leave();
        SeaCombat::Leave();
        SeaEconomy::projects.resize(0); SeaFactories::draining.deleteAll();
        supportRetry.deleteAll();
        SeaEcoLayout::Reset();
        SeaLayout::Leave();
    }
    bool ReserveSupport(CCircuitDef@ nano, const AIFloat3 &in centre, int facing) {
        if (nano is null) return false;
        const int count=AiMax(1,AiMin(Global::RoleSettings::Sea::MaxSupportPerBerth,
            Global::RoleSettings::Sea::ReservedSupportPerFactory));
        const int have=SupportFootprint(nano,centre,count);
        if (have>=count) return false;
        const AIFloat3 rear=LayoutHelpers::Offset(centre,facing,0,-224.0f);
        SeaLayout::PlanPatch(nano,rear,count-have,300.0f,centre);
        return true; // one bounded search per tick, including failed attempts
    }
    void Tick() {
        if (!SeaLayout::Enabled() || ai.frame-lastTick<SECOND) return;
        lastTick=ai.frame; SeaEconomy::Tick(); SeaLayout::RefreshGeometry();
        if (SeaLayout::Active()) { SeaCombat::Tick(); SeaFactories::Tick(); }
        const string side=Global::AISettings::Side;
        CCircuitDef@ platform=ai.GetCircuitDef(UnitHelpers::GetSeaplanePlatformNameForSide(side));
        const bool planAir=Global::RoleSettings::Sea::SeaplanesAfterT2 && platform !is null && platform.IsAvailable(ai.frame);
        if (SeaLayout::Active()) {
            if (SeaLayout::berths.length()==0) SeaLayout::Add(UnitHelpers::GetT1ShipyardForSide(side),Global::Map::StartPos);
            if (SeaLayout::berths[0].slot>=0 && int(SeaLayout::berths.length())<Global::RoleSettings::Sea::PreplannedYards) {
                const string next=planAir && SeaLayout::berths.length()==2 ? platform.GetName() : UnitHelpers::GetT2ShipyardForSide(side);
                SeaLayout::Add(next,LayoutHelpers::Offset(SeaLayout::berths[0].centre,SeaLayout::facing,400.0f*float(SeaLayout::berths.length()),0));
            }
        } else if (SeaLayout::hadFactory && int(SeaLayout::berths.length())<AiMax(1,Global::RoleSettings::Sea::PreplannedYards-1)) {
            // Compact placement needs future harbors too. An unconstrained
            // opening can hug the map edge, leaving no rear capital-eco space.
            // Reserve forward sites now; production/income gates stay intact.
            const AIFloat3 harbor=SeaEcoLayout::Harbor();
            if (harbor.x>=0) {
                const AIFloat3 anchor=SeaLayout::berths.length()==0
                    ? LayoutHelpers::Offset(harbor,SeaLayout::facing,0,Global::RoleSettings::Sea::FirstPlannedHarborAdvance)
                    : LayoutHelpers::Offset(SeaLayout::berths[0].anchor,SeaLayout::facing,400.0f*float(SeaLayout::berths.length()),0);
                SeaLayout::Add(planAir && SeaLayout::berths.length()==1 ? platform.GetName() : UnitHelpers::GetT2ShipyardForSide(side),anchor);
            }
        }
        for (uint i=0; i<SeaLayout::berths.length(); ++i) {
            SeaLayout::Validate(SeaLayout::berths[i]);
            if (SeaLayout::berths[i].slot<0 && !SeaLayout::berths[i].active && !SeaLayout::berths[i].retired) { SeaLayout::Search(SeaLayout::berths[i]); break; }
        }
        // Reserve rear support before energy can consume the yard's build reach.
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NavalNanoNameForSide(side));
        if (nano !is null) for (uint b=0; b<SeaLayout::berths.length(); ++b) {
            SeaLayout::Berth@ berth=SeaLayout::berths[b]; if (berth.slot<0 || berth.retired) continue;
            if (ReserveSupport(nano,berth.centre,berth.facing)) break;
        }
        // Amphibious complexes and other naval production use the same support
        // banks without entering shipyard tech/replacement bookkeeping.
        for (uint i=0; i<SeaEconomy::productionFactories.length(); ++i) {
            CCircuitUnit@ factory=ai.GetTeamUnit(SeaEconomy::productionFactories[i]);
            if (factory is null) continue;
            // D-212 owns the coastal 6/12-pad footprint. Retrying the generic
            // 24-pad rectangle here every second duplicates that search and
            // often cannot fit the same coast. Income-based Support() below
            // remains available to add real build power above the initial pad.
            if (SeaInvasion::OwnsSupport(factory)) continue;
            if (ReserveSupport(nano,factory.GetPos(ai.frame),aiTerrainMgr.GetBuildingFacing(factory))) break;
        }
        SeaEcoLayout::Tick();
        // Preserve claimed pins while their builders approach the reserved site.
        for (uint i=0; i<SeaEconomy::owned.length(); ++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(SeaEconomy::owned[i]); if (u is null) continue;
            IBuilderTask@ t=cast<IBuilderTask>(u.task);
            // Native dormant chain links are deleted without a removed hook.
            // Inspect live unit ownership instead of retaining those pointers.
            if (t !is null && t.buildDef !is null && t.target is null && !SeaEconomy::OwnsTask(t)) {
                if (ControlledEconomy(t.buildDef) || UnitHelpers::IsSeaplanePlatform(t.buildDef.GetName()) || (SeaLayout::hadFactory && SeaEconomy::Yard(t.buildDef))) {
                    u.CmdStop(); aiBuilderMgr.AbortTask(t); continue;
                }
            }
            if (!SeaLayout::Active() || t is null || t.GetBuildType()!=int(Task::BuildType::GUARD)) continue;
            CCircuitUnit@ target=t.target;
            const bool productive=target !is null && !Lifecycle::IsRetiring(target)
                && (target.GetBuildProgress()<1 || SeaEconomy::Busy(target.id));
            if (!productive) { aiBuilderMgr.AssignTask(u,Wait()); u.CmdStop(); }
        }
        LayoutHelpers::CheckAlliedPlacements();
    }
    IUnitTask@ Place(CCircuitUnit@ u, const string &in name, Task::BuildType kind, int size=6) {
        CCircuitDef@ d=ai.GetCircuitDef(name);
        if (d is null || SeaEconomy::Pending(d)>=2) return null;
        if (SeaEcoLayout::Managed(d)) {
            IUnitTask@ packed=SeaEcoLayout::Place(u,d,kind);
            IBuilderTask@ order=cast<IBuilderTask>(packed);
            if (order !is null && order.buildDef is d) SeaEconomy::Admit(d,false,true);
            return packed;
        }
        AIFloat3 anchor=LayoutHelpers::Offset(Global::Map::StartPos,SeaLayout::facing,0,-350.0f);
        const AIFloat3 harbor=SeaEcoLayout::Harbor();
        if (harbor.x>=0) anchor=LayoutHelpers::Offset(harbor,SeaEcoLayout::direction,0,-350.0f);
        // A coastal commander can start far inland. Anchor naval economy to
        // the first usable harbor so construction ships can reach its modules.
        for (uint i=0; i<SeaLayout::berths.length(); ++i) {
            SeaLayout::Berth@ b=SeaLayout::berths[i];
            if (b.slot>=0 && !b.retired) { anchor=LayoutHelpers::Offset(b.centre,b.facing,0,-350.0f); break; }
        }
        IUnitTask@ t=SeaLayout::Place(u,d,kind,anchor,size);
        if (t !is null) SeaEconomy::Admit(d,false,true);
        return t;
    }
    IUnitTask@ Upgrade(CCircuitUnit@ u) {
        if (!SeaConstructor::IsT2(u.circuitDef)) return null;
        if (aiEconomyMgr.IsMetalMap()) return aiEconomyMgr.EnqueueFieldUpgrade(u,Global::Map::StartPos,2000.0f);
        const string side=UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        CCircuitDef@ d=ai.GetCircuitDef(side=="armada" ? "armuwmme" : side=="cortex" ? "coruwmme" : "leganavalmex");
        if (d is null || !d.IsAvailable(ai.frame) || !u.circuitDef.CanBuild(d)) return null;
        AIFloat3 p(-1,0,-1); float distance=2400.0f*2400.0f;
        for (uint i=0; i<SeaEconomy::owned.length(); ++i) {
            CCircuitUnit@ mex=ai.GetTeamUnit(SeaEconomy::owned[i]);
            if (mex is null || mex.GetBuildProgress()<1 || mex.circuitDef.GetExtractsMetal()<=0
                || mex.circuitDef.GetExtractsMetal()>=d.GetExtractsMetal()) continue;
            const AIFloat3 at=mex.GetPos(ai.frame);
            const float sq=MapHelpers::SqDist(at,u.GetPos(ai.frame));
            if (sq>=distance || Economy::MexTracker::AnyUpgradeInProgressNear(at,96.0f)
                || !aiTerrainMgr.CanUpgradeTerrain(d,at) || !aiTerrainMgr.CanReachAt(u,at,u.circuitDef.GetBuildDistance())) continue;
            distance=sq; p=at;
        }
        if (p.x<0) return null;
        return aiBuilderMgr.Enqueue(TaskB::Spot(Task::BuildType::MEXUP,Task::Priority::HIGH,d,p,-1));
    }
    IUnitTask@ Support(CCircuitUnit@ u) {
        const string side=UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NavalNanoNameForSide(side));
        if (nano is null || !u.circuitDef.CanBuild(nano) || !nano.IsAvailable(ai.frame)) return null;
        CCircuitUnit@ selected=null;
        float bestFill=1.0f, selectedLocal=0, selectedTarget=0;
        for (uint i=0; i<SeaEconomy::productionFactories.length(); ++i) {
            CCircuitUnit@ yard=ai.GetTeamUnit(SeaEconomy::productionFactories[i]);
            if (yard is null || yard.GetBuildProgress()<1 || SeaFactories::Hold(yard) || !SeaEconomy::Busy(yard.id)) continue;
            int64 retry=0;
            if (supportRetry.get(""+yard.id,retry) && ai.frame<retry) continue;
            CCircuitDef@ product=SeaEconomy::Product(yard.id);
            if (product is null || product.GetBuildTime()<=0) continue;
            const float local=SeaEconomy::LocalPower(yard);
            const float target=SeaEconomy::SupportTarget(yard,product);
            if (!SeaMath::SupportNeeded(target,local,yard.circuitDef.GetBuildSpeed(),nano.GetBuildSpeed(),
                Global::RoleSettings::Sea::MaxSupportPerBerth)) continue;
            const float fill=local/target;
            if (fill<bestFill) { @selected=yard; bestFill=fill; selectedLocal=local; selectedTarget=target; }
        }
        if (selected !is null) {
            CCircuitDef@ product=SeaEconomy::Product(selected.id);
            if (!SeaEconomy::Fund(nano,u.circuitDef.GetBuildSpeed(),nano.GetBuildSpeed()*product.costM/product.GetBuildTime(),
                nano.GetBuildSpeed()*product.costE/product.GetBuildTime())) return null;
            const int f=aiTerrainMgr.GetBuildingFacing(selected);
            const AIFloat3 anchor=LayoutHelpers::Offset(selected.GetPos(ai.frame),f,0,-224.0f);
            IUnitTask@ t=SeaLayout::Place(u,nano,Task::BuildType::NANO,anchor,6,300.0f,selected.GetPos(ai.frame));
            if (t !is null) {
                SeaEconomy::Admit(nano,true,true);
                IBuilderTask@ build=cast<IBuilderTask>(t);
                if (build is null || MapHelpers::SqDist(build.GetBuildPos(),selected.GetPos(ai.frame))>nano.GetBuildDistance()*nano.GetBuildDistance())
                    Invariants::Violation("INV-135",""+selected.id,"SEA support order cannot reach its production factory");
                GenericHelpers::LogUtil("[SEA][Support] factory="+selected.id+" name="+selected.circuitDef.GetName()
                    +" product="+product.GetName()+" local="+selectedLocal+" target="+selectedTarget,1);
                return t;
            }
            supportRetry.set(""+selected.id,int64(ai.frame+5*SECOND)); // blocked placement must not starve other factories
        }
        return null;
    }
    IUnitTask@ Assist(CCircuitUnit@ u) {
        CCircuitUnit@ reclaim=aiBuilderMgr.FindReclaimTargetFor(u);
        if (reclaim !is null) return aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH,reclaim,30*SECOND));
        const float radius=u.circuitDef.IsMobile() ? 800.0f : u.circuitDef.GetBuildDistance();
        CCircuitUnit@ target=aiBuilderMgr.FindUnfinishedNear(u.GetPos(ai.frame),radius,null);
        if (target !is null && !Lifecycle::IsRetiring(target)
            && aiTerrainMgr.CanReachAt(u,target.GetPos(ai.frame),u.circuitDef.GetBuildDistance()))
            return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::NORMAL,target,30*SECOND));
        for (uint i=0; i<SeaEconomy::productionFactories.length(); ++i) {
            CCircuitUnit@ yard=ai.GetTeamUnit(SeaEconomy::productionFactories[i]);
            if (yard is null || SeaFactories::Hold(yard) || !SeaEconomy::Busy(yard.id)) continue;
            const float reach=u.circuitDef.GetBuildDistance();
            if (MapHelpers::SqDist(yard.GetPos(ai.frame),u.GetPos(ai.frame))>reach*reach) continue;
            return GuardHelpers::AssignWorkerGuard(u,yard,Task::Priority::LOW,true,10*SECOND);
        }
        return null;
    }
    IUnitTask@ CapitalAssist(CCircuitUnit@ u) {
        if (!SeaConstructor::IsT1(u.circuitDef) && !UnitHelpers::IsCommander(u.circuitDef)) return null;
        // Finish a funded tech investment with nearby existing power. T2
        // constructors retain mex-upgrade ownership, and the expansion ship
        // stays available to take metal. No extra workforce is purchased here.
        if (u.id==SeaEconomy::mexWorker || aiEconomyMgr.metal.current<aiEconomyMgr.metal.storage*.35f
            || aiEconomyMgr.energy.current<aiEconomyMgr.energy.storage*.35f) return null;
        const string side=UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        const string fusion=UnitHelpers::GetNavalFusionNameForSide(side);
        CCircuitUnit@ target=null; float distance=Global::RoleSettings::Sea::CapitalAssistRadius*Global::RoleSettings::Sea::CapitalAssistRadius;
        for (uint i=0;i<SeaEconomy::owned.length();++i) {
            CCircuitUnit@ candidate=ai.GetTeamUnit(SeaEconomy::owned[i]);
            if (candidate is null || candidate.GetBuildProgress()>=1 || Lifecycle::IsRetiring(candidate)
                || (!UnitHelpers::IsT2Shipyard(candidate.circuitDef.GetName()) && candidate.circuitDef.GetName()!=fusion)) continue;
            const float sq=MapHelpers::SqDist(u.GetPos(ai.frame),candidate.GetPos(ai.frame));
            if (sq<distance && aiTerrainMgr.CanReachAt(u,candidate.GetPos(ai.frame),u.circuitDef.GetBuildDistance())) { @target=candidate; distance=sq; }
        }
        if (target is null) return null;
        int assigned=0;
        for (uint i=0;i<SeaEconomy::owned.length();++i) {
            CCircuitUnit@ worker=ai.GetTeamUnit(SeaEconomy::owned[i]); if (worker is null) continue;
            IBuilderTask@ task=cast<IBuilderTask>(worker.task);
            if (task !is null && task.target is target) {
                if (worker is u) return task;
                ++assigned;
            }
        }
        if (assigned>=Global::RoleSettings::Sea::CapitalAssistWorkers) return null;
        const float power=u.circuitDef.GetBuildSpeed(), horizon=Global::RoleSettings::Sea::WorkforceHorizon;
        const float m=BuildPowerMath::Room(aiEconomyMgr.metal.current,0,aiEconomyMgr.metal.income,TeamEconomy::OwnMetal(TeamEconomy::USAGE),0,horizon);
        const float e=BuildPowerMath::Room(aiEconomyMgr.energy.current,0,aiEconomyMgr.energy.income,TeamEconomy::OwnEnergy(TeamEconomy::USAGE),0,horizon);
        if (m<power*target.circuitDef.costM/target.circuitDef.GetBuildTime()
            || e<power*target.circuitDef.costE/target.circuitDef.GetBuildTime()) return null;
        return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH,target,60*SECOND));
    }
    IUnitTask@ NativeTask(CCircuitUnit@ u) {
        // Reuse native path-cost expansion, reclaim, geo, storage, defence and
        // auxiliary factories. Only controlled structures are re-planned here.
        aiBuilderMgr.experimentalBuild=false;
        IUnitTask@ task=aiBuilderMgr.DefaultMakeTask(u);
        aiBuilderMgr.experimentalBuild=true;
        IBuilderTask@ build=cast<IBuilderTask>(task);
        if (build is null || build.buildDef is null || build.target !is null || SeaEconomy::OwnsTask(task)) return task;
        const Task::BuildType kind=PlacementKind(build.buildDef,build.GetBuildType());
        CCircuitDef@ def=build.buildDef;
        const bool controlled=kind==Task::BuildType::ENERGY || kind==Task::BuildType::CONVERT || kind==Task::BuildType::NANO
            || (kind==Task::BuildType::FACTORY && (SeaEconomy::Yard(def) || UnitHelpers::IsSeaplanePlatform(def.GetName()) || !SeaFactories::FactoryAllowed(def)));
        if (!controlled) return task;
        // Never abandon another worker's order. Native queued work is adopted
        // only when this call is its sole prospective assignee.
        if (build.GetUnits().length()>0) return task;
        aiBuilderMgr.AbortTask(task);
        if (kind==Task::BuildType::FACTORY) {
            if (SeaInvasion::Active() && SeaInvasion::Factory(def)) return SeaInvasion::Build(u);
            if (UnitHelpers::IsT2Shipyard(def.GetName()) && !SeaEconomy::TechReady(def)) return null;
            return SeaLayout::Factory(u,def.GetName());
        }
        if (kind==Task::BuildType::NANO) return Support(u);
        if (kind==Task::BuildType::CONVERT && aiEconomyMgr.IsMetalMap()) return null;
        return Place(u,def.GetName(),kind,6);
    }
    IUnitTask@ Resume(CCircuitUnit@ u) {
        const array<int> kinds={int(Task::BuildType::FACTORY),int(Task::BuildType::ENERGY),int(Task::BuildType::NANO),int(Task::BuildType::CONVERT)};
        for (uint i=0; i<kinds.length(); ++i) {
            IUnitTask@ task=aiBuilderMgr.FindQueuedTask(u,kinds[i]);
            if (task !is null && SeaEconomy::OwnsTask(task)) return task;
        }
        return null;
    }
    // Keep normal SEA decisions, but use one owner for economy placement.
    IUnitTask@ LegacyTask(CCircuitUnit@ u) {
        if (u is null) return null;
        SeaEconomy::Tick();
        if (u.task !is null && (u.task.IsEnemyReclaim() || u.task.GetType()==int(Task::Type::PLAYER))) return u.task;
        IBuilderTask@ current=cast<IBuilderTask>(u.task);
        if (current !is null && !current.IsDead() && current.GetBuildType()<int(Task::BuildType::REPAIR)
            && (current.target !is null || SeaEconomy::OwnsTask(current))) return current;
        if (!u.circuitDef.IsMobile()) { IUnitTask@ help=Assist(u); return help is null ? Wait() : help; }
        IUnitTask@ task=Seaplane(u); if (task !is null) return task;
        @task=SeaEcoLayout::Support(u); if (task !is null) return task;
        // Leave the commander and one construction ship on native expansion.
        // Other T1 ships can spend funded surplus on useful factory power.
        if (SeaConstructor::IsT1(u.circuitDef) && u.id!=SeaEconomy::mexWorker) {
            @task=Support(u); if (task !is null) return task;
        }
        return LayoutTask(u,RoleSea::Sea_LegacyBuilderTask(u));
    }
    // Also applied to the shared manager's native fallback, which runs after
    // a role returns null. Keep null as null so normal expansion can continue.
    IUnitTask@ LayoutTask(CCircuitUnit@ u, IUnitTask@ task) {
        IBuilderTask@ build=cast<IBuilderTask>(task);
        if (build is null || build.buildDef is null || build.target !is null || SeaEconomy::OwnsTask(task)) return task;
        const Task::BuildType kind=PlacementKind(build.buildDef,build.GetBuildType());
        if (kind==Task::BuildType::FACTORY && SeaInvasion::Active() && SeaInvasion::Factory(build.buildDef)) {
            // The invasion controller is the only admission/placement owner.
            // Its pinned tasks returned above are already accounted for.
            if (build.GetUnits().length()>0) return task;
            aiBuilderMgr.AbortTask(task);
            IUnitTask@ invasion=SeaInvasion::Build(u);
            return invasion is null ? Wait() : invasion;
        }
        if (kind==Task::BuildType::FACTORY && !SeaFactories::FactoryAllowed(build.buildDef)) {
            // Do not cancel a structure that another builder already started.
            array<CCircuitUnit@>@ workers=build.GetUnits();
            for (uint i=0;i<workers.length();++i) if (workers[i] !is null) workers[i].CmdStop();
            aiBuilderMgr.AbortTask(task);
            IUnitTask@ platform=Seaplane(u); return platform is null ? Wait() : platform;
        }
        // Coastal commanders still need land energy and normal mex expansion.
        // Only naval buildings belong to this water layout.
        const bool yard=SeaEconomy::Yard(build.buildDef) || UnitHelpers::IsSeaplanePlatform(build.buildDef.GetName());
        SeaLayout::RefreshGeometry();
        if (SeaEconomy::Yard(build.buildDef) && !SeaLayout::hadFactory) return task; // opening exception, still honors allied native reservations
        if (!ControlledEconomy(build.buildDef) && !yard) return task;
        const string name=build.buildDef.GetName();
        array<CCircuitUnit@>@ workers=build.GetUnits();
        for (uint i=0;i<workers.length();++i) if (workers[i] !is null) workers[i].CmdStop();
        aiBuilderMgr.AbortTask(task);
        @task=yard ? SeaLayout::Factory(u,name) : kind==Task::BuildType::NANO ? Support(u) : Place(u,name,kind);
        if (task is null && ai.frame-placementLog>30*SECOND) {
            placementLog=ai.frame;
            CCircuitDef@ definition=ai.GetCircuitDef(name);
            GenericHelpers::LogUtil("[SEA][Placement] deferred "+name+" builder="+u.circuitDef.GetName()+" available="+definition.IsAvailable(ai.frame)
                +" pending="+SeaEconomy::Pending(definition)+" projects="+SeaEconomy::projects.length(),1);
        }
        return task is null ? Wait() : task;
    }
    IUnitTask@ MakeTask(CCircuitUnit@ u) {
        if (u is null) return null;
        SeaEconomy::Tick();
        if (u.task !is null && (u.task.IsEnemyReclaim() || u.task.GetType()==int(Task::Type::PLAYER))) return u.task;
        IBuilderTask@ current=cast<IBuilderTask>(u.task);
        if (current !is null && !current.IsDead() && current.GetBuildType()<int(Task::BuildType::REPAIR)) return current;
        if (!u.circuitDef.IsMobile()) { IUnitTask@ t=Assist(u); return t is null ? Wait() : t; }
        IUnitTask@ queued=Resume(u); if (queued !is null) return queued;
        @queued=Seaplane(u); if (queued !is null) return queued;
        @queued=SeaEcoLayout::Support(u); if (queued !is null) return queued;
        @queued=CapitalAssist(u); if (queued !is null) return queued;
        const string side=UnitHelpers::GetSideForUnitName(u.circuitDef.GetName());
        CCircuitDef@ t1=ai.GetCircuitDef(UnitHelpers::GetT1ShipyardForSide(side));
        CCircuitDef@ t2=ai.GetCircuitDef(UnitHelpers::GetT2ShipyardForSide(side));
        const float mi=aiEconomyMgr.metal.income, ei=aiEconomyMgr.energy.income;
        const bool empty=SeaEconomy::Have(t1)+SeaEconomy::Have(t2)==0;
        IUnitTask@ t=null;
        if (empty && mi<5.0f) @t=aiEconomyMgr.EnqueueMexWithin(u,Global::Map::StartPos,1000.0f,3,true);
        if (t !is null) return t;
        if (empty && t1 !is null) { @t=SeaLayout::Factory(u,t1.GetName()); if (t !is null) return t; }
        // Energy expansion must not indefinitely postpone useful local power
        // while both banks fill. These turrets can help nearby energy frames
        // as well as the yard; Support still checks actual two-resource funding.
        if (!empty && aiEconomyMgr.metal.current>aiEconomyMgr.metal.storage*.5f
            && aiEconomyMgr.energy.current>aiEconomyMgr.energy.storage*.5f
            && ei>TeamEconomy::OwnEnergy(TeamEconomy::USAGE)*1.1f) {
            @t=Support(u); if (t !is null) return t;
        }
        // Factory pull can greatly exceed available income. Keep one expanding
        // ship while the other workers grow reliable energy toward the T2 gate.
        if (SeaConstructor::IsT1(u.circuitDef) && u.id!=SeaEconomy::mexWorker
            && ei<AiMin(Global::RoleSettings::Sea::TidalEnergyIncomeMinimum,mi*Global::RoleSettings::Sea::EnergyPerMetal)) {
            @t=Place(u,UnitHelpers::GetTidalNameForSide(side),Task::BuildType::ENERGY);
            if (t !is null) return t;
        }
        // The dedicated expansion ship must try reachable safe metal before
        // native discretionary tasks can assign it a repair or factory guard.
        if (!empty && u.id==SeaEconomy::mexWorker) {
            @t=aiEconomyMgr.EnqueueMexWithin(u,u.GetPos(ai.frame),2400.0f,0,true);
            if (t !is null) return t;
        }
        if (UnitHelpers::IsCommander(u.circuitDef) && !empty && SeaEconomy::Number(SeaEconomy::Constructor(side,false),true)>=2) {
            @t=NativeTask(u); if (t !is null) return t;
        }
        const bool energyLow=aiEconomyMgr.energy.current<aiEconomyMgr.energy.storage*.45f && ei<aiEconomyMgr.energy.pull*1.1f;
        if (!empty && UnitHelpers::IsCommander(u.circuitDef) && SeaEconomy::Number(SeaEconomy::Constructor(side,false),true)<2 && !energyLow) {
            @t=Assist(u); if (t !is null) return t;
        }
        if (energyLow) {
            CCircuitDef@ fus=ai.GetCircuitDef(UnitHelpers::GetNavalFusionNameForSide(side));
            if (fus !is null && u.circuitDef.CanBuild(fus) && mi>=30 && SeaEconomy::Pending(fus)+aiBuilderMgr.GetUnfinishedCount(fus)==0)
                @t=Place(u,fus.GetName(),Task::BuildType::ENERGY,2);
            if (t is null) @t=Place(u,UnitHelpers::GetTidalNameForSide(side),Task::BuildType::ENERGY);
            if (t !is null) return t;
        }
        // A selected, protected relocation must reach an actual builder before
        // native discretionary expansion can claim every free constructor.
        for (uint i=0; i<SeaLayout::berths.length(); ++i) {
            SeaLayout::Berth@ b=SeaLayout::berths[i]; if (b.oldUnit<0) continue;
            CCircuitUnit@ old=ai.GetTeamUnit(b.oldUnit);
            if (old !is null && Lifecycle::IsRetiring(old) && aiTerrainMgr.CanReachAt(u,old.GetPos(ai.frame),u.circuitDef.GetBuildDistance()))
                return aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH,old,120*SECOND));
            if (!b.active && SeaFactories::Safe(b.anchor)) { @t=SeaLayout::Factory(u,b.name,b.oldUnit,b.anchor); if (t !is null) return t; }
        }
        @t=Upgrade(u); if (t !is null) return t;
        if (SeaConstructor::IsT2(u.circuitDef) && mi>=Global::RoleSettings::Sea::MinimumMetalIncomeForFUS
            && ei<mi*Global::RoleSettings::Sea::EnergyPerMetal) {
            CCircuitDef@ reactor=ai.GetCircuitDef(UnitHelpers::GetNavalFusionNameForSide(side));
            if (reactor !is null && SeaEconomy::Pending(reactor)+aiBuilderMgr.GetUnfinishedCount(reactor)==0) {
                @t=Place(u,reactor.GetName(),Task::BuildType::ENERGY,2); if (t !is null) return t;
            }
        }
        if (!empty && t2 !is null && SeaEconomy::Have(t2)==0 && SeaEconomy::TechReady(t2)) {
            @t=SeaLayout::Factory(u,t2.GetName()); if (t !is null) { SeaEconomy::Admit(t2,false,true); return t; }
        }
        if (u.id==SeaEconomy::mexWorker || UnitHelpers::IsCommander(u.circuitDef)) {
            @t=aiEconomyMgr.EnqueueMexWithin(u,u.id==SeaEconomy::mexWorker ? u.GetPos(ai.frame) : Global::Map::StartPos,
                u.id==SeaEconomy::mexWorker ? 2400.0f : 1000.0f,0,true);
            if (t !is null) return t;
        }
        if (SeaConstructor::IsT1(u.circuitDef)) {
            @t=RoleSea::Sea_TryHandleObjective(u,u.GetPos(ai.frame),side,mi,ei);
            if (t !is null) return t;
        }
        @t=Support(u); if (t !is null) return t;
        // Existing threat-driven tasks retain native placement, which observes
        // the same allied reservations and exit corridors as the new planner.
        const array<int> kinds={int(Task::BuildType::DEFENCE),int(Task::BuildType::SONAR),int(Task::BuildType::RADAR),
            int(Task::BuildType::BUNKER),int(Task::BuildType::GEO),int(Task::BuildType::GEOUP),int(Task::BuildType::REPAIR)};
        for (uint i=0; i<kinds.length(); ++i) { @t=aiBuilderMgr.FindQueuedTask(u,kinds[i]); if (t !is null) return t; }
        if (!aiEconomyMgr.IsMetalMap() && !energyLow && aiEconomyMgr.energy.current>aiEconomyMgr.energy.storage*.85f) {
            const string convert=SeaConstructor::IsT2(u.circuitDef) ? UnitHelpers::GetAdvNavalEnergyConverterNameForSide(side) : UnitHelpers::GetNavalEnergyConverterNameForSide(side);
            CCircuitDef@ d=ai.GetCircuitDef(convert);
            if (d !is null && ei>aiEconomyMgr.energy.pull+aiEconomyMgr.GetEnergyUse(d)*.75f) @t=Place(u,convert,Task::BuildType::CONVERT,6);
            if (t !is null) return t;
        }
        @t=NativeTask(u); if (t !is null) return t;
        @t=Place(u,UnitHelpers::GetTidalNameForSide(side),Task::BuildType::ENERGY);
        if (t !is null) return t;
        @t=Assist(u); return t is null ? Wait() : t;
    }
}

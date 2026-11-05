#include "../../helpers/math/front_factory_math.as"

namespace FrontFactorySupport {
    int frame=-SECOND;
    // B7: assigned[j] is the target id for turrets[j] (-1: none). Both arrays
    // change together: any turret add/remove forces the next snapshot.
    array<int> assigned;
    array<int> turrets;
    bool loaded=false;
    void Reset() {
        loaded=false;frame=-SECOND;turrets.resize(0);assigned.resize(0);
    }
    void Added(CCircuitUnit@ unit) {
        if(unit is null || unit.circuitDef.IsMobile() || unit.circuitDef.GetBuildDistance()<=0.f
            || unit.circuitDef.GetName()!=UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side)) return;
        if(turrets.find(unit.id)<0) { turrets.insertLast(unit.id);turrets.sortAsc();frame=-SECOND; }
    }
    void Removed(CCircuitUnit@ unit) {
        if(unit is null) return;
        FrontLayout::Removed(unit);
        if(unit.id==factories[0] || unit.id==factories[1]) frame=-SECOND;
        const int index=turrets.find(unit.id);
        if(index>=0) {turrets.removeAt(index);frame=-SECOND;}
        const int far=farIds.find(unit.id);
        if(far>=0) {farIds.removeAt(far);farSince.removeAt(far);}
    }
    // D-468, INV-252: a turret never holds a repair order on a target outside
    // its reach for TurretRepairReachGraceSeconds (played: FRONT's factory
    // turrets stood on a T1 constructor that had walked away). Native
    // CSRepairTask releases them; this watches that it does. Runs inside the
    // once-a-second census, O(turrets with an out-of-reach target).
    array<int> farIds,farSince;
    void CheckReach(CCircuitUnit@ turret) {
        IBuilderTask@ task=cast<IBuilderTask>(turret.task);
        CCircuitUnit@ target=(task is null || task.IsDead()
            || task.GetBuildType()!=int(Task::BuildType::REPAIR))?null:task.target;
        bool far=false;
        if(target !is null) {
            // GetModelRadius is registered non-const: resolve the mutable def.
            CCircuitDef@ targetDef=ai.GetCircuitDef(target.circuitDef.GetName());
            const float reach=turret.circuitDef.GetBuildDistance()+(targetDef is null?0.f:targetDef.GetModelRadius());
            far=MapHelpers::SqDist(turret.GetPos(ai.frame),target.GetPos(ai.frame))>reach*reach;
        }
        const int index=farIds.find(turret.id);
        if(!far) {
            if(index>=0) {farIds.removeAt(index);farSince.removeAt(index);}
            return;
        }
        if(index<0) {farIds.insertLast(turret.id);farSince.insertLast(ai.frame);return;}
        if(ai.frame-farSince[index]<int(Global::RoleSettings::Front::TurretRepairReachGraceSeconds*SECOND)) return;
        Invariants::Violation("INV-252","front-turret-"+turret.id,"construction turret "+turret.id+" has held a repair order on "
            +target.circuitDef.GetName()+" "+target.id+" out of its reach for "+((ai.frame-farSince[index])/SECOND)+" s");
    }
    void Load() {
        if(loaded) return;
        loaded=true;
        array<Id>@ owned=ai.GetOwnedUnitIds();
        for(uint i=0;i<owned.length();++i) {
            CCircuitUnit@ unit=ai.GetTeamUnit(owned[i]);
            Added(unit);
            FrontLayout::Adopt(unit);
        }
    }
    array<int> targets={-1,-1};
    array<int> factories={-1,-1};
    array<float> deficits={0.f,0.f};
    array<AIFloat3> positions(2);
    array<uint> reachMasks;
    array<float> powers;
    array<int> owners;
    array<float> fundedTargets={0.f,0.f};
    FrontFactoryMath::Budget budget;

    bool Active() {
        return Global::AISettings::Role==AiRole::FRONT
            && Global::RoleSettings::Front::FactoryLayoutsEnabled
            && (aiTerrainMgr.HasLayoutGroup(FrontLayout::ROOT+".t1.factory") || FrontLayout::Factory(0) !is null);
    }
    void ReadFactory(uint i,FrontFactoryMath::Budget& inout resources) {
            targets[i]=-1;factories[i]=-1;deficits[i]=0.f;fundedTargets[i]=0.f;
            CCircuitUnit@ factory=FrontLayout::Factory(i);
            if(factory is null) return;
            factories[i]=factory.id;
            IBuilderTask@ production=cast<IBuilderTask>(factory.task);
            const CCircuitDef@ product=null;
            if(factory.GetBuildProgress()<1.f) {
                @product=factory.circuitDef;targets[i]=factory.id;
            } else if(production !is null && factory.task.GetType()==int(Task::Type::FACTORY)) {
                @product=production.buildDef;
                if(production.target !is null) targets[i]=production.target.id;
            }
            if(product is null) return;
            CCircuitUnit@ target=targets[i]<0?null:ai.GetTeamUnit(targets[i]);
            positions[i]=target is null?factory.GetPos(ai.frame):target.GetPos(ai.frame);
            const float share=i==0?FrontFactoryMath::FirstShare(FrontLayout::Factory(1) !is null,
                Global::RoleSettings::Front::FactoryT1BudgetShare):1.f;
            const float funded=FrontFactoryMath::FundedPower(product.GetBuildTime(),product.costM,product.costE,resources.metal*share,resources.energy*share);
            fundedTargets[i]=funded;
            const float nativePower=factory.GetBuildProgress()<1.f?0.f:factory.circuitDef.GetBuildSpeed();
            deficits[i]=FrontFactoryMath::SupportDemand(funded,nativePower);
            // Reserve the first factory's allocation once, including native BP.
            if(i==0 && product.GetBuildTime()>0.f) {
                resources.metal=AiMax(0.f,resources.metal-funded*product.costM/product.GetBuildTime());
                resources.energy=AiMax(0.f,resources.energy-funded*product.costE/product.GetBuildTime());
            }
    }
    void ReadTurrets() {
        // One bootstrap census on activation/load, then lifecycle-maintained IDs.
        // Includes ordinary fallback turrets: counting only slots would request
        // endless replacements for useful support built outside reservations.
        // O(T) per shared second; IDs are deterministic, each turret counted once.
        reachMasks.resize(turrets.length());powers.resize(turrets.length());
        for(uint j=0;j<turrets.length();++j) {
                reachMasks[j]=0;powers[j]=0.f;
                CCircuitUnit@ turret=ai.GetTeamUnit(turrets[j]);
                if(turret is null || turret.GetBuildProgress()<1.f) continue;
                CheckReach(turret);
                if(turret.task !is null && (turret.task.IsExternalControlled() || turret.task.IsEnemyReclaim()
                    || turret.task.GetType()==int(Task::Type::PLAYER)
                    || turret.task.GetType()==int(Task::Type::RETREAT))) continue;
                if(HasOtherWork(turret)) continue;
                const float reach=turret.circuitDef.GetBuildDistance();
                const AIFloat3 here=turret.GetPos(ai.frame);
                if(fundedTargets[0]>0.f && MapHelpers::SqDist(here,positions[0])<=reach*reach) reachMasks[j]|=1;
                if(fundedTargets[1]>0.f && MapHelpers::SqDist(here,positions[1])<=reach*reach) reachMasks[j]|=2;
                powers[j]=turret.circuitDef.GetBuildSpeed();
        }
    }
    bool HasOtherWork(CCircuitUnit@ unit) {
        IBuilderTask@ task=cast<IBuilderTask>(unit.task);
        return task !is null && !task.IsDead() && task.target !is null
            && task.target.id!=targets[0] && task.target.id!=targets[1];
    }
    void Allocate() {
        // Exclusive coverage first: a shared turret must not take T1's work
        // while an otherwise unusable T1-only turret could do it. Two linear
        // passes reuse snapshot buffers; no per-worker population scan.
        FrontFactoryMath::Allocate(reachMasks,powers,deficits,owners);
        assigned.resize(turrets.length());
        for(uint j=0;j<turrets.length();++j) {
            const int owner=owners[j];
            assigned[j]=(owner>=0 && targets[owner]>=0)?targets[owner]:-1;
        }
    }
    void PublishState() {
        CCircuitUnit@ first=ai.GetTeamUnit(factories[0]);
        CCircuitUnit@ second=ai.GetTeamUnit(factories[1]);
        const bool full=first !is null && second !is null && first.GetBuildProgress()>=1.f
            && second.GetBuildProgress()>=1.f && targets[0]>=0 && targets[1]>=0
            && fundedTargets[0]>0.f && fundedTargets[1]>0.f
            && deficits[0]<=0.f && deficits[1]<=0.f;
        const int reserved=aiTerrainMgr.GetReservationState(aiTerrainMgr.GetLayoutInt(FrontLayout::ROOT+".t2_slot",-1));
        const bool extension=second !is null || (reserved>=0 && reserved<4);
        const int state=full?3:(extension?2:1);
        if(aiTerrainMgr.GetLayoutInt(FrontLayout::ROOT+".state",0)!=state) {
            aiTerrainMgr.SetLayoutInt(FrontLayout::ROOT+".state",state);
            GenericHelpers::LogUtil("[FrontLayout] support state="+state+" T1 deficit="+deficits[0]+" T2 deficit="+deficits[1],1);
        }
    }
    void Snapshot() {
        Load();
        if(ai.frame<frame+SECOND) return;
        frame=ai.frame;
        budget.metal=Economy::GetMinMetalIncomeLast10s()*Global::RoleSettings::Front::FactoryProductionBudgetShare;
        budget.energy=Economy::GetMinEnergyIncomeLast10s()*Global::RoleSettings::Front::FactoryProductionBudgetShare;
        for(uint i=0;i<2;++i) ReadFactory(i,budget);
        ReadTurrets();
        Allocate();
        PublishState();
    }
    CCircuitUnit@ FactoryNeedingSupport() {
        Snapshot();
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if(nano is null || aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::NANO),nano)>0) return null;
        for(uint i=0;i<2;++i) if(deficits[i]>0.f && factories[i]>=0) {
            CCircuitUnit@ factory=ai.GetTeamUnit(factories[i]);
            if(factory !is null && factory.GetBuildProgress()>=1.f) return factory;
        }
        // Other production domains retain their original support policy; taking
        // admission ownership must not starve gantries or additional factories.
        return Factory::SelectFactoryNeedingNano(factories[0],factories[1]);
    }
    bool OwnsFactory(CCircuitUnit@ unit) {
        return unit !is null && (unit.id==factories[0] || unit.id==factories[1]);
    }
    IUnitTask@ Assist(CCircuitUnit@ u,bool factorySide) {
        // Cheap unit tests first: this runs on every FRONT builder MakeTask.
        if(u is null || u.circuitDef.IsMobile() || u.circuitDef.GetBuildDistance()<=0.f || !Active()) return null;
        if(u.task !is null && (u.task.IsExternalControlled() || u.task.IsEnemyReclaim()
            || u.task.GetType()==int(Task::Type::PLAYER) || u.task.GetType()==int(Task::Type::RETREAT))) return u.task;
        IUnitTask@ opening=OpeningAssist(u,factorySide);
        if(opening !is null) return opening;
        Snapshot();
        const int index=turrets.find(u.id);
        const int targetId=(index>=0 && uint(index)<assigned.length())?assigned[index]:-1;
        if(targetId<0) return null;
        CCircuitUnit@ target=ai.GetTeamUnit(targetId);
        if(target is null || target.GetBuildProgress()>=1.f) return null;
        const float reach=u.circuitDef.GetBuildDistance();
        if(MapHelpers::SqDist(u.GetPos(ai.frame),target.GetPos(ai.frame))>reach*reach) return null;
        IBuilderTask@ current=cast<IBuilderTask>(u.task);
        // Preserve repair/construction already serving non-production work.
        // Enemy reclaim, player ownership and retreat were checked above.
        if(HasOtherWork(u)) return u.task;
        if(current !is null && !current.IsDead() && current.target is target
            && current.GetBuildType()==int(Task::BuildType::REPAIR)) return u.task;
        return factorySide?aiFactoryMgr.Enqueue(TaskS::Repair(Task::Priority::NORMAL,target))
            :aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::NORMAL,target,10*SECOND));
    }
    IUnitTask@ OpeningAssist(CCircuitUnit@ turret,bool factorySide) {
        CCircuitUnit@ factory=FrontConstructors::OpeningFactory();
        if(factory is null || !FrontConstructors::UsefulTurret(factory)
            || turret.id!=FrontConstructors::openingTurret) return null;
        // The opening nano replaces the commander's factory assistance, even
        // when the shared production budget would assign no optional support.
        IBuilderTask@ production=cast<IBuilderTask>(factory.task);
        CCircuitUnit@ target=production is null?null:production.target;
        const float reach=turret.circuitDef.GetBuildDistance();
        if(target is null || target.GetBuildProgress()>=1.f
            || MapHelpers::SqDist(turret.GetPos(ai.frame),target.GetPos(ai.frame))>reach*reach)
            return factorySide?aiFactoryMgr.Enqueue(TaskS::Wait(true,SECOND))
                :aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        IBuilderTask@ current=cast<IBuilderTask>(turret.task);
        if(current !is null && !current.IsDead() && current.target is target
            && current.GetBuildType()==int(Task::BuildType::REPAIR)) return turret.task;
        return factorySide?aiFactoryMgr.Enqueue(TaskS::Repair(Task::Priority::NORMAL,target))
            :aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::NORMAL,target,10*SECOND));
    }
}

#include "../../helpers/math/front_constructor_math.as"
// Stable FRONT seats, assigned in completion order rather than engine unit-ID
// order. A casualty opens only its own seat; surviving workers never reshuffle.
namespace FrontConstructors {
    const int SUPPORT = FrontConstructorMath::SUPPORT, EXPANSION = FrontConstructorMath::EXPANSION,
        COMMANDER = FrontConstructorMath::COMMANDER, ENERGY = FrontConstructorMath::ENERGY;
    // Preserve persisted seat IDs; admission order adds energy before expansion.

    array<int> seats = {-1, -1, -1, -1};
    array<bool> filled = {false, false, false, false};
    IUnitTask@ openingNano = null;
    int openingTurret = -1;
    bool loaded = false;
    IUnitTask@ recruit = null;
    void Load() {
        if (loaded) return;
        loaded = true;
        for (uint i = 0; i < seats.length(); ++i) {
            seats[i] = aiTerrainMgr.GetLayoutInt("front.constructor." + i, -1);
            filled[i] = aiTerrainMgr.GetLayoutInt("front.constructor.filled." + i, 0) != 0;
        }
    }
    void Save(int seat) {
        aiTerrainMgr.SetLayoutInt("front.constructor." + seat, seats[seat]);
        aiTerrainMgr.SetLayoutInt("front.constructor.filled." + seat, filled[seat] ? 1 : 0);
    }
    const array<string> candidates = {"armck","corck","legck","armcv","corcv","legcv",
        "armch","corch","legch","armbeaver","cormuskrat","legotter"};
    bool Eligible(CCircuitUnit@ unit) {
        return unit !is null && candidates.find(unit.circuitDef.GetName()) >= 0
            && !unit.circuitDef.IsAbleToFly();
    }
    int Seat(int id) { Load(); return seats.find(id); }
    bool IsBase(int id) { Load(); return id >= 0 && seats[SUPPORT] == id; }
    int Missing() {
        Load();
        return FrontConstructorMath::Missing(seats);
    }
    bool OnAdded(CCircuitUnit@ unit) {
        if (Global::AISettings::Role != AiRole::FRONT || !Eligible(unit)) return false;
        if (Team::Ferry::IsGift(unit.id) || Team::Recovery::IsGift(unit.id)) return false;
        // Called on builder admission/completion. No recurring owned-army scan,
        // borrowed handles, or random-ID ordering. At most four comparisons.
        int seat = Seat(unit.id);
        if (seat < 0) {
            seat = Missing();
            if (seat >= 0) { seats[seat] = unit.id; filled[seat] = true; Save(seat); }
            GenericHelpers::LogUtil("[FrontConstructors] assigned unit=" + unit.id + " seat=" + seat, 1);
        }
        if (seat == SUPPORT || seat == ENERGY) unit.AddAttribute(Unit::Attr::BASE.type);
        else unit.DelAttribute(Unit::Attr::BASE.type);
        return true; // bypass generic primary/secondary/guard reassignment
    }
    void OnRemoved(CCircuitUnit@ unit) {
        const int seat = Seat(unit.id);
        if (seat < 0) return;
        seats[seat] = -1; Save(seat);
        GenericHelpers::LogUtil("[FrontConstructors] vacant seat=" + seat + " unit=" + unit.id, 1);
    }
    IUnitTask@ Recruit(CCircuitUnit@ factory, bool commanderEnabled) {
        const int seat = Missing();
        if (seat < 0) return null;
        // Preserve two constructors/scout/raiders/expansion opening order. Once
        // a seat has existed, replacing it precedes all optional production.
        if (!FrontConstructorMath::RecruitAllowed(seat,filled[seat],RoleFront::g_frontPostRaidConstructorQueued,commanderEnabled)) return null;
        // Hold our one recruit through frame construction; the shared pending
        // index counts only unstarted orders. Release the handle on completion
        // or cancellation, without retaining an engine unit across callbacks.
        if (recruit !is null && !recruit.IsDead()) return null;
        @recruit = null;
        for (uint i = 0; i < candidates.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(candidates[i]);
            if (def !is null && aiFactoryMgr.GetPendingRecruitCount(def) > 0) return null;
        }
        for (uint i = 0; i < candidates.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(candidates[i]);
            if (def is null || !factory.circuitDef.CanBuild(def) || !def.IsAvailable(ai.frame)) continue;
            IUnitTask@ task = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::BUILDPOWER,
                Task::Priority::HIGH, def, factory.GetPos(ai.frame), 64.f));
            @recruit = task;
            if (task !is null) GenericHelpers::LogUtil("[FrontConstructors] recruit seat=" + seat + " def=" + def.GetName(), 1);
            return task;
        }
        return null;
    }
    bool OpeningPending(CCircuitUnit@ factory) {
        Load();
        if (FrontConstructorMath::OpeningDone(filled)) return false;
        for (uint i=0; i<candidates.length(); ++i) {
            CCircuitDef@ def=ai.GetCircuitDef(candidates[i]);
            if (def !is null && factory.circuitDef.CanBuild(def) && def.IsAvailable(ai.frame)) return true;
        }
        return recruit !is null && !recruit.IsDead();
    }
    CCircuitUnit@ OpeningFactory() {
        if (Factory::primaryT1BotLab !is null) return Factory::primaryT1BotLab;
        return Factory::primaryT1VehPlant;
    }
    IUnitTask@ AssistFactory(CCircuitUnit@ unit) {
        CCircuitUnit@ factory=OpeningFactory();
        if (factory is null) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        return GuardHelpers::AssignWorkerGuard(unit,factory,Task::Priority::NORMAL,true,10*SECOND);
    }
    bool ReachesFactory(CCircuitUnit@ turret,CCircuitUnit@ factory) {
        if(factory is null || turret is null || turret.circuitDef.IsMobile()
            || turret.circuitDef.GetName()!=UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side)) return false;
        const float reach=turret.circuitDef.GetBuildDistance();
        return MapHelpers::SqDist(turret.GetPos(ai.frame),factory.GetPos(ai.frame))<=reach*reach;
    }
    bool UsefulTurret(CCircuitUnit@ factory) {
        // Cache only identity; validate existence/type/reach on each task ask.
        // Scan the lifecycle-maintained turret list only after loss or relocation.
        if(ReachesFactory(ai.GetTeamUnit(openingTurret),factory)) return true;
        openingTurret=-1;
        IBuilderTask@ pending=cast<IBuilderTask>(openingNano);
        if(pending !is null && !pending.IsDead() && ReachesFactory(pending.target,factory)) {
            openingTurret=pending.target.id;return true;
        }
        FrontFactorySupport::Load();
        for (uint i=0; i<FrontFactorySupport::turrets.length(); ++i) {
            CCircuitUnit@ turret=ai.GetTeamUnit(FrontFactorySupport::turrets[i]);
            if (ReachesFactory(turret,factory)) {openingTurret=turret.id;return true;}
        }
        return false;
    }
    bool OpeningComplete() {
        CCircuitUnit@ factory=OpeningFactory();
        return factory !is null && UsefulTurret(factory)
            && ai.GetTeamUnit(openingTurret).GetBuildProgress()>=1.f;
    }
    IUnitTask@ EnqueueOpeningTurret(CCircuitUnit@ unit,CCircuitUnit@ factory,CCircuitDef@ nano) {
        // One retained task owns this opener independently of unrelated front
        // defence queues/cooldowns. Slot search is bounded by the layout group.
        int group=aiTerrainMgr.GetLayoutInt(FrontLayout::TierKey(0)+".adopted_nano",-1);
        if(group<0) group=aiTerrainMgr.GetNamedLayoutGroup(FrontLayout::PlanKey(0)+".nano");
        const int slot=aiTerrainMgr.NextSupportSlot(unit,nano,group,factory.GetPos(ai.frame),8);
        if(slot>=0) {
            IUnitTask@ task=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO,Task::Priority::HIGH,
                nano,aiTerrainMgr.GetReservationPos(slot),0.f,true,300*SECOND));
            if(task !is null && !AiPinReservation(task,slot)) {aiBuilderMgr.AbortTask(task);return null;}
            return task;
        }
        // Ordinary placement retains native reservation checks on cramped maps.
        return aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO,Task::Priority::HIGH,
            nano,factory.GetPos(ai.frame),SQUARE_SIZE*24,true,300*SECOND));
    }
    IUnitTask@ OpeningSupport(CCircuitUnit@ unit) {
        if (openingNano !is null && !openingNano.IsDead()) return openingNano;
        @openingNano=null;
        CCircuitUnit@ factory=OpeningFactory();
        if (factory is null || UsefulTurret(factory)) return null;
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if (nano !is null && unit.circuitDef.CanBuild(nano) && nano.IsAvailable(ai.frame)) {
            @openingNano=EnqueueOpeningTurret(unit,factory,nano);
            if (openingNano !is null) {
                GenericHelpers::LogUtil("[FrontConstructors] opening turret builder="+unit.id,1);
                return openingNano;
            }
        }
        return AssistFactory(unit);
    }
    IUnitTask@ CommanderOpening(CCircuitUnit@ unit) {
        if (!UnitHelpers::IsCommander(unit.circuitDef) || CommanderFront::Ready()) return null;
        CCircuitUnit@ factory=OpeningFactory();
        if (factory is null || factory.GetBuildProgress()<1.f) return null;
        IUnitTask@ current=unit.task;
        if (current !is null && (current.IsExternalControlled() || current.IsEnemyReclaim()
            || current.GetType()==int(Task::Type::PLAYER) || current.GetType()==int(Task::Type::RETREAT))) return current;
        IBuilderTask@ build=cast<IBuilderTask>(current);
        if (build !is null && !build.IsDead() && build.target !is null
            && build.GetBuildType()<int(Task::BuildType::REPAIR)) return current;
        if(UsefulTurret(factory)) {
            CCircuitUnit@ turret=ai.GetTeamUnit(openingTurret);
            const int phase=FrontConstructorMath::CommanderPhase(false,true,turret.GetBuildProgress());
            if(phase==2) return null;
            if(build !is null && !build.IsDead() && build.target is turret
                && build.GetBuildType()==int(Task::BuildType::REPAIR)) return current;
            GenericHelpers::LogUtil("[FrontConstructors] commander assist turret="+turret.id,1);
            return aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::HIGH,turret,10*SECOND));
        }
        return AssistFactory(unit);
    }
    IUnitTask@ EnergyWork(CCircuitUnit@ unit) {
        IBuilderTask@ current=cast<IBuilderTask>(unit.task);
        if (current !is null && !current.IsDead() && Local(current)
            && current.GetBuildType()==int(Task::BuildType::ENERGY)) return current;
        // Ask for energy explicitly: default planning can select factory assist
        // indefinitely. Native selection retains affordability/wind/cap policy
        // and filters definitions before enqueueing for this worker.
        IUnitTask@ energy=aiEconomyMgr.EnqueueWorkerEnergy(unit);
        if(energy is null) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        GenericHelpers::LogUtil("[FrontConstructors] energy work builder="+unit.id,1);
        return energy;
    }
    bool Local(IUnitTask@ task) {
        IBuilderTask@ build = cast<IBuilderTask>(task);
        if (build is null) return false;
        const AIFloat3 p = build.GetBuildPos();
        const float radius = Global::RoleSettings::Front::BaseSupportRadius;
        return p.x >= 0.f && p.z >= 0.f && MapHelpers::SqDist(p, Global::Map::StartPos) <= radius * radius;
    }
    IUnitTask@ BaseWork(CCircuitUnit@ unit) {
        // Keep an in-progress local structure; never abort shared work merely
        // to select another economic rung. Native retreat/combat owns safety.
        IBuilderTask@ current = cast<IBuilderTask>(unit.task);
        if (current !is null && !current.IsDead() && current.target !is null
            && current.GetBuildType() < int(Task::BuildType::REPAIR) && Local(current)) return current;
        IUnitTask@ opening=OpeningSupport(unit);
        if (opening !is null) return opening;
        IUnitTask@ normal = aiBuilderMgr.DefaultMakeTask(unit);
        IBuilderTask@ build = cast<IBuilderTask>(normal);
        if (normal is null) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        if (normal.GetType() == int(Task::Type::WAIT)) {
            // Native has no support admission once the FRONT planner owns it.
            // Preserve its other rungs; an idle base seat may fund a missing nano.
            if(FrontFactorySupport::Active()) {
                IUnitTask@ support=RoleFront::Front_TryBuildNano(Economy::GetMinMetalIncomeLast10s(),true);
                if(support !is null) return support;
            }
            return normal;
        }
        if (Local(normal) && build.GetBuildType() == int(Task::BuildType::ENERGY)) return normal;
        IUnitTask@ special = RoleFront::Front_T1Constructor_AiMakeTask(unit, null,
            Economy::GetMinMetalIncomeLast10s(), Economy::GetMinEnergyIncomeLast10s(),
            aiEconomyMgr.isEnergyStalling, aiEconomyMgr.isEnergyFull);
        if (special !is null) return special;
        if (Local(normal)) return normal;
        // Rejected fresh defaults are retired by the native default-task owner;
        // queued tasks belonging to other builders remain untouched.
        return aiBuilderMgr.Enqueue(TaskB::Patrol(Task::Priority::LOW, Global::Map::StartPos, 10 * SECOND));
    }
}

// TECH energy-reclaim transition: three stable worker seats, claimed on existing asks.
// No periodic army census or per-frame placement scan. IDs are revalidated on each use;
// air replacement releases a bot without interrupting its paid construction.
namespace TechGrowth {
    bool active=false;
    bool reclaimMarked=false;
    int lastTick=-SECOND;
    int nanoId=-1, afusId=-1, converterId=-1;
    void MarkEnergyReclaim() {
        // Commit only after an actual reclaim task is accepted. Recruitment is
        // deferred until the next policy tick, outside that task's assignment.
        reclaimMarked=true;
        aiTerrainMgr.SetLayoutInt("tech.growth.reclaim",1);
    }
    bool Available(CCircuitUnit@ u) {
        if(u is null || u.circuitDef is null || u.GetBuildProgress()<1.f) return false;
        if(Team::Ferry::IsGift(u.id) || Team::Recovery::IsGift(u.id)
            || UnitHelpers::IsCommander(u.circuitDef) || SeaConstructor::IsT1(u.circuitDef)
            || SeaConstructor::IsT2(u.circuitDef) || TechHarbour::IsHoverConstructor(u.circuitDef)
            || FrontlineEngineering::members.exists(""+u.id)) return false;
        return u.task is null || (!u.task.IsExternalControlled() && !u.task.IsEnemyReclaim()
            && u.task.GetType()!=int(Task::Type::PLAYER) && u.task.GetType()!=int(Task::Type::RETREAT));
    }
    bool Alive(int id) { return id>=0 && Available(ai.GetTeamUnit(id)); }
    bool CanBuild(CCircuitUnit@ u,const string& in name) {
        CCircuitDef@ def=ai.GetCircuitDef(name);
        return def !is null && u.circuitDef.CanBuild(def);
    }
    void Tick() {
        if(ai.frame<lastTick+SECOND) return;
        lastTick=ai.frame;
        if(!Global::RoleSettings::Tech::GrowthEnabled || Global::AISettings::Role!=AiRole::TECH) {
            active=false; nanoId=-1; afusId=-1; converterId=-1; return;
        }
        if(!active && (reclaimMarked || aiTerrainMgr.GetLayoutInt("tech.growth.reclaim",0)>0)) {
            active=true;
            GenericHelpers::LogUtil("[TECH][Growth] enabled: T1 energy reclaim started",1);
            Recruit();
        }
        // The transition is permanent. Resource admission controls construction,
        // not worker ownership, so spending the reclaim bank cannot oscillate roles.
        if(!Alive(nanoId)) nanoId=-1;
        if(!Alive(afusId)) afusId=-1;
        if(!Alive(converterId)) converterId=-1;
        if(active && Alive(TechBuild::airAfusId)) afusId=TechBuild::airAfusId;
        if(active && Alive(TechBuild::airConvId)) converterId=TechBuild::airConvId;
    }
    bool Dedicated(CCircuitUnit@ u) {return active && u !is null && (u.id==nanoId || u.id==afusId || u.id==converterId);}
    void Recruit() {
        // Once on mode entry, not per tick: reuse the revision-owned constructor
        // subset. Wake only the three seats; do not abandon paid construction.
        CCircuitDef@ nano=ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        if(nano is null) return;
        array<Id>@ workers=OwnedEconomy::Workers(nano);
        for(uint i=0;i<workers.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(workers[i]);
            IBuilderTask@ task=u is null?null:cast<IBuilderTask>(u.task);
            // Leave the builder that started retirement to collect its refund.
            // It may claim a still-vacant seat on its next ordinary work ask.
            if(task !is null && task.GetBuildType()==int(Task::BuildType::RECLAIM)) continue;
            Claim(u);
        }
        array<int> seats={nanoId,afusId,converterId};
        for(uint i=0;i<seats.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(seats[i]);
            if(u is null || u.task is null || u.task.IsExternalControlled() || u.task.IsEnemyReclaim()
                || u.task.GetType()==int(Task::Type::PLAYER) || u.task.GetType()==int(Task::Type::RETREAT)) continue;
            if(TechBuild::KeepCurrent(u) is null) aiBuilderMgr.AssignTask(u,TechBuild::Wait(SECOND));
        }
    }
    int Claim(CCircuitUnit@ u) {
        Tick();
        if(!active || !Available(u)) return 0;
        const string side=Global::AISettings::Side;
        const int tier=UnitHelpers::GetConstructorTier(u.circuitDef);
        if(tier==1 && CanBuild(u,UnitHelpers::GetT1NanoNameForSide(side))) {
            CCircuitUnit@ current=ai.GetTeamUnit(nanoId);
            if(nanoId<0 || (UnitHelpers::IsAirConstructor(u.circuitDef) && current !is null
                && !UnitHelpers::IsAirConstructor(current.circuitDef))) nanoId=u.id;
        }
        if(tier>=2) {
            if(afusId<0 && u.id!=converterId && CanBuild(u,UnitHelpers::GetAdvFusionNameForSide(side))) afusId=u.id;
            else if(converterId<0 && u.id!=afusId && CanBuild(u,UnitHelpers::GetAdvEnergyConverterNameForSide(side))) converterId=u.id;
        }
        return u.id==nanoId?1:u.id==afusId?2:u.id==converterId?3:0;
    }
    float PowerTarget(const EcoPlanner::State@ state, CCircuitUnit@ project) {
        const float backlogTarget=TechEconomyMath::GrowthPowerTarget(aiEconomyMgr.metal.income,aiEconomyMgr.metal.current,
            Global::RoleSettings::Tech::GrowthMetalReserve,Global::RoleSettings::Tech::GrowthDrainSeconds,
            Global::RoleSettings::Tech::EcoBuildPowerPerMetal);
        const float projectTarget=TechEconomyMath::CapacityTarget(state.mIncome,
            Global::RoleSettings::Tech::EcoBuildPowerPerMetal,Global::RoleSettings::Tech::PowerBuildPowerPerMetal,
            state.eIncome,aiEconomyMgr.energy.current,Global::RoleSettings::Tech::PowerCapacityBankSeconds,
            project is null?0.f:project.circuitDef.GetBuildTime(),project is null?0.f:project.circuitDef.costE);
        // A full bank is direct evidence of unspent capacity. Use the
        // existing per-income ceiling rather than whichever nearby frame
        // happened to populate the shared context (often a small turret).
        const bool full=state.mStor>0.f && state.mCur>=state.mStor*.9f
            && state.eStor>0.f && state.eCur>=state.eStor*.5f;
        const float fundedCeiling=full ? AiMax(state.mIncome,aiEconomyMgr.metal.income)
            * Global::RoleSettings::Tech::PowerBuildPowerPerMetal : 0.f;
        return AiMax(AiMax(backlogTarget,projectTarget),fundedCeiling);
    }
    IUnitTask@ SupportCurrentReactor(CCircuitUnit@ u,const EcoPlanner::State@ state) {
        IBuilderTask@ task=cast<IBuilderTask>(Builder::EnergyBuildTask);
        if(task is null || task.IsDead() || task.target is null || task.buildDef is null
            || task.buildDef.GetName()!=UnitHelpers::GetAdvFusionNameForSide(Global::AISettings::Side)
            || task.target.GetBuildProgress()>=1.f || Layout::nano is null
            || aiEconomyMgr.isEnergyStalling || aiEconomyMgr.metal.current<Layout::nano.costM) return null;
        const AIFloat3 at=task.target.GetPos(ai.frame);
        // Reuse the current project handle: no extra unfinished-unit census.
        // Aggregate home power cannot serve an AFUS outside those turrets' reach.
        // The native power query scans O(N) owned units on this worker's work ask,
        // not every Tick. Keep this cost in the deferred 16-AI comparisons.
        const float local=aiBuilderMgr.GetStaticBuildPowerNear(at,Layout::nano.GetBuildDistance());
        const float desired=AiMin(PowerTarget(state,task.target),task.buildDef.GetBuildTime()
            /AiMax(1.f,Global::RoleSettings::Tech::GrowthDrainSeconds));
        if(local+state.arrivingBuildPower>=desired) return null;
        Layout::PrepareEconomySupport(at,u);
        return Layout::EconomySupport(u);
    }
    IUnitTask@ Work(CCircuitUnit@ u, const EcoPlanner::State@ state, CCircuitUnit@ project) {
        const int seat=Claim(u);
        if(seat==0) return null;
        IUnitTask@ keep=TechBuild::KeepCurrent(u);
        if(keep !is null) return keep;
        IUnitTask@ work;
        if(seat==1) {
            // A reserved reactor/converter may be waiting for this exact
            // support turret. Satisfy that dependency before aggregate capacity
            // checks; otherwise a full old cluster strands the next one.
            @work=Layout::EconomySupport(u);
            if(work !is null) return work;
            @work=SupportCurrentReactor(u,state);
            if(work !is null) return work;
            const float target=PowerTarget(state,project);
            const float power=state.buildPowerNear+state.arrivingBuildPower;
            if(!aiEconomyMgr.isEnergyStalling && power<target && Layout::nano !is null
                && aiEconomyMgr.metal.current>=Layout::nano.costM) {
                // Reserve one funded bootstrap slot even while a dear frame
                // occupies the ordinary concurrency budget. Still one shared
                // nano order at a time; no speculative queue of new projects.
                @work=Layout::NanoTask(u,Task::Priority::HIGH,1);
            }
        } else {
            const string name=seat==2?UnitHelpers::GetAdvFusionNameForSide(Global::AISettings::Side)
                :UnitHelpers::GetAdvEnergyConverterNameForSide(Global::AISettings::Side);
            TechBuild::LiftCapForRole(name);
            CCircuitDef@ def=ai.GetCircuitDef(name);
            const bool funded=seat==2 && def !is null && TechEconomyMath::FundedGrowthReactor(
                aiEconomyMgr.metal.current,Global::RoleSettings::Tech::GrowthMetalReserve,def.costM,
                aiEconomyMgr.energy.current,aiEconomyMgr.energy.storage,aiEconomyMgr.energy.income,def.costE,
                Global::RoleSettings::Tech::GrowthDrainSeconds,aiEconomyMgr.isEnergyStalling);
            @work=TechBuild::BuildByLayout(u,name,seat==2?Task::BuildType::ENERGY:Task::BuildType::CONVERT,funded);
            if(work is null) @work=TechBuild::AssistNearestOf(u,name);
        }
        if(work !is null) {
            GenericHelpers::LogUtil("[TECH][Growth] worker="+u.id+" seat="+seat,2);
            return work;
        }
        return TechBuild::Wait(3*SECOND);
    }
}

namespace MaintenanceProbe {
    int phase=0,changed=-1,frameId=-1;
    array<int> workers;
    IUnitTask@ build;
    IUnitTask@ assist;
    bool damaged=false,healed=false,repairObserved=false;
    void Check(const string& in name,bool pass) {
        AiLog("[MaintenanceProbe] "+(pass?"PASS ":"FAIL ")+name);
    }
    void Tick() {
        if(ai.teamId!=0) return;
        if(phase==0 && ai.frame>=30*SECOND) {
            phase=1;
            array<int>@ ids=ai.GetOwnedUnitIds();
            for(uint i=0;i<ids.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
                if(u !is null && u.circuitDef.GetName()=="armack") workers.insertLast(u.id);
            }
            Check("released",workers.length()==3 && TechForward::T2Released());
            FrontlineEngineering::Load();
            aiBuilderMgr.SetDefenseRule(-1,"enabled",0);
            EngineeringLanes::lanes.resize(0);
            EngineeringLanes::Lane@ lane=EngineeringLanes::Lane();
            lane.team=1;lane.share=.2f;lane.station=AIFloat3(4500,0,1600);
            EngineeringLanes::lanes.insertLast(lane);
            FrontlineEngineering::reassess=-1;
        }
        if(phase==0 || workers.length()!=3) return;
        EngineeringLanes::lanes[0].frame=ai.frame;
        for(uint i=0;i<workers.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(workers[i]);
            if(u !is null && u.GetHealthPercent()<.99f) damaged=true;
            IBuilderTask@ task=u is null?null:cast<IBuilderTask>(u.task);
            if(phase==1 && damaged && task !is null && task.GetBuildType()==Task::BuildType::REPAIR) repairObserved=true;
        }
        if(damaged) {
            bool full=true;
            for(uint i=0;i<workers.length();++i) full=full && ai.GetTeamUnit(workers[i]).GetHealthPercent()>=.99f;
            healed=healed || full;
        }
        if(phase==1 && ai.frame>=110*SECOND) {
            Check("nearby_healed",damaged && healed && repairObserved);
            CCircuitDef@ def=ai.GetCircuitDef("armfus");def.maxThisUnit=32;
            @build=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::ENERGY,Task::Priority::NORMAL,def,AIFloat3(4500,0,1800),128,true,0));
            Check("construction_started",build !is null);
            if(build !is null) aiBuilderMgr.AssignTask(ai.GetTeamUnit(workers[0]),build);
            phase=2;
        }
        if(phase==2) {
            CCircuitUnit@ target=aiBuilderMgr.FindUnfinishedNear(AIFloat3(4500,0,1800),500,ai.GetCircuitDef("armfus"));
            if(target is null) return;
            frameId=target.id;
            @assist=aiBuilderMgr.Enqueue(TaskB::Repair(Task::Priority::NORMAL,target,600*SECOND));
            if(assist is null) return;
            aiBuilderMgr.AssignTask(ai.GetTeamUnit(workers[1]),assist);
            // Supply a new assignment while real construction/assistance runs.
            FrontlineEngineering::target=2;FrontlineEngineering::station=AIFloat3(3800,0,1600);
            FrontlineEngineering::reassess=ai.frame+300*SECOND;
            for(uint i=0;i<FrontlineEngineering::seats.length();++i) FrontlineEngineering::seats[i].route.resize(0);
            changed=ai.frame;phase=3;
            Check("build_retained_on_ask",FrontlineEngineering::Work(ai.GetTeamUnit(workers[0])) is build);
            Check("assist_retained_on_ask",FrontlineEngineering::Work(ai.GetTeamUnit(workers[1])) is assist);
        }
        if(phase==3 && ai.frame>=changed+SECOND) {
            Check("build_retained_on_tick",ai.GetTeamUnit(workers[0]).task is build);
            Check("assist_retained_on_tick",ai.GetTeamUnit(workers[1]).task is assist);
            phase=4;
        }
        if(phase==4) {
            CCircuitUnit@ target=ai.GetTeamUnit(frameId);
            if(target !is null && target.GetBuildProgress()>=1) {
                Check("construction_finished",true);phase=5;
            }
        }
        if(phase==5) {
            bool arrived=true;
            for(uint i=0;i<2;++i) arrived=arrived && ai.GetTeamUnit(workers[i]).GetPos(ai.frame).distance2D(FrontlineEngineering::station)<=FrontlineEngineering::arrival;
            if(arrived) {Check("relocated_after_finish",true);phase=6;AiLog("[MaintenanceProbe] complete");}
        }
    }
}

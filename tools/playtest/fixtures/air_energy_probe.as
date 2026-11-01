namespace AirEnergyProbe {
    int phase=0,worker=-1,target=-1;
    IUnitTask@ cleanup;
    IUnitTask@ Retain(CCircuitUnit@ u) {
        if(u.id==worker && cleanup !is null && !cleanup.IsDead()) return cleanup;
        return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
    }
    void Check(const string& in key,bool pass) { AiLog("[AirEnergyProbe] "+(pass?"PASS ":"FAIL ")+key); }
    void Tick() {
        if(ai.teamId!=0) return;
        if(phase==0 && ai.frame>=30*SECOND) {
            phase=1;
            array<int>@ ids=ai.GetOwnedUnitIds();
            for(uint i=0;i<ids.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
                if(u.circuitDef.GetName()=="corca") worker=u.id;
            }
            Check("fixture",worker>=0 && AirEconomy::HasReactor());
            if(worker<0) return;
            CCircuitUnit@ u=ai.GetTeamUnit(worker);
            AirEconomy::Tick();
            Check("recovery_rejects_solar",AirBuild::Energy(u,true) is null);
            Check("placement_rejects_solar",AirLayout::Place(u,ai.GetCircuitDef("corsolar"),Task::BuildType::ENERGY,Task::Priority::NORMAL) is null);
            Check("placement_rejects_advanced",AirLayout::Place(u,ai.GetCircuitDef("coradvsol"),Task::BuildType::ENERGY,Task::Priority::NORMAL) is null);
            EcoPlanner::State@ state=EcoPlanner::Read(u,AirEconomy::metal,AirEconomy::energy,true);
            Check("chooser_rejects_advanced",EcoPlanner::Make("advsolar","coradvsol",state,false) is null);
            @cleanup=AirReclaim::MakeTask(u);
            IBuilderTask@ build=cast<IBuilderTask>(cleanup);
            Check("reclaim_admitted",build !is null && build.target !is null && build.target.circuitDef.GetName()=="corsolar");
            if(build !is null && build.target !is null) {
                target=build.target.id;aiBuilderMgr.AssignTask(u,cleanup);
            }
        }
        if(phase==1 && target>=0 && ai.GetTeamUnit(target) is null) {
            phase=2;Check("reclaim_finished",true);AiLog("[AirEnergyProbe] complete");
        }
    }
}

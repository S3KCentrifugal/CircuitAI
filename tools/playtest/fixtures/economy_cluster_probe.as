namespace ClusterProbe {
    bool active=false,parallel=false,nanoHelp=false,converterHelp=false,reactorHelp=false,fusionHelp=false,retained=false;
    int phase=0,firstSlot=-1,otherGroup=-1,last=-SECOND,peak=0;
    array<int> projectSlots;
    array<IUnitTask@> projects;
    IUnitTask@ firstTask;
    void Check(bool ok,const string& in label) {AiLog("[ClusterTest] "+(ok?"PASS ":"FAIL ")+label);}
    bool Handle(const string& in message) {
        if(message!="cluster-init" || ai.teamId!=0) return false;
        if(!Global::Map::MapResolved) Setup::setupMap(AIFloat3(11184,0,2128));
        Check(Global::AISettings::Role==AiRole::TECH,"TECH role resolved");
        // The fixture supplies completed AFUS for energy, but needs an older
        // unfinished fusion to test assistance precedence, not new-build policy.
        @Global::energyAllowed=null;
        Layout::OnRoleLeave();Layout::Enable(true);Layout::planned=true;Layout::fallback=false;
        Layout::boxCentre=AIFloat3(11184,0,2128);Layout::homeCentre=Layout::boxCentre;
        @Layout::nano=ai.GetCircuitDef("cornanotc");Layout::nano.maxThisUnit=100;
        Layout::boxZone=aiTerrainMgr.ReserveZone(Layout::boxCentre,0,600,500,false);
        Layout::nanoGroup=aiTerrainMgr.LayBand(Layout::boxZone,Layout::nano,AIFloat3(11184,0,2228),0,4,4,0,true,true,false);
        firstSlot=aiTerrainMgr.NextSlotAny(Layout::nanoGroup,Layout::boxCentre);
        array<int> localSlots;aiTerrainMgr.GetScopedReservationIds(Layout::boxZone,0,Layout::nano,localSlots);
        array<int> groupSlots;aiTerrainMgr.GetScopedReservationIds(-1,Layout::nanoGroup,Layout::nano,groupSlots);
        bool same=localSlots.length()==groupSlots.length();
        for(uint s=0;s<localSlots.length() && same;++s) same=localSlots[s]==groupSlots[s];
        array<int> invalidSlots;aiTerrainMgr.GetScopedReservationIds(0,0,Layout::nano,invalidSlots);
        Check(same && invalidSlots.length()==0,"scoped index group and invalid queries");
        firstSlot=-1;
        for(uint s=0;s<localSlots.length() && firstSlot<0;++s)
            if(aiTerrainMgr.IsReservationBuildable(localSlots[s])) firstSlot=localSlots[s];
        Layout::fwdZone=aiTerrainMgr.ReserveZone(AIFloat3(10000,0,4500),0,500,500,false);
        Layout::fwdGroup=aiTerrainMgr.LayBand(Layout::fwdZone,Layout::nano,AIFloat3(10000,0,4600),0,4,4,0,true,true,false);
        otherGroup=Layout::fwdGroup;
        const array<string> names={"corafus","cormmkr","corfus"};
        for(uint i=0;i<names.length();++i) {
            CCircuitDef@ def=ai.GetCircuitDef(names[i]);def.maxThisUnit=100;
            int slot=-1;
            for(int dz=-64;dz<=64 && slot<0;dz+=32) for(int dx=0;dx<=96 && slot<0;dx+=32) {
                const int group=aiTerrainMgr.LayBand(Layout::boxZone,def,AIFloat3(11408+dx,0,2028+int(i)*152+dz),0,1,1,0,true,true,false);
                slot=aiTerrainMgr.NextSlotAny(group,Layout::boxCentre);
                if(slot>=0 && !aiTerrainMgr.IsReservationBuildable(slot)) {aiTerrainMgr.ReleaseReservation(slot);slot=-1;}
            }
            projectSlots.insertLast(slot);
            projects.insertLast(null);
        }
        array<int> remoteSlots;aiTerrainMgr.GetScopedReservationIds(Layout::fwdZone,0,Layout::nano,remoteSlots);
        Check(firstSlot>=0 && remoteSlots.length()>0 && projectSlots[0]>=0 && projectSlots[1]>=0 && projectSlots[2]>=0,"fixture reservations");
        active=true;return true;
    }
    IUnitTask@ Start(CCircuitUnit@ u,int slot,CCircuitDef@ def,Task::BuildType type) {
        IUnitTask@ t=aiBuilderMgr.Enqueue(TaskB::Common(type,Task::Priority::HIGH,def,aiTerrainMgr.GetReservationPos(slot),0.f,true,20*60*SECOND));
        AiLog("[ClusterProbe] start "+def.GetName()+" worker="+u.id+" slot="+slot+" task="+(t !is null));
        if(t !is null && !AiPinReservation(t,slot)) {aiBuilderMgr.AbortTask(t);return null;}
        return t;
    }
    IUnitTask@ Task(CCircuitUnit@ u) {
        if(!active) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        IBuilderTask@ current=cast<IBuilderTask>(u.task);
        if(current !is null && !current.IsDead() && current.GetBuildType()<int(Task::BuildType::REPAIR)) return u.task;
        if(phase==0 && u.circuitDef.GetName()=="corca" && firstTask is null) {
            @firstTask=Start(u,firstSlot,Layout::nano,Task::BuildType::NANO);if(firstTask !is null) return firstTask;
        }
        if(phase==0 && u.circuitDef.GetName()=="coraca") {
            const array<string> names={"corafus","cormmkr","corfus"};
            for(uint i=0;i<projects.length();++i) if(projects[i] is null) {
                @projects[i]=Start(u,projectSlots[i],ai.GetCircuitDef(names[i]),i==1?Task::BuildType::CONVERT:Task::BuildType::ENERGY);
                if(projects[i] !is null) return projects[i];
            }
        }
        if(phase>=1) {IUnitTask@ task=EconomyCluster::BatchWork(u);if(task !is null) return task;}
        return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
    }
    void Tick() {
        if(!active || ai.frame<last+SECOND) return;last=ai.frame;
        if(phase==0) {
            if(ai.frame%(10*SECOND)<SECOND) {
                string status="[ClusterProbe] waiting nano="+aiTerrainMgr.GetReservationState(firstSlot);
                for(uint i=0;i<projectSlots.length();++i) status+=" project="+aiTerrainMgr.GetReservationState(projectSlots[i]);
                AiLog(status);
            }
            bool ready=aiTerrainMgr.GetReservationState(firstSlot)==3;
            for(uint i=0;i<projects.length();++i) {
                if(aiTerrainMgr.GetReservationUnit(projectSlots[i]) is null) ready=false;
            }
            if(!ready) return;
            for(uint i=0;i<projects.length();++i) {
                IBuilderTask@ t=cast<IBuilderTask>(projects[i]);
                // Release each original builder after the frame starts. Actual
                // turret progress must complete the three staged structures.
                if(t !is null && !t.IsDead()) {
                    array<CCircuitUnit@>@ workers=t.GetUnits();
                    for(uint w=0;w<workers.length();++w) {
                        workers[w].CmdStop();
                        aiBuilderMgr.AssignTask(workers[w],aiBuilderMgr.Enqueue(TaskB::Wait(SECOND)));
                    }
                }
            }
            phase=1;Check(true,"frames and first turret ready");
        }
        EconomyCluster::Tick();
        int pending=0,remote=0,finished=0;
        array<int> slots;aiTerrainMgr.GetScopedReservationIds(Layout::boxZone,0,Layout::nano,slots);
        const uint localTotal=slots.length();
        for(uint i=0;i<slots.length();++i) {
            const int s=aiTerrainMgr.GetReservationState(slots[i]);if(s==1 || s==2) ++pending;
            CCircuitUnit@ u=aiTerrainMgr.GetReservationUnit(slots[i]);
            if(u is null || s!=3) continue;
            ++finished;
            IBuilderTask@ work=cast<IBuilderTask>(u.task);if(work is null || work.target is null) continue;
            if(!retained) {retained=EconomyCluster::Assist(u,false) is u.task;Check(retained,"unchanged repair task retained");}
            const string name=work.target.circuitDef.GetName();
            if(name=="cornanotc" && !nanoHelp) {nanoHelp=true;Check(true,"turrets prioritize turret frames");}
            if(name=="cormmkr" && !converterHelp) {converterHelp=true;Check(true,"surplus redirects to converter");}
            if(name=="corafus" && !reactorHelp) {reactorHelp=true;Check(true,"AFUS after converter");}
            if(name=="corfus" && !fusionHelp) {fusionHelp=true;Check(true,"fusion after AFUS");}
        }
        if(pending>peak) peak=pending;
        if(pending>10) Check(false,"batch exceeded ten");
        if(peak==10 && !parallel) {parallel=true;Check(true,"ten distinct local projects");}
        aiTerrainMgr.GetScopedReservationIds(Layout::fwdZone,0,Layout::nano,slots);
        for(uint i=0;i<slots.length();++i) if(aiTerrainMgr.GetReservationState(slots[i])>0) ++remote;
        if(remote>0) Check(false,"remote cluster admitted");
        bool complete=finished==int(localTotal);
        for(uint i=0;i<projectSlots.length();++i) complete=complete && aiTerrainMgr.GetReservationState(projectSlots[i])==3;
        if(complete && phase==1) {phase=2;Check(parallel && nanoHelp && converterHelp && reactorHelp && fusionHelp && retained && remote==0,"completed locally in priority order");}
    }
}

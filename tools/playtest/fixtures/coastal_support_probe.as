namespace CoastalProbe {
    bool active=false, capability=false, ordered=false, stopped=false;
    int phase=0, landSlot=-1, supportSlot=-1, airId=-1, lastTick=-1000, labSlot=-1;
    float progress=0.f;
    IUnitTask@ reactorTask;
    IUnitTask@ supportTask;
    IUnitTask@ labTask;
    void Check(bool pass,const string& in label) { AiLog("[CoastalTest] "+(pass?"PASS ":"FAIL ")+label); }
    bool Handle(const string& in message) {
        if (message!="coastal-init" || ai.teamId!=0) return false;
        if (!Global::Map::MapResolved) Setup::setupMap(AIFloat3(2800,0,800));
        Layout::OnRoleLeave(); Layout::Enable(true);
        Layout::planned=true; Layout::fallback=false;
        Layout::homeCentre=AIFloat3(2800,0,800); Layout::boxCentre=Layout::homeCentre;
        @Layout::nano=ai.GetCircuitDef("cornanotc");
        Layout::boxZone=aiTerrainMgr.ReserveZone(Layout::boxCentre,0,600,500,false);
        Layout::nanoGroup=aiTerrainMgr.LayBand(Layout::boxZone,Layout::nano,AIFloat3(2800,0,1056),0,2,2,0,true,true,false);
        CCircuitDef@ fusion=ai.GetCircuitDef("corfus"); fusion.maxThisUnit=100;
        // Real terrain/footprints choose the usable land project in this small
        // supplied shore zone. The candidate coastal support must reach it.
        for (int z=640;z<=960 && landSlot<0;z+=64) for (int x=2600;x<=3000 && landSlot<0;x+=64) {
            const int group=aiTerrainMgr.LayBand(Layout::boxZone,fusion,AIFloat3(x,0,z),0,1,1,0,true,true,false);
            const int slot=aiTerrainMgr.NextSlotAny(group,Layout::boxCentre);
            if(slot>=0 && aiTerrainMgr.IsReservationBuildable(slot)) landSlot=slot;
            else if(slot>=0) aiTerrainMgr.ReleaseReservation(slot);
        }
        Check(Layout::nanoGroup>0 && landSlot>=0,"shore fixture");
        active=true; return true;
    }
    void Tick() {
        if(!active || ai.frame<lastTick+30) return;
        lastTick=ai.frame;
        if (supportSlot<0 && supportTask !is null) supportSlot=AiTaskReservationId(supportTask);
        if(supportSlot>=0 && phase==0 && aiTerrainMgr.GetReservationState(supportSlot)==3) {
            Check(true,"naval turret completed"); phase=1;
        }
        if(phase==1 && reactorTask !is null) {
            IBuilderTask@ bt=cast<IBuilderTask>(reactorTask);
            if(bt !is null && bt.target !is null && bt.target.GetBuildProgress()>0.01f) {
                progress=bt.target.GetBuildProgress();
                aiBuilderMgr.AbortTask(reactorTask); stopped=true; phase=2;
                Check(true,"air builder released");
            }
        }
        if(phase==2) {
            CCircuitUnit@ target=aiTerrainMgr.GetReservationUnit(landSlot);
            if(target !is null && target.GetBuildProgress()>progress+0.05f) {
                Check(true,"naval turret assists land"); phase=3;
            }
        }
        if (phase==4 && labTask !is null) {
            if (labSlot<0) labSlot=AiTaskReservationId(labTask);
            if (labSlot>=0 && aiTerrainMgr.GetReservationState(labSlot)==3) {
                Check(true,"reachable advanced factory completed"); phase=5;
            }
        }
    }
    IUnitTask@ Task(CCircuitUnit@ u) {
        if(!active) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
        const string name=u.circuitDef.GetName();
        if(name=="corcom" && !capability) {
            capability=true; Check(Layout::CoastalDefinition(u) is null,"incapable builder stays land only");
        }
        if(name=="corck" && phase==3) {
            CCircuitDef@ lab=ai.GetCircuitDef("coralab"); lab.maxThisUnit=100;
            if(Layout::labSlot<0) {
                Layout::labSlot=aiTerrainMgr.ReserveBuilding(lab,AIFloat3(2808,0,1800),0);
                Check(Layout::labSlot>=0 && !aiTerrainMgr.CanReachAtSafe(u,
                    aiTerrainMgr.GetReservationPos(Layout::labSlot),u.circuitDef.GetBuildDistance()),"ridge blocks original factory");
            }
            @labTask=Layout::T2LabTask(600*SECOND,u);
            if(labTask !is null) {phase=4; return labTask;}
        }
        if(name=="corck" && phase==4 && labTask !is null && !labTask.IsDead()) return labTask;
        if(name=="corcs" && phase==0 && !ordered) {
            // Exercise the policy entry and its native spatial validation.
            IUnitTask@ task=Layout::CoastalNanoTask(u,Task::Priority::HIGH);
            if(task !is null) { @supportTask=task; ordered=true;return task; }
        }
        if(name=="corcs" && u.task !is null && !u.task.IsDead() && ordered && phase==0) return u.task;
        if(name=="coraca" && phase==1 && !stopped) {
            if(reactorTask !is null && !reactorTask.IsDead()) return reactorTask;
            @reactorTask=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::ENERGY,Task::Priority::HIGH,
                ai.GetCircuitDef("corfus"),aiTerrainMgr.GetReservationPos(landSlot),0.f,false,600*SECOND));
            if(reactorTask !is null && !AiPinReservation(reactorTask,landSlot)) {
                aiBuilderMgr.AbortTask(reactorTask); @reactorTask=null; Check(false,"pin reactor");
            }
            if(reactorTask !is null) return reactorTask;
        }
        if(name=="cornanotcplat" && phase>=1) {
            IUnitTask@ task=RoleTech::Tech_TurretWork(u,false);
            if(task !is null) return task;
        }
        return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
    }
}

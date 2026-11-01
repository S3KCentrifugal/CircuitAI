namespace BootstrapProbe {
    bool active=false;
    int phase=0,last=-SECOND,first=-1,badSlot=-1,start=0;
    bool initialized=false;
    void Check(bool ok,const string& in label) {AiLog("[BootstrapTest] "+(ok?"PASS ":"FAIL ")+label);}
    bool Handle(const string& in message) {
        if(message!="bootstrap-init" || ai.teamId!=0) return false;
        if(!Global::Map::MapResolved) Setup::setupMap(AIFloat3(11184,0,2128));
        Check(Global::AISettings::Role==AiRole::TECH,"TECH role resolved");
        Layout::OnRoleLeave();Layout::Enable(true);Layout::planned=true;Layout::fallback=false;
        Layout::boxCentre=AIFloat3(11184,0,2128);Layout::homeCentre=Layout::boxCentre;
        @Layout::nano=ai.GetCircuitDef("cornanotc");Layout::nano.maxThisUnit=100;
        Layout::boxZone=aiTerrainMgr.ReserveZone(Layout::boxCentre,0,600,500,false);
        Layout::nanoGroup=aiTerrainMgr.LayBand(Layout::boxZone,Layout::nano,AIFloat3(11184,0,2228),0,4,4,0,true,true,false);
        Check(Layout::nanoGroup>0,"fixture reservations");
        TechChain::active=true;TechChain::done=false;TechChain::objective="nuke";
        Global::RoleSettings::Tech::NukeRushTurrets=2;
        // Deterministically reject even zero-threat connectors, then restore
        // the production threshold. This tests refusal, not enemy perception.
        Global::RoleSettings::Tech::RushBootstrapMaxThreat=-1.f;
        active=true;start=ai.frame;return true;
    }
    IUnitTask@ Task(CCircuitUnit@ u) {
        IBuilderTask@ current=cast<IBuilderTask>(u.task);
        if(current !is null && !current.IsDead() && current.GetBuildType()<int(Task::BuildType::REPAIR)) return u.task;
        if(active && u.circuitDef.GetName()=="corca") {
            IUnitTask@ t=RushBootstrap::TravelTask(u);if(t !is null) return t;
            @t=RushBootstrap::Work(u);if(t !is null) return t;
        }
        return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
    }
    void Tick() {
        if(!active || ai.frame<last+SECOND || ai.frame<300) return;
        last=ai.frame;
        if(!initialized) {
            TechChain::active=true;TechChain::done=false;TechChain::objective="nuke";
            initialized=true;
        }
        if(ai.frame%300==0) AiLog("[BootstrapTest] state enabled="+RushBootstrap::Enabled()+" needed="+RushBootstrap::Needed()
            +" requested="+RushBootstrap::requested+" workers="+OwnedEconomy::Workers(Layout::nano).length());
        RushBootstrap::Tick();
        if(phase==0 && ai.frame>start+15*SECOND) {
            Check(RushBootstrap::worker<0,"unsafe route refused");
            Global::RoleSettings::Tech::RushBootstrapMaxThreat=0.f;phase=1;
        }
        if(phase==1 && RushBootstrap::worker>=0) {
            first=RushBootstrap::worker;
            Check(aiTerrainMgr.GetReservationState(RushBootstrap::slot)==0,"one remote worker no claim");
            // A paid build task is never a recruit, including before its frame.
            CCircuitUnit@ u=ai.GetTeamUnit(first);
            IUnitTask@ paid=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::ENERGY,Task::Priority::HIGH,
                ai.GetCircuitDef("corsolar"),u.GetPos(ai.frame),0.f,true,60*SECOND));
            aiBuilderMgr.AssignTask(u,paid);
            Check(!RushBootstrap::Eligible(u) && u.task is paid,"protected construction retained");
            AiLog("[BootstrapTest] kill worker="+first);phase=2;
        }
        if(phase==2 && ai.GetTeamUnit(first) is null && RushBootstrap::worker>=0 && RushBootstrap::worker!=first) {
            Check(true,"lost worker replaced");badSlot=RushBootstrap::slot;
            aiTerrainMgr.ReleaseReservation(badSlot);phase=3;
        }
        if(phase==3 && RushBootstrap::worker>=0 && RushBootstrap::slot!=badSlot) {
            Check(true,"invalid slot recovered");phase=4;
        }
        if(phase==4 && Layout::nano.count-aiBuilderMgr.GetUnfinishedCount(Layout::nano)>=2) {
            Check(true,"completed support after travel");phase=5;
        }
    }
}

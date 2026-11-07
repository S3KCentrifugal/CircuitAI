namespace EcoFlakProbe {
    bool active=false;
    const bool compact=__COMPACT__;
    int compactGroup=0;
    int lastOrder=-100000;
    int traceFrame=-100000;
    void Check(bool ok,const string& in label) { GenericHelpers::LogUtil("[EcoFlakTest] "+(ok?"PASS ":"FAIL ")+label,1); }
    bool Handle(const string& in message) {
        if (message!="eco-flak-init" || ai.teamId!=0) return false;
        if (!Global::Map::MapResolved) Setup::setupMap(AIFloat3(1600,0,10100));
        Layout::OnRoleLeave();
        EcoFlak::Load();
        Check(Global::RoleSettings::Tech::EcoFlakMinimum==1 && EcoFlak::Maximum()==15
            && Global::RoleSettings::Tech::EcoFlakCooldownSeconds==30.f,"default policy");
        Global::RoleSettings::Tech::EcoFlakMaximum=3;
        Global::AISettings::Role=AiRole::TECH;
        Global::AISettings::Side="__SIDE__";
        Layout::Enable(true); Layout::planned=true; Layout::fallback=false;
        if (!compact) Layout::boxZone=aiTerrainMgr.ReserveZone(AIFloat3(1600,0,10100),0,200,200,false);
        else { Layout::fallback=true; Layout::homeCentre=AIFloat3(1600,0,10100); }
        @Layout::nano=ai.GetCircuitDef(UnitHelpers::GetT1NanoNameForSide(Global::AISettings::Side));
        // A supplied geometry envelope, not a replacement for ordinary eco planning.
        EcoFlak::Clear();
        if (!compact) { EcoFlak::Add(Layout::boxZone); Check(EcoFlak::clusters.length()==1,"geometry registered"); }
        EcoFlak::bases={AIFloat3(1600,0,10100)};
        Check(aiTerrainMgr.GetZoneCorner(-1,false).x<0,"missing geometry rejected");
        Check(EcoFlak::Enabled()==__ENABLED__,"profile gate");
        active=true; return true;
    }
    int checkFrame = -1;
    bool checkedWorker = false, checkedWindBefore = false, checkedWindAfter = false;
    void Tick() {
        if (!active) return;
        EcoFlak::Tick();
        if (ai.frame < checkFrame + SECOND) return;
        checkFrame = ai.frame;
        int assigned = 0;
        CCircuitDef@ flak = EcoFlak::Definition();
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint i = 0; i < ids.length(); ++i) {
            CCircuitUnit@ unit = ai.GetTeamUnit(ids[i]);
            if (unit is null || !unit.circuitDef.IsMobile()) continue;
            IBuilderTask@ task = cast<IBuilderTask>(unit.task);
            if (task !is null && task.buildDef is flak) ++assigned;
        }
        if (assigned > 1) Check(false, "single flak constructor");
        if (assigned == 1 && !checkedWorker) { checkedWorker=true; Check(true,"single flak constructor"); }
        CCircuitDef@ wind = ai.GetCircuitDef(UnitHelpers::GetWindNameForSide(Global::AISettings::Side));
        CCircuitUnit@ target = aiBuilderMgr.FindOwnNear(Layout::BaseCentre(),4000.f,wind);
        if (target is null) return;
        const bool afus = TechBuild::FinishedOf(UnitHelpers::GetAdvFusionNameForSide(Global::AISettings::Side)) > 0;
        if (!afus && !checkedWindBefore) {
            checkedWindBefore=true; Check(!TechReclaim::Allowed(target,"probe"),"wind protected before AFUS");
        }
        if (afus && !checkedWindAfter) {
            checkedWindAfter=true; Check(TechReclaim::Allowed(target,"probe"),"wind eligible after AFUS");
        }
    }
    IUnitTask@ Task(CCircuitUnit@ u) {
        if (active && ai.teamId==0 && UnitHelpers::IsAirConstructor(u.circuitDef)) {
            if (compact && compactGroup==0) {
                int slot=-1; compactGroup=CompactEco::Grow(u,null,slot);
                if (compactGroup==0) return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
                EcoFlak::tickFrame=-100000;
                EcoFlak::Tick();
                Check(CompactEco::Active() && !Layout::HasComplex() && EcoFlak::clusters.length()==1,"geometry registered");
            }
            IUnitTask@ current=TechBuild::KeepCurrent(u);
            if (current !is null) return current;
            IUnitTask@ t=EcoFlak::Work(u);
            if (ai.frame>=traceFrame+30*SECOND) {
                traceFrame=ai.frame;
                EcoFlak::Cluster@ c=EcoFlak::clusters[0];
                CCircuitDef@ d=EcoFlak::Definition();
                GenericHelpers::LogUtil("[EcoFlakTest] state enabled="+EcoFlak::Enabled()+" desired="+c.desired
                    +" first="+c.sites[0].x+","+c.sites[0].z+" cursor="+c.cursor+" retry="+c.retry
                    +" canBuild="+u.circuitDef.CanBuild(d)+" allowed="+d.IsBuildAllowed()+" available="+d.IsAvailable(ai.frame),1);
            }
            if(t !is null) {
                IBuilderTask@ build = cast<IBuilderTask>(t);
                if (build !is null && build.GetBuildType() < int(Task::BuildType::REPAIR) && t !is u.task) {
                    Check(ai.frame-lastOrder>=30*SECOND,"order cooldown"); lastOrder=ai.frame;
                    const AIFloat3 p=aiTerrainMgr.GetReservationPos(AiTaskReservationId(t));
                    Check(EcoFlak::OutsideEconomy(p),"physical order outside economy");
                }
                if (compact) Check(aiTerrainMgr.GetGroupCount(compactGroup,false)==1,"compact economy unchanged");
                return t;
            }
            IUnitTask@ assist=TechBuild::AssistAny(u,4000.f);
            if (assist !is null) return assist;
        }
        return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
    }
}

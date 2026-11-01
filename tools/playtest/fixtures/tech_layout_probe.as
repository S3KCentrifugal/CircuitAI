namespace TechLayoutProbe {
    int phase=0,worker=-1,reactorWorker=-1,anchor=-1,slot=-1;
    AIFloat3 site;
    IUnitTask@ work;
    IUnitTask@ Retain(CCircuitUnit@ u) {
        if(u.id==worker && work !is null && !work.IsDead()) return work;
        return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
    }
    void Check(const string& in key,bool pass) { AiLog("[TechLayoutProbe] "+(pass?"PASS ":"FAIL ")+key); }
    void Tick() {
        if(ai.teamId!=0) return;
        if(phase==0 && ai.frame>=30*SECOND) {
            phase=1;
            array<int>@ ids=ai.GetOwnedUnitIds();
            for(uint i=0;i<ids.length();++i) {
                const string name=ai.GetTeamUnit(ids[i]).circuitDef.GetName();
                if(name=="coraca") reactorWorker=ids[i];
                if(name=="corca") worker=ids[i];
                if(name=="corack") anchor=ids[i];
            }
            @Layout::nano=ai.GetCircuitDef("cornanotc");Layout::nano.maxThisUnit=100;
            Layout::planned=true;Layout::fallback=false;Layout::facing=0;Layout::extraZones.resize(0);
            Layout::boxCentre=AIFloat3(5000,0,1500);Layout::fwdCentre=AIFloat3(5000,0,3000);
            Layout::boxZone=aiTerrainMgr.ReserveZone(Layout::boxCentre,0,96,96,false);
            Layout::fwdZone=aiTerrainMgr.ReserveZone(Layout::fwdCentre,0,256,256,false);
            Layout::nanoGroup=aiTerrainMgr.LayBand(Layout::boxZone,Layout::nano,Layout::boxCentre,0,4,2,0,true,true,true);
            Layout::fwdGroup=aiTerrainMgr.LayBand(Layout::fwdZone,Layout::nano,Layout::fwdCentre,0,4,2,0,true,true,true);
            CCircuitDef@ af=ai.GetCircuitDef("corafus");af.maxThisUnit=20;
            Check("fixture",worker>=0 && reactorWorker>=0 && anchor>=0 && Layout::nanoGroup>0 && Layout::fwdGroup>0);
            if(worker<0 || Layout::nanoGroup<=0) return;
            slot=Layout::PackSetAnywhere(af,Layout::boxCentre,1);
            site=aiTerrainMgr.GetReservationPos(slot);
            Check("primary_ring_first",slot>=0 && site.distance2D(Layout::boxCentre)<600 && !Layout::economyOverflowNeeded);
            Check("planned_is_not_build_power",!Layout::HasEconomySupport(site));
            bool west=false,east=false,north=false,south=false,overflow=false,full=true;
            for(int k=0;k<80;++k) {
                const int next=Layout::PackSetAnywhere(af,Layout::boxCentre,1);
                if(next<0) break;
                const AIFloat3 at=aiTerrainMgr.GetReservationPos(next);
                if(at.distance2D(Layout::fwdCentre)<600) {
                    overflow=true;
                    full=aiTerrainMgr.PackSet(Layout::boxZone,af,Layout::nanoGroup,0,Layout::boxCentre,1,true,-1)<0;
                    break;
                }
                west=west || at.x<Layout::boxCentre.x-96;
                east=east || at.x>Layout::boxCentre.x+96;
                north=north || at.z<Layout::boxCentre.z-96;
                south=south || at.z>Layout::boxCentre.z+96;
            }
            Check("all_sides_used",west && east && north && south);
            Check("overflow_only_when_full",overflow && full);

            // Bind a distant engineering cohort through the real native entry.
            // The home aircraft is not enrolled and must not inherit its radius.
            aiBuilderMgr.SupportDefenseWork(ai.GetTeamUnit(reactorWorker),anchor,anchor,-1,-1);
            Check("distant_support_bound",anchor>=0
                && ai.GetTeamUnit(anchor).GetPos(ai.frame).distance2D(site)>1200);

            Layout::PrepareEconomySupport(site);
            @work=Layout::EconomySupport(ai.GetTeamUnit(worker));
            Check("support_ordered",work !is null && cast<IBuilderTask>(work).buildDef is Layout::nano);
            if(work !is null) aiBuilderMgr.AssignTask(ai.GetTeamUnit(worker),work);
        }
        if(phase==1 && Layout::HasEconomySupport(site)) {
            phase=2;Check("support_completed",true);worker=reactorWorker;
            @work=Layout::Place(Task::BuildType::ENERGY,Task::Priority::HIGH,ai.GetCircuitDef("corafus"),120*SECOND,ai.GetTeamUnit(worker));
            IBuilderTask@ build=cast<IBuilderTask>(work);
            Check("reactor_supported",build !is null && build.buildDef.GetName()=="corafus" && Layout::HasEconomySupport(build.GetBuildPos()));
            if(work !is null) aiBuilderMgr.AssignTask(ai.GetTeamUnit(worker),work);
        }
        if(phase==2) {
            IBuilderTask@ build=cast<IBuilderTask>(work);
            CCircuitUnit@ frame=build is null ? null : build.target;
            if(frame is null || frame.GetBuildProgress()<=0.001f) return;
            phase=3;
            Check("home_air_builds_with_engineers",frame.circuitDef.GetName()=="corafus");
            AiLog("[TechLayoutProbe] complete");
        }
    }
}

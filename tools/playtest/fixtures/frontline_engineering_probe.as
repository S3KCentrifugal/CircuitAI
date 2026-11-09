namespace EngineeringProbe {
    int phase=0, selectedAt=-1;
    array<int> workers;
    array<AIFloat3> starts;
    array<bool> relocated;
    array<bool> deployed;
    array<int> helpers;
    bool cooperative=false, isolated=true,emergencyChecked=false,followChecked=false;
    int lostHelper=-1;
    void Check(const string& in name,bool pass) {
        AiLog("[EngineeringProbe] "+(pass?"PASS ":"FAIL ")+name);
    }
    void Tick() {
        if(ai.teamId!=0) return;
        if(phase==0 && ai.frame>=30*SECOND) {
            phase=1;
            array<int>@ ids=ai.GetOwnedUnitIds();
            for(uint i=0;i<ids.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
                if(u !is null && (u.circuitDef.GetName()=="armack" || u.circuitDef.GetName()=="corack")) {
                    workers.insertLast(u.id);starts.insertLast(u.GetPos(ai.frame));relocated.insertLast(false);deployed.insertLast(false);
                }
                if(u !is null && u.circuitDef.GetName()=="corfast") helpers.insertLast(u.id);
            }
            Check("fixture",workers.length()==3 && TechForward::T2Released());
            FrontlineEngineering::Load();
            // Supplied funding isolates the shared planner/placement contract.
            aiBuilderMgr.SetDefenseRule(2,"metal",0);
            aiBuilderMgr.SetDefenseRule(2,"energy",0);
            aiBuilderMgr.SetDefenseRule(2,"seconds",300);
            aiBuilderMgr.SetDefenseRule(-1,"surplus_energy_margin",0);
            EngineeringLanes::lanes.resize(0);
            for(int i=0;i<2;++i) {
                EngineeringLanes::Lane@ lane=EngineeringLanes::Lane();
                lane.team=i+1;lane.share=i==0?.2f:.6f;
                lane.station=AIFloat3(i==0?4500:4000,0,1600);
                EngineeringLanes::lanes.insertLast(lane);
            }
            FrontlineEngineering::reassess=-1;
            if(helpers.length()>0) {
                // A helper disappearing between roster callbacks must not
                // prevent healthy constructors from accepting a safe lane.
                FrontlineEngineering::Seat@ unavailable=FrontlineEngineering::Seat();
                unavailable.helper=true;
                FrontlineEngineering::seats.insertAt(0,unavailable);
                FrontlineEngineering::SelectLane();
                FrontlineEngineering::seats.removeAt(0);
                Check("unavailable_helper_no_veto",FrontlineEngineering::target==1);
                // Supplied fusion occupies this station center. Arrival is an
                // area: a verified route to its open edge must remain usable.
                CCircuitUnit@ worker=ai.GetTeamUnit(workers[0]);
                const AIFloat3 occupied(2500,0,2500);
                array<AIFloat3>@ exact=FrontlineEngineering::ExactSafeRoute(worker,occupied);
                array<AIFloat3>@ nearby=FrontlineEngineering::SafeRoute(worker,occupied);
                Check("occupied_station_edge",exact.length()==0 && nearby.length()>0
                    && nearby[nearby.length()-1].distance2D(occupied)<=FrontlineEngineering::arrival);
            }
        }
        if(phase==0) return;
        for(uint i=0;i<workers.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(workers[i]);
            if(u !is null && FrontlineEngineering::target==1 && u.GetPos(ai.frame).distance2D(starts[i])>32
                && u.GetPos(ai.frame).distance2D(FrontlineEngineering::station)<=FrontlineEngineering::arrival) deployed[i]=true;
        }
        // These are supplied normalized lane summaries, not natural map evidence.
        for(uint i=0;i<EngineeringLanes::lanes.length();++i) {
            EngineeringLanes::Lane@ lane=EngineeringLanes::lanes[i];
            lane.frame=ai.frame;
            lane.share=lane.team==1?.2f:(phase>=2?.1f:.6f);
            lane.station=AIFloat3(lane.team==1?(helpers.length()>0 && ai.frame>=120*SECOND?4800:4500):4000,0,1600);
            if(helpers.length()>0) lane.combatDistance=100;
        }
        if(helpers.length()>0) {
            if(!followChecked && ai.frame>=160*SECOND) {
                followChecked=true;
                Check("follows_current_lane",FrontlineEngineering::target==1 && FrontlineEngineering::station.x==4800
                    && FrontlineEngineering::reassess==selectedAt+300*SECOND);
            }
            int building=0;
            for(uint i=0;i<helpers.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(helpers[i]);
                IBuilderTask@ task=u is null?null:cast<IBuilderTask>(u.task);
                if(task !is null && task.buildDef !is null && task.buildDef.GetName()=="corpyro") ++building;
            }
            cooperative=cooperative || building>=2;
            for(uint i=0;i<workers.length();++i) {
                IBuilderTask@ task=cast<IBuilderTask>(ai.GetTeamUnit(workers[i]).task);
                if(task !is null && task.buildDef !is null && task.buildDef.GetName()=="corpyro") isolated=false;
            }
            if(!emergencyChecked && ai.frame>=220*SECOND) {
                emergencyChecked=true;
                CCircuitUnit@ factory=aiBuilderMgr.FindOwnNear(AIFloat3(3000,0,2800),500,ai.GetCircuitDef("coralab"));
                EngineeringReplacements::Lost(ai.GetCircuitDef("corfast").id);
                Check("base_emergency_blocks_replacement",factory !is null && EngineeringReplacements::BaseEmergency()
                    && EngineeringReplacements::Recruit(factory) is null);
                for(uint i=0;i<EngineeringReplacements::needs.length();++i)
                    if(EngineeringReplacements::needs[i].def==ai.GetCircuitDef("corfast").id) --EngineeringReplacements::needs[i].count;
            }
        }
        if(phase==1 && ai.frame>=35*SECOND) {
            phase=2;selectedAt=FrontlineEngineering::reassess-300*SECOND;
            Check("least_progress",FrontlineEngineering::target==1 && selectedAt>=30*SECOND);
            EngineeringLanes::lanes[1].share=.1f;
        }
        if(phase==2 && ai.frame>=90*SECOND) {
            phase=3;bool moved=true;
            for(uint i=0;i<workers.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(workers[i]);
                moved=moved && u !is null && deployed[i];
            }
            Check("physical_travel",moved);
            Check("no_early_switch",FrontlineEngineering::target==1);
            AiLog("[EngineeringProbe] defense="+aiBuilderMgr.DescribeDefense()+" pbCap="+ai.GetCircuitDef("armpb").maxThisUnit);
            const AIFloat3 danger(6500,0,5500);
            array<AIFloat3>@ rejected=FrontlineEngineering::SafeRoute(ai.GetTeamUnit(workers[0]),danger);
            AiLog("[EngineeringProbe] danger="+aiBattle.SurfThreat(danger)+" route="+rejected.length());
            Check("unsafe_route_rejected",aiBattle.SurfThreat(danger)>0 && rejected.length()==0);
            if(helpers.length()>0) {
                Check("helpers_joined",FrontlineEngineering::seats.length()==5);
                Check("twitchers_cooperate",cooperative);
                Check("constructors_ignore_fiends",isolated);
                lostHelper=helpers[0];ai.GetTeamUnit(lostHelper).SelfDestruct(true);
            }
        }
        if(phase==3 && ai.frame>=selectedAt+300*SECOND+2*SECOND) {
            phase=4;
            for(uint i=0;i<workers.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(workers[i]);
                array<AIFloat3>@ path=FrontlineEngineering::SafeRoute(u,EngineeringLanes::lanes[1].station);
                array<AIFloat3>@ raw=aiBattle.GetUnitTerrainRoute(u.circuitDef,u.GetPos(ai.frame),EngineeringLanes::lanes[1].station,true,1,1,10000,0);
                AiLog("[EngineeringProbe] member="+u.id+" route="+path.length()+" raw="+raw.length()+" startThreat="+aiBattle.SurfThreat(u.GetPos(ai.frame))+" endThreat="+aiBattle.SurfThreat(EngineeringLanes::lanes[1].station)+" protected="+FrontlineEngineering::Protected(u));
            }
            AiLog("[EngineeringProbe] target="+FrontlineEngineering::target+" next="+FrontlineEngineering::reassess+" selected="+selectedAt);
            Check("five_minute_switch",FrontlineEngineering::target==2);
            CCircuitDef@ pit=ai.GetCircuitDef(helpers.length()>0?"corvipe":"armpb");
            Check("t2_defense_built",pit.count-aiBuilderMgr.GetUnfinishedCount(pit)>0);
            Check("no_t1_defense",ai.GetCircuitDef("armbeamer").count==0 && ai.GetCircuitDef("armhlt").count==0
                && ai.GetCircuitDef("corhllt").count==0 && ai.GetCircuitDef("corhlt").count==0);
            if(helpers.length()>0) {
                Check("fiend_completed",ai.GetCircuitDef("corpyro").count>0);
                bool replaced=ai.GetTeamUnit(lostHelper) is null && FrontlineEngineering::seats.length()==5;
                Check("lost_helper_replaced",replaced && ai.GetCircuitDef("corfast").count==2);
            }
        }
        if(phase==4) {
            // Arrival is an event: subsequent defense placement may move a
            // constructor outside the arrival circle again.
            for(uint i=0;i<workers.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(workers[i]);
                if(u !is null && FrontlineEngineering::target==2
                    && u.GetPos(ai.frame).distance2D(FrontlineEngineering::station)<=FrontlineEngineering::arrival) relocated[i]=true;
            }
        }
        if(phase==4 && ai.frame>=selectedAt+360*SECOND) {
            bool arrived=FrontlineEngineering::target==2;
            for(uint i=0;i<relocated.length();++i) arrived=arrived && relocated[i];
            // Engineering must finish construction before moving. This is an
            // event completion check, not a sixty-second cancellation deadline.
            if(!arrived && helpers.length()>0 && ai.frame<600*SECOND) return;
            phase=5;
            for(uint i=0;i<workers.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(workers[i]);
                AiLog("[EngineeringProbe] arrival member="+workers[i]+" reached="+relocated[i]+" distance="+(u is null?-1:u.GetPos(ai.frame).distance2D(FrontlineEngineering::station)));
                arrived=arrived && u !is null && relocated[i];
            }
            Check("relocation_arrived",arrived);
            AiLog("[EngineeringProbe] complete");
        }
    }
}

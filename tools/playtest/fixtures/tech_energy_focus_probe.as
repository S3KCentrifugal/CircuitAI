namespace TechEnergyFocusProbe {
    int phase=0;
    int bot=-1,air=-1,t1=-1,twitch=-1;
    IUnitTask@ reactor;
    IUnitTask@ product;
    IUnitTask@ Retain(CCircuitUnit@ u) {
        if(phase!=1) return null;
        if(u.id==bot && reactor !is null && !reactor.IsDead()) return reactor;
        if(u.id==twitch && product !is null && !product.IsDead()) return product;
        return null;
    }
    void Check(const string& in key,bool pass) { AiLog("[TechEnergyFocus] "+(pass?"PASS ":"FAIL ")+key); }
    void Tick() {
        if(ai.teamId!=0) return;
        if(phase==0 && ai.frame>=30*SECOND) {
            phase=1;
            // This fixture deliberately builds one mobile target below normal income.
            Global::RoleSettings::Tech::PlanCombatGate=0;
            Global::RoleSettings::Tech::PlanT3RushCombatGate=0;
            array<int>@ ids=ai.GetOwnedUnitIds();
            for(uint i=0;i<ids.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
                const string n=u.circuitDef.GetName();
                if(n=="corack") bot=u.id;
                if(n=="coraca") air=u.id;
                if(n=="corca") t1=u.id;
                if(n=="corfast") twitch=u.id;
            }
            Check("fixture",bot>=0 && air>=0 && t1>=0 && twitch>=0);
            if(bot<0 || air<0 || t1<0 || twitch<0) return;
            CCircuitDef@ def=ai.GetCircuitDef("corafus");def.maxThisUnit=10;
            Check("initial_admission",TechBuild::CanStartAfus(def));
            @reactor=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::ENERGY,Task::Priority::HIGH,def,AIFloat3(4200,0,1600),0,true,300*SECOND));
            Check("queued_blocks_second",reactor !is null && !TechBuild::CanStartAfus(def)
                && Layout::Place(Task::BuildType::ENERGY,Task::Priority::HIGH,def,300*SECOND,ai.GetTeamUnit(air)) is null);
            ai.GetTeamUnit(bot).DelAttribute(Unit::Attr::SOLO.type);
            aiBuilderMgr.AssignTask(ai.GetTeamUnit(bot),reactor);
            CCircuitDef@ fiend=ai.GetCircuitDef("corpyro");fiend.maxThisUnit=10;
            @product=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::RECRUIT,Task::Priority::NORMAL,fiend,AIFloat3(5400,0,1600),0,true,300*SECOND));
            aiBuilderMgr.AssignTask(ai.GetTeamUnit(twitch),product);
        }
        if(phase==1 && ai.frame>=31*SECOND) {
            CCircuitDef@ def=ai.GetCircuitDef("corafus");
            CCircuitUnit@ frame=cast<IBuilderTask>(reactor).target;
            CCircuitUnit@ fiend=cast<IBuilderTask>(product).target;
            if((frame is null || fiend is null) && ai.frame<90*SECOND) return;
            phase=2;
            Check("both_frames_exist",frame !is null && fiend !is null);
            Check("framed_blocks_second",!TechBuild::CanStartAfus(def));
            Check("t1_rejects_fiend",fiend !is null
                && ai.GetTeamUnit(t1).GetPos(ai.frame).distance2D(fiend.GetPos(ai.frame))<=300
                && TechBuild::AssistAny(ai.GetTeamUnit(t1),300) is null);
            TechRules::Ctx context;@context.u=ai.GetTeamUnit(air);
            IUnitTask@ help=TechRules::DoAirReactor(context);
            IBuilderTask@ repair=cast<IBuilderTask>(help);
            Check("idle_air_assists_reactor",repair !is null && repair.target !is null
                && frame !is null && repair.target.id==frame.id);
            if(help !is null) aiBuilderMgr.AssignTask(ai.GetTeamUnit(air),help);
            // Losing the original builder task must not unlock another reactor
            // while its physical unfinished frame still exists.
            if(reactor !is null) aiBuilderMgr.AbortTask(reactor);
            Check("orphan_blocks_second",!TechBuild::CanStartAfus(def));
            AiLog("[TechEnergyFocus] complete");
        }
    }
}

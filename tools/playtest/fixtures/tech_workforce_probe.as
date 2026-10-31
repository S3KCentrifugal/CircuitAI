namespace TechWorkforceProbe {
    bool done = false;
    void Check(const string& in name, bool pass) {
        AiLog("[TechWorkforce] " + (pass ? "PASS " : "FAIL ") + name);
    }
    void Tick() {
        if (done || ai.teamId != 0 || ai.frame < 30 * SECOND) return;
        done = true;
        Global::AISettings::Role = AiRole::TECH;
        Global::RoleSettings::Tech::HeavyRushEnabled = false;
        TechChain::active = false;
        CCircuitDef@ ctor = ai.GetCircuitDef("armack");
        CCircuitDef@ assist = ai.GetCircuitDef("armfark");
        array<CCircuitUnit@> labs;
        array<int>@ ids = ai.GetOwnedUnitIds();
        for (uint i=0; i<ids.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
            if (u !is null && u.circuitDef.GetName()=="armalab") labs.insertLast(u);
        }
        Check("fixture", labs.length()==2 && ctor.count==3 && assist.count==4);
        if (labs.length()!=2) return;
        @Factory::primaryT2BotLab = labs[0];
        Team::Donation::pendingRequests.resize(0);
        Team::Donation::ordered = 0;
        RoleTech::Tech_IncomeBuilderLimits(100);
        IUnitTask@ first = RoleTech::Tech_FactoryAiMakeTask(labs[0]);
        Check("assist_replaces_surplus_constructor", first !is null
            && aiFactoryMgr.GetPendingRecruitCount(ctor)==0 && aiFactoryMgr.GetPendingRecruitCount(assist)==1);
        IUnitTask@ second = RoleTech::Tech_FactoryAiMakeTask(labs[0]);
        Check("queued_assist_counts", aiFactoryMgr.GetPendingRecruitCount(assist)==1
            && assist.count+aiFactoryMgr.GetPendingRecruitCount(assist)==5);
        IUnitTask@ other = RoleTech::Tech_FactoryAiMakeTask(labs[1]);
        Check("second_lab_no_constructor", aiFactoryMgr.GetPendingRecruitCount(ctor)==0);
        if (first !is null) aiFactoryMgr.AbortTask(first);
        if (second !is null && second !is first) aiFactoryMgr.AbortTask(second);
        if (other !is null && other !is first && other !is second) aiFactoryMgr.AbortTask(other);
        Team::Donation::HandleMessage("barbdon|conreq",1);
        IUnitTask@ delivery = Team::Donation::FactoryMakeTask(labs[0]);
        Check("donation_admitted_at_home_cap", delivery !is null && ctor.maxThisUnit==4);
        Check("donation_queue_counted", aiFactoryMgr.GetPendingRecruitCount(ctor)==1
            && ctor.count+aiFactoryMgr.GetPendingRecruitCount(ctor)==4);
        RoleTech::Tech_IncomeBuilderLimits(100);
        Check("economy_preserves_delivery_headroom", ctor.maxThisUnit==4);
        if (delivery !is null) aiFactoryMgr.AbortTask(delivery);
        Team::Donation::pendingRequests.resize(0);
        Team::Donation::ordered = 0;
        RoleTech::Tech_IncomeBuilderLimits(100);
        Check("headroom_released", ctor.maxThisUnit==3 && aiFactoryMgr.GetPendingRecruitCount(ctor)==0);
        AiLog("[TechWorkforce] complete");
    }
}

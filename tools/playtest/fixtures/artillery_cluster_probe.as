// Supplied construction fixture; only staged copies include this module.
namespace ArtilleryClusterProbe {
    bool ready=false, boundaries=false;
    dictionary crewChecked;
    bool t2=__T2__;
    bool faults=__FAULTS__, cancelled=false, changedTier=false;
    IUnitTask@ cancelledTask;
    const string side="__SIDE__";
    void Check(const string& in label, bool pass) {
        GenericHelpers::LogUtil("[ArtilleryTest] "+(pass?"PASS ":"FAIL ")+label,1);
    }
    IUnitTask@ Work(CCircuitUnit@ u) {
        if (u is null) return null;
        if (ready && (!t2 || ai.frame>=12*MINUTE)) {
            IUnitTask@ t=FrontAgitator::Work(u);
            if (t !is null) return t;
        }
        return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
    }
    void Tick() {
        if (ai.teamId!=0 || ai.frame<5*SECOND) return;
        if (!Global::Map::MapResolved) Setup::setupMap(AIFloat3(1536,0,3840));
        Global::AISettings::Role=AiRole::FRONT;
        Global::AISettings::Side=side;
        Global::LolCannon::Enabled=false;
        Global::RoleSettings::Front::Agitator=true;
        Global::RoleSettings::Front::SpecialPorc=true;
        Economy::_UpdateSlidingMinima(ai.frame,(t2||changedTier)?65.0f:35.0f,10000.0f);
        if (!boundaries) {
            boundaries=true;
            Check("before twelve minutes stays T1",!FrontAgitator::UseT2At(12*MINUTE-1,65.0f));
            Check("below sixty five stays T1",!FrontAgitator::UseT2At(12*MINUTE,64.99f));
            Check("exact boundaries use T2",FrontAgitator::UseT2At(12*MINUTE,65.0f));
            Check("null worker safe",FrontAgitator::Work(null) is null);
            GenericHelpers::LogUtil("[ArtilleryTest] fixture ready side="+side+" t2="+t2,1);
            ready=true;
        }
        if (t2 && ai.frame<12*MINUTE) return;
        if (faults && !cancelled && FrontAgitator::prep !is null) {
            IUnitTask@ current=FrontAgitator::kinds[FrontAgitator::prep.kind].order;
            IBuilderTask@ b=cast<IBuilderTask>(current);
            if (b !is null && !b.IsDead() && b.target !is null && b.buildDef !is null
                && b.buildDef is FrontAgitator::prep.defs[1] && b.target.GetBuildProgress()<1.0f) {
                @cancelledTask=current; cancelled=true;
                aiBuilderMgr.AbortTask(cancelledTask);
                Check("cancelled task dead",cancelledTask.IsDead());
                // Force a mode transition in the staged fixture only; the
                // normal T2 matrix independently waits the real 12 minutes.
                Global::RoleSettings::Front::SpecialPorcMinGameSeconds=0;
                changedTier=true;
                GenericHelpers::LogUtil("[ArtilleryTest] forced mid-chain tier transition",1);
            }
        }
        if (FrontAgitator::prep !is null && ai.frame%(30*SECOND)==0) {
            for (uint j=0;j<4;++j)
                GenericHelpers::LogUtil("[ArtilleryTest] slot step="+j+" unit="+FrontAgitator::prep.units[j]
                    +" state="+aiTerrainMgr.GetReservationState(FrontAgitator::prep.slots[j]),1);
        }
        array<int>@ ids=ai.GetOwnedUnitIds();
        for (uint i=0;i<ids.length();++i) {
            CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
            if (u !is null && u.circuitDef !is null && u.circuitDef.GetName()=="corhllt" && ai.frame%(30*SECOND)==0)
                GenericHelpers::LogUtil("[ArtilleryTest] actual light id="+u.id+" pos="+u.GetPos(ai.frame).x+","+u.GetPos(ai.frame).z
                    +" plan="+(FrontAgitator::prep is null?"none":""+FrontAgitator::prep.pos[2].x+","+FrontAgitator::prep.pos[2].z),1);
            if (u is null || u.circuitDef is null || UnitHelpers::IsCommander(u.circuitDef)
                || !u.circuitDef.IsMobile() || u.circuitDef.GetBuildSpeed()<=0) continue;
            if (FrontAgitator::OnOrder(u)) {
                if (FrontMexUp::Helper(u)) Check("project crew not mex helper",false);
                else if (!crewChecked.exists(""+u.id)) { crewChecked.set(""+u.id,true); Check("project crew not mex helper",true); }
                continue;
            }
            if (!FrontFactoryNanos::Free(u)) continue;
            if (FrontAgitator::prep !is null && ai.frame%(30*SECOND)==0)
                GenericHelpers::LogUtil("[ArtilleryTest] worker="+u.circuitDef.GetName()+" gun buildable="
                    +u.circuitDef.CanBuild(FrontAgitator::prep.defs[3])+" available="+FrontAgitator::prep.defs[3].IsAvailable(ai.frame),1);
            IUnitTask@ t=FrontAgitator::Work(u);
            if (t !is null && cancelledTask !is null) Check("cancelled task never reused",t !is cancelledTask && cancelledTask.IsDead());
            @u=ai.GetTeamUnit(ids[i]);
            if (u !is null && t !is null && !t.IsDead()) aiBuilderMgr.AssignTask(u,t);
        }
    }
}

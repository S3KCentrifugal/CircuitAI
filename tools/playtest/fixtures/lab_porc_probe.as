// Injected only into isolated construction regressions. Real planner/native
// tasks issue all construction commands; the fixture supplies the situation.
namespace LabPorcProbe {
    int primary=-1, helper=-1, spare=-1, gun=-1, phase=0;
    int started=0, cancelledAt=-1;
    IUnitTask@ project;
    IUnitTask@ cancelled;
    bool cancellation=__CANCEL__;
    bool loss=__LOSS__;
    bool shared=__SHARED__;
    bool ready=false;
    bool finished=false;
    void Check(const string& in label, bool pass) {
        GenericHelpers::LogUtil("[LabPorcTest] "+(pass?"PASS ":"FAIL ")+label,1);
    }
    IUnitTask@ Work(CCircuitUnit@ u) {
        // Explicit fixture assignments exercise the planner without unrelated
        // default economy orders competing for supplied workers.
        if (u !is null && ready && u.task !is null && !u.task.IsDead()
            && FrontLabPorc::IsOurs(u.task)) return u.task;
        IBuilderTask@ b=u is null ? null : cast<IBuilderTask>(u.task);
        if (b !is null && !b.IsDead() && (b.GetBuildType()==int(Task::BuildType::GUARD)
            || b.GetBuildType()==int(Task::BuildType::PATROL))) return u.task;
        if (b !is null && !b.IsDead() && b.GetBuildType()==int(Task::BuildType::REPAIR)
            && b.target !is null && b.target.GetBuildProgress()<1.0f) return u.task;
        return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
    }
    void Tick() {
        if (ai.teamId!=0) return;
        if (ai.frame<5*SECOND) return;
        if (!Global::Map::MapResolved) Setup::setupMap(AIFloat3(1536,0,3840));
        Global::AISettings::Role=AiRole::FRONT;
        Global::AISettings::Side="cortex";
        Global::LolCannon::Enabled=false;
        Global::RoleSettings::Front::LabPorc=true;
        Global::RoleSettings::Front::LabPorcPopupMetalIncome=0;
        Global::RoleSettings::Front::LabPorcTier={1};
        Global::RoleSettings::Front::MexUpgradeFirst=true;
        if (!ready && ai.frame>=10*SECOND) {
            array<int>@ ids=ai.GetOwnedUnitIds();
            array<int> workers;
            int lab=-1;
            for (uint i=0;i<ids.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
                if (u is null || u.circuitDef is null) continue;
                if (u.circuitDef.GetName()=="coracv") workers.insertLast(u.id);
                if (u.circuitDef.GetName()=="coravp") lab=u.id;
            }
            if (workers.length()<3 || lab<0) return;
            workers.sortAsc();
            primary=workers[0]; helper=workers[1]; spare=workers[2];
            @project=FrontLabPorc::Work(ai.GetTeamUnit(primary));
            if (project is null || project.IsDead()) return;
            ready=true; started=ai.frame;
            aiBuilderMgr.AssignTask(ai.GetTeamUnit(primary),project);
            if (shared) aiBuilderMgr.AssignTask(ai.GetTeamUnit(helper),project);
            else aiBuilderMgr.AssignTask(ai.GetTeamUnit(helper),aiBuilderMgr.Enqueue(TaskB::Guard(
                Task::Priority::LOW,ai.GetTeamUnit(lab),true,120*SECOND)));
            Check("fixture ready",true);
        }
        if (!ready || finished) return;
        if (phase==0 && ai.frame>=started+SECOND) {
            CCircuitUnit@ candidate=ai.GetTeamUnit(helper);
            IBuilderTask@ cb=candidate is null ? null : cast<IBuilderTask>(candidate.task);
            GenericHelpers::LogUtil("[LabPorcTest] helper state id="+helper+" task="
                +(candidate is null || candidate.task is null ? -1 : candidate.task.GetType())+" build="
                +(cb is null ? -1 : cb.GetBuildType())+" eligible="+FrontMexUp::Helper(candidate)
                +" crew="+LolCannon::IsCrew(helper)+" age="+(ai.frame-FrontMexUp::lastScan),1);
            __HELP_DIAG__
            FrontMexUp::Update();
            CCircuitUnit@ a=ai.GetTeamUnit(primary);
            CCircuitUnit@ b=ai.GetTeamUnit(helper);
            Check("helper joined active defence",a !is null && b !is null && a.task is project && b.task is project);
            Check("shared defence is not expendable",a !is null && !FrontMexUp::Helper(a));
            __NULL_CHECK__
            phase=1;
        }
        IBuilderTask@ build=cast<IBuilderTask>(project);
        // A builder can die before the nanoframe is attributed to its original
        // task. Observe the real owned structure independently of that handle.
        if (gun<0) {
            array<int>@ ids=ai.GetOwnedUnitIds();
            for (uint i=0;i<ids.length();++i) {
                CCircuitUnit@ f=ai.GetTeamUnit(ids[i]);
                if (f !is null && f.circuitDef !is null && f.circuitDef.GetName()=="corvipe") { gun=f.id; break; }
            }
        }
        if (phase==1 && build !is null && !build.IsDead() && gun>=0) {
            CCircuitUnit@ frame=ai.GetTeamUnit(gun);
            if (frame is null || frame.GetBuildProgress()>=1.0f) return;
            __REPAIR_CHECK__
            if (cancellation) {
                @cancelled=project;
                aiBuilderMgr.AbortTask(cancelled);
                Check("cancelled task dead",cancelled.IsDead());
                cancelledAt=ai.frame; phase=4; @project=null;
                return;
            }
            phase=2;
        }
        if (phase==4) {
            // Honour the real planner's failure backoff. Workers idle through
            // native cleanup, then receive a fresh repair of the original ID.
            @project=FrontLabPorc::Work(ai.GetTeamUnit(primary));
            if (project is null) return;
            Check("backoff honoured",ai.frame-cancelledAt>=10*SECOND);
            Check("frame recovered with new task",!project.IsDead() && project !is cancelled);
            if (project.IsDead()) return;
            aiBuilderMgr.AssignTask(ai.GetTeamUnit(primary),project);
            Check("repair crew protected",!FrontMexUp::Helper(ai.GetTeamUnit(primary)));
            IUnitTask@ joined=FrontLabPorc::Work(ai.GetTeamUnit(helper));
            Check("cancelled task not reentered",joined !is null && joined !is cancelled && !joined.IsDead());
            if (joined !is null && !joined.IsDead()) aiBuilderMgr.AssignTask(ai.GetTeamUnit(helper),joined);
            phase=2;
        }
        if (loss && phase>=1 && phase<3 && ai.GetTeamUnit(primary) is null) {
            Check("dead builder resolves null",true);
            CCircuitUnit@ s=ai.GetTeamUnit(spare);
            if (s !is null) aiBuilderMgr.AssignTask(s,aiBuilderMgr.Enqueue(TaskB::Patrol(
                Task::Priority::LOW,s.GetPos(ai.frame),120*SECOND)));
            FrontMexUp::lastScan=-100000;
            FrontMexUp::Update();
            @s=ai.GetTeamUnit(spare);
            Check("replacement joined after loss",s !is null && s.task is project && !project.IsDead());
            phase=3;
        }
        CCircuitUnit@ g=ai.GetTeamUnit(gun);
        if (g !is null && g.GetBuildProgress()>=1.0f && (!loss || phase==3)) {
            Check("original frame completed",true);
            Check("retired task stays dead",cancelled is null || cancelled.IsDead());
            // Safe empty/stale-ID entry points after completion.
            Check("null helper rejected",!FrontMexUp::Helper(null));
            finished=true;
            GenericHelpers::LogUtil("[LabPorcTest] COMPLETE gun="+gun,1);
        }
    }
}

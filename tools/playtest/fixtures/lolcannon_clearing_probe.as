// Isolated real-engine clearing regression; no normal AI economy runs.
namespace ClearingProbe {
    const AIFloat3 site(1008,0,6928), open(1200,0,6976);
    int phase=0, worker=-1, blocker=-1, gift=-1, started=0;
    bool initialized=false, freeSearch=false, premature=false, earlyChecked=false;
    IUnitTask@ task;
    void Check(const string &in name, bool ok) { AiLog("[ClearingProbe] " + (ok ? "PASS " : "FAIL ") + name); }
    CCircuitUnit@ Worker() { return ai.GetTeamUnit(worker); }
    IUnitTask@ Retain(CCircuitUnit@ u) {
        if (u.id==worker && task !is null && !task.IsDead()) return task;
        return aiBuilderMgr.Enqueue(TaskB::Wait(SECOND));
    }
    void AbortWork() {
        if(task !is null && !task.IsDead()) aiBuilderMgr.AbortTask(task);
        @task=null;
    }
    void Attempt() {
        CCircuitDef@ drag=ai.GetCircuitDef("armdrag"); drag.maxThisUnit=1000;
        Check("lease blocks exact replacement team="+ai.teamId, !aiTerrainMgr.CanReserveBuilding(drag,open,0));
        const int zone=aiTerrainMgr.ReserveZone(open,0,32,32,false);
        Check("lease refuses overlapping district team="+ai.teamId,zone==0);
        if(zone>0) aiTerrainMgr.ReleaseZone(zone);
        const int id=aiTerrainMgr.ReserveBuilding(drag,open,0);
        Check("lease refuses replacement slot team="+ai.teamId,id<0);
        if(id>=0) aiTerrainMgr.ReleaseReservation(id);
        @task=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::DEFENCE,Task::Priority::HIGH,drag,open,0.0f,true,30*SECOND));
        if(Worker() !is null && task !is null) aiBuilderMgr.AssignTask(Worker(),task);
    }
    bool Message(const string &in msg) {
        if(msg=="clearing-probe|attempt") { Attempt(); return true; }
        if(msg=="clearing-probe|abort") { AbortWork(); return true; }
        if(msg=="clearing-probe|handoff") {
            Check("allied cannon excluded after handoff",!aiTerrainMgr.CanReserveBuilding(ai.GetCircuitDef("armvulc"),site,2));
            return true;
        }
        return false;
    }
    void Tick() {
        if(!initialized) {
            initialized=true;
            Global::AISettings::Role=ai.teamId==0 ? AiRole::TECH : AiRole::FRONT;
            aiTerrainMgr.SetLayoutEnabled(true);
            aiTerrainMgr.SetLayoutPriority(ai.teamId==0 ? 2 : 0);
            aiTerrainMgr.SetBuildSiteReservations(true);
        }
        Team::Roster::Update();
        if(ai.frame<600 || ai.frame%15!=0) return;
        if(worker<0) {
            array<int>@ ids=ai.GetOwnedUnitIds();
            for(uint i=0;i<ids.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
                if(u !is null && u.circuitDef.GetName()=="armack") worker=u.id;
            }
        }
        if(ai.teamId!=0) return;
        CCircuitDef@ gun=ai.GetCircuitDef("armvulc"); gun.maxThisUnit=1000;
        if(phase==0) {
            phase=1;
            Check("workers supplied",Worker() !is null);
            Check("actual cannon half footprint",LolCannonClear::Half(gun)==64.0f);
            // Controlled candidate list, native ground/support checks unchanged.
            freeSearch=true;
            const bool found=LolCannon::Plan();
            freeSearch=false;
            Check("available ground selected before reclaim",found && !premature && !LolCannonClear::Active());
            if(LolCannon::gunRes>=0) aiTerrainMgr.ReleaseReservation(LolCannon::gunRes);
            LolCannon::gunRes=-1;
            LolCannon::ReleaseAll(LolCannon::turretRes); LolCannon::turretRes.resize(0);
            LolCannon::ReleaseAll(LolCannon::storeRes); LolCannon::storeRes.resize(0);
            LolCannonClear::Index();
            array<int> hit; LolCannonClear::Blockers(site,400,200,hit);
            if(hit.length()>0) blocker=LolCannonClear::sUnit[hit[0]].id;
            Check("physical blocker indexed",blocker>=0);
            Check("clearing starts over existing structure",LolCannonClear::Start(site,2,0,AIFloat3(1008,0,1000),site,400,200,hit,"fixture",gun));
            Check("lease precedes reclaim",LolCannonClear::clearingZone>0);
            Attempt(); AiSendMessage("clearing-probe|attempt");
            return;
        }
        if(phase==1 && ai.frame>=900) {
            phase=2; AbortWork(); AiSendMessage("clearing-probe|abort");
            array<int>@ ids=ai.GetOwnedUnitIds();
            for(uint i=0;i<ids.length();++i) if(ai.GetTeamUnit(ids[i]).circuitDef.GetName()=="armsolar") gift=ids[i];
            Check("allied structure donated for reclaim",gift>=0);
            @task=LolCannonClear::CrewTask(Worker());
            Check("reclaim task assigned",task !is null);
            if(task !is null) aiBuilderMgr.AssignTask(Worker(),task);
        }
        if(phase==2) {
            LolCannonClear::Tick(1);
            if(LolCannonClear::Live(blocker) !is null) return;
            LolCannonClear::TryReserveEarly();
            if(LolCannonClear::earlyGun<0) return;
            if(!earlyChecked) {
                earlyChecked=true;
                Check("original blocker actually reclaimed",true);
                Check("cannon reserved while clearing active",LolCannonClear::Active());
            }
            if(LolCannonClear::Busy()) {
                if(task is null || task.IsDead()) {
                    @task=LolCannonClear::CrewTask(Worker());
                    if(task !is null) aiBuilderMgr.AssignTask(Worker(),task);
                }
                return;
            }
            Check("donated structure actually reclaimed",gift>=0 && ai.GetTeamUnit(gift) is null);
            LolCannonClear::End("fixture completed original blockers");
            Check("cleanup retains lease",LolCannonClear::clearingZone>0);
            LolCannonClear::ReleaseProtection();
            const bool found=LolCannon::TryCleared();
            LolCannonClear::Result(found);
            Check("clearing hands off to full project",found);
            Check("early footprint survives handoff",found && LolCannon::site.SqDistance2D(site)<16.0f);
            Check("clearing lease released",LolCannonClear::clearingZone==0);
            if(!found) { AiLog("[ClearingProbe] DONE"); phase=9; return; }
            AiSendMessage("clearing-probe|handoff");
            AbortWork();
            @task=LolCannon::OrderAt(Task::BuildType::DEFENCE,gun,LolCannon::site,LolCannon::gunRes,true);
            Check("cannon task pinned",task !is null);
            if(task !is null) aiBuilderMgr.AssignTask(Worker(),task);
            phase=3; started=ai.frame;
        }
        if(phase==3) {
            IBuilderTask@ build=cast<IBuilderTask>(task);
            if(build !is null && build.target !is null) {
                Check("cannon frame actually placed",build.target.circuitDef is gun);
                const AIFloat3 cancel(510,0,8528);
                const int z=aiTerrainMgr.ReserveClearingZone(cancel,0,128,128);
                Check("cancellation lease acquired",z>0);
                if(z>0) aiTerrainMgr.ReleaseZone(z);
                const int slot=aiTerrainMgr.ReserveBuilding(gun,cancel,2);
                Check("cancellation frees ground",slot>=0);
                if(slot>=0) aiTerrainMgr.ReleaseReservation(slot);
                AiLog("[ClearingProbe] DONE");phase=9;
            } else if(ai.frame-started>60*SECOND) {
                Check("cannon frame timeout",false); AiLog("[ClearingProbe] DONE");phase=9;
            }
        }
    }
}

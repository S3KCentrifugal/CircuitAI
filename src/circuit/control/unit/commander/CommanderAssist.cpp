/*
 * CommanderAssist.cpp
 *
 * D-490 (owner, 2026-11-07): the FRONT commander never leaves its own
 * construction for another build task, and breaks off assisting another
 * builder when energy is low, for energy or a mex.
 */

#include "control/unit/commander/CommanderController.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "terrain/BattleAnalysis.h"
#include "unit/CircuitUnit.h"
#include "unit/ally/AllyUnit.h"
#include "spring/SpringUnit.h"
#include "task/common/WaitTask.h"
#include "task/builder/RepairTask.h"
#include "control/core/LeaseTask.h"
#include "unit/action/TravelAction.h"
#include "spring/SpringCallback.h"
#include "spring/CustomCommand.h"
#include "Sim/Units/CommandAI/Command.h"
#include "AISCommands.h"
#include <array>
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

namespace circuit {
using BT=IBuilderTask::BuildType;

namespace {
// D-490: the energy break is tried at most once per this many seconds.
constexpr int ASSIST_BREAK_PERIOD_SECONDS=1;
// D-490: an assist broken with no energy or mex to take waits this long, then
// the work ladder is asked again (its assist offers are closed while energy is low).
constexpr int ASSIST_BREAK_WAIT_SECONDS=2;
// D-490: INV-263, an assist held this long with energy low is a broken break.
constexpr int ASSIST_LOW_INVARIANT_SECONDS=5;
// D-490: INV-263 is logged at most once per this many seconds per commander.
constexpr int ASSIST_LOW_LOG_SECONDS=60;
}

// Supplement a stationary owner's empty/WAIT queue without changing its task,
// retreat latch or station. One local O(K) query per second at most; no unit
// census, task allocation or retained engine wrappers. An active command wins,
// including our own repair, so no per-tick order churn. Engine repair-with-area
// bounds the target before movement, as in CBRepairTask::UpdateStationary.
void CCommanderController::StationaryAssist(CCircuitUnit* unit,State& s,int frame) {
    if(cfg->work.stationaryAssist<=0 || frame<s.work.stationaryAssistNext) return;
    s.work.stationaryAssistNext=frame+FRAMES_PER_SEC;
    auto* current=unit->GetTask();
    if(!current || current->IsDead() || current->IsExternalControlled() || current->IsEnemyReclaim()
        || unit->IsMorphing() || unit->GetUnit()->IsParalyzed() || unit->GetUnit()->IsBeingBuilt()
        || unit->GetUnit()->GetRulesParamFloat("circuit_comm_transported",0)>0 || s.pending>=0) return;
    bool holding=current->GetType()==IUnitTask::Type::IDLE;
    if(auto* wait=dynamic_cast<IWaitTask*>(current)) holding=wait->IsStationary();
    if(current->GetType()==IUnitTask::Type::RETREAT) {
        const auto* travel=unit->GetTravelAct();
        const bool jammed=Jammed(unit);
        holding=jammed || (travel && travel->IsFinished());
        springai::AIFloat3 station;
        if(holding && !jammed && RetreatStation(unit,station))
            holding=unit->GetPos(frame).SqDistance2D(station)<=64.f*64.f;
    }
    if(auto* lease=dynamic_cast<CLeaseTask*>(current))
        holding=lease->GetController()==this && s.mode==Mode::FALLBACK
            && unit->GetPos(frame).SqDistance2D(s.fallback.goal)<=64.f*64.f;
    if(!holding || !unit->GetCircuitDef()->IsAbleToRepair()) { s.work.stationaryAssistOwner=nullptr; return; }
    auto* api=ai->GetUnitAPI();
    const int queued=api->GetCMDQueueSize(unit->GetId());
    if(s.work.stationaryAssistOwner==current && queued>0 && api->GetCMD(unit->GetId())==CMD_REPAIR
        && unit->GetPos(frame).SqDistance2D(s.work.stationaryAssistPosition)>64.f) {
        ai->LOG("[INVARIANT] INV-274 stationary commander assistance moved unit=%i",unit->GetId());
        s.work.stationaryAssistOwner=nullptr;
    }
    if(queued<0 || queued>1 || (queued==1 && api->GetCMD(unit->GetId())!=CMD_WAIT)) return;
    const auto here=unit->GetPos(frame);
    // Target centres are already tested in 3D against build reach. Keep only
    // a numerical margin, so valid work near the edge is not silently ignored.
    const float reach=unit->GetCircuitDef()->GetBuildDistance()-1.f;
    if(reach<=100.f) return;
    int best=-1;
    float bestDistance=reach*reach;
    workIds=ai->GetCallback()->GetFriendlyUnitIdsIn(here,reach,false);
    for(int id:workIds) {
        if(id==unit->GetId()) continue;
        auto* target=ai->GetFriendlyUnit(id);
        if(!target || !target->GetCircuitDef() || ai->GetBuilderManager()->IsReclaimUnit(target)) continue;
        auto* body=target->GetUnit();
        if(body->GetHealth()<=0 || (!body->IsBeingBuilt() && body->GetHealth()>=body->GetMaxHealth())) continue;
        const float distance=here.SqDistance(target->GetPos(frame));
        if(distance<bestDistance || (distance==bestDistance && (best<0 || id<best))) {
            best=id;bestDistance=distance;
        }
    }
    // BAR temporarily marks fresh nanoframes neutral. The friendly callback
    // omits them; keep this second query local and admit allied frames only.
    const auto& neutrals=ai->GetCallback()->GetNeutralUnitsIn(here,reach,false);
    for(auto* target:neutrals) {
        if(target->GetAllyTeam()!=ai->GetAllyTeamId() || !target->IsBeingBuilt() || target->GetHealth()<=0) continue;
        const int id=target->GetUnitId();
        auto* ally=ai->GetFriendlyUnit(id);
        if(ally && ai->GetBuilderManager()->IsReclaimUnit(ally)) continue;
        const float distance=here.SqDistance(target->GetPos());
        if(distance<bestDistance || (distance==bestDistance && (best<0 || id<best))) {
            best=id;bestDistance=distance;
        }
    }
    utils::free(neutrals);
    if(best<0) return;
    s.work.stationaryAssistOwner=current;
    s.work.stationaryAssistPosition=here;
    std::array<float,5> params={float(best),here.x,here.y,here.z,reach-100.f};
    TRY_UNIT(ai,unit,
        unit->RemoveWait();
        SendCustomCommand(ai->GetSkirmishAIId(),unit->GetId(),CMD_REPAIR,params,0,frame+30*FRAMES_PER_SEC);
        unit->GetUnit()->Wait(UNIT_COMMAND_OPTION_SHIFT_KEY);
    )
    ai->LOG("[CommanderAssist] unit=%i target=%i holding=1 task=%i",unit->GetId(),best,int(current->GetType()));
}

/*
 * D-493: own construction against assisting by the task's recorded origin
 * (CommanderTaskOrigin.h, tested): ladder, group and solar tasks are the
 * commander's own; an assist rung, a group assist or a joined job is an
 * assist. An unrecorded task falls back to "works it alone". Cost: a cast, a
 * set size and an eight-entry scan.
 */
bool CCommanderController::IsOwnConstruction(CCircuitUnit* unit,IUnitTask* task) const {
    auto* build=dynamic_cast<IBuilderTask*>(task);
    if(!unit || !build || task->IsDead() || task->IsExternalControlled() || task->IsEnemyReclaim()) return false;
    const State* s=states.Find(unit->GetId());
    const auto origin=s?s->work.OriginOf(task):commander::TaskOrigin::None;
    const bool construction=build->GetBuildDef()!=nullptr && build->GetBuildType()<BT::REPAIR;
    return commander::OwnConstruction(origin,construction,task->GetAssignees().size()<=1);
}

bool CCommanderController::IsAssisting(CCircuitUnit* unit,IUnitTask* task) const {
    auto* build=dynamic_cast<IBuilderTask*>(task);
    if(!unit || !build || task->IsDead() || task->IsExternalControlled() || task->IsEnemyReclaim()) return false;
    const State* s=states.Find(unit->GetId());
    const auto origin=s?s->work.OriginOf(task):commander::TaskOrigin::None;
    const bool construction=build->GetBuildDef()!=nullptr && build->GetBuildType()<BT::REPAIR;
    bool repairOfFrame=false;
    if(build->GetBuildType()==BT::REPAIR) {
        CAllyUnit* target=build->GetTarget();
        if(!target) if(auto* repair=dynamic_cast<IRepairTask*>(task)) target=ai->GetFriendlyUnit(repair->GetTargetId());
        repairOfFrame=target && target->GetCircuitDef() && !target->GetCircuitDef()->IsMobile() && target->GetUnit()->IsBeingBuilt();
    }
    return commander::Assisting(origin,construction,task->GetAssignees().size()<=1,repairOfFrame,build->GetBuildType()==BT::GUARD);
}

IUnitTask* CCommanderController::Handed(CCircuitUnit* unit,IUnitTask* task,commander::TaskOrigin origin) {
    if(!task || !unit) return task;
    if(State* s=states.Find(unit->GetId())) s->work.NoteOrigin(task,origin);
    return task;
}
IUnitTask* CCommanderController::HandedGroup(CCircuitUnit* unit,IUnitTask* task) {
    if(!task || !unit || !Handles(unit)) return task;
    State* s=states.Find(unit->GetId());
    if(!s || s->work.OriginOf(task)!=commander::TaskOrigin::None) return task;  // keep the first record
    // Nobody else on it: the commander starts it. Someone else on it: a join.
    bool others=false;
    for(auto* worker:task->GetAssignees()) if(worker!=unit) { others=true; break; }
    return Handed(unit,task,others?commander::TaskOrigin::Assist:commander::TaskOrigin::Group);
}

// Energy is low: the bank under front_assist_break_energy of storage, or stalling.
bool CCommanderController::AssistEnergyLow() const {
    // D-493: the shared definition (resource/EnergyState.h); this caller's threshold.
    return cfg->front.assistBreakEnergy>0 && ai->GetEconomyManager()->IsEnergyLow(cfg->front.assistBreakEnergy);
}

// The commander's assist offers (group assist, joining a job, adopting a
// worker's project, the assist/factory/base rungs) are closed while energy is low.
bool CCommanderController::AssistClosed(CCircuitUnit* unit) const {
    if(!unit || !Handles(unit) || !role.frontDuty) return false;
    if(AssistEnergyLow()) return true;
    // D-493: closed for front_assist_close_seconds after a break, so a brief
    // recovery of the bank does not hand the commander the same assist again.
    const State* s=states.Find(unit->GetId());
    return s && ai->GetLastFrame()<s->work.assistClosedUntil;
}

// Reevaluate (out of build range) asks the policy again; for a FRONT
// commander on its own construction that offer is skipped (front_keep_own_build).
bool CCommanderController::KeepsOwnConstruction(CCircuitUnit* unit,IUnitTask* task) const {
    if(!unit || !Handles(unit)) return false;
    Bind bound(this,PresetOfUnit(unit->GetId()));
    return role.frontDuty && cfg->front.keepOwnBuild>0 && !HealthRetreat(unit) && !EnergyRetreat(unit)
        && IsOwnConstruction(unit,task);
}

/*
 * From Tick, below safety, jamming, T3 and fallback: a FRONT commander that is
 * assisting while energy is low leaves the assist for emergency energy
 * (front_solar_*), then a mex, else a short stationary wait. Own construction
 * is never touched here. Cost: at most once per second per commander, one
 * assignee check, and the existing solar and mex offers.
 */
bool CCommanderController::AssistEnergyBreak(CCircuitUnit* unit,State& s,int frame) {
    if(!role.frontDuty || cfg->front.assistBreakEnergy<=0) return false;
    auto* current=unit->GetTask();
    if(!IsAssisting(unit,current) || !AssistEnergyLow()) { s.work.assistLowSince=-1; return false; }
    // INV-263: an assisting commander never stays on the assist
    // ASSIST_LOW_INVARIANT_SECONDS with energy low.
    if(s.work.assistLowSince<0) s.work.assistLowSince=frame;
    else if(frame-s.work.assistLowSince>=ASSIST_LOW_INVARIANT_SECONDS*FRAMES_PER_SEC && frame>=s.work.assistLowLog) {
        s.work.assistLowLog=frame+ASSIST_LOW_LOG_SECONDS*FRAMES_PER_SEC;
        ai->LOG("[INVARIANT] INV-263 commander %i assisting %.0f s with energy low",unit->GetId(),
            float(frame-s.work.assistLowSince)/FRAMES_PER_SEC);
    }
    if(frame<s.work.assistBreakNext) return false;
    s.work.assistBreakNext=frame+ASSIST_BREAK_PERIOD_SECONDS*FRAMES_PER_SEC;
    s.work.assistClosedUntil=frame+int(cfg->front.assistCloseSeconds*FRAMES_PER_SEC);
    // D-493: a break is a reason to look for a solar site now, whatever the
    // three-second retry of the last failed search (one bounded search).
    s.front.solarNext=0;
    const char* why="solar";
    IUnitTask* next=FrontWork(unit,WORK_SOLAR,nullptr,0);
    if(!next || next==current) {
        why="mex";
        next=FrontWork(unit,ai->GetBattle()->GetFrontLaneLength()>0.f?WORK_MEX_LANE:WORK_MEX,nullptr,cfg->front.radius);
    }
    if(!next || next==current) {
        why="wait";
        auto* wait=static_cast<IWaitTask*>(ai->GetBuilderManager()->Enqueue(TaskB::Wait(ASSIST_BREAK_WAIT_SECONDS*FRAMES_PER_SEC)));
        wait->SetStationary(true);
        next=wait;
    }
    auto* eco=ai->GetEconomyManager();
    ai->LOG("[CommanderWork] unit=%i assist_break energy=%.0f/%.0f stalling=%i next=%s",unit->GetId(),
        eco->GetEnergyCur(),eco->GetEnergyStore(),int(eco->IsEnergyStalling()),why);
    ai->GetBuilderManager()->AssignTask(unit,next);
    return true;
}

} // namespace circuit

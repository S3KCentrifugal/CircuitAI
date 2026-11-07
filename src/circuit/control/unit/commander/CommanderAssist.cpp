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

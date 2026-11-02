#include "control/core/ControlledTask.h"
#include "control/core/UnitController.h"
#include "module/TaskModule.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "util/Performance.h"

namespace circuit {
CControlledTask::CControlledTask(ITaskModule* manager,IUnitController* controller,IUnitTask* previous)
    : IFighterTask(manager,FightType::DEFEND,1.f,-1),controller(controller),previous(previous) {
    if(previous) previous->AddRef();
}
CControlledTask::~CControlledTask() { if(previous) previous->Release(); }
void CControlledTask::AssignTo(CCircuitUnit* unit) {
    // Do not call IFighterTask::AssignTo: its generic DGun action would be a
    // second command owner. This task owns no generic fighter side sets.
    restored=false;
    oldFire=unit->GetRequestedFireState(); oldMove=unit->GetRequestedMoveState();
    IUnitTask::AssignTo(unit);
    if(controller) controller->Leased(unit,this);
}
void CControlledTask::Restore(CCircuitUnit* unit) {
    if(restored || unit->IsDead() || unit->IsDestroying()) return;
    restored=true;
    // The controller is the only writer of these states (D-388).
    if(controller) controller->RestoreAfterLease(unit,oldFire,oldMove);
}
void CControlledTask::Stop(bool done) {
    for(auto* unit:units) if(!unit->IsDead()) Restore(unit);
    IUnitTask::Stop(done);
}
void CControlledTask::RemoveAssignee(CCircuitUnit* unit) {
    Restore(unit);
    IUnitTask::RemoveAssignee(unit);
    if(units.empty()) manager->AbortTask(this);
}
bool CControlledTask::ForgetUnit(CCircuitUnit* unit) {
    const bool removed=IUnitTask::ForgetUnit(unit);
    if(removed && units.empty()) manager->AbortTask(this);
    return removed;
}
void CControlledTask::OnUnitDestroyed(CCircuitUnit* unit,CEnemyInfo*) { ForgetUnit(unit); }
void CControlledTask::OnUnitMoveFailed(CCircuitUnit* unit) {
    if(controller) controller->MoveFailed(unit->GetId());
}
void CControlledTask::OnUnitIdle(CCircuitUnit* unit) {
    if(controller) controller->Idle(unit->GetId());
}
void CControlledTask::Resume(CCircuitUnit* unit) {
    performance::Scope measured(manager->GetCircuit(),performance::COMMANDER_HANDOVER);
    // Manager may release this task later in the same scheduler cycle. The
    // prior task stays retained until this object is actually destroyed.
    // Wait/idle tasks do not necessarily emit a replacement command. Do not
    // leave the combat escape route running under their restored ownership.
    TRY_UNIT(manager->GetCircuit(),unit,unit->CmdStop();)
    if(previous && !previous->IsDead() && previous->GetManager()==manager
        && !previous->IsExternalControlled() && previous->CanAssignTo(unit)
        && (!controller || controller->CanResumeTask(unit,previous))) {
        manager->AssignTask(unit,previous);
    } else RemoveAssignee(unit);
}
void CControlledTask::Handover(CCircuitUnit* unit) {
    performance::Scope measured(manager->GetCircuit(),performance::COMMANDER_HANDOVER);
    TRY_UNIT(manager->GetCircuit(),unit,unit->CmdStop();)
    RemoveAssignee(unit);
}
}

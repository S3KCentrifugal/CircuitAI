#pragma once
// D-388: the task a controlled unit holds while its controller acts on it
// directly (combat, withdrawal, front deployment). Formerly CCommanderTask.
// Owns one retained resume token. Removal never resumes implicitly: player,
// capture, death and retreat takeovers must remain authoritative. Restoring
// fire, move and cloak state on removal goes through the owning controller's
// single writer (IUnitController::RestoreAfterLease), never directly.
#include "task/fighter/FighterTask.h"

namespace circuit {
class IUnitController;

class CControlledTask final : public IFighterTask {
public:
    CControlledTask(ITaskModule* manager,IUnitController* controller,IUnitTask* previous);
    ~CControlledTask() override;
    void AssignTo(CCircuitUnit* unit) override;
    void RemoveAssignee(CCircuitUnit* unit) override;
    bool ForgetUnit(CCircuitUnit* unit) override;
    void Start(CCircuitUnit*) override {}
    void Update() override {}
    void Stop(bool done) override;
    void OnUnitIdle(CCircuitUnit* unit) override;
    void OnUnitDamaged(CCircuitUnit*,CEnemyInfo*) override {}
    void OnUnitDestroyed(CCircuitUnit* unit,CEnemyInfo*) override;
    void OnUnitMoveFailed(CCircuitUnit* unit) override;
    void Resume(CCircuitUnit* unit);
    // D-299: hand the unit back to its manager for a new task instead of the
    // retained previous one (a fallback line must not resume front work).
    void Handover(CCircuitUnit* unit);
    IUnitController* GetController() const { return controller; }
private:
    IUnitController* controller;  // owned by the AI's controller registry; outlives its tasks
    IUnitTask* previous;
    int oldFire=2,oldMove=1;
    bool restored=false;
    void Restore(CCircuitUnit* unit);
};
}

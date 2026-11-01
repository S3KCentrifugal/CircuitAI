#pragma once
// D-430: the ranged unit controller, the second unit controller on the D-388
// framework (unit-controller-architecture.md, plan phase 3). It owns a unit
// type's ranged policy as a preset in behaviour.json "controllers" (type
// "ranged"), publishes that policy to the unit type, attaches every unit of
// a bound type, and runs the existing CRangedEngagement for a unit while it
// holds the controller's lease (a CControlledTask from the military manager).
//
// Behaviour is deliberately that of the artillery-task path it replaces: the
// engagement opens on lease assignment and closes on lease end, exactly where
// CArtilleryTask::AssignTo / RemoveAssignee used to open and close it, so a
// controlled Thug plays as an attribute Thug did. What changes is ownership:
// the controller is the single writer of the unit's fire and move state, the
// registry's arbiter answers who owns the unit, and the type needs no `ranged`
// attribute. The line group controller (control/group/LineController.h) reads
// the same engagement's cohort and writes directives the engagement consumes.
#include "control/core/CommandWriter.h"
#include "control/core/UnitController.h"
#include "unit/RangedPolicy.h"

#include <cstddef>
#include <memory>
#include <string>
#include <vector>

namespace circuit {
class CCircuitAI;
class CCircuitUnit;
class CControlledTask;
class CRangedEngagement;
class IUnitTask;

struct RangedConfig {
    RangedPolicy policy;
};
struct RangedState : control::ControlledState {
    // The engagement lives exactly as long as the lease (artillery-task parity).
    std::unique_ptr<CRangedEngagement> engagement;
    IUnitTask* lease = nullptr;  // address only, compared never dereferenced
    int lastTaskType = -1;       // detects a retreat lease ending (restore fire state)
    int leases = 0;
};

class CRangedController final : public CUnitControllerBase<RangedConfig, RangedState> {
public:
    using State = RangedState;
    explicit CRangedController(CCircuitAI* ai);
    ~CRangedController() override;

    // IUnitController
    const char* Name() const override { return "ranged"; }
    int ParsePreset(const std::string& name, const Json::Value& resolved, std::vector<std::string>& problems) override;
    void BindDef(int defId, int preset) override;
    bool SetOption(const std::string& name, float value) override;
    bool SetPresetOption(const std::string& preset, const std::string& name, float value) override;
    void Attach(CCircuitUnit* unit) override;
    void Detach(int unitId) override;
    bool Owns(CCircuitUnit* unit) const override;
    void Update() override;
    void Damaged(CCircuitUnit* unit) override;
    void MoveFailed(int unitId) override;
    void Idle(int unitId) override;
    void Leased(CCircuitUnit* unit, IUnitTask* task) override;
    void RestoreAfterLease(CCircuitUnit* unit, int fireState, int moveState) override;

    // The military manager's admission (TryMakeRangedTask) asks here for a
    // bound type's task: a fresh lease. Null when the type is not bound.
    IUnitTask* MakeLease(CCircuitUnit* unit);
    bool Bound(int defId) const { return PresetForDef(defId) >= 0; }
    CCommandWriter& Writer() { return writer; }
    int Leases() const { return leasesOpened; }

private:
    void OnPresetAssigned(int defId, int preset) override;
    void Publish(int defId, int preset);
    void Tick(CCircuitUnit* unit, State& s, int frame);
    void CloseEngagement(CCircuitUnit* unit, State& s, bool commands);

    CCircuitAI* ai;
    CCommandWriter writer;
    std::size_t cursor = 0;  // round-robin decision slice, as ITaskModule::Update
    int leasesOpened = 0;
    bool trace = false;
};

} // namespace circuit

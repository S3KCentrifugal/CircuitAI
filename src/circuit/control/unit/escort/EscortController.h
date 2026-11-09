#pragma once
// D-509: the escort unit controller (type "escort"): the T1 anti-air bots
// (Crasher, Trasher, Legion AA bot) that ride with a battle group. It leases
// each unit like the skirmisher and support controllers do, opens its fire at
// will (the engine fires at air in reach on its own), and walks it to the slot
// its battle group gives it: escort_behind elmos behind the screen
// (CBattleGroupController::EscortPoint, control/kernel/AirDefence.h). Which
// group an escort rides with, and how many a group needs, is the battle
// group's decision; this controller only moves the unit. A unit is leased
// only while a group with an air rank exists, and one left with no group for
// release_seconds is handed back to its ordinary (anti-air squad) tasks.
//
// Cost: once per DECISION_SLICE frames for each unit (sliced like the support
// controller), one O(log E) slot lookup and at most one move command, sent only
// when the slot moved by more than `arrival`.
#include "control/core/CommandWriter.h"
#include "control/core/UnitController.h"

#include "AIFloat3.h"

#include <cstddef>
#include <string>
#include <vector>

namespace circuit {
class CCircuitAI;
class CCircuitUnit;
class IUnitTask;

struct EscortConfig {
    float arrival = 48.f;       // arrival: elmos; no new move while the slot is this close to the last one sent
    float moveSeconds = 20.f;   // move_seconds: lifetime of one move order
    float fireAtWill = 1.f;     // fire_at_will: 1 opens fire for the lease (air targets in reach)
    float log = 0.f;            // log: ESCORT: lines on slot changes
    float releaseSeconds = 15.f;// release_seconds: an escort with no group this long goes back to ordinary tasks
};
struct EscortState : control::ControlledState {
    IUnitTask* lease = nullptr;  // the lease; dereferenced (Handover) only while it is still the unit's task
    springai::AIFloat3 sent;     // the last slot a move was sent to
    bool hasSent = false;
    int group = -1;              // the group of the last slot (log only)
    int alone = -1;              // the frame it last lost its group (-1: has one)
};

class CEscortController final : public CUnitControllerBase<EscortConfig, EscortState> {
public:
    using State = EscortState;
    explicit CEscortController(CCircuitAI* ai);
    ~CEscortController() override;

    // IUnitController
    const char* Name() const override { return "escort"; }
    void Attach(CCircuitUnit* unit) override;
    void Detach(int unitId) override;
    bool Owns(CCircuitUnit* unit) const override;
    void Update() override;
    void Idle(int unitId) override;
    void MoveFailed(int unitId) override;
    void Leased(CCircuitUnit* unit, IUnitTask* task) override;
    void RestoreAfterLease(CCircuitUnit* unit, int fireState, int moveState) override;

    IUnitTask* MakeLease(CCircuitUnit* unit);
    bool Bound(int defId) const { return PresetForDef(defId) >= 0; }

private:
    void OnPresetAssigned(int defId, int preset) override;
    void Tick(CCircuitUnit* unit, State& s, int frame);

    CCircuitAI* ai;
    CCommandWriter writer;
    std::size_t cursor = 0;
};

} // namespace circuit

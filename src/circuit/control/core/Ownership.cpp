#include "control/core/Ownership.h"
#include "task/UnitTask.h"
#include "unit/CircuitUnit.h"
#include "spring/SpringUnit.h"

namespace circuit::control {

namespace {
// BAR marks a unit carried by a transport with this rules parameter (D-291).
constexpr const char* TRANSPORTED_PARAM = "circuit_comm_transported";
}

Suspension SuspensionOf(CCircuitUnit* unit, int frame) {
	SuspensionFlags f;
	const IUnitTask* task = unit->GetTask();
	f.noTask = task == nullptr;
	if (task != nullptr) {
		f.player = task->GetType() == IUnitTask::Type::PLAYER;
		f.external = task->IsExternalControlled();
		f.enemyReclaim = task->IsEnemyReclaim();
	}
	f.transported = unit->GetUnit()->GetRulesParamFloat(TRANSPORTED_PARAM, 0) > 0;
	f.morphing = unit->IsMorphing();
	f.beingBuilt = unit->GetUnit()->IsBeingBuilt();
	f.stunned = unit->GetUnit()->IsParalyzed();
	f.disarmed = unit->IsDisarmed(frame);
	return Suspended(f);
}

} // namespace circuit::control

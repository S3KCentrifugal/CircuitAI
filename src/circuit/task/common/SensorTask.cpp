/*
 * SensorTask.cpp
 *
 *  Created on: Nov 9, 2016
 *      Author: rlcevg
 */

#include "task/common/SensorTask.h"
#include "module/FactoryManager.h"
#include "CircuitAI.h"
#include "control/unit/commander/CommanderController.h"

#include "spring/SpringCallback.h"

namespace circuit {

using namespace springai;

ISensorTask::ISensorTask(ITaskModule* mgr, Priority priority, std::function<bool (CCircuitDef*)> isSensor,
						 CCircuitDef* buildDef, const AIFloat3& position, BuildType buildType,
						 SResource cost, float shake, int timeout)
		: IBuilderTask(mgr, priority, buildDef, position, Type::BUILDER, buildType, cost, shake, timeout)
		, isSensorTest(isSensor)
{
}

ISensorTask::ISensorTask(ITaskModule* mgr, std::function<bool (CCircuitDef*)> isSensor, BuildType buildType)
		: IBuilderTask(mgr, Type::BUILDER, buildType)
		, isSensorTest(isSensor)
{
}

ISensorTask::~ISensorTask()
{
}

bool ISensorTask::CanAssignTo(CCircuitUnit* unit) const
{
	if (manager->GetCircuit()->GetFactoryManager()->GetFactoryCount() == 0) {
		return false;
	}
	return IBuilderTask::CanAssignTo(unit);
}

void ISensorTask::Update()
{
	IBuilderTask::Update();
	if (isDead || (target != nullptr)) {
		return;
	}

	CCircuitAI* circuit = manager->GetCircuit();
	// The group already admitted this project against forward coverage. A
	// nearby short/mobile radar is not proof that its forward goal is covered.
	// Borrowed task identity expires in BuilderManager::DequeueTask; O(1).
	if (circuit->GetCommanderController()->OwnsGroupProject(this)) return;
	bool isBuilt = false;
	COOAICallback* clb = circuit->GetCallback();
	auto& friendlies = clb->GetFriendlyUnitIdsIn(GetPosition(), 500.f);
	for (int auId : friendlies) {
		CCircuitDef::Id defId = clb->Unit_GetDefId(auId);
		if (isSensorTest(circuit->GetCircuitDef(defId))) {
			isBuilt = true;
			break;
		}
	}
	if (isBuilt) {
		manager->AbortTask(this);
	}
}

} // namespace circuit

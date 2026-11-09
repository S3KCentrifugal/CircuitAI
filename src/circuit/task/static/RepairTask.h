/*
 * RepairTask.h
 *
 *  Created on: Mar 30, 2015
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_STATIC_REPAIRTASK_H_
#define SRC_CIRCUIT_TASK_STATIC_REPAIRTASK_H_

#include "task/common/RepairTask.h"

#include <vector>

namespace circuit {

class CSRepairTask final: public IRepairTask {
public:
	CSRepairTask(ITaskModule* mgr, Priority priority, CAllyUnit* target, int timeout = 0);
	virtual ~CSRepairTask();

	virtual void AssignTo(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;
protected:
	virtual void Finish() override final;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;

private:
	// D-468: releases assignees the target has left; true when the task ended.
	bool ReleaseOutOfReach();
	std::vector<CCircuitUnit*> outOfReach;  // reused scratch, assignees only
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_STATIC_REPAIRTASK_H_

/*
 * WaitTask.h
 *
 *  Created on: May 29, 2017
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_BUILDER_WAITTASK_H_
#define SRC_CIRCUIT_TASK_BUILDER_WAITTASK_H_

#include "task/common/WaitTask.h"

namespace circuit {

class CBWaitTask final: public IWaitTask {
public:
	CBWaitTask(ITaskModule* mgr, int timeout);
	virtual ~CBWaitTask();

	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;

	// D-110: a ferry's cargo park: no retreat, no self-destruct, nothing until the
	// run ends (the owner: the cargo is not interrupted until the drop-off)
	void SetHold(bool value) { isHold = value; }
	bool IsHold() const { return isHold; }
private:
	bool isHold = false;
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_BUILDER_WAITTASK_H_

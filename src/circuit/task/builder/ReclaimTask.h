/*
 * ReclaimTask.h
 *
 *  Created on: Jan 31, 2015
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_BUILDER_RECLAIMTASK_H_
#define SRC_CIRCUIT_TASK_BUILDER_RECLAIMTASK_H_

#include "task/common/ReclaimTask.h"

namespace circuit {

class CBReclaimTask final: public IReclaimTask {
public:
	CBReclaimTask(ITaskModule* mgr, Priority priority,
				  const springai::AIFloat3& position,
				  SResource cost, int timeout, float radius = .0f, bool isMetal = true);
	CBReclaimTask(ITaskModule* mgr, Priority priority,
				  CCircuitUnit* target,
				  int timeout);
	CBReclaimTask(ITaskModule* mgr);  // Load
	virtual ~CBReclaimTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void AssignTo(CCircuitUnit* unit) override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;

	// Enemy wall (dragon's teeth) target for rez bots; -1 = positional/feature.
	void SetEnemyWall(int id) { enemyWallId = id; }
	int GetEnemyWallId() const { return enemyWallId; }

private:
	virtual bool Execute(CCircuitUnit* unit) override;
	virtual bool Reevaluate(CCircuitUnit* unit) override;

	int enemyWallId = -1;

	virtual bool Load(std::istream& is) override;
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_BUILDER_RECLAIMTASK_H_

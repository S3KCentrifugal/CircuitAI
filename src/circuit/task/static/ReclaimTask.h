/*
 * ReclaimTask.h
 *
 *  Created on: Mar 31, 2015
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_STATIC_RECLAIMTASK_H_
#define SRC_CIRCUIT_TASK_STATIC_RECLAIMTASK_H_

#include "task/common/ReclaimTask.h"

namespace circuit {

class CSReclaimTask final: public IReclaimTask {
public:
	CSReclaimTask(ITaskModule* mgr, Priority priority,
				  const springai::AIFloat3& position,
				  SResource cost, int timeout, float radius = .0f);
	CSReclaimTask(ITaskModule* mgr, int enemyId);
	virtual ~CSReclaimTask();

	virtual void AssignTo(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;
	void Stop(bool done) override;
	void OnUnitIdle(CCircuitUnit* unit) override;
	bool IsEnemyReclaim() const override { return enemyId >= 0; }
	int GetEnemyId() const { return enemyId; }
	void ReclaimEnemy(CCircuitUnit* unit, int id);

	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;
private:
	int enemyId = -1; // transient observation; reconstructed by the manager after load
	bool commandNeeded = true;
	int lastEnemyCommand = -100000;
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_STATIC_RECLAIMTASK_H_

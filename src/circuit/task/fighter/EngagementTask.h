/*
 * EngagementTask.h
 *
 * D-440: the one-unit task that hosts a CRangedEngagement for a definition
 * with an engagement policy (the `ranged` attribute path). Formerly the
 * engagement branch inside CArtilleryTask; the skirmisher and backline
 * controllers host the same engagement on their CLeaseTask instead.
 */

#ifndef SRC_CIRCUIT_TASK_FIGHTER_ENGAGEMENTTASK_H_
#define SRC_CIRCUIT_TASK_FIGHTER_ENGAGEMENTTASK_H_

#include "task/fighter/FighterTask.h"

#include <memory>

namespace circuit {
class CRangedEngagement;

class CEngagementTask final: public IFighterTask {
public:
	explicit CEngagementTask(ITaskModule* mgr);
	~CEngagementTask() override;

	bool CanAssignTo(CCircuitUnit* unit) const override;
	void AssignTo(CCircuitUnit* unit) override;
	void RemoveAssignee(CCircuitUnit* unit) override;
	bool ForgetUnit(CCircuitUnit* unit) override;
	void Stop(bool done) override;

	void Start(CCircuitUnit* unit) override;
	void Update() override;

	void OnUnitIdle(CCircuitUnit* unit) override;
	void OnUnitMoveFailed(CCircuitUnit* unit) override;
	void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;

private:
	std::unique_ptr<CRangedEngagement> ranged;
	void Execute(CCircuitUnit* unit);
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_ENGAGEMENTTASK_H_

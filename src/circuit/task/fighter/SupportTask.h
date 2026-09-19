/*
 * SupportTask.h
 *
 *  Created on: Jul 3, 2016
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_FIGHTER_SUPPORTTASK_H_
#define SRC_CIRCUIT_TASK_FIGHTER_SUPPORTTASK_H_

#include "task/fighter/FighterTask.h"

namespace circuit {

class CSupportTask final: public IFighterTask {
public:
	CSupportTask(ITaskModule* mgr);
	virtual ~CSupportTask();

	virtual void RemoveAssignee(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

private:
	// Squads this unit may join. For a mobile radar or jammer the list is
	// rationed and ranked; see the definition.
	void FindCandidates(CCircuitUnit* unit, const std::set<IFighterTask*>& tasks,
			std::vector<IFighterTask*>& outTasks) const;
	void ApplyPath(const CQueryPathMulti* query);
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_SUPPORTTASK_H_

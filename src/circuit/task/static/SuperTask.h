/*
 * SuperTask.h
 *
 *  Created on: Aug 12, 2016
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_STATIC_SUPERTASK_H_
#define SRC_CIRCUIT_TASK_STATIC_SUPERTASK_H_

#include "task/fighter/FighterTask.h"

#include <functional>

namespace circuit {

class CCircuitDef;
struct SEnemyData;

class CSuperTask final: public IFighterTask {
public:
	CSuperTask(ITaskModule* mgr);
	virtual ~CSuperTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

	// Script hooks
	void SetTargetPos(const springai::AIFloat3& pos);

private:
	void ExecuteAttack(CCircuitUnit* unit);
	/*
	 * Area-effect target selection shared by the weapons whose worth is not the
	 * metal of the enemy group they hit: Juno deletes only flagged defs, EMP only
	 * paralyses what it can hold. The classifier decides whether an enemy is a
	 * candidate at all and at what rank; everything else - last known positions,
	 * range, aim-point scoring, the hold-fire path - is common.
	 *
	 * Classifier: returns true for a candidate, and fills rank (lower fires
	 * first) and value (tie-break inside a rank).
	 */
	using TClassify = std::function<bool (const SEnemyData&, CCircuitDef*, int&, float&)>;
	// minValue: the best aim point must sum to at least this, else no target.
	// avoidFriendly: an aim point whose blast holds one of our own units is
	// rejected (damaging weapons: Perdition, Catalyst). EMP and Juno do no damage.
	bool SelectAreaTarget(CCircuitUnit* unit, CCircuitDef* cdef, const char* tag,
			float sqAoe, int minTargets, int mobileMaxAge, const TClassify& classify,
			float minValue = 0.f, bool avoidFriendly = false);
	// Tactical launchers (Perdition, Catalyst): the richest blast in range.
	bool SelectLauncherTarget(CCircuitUnit* unit, CCircuitDef* cdef, float minValue);
	// The metal a target must be worth for a stockpiled shot; decays while the
	// shot waits (CMilitaryManager::SStockInfo).
	float StockedShotFloor(CCircuitUnit* unit, CCircuitDef* cdef, int frame, float shotCost);
	// Juno: the highest-priority sensor/EW target in range.
	bool SelectPulseTarget(CCircuitUnit* unit, CCircuitDef* cdef);
	// Juno fallback: ground we cover with radar but read nothing from, which
	// is where a jammer that hides itself from radar has to be.
	bool SelectSuspectedJammer(CCircuitUnit* unit, CCircuitDef* cdef);
	// EMP: the most valuable target the shot can actually hold, structures first.
	bool SelectEmpTarget(CCircuitUnit* unit, CCircuitDef* cdef);

	int targetFrame;
	springai::AIFloat3 targetPos;
	bool isTargetOverride;
	int stockSinceFrame;  // first frame a shot has been waiting; -1 while the tube is empty
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_STATIC_SUPERTASK_H_

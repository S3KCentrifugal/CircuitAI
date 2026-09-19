/*
 * BombTask.h
 *
 *  Created on: Jan 6, 2016
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_FIGHTER_BOMBTASK_H_
#define SRC_CIRCUIT_TASK_FIGHTER_BOMBTASK_H_

#include "task/fighter/SquadTask.h"

namespace circuit {

class CBombTask final: public ISquadTask {
public:
	CBombTask(ITaskModule* mgr, float powerMod);
	virtual ~CBombTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void AssignTo(CCircuitUnit* unit) override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;

private:
	/*
	 * A bombing pass is alpha damage: it either kills or is wasted. FOCUS puts
	 * the whole group on one target, which is what a fat static needs; AREA
	 * spreads the group into a line across a front and bombs the ground, which
	 * is what a cluster of cheap targets needs. See doc/bomber-targeting.md.
	 */
	enum class EMode: char {FOCUS = 0, AREA = 1};

	void FindTarget();
	// Sum of one full firing from every member.
	float GetGroupAlpha() const;
	// Lowest-threat bearing to run in from, sampled on a ring around pos.
	springai::AIFloat3 PickApproachDir(const springai::AIFloat3& pos) const;
	// Line abreast across the front, perpendicular to the approach, each unit
	// bombing its own slice and attack-moving out the far side.
	void AttackArea(const int frame);

	EMode mode = EMode::FOCUS;
	springai::AIFloat3 areaCentre;
	springai::AIFloat3 approachDir;
	float frontLength = 0.f;
	int areaCount = 0;
	void ApplyTargetPath(const CQueryPathSingle* query);
	void FallbackBasePos();
	void ApplyBasePos(const CQueryPathSingle* query);
	void Fallback();
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_BOMBTASK_H_

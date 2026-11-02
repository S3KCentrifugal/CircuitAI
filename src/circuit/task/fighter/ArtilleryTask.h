/*
 * ArtilleryTask.h
 *
 *  Created on: Jan 6, 2016
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_TASK_FIGHTER_ARTILLERYTASK_H_
#define SRC_CIRCUIT_TASK_FIGHTER_ARTILLERYTASK_H_

#include "task/fighter/FighterTask.h"

#include <unordered_map>

namespace circuit {
class CRangedEngagement;

class CArtilleryTask final: public IFighterTask {
public:
	CArtilleryTask(ITaskModule* mgr);
	virtual ~CArtilleryTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void AssignTo(CCircuitUnit* unit) override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;
	virtual bool ForgetUnit(CCircuitUnit* unit) override;
	virtual void Stop(bool done) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnUnitMoveFailed(CCircuitUnit* unit) override;
	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;

private:
	std::unique_ptr<CRangedEngagement> ranged;
	void Execute(CCircuitUnit* unit);
	CEnemyInfo* FindTarget(CCircuitUnit* unit, const springai::AIFloat3& pos);
	void ApplyTargetPath(const CQueryPathMulti* query);
	void FallbackSafePos(CCircuitUnit* unit);
	void ApplySafePos(const CQueryPathMulti* query);
	void Fallback(CCircuitUnit* unit, bool proceed);
	// Owner 2026-11-02: ghost porc fire (SArtyCommInfo::ghostDefs). Last shot
	// is read off the main weapon's reload frame, sampled every Execute.
	struct GhostFire { int reload = -1, shot = -1, orderUntil = -1; };
	std::unordered_map<int, GhostFire> ghostFire;
	// Unit def id -> radar/jammer/shield structure (owner: counts as porc).
	std::unordered_map<int, bool> ghostSupport;
	bool FireAtGhost(CCircuitUnit* unit, const springai::AIFloat3& pos, int frame);
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_ARTILLERYTASK_H_

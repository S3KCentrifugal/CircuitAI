/*
 * DebugGoalTask.h
 *
 * Debug goal (owner 2026-11-01, branch debug-widget-test): the team link
 * widget's debug window "goal" toggle. While it is on, CMilitaryManager puts
 * every military non-spam unit in reach into this task, and this task moves
 * them; off aborts the task and every member goes back to the idle task, so
 * the normal task assignment takes it again.
 *
 *  - position goal: every member moves to (x, z). Reach: half the map's long
 *    edge from the point (debug::GoalReach).
 *  - player (team) goal: every member moves to the nearest scouted unit of
 *    that team, in sight or a ghost (its last known spot); reach three
 *    quarters of the long edge from the unit. When the target dies, or its
 *    spot is seen empty for GOAL_HIDDEN_FRAMES, the member takes the next
 *    nearest one within reach, or leaves the task when none is left.
 *
 * Members do not retreat while in the task. Plain MOVE orders: units fire at
 * what comes in range on the way under their own fire state.
 * Spam units (their factory's spam route) are never taken; the manager decides
 * membership (CMilitaryManager::UpdateDebugGoal), this task owns the orders.
 */

#ifndef SRC_CIRCUIT_TASK_FIGHTER_DEBUGGOALTASK_H_
#define SRC_CIRCUIT_TASK_FIGHTER_DEBUGGOALTASK_H_

#include "task/fighter/FighterTask.h"

#include <map>
#include <vector>

namespace circuit {

class CDebugGoalTask final: public IFighterTask {
public:
	CDebugGoalTask(ITaskModule* mgr, int serial);
	virtual ~CDebugGoalTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override { return true; }
	virtual void AssignTo(CCircuitUnit* unit) override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;
	virtual bool ForgetUnit(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;
	virtual void Stop(bool done) override;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override {}  // no retreat
	virtual void OnUnitMoveFailed(CCircuitUnit* unit) override {}

	int GetSerial() const { return serial; }
	// Player goal: the scouted units of the goal's team, once per call
	void RefreshTargets();
	// The nearest target within reach of pos, by enemy id; -1 none
	int NearestTarget(const springai::AIFloat3& pos, int exceptId = -1) const;

private:
	struct SGoal {
		int targetId = -1;                               // player goal: the enemy it goes to
		springai::AIFloat3 orderPos = springai::AIFloat3(-1.f, 0.f, -1.f);
		int orderFrame = -1;
		int hiddenFrame = -1;                            // target spot first seen empty
	};
	struct STarget {
		int id;
		float x, z;
	};

	void Maintain(CCircuitUnit* unit, SGoal& goal, int frame, bool force);
	bool IsTargetGone(SGoal& goal, int frame) const;
	void Order(CCircuitUnit* unit, SGoal& goal, const springai::AIFloat3& pos, int frame);

	int serial;
	std::map<int, SGoal> goals;  // unit id -> its goal
	std::vector<STarget> targets;
	int targetsFrame;
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_FIGHTER_DEBUGGOALTASK_H_

/*
 * BraceTask.h
 *
 * D-474: a land constructor that is damaged, or whose structure under
 * construction is destroyed, steps back from the threat and builds one
 * defence between itself and the threat. CBuilderManager decides when
 * (BraceTrigger); the rules are engine-free in control/kernel/ConstructorBrace.h.
 *
 * One builder per task. Detached: never in buildTasks, so no other builder
 * takes it and it is not saved (after a load the builder gets new work).
 * Lifetime: done when the defence finishes, or when there is no defence to
 * build and the builder reaches its retreat point; aborted by the task
 * timeout. Two commands per brace: a MOVE, then a queued BUILD.
 */

#ifndef SRC_CIRCUIT_TASK_BUILDER_BRACETASK_H_
#define SRC_CIRCUIT_TASK_BUILDER_BRACETASK_H_

#include "task/builder/BuilderTask.h"

namespace circuit {

class CBBraceTask final: public IBuilderTask {
public:
	// buildDef may be null: retreat only (the builder can build no listed defence).
	// holdAbove: the health fraction at or below which the builder leaves the
	// brace for the retreat (the brace threshold; see CBuilderManager::BraceHold).
	CBBraceTask(ITaskModule* mgr, CCircuitDef* buildDef, const springai::AIFloat3& retreatPos,
				const springai::AIFloat3& sitePos, float holdAbove, int timeout);
	virtual ~CBBraceTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void AssignTo(CCircuitUnit* unit) override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;

	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;

	const springai::AIFloat3& GetRetreatPos() const { return retreatPos; }

protected:
	virtual void Finish() override;
	virtual bool Execute(CCircuitUnit* unit) override;

private:
	// The builder is back at (or near) its retreat point.
	bool Arrived(CCircuitUnit* unit) const;

	springai::AIFloat3 retreatPos;
	float holdAbove;
	int buildOrders = 0;  // BUILD commands given; bounded by MAX_BUILD_ORDERS
	int startFrame = -1;  // frame of Start: an idle right after it is stale
	bool restarted = false;  // the stale idle was answered once
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_BUILDER_BRACETASK_H_

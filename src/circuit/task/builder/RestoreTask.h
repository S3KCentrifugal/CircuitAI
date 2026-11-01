/*
 * RestoreTask.h
 *
 * Terrain restore (owner 2026-10-31): one builder pulls a square of damaged
 * ground (a crater, or crater lava) back to the map's original height with the
 * engine's CMD_RESTORE. Created and assigned by CRestoreControl only; it lives
 * outside buildTasks, so no other builder picks it and it is never saved.
 */

#ifndef SRC_CIRCUIT_TASK_BUILDER_RESTORETASK_H_
#define SRC_CIRCUIT_TASK_BUILDER_RESTORETASK_H_

#include "task/builder/BuilderTask.h"

#include <string>

namespace circuit {

class CBRestoreTask final: public IBuilderTask {
public:
	CBRestoreTask(ITaskModule* mgr, Priority priority, const springai::AIFloat3& position,
				  float radius, int reason, int maxFrames);
	virtual ~CBRestoreTask();

	virtual bool CanAssignTo(CCircuitUnit* unit) const override;
	virtual void RemoveAssignee(CCircuitUnit* unit) override;
	// restore.protect: ordinary builder and wait tasks, and the re-ask of a
	// busy builder, do not take the restorer away while the patch is worked
	virtual bool KeepsAssignee(const IUnitTask* next) const override;

	virtual void Start(CCircuitUnit* unit) override;
	virtual void Update() override;
	virtual void Stop(bool done) override;

private:
	virtual bool Execute(CCircuitUnit* unit) override;
	virtual bool Reevaluate(CCircuitUnit* unit) override { return true; }

public:
	virtual void OnUnitIdle(CCircuitUnit* unit) override;
	virtual void OnTravelEnd(CCircuitUnit* unit) override {}  // the engine walks it into range

	float GetRadius() const { return radius; }
	int GetReason() const { return reason; }

private:
	float radius;    // half side of the restored square, elmos (engine cap 200)
	int reason;      // CRestoreControl::Reason
	int maxFrames;   // abort when the restore has not finished by then
	int startFrame;  // first order given; -1 before
	int orders;      // restore orders given (the engine can drop one)
	int unitId;      // the restorer, for the log
	std::string unitName;
	mutable bool keptLogged;  // one "kept" line per task
};

} // namespace circuit

#endif // SRC_CIRCUIT_TASK_BUILDER_RESTORETASK_H_

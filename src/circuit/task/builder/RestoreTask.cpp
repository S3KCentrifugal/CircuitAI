/*
 * RestoreTask.cpp
 *
 * Terrain restore (owner 2026-10-31), see RestoreTask.h and
 * module/RestoreControl.h.
 */

#include "task/builder/RestoreTask.h"
#include "module/BuilderManager.h"
#include "module/RestoreControl.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "Log.h"
#include "UnitDef.h"

#include <algorithm>

namespace circuit {

using namespace springai;

CBRestoreTask::CBRestoreTask(ITaskModule* mgr, Priority priority, const AIFloat3& position,
							 float radius, int reason, int maxFrames)
		: IBuilderTask(mgr, priority, nullptr, position, Type::BUILDER, BuildType::TERRAFORM, {0.f, 0.f}, 0.f, maxFrames)
		, radius(radius)
		, reason(reason)
		, maxFrames(maxFrames)
		, startFrame(-1)
		, orders(0)
		, unitId(-1)
{
}

CBRestoreTask::~CBRestoreTask()
{
}

bool CBRestoreTask::CanAssignTo(CCircuitUnit* unit) const
{
	return units.empty() && static_cast<CBuilderManager*>(manager)->GetRestoreControl()->IsEligible(unit);
}

void CBRestoreTask::RemoveAssignee(CCircuitUnit* unit)
{
	IBuilderTask::RemoveAssignee(unit);
	if (units.empty() && !IsDead()) {
		manager->AbortTask(this);  // one restorer per patch: taken away (retreat, script) ends it
	}
}

void CBRestoreTask::Start(CCircuitUnit* unit)
{
	unitId = unit->GetId();
	unitName = unit->GetCircuitDef()->GetDef()->GetName();
	Execute(unit);
}

void CBRestoreTask::Update()
{
	// No per-unit pathing: the engine walks the restorer into range itself.
	if (units.empty() || (startFrame < 0)) {
		return;
	}
	if (manager->GetCircuit()->GetLastFrame() - startFrame > maxFrames) {
		manager->GetCircuit()->LOG("RESTORE: timeout %s(%i) at (%.0f, %.0f) r=%.0f after %i orders",
				unitName.c_str(), unitId, position.x, position.z, radius, orders);
		manager->AbortTask(this);
	}
}

void CBRestoreTask::Stop(bool done)
{
	const int frame = manager->GetCircuit()->GetLastFrame();
	const float seconds = (startFrame < 0) ? 0.f : float(frame - startFrame) / FRAMES_PER_SEC;
	IBuilderTask::Stop(done);
	static_cast<CBuilderManager*>(manager)->GetRestoreControl()->TaskEnded(this, done, seconds);
}

bool CBRestoreTask::Execute(CCircuitUnit* unit)
{
	executors.insert(unit);
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	if (startFrame < 0) {
		startFrame = frame;
	}
	++orders;
	TRY_UNIT(circuit, unit,
		unit->CmdRestoreArea(position, radius, 0, frame + FRAMES_PER_SEC * 60);
	)
	return true;
}

void CBRestoreTask::OnUnitIdle(CCircuitUnit* unit)
{
	// The engine ends CMD_RESTORE when this builder's share of the work is
	// spent, or drops it (unreachable, unit pushed away). Check the ground
	// itself, live, once per idle: at most 26x26 engine reads.
	CCircuitAI* circuit = manager->GetCircuit();
	CRestoreControl* control = static_cast<CBuilderManager*>(manager)->GetRestoreControl();
	CTerrainManager::SDamageQuery query;
	query.threshold = control->GetDamageThreshold();
	query.lavaLevel = control->GetLavaLevel();
	query.lavaMargin = control->GetLavaMargin();
	query.live = true;
	query.step = 2;
	// One cell in from the square's edge: the engine moves corners, and an
	// edge cell keeps the unrestored corners outside the square.
	const float inner = std::max(radius - 2.f * SQUARE_SIZE, float(SQUARE_SIZE));
	const CTerrainManager::STerrainDamage left = circuit->GetTerrainManager()->GetTerrainDamage(position, inner, query);
	if (left.cells == 0) {
		manager->DoneTask(this);
		return;
	}
	if (orders < 3) {
		circuit->LOG("RESTORE: again %s(%i) at (%.0f, %.0f): %i cells left, dug %.0f raised %.0f",
				unitName.c_str(), unitId, position.x, position.z, left.cells, left.dug, left.raised);
		Execute(unit);
		return;
	}
	circuit->LOG("RESTORE: gave up %s(%i) at (%.0f, %.0f): %i cells left after %i orders",
			unitName.c_str(), unitId, position.x, position.z, left.cells, orders);
	manager->AbortTask(this);
}

} // namespace circuit

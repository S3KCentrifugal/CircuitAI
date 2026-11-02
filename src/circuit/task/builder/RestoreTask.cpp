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

#define RLOG(c, fmt, ...) (c)->LOG("RESTORE[t%i]: " fmt, (c)->GetTeamId() __VA_OPT__(,) __VA_ARGS__)

CBRestoreTask::CBRestoreTask(ITaskModule* mgr, Priority priority, const AIFloat3& position,
							 float radius, int reason, int maxFrames)
		: IBuilderTask(mgr, priority, nullptr, position, Type::BUILDER, BuildType::TERRAFORM, {0.f, 0.f}, 0.f, maxFrames)
		, radius(radius)
		, reason(reason)
		, maxFrames(maxFrames)
		, startFrame(-1)
		, orders(0)
		, unitId(-1)
		, keptLogged(false)
{
}

CBRestoreTask::~CBRestoreTask()
{
}

bool CBRestoreTask::CanAssignTo(CCircuitUnit* unit) const
{
	// Up to restore.max_per_task restorers, all of the first one's class
	// (owner 2026-11-01: at most 2 air cons, or 2 T1 cons, or 2 rez bots)
	const CRestoreControl* control = static_cast<CBuilderManager*>(manager)->GetRestoreControl();
	if ((int(units.size()) >= control->GetMaxPerTask()) || !control->IsEligible(unit)) {
		return false;
	}
	return units.empty() || (control->ClassOf(*units.begin()) == control->ClassOf(unit));
}

void CBRestoreTask::RemoveAssignee(CCircuitUnit* unit)
{
	const bool killed = unit->IsDead();
	const bool wasOurs = (units.find(unit) != units.end());
	IBuilderTask::RemoveAssignee(unit);
	if (!wasOurs || IsDead()) {
		return;
	}
	RLOG(manager->GetCircuit(), "lost %s(%i) at (%.0f, %.0f): %s, %i restorer(s) left",
			unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), position.x, position.z,
			killed ? "killed" : "taken (retreat, fight or a task that may take it)", int(units.size()));
	static_cast<CBuilderManager*>(manager)->GetRestoreControl()->Lost(position, radius, killed);
	if (units.empty()) {
		manager->AbortTask(this);  // the last restorer is gone: the patch ends
	}
}

bool CBRestoreTask::KeepsAssignee(const IUnitTask* next) const
{
	if (IsDead() || units.empty() || !static_cast<CBuilderManager*>(manager)->GetRestoreControl()->IsProtected()) {
		return false;
	}
	if (next != nullptr) {
		// Retreat, fights, player orders and NOW builder tasks still take it.
		const IUnitTask::Type type = next->GetType();
		if ((type != Type::BUILDER) && (type != Type::WAIT) && (type != Type::IDLE)) {
			return false;
		}
		if ((type == Type::BUILDER) && (static_cast<const IBuilderTask*>(next)->GetPriority() == Priority::NOW)) {
			return false;
		}
		if (!keptLogged) {
			keptLogged = true;
			RLOG(manager->GetCircuit(), "kept %s(%i) on its restore at (%.0f, %.0f) (refused task type %i)",
					unitName.c_str(), unitId, position.x, position.z, int(type));
		}
	}
	return true;
}

void CBRestoreTask::Start(CCircuitUnit* unit)
{
	if (unitId < 0) {  // the first restorer names the patch in the log
		unitId = unit->GetId();
		unitName = unit->GetCircuitDef()->GetDef()->GetName();
	}
	Execute(unit);
}

void CBRestoreTask::Update()
{
	// No per-unit pathing: the engine walks the restorer into range itself.
	if (units.empty() || (startFrame < 0)) {
		return;
	}
	if (manager->GetCircuit()->GetLastFrame() - startFrame > maxFrames) {
		RLOG(manager->GetCircuit(), "timeout %s(%i) at (%.0f, %.0f) r=%.0f after %i orders",
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
		unit->CmdRestoreArea(position, radius, 0, frame + std::max(maxFrames, FRAMES_PER_SEC * 60));  // the walk out included
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
	// One cell in from the square's edge: the engine moves corners, and an
	// edge cell keeps the unrestored corners outside the square. Our and our
	// allies' building pads are skipped as in the scan, and less than a
	// patch's minimum is restored (the scan would never start it).
	const float inner = std::max(radius - 2.f * SQUARE_SIZE, float(SQUARE_SIZE));
	const CTerrainManager::STerrainDamage left = control->MeasureLive(position, inner);
	if (control->IsRestored(left)) {
		manager->DoneTask(this);
		return;
	}
	if (orders < 3 * std::max(1, int(units.size()))) {  // three orders per restorer
		RLOG(circuit, "again %s(%i) at (%.0f, %.0f): %i cells left, dug %.0f raised %.0f",
				unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), position.x, position.z, left.cells, left.dug, left.raised);
		Execute(unit);
		return;
	}
	RLOG(circuit, "gave up %s(%i) at (%.0f, %.0f): %i cells left after %i orders",
			unitName.c_str(), unitId, position.x, position.z, left.cells, orders);
	manager->AbortTask(this);
}

} // namespace circuit

/*
 * BraceTask.cpp
 *
 * D-474: see BraceTask.h and control/kernel/ConstructorBrace.h.
 */

#include "task/builder/BraceTask.h"
#include "task/RetreatTask.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitUnit.h"
#include "spring/SpringCallback.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "AISCommands.h"
#include "Log.h"

namespace circuit {

using namespace springai;

namespace {
// The retreat point counts as reached within this distance (elmos).
constexpr float ARRIVE_RADIUS = 32.f;
// How far from the planned site the defence may be placed (elmos): the site
// is near the builder by construction, so a small search keeps it between
// the builder and the threat.
constexpr float SITE_SEARCH = 96.f;
// BUILD orders per brace: the first, and one retry when the engine drops it.
constexpr int MAX_BUILD_ORDERS = 2;
// An idle event this soon after Start belongs to the order the builder had
// before (a frame destroyed under it reports idle after the brace began):
// played, b08, the brace spent its retry on it and its BUILD was then dropped.
constexpr int STALE_IDLE_FRAMES = 5;
}

CBBraceTask::CBBraceTask(ITaskModule* mgr, CCircuitDef* buildDef, const AIFloat3& retreatPos,
						 const AIFloat3& sitePos, float holdAbove, int timeout)
		: IBuilderTask(mgr, Priority::NOW, buildDef, sitePos, Type::BUILDER, BuildType::DEFENCE,
					   (buildDef != nullptr) ? SResource{buildDef->GetCostM(), buildDef->GetCostE()} : SResource{0.f, 0.f},
					   0.f, timeout)
		, retreatPos(retreatPos)
		, holdAbove(holdAbove)
{
	canAutoAbort = false;  // OnUnitDamaged/OnUnitDestroyed are handled here
}

CBBraceTask::~CBBraceTask()
{
}

bool CBBraceTask::CanAssignTo(CCircuitUnit* unit) const
{
	// One builder, the one it was made for (the manager assigns it directly).
	return units.empty() && ((buildDef == nullptr) || unit->GetCircuitDef()->CanBuild(buildDef));
}

void CBBraceTask::AssignTo(CCircuitUnit* unit)
{
	// No travel action and no path: two engine commands do the whole job.
	IUnitTask::AssignTo(unit);
	ShowAssignee(unit);
	if (initiator == nullptr) {
		initiator = unit;
	}
}

void CBBraceTask::Start(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	startFrame = circuit->GetLastFrame();
	TRY_UNIT(circuit, unit,
		unit->CmdPriority(ClampPriority());
		unit->CmdMoveTo(retreatPos, UNIT_CMD_OPTION, INT_MAX);
	)
	if (buildDef != nullptr) {
		Execute(unit);
	}
}

bool CBBraceTask::Execute(CCircuitUnit* unit)
{
	if ((buildDef == nullptr) || (buildOrders >= MAX_BUILD_ORDERS)) {
		return false;
	}
	CCircuitAI* circuit = manager->GetCircuit();
	if (target != nullptr) {
		++buildOrders;
		TRY_UNIT(circuit, unit,
			unit->CmdRepair(target, UNIT_COMMAND_OPTION_SHIFT_KEY, INT_MAX);
		)
		return true;
	}
	if (!geom::is_valid(buildPos)) {
		// Reachable without the safe-path test: the site is toward the threat
		// on purpose. No reservation is served (no BeginReservedSearch).
		CTerrainManager* terrainMgr = circuit->GetTerrainManager();
		CBuilderManager* builderMgr = circuit->GetBuilderManager();
		const float reach = unit->GetCircuitDef()->GetBuildDistance();
		// No wreck on the site: the engine drops a BUILD on a feature, and a
		// lost frame's ground often holds one (played, b08).
		COOAICallback* callback = circuit->GetCallback();
		const float clear = buildDef->GetRadius();
		CTerrainManager::TerrainPredicate predicate = [this, terrainMgr, builderMgr, callback, unit, reach, clear](const AIFloat3& p) {
			return builderMgr->IsBuildPositionAllowed(buildDef, p) && !callback->IsFeaturesIn(p, clear)
				&& terrainMgr->CanReachAt(unit, p, reach);
		};
		FindFacing(position);
		SetBuildPos(terrainMgr->FindBuildSite(buildDef, position, SITE_SEARCH, facing, predicate));
		if (!geom::is_valid(buildPos)) {
			circuit->LOG("[Brace] unit=%i no_site def=%s at=%.0f,%.0f", unit->GetId(),
					buildDef->GetDef()->GetName(), position.x, position.z);
			buildOrders = MAX_BUILD_ORDERS;  // retreat only
			return false;
		}
	}
	++buildOrders;
	circuit->LOG("[Brace] unit=%i build_order=%i def=%s site=%.0f,%.0f", unit->GetId(), buildOrders,
			buildDef->GetDef()->GetName(), buildPos.x, buildPos.z);
	TRY_UNIT(circuit, unit,
		// Queued behind the MOVE: the builder steps back first, then builds.
		if (!BuildAtSite(unit, UNIT_COMMAND_OPTION_SHIFT_KEY, INT_MAX)) {
			circuit->LOG("[Brace] unit=%i site_refused def=%s", unit->GetId(), buildDef->GetDef()->GetName());
			buildOrders = MAX_BUILD_ORDERS;
			return false;
		}
	)
	return true;
}

void CBBraceTask::Update()
{
	if (units.empty()) {
		// Taken away (retreat, a controller, a script, death): nothing left
		// to do. A started frame stays for the repair watchdog.
		manager->AbortTask(this);
		return;
	}
	CCircuitUnit* unit = *units.begin();
	CCircuitAI* circuit = manager->GetCircuit();
	// INV-257 (D-474): the brace threshold supersedes the brace. OnUnitDamaged
	// hands a builder at or below it to the retreat task; a builder still here
	// below the threshold means a damage event was missed.
	if (unit->GetHealthPercent() <= holdAbove) {
		circuit->LOG("[INVARIANT] INV-257 brace kept below the brace threshold unit=%i health=%.2f threshold=%.2f",
				unit->GetId(), unit->GetHealthPercent(), holdAbove);
		manager->AssignTask(unit, manager->EnqueueRetreat());
		manager->AbortTask(this);
		return;
	}
	// Retreat only: done on arrival.
	if (((buildDef == nullptr) || (buildOrders >= MAX_BUILD_ORDERS && (target == nullptr))) && Arrived(unit)) {
		manager->DoneTask(this);
	}
	// A defence finishing ends the task through CBuilderManager::UnitFinished.
}

bool CBBraceTask::Arrived(CCircuitUnit* unit) const
{
	const AIFloat3& pos = unit->GetPos(manager->GetCircuit()->GetLastFrame());
	return pos.SqDistance2D(retreatPos) <= ARRIVE_RADIUS * ARRIVE_RADIUS;
}

void CBBraceTask::OnUnitIdle(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	if (!restarted && (circuit->GetLastFrame() - startFrame <= STALE_IDLE_FRAMES)) {
		// The previous order's idle: give the MOVE and the BUILD again, uncounted.
		restarted = true;
		circuit->LOG("[Brace] unit=%i stale_idle reissue", unit->GetId());
		TRY_UNIT(circuit, unit,
			unit->CmdMoveTo(retreatPos, UNIT_CMD_OPTION, INT_MAX);
			if ((buildDef != nullptr) && (target == nullptr) && geom::is_valid(buildPos)) {
				BuildAtSite(unit, UNIT_COMMAND_OPTION_SHIFT_KEY, INT_MAX);
			}
		)
		return;
	}
	{
		const AIFloat3& pos = unit->GetPos(manager->GetCircuit()->GetLastFrame());
		manager->GetCircuit()->LOG("[Brace] unit=%i idle orders=%i frame=%i at=%.0f,%.0f", unit->GetId(), buildOrders,
				(target != nullptr) ? target->GetId() : -1, pos.x, pos.z);
	}
	// The MOVE ended and the BUILD was dropped (blocked site, no resources to
	// start): one retry on a fresh site search, then the task ends where the
	// builder stands.
	if ((buildDef != nullptr) && (target == nullptr) && (buildOrders < MAX_BUILD_ORDERS)) {
		SetBuildPos(-RgtVector);
	}
	if ((buildDef != nullptr) && Execute(unit)) {
		return;
	}
	manager->DoneTask(this);
}

void CBBraceTask::OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	// Already bracing. Only the brace threshold interrupts (D-474: holdAbove,
	// not the builder's ordinary retreat fraction); the self-destruct rule of
	// the other builder tasks is kept.
	CCircuitDef* cdef = unit->GetCircuitDef();
	const float healthPerc = unit->GetHealthPercent();
	if ((healthPerc > holdAbove) && !unit->IsDisarmed(manager->GetCircuit()->GetLastFrame())) {
		if (healthPerc < cdef->GetSelfDHP()) {
			unit->CmdSelfD(true);
		}
		return;
	}
	manager->AssignTask(unit, manager->EnqueueRetreat());
	manager->AbortTask(this);
}

void CBBraceTask::Finish()
{
	// No build chain and no build delay: the defence is the whole job.
}

} // namespace circuit

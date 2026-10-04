/*
 * ReclaimTask.cpp
 *
 *  Created on: Mar 31, 2015
 *      Author: rlcevg
 */

#include "task/static/ReclaimTask.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/FactoryManager.h"
#include "unit/action/DGunAction.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringCallback.h"

namespace circuit {

using namespace springai;

CSReclaimTask::CSReclaimTask(ITaskModule* mgr, Priority priority,
							 const AIFloat3& position,
							 SResource cost, int timeout, float radius)
		: IReclaimTask(mgr, priority, Type::FACTORY, position, cost, timeout, radius)
{
}

CSReclaimTask::~CSReclaimTask()
{
}

CSReclaimTask::CSReclaimTask(ITaskModule* mgr, int id)
		: IReclaimTask(mgr, Priority::NOW, Type::FACTORY, -RgtVector, {0.f, 0.f}, 0, 0.f, false)
		, enemyId(id)
{
}

void CSReclaimTask::AssignTo(CCircuitUnit* unit)
{
	IUnitTask::AssignTo(unit);

	CCircuitAI* circuit = manager->GetCircuit();
	ShowAssignee(unit);
	if (!geom::is_valid(position)) {
		position = unit->GetPos(circuit->GetLastFrame());
	}

	if (unit->HasDGun()) {
		unit->PushDGunAct(new CDGunAction(unit, unit->GetDGunRange()));
	}

	lastTouched = circuit->GetLastFrame();
}

void CSReclaimTask::Start(CCircuitUnit* unit)
{
	if (IsEnemyReclaim()) {
		// No economic or anti-capture action may replace this defensive command.
		unit->ClearAct();
		ReclaimEnemy(unit, enemyId);
		return;
	}
	Execute(unit);
}

void CSReclaimTask::ReclaimEnemy(CCircuitUnit* unit, int id)
{
	CCircuitAI* circuit = manager->GetCircuit();
	CEnemyInfo* enemy = circuit->GetFactoryManager()->GetReclaimEnemy(unit, id);
	if (enemy == nullptr) return;
	const int frame = circuit->GetLastFrame();
	if (id == enemyId && (!commandNeeded || frame - lastEnemyCommand < FRAMES_PER_SEC)) return;
	enemyId = id;
	TRY_UNIT(circuit, unit,
		unit->CmdReclaimEnemy(enemy); // replace current order; one command until idle or target change
	)
	commandNeeded = false;
	lastEnemyCommand = frame;
}

void CSReclaimTask::OnUnitIdle(CCircuitUnit* unit)
{
	if (IsEnemyReclaim()) {
		// Revalidate/retarget in the shared response pass, not a stale idle callback.
		commandNeeded = true;
		return;
	}
	IReclaimTask::OnUnitIdle(unit);
}

void CSReclaimTask::Stop(bool done)
{
	if (IsEnemyReclaim()) {
		for (CCircuitUnit* unit : units) {
			TRY_UNIT(manager->GetCircuit(), unit, unit->CmdStop();)
		}
	}
	IReclaimTask::Stop(done);
}

void CSReclaimTask::Update()
{
	if (IsEnemyReclaim()) return; // validity/release is owned by the shared response pass
	CCircuitAI* circuit = manager->GetCircuit();
	if (circuit->GetEconomyManager()->IsMetalFull()) {
		manager->AbortTask(this);
	} else if ((++updCount % 4 == 0) && !units.empty()) {
		// Check for damaged units
		CBuilderManager* builderMgr = circuit->GetBuilderManager();
		CAllyUnit* repairTarget = nullptr;
		circuit->UpdateFriendlyUnits();
		auto& us = circuit->GetCallback()->GetFriendlyUnitsIn(position, radius * 0.9f);
		for (Unit* u : us) {
			auto [cand, isTeam] = circuit->GetTeamOrAllyUnit(u);
			if ((cand == nullptr)  // no self-check
				|| builderMgr->IsReclaimUnit(cand)
				|| (isTeam ? static_cast<CCircuitUnit*>(cand)->IsAttrNoRepair() : cand->GetCircuitDef()->IsAttrNoRepair()))
			{
				continue;
			}
			if (!u->IsBeingBuilt() && (u->GetHealth() < u->GetMaxHealth())) {
				repairTarget = cand;
				break;
			}
		}
		utils::free(us);
		if (repairTarget != nullptr) {
			// Repair task
			IUnitTask* task = circuit->GetFactoryManager()->Enqueue(TaskS::Repair(
					IBuilderTask::Priority::NORMAL, repairTarget));
			decltype(units) tmpUnits = units;
			for (CCircuitUnit* unit : tmpUnits) {
				manager->AssignTask(unit, task);
			}
			manager->AbortTask(this);
		}
	}
}

void CSReclaimTask::OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	if (IsEnemyReclaim()) return;
	if (unit->GetHealthPercent() < unit->GetCircuitDef()->GetSelfDHP()) {
		unit->CmdSelfD(true);
	}
}

} // namespace circuit

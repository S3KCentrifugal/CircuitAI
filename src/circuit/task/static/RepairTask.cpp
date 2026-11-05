/*
 * RepairTask.cpp
 *
 *  Created on: Mar 30, 2015
 *      Author: rlcevg
 */

#include "task/static/RepairTask.h"
#include "module/BuilderManager.h"
#include "module/EconomyManager.h"
#include "module/FactoryManager.h"
#include "unit/action/DGunAction.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringCallback.h"

#include "AISCommands.h"
#include "Log.h"
#include "Feature.h"

namespace circuit {

using namespace springai;

CSRepairTask::CSRepairTask(ITaskModule* mgr, Priority priority, CAllyUnit* target, int timeout)
		: IRepairTask(mgr, priority, Type::FACTORY, target, timeout)
{
	static_cast<CFactoryManager*>(mgr)->MarkRepairUnit(target->GetId(), this);
}

CSRepairTask::~CSRepairTask()
{
}

void CSRepairTask::AssignTo(CCircuitUnit* unit)
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
}

void CSRepairTask::Start(CCircuitUnit* unit)
{
	IRepairTask::Start(unit);
	if (targetId != -1) {
		Execute(unit);
	}
}

void CSRepairTask::Update()
{
	CCircuitAI* circuit = manager->GetCircuit();
	CEconomyManager* economyMgr = circuit->GetEconomyManager();

	// D-468: before the energy-empty return, which used to skip every check.
	if (ReleaseOutOfReach()) {
		return;
	}

	const bool isEnergyEmpty = economyMgr->IsEnergyEmpty();
	for (CCircuitUnit* unit : units) {
		TRY_UNIT(circuit, unit,
			unit->CmdWait(isEnergyEmpty);
		)
	}
	if (isEnergyEmpty) {
		return;
	}

	if ((economyMgr->GetAvgMetalIncome() < savedIncome.metal * 0.6f) || (economyMgr->GetAvgEnergyIncome() < savedIncome.energy * 0.6f)) {
		manager->AbortTask(this);
	} else if ((++updCount % 4 == 0) && !units.empty()) {
		const float radius = (*units.begin())->GetCircuitDef()->GetBuildDistance();
		// D-468: look for the next target around the turret, not around the old
		// target: from there a target up to twice the reach away was handed to
		// every assignee (played: three turrets released and re-given one wind
		// turbine every second or two).
		const AIFloat3 searchPos = (*units.begin())->GetPos(circuit->GetLastFrame());
		CAllyUnit* repTarget = circuit->GetFriendlyUnit(targetId);
		if ((repTarget == nullptr)
			|| (position.SqDistance2D(repTarget->GetPos(circuit->GetLastFrame())) > SQUARE(radius * 0.9f)))
		{
			manager->AbortTask(this);
			return;
		}
		if (circuit->GetBuilderManager()->IsReclaimUnit(repTarget)) {
			manager->AbortTask(this);  // marked for reclaim by us or a teammate since we started
			return;
		}

		IUnitTask* task = nullptr;
		if (repTarget->GetUnit()->IsBeingBuilt()) {
			CFactoryManager* factoryMgr = circuit->GetFactoryManager();
			if (economyMgr->IsMetalEmpty() && !factoryMgr->IsHighPriority(repTarget)) {
				// Check for damaged units
				CBuilderManager* builderMgr = circuit->GetBuilderManager();
				circuit->UpdateFriendlyUnits();
				auto& us = circuit->GetCallback()->GetFriendlyUnitsIn(searchPos, radius * 0.9f);
				for (Unit* u : us) {
					auto [cand, isTeam] = circuit->GetTeamOrAllyUnit(u);
					if ((cand == nullptr)  // no self-check
						|| builderMgr->IsReclaimUnit(cand)
						|| (isTeam ? static_cast<CCircuitUnit*>(cand)->IsAttrNoRepair() : cand->GetCircuitDef()->IsAttrNoRepair()))
					{
						continue;
					}
					if (!u->IsBeingBuilt() && (u->GetHealth() < u->GetMaxHealth())) {
						task = factoryMgr->Enqueue(TaskS::Repair(IBuilderTask::Priority::NORMAL, cand));
						break;
					}
				}
				utils::free(us);
				if (task == nullptr) {
					// Reclaim task
					if (circuit->GetCallback()->IsFeaturesIn(searchPos, radius) && !builderMgr->IsResurrect(searchPos, radius)) {
						task = factoryMgr->Enqueue(TaskS::Reclaim(IBuilderTask::Priority::NORMAL, searchPos, radius));
					}
				}
			}
		} else if (economyMgr->IsMetalFull()) {
			// Check for units under construction
			CFactoryManager* factoryMgr = circuit->GetFactoryManager();
			CBuilderManager* builderMgr = circuit->GetBuilderManager();
			const float maxCost = MAX_BUILD_SEC * economyMgr->GetAvgMetalIncome() * economyMgr->GetEcoFactor();
			circuit->UpdateFriendlyUnits();
			auto& us = circuit->GetCallback()->GetFriendlyUnitsIn(searchPos, radius * 0.9f);
			for (Unit* u : us) {
				auto [cand, isTeam] = circuit->GetTeamOrAllyUnit(u);
				if ((cand == nullptr)  // no self-check
					|| builderMgr->IsReclaimUnit(cand)
					|| (isTeam ? static_cast<CCircuitUnit*>(cand)->IsAttrNoRepair() : cand->GetCircuitDef()->IsAttrNoRepair()))
				{
					continue;
				}
				bool isHighPrio = factoryMgr->IsHighPriority(cand);
				if (u->IsBeingBuilt() && ((cand->GetCircuitDef()->GetBuildTime() < maxCost) || isHighPrio)) {
					IBuilderTask::Priority priority = isHighPrio ? IBuilderTask::Priority::HIGH : IBuilderTask::Priority::NORMAL;
					task = factoryMgr->Enqueue(TaskS::Repair(priority, cand));
					break;
				}
			}
			utils::free(us);
		}

		if (task != nullptr) {
			decltype(units) tmpUnits = units;
			for (CCircuitUnit* unit : tmpUnits) {
				manager->AssignTask(unit, task);
			}
			manager->AbortTask(this);
		}
	}
}

// D-468: a construction turret cannot walk to its target. The engine keeps an
// out-of-reach repair order until its 60 s timeout (BuilderCAI::MoveInBuildRange
// only sets a move goal, and a turret has none to follow), so a turret whose
// target walked off - a constructor leaving the factory - stood idle with the
// order still shown. The check below every 4th update measured how far the
// target moved from where the task began, not from each turret, and allowed
// up to twice the reach; while energy was empty it never ran at all.
// Each assignee's own reach is the engine's (build distance + the target's
// radius, 2D or 3D per the turret's def), with no inset: every picker
// (CreateAssistTask 0.9 x reach + radius, the re-target below, FRONT's
// FrontFactorySupport within the build distance) stays inside it, so a turret
// is never released from a target it was just given (an inset of 32 did that:
// played, one turret re-given a constructor in its yard 11 times). Cost:
// O(assignees) distances per update, usually one or two; a command only when
// a turret is released.
bool CSRepairTask::ReleaseOutOfReach()
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	CAllyUnit* repTarget = circuit->GetFriendlyUnit(targetId);
	if ((repTarget == nullptr) || units.empty()) {
		return false;  // the existing checks below own a lost target
	}
	const AIFloat3& targetPos = repTarget->GetPos(frame);
	const float targetRadius = repTarget->GetCircuitDef()->GetRadius();
	outOfReach.clear();
	for (CCircuitUnit* unit : units) {
		CCircuitDef* cdef = unit->GetCircuitDef();
		if (cdef->IsMobile()) {
			continue;
		}
		const AIFloat3& pos = unit->GetPos(frame);
		const float sqDist = cdef->GetDef()->IsBuildRange3D() ? pos.SqDistance(targetPos) : pos.SqDistance2D(targetPos);
		const float reach = cdef->GetBuildDistance() + targetRadius;
		if (sqDist > SQUARE(reach)) {
			outOfReach.push_back(unit);
		}
	}
	if (outOfReach.empty()) {
		return false;
	}
	for (CCircuitUnit* unit : outOfReach) {
		circuit->LOG("[TurretRepair] release turret=%i target=%i (%s) out of reach",
				unit->GetId(), targetId, repTarget->GetCircuitDef()->GetDef()->GetName());
		TRY_UNIT(circuit, unit,
			unit->CmdStop();
		)
	}
	if (outOfReach.size() == units.size()) {
		manager->AbortTask(this);
		return true;
	}
	for (CCircuitUnit* unit : outOfReach) {
		RemoveAssignee(unit);  // to the idle task; the next ask chooses again
	}
	return false;
}

void CSRepairTask::Finish()
{
	CCircuitAI* circuit = manager->GetCircuit();
	for (CCircuitUnit* unit : units) {
		TRY_UNIT(circuit, unit,
			unit->CmdPriority(0);
			unit->CmdPatrolTo(position, UNIT_COMMAND_OPTION_SHIFT_KEY);
		)
	}

	IRepairTask::Finish();
}

void CSRepairTask::OnUnitIdle(CCircuitUnit* unit)
{
	manager->DoneTask(this);
}

void CSRepairTask::OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	if (unit->GetHealthPercent() < unit->GetCircuitDef()->GetSelfDHP()) {
		unit->CmdSelfD(true);
	}
}

} // namespace circuit

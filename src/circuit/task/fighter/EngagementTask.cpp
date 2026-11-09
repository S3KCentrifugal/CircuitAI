/*
 * EngagementTask.cpp
 *
 * D-440: see EngagementTask.h. The lifecycle below is the engagement branch
 * CArtilleryTask carried from D-288 to D-433, unchanged in order and effect.
 */

#include "task/fighter/EngagementTask.h"
#include "task/fighter/RangedEngagement.h"
#include "task/RetreatTask.h"
#include "module/MilitaryManager.h"
#include "setup/SetupManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"

namespace circuit {

using namespace springai;

CEngagementTask::CEngagementTask(ITaskModule* mgr)
		: IFighterTask(mgr, FightType::ENGAGE, 1.f)
{
	position = manager->GetCircuit()->GetSetupManager()->GetBasePos();
}

CEngagementTask::~CEngagementTask()
{
}

bool CEngagementTask::CanAssignTo(CCircuitUnit* unit) const
{
	return units.empty() && unit->GetCircuitDef()->HasEngagementPolicy();
}

void CEngagementTask::AssignTo(CCircuitUnit* unit)
{
	IFighterTask::AssignTo(unit);
	ranged = std::make_unique<CRangedEngagement>(manager->GetCircuit(), this, unit);
}

void CEngagementTask::RemoveAssignee(CCircuitUnit* unit)
{
	if (ranged) {
		ranged->Release(unit);
		ranged.reset();
	}
	IFighterTask::RemoveAssignee(unit);
	if (units.empty()) {
		manager->AbortTask(this);
	}

	unit->CmdSetMoveState(unit->GetCircuitDef()->GetMoveState());  // default: CCircuitDef::MoveType::MANEUVRE
}

void CEngagementTask::Start(CCircuitUnit* unit)
{
	Execute(unit);
}

bool CEngagementTask::ForgetUnit(CCircuitUnit* unit)
{
	// ForgetUnitEverywhere broadcasts every removed ally to every task. Only
	// this task's assignee owns this engagement; clearing it for another unit
	// would leave the assignee without its decision loop.
	if (ranged && units.count(unit)) { ranged->Release(unit, false); ranged.reset(); }
	return IFighterTask::ForgetUnit(unit);
}

void CEngagementTask::Stop(bool done)
{
	if (ranged) {
		ranged->Release(units.empty() ? nullptr : *units.begin());
		ranged.reset();
	}
	IFighterTask::Stop(done);
}

void CEngagementTask::Update()
{
	for (CCircuitUnit* unit : units) Execute(unit);
}

void CEngagementTask::Execute(CCircuitUnit* unit)
{
	if (!ranged) return;
	ranged->Update(unit);
	auto* selected = manager->GetCircuit()->GetEnemyInfo(ranged->Target());
	if (selected != GetTarget()) SetTarget(selected);
	position = unit->GetPos(manager->GetCircuit()->GetLastFrame());
}

void CEngagementTask::OnUnitIdle(CCircuitUnit* unit)
{
	IFighterTask::OnUnitIdle(unit);
	if (ranged) ranged->Idle();
}

void CEngagementTask::OnUnitMoveFailed(CCircuitUnit* unit)
{
	if (ranged) { ranged->MoveFailed(); return; }
	IFighterTask::OnUnitMoveFailed(unit);
}

void CEngagementTask::OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	if (ranged) {
		ranged->Idle();
		// Script/JSON chooses this doctrine. Forward-only firing-line hulls
		// retain their weapon owner even at low HP; other hulls keep the
		// existing native repair retreat. No polling or extra query is added.
		if (unit->GetCircuitDef()->GetRangedPolicy().holdFireline || ranged->IsSustainedRush()) return;
		// Holding a firing position need never raise another idle event, so
		// health retreat must hand over now rather than wait in cowards.
		if (unit->GetHealthPercent() <= unit->GetCircuitDef()->GetRetreat()) {
			manager->AssignTask(unit, manager->EnqueueRetreat());
			return;
		}
	}
	IFighterTask::OnUnitDamaged(unit, attacker);
}

} // namespace circuit

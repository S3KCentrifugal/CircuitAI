/*
 * DebugGoalTask.cpp
 *
 * See DebugGoalTask.h.
 */

#include "task/fighter/DebugGoalTask.h"
#include "task/static/DebugStrike.h"
#include "module/MilitaryManager.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitDef.h"
#include "unit/enemy/EnemyManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringMap.h"

#include "UnitDef.h"

namespace circuit {

using namespace springai;

// A member re-issues its move when the target moved this far from the order
#define GOAL_MOVED			(SQUARE_SIZE * 12)
// ... or when it went idle (or every GOAL_RENEW) farther than this from it
#define GOAL_ARRIVED		(SQUARE_SIZE * 16)
#define GOAL_RENEW			(FRAMES_PER_SEC * 30)
// A target spot seen empty this long means the target no longer exists there:
// the hidden flag flickers while a unit leaves and re-enters sight
#define GOAL_HIDDEN_FRAMES	(FRAMES_PER_SEC * 3)
#define GOAL_TARGETS_EVERY	(FRAMES_PER_SEC / 2)

CDebugGoalTask::CDebugGoalTask(ITaskModule* mgr, int serial)
		: IFighterTask(mgr, FightType::GOAL, 1.f)
		, serial(serial)
		, targetsFrame(-1000000)
{
}

CDebugGoalTask::~CDebugGoalTask()
{
}

void CDebugGoalTask::AssignTo(CCircuitUnit* unit)
{
	IFighterTask::AssignTo(unit);
	goals[unit->GetId()] = SGoal();
}

void CDebugGoalTask::RemoveAssignee(CCircuitUnit* unit)
{
	goals.erase(unit->GetId());
	IFighterTask::RemoveAssignee(unit);  // to the idle task: normal assignment takes it
}

bool CDebugGoalTask::ForgetUnit(CCircuitUnit* unit)
{
	goals.erase(unit->GetId());
	return IFighterTask::ForgetUnit(unit);
}

void CDebugGoalTask::Start(CCircuitUnit* unit)
{
	auto it = goals.find(unit->GetId());
	if (it == goals.end()) return;
	Maintain(unit, it->second, manager->GetCircuit()->GetLastFrame(), true);
}

void CDebugGoalTask::Stop(bool done)
{
	goals.clear();
	IFighterTask::Stop(done);
}

void CDebugGoalTask::RefreshTargets()
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	if (frame - targetsFrame < GOAL_TARGETS_EVERY) return;
	targetsFrame = frame;
	targets.clear();
	const debug::Strike& s = circuit->GetMilitaryManager()->GetDebugStrike(debug::GOAL);
	if (s.mode != debug::Mode::TEAM) return;
	// The team's units the AI has scouted (team cached at first LOS), in sight
	// or ghosts; not aircraft, which no ground goal can reach or keep up with
	const CEnemyManager* enemies = circuit->GetEnemyManager();
	for (const auto* pool : {&enemies->GetHostileDatas(), &enemies->GetPeaceDatas()}) {
		for (const SEnemyData& e : *pool) {
			if (e.IsFake() || e.IsDead() || e.IsDying() || e.IsHidden() || (e.team != s.team)
				|| ((e.cdef != nullptr) && e.cdef->IsAbleToFly())) continue;
			targets.push_back({e.id, e.pos.x, e.pos.z});
		}
	}
}

int CDebugGoalTask::NearestTarget(const AIFloat3& pos, int exceptId) const
{
	const float reach = debug::GoalReach(debug::Mode::TEAM,
			CTerrainManager::GetTerrainWidth(), CTerrainManager::GetTerrainHeight());
	if (exceptId < 0) {
		const int i = debug::NearestWithin(pos.x, pos.z, targets.data(), int(targets.size()), reach);
		return (i < 0) ? -1 : targets[i].id;
	}
	int best = -1;
	float bestSq = reach * reach;
	for (const STarget& t : targets) {
		if (t.id == exceptId) continue;
		const float sq = SQUARE(t.x - pos.x) + SQUARE(t.z - pos.z);
		if (sq <= bestSq) { bestSq = sq; best = t.id; }
	}
	return best;
}

void CDebugGoalTask::Update()
{
	// No IFighterTask::Update: a shield unit does not retreat either
	CCircuitAI* circuit = manager->GetCircuit();
	const debug::Strike& s = circuit->GetMilitaryManager()->GetDebugStrike(debug::GOAL);
	if (!s.Active() || (s.serial != serial)) return;  // the manager ends this task
	const int frame = circuit->GetLastFrame();
	RefreshTargets();
	// Maintain can release a member: walk a copy
	const std::vector<CCircuitUnit*> members(units.begin(), units.end());
	for (CCircuitUnit* unit : members) {
		auto it = goals.find(unit->GetId());
		if ((it == goals.end()) || unit->IsDead()) continue;
		Maintain(unit, it->second, frame, false);
	}
}

void CDebugGoalTask::OnUnitIdle(CCircuitUnit* unit)
{
	IFighterTask::OnUnitIdle(unit);
	if (unit->GetTask() != this) return;
	auto it = goals.find(unit->GetId());
	if (it == goals.end()) return;
	const int frame = manager->GetCircuit()->GetLastFrame();
	if (geom::is_valid(it->second.orderPos)
		&& (unit->GetPos(frame).SqDistance2D(it->second.orderPos) <= SQUARE(GOAL_ARRIVED))) return;  // there
	Maintain(unit, it->second, frame, true);
}

bool CDebugGoalTask::IsTargetGone(SGoal& goal, int frame) const
{
	CEnemyInfo* target = manager->GetCircuit()->GetEnemyInfo(goal.targetId);
	if ((target == nullptr) || (target->GetUnit() == nullptr)) return true;
	if (target->GetData()->IsDead() || target->GetData()->IsDying()) return true;
	if (!target->IsHidden()) {
		goal.hiddenFrame = -1;
		return false;
	}
	if (goal.hiddenFrame < 0) goal.hiddenFrame = frame;
	return frame - goal.hiddenFrame >= GOAL_HIDDEN_FRAMES;
}

void CDebugGoalTask::Maintain(CCircuitUnit* unit, SGoal& goal, int frame, bool force)
{
	CCircuitAI* circuit = manager->GetCircuit();
	debug::Strike& s = circuit->GetMilitaryManager()->GetDebugStrike(debug::GOAL);
	const AIFloat3 pos = unit->GetPos(frame);
	if (s.mode == debug::Mode::POS) {
		const AIFloat3 dest(s.x, circuit->GetMap()->GetElevationAt(s.x, s.z), s.z);
		if (force || (goal.orderFrame < 0)
			|| ((frame - goal.orderFrame >= GOAL_RENEW) && (pos.SqDistance2D(dest) > SQUARE(GOAL_ARRIVED))))
		{
			Order(unit, goal, dest, frame);
		}
		return;
	}
	if (s.mode != debug::Mode::TEAM) return;

	if (goal.targetId >= 0 && IsTargetGone(goal, frame)) {
		const int gone = goal.targetId;
		++s.launches;  // GOAL: targets gone while members headed to them
		goal.targetId = NearestTarget(pos, gone);
		goal.hiddenFrame = -1;
		if (goal.targetId < 0) {
			circuit->LOG("DEBUG: goal: %s(%i) target %i gone, none of team %i left within reach: normal behaviour",
					unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), gone, s.team);
			RemoveAssignee(unit);  // goal is no longer valid
			return;
		}
		force = true;
		circuit->LOG("DEBUG: goal: %s(%i) target %i gone, next nearest %i", unit->GetCircuitDef()->GetDef()->GetName(),
				unit->GetId(), gone, goal.targetId);
	}
	if (goal.targetId < 0) {
		goal.targetId = NearestTarget(pos);
		if (goal.targetId < 0) {
			RemoveAssignee(unit);  // nothing of the team within reach of it
			return;
		}
		force = true;
	}
	CEnemyInfo* target = circuit->GetEnemyInfo(goal.targetId);
	if (target == nullptr) return;  // gone: the next update picks another
	AIFloat3 dest = target->GetPos();  // in sight / radar: where it is; a ghost: its last known spot
	dest.y = circuit->GetMap()->GetElevationAt(dest.x, dest.z);
	if (force || (goal.orderFrame < 0) || !geom::is_valid(goal.orderPos)
		|| (dest.SqDistance2D(goal.orderPos) > SQUARE(GOAL_MOVED))
		|| ((frame - goal.orderFrame >= GOAL_RENEW) && (pos.SqDistance2D(dest) > SQUARE(GOAL_ARRIVED))))
	{
		Order(unit, goal, dest, frame);
	}
}

void CDebugGoalTask::Order(CCircuitUnit* unit, SGoal& goal, const AIFloat3& pos, int frame)
{
	CCircuitAI* circuit = manager->GetCircuit();
	TRY_UNIT(circuit, unit,
		unit->CmdMoveTo(pos);
	)
	goal.orderPos = pos;
	goal.orderFrame = frame;
	state = State::ENGAGE;
}

} // namespace circuit

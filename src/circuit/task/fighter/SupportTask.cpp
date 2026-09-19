/*
 * SupportTask.cpp
 *
 *  Created on: Jul 3, 2016
 *      Author: rlcevg
 */

#include "task/fighter/SupportTask.h"
#include "task/fighter/SquadTask.h"
#include "module/MilitaryManager.h"
#include "setup/SetupManager.h"
#include "terrain/TerrainManager.h"
#include "terrain/path/PathFinder.h"
#include "terrain/path/QueryPathMulti.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "AISCommands.h"

#include <algorithm>

namespace circuit {

using namespace springai;

CSupportTask::CSupportTask(ITaskModule* mgr)
		: IFighterTask(mgr, FightType::SUPPORT, 1.f)
{
	const AIFloat3& pos = manager->GetCircuit()->GetSetupManager()->GetBasePos();
	position = geom::get_radial_pos(pos, SQUARE_SIZE * 32);
}

CSupportTask::~CSupportTask()
{
}

void CSupportTask::RemoveAssignee(CCircuitUnit* unit)
{
	IFighterTask::RemoveAssignee(unit);
	if (units.empty()) {
		manager->AbortTask(this);
	}
}

void CSupportTask::Start(CCircuitUnit* unit)
{
	if (State::DISENGAGE == state) {
		return;
	}

	CCircuitAI* circuit = manager->GetCircuit();
	CTerrainManager* terrainMgr = circuit->GetTerrainManager();
	AIFloat3 pos = position;
	CTerrainManager::CorrectPosition(pos);
	AIFloat3 freePos = terrainMgr->FindBuildSite(unit->GetCircuitDef(), pos, 300.0f, UNIT_NO_FACING, true);
//	AIFloat3 freePos = terrainMgr->FindSpringBuildSite(unit->GetCircuitDef(), pos, 300.0f, UNIT_NO_FACING);
	pos = geom::is_valid(freePos) ? freePos : pos;

	TRY_UNIT(circuit, unit,
		unit->CmdFightTo(pos, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, circuit->GetLastFrame() + FRAMES_PER_SEC * 60);
		unit->CmdWantedSpeed(NO_SPEED_LIMIT);
	)
	state = State::DISENGAGE;  // Wait
}

/*
 * The squads this unit may join, most worth joining first.
 *
 * Every support unit walks to a squad and joins it outright, and until the
 * sensor cap this picked the nearest one every time - so on a map with one
 * forward squad, every mobile radar and jammer the factory ever made ended up
 * in it (27 radar bots behind a single sharpshooter). A sensor is rationed:
 * squads already at CMilitaryManager::SSensorInfo::maxPerSquad are dropped,
 * and what survives is ordered by squad value so the scarce escorts cover the
 * highest-tier squads first. The caller hands the best few to the pathfinder
 * and lets it choose the nearest of them, which keeps a sensor from crossing
 * the map to reach a marginally better squad.
 *
 * Non-sensor support units are unaffected: they get every candidate, in the
 * arbitrary order the task set yields, exactly as before.
 */
void CSupportTask::FindCandidates(CCircuitUnit* unit, const std::set<IFighterTask*>& tasks,
		std::vector<IFighterTask*>& outTasks) const
{
	CMilitaryManager* militaryMgr = static_cast<CMilitaryManager*>(manager);
	CCircuitAI* circuit = manager->GetCircuit();
	CTerrainManager* terrainMgr = circuit->GetTerrainManager();
	const int frame = circuit->GetLastFrame();
	const bool isSensor = militaryMgr->IsSensorUnit(unit->GetCircuitDef());

	for (IFighterTask* candy : tasks) {
		ISquadTask* task = static_cast<ISquadTask*>(candy);
		CCircuitUnit* leader = task->GetLeader();
		if (leader == nullptr) {
			continue;
		}
		const AIFloat3& pos = leader->GetPos(frame);
		if (!terrainMgr->CanMoveToPos(unit->GetArea(), pos)) {
			continue;
		}
		if (!((unit->GetCircuitDef()->IsAmphibious() || unit->GetCircuitDef()->IsSurfer())
				&& (leader->GetCircuitDef()->IsAbleToDive() || leader->GetCircuitDef()->IsSurfer()))
			&& !(leader->GetCircuitDef()->IsSubmarine() && unit->GetCircuitDef()->IsSubmarine())
			&& !(/*leader->GetCircuitDef()->IsAbleToFly() && */unit->GetCircuitDef()->IsAbleToFly())
			&& !(leader->GetCircuitDef()->IsLander() && unit->GetCircuitDef()->IsLander())
			&& !(leader->GetCircuitDef()->IsFloater() && unit->GetCircuitDef()->IsFloater()))
		{
			continue;
		}
		if (isSensor && !militaryMgr->NeedsSensor(candy)) {
			continue;  // already escorted; a second adds no coverage
		}
		outTasks.push_back(candy);
	}

	if (!isSensor || outTasks.empty()) {
		return;
	}
	std::sort(outTasks.begin(), outTasks.end(),
			[militaryMgr](const IFighterTask* a, const IFighterTask* b) {
		return militaryMgr->GetSquadValue(a) > militaryMgr->GetSquadValue(b);
	});
	const size_t top = size_t(std::max(1, militaryMgr->GetSensorInfo().topCandidates));
	if (outTasks.size() > top) {
		outTasks.resize(top);
	}
}

void CSupportTask::Update()
{
	if (updCount++ % 8 != 0) {
		return;
	}

	CCircuitUnit* unit = *units.begin();
	if (unit->Blocker() != nullptr) {
		return;  // Do not interrupt current action
	}

	const std::set<IFighterTask*>& tasksA = static_cast<CMilitaryManager*>(manager)->GetTasks(IFighterTask::FightType::ATTACK);
	const std::set<IFighterTask*>& tasksD = static_cast<CMilitaryManager*>(manager)->GetTasks(IFighterTask::FightType::DEFEND);
	const std::set<IFighterTask*>& tasks = tasksA.empty() ? tasksD : tasksA;
	if (tasks.empty()) {
		Start(unit);
		return;
	}

	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();

	std::vector<IFighterTask*> candidates;
	FindCandidates(unit, tasks, candidates);
	if (candidates.empty()) {
		// For a sensor this is the normal "every squad already has one" case:
		// hold on the base ring instead of piling onto a covered squad.
		Start(unit);
		return;
	}
	urgentPositions.clear();
	urgentPositions.reserve(candidates.size());
	for (IFighterTask* candy : candidates) {
		urgentPositions.push_back(static_cast<ISquadTask*>(candy)->GetLeaderPos(frame));
	}

	if (!IsQueryReady(unit)) {
		return;
	}

	CPathFinder* pathfinder = circuit->GetPathfinder();
	const AIFloat3& startPos = unit->GetPos(frame);
	const float range = pathfinder->GetSquareSize();

	std::shared_ptr<IPathQuery> query = pathfinder->CreatePathMultiQuery(
			unit, circuit->GetThreatMap(),
			startPos, range, urgentPositions, nullptr, false, std::numeric_limits<float>::max(), true);
	pathQueries[unit] = query;

	pathfinder->RunQuery(circuit->GetScheduler().get(), query, [this](const IPathQuery* query) {
		this->ApplyPath(static_cast<const CQueryPathMulti*>(query));
	});
}

void CSupportTask::ApplyPath(const CQueryPathMulti* query)
{
	const std::shared_ptr<CPathInfo>& pPath = query->GetPathInfo();
	CCircuitUnit* unit = query->GetUnit();

	if (pPath->posPath.empty()) {
		Start(unit);
		return;
	}

	const std::set<IFighterTask*>& tasksA = static_cast<CMilitaryManager*>(manager)->GetTasks(IFighterTask::FightType::ATTACK);
	const std::set<IFighterTask*>& tasksD = static_cast<CMilitaryManager*>(manager)->GetTasks(IFighterTask::FightType::DEFEND);
	const std::set<IFighterTask*>& tasks = tasksA.empty() ? tasksD : tasksA;
	if (tasks.empty()) {
		Start(unit);
		return;
	}

	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	const AIFloat3& startPos = unit->GetPos(frame);
	const AIFloat3& endPos = pPath->posPath.back();
	if (startPos.SqDistance2D(endPos) < SQUARE(1000.f)) {
		// Re-filter rather than trust the list Update built: the walk took time,
		// and another sensor may have taken the slot meanwhile.
		std::vector<IFighterTask*> candidates;
		FindCandidates(unit, tasks, candidates);
		if (candidates.empty()) {
			Start(unit);
			return;
		}
		// FindCandidates has already ordered a sensor's list by squad value and
		// cut it to the best few, so nearest-of-those is nearest-of-the-best.
		IFighterTask* task = candidates.front();
		float minSqDist = std::numeric_limits<float>::max();
		for (IFighterTask* candy : candidates) {
			float sqDist = endPos.SqDistance2D(static_cast<ISquadTask*>(candy)->GetLeaderPos(frame));
			if (minSqDist > sqDist) {
				minSqDist = sqDist;
				task = candy;
			}
		}
		manager->AssignTask(unit, task);
//		manager->DoneTask(this);  // NOTE: RemoveAssignee will abort task
	} else {
		TRY_UNIT(circuit, unit,
			unit->CmdFightTo(endPos, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame + FRAMES_PER_SEC * 60);
		)
		state = State::ROAM;  // Not wait
	}
}

} // namespace circuit

/*
 * BombTask.cpp
 *
 *  Created on: Jan 6, 2016
 *      Author: rlcevg
 */

#include "task/fighter/BombTask.h"
#include "map/ThreatMap.h"
#include "module/MilitaryManager.h"
#include "setup/SetupManager.h"
#include "terrain/TerrainManager.h"
#include "terrain/path/PathFinder.h"
#include "terrain/path/QueryPathSingle.h"
#include "unit/action/FightAction.h"
#include "unit/action/MoveAction.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitWDef.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringCallback.h"
#include "spring/SpringMap.h"

#include "AISCommands.h"
#include "Log.h"

#include <algorithm>
#include <cmath>
#include <limits>

namespace circuit {

using namespace springai;

CBombTask::CBombTask(ITaskModule* mgr, float powerMod)
		: ISquadTask(mgr, FightType::BOMB, powerMod)
{
}

CBombTask::~CBombTask()
{
}

bool CBombTask::CanAssignTo(CCircuitUnit* unit) const
{
	if (!unit->GetCircuitDef()->IsRoleBomber()) {
		return false;
	}
	// Grouping by exact def makes a mixed wave fly as several parallel groups,
	// each picking its own target. Grouping by role lets them form one line.
	// ISquadTask already tracks lowestSpeed / lowestRange for heterogeneity.
	if (!manager->GetCircuit()->GetMilitaryManager()->GetBomberInfo().groupMixedDefs
		&& (unit->GetCircuitDef() != leader->GetCircuitDef()))
	{
		return false;
	}
	const int frame = manager->GetCircuit()->GetLastFrame();
	if (leader->GetPos(frame).SqDistance2D(unit->GetPos(frame)) > SQUARE(1000.f)) {
		return false;
	}
	return true;
}

void CBombTask::AssignTo(CCircuitUnit* unit)
{
	ISquadTask::AssignTo(unit);

	int squareSize = manager->GetCircuit()->GetPathfinder()->GetSquareSize();
	CCircuitDef* cdef = unit->GetCircuitDef();
	ITravelAction* travelAction;
	if (cdef->IsAttrSiege()) {
		travelAction = new CFightAction(unit, squareSize);
	} else {
		travelAction = new CMoveAction(unit, squareSize);
	}
	unit->PushTravelAct(travelAction);
	travelAction->StateWait();
	unit->SetAllowedToJump(cdef->IsAbleToJump() && cdef->IsAttrJump());
}

void CBombTask::RemoveAssignee(CCircuitUnit* unit)
{
	ISquadTask::RemoveAssignee(unit);
	if (units.empty()) {
		manager->AbortTask(this);
	}
}

void CBombTask::Start(CCircuitUnit* unit)
{
	if ((State::REGROUP == state) || (State::ENGAGE == state)) {
		return;
	}
	if (!pPath->posPath.empty()) {
		unit->GetTravelAct()->SetPath(pPath);
	}
}

void CBombTask::Update()
{
	++updCount;

	/*
	 * Check safety
	 */
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();

	if (State::DISENGAGE == state) {
		if (updCount % 32 == 1) {
			const float maxDist = std::max<float>(lowestRange, circuit->GetPathfinder()->GetSquareSize());
			if (position.SqDistance2D(leader->GetPos(frame)) < SQUARE(maxDist)) {
				state = State::ROAM;
			} else {
				if (IsQueryReady(leader)) {
					FallbackBasePos();
				}
				return;
			}
		} else {
			return;
		}
	}

	/*
	 * Merge tasks if possible
	 */
	ISquadTask* task = GetMergeTask();
	if (task != nullptr) {
		task->Merge(this);
		units.clear();
		manager->AbortTask(this);
		return;
	}

	/*
	 * Regroup if required
	 */
	bool wasRegroup = (State::REGROUP == state);
	bool mustRegroup = IsMustRegroup();
	if (State::REGROUP == state) {
		if (mustRegroup) {
			CCircuitAI* circuit = manager->GetCircuit();
			int frame = circuit->GetLastFrame() + FRAMES_PER_SEC * 60;
			for (CCircuitUnit* unit : units) {
				unit->GetTravelAct()->StateWait();
				TRY_UNIT(circuit, unit,
					unit->CmdFightTo(groupPos, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame);
				)
			}
		}
		return;
	}

	bool isExecute = (updCount % 4 == 0);
	if (!isExecute) {
		for (CCircuitUnit* unit : units) {
			isExecute |= unit->IsForceUpdate(frame);
		}
		if (!isExecute) {
			if (wasRegroup && !pPath->posPath.empty()) {
				ActivePath();
			}
			return;
		}
	}

	/*
	 * Update target
	 */
	FindTarget();

	const AIFloat3& startPos = leader->GetPos(frame);
	state = State::ROAM;
	if (GetTarget() != nullptr) {
		state = State::ENGAGE;
		if (mode == EMode::AREA) {
			AttackArea(frame);
		} else {
			Attack(frame, GetTarget()->NotInRadarAndLOS() || (GetTarget()->GetCircuitDef() == nullptr)
				|| !GetTarget()->GetCircuitDef()->IsMobile() || circuit->IsCheating());
		}
		return;
	}

	if (!IsQueryReady(leader)) {
		return;
	}

	if (!geom::is_valid(position)) {
		FallbackBasePos();
		return;
	}

	CPathFinder* pathfinder = circuit->GetPathfinder();
	std::shared_ptr<IPathQuery> query = pathfinder->CreatePathSingleQuery(
			leader, circuit->GetThreatMap(),
			startPos, position, pathfinder->GetSquareSize(), GetHitTest());
	pathQueries[leader] = query;

	pathfinder->RunQuery(circuit->GetScheduler().get(), query, [this](const IPathQuery* query) {
		this->ApplyTargetPath(static_cast<const CQueryPathSingle*>(query));
	});
}

void CBombTask::OnUnitIdle(CCircuitUnit* unit)
{
	ISquadTask::OnUnitIdle(unit);
	if (units.empty()) {
		return;
	}

	CCircuitAI* circuit = manager->GetCircuit();
	const float maxDist = std::max<float>(lowestRange, circuit->GetPathfinder()->GetSquareSize());
	if (position.SqDistance2D(leader->GetPos(circuit->GetLastFrame())) < SQUARE(maxDist)) {
		CTerrainManager* terrainMgr = circuit->GetTerrainManager();
		position = terrainMgr->GetRandomMovePosition(leader);
	}

	if (units.find(unit) != units.end()) {
		Start(unit);  // NOTE: Not sure if it has effect
	}
}

void CBombTask::OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	// Do not retreat if bomber is close to target
	if (GetTarget() == nullptr) {
		ISquadTask::OnUnitDamaged(unit, attacker);
	} else {
		const AIFloat3& pos = unit->GetPos(manager->GetCircuit()->GetLastFrame());
		if (pos.SqDistance2D(GetTarget()->GetPos()) > SQUARE(unit->GetCircuitDef()->GetLosRadius())) {
			ISquadTask::OnUnitDamaged(unit, attacker);
		}
	}
}

float CBombTask::GetGroupAlpha() const
{
	float alpha = 0.f;
	for (CCircuitUnit* unit : units) {
		CCircuitDef* cdef = unit->GetCircuitDef();
		const CWeaponDef* wd = (cdef != nullptr) ? cdef->GetWeaponDef() : nullptr;
		if (wd != nullptr) {
			alpha += wd->GetAlpha();
		}
	}
	return alpha;
}

/*
 * Air LOS is coarse and terrain-free, so the defender sees a run coming and
 * angle matters more than surprise. AA also shoots bombers before anything else
 * (unit_aa_targeting_priority.lua puts bombers at 0.1 against fighters at 2),
 * which is why the escort cannot screen the run and why the approach bearing is
 * worth choosing: sample the threat map on a ring around the aim point and run
 * in from the quietest side.
 */
AIFloat3 CBombTask::PickApproachDir(const AIFloat3& pos) const
{
	CCircuitAI* circuit = manager->GetCircuit();
	CThreatMap* threatMap = circuit->GetThreatMap();
	const CMilitaryManager::SBomberInfo& cfg = circuit->GetMilitaryManager()->GetBomberInfo();
	const int samples = cfg.approachSamples;
	const float ring = cfg.approachRing;

	AIFloat3 bestDir(1.f, 0.f, 0.f);
	float bestThreat = std::numeric_limits<float>::max();
	for (int i = 0; i < samples; ++i) {
		const float angle = (2.f * float(M_PI) * float(i)) / float(samples);
		const float dx = std::cos(angle);
		const float dz = std::sin(angle);
		AIFloat3 probe(pos.x + dx * ring, pos.y, pos.z + dz * ring);
		CTerrainManager::CorrectPosition(probe);
		// Threat at the stand-off point plus the midpoint of the run-in, so a
		// bearing that is clear at range but crosses a battery is not chosen.
		AIFloat3 mid(pos.x + dx * ring * 0.5f, pos.y, pos.z + dz * ring * 0.5f);
		CTerrainManager::CorrectPosition(mid);
		const float threat = threatMap->GetThreatAt(probe) + threatMap->GetThreatAt(mid);
		if (threat < bestThreat) {
			bestThreat = threat;
			bestDir = AIFloat3(dx, 0.f, dz);
		}
	}
	return bestDir;
}

void CBombTask::FindTarget()
{
	// TODO: 1) Bombers should constantly harass undefended targets and not suicide.
	//       2) Fat target getting close to base should gain priority and be attacked by group if high AA threat.
	//       3) Avoid RoleAA targets.
	CCircuitAI* circuit = manager->GetCircuit();
	CThreatMap* threatMap = circuit->GetThreatMap();
	CCircuitDef* cdef = leader->GetCircuitDef();
	const CMilitaryManager::SBomberInfo& cfg = circuit->GetMilitaryManager()->GetBomberInfo();
	const bool isAntiStatic = cdef->IsAttrAntiStat();
	const bool notAW = !cdef->HasSurfToWater();
	const AIFloat3& pos = leader->GetPos(circuit->GetLastFrame());
	const float scale = (cdef->GetMinRange() > 300.0f) ? 4.0f : 1.0f;
	const float maxPower = attackPower * scale * powerMod;
	const float speed = cdef->GetSpeed() / 1.75f;
	const int canTargetCat = cdef->GetTargetCategory();
	const int noChaseCat = cdef->GetNoChaseCategory();
	const float sqRange = (GetTarget() != nullptr) ? pos.SqDistance2D(GetTarget()->GetPos()) + 1.f : SQUARE(2000.0f);

	// A pass either kills or is wasted, so the group's alpha decides what is
	// worth attacking at all. Targets it cannot finish are left for a bigger
	// group - but only while something finishable exists.
	const float groupAlpha = GetGroupAlpha();
	const float killCap = groupAlpha * cfg.killMargin;

	COOAICallback* callback = circuit->GetCallback();
	const float trueAoe = cdef->GetAoe() + SQUARE_SIZE;
	const float allyAoe = std::min(trueAoe, DEFAULT_SLACK * 2.f);
	std::function<bool (const AIFloat3& pos)> noAllies = [](const AIFloat3& pos) {
		return true;
	};
	if (allyAoe > SQUARE_SIZE * 2) {
		noAllies = [callback, allyAoe](const AIFloat3& pos) {
			return !callback->IsFriendlyUnitsIn(pos, allyAoe);
		};
	}

	SetTarget(nullptr);  // make adequate enemy->GetTasks().size()
	CEnemyInfo* bestTarget = nullptr;   // in range and finishable
	CEnemyInfo* bestFat = nullptr;      // in range, too fat for this group
	position = -RgtVector;
	float bestValue = 0.f;
	float bestFatValue = 0.f;
	float bestOutValue = 0.f;           // heading only; never displaces a target
	// Candidates kept for the area-mode cluster test.
	static std::vector<std::pair<AIFloat3, float>> candidates;  // NOTE: micro-opt
	candidates.clear();

	threatMap->SetThreatType(leader);
	const CCircuitAI::EnemyInfos& enemies = circuit->GetEnemyInfos();
	for (auto& kv : enemies) {
		CEnemyInfo* enemy = kv.second;
		if (enemy->IsHidden()) {
			continue;
		}
		const AIFloat3& ePos = enemy->GetPos();
		float power = threatMap->GetThreatAt(ePos);
		if ((maxPower <= power) ||
			(notAW && (ePos.y < -SQUARE_SIZE * 5)))
		{
			continue;
		}

		int targetCat;
		float health;
		CCircuitDef* edef = enemy->GetCircuitDef();
		if (edef != nullptr) {
			if ((edef->GetSpeed() > speed)
				|| (isAntiStatic && edef->IsMobile())
				|| circuit->GetCircuitDef(edef->GetId())->IsIgnore())
			{
				continue;
			}
			targetCat = edef->GetCategory();
			if ((targetCat & canTargetCat) == 0) {
				continue;
			}
			health = enemy->GetHealth();
		} else {
			continue;  // unidentified radar blips are never bombed
		}

		if (((targetCat & noChaseCat) != 0) || !noAllies(ePos)) {
			continue;
		}

		// Value per HP: gain against how much has to be chewed through. Health
		// is current, so a damaged high-value target becomes more attractive.
		const float value = enemy->GetCost() / std::max(health, 1.f);
		candidates.emplace_back(ePos, enemy->GetCost());

		const float sqDist = pos.SqDistance2D(ePos);
		if (sqDist >= sqRange) {
			// Out of range: may set a heading, must never clear a chosen target.
			if (bestOutValue < value) {
				bestOutValue = value;
				if (bestTarget == nullptr) {
					position = ePos;
				}
			}
			continue;
		}
		if ((groupAlpha > 0.f) && (health > killCap)) {
			if (bestFatValue < value) {
				bestFatValue = value;
				bestFat = enemy;
			}
			continue;
		}
		if (bestValue < value) {
			bestValue = value;
			bestTarget = enemy;
		}
	}

	if ((bestTarget == nullptr) && (bestFat != nullptr)) {
		bestTarget = bestFat;   // nothing finishable in range: chip at the best one
		bestValue = bestFatValue;
	}

	mode = EMode::FOCUS;
	areaCount = 0;
	if (bestTarget != nullptr) {
		SetTarget(bestTarget);
		position = bestTarget->GetPos();

		// Area mode: a cluster of cheap targets is worth a line across a front
		// rather than the whole group's alpha on one of them. A target worth
		// focusCost on its own always keeps the group concentrated.
		if (cfg.isEnabled && (bestTarget->GetCost() < cfg.focusCost) && (units.size() > 1)) {
			const float sqArea = SQUARE(cfg.areaRadius);
			AIFloat3 sum(0.f, 0.f, 0.f);
			int count = 0;
			for (const auto& cand : candidates) {
				if (position.SqDistance2D(cand.first) < sqArea) {
					sum += cand.first;
					++count;
				}
			}
			if (count >= cfg.areaMinTargets) {
				mode = EMode::AREA;
				areaCount = count;
				areaCentre = sum / float(count);
				CTerrainManager::CorrectPosition(areaCentre);
				approachDir = PickApproachDir(areaCentre);
				// Front length from the size of the run: enough line for every
				// bomber at its spacing, bounded by the cluster it covers.
				const float aoe = std::max(cdef->GetAoe(), 1.f);
				const float spacing = std::max(cfg.minSpacing, aoe * 2.f);
				frontLength = std::min(spacing * float(units.size() - 1), cfg.areaRadius * 2.f);
			}
		}
	}

	circuit->LOG("BOMB: leader=%i n=%zu alpha=%.0f maxPower=%.1f mode=%s -> target=%s cost=%.0f health=%.0f value=%.3f areaCount=%i front=%.0f",
			leader->GetId(), units.size(), groupAlpha, maxPower,
			(mode == EMode::AREA) ? "AREA" : "FOCUS",
			((bestTarget != nullptr) && (bestTarget->GetCircuitDef() != nullptr))
					? bestTarget->GetCircuitDef()->GetDef()->GetName() : "<none>",
			(bestTarget != nullptr) ? bestTarget->GetCost() : 0.f,
			(bestTarget != nullptr) ? bestTarget->GetHealth() : 0.f,
			bestValue, areaCount, frontLength);
	// Return: target, startPos=leader->pos, endPos=position
}

/*
 * Line abreast across the front, perpendicular to the approach bearing. Each
 * bomber attack-grounds its own slice and then attack-moves out the far side,
 * so survivors clean up what the pass left and leave along the exit heading
 * instead of circling back over the AA.
 *
 * Spacing is clamped into [minSpacing, 2 * AoE]: at the top the bombs tile the
 * front with no overlap, and a group too large for the front packs down toward
 * minSpacing, concentrating damage where the targets are densest.
 */
void CBombTask::AttackArea(const int frame)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const CMilitaryManager::SBomberInfo& cfg = circuit->GetMilitaryManager()->GetBomberInfo();
	const int count = int(units.size());
	if (count < 1) {
		return;
	}
	const float aoe = std::max(leader->GetCircuitDef()->GetAoe(), 1.f);
	const float maxSpacing = std::max(cfg.minSpacing, aoe * 2.f);
	const float spacing = (count > 1)
			? std::clamp(frontLength / float(count - 1), cfg.minSpacing, maxSpacing)
			: 0.f;
	// Perpendicular to the run-in, so the line sweeps the front broadside.
	const AIFloat3 frontDir(-approachDir.z, 0.f, approachDir.x);
	const float half = 0.5f * spacing * float(count - 1);

	int idx = 0;
	for (CCircuitUnit* unit : units) {
		if (unit->Blocker() != nullptr) {
			continue;  // Do not interrupt current action
		}
		unit->GetTravelAct()->StateWait();

		const float offset = spacing * float(idx) - half;
		AIFloat3 slot(areaCentre.x + frontDir.x * offset, areaCentre.y, areaCentre.z + frontDir.z * offset);
		CTerrainManager::CorrectPosition(slot);
		AIFloat3 exit(slot.x + approachDir.x * cfg.cleanupDistance, slot.y,
				slot.z + approachDir.z * cfg.cleanupDistance);
		CTerrainManager::CorrectPosition(exit);

		TRY_UNIT(circuit, unit,
			unit->CmdAttackGround(slot, 0, frame + FRAMES_PER_SEC * 60);
			// Queued: clean up and leave rather than loitering over the target.
			unit->CmdFightTo(exit, UNIT_COMMAND_OPTION_SHIFT_KEY, frame + FRAMES_PER_SEC * 60);
		)
		++idx;
	}
	attackFrame = frame;
}

void CBombTask::ApplyTargetPath(const CQueryPathSingle* query)
{
	pPath = query->GetPathInfo();

	if (!pPath->posPath.empty()) {
		ActivePath(lowestSpeed);
	} else {
		FallbackBasePos();
	}
}

void CBombTask::FallbackBasePos()
{
	CCircuitAI* circuit = manager->GetCircuit();
	CSetupManager* setupMgr = circuit->GetSetupManager();

	const AIFloat3& startPos = leader->GetPos(circuit->GetLastFrame());
	const AIFloat3& endPos = setupMgr->GetBasePos();
	const float pathRange = DEFAULT_SLACK * 4;

	CPathFinder* pathfinder = circuit->GetPathfinder();
	std::shared_ptr<IPathQuery> query = pathfinder->CreatePathSingleQuery(
			leader, circuit->GetThreatMap(),
			startPos, endPos, pathRange);
	pathQueries[leader] = query;

	pathfinder->RunQuery(circuit->GetScheduler().get(), query, [this](const IPathQuery* query) {
		this->ApplyBasePos(static_cast<const CQueryPathSingle*>(query));
	});
}

void CBombTask::ApplyBasePos(const CQueryPathSingle* query)
{
	pPath = query->GetPathInfo();

	if (!pPath->path.empty()) {
		if (pPath->path.size() > 2) {
			ActivePath();
		}
	} else {
		Fallback();
	}
}

void CBombTask::Fallback()
{
	// should never happen
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	for (CCircuitUnit* unit : units) {
		unit->GetTravelAct()->StateWait();
		TRY_UNIT(circuit, unit,
			unit->CmdFightTo(position, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame + FRAMES_PER_SEC * 60);
			unit->CmdWantedSpeed(lowestSpeed);
		)
	}
}

} // namespace circuit

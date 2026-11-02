/*
 * ArtilleryTask.cpp
 *
 *  Created on: Jan 6, 2016
 *      Author: rlcevg
 */

#include "task/fighter/ArtilleryTask.h"
#include "task/fighter/RangedEngagement.h"
#include "task/RetreatTask.h"
#include "map/ThreatMap.h"
#include "module/MilitaryManager.h"
#include "setup/SetupManager.h"
#include "terrain/TerrainManager.h"
#include "terrain/path/PathFinder.h"
#include "terrain/path/QueryPathMulti.h"
#include "unit/action/FightAction.h"
#include "unit/action/MoveAction.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/CircuitUnit.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringMap.h"

#include "AISCommands.h"
#include "Log.h"
#include "Weapon.h"

namespace circuit {

using namespace springai;

CArtilleryTask::CArtilleryTask(ITaskModule* mgr)
		: IFighterTask(mgr, FightType::ARTY, 1.f)
{
	position = manager->GetCircuit()->GetSetupManager()->GetBasePos();
}

CArtilleryTask::~CArtilleryTask()
{
}

bool CArtilleryTask::CanAssignTo(CCircuitUnit* unit) const
{
	return units.empty() && (unit->GetCircuitDef()->IsRoleArty() || unit->GetCircuitDef()->IsAttrRanged());
}

void CArtilleryTask::AssignTo(CCircuitUnit* unit)
{
	IFighterTask::AssignTo(unit);
	if (unit->GetCircuitDef()->IsAttrRanged()) {
		ranged = std::make_unique<CRangedEngagement>(manager->GetCircuit(), this, unit);
		return;
	}

	unit->CmdSetMoveState(CCircuitDef::MoveType::HOLD_POS);
	/*
	 * This task only ever ORDERS a structure (FindTarget skips IsMobile), but a
	 * unit holding position on fire-at-will shoots whatever wanders into range,
	 * so a Longbow parked at a porc line spent its salvos on passing boats. For
	 * `siege`-tagged artillery, return fire: it engages its ordered target and
	 * anything that attacks it, and nothing else. Restored to fire-at-will when
	 * the unit leaves the task, so a retreat or a squad reassignment behaves
	 * as before. Config-driven: the attribute is the switch.
	 */
	if (unit->GetCircuitDef()->IsAttrSiege()) {
		unit->CmdSetFireState(CCircuitDef::FireType::RETURN);
	}

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

void CArtilleryTask::RemoveAssignee(CCircuitUnit* unit)
{
	if (ranged) {
		ranged->Release(unit);
		ranged.reset();
	} else if (unit->GetCircuitDef()->IsAttrSiege()) {
		unit->CmdSetFireState(CCircuitDef::FireType::OPEN);
	}
	ghostFire.erase(unit->GetId());
	IFighterTask::RemoveAssignee(unit);
	if (units.empty()) {
		manager->AbortTask(this);
	}

	unit->CmdSetMoveState(unit->GetCircuitDef()->GetMoveState());  // default: CCircuitDef::MoveType::MANEUVRE
}

void CArtilleryTask::Start(CCircuitUnit* unit)
{
	Execute(unit);
}

bool CArtilleryTask::ForgetUnit(CCircuitUnit* unit)
{
	// ForgetUnitEverywhere broadcasts every removed ally to every task. Only
	// this task's assignee owns this controller; clearing it for a dead radar
	// leaves a ranged gun on the legacy path without its required travel action.
	if (ranged && units.count(unit)) { ranged->Release(unit, false); ranged.reset(); }
	return IFighterTask::ForgetUnit(unit);
}

void CArtilleryTask::Stop(bool done)
{
	if (ranged) {
		ranged->Release(units.empty() ? nullptr : *units.begin());
		ranged.reset();
	}
	IFighterTask::Stop(done);
}

void CArtilleryTask::Update()
{
	if (ranged) {
		for (CCircuitUnit* unit : units) Execute(unit);
		return;
	}
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();

	if (++updCount % 4 == 0) {
		for (CCircuitUnit* unit : units) {
			Execute(unit);
		}
	} else {
		for (CCircuitUnit* unit : units) {
			if (unit->IsForceUpdate(frame)) {
				Execute(unit);
			}
		}
	}
}

void CArtilleryTask::Execute(CCircuitUnit* unit)
{
	if (ranged) {
		ranged->Update(unit);
		auto* selected=manager->GetCircuit()->GetEnemyInfo(ranged->Target());
		if (selected!=GetTarget()) SetTarget(selected);
		position = unit->GetPos(manager->GetCircuit()->GetLastFrame());
		return;
	}
	if (unit->Blocker() != nullptr) {
		return;  // Do not interrupt current action
	}

	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	const AIFloat3& pos = unit->GetPos(frame);
	CEnemyInfo* bestTarget = FindTarget(unit, pos);

	if (bestTarget != nullptr) {
		unit->GetTravelAct()->StateWait();

		// A commander can walk off: a short order so ATTACK never chases it out
		// of the firing spot; the next Execute re-picks (a structure if it left).
		const CCircuitDef* edef = bestTarget->GetCircuitDef();
		const int timeout = frame + FRAMES_PER_SEC * ((edef != nullptr && edef->IsMobile()) ? 5 : 60);
		TRY_UNIT(circuit, unit,
			if (!circuit->IsCheating()) {
				unit->GetUnit()->Attack(bestTarget->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);
			} else {
				unit->CmdAttackGround(bestTarget->GetPos(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);
			}
			unit->CmdSetTarget(bestTarget);
		)
		return;
	}

	if (FireAtGhost(unit, pos, frame)) {
		return;
	}

	if (!IsQueryReady(unit)) {
		return;
	}

	if (enemyPositions.empty()) {
		FallbackSafePos(unit);
		return;
	}

	CCircuitDef* cdef = unit->GetCircuitDef();
	CThreatMap* threatMap = circuit->GetThreatMap();
	const float range = std::max(cdef->GetMaxRange()/* - threatMap->GetSquareSize()*/, (float)threatMap->GetSquareSize());

	CPathFinder* pathfinder = circuit->GetPathfinder();
	std::shared_ptr<IPathQuery> query = pathfinder->CreatePathMultiQuery(
			unit, threatMap,
			pos, range, enemyPositions);
	pathQueries[unit] = query;

	pathfinder->RunQuery(circuit->GetScheduler().get(), query, [this](const IPathQuery* query) {
		this->ApplyTargetPath(static_cast<const CQueryPathMulti*>(query));
	});
}

void CArtilleryTask::OnUnitIdle(CCircuitUnit* unit)
{
	IFighterTask::OnUnitIdle(unit);
	if (ranged) { ranged->Idle(); return; }
	if (units.find(unit) != units.end()) {
		RemoveAssignee(unit);
	}
}

void CArtilleryTask::OnUnitMoveFailed(CCircuitUnit* unit)
{
	if (ranged) { ranged->MoveFailed(); return; }
	IFighterTask::OnUnitMoveFailed(unit);
}

void CArtilleryTask::OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	if (ranged) {
		ranged->Idle();
        // Script/JSON chooses this doctrine. Forward-only firing-line hulls
        // retain their weapon owner even at low HP; other artillery keeps its
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

bool GhostFireStep(CCircuitAI* circuit, CCircuitUnit* unit, const AIFloat3& pos, int frame,
		SGhostFire& track, std::unordered_map<int, bool>& ghostSupport)
{
	// Owner 2026-11-02: listed rocket artillery (Arbiter, Negotiator, Thanatos,
	// Ambassador, Boreas) with nothing seen to shoot fires on a ghost image of
	// enemy porc already in weapon range, once it has not fired for
	// ghost_idle_seconds. One ATTACK_GROUND volley; never a move toward it.
	// Owner 2026-11-02: porc here includes building radars, building jammers
	// and shields, besides armed structures.
	const CMilitaryManager::SArtyCommInfo& info = circuit->GetMilitaryManager()->GetArtyCommInfo();
	CCircuitDef* cdef = unit->GetCircuitDef();
	if (!info.isEnabled || info.ghostDefs.count(cdef->GetId()) == 0) {
		return false;
	}
	springai::Weapon* weapon = unit->GetMainWeapon();
	if (weapon == nullptr) {
		return false;
	}
	// A shot is the engine's weapon-fired event for this unit, or a rising
	// main-weapon reload frame (sampled per call, so it can lag). Test g1: the
	// reload sample alone missed an Ambassador's ghost volley and re-fired 21 s
	// later as if idle. O(1) per call.
	const int reload = weapon->GetReloadFrame();
	if (track.reload < 0) {
		track.shot = (reload > frame) ? frame : -1;
	} else if (reload > track.reload) {
		track.shot = frame;
		track.orderUntil = -1;
	}
	track.reload = reload;
	if (unit->GetFireFrame() > track.shot) {
		track.shot = unit->GetFireFrame();
		if (track.shot >= track.orderUntil - FRAMES_PER_SEC * 5) track.orderUntil = -1;
	}
	if (frame < track.orderUntil) {
		return true;  // the volley is on its way; do not replace the order
	}
	if ((frame - track.shot < info.ghostIdleFrames) || (reload > frame)) {
		return false;
	}
	CThreatMap* threatMap = circuit->GetThreatMap();
	threatMap->SetThreatType(unit);
	if (threatMap->GetThreatAt(pos) > THREAT_MIN) {
		return false;  // retreat comes first
	}
	const bool notAW = !cdef->HasSurfToWater();
	const int canTargetCat = cdef->GetTargetCategory();
	float bestSqDist = SQUARE(cdef->GetMaxRange(CCircuitDef::RangeType::LAND));
	const CEnemyUnit* best = nullptr;
	// O(known enemies), only while idle past the gate.
	for (const auto& kv : circuit->GetEnemyManager()->GetEnemyUnits()) {
		const CEnemyUnit* e = kv.second;
		const CCircuitDef* edef = (e != nullptr) ? e->GetCircuitDef() : nullptr;
		if ((edef == nullptr) || !e->NotInRadarAndLOS() || e->IsIgnore() || e->IsBeingBuilt()
			|| (e->GetData().losStatus & (SEnemyData::LosMask::HIDDEN | SEnemyData::LosMask::DYING | SEnemyData::LosMask::DEAD))
			|| edef->IsMobile() || edef->IsAbleToFly()
			|| ((edef->GetCategory() & canTargetCat) == 0)
			|| (notAW && (e->GetPos().y < -SQUARE_SIZE * 5)))
		{
			continue;
		}
		if (!edef->HasSurfToLand()) {
			// Engine def reads once per type per task, then O(1).
			auto it = ghostSupport.find(edef->GetId());
			if (it == ghostSupport.end()) {
				springai::UnitDef* ud = edef->GetDef();
				const bool support = (edef->GetShieldMount() != nullptr)
					|| (ud->GetRadarRadius() > 0) || (ud->GetJammerRadius() > 0);
				it = ghostSupport.emplace(edef->GetId(), support).first;
			}
			if (!it->second) {
				continue;
			}
		}
		const float sqDist = pos.SqDistance2D(e->GetPos());
		if (sqDist < bestSqDist) {
			bestSqDist = sqDist;
			best = e;
		}
	}
	if (best == nullptr) {
		return false;
	}
	unit->GetTravelAct()->StateWait();
	const int timeout = frame + FRAMES_PER_SEC * 5;
	track.orderUntil = timeout;
	TRY_UNIT(circuit, unit,
		unit->CmdAttackGround(best->GetPos(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, timeout);
	)
	circuit->LOG("ARTY: %s %i fires on ghost %s at (%.0f, %.0f), last shot %s %.0f s ago",
			cdef->GetDef()->GetName(), unit->GetId(), best->GetCircuitDef()->GetDef()->GetName(),
			best->GetPos().x, best->GetPos().z, (track.shot < 0) ? "never seen, game time" : "",
			float(frame - std::max(0, track.shot)) / FRAMES_PER_SEC);
	return true;
}

bool CArtilleryTask::FireAtGhost(CCircuitUnit* unit, const AIFloat3& pos, int frame)
{
	return GhostFireStep(manager->GetCircuit(), unit, pos, frame, ghostFire[unit->GetId()], ghostSupport);
}

CEnemyInfo* CArtilleryTask::FindTarget(CCircuitUnit* unit, const AIFloat3& pos)
{
	CCircuitAI* circuit = manager->GetCircuit();
	CThreatMap* threatMap = circuit->GetThreatMap();
	CCircuitDef* cdef = unit->GetCircuitDef();
	const bool notAW = !cdef->HasSurfToWater();
	const int canTargetCat = cdef->GetTargetCategory();
	const int noChaseCat = cdef->GetNoChaseCategory();
	float range = cdef->GetMaxRange();
	float minSqDist = SQUARE(range);

	enemyPositions.clear();
	threatMap->SetThreatType(unit);
	bool isPosSafe = (threatMap->GetThreatAt(pos) <= THREAT_MIN) || cdef->IsPlane();

	const CCircuitAI::EnemyInfos& enemies = circuit->GetEnemyInfos();
	if (isPosSafe) {
		// Трубка 15, прицел 120, бац, бац …и мимо!
		float maxThreat = .0f;
		CEnemyInfo* bestTarget = nullptr;
		CEnemyInfo* mediumTarget = nullptr;
		CEnemyInfo* worstTarget = nullptr;
		// Owner 2026-11-01: a stationary or slow enemy commander in range is shot
		// before any structure (see SArtyCommInfo). Same O(enemies) loop.
		const CMilitaryManager::SArtyCommInfo& artyComm = circuit->GetMilitaryManager()->GetArtyCommInfo();
		const bool commTargets = artyComm.isEnabled && (artyComm.defs.count(cdef->GetId()) > 0);
		CEnemyInfo* commTarget = nullptr;
		float commSqDist = SQUARE(range);
		// Then a heavy unit (Fatboy, Tzar, ...) moving at most a fraction of its
		// own top speed, still ahead of every structure.
		CEnemyInfo* heavyTarget = nullptr;
		float heavySqDist = SQUARE(range);
		for (auto& kv : enemies) {
			CEnemyInfo* enemy = kv.second;
			if (enemy->IsHidden()
				|| !enemy->IsInRadarOrLOS()
				|| (notAW && (enemy->GetPos().y < -SQUARE_SIZE * 5)))
			{
				continue;
			}

			CCircuitDef* edef = enemy->GetCircuitDef();
			if (commTargets && (edef != nullptr) && edef->IsRoleComm()
				&& ((edef->GetCategory() & canTargetCat) != 0)
				&& (enemy->GetVel().SqLength2D() <= artyComm.maxSqSpeed))
			{
				const float sqDist = pos.SqDistance2D(enemy->GetPos());
				if (sqDist < commSqDist) {
					commTarget = enemy;
					commSqDist = sqDist;
				}
				continue;
			}
			if (commTargets && (edef != nullptr) && ((edef->GetCategory() & canTargetCat) != 0)) {
				auto it = artyComm.heavyMaxSqSpeed.find(edef->GetId());
				if ((it != artyComm.heavyMaxSqSpeed.end()) && (enemy->GetVel().SqLength2D() <= it->second)) {
					const float sqDist = pos.SqDistance2D(enemy->GetPos());
					if (sqDist < heavySqDist) {
						heavyTarget = enemy;
						heavySqDist = sqDist;
					}
					continue;
				}
			}
			if ((edef == nullptr) || edef->IsMobile() || edef->IsAttrSiege()
				|| circuit->GetCircuitDef(edef->GetId())->IsIgnore())
			{
				continue;
			}
			int targetCat = edef->GetCategory();
			if ((targetCat & canTargetCat) == 0) {
				continue;
			}

			const float sqDist = pos.SqDistance2D(enemy->GetPos());
			if (sqDist < minSqDist) {
				if (edef->IsEnemyRoleAny(CCircuitDef::RoleMask::BUILDER)) {
					bestTarget = enemy;
					minSqDist = sqDist;
					maxThreat = std::numeric_limits<float>::max();
				} else if (edef->GetPower() > maxThreat) {
					bestTarget = enemy;
					minSqDist = sqDist;
					maxThreat = edef->GetPower();
				} else if (bestTarget == nullptr) {
					if ((targetCat & noChaseCat) == 0) {
						mediumTarget = enemy;
					} else if (mediumTarget == nullptr) {
						worstTarget = enemy;
					}
				}
				continue;
			}

			if ((targetCat & noChaseCat) != 0) {
				continue;
			}
//			if (sqDist < SQUARE(2000.f)) {  // maxSqDist
				enemyPositions.push_back(enemy->GetPos());
//			}
		}
		if (commTarget != nullptr) {
			bestTarget = commTarget;
		} else if (heavyTarget != nullptr) {
			bestTarget = heavyTarget;
		} else if (bestTarget == nullptr) {
			bestTarget = (mediumTarget != nullptr) ? mediumTarget : worstTarget;
		}
		if (bestTarget != nullptr) {
			position = bestTarget->GetPos();
			return bestTarget;
		}
	} else {
		// Avoid closest units and choose safe position
		for (auto& kv : enemies) {
			CEnemyInfo* enemy = kv.second;
			if (enemy->IsHidden()
				|| !enemy->IsInRadarOrLOS()
				|| (notAW && (enemy->GetPos().y < -SQUARE_SIZE * 5)))
			{
				continue;
			}

			CCircuitDef* edef = enemy->GetCircuitDef();
			if ((edef == nullptr) || edef->IsMobile()
				|| circuit->GetCircuitDef(edef->GetId())->IsIgnore())
			{
				continue;
			}
			int targetCat = edef->GetCategory();
			if (((targetCat & canTargetCat) == 0)
				|| ((targetCat & noChaseCat) != 0))
			{
				continue;
			}

			const float sqDist = pos.SqDistance2D(enemy->GetPos());
			if (sqDist < minSqDist) {
				continue;
			}

//			if (sqDist < SQUARE(2000.f)) {  // maxSqDist
				enemyPositions.push_back(enemy->GetPos());
//			}
		}
	}

	if (enemyPositions.empty()) {
		return nullptr;
	}

	return nullptr;
	// Return: <target>, startPos=pos, enemyPositions
}

void CArtilleryTask::ApplyTargetPath(const CQueryPathMulti* query)
{
	const std::shared_ptr<CPathInfo>& pPath = query->GetPathInfo();
	CCircuitUnit* unit = query->GetUnit();

	if (!pPath->posPath.empty()) {
		if (manager->GetCircuit()->GetThreatMap()->GetThreatAt(pPath->posPath.back()) > THREAT_MIN) {
			FallbackSafePos(unit);
		} else {
			position = pPath->posPath.back();
			unit->GetTravelAct()->SetPath(pPath);
		}
	} else {
		FallbackSafePos(unit);
	}
}

void CArtilleryTask::FallbackSafePos(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	circuit->GetMilitaryManager()->FillSafePos(unit, urgentPositions);
	if (urgentPositions.empty()) {
		Fallback(unit, false);
		return;
	}

	const AIFloat3& startPos = unit->GetPos(circuit->GetLastFrame());
	const float pathRange = DEFAULT_SLACK * 4;

	CPathFinder* pathfinder = circuit->GetPathfinder();
	std::shared_ptr<IPathQuery> query = pathfinder->CreatePathMultiQuery(
			unit, circuit->GetThreatMap(),
			startPos, pathRange, urgentPositions);
	pathQueries[unit] = query;

	pathfinder->RunQuery(circuit->GetScheduler().get(), query, [this](const IPathQuery* query) {
		this->ApplySafePos(static_cast<const CQueryPathMulti*>(query));
	});
}

void CArtilleryTask::ApplySafePos(const CQueryPathMulti* query)
{
	const std::shared_ptr<CPathInfo>& pPath = query->GetPathInfo();
	CCircuitUnit* unit = query->GetUnit();

	const bool proceed = pPath->path.size() > 2;
	if (proceed) {
		unit->GetTravelAct()->SetPath(pPath);
	} else {
		Fallback(unit, proceed);
	}
}

void CArtilleryTask::Fallback(CCircuitUnit* unit, bool proceed)
{
	if (proceed) {
		return;
	}

	if (unit->GetTravelAct()->GetState() == IAction::State::WAIT) {
		return;
	}
	unit->GetTravelAct()->StateWait();
	TRY_UNIT(manager->GetCircuit(), unit,
		unit->CmdStop();
	)
}

} // namespace circuit

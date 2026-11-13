/*
 * SuperTask.cpp
 *
 *  Created on: Aug 12, 2016
 *      Author: rlcevg
 */

#include "task/static/SuperTask.h"
#include "task/fighter/SquadTask.h"
#include "map/InfluenceMap.h"
#include "map/MapManager.h"
#include "module/MilitaryManager.h"
#include "terrain/TerrainManager.h"
#include "terrain/BattleAnalysis.h"
#include "unit/enemy/EnemyManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/ally/AllyTeam.h"
#include "unit/ally/AllyUnit.h"
#include "Command.h"
#include "Sim/Units/CommandAI/Command.h"
#include "task/static/StrategicTargeting.h"
#include "task/static/TierTargeting.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitWDef.h"

#define SMILEY_RADIUS	400.f  // D-124: the face over a nuke's target
#define SMILEY_DEDUPE	(FRAMES_PER_SEC * 5)  // D-124: the stockpile watch draws only if the event did not within this
#define SMILEY_DEDUPE_EVENT	(FRAMES_PER_SEC * 1)  // D-124: two launch signals this close are one launch
#include "CircuitAI.h"
#include "util/GameAttribute.h"
#include "util/Utils.h"
#include "spring/SpringCallback.h"
#include "WeaponMount.h"
#include "WeaponDef.h"
#include "Damage.h"
#include "UnitDef.h"

#include "spring/SpringMap.h"
#include "spring/SpringUnit.h"

#include "AISCommands.h"
#include "Lua.h"
#include "Log.h"

#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <format>
#include <limits>
#include <vector>

namespace circuit {

using namespace springai;

#define TARGET_DELAY	(FRAMES_PER_SEC * 10)
// Debug strikes: a team strike rescans this often (the nuke's aim-point scan is
// quadratic in the team's known units, so less often); orders are renewed
// before the engine's 60 s order timeout.
#define DEBUG_RESCAN_LOL	(FRAMES_PER_SEC * 2)
#define DEBUG_RESCAN_NUKE	(FRAMES_PER_SEC * 5)
#define DEBUG_ORDER_RENEW	(FRAMES_PER_SEC * 30)
// Launcher priority: ranks 0..2 (LauncherPriorityRank); the ordinary pick is shifted above them.
#define LAUNCHER_PRIO_RANKS	3

CSuperTask::CSuperTask(ITaskModule* mgr)
		: IFighterTask(mgr, IFighterTask::FightType::SUPER, 1.f)
		, targetFrame(0)
		, targetPos(-RgtVector)
		, isTargetOverride(false)
		, stockSinceFrame(-1)
{
}

CSuperTask::~CSuperTask()
{
}

bool CSuperTask::CanAssignTo(CCircuitUnit* unit) const
{
	return false;
}

void CSuperTask::RemoveAssignee(CCircuitUnit* unit)
{
	manager->GetCircuit()->GetAllyTeam()->GetPulseClaims().ReleasePending(unit->GetId());
	IFighterTask::RemoveAssignee(unit);
	if (units.empty()) {
		manager->AbortTask(this);
	}
}

void CSuperTask::Start(CCircuitUnit* unit)
{
	const int frame = manager->GetCircuit()->GetLastFrame();
	targetFrame = frame - TARGET_DELAY;
	position = unit->GetPos(frame);
}

void CSuperTask::Update()
{
	if (units.empty()) {  // never expected: RemoveAssignee aborts the task on its last unit
		manager->AbortTask(this);
		return;
	}
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	CCircuitUnit* unit = *units.begin();

	// D-124 (owner): a nuclear missile launched: a smiley face on the map over
	// the target. The weapon-fired event is the hook (CCircuitAI::WeaponFired);
	// this stockpile watch is its safety net and draws only when the event did
	// not in the last SMILEY_DEDUPE frames
	if (IsNukeSilo(unit->GetCircuitDef()) || IsPulse(unit->GetCircuitDef())) {
		const int stock = unit->GetUnit()->GetStockpile();
		if ((lastStock >= 0) && (stock < lastStock) && state == State::ENGAGE
			&& strategic::Valid({targetPos.x, targetPos.z}) && (frame - lastStrategicLaunch > SMILEY_DEDUPE)) {
			OnLaunch(unit, "stockpile drop");
		}
		lastStock = stock;
	}
	if (IsNukeSilo(unit->GetCircuitDef()) && (frame - strikeChecked >= FRAMES_PER_SEC)) {
		strikeChecked = frame;
		ResolveStrikes(unit, frame);  // once a second: one hash-free walk over the ally team's few pending launches
	}

	if (unit->Blocker() != nullptr) {
		return;  // Do not interrupt current action
	}

	if (syncPending) {
		return;  // a timed volley order is due (CMilitaryManager::UpdateSyncOrders)
	}

	if (UpdateDebug(unit)) {
		return;  // the widget's debug strike owns this silo or cannon
	}

	if (!tierByDef.empty()) {
		UpdateTiered(unit);
		return;
	}

	CCircuitDef* cdef = unit->GetCircuitDef();
	if (cdef->IsHoldFire()) {
		if (targetFrame + (cdef->GetReloadTime() + TARGET_DELAY) > frame) {
			if ((State::ENGAGE == state) && (targetFrame + TARGET_DELAY <= frame)) {
				TRY_UNIT(circuit, unit,
					unit->CmdStop();
				)
				state = State::ROAM;
			}
			return;
		}
	} else if (targetFrame + TARGET_DELAY > frame) {
		return;
	}

	// Owner 2026-11-03: a Juno the commander group built to probe a jammed
	// ghost cluster aims its first pulse at the cluster's centre (it fires the
	// moment the pulse is stocked); OnLaunch then returns it to the targeting below.
	if (!probeOrderChecked && IsPulse(cdef)) {
		probeOrderChecked = true;
		AIFloat3 aim;
		if (circuit->GetMilitaryManager()->TakeProbeOrder(position, aim)) {
			SetTarget(nullptr);
			targetPos = aim;
			isTargetOverride = true;
			probeAim = true;
			circuit->LOG("PROBE %s(%i): commander group probe Juno, first pulse at (%.0f,%.0f)",
					cdef->GetDef()->GetName(), unit->GetId(), aim.x, aim.z);
		}
	}

	if (isTargetOverride) {
		ExecuteAttack(unit);
		return;
	}

	CMilitaryManager* policyMgr = circuit->GetMilitaryManager();
	const bool isPulse = IsPulse(cdef);
	const CWeaponDef* empWd = cdef->GetWeaponDef();
	const bool isEmp = !isPulse && policyMgr->GetEmpInfo().isEnabled
			&& cdef->IsRespRoleAny(policyMgr->GetEmpInfo().empRole)
			&& (empWd != nullptr) && empWd->IsParalyzer();
	if (isPulse || isEmp) {
		if (isPulse && unit->GetUnit()->GetStockpile() <= 0) {
			circuit->GetAllyTeam()->GetPulseClaims().ReleasePending(unit->GetId());
			targetFrame = frame;
			return;
		}
		if (isPulse) {
			// Observe allied ground orders too, including human-controlled Junos.
			// This only reads their commands; it never takes control of them.
			const auto& policy = policyMgr->GetPulseInfo();
			for (const auto& [id, ally] : circuit->GetAllyTeam()->GetFriendlyUnits()) {
				if (id == unit->GetId() || ally->GetCircuitDef() == nullptr || !IsPulse(ally->GetCircuitDef())) continue;
				auto commands = ally->GetUnit()->GetCurrentCommands();
				if (!commands.empty() && commands.front()->GetId() == CMD_ATTACK) {
					const auto params = commands.front()->GetParams();
					if (params.size() >= 3) circuit->GetAllyTeam()->GetPulseClaims().Add(id, {params[0], params[2]},
						ally->GetCircuitDef()->GetAoe(), frame, policy.pendingFrames, true);
				}
				utils::free_clear(commands);
			}
		}
		// Neither weapon falls back to the group scan: spending the stockpile on
		// the richest enemy blob, which one cannot damage and the other cannot
		// hold, is worse than waiting for a target that works.
		// A known jammer or radar always wins: its position is certain, so a
		// target deep behind the line is still worth the shot. Only when nothing
		// is known does the weapon fall back to inferring one from a radar hole.
		// Owner 2026-11-03: the probing shot at a jammed ghost cluster comes
		// after every known radar/jammer and before the radar-hole inference.
		probeAim = false;
		const bool hasTarget = isPulse
				? (SelectPulseTarget(unit, cdef) || SelectProbeTarget(unit, cdef)
					|| SelectSuspectedJammer(unit, cdef) || SelectFogTarget(unit, cdef))
				: SelectEmpTarget(unit, cdef);
		if (hasTarget) {
			if (!SyncLaunch(unit, cdef, frame)) ExecuteAttack(unit);
		} else {
			TRY_UNIT(circuit, unit,
				unit->CmdStop();
			)
			SetTarget(nullptr);
			targetFrame = frame;
		}
		return;
	}
	if (IsNukeSilo(cdef)) {
		if (SelectNuclearTarget(unit, cdef)) ExecuteAttack(unit);
		else {
			TRY_UNIT(circuit, unit, unit->CmdStop();)
			SetTarget(nullptr);
			targetFrame = frame;
		}
		return;
	}

	const float mapDiag = std::sqrt(SQUARE(float(CTerrainManager::GetTerrainWidth())) + SQUARE(float(CTerrainManager::GetTerrainHeight())));
	const bool isRegional = (cdef->GetMaxRange() < mapDiag);

	// A stockpiled launcher whose range does not cover the map - Perdition
	// (2300), Catalyst (2250) - cannot be aimed by the group scan below. Enemy
	// groups are k-means cells, 1 + sqrt(N) of them for the whole map, and a
	// cell's centroid is almost never within 2300 of a static that sits in one
	// of our clusters: every logged tick read inRange=0 while the enemy stood
	// inside reach. Scan units instead, as EMP and Juno do, and value the aim
	// point by the metal inside the blast. The shot is still subject to the
	// stockpile floor, so it is not thrown at a lone scout.
	if (cdef->IsAttrStock() && isRegional && (empWd != nullptr)) {
		const float floor = StockedShotFloor(unit, cdef, frame, empWd->GetCostMShot());
		if (SelectLauncherTarget(unit, cdef, floor)) {
			if (!SyncLaunch(unit, cdef, frame)) ExecuteAttack(unit);
		} else {
			TRY_UNIT(circuit, unit,
				unit->CmdStop();
			)
			SetTarget(nullptr);
			targetFrame = frame;
		}
		return;
	}

	CInfluenceMap* inflMap = circuit->GetInflMap();
	CMilitaryManager* militaryMgr = circuit->GetMilitaryManager();
	const float maxSqRange = SQUARE(cdef->GetMaxRange());
	const float sqAoe = SQUARE(cdef->GetAoe() * 1.25f);
	float cost = 0.f;
	int groupIdx = -1;
	const std::array<const std::set<IFighterTask*>*, 3> avoidTasks = {  // NOTE: ISquadTask only
		&militaryMgr->GetTasks(IFighterTask::FightType::ATTACK),
		&militaryMgr->GetTasks(IFighterTask::FightType::AH),
		&militaryMgr->GetTasks(IFighterTask::FightType::AA),
	};
	// A super weapon whose range does not cover the map - EMP silo (~3650), tactical
	// missile launchers (~2300), T2 LRPCs (~4650-4950) and, on large maps, the endgame
	// LRPCs (~5750-6100) - is a regional weapon: it is built as a cluster defence and
	// its targets are the enemy pushes into our own clusters, which sit in *our*
	// influence. Requiring enemy-dominated ground (influence <= -INFL_EPS) there
	// rejects every group it can reach, so the EMP filled its stockpile and never
	// fired and the LRPCs were left to engine auto-targeting, while the map-range
	// Junos (32000) and nukes (72000) worked. For regional weapons require only enemy
	// presence at the group; the own-squad exclusion and cost floor below still apply.
	// Map-range weapons keep the strict rule so they are never spent on the front line.
	int inRange = 0, rejInfl = 0, rejSquad = 0, rejIgnore = 0;
	auto isTargetValid = [&avoidTasks, frame, sqAoe, inflMap, circuit, isRegional, &rejInfl, &rejSquad, &rejIgnore](const CEnemyManager::SEnemyGroup& group) {
		// Ally influence and own tasks avoidance
		if (isRegional) {
			if (inflMap->GetEnemyInflAt(group.pos) <= INFL_EPS) {
				++rejInfl;
				return false;
			}
		} else if (inflMap->GetInfluenceAt(group.pos) > -INFL_EPS) {
			++rejInfl;
			return false;
		}
		for (const std::set<IFighterTask*>* tasks : avoidTasks) {
			for (const IFighterTask* task : *tasks) {
				const AIFloat3& leaderPos = static_cast<const ISquadTask*>(task)->GetLeaderPos(frame);
				if (leaderPos.SqDistance2D(group.pos) < sqAoe) {
					++rejSquad;
					return false;
				}
			}
		}
		for (const ICoreUnit::Id eId : group.units) {
			CEnemyInfo* enemy = circuit->GetEnemyInfo(eId);
			if (enemy == nullptr) {
				continue;
			}
			CCircuitDef* edef = enemy->GetCircuitDef();
			// NOTE: groups are created by leader, ignore flags could be different
			if ((edef == nullptr) || !circuit->GetCircuitDef(edef->GetId())->IsIgnore()) {
				return true;
			}
		}
		++rejIgnore;
		return false;
	};

	const std::vector<CEnemyManager::SEnemyGroup>& groups = circuit->GetEnemyManager()->GetEnemyGroups();
	if (cdef->IsHoldFire() || (State::ROAM == state)) {
		for (unsigned i = 0; i < groups.size(); ++i) {
			const CEnemyManager::SEnemyGroup& group = groups[i];
			if ((cost >= group.cost) || (position.SqDistance2D(group.pos) >= maxSqRange)) {
				continue;
			}
			++inRange;
			if (isTargetValid(group)) {
				cost = group.cost;
				groupIdx = i;
			}
		}
	} else {
		// TODO: Use WeaponDef::GetTurnRate() for turn-delay weight
		const AIFloat3& targetVec = (targetPos - position).Normalize2D();
		for (unsigned i = 0; i < groups.size(); ++i) {
			const CEnemyManager::SEnemyGroup& group = groups[i];
			if (position.SqDistance2D(group.pos) >= maxSqRange) {
				continue;
			}
			++inRange;
			const AIFloat3& newVec = (group.pos - position).Normalize2D();
			const float angleMod = M_PI / (2.f * (std::acos(targetVec.dot2D(newVec)) + 1e-2f));
			if (cost >= group.cost * angleMod) {
				continue;
			}
			if (isTargetValid(group)) {
				cost = group.cost;
				groupIdx = i;
			}
		}
	}
	// NOTE: for a stockpile weapon CWeaponDef::GetCostM() is the per-second
	//       stockpiling rate, not the cost of a shot; comparing it against a
	//       group's absolute metal cost left Juno with a ~2.7 metal floor.
	const float maxCost = cdef->IsAttrStock()
			? StockedShotFloor(unit, cdef, frame, cdef->GetWeaponDef()->GetCostMShot())
			: cdef->GetCostM() * 0.01f;

	if ((groupIdx < 0) || (cost < maxCost)) {
		// Diagnostic for a super weapon that never fires: which gate rejected every
		// reachable group. Once a minute per unit (Update runs every TARGET_DELAY);
		// for stockpiled launchers only while a shot is stocked.
		if (((frame / TARGET_DELAY) % 6 == 0)
			&& (!cdef->IsAttrStock() || (unit->GetUnit()->GetStockpile() > 0)))
		{
			circuit->LOG("SUPER %s(%i): no target | range=%.0f regional=%i groups=%zu inRange=%i rejInfl=%i rejSquad=%i rejIgnore=%i bestCost=%.0f minCost=%.0f",
					cdef->GetDef()->GetName(), unit->GetId(), cdef->GetMaxRange(), int(isRegional), groups.size(),
					inRange, rejInfl, rejSquad, rejIgnore, cost, maxCost);
		}
		TRY_UNIT(circuit, unit,
			unit->CmdStop();
		)
		SetTarget(nullptr);
		targetFrame = frame;
		return;
	}

	const AIFloat3& grPos = groups[groupIdx].pos;
	CEnemyInfo* bestTarget = nullptr;
	if (cdef->IsAttrStock()) {
		float minSqDist = std::numeric_limits<float>::max();
		for (const ICoreUnit::Id eId : groups[groupIdx].units) {
			CEnemyInfo* enemy = circuit->GetEnemyInfo(eId);
			if (enemy == nullptr) {
				continue;
			}
			CCircuitDef* edef = enemy->GetCircuitDef();
			// NOTE: groups are created by leader, ignore flags could be different
			if ((edef != nullptr) && circuit->GetCircuitDef(edef->GetId())->IsIgnore()) {
				continue;
			}
			const float sqDist = grPos.SqDistance2D(enemy->GetPos());
			if ((minSqDist > sqDist) && (position.SqDistance2D(enemy->GetPos()) < maxSqRange)) {
				minSqDist = sqDist;
				bestTarget = enemy;
			}
		}
	} else {
		float maxCost = 0.f;
		for (const ICoreUnit::Id eId : groups[groupIdx].units) {
			CEnemyInfo* enemy = circuit->GetEnemyInfo(eId);
			if (enemy == nullptr) {
				continue;
			}
			CCircuitDef* edef = enemy->GetCircuitDef();
			// NOTE: groups are created by leader, ignore flags could be different
			if ((edef != nullptr) && circuit->GetCircuitDef(edef->GetId())->IsIgnore()) {
				continue;
			}
			if ((maxCost < enemy->GetCost()) && (position.SqDistance2D(enemy->GetPos()) < maxSqRange)) {
				maxCost = enemy->GetCost();
				bestTarget = enemy;
			}
		}
	}
	SetTarget(bestTarget);
	if (GetTarget() != nullptr) {
		targetPos = GetTarget()->GetPos();
		targetPos.y = circuit->GetMap()->GetElevationAt(targetPos.x, targetPos.z);

		ExecuteAttack(unit);
	}
}

/*
 * Shared area-target selection. See the header for the contract.
 *
 * Differences from the generic super-weapon scan, all deliberate:
 *  - no influence gate. The best targets for these weapons are often on ground
 *    we hold: a jamming push into our own base, a minefield on our expansion.
 *  - no own-squad exclusion. Neither weapon can damage our units.
 *  - mobile targets are shot at their last known position while it is fresher
 *    than mobileMaxAge, which is the only way to hit a mobile jammer at all:
 *    it hides the very radar that would track it.
 *  - it attacks the ground, not a unit, because the kill or stun is by area and
 *    the target may no longer be visible.
 */
bool CSuperTask::SelectAreaTarget(CCircuitUnit* unit, CCircuitDef* cdef, const char* tag,
		float sqAoe, int minTargets, int mobileMaxAge, const TClassify& classify, float minValue, bool avoidFriendly,
		bool allEnemies, bool pulseClaims, bool nuclearHistory, const TAimScale& aimScale, const TExtraAims& extraAims, const CWeaponDef* blastWeapon,
		int centerRanks)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	const float maxSqRange = SQUARE(cdef->GetMaxRange());

	struct SAreaCand {
		springai::AIFloat3 pos;
		int rank;
		float value;
		float health;
		const CCircuitDef* cdef;
		ICoreUnit::Id id;
	};
	std::vector<SAreaCand> cands;
	int rejRange = 0, rejStale = 0, rejClass = 0, rejFriendly = 0;

	const auto* enemies = circuit->GetEnemyManager();
	areaRank = -1;
	for (const auto* pool : {&enemies->GetHostileDatas(), allEnemies ? &enemies->GetPeaceDatas() : nullptr}) {
	if (pool == nullptr) continue;
	areaPeacePool = (pool == &enemies->GetPeaceDatas());
	for (const SEnemyData& e : *pool) {
		if (e.IsFake() || e.IsDead() || e.IsDying() || e.IsIgnore()) {
			continue;
		}
		CCircuitDef* edef = e.cdef;
		if (edef == nullptr) {
			continue;
		}
		int rank = 0;
		float value = 0.f;
		if (!classify(e, edef, rank, value)) {
			++rejClass;
			continue;
		}
		if (edef->IsMobile() && !e.IsInRadarOrLOS()) {
			CEnemyInfo* info = circuit->GetEnemyInfo(e.id);
			const int lastSeen = (info == nullptr) ? -1 : info->GetData()->GetLastSeen();
			if ((lastSeen < 0) || (frame - lastSeen > mobileMaxAge)) {
				++rejStale;
				continue;
			}
		}
		if (position.SqDistance2D(e.pos) >= maxSqRange) {
			++rejRange;
			continue;
		}
		if ((pulseClaims || nuclearHistory) && !CanAimStrategic(unit, e.pos)) continue;
		if (avoidFriendly) {
			// A damaging blast on our own units is never worth it, whatever the
			// enemy value inside it (CR-005). The engine query is per candidate;
			// candidates are the hostiles in range, a few dozen at most.
			auto& friendlies = circuit->GetCallback()->GetFriendlyUnitsIn(e.pos, std::sqrt(sqAoe));
			const bool hit = !friendlies.empty();
			utils::free(friendlies);
			if (hit) {
				++rejFriendly;
				continue;
			}
		}
		cands.push_back({e.pos, rank, value, ((e.health > 0.f) ? e.health : edef->GetHealth()), edef, e.id});
	}
	}

	// Aim points: every candidate, plus the caller's extra points (nukes: just
	// outside an antinuke's coverage), which pass the same range, claim and
	// friendly checks as a candidate.
	std::vector<springai::AIFloat3> aims;
	aims.reserve(cands.size());
	for (const SAreaCand& c : cands) aims.push_back(c.pos);
	if (extraAims && !cands.empty()) {
		std::vector<springai::AIFloat3> cpos;
		cpos.reserve(cands.size());
		for (const SAreaCand& c : cands) cpos.push_back(c.pos);
		for (springai::AIFloat3 p : extraAims(cpos)) {
			if ((p.x < 0.f) || (p.z < 0.f) || (p.x >= CTerrainManager::GetTerrainWidth()) || (p.z >= CTerrainManager::GetTerrainHeight())) continue;
			if (position.SqDistance2D(p) >= maxSqRange) continue;
			if ((pulseClaims || nuclearHistory) && !CanAimStrategic(unit, p)) continue;
			if (avoidFriendly) {
				auto& friendlies = circuit->GetCallback()->GetFriendlyUnitsIn(p, std::sqrt(sqAoe));
				const bool hit = !friendlies.empty();
				utils::free(friendlies);
				if (hit) continue;
			}
			p.y = circuit->GetMap()->GetElevationAt(p.x, p.z);
			aims.push_back(p);
		}
	}

	// Chain reactions (owner 2026-11-02): with a blast weapon, an aim point is
	// worth the metal of everything that dies - the blast's own kills, then
	// every death explosion's kills, repeated - see ChainKill.
	float chainReach = 0.f;
	if (blastWeapon != nullptr) {
		for (const SAreaCand& c : cands) chainReach = std::max(chainReach, DeathBlastOf(c.cdef).radius);
	}
	const float sqReach = SQUARE(std::sqrt(sqAoe) + chainReach);
	std::vector<SChainUnit> nearUnits;

	int bestRank = std::numeric_limits<int>::max();
	float bestValue = 0.f;
	int bestCount = 0;
	int bestIdx = -1;
	for (unsigned i = 0; i < aims.size(); ++i) {
		if (blastWeapon != nullptr) {
			int rank = std::numeric_limits<int>::max();
			int count = 0;
			nearUnits.clear();
			for (const SAreaCand& c : cands) {
				const float sqDist = aims[i].SqDistance2D(c.pos);
				if (sqDist >= sqReach) continue;
				if (sqDist < sqAoe) { rank = std::min(rank, c.rank); ++count; }
				nearUnits.push_back({c.pos, c.value, c.health, c.cdef, FacingOf(c.id, DeathBlastOf(c.cdef))});
			}
			if (count < minTargets) continue;
			float value = ChainKill(blastWeapon, std::sqrt(sqAoe), aims[i], nearUnits);
			if (aimScale) value *= aimScale(aims[i]);
			if ((rank < bestRank) || ((rank == bestRank) && (value > bestValue))) {
				bestRank = rank; bestValue = value; bestCount = count; bestIdx = int(i);
			}
			continue;
		}
		int rank = std::numeric_limits<int>::max();
		float value = 0.f;
		int count = 0;
		for (unsigned j = 0; j < cands.size(); ++j) {
			const float sqDist = aims[i].SqDistance2D(cands[j].pos);
			if (sqDist >= sqAoe) {
				continue;
			}
			rank = std::min(rank, cands[j].rank);
			value += cands[j].value;
			++count;
		}
		// Launcher priority: a priority rank belongs only to the aim point on
		// that target, so the shot lands on it, not at the edge of a clump.
		if ((centerRanks > 0) && (rank < centerRanks)) {
			rank = ((i < cands.size()) && (cands[i].rank < centerRanks)) ? cands[i].rank : centerRanks;
		}
		if (count < minTargets) {
			continue;
		}
		if (aimScale) {
			value *= aimScale(aims[i]);
		}
		if ((rank < bestRank) || ((rank == bestRank) && (value > bestValue))) {
			bestRank = rank;
			bestValue = value;
			bestCount = count;
			bestIdx = int(i);
		}
	}

	if ((bestIdx >= 0) && (bestValue < minValue) && (bestRank >= centerRanks)) {
		bestIdx = -1;  // the richest aim point is not worth the shot yet; see StockedShotFloor
	}
	if (bestIdx < 0) {
		if ((frame / TARGET_DELAY) % 6 == 0) {
			circuit->LOG("%s %s(%i): no target | range=%.0f candidates=%zu rejClass=%i rejRange=%i rejStale=%i rejFriendly=%i minTargets=%i bestValue=%.0f minValue=%.0f",
					tag, cdef->GetDef()->GetName(), unit->GetId(), cdef->GetMaxRange(),
					cands.size(), rejClass, rejRange, rejStale, rejFriendly, minTargets, bestValue, minValue);
		}
		return false;
	}

	areaRank = bestRank;
	areaReach = std::sqrt(sqReach);  // blast plus chain reach: a landed nuke marks this much (StrikeLedger)
	SetTarget(nullptr);  // area effect at a position, possibly of a unit we can no longer see
	const bool isMoved = (targetPos.SqDistance2D(aims[bestIdx]) > SQUARE(1.f));
	targetPos = aims[bestIdx];
	targetPos.y = circuit->GetMap()->GetElevationAt(targetPos.x, targetPos.z);
	if (isMoved) {  // Update runs every TARGET_DELAY: only log a new aim point
		circuit->LOG("%s %s(%i): rank=%i targets=%i value=%.0f at (%i,%i)%s%s",
				tag, cdef->GetDef()->GetName(), unit->GetId(), bestRank, bestCount, bestValue,
				int(targetPos.x), int(targetPos.z),
				((bestRank < centerRanks) && (bestIdx < int(cands.size()))) ? " priority " : "",
				((bestRank < centerRanks) && (bestIdx < int(cands.size()))) ? cands[bestIdx].cdef->GetDef()->GetName() : "");
	}
	return true;
}

/*
 * Blast and chain kills (owner 2026-11-02). Engine area damage is
 * damage x (R - d) / (R - d x edge effectiveness), d measured to the unit's
 * collision volume (CollisionVolumes.h, SurfaceDistance). A nuke
 * (15000, R 960, edge 0) kills a full 9400-health Cortex AFUS only within about
 * 360 of the impact, but each AFUS or advanced geo that dies explodes for 10600
 * over 640 (customfusionexplo), fusions and nuke silos for 2650 over 240, so a
 * tight economy block usually dies whole once one of them goes. ChainKill
 * applies the blast to every known unit near the aim point (health as last
 * seen), then each death's explosion to the survivors, until nothing more
 * dies, and returns the metal of the dead.
 */
float CSuperTask::AreaDamage(float damage, float radius, float edge, float dist)
{
	if ((damage <= 0.f) || (dist >= radius)) return 0.f;
	const float denom = radius - dist * edge;
	return (denom > 0.f) ? damage * (radius - dist) / denom : damage;
}

CSuperTask::SDeathBlast CSuperTask::DeathBlastOf(const CCircuitDef* cdef)
{
	auto it = deathBlasts.find(cdef);
	if (it != deathBlasts.end()) return it->second;
	SDeathBlast b;
	CCircuitDef* d = const_cast<CCircuitDef*>(cdef);
	b.volume = d->GetRadius();
	// the generated table (CollisionVolumes.h), indexed by name once per process
	static const std::unordered_map<std::string, const CV::SVolume*> table = []() {
		std::unordered_map<std::string, const CV::SVolume*> t;
		for (const CV::SVolume& v : CV::volumes) t.emplace(v.name, &v);
		return t;
	}();
	auto cv = table.find(d->GetDef()->GetName());
	b.cv = (cv != table.end()) ? cv->second : nullptr;
	const std::unique_ptr<WeaponDef> wd(d->GetDef()->GetDeathExplosion());
	if (wd != nullptr) {
		b.radius = wd->GetAreaOfEffect();
		b.edge = wd->GetEdgeEffectiveness();
		Damage* damage = wd->GetDamage();
		const std::vector<float>& types = damage->GetTypes();
		// default armour; a paralyzer death blast (armamex, armshockwave: empblast) stuns, it kills nothing
		b.damage = (types.empty() || wd->IsParalyzer()) ? 0.f : types[0];
		delete damage;
	}
	deathBlasts.emplace(cdef, b);
	return b;
}

/*
 * The engine's area damage distance is to the collision volume's surface
 * (headless calibration 2026-11-02: exact to under 1 elmo). Cylinders (Y axis)
 * and spheres: planar distance minus the radius; boxes and lying cylinders: the
 * planar distance to the footprint rectangle, half-sizes and offsets turned by
 * the building facing (0 south, 1 east, 2 north, 3 west). A def without a table
 * entry: centre distance minus its radius x nuclear.blast_volume_factor.
 */
float CSuperTask::SurfaceDistance(const SDeathBlast& b, float volumeFactor, const AIFloat3& unitPos, int facing, const AIFloat3& p)
{
	const CV::SVolume* v = b.cv;
	if (v == nullptr) {
		return std::max(0.f, std::sqrt(unitPos.SqDistance2D(p)) - b.volume * volumeFactor);
	}
	const bool turned = (facing == 1) || (facing == 3);
	float ox = v->ox, oz = v->oz;
	switch (facing) {
		case 1: ox = v->oz; oz = -v->ox; break;
		case 2: ox = -v->ox; oz = -v->oz; break;
		case 3: ox = -v->oz; oz = v->ox; break;
		default: break;
	}
	const float dx = p.x - (unitPos.x + ox), dz = p.z - (unitPos.z + oz);
	switch (v->type) {
		case CV::CYL_Y:
		case CV::SPHERE:
			return std::max(0.f, std::sqrt(dx * dx + dz * dz) - (v->sx + v->sz) * 0.25f);
		default: {  // BOX, CYL_X, CYL_Z: the planar rectangle
			const float hx = (turned ? v->sz : v->sx) * 0.5f, hz = (turned ? v->sx : v->sz) * 0.5f;
			const float ex = std::max(0.f, std::abs(dx) - hx), ez = std::max(0.f, std::abs(dz) - hz);
			return std::sqrt(ex * ex + ez * ez);
		}
	}
}

int CSuperTask::FacingOf(ICoreUnit::Id id, const SDeathBlast& b)
{
	if ((b.cv == nullptr) || (b.cv->type == CV::CYL_Y) || (b.cv->type == CV::SPHERE)) return 0;  // round: facing does not matter
	auto it = facings.find(id);
	if (it != facings.end()) return it->second;
	CEnemyInfo* info = manager->GetCircuit()->GetEnemyInfo(id);
	if ((info == nullptr) || !info->GetData()->IsInLOS()) return 0;  // facing 0 until seen
	const int facing = info->GetUnit()->GetBuildingFacing();
	if ((facing < 0) || (facing > 3)) return 0;
	facings.emplace(id, facing);
	return facing;
}

float CSuperTask::ChainKill(const CWeaponDef* wd, float radius, const AIFloat3& aim, const std::vector<SChainUnit>& units)
{
	const float volumeFactor = manager->GetCircuit()->GetMilitaryManager()->GetNuclearInfo().volumeFactor;
	const unsigned n = units.size();
	std::vector<float> hp(n);
	std::vector<SDeathBlast> blasts(n);
	std::vector<unsigned> frontier;
	for (unsigned k = 0; k < n; ++k) {
		blasts[k] = DeathBlastOf(units[k].cdef);
		hp[k] = units[k].health - AreaDamage(wd->GetDamage(), radius, wd->GetEdgeEffectiveness(),
				SurfaceDistance(blasts[k], volumeFactor, units[k].pos, units[k].facing, aim));
		if (hp[k] <= 0.f) frontier.push_back(k);
	}
	std::vector<bool> dead(n, false);
	float value = 0.f;
	while (!frontier.empty()) {
		std::vector<unsigned> next;
		for (unsigned k : frontier) {
			if (dead[k]) continue;
			dead[k] = true;
			value += units[k].value;
			const SDeathBlast& b = blasts[k];
			if (b.damage <= 0.f) continue;
			for (unsigned j = 0; j < n; ++j) {
				if (dead[j] || (hp[j] <= 0.f)) continue;
				hp[j] -= AreaDamage(b.damage, b.radius, b.edge, SurfaceDistance(blasts[j], volumeFactor, units[j].pos, units[j].facing, units[k].pos));
				if (hp[j] <= 0.f) next.push_back(j);
			}
		}
		frontier.swap(next);
	}
	return value;
}

/*
 * A stockpiled shot is already paid for. The longer it waits, the less a
 * target has to be worth; with several stocked, any target at all. Shared by
 * the group scan (nukes, Junos without a pulse block) and the launcher scan.
 */
float CSuperTask::StockedShotFloor(CCircuitUnit* unit, CCircuitDef* cdef, int frame, float shotCost)
{
	const int stock = unit->GetUnit()->GetStockpile();
	if (stock <= 0) {
		stockSinceFrame = -1;
		return shotCost;
	}
	if (stockSinceFrame < 0) {
		stockSinceFrame = frame;
	}
	const CMilitaryManager::SStockInfo& st = manager->GetCircuit()->GetMilitaryManager()->GetStockInfo();
	float fraction = 1.f;
	if (st.patienceSeconds > 0.f) {
		fraction -= float(frame - stockSinceFrame) / (st.patienceSeconds * FRAMES_PER_SEC);
	}
	if ((st.fullFireCount > 0) && (stock >= st.fullFireCount)) {
		fraction = 0.f;
	}
	return shotCost * std::max(st.minFraction, fraction);
}

/*
 * Tactical launchers (Perdition napalm, Catalyst tactical nuke) do plain area
 * damage, so the worth of an aim point is the metal inside the blast. Every
 * hostile the weapon's target category allows is a candidate - a napalm
 * missile cannot hit aircraft - and the best aim point is the densest clump,
 * structures first only when configured. The floor passed in keeps the shot
 * for something worth its cost until patience runs out.
 */
bool CSuperTask::SelectLauncherTarget(CCircuitUnit* unit, CCircuitDef* cdef, float minValue)
{
	CMilitaryManager* militaryMgr = manager->GetCircuit()->GetMilitaryManager();
	const CMilitaryManager::SStockInfo& st = militaryMgr->GetStockInfo();
	const CMilitaryManager::SLauncherPrioInfo& lp = militaryMgr->GetLauncherPrioInfo();
	const bool prio = lp.isEnabled && (lp.defs.count(cdef->GetId()) > 0);
	const int canTargetCat = cdef->GetTargetCategory();
	// Launcher priority (owner 2026-11-03): shields, Pulsar, Bulwark, Bastion;
	// then slow commanders; then Persecutor, Rattlesnake, Eviscerator and
	// stationary T3. Shields are unarmed, so the peace pool is scanned too, but
	// only for priority targets: the ordinary pick is unchanged.
	return SelectAreaTarget(unit, cdef, "LAUNCHER", SQUARE(cdef->GetAoe()),
			st.launcherMinTargets, st.launcherMobileMaxAge,
			[this, &st, canTargetCat, prio, cdef](const SEnemyData& e, CCircuitDef* edef, int& rank, float& value) {
		if ((canTargetCat & edef->GetCategory()) == 0) {
			return false;  // outside the weapon's target category (aircraft for napalm)
		}
		value = e.cost;
		const int pr = prio ? LauncherPriorityRank(e, edef, cdef) : -1;
		if (pr >= 0) {
			rank = pr;
			return true;
		}
		if (areaPeacePool) {
			return false;
		}
		rank = ((st.launcherStructuresFirst && !edef->IsMobile()) ? 0 : 1) + (prio ? LAUNCHER_PRIO_RANKS : 0);
		return true;
	}, minValue, /*avoidFriendly*/ true, /*allEnemies*/ prio, false, false, nullptr, nullptr, nullptr,
			prio ? LAUNCHER_PRIO_RANKS : 0);
}

/*
 * Pulse weapons (Juno) do 1 damage: their effect is a Lua gadget that deletes
 * defs flagged juno_kill / juno_deny / mine inside the blast. Ranking enemy
 * groups by metal cost therefore aims them at armies they cannot touch, so
 * they select the highest-priority sensor / EW class in range instead.
 */
bool CSuperTask::SelectPulseTarget(CCircuitUnit* unit, CCircuitDef* cdef)
{
	const CMilitaryManager::SPulseInfo& pulse = manager->GetCircuit()->GetMilitaryManager()->GetPulseInfo();
	return SelectAreaTarget(unit, cdef, "PULSE", SQUARE(cdef->GetAoe()),
			pulse.minTargets, pulse.mobileMaxAge,
			[&pulse](const SEnemyData& e, CCircuitDef* edef, int& rank, float& value) {
		const auto cls = pulse.targetClasses.find(edef->GetId());
		if (cls == pulse.targetClasses.end()) return false;
		const int r = pulse.rank[cls->second];
		if (r < 0) {
			return false;  // class excluded by config
		}
		rank = r;
		value = e.cost;
		return true;
	}, 0.f, false, true, true);
}

bool CSuperTask::SelectProbeTarget(CCircuitUnit* unit, CCircuitDef* cdef)
{
	CCircuitAI* circuit = manager->GetCircuit();
	CMilitaryManager* militaryMgr = circuit->GetMilitaryManager();
	if (!militaryMgr->GetPulseInfo().probe) return false;
	const int frame = circuit->GetLastFrame();
	const float maxSqRange = SQUARE(cdef->GetMaxRange());
	const strategic::Ledger& history = circuit->GetAllyTeam()->GetProbeHistory();
	for (const strategic::ProbeCluster& c : militaryMgr->GetProbeClusters()) {  // best first
		AIFloat3 p(c.center.x, 0.f, c.center.z);
		if (position.SqDistance2D(p) >= maxSqRange) continue;
		if (history.Blocked(c.center, -1, frame, false)) continue;  // probed recently, by us or an ally
		if (!CanAimStrategic(unit, p)) continue;  // another Juno's pending or launched pulse
		SetTarget(nullptr);
		const bool isMoved = (targetPos.SqDistance2D(p) > SQUARE(1.f));
		targetPos = p;
		targetPos.y = circuit->GetMap()->GetElevationAt(p.x, p.z);
		probeAim = true;
		if (isMoved) {
			circuit->LOG("PROBE %s(%i): probing shot at jammed ghosts=%i metal=%.0f at (%i,%i)",
					cdef->GetDef()->GetName(), unit->GetId(), c.count, c.metal, int(p.x), int(p.z));
		}
		return true;
	}
	return false;
}

bool CSuperTask::IsPulse(CCircuitDef* cdef) const
{
	const auto& p = manager->GetCircuit()->GetMilitaryManager()->GetPulseInfo();
	return p.isEnabled && (cdef->IsRespRoleAny(p.pulseRole) || p.unitDefs.count(cdef->GetId()) != 0);
}

bool CSuperTask::CanAimStrategic(CCircuitUnit* unit, const AIFloat3& pos) const
{
	CCircuitAI* circuit = manager->GetCircuit();
	if (!strategic::Valid({pos.x, pos.z}) || pos.x >= CTerrainManager::GetTerrainWidth() || pos.z >= CTerrainManager::GetTerrainHeight()) return false;
	const int frame = circuit->GetLastFrame();
	if (IsPulse(unit->GetCircuitDef())) return !circuit->GetAllyTeam()->GetPulseClaims().Blocked({pos.x, pos.z}, unit->GetId(), frame, false);
	if (IsNukeSilo(unit->GetCircuitDef())) {
		const strategic::Overnuke& over = circuit->GetMilitaryManager()->GetOvernuke();
		if (over.Covers({pos.x, pos.z})) return true;  // the overnuke target: every silo, every shot
		return !over.Done({pos.x, pos.z}, frame)
			&& !circuit->GetAllyTeam()->GetNuclearHistory().Blocked({pos.x, pos.z}, unit->GetId(), frame, true);
	}
	return true;
}

/*
 * One overnuke per ally team (owner 2026-11-01): the silos of every allied BARb
 * (TECH's, AIR's, FRONT's grid) count towards the breakpoints, stock the salvo
 * and stop together. fn(owner AI, its super task, the silo). A walk over the
 * allied AIs' SUPER tasks - a handful each.
 */
template<typename F> static void ForEachAllyNukeSilo(CCircuitAI* circuit, F&& fn)
{
	for (CCircuitAI* ai : circuit->GetGameAttribute()->GetCircuits()) {
		if (!ai->IsInitialized() || (ai->GetAllyTeamId() != circuit->GetAllyTeamId())) continue;
		for (IFighterTask* task : ai->GetMilitaryManager()->GetTasks(IFighterTask::FightType::SUPER)) {
			const auto& assignees = task->GetAssignees();
			if (assignees.empty() || !CSuperTask::IsNukeSilo((*assignees.begin())->GetCircuitDef())) continue;
			fn(ai, static_cast<CSuperTask*>(task), *assignees.begin());
		}
	}
}

int CSuperTask::CountNukeSilos() const
{
	int count = 0;
	ForEachAllyNukeSilo(manager->GetCircuit(), [&count](CCircuitAI*, CSuperTask*, CCircuitUnit*) { ++count; });
	return count;
}

/*
 * Overnuke (owner 2026-10-28). With nuclear.overnuke_silos finished silos or
 * more, the best aim point the scan finds becomes the target of every silo for
 * a roll of overnuke_min..overnuke_max launches (CSuperTask::OnLaunch counts
 * them), then the next best; a target with no known structure left in the blast
 * ends early. A silo that cannot reach the target picks its own as before.
 */
bool CSuperTask::SelectNuclearTarget(CCircuitUnit* unit, CCircuitDef* cdef)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	const auto& policy = circuit->GetMilitaryManager()->GetNuclearInfo();
	const float floor = StockedShotFloor(unit, cdef, frame, cdef->GetWeaponDef()->GetCostMShot());
	float coverFactor = policy.antinukeFactorOrdinary;  // overnuke: antinukeFactorOvernuke, set below
	auto scan = [&]() {
		const auto interceptors = KnownInterceptors();
		// Nuke outcome (owner 2026-11-06): a ghost in an area a missile of ours landed
		// on, not seen since, weighs strike_factor; an aim point near an intercept
		// with no known interceptor counts one presumed interceptor.
		const strategic::StrikeLedger& strikes = circuit->GetAllyTeam()->GetNuclearStrikes();
		const bool marked = !strikes.Empty() && (policy.strikeFactor < 1.f);
		const bool full = strikes.Empty() || (policy.interceptPresumeRadius <= 0.f);
		const bool found = SelectAreaTarget(unit, cdef, "NUCLEAR", SQUARE(cdef->GetAoe()), 1, 0,
			[&policy, circuit, &strikes, marked](const SEnemyData& e, CCircuitDef* d, int& rank, float& value) {
				if (!strategic::NuclearTarget(d->IsMobile(), true, policy.structuresOnly)) return false;
				rank = 0; value = e.cost;
				if (marked && !e.IsInLOS()) {
					const CEnemyInfo* info = circuit->GetEnemyInfo(e.id);
					const int lastSeen = (info == nullptr) ? -1 : info->GetData()->GetLastSeen();
					value *= strikes.GhostFactor({e.pos.x, e.pos.z}, lastSeen, policy.strikeFactor);
				}
				return true;
			}, floor, true, true, false, true,
			[&policy, &interceptors, &coverFactor, &strikes, full, frame](const AIFloat3& pos) {
				int n = CountInterceptorCover(interceptors, pos);
				if ((n <= 0) && !full && strikes.PresumedCover({pos.x, pos.z}, policy.interceptPresumeRadius, frame)) n = 1;
				return (n <= 0) ? 1.f : std::max(policy.antinukeFloor, std::pow(coverFactor, float(n)));
			},
			[&interceptors](const std::vector<AIFloat3>& targets) {
				return CoverEdgeAims(interceptors, targets);
			}, policy.blastKill ? cdef->GetWeaponDef() : nullptr);
		if (found) {
			const int cover = CountInterceptorCover(interceptors, targetPos);
			if (coverLogPos.SqDistance2D(targetPos) > SQUARE(1.f)) {  // once per new aim point
			coverLogPos = targetPos;
			circuit->LOG("NUCLEAR %s(%i): aim (%i,%i) antinukes covering=%i of %zu known, value x%.2f",
					cdef->GetDef()->GetName(), unit->GetId(), int(targetPos.x), int(targetPos.z), cover,
					interceptors.size(), (cover <= 0) ? 1.f : std::max(policy.antinukeFloor, std::pow(coverFactor, float(cover))));
			}
		}
		// nuke rush scouting (team/nuke_recon.as) sends AIR to the latest aim
		if (found) circuit->GetMilitaryManager()->SetNuclearAim(targetPos, cdef->GetAoe());
		return found;
	};
	strategic::Overnuke& over = circuit->GetMilitaryManager()->GetOvernuke();
	const int silos = CountNukeSilos();
	if ((policy.overnukeSilos > 0) && (silos >= policy.overnukeSilos)) {
		coverFactor = policy.antinukeFactorOvernuke;
	}
	if ((policy.overnukeSilos <= 0) || (silos < policy.overnukeSilos)) {
		if (over.Active()) {
			circuit->LOG("NUKE: overnuke ends at %i of %i launches: %i silos left", over.Fired(), over.Goal(), silos);
			over.End(frame, policy.repeatFrames);
		}
		return scan();
	}
	if (over.Active()) {
		const AIFloat3 at(over.Pos().x, 0.f, over.Pos().z);
		bool structure = false;
		const auto* enemies = circuit->GetEnemyManager();
		for (const auto* pool : {&enemies->GetHostileDatas(), &enemies->GetPeaceDatas()}) for (const auto& e : *pool) {
			if (!e.IsFake() && !e.IsDead() && !e.IsDying() && !e.IsIgnore() && (e.cdef != nullptr)
				&& strategic::NuclearTarget(e.cdef->IsMobile(), true, policy.structuresOnly)
				&& (at.SqDistance2D(e.pos) < SQUARE(over.Radius()))) { structure = true; break; }
		}
		// Fire until empty (owner 2026-11-04): the salvo ends once every allied silo in
		// reach holds no missile, however many it fired past the roll.
		int stock = 0;
		if (structure && over.UntilEmpty()) {
			ForEachAllyNukeSilo(circuit, [&](CCircuitAI*, CSuperTask*, CCircuitUnit* silo) {
				if (silo->GetPos(frame).SqDistance2D(at) < SQUARE(silo->GetCircuitDef()->GetMaxRange()))
					stock += std::max(0, silo->GetUnit()->GetStockpile());
			});
		}
		if (!structure) {
			circuit->LOG("NUKE: overnuke at (%.0f, %.0f) ends at %i of %i launches: no target left there",
					at.x, at.z, over.Fired(), over.Goal());
			over.End(frame, policy.repeatFrames);
		} else if (over.UntilEmpty() && (stock <= 0)) {
			circuit->LOG("NUKE: overnuke salvo at (%.0f, %.0f) is empty after %i launches; the next target stocks",
					at.x, at.z, over.Fired());
			over.End(frame, policy.repeatFrames);
			StopNukeSilos();
		} else if (position.SqDistance2D(at) < SQUARE(cdef->GetMaxRange())) {
			if (over.Stocking() && !ReleaseSalvo(frame, scan)) {
				return false;  // hold fire: the salvo is still stocking
			}
			const AIFloat3 aim(over.Pos().x, 0.f, over.Pos().z);  // ReleaseSalvo may have moved it
			SetTarget(nullptr);
			targetPos = aim;
			targetPos.y = circuit->GetMap()->GetElevationAt(aim.x, aim.z);
			return true;
		} else {
			return scan();  // out of this silo's reach: its own target
		}
	}
	if (!scan()) return false;
	// Second breakpoint (owner 2026-10-30): with overnuke_team_silos finished silos across
	// every allied BARb, the roll is overnuke_team_min..max. CountNukeSilos already counts them.
	const int teamSilos = silos;
	const bool teamRoll = (policy.overnukeTeamSilos > 0) && (teamSilos >= policy.overnukeTeamSilos);
	// Third breakpoint (owner 2026-11-04): overnuke_tier3_silos and up roll overnuke_tier3_min..max
	const bool tier3 = (policy.overnukeTier3Silos > 0) && (teamSilos >= policy.overnukeTier3Silos);
	int lo = tier3 ? policy.overnukeTier3Min : teamRoll ? policy.overnukeTeamMin : policy.overnukeMin;
	int hi = tier3 ? policy.overnukeTier3Max : teamRoll ? policy.overnukeTeamMax : policy.overnukeMax;
	const bool firstRoll = over.FirstRoll(lo, hi);  // front nukerush: the team's first salvo (script SetOvernukeFirstRoll)
	const int roll = lo + rand() % (hi - lo + 1);
	circuit->LOG("NUKE: overnuke roll %i..%i (%i silos across the allied AIs%s)", lo, hi, teamSilos,
			firstRoll ? ", the nukerush first salvo" : tier3 ? ", the third breakpoint" : teamRoll ? ", the team breakpoint" : "");
	over.Begin({targetPos.x, targetPos.z}, (policy.repeatRadius > 0.f) ? policy.repeatRadius : cdef->GetAoe(), roll,
			frame, policy.overnukeStock);
	circuit->LOG("NUKE: overnuke with %i silos at (%.0f, %.0f): %i launches%s", silos, targetPos.x, targetPos.z, roll,
			over.Stocking() ? ", stocking the salvo first" : "");
	circuit->GetMilitaryManager()->NoteOvernukeRound();  // our silo began it: we ask AIR (team/nuke_recon.as)
	StopStraySilos("began");  // owner 2026-11-08: no allied silo keeps an older order of its own
	if (over.Stocking() && !ReleaseSalvo(frame, scan)) {
		return false;
	}
	targetPos = AIFloat3(over.Pos().x, 0.f, over.Pos().z);
	targetPos.y = circuit->GetMap()->GetElevationAt(targetPos.x, targetPos.z);
	return true;
}

/*
 * Antinuke cover (owner 2026-11-02). BAR interceptors engage a missile whose
 * target lies inside their weapon coverage, so an aim point is judged by the
 * known enemy units with an interceptor weapon (read from the def, not from a
 * role list, so Legion's Rampart - a geothermal with an antinuke - counts)
 * whose coverage holds it. Enemy stockpiles are unknown: every known
 * interceptor counts as armed. Mobile ones count only while in radar or LOS.
 * Each one multiplies the aim point's metal value by nuclear.antinuke_factor (SNuclearInfo).
 */
std::vector<std::pair<AIFloat3, float>> CSuperTask::KnownInterceptors()
{
	std::vector<std::pair<AIFloat3, float>> out;
	CCircuitAI* circuit = manager->GetCircuit();
	CBattleAnalysis* battle = circuit->GetBattle();
	if (battle == nullptr) return out;
	const float margin = circuit->GetMilitaryManager()->GetNuclearInfo().coveredMargin;
	const auto* enemies = circuit->GetEnemyManager();
	for (const auto* pool : {&enemies->GetHostileDatas(), &enemies->GetPeaceDatas()}) for (const SEnemyData& e : *pool) {
		if (e.IsFake() || e.IsDead() || e.IsDying() || (e.cdef == nullptr)) continue;
		if (e.cdef->IsMobile() && !e.IsInRadarOrLOS()) continue;  // a mobile antinuke's old position says little
		auto it = interceptorCoverage.find(e.cdef);
		if (it == interceptorCoverage.end()) {
			it = interceptorCoverage.emplace(e.cdef, battle->InterceptorCoverage(e.cdef)).first;
		}
		if (it->second > 0.f) out.emplace_back(e.pos, SQUARE(it->second + margin));
	}
	return out;
}

/*
 * Edge aims (owner 2026-11-02): an interceptor engages a missile by where it
 * will land, so a point just outside the coverage still blasts whatever lies
 * within the blast radius inside it. For each target inside a coverage the
 * point on the line from that interceptor through the target, just past its
 * coverage, is an extra aim point; the scan then scores it like any other (its
 * own cover by the other interceptors included), so a two-antinuke area can
 * be hit from the edge where only one covers.
 */
std::vector<AIFloat3> CSuperTask::CoverEdgeAims(const std::vector<std::pair<AIFloat3, float>>& interceptors,
		const std::vector<AIFloat3>& targets)
{
	std::vector<AIFloat3> out;
	for (const auto& ic : interceptors) {
		const float r = std::sqrt(ic.second) + 8.f;  // ic.second: squared coverage incl. margin
		std::vector<AIFloat3> mine;
		for (const AIFloat3& t : targets) {
			const float sq = t.SqDistance2D(ic.first);
			if (sq >= ic.second) continue;
			AIFloat3 dir(t.x - ic.first.x, 0.f, t.z - ic.first.z);
			const float len = std::sqrt(sq);
			if (len < 1.f) continue;  // the interceptor itself: no direction
			const AIFloat3 p(ic.first.x + dir.x / len * r, 0.f, ic.first.z + dir.z / len * r);
			bool dup = false;  // targets in one direction share an edge point
			for (const AIFloat3& q : mine) if (q.SqDistance2D(p) < SQUARE(128.f)) { dup = true; break; }
			if (!dup) mine.push_back(p);
		}
		out.insert(out.end(), mine.begin(), mine.end());
	}
	return out;
}

int CSuperTask::CountInterceptorCover(const std::vector<std::pair<AIFloat3, float>>& interceptors, const AIFloat3& pos)
{
	int count = 0;
	for (const auto& ic : interceptors) if (pos.SqDistance2D(ic.first) < ic.second) ++count;
	return count;
}

/*
 * Nuke outcome (owner 2026-11-06, strategic::StrikeLedger). Once a second per
 * silo: the silo's experience against its pending launches (a handful). A rise
 * means the missile dealt damage: the area is marked struck and its ghosts
 * weigh nuclear.strike_factor until scouted. No rise by the window's end means
 * it was intercepted: an interceptor is presumed there (aim value x
 * antinuke_factor) unless a known one already covers the aim.
 */
void CSuperTask::ResolveStrikes(CCircuitUnit* unit, int frame)
{
	CCircuitAI* circuit = manager->GetCircuit();
	strategic::StrikeLedger& strikes = circuit->GetAllyTeam()->GetNuclearStrikes();
	if (!strikes.HasPending(unit->GetId())) return;
	const auto& policy = circuit->GetMilitaryManager()->GetNuclearInfo();
	const float exp = unit->GetUnit()->GetExperience();
	strikes.Resolve(unit->GetId(), exp, frame, policy.interceptPresumeFrames,
		[&](const strategic::StrikeLedger::Pending& p, strategic::StrikeLedger::Outcome out) {
			const float seconds = float(frame - p.launch) / FRAMES_PER_SEC;
			if (out == strategic::StrikeLedger::Outcome::HIT) {
				circuit->LOG("NUKE: landed from %s(%i) at (%.0f, %.0f) after %.0f s: experience %.5f -> %.5f; ghosts within %.0f x%.2f until scouted",
						unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), p.aim.x, p.aim.z, seconds, p.exp, exp,
						p.radius, policy.strikeFactor);
				return;
			}
			const AIFloat3 at(p.aim.x, 0.f, p.aim.z);
			const int known = CountInterceptorCover(KnownInterceptors(), at);
			if (known > 0) strikes.ClearPresumed(p.aim, 1.f);  // a known interceptor explains it
			circuit->LOG("NUKE: intercepted from %s(%i) at (%.0f, %.0f): no experience in %.0f s (%.5f); known antinukes covering=%i%s",
					unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), p.aim.x, p.aim.z, seconds, exp, known,
					(known > 0 || policy.interceptPresumeRadius <= 0.f) ? "" : ", one presumed there");
		});
}

/*
 * Salvo (owner 2026-10-30). While the overnuke stocks, every silo that reaches
 * the target holds fire. Each of their updates (one per silo every
 * TARGET_DELAY) sums the stock of the reaching silos - a walk over the allied AIs'
 * SUPER tasks, a handful - and opens fire once it reaches the roll (capped by
 * what they can hold), the timeout runs out, or a reaching silo is hit. At the
 * release the scan runs once more: when scouting has found a better aim point
 * since the target was chosen, the whole salvo goes there.
 */
bool CSuperTask::ReleaseSalvo(int frame, const std::function<bool ()>& scan)
{
	CCircuitAI* circuit = manager->GetCircuit();
	CMilitaryManager* militaryMgr = circuit->GetMilitaryManager();
	const auto& policy = militaryMgr->GetNuclearInfo();
	strategic::Overnuke& over = militaryMgr->GetOvernuke();
	const AIFloat3 at(over.Pos().x, 0.f, over.Pos().z);
	int stocked = 0, reaching = 0;
	bool hit = false;
	ForEachAllyNukeSilo(circuit, [&](CCircuitAI*, CSuperTask*, CCircuitUnit* silo) {
		CCircuitDef* sdef = silo->GetCircuitDef();
		if (silo->GetPos(frame).SqDistance2D(at) >= SQUARE(sdef->GetMaxRange())) return;
		++reaching;
		stocked += std::max(0, silo->GetUnit()->GetStockpile());
		if (policy.overnukeFireBelowHealth > 0.f) {
			hit = hit || (silo->GetUnit()->GetHealth() < policy.overnukeFireBelowHealth * silo->GetUnit()->GetMaxHealth());
		}
	});
	const int need = std::min(over.Goal(), policy.overnukeStockCap * std::max(1, reaching));
	const strategic::SalvoGate gate = strategic::SalvoRelease(stocked, need, frame, over.Since(),
			policy.overnukeStockFrames, hit);
	if (gate == strategic::SalvoGate::HOLD) {
		return false;
	}
	const AIFloat3 keep = targetPos;
	if (scan() && (targetPos.SqDistance2D(at) > SQUARE(over.Radius()))) {
		circuit->LOG("NUKE: overnuke salvo moves from (%.0f, %.0f) to (%.0f, %.0f): a better target found since",
				at.x, at.z, targetPos.x, targetPos.z);
		over.Retarget({targetPos.x, targetPos.z});
		StopStraySilos("moved");
	}
	targetPos = keep;
	over.Release(stocked, policy.overnukeFireAll);
	static const char* why[] = {"", "stocked", "timeout", "a silo hit"};
	circuit->LOG("NUKE: overnuke salvo released (%s) after %is: %i stocked in %i silos, %i launches",
			why[int(gate)], (frame - over.Since()) / FRAMES_PER_SEC, stocked, reaching, over.Goal());
	return true;
}

/*
 * The salvo's last launch: stop every silo still holding the attack order, so
 * none fires again at the finished target before its next update.
 */
void CSuperTask::StopNukeSilos()
{
	ForEachAllyNukeSilo(manager->GetCircuit(), [](CCircuitAI* owner, CSuperTask* st, CCircuitUnit* silo) {
		TRY_UNIT(owner, silo, silo->CmdStop();)
		st->SetTarget(nullptr);
		st->isTargetOverride = false;
		st->state = State::ROAM;
	});
}

/*
 * One target for every silo (owner 2026-11-08). A silo of another allied AI
 * can still hold the attack-ground order its own last update gave - picked
 * while the ally team counted fewer silos (a silo just finished is counted only
 * once its SUPER task exists) - and its update runs only every TARGET_DELAY, so
 * a missile stocked in between flew at that old target (headless: an armsilo
 * fired 5148 elmos off the overnuke 8 s after a corsilo began it). When an
 * overnuke begins or moves, every other allied silo aiming outside it stops and
 * re-selects on its next update, which joins the overnuke.
 */
void CSuperTask::StopStraySilos(const char* why)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const strategic::Overnuke& over = circuit->GetMilitaryManager()->GetOvernuke();
	if (!over.Active()) return;
	ForEachAllyNukeSilo(circuit, [&](CCircuitAI* owner, CSuperTask* st, CCircuitUnit* silo) {
		if ((st == this) || st->debugEngaged || (st->state != State::ENGAGE)) return;
		const AIFloat3 aim = st->GetAimPos();
		if (over.Covers({aim.x, aim.z})) return;
		TRY_UNIT(owner, silo, silo->CmdStop();)
		st->SetTarget(nullptr);
		st->isTargetOverride = false;
		st->state = State::ROAM;
		st->targetFrame = 0;  // re-select on its next update, not TARGET_DELAY later
		circuit->LOG("NUKE: overnuke %s at (%.0f, %.0f): %s(%i) of team %i stops its own aim (%.0f, %.0f)",
				why, over.Pos().x, over.Pos().z, silo->GetCircuitDef()->GetDef()->GetName(), silo->GetId(),
				owner->GetTeamId(), aim.x, aim.z);
	});
}

bool CSuperTask::SelectFogTarget(CCircuitUnit* unit, CCircuitDef* cdef)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const auto& policy = circuit->GetMilitaryManager()->GetPulseInfo();
	if (!policy.scatter) return false;
	const auto* map = circuit->GetMapManager();
	AIFloat3 best(-1.f, 0.f, -1.f);
	float bestScore = -1.f;
	const float width = CTerrainManager::GetTerrainWidth(), height = CTerrainManager::GetTerrainHeight();
	const float step = std::max(policy.scatterStep, std::sqrt(width * height / 4096.f));
	const auto& enemy = circuit->GetEnemyManager()->GetEnemyPos(); // known-contact aggregate, never hidden units
	for (float z = step / 2; z < height; z += step) for (float x = step / 2; x < width; x += step) {
		const AIFloat3 edge(x, 0.f, z);
		if (!map->IsInLOS(edge)) continue;
		for (int k = 0; k < 8; ++k) {
			const float angle = float(k) * float(M_PI) / 4.f;
			const AIFloat3 boundaryPos(x + std::cos(angle) * step, 0.f, z + std::sin(angle) * step);
			AIFloat3 p(x + std::cos(angle) * (step + policy.scatterDepth), 0.f, z + std::sin(angle) * (step + policy.scatterDepth));
			if (boundaryPos.x < 0 || boundaryPos.z < 0 || boundaryPos.x >= width || boundaryPos.z >= height || !CanAimStrategic(unit, p)
				|| map->IsInLOS(boundaryPos) || map->IsInLOS(p) || position.SqDistance2D(p) >= SQUARE(cdef->GetMaxRange())) continue;
			if (p.SqDistance2D(enemy) >= edge.SqDistance2D(enemy)) continue; // enemy-facing fog, not the back of our base
			// Stable rotation prevents repeatedly favoring the same equal-valued edge.
			const unsigned hash = unsigned(x) * 73856093u ^ unsigned(z) * 19349663u ^ unsigned(unit->GetId()) ^ unsigned(lastStrategicLaunch);
			const float score = 1.f / (1.f + std::sqrt(p.SqDistance2D(enemy)) / step)
				+ circuit->GetInflMap()->GetEnemyInflAt(p) + float(hash % 1000) * 0.0001f;
			if (score > bestScore) { best = p; bestScore = score; }
		}
	}
	if (best.x < 0.f) return false;
	SetTarget(nullptr); targetPos = best;
	targetPos.y = circuit->GetMap()->GetElevationAt(best.x, best.z);
	circuit->LOG("PULSE %s(%i): fog scatter at (%i,%i)", cdef->GetDef()->GetName(), unit->GetId(), int(best.x), int(best.z));
	return true;
}

/*
 * Fallback when no jammer or radar is known: find the hole one is making.
 *
 * A jammer sits inside its own radardistancejam bubble (360-760 in BAR) and
 * hides itself along with everything near it, so it is a *known* target only
 * where we have LOS - which in practice means a unit is already standing next
 * to it. The useful evidence is therefore negative: ground that we cover with
 * radar, cannot see, believe the enemy holds, and read no contacts from.
 *
 * Probes are seeded from known enemy contacts and thrown outward one jam
 * radius, so the search follows the front and the recently contested ground
 * rather than sweeping the map. Each probe must satisfy:
 *
 *   in our radar coverage  - otherwise "no contact" only means "not looking"
 *   not in our LOS         - with eyes on it we would see the units directly
 *   enemy influence        - the enemy operates here; empty rear ground is not
 *                            evidence of anything
 *   no contact within holeRadius - the hole itself
 *
 * The pulse AoE (1400) is wider than the widest jam radius, so aiming at the
 * hole tends to catch whatever made it. Each shot that removes a jammer turns
 * its pocket into contacts, which moves the next hole further along the line:
 * the weapon walks the front instead of stalling on it.
 */
bool CSuperTask::SelectSuspectedJammer(CCircuitUnit* unit, CCircuitDef* cdef)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const CMilitaryManager::SPulseInfo& pulse = circuit->GetMilitaryManager()->GetPulseInfo();
	if (!pulse.suspectJammer) {
		return false;
	}
	CMapManager* mapMgr = circuit->GetMapManager();
	CInfluenceMap* inflMap = circuit->GetInflMap();
	const float maxSqRange = SQUARE(cdef->GetMaxRange());
	const float sqHole = SQUARE(pulse.holeRadius);

	const std::vector<SEnemyData>& enemies = circuit->GetEnemyManager()->GetHostileDatas();
	AIFloat3 bestPos(-1.f, 0.f, 0.f);
	float bestScore = 0.f;
	int probed = 0, rejRadar = 0, rejLos = 0, rejInfl = 0, rejOccupied = 0;

	for (const SEnemyData& seed : enemies) {
		if (seed.IsFake() || seed.IsDead() || seed.IsDying()) {
			continue;
		}
		for (int i = 0; i < pulse.holeProbes; ++i) {
			const float angle = (2.f * float(M_PI) * float(i)) / float(pulse.holeProbes);
			AIFloat3 probe(seed.pos.x + std::cos(angle) * pulse.holeProbeRadius, 0.f,
					seed.pos.z + std::sin(angle) * pulse.holeProbeRadius);
			CTerrainManager::CorrectPosition(probe);
			probe.y = circuit->GetMap()->GetElevationAt(probe.x, probe.z);
			if (!CanAimStrategic(unit, probe)) continue;
			if (position.SqDistance2D(probe) >= maxSqRange) {
				continue;
			}
			++probed;

			if (!mapMgr->IsInRadar(probe)) {
				++rejRadar;  // not looking there: silence means nothing
				continue;
			}
			if (mapMgr->IsInLOS(probe)) {
				++rejLos;    // we can see it; absence of contacts is real
				continue;
			}
			const float infl = inflMap->GetEnemyInflAt(probe);
			if (infl < pulse.holeMinEnemyInfl) {
				++rejInfl;   // empty rear ground, not a front
				continue;
			}
			// The hole: nothing known inside a jam radius of the probe.
			bool occupied = false;
			for (const SEnemyData& other : enemies) {
				if (other.IsFake() || other.IsDead() || other.IsDying()) {
					continue;
				}
				if (probe.SqDistance2D(other.pos) < sqHole) {
					occupied = true;
					break;
				}
			}
			if (occupied) {
				++rejOccupied;
				continue;
			}
			// Rank by how strongly we believe the enemy is here.
			if (bestScore < infl) {
				bestScore = infl;
				bestPos = probe;
			}
		}
	}

	if (bestScore <= 0.f) {
		if ((circuit->GetLastFrame() / TARGET_DELAY) % 6 == 0) {
			circuit->LOG("PULSE %s(%i): no suspected jammer | probes=%i rejRadar=%i rejLos=%i rejInfl=%i rejOccupied=%i",
					cdef->GetDef()->GetName(), unit->GetId(), probed, rejRadar, rejLos, rejInfl, rejOccupied);
		}
		return false;
	}

	SetTarget(nullptr);
	const bool isMoved = (targetPos.SqDistance2D(bestPos) > SQUARE(1.f));
	targetPos = bestPos;
	targetPos.y = circuit->GetMap()->GetElevationAt(targetPos.x, targetPos.z);
	if (isMoved) {
		circuit->LOG("PULSE %s(%i): suspected jammer, radar hole at (%i,%i) enemyInfl=%.3f (probes=%i)",
				cdef->GetDef()->GetName(), unit->GetId(),
				int(targetPos.x), int(targetPos.z), bestScore, probed);
	}
	return true;
}

/*
 * EMP weapons deal no health damage. A shot is worth firing only if it lands a
 * stun, and whether it does is arithmetic, not a property of the target's cost:
 *
 *   effective = paralyzeDamage * paralyzemultiplier * salvo
 *   stunned   iff effective > maxHealth
 *   seconds   = declineRate * (min(effective / maxHealth, cap) - 1)
 *   cap       = 1 + paralyzeTime / declineRate
 *
 * (Recoil CUnit::DoDamage with modrules.paralyze.paralyzeOnMaxHealth.) So a
 * Titan at 69 000 health shrugs off one 50 000 shot despite multiplier 1.0,
 * while every strategic structure in the game is a full-length stun - and
 * unit_paralyze_damage_limit.lua caps mobiles at 20 s but not buildings, which
 * is why structures rank first. Anti-nuke is the one class ranked above raw
 * value: stunning it is what lets a nuke through, and the EMP missile itself
 * carries no `targetable`, so the anti-nuke cannot intercept it. Static shield
 * generators come next (owner, 2026-10-20), then large structures, then the rest.
 */
bool CSuperTask::SelectEmpTarget(CCircuitUnit* unit, CCircuitDef* cdef)
{
	CMilitaryManager* militaryMgr = manager->GetCircuit()->GetMilitaryManager();
	const CMilitaryManager::SEmpInfo& emp = militaryMgr->GetEmpInfo();
	const CWeaponDef* wd = cdef->GetWeaponDef();
	if ((wd == nullptr) || !wd->IsParalyzer()) {
		return false;
	}
	const float shot = wd->GetParalyzeDamage() * float(militaryMgr->GetEmpSalvoSize());
	const float decline = 1.f / emp.declineRate;
	const float cap = 1.f + wd->GetParalyzeTime() * decline;
	const CMilitaryManager::SLauncherPrioInfo& lp = militaryMgr->GetLauncherPrioInfo();
	const bool prio = lp.isEnabled && (lp.defs.count(cdef->GetId()) > 0);
	const int shift = prio ? LAUNCHER_PRIO_RANKS : 0;

	return SelectAreaTarget(unit, cdef, "EMP", SQUARE(cdef->GetAoe()),
			emp.minTargets, emp.mobileMaxAge,
			[this, &emp, shot, decline, cap, prio, shift, cdef](const SEnemyData& e, CCircuitDef* edef, int& rank, float& value) {
		// BAR's EMPABLE is SURFACE and paralyzemultiplier != 0, so one bit rejects
		// aircraft, submerged units and every immune def at once.
		if ((edef->GetCategory() & emp.empableFlag) == 0) {
			return false;
		}
		const float health = edef->GetHealth();
		const float effective = shot * edef->GetParalyzeMult();
		if ((health <= 0.f) || (effective <= health)) {
			return false;  // cannot be stunned by the shots we can land
		}
		const float stun = (std::min(effective / health, cap) - 1.f) / decline;
		if (stun < emp.minStunSeconds) {
			return false;  // too brief to be worth the shot
		}
		value = e.cost;
		// Launcher priority (owner 2026-11-03): a target the shot can hold
		// (checked above) of the priority ranks; commanders never (paralyzer).
		const int pr = prio ? LauncherPriorityRank(e, edef, cdef) : -1;
		if (pr >= 0) {
			rank = pr;
			return true;
		}
		const bool isMobile = edef->IsMobile();
		if (!isMobile && edef->IsRespRoleAny(emp.antiNukeRole)) {
			rank = 0;
		} else if (!isMobile && emp.shieldsSecond && (edef->GetMaxShield() > 0.f)) {
			// A static plasma deflector (Armada/Cortex gate and floating gate,
			// Legion deflector and T3 shield): stunned, it drops its bubble and
			// the porc and artillery it covers are open to everything else.
			rank = 1;
		} else if (!isMobile && (!emp.structuresFirst || e.cost >= emp.structuresFirstMinCost)) {
			rank = 2;  // a large structure: LRPC, bastion, silo, AFUS, gantry
		} else {
			// Everything else - cheap structures and every mobile - by cost.
			// A target that cannot be stunned was already rejected above, so
			// "highest metal cost except EMP-immune" is what this rank is.
			rank = 3;
		}
		rank += shift;
		// Value is metal: it floats Ragnarok, AFUS, gantry and silo above a cheap
		// turret without any of them needing to be tagged.
		return true;
	// Unarmed enemies (anti-nuke, shields, AFUS, gantries) live in the peace
	// pool, not the hostile one: without allEnemies the silo never saw any of
	// the structures its ranking is for and only ever shot armed units.
	}, 0.f, false, true, false, false, nullptr, nullptr, nullptr, shift);
}

bool CSuperTask::IsNukeSilo(CCircuitDef* cdef)
{
	const std::string name = cdef->GetDef()->GetName();
	return (name == "armsilo") || (name == "corsilo") || (name == "legsilo");
}

bool CSuperTask::IsLolCannon(CCircuitDef* cdef)
{
	const std::string name = cdef->GetDef()->GetName();
	return (name == "armvulc") || (name == "corbuzz") || (name == "legstarfall");
}

AIFloat3 CSuperTask::GetAimPos() const
{
	if (!isTargetOverride && (GetTarget() != nullptr)) {
		return GetTarget()->GetPos();
	}
	return targetPos;
}

void CSuperTask::OnLaunch(CCircuitUnit* unit, const char* how)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	CCircuitDef* d = unit->GetCircuitDef();
	if (syncOrderFrame >= 0) {
		// same-impact volley: learn the def's real order-to-launch delay
		CMilitaryManager* militaryMgr = circuit->GetMilitaryManager();
		const int actual = frame - syncOrderFrame;
		circuit->LOG("SYNC %s(%i): launched %i frames after the order (predicted %.0f)",
				d->GetDef()->GetName(), unit->GetId(), actual, syncPredDelay);
		if (syncPredDelay >= 0.f) militaryMgr->NoteSyncDelay(d->GetId(), float(actual) - syncPredDelay);
		syncOrderFrame = -1;
		if ((syncAnchorVolley >= 0) && (frame <= syncAnchorUntil)) {
			militaryMgr->SyncAnchorLaunched(syncAnchorVolley, frame + syncAnchorFlight);
		}
		syncAnchorVolley = -1;
	}
	CountTierShot(unit, frame);
	const bool nuke = IsNukeSilo(d), pulse = IsPulse(d);
	if (!nuke && !pulse) return;
	if (frame - lastStrategicLaunch <= SMILEY_DEDUPE_EVENT) return;
	if (nuke && debugEngaged) {
		// Debug strike: no nuclear history, no overnuke count, and the
		// attack-ground order stays, so every stocked missile goes there too
		lastStrategicLaunch = frame;
		debug::Strike& s = circuit->GetMilitaryManager()->GetDebugStrike(debug::NUKE);
		++s.launches;
		const AIFloat3 at = GetAimPos();
		circuit->LOG("DEBUG: nuke launch %i from %s(%i) at (%.0f, %.0f) (%s)", s.launches,
				d->GetDef()->GetName(), unit->GetId(), at.x, at.z, how);
		if (geom::is_valid(at) && (frame - lastSmileyFrame > SMILEY_DEDUPE_EVENT)) {
			lastSmileyFrame = frame;
			circuit->DrawSmiley(at, SMILEY_RADIUS);
		}
		return;
	}
	const AIFloat3 aim = GetAimPos();
	if (!CanAimStrategic(unit, aim)) circuit->LOG("[INVARIANT] INV-095 strategic launch violates target-area exclusion: unit=%i", unit->GetId());
	lastStrategicLaunch = frame;
	if (nuke) {
		if (geom::is_valid(aim)) circuit->GetMilitaryManager()->NoteNuclearLaunch(aim, d->GetAoe());
		const auto& policy = circuit->GetMilitaryManager()->GetNuclearInfo();
		circuit->GetAllyTeam()->GetNuclearHistory().Add(unit->GetId(), {aim.x, aim.z},
			policy.repeatRadius > 0.f ? policy.repeatRadius : d->GetAoe(), frame, policy.repeatFrames, false);
		if (geom::is_valid(aim)) {
			// Nuke outcome (owner 2026-11-06): pending until the silo's experience rises or the window closes
			const float exp = unit->GetUnit()->GetExperience();
			const float reach = std::max(d->GetAoe(), (aim.SqDistance2D(targetPos) < SQUARE(1.f)) ? areaReach : 0.f);
			circuit->GetAllyTeam()->GetNuclearStrikes().Launch(unit->GetId(), {aim.x, aim.z}, reach, frame,
					policy.strikeWindowFrames, exp);
			circuit->LOG("NUKE: outcome pending %s(%i) at (%.0f, %.0f) reach=%.0f experience=%.5f",
					d->GetDef()->GetName(), unit->GetId(), aim.x, aim.z, reach, exp);
		}
		strategic::Overnuke& over = circuit->GetMilitaryManager()->GetOvernuke();
		const int scouts = over.Scouts();
		const bool salvo = over.Salvo();
		if (over.Count({aim.x, aim.z}, frame, policy.repeatFrames, policy.overnukeScoutEvery)) {
			if (over.Scouts() > scouts) circuit->GetMilitaryManager()->NoteOvernukeScout();  // our launch: we ask AIR
			circuit->LOG("NUKE: overnuke launch %i of %i from %s(%i)%s", over.Fired(), over.Goal(),
					d->GetDef()->GetName(), unit->GetId(), (over.Scouts() > scouts) ? ": scouts asked" : "");
			if (salvo && over.Active()) {
				// Mid-salvo: the attack-ground order ends with the shot, so the
				// next update re-aims the moment the reload (30 s, less with
				// veterancy: the engine's reload frame already has it) is over,
				// not at the next 10 s tick (played: 39 s between volleys).
				int ready = -1;
				for (int w = 0; w < 4; ++w) {  // silos mount 1-2 weapons; a missing index reads -1
					ready = std::max(ready, circuit->GetUnitAPI()->GetVisibleWeaponReload(unit->GetId(), w));
				}
				if (ready <= frame) ready = frame + d->GetReloadTime();
				targetFrame = ready - TARGET_DELAY + 1;
				if (frame - lastSmileyFrame > SMILEY_DEDUPE_EVENT) {
					lastSmileyFrame = frame;
					circuit->DrawSmiley(aim, SMILEY_RADIUS);
				}
				return;
			}
			if (salvo) {
				StopNukeSilos();  // the last one: no silo fires again at the finished target
			}
		}
	} else {
		const auto& policy = circuit->GetMilitaryManager()->GetPulseInfo();
		circuit->GetAllyTeam()->GetPulseClaims().Add(unit->GetId(), {aim.x, aim.z}, d->GetAoe(), frame, policy.coverageFrames, false);
		if (probeAim && (policy.probeRepeatFrames > 0)) {
			circuit->GetAllyTeam()->GetProbeHistory().Add(-1, {aim.x, aim.z}, policy.probeRadius, frame, policy.probeRepeatFrames, false);
		}
		circuit->LOG("PULSE: launched from %s(%i) at (%.0f, %.0f) (%s)%s", d->GetDef()->GetName(), unit->GetId(), aim.x, aim.z, how,
				probeAim ? " probe" : "");
		probeAim = false;
	}
	// Attack-ground persists after launch; stop it before another stocked shot
	// can fire without passing the updated ledger. Keep the aim for event users.
	TRY_UNIT(circuit, unit, unit->CmdStop();)
	SetTarget(nullptr); targetPos = aim; isTargetOverride = false; state = State::ROAM;
	if (!nuke) return;
	if (frame - lastSmileyFrame <= SMILEY_DEDUPE_EVENT) {
		return;  // one smiley a launch
	}
	const AIFloat3 at = GetAimPos();
	if (!geom::is_valid(at)) {
		circuit->LOG("NUKE: launched from %s(%i) (%s) with no aim known: no smiley (D-124)", unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), how);
		return;
	}
	lastSmileyFrame = frame;
	circuit->LOG("NUKE: launched from %s(%i) at (%.0f, %.0f) (%s): a smiley on the target (D-124)",
			unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), at.x, at.z, how);
	circuit->DrawSmiley(at, SMILEY_RADIUS);
}

void CSuperTask::SetTargetTier(const CCircuitDef* edef, int tier)
{
	if (edef == nullptr) return;
	if (tier > 0) tierByDef[edef->GetId()] = tier;
	else tierByDef.erase(edef->GetId());
}

/*
 * Tiered fire (lolcannons, owner 2026-10-26). One pass over the enemy datas
 * (hostile and peaceful: an advanced fusion is unarmed) every
 * tierRetargetFrames, at once when the target under fire is gone: O(enemies)
 * with one hash lookup each, per lolcannon, so a few hundred lookups every two
 * seconds for the one or two an AI owns. Mobile roster units count only while
 * in radar or LOS; structures also at their remembered position. Orders: one
 * attack on a new target, else one every 30 s before the 60 s order timeout,
 * or when a target seen only as ground comes into sight. No roster unit in
 * range: one stop, then nothing, and the script's hold fire keeps the engine
 * from spending the gun on spam.
 */
void CSuperTask::UpdateTiered(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	if ((tierTargetId >= 0) && (circuit->GetEnemyInfo(tierTargetId) == nullptr)) {
		targetFrame = frame - tierRetargetFrames;  // the target is gone: the next one now
	}
	if ((tierAreaMax > 1) && (tierDwellShots <= 0) && !tierAreas.empty()
		&& (frame - tierRotation.since >= tierDwellFrames))
	{
		targetFrame = frame - tierRetargetFrames;  // the dwell is up: the next area now
	}
	if (targetFrame + tierRetargetFrames > frame) {
		return;
	}
	targetFrame = frame;

	const bool byArea = (tierAreaMax > 1);
	std::vector<tier::Candidate> candidates;
	std::vector<const SEnemyData*> candidateDatas;
	CCircuitDef* cdef = unit->GetCircuitDef();
	const float maxSqRange = SQUARE(cdef->GetMaxRange());
	if (WatchBlasts(unit, maxSqRange)) {
		tierRotation.topId = -1;  // a new likely kill: the rotation restarts at the top (TopChanged)
	}
	const int canTargetCat = cdef->GetTargetCategory();
	tier::Candidate best{-1, 0, 0.f, 0.f};
	const SEnemyData* bestData = nullptr;
	const auto* enemies = circuit->GetEnemyManager();
	for (const auto* pool : {&enemies->GetHostileDatas(), &enemies->GetPeaceDatas()}) {
		for (const SEnemyData& e : *pool) {
			if (e.IsFake() || e.IsDead() || e.IsDying() || e.IsIgnore() || (e.cdef == nullptr)) {
				continue;
			}
			const auto it = tierByDef.find(e.cdef->GetId());
			if (it == tierByDef.end()) {
				continue;
			}
			const bool likelyKilled = !tierLikelyKilled.empty() && (tierLikelyKilled.count(e.id) > 0);
			const int tierOf = it->second + (likelyKilled ? std::max(0, tierBlastPenalty) : 0);
			if (!byArea && (bestData != nullptr) && (tierOf > best.tier)) {
				continue;
			}
			if (((canTargetCat & e.cdef->GetCategory()) == 0) || (e.cdef->IsMobile() && !e.IsInRadarOrLOS())) {
				continue;
			}
			const float sqDist = position.SqDistance2D(e.pos);
			if (sqDist >= maxSqRange) {
				continue;
			}
			tier::Candidate c{e.id, it->second, e.cost, sqDist, e.pos.x, e.pos.z};
			if (likelyKilled) {
				c = tier::Downranked(c, tierBlastPenalty);
			}
			if (byArea) {
				candidates.push_back(c);
				candidateDatas.push_back(&e);
				continue;
			}
			if (tier::Better(c, (bestData == nullptr) ? nullptr : &best, tierTargetId)) {
				best = c;
				bestData = &e;
			}
		}
	}
	if (byArea) {
		const int pick = PickTierArea(unit, candidates);
		if (pick >= 0) {
			best = candidates[pick];
			bestData = candidateDatas[pick];
		}
	}

	if (bestData == nullptr) {
		if ((tierTargetId >= 0) || (State::ENGAGE == state)) {
			TRY_UNIT(circuit, unit,
				unit->CmdStop();
			)
			circuit->LOG("TIER: team=%i %s(%i): no roster target in range (%.0f); holding fire",
					circuit->GetTeamId(), cdef->GetDef()->GetName(), unit->GetId(), cdef->GetMaxRange());
		}
		tierTargetId = -1;
		SetTarget(nullptr);
		state = State::ROAM;
		return;
	}

	CEnemyInfo* info = circuit->GetEnemyInfo(bestData->id);
	const bool onUnit = (info != nullptr) && info->IsInRadarOrLOS() && !circuit->IsCheating();
	const bool isNew = (bestData->id != tierTargetId);
	if (!isNew && (State::ENGAGE == state) && (onUnit == tierOrderOnUnit)
		&& (frame - tierOrderFrame < FRAMES_PER_SEC * 30))
	{
		return;  // still on it
	}
	if (isNew) {
		circuit->LOG("TIER: team=%i frame=%i %s(%i): tier %i %s(%i) cost=%.0f at (%i,%i), %.0f away%s",
				circuit->GetTeamId(), frame, cdef->GetDef()->GetName(), unit->GetId(), best.tier, bestData->cdef->GetDef()->GetName(), bestData->id,
				bestData->cost, int(bestData->pos.x), int(bestData->pos.z), std::sqrt(best.sqDist), onUnit ? "" : " (last seen)");
	}
	tierTargetId = bestData->id;
	isTargetOverride = false;
	SetTarget(info);
	targetPos = bestData->pos;
	targetPos.y = circuit->GetMap()->GetElevationAt(targetPos.x, targetPos.z);
	ExecuteAttack(unit);
	tierOrderFrame = frame;
	tierOrderOnUnit = onUnit;
}

void CSuperTask::SetTierRotation(int areas, int dwellFrames, int dwellShots, float radius)
{
	tierAreaMax = std::max(1, areas);
	tierDwellFrames = std::max(1, dwellFrames);
	tierDwellShots = std::max(0, dwellShots);
	tierAreaRadius = std::max(1.f, radius);
	tier::Restart(tierRotation, manager->GetCircuit()->GetLastFrame());
}

void CSuperTask::SetTierBlastWatch(float minRadius, float drop, int minPoints, int penalty)
{
	tierBlastMinRadius = minRadius;
	tierBlastDrop = std::max(0.1f, drop);
	tierBlastPoints = std::clamp(minPoints, 1, tier::BLAST_RING_POINTS);
	tierBlastPenalty = std::max(0, penalty);
	if (tierBlastMinRadius <= 0.f) {
		tierRings.clear();
		tierLikelyKilled.clear();
	}
}

void CSuperTask::SampleRing(SGroundRing& r) const
{
	CMap* map = manager->GetCircuit()->GetMap();
	constexpr float STEP = 2.f * 3.14159265f / float(tier::BLAST_RING_POINTS);
	for (int i = 0; i < tier::BLAST_RING_POINTS; ++i) {
		const float a = STEP * float(i);
		r.h[i] = map->GetElevationAt(r.x + std::cos(a) * r.radius, r.z + std::sin(a) * r.radius);
	}
	r.frame = manager->GetCircuit()->GetLastFrame();
}

/*
 * Likely killed (owner 2026-11-12; TierTargeting.h). Run before each roster
 * scan. Roster structures with a big death blast within range + 800: in radar
 * or LOS the ring round each is read (at most every 10 s) and any mark is
 * cleared; out of sight the ring is read again, and a sunk ring marks the
 * structure, plus every roster structure out of sight that its death blast
 * (DeathBlastOf, AreaDamage) would kill. O(roster structures in reach); 8
 * height reads per ring.
 */
bool CSuperTask::WatchBlasts(CCircuitUnit* unit, float maxSqRange)
{
	if (tierBlastMinRadius <= 0.f) {
		return false;
	}
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	const char* gunName = unit->GetCircuitDef()->GetDef()->GetName();
	struct SBlast { AIFloat3 pos; SDeathBlast b; int id; };
	std::vector<SBlast> blasts;
	// A watched structure that left the roster (its wreck seen, or the engine
	// told us) over a sunk ring died in its own blast: whatever that blast
	// killed out of sight stays an image unless it is marked (headless
	// 2026-11-12: the advanced fusion's image went, the fusion and LLT beside
	// it stayed). A ring that did not sink (reclaimed, say) marks nothing.
	for (auto it = tierRings.begin(); it != tierRings.end();) {
		if (circuit->GetEnemyInfo(it->first) != nullptr) {
			++it;
			continue;
		}
		SGroundRing now = it->second;
		SampleRing(now);
		const int sunk = tier::SunkPoints(it->second.h, now.h, tier::BLAST_RING_POINTS, tierBlastDrop);
		if ((it->second.cdef != nullptr) && (sunk >= tierBlastPoints)) {
			circuit->LOG("TIER: team=%i frame=%i %s(%i): %s(%i) at (%i,%i) gone from the roster over its own crater (%i of %i ground points %.0f round it sank %.1f+ elmos): its death blast marks what it killed out of sight",
					circuit->GetTeamId(), frame, gunName, unit->GetId(), it->second.cdef->GetDef()->GetName(), it->first,
					int(it->second.x), int(it->second.z), sunk, tier::BLAST_RING_POINTS, it->second.radius, tierBlastDrop);
			blasts.push_back({AIFloat3(it->second.x, 0.f, it->second.z), DeathBlastOf(it->second.cdef), it->first});
		}
		it = tierRings.erase(it);
	}
	for (auto it = tierLikelyKilled.begin(); it != tierLikelyKilled.end();) {
		if (circuit->GetEnemyInfo(it->first) == nullptr) it = tierLikelyKilled.erase(it); else ++it;
	}
	const float reach = std::sqrt(maxSqRange) + 800.f;
	const float sqReach = reach * reach;
	const auto* enemies = circuit->GetEnemyManager();
	auto onRoster = [this, &sqReach](const SEnemyData& e) {
		return !(e.IsFake() || e.IsDead() || e.IsDying() || e.IsIgnore() || (e.cdef == nullptr) || e.cdef->IsMobile())
			&& (tierByDef.find(e.cdef->GetId()) != tierByDef.end())
			&& (position.SqDistance2D(e.pos) < sqReach);
	};
	for (const auto* pool : {&enemies->GetHostileDatas(), &enemies->GetPeaceDatas()}) {
		for (const SEnemyData& e : *pool) {
			if (!onRoster(e)) {
				continue;
			}
			if (e.IsInRadarOrLOS()) {
				const auto mit = tierLikelyKilled.find(e.id);
				if (mit != tierLikelyKilled.end()) {
					circuit->LOG("TIER: team=%i frame=%i %s(%i): %s(%i) at (%i,%i) seen again %i s after it was marked likely killed; back on its tier",
							circuit->GetTeamId(), frame, gunName, unit->GetId(), e.cdef->GetDef()->GetName(), e.id,
							int(e.pos.x), int(e.pos.z), (frame - mit->second) / FRAMES_PER_SEC);
					tierLikelyKilled.erase(mit);
				}
				auto rr = tierRingRadius.find(e.cdef);
				if (rr == tierRingRadius.end()) {
					const SDeathBlast b = DeathBlastOf(e.cdef);
					float ring = 0.f;
					if ((b.damage > 0.f) && (b.radius >= tierBlastMinRadius)) {
						UnitDef* ud = e.cdef->GetDef();
						const float hx = ud->GetXSize() * SQUARE_SIZE * 0.5f, hz = ud->GetZSize() * SQUARE_SIZE * 0.5f;
						ring = tier::BlastRingRadius(b.radius, std::sqrt(hx * hx + hz * hz));
					}
					rr = tierRingRadius.emplace(e.cdef, ring).first;
				}
				if (rr->second <= 0.f) {
					continue;
				}
				SGroundRing& r = tierRings[e.id];
				if ((r.frame >= 0) && (frame - r.frame < FRAMES_PER_SEC * 10) && (r.x == e.pos.x) && (r.z == e.pos.z)) {
					continue;
				}
				r.x = e.pos.x;
				r.z = e.pos.z;
				r.radius = rr->second;
				r.cdef = e.cdef;
				r.sunk = 0;
				SampleRing(r);
				continue;
			}
			if (tierLikelyKilled.count(e.id) > 0) {
				continue;
			}
			const auto rit = tierRings.find(e.id);
			if (rit == tierRings.end()) {
				continue;
			}
			SGroundRing now = rit->second;
			SampleRing(now);
			const int sunk = tier::SunkPoints(rit->second.h, now.h, tier::BLAST_RING_POINTS, tierBlastDrop);
			if (sunk < tierBlastPoints) {
				if (sunk != rit->second.sunk) {  // a partial sink, logged when it changes (shells, a far blast)
					rit->second.sunk = sunk;
					circuit->LOG("TIER: team=%i frame=%i %s(%i): %s(%i) at (%i,%i) out of sight: %i of %i ground points sank %.1f+ elmos (%i needed)",
							circuit->GetTeamId(), frame, gunName, unit->GetId(), e.cdef->GetDef()->GetName(), e.id, int(e.pos.x), int(e.pos.z),
							sunk, tier::BLAST_RING_POINTS, tierBlastDrop, tierBlastPoints);
				}
				continue;
			}
			float deepest = 0.f;
			for (int i = 0; i < tier::BLAST_RING_POINTS; ++i) deepest = std::max(deepest, rit->second.h[i] - now.h[i]);
			circuit->LOG("TIER: team=%i frame=%i %s(%i): %s(%i) at (%i,%i) likely killed: %i of %i ground points %.0f round it sank %.1f+ elmos (deepest %.1f) out of sight; down %i tiers until radar or LOS shows it",
					circuit->GetTeamId(), frame, gunName, unit->GetId(), e.cdef->GetDef()->GetName(), e.id, int(e.pos.x), int(e.pos.z),
					sunk, tier::BLAST_RING_POINTS, rit->second.radius, tierBlastDrop, deepest, tierBlastPenalty);
			tierLikelyKilled[e.id] = frame;
			blasts.push_back({e.pos, DeathBlastOf(e.cdef), e.id});
			tierRings.erase(rit);
		}
	}
	if (blasts.empty()) {
		return false;
	}
	// what those blasts would have killed with them
	for (const auto* pool : {&enemies->GetHostileDatas(), &enemies->GetPeaceDatas()}) {
		for (const SEnemyData& e : *pool) {
			if (!onRoster(e) || e.IsInRadarOrLOS() || (tierLikelyKilled.count(e.id) > 0)
				|| (circuit->GetEnemyInfo(e.id) == nullptr))  // the blast's own entry, gone but not yet swept from the pool
			{
				continue;
			}
			const float health = e.cdef->GetHealth();
			for (const SBlast& s : blasts) {
				const float dist = std::sqrt(s.pos.SqDistance2D(e.pos));
				const float dmg = AreaDamage(s.b.damage, s.b.radius, s.b.edge, dist);
				if ((health <= 0.f) || (dmg < health)) {
					continue;
				}
				circuit->LOG("TIER: team=%i frame=%i %s(%i): %s(%i) at (%i,%i) likely killed with it: %.0f from the blast of %i (%.0f away) >= %.0f health",
						circuit->GetTeamId(), frame, gunName, unit->GetId(), e.cdef->GetDef()->GetName(), e.id, int(e.pos.x), int(e.pos.z),
						dmg, s.id, dist, health);
				tierLikelyKilled[e.id] = frame;
				tierRings.erase(e.id);
				break;
			}
		}
	}
	tierBlastPos = blasts.back().pos;
	++tierBlastSerial;
	return true;
}

AIFloat3 CSuperTask::GetTierAreaPos(int i) const
{
	if (!ValidArea(i)) return -RgtVector;
	return AIFloat3(tierAreas[i].x, 0.f, tierAreas[i].z);
}

/*
 * The area rotation (owner 2026-10-27): rank the areas, restart at the top when
 * fresh scouting changed the top one (TopChanged), else move on once the dwell
 * is up. One log line, with the whole ranking, whenever the area changes.
 */
int CSuperTask::PickTierArea(CCircuitUnit* unit, const std::vector<tier::Candidate>& candidates)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	tierAreas = tier::BuildAreas(candidates, tierAreaRadius, tierTargetId, size_t(tierAreaMax));
	if (!tierLikelyKilled.empty()) {
		// Likely killed (owner 2026-11-12): an area seeded by a likely-killed
		// image holds nothing better; while a live area is left the rotation
		// skips it (headless: the gun dwelt 30 s on each dead image in turn).
		const auto dead = [this, &candidates](const tier::Area& a) { return tierLikelyKilled.count(candidates[a.aim].id) > 0; };
		if (!std::all_of(tierAreas.begin(), tierAreas.end(), dead)) {
			tierAreas.erase(std::remove_if(tierAreas.begin(), tierAreas.end(), dead), tierAreas.end());
		}
	}
	tierAreaTargets.clear();
	for (const tier::Area& a : tierAreas) tierAreaTargets.push_back(candidates[a.aim].id);
	tierSeenNow.clear();
	for (const tier::Candidate& c : candidates) tierSeenNow.insert(c.id);
	// "Seen" spans TIER_SEEN_FRAMES (a3: commanders flickering in and out of
	// radar restarted the rotation 19 times in 29): the old top still counts
	// while it lives and was a candidate that recently; only a target new for
	// that long is fresh news.
	constexpr int TIER_SEEN_FRAMES = FRAMES_PER_SEC * 30;
	auto seenLately = [this, frame](int id) {
		const auto it = tierLastSeen.find(id);
		return (it != tierLastSeen.end()) && (frame - it->second <= TIER_SEEN_FRAMES);
	};
	const int oldTop = tierRotation.topId;
	const bool oldTopStill = (tierSeenNow.count(oldTop) > 0)
		|| ((oldTop >= 0) && (circuit->GetEnemyInfo(oldTop) != nullptr) && seenLately(oldTop));
	const int top = tierAreas.empty() ? -1 : tierAreas[0].seedId;
	const bool topSeenBefore = seenLately(top);
	for (const tier::Candidate& c : candidates) tierLastSeen[c.id] = frame;
	for (auto it = tierLastSeen.begin(); it != tierLastSeen.end();) {
		if (frame - it->second > TIER_SEEN_FRAMES) it = tierLastSeen.erase(it); else ++it;
	}
	const int oldIndex = tierRotation.index;
	const char* why = nullptr;
	if (tier::TopChanged(oldTop, top, oldTopStill, topSeenBefore)) {
		tier::Restart(tierRotation, frame);
		why = "the top area changed";
	} else if (tier::Advance(tierRotation, int(tierAreas.size()), frame, tierDwellFrames, tierDwellShots)) {
		why = (tierRotation.index == 0) ? "back to the top" : "next area";
	}
	tierRotation.topId = top;
	if (tierAreas.empty()) {
		return -1;
	}
	if ((why != nullptr) || (oldIndex != tierRotation.index)) {
		std::string ranking;
		for (size_t i = 0; i < tierAreas.size(); ++i) {
			const tier::Area& a = tierAreas[i];
			ranking += std::format("{}#{} t{} {:.0f}m ({},{})", i ? "; " : "", i + 1, a.tier, a.metal, int(a.x), int(a.z));
		}
		circuit->LOG("TIER: team=%i frame=%i %s(%i): area %i of %i (%s): %s",
				circuit->GetTeamId(), frame, unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(),
				tierRotation.index + 1, int(tierAreas.size()), (why != nullptr) ? why : "fewer areas", ranking.c_str());
	}
	return tierAreas[tierRotation.index].aim;
}

void CSuperTask::CountTierShot(CCircuitUnit* unit, int frame)
{
	if (tierByDef.empty() || (tierAreaMax <= 1) || (tierDwellShots <= 0)) return;
	// A salvo raises one event per projectile: shots closer than the main
	// weapon's salvo plus half its reload are one shot. The def's own reload
	// time is its quickest weapon's (b3: the Starfall moved on after 1-7 s).
	if (tierShotGap < 0) {
		float reload = 0.f, salvo = 0.f;
		auto mounts = unit->GetCircuitDef()->GetDef()->GetWeaponMounts();
		for (springai::WeaponMount* mount : mounts) {
			springai::WeaponDef* wd = mount->GetWeaponDef();
			if (wd->GetReload() > reload) {
				reload = wd->GetReload();
				salvo = wd->GetSalvoDelay() * std::max(0, wd->GetSalvoSize() - 1);
			}
			delete wd;
			delete mount;
		}
		tierShotGap = std::max(FRAMES_PER_SEC / 2, int((salvo + reload * 0.5f) * FRAMES_PER_SEC));
		manager->GetCircuit()->LOG("TIER: %s(%i): one shot = fire events within %i frames (reload %.1f s, salvo %.1f s)",
				unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(), tierShotGap, reload, salvo);
	}
	if (frame - tierShotFrame < tierShotGap) return;
	tierShotFrame = frame;
	if (++tierRotation.shots >= tierDwellShots) {
		targetFrame = frame - tierRetargetFrames;  // the next area at the next update
	}
}

/*
 * Debug strikes (owner 2026-10-31, DebugStrike.h). Every silo and cannon reads
 * the strike its manager holds: a new serial is acted on at the next update, a
 * team strike is rescanned every DEBUG_RESCAN_*, and nothing else is read while
 * no strike is on (one int compare per update). Nuke: every silo, set to fire
 * at will, at the position, or at the richest aim point of the team's scouted
 * units (no friendly unit in the blast), until the strike is turned off or the
 * team has nothing scouted left after a launch. Lolcannon: each cannon that
 * reaches the position, or a scouted unit of the team, fires at it; the others
 * keep their tiered fire. Turned off: stop, fire state back, normal targeting.
 */
bool CSuperTask::UpdateDebug(CCircuitUnit* unit)
{
	if (debugKind == -2) {
		CCircuitDef* d = unit->GetCircuitDef();
		debugKind = IsNukeSilo(d) ? debug::NUKE : IsLolCannon(d) ? debug::LOL : -1;
	}
	if (debugKind < 0) {
		return false;
	}
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	debug::Strike& s = circuit->GetMilitaryManager()->GetDebugStrike(debugKind);
	const bool nuke = (debugKind == debug::NUKE);
	if (s.Active() && ((s.serial != debugSerial)
		|| (frame - debugCheckFrame >= (nuke ? DEBUG_RESCAN_NUKE : DEBUG_RESCAN_LOL))))
	{
		debugSerial = s.serial;
		debugCheckFrame = frame;
		DebugScan(unit, s);
	}
	if (!s.Active() || !debugApplies) {
		if (debugEngaged) {
			EndDebug(unit, !s.Active() ? ((s.mode == debug::Mode::DONE) ? "the team has no scouted unit left" : "strike off")
					: (nuke ? "no target" : "out of range"));
		}
		return false;
	}
	if (!debugEngaged) {
		debugEngaged = true;
		debugOrderTargetId = -1;
		if (nuke) {
			TRY_UNIT(circuit, unit, unit->TrySetFireState(CCircuitDef::FireType::OPEN);)
		}
		circuit->LOG("DEBUG: %s(%i) joins the %s strike: %s", unit->GetCircuitDef()->GetDef()->GetName(), unit->GetId(),
				nuke ? "nuke" : "lol", debug::Describe(s, 0).c_str());
	}
	if (!debugHasAim) {
		if (State::ENGAGE == state) {  // a team strike waits for scouting: hold, never a target of our own
			TRY_UNIT(circuit, unit, unit->CmdStop();)
			SetTarget(nullptr);
			state = State::ROAM;
		}
		return true;
	}
	DebugOrder(unit);
	return true;
}

void CSuperTask::DebugScan(CCircuitUnit* unit, debug::Strike& s)
{
	CCircuitAI* circuit = manager->GetCircuit();
	CCircuitDef* cdef = unit->GetCircuitDef();
	const float maxSqRange = SQUARE(cdef->GetMaxRange());
	const bool nuke = (debugKind == debug::NUKE);
	debugApplies = false;
	debugHasAim = false;
	debugTargetId = -1;
	if (s.mode == debug::Mode::POS) {
		const AIFloat3 at(s.x, 0.f, s.z);
		if (position.SqDistance2D(at) >= maxSqRange) {
			return;  // out of reach: this one keeps its normal fire
		}
		debugApplies = debugHasAim = true;
		debugAim = at;
		debugAim.y = circuit->GetMap()->GetElevationAt(at.x, at.z);
		return;
	}

	// Team strike: the team's units the AI has scouted (its enemy datas, team
	// cached at first LOS): structures where last seen, mobiles in radar or LOS
	const int team = s.team;
	auto targetable = [team](const SEnemyData& e) {
		return !e.IsFake() && !e.IsDead() && !e.IsDying() && !e.IsIgnore() && (e.cdef != nullptr) && (e.team == team)
			&& (!e.cdef->IsMobile() || e.IsInRadarOrLOS());
	};
	const auto* enemies = circuit->GetEnemyManager();
	if (nuke) {
		int known = 0;
		for (const auto* pool : {&enemies->GetHostileDatas(), &enemies->GetPeaceDatas()}) {
			for (const SEnemyData& e : *pool) if (targetable(e)) ++known;
		}
		if (debug::TeamDone(s, known)) {
			s.mode = debug::Mode::DONE;
			circuit->LOG("DEBUG: nuke strike on team %i done after %i launches: no scouted unit of it left", team, s.launches);
			return;
		}
		debugApplies = true;  // every silo: hold until there is a target
		if ((known > 0) && SelectAreaTarget(unit, cdef, "DEBUG NUKE", SQUARE(cdef->GetAoe()), 1, 0,
			[&targetable](const SEnemyData& e, CCircuitDef* d, int& rank, float& value) {
				if (!targetable(e)) return false;
				rank = 0; value = e.cost; return true;
			}, 0.f, true, true))
		{
			debugHasAim = true;
			debugAim = targetPos;
		}
		return;
	}

	// lolcannon: the dearest of the team's units in range, then the nearest;
	// the one under fire is kept while it is as dear (tier::Better, one tier)
	const int canTargetCat = cdef->GetTargetCategory();
	tier::Candidate best{-1, 0, 0.f, 0.f};
	const SEnemyData* bestData = nullptr;
	for (const auto* pool : {&enemies->GetHostileDatas(), &enemies->GetPeaceDatas()}) {
		for (const SEnemyData& e : *pool) {
			if (!targetable(e) || ((canTargetCat & e.cdef->GetCategory()) == 0)) continue;
			const float sqDist = position.SqDistance2D(e.pos);
			if (sqDist >= maxSqRange) continue;
			const tier::Candidate c{e.id, 1, e.cost, sqDist, e.pos.x, e.pos.z};
			if (tier::Better(c, (bestData == nullptr) ? nullptr : &best, debugOrderTargetId)) {
				best = c;
				bestData = &e;
			}
		}
	}
	if (bestData == nullptr) {
		return;  // none of the team's units in reach: tiered fire as usual
	}
	debugApplies = debugHasAim = true;
	debugTargetId = bestData->id;
	debugAim = bestData->pos;
	debugAim.y = circuit->GetMap()->GetElevationAt(debugAim.x, debugAim.z);
}

void CSuperTask::DebugOrder(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	CEnemyInfo* info = (debugTargetId >= 0) ? circuit->GetEnemyInfo(debugTargetId) : nullptr;
	const bool onUnit = (info != nullptr) && info->IsInRadarOrLOS() && !circuit->IsCheating();
	const bool moved = (debugTargetId != debugOrderTargetId) || (onUnit != debugOrderOnUnit)
			|| (!onUnit && (debugAim.SqDistance2D(debugOrderAim) > SQUARE(16.f)));
	if (!moved && (State::ENGAGE == state) && (frame - debugOrderFrame < DEBUG_ORDER_RENEW)) {
		return;  // still on it
	}
	CCircuitDef* cdef = unit->GetCircuitDef();
	if (moved) {
		circuit->LOG("DEBUG: %s(%i) fires at %s (%.0f, %.0f)%s", cdef->GetDef()->GetName(), unit->GetId(),
				((info != nullptr) && (info->GetCircuitDef() != nullptr)) ? info->GetCircuitDef()->GetDef()->GetName() : "ground",
				debugAim.x, debugAim.z,
				((info != nullptr) && !onUnit) ? " (last seen)" : "");
	}
	SetTarget(info);
	isTargetOverride = false;
	targetPos = debugAim;
	TRY_UNIT(circuit, unit,
		if (onUnit) {
			unit->GetUnit()->Attack(info->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame + FRAMES_PER_SEC * 60);
		} else {
			unit->CmdAttackGround(debugAim, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame + FRAMES_PER_SEC * 60);
		}
	)
	debugOrderFrame = frame;
	debugOrderAim = debugAim;
	debugOrderTargetId = debugTargetId;
	debugOrderOnUnit = onUnit;
	state = State::ENGAGE;
}

void CSuperTask::EndDebug(CCircuitUnit* unit, const char* why)
{
	CCircuitAI* circuit = manager->GetCircuit();
	TRY_UNIT(circuit, unit,
		unit->CmdStop();
		if (debugKind == debug::NUKE) {
			unit->TrySetFireState(unit->GetCircuitDef()->GetFireState());
		}
	)
	circuit->LOG("DEBUG: %s(%i) leaves the strike (%s): normal targeting", unit->GetCircuitDef()->GetDef()->GetName(),
			unit->GetId(), why);
	debugEngaged = false;
	debugApplies = false;
	debugHasAim = false;
	debugTargetId = debugOrderTargetId = -1;
	SetTarget(nullptr);
	isTargetOverride = false;
	tierTargetId = -1;
	targetFrame = 0;  // the normal scan at the next update
	state = State::ROAM;
}

/*
 * Launcher priority (owner 2026-11-03), see CMilitaryManager::SLauncherPrioInfo.
 */
int CSuperTask::LauncherPriorityRank(const SEnemyData& e, CCircuitDef* edef, CCircuitDef* cdef) const
{
	const CMilitaryManager::SLauncherPrioInfo& lp = manager->GetCircuit()->GetMilitaryManager()->GetLauncherPrioInfo();
	if (!lp.isEnabled || (lp.defs.count(cdef->GetId()) == 0)) {
		return -1;
	}
	const CCircuitDef::Id id = edef->GetId();
	const bool isMobile = edef->IsMobile();
	if ((lp.primary.count(id) > 0) || (!isMobile && lp.primaryShields && (edef->GetMaxShield() > 0.f))) {
		return 0;
	}
	// Speed only means something while radar or LOS tracks the unit.
	const bool live = e.IsInRadarOrLOS();
	const float sqSpeed = e.vel.SqLength2D();
	const CWeaponDef* wd = cdef->GetWeaponDef();
	const bool isParalyzer = (wd != nullptr) && wd->IsParalyzer();
	if (!isParalyzer && (lp.commMaxSqSpeed >= 0.f) && edef->IsRoleComm() && live && (sqSpeed <= lp.commMaxSqSpeed)) {
		return 1;
	}
	if (lp.tertiary.count(id) > 0) {
		return 2;
	}
	if ((lp.t3Defs.count(id) > 0) && (!isMobile || (live && (sqSpeed <= lp.t3MaxSqSpeed)))) {
		return 2;
	}
	return -1;
}

/*
 * Synchronised volley (owner 2026-11-03). The scan just aimed this launcher at
 * a primary target (rank 0). Every other sync launcher of this AI that is free
 * (no script override, tiered fire, debug strike or blocker) and reaches the
 * same aim point, with none of our units in its own blast, is its crew. With a
 * crew, nobody fires until every one has a stocked missile; then this update
 * orders them all at that aim point on the same frame. A launcher that has
 * held stocked for sync_max_wait_seconds fires alone. Holding launchers get a
 * stop (an attack order with an empty tube would fire the moment it fills)
 * and rescan every sync_recheck_seconds.
 */
bool CSuperTask::SyncLaunch(CCircuitUnit* unit, CCircuitDef* cdef, int frame)
{
	CCircuitAI* circuit = manager->GetCircuit();
	CMilitaryManager* militaryMgr = circuit->GetMilitaryManager();
	const CMilitaryManager::SLauncherPrioInfo& lp = militaryMgr->GetLauncherPrioInfo();
	if (!lp.isEnabled || (areaRank != 0) || (lp.syncDefs.count(cdef->GetId()) == 0)) {
		syncHoldSince = -1;
		return false;
	}
	std::vector<std::pair<CSuperTask*, CCircuitUnit*>> crew;
	for (IFighterTask* task : militaryMgr->GetTasks(IFighterTask::FightType::SUPER)) {
		if (task == this) continue;
		const auto& assignees = task->GetAssignees();
		if (assignees.empty()) continue;
		CCircuitUnit* other = *assignees.begin();
		CCircuitDef* odef = other->GetCircuitDef();
		if (lp.syncDefs.count(odef->GetId()) == 0) continue;
		CSuperTask* st = static_cast<CSuperTask*>(task);
		if (st->isTargetOverride || st->syncPending || !st->tierByDef.empty() || st->debugEngaged || (other->Blocker() != nullptr)) continue;
		if (other->GetPos(frame).SqDistance2D(targetPos) >= SQUARE(odef->GetMaxRange())) continue;
		auto& friendlies = circuit->GetCallback()->GetFriendlyUnitsIn(targetPos, odef->GetAoe());
		const bool hit = !friendlies.empty();
		utils::free(friendlies);
		if (hit) continue;
		crew.push_back({st, other});
	}
	if (crew.empty()) {
		syncHoldSince = -1;
		return false;  // alone in range: fire as usual
	}
	const bool selfReady = unit->GetUnit()->GetStockpile() > 0;
	int ready = selfReady ? 1 : 0;
	for (const auto& c : crew) {
		if (c.second->GetUnit()->GetStockpile() > 0) ++ready;
	}
	const int total = int(crew.size()) + 1;
	if (ready < total) {
		if (syncHoldSince < 0) syncHoldSince = frame;
		if (selfReady && (lp.syncMaxWaitFrames > 0) && (frame - syncHoldSince >= lp.syncMaxWaitFrames)) {
			circuit->LOG("SYNC %s(%i): waited %is at (%i,%i), %i/%i stocked: fires alone",
					cdef->GetDef()->GetName(), unit->GetId(), (frame - syncHoldSince) / FRAMES_PER_SEC,
					int(targetPos.x), int(targetPos.z), ready, total);
			syncHoldSince = -1;
			return false;
		}
		if (syncLogPos.SqDistance2D(targetPos) > SQUARE(1.f)) {
			syncLogPos = targetPos;
			circuit->LOG("SYNC %s(%i): holds for a volley at (%i,%i): %i/%i stocked",
					cdef->GetDef()->GetName(), unit->GetId(), int(targetPos.x), int(targetPos.z), ready, total);
		}
		TRY_UNIT(circuit, unit,
			unit->CmdStop();
		)
		SetTarget(nullptr);
		state = State::ROAM;
		targetFrame = frame - TARGET_DELAY + lp.syncRecheckFrames;
		return true;
	}
	// A launcher aimed (attack order) or fired in the last sync_settle_seconds
	// is still open (Catalyst doors, Perdition popup: they close 4 s after the
	// last aim and take ~4 s) and launches far sooner than its cold delay, so
	// the volley waits until every member has closed.
	if (lp.syncSettleFrames > 0) {
		auto busy = [frame, &lp](const CSuperTask* t, const CCircuitUnit* u) {
			return (frame - std::max(u->GetFireFrame(), t->lastAttackOrder) <= lp.syncSettleFrames);
		};
		bool settled = !busy(this, unit);
		for (const auto& c : crew) settled = settled && !busy(c.first, c.second);
		if (!settled) {
			TRY_UNIT(circuit, unit,
				unit->CmdStop();
			)
			SetTarget(nullptr);
			state = State::ROAM;
			targetFrame = frame - TARGET_DELAY + lp.syncRecheckFrames;
			return true;
		}
	}
	syncHoldSince = -1;
	syncLogPos = AIFloat3(-1.f, 0.f, -1.f);

	// Same impact (owner 2026-11-03): the shot that takes longest from order to
	// impact is ordered now, every other one later by the difference, so all
	// land together. With no timing for a def, all are ordered now.
	struct SMember { CSuperTask* task; CCircuitUnit* unit; float delay, flight; };
	std::vector<SMember> members;
	members.reserve(crew.size() + 1);
	members.push_back({this, unit, 0.f, 0.f});
	for (const auto& c : crew) members.push_back({c.first, c.second, 0.f, 0.f});
	bool timed = true;
	for (SMember& m : members) {
		timed = timed && m.task->SyncPredict(m.unit, targetPos, frame, m.delay, m.flight);
	}
	if (!timed) {
		circuit->LOG("SYNC %s(%i): volley of %i at (%i,%i)", cdef->GetDef()->GetName(), unit->GetId(), total,
				int(targetPos.x), int(targetPos.z));
		for (const auto& c : crew) {
			c.first->FireSync(c.second, targetPos);
		}
		ExecuteAttack(unit);
		return true;
	}
	unsigned anchor = 0;
	for (unsigned i = 1; i < members.size(); ++i) {
		if (members[i].delay + members[i].flight > members[anchor].delay + members[anchor].flight) anchor = i;
	}
	const float tMax = members[anchor].delay + members[anchor].flight;
	const int volley = militaryMgr->NewSyncVolley();
	std::string plan;
	for (const SMember& m : members) {
		plan += std::format(" {}({}) +{}", m.unit->GetCircuitDef()->GetDef()->GetName(), m.unit->GetId(),
				int(std::lround(tMax - m.delay - m.flight)));
	}
	circuit->LOG("SYNC %s(%i): timed volley %i of %i at (%i,%i), impact predicted at frame %i:%s",
			cdef->GetDef()->GetName(), unit->GetId(), volley, total, int(targetPos.x), int(targetPos.z),
			frame + int(std::lround(tMax)), plan.c_str());
	const AIFloat3 aim = targetPos;
	for (unsigned i = 0; i < members.size(); ++i) {
		SMember& m = members[i];
		const int offset = int(std::lround(tMax - m.delay - m.flight));
		if (i == anchor) {
			m.task->syncAnchorVolley = volley;
			m.task->syncAnchorFlight = int(std::lround(m.flight));
			m.task->syncAnchorUntil = frame + int(std::lround(m.delay)) + FRAMES_PER_SEC * 15;
		}
		if (offset <= 0) {
			m.task->FireSync(m.unit, aim, m.delay);
		} else {
			m.task->syncPending = true;
			TRY_UNIT(circuit, m.unit,
				m.unit->CmdStop();  // an older attack order would fire before the timed one
			)
			m.task->SetTarget(nullptr);
			m.task->targetPos = aim;
			militaryMgr->AddSyncOrder({m.unit->GetId(), aim, frame + offset, volley, m.delay + m.flight, frame, m.delay});
		}
	}
	return true;
}

bool CSuperTask::SyncPredict(CCircuitUnit* unit, const AIFloat3& pos, int frame, float& delay, float& flight) const
{
	const CMilitaryManager* militaryMgr = manager->GetCircuit()->GetMilitaryManager();
	const CMilitaryManager::SLauncherPrioInfo& lp = militaryMgr->GetLauncherPrioInfo();
	const CCircuitDef* d = unit->GetCircuitDef();
	auto it = lp.timing.find(d->GetId());
	if (it == lp.timing.end()) {
		return false;
	}
	const CMilitaryManager::SLauncherPrioInfo::STiming& tm = it->second;
	const float dist = unit->GetPos(frame).distance2D(pos);
	const bool ready = (tm.delayReady >= 0.f) && (frame - unit->GetFireFrame() <= tm.readyFrames);
	delay = std::max(0.f, (ready ? tm.delayReady : CMilitaryManager::SLauncherPrioInfo::Interp(tm.delay, dist))
			+ militaryMgr->GetSyncDelayBias(d->GetId()));
	flight = std::max(0.f, CMilitaryManager::SLauncherPrioInfo::Interp(tm.flight, dist));
	return true;
}

void CSuperTask::CancelSyncPending()
{
	syncPending = false;
	syncAnchorVolley = -1;
	targetFrame = 0;  // rescan at the next update
}

void CSuperTask::FireSync(CCircuitUnit* unit, const AIFloat3& pos, float predDelay)
{
	syncPending = false;
	syncOrderFrame = manager->GetCircuit()->GetLastFrame();
	float flight = 0.f;
	// a timed volley passes the delay it planned with, so the learned bias
	// compares the launch with the plan that set the order frame
	if (predDelay >= 0.f) syncPredDelay = predDelay;
	else if (!SyncPredict(unit, pos, syncOrderFrame, syncPredDelay, flight)) syncPredDelay = -1.f;
	SetTarget(nullptr);
	targetPos = pos;
	areaRank = 0;
	syncHoldSince = -1;
	syncLogPos = AIFloat3(-1.f, 0.f, -1.f);
	ExecuteAttack(unit);
}

void CSuperTask::SetTargetPos(const AIFloat3& pos)
{
	SetTarget(nullptr);
	targetFrame = 0;
	isTargetOverride = geom::is_valid(pos);
	if (isTargetOverride) {
		targetPos = pos;
		targetPos.y = manager->GetCircuit()->GetMap()->GetElevationAt(pos.x, pos.z);
	}
}

void CSuperTask::ExecuteAttack(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	CCircuitDef* d = unit->GetCircuitDef();
	const bool nuke = IsNukeSilo(d), pulse = IsPulse(d);
	bool valid = CanAimStrategic(unit, targetPos);
	if (nuke && circuit->GetMilitaryManager()->GetNuclearInfo().structuresOnly) {
		bool structure = false;
		const auto* enemies = circuit->GetEnemyManager();
		for (const auto* pool : {&enemies->GetHostileDatas(), &enemies->GetPeaceDatas()}) for (const auto& e : *pool) {
			if (!e.IsFake() && !e.IsDead() && !e.IsDying() && !e.IsIgnore() && e.cdef != nullptr
				&& !e.cdef->IsMobile() && targetPos.SqDistance2D(e.pos) < SQUARE(d->GetAoe())) { structure = true; break; }
		}
		valid = valid && structure;
	}
	if (nuke && valid) {
		auto& allies = circuit->GetCallback()->GetFriendlyUnitsIn(targetPos, d->GetAoe());
		valid = allies.empty();
		utils::free(allies);
	}
	if ((nuke || pulse) && !valid) {
		TRY_UNIT(circuit, unit, unit->CmdStop();)
		circuit->GetAllyTeam()->GetPulseClaims().ReleasePending(unit->GetId());
		SetTarget(nullptr); isTargetOverride = false; targetFrame = frame; state = State::ROAM;
		return;
	}
	if (pulse && unit->GetUnit()->GetStockpile() > 0) {
		const auto& policy = circuit->GetMilitaryManager()->GetPulseInfo();
		circuit->GetAllyTeam()->GetPulseClaims().Add(unit->GetId(), {targetPos.x, targetPos.z}, d->GetAoe(), frame, policy.pendingFrames, true);
	}

	bool isFiring = !unit->GetCircuitDef()->IsAttrStock() || (unit->GetUnit()->GetStockpile() > 0);
	std::string cmd = isFiring ? "ai_super_fire:" : "ai_super_intention:";
	cmd += std::format("{}/{}/{}", unit->GetId(), int(targetPos.x), int(targetPos.z));
	circuit->GetLua()->CallRules(cmd.c_str(), cmd.size());

	TRY_UNIT(circuit, unit,
		if (!isTargetOverride && (GetTarget() != nullptr)
			&& GetTarget()->IsInRadarOrLOS() && !circuit->IsCheating())
		{
			unit->GetUnit()->Attack(GetTarget()->GetUnit(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame + FRAMES_PER_SEC * 60);
		} else {
			unit->CmdAttackGround(targetPos, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame + FRAMES_PER_SEC * 60);
			lastAttackOrder = frame;
		}
	)
	targetFrame = frame;
	state = State::ENGAGE;
}

} // namespace circuit

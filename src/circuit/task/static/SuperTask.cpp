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
#include "unit/enemy/EnemyManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitWDef.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "spring/SpringMap.h"

#include "AISCommands.h"
#include "Lua.h"
#include "Log.h"

#include <algorithm>
#include <cmath>
#include <format>
#include <limits>
#include <vector>

namespace circuit {

using namespace springai;

#define TARGET_DELAY	(FRAMES_PER_SEC * 10)

CSuperTask::CSuperTask(ITaskModule* mgr)
		: IFighterTask(mgr, IFighterTask::FightType::SUPER, 1.f)
		, targetFrame(0)
		, targetPos(-RgtVector)
		, isTargetOverride(false)
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

	if (unit->Blocker() != nullptr) {
		return;  // Do not interrupt current action
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

	if (isTargetOverride) {
		ExecuteAttack(unit);
		return;
	}

	CMilitaryManager* policyMgr = circuit->GetMilitaryManager();
	const bool isPulse = policyMgr->GetPulseInfo().isEnabled
			&& cdef->IsRespRoleAny(policyMgr->GetPulseInfo().pulseRole);
	const CWeaponDef* empWd = cdef->GetWeaponDef();
	const bool isEmp = !isPulse && policyMgr->GetEmpInfo().isEnabled
			&& cdef->IsRespRoleAny(policyMgr->GetEmpInfo().empRole)
			&& (empWd != nullptr) && empWd->IsParalyzer();
	if (isPulse || isEmp) {
		// Neither weapon falls back to the group scan: spending the stockpile on
		// the richest enemy blob, which one cannot damage and the other cannot
		// hold, is worse than waiting for a target that works.
		// A known jammer or radar always wins: its position is certain, so a
		// target deep behind the line is still worth the shot. Only when nothing
		// is known does the weapon fall back to inferring one from a radar hole.
		const bool hasTarget = isPulse
				? (SelectPulseTarget(unit, cdef) || SelectSuspectedJammer(unit, cdef))
				: SelectEmpTarget(unit, cdef);
		if (hasTarget) {
			ExecuteAttack(unit);
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
	const float mapDiag = std::sqrt(SQUARE(float(CTerrainManager::GetTerrainWidth())) + SQUARE(float(CTerrainManager::GetTerrainHeight())));
	const bool isRegional = (cdef->GetMaxRange() < mapDiag);
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
	const float maxCost = cdef->IsAttrStock() ? cdef->GetWeaponDef()->GetCostMShot() : cdef->GetCostM() * 0.01f;

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
		float sqAoe, int minTargets, int mobileMaxAge, const TClassify& classify)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	const float maxSqRange = SQUARE(cdef->GetMaxRange());

	struct SAreaCand {
		springai::AIFloat3 pos;
		int rank;
		float value;
	};
	std::vector<SAreaCand> cands;
	int rejRange = 0, rejStale = 0, rejClass = 0;

	for (const SEnemyData& e : circuit->GetEnemyManager()->GetHostileDatas()) {
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
		cands.push_back({e.pos, rank, value});
	}

	int bestRank = std::numeric_limits<int>::max();
	float bestValue = 0.f;
	int bestCount = 0;
	int bestIdx = -1;
	for (unsigned i = 0; i < cands.size(); ++i) {
		int rank = std::numeric_limits<int>::max();
		float value = 0.f;
		int count = 0;
		for (unsigned j = 0; j < cands.size(); ++j) {
			if (cands[i].pos.SqDistance2D(cands[j].pos) >= sqAoe) {
				continue;
			}
			rank = std::min(rank, cands[j].rank);
			value += cands[j].value;
			++count;
		}
		if (count < minTargets) {
			continue;
		}
		if ((rank < bestRank) || ((rank == bestRank) && (value > bestValue))) {
			bestRank = rank;
			bestValue = value;
			bestCount = count;
			bestIdx = int(i);
		}
	}

	if (bestIdx < 0) {
		if ((frame / TARGET_DELAY) % 6 == 0) {
			circuit->LOG("%s %s(%i): no target | range=%.0f candidates=%zu rejClass=%i rejRange=%i rejStale=%i minTargets=%i",
					tag, cdef->GetDef()->GetName(), unit->GetId(), cdef->GetMaxRange(),
					cands.size(), rejClass, rejRange, rejStale, minTargets);
		}
		return false;
	}

	SetTarget(nullptr);  // area effect at a position, possibly of a unit we can no longer see
	const bool isMoved = (targetPos.SqDistance2D(cands[bestIdx].pos) > SQUARE(1.f));
	targetPos = cands[bestIdx].pos;
	targetPos.y = circuit->GetMap()->GetElevationAt(targetPos.x, targetPos.z);
	if (isMoved) {  // Update runs every TARGET_DELAY: only log a new aim point
		circuit->LOG("%s %s(%i): rank=%i targets=%i value=%.0f at (%i,%i)",
				tag, cdef->GetDef()->GetName(), unit->GetId(), bestRank, bestCount, bestValue,
				int(targetPos.x), int(targetPos.z));
	}
	return true;
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
		// Custom config roles live in respRole: AddRole() puts the requested role
		// there and only the binded role in role.
		const bool isJammer = edef->IsRespRoleAny(pulse.jammerRole);
		const bool isRadar = edef->IsRespRoleAny(pulse.radarRole);
		if (!isJammer && !isRadar) {
			return false;
		}
		const bool isMobile = edef->IsMobile();
		CMilitaryManager::PulseClass cls;
		if (isJammer) {  // a def marked both counts as the jammer it is
			cls = isMobile ? CMilitaryManager::PulseClass::JAMMER_MOBILE
					: CMilitaryManager::PulseClass::JAMMER_STATIC;
		} else {
			cls = isMobile ? CMilitaryManager::PulseClass::RADAR_MOBILE
					: CMilitaryManager::PulseClass::RADAR_STATIC;
		}
		const int r = pulse.rank[static_cast<CMilitaryManager::PulseC>(cls)];
		if (r < 0) {
			return false;  // class excluded by config
		}
		rank = r;
		value = e.cost;
		return true;
	});
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
 * carries no `targetable`, so the anti-nuke cannot intercept it.
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

	return SelectAreaTarget(unit, cdef, "EMP", SQUARE(cdef->GetAoe()),
			emp.minTargets, emp.mobileMaxAge,
			[&emp, shot, decline, cap](const SEnemyData& e, CCircuitDef* edef, int& rank, float& value) {
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
		const bool isMobile = edef->IsMobile();
		if (!isMobile && edef->IsRespRoleAny(emp.antiNukeRole)) {
			rank = 0;
		} else if (!isMobile) {
			rank = 1;  // every other structure, ranked by value below
		} else {
			rank = emp.structuresFirst ? 2 : 1;
		}
		// Value is metal: it floats Ragnarok, AFUS, gantry and silo above a cheap
		// turret without any of them needing to be tagged.
		value = e.cost;
		return true;
	});
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
		}
	)
	targetFrame = frame;
	state = State::ENGAGE;
}

} // namespace circuit

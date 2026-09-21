/*
 * AirWaveTask.cpp
 *
 * See AirWaveTask.h and doc/air-wave-attacks.md.
 */

#include "task/fighter/AirWaveTask.h"
#include "module/MilitaryManager.h"
#include "map/ThreatMap.h"
#include "terrain/TerrainManager.h"
#include "setup/SetupManager.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitDef.h"
#include "unit/enemy/EnemyManager.h"
#include "unit/enemy/EnemyUnit.h"
#include "CircuitAI.h"
#include "spring/SpringCallback.h"
#include "util/Utils.h"

#include "AISCommands.h"
#include "Log.h"
#include "UnitDef.h"

#include <algorithm>
#include <cmath>
#include <limits>

namespace circuit {

using namespace springai;

// A unit is "in its slot" within this radius; the line is formed when this
// fraction of the living wave is.
#define WAVE_SLOT_RADIUS		(SQUARE_SIZE * 16)
#define WAVE_FORMED_FRACTION	0.75f
// Attack phase deadline: long enough for the slowest bomber to cross the map.
#define WAVE_ATTACK_TIMEOUT		(FRAMES_PER_SEC * 150)
// Smart bearing: probes on a ring at the stand-off distance.
#define WAVE_BEARING_SAMPLES	12

CAirWaveTask::CAirWaveTask(ITaskModule* mgr)
		: IFighterTask(mgr, FightType::WAVE, 1.f)
		, mode(EMode::CARPET)
		, state_(EState::PLANNED)
		, aim(-RgtVector)
		, formDistance(1200.f)
		, spacing(96.f)
		, overrun(900.f)
		, formTimeout(FRAMES_PER_SEC * 45)
		, holdFrames(0)
		, bearingDeg(0.f)
		, usedBearingDeg(0.f)
		, groups(1)
		, dealt(0)
		, stateFrame(0)
		, strikeTargetId(-1)
		, formedCount(0)
		, linesReady(false)
{
}

CAirWaveTask::~CAirWaveTask()
{
}

bool CAirWaveTask::CanAssignTo(CCircuitUnit* unit) const
{
	return unit->GetCircuitDef()->IsAbleToFly();  // script decides membership beyond that
}

void CAirWaveTask::AssignTo(CCircuitUnit* unit)
{
	IFighterTask::AssignTo(unit);
	slots[unit] = dealt++;
}

void CAirWaveTask::RemoveAssignee(CCircuitUnit* unit)
{
	IFighterTask::RemoveAssignee(unit);
	slots.erase(unit);
	if (units.empty()) {
		manager->AbortTask(this);  // the wave is gone; do not stay in the task sets forever (CR-011)
	}
}

void CAirWaveTask::Start(CCircuitUnit* unit)
{
	if (state_ == EState::FORMING) {
		IssueForm(unit);
	} else if (state_ == EState::ATTACKING) {
		IssueAttack(unit);
	}
}

void CAirWaveTask::OnUnitIdle(CCircuitUnit* unit)
{
	const int frame = manager->GetCircuit()->GetLastFrame();
	switch (state_) {
		case EState::FORMING:
		case EState::HOLDING: {
			if (unit->GetPos(frame).SqDistance2D(SlotPos(unit)) > SQUARE(WAVE_SLOT_RADIUS)) {
				IssueForm(unit);
			}
		} break;
		case EState::ATTACKING: {
			if (!IsPastAim(unit, frame)) {
				IssueAttack(unit);  // the fight order was eaten by a retarget; go again
			}
		} break;
		default: break;
	}
}

void CAirWaveTask::OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	// Hold the line. Scattering under fire is what the native squad does and
	// what a formation exists not to do.
}

void CAirWaveTask::EnterState(EState next)
{
	state_ = next;
	stateFrame = manager->GetCircuit()->GetLastFrame();
}

/*
 * Script hooks
 */
void CAirWaveTask::SetPlan(int m, const AIFloat3& a, float fd, float sp, float ov, int ft, int hf, float bd, int gr)
{
	mode = static_cast<EMode>(std::max(0, std::min(int(EMode::FEINT), m)));
	aim = a;
	CTerrainManager::CorrectPosition(aim);
	position = aim;
	formDistance = std::max(200.f, fd);
	spacing = std::max(32.f, sp);
	overrun = std::max(0.f, ov);
	formTimeout = std::max(0, ft);
	holdFrames = std::max(0, hf);
	bearingDeg = bd;
	groups = (gr >= 2) ? 2 : 1;
	linesReady = false;
	formedCount = 0;
	EnterState(EState::FORMING);
}

CEnemyInfo* CAirWaveTask::GetStrikeTarget() const
{
	return (strikeTargetId < 0) ? nullptr : manager->GetCircuit()->GetEnemyInfo(strikeTargetId);
}

bool CAirWaveTask::PickStrikeTarget(const AIFloat3& from, int preference, float minStaticCost, bool includeHeavy)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const AIFloat3 base = circuit->GetSetupManager()->GetBasePos();
	const SEnemyData* best = nullptr;
	float bestScore = -1.f;
	for (const SEnemyData& e : circuit->GetEnemyManager()->GetHostileDatas()) {
		if (e.IsFake() || e.IsDead() || e.IsDying() || e.IsIgnore() || (e.cdef == nullptr)) {
			continue;
		}
		const bool isStatic = !e.cdef->IsMobile();
		if (isStatic) {
			if (e.cost < minStaticCost) {
				continue;
			}
		} else if (!includeHeavy || !e.cdef->IsRoleHeavy() || e.cdef->IsAbleToFly()) {
			continue;
		}
		float score;
		if (preference == 1) {
			score = e.pos.SqDistance2D(base);                                   // deepest
		} else {
			score = e.cost / (1.f + std::sqrt(e.pos.SqDistance2D(from)) / 1000.f);  // value, discounted by distance
		}
		if (score > bestScore) {
			bestScore = score;
			best = &e;
		}
	}
	if (best == nullptr) {
		return false;
	}
	strikeTargetId = best->id;
	aim = best->pos;
	position = aim;
	circuit->LOG("WAVE: strike target %s(%i) cost %.0f at (%.0f, %.0f), preference %i",
			best->cdef->GetDef()->GetName(), best->id, best->cost, aim.x, aim.z, preference);
	return true;
}

/*
 * Geometry
 */
float CAirWaveTask::PickSmartBearingDeg(const AIFloat3& baseDir) const
{
	CCircuitAI* circuit = manager->GetCircuit();
	CThreatMap* threatMap = circuit->GetThreatMap();
	if (units.empty()) {
		return 0.f;
	}
	threatMap->SetThreatType(*units.begin());
	const float baseAngle = std::atan2(baseDir.z, baseDir.x);
	float bestDeg = 0.f;
	float bestThreat = std::numeric_limits<float>::max();
	for (int i = 0; i < WAVE_BEARING_SAMPLES; ++i) {
		const float deg = (360.f * float(i)) / float(WAVE_BEARING_SAMPLES) - 180.f;
		const float angle = baseAngle + deg * float(M_PI) / 180.f;
		// The line stands at -dir * formDistance from the aim and flies dir.
		const AIFloat3 dir(std::cos(angle), 0.f, std::sin(angle));
		AIFloat3 stand(aim.x - dir.x * formDistance, aim.y, aim.z - dir.z * formDistance);
		AIFloat3 mid(aim.x - dir.x * formDistance * 0.5f, aim.y, aim.z - dir.z * formDistance * 0.5f);
		CTerrainManager::CorrectPosition(stand);
		CTerrainManager::CorrectPosition(mid);
		// Frontal is the cheapest flight; break ties toward it.
		const float threat = threatMap->GetThreatAt(stand) + threatMap->GetThreatAt(mid) + std::fabs(deg) * 1e-4f;
		if (threat < bestThreat) {
			bestThreat = threat;
			bestDeg = deg;
		}
	}
	return bestDeg;
}

void CAirWaveTask::ComputeLines()
{
	CCircuitAI* circuit = manager->GetCircuit();
	const AIFloat3 base = circuit->GetSetupManager()->GetBasePos();
	AIFloat3 baseDir(aim.x - base.x, 0.f, aim.z - base.z);
	const float len = std::sqrt(baseDir.x * baseDir.x + baseDir.z * baseDir.z);
	if (len < 1.f) {
		baseDir = AIFloat3(1.f, 0.f, 0.f);
	} else {
		baseDir.x /= len;
		baseDir.z /= len;
	}
	float deg = bearingDeg;
	if (deg >= SMART_BEARING - 1.f) {
		deg = PickSmartBearingDeg(baseDir);
	}
	usedBearingDeg = deg;
	const float baseAngle = std::atan2(baseDir.z, baseDir.x);
	groupDir.clear();
	groupCentre.clear();
	for (int g = 0; g < groups; ++g) {
		const float sign = (g == 0) ? 1.f : -1.f;
		const float angle = baseAngle + sign * deg * float(M_PI) / 180.f;
		const AIFloat3 dir(std::cos(angle), 0.f, std::sin(angle));
		AIFloat3 centre(aim.x - dir.x * formDistance, aim.y, aim.z - dir.z * formDistance);
		CTerrainManager::CorrectPosition(centre);
		groupDir.push_back(dir);
		groupCentre.push_back(centre);
	}
	linesReady = true;
	circuit->LOG("WAVE: %s lines ready: aim (%.0f, %.0f) bearing %+.0f deg, %i group(s), stand-off %.0f, spacing %.0f, %zu units",
			(mode == EMode::STRIKE) ? "strike" : "carpet", aim.x, aim.z, usedBearingDeg, groups, formDistance, spacing, units.size());
}

int CAirWaveTask::LaneOf(int slot) const
{
	const int k = (groups <= 1) ? slot : (slot / 2);  // index within the group
	return (k == 0) ? 0 : (((k % 2) == 1) ? int((k + 1) / 2) : -int(k / 2));
}

AIFloat3 CAirWaveTask::SlotPos(CCircuitUnit* unit) const
{
	auto it = slots.find(unit);
	const int slot = (it == slots.end()) ? 0 : it->second;
	const int g = GroupOf(slot);
	if (!linesReady || (g >= int(groupDir.size()))) {
		return aim;
	}
	const AIFloat3& dir = groupDir[g];
	const AIFloat3& centre = groupCentre[g];
	const float off = spacing * float(LaneOf(slot));
	AIFloat3 p(centre.x - dir.z * off, centre.y, centre.z + dir.x * off);
	CTerrainManager::CorrectPosition(p);
	return p;
}

AIFloat3 CAirWaveTask::EndPos(CCircuitUnit* unit) const
{
	auto it = slots.find(unit);
	const int slot = (it == slots.end()) ? 0 : it->second;
	const int g = GroupOf(slot);
	if (!linesReady || (g >= int(groupDir.size()))) {
		return aim;
	}
	const AIFloat3& dir = groupDir[g];
	const AIFloat3 s = SlotPos(unit);
	const float run = formDistance + overrun;
	AIFloat3 p(s.x + dir.x * run, s.y, s.z + dir.z * run);
	CTerrainManager::CorrectPosition(p);
	return p;
}

bool CAirWaveTask::IsPastAim(CCircuitUnit* unit, int frame) const
{
	auto it = slots.find(unit);
	const int g = GroupOf((it == slots.end()) ? 0 : it->second);
	if (!linesReady || (g >= int(groupDir.size()))) {
		return true;
	}
	const AIFloat3& dir = groupDir[g];
	const AIFloat3& p = unit->GetPos(frame);
	return ((p.x - aim.x) * dir.x + (p.z - aim.z) * dir.z) > 0.f;
}

/*
 * Orders
 */
void CAirWaveTask::IssueForm(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	TRY_UNIT(circuit, unit,
		unit->CmdWantedSpeed(NO_SPEED_LIMIT);
		unit->CmdMoveTo(SlotPos(unit), 0, circuit->GetLastFrame() + formTimeout + FRAMES_PER_SEC * 30);
	)
}

void CAirWaveTask::IssueAttack(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	CEnemyInfo* target = ((mode == EMode::STRIKE) || (mode == EMode::DEEP)) ? GetStrikeTarget() : nullptr;
	TRY_UNIT(circuit, unit,
		unit->CmdWantedSpeed(NO_SPEED_LIMIT);
		if (target != nullptr) {
			unit->Attack(target, false, frame + WAVE_ATTACK_TIMEOUT);
		} else {
			// Attack-move down the lane: the bombers release on what they cross
			// and keep going, so the wave carpets the strip instead of stacking
			// on the first target.
			unit->CmdFightTo(EndPos(unit), 0, frame + WAVE_ATTACK_TIMEOUT);
		}
	)
}

/*
 * State machine
 */
void CAirWaveTask::Update()
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	if ((state_ == EState::PLANNED) || (state_ == EState::DONE)) {
		return;
	}
	if (units.empty()) {
		return;  // the wave died or was never handed units; script aborts it
	}
	if (!linesReady) {
		ComputeLines();
		for (CCircuitUnit* unit : units) {
			IssueForm(unit);
		}
		return;
	}

	switch (state_) {
		case EState::FORMING: {
			int formed = 0;
			for (CCircuitUnit* unit : units) {
				if (unit->GetPos(frame).SqDistance2D(SlotPos(unit)) < SQUARE(WAVE_SLOT_RADIUS)) {
					++formed;
				} else if (!circuit->GetCallback()->Unit_HasCommands(unit->GetId())) {
					IssueForm(unit);
				}
			}
			formedCount = formed;
			const bool timedOut = (frame - stateFrame) > formTimeout;
			if ((float(formed) >= WAVE_FORMED_FRACTION * float(units.size())) || timedOut) {
				circuit->LOG("WAVE: line %s with %i of %zu after %i s; %s",
						timedOut ? "timed out" : "formed", formed, units.size(), (frame - stateFrame) / FRAMES_PER_SEC,
						(holdFrames > 0) ? "holding" : "attacking");
				if (holdFrames > 0) {
					EnterState(EState::HOLDING);
				} else {
					EnterState(EState::ATTACKING);
					for (CCircuitUnit* unit : units) {
						IssueAttack(unit);
					}
				}
			}
		} break;

		case EState::HOLDING: {
			if ((frame - stateFrame) > holdFrames) {
				circuit->LOG("WAVE: hold over after %i s; attacking", (frame - stateFrame) / FRAMES_PER_SEC);
				EnterState(EState::ATTACKING);
				for (CCircuitUnit* unit : units) {
					IssueAttack(unit);
				}
			}
		} break;

		case EState::ATTACKING: {
			bool over = false;
			const char* why = "";
			if ((mode == EMode::STRIKE) || (mode == EMode::DEEP)) {
				CEnemyInfo* target = GetStrikeTarget();
				if ((target == nullptr) || (target->GetUnit() == nullptr)) {
					over = true;
					why = "strike target gone";
				}
			} else {
				int past = 0;
				for (CCircuitUnit* unit : units) {
					if (IsPastAim(unit, frame)) {
						++past;
					}
				}
				if (past * 2 >= int(units.size())) {
					over = true;
					why = "half the wave is past the aim";
				}
			}
			if (!over && ((frame - stateFrame) > WAVE_ATTACK_TIMEOUT)) {
				over = true;
				why = "attack timed out";
			}
			if (over) {
				circuit->LOG("WAVE: run over (%s) with %zu survivors; releasing to native bombing", why, units.size());
				EnterState(EState::DONE);
				manager->AbortTask(this);
				return;
			}
		} break;

		default: break;
	}
}

} // namespace circuit

/*
 * AirWaveTask.cpp
 *
 * See AirWaveTask.h and doc/air-wave-attacks.md.
 */

#include "task/fighter/AirWaveTask.h"
#include "task/fighter/AirGeometry.h"
#include "unit/CircuitWDef.h"
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
#include "WeaponDef.h"
#include "WeaponMount.h"

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
    releasedAt.erase(unit);
    outbound.erase(unit);
    assembled.erase(unit);
    if (safeFlight) {
        unit->TrySetFireState(unit->GetCircuitDef()->GetFireState());
        unit->TrySetMoveState(unit->GetCircuitDef()->GetMoveState());
        unit->TrySetIdleMode(1);
    }
	if (units.empty()) {
		manager->AbortTask(this);  // the wave is gone; do not stay in the task sets forever (CR-011)
	}
}

void CAirWaveTask::Start(CCircuitUnit* unit)
{
    if (safeFlight) {
        unit->TrySetIdleMode(0);
        unit->TrySetFireState(CCircuitDef::FireType::HOLD);
    }
	if (state_ == EState::FORMING && linesReady) {
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
			if (!linesReady) break;
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

void CAirWaveTask::OnWeaponFired(CCircuitUnit* unit, int weaponDefId)
{
    if (!safeFlight || state_ != EState::ATTACKING || releasedAt.count(unit)) return;
    CWeaponDef* weapon = manager->GetCircuit()->GetWeaponDef(weaponDefId);
    if (weapon == nullptr || weapon->IsParalyzer() || weapon->GetDamage() <= 0.f) return;
    releasedAt[unit] = manager->GetCircuit()->GetLastFrame();
    manager->GetCircuit()->LOG("WAVE: released unit=%i weapon=%i", unit->GetId(), weaponDefId);
}

void CAirWaveTask::OnDamageDealt(CCircuitUnit* unit, int weaponDefId)
{
    // Preserve the earlier fired timestamp if the engine provided one.
    // This fallback also observes scripted Phoenix heat-ray emissions.
    OnWeaponFired(unit, weaponDefId);
}

void CAirWaveTask::SetFlightPolicy(float width, float depth, float loss, const AIFloat3& home)
{
    if (!std::isfinite(width) || !std::isfinite(depth) || !std::isfinite(loss)
        || !std::isfinite(home.x) || !std::isfinite(home.z)) return;
    safeFlight = true;
    maxWidth = std::clamp(width, 0.f, 4000.f);
    rankSpacing = std::clamp(depth, 64.f, 600.f);
    abortFraction = std::clamp(loss, .05f, 1.f);
    returnPos = home;
    CTerrainManager::CorrectPosition(returnPos);
}

void CAirWaveTask::SetStrikePolicy(CCircuitDef* bomber, int count, float fraction, float margin, float weight, float ceiling)
{
    damageBudget = 0.f;
    passDamage = 0.f;
    if (bomber == nullptr || count <= 0 || !std::isfinite(fraction) || !std::isfinite(margin)
        || !std::isfinite(weight) || !std::isfinite(ceiling)) return;
    passDamage = StrikeAlpha(bomber) * std::clamp(fraction, 0.f, 1.f);
    damageBudget = passDamage * count;
    expectedCount = count;
    passFraction = std::clamp(fraction, 0.f, 1.f);
    damageMargin = std::max(1.f, margin);
    threatWeight = std::max(0.f, weight);
    maxThreat = std::max(0.f, ceiling);
}

void CAirWaveTask::ConsiderStrikeAircraft(CCircuitDef* bomber)
{
    const float damage = StrikeAlpha(bomber) * passFraction;
    passDamage = std::min(passDamage, damage);
    damageBudget = passDamage * expectedCount;
}

float CAirWaveTask::StrikeAlpha(CCircuitDef* bomber)
{
    if (bomber == nullptr) return 0.f;
    const auto found = strikeAlpha.find(bomber->GetId());
    if (found != strikeAlpha.end()) return found->second;
    float alpha = 0.f;
    // Representative weapons can be zero-damage targeting/sound mounts.
    // Inspect loaded mounts locally; do not change shared/static classification.
    for (WeaponMount* mount : bomber->GetDef()->GetWeaponMounts()) {
        WeaponDef* wd = mount->GetWeaponDef();
        CWeaponDef* weapon = manager->GetCircuit()->GetWeaponDef(wd->GetWeaponDefId());
        const auto& params = wd->GetCustomParams();
        if (weapon != nullptr && !weapon->IsParalyzer() && weapon->GetDamage() > 0.f
            && !params.count("bogus") && !params.count("fake_weapon")) {
            float loadedAlpha = weapon->GetAlpha();
            const auto sweep = params.find("sweepfire_firetime");
            if (sweep != params.end()) {
                // BAR sweep scripts emit once per simulation frame. This is an
                // upper bound; script passFraction accounts for time on target.
                const float seconds = utils::string_to_float(sweep->second);
                if (std::isfinite(seconds) && seconds > 0.f)
                    loadedAlpha = weapon->GetDamage() * std::clamp(seconds * FRAMES_PER_SEC, 1.f, 900.f);
            }
            alpha = std::max(alpha, loadedAlpha);
        }
        delete wd;
        delete mount;
    }
    strikeAlpha[bomber->GetId()] = alpha;
    return alpha;
}

void CAirWaveTask::SetAssemblyPolicy(float radius, float fraction, int frames)
{
    if (!std::isfinite(radius) || !std::isfinite(fraction)) return;
    assemblyRadius = std::clamp(radius, 64.f, 800.f);
    assemblyFraction = std::clamp(fraction, .5f, 1.f);
    joinFrames = std::clamp(frames, 0, FRAMES_PER_SEC * 60);
}

float CAirWaveTask::RouteExposure(const AIFloat3& from, const AIFloat3& to) const
{
    const float distance = std::sqrt(from.SqDistance2D(to));
    const int samples = std::clamp(int(distance / 256.f) + 1, 1, 128);
    float total = 0.f;
    const CThreatMap* threat = manager->GetCircuit()->GetThreatMap();
    for (int i = 0; i <= samples; ++i) {
        const float f = float(i) / samples;
        const AIFloat3 p(from.x + (to.x-from.x)*f, 0.f, from.z + (to.z-from.z)*f);
        total += threat->GetAirThreatAtPos(p);
    }
    return total * distance / float(samples + 1);
}

void CAirWaveTask::ReturnHome(const char* reason)
{
    CCircuitAI* circuit = manager->GetCircuit();
    circuit->LOG("WAVE: returning reason=%s alive=%zu released=%zu initial=%i", reason, units.size(), releasedAt.size(), launchCount);
    EnterState(EState::RETURNING);
    for (CCircuitUnit* unit : units) {
        unit->TrySetFireState(CCircuitDef::FireType::HOLD);
        // A released aircraft completes the planned straight egress before
        // turning home. Target disappearance must not force a U-turn over AA.
        const bool finishPass = linesReady && releasedAt.count(unit) != 0;
        TRY_UNIT(circuit, unit,
            if (finishPass) unit->CmdMoveTo(EndPos(unit), 0, circuit->GetLastFrame() + WAVE_ATTACK_TIMEOUT);
            unit->CmdMoveTo(returnPos, finishPass ? UNIT_COMMAND_OPTION_SHIFT_KEY : 0,
                circuit->GetLastFrame() + WAVE_ATTACK_TIMEOUT);
        )
    }
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
	assembled.clear();
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
    requiredBombers = 0;
    // The ordinary hostile set excludes peaceful economic structures. A
    // strategic strike must also consider the known peace-unit snapshot.
    const auto& hostile = circuit->GetEnemyManager()->GetHostileDatas();
    const auto& peaceful = circuit->GetEnemyManager()->GetPeaceDatas();
    const std::vector<const std::vector<SEnemyData>*> sets = safeFlight
        ? std::vector<const std::vector<SEnemyData>*>{&hostile, &peaceful}
        : std::vector<const std::vector<SEnemyData>*>{&hostile};
	for (const auto* candidates : sets) for (const SEnemyData& e : *candidates) {
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
        if (safeFlight) {
            if (e.health <= 0.f || passDamage <= 0.f || circuit->GetThreatMap()->GetAirThreatAtPos(e.pos) > maxThreat) continue;
            const int required = static_cast<int>(std::ceil(e.health * damageMargin / passDamage));
            if (requiredBombers == 0 || required < requiredBombers) requiredBombers = required;
            if (damageBudget < e.health * damageMargin) continue;
        }
		if (preference == 1) {
			score = e.pos.SqDistance2D(base);                                   // deepest
		} else {
			score = e.cost / (1.f + std::sqrt(e.pos.SqDistance2D(from)) / 1000.f);  // value, discounted by distance
		}
        if (safeFlight) {
            const float length = std::max(1.f, std::sqrt(from.SqDistance2D(e.pos)));
            score /= 1.f + threatWeight * RouteExposure(from, e.pos) / length;
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
	if (units.empty() && !safeFlight) {
		return 0.f;
	}
	if (!units.empty()) threatMap->SetThreatType(*units.begin());
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
		float threat = threatMap->GetThreatAt(stand) + threatMap->GetThreatAt(mid) + std::fabs(deg) * 1e-4f;
        if (safeFlight) {
            AIFloat3 exit(aim.x + dir.x * overrun, 0.f, aim.z + dir.z * overrun);
            CTerrainManager::CorrectPosition(exit);
            const float distance = std::sqrt(returnPos.SqDistance2D(stand)) + formDistance
                + overrun + std::sqrt(exit.SqDistance2D(returnPos));
            threat = threatWeight * (RouteExposure(returnPos, stand) + RouteExposure(stand, exit)
                + RouteExposure(exit, returnPos)) + distance;
        }
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
    if (safeFlight) {
        // Assign nearby slots once, after the asynchronous release window.
        // ID order makes equal-distance ties independent of pointer addresses.
        std::vector<CCircuitUnit*> ordered(units.begin(), units.end());
        std::sort(ordered.begin(), ordered.end(), [](CCircuitUnit* a, CCircuitUnit* b) { return a->GetId() < b->GetId(); });
        std::vector<bool> used(ordered.size(), false);
        assemblyTravelFrames = 0;
        for (CCircuitUnit* unit : ordered) {
            int best = 0;
            float distance = std::numeric_limits<float>::max();
            for (size_t i = 0; i < ordered.size(); ++i) {
                if (used[i]) continue;
                slots[unit] = int(i);
                const float candidate = unit->GetPos(circuit->GetLastFrame()).SqDistance2D(SlotPos(unit));
                if (candidate < distance) { distance = candidate; best = int(i); }
            }
            slots[unit] = best;
            used[best] = true;
            assemblyTravelFrames = std::max(assemblyTravelFrames, int(std::ceil(FRAMES_PER_SEC *
                air_geometry::TransitSeconds(std::sqrt(distance), unit->GetCircuitDef()->GetSpeed()))));
        }
        stateFrame = circuit->GetLastFrame();
    }
    launchCount = safeFlight ? std::max(expectedCount, int(units.size())) : int(units.size());
	circuit->LOG("WAVE: %s lines ready: aim (%.0f, %.0f) bearing %+.0f deg, %i group(s), stand-off %.0f, spacing %.0f, %zu units",
			(mode == EMode::STRIKE) ? "strike" : "carpet", aim.x, aim.z, usedBearingDeg, groups, formDistance, spacing, units.size());
    if (safeFlight) circuit->LOG("WAVE: assembly travel=%i settle=%i seconds", assemblyTravelFrames / FRAMES_PER_SEC, formTimeout / FRAMES_PER_SEC);
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
	const auto bounded = air_geometry::FormationSlot(groups <= 1 ? slot : slot / 2, maxWidth, spacing, rankSpacing);
    const float off = safeFlight ? bounded.lateral : spacing * float(LaneOf(slot));
    const float behind = safeFlight ? bounded.behind : 0.f;
	AIFloat3 p(centre.x - dir.z * off - dir.x * behind, centre.y, centre.z + dir.x * off - dir.z * behind);
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
    const auto bounded = air_geometry::FormationSlot(groups <= 1 ? slot : slot / 2, maxWidth, spacing, rankSpacing);
    const float extra = safeFlight ? bounded.behind : 0.f;
	AIFloat3 p(s.x + dir.x * (run + extra), s.y, s.z + dir.z * (run + extra));
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
		unit->CmdMoveTo(SlotPos(unit), 0, circuit->GetLastFrame() + formTimeout + assemblyTravelFrames + FRAMES_PER_SEC * 30);
	)
}

void CAirWaveTask::IssueAttack(CCircuitUnit* unit)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
    if (safeFlight) unit->TrySetFireState(CCircuitDef::FireType::OPEN);
	CEnemyInfo* target = ((mode == EMode::STRIKE) || (mode == EMode::DEEP)) ? GetStrikeTarget() : nullptr;
	TRY_UNIT(circuit, unit,
		unit->CmdWantedSpeed(NO_SPEED_LIMIT);
		if (target != nullptr) {
            if (safeFlight && !target->GetCircuitDef()->IsMobile()) unit->CmdAttackGround(target->GetPos(), 0, frame + WAVE_ATTACK_TIMEOUT);
			else unit->Attack(target, false, frame + WAVE_ATTACK_TIMEOUT);
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
        if (safeFlight && int(units.size()) < expectedCount && frame - stateFrame < joinFrames) return;
		ComputeLines();
		for (CCircuitUnit* unit : units) {
			IssueForm(unit);
		}
		return;
	}
    launchCount = std::max(launchCount, static_cast<int>(units.size()));
    if (safeFlight && state_ != EState::RETURNING
        && air_geometry::LossAbort(launchCount, static_cast<int>(units.size()), abortFraction)) {
        ReturnHome("loss threshold");
        return;
    }

	switch (state_) {
		case EState::FORMING: {
			int formed = 0;
			for (CCircuitUnit* unit : units) {
                const float distance = unit->GetPos(frame).SqDistance2D(SlotPos(unit));
                if (safeFlight && distance < SQUARE(assemblyRadius)) assembled.insert(unit);
                if (safeFlight && distance > SQUARE(assemblyRadius * 2.f)) assembled.erase(unit);
				if (safeFlight ? assembled.count(unit) != 0 : distance < SQUARE(WAVE_SLOT_RADIUS)) {
					++formed;
				} else if (!circuit->GetCallback()->Unit_HasCommands(unit->GetId())) {
					IssueForm(unit);
				}
			}
			formedCount = formed;
			const bool timedOut = (frame - stateFrame) > formTimeout + assemblyTravelFrames;
            const bool ready = float(formed) >= (safeFlight ? assemblyFraction : WAVE_FORMED_FRACTION) * float(units.size());
            if (safeFlight && timedOut && !ready) {
                circuit->LOG("WAVE: assembly incomplete formed=%i total=%zu radius=%.0f", formed, units.size(), assemblyRadius);
                ReturnHome("assembly incomplete"); return;
            }
			if (ready || timedOut) {
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

            if (safeFlight) {
                for (CCircuitUnit* unit : units) {
                    auto shot = releasedAt.find(unit);
                    if (shot != releasedAt.end() && frame - shot->second >= FRAMES_PER_SEC * 3 && !outbound.count(unit)) {
                        outbound.insert(unit);
                        unit->TrySetFireState(CCircuitDef::FireType::HOLD);
                        TRY_UNIT(circuit, unit, unit->CmdMoveTo(EndPos(unit), 0, frame + WAVE_ATTACK_TIMEOUT);)
                    }
                }
                if (outbound.size() == units.size()) {
                    bool past = true;
                    for (CCircuitUnit* unit : units) if (!IsPastAim(unit, frame)) { past = false; break; }
                    if (past) { ReturnHome("pass complete"); return; }
                }
            }
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
                if (safeFlight) { ReturnHome(why); return; }
				circuit->LOG("WAVE: run over (%s) with %zu survivors; releasing to native bombing", why, units.size());
				EnterState(EState::DONE);
				manager->AbortTask(this);
				return;
			}
		} break;

        case EState::RETURNING: {
            bool home = true;
            for (CCircuitUnit* unit : units) if (unit->GetPos(frame).SqDistance2D(returnPos) > SQUARE(600.f)) { home = false; break; }
            if (home || frame - stateFrame > WAVE_ATTACK_TIMEOUT) {
                circuit->LOG("WAVE: returned alive=%zu reachedHome=%i", units.size(), home);
                EnterState(EState::DONE);
                manager->AbortTask(this);
                return;
            }
        } break;

		default: break;
	}
}

} // namespace circuit

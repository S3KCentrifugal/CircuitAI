/*
 * RouteTask.cpp
 *
 * See RouteTask.h. Orders default to moves (CmdMoveTo) queued with SHIFT so the
 * engine walks the waypoints in order. Ordinary spam fires while travelling;
 * opt-in standoff units pause the route to hold weapon range during contact.
 * Specialist routes can finish with fight; patrol mode loops patrol points.
 */

#include "task/fighter/RouteTask.h"
#include "module/MilitaryManager.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitUnit.h"
#include "unit/enemy/EnemyUnit.h"
#include "CircuitAI.h"
#include "spring/SpringCallback.h"
#include "spring/CustomCommand.h"
#include "spring/SpringUnit.h"
#include "util/Utils.h"

#include "AISCommands.h"
#include "Log.h"

#include <algorithm>
#include <cmath>
#include <limits>

namespace circuit {

using namespace springai;

CRouteTask::CRouteTask(ITaskModule* mgr)
		: IFighterTask(mgr, FightType::ROUTE, 1.f)
		, laneCount(1)
		, laneSpacing(0.f)
		, laneEndSpread(0.f)
		, laneDealt(0)
		, version(0)
		, dirty(false)
		, arriveRadius(SQUARE_SIZE * 32)
{
}

CRouteTask::~CRouteTask()
{
}

bool CRouteTask::CanAssignTo(CCircuitUnit* unit) const
{
	return true;  // script decides membership
}

void CRouteTask::AssignTo(CCircuitUnit* unit)
{
	IFighterTask::AssignTo(unit);
    hadAssignee = true;
	// Deal lanes from the centre outwards: 0, +1, -1, +2, -2 ... so a small
	// stream still straddles the line rather than drifting to one side.
	const unsigned int k = laneDealt++ % std::max(1, laneCount);
	const int lane = (k == 0) ? 0 : (((k % 2) == 1) ? int((k + 1) / 2) : -int(k / 2));
	lanes[unit] = lane;
}

void CRouteTask::RemoveAssignee(CCircuitUnit* unit)
{
    if (seaTarget >= 0) {
        // BAR accepts an ID-specific cancel, including pending out-of-range
        // targets. Do not cancel a player's replacement priority list.
        TRY_UNIT(manager->GetCircuit(), unit,
            float params[] = {float(seaTarget)};
            SendCustomCommand(manager->GetCircuit()->GetSkirmishAIId(), unit->GetId(), CMD_UNIT_CANCEL_TARGET, params);
        )
        unit->TrySetFireState(unit->GetCircuitDef()->GetFireState());
    }
	// The task belongs to a factory and outlives its units; script aborts it
	// when the factory is gone. Fighter tasks have no timeout, so an empty
	// route task simply idles in the update list.
	IFighterTask::RemoveAssignee(unit);
	lanes.erase(unit);
	unitRoutes.erase(unit);
    unitArrival.erase(unit);
	issuing.erase(unit);
	lastIssue.erase(unit);
	retryUnits.erase(unit);
	engaging.erase(unit);
    issuedVersion.erase(unit);
    if (holdPosition) unit->TrySetMoveState(unit->GetCircuitDef()->GetMoveState());
    if (ManagedControl() && hadAssignee && units.empty()) manager->AbortTask(this);
}

void CRouteTask::SetLanes(int count, float spacing, float endSpread)
{
	laneCount = std::max(1, count);
	laneSpacing = std::max(0.f, spacing);
	laneEndSpread = std::min(1.f, std::max(0.f, endSpread));
}

void CRouteTask::SetTraversal(bool preserve, float radius, bool fight)
{
	preserveWaypoints = preserve;
	arriveRadius = std::isfinite(radius) ? std::clamp(radius, 16.f, 512.f) : 48.f;
	fightAtEnd = fight;
}

int CRouteTask::LaneOf(CCircuitUnit* unit) const
{
	auto it = lanes.find(unit);
	return (it == lanes.end()) ? 0 : it->second;
}

AIFloat3 CRouteTask::LanePoint(CCircuitUnit* unit, unsigned int idx) const
{
	const auto& route = RouteFor(unit);
	if (unitRoutes.count(unit)) return route[idx];
	const AIFloat3& p = route[idx];
	const int lane = LaneOf(unit);
	if ((lane == 0) || (laneSpacing <= 0.f) || (route.size() < 2)) {
		return p;
	}
	// Sideways is perpendicular to the leg arriving at this point (for the
	// first point, the leg leaving it), so the band follows the line's bends.
	const AIFloat3& a = route[(idx == 0) ? 0 : idx - 1];
	const AIFloat3& b = route[(idx == 0) ? 1 : idx];
	AIFloat3 dir(b.x - a.x, 0.f, b.z - a.z);
	const float len = std::sqrt(dir.x * dir.x + dir.z * dir.z);
	if (len < 1.f) {
		return p;
	}
	const float scale = (idx + 1 == route.size()) ? laneEndSpread : 1.f;
	const float off = laneSpacing * float(lane) * scale;
	AIFloat3 out(p.x + (-dir.z / len) * off, p.y, p.z + (dir.x / len) * off);
	CTerrainManager::CorrectPosition(out);
	// Formation offsets can cross a coast even when the centre route is legal.
	// Both land spam and SEA collapse that member to the route instead of
	// issuing an unreachable cliff/coast order. This uses the existing movement
	// area lookup, not a new path query; aircraft have no restricted area.
	if (!manager->GetCircuit()->GetTerrainManager()->CanMoveToPos(unit->GetArea(), out)) return p;
	return out;
}

void CRouteTask::Start(CCircuitUnit* unit)
{
    if (holdPosition) unit->TrySetMoveState(CCircuitDef::MoveType::HOLD_POS);
	IssueRoute(unit, 0);
}

void CRouteTask::Update()
{
	const bool changed = dirty;
	dirty = false;
	// The route changed, which means the destination changed: send everything
	// already in the air straight at the new one. Re-running the new lane from
	// its nearest waypoint would walk units backwards to pick the lane up,
	// and a spam unit's value is pressure and vision forward, not formation.
	// Units produced after this still get the full lane from Start().
	for (CCircuitUnit* unit : units) {
		CCircuitAI* circuit = manager->GetCircuit();
		CCircuitDef* def = unit->GetCircuitDef();
		CEnemyInfo* nearest = nullptr;
		float nearestSq = SQUARE(def->GetMaxRange() * 1.1f);
		if (def->GetStandoff() > 0.f && !(seaControl && holdPosition)) {
			const AIFloat3 here = unit->GetPos(circuit->GetLastFrame());
			for (const auto& kv : circuit->GetEnemyInfos()) {
				CEnemyInfo* enemy = kv.second;
				const CCircuitDef* edef = enemy->GetCircuitDef();
				if (enemy->IsHidden() || !enemy->IsInRadarOrLOS() || edef == nullptr
						|| !(edef->GetCategory() & def->GetTargetCategory())
						|| (!def->HasSurfToWater() && enemy->GetPos().y < -SQUARE_SIZE * 5)) continue;
				const float sq = here.SqDistance(enemy->GetPos());
				if (sq < nearestSq) { nearestSq = sq; nearest = enemy; }
			}
		}
		if (nearest != nullptr) {
			if (engaging.insert(unit).second) { // before Stop can cause an idle callback
				circuit->LOG("RANGE: %s(%i) pauses route at %.0f for weapon range %.0f",
						def->GetDef()->GetName(), unit->GetId(), std::sqrt(nearestSq), def->GetMaxRange());
			}
			if (unit->KeepWeaponRange(nearest, circuit->GetLastFrame() + FRAMES_PER_SEC * 10)) continue;
		}
		const bool resume = engaging.erase(unit) != 0;
		if (resume) circuit->LOG("RANGE: %s(%i) resumes specialist route", def->GetDef()->GetName(), unit->GetId());
        bool retry=retryUnits.count(unit) && circuit->GetLastFrame()-lastIssue[unit]>=FRAMES_PER_SEC;
        if (ManagedControl() && retry && circuit->GetCallback()->Unit_HasCommands(unit->GetId())) {
            // Idle events can describe an order just replaced by another
            // callback. Preserve that live queue; only repair an empty one.
            retryUnits.erase(unit);
            retry = false;
        }
        if (!changed && !resume && !retry) continue;
        if (ManagedControl() && !resume && !retry && issuedVersion.count(unit) && issuedVersion[unit] == version) continue;
        retryUnits.erase(unit);
        if (!changed && !resume && !ManagedControl() && IsAtEnd(unit)) continue;
		if (patrol) IssueRoute(unit, 0);
		else if (preserveWaypoints) IssueRoute(unit, NearestAheadIndex(unit));
		else IssueDirect(unit);
	}
}

void CRouteTask::OnUnitIdle(CCircuitUnit* unit)
{
	if (issuing.count(unit) != 0) return;
    // A rejected/zero-length waypoint can synchronously idle again. Bound
    // opt-in exact routes instead of filling the engine's command/event queues.
	if (engaging.count(unit) != 0) return;  // Update owns contact loss and lane resumption.
	if (patrol && !route.empty()) {
		if (ManagedControl()) { retryUnits.insert(unit); return; }
		IssueRoute(unit, 0);
		return;
	}
	if (route.empty() || IsAtEnd(unit)) {
		return;  // holding at the destination; weapons keep firing on their own
	}
    if (preserveWaypoints) { retryUnits.insert(unit); return; }
	// Stuck or the queue was cleared: continue from the nearest waypoint ahead
	IssueRoute(unit, NearestAheadIndex(unit));
}

void CRouteTask::OnUnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker)
{
	if (seaControl) IFighterTask::OnUnitDamaged(unit, attacker);
	// No retreat: spam trades bodies for pressure.
}

bool CRouteTask::SetSeaTarget(int id)
{
    if (!seaControl) return false;
    auto* circuit = manager->GetCircuit();
    if (id >= 0) {
        const auto* enemy = circuit->GetEnemyInfo(id);
        if (enemy == nullptr || !enemy->IsInRadarOrLOS() || enemy->GetCircuitDef() == nullptr
            || !enemy->GetCircuitDef()->IsAbleToFly()) return false;
        const auto data = enemy->GetData()->GetData();
        if (data.losStatus & (SEnemyData::LosMask::HIDDEN | SEnemyData::LosMask::NEUTRAL
            | SEnemyData::LosMask::DYING | SEnemyData::LosMask::DEAD)) return false;
        if (data.IsIgnore() && (!enemy->GetCircuitDef()->IsIgnore()
            || enemy->GetUnit()->GetRulesParamFloat("ignoredByAI", 0.f) > 0.f)) return false;
    }
    if (id == seaTarget) return true;
    // Explicit SEA opt-in: do not enable CircuitUnit's shared CmdSetTarget stub.
    // BAR's priority-fire command leaves the MOVE/patrol queue intact. Issue on
    // target transitions only; script reacquires legal contacts each census.
    for (auto* unit : units) {
        if (!unit->GetCircuitDef()->HasSurfToAir()) continue;
        TRY_UNIT(circuit, unit,
            if (id >= 0) {
                float params[] = {float(id)};
                SendCustomCommand(circuit->GetSkirmishAIId(), unit->GetId(), CMD_UNIT_SET_TARGET, params);
                unit->TrySetFireState(CCircuitDef::FireType::OPEN);
            } else if (seaTarget >= 0) {
                float params[] = {float(seaTarget)};
                SendCustomCommand(circuit->GetSkirmishAIId(), unit->GetId(), CMD_UNIT_CANCEL_TARGET, params);
                unit->TrySetFireState(unit->GetCircuitDef()->GetFireState());
            }
        )
    }
    seaTarget = id;
    return true;
}

void CRouteTask::SetRoute(std::vector<AIFloat3>&& waypoints)
{
    if (ManagedControl() && unitRoutes.empty() && waypoints.size() == route.size()
        && std::equal(route.begin(), route.end(), waypoints.begin(), [](const AIFloat3& a, const AIFloat3& b) {
            return a.x == b.x && a.y == b.y && a.z == b.z;
        })) return;
	unitRoutes.clear();
    unitArrival.clear();
	route = std::move(waypoints);
	++version;
	dirty = !route.empty();
	if (!route.empty()) {
		position = route.back();
	}
}

bool CRouteTask::IsAtEnd(CCircuitUnit* unit) const
{
	const auto& route = RouteFor(unit);
	if (route.empty()) {
		return true;
	}
	const int frame = manager->GetCircuit()->GetLastFrame();
	const auto it=unitArrival.find(unit);
    const float radius=it==unitArrival.end() ? arriveRadius : it->second;
    return unit->GetPos(frame).SqDistance2D(route.back()) < SQUARE(radius);
}

unsigned int CRouteTask::NearestAheadIndex(CCircuitUnit* unit) const
{
	const auto& route = RouteFor(unit);
	// Nearest waypoint, then the one after it unless it is the last: a unit
	// standing on waypoint k should head for k+1.
	if (route.empty()) {
		return 0;
	}
	const int frame = manager->GetCircuit()->GetLastFrame();
	const AIFloat3& pos = unit->GetPos(frame);
	unsigned int best = 0;
	float bestSq = std::numeric_limits<float>::max();
	for (unsigned int i = 0; i < route.size(); ++i) {
		const float sq = pos.SqDistance2D(route[i]);
		if (sq < bestSq) {
			bestSq = sq;
			best = i;
		}
	}
	if ((best + 1 < route.size()) && (bestSq < SQUARE(arriveRadius))) {
		++best;
	}
	return best;
}

void CRouteTask::IssueDirect(CCircuitUnit* unit)
{
	const auto& route = RouteFor(unit);
	if (route.empty()) {
		return;
	}
	CCircuitAI* circuit = manager->GetCircuit();
	TRY_UNIT(circuit, unit,
		unit->CmdWantedSpeed(NO_SPEED_LIMIT);
		unit->CmdMoveTo(LanePoint(unit, route.size() - 1), 0, circuit->GetLastFrame() + FRAMES_PER_SEC * 600);
	)
}

void CRouteTask::IssueRoute(CCircuitUnit* unit, unsigned int fromIdx)
{
    if (airControl && airTarget >= 0) {
        auto* circuit = manager->GetCircuit();
        auto* enemy = circuit->GetEnemyInfo(airTarget);
        if (enemy != nullptr && !enemy->IsHidden() && enemy->IsInRadarOrLOS()) {
            if (!issuing.insert(unit).second) return;
            TRY_UNIT(circuit, unit, unit->Attack(enemy, false, circuit->GetLastFrame() + FRAMES_PER_SEC * 3600, false);)
            issuing.erase(unit); issuedVersion[unit] = version; lastIssue[unit] = circuit->GetLastFrame();
            return;
        }
    }
	const auto& route = RouteFor(unit);
	if (route.empty()) {
		return;
	}
	CCircuitAI* circuit = manager->GetCircuit();
	if (!issuing.insert(unit).second) return;
	lastIssue[unit]=circuit->GetLastFrame();
	const int timeout = circuit->GetLastFrame() + FRAMES_PER_SEC * 600;
	TRY_UNIT(circuit, unit,
		unit->CmdWantedSpeed(NO_SPEED_LIMIT);
		for (unsigned int i = fromIdx; i < route.size(); ++i) {
			const short options = (i == fromIdx) ? 0 : UNIT_COMMAND_OPTION_SHIFT_KEY;
			if (patrol && i > fromIdx) unit->CmdPatrolTo(LanePoint(unit, i), options, timeout);
			else if (fightAtEnd && i + 1 == route.size()) unit->CmdFightTo(LanePoint(unit, i), options, timeout);
			else unit->CmdMoveTo(LanePoint(unit, i), options, timeout);
		}
	)
	issuing.erase(unit);
    if (ManagedControl()) issuedVersion[unit] = version;
}

const std::vector<AIFloat3>& CRouteTask::RouteFor(CCircuitUnit* unit) const
{
    const auto it=unitRoutes.find(unit);
    return it==unitRoutes.end() ? route : it->second;
}

bool CRouteTask::SetUnitRoute(CCircuitUnit* unit, std::vector<AIFloat3>&& points, float radius)
{
    if (unit==nullptr || units.count(unit)==0 || points.empty() || !std::isfinite(radius)) return false;
    for (const auto& p:points) if (!std::isfinite(p.x) || !std::isfinite(p.y) || !std::isfinite(p.z)) return false;
    unitRoutes[unit]=std::move(points);
    unitArrival[unit]=std::clamp(radius,16.f,512.f);
    IssueRoute(unit,0);
    return true;
}

} // namespace circuit

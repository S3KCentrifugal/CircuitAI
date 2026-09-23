/*
 * FerryTask.cpp
 *
 * See FerryTask.h.
 *
 * Every state carries a deadline. Transports in Spring fail to load for
 * reasons the AI cannot observe - capacity, unit mass, the cargo walking away
 * mid-approach - and there is no "am I carrying something" accessor in the C++
 * wrapper, so the load is verified positionally: a loaded unit's position
 * tracks its transport. Without deadlines a failed pick-up would hang the
 * transport for the rest of the game, which is strictly worse than the walk it
 * was meant to replace.
 */

#include "task/fighter/FerryTask.h"
#include "module/MilitaryManager.h"
#include "module/BuilderManager.h"
#include "terrain/TerrainManager.h"
#include "spring/SpringCallback.h"
#include "unit/CircuitUnit.h"
#include "unit/CircuitDef.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "AISCommands.h"
#include "Log.h"
#include "spring/SpringMap.h"

namespace circuit {

using namespace springai;

// Deadlines per state, in frames.
#define FERRY_TRAVEL_TIMEOUT	(FRAMES_PER_SEC * 90)
#define FERRY_LOAD_TIMEOUT		(FRAMES_PER_SEC * 20)
#define FERRY_UNLOAD_TIMEOUT	(FRAMES_PER_SEC * 20)
// A carried unit sits at the transport's own position in the horizontal
// plane - but so does a unit the transport is hovering over, about to load.
// 2D distance cannot tell those apart, and treating it as "loaded" made the
// task issue the flight to the drop one tick after issuing the load, which
// cancelled the load and flew the transport off empty (then reported a clean
// delivery, because the "landed" test was the same check inverted). What
// distinguishes the two is height: a loaded ground unit is lifted off the
// terrain, an unloaded one is on it. So the load and unload tests are on the
// cargo's height above ground, with the 2D proximity kept only as a sanity
// check on the load side.
#define FERRY_LOADED_DIST		(SQUARE_SIZE * 4)
// Any lift at all. An Atlas hovers low with its load until it is told to
// move; the old 24-elmo bar was never cleared, the load "did not take" and
// the cargo was given away hanging under the transport (D-056).
#define FERRY_LIFT_HEIGHT		(SQUARE_SIZE / 2)
#define FERRY_GROUND_TOLERANCE	1.f
#define FERRY_LANDED_TICKS		2
// Close enough to the drop to issue the unload.
#define FERRY_DROP_DIST			(SQUARE_SIZE * 12)
#define FERRY_LOAD_RETRIES		2
#define FERRY_UNLOAD_RETRIES	2
// Landing-spot search around the drop; doubled per unload retry.
#define FERRY_LAND_SEARCH		(SQUARE_SIZE * 40)
// How long the cargo is parked once a run starts. Longer than any run: the
// script gives the unit away at the end of every path, which ends the wait.
// Longer than every state deadline of a run added up (travel 90 + 3 x load 20
// + travel 90 + 3 x unload 20 + dump 40 = 340 s) and renewed on each retry,
// so the cargo never takes build orders while the ferry still owns it (CR-024).
#define FERRY_HOLD_FRAMES		(FRAMES_PER_SEC * 600)

CFerryTask::CFerryTask(ITaskModule* mgr)
		: IFighterTask(mgr, FightType::FERRY, 1.f)
		, state_(EState::IDLE)
		, unloadRetries(0)
		, landPos(-RgtVector)
		, cargoId(-1)
		, dropPos(-RgtVector)
		, holdPos(-RgtVector)
		, stateFrame(0)
		, loadRetries(0)
{
}

CFerryTask::~CFerryTask()
{
}

bool CFerryTask::CanAssignTo(CCircuitUnit* unit) const
{
	// One transport per task: the sequence below tracks a single carrier.
	return units.empty() && (unit->GetCircuitDef() != nullptr) && unit->GetCircuitDef()->IsRoleTrans();
}

void CFerryTask::RemoveAssignee(CCircuitUnit* unit)
{
	IFighterTask::RemoveAssignee(unit);
	if (units.empty()) {
		// The transport died. Latch FAILED so script stops waiting on a run
		// that can no longer finish and falls back to walking the cargo.
		if ((state_ != EState::IDLE) && (state_ != EState::DONE)) {
			state_ = EState::FAILED;
		}
		manager->AbortTask(this);
	}
}

CCircuitUnit* CFerryTask::GetTransport() const
{
	return units.empty() ? nullptr : *units.begin();
}

CCircuitUnit* CFerryTask::GetCargo() const
{
	return (cargoId < 0) ? nullptr : manager->GetCircuit()->GetTeamUnit(cargoId);
}

bool CFerryTask::IsLifted(CCircuitUnit* cargo, int frame) const
{
	CCircuitAI* circuit = manager->GetCircuit();
	const AIFloat3& pos = cargo->GetPos(frame);
	const float ground = circuit->GetMap()->GetElevationAt(pos.x, pos.z);
	return (pos.y - ground) > FERRY_LIFT_HEIGHT;
}

void CFerryTask::Enter(EState next)
{
	state_ = next;
	stateFrame = manager->GetCircuit()->GetLastFrame();
}

bool CFerryTask::IsExpired(int frame) const
{
	int limit;
	switch (state_) {
		case EState::LOADING:	limit = FERRY_LOAD_TIMEOUT;		break;
		case EState::UNLOADING:	limit = FERRY_UNLOAD_TIMEOUT;	break;
		case EState::DUMPING:	limit = FERRY_UNLOAD_TIMEOUT * 2;	break;
		default:				limit = FERRY_TRAVEL_TIMEOUT;	break;
	}
	return (frame - stateFrame) > limit;
}

AIFloat3 CFerryTask::FindLandingSpot(CCircuitUnit* cargo, const AIFloat3& around, float radius) const
{
	CCircuitAI* circuit = manager->GetCircuit();
	if ((cargo == nullptr) || (cargo->GetCircuitDef()->GetDef() == nullptr)) {
		return around;
	}
	// D-091: FindClosestBuildSite with a mobile def ignored the buildings and
	// water around an ally's start and returned the same refused spot on every
	// retry (played: `dump retry 9 ... at (11488, 4720)`). Our search: the
	// cargo's move type reaches it, no structure covers it, and never a spot
	// the engine already refused.
	const AIFloat3 spot = circuit->GetTerrainManager()->FindDropSpot(cargo, around, radius, refusedDrops, SQUARE_SIZE * 8);
	if (geom::is_valid(spot)) {
		return spot;
	}
	circuit->LOG("FERRY: no standing room for cargo %i within %.0f of (%.0f, %.0f)", cargoId, radius, around.x, around.z);
	return around;
}

// D-091: the cargo stands on a factory's footprint (just rolled out, or parked
// there by HoldCargo's stop). yardPos is that factory's position.
bool CFerryTask::OnFactoryYard(CCircuitUnit* cargo, int frame)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const AIFloat3& p = cargo->GetPos(frame);
	for (int id : circuit->GetCallback()->GetFriendlyUnitIdsIn(p, SQUARE_SIZE * 12, false)) {
		CCircuitUnit* u = circuit->GetTeamUnit(id);
		if ((u == nullptr) || (u == cargo) || u->GetCircuitDef()->IsMobile() || !u->GetCircuitDef()->IsBuilder()) {
			continue;
		}
		const AIFloat3& f = u->GetPos(frame);
		const float hx = u->GetCircuitDef()->GetDef()->GetXSize() * SQUARE_SIZE * 0.5f;
		const float hz = u->GetCircuitDef()->GetDef()->GetZSize() * SQUARE_SIZE * 0.5f;
		if ((std::fabs(p.x - f.x) <= hx) && (std::fabs(p.z - f.z) <= hz)) {
			yardPos = f;
			return true;
		}
	}
	return false;
}

void CFerryTask::HoldCargo(CCircuitUnit* cargo)
{
	CCircuitAI* circuit = manager->GetCircuit();
	CBuilderManager* builderMgr = circuit->GetBuilderManager();
	if ((cargo == nullptr) || (cargo->GetManager() != builderMgr)) {
		return;
	}
	IUnitTask* wait = builderMgr->Enqueue(TaskB::Wait(FERRY_HOLD_FRAMES));
	if (wait != nullptr) {
		builderMgr->AssignTask(cargo, wait);
	}
	TRY_UNIT(circuit, cargo,
		cargo->CmdStop();
	)
}

void CFerryTask::Fail(const char* why)
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	CCircuitUnit* transport = GetTransport();
	CCircuitUnit* cargo = GetCargo();
	// Still carrying it: set it down first. Giving a unit away while it hangs
	// under our transport is what the "transferred without delivery" report
	// was - the recipient owned a constructor it could not use and we kept
	// flying it around.
	if ((state_ != EState::DUMPING) && (transport != nullptr) && (cargo != nullptr) && IsLifted(cargo, frame)) {
		landPos = FindLandingSpot(cargo, transport->GetPos(frame), FERRY_LAND_SEARCH * 3);
		circuit->LOG("FERRY: run failed (%s) | cargo=%i state=%i; setting it down at (%.0f, %.0f)",
				why, cargoId, int(state_), landPos.x, landPos.z);
		TRY_UNIT(circuit, transport,
			transport->CmdUnloadUnit(landPos, cargo, 0, frame + FERRY_UNLOAD_TIMEOUT * 2);
		)
		Enter(EState::DUMPING);
		return;
	}
	circuit->LOG("FERRY: run failed (%s) | cargo=%i state=%i", why, cargoId, int(state_));
	cargoId = -1;
	Enter(EState::FAILED);
	if ((transport != nullptr) && geom::is_valid(holdPos)) {
		GoTo(transport, holdPos);
	}
}

void CFerryTask::GoTo(CCircuitUnit* unit, const AIFloat3& pos)
{
	CCircuitAI* circuit = manager->GetCircuit();
	TRY_UNIT(circuit, unit,
		unit->CmdMoveTo(pos, 0, circuit->GetLastFrame() + FERRY_TRAVEL_TIMEOUT);
	)
}

void CFerryTask::SetHoldPos(const AIFloat3& pos)
{
	holdPos = pos;
	if (state_ == EState::IDLE) {
		CCircuitUnit* transport = GetTransport();
		if ((transport != nullptr) && geom::is_valid(holdPos)) {
			GoTo(transport, holdPos);
		}
	}
}

bool CFerryTask::SetCargo(int id, const AIFloat3& pos)
{
	if ((state_ != EState::IDLE) && (state_ != EState::DONE) && (state_ != EState::FAILED)) {
		return false;  // a run is already in flight
	}
	CCircuitUnit* cargo = manager->GetCircuit()->GetTeamUnit(id);
	if ((cargo == nullptr) || !geom::is_valid(pos)) {
		return false;
	}
	cargoId = id;
	dropPos = pos;
	landPos = -RgtVector;
	loadRetries = 0;
	unloadRetries = 0;
	landedTicks = 0;
	groundTicks = 0;
	refusedDrops.clear();
	Enter(EState::TO_CARGO);
	HoldCargo(cargo);
	CCircuitUnit* transport = GetTransport();
	if (transport != nullptr) {
		GoTo(transport, cargo->GetPos(manager->GetCircuit()->GetLastFrame()));
	}
	return true;
}

void CFerryTask::Reset()
{
	cargoId = -1;
	landPos = -RgtVector;
	unloadRetries = 0;
	Enter(EState::IDLE);
	CCircuitUnit* transport = GetTransport();
	if ((transport != nullptr) && geom::is_valid(holdPos)) {
		GoTo(transport, holdPos);
	}
}

void CFerryTask::Start(CCircuitUnit* unit)
{
	if (geom::is_valid(holdPos)) {
		GoTo(unit, holdPos);
	}
}

void CFerryTask::OnUnitIdle(CCircuitUnit* unit)
{
	// Update() re-issues whatever the current state needs; going idle mid-run
	// is normal (a move order completes before the state advances).
}

void CFerryTask::Update()
{
	CCircuitAI* circuit = manager->GetCircuit();
	const int frame = circuit->GetLastFrame();
	CCircuitUnit* transport = GetTransport();
	if (transport == nullptr) {
		return;
	}

	switch (state_) {
		case EState::IDLE:
		case EState::DONE:
		case EState::FAILED: {
			return;  // waiting on script
		} break;

		case EState::TO_CARGO: {
			CCircuitUnit* cargo = GetCargo();
			if (cargo == nullptr) {
				Fail("cargo gone");
				return;
			}
			const AIFloat3& cPos = cargo->GetPos(frame);
			// D-091: a unit still being built, or still on its factory's yard, cannot
			// be loaded (played: the transport hovered at the lab trying to lift a
			// constructor that was not out yet); the transport waits beside it and the
			// cargo is walked off the yard first
			if (cargo->GetUnit()->IsBeingBuilt()) {
				stateFrame = frame;  // waiting on the factory is not a failure to reach
				GoTo(transport, cPos);
				return;
			}
			if (OnFactoryYard(cargo, frame)) {
				stateFrame = frame;
				float dx = cPos.x - yardPos.x, dz = cPos.z - yardPos.z;
				const float len = std::sqrt(dx * dx + dz * dz);
				if (len < 1.f) { dx = 0.f; dz = 1.f; } else { dx /= len; dz /= len; }
				const AIFloat3 away(cPos.x + dx * 160.f, cPos.y, cPos.z + dz * 160.f);
				const AIFloat3 out = circuit->GetTerrainManager()->FindDropSpot(cargo, away, 240.f, {}, 0.f);
				if (geom::is_valid(out)) {
					TRY_UNIT(circuit, cargo,
						cargo->CmdMoveTo(out, 0, frame + FRAMES_PER_SEC * 20);
					)
				}
				GoTo(transport, cPos);
				return;
			}
			if (transport->GetPos(frame).SqDistance2D(cPos) < SQUARE(FERRY_DROP_DIST)) {
				// D-091: only the load; the flight to the drop is ordered once the
				// cargo is seen lifted (played: a load the engine refused left the queued
				// move to fly the transport off empty)
				TRY_UNIT(circuit, transport,
					transport->CmdLoadUnits({cargo}, 0, frame + FERRY_LOAD_TIMEOUT);
				)
				Enter(EState::LOADING);
			} else if (IsExpired(frame)) {
				Fail("could not reach cargo");
			} else {
				GoTo(transport, cPos);  // the cargo may have moved
			}
		} break;

		case EState::LOADING: {
			CCircuitUnit* cargo = GetCargo();
			if (cargo == nullptr) {
				Fail("cargo gone while loading");
				return;
			}
			// No wrapper accessor reports the carrier, so infer it: a loaded
			// unit is off the ground and at the transport's position. Height is
			// the part that matters - see FERRY_LIFT_HEIGHT.
			if (IsLifted(cargo, frame)
				&& (cargo->GetPos(frame).SqDistance2D(transport->GetPos(frame)) < SQUARE(FERRY_LOADED_DIST)))
			{
				Enter(EState::TO_DROP);
				GoTo(transport, dropPos);
			} else if (IsExpired(frame)) {
				if (++loadRetries > FERRY_LOAD_RETRIES) {
					Fail("load did not take");
				} else {
					circuit->LOG("FERRY: load retry %i for cargo %i", loadRetries, cargoId);
					HoldCargo(cargo);  // renew the park (CR-024)
					Enter(EState::TO_CARGO);
				}
			}
		} break;

		case EState::TO_DROP: {
			if (GetCargo() == nullptr) {
				Fail("cargo lost in flight");
				return;
			}
			// D-091: never fly on without it: the cargo on the ground for two updates
			// means the load did not hold; back to it and load again
			if (unloadRetries == 0) {
				groundTicks = IsLifted(GetCargo(), frame) ? 0 : (groundTicks + 1);
				if (groundTicks >= 2) {
					groundTicks = 0;
					if (++loadRetries > FERRY_LOAD_RETRIES) {
						Fail("cargo not carried");
						return;
					}
					circuit->LOG("FERRY: cargo %i is not aboard; back to load it (retry %i)", cargoId, loadRetries);
					Enter(EState::TO_CARGO);
					GoTo(transport, GetCargo()->GetPos(frame));
					return;
				}
			}
			if (transport->GetPos(frame).SqDistance2D(dropPos) < SQUARE(FERRY_DROP_DIST)) {
				CCircuitUnit* cargo = GetCargo();
				if (!geom::is_valid(landPos)) {
					landPos = FindLandingSpot(cargo, dropPos, FERRY_LAND_SEARCH);
					if (landPos.SqDistance2D(dropPos) > SQUARE(SQUARE_SIZE * 2)) {
						circuit->LOG("FERRY: drop (%.0f, %.0f) is occupied; landing cargo %i at (%.0f, %.0f)",
								dropPos.x, dropPos.z, cargoId, landPos.x, landPos.z);
					}
				}
				TRY_UNIT(circuit, transport,
					transport->CmdUnloadUnit(landPos, cargo, 0, frame + FERRY_UNLOAD_TIMEOUT);
				)
				Enter(EState::UNLOADING);
			} else if (IsExpired(frame)) {
				Fail("could not reach drop");
			}
		} break;

		case EState::UNLOADING: {
			CCircuitUnit* cargo = GetCargo();
			if (cargo == nullptr) {
				Fail("cargo gone while unloading");
				return;
			}
			// Landed when the cargo sits on the ground - exactly, for two
			// updates running. A hanging unit is never exactly on the ground,
			// and the engine does not detach a unit that changes team, so a
			// give one update early would leave it under our transport (D-056).
			const AIFloat3& cPos = cargo->GetPos(frame);
			const bool onGround = (cPos.y - circuit->GetMap()->GetElevationAt(cPos.x, cPos.z)) < FERRY_GROUND_TOLERANCE;
			landedTicks = onGround ? (landedTicks + 1) : 0;
			if (landedTicks >= FERRY_LANDED_TICKS) {
				circuit->LOG("FERRY: delivered cargo %i at (%.0f, %.0f)", cargoId, landPos.x, landPos.z);
				Enter(EState::DONE);
				// Head home without waiting for script: the run is over either
				// way, and the transport is the thing worth recovering.
				if (geom::is_valid(holdPos)) {
					GoTo(transport, holdPos);
				}
			} else if (IsExpired(frame)) {
				if (++unloadRetries > FERRY_UNLOAD_RETRIES) {
					Fail("unload did not take");
				} else {
					// The spot was not clear after all (a unit walked onto it, the
					// engine disagreed). Widen the search from where we hover.
					refusedDrops.push_back(landPos);  // D-091: never this spot again
					landPos = FindLandingSpot(cargo, transport->GetPos(frame), FERRY_LAND_SEARCH * (unloadRetries + 1));
					dropPos = landPos;
					circuit->LOG("FERRY: unload retry %i for cargo %i at (%.0f, %.0f)", unloadRetries, cargoId, landPos.x, landPos.z);
					Enter(EState::TO_DROP);
					GoTo(transport, landPos);
				}
			}
		} break;

		case EState::DUMPING: {
			CCircuitUnit* cargo = GetCargo();
			if ((cargo == nullptr) || !IsLifted(cargo, frame)) {
				circuit->LOG("FERRY: cargo %i set down after a failed run (%s)", cargoId, (cargo == nullptr) ? "gone" : "on the ground");
				cargoId = -1;
				Enter(EState::FAILED);
				if (geom::is_valid(holdPos)) {
					GoTo(transport, holdPos);
				}
			} else if (IsExpired(frame)) {
				// Still lifted: FAILED is never entered with live cargo under the
				// transport, since the script gives the cargo away on FAILED and
				// the engine does not detach a unit that changes team (CR-004).
				// Try a wider landing spot from wherever the transport hovers.
				++unloadRetries;
				refusedDrops.push_back(landPos);  // D-091
				landPos = FindLandingSpot(cargo, transport->GetPos(frame), FERRY_LAND_SEARCH * (unloadRetries + 1));
				circuit->LOG("FERRY: dump retry %i for cargo %i at (%.0f, %.0f); still lifted, not given", unloadRetries, cargoId, landPos.x, landPos.z);
				TRY_UNIT(circuit, transport,
					transport->CmdUnloadUnit(landPos, cargo, 0, frame + FERRY_UNLOAD_TIMEOUT * 2);
				)
				Enter(EState::DUMPING);
			}
		} break;

		default: break;
	}
}

} // namespace circuit

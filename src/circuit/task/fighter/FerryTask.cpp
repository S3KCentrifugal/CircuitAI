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
#include "unit/CircuitUnit.h"
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
#define FERRY_LIFT_HEIGHT		(SQUARE_SIZE * 3)
// Close enough to the drop to issue the unload.
#define FERRY_DROP_DIST			(SQUARE_SIZE * 12)
#define FERRY_LOAD_RETRIES		2

CFerryTask::CFerryTask(ITaskModule* mgr)
		: IFighterTask(mgr, FightType::FERRY, 1.f)
		, state_(EState::IDLE)
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
		default:				limit = FERRY_TRAVEL_TIMEOUT;	break;
	}
	return (frame - stateFrame) > limit;
}

void CFerryTask::Fail(const char* why)
{
	CCircuitAI* circuit = manager->GetCircuit();
	circuit->LOG("FERRY: run failed (%s) | cargo=%i state=%i", why, cargoId, int(state_));
	cargoId = -1;
	Enter(EState::FAILED);
	CCircuitUnit* transport = GetTransport();
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
	loadRetries = 0;
	Enter(EState::TO_CARGO);
	CCircuitUnit* transport = GetTransport();
	if (transport != nullptr) {
		GoTo(transport, cargo->GetPos(manager->GetCircuit()->GetLastFrame()));
	}
	return true;
}

void CFerryTask::Reset()
{
	cargoId = -1;
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
			if (transport->GetPos(frame).SqDistance2D(cPos) < SQUARE(FERRY_DROP_DIST)) {
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
					Enter(EState::TO_CARGO);
				}
			}
		} break;

		case EState::TO_DROP: {
			if (GetCargo() == nullptr) {
				Fail("cargo lost in flight");
				return;
			}
			if (transport->GetPos(frame).SqDistance2D(dropPos) < SQUARE(FERRY_DROP_DIST)) {
				CCircuitUnit* cargo = GetCargo();
				TRY_UNIT(circuit, transport,
					transport->CmdUnloadUnit(dropPos, cargo, 0, frame + FERRY_UNLOAD_TIMEOUT);
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
			// Landed when the cargo is back on the ground. Not "no longer at the
			// transport's position": a unit that was never picked up is also
			// not at the transport's position, and that read as delivered.
			if (!IsLifted(cargo, frame)) {
				circuit->LOG("FERRY: delivered cargo %i at (%.0f, %.0f)", cargoId, dropPos.x, dropPos.z);
				Enter(EState::DONE);
				// Head home without waiting for script: the run is over either
				// way, and the transport is the thing worth recovering.
				if (geom::is_valid(holdPos)) {
					GoTo(transport, holdPos);
				}
			} else if (IsExpired(frame)) {
				Fail("unload did not take");
			}
		} break;

		default: break;
	}
}

} // namespace circuit

/*
 * MoveAction.cpp
 *
 *  Created on: Jan 13, 2015
 *      Author: rlcevg
 */

#include "unit/action/MoveAction.h"
#include "unit/CircuitUnit.h"
#include "spring/SpringCallback.h"
#include "CircuitAI.h"
#include "util/Utils.h"

#include "AISCommands.h"

namespace circuit {

using namespace springai;

CMoveAction::CMoveAction(CCircuitUnit* owner, int squareSize, float speed)
		: ITravelAction(owner, Type::MOVE, squareSize, speed)
{
}

CMoveAction::CMoveAction(CCircuitUnit* owner, const std::shared_ptr<CPathInfo>& pPath,
		int squareSize, float speed)
		: ITravelAction(owner, Type::MOVE, pPath, squareSize, speed)
{
}

CMoveAction::~CMoveAction()
{
}

void CMoveAction::Update(CCircuitAI* circuit)
{
	if (lastFrame + FRAMES_PER_SEC > circuit->GetLastFrame()) {
		return;
	}
	CCircuitUnit* unit = static_cast<CCircuitUnit*>(ownerList);
	if (unit->IsJumping()) {
		return;
	}
	lastFrame = circuit->GetLastFrame();

	if (enginePath) {
		UpdateEnginePath(circuit, unit);
		return;
	}

	float stepSpeed;
	int pathMaxIndex = CalcSpeedStep(circuit, stepSpeed);
	switch (pathMaxIndex) {
		case -2:  // arrived
			TRY_UNIT(circuit, unit,
				unit->CmdMoveTo(pPath->posPath.back(), UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, lastFrame + FRAMES_PER_SEC * 60);
			)
			return;
		case -1: return;  // continue with current waypoints
		default: break;  // update waypoints
	}
	int step = pathIterator;

	TRY_UNIT(circuit, unit,
		constexpr short options = UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY | UNIT_COMMAND_OPTION_SHIFT_KEY;
		const AIFloat3& startPos = unit->GetPos(lastFrame);
		AIFloat3 nextPos;
		if (unit->IsAllowedToJump() && unit->IsJumpReady()) {
			const float range = unit->GetCircuitDef()->GetJumpRange();
			const float sqRange = SQUARE(range);
			for (; (step < pathMaxIndex) && (pPath->posPath[step].SqDistance2D(startPos) < sqRange); ++step);
			nextPos = pPath->posPath[std::max(0, step - 1)];
			const float sqJumpDist = nextPos.SqDistance2D(startPos);
			bool isBadJump = sqJumpDist < SQUARE(range * 0.5f);
			if (!isBadJump) {
				isBadJump = SQUARE(range * 1.2f) < sqJumpDist;
				if (isBadJump) {
					nextPos = startPos + (nextPos - startPos).Normalize2D() * range;
				}
				unit->CmdJumpTo(nextPos, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, lastFrame + FRAMES_PER_SEC * 300);
			}
			if (isBadJump) {
				nextPos = pPath->posPath[step];
				unit->CmdMoveTo(nextPos, options, lastFrame + FRAMES_PER_SEC * 300);
			}
		} else {
			nextPos = pPath->posPath[step];
			unit->CmdMoveTo(nextPos, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, lastFrame + FRAMES_PER_SEC * 300);
		}
		unit->CmdWantedSpeed(stepSpeed);

		if (!geom::is_in_range(startPos, nextPos, DUP_CMD_DIST)) {
			return;
		}
		for (int i = 2; (step < pathMaxIndex) && (i < 3); ++i) {
			step = std::min(step + increment, pathMaxIndex);
			const AIFloat3& pos = pPath->posPath[step];
			unit->CmdMoveTo(pos, options, lastFrame + FRAMES_PER_SEC * 60 * i);
		}
	)
}

void CMoveAction::UpdateEnginePath(CCircuitAI* circuit, CCircuitUnit* unit)
{
	if ((pPath == nullptr) || pPath->posPath.empty()) {
		return;
	}
	const int frame = lastFrame;
	const AIFloat3& goal = pPath->posPath.back();
	const AIFloat3& pos = unit->GetPos(frame);
	if (pos.SqDistance2D(goal) <= SQUARE(SQUARE_SIZE * 16)) {
		engineIssued = false;
		StateFinish();  // the task takes over at its target (OnTravelEnd)
		return;
	}
	if ((engineFrame >= 0) && (frame < engineFrame + FRAMES_PER_SEC * 3)) {
		return;  // normal cadence: at most one order every 3 s
	}
	const bool hasOrders = circuit->GetCallback()->Unit_HasCommands(unit->GetId());
	if (engineIssued && hasOrders && (frame < engineFrame + FRAMES_PER_SEC * 15)
		&& (goal.SqDistance2D(engineGoal) <= SQUARE(SQUARE_SIZE * 32)))
	{
		return;  // same goal, the engine is still walking it
	}
	TRY_UNIT(circuit, unit,
		unit->CmdMoveTo(goal, UNIT_COMMAND_OPTION_RIGHT_MOUSE_KEY, frame + FRAMES_PER_SEC * 300);
		unit->CmdWantedSpeed(speed);
	)
	engineGoal = goal;
	engineFrame = frame;
	engineIssued = true;
}

} // namespace circuit

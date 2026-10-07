/*
 * SpringUnit.cpp
 *
 *  Created on: Jul 20, 2026
 *      Author: rlcevg
 */

#include "spring/SpringUnit.h"
#include "spring/GuardCommand.h"
#include "util/Defines.h"
#include <algorithm>
#include <cmath>
#include <climits>

#include "SSkirmishAICallback.h"	// "direct" C API
#include "Sim/Units/CommandAI/Command.h"

namespace circuit {

int CUnitAPI::GetFriendlyUnitIds(std::vector<int>& buffer) const
{
	buffer.resize(MAX_UNITS); // allocated/initialized once, not shrunk each frame
	return std::clamp(sAICallback->getFriendlyUnits(skirmishAIId,buffer.data(),MAX_UNITS),0,MAX_UNITS);
}

void CUnitAPI::GetPosition(int unitId,float* position) const
{
	sAICallback->Unit_getPos(skirmishAIId,unitId,position);
}

CUnitAPI::CUnitAPI(const struct SSkirmishAICallback* clb, int sAIId)
		: sAICallback(clb)
		, skirmishAIId(sAIId)
{
}

CUnitAPI::~CUnitAPI()
{
}

int CUnitAPI::GetCMDQueueSize(int unitId)
{
	return sAICallback->Unit_getCurrentCommands(skirmishAIId, unitId);
}

int CUnitAPI::GetCMD(int unitId, int commandIdx)
{
	return sAICallback->Unit_CurrentCommand_getId(skirmishAIId, unitId, commandIdx);
}

bool CUnitAPI::HasGuardIntent(int unitId, int targetId, int frame) const
{
	const int count = sAICallback->Unit_getCurrentCommands(skirmishAIId, unitId);
	return guard::HasIntent(count, targetId, frame, [&](int i) {
		guard::Command c;
		const int id = sAICallback->Unit_CurrentCommand_getId(skirmishAIId, unitId, i);
		if (id != CMD_GUARD && id != CMD_REPAIR && id != CMD_MOVE) return c;
		const int options = sAICallback->Unit_CurrentCommand_getOptions(skirmishAIId, unitId, i);
		c.timeout = sAICallback->Unit_CurrentCommand_getTimeOut(skirmishAIId, unitId, i);
		// One bounded copy detects both single-target and malformed/area orders.
		// The C API returns the copied count, not the full size with this buffer.
		float params[4] = {};
		const int n = sAICallback->Unit_CurrentCommand_getParams(skirmishAIId, unitId, i, params, 4);
		if (id == CMD_GUARD || id == CMD_REPAIR) {
			c.kind = id == CMD_GUARD ? guard::Command::Kind::GUARD : guard::Command::Kind::REPAIR;
			const int mask = SHIFT_KEY | (id == CMD_REPAIR ? INTERNAL_ORDER : 0);
			c.valid = n == 1 && std::isfinite(params[0]) && params[0] >= 0.f
				&& (options & ~mask) == 0;
			c.target = params[0];
		} else {
			c.kind = guard::Command::Kind::MOVE;
			const bool internal = (options & INTERNAL_ORDER) != 0;
			const bool clearance = options == RIGHT_MOUSE_KEY && c.timeout != INT_MAX;
			c.valid = n == 3 && (internal || clearance)
				&& std::isfinite(params[0]) && std::isfinite(params[1]) && std::isfinite(params[2]);
		}
		return c;
	});
}

} /* namespace circuit */

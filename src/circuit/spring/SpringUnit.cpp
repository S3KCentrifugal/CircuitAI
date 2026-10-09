/*
 * SpringUnit.cpp
 *
 *  Created on: Jul 20, 2026
 *      Author: rlcevg
 */

#include "spring/SpringUnit.h"
#include "util/Defines.h"
#include <algorithm>

#include "SSkirmishAICallback.h"	// "direct" C API

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

} /* namespace circuit */

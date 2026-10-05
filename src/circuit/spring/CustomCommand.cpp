#include "spring/CustomCommand.h"
#include "CombinedCallbackBridge.h"
#include "CallbackAIException.h"

namespace circuit {
void SendCustomCommand(int aiId, int unitId, int commandId, std::span<float> params,
    short options, int timeout)
{
    const int result = bridged_Unit_executeCustomCommand(aiId, unitId, commandId,
        params.data(), static_cast<int>(params.size()), options, timeout);
    if (result != 0) throw springai::CallbackAIException("executeCustomCommand", result);
}
}

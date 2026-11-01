#pragma once
// D-388: the engine side of the ownership ladder (control/core/Suspension.h).
// Reads the unit's current task and engine state; no state of its own.

#include "control/core/Suspension.h"

namespace circuit {
class CCircuitUnit;
namespace control {
// Which rung of the ladder holds the unit now, or NONE when its controller
// owns it. O(1) plus a few engine reads.
Suspension SuspensionOf(CCircuitUnit* unit, int frame);
}
}

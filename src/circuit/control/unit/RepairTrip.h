#pragma once
// D-514: a battle group member's repair trip, shared by the skirmisher and
// support controllers. The battle group controller picks one member at a time
// (CBattleGroupController::Rotate, control/kernel/RepairCrew.h); while it is
// picked, Step walks the hull to the crew station and its engagement waits.
// When the trip ends the engagement re-decides at once and the hull rejoins.
//
// Cost: one O(1) lookup per decision of a battle group member; at most one
// move order, sent again only when the station moved by more than ARRIVAL.
#include "AIFloat3.h"

namespace circuit {
class CCircuitAI;
class CCircuitUnit;
class CRangedEngagement;

namespace repair_trip {

struct Memory {
    bool active = false;
    bool hasSent = false;
    springai::AIFloat3 sent;   // the last station a move was sent to
};

// True while the unit is on its repair trip (the caller skips its engagement
// decision); false otherwise, ending a finished trip with engagement.Idle().
bool Step(CCircuitAI* ai, CCircuitUnit* unit, CRangedEngagement& engagement, Memory& memory, int frame, const char* tag);

} // namespace repair_trip
} // namespace circuit

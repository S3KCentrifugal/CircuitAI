#include "control/unit/RepairTrip.h"
#include "control/group/BattleGroupController.h"
#include "task/fighter/RangedEngagement.h"
#include "terrain/TerrainManager.h"
#include "unit/CircuitUnit.h"
#include "util/Defines.h"
#include "CircuitAI.h"
#include "util/Utils.h"
#include "Log.h"

namespace circuit::repair_trip {

namespace {
// Elmos: no new move while the station is this close to the last one sent, or
// to the hull (the repair bot walks the last stretch to it).
constexpr float ARRIVAL = 64.f;
// Seconds a move order to the station lives.
constexpr int MOVE_SECONDS = 20;
}

bool Step(CCircuitAI* ai, CCircuitUnit* unit, CRangedEngagement& engagement, Memory& memory, int frame, const char* tag)
{
	const CBattleGroupController* groups = ai->GetBattleGroupController();
	springai::AIFloat3 station;
	if (groups == nullptr || !groups->RepairTrip(unit->GetId(), station)) {
		if (memory.active) {
			memory.active = false; memory.hasSent = false;
			ai->LOG("%s: repair trip over unit=%i health=%.2f frame=%i", tag, unit->GetId(), unit->GetHealthPercent(), frame);
			engagement.Idle();  // re-decide now: back to the slot
		}
		return false;
	}
	if (!memory.active) {
		memory.active = true; memory.hasSent = false;
		ai->LOG("%s: repair trip unit=%i health=%.2f station=%.0f,%.0f frame=%i",
			tag, unit->GetId(), unit->GetHealthPercent(), station.x, station.z, frame);
	}
	constexpr float arrivalSq = ARRIVAL * ARRIVAL;
	if (memory.hasSent && memory.sent.SqDistance2D(station) < arrivalSq) return true;
	if (unit->GetPos(frame).SqDistance2D(station) < arrivalSq) { memory.sent = station; memory.hasSent = true; return true; }
	CTerrainManager::CorrectPosition(station);
	TRY_UNIT(ai, unit, unit->CmdMoveTo(station, 0, frame + MOVE_SECONDS * FRAMES_PER_SEC);)
	memory.sent = station; memory.hasSent = true;
	return true;
}

} // namespace circuit::repair_trip

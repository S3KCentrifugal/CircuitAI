#ifndef CIRCUIT_UTIL_LAGLOAD_H
#define CIRCUIT_UTIL_LAGLOAD_H

#include "util/Defines.h"

#include <algorithm>

namespace circuit {
namespace lagload {

// Owner 2026-10-25: one load level for every SMRTBARb in this process (they
// all run on the host's client). Entrenched Plains lagged at 2,344 AI units,
// Esker Creek at 1,887.
// Owner 2026-11-13: the gap between new move orders and between attack-target
// changes for each T1/T2 unit rises in straight lines through 0 s at 1,500 AI
// units, 10 s at 2,500, 20 s at 3,000 and 30 s at 3,500 (held at 30 s above).
// Pounders share that floor (their own slower ramp would now be the faster
// one). Construction turret orders keep the old ramp, 0 s at 1,500 to 5 s at
// 3,500: a longer hold would starve the economy, and an idle turret is never
// held anyway. Commanders, T3, factories (gantry included) and lag_exempt defs
// are never throttled here.
// Plain counters on the engine thread; one recompute per second, one log line
// per minute.
struct State {
	int frame = -1;
	int minute = -1;
	int aiUnits = 0;
	int enemyUnits = 0;  // known (seen or on radar) by the logging AI
	float level = 0.f;   // turret ramp: 0 at START_UNITS, 1 at FULL_UNITS
	int moveFloor = 0;   // frames
	int targetFloor = 0;
	int mortarFloor = 0;
	int turretFloor = 0;
	unsigned moves = 0, movesDropped = 0;
	unsigned targets = 0, targetsDropped = 0;
	unsigned turret = 0, turretDropped = 0;
	unsigned other = 0;
};

constexpr int START_UNITS = 1500;
constexpr int STEP1_UNITS = 2500;  // move/target floor 10 s
constexpr int STEP2_UNITS = 3000;  // 20 s
constexpr int FULL_UNITS = 3500;

inline State& Get() { static State state; return state; }

inline void SetUnits(State& s, int aiUnits)
{
	s.aiUnits = aiUnits;
	s.level = std::clamp(float(aiUnits - START_UNITS) / float(FULL_UNITS - START_UNITS), 0.f, 1.f);
	float seconds;
	if (aiUnits <= START_UNITS) {
		seconds = 0.f;
	} else if (aiUnits <= STEP1_UNITS) {
		seconds = 10.f * float(aiUnits - START_UNITS) / float(STEP1_UNITS - START_UNITS);
	} else if (aiUnits <= STEP2_UNITS) {
		seconds = 10.f + 10.f * float(aiUnits - STEP1_UNITS) / float(STEP2_UNITS - STEP1_UNITS);
	} else {
		seconds = std::min(30.f, 20.f + 10.f * float(aiUnits - STEP2_UNITS) / float(FULL_UNITS - STEP2_UNITS));
	}
	s.moveFloor = int(seconds * FRAMES_PER_SEC);
	s.targetFloor = s.moveFloor;
	s.mortarFloor = s.moveFloor;
	s.turretFloor = int(s.level * 5.f * FRAMES_PER_SEC);
}

} // namespace lagload
} // namespace circuit

#endif // CIRCUIT_UTIL_LAGLOAD_H

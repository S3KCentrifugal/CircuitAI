#pragma once
// D-509: how many anti-air escorts a battle group needs, how many the factories
// should start, and where an escort stands. Engine-free
// (tests/air_defence_test.cpp); the battle group controller supplies the
// observations (control/group/BattleGroupController.cpp), the escort controller
// walks the units (control/unit/escort/EscortController.cpp).
//
// Need. The escorts a group needs are the ones that can shoot down the enemy
// air now near it within kill_seconds:
//
//   need = ceil(held air HP / (escort anti-air DPS x kill_seconds)),
//          at least 1 while any armed air is held, at most the cap,
//   cap  = min(rank max, ceil(per_screen x screens)), at least 1.
//
// Held air HP is the larger of the HP seen now and the last peak decaying to
// zero over memory_seconds: drones that land to re-arm, or bombers between
// passes, do not cancel the request, and the need falls off smoothly once the
// air is gone. It follows the air present, never a running total: a hive that
// rebuilds its drones does not grow the need past the drones in the air.
//
// Request. Factories start escorts only for the shortfall the existing and
// coming escorts do not cover:
//
//   request = sum over groups of max(0, need - assigned)
//             - escorts with no group - escorts queued or being built.
//
// So a lost escort is replaced, a group with enough asks for none, and an
// order already placed is never placed twice (the under- and over-production
// the owner asked to avoid, 2026-11-09).
#include "terrain/RangedGeometry.h"

#include <algorithm>
#include <cmath>

namespace circuit::air_defence {

// The decaying peak of one group's held air HP.
struct Memory { float peak = 0.f; int frame = -1; };

// The air HP the group plans for: max(now, the peak decaying linearly over
// memoryFrames). Updates the memory. O(1).
inline float Held(Memory& m, float current, int frame, int memoryFrames) {
    float decayed = 0.f;
    if (m.frame >= 0 && memoryFrames > 0) {
        const float left = 1.f - float(frame - m.frame) / float(memoryFrames);
        decayed = m.peak * std::max(0.f, left);
    }
    if (current >= decayed) { m.peak = current; m.frame = frame; return current; }
    return decayed;
}

// The most escorts one group takes: its share of the screen, within the rank max.
inline int Cap(int screens, float perScreen, int rankMax) {
    const int share = std::max(1, int(std::ceil(perScreen * float(std::max(0, screens)))));
    return std::max(1, std::min(rankMax > 0 ? rankMax : share, share));
}

// Escorts that kill `airHealth` within killSeconds, 1..cap; 0 with no air.
inline int Need(float airHealth, float escortDps, float killSeconds, int cap) {
    if (airHealth <= 0.f) return 0;
    if (escortDps <= 0.f || killSeconds <= 0.f) return std::max(1, cap);
    const int n = int(std::ceil(airHealth / (escortDps * killSeconds)));
    return std::clamp(n, 1, std::max(1, cap));
}

// Escorts to start now: the shortfall no existing or coming escort covers.
inline int Request(int deficit, int unassigned, int inProduction) {
    return std::max(0, deficit - std::max(0, unassigned) - std::max(0, inProduction));
}

// The point of escort `index` of `count`: `behind` elmos past the screen's
// rear edge (rearDepth, measured from the centre along `back`, which points
// away from the enemy), in a row `spacing` apart across the axis.
inline ranged::Point Slot(ranged::Point center, ranged::Point back, float rearDepth, float behind,
                          int index, int count, float spacing) {
    const float depth = std::max(0.f, rearDepth) + behind;
    const float lateral = (float(index) - float(std::max(1, count) - 1) * .5f) * spacing;
    return {center.x + back.x * depth - back.z * lateral, center.z + back.z * depth + back.x * lateral};
}

} // namespace circuit::air_defence

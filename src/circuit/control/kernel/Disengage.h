#pragma once
// D-433: the retreat rule and the repair rotation of a skirmisher or backline
// hull, engine-free (tests/disengage_test.cpp). The meta
// (knowledge/60-tactics/61-micro.md): a unit that can outrun its attacker
// leaves at 30 to 40 percent, one that cannot stays and fires, a veteran
// leaves earlier because its experience dies with it, and a line holding a
// stand-off takes free repair from a builder behind it. The legacy floor
// (behaviour.json "retreat") stays beneath this rule, unchanged.
#include "terrain/GroundCohort.h"

#include <algorithm>

namespace circuit::disengage {

// Retreat when the hull can get away and its health is at or under the
// threshold, raised by `veteranBonus` x experience (experience clamped to 1).
// A threshold of 0 is the rule switched off.
inline bool ShouldRetreat(float healthFraction, float experience, bool canEscape, float threshold, float veteranBonus) {
    if (threshold <= 0.f || !canEscape) return false;
    return healthFraction <= threshold + veteranBonus * std::clamp(experience, 0.f, 1.f);
}
// A hull can escape when nothing is on it, when the hazard is static (walk
// out of its reach), when the hazard is no faster, or when its own range
// advantage lets it kite (cohort::ShortKite).
inline bool CanEscape(bool danger, bool dangerMobile, float dangerSpeed, float dangerRange,
                      float ownSpeed, float ownRange, float reaction) {
    if (!danger || !dangerMobile) return true;
    if (dangerSpeed <= ownSpeed) return true;
    return cohort::ShortKite(ownRange, dangerRange, ownSpeed, reaction);
}
// A repair trip is wanted under `repairHealth` at most once per cooldown.
inline bool WantsRepair(float healthFraction, float repairHealth, int frame, int lastRepairFrame, int cooldownFrames) {
    if (repairHealth <= 0.f || healthFraction >= repairHealth) return false;
    return lastRepairFrame < 0 || frame >= lastRepairFrame + cooldownFrames;
}

} // namespace circuit::disengage

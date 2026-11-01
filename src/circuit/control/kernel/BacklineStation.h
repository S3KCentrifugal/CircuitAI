#pragma once
// D-432: the backline controller's decisions, engine-free
// (tests/backline_station_test.cpp). A backline hull (Aggravator, Rocketeer)
// stands behind its screen cohort, shoots what the screen cannot reach, moves
// only between shots, leaves first on a withdrawal and tucks behind the
// nearest screen members when a short-range hostile leaks round the screen.
// The kernel answers four questions from plain numbers: where the station is,
// how a target is weighted for the job, whether a step is free right now,
// and whether a hostile has leaked (and where to tuck).
#include "terrain/RangedGeometry.h"

#include <algorithm>
#include <cmath>
#include <vector>

namespace circuit::backline {

// Target weighting levers of a preset (behaviour.json "controllers").
struct Weights {
    float staticBonus = 1.5f;        // static_bonus: a tower or building in reach
    float beyondScreenBonus = 1.3f;  // beyond_screen_bonus: a contact the screen cannot reach
    float fastTargetSpeed = 70.f;    // fast_target_speed: elmos per second above which a shot is wasted
    float fastPenalty = .3f;         // fast_target_penalty
    float selfDefenceRadius = 250.f; // self_defence_radius: a hostile this close is shot regardless
    float selfDefenceBonus = 4.f;    // self_defence_bonus
};

// What a member's engagement reads. Plain data, rebuilt every decision.
struct Directive {
    bool active = false;
    bool stationSet = false;
    ranged::Point station{0.f, 0.f};      // the line centre of the rear station (members spread laterally)
    ranged::Point screenCentre{0.f, 0.f};
    float screenReach = 0.f;
    bool tuck = false;
    ranged::Point tuckPoint{0.f, 0.f};
    bool moveAfterShot = true;
    int aimHoldFrames = 24;
    Weights weights;
};

// How far behind the screen the rear stands: its reach advantage over the
// screen less the margin, clamped to the formation's separation band, so it
// fires at everything the screen fights from outside the screen's own band.
inline float Separation(float ownReach, float screenReach, float margin, float minimum, float maximum) {
    const float wanted = ownReach - screenReach - margin;
    return std::clamp(wanted, std::min(minimum, maximum), std::max(minimum, maximum));
}
// The station: the screen centre moved back along the line's back direction
// (unit length, from the hostile centroid through the screen).
inline ranged::Point Station(ranged::Point screenCentre, ranged::Point back, float separation) {
    return {screenCentre.x + back.x * separation, screenCentre.z + back.z * separation};
}
// The job's multiplier on the engagement's own target score. Statics first,
// then what the screen cannot reach; a fast target is a wasted missile unless
// it is coming for the backline itself.
inline float TargetWeight(bool mobile, float distanceFromScreen, float screenReach, float targetSpeed,
                          float distanceFromSelf, const Weights& w) {
    float weight = 1.f;
    if (!mobile) weight *= w.staticBonus;
    else if (screenReach > 0.f && distanceFromScreen > screenReach) weight *= w.beyondScreenBonus;
    if (mobile && distanceFromSelf <= w.selfDefenceRadius) return weight * w.selfDefenceBonus;
    if (mobile && targetSpeed > w.fastTargetSpeed) weight *= w.fastPenalty;
    return weight;
}
// A step is free when the weapon has more than `aimHoldFrames` of reload left
// (the move finishes before the next shot is due) or when there is nothing to
// shoot. A ready weapon with a target holds still and fires first.
inline bool MayStep(int frame, int reloadFrame, int aimHoldFrames, bool hasTarget) {
    if (!hasTarget) return true;
    return reloadFrame - frame > aimHoldFrames;
}
// A hostile has leaked when no screen member stands within `corridor` of the
// segment from the hostile to the hull: nothing is between them.
inline bool Leaked(ranged::Point hull, ranged::Point hostile, const std::vector<ranged::Point>& screen, float corridor) {
    const float dx = hull.x - hostile.x, dz = hull.z - hostile.z;
    const float lengthSq = dx * dx + dz * dz;
    for (const ranged::Point& s : screen) {
        float t = lengthSq > 0.f ? ((s.x - hostile.x) * dx + (s.z - hostile.z) * dz) / lengthSq : 0.f;
        t = std::clamp(t, 0.f, 1.f);
        const float px = hostile.x + dx * t - s.x, pz = hostile.z + dz * t - s.z;
        if (px * px + pz * pz <= corridor * corridor) return false;
    }
    return true;
}
// Where to tuck: the far side (from the hostile) of the mean of the `count`
// screen members nearest the hull, `offset` elmos beyond them. Without a
// screen the hull stays where it is.
inline ranged::Point Tuck(ranged::Point hull, ranged::Point hostile, std::vector<ranged::Point> screen, int count, float offset) {
    if (screen.empty() || count <= 0) return hull;
    std::sort(screen.begin(), screen.end(), [&](ranged::Point a, ranged::Point b) {
        return ranged::DistanceSq(a, hull) < ranged::DistanceSq(b, hull);
    });
    const int n = std::min<int>(count, int(screen.size()));
    ranged::Point mean{0.f, 0.f};
    for (int i = 0; i < n; ++i) { mean.x += screen[i].x; mean.z += screen[i].z; }
    mean.x /= float(n); mean.z /= float(n);
    float ax = mean.x - hostile.x, az = mean.z - hostile.z;
    const float length = std::sqrt(ax * ax + az * az);
    if (length < 1.f) return mean;
    ax /= length; az /= length;
    return {mean.x + ax * offset, mean.z + az * offset};
}

} // namespace circuit::backline

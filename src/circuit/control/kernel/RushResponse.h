#pragma once
// D-510: a battle group rushed by shorter-ranged raiders (Pawns, Grunts,
// Goblins) kites them, and every retreat of the group heads for the nearest
// help that can fight beside it. Engine-free (tests/rush_response_test.cpp);
// the cohort world supplies contacts and friends
// (task/fighter/GroundCohorts.cpp), the battle group turns its rows to the
// axis (control/group/BattleGroupController.cpp), a member's escape leans
// along it (task/fighter/RangedEngagement.cpp).
//
// Rushed. A rusher is an armed enemy mobile within detect_radius of the
// group whose reach is short of ours by range_margin and which closes on us
// (or is already inside our reach). The group is rushed when at least
// min_count of them hold value_share of its own metal or more: a few raiders
// against a large group are simply shot. A raider runs twice a Thug's speed,
// so a kite does not escape them: the group kites only when it holds range or
// reaches help first (KiteWorthwhile), and otherwise stands and fires.
//
// Help. Allied armed statics (their metal x static_weight) and allied armed
// mobiles outside the group, summed in cells of CELL elmos, within
// help_radius. A cell helps when its strength is at least `needed` (the
// rushers' value x help_ratio less our own, at least MIN_HELP) and it lies
// within help_cone degrees of the direction away from the threat, so the
// group never runs through the enemy to reach it. The nearest such cell wins;
// with none, a point help_lane_step back down our lane, then our base, if
// either lies in the cone; otherwise straight away from the threat.
#include "terrain/RangedGeometry.h"

#include <algorithm>
#include <cmath>
#include <vector>

namespace circuit::rush_response {

inline constexpr float CELL = 512.f;     // elmos; help is summed per cell
inline constexpr float MIN_HELP = 100.f; // metal; the least a cell must bring

// The rushers: how many, their metal and centroid, the nearest one's distance,
// the fastest speed and the longest reach among them.
struct Detection {
    int count = 0; float value = 0.f; ranged::Point centroid{0.f, 0.f};
    float nearest = 0.f, speed = 0.f, range = 0.f;
};

// A kite outruns raiders up to this share of their speed (it holds range).
inline constexpr float KITE_SPEED_SHARE = .9f;

inline ranged::Point Unit(ranged::Point v) {
    const float length = std::sqrt(v.x * v.x + v.z * v.z);
    return length > 1e-3f ? ranged::Point{v.x / length, v.z / length} : ranged::Point{0.f, 0.f};
}
inline float Dot(ranged::Point a, ranged::Point b) { return a.x * b.x + a.z * b.z; }

// Does a contact rush the group? `closing` is its speed toward the group's
// centre (ranged::ClosingSpeed); inside our reach it rushes whatever its speed.
inline bool Rushes(float distance, float closing, float enemyRange, float ownRange,
                   float rangeMargin, float closingMin, float detectRadius) {
    if (distance > detectRadius || enemyRange + rangeMargin > ownRange) return false;
    return closing >= closingMin || distance <= ownRange;
}
// Adds one rusher (position, metal, distance, speed, reach). O(1).
inline void Add(Detection& d, ranged::Point pos, float value, float distance = 0.f, float speed = 0.f, float range = 0.f) {
    const float n = float(d.count);
    d.centroid = {(d.centroid.x * n + pos.x) / (n + 1.f), (d.centroid.z * n + pos.z) / (n + 1.f)};
    d.nearest = d.count == 0 ? distance : std::min(d.nearest, distance);
    d.speed = std::max(d.speed, speed); d.range = std::max(d.range, range);
    ++d.count; d.value += std::max(0.f, value);
}

// Is a kite worth it? Measured in the D-510 arenas: against raiders twice our
// speed, backing off with help 800 behind changed nothing and with none near
// lost a Thug more (each step away is a volley not fired, and they catch us
// anyway). So a kite runs only while it buys something: we hold range (they
// are not much faster than us), or help (helpDistance; negative: none) is
// reached before the fastest closes from the nearest's distance to its own
// reach, with `slack` on that time. Otherwise the group stands and fires.
inline bool KiteWorthwhile(const Detection& d, float ownSpeed, float helpDistance, float slack) {
    if (ownSpeed <= 0.f) return false;
    if (ownSpeed >= d.speed * KITE_SPEED_SHARE) return true;
    if (helpDistance < 0.f) return false;
    const float gap = std::max(0.f, d.nearest - d.range);
    const float closing = std::max(1.f, d.speed - ownSpeed);
    return helpDistance / ownSpeed <= slack * gap / closing;
}
inline bool Rushed(const Detection& d, float ownValue, int minCount, float valueShare) {
    return d.count >= std::max(1, minCount) && d.value >= valueShare * std::max(0.f, ownValue);
}

// The help a group needs: enough to face the rushers beside it.
inline float Needed(float threat, float ownValue, float helpRatio) {
    return std::max(MIN_HELP, threat * helpRatio - std::max(0.f, ownValue));
}

// Allied strength summed per cell (a few cells near a group: linear search).
struct Cell { int x = 0, z = 0; float strength = 0.f; float sx = 0.f, sz = 0.f, weight = 0.f; };
inline void AddHelp(std::vector<Cell>& cells, ranged::Point pos, float strength) {
    if (strength <= 0.f) return;
    const int cx = int(std::floor(pos.x / CELL)), cz = int(std::floor(pos.z / CELL));
    for (Cell& c : cells) {
        if (c.x != cx || c.z != cz) continue;
        c.strength += strength; c.sx += pos.x * strength; c.sz += pos.z * strength; c.weight += strength;
        return;
    }
    cells.push_back({cx, cz, strength, pos.x * strength, pos.z * strength, strength});
}
inline ranged::Point Centre(const Cell& c) {
    return c.weight > 0.f ? ranged::Point{c.sx / c.weight, c.sz / c.weight} : ranged::Point{0.f, 0.f};
}
// Is `target` within coneDegrees of `away` seen from `from`?
inline bool InCone(ranged::Point from, ranged::Point away, ranged::Point target, float coneDegrees) {
    const ranged::Point to = Unit({target.x - from.x, target.z - from.z});
    if (to.x == 0.f && to.z == 0.f) return false;
    return Dot(to, away) >= std::cos(std::clamp(coneDegrees, 0.f, 90.f) * 3.14159265f / 180.f);
}
// The nearest helping cell within the cone and radius, or -1. O(cells).
inline int ChooseHelp(const std::vector<Cell>& cells, ranged::Point from, ranged::Point away,
                      float needed, float radius, float coneDegrees) {
    int best = -1; float bestDistance = radius * radius;
    for (std::size_t i = 0; i < cells.size(); ++i) {
        if (cells[i].strength < needed) continue;
        const ranged::Point c = Centre(cells[i]);
        const float d = ranged::DistanceSq(from, c);
        if (d > bestDistance || !InCone(from, away, c, coneDegrees)) continue;
        best = int(i); bestDistance = d;
    }
    return best;
}

// The retreat axis toward `anchor` (unit length); `away` when the anchor is
// not ahead of us along it. A member's escape leans along it by `weight`.
inline ranged::Point Axis(ranged::Point from, ranged::Point away, ranged::Point anchor) {
    const ranged::Point to = Unit({anchor.x - from.x, anchor.z - from.z});
    return (to.x == 0.f && to.z == 0.f) || Dot(to, away) <= 0.f ? away : to;
}
inline ranged::Point Lean(ranged::Point escape, ranged::Point axis, float weight) {
    if (Dot(escape, axis) < 0.f || weight <= 0.f) return escape;   // never lean toward the danger
    const float w = std::clamp(weight, 0.f, 1.f);
    const ranged::Point mixed = Unit({escape.x * (1.f - w) + axis.x * w, escape.z * (1.f - w) + axis.z * w});
    return (mixed.x == 0.f && mixed.z == 0.f) ? escape : mixed;
}

} // namespace circuit::rush_response

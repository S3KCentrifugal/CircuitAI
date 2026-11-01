#pragma once
#include "control/kernel/CommanderCombat.h"

namespace circuit::commander {
// Bounded nearest-first sampling along a caller-supplied rearward route.
// No heap allocations or engine state. The caller owns terrain/threat admission.
// Search includes the current station and never goes forward or beyond budget.
template<class At, class Admit>
std::optional<Point> NearestFallback(float progress, float search, float spacing, At at, Admit admit) {
    if (!std::isfinite(progress) || !std::isfinite(search) || !std::isfinite(spacing)
        || progress < 0 || search < 0 || spacing <= 0) return std::nullopt;
    const float distance = std::min(progress, search);
    const int count = std::clamp(int(std::ceil(distance / std::max(spacing, distance / 32.f))), 1, 32);
    for (int i = 0; i <= count; ++i) {
        const Point candidate = at(progress - distance * float(i) / count);
        if (std::isfinite(candidate.x) && std::isfinite(candidate.z) && admit(candidate)) return candidate;
    }
    return std::nullopt;
}
// A withdrawal leg may leave an existing weapon envelope, but may not move
// deeper into it or cross a new envelope to reach a superficially safe endpoint.
inline bool FallbackLegClear(Point from, Point to, Point enemy, float radius) {
    const Point start=from-enemy, step=to-from;
    const float r=std::max(0.f,radius), square=Dot(step,step);
    if(Dot(start,start)<r*r) return Dot(start,step)>=0.f;
    const float t=square>0.f?std::clamp(-Dot(start,step)/square,0.f,1.f):0.f;
    const Point nearest=start+step*t;
    return Dot(nearest,nearest)>=r*r;
}
// Keep a station outside an observed weapon envelope through arrival plus a
// policy preparation window. Closing motion matters; reload gaps are not cover.
inline bool FallbackClear(Point station, Point enemy, Point velocity, float weaponReach,
        float margin, float arrival, float preparation) {
    const Point delta = station - enemy;
    const float closing = std::max(0.f, Dot(velocity, Normal(delta)));
    return Length(delta) >= std::max(0.f, weaponReach) + std::max(0.f, margin)
        + closing * (std::max(0.f, arrival) + std::max(0.f, preparation));
}
}

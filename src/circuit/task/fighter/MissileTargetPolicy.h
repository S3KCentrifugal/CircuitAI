#pragma once
#include <algorithm>
#include <string>
namespace circuit {
inline bool IsSlowMissileLauncher(const std::string& name) {
    return name == "armmerl" || name == "corvroc" || name == "legavroc";
}
// 2026-11-06: launchers that leave identified, idle or slow T1 mobiles alone
// (Ambassador, Negotiator, Boreas, Arbiter).
inline bool IsT1ExemptLauncher(const std::string& name) {
    return name == "armmerl" || name == "corvroc" || name == "legavroc" || name == "corhrk";
}
// 2026-11-07 (@Barscrewl): launchers that pick only stationary or slow targets
// (SlowMissileSpeedAllowed): the three slow launchers plus Arbiter. Arbiter keeps
// its own fire state and controller; only the pick is gated.
inline bool IsSlowTargetLauncher(const std::string& name) {
    return IsSlowMissileLauncher(name) || name == "corhrk";
}
// 2026-11-07: ghost structures in the default pick (3 blind volleys at heavy
// porc, 1 at other porc) for Arbiter too, besides the close-in snipe units.
inline bool IsGhostPickLauncher(const std::string& name) {
    return IsSlowMissileLauncher(name) || name == "corhrk";
}
// 2026-11-07: spam retreat and the stationary-only radar-dot rule for the three
// slow launchers plus Arbiter and Thanatos.
inline bool IsSpamRetreatLauncher(const std::string& name) {
    return IsSlowMissileLauncher(name) || name == "corhrk" || name == "leghrk";
}
// Velocity is elmos/frame; definition speed is elmos/second.
inline bool SlowMissileSpeedAllowed(float velocitySq, float maxSpeed, bool identified, float fps) {
    if (!(velocitySq >= 0.f)) return false;
    if (!identified) return velocitySq == 0.f; // no known top speed: stationary dots only
    if (maxSpeed <= 0.f) return velocitySq == 0.f;
    const float limit = std::min(maxSpeed * 0.25f, 12.f) / fps;
    return velocitySq == 0.f || velocitySq < limit * limit;
}
}

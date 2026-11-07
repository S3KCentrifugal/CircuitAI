#pragma once
#include <algorithm>
#include <string>
namespace circuit {
// 2026-11-07 (@Barscrewl): Tremor (cortrem) runs the Ambassador rules too
// (except the snipe sequence: it outranges those threats; ghost fire is timed).
inline bool IsSlowMissileLauncher(const std::string& name) {
    return name == "armmerl" || name == "corvroc" || name == "legavroc" || name == "cortrem";
}
// 2026-11-06: launchers that leave identified, idle or slow T1 mobiles alone
// (Ambassador, Negotiator, Boreas, Arbiter).
inline bool IsT1ExemptLauncher(const std::string& name) {
    return IsSlowMissileLauncher(name) || name == "corhrk";
}
// 2026-11-07 (@Barscrewl): launchers that pick only stationary or slow targets
// (SlowMissileSpeedAllowed): the three slow launchers plus Arbiter. Arbiter keeps
// its own fire state and controller; only the pick is gated.
inline bool IsSlowTargetLauncher(const std::string& name) {
    return IsSlowMissileLauncher(name) || name == "corhrk";
}
// 2026-11-07: ghost structures in the default pick (3 blind volleys at heavy
// porc, 1 at other porc) for Arbiter too, besides the close-in snipe units.
// 2026-11-07: + Vanguard (armvang, 5 volleys at heavy porc, 1 at other porc).
inline bool IsGhostPickLauncher(const std::string& name) {
    return IsSlowMissileLauncher(name) || name == "corhrk" || name == "armvang";
}
// 2026-11-07: Tremor fires on a ghost for a time, not a volley count (it fires
// continuously, 0.5 s reload): heavy porc 105 s, anything else 45 s.
inline bool IsTimedGhostLauncher(const std::string& name) {
    return name == "cortrem";
}
// 2026-11-07: spam retreat and the stationary-only radar-dot rule for the three
// slow launchers plus Arbiter and Thanatos.
inline bool IsSpamRetreatLauncher(const std::string& name) {
    return IsSlowMissileLauncher(name) || name == "corhrk" || name == "leghrk";
}
// 2026-11-07: the radar-dot pick (stationary unidentified dots, after known
// targets, before ghosts) by name: those plus Vanguard.
inline bool IsDotPickLauncher(const std::string& name) {
    return IsSpamRetreatLauncher(name) || name == "armvang";
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

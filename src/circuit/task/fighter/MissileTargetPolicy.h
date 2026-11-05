#pragma once
#include <algorithm>
#include <string>
namespace circuit {
inline bool IsSlowMissileLauncher(const std::string& name) {
    return name == "armmerl" || name == "corvroc" || name == "legavroc";
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

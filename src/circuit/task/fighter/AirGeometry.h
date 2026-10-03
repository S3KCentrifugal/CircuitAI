#ifndef CIRCUIT_AIR_GEOMETRY_H
#define CIRCUIT_AIR_GEOMETRY_H
#include <algorithm>
#include <cmath>
namespace circuit::air_geometry {
struct Slot { float lateral; float behind; };
// Target classes are mechanism; script supplies their order. Unidentified,
// hidden and submerged contacts are rejected by the caller before this filter.
inline bool OperationTargetClass(int preference, bool mobile, bool flying,
        bool attacker, bool earlyEconomy, bool allowed, int primaryPreference = -1)
{
    if (flying) return false;
    // Falling back must not retry a primary target with weaker admission gates.
    if (primaryPreference >= 0 && preference != primaryPreference
        && OperationTargetClass(primaryPreference, mobile, flying, attacker, earlyEconomy, allowed)) return false;
    switch (preference) {
        case 0: return !mobile;
        case 2: return !mobile && earlyEconomy;
        case 3: return !mobile && attacker;
        case 4: return !mobile && !attacker;
        case 5: return !mobile && allowed;
        case 6: case 7: return mobile && allowed;
        case 8: return mobile;
        default: return false;
    }
}
inline bool PreferDistrictTarget(bool committed, bool local, bool bestLocal, float score, float bestScore)
{
    if (committed && local != bestLocal) return local;
    return score > bestScore;
}
// Short cohort legs bound how far faster escorts can run ahead. A leg is
// longer than the arrival disc, so successive arrivals require real progress.
inline int CohortLegCount(float distance, float arrivalRadius)
{
    if (!std::isfinite(distance) || !std::isfinite(arrivalRadius) || distance <= 0.f) return 1;
    const float length = std::max(1024.f, std::max(0.f, arrivalRadius) * 2.f);
    return std::clamp(int(std::min(256.f, std::ceil(distance / length))), 1, 256);
}
// Travel is separate from the script's settling allowance. Clamp before any
// float-to-frame conversion; malformed inputs must not create infinite waits.
inline float TransitSeconds(float distance, float speed)
{
    if (!std::isfinite(distance) || !std::isfinite(speed) || distance <= 0.f || speed <= 0.f) return 0.f;
    return std::min(300.f, distance / speed);
}
// Odd, centre-out columns keep every rank inside the requested width.
inline Slot FormationSlot(int index, float width, float spacing, float rankSpacing)
{
    if (index < 0 || !std::isfinite(width) || !std::isfinite(spacing)
        || !std::isfinite(rankSpacing) || width < 0.f || spacing <= 0.f || rankSpacing <= 0.f) return {0.f, 0.f};
    const int half = int(std::min(64.f, width / (2.f * spacing)));
    const int columns = half * 2 + 1;
    const int k = index % columns;
    const int lane = k == 0 ? 0 : k % 2 ? (k + 1) / 2 : -k / 2;
    const Slot slot{float(lane) * spacing, float(index / columns) * rankSpacing};
    return std::isfinite(slot.lateral) && std::isfinite(slot.behind) ? slot : Slot{0.f, 0.f};
}
inline bool LossAbort(int initial, int alive, float fraction)
{
    return initial > 0 && alive >= 0 && std::isfinite(fraction) && fraction > 0.f
        && fraction <= 1.f && float(initial - alive) / initial >= fraction;
}
// Threat-map exposure is a risk proxy, not a DPS prediction. Configuration
// supplies its scale and the explicit reserve for unobserved resistance.
inline int RequiredForce(float health, float pass, float margin, float risk, float unknown, float army)
{
    if (!std::isfinite(health) || !std::isfinite(pass) || !std::isfinite(margin)
        || !std::isfinite(risk) || !std::isfinite(unknown) || !std::isfinite(army)
        || health <= 0.f || pass <= 0.f) return 0;
    const double need = double(health) * std::max(1.f, margin) / pass
        * (1.0 + std::clamp(risk, 0.f, 4.f) + std::clamp(unknown, 0.f, 2.f) + std::clamp(army, 0.f, 2.f));
    // Inputs originate as floats. Do not buy a whole extra aircraft for a
    // representational epsilon above an integral payload requirement.
    return int(std::min<double>(1000000, std::ceil(need - std::max<double>(1, need) * 1e-7)));
}
inline int AttritionReserve(float aaMetal, float aircraftMetal, float fraction)
{
    if (!std::isfinite(aaMetal) || !std::isfinite(aircraftMetal) || !std::isfinite(fraction)
        || aaMetal <= 0.f || aircraftMetal <= 0.f || fraction <= 0.f) return 0;
    return int(std::ceil(std::min(1000000.f, aaMetal / aircraftMetal * std::min(2.f, fraction))));
}
inline float AttackDelay(float longestSeconds, float distance, float speed)
{
    if (!std::isfinite(longestSeconds) || longestSeconds < 0.f) return 0.f;
    return std::clamp(longestSeconds - TransitSeconds(distance, speed), 0.f, 300.f);
}
}
#endif

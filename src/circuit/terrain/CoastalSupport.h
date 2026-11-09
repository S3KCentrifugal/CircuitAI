#ifndef CIRCUIT_COASTAL_SUPPORT_H
#define CIRCUIT_COASTAL_SUPPORT_H
#include <cmath>
namespace circuit { namespace coastal_support {
// Conservative centre-to-centre support envelope. The margin reserves room
// for footprints instead of relying on a model-radius extension at the limit.
inline bool ReachesLand(float waterHeight, float landHeight, float distanceSquared,
                        float buildRange, float margin = 64.f) {
    return std::isfinite(waterHeight) && std::isfinite(landHeight)
        && std::isfinite(distanceSquared) && std::isfinite(buildRange)
        && waterHeight < 0.f && landHeight >= 0.f && distanceSquared >= 0.f
        && buildRange > margin && distanceSquared <= (buildRange-margin)*(buildRange-margin);
}
}}
#endif

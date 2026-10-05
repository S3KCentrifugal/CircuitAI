#ifndef CIRCUIT_NAVAL_GEOMETRY_H
#define CIRCUIT_NAVAL_GEOMETRY_H

#include <algorithm>
#include <cmath>

namespace circuit::naval {
// Test the entire swept hull, not just a connected coarse water sector.
// The caller supplies current terrain elevation; no AI policy lives here.
template<class Elevation>
bool Corridor(float x, float z, int facing, float length, float halfWidth,
              float draft, Elevation elevation)
{
    if (!std::isfinite(x) || !std::isfinite(z) || !std::isfinite(length) || !std::isfinite(halfWidth) || !std::isfinite(draft)
        || length < 0 || halfWidth < 0 || draft <= 0 || facing < 0 || facing > 3) return false;
    const float dx = facing == 1 ? 1.f : facing == 3 ? -1.f : 0.f;
    const float dz = facing == 0 ? 1.f : facing == 2 ? -1.f : 0.f;
    const int rows = std::max(1, int(std::ceil(length / 8.f)));
    const int cols = std::max(1, int(std::ceil(2.f * halfWidth / 8.f)));
    for (int r = 0; r <= rows; ++r) {
        const float along = length * r / rows;
        for (int c = 0; c <= cols; ++c) {
            const float across = -halfWidth + 2.f * halfWidth * c / cols;
            const float y = elevation(x + dx * along + dz * across, z + dz * along - dx * across);
            if (!std::isfinite(y) || y > -draft) return false;
        }
    }
    return true;
}
}
#endif

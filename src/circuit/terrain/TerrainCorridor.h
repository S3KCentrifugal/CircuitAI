#pragma once
#include <algorithm>
#include <cmath>

namespace circuit::lane {
// Fine terrain corridor check independent of the engine and role policy.
// The caller supplies loaded MoveData limits and current height/slope samples.
template<class Height, class Slope>
bool TerrainCorridor(float ax, float az, float bx, float bz, float halfWidth,
        float maxSlope, float depth, bool dry, Height height, Slope slope)
{
    const float length = std::hypot(bx-ax,bz-az);
    const int steps = std::max(1,int(std::ceil(length/8.f)));
    const int extent = std::max(0,int(std::ceil(halfWidth/8.f)));
    for (int i=0;i<=steps;++i) {
        const float x=ax+(bx-ax)*i/steps, z=az+(bz-az)*i/steps;
        for (int dx=-extent;dx<=extent;++dx) for (int dz=-extent;dz<=extent;++dz) {
            const float px=x+dx*8.f, pz=z+dz*8.f;
            const float h=height(px,pz), s=slope(px,pz);
            if (!std::isfinite(h) || !std::isfinite(s) || h < (dry ? 0.f : -depth)
                    || s > maxSlope) return false;
        }
    }
    return true;
}
}

#pragma once
#include <algorithm>
#include <cmath>

namespace circuit::lane {
// Closed rectangle intersection, including grazing: callers expand footprints
// by the moving unit's radius. A local connector may not cut through a building.
inline bool SegmentOutsideBox(float ax,float az,float bx,float bz,
        float minx,float minz,float maxx,float maxz) {
    float lo=0.f,hi=1.f;
    const auto clip=[&](float a,float delta,float low,float high) {
        if(delta==0.f) return a>=low && a<=high;
        float first=(low-a)/delta,last=(high-a)/delta;
        if(first>last) std::swap(first,last);
        lo=std::max(lo,first);hi=std::min(hi,last);
        return lo<=hi;
    };
    return !(clip(ax,bx-ax,minx,maxx) && clip(az,bz-az,minz,maxz));
}
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

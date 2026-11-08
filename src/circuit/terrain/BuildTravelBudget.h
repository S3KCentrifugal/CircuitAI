#ifndef SRC_CIRCUIT_TERRAIN_BUILDTRAVELBUDGET_H_
#define SRC_CIRCUIT_TERRAIN_BUILDTRAVELBUDGET_H_
#include <algorithm>
#include <cmath>
#include <functional>
#include <limits>
#include <queue>
#include <utility>
#include <vector>

namespace circuit::build_travel {
// Placement's IsBlocked deliberately treats every structure mark as blocked,
// regardless of its mask. Walking must ignore planning-only reservation marks
// in BOTH layers, while retaining physical buildings and their clearance.
inline bool PhysicalBlock(unsigned blockers, unsigned structures, unsigned reservationMask)
{
    return ((blockers | structures) & ~reservationMask) != 0;
}
// A bounded local Dijkstra, not a whole-map path request. Coordinates are
// relative to the builder's actual position; diagonal corner cutting is illegal.
// O(V log V) time/O(V) scratch, V <= 65^2; used only during site admission.
template<class Passable>
bool Within(float dx, float dz, float range, float budget, Passable&& passable)
{
    constexpr float step = 16.f;
    if (!std::isfinite(dx) || !std::isfinite(dz) || !std::isfinite(range)
        || !std::isfinite(budget) || range < 0 || budget < 0) return false;
    if (dx*dx + dz*dz <= range*range) return passable(0.f, 0.f);
    if (dx*dx + dz*dz > (range+budget)*(range+budget)) return false;
    const int radius = int(std::ceil(std::min(32.f, budget / step)));
    if (radius < 1) return false;
    const int width = 2*radius+1;
    std::vector<float> distance(width*width, std::numeric_limits<float>::infinity());
    std::vector<signed char> allowed(width*width, -1);
    auto index = [=](int x, int z) { return (z+radius)*width + x+radius; };
    auto open = [&](int x, int z) {
        if (std::abs(x)>radius || std::abs(z)>radius) return false;
        auto& value = allowed[index(x,z)];
        if (value < 0) value = passable(x*step,z*step) ? 1 : 0;
        return value != 0;
    };
    using Node = std::pair<float,int>;
    std::priority_queue<Node,std::vector<Node>,std::greater<Node>> queue;
    distance[index(0,0)]=0.f;
    queue.push({0.f,index(0,0)});
    while (!queue.empty()) {
        const auto [cost,id]=queue.top(); queue.pop();
        if (cost != distance[id]) continue;
        const int x=id%width-radius, z=id/width-radius;
        const float ex=dx-x*step, ez=dz-z*step;
        if (ex*ex+ez*ez <= range*range && open(x,z)) return true;
        for (int oz=-1; oz<=1; ++oz) for (int ox=-1; ox<=1; ++ox) {
            if (ox==0 && oz==0) continue;
            const float next=cost+step*((ox!=0 && oz!=0)?1.41421356237f:1.f);
            if (next>budget || !open(x+ox,z+oz)) continue;
            if (ox!=0 && oz!=0 && (!open(x+ox,z) || !open(x,z+oz))) continue;
            const int ni=index(x+ox,z+oz);
            if (next>=distance[ni]) continue;
            distance[ni]=next; queue.push({next,ni});
        }
    }
    return false;
}
} // namespace circuit::build_travel
#endif

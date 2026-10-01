#pragma once

#include <algorithm>
#include <cmath>
#include <vector>

// Engine-free target/claim rules. Callers supply all policy thresholds.
namespace circuit::strategic {
struct Point { float x, z; };
inline float DistanceSq(Point a, Point b) { return (a.x-b.x)*(a.x-b.x) + (a.z-b.z)*(a.z-b.z); }
inline bool Valid(Point p) { return std::isfinite(p.x) && std::isfinite(p.z) && p.x >= 0 && p.z >= 0; }
inline int SensorClass(bool jammer, bool radar, bool mobile, bool advanced)
{
    if (!jammer && !radar) return -1;
    if (mobile) return jammer ? 4 : 5;
    return jammer ? (advanced ? 0 : 1) : (advanced ? 2 : 3);
}
inline bool NuclearTarget(bool mobile, bool known, bool structuresOnly) { return known && (!structuresOnly || !mobile); }
struct Claim { int owner, expires; Point pos; float radius; bool pending; };
class Ledger {
public:
    bool Blocked(Point p, int owner, int frame, bool perOwner, bool ignoreOwnPending = true) const
    {
        return std::any_of(claims.begin(), claims.end(), [&](const Claim& c) {
            return c.expires > frame && (!perOwner || c.owner == owner)
                && !(ignoreOwnPending && c.pending && c.owner == owner)
                && DistanceSq(p, c.pos) <= c.radius*c.radius;
        });
    }
    void ReleasePending(int owner)
    {
        std::erase_if(claims, [=](const Claim& c) { return c.owner == owner && c.pending; });
    }
    void Add(int owner, Point pos, float radius, int frame, int duration, bool pending)
    {
        std::erase_if(claims, [=](const Claim& c) { return c.expires <= frame; });
        ReleasePending(owner);
        if (Valid(pos) && radius >= 0 && duration > 0) claims.push_back({owner, frame + duration, pos, radius, pending});
    }
    template<class Alive> void Prune(int frame, const Alive& alive)
    {
        std::erase_if(claims, [&](const Claim& c) { return c.expires <= frame || !alive(c.owner); });
    }
private:
    std::vector<Claim> claims;
};
}

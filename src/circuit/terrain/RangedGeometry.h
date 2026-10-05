#ifndef CIRCUIT_RANGED_GEOMETRY_H
#define CIRCUIT_RANGED_GEOMETRY_H

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <unordered_map>
#include <vector>

namespace circuit::ranged {
struct Point { float x = 0.f, z = 0.f; };
inline float DistanceSq(Point a, Point b) {
    const float x = a.x-b.x, z = a.z-b.z; return x*x+z*z;
}
inline float SegmentDistanceSq(Point p, Point a, Point b) {
    const float dx=b.x-a.x, dz=b.z-a.z, den=dx*dx+dz*dz;
    const float t=den>0.f ? std::clamp(((p.x-a.x)*dx+(p.z-a.z)*dz)/den,0.f,1.f) : 0.f;
    return DistanceSq(p,{a.x+dx*t,a.z+dz*t});
}
// Reject a route that enters known coverage even if its endpoint is safe.
// An already exposed unit may escape monotonically; it may not cross the
// coverage center or add exposure to another weapon. Tested by ranged tests.
inline bool SafeSegment(Point a, Point b, Point danger, float radius) {
    const float r2=radius*radius, start=DistanceSq(a,danger);
    if (start>=r2) return SegmentDistanceSq(danger,a,b)>=r2;
    return DistanceSq(b,danger)>start &&
        (a.x-danger.x)*(b.x-a.x)+(a.z-danger.z)*(b.z-a.z)>=0.f;
}
inline float ClosingSpeed(Point from, Point enemy, Point velocity) {
    const float d=std::sqrt(DistanceSq(from,enemy));
    return d>0.f ? std::max(0.f,((from.x-enemy.x)*velocity.x+(from.z-enemy.z)*velocity.z)/d) : 0.f;
}
inline float EscapeSeconds(float speed, float turnRate, float acceleration, bool forwardArc, float reaction) {
    // Engine turn units/frame and acceleration elmos/frame^2 -> seconds.
    // An escape MOVE points away from the enemy. A forward-facing hull may
    // need a full half-turn (32768 engine angle units), not a quarter-turn.
    // Underestimating this window lets fast assault units close during aiming.
    const float turn=forwardArc ? 32768.f/std::max(1.f,turnRate)/30.f : 0.f;
    const float accelerate=std::min(6.f,speed/std::max(1.f,acceleration*900.f));
    return reaction+turn+accelerate*.5f;
}
inline float UsefulScore(float cost, float hp, float damage, float reserved,
                         bool precision, bool heavy, bool los, float progress) {
    const float left=std::max(0.f,hp-reserved);
    const float useful=std::min(std::max(1.f,damage),left);
    // Claimed lethal salvos lower priority, but do not permanently blacklist a
    // target if all other shots are unavailable. Reservations expire on reload.
    const float efficiency=precision ? useful/std::max(1.f,damage) : 1.f;
    return (1.f+cost)*(.05f+.95f*efficiency)*(heavy?1.2f:1.f)*(los?1.f:.65f)*progress;
}

// Frame-local spatial index. Build O(N); queries cost visited cells + results,
// not O(N) per shooter and not universally O(1). Buckets retain allocation
// across refreshes. All access stays on the AI callback thread.
class SpatialIndex {
public:
    explicit SpatialIndex(float cell=512.f): cell(cell) {}
    void Clear() { for (auto& [key, values]: cells) values.clear(); }
    void Add(Point p, int id) { cells[Key(p)].push_back(id); }
    void Remove(Point p, int id) {
        auto it=cells.find(Key(p));
        if(it!=cells.end()) std::erase(it->second,id);
    }
    template<class F> void Query(Point p, float radius, F&& visit) const {
        const int x0=Coord(p.x-radius), x1=Coord(p.x+radius);
        const int z0=Coord(p.z-radius), z1=Coord(p.z+radius);
        for (int z=z0;z<=z1;++z) for(int x=x0;x<=x1;++x) {
            const auto it=cells.find(Key(x,z));
            if (it!=cells.end()) for(int id:it->second) visit(id);
        }
    }
private:
    int Coord(float v) const { return int(std::floor(v/cell)); }
    static std::uint64_t Key(int x,int z) { return (std::uint64_t(std::uint32_t(x))<<32)|std::uint32_t(z); }
    std::uint64_t Key(Point p) const { return Key(Coord(p.x),Coord(p.z)); }
    float cell;
    std::unordered_map<std::uint64_t,std::vector<int>> cells;
};
}
#endif

#pragma once

#include <algorithm>
#include <cmath>
#include <unordered_map>
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
// Probing shot (owner 2026-11-03): ghost images of enemy structures that lie
// inside our radar coverage, out of LOS, yet show no radar signature - no
// contact (identified or a bare dot) within clearRadius - are probably under a
// jammer. ProbeClusters groups them: each cluster is the ghosts within radius
// of its centre, best (most ghosts, then most metal) first, members removed
// before the next is picked. O(G*G) on the few dozen filtered ghosts; the
// contact check is a hash grid, O(C + 9 G).
struct Ghost { Point pos; float metal; };
struct ProbeCluster { Point center; int count = 0; float metal = 0.f; std::vector<Point> members; };
inline std::vector<Ghost> UnsignedGhosts(const std::vector<Ghost>& ghosts, const std::vector<Point>& contacts, float clearRadius)
{
    if (clearRadius <= 0.f || contacts.empty()) return ghosts;
    const float cell = clearRadius;
    auto key = [](int cx, int cz) { return (static_cast<long long>(cx) << 32) ^ static_cast<unsigned>(cz); };
    std::unordered_map<long long, std::vector<Point>> grid;
    for (const Point& c : contacts) grid[key(int(std::floor(c.x / cell)), int(std::floor(c.z / cell)))].push_back(c);
    std::vector<Ghost> out;
    for (const Ghost& g : ghosts) {
        const int cx = int(std::floor(g.pos.x / cell)), cz = int(std::floor(g.pos.z / cell));
        bool signed_ = false;
        for (int dx = -1; dx <= 1 && !signed_; ++dx) for (int dz = -1; dz <= 1 && !signed_; ++dz) {
            auto it = grid.find(key(cx + dx, cz + dz));
            if (it == grid.end()) continue;
            for (const Point& c : it->second) if (DistanceSq(c, g.pos) <= clearRadius * clearRadius) { signed_ = true; break; }
        }
        if (!signed_) out.push_back(g);
    }
    return out;
}
inline std::vector<ProbeCluster> ProbeClusters(std::vector<Ghost> ghosts, float radius, int minCount, int maxClusters = 8)
{
    std::vector<ProbeCluster> out;
    const float sq = radius * radius;
    minCount = std::max(1, minCount);
    while (int(out.size()) < maxClusters && int(ghosts.size()) >= minCount) {
        ProbeCluster best;
        for (const Ghost& seed : ghosts) {
            float sx = 0.f, sz = 0.f; int n = 0;
            for (const Ghost& g : ghosts) if (DistanceSq(g.pos, seed.pos) <= sq) { sx += g.pos.x; sz += g.pos.z; ++n; }
            const Point c{sx / float(n), sz / float(n)};
            ProbeCluster cand; cand.center = c;
            for (const Ghost& g : ghosts) if (DistanceSq(g.pos, c) <= sq) { ++cand.count; cand.metal += g.metal; }
            if (cand.count > best.count || (cand.count == best.count && cand.metal > best.metal)) best = cand;
        }
        if (best.count < minCount) break;
        std::vector<Ghost> rest;
        for (const Ghost& g : ghosts) {
            if (DistanceSq(g.pos, best.center) <= sq) best.members.push_back(g.pos);
            else rest.push_back(g);
        }
        out.push_back(best);
        ghosts.swap(rest);
    }
    return out;
}
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
// Overnuke (owner 2026-10-28): with enough silos every one of them fires at
// one target until `goal` launches have gone at it (the caller rolls 17-30),
// or no target is left there, then the next. Every `scoutEvery` launches it
// counts a scout request; finished targets go to `done` so none is picked again.
// Salvo (owner 2026-10-30): a target begun with stock=true holds every silo
// that reaches it until together they have stocked the roll (SalvoGate), then
// Release() opens fire and every silo fires as fast as its reload allows.
enum class SalvoGate { HOLD, STOCKED, TIMEOUT, HIT };
// stocked: missiles in the reaching silos; need: the roll, capped by what they
// can hold; hit: a reaching silo is damaged (use the stock before it is lost).
inline SalvoGate SalvoRelease(int stocked, int need, int frame, int since, int maxFrames, bool hit)
{
    if (stocked >= std::max(1, need)) return SalvoGate::STOCKED;
    if (stocked > 0 && hit) return SalvoGate::HIT;
    if (stocked > 0 && maxFrames > 0 && frame - since >= maxFrames) return SalvoGate::TIMEOUT;
    return SalvoGate::HOLD;
}
class Overnuke {
public:
    bool Active() const { return Valid(pos) && fired < goal; }
    bool Covers(Point p) const { return Active() && DistanceSq(p, pos) <= radius*radius; }
    void Begin(Point p, float r, int roll, int frame = 0, bool stock = false)
    {
        pos = p; radius = std::max(0.f, r); goal = std::max(1, roll); fired = 0;
        stocking = stock; since = frame; ++begun;
    }
    // Front nukerush (owner 2026-11-04): the ally team's first overnuke rolls
    // firstMin..firstMax launches instead of the policy's roll; 0 = off.
    void SetFirstRoll(int lo, int hi) { firstMin = std::max(0, lo); firstMax = std::max(firstMin, hi); }
    bool FirstRoll(int& lo, int& hi) const
    {
        if ((begun > 0) || (firstMax <= 0)) return false;
        lo = std::max(1, firstMin); hi = std::max(lo, firstMax); return true;
    }
    int Begun() const { return begun; }
    bool Stocking() const { return Active() && stocking; }
    bool Salvo() const { return Active() && !stocking; }
    int Since() const { return since; }
    // Open fire. A release short of the roll (timeout, a silo hit) fires only
    // what is stocked: the goal drops to it.
    // fireAll (owner 2026-11-04): every missile stocked at the release goes, so
    // the goal rises to the stock when the silos hold more than the roll.
    void Release(int stocked, bool fireAll = false)
    {
        stocking = false;
        if (stocked > 0 && stocked < goal) goal = stocked;
        if (fireAll && stocked > goal) goal = stocked;
    }
    // A better aim point found before the first launch (fresh scouting): the
    // salvo goes there instead, same roll.
    void Retarget(Point p) { if (Valid(p) && fired == 0) pos = p; }
    // A launch at p. True when it counted against the target.
    bool Count(Point p, int frame, int duration, int scoutEvery)
    {
        if (!Covers(p)) return false;
        ++fired;
        if (scoutEvery > 0 && fired % scoutEvery == 0) ++scouts;
        if (fired >= goal) End(frame, duration);
        return true;
    }
    void End(int frame, int duration)
    {
        if (!Valid(pos)) return;
        if (fired < goal) goal = fired;
        done.Add(-1, pos, radius, frame, duration, false);
    }
    bool Done(Point p, int frame) const { return done.Blocked(p, -1, frame, false); }
    Point Pos() const { return pos; }
    float Radius() const { return radius; }
    int Fired() const { return fired; }
    int Goal() const { return goal; }
    int Scouts() const { return scouts; }  // every scout request so far, all targets
private:
    Point pos{-1.f, -1.f};
    float radius = 0.f;
    int goal = 0, fired = 0, scouts = 0, begun = 0, firstMin = 0, firstMax = 0;
    bool stocking = false;
    int since = 0;  // frame the target began, for the stock timeout
    Ledger done;
};
}

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
// Nuke outcome (owner 2026-11-06). The engine adds experience to the silo for
// every point of damage its missile deals (BAR modrules experienceMult; the
// same experience raises its health and cuts its reload), so a launch is
// pending until its silo's experience rises - the missile landed - or the
// window closes with none - it was intercepted. A landing marks the area
// (blast plus chain reach): every ghost in it last seen before the strike is
// worth `factor` of its metal until it is seen again, i.e. until a scout
// refreshes the ghosts (a destroyed one then vanishes). An interception
// presumes an armed interceptor around that aim until one is seen there or
// the presumption expires. Engine-free; marks and pendings are capped.
class StrikeLedger {
public:
    struct Pending { int silo; Point aim; float radius; int launch, deadline; float exp; };
    struct Mark { Point pos; float radius; int frame, expires; bool hit; };
    enum class Outcome { HIT, INTERCEPTED };
    void Launch(int silo, Point aim, float radius, int frame, int windowFrames, float exp)
    {
        if (!Valid(aim)) return;
        if (pending.size() >= 64) pending.erase(pending.begin());
        pending.push_back({silo, aim, std::max(0.f, radius), frame, frame + std::max(1, windowFrames), exp});
    }
    bool HasPending(int silo) const
    {
        return std::any_of(pending.begin(), pending.end(), [=](const Pending& p) { return p.silo == silo; });
    }
    // exp: the silo's experience now (exp < 0: the silo is gone, its launches are dropped).
    // fn(const Pending&, Outcome) for each resolved launch, oldest first; a rise
    // goes to the silo's oldest pending launch, the rest re-baseline on it.
    template<class F> void Resolve(int silo, float exp, int frame, int presumeFrames, F&& fn)
    {
        for (size_t i = 0; i < pending.size();) {
            Pending& p = pending[i];
            if (p.silo != silo) { ++i; continue; }
            if (exp < 0.f) { pending.erase(pending.begin() + i); continue; }
            Outcome out;
            if (exp > p.exp + 1e-7f) out = Outcome::HIT;
            else if (frame >= p.deadline) out = Outcome::INTERCEPTED;
            else break;  // the oldest is still in flight: later ones wait for it
            const Pending done = p;
            pending.erase(pending.begin() + i);
            for (Pending& q : pending) if (q.silo == silo) q.exp = exp;
            if (marks.size() >= 128) marks.erase(marks.begin());
            marks.push_back({done.aim, done.radius, frame,
                (out == Outcome::HIT) ? -1 : frame + std::max(1, presumeFrames), out == Outcome::HIT});
            fn(done, out);
            if (out == Outcome::HIT) break;  // one rise resolves one launch
        }
    }
    // The ghost factor at p for a ghost last seen at lastSeen (1 outside every struck area).
    float GhostFactor(Point p, int lastSeen, float factor) const
    {
        for (const Mark& m : marks) {
            if (m.hit && lastSeen < m.frame && DistanceSq(p, m.pos) <= m.radius * m.radius) return factor;
        }
        return 1.f;
    }
    // A presumed interceptor whose last intercept lies within radius of p and has not expired.
    bool PresumedCover(Point p, float radius, int frame) const
    {
        return std::any_of(marks.begin(), marks.end(), [&](const Mark& m) {
            return !m.hit && m.expires > frame && DistanceSq(p, m.pos) <= radius * radius;
        });
    }
    // A known interceptor now stands near a presumed one: the known one counts instead.
    void ClearPresumed(Point p, float radius)
    {
        std::erase_if(marks, [&](const Mark& m) { return !m.hit && DistanceSq(p, m.pos) <= radius * radius; });
    }
    bool Empty() const { return marks.empty(); }
private:
    std::vector<Pending> pending;
    std::vector<Mark> marks;
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
        stocking = stock; since = frame; ++begun; untilEmpty = false;
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
    // fireAll (owner 2026-11-04): the silos keep stocking while the salvo fires,
    // so it has no fixed goal: every reaching silo fires until its stock is 0
    // (the caller ends it with End() once their stock sums to 0), even past the
    // roll - a salvo released at 8 may fire 12.
    void Release(int stocked, bool fireAll = false)
    {
        stocking = false;
        if (fireAll) { untilEmpty = true; goal = UNTIL_EMPTY; return; }
        if (stocked > 0 && stocked < goal) goal = stocked;
    }
    bool UntilEmpty() const { return Active() && untilEmpty; }
    static constexpr int UNTIL_EMPTY = 1000000;
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
    bool stocking = false, untilEmpty = false;
    int since = 0;  // frame the target began, for the stock timeout
    Ledger done;
};
}

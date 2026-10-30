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
        stocking = stock; since = frame;
    }
    bool Stocking() const { return Active() && stocking; }
    bool Salvo() const { return Active() && !stocking; }
    int Since() const { return since; }
    // Open fire. A release short of the roll (timeout, a silo hit) fires only
    // what is stocked: the goal drops to it.
    void Release(int stocked)
    {
        stocking = false;
        if (stocked > 0 && stocked < goal) goal = stocked;
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
    int goal = 0, fired = 0, scouts = 0;
    bool stocking = false;
    int since = 0;  // frame the target began, for the stock timeout
    Ledger done;
};
}

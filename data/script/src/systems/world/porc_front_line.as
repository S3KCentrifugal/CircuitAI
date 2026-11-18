// Porc front line (owner, 2026-11-18).
#include "../../define.as"
#include "../../global.as"
#include "../../helpers/common/generic_helpers.as"
#include "lanes.as"

/******************************************************************************

PORC FRONT LINE

Owner, 2026-11-18: "the front line is the furthest forward that defensive
buildings are currently alive and have been alive more than 2 minutes". Site
clearing leaves the furthest-forward T1, T1.5 and T2 defences alive and only
reclaims porc left Global::PorcFrontLine::BehindMargin (500) or more behind.

Defensive building: one of ours, not mobile, finished, with a surface or air
threat and a weapon range (every porc tier, pop-ups, AA). First seen finished
by a sweep = its start; it counts for the line once it has stood
MinAgeSeconds (a sweep every SweepSeconds, so up to that much late).

Forward(p) = dist(A, E) - dist(p, E): how far p stands ahead of its nearest
allied start A toward the enemy start E nearest p (Lanes::AllyStarts: ours and
every allied SMRTBARb's; Lanes::EnemyStarts). The line at p is the largest
Forward of the counted defensive buildings within Radius of p, so each part
of a wide front has its own line. Behind(p) = line - Forward(p).
LeftBehind(p): a line is known there and p is BehindMargin or more behind
it. No counted building within Radius: unknown, and callers keep the porc.

Only our own buildings draw the line (allied units cannot be listed); an
allied SMRTBARb asked to give buildings judges its own porc against its own
line.

Cost: Sweep is one pass over our units every SweepSeconds with one dictionary
lookup per finished structure; the kept list holds only defensive buildings.
LineAt is O(defensive buildings) per call; callers (site clearing) ask it a
handful of times per search.

******************************************************************************/
namespace PorcFrontLine {
    dictionary seenAt;          // id -> int64 frame first seen finished
    array<AIFloat3> pos;        // the last sweep's defensive buildings ...
    array<float> fwd;           // ... their Forward ...
    array<int> since;           // ... and the frame each was first seen finished
    array<AIFloat3> enemyStarts, allyStarts;
    int lastSweep = -100000;

    bool IsDefensive(const CCircuitDef@ d)
    {
        if (d is null || d.IsMobile()) return false;
        // any weapon: GetSurfThreat() is 0 for T1 ground porc in this build (LLT, HLLT, HLT, Maw: only the AA
        // counted in the 2026-11-18 lolcannon-siteclear fixture, 57 of ~280 defences)
        return d.GetMaxRange() > 0.0f;
    }

    float Forward(const AIFloat3 &in p)
    {
        if (enemyStarts.length() == 0 || allyStarts.length() == 0) return 0.0f;
        float best = 1.0e30f; uint bi = 0;
        for (uint i = 0; i < enemyStarts.length(); ++i) {
            const float sq = p.SqDistance2D(enemyStarts[i]);
            if (sq < best) { best = sq; bi = i; }
        }
        float abest = 1.0e30f; uint ai_ = 0;
        for (uint i = 0; i < allyStarts.length(); ++i) {
            const float sq = p.SqDistance2D(allyStarts[i]);
            if (sq < abest) { abest = sq; ai_ = i; }
        }
        return allyStarts[ai_].distance2D(enemyStarts[bi]) - sqrt(best);
    }

    void Sweep()
    {
        lastSweep = ai.frame;
        enemyStarts = Lanes::EnemyStarts();
        allyStarts = Lanes::AllyStarts();
        pos.resize(0); fwd.resize(0); since.resize(0);
        dictionary next;
        array<Id>@ own = ai.GetOwnedUnitIds();
        for (uint i = 0; i < own.length(); ++i) {
            CCircuitUnit@ u = ai.GetTeamUnit(own[i]);
            if (!ai.IsOwnedUnit(u) || !IsDefensive(u.circuitDef) || u.GetBuildProgress() < 1.0f) continue;
            const string key = "" + u.id;
            int64 at = 0;   // int64 and only on a hit: an int out-arg is unreliable on a miss (11-18)
            if (!seenAt.get(key, at)) at = int64(ai.frame);
            next.set(key, at);
            const AIFloat3 p = u.GetPos(ai.frame);
            pos.insertLast(p);
            fwd.insertLast(Forward(p));
            since.insertLast(int(at));
        }
        seenAt = next;   // gone buildings drop out
    }

    // Main AiUpdate (every second); self-limited to every SweepSeconds
    void Tick()
    {
        if (ai.frame - lastSweep >= int(Global::PorcFrontLine::SweepSeconds * SECOND)) Sweep();
    }
    void Ensure() { if (lastSweep < 0 || ai.frame - lastSweep >= int(Global::PorcFrontLine::SweepSeconds * SECOND)) Sweep(); }

    // The line at p: the largest Forward of our counted defensive buildings within Radius
    float LineAt(const AIFloat3 &in p, bool &out known)
    {
        Ensure();
        known = false;
        float line = -1.0e30f;
        const float r = Global::PorcFrontLine::Radius;
        const int age = int(Global::PorcFrontLine::MinAgeSeconds * SECOND);
        for (uint i = 0; i < pos.length(); ++i) {
            if (ai.frame - since[i] < age || pos[i].SqDistance2D(p) > r * r) continue;
            if (fwd[i] > line) { line = fwd[i]; known = true; }
        }
        return line;
    }
    // How far p stands behind the line (< 0 ahead of it); known false: no line there
    float Behind(const AIFloat3 &in p, bool &out known)
    {
        const float line = LineAt(p, known);
        return known ? line - Forward(p) : 0.0f;
    }
    bool LeftBehind(const AIFloat3 &in p)
    {
        bool known = false;
        const float b = Behind(p, known);
        return known && b >= Global::PorcFrontLine::BehindMargin;
    }
}  // namespace PorcFrontLine

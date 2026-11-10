#pragma once
// D-512: a battle group grows bolder as it trades well and falls back to heal
// as it trades badly. Engine-free (tests/trade_momentum_test.cpp).
//
// Ledger. Metal the group's members killed (the engine's enemy-destroyed
// event names the attacker) and metal it lost, each decaying with a
// half-life so the last fights count most. O(1) per kill or loss, applied
// lazily: nothing runs per frame.
//
// Momentum. m = (killed - lost) / (killed + lost + prior), in (-1, 1). The
// prior (metal) is the evidence a sign needs: one lucky kill is not a streak.
//
// Effects (the cohort plan, task/fighter/GroundCohorts.cpp):
//   winning  the entry advantage needed to commit shrinks by press x m and the
//            loss limit grows by the same share; at m >= push a group with
//            nothing in sight (enemy jammer, fog) keeps advancing down the lane
//            instead of holding.
//   losing   the entry needed grows by caution x |m| and the loss limit shrinks;
//            at m <= -fall_back the group falls back to the nearest friendly
//            defence or group (D-510's help) and holds there to heal.
#include <algorithm>
#include <cmath>

namespace circuit::trade {

struct Ledger { float killed = 0.f, lost = 0.f; int frame = -1; };

// Brings the ledger to `frame`: both sums halve every halfLifeFrames. O(1).
inline void Decay(Ledger& l, int frame, int halfLifeFrames) {
    if (l.frame >= 0 && frame > l.frame && halfLifeFrames > 0) {
        const float keep = std::exp2(-float(frame - l.frame) / float(halfLifeFrames));
        l.killed *= keep; l.lost *= keep;
    }
    l.frame = std::max(l.frame, frame);
}
inline void Kill(Ledger& l, float metal, int frame, int halfLifeFrames) {
    Decay(l, frame, halfLifeFrames); l.killed += std::max(0.f, metal);
}
inline void Loss(Ledger& l, float metal, int frame, int halfLifeFrames) {
    Decay(l, frame, halfLifeFrames); l.lost += std::max(0.f, metal);
}
inline float Momentum(const Ledger& l, float prior) {
    const float total = l.killed + l.lost + std::max(1.f, prior);
    return (l.killed - l.lost) / total;
}

// The advantage a commitment needs, as a factor on advantage_enter.
inline constexpr float MIN_ENTRY_SCALE = .25f;  // a winning streak never commits for nothing
inline float EntryScale(float m, float press, float caution) {
    return m >= 0.f ? std::max(MIN_ENTRY_SCALE, 1.f - press * m) : 1.f + caution * -m;
}
// The share of HP a commitment may cost, as a factor on the loss limit.
inline float LossScale(float m, float press, float caution) {
    return m >= 0.f ? 1.f + press * m : 1.f / (1.f + caution * -m);
}
inline bool Pushes(float m, float push) { return push > 0.f && m >= push; }
inline bool FallsBack(float m, float fallBack) { return fallBack > 0.f && m <= -fallBack; }

} // namespace circuit::trade

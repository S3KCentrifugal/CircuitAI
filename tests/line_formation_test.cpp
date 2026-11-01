// D-430: the line formation kernel (control/kernel/LineFormation.h):
// composition classes, facing with a heading deadband, spacing from enemy
// splash, order routing with per-slot delays and the one-mind damping.
#include "control/kernel/LineFormation.h"

#include <cassert>
#include <cstdio>

using namespace circuit;
using namespace circuit::line;

int main() {
    {  // Composition: Thug reach 380. Pawn 180 short, Mace 380 peer, Shellshocker 700 long.
        assert(Classify(true, false, 180, 380, .25f) == Threat::SHORT);
        assert(Classify(true, false, 380, 380, .25f) == Threat::PEER);
        assert(Classify(true, false, 460, 380, .25f) == Threat::PEER);   // within the band
        assert(Classify(true, false, 700, 380, .25f) == Threat::LONG);
        assert(Classify(false, false, 320, 380, .25f) == Threat::STATIC);
        assert(Classify(true, true, 300, 380, .25f) == Threat::COMMANDER);
        Composition c;
        assert(!c.any);
        c.Add(Threat::SHORT, 100, {0, 0}, 0);
        c.Add(Threat::SHORT, 100, {200, 0}, 0);
        c.Add(Threat::LONG, 300, {400, 0}, 96);
        assert(c.any && c.total == 500 && c.count[int(Threat::SHORT)] == 2 && c.maxSplash == 96);
        assert(c.Dominant() == Threat::LONG);
        const auto centroid = c.Centroid();
        assert(centroid.x == 280 && centroid.z == 0);  // metal-weighted
    }
    {  // Facing and the deadband: a weaving enemy does not re-slot the line.
        const auto back = Facing({1000, 1000}, {1000, 1400});
        assert(back.x == 0 && back.z == -1);
        assert(Facing({5, 5}, {5, 5}).x == 0 && Facing({5, 5}, {5, 5}).z == 0);  // coincident: keep
        assert(Reorient({0, 0}, back, 20));          // first facing always applies
        assert(!Reorient(back, {0, 0}, 20));         // no axis: keep
        assert(!Reorient(back, {.17f, -.985f}, 20)); // 10 degrees: within deadband
        assert(Reorient(back, {.5f, -.866f}, 20));   // 30 degrees: re-slot
        assert(Reorient(back, {0, 1}, 20));          // reversed
    }
    {  // Spacing: Janus splash 120 at spacing 64 asks 240, capped at 2x; Pawn none.
        assert(Spread(0, 64, 2) == 1.f);
        assert(Spread(20, 64, 2) == 1.f);           // never tighter than configured
        assert(Spread(48, 64, 2) == 1.5f);
        assert(Spread(120, 64, 2) == 2.f);          // cap
        assert(Spread(120, 64, 4) == 3.75f);
        assert(Spread(120, 0, 2) == 1.f);
    }
    {  // Delays: fixed seconds, or the time to open the separation.
        assert(DelayFrames(1.f, 0, 45) == 30);
        assert(DelayFrames(0.f, 90, 45) == 0);
        assert(DelayFrames(-1.f, 90, 45) == 60);    // 90 elmos at 45 elmos/s = 2 s
        assert(DelayFrames(-1.f, 90, 0) == 2700);   // speed clamped to 1
        assert(DelayFrames(-1.f, -5, 45) == 0);
    }
    {  // Orders from the cohort's modes; caution ranks; damping.
        assert(InternalOrder(3, true, true) == Order::WITHDRAW);   // WITHDRAW
        assert(InternalOrder(2, true, true) == Order::WITHDRAW);   // KITE
        assert(InternalOrder(4, true, true) == Order::ATTACK);     // RUSH
        assert(InternalOrder(0, true, true) == Order::ATTACK);     // ADVANCE on a committed target
        assert(InternalOrder(0, true, false) == Order::ADVANCE);
        assert(InternalOrder(0, false, false) == Order::ADVANCE);
        assert(InternalOrder(1, false, false) == Order::HOLD);
        assert(InternalOrder(5, true, true) == Order::ADVANCE);    // REGROUP
        assert(Effective(Order::ATTACK, Order::WITHDRAW) == Order::WITHDRAW);  // script more cautious wins
        assert(Effective(Order::WITHDRAW, Order::ATTACK) == Order::WITHDRAW);  // own caution wins
        assert(Effective(Order::ADVANCE, Order::HOLD) == Order::HOLD);
        assert(Effective(Order::ADVANCE, Order::NONE) == Order::ADVANCE);
        assert(Effective(Order::ATTACK, Order::ADVANCE) == Order::ATTACK);     // equal caution: own
        assert(Replace(Order::ADVANCE, Order::WITHDRAW, 0, 30));   // more cautious at once
        assert(!Replace(Order::WITHDRAW, Order::ADVANCE, 10, 30)); // less cautious waits
        assert(Replace(Order::WITHDRAW, Order::ADVANCE, 30, 30));
        assert(!Replace(Order::HOLD, Order::HOLD, 100, 30));
    }
    {  // Routing a withdrawal: the rear goes now, the screen covers one second.
        const Routing withdraw{1.f, 0.f, true};
        const int screenDelay = DelayFrames(withdraw.screenDelay, 0, 45), rearDelay = DelayFrames(withdraw.rearDelay, 0, 45);
        assert(StanceFor(Order::WITHDRAW, Slot::REAR, withdraw, 0, rearDelay) == Stance::WITHDRAW);
        assert(StanceFor(Order::WITHDRAW, Slot::SCREEN, withdraw, 0, screenDelay) == Stance::COVER);
        assert(StanceFor(Order::WITHDRAW, Slot::SCREEN, withdraw, 29, screenDelay) == Stance::COVER);
        assert(StanceFor(Order::WITHDRAW, Slot::SCREEN, withdraw, 30, screenDelay) == Stance::WITHDRAW);
        const Routing noCover{1.f, 0.f, false};
        assert(StanceFor(Order::WITHDRAW, Slot::SCREEN, noCover, 0, 30) == Stance::HOLD);
        // Advance: the screen leads, the rear waits for the separation to open.
        const Routing advance{0.f, -1.f, false};
        assert(StanceFor(Order::ADVANCE, Slot::SCREEN, advance, 0, 0) == Stance::FOLLOW);
        const int rearAdvance = DelayFrames(advance.rearDelay, 90, 45);
        assert(StanceFor(Order::ADVANCE, Slot::REAR, advance, 0, rearAdvance) == Stance::HOLD);
        assert(StanceFor(Order::ADVANCE, Slot::REAR, advance, 60, rearAdvance) == Stance::FOLLOW);
        // Attack: the screen engages, the rear fires over it.
        const Routing attack{0.f, 0.f, false};
        assert(StanceFor(Order::ATTACK, Slot::SCREEN, attack, 0, 0) == Stance::ENGAGE);
        assert(StanceFor(Order::ATTACK, Slot::REAR, attack, 0, 0) == Stance::FOLLOW);
        assert(StanceFor(Order::HOLD, Slot::REAR, attack, 0, 0) == Stance::HOLD);
        assert(StanceFor(Order::NONE, Slot::REAR, attack, 0, 0) == Stance::FOLLOW);
    }
    std::puts("line formation: composition, facing, spread, delays, orders and routing PASS");
    return 0;
}

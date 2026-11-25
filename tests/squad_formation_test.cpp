// Owner 2026-11-24: the battle squad formation kernel (control/kernel/SquadFormation.h):
// rank rows front to back, row slots, the order from the local balance and
// momentum, the advance pace, break-up and merge rules.
#include "control/kernel/SquadFormation.h"

#include <cassert>
#include <cmath>
#include <cstdio>

using namespace circuit;
using namespace circuit::squad_formation;
using battle_group::Order;

static bool Near(float a, float b) { return std::fabs(a - b) < 1e-3f; }

int main() {
    {  // Rows: artillery at the anchor, utility in the middle, the screen in front.
        const Rows all = Stack(true, true, 120.f, 140.f);
        assert(Near(all.artillery, 0.f) && Near(all.utility, 120.f) && Near(all.screen, 260.f));
        // No utility: the screen stands screen_ahead in front of the guns... plus nothing.
        const Rows noUtility = Stack(false, true, 120.f, 140.f);
        assert(Near(noUtility.screen, 140.f));
        // No artillery (a heavy squad): the utility on the anchor, the screen in front of it only.
        const Rows heavy = Stack(true, false, 120.f, 140.f);
        assert(Near(heavy.utility, 0.f) && Near(heavy.screen, 140.f));
        // One rank: everybody on the anchor.
        const Rows screenOnly = Stack(false, false, 120.f, 140.f);
        assert(Near(screenOnly.screen, 0.f));
        // Negative gaps are clamped.
        const Rows clamped = Stack(true, true, -5.f, -5.f);
        assert(Near(clamped.utility, 0.f) && Near(clamped.screen, 0.f));
    }
    {  // Row slots: centred across the axis, a full row wraps backwards.
        assert(PerRow(400.f, 80.f) == 6 && PerRow(0.f, 80.f) == 1 && PerRow(10.f, 80.f) == 1);
        const ranged::Point forward{1.f, 0.f};  // enemy to the +x side: lateral is z
        const ranged::Point c{1000.f, 1000.f};
        const auto a = RowSlot(c, forward, 0, 3, 80.f, 6, 64.f);
        const auto b = RowSlot(c, forward, 1, 3, 80.f, 6, 64.f);
        const auto d = RowSlot(c, forward, 2, 3, 80.f, 6, 64.f);
        assert(Near(a.x, 1000.f) && Near(a.z, 920.f) && Near(b.z, 1000.f) && Near(d.z, 1080.f));
        // 7 members, 6 per row: the 7th stands alone, centred, one row back.
        const auto seventh = RowSlot(c, forward, 6, 7, 80.f, 6, 64.f);
        assert(Near(seventh.x, 936.f) && Near(seventh.z, 1000.f));
    }
    {  // Orders from the balance.
        Balance none;
        assert(Decide(none, Order::NONE, 1.3f, .8f, 1.f, false) == Order::ADVANCE);
        assert(Decide(none, Order::ATTACK, 1.3f, .8f, 1.f, true) == Order::WITHDRAW);  // losing: heal first
        Balance strong{2000.f, 1000.f, true};
        assert(Decide(strong, Order::ADVANCE, 1.3f, .8f, 1.f, false) == Order::ATTACK);
        Balance even{1000.f, 1000.f, true};
        assert(Decide(even, Order::ADVANCE, 1.3f, .8f, 1.f, false) == Order::HOLD);
        assert(Decide(even, Order::ATTACK, 1.3f, .8f, 1.f, false) == Order::ATTACK);  // hysteresis
        // Winning lowers the bar: entry scale .7 commits at 1.0.
        assert(Decide(even, Order::HOLD, 1.3f, .8f, .7f, false) == Order::ATTACK);
        Balance weak{500.f, 1000.f, true};
        assert(Decide(weak, Order::ATTACK, 1.3f, .8f, 1.f, false) == Order::WITHDRAW);
    }
    {  // Pace, break-up, merge, direction.
        assert(Near(AdvanceStep(1000.f, 0.f, 200.f, 300.f, false), 300.f));
        assert(Near(AdvanceStep(100.f, 0.f, 200.f, 300.f, false), 100.f));    // never past the goal
        assert(Near(AdvanceStep(1000.f, 250.f, 200.f, 300.f, false), 0.f));   // waits for the slowest
        assert(Near(AdvanceStep(1000.f, 250.f, 200.f, 300.f, true), 300.f));  // the wait ran out
        assert(Broken(1, 2) && !Broken(2, 2) && !Broken(0, 0));
        assert(CanMerge(4, 5, 100.f * 100.f, 1500.f, 32, false, false));
        assert(!CanMerge(4, 5, 100.f * 100.f, 1500.f, 32, true, false));
        assert(!CanMerge(20, 20, 100.f * 100.f, 1500.f, 32, false, false));
        assert(!CanMerge(4, 5, 2000.f * 2000.f, 1500.f, 32, false, false));
        const auto t = Toward({0.f, 0.f}, {0.f, 10.f}, {1.f, 0.f});
        assert(Near(t.x, 0.f) && Near(t.z, 1.f));
        const auto f = Toward({5.f, 5.f}, {5.f, 5.f}, {1.f, 0.f});
        assert(Near(f.x, 1.f) && Near(f.z, 0.f));
        assert(SlotOf(Rank::SCREEN) == battle_group::Slot::SCREEN && SlotOf(Rank::ARTILLERY) == battle_group::Slot::REAR);
    }
    {  // Hysteresis (owner 2026-11-25): no single-decision retreat, a held withdrawal, a clear re-entry.
        Hysteresis h; int streak = 0;
        assert(Settle(Order::ATTACK, Order::WITHDRAW, 100, .5f, 1.2f, 1.f, h, streak) == Order::ATTACK && streak == 1);
        assert(Settle(Order::ATTACK, Order::WITHDRAW, 130, .5f, 1.2f, 1.f, h, streak) == Order::WITHDRAW && streak == 2);
        streak = 0;
        assert(Settle(Order::WITHDRAW, Order::ATTACK, 100, 2.f, 1.2f, 1.f, h, streak) == Order::WITHDRAW);  // still holding
        assert(Settle(Order::WITHDRAW, Order::ATTACK, 400, 1.3f, 1.2f, 1.f, h, streak) == Order::HOLD);     // 1.3 < 1.5
        assert(Settle(Order::WITHDRAW, Order::ATTACK, 400, 1.6f, 1.2f, 1.f, h, streak) == Order::ATTACK);
        assert(Settle(Order::WITHDRAW, Order::ADVANCE, 400, 0.f, 1.2f, 1.f, h, streak) == Order::ADVANCE);
        assert(Settle(Order::HOLD, Order::WITHDRAW, 0, .5f, 1.2f, 1.f, h, streak) == Order::WITHDRAW);       // only attack waits
    }
    std::puts("squad_formation_test: ok");
    return 0;
}

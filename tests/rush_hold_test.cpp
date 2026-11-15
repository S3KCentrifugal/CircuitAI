// D-513: the rush hold (control/kernel/RushHold.h): ten Thugs at full health,
// half of them dead, half their health lost spread across all, and the off switch.
#include "control/kernel/RushHold.h"

#include <cassert>
#include <cstdio>

using namespace circuit;

int main() {
    constexpr float THUG = 1100.f, START = 10 * THUG;
    assert(rush_hold::Holds(START, START, .5f));                 // just committed
    assert(rush_hold::Holds(6 * THUG, START, .5f));              // four dead: 40% lost, still rushing
    assert(!rush_hold::Holds(5 * THUG, START, .5f));             // five dead: 50% lost, the hold ends
    assert(!rush_hold::Holds(10 * THUG * .45f, START, .5f));     // all alive at 45%: also ends
    assert(rush_hold::Holds(10 * THUG * .55f, START, .5f));
    assert(rush_hold::Holds(3 * THUG, START, .8f));              // a deeper hold: 70% lost, still holding
    assert(!rush_hold::Holds(START, START, 0.f));                // off
    assert(!rush_hold::Holds(100.f, 0.f, .5f));                  // nothing to hold
    std::puts("rush_hold_test: ok");
    return 0;
}

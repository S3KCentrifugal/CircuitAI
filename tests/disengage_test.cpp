// D-433: the retreat rule and repair rotation kernel (control/kernel/Disengage.h).
#include "control/kernel/Disengage.h"

#include <cassert>
#include <cstdio>

using namespace circuit;

int main() {
    {  // ShouldRetreat: threshold, veteran bonus, escape feasibility, the off switch.
        assert(disengage::ShouldRetreat(.30f, 0.f, true, .35f, .1f));       // under the threshold
        assert(!disengage::ShouldRetreat(.40f, 0.f, true, .35f, .1f));      // above it
        assert(disengage::ShouldRetreat(.40f, 1.f, true, .35f, .1f));       // a veteran leaves at 45
        assert(disengage::ShouldRetreat(.40f, 5.f, true, .35f, .1f));       // experience clamped to 1: still 45, not 85
        assert(!disengage::ShouldRetreat(.46f, 5.f, true, .35f, .1f));
        assert(!disengage::ShouldRetreat(.10f, 1.f, false, .35f, .1f));     // cannot escape: stay and fire
        assert(!disengage::ShouldRetreat(.10f, 1.f, true, 0.f, .1f));       // rule off
        assert(disengage::ShouldRetreat(.35f, 0.f, true, .35f, 0.f));       // at the threshold
    }
    {  // CanEscape: no hazard, a static hazard, a slower hazard, a kiteable faster hazard.
        assert(disengage::CanEscape(false, false, 0.f, 0.f, 45.f, 380.f, 1.25f));
        assert(disengage::CanEscape(true, false, 0.f, 430.f, 45.f, 380.f, 1.25f));      // a tower: walk out
        assert(disengage::CanEscape(true, true, 40.f, 325.f, 45.f, 380.f, 1.25f));      // a slower Centurion
        assert(disengage::CanEscape(true, true, 45.f, 325.f, 45.f, 380.f, 1.25f));      // the same speed
        assert(!disengage::CanEscape(true, true, 90.f, 325.f, 45.f, 380.f, 1.25f));     // a Pawn: faster, and 55 of band is too narrow
        assert(disengage::CanEscape(true, true, 90.f, 200.f, 45.f, 380.f, 1.25f));      // a Pawn against a 180 advantage: kite
        assert(!disengage::CanEscape(true, true, 90.f, 475.f, 45.f, 380.f, 1.25f));     // outranged and outrun
    }
    {  // WantsRepair: under the health line, once per cooldown, off at 0.
        assert(disengage::WantsRepair(.5f, .6f, 1000, -1, 600));
        assert(!disengage::WantsRepair(.7f, .6f, 1000, -1, 600));
        assert(!disengage::WantsRepair(.5f, .6f, 1000, 800, 600));   // cooling down
        assert(disengage::WantsRepair(.5f, .6f, 1400, 800, 600));    // cooled
        assert(!disengage::WantsRepair(.5f, 0.f, 1000, -1, 600));    // off
        assert(!disengage::WantsRepair(.6f, .6f, 1000, -1, 600));    // at the line: not under it
    }
    std::puts("disengage_test: ok");
    return 0;
}

#pragma once
// D-513: a committed rush holds until the members it began with have lost a
// configured share of their health. Engine-free (tests/rush_hold_test.cpp).
//
// The owner: "when a rush is initiated ... the units do not retreat until the
// group it started at in terms of health reaches lower than 50% health. So
// for example if they started rush with 10 units and 5 died, that would be 50%
// health lost from the initial sum. It should be configurable." The health is
// the sum over the members at the start (the dead count 0), against that sum
// at the start; rush_hold_loss is the share that ends the hold.
#include <algorithm>

namespace circuit::rush_hold {

// The hold stands while current > (1 - loss) x initial; loss <= 0 is off.
inline bool Holds(float current, float initial, float loss) {
    if (loss <= 0.f || initial <= 0.f) return false;
    return current > (1.f - std::min(1.f, loss)) * initial;
}

} // namespace circuit::rush_hold

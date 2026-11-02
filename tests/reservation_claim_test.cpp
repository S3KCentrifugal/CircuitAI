#include "terrain/ReservationClaim.h"
#include <cassert>
#include <set>

int main()
{
    using circuit::reservation::AllowsReservedCell;
    assert(AllowsReservedCell(1, 1, false));
    assert(AllowsReservedCell(1, 1, true));
    assert(AllowsReservedCell(1, 0, true)); // reclaimed opening, then exact claim
    assert(!AllowsReservedCell(1, 0, false)); // no authority over another mark
    assert(!AllowsReservedCell(1, 2, true)); // another corridor remains protected
    assert(!AllowsReservedCell(0, 0, true)); // unscoped placement is unchanged
    std::set<int> claimed{7}; // Another task owns seven.
    int own = -1;
    int calls = 0;
    auto claim = [&](int id) { ++calls; return claimed.insert(id).second; };
    auto unclaim = [&](int id) { assert(claimed.erase(id) == 1); };
    assert(!circuit::reservation::ReplaceClaim(own, 7, claim, unclaim));
    assert(own == -1 && claimed.count(7));
    assert(circuit::reservation::ReplaceClaim(own, 3, claim, unclaim));
    const int before = calls;
    assert(circuit::reservation::ReplaceClaim(own, 3, claim, unclaim));
    assert(calls == before); // Activation plus explicit pin is idempotent.
    assert(!circuit::reservation::ReplaceClaim(own, 7, claim, unclaim));
    assert(own == 3 && claimed.count(3) && claimed.count(7));
    assert(circuit::reservation::ReplaceClaim(own, 4, claim, unclaim));
    assert(!claimed.count(3) && claimed.count(4) && claimed.count(7));
    assert(!circuit::reservation::ReplaceClaim(own, -1, claim, unclaim));
    unclaim(own); // Abort releases only this task's retained claim.
    assert(claimed == std::set<int>{7});
}

// D-514: the battle group's repair crew (control/kernel/RepairCrew.h): one bot
// per twelve members, the one-at-a-time repair trip, and reclaim versus resurrect.
#include "control/kernel/RepairCrew.h"

#include <cassert>
#include <cstdio>

using namespace circuit;
using repair_crew::Candidate;
using repair_crew::Recovery;

int main() {
    // Need: 1 per 12, floored, capped.
    assert(repair_crew::Need(11, 12.f, 3) == 0);
    assert(repair_crew::Need(12, 12.f, 3) == 1);
    assert(repair_crew::Need(23, 12.f, 3) == 1);
    assert(repair_crew::Need(24, 12.f, 3) == 2);
    assert(repair_crew::Need(44, 12.f, 3) == 3);   // the cap
    assert(repair_crew::Need(44, 12.f, 0) == 3);   // uncapped: 44 / 12
    assert(repair_crew::Need(24, 0.f, 3) == 0);    // off
    assert(repair_crew::Need(0, 12.f, 3) == 0);

    // Keep: a group holds the bots it has while ceil(members / 12) allows.
    assert(repair_crew::Keep(9, 12.f, 3) == 1);    // fourteen cut to nine: keeps its bot
    assert(repair_crew::Keep(1, 12.f, 3) == 1);
    assert(repair_crew::Keep(13, 12.f, 3) == 2);
    assert(repair_crew::Keep(0, 12.f, 3) == 0);
    assert(repair_crew::Keep(40, 12.f, 3) == 3);
    assert(repair_crew::Keep(9, 0.f, 3) == 0);

    // Trip: the lowest under the line, ties to the lower id, none above it.
    assert(repair_crew::ChooseTrip({{5, .9f}, {7, .4f}, {3, .55f}}, .6f) == 7);
    assert(repair_crew::ChooseTrip({{9, .3f}, {4, .3f}}, .6f) == 4);
    assert(repair_crew::ChooseTrip({{1, .6f}, {2, .95f}}, .6f) == -1);
    assert(repair_crew::ChooseTrip({}, .6f) == -1);
    assert(repair_crew::TripDone(.95f, .95f));
    assert(!repair_crew::TripDone(.94f, .95f));

    // Recovery: low metal reclaims, plenty of metal with energy resurrects,
    // plenty of metal without energy waits.
    assert(repair_crew::Mode(.2f, .1f, .5f, .3f) == Recovery::RECLAIM);
    assert(repair_crew::Mode(.2f, .9f, .5f, .3f) == Recovery::RECLAIM);
    assert(repair_crew::Mode(.7f, .5f, .5f, .3f) == Recovery::RESURRECT);
    assert(repair_crew::Mode(.7f, .1f, .5f, .3f) == Recovery::NONE);
    assert(repair_crew::Fraction(500.f, 1000.f) == .5f);
    assert(repair_crew::Fraction(5.f, 0.f) == 0.f);
    std::puts("repair_crew_test: ok");
    return 0;
}

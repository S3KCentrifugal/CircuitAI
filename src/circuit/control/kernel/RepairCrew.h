#pragma once
// D-514: a battle group's repair crew (resurrection bots), engine-free
// (tests/repair_crew_test.cpp). The battle group controller
// (control/group/BattleGroupController.cpp) supplies member health and the
// crew counts, the rezzer controller (control/unit/rezzer/RezzerController.cpp)
// walks and orders the bots.
//
// Need. One bot for every `perUnits` members (screen and support):
//
//   need = min(max, floor(members / perUnits)), 0 when perUnits is 0.
//
// So twelve Thugs and Aggravators ask for one, twenty-four for two, eleven for
// none (the owner's 1 per 12, 2026-11-10). Production uses the escort formula
// (air_defence::Request): only the shortfall no assigned, spare, queued or
// building bot covers.
//
// Rotation. At most one member of a group is on a repair trip at a time: the
// lowest health fraction under `tripHealth` walks back to the crew; it rejoins
// at `doneHealth`. A tie goes to the lower unit id (deterministic).
//
// Recovery. With nothing to repair a bot reclaims while metal is low and
// resurrects while metal is plentiful and energy is not low:
//
//   metal fraction <  rezMetal                         -> reclaim
//   metal fraction >= rezMetal, energy >= rezEnergy    -> resurrect
//   otherwise (metal fine, energy low)                 -> neither: it waits at its station
#include <algorithm>
#include <cmath>
#include <vector>

namespace circuit::repair_crew {

// Bots a group of `members` needs; `max` 0 leaves it uncapped.
inline int Need(int members, float perUnits, int max) {
    if (perUnits <= 0.f || members <= 0) return 0;
    const int n = int(float(members) / perUnits);
    return max > 0 ? std::min(n, max) : n;
}

// Bots a group keeps: one per started `perUnits` members (ceil), so a group
// that had its twelve and lost three keeps its bot while it needs it most;
// only new bots wait for a full twelve (Need). b25 arena: the floor alone
// released the bot when the first wave cut fourteen members to nine.
inline int Keep(int members, float perUnits, int max) {
    if (perUnits <= 0.f || members <= 0) return 0;
    const int n = int(std::ceil(float(members) / perUnits));
    return max > 0 ? std::min(n, max) : n;
}

struct Candidate { int id = -1; float health = 1.f; };

// The member to send back: the lowest health fraction under `tripHealth`, or -1.
inline int ChooseTrip(const std::vector<Candidate>& members, float tripHealth) {
    int best = -1; float lowest = tripHealth;
    for (const Candidate& c : members) {
        if (c.health >= tripHealth) continue;
        if (best < 0 || c.health < lowest || (c.health == lowest && c.id < best)) { best = c.id; lowest = c.health; }
    }
    return best;
}

// The member at `health` has been repaired enough to rejoin.
inline bool TripDone(float health, float doneHealth) { return health >= doneHealth; }

enum class Recovery { RECLAIM, RESURRECT, NONE };

// What a bot with nothing to repair does with the wrecks near it.
inline Recovery Mode(float metalFraction, float energyFraction, float rezMetal, float rezEnergy) {
    if (metalFraction < rezMetal) return Recovery::RECLAIM;
    if (energyFraction >= rezEnergy) return Recovery::RESURRECT;
    return Recovery::NONE;
}

// A resource's fill fraction, 0 with no storage.
inline float Fraction(float current, float storage) {
    return storage > 0.f ? std::clamp(current / storage, 0.f, 1.f) : 0.f;
}

} // namespace circuit::repair_crew

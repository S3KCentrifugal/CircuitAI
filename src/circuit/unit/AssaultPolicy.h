#ifndef CIRCUIT_ASSAULT_POLICY_H
#define CIRCUIT_ASSAULT_POLICY_H

namespace circuit {

// Owner 2026-11-08: shared local-strength micro for Mace, Thug, Satyr,
// Aggravator, Rocketeer and Ballista (behaviour JSON "assault_micro").
// Every hull compares the metal of the allied AI assault hulls within
// `radius` to the metal of the enemy army and static defences within
// `radius`, and picks one of three cadences against the nearest enemy:
//   superiority (ratio >= superior): in to supIn*range, out to supOut*range
//     while reloading;
//   equivalence (equal <= ratio < superior): in eqIn, out eqOut, one shot
//     every eqPeriod seconds;
//   deficiency (ratio < equal): in defIn, out defOut, one shot every
//     defPeriod seconds.
// Heavy porc (Pulsar, Bulwark, Bastion, Persecutor, Rattlesnake, Eviscerator)
// whose reach covers the engagement ground overrides every mode: the hull
// leaves that reach by porcMargin and never steps in. Fire at will always.
struct AssaultPolicy {
    bool enabled = false;
    float radius = 800.f;
    float superior = 1.2f, equal = .9f;
    float supIn = .80f, supOut = .99f;
    float eqIn = .90f, eqOut = 1.01f, eqPeriod = 2.f;
    float defIn = .99f, defOut = 1.10f, defPeriod = 5.f;
    float porcMargin = 64.f;
    // Owner 2026-11-08 (Mace, Thug, Satyr): commander_no_retreat - against an
    // enemy commander the hull holds the step-in distance and never backs
    // out; commander_blast - it never stands inside an enemy commander's
    // death explosion (area of effect + commanderMargin), whatever the mode.
    bool commanderNoRetreat = false, commanderBlast = false;
    float commanderMargin = 4.f;
};

} // namespace circuit

#endif // CIRCUIT_ASSAULT_POLICY_H

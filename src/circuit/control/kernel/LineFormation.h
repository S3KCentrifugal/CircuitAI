#pragma once
// D-430: the line formation's decisions, engine-free (tests/line_formation_test.cpp).
// A line is a screen cohort (Thugs, Maces) and the rear cohort paired behind
// it (Aggravators, Rocketeers). The kernel answers four questions from plain
// numbers: how the enemy nearby is composed, which way the line should face
// and how far apart it should stand, which order the line is under, and what
// stance each slot kind takes as that order is routed to it with a delay.
#include "terrain/RangedGeometry.h"

#include <algorithm>
#include <cmath>

namespace circuit::line {

// Logged as integers: append only.
enum class Order : int { NONE = 0, ADVANCE = 1, ATTACK = 2, HOLD = 3, WITHDRAW = 4 };
enum class Slot : int { SCREEN = 0, REAR = 1 };
enum class Stance : int { FOLLOW = 0, COVER = 1, HOLD = 2, WITHDRAW = 3, ENGAGE = 4 };
// Hostile contacts by weapon reach relative to the screen's own reach.
enum class Threat : int { SHORT = 0, PEER = 1, LONG = 2, STATIC = 3, COMMANDER = 4, COUNT = 5 };

inline const char* Name(Order o) {
    switch (o) {
        case Order::NONE: return "none"; case Order::ADVANCE: return "advance"; case Order::ATTACK: return "attack";
        case Order::HOLD: return "hold"; case Order::WITHDRAW: return "withdraw";
    }
    return "?";
}
inline const char* Name(Stance s) {
    switch (s) {
        case Stance::FOLLOW: return "follow"; case Stance::COVER: return "cover"; case Stance::HOLD: return "hold";
        case Stance::WITHDRAW: return "withdraw"; case Stance::ENGAGE: return "engage";
    }
    return "?";
}

// How an order reaches the two slot kinds: a delay in seconds for each, and
// whether the screen covers (holds its band and keeps firing) through its
// delay instead of merely waiting. A negative delay means "the time the rear
// needs to open its separation at the screen's speed" (DelayFrames).
struct Routing {
    float screenDelay = 0.f, rearDelay = 0.f;
    bool screenCover = false;
};

struct Composition {
    float metal[int(Threat::COUNT)] = {};
    int count[int(Threat::COUNT)] = {};
    float total = 0.f, maxSplash = 0.f;
    ranged::Point weighted{0.f, 0.f};  // metal-weighted sum, divide by total
    bool any = false;
    void Add(Threat t, float value, ranged::Point at, float splash) {
        metal[int(t)] += value; ++count[int(t)]; total += value;
        weighted.x += at.x * value; weighted.z += at.z * value;
        maxSplash = std::max(maxSplash, splash); any = true;
    }
    ranged::Point Centroid() const {
        return total > 0.f ? ranged::Point{weighted.x / total, weighted.z / total} : weighted;
    }
    Threat Dominant() const {
        int best = 0;
        for (int i = 1; i < int(Threat::COUNT); ++i) if (metal[i] > metal[best]) best = i;
        return Threat(best);
    }
};

// A contact's class against the screen's reach. `band` is the fraction of the
// own reach within which a mobile enemy counts as a peer (a Mace to a Thug).
inline Threat Classify(bool mobile, bool commander, float enemyRange, float ownRange, float band) {
    if (commander) return Threat::COMMANDER;
    if (!mobile) return Threat::STATIC;
    if (std::fabs(enemyRange - ownRange) <= band * ownRange) return Threat::PEER;
    return enemyRange < ownRange ? Threat::SHORT : Threat::LONG;
}

// The line's "back": from the hostile centroid through the line's centre,
// unit length; {0,0} when the two coincide (keep the previous facing).
inline ranged::Point Facing(ranged::Point center, ranged::Point centroid) {
    const float dx = center.x - centroid.x, dz = center.z - centroid.z;
    const float length = std::sqrt(dx * dx + dz * dz);
    return length > 1.f ? ranged::Point{dx / length, dz / length} : ranged::Point{0.f, 0.f};
}
// Re-slot only when the axis turned more than the deadband, so a weaving
// enemy does not make every member re-slot each update.
inline bool Reorient(ranged::Point current, ranged::Point wanted, float deadbandDegrees) {
    if (wanted.x == 0.f && wanted.z == 0.f) return false;
    if (current.x == 0.f && current.z == 0.f) return true;
    const float dot = std::clamp(current.x * wanted.x + current.z * wanted.z, -1.f, 1.f);
    return std::acos(dot) > deadbandDegrees * 3.14159265f / 180.f;
}
// Spacing multiplier: adjacent slots at least one enemy splash diameter apart,
// never tighter than the configured spacing, never wider than `cap` times it.
inline float Spread(float maxSplash, float spacing, float cap) {
    if (spacing <= 0.f || maxSplash <= 0.f) return 1.f;
    return std::clamp(2.f * maxSplash / spacing, 1.f, std::max(1.f, cap));
}
// Frames before a slot kind acts on an order. A negative delay is the time to
// open `separation` elmos at `speed` elmos per second.
inline int DelayFrames(float seconds, float separation, float speed) {
    if (seconds >= 0.f) return int(seconds * 30.f);
    return int(std::max(0.f, separation) / std::max(1.f, speed) * 30.f);
}
// The order the line follows from its own assessment of the cohort it rides.
inline Order InternalOrder(int mode, bool hasTarget, bool committed) {
    // cohort::Mode: ADVANCE 0, HOLD 1, KITE 2, WITHDRAW 3, RUSH 4, REGROUP 5
    switch (mode) {
        case 2: case 3: return Order::WITHDRAW;
        case 4: return Order::ATTACK;
        case 1: return Order::HOLD;
        case 5: return Order::ADVANCE;
        default: return hasTarget && committed ? Order::ATTACK : Order::ADVANCE;
    }
}
// More cautious orders rank higher; the line always takes the more cautious
// of its own order and the script's.
inline int Caution(Order o) {
    switch (o) { case Order::WITHDRAW: return 3; case Order::HOLD: return 2; case Order::NONE: return 0; default: return 1; }
}
inline Order Effective(Order internal, Order script) {
    return Caution(script) > Caution(internal) ? script : internal;
}
// A less cautious order replaces the current one only after it has held
// `minFrames` (damping mode flicker); a more cautious one replaces at once.
inline bool Replace(Order current, Order wanted, int held, int minFrames) {
    if (wanted == current) return false;
    return Caution(wanted) >= Caution(current) || held >= minFrames;
}
// The stance a slot kind takes `elapsed` frames into an order whose routing
// gives it `delay` frames.
inline Stance StanceFor(Order order, Slot slot, const Routing& routing, int elapsed, int delay) {
    const bool due = elapsed >= delay;
    switch (order) {
        case Order::WITHDRAW:
            if (due) return Stance::WITHDRAW;
            return slot == Slot::SCREEN && routing.screenCover ? Stance::COVER : Stance::HOLD;
        case Order::ADVANCE: return due ? Stance::FOLLOW : Stance::HOLD;
        case Order::ATTACK: return due ? (slot == Slot::SCREEN ? Stance::ENGAGE : Stance::FOLLOW) : Stance::HOLD;
        case Order::HOLD: return Stance::HOLD;
        default: return Stance::FOLLOW;
    }
}

// What a member's controller reads. Plain data.
struct Directive {
    Stance stance = Stance::FOLLOW;
    Order order = Order::NONE;
    int orderFrame = -1;        // when the current order was issued
    bool facingSet = false;
    ranged::Point facing{0.f, 0.f};
    float spread = 1.f;
    int line = -1;
    int generation = 0;
};

} // namespace circuit::line

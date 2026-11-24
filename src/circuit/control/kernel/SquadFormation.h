#pragma once
// Owner 2026-11-24: battle squads (control/group/BattleSquads.h), engine-free
// (tests/squad_formation_test.cpp). A battle squad is a script-made squad (the
// FRONT T2 artillery and bot squads, the T3 heavy wave) whose members a native
// controller places and orders with the battle group's rules (D-430,
// kernel/BattleGroup.h). Three ranks stand front to back along the axis to the
// enemy:
//   screen     the heavy damage soakers (Bulls, Welders, Mammoths, Titans ...)
//   utility    radar, jammer and flak, in the middle, covered by the screen
//   artillery  at the back, each gun at its own height-aware reach from the
//              target (the caller solves it with CRangedWorld::StandoffRange)
// A squad without artillery puts its utility at the anchor and the screen in
// front of it; a squad of one rank stands on the anchor.
//
// Everything here is O(members) or less on plain numbers; the controller
// calls it once per squad update.
#include "control/kernel/BattleGroup.h"
#include "terrain/RangedGeometry.h"

#include <algorithm>
#include <cmath>

namespace circuit::squad_formation {

// Logged as integers: append only.
enum class Rank : int { SCREEN = 0, UTILITY = 1, ARTILLERY = 2, COUNT = 3 };

inline const char* Name(Rank r) {
    switch (r) {
        case Rank::SCREEN: return "screen"; case Rank::UTILITY: return "utility";
        case Rank::ARTILLERY: return "artillery"; default: break;
    }
    return "?";
}

// The battle group slot kind a rank follows for order routing: the screen
// is the screen, utility and artillery are the rear (a withdrawal reaches
// them first, the screen covers through its delay).
inline battle_group::Slot SlotOf(Rank r) {
    return r == Rank::SCREEN ? battle_group::Slot::SCREEN : battle_group::Slot::REAR;
}

// Distance of each rank's row in front of the anchor (toward the enemy).
struct Rows { float screen = 0.f, utility = 0.f, artillery = 0.f; };
inline Rows Stack(bool hasUtility, bool hasArtillery, float utilityAhead, float screenAhead) {
    Rows r;
    utilityAhead = std::max(0.f, utilityAhead); screenAhead = std::max(0.f, screenAhead);
    if (hasArtillery) {
        r.utility = utilityAhead;
        r.screen = (hasUtility ? utilityAhead : 0.f) + screenAhead;
    } else {
        r.utility = 0.f;
        r.screen = hasUtility ? screenAhead : 0.f;
    }
    return r;
}

// Members per row: as many as fit `width` at `spacing`, at least one.
inline int PerRow(float width, float spacing) {
    if (width <= 0.f || spacing <= 0.f) return 1;
    return std::max(1, int(width / spacing) + 1);
}

// The slot of the `index`-th of `count` members of one rank whose row centre
// is `centre`, facing `forward` (unit length). A full row wraps into another
// `depth` elmos further back (away from the enemy). Lateral order is by index,
// so the caller sorts members across the axis first (no crossing).
inline ranged::Point RowSlot(ranged::Point centre, ranged::Point forward, int index, int count,
                             float spacing, int perRow, float depth) {
    perRow = std::max(1, perRow);
    count = std::max(1, count);
    const int row = index / perRow;
    const int inRow = std::min(perRow, count - row * perRow);
    const float lateral = (float(index % perRow) - float(inRow - 1) * .5f) * spacing;
    const float back = depth * float(row);
    // left normal of forward: (-fz, fx)
    return {centre.x - forward.z * lateral - forward.x * back, centre.z + forward.x * lateral - forward.z * back};
}

// The order a squad takes from the local balance (metal x health of its armed
// members against the armed hostiles near it) and its trade momentum
// (kernel/TradeMomentum.h). Nothing near: advance down the lane, unless the
// squad is losing badly (fall back to heal). With contact: attack once the
// ratio reaches `enter` (scaled down while winning, up while losing), withdraw
// below `exit`, and in between keep attacking or hold.
struct Balance { float own = 0.f, hostile = 0.f; bool contact = false; };
inline battle_group::Order Decide(const Balance& b, battle_group::Order current, float enter, float exit,
                                  float entryScale, bool fallBack) {
    using battle_group::Order;
    if (!b.contact || b.hostile <= 0.f) return fallBack ? Order::WITHDRAW : Order::ADVANCE;
    const float ratio = b.own / b.hostile;
    if (ratio < exit * entryScale) return Order::WITHDRAW;
    if (ratio >= enter * entryScale) return Order::ATTACK;
    return current == Order::ATTACK ? Order::ATTACK : Order::HOLD;
}

// The anchor's next step while advancing: `step` toward the goal, never past
// it, and none while a member lags more than `tolerance` behind its place
// (the squad keeps its slowest member's pace) unless the wait ran out.
inline float AdvanceStep(float toGoal, float lag, float tolerance, float step, bool waitOver) {
    if (toGoal <= 0.f) return 0.f;
    if (lag > tolerance && !waitOver) return 0.f;
    return std::min(toGoal, std::max(0.f, step));
}

// A squad with fewer than `breakSize` armed members (screen and artillery) is
// broken: it joins another squad of its template or walks home.
inline bool Broken(int armed, int breakSize) { return breakSize > 0 && armed < breakSize; }

// Two squads merge when both are out of a fight, their centres are within
// `radius` and the result fits `sizeMax`.
inline bool CanMerge(int a, int b, float distanceSq, float radius, int sizeMax, bool aFighting, bool bFighting) {
    return a > 0 && b > 0 && !aFighting && !bFighting && a + b <= sizeMax && distanceSq <= radius * radius;
}

// The unit vector from `from` to `to`, or `fallback` when they coincide.
inline ranged::Point Toward(ranged::Point from, ranged::Point to, ranged::Point fallback) {
    const float dx = to.x - from.x, dz = to.z - from.z;
    const float length = std::sqrt(dx * dx + dz * dz);
    return length > 1.f ? ranged::Point{dx / length, dz / length} : fallback;
}

} // namespace circuit::squad_formation

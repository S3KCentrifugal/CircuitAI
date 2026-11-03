#ifndef SRC_CIRCUIT_TERRAIN_FACTORYDISTRICTGEOMETRY_H_
#define SRC_CIRCUIT_TERRAIN_FACTORYDISTRICTGEOMETRY_H_

#include "terrain/BaseLayoutGeometry.h"
#include <cmath>
#include <utility>

namespace circuit::base_layout {
// Hover movement ignores submerged terrain slope, but never an occupancy or
// invalid-sample sentinel. Connectivity admission still checks engine areas.
inline float FactoryExitSlope(float height, float slope, bool hover) {
    return hover && height < 0.f && std::isfinite(slope) ? 0.f : slope;
}

[[nodiscard]] inline bool OutsideBlast(float x, float z, const Rect& protectedArea, float radius)
{
    if (!protectedArea.IsValid() || !std::isfinite(radius) || radius < 0.f) return false;
    const float dx = x - std::clamp(x, protectedArea.minX * 16.f, protectedArea.maxX * 16.f);
    const float dz = z - std::clamp(z, protectedArea.minZ * 16.f, protectedArea.maxZ * 16.f);
    return dx * dx + dz * dz > radius * radius;
}

// Support-bank widths of a district: two T1 turrets behind the T1 lab, three
// behind the wider T2 lab (the legacy MakeFactoryCluster tiers use the same).
constexpr int kT1SupportColumns = 2;
constexpr int kT2SupportColumns = 3;
constexpr int kMaxSupportColumns = 8;
constexpr int kMaxSupportRows = 8;

// Opt-in geometry. The legacy TECH/SUPPORT bank sizes remain unchanged.
// Rows are reserved capacity, never a claim that the economy funds them.
[[nodiscard]] inline bool ResizeSupportBank(FactoryCluster& cluster,
        const Footprint& nano, int columns, int rows, float reach)
{
    if (!cluster.valid || columns < 1 || columns > kMaxSupportColumns || rows < 1 || rows > kMaxSupportRows
        || !(reach > 0.f) || nano.x <= 0 || nano.z <= 0) return false;
    const auto& factory = cluster.factory;
    const int facing = factory.facing;
    if (columns * nano.x > factory.footprint.x) return false;
    const Point rear = Offset(factory.centre, facing, -factory.footprint.z, 0);
    auto slots = GridBehind(rear, facing, nano, columns, rows, 0, false, 1);
    for (auto& slot : slots) {
        slot.centre.x2 = AlignParity(slot.centre.x2, (facing & 1) ? nano.z : nano.x);
        slot.centre.z2 = AlignParity(slot.centre.z2, (facing & 1) ? nano.x : nano.z);
        const float dx = float(slot.centre.x2 - factory.centre.x2) * HALF_CELL_ELMOS;
        const float dz = float(slot.centre.z2 - factory.centre.z2) * HALF_CELL_ELMOS;
        // Conservative centre-to-centre coverage, including the furthest row.
        if (dx * dx + dz * dz > reach * reach || !IsAligned(slot.centre, nano, facing)) return false;
    }
    cluster.nanoBounds = BoundsOf(slots);
    cluster.nanos = std::move(slots);
    return true;
}

[[nodiscard]] inline FactoryPair MakeFactoryDistrict(const Point& rear, int facing,
        const Footprint& first, const Footprint& second, const Footprint& nano,
        int firstRows, int secondRows, int gap, float reach)
{
    auto result = MakeFactoryPair(rear, facing, first, FactoryTier::T1,
        second, FactoryTier::T2, nano, gap);
    if (!result.valid) return result;
    result.valid = ResizeSupportBank(result.first, nano, kT1SupportColumns, firstRows, reach)
        && ResizeSupportBank(result.second, nano, kT2SupportColumns, secondRows, reach)
        && !Intersects(result.first.nanoBounds, result.second.nanoBounds);
    return result;
}

// D-460: the facings a factory at (x, z) may take toward a goal (its lane, or
// the enemy start before the lane exists), best first: the axis facing toward
// the goal, then each side facing that does not point away from it, the side
// nearer the goal first and the one toward the map interior (cx, cz) on a tie.
// The opposite facing is never returned. Facings: 0 south (+z), 1 east (+x),
// 2 north (-z), 3 west (-x). Returns the count written to `out` (0: no goal).
constexpr float kFacingSideTolerance = 0.05f;  // fraction of the goal distance
[[nodiscard]] inline float FacingDot(int facing, float dx, float dz)
{
    switch (facing) {
        case 0: return dz;
        case 1: return dx;
        case 2: return -dz;
        default: return -dx;
    }
}
[[nodiscard]] inline int FacingsToward(float x, float z, float gx, float gz, float cx, float cz, int out[3])
{
    const float dx = gx - x, dz = gz - z;
    const float length = std::sqrt(dx * dx + dz * dz);
    if (!std::isfinite(length) || length <= 0.f) return 0;
    const int primary = std::abs(dx) > std::abs(dz) ? (dx > 0.f ? 1 : 3) : (dz > 0.f ? 0 : 2);
    int first = (primary + 1) % 4, second = (primary + 3) % 4;
    const float a = FacingDot(first, dx, dz), b = FacingDot(second, dx, dz);
    if (b > a || (b == a && FacingDot(second, cx - x, cz - z) > FacingDot(first, cx - x, cz - z))) std::swap(first, second);
    int count = 0;
    out[count++] = primary;
    const float tolerance = -kFacingSideTolerance * length;
    if (FacingDot(first, dx, dz) >= tolerance) out[count++] = first;
    if (FacingDot(second, dx, dz) >= tolerance) out[count++] = second;
    return count;
}

} // namespace circuit::base_layout
#endif

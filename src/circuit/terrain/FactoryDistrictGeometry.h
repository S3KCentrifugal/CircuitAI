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

// Opt-in geometry. The legacy TECH/SUPPORT bank sizes remain unchanged.
// Rows are reserved capacity, never a claim that the economy funds them.
[[nodiscard]] inline bool ResizeSupportBank(FactoryCluster& cluster,
        const Footprint& nano, int columns, int rows, float reach)
{
    if (!cluster.valid || columns < 1 || columns > 8 || rows < 1 || rows > 8
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
    result.valid = ResizeSupportBank(result.first, nano, 2, firstRows, reach)
        && ResizeSupportBank(result.second, nano, 3, secondRows, reach)
        && !Intersects(result.first.nanoBounds, result.second.nanoBounds);
    return result;
}

} // namespace circuit::base_layout
#endif

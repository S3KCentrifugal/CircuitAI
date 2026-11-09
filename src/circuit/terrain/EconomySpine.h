#pragma once
#include "BaseLayoutGeometry.h"
#include <cmath>

namespace circuit::economy_spine {
using namespace base_layout;
enum Family { SUPPORT, REACTOR, CONVERTER };
struct Site { Slot slot; Family family; };
struct Plan {
    std::vector<Site> sites;
    Rect bounds;
    int columns = 0, rows = 0, facing = 0;
};
// Pure startup ranking: capacity always wins; neighbour space breaks capacity
// ties before travel. Exact ties retain the caller's deterministic order.
struct CandidateRank {
    int reactors = 0, converters = 0, support = 0, overlap = 0;
    float travel2 = 0;
};
inline bool BetterCandidate(const CandidateRank& a, const CandidateRank& b) {
    if (a.reactors != b.reactors) return a.reactors > b.reactors;
    if (a.converters != b.converters) return a.converters > b.converters;
    if (a.support != b.support) return a.support > b.support;
    if (a.overlap != b.overlap) return a.overlap < b.overlap;
    return a.travel2 < b.travel2;
}
inline int ExpansionOverlap(const Rect& bounds, const std::vector<Point>& samples) {
    int count = 0;
    for (const auto& p : samples)
        count += p.x2 >= bounds.minX * 2 && p.x2 < bounds.maxX * 2
            && p.z2 >= bounds.minZ * 2 && p.z2 < bounds.maxZ * 2;
    return count;
}
inline std::vector<Point> PreferenceOffsets(Point origin, const std::vector<Point>& neighbours, int radius) {
    std::vector<Point> offsets{{0,0}};
    if (radius <= 0) return offsets;
    auto add = [&](Point p) {
        if (std::find(offsets.begin(), offsets.end(), p) == offsets.end()) offsets.push_back(p);
    };
    // One directed offset from the closest neighbour; bounded regardless of
    // roster size. Remaining offsets cover every axis at half/full radius.
    const Point* nearest = nullptr;
    double best = 0;
    for (const auto& p : neighbours) {
        const double dx = double(origin.x2) - p.x2, dz = double(origin.z2) - p.z2;
        const double d = dx * dx + dz * dz;
        if (d > 0 && (!nearest || d < best)) { nearest = &p; best = d; }
    }
    if (nearest) {
        const double scale = radius / std::sqrt(best);
        add({int(std::lround((origin.x2 - nearest->x2) * scale)),
            int(std::lround((origin.z2 - nearest->z2) * scale))});
    }
    for (int r : {radius / 2, radius})
        for (Point p : {Point{1,0},Point{-1,0},Point{0,1},Point{0,-1},
                       Point{1,1},Point{-1,1},Point{1,-1},Point{-1,-1}})
            add({p.x2 * r, p.z2 * r});
    return offsets;
}
struct CandidateIndex { int offset, turn, shape; };
inline std::vector<CandidateIndex> CandidateOrder(int offsets, int limit) {
    std::vector<CandidateIndex> result;
    if (offsets <= 0 || limit <= 0) return result;
    result.reserve(std::min(limit, offsets * 24));
    // Give every size/wing combination a chance at home and in the preferred
    // direction before spending the remaining budget on large shifted plans.
    for (int pass = 0; pass < 2; ++pass)
        for (int shape = 0; shape < 6; ++shape)
            for (int offset = pass == 0 ? 0 : std::min(2, offsets);
                 offset < (pass == 0 ? std::min(2, offsets) : offsets); ++offset)
                for (int turn = 0; turn < 4; ++turn) {
                    if (int(result.size()) >= limit) return result;
                    result.push_back({offset,turn,shape});
                }
    return result;
}
inline float DistanceSquared(Point a, Point b) {
    const float dx = float(a.x2 - b.x2) * HALF_CELL_ELMOS;
    const float dz = float(a.z2 - b.z2) * HALF_CELL_ELMOS;
    return dx * dx + dz * dz;
}

// Planning-only O(E*N + R log R): retain holes rather than discarding a whole
// district. Economy slots must still have a buildable support slot in reach.
// Scratch flags belong to this survey; no terrain result survives the call.
inline bool RetainBuildable(Plan& plan, std::vector<unsigned char>& allowed,
    Point centre, float reach, int reactorLimit)
{
    if (allowed.size() != plan.sites.size() || reach <= 0 || reactorLimit < 1) return false;
    std::vector<size_t> reactors;
    const float reach2 = reach * reach;
    for (size_t i = 0; i < plan.sites.size(); ++i) {
        const auto& site = plan.sites[i];
        if (!allowed[i] || site.family == SUPPORT) continue;
        bool supported = false;
        for (size_t n = 0; n < plan.sites.size() && !supported; ++n)
            supported = allowed[n] && plan.sites[n].family == SUPPORT
                && DistanceSquared(site.slot.centre, plan.sites[n].slot.centre) <= reach2;
        allowed[i] = supported;
        if (supported && site.family == REACTOR) reactors.push_back(i);
    }
    // Nearest-first leaves both banks available instead of filling one wing
    // before considering the other. Original order is the deterministic tie.
    std::sort(reactors.begin(), reactors.end(), [&](size_t a, size_t b) {
        const float da = DistanceSquared(plan.sites[a].slot.centre, centre);
        const float db = DistanceSquared(plan.sites[b].slot.centre, centre);
        return da == db ? a < b : da < db;
    });
    for (size_t i = size_t(reactorLimit); i < reactors.size(); ++i) allowed[reactors[i]] = false;
    size_t count = 0;
    int supportCount = 0, reactorCount = 0, converterCount = 0;
    for (size_t i = 0; i < plan.sites.size(); ++i) if (allowed[i]) {
        const auto family = plan.sites[i].family;
        supportCount += family == SUPPORT;
        reactorCount += family == REACTOR;
        converterCount += family == CONVERTER;
        plan.sites[count++] = plan.sites[i];
    }
    plan.sites.resize(count);
    return supportCount > 0 && reactorCount > 0 && converterCount > 0;
}
inline bool TouchesStart(const Rect& bounds, float x, float z, float clearance) {
    const float dx = x - std::clamp(x, bounds.minX * 16.f, bounds.maxX * 16.f);
    const float dz = z - std::clamp(z, bounds.minZ * 16.f, bounds.maxZ * 16.f);
    return dx * dx + dz * dz < clearance * clearance;
}

// Pure, bounded geometry. Footprints are whole 16-elmo cells; centers are
// half-cells. No UnitDef, terrain callback or borrowed object is retained.
inline Plan Generate(Point origin, int facing, Footprint nano, Footprint reactor,
    Footprint converter, int columns, int rows, int wingColumns, bool mirrored,
    int serviceDepth, float buildReach)
{
    Plan result;
    if (!IsFacingValid(facing) || columns < 2 || columns > 8 || columns % 2 != 0 || rows < 2 || rows > 24 || rows % 2 != 0
        || wingColumns < 1 || wingColumns > 3 || serviceDepth < 0 || serviceDepth > 32
        || nano.x <= 0 || nano.z <= 0 || reactor.x <= 0 || reactor.z <= 0
        || converter.x <= 0 || converter.z <= 0 || buildReach <= 0) return result;
    result.columns = columns; result.rows = rows; result.facing = facing;
    const int width = columns * nano.x, length = rows * nano.z;
    const int wingWidth = wingColumns * reactor.x;
    const int reactorRows = (length / 2) / reactor.z;
    const int converterRows = (length - reactorRows * reactor.z) / converter.z;
    const int converterColumns = wingWidth / converter.x;
    if (reactorRows < 1 || converterRows < 1 || converterColumns < 1) return {};
    result.sites.reserve(columns * rows + (mirrored ? 2 : 1)
        * (wingColumns * reactorRows + converterColumns * converterRows));
    auto add = [&](Family family, Footprint footprint, int x2, int z2) {
        Slot slot;
        slot.centre = Offset(origin, facing, z2, x2);
        slot.footprint = footprint; slot.facing = facing;
        slot.order = int(result.sites.size());
        result.sites.push_back({slot, family});
    };
    for (int row = 0; row < rows; ++row)
        for (int col = 0; col < columns; ++col)
            add(SUPPORT, nano, -width + (2 * col + 1) * nano.x,
                length - (2 * row + 1) * nano.z);
    const int supportCount = int(result.sites.size());
    for (int side : {1, -1}) {
        if (side < 0 && !mirrored) break;
        // Mirroring swaps the growth ends, matching the two-sided layout.
        for (int row = 0; row < reactorRows; ++row)
            for (int col = 0; col < wingColumns; ++col)
                add(REACTOR, reactor, side * (width + (2 * col + 1) * reactor.x),
                    side * (length - (2 * row + 1) * reactor.z));
        for (int row = 0; row < converterRows; ++row)
            for (int col = 0; col < converterColumns; ++col)
                add(CONVERTER, converter, side * (width + (2 * col + 1) * converter.x),
                    side * (-length + (2 * row + 1) * converter.z));
    }
    // Conservative center-to-center support (no model-radius assumptions).
    // Bounded planning-only O(economy slots * support slots).
    const float reach2 = buildReach * buildReach;
    for (size_t i = supportCount; i < result.sites.size(); ++i) {
        bool served = false;
        for (int n = 0; n < supportCount && !served; ++n) {
            const auto a = result.sites[i].slot.centre, b = result.sites[n].slot.centre;
            const float dx = float(a.x2 - b.x2) * HALF_CELL_ELMOS;
            const float dz = float(a.z2 - b.z2) * HALF_CELL_ELMOS;
            served = dx * dx + dz * dz <= reach2;
        }
        if (!served) return {};
    }
    const int acrossMin2 = -width - (mirrored ? 2 * wingWidth : 0);
    const int acrossMax2 = width + 2 * wingWidth;
    bool first = true;
    // Service bays at both ends remain unoccupied by permanent module slots.
    for (int x : {acrossMin2, acrossMax2}) for (int z : {-length - 2 * serviceDepth, length + 2 * serviceDepth}) {
        const Point point = Offset(origin, facing, z, x);
        if (first) result.bounds = {point.x2 / 2, point.z2 / 2, point.x2 / 2, point.z2 / 2};
        result.bounds.minX = std::min(result.bounds.minX, point.x2 / 2);
        result.bounds.minZ = std::min(result.bounds.minZ, point.z2 / 2);
        result.bounds.maxX = std::max(result.bounds.maxX, point.x2 / 2);
        result.bounds.maxZ = std::max(result.bounds.maxZ, point.z2 / 2);
        first = false;
    }
    return result;
}
} // namespace circuit::economy_spine

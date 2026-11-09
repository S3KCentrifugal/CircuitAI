#pragma once
// D-501 (battle-group-composition-proposal.md, phase 0): where each member of a
// battle group rank stands, engine-free (tests/group_layout_test.cpp).
//
// The members nearest the enemy take the front row, each row keeps the
// members' left-to-right order (so nobody crosses the group to reach a slot),
// a row holds as many members as fit `row_width` at the group's spacing, and a
// slot a member cannot walk to directly from the group's centre is pulled in
// along that line (PullIn with the terrain's direct-passability test).
// D-430 indexed slots by join order: a Mace already east of a mountain could
// be given the western end of a 640-elmo arc and walked round it.
//
// Cost: Order is O(M log M) for M members, once per rank per frame at most
// (CRangedWorld caches it on the cohort plan); every member then reads its
// slot in O(1). PullIn is O(length / step) passability tests.
#include "terrain/RangedGeometry.h"

#include <algorithm>
#include <cmath>
#include <vector>

namespace circuit::group_layout {

// The native bound on a cohort (cohort_size is clamped to it): the layout,
// assessment and merge passes are linear or M log M in it.
constexpr int MAX_GROUP_SIZE = 32;

struct Member { int id = -1; ranged::Point pos{0.f, 0.f}; };
struct Slot { int id = -1; int row = 0; int index = 0; int rowCount = 1; int rows = 1; };

// Members per row: as many as fit `rowWidth` at `spacing`, at least one; with
// no width (0) one row holds everybody, the D-430 layout.
inline int PerRow(float rowWidth, float spacing, int count) {
    if (rowWidth <= 0.f || spacing <= 0.f) return std::max(1, count);
    return std::max(1, int(rowWidth / spacing) + 1);
}

// Rows and order. `origin` is the target (engaged) or the travel focus, `back`
// the unit direction from it through the group. Depth is measured along
// `back` (smaller is nearer the enemy), the lateral order along its left
// normal. Ties fall to the unit id, so every member computes the same layout.
inline void Order(ranged::Point origin, ranged::Point back, int perRow, std::vector<Member>& members, std::vector<Slot>& out) {
    out.clear();
    const int count = int(members.size());
    if (count == 0) return;
    perRow = std::max(1, perRow);
    const auto depth = [&](const Member& m) { return (m.pos.x - origin.x) * back.x + (m.pos.z - origin.z) * back.z; };
    const auto lateral = [&](const Member& m) { return -(m.pos.x - origin.x) * back.z + (m.pos.z - origin.z) * back.x; };
    std::sort(members.begin(), members.end(), [&](const Member& a, const Member& b) {
        const float da = depth(a), db = depth(b);
        return da != db ? da < db : a.id < b.id;
    });
    const int rows = (count + perRow - 1) / perRow;
    out.reserve(members.size());
    for (int row = 0; row < rows; ++row) {
        const auto first = members.begin() + row * perRow;
        const auto last = members.begin() + std::min(count, (row + 1) * perRow);
        std::sort(first, last, [&](const Member& a, const Member& b) {
            const float la = lateral(a), lb = lateral(b);
            return la != lb ? la < lb : a.id < b.id;
        });
        const int rowCount = int(last - first);
        for (auto it = first; it != last; ++it)
            out.push_back({it->id, row, int(it - first), rowCount, rows});
    }
}

// The slot of `slot` in the engaged layout: an arc around the target, the same
// geometry as cohort::Arc. Row 0 (nearest the enemy) stands `depth` x (rows - 1)
// closer than the band so every row is inside it; with `rowsBehind` (a static
// armed target, whose reach must not be entered) the further rows stand behind.
inline ranged::Point Engaged(ranged::Point target, ranged::Point back, float radius, float spacing, float depth,
                             bool rowsBehind, const Slot& slot) {
    const float rowRadius = rowsBehind ? radius + depth * float(slot.row)
                                       : std::max(spacing, radius - depth * float(slot.rows - 1 - slot.row));
    const float angle = std::atan2(back.z, back.x);
    const float step = std::min(2.f * std::asin(std::min(.9f, (spacing + 1.f) / (2.f * std::max(1.f, rowRadius)))),
                                2.f / float(std::max(1, slot.rowCount - 1)));
    const float a = angle + (float(slot.index) - float(slot.rowCount - 1) * .5f) * step;
    return {target.x + std::cos(a) * rowRadius, target.z + std::sin(a) * rowRadius};
}

// The travel layout: lanes across the direction of travel, further rows behind.
// `anchor` is the focus (travel) or a station (support rank).
inline ranged::Point Lanes(ranged::Point anchor, ranged::Point back, float spacing, float depth, const Slot& slot) {
    const float offset = (float(slot.index) - float(slot.rowCount - 1) * .5f) * (spacing + 1.f);
    const float behind = depth * float(slot.row);
    return {anchor.x - back.z * offset + back.x * behind, anchor.z + back.x * offset + back.z * behind};
}

// Pull a slot in along the line from `centre` until the whole way is directly
// passable; the centre itself when nothing on the way is.
template <class Passable>
ranged::Point PullIn(ranged::Point centre, ranged::Point slot, float step, Passable passable) {
    if (passable(centre, slot)) return slot;
    const float dx = slot.x - centre.x, dz = slot.z - centre.z;
    const float length = std::sqrt(dx * dx + dz * dz);
    if (length <= 1.f || step <= 0.f) return centre;
    for (float d = length - step; d > 0.f; d -= step) {
        const ranged::Point p{centre.x + dx * d / length, centre.z + dz * d / length};
        if (passable(centre, p)) return p;
    }
    return centre;
}

} // namespace circuit::group_layout

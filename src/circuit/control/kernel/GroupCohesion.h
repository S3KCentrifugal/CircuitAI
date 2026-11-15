#pragma once
// D-501 (battle-group-composition-proposal.md, phase 3): whether a battle
// group still holds together, engine-free (tests/group_cohesion_test.cpp).
//
// Members connected through a direct way (no obstacle on the straight line,
// the terrain's direct-passability test) within `link` elmos form one part;
// links are tested to each member's K nearest neighbours only. A group of more
// than one part splits along them: a Mace on the far side of a mountain stops
// pulling its group's slots across it. A member far from the centre for long
// enough is a stray and leaves.
//
// Cost: Components is O(M^2) distance reads to find neighbours plus O(M K)
// passability tests, M <= group_layout::MAX_GROUP_SIZE; run per group every
// recruit period, not per frame.
#include "terrain/RangedGeometry.h"

#include <algorithm>
#include <numeric>
#include <vector>

namespace circuit::group_cohesion {

constexpr int NEIGHBOURS = 3;

// Union-find over members; `label` gets each member's part (0-based, parts in
// order of their first member). Returns the number of parts.
template <class Passable>
int Components(const std::vector<ranged::Point>& pos, float link, Passable passable, std::vector<int>& label) {
    const int n = int(pos.size());
    std::vector<int> parent(n);
    std::iota(parent.begin(), parent.end(), 0);
    const auto find = [&](int x) { while (parent[x] != x) { parent[x] = parent[parent[x]]; x = parent[x]; } return x; };
    std::vector<std::pair<float, int>> closest;
    closest.reserve(n);
    for (int i = 0; i < n; ++i) {
        closest.clear();
        for (int j = 0; j < n; ++j) {
            if (j == i) continue;
            const float d = ranged::DistanceSq(pos[i], pos[j]);
            if (d <= link * link) closest.push_back({d, j});
        }
        const int k = std::min<int>(NEIGHBOURS, int(closest.size()));
        std::partial_sort(closest.begin(), closest.begin() + k, closest.end());
        for (int t = 0; t < k; ++t) {
            const int j = closest[t].second;
            if (find(i) == find(j)) continue;
            if (passable(pos[i], pos[j])) parent[find(i)] = find(j);
        }
    }
    label.assign(n, -1);
    int parts = 0;
    std::vector<int> partOf(n, -1);
    for (int i = 0; i < n; ++i) {
        const int root = find(i);
        if (partOf[root] < 0) partOf[root] = parts++;
        label[i] = partOf[root];
    }
    return parts;
}

// The part that keeps the group: the largest, the anchor's on a tie.
inline int KeptPart(const std::vector<int>& label, int parts, int anchorIndex) {
    std::vector<int> size(parts, 0);
    for (int l : label) if (l >= 0) ++size[l];
    int best = anchorIndex >= 0 && anchorIndex < int(label.size()) ? label[anchorIndex] : 0;
    for (int p = 0; p < parts; ++p) if (size[p] > size[best]) best = p;
    return best;
}

// A stray: farther than `radius` from the centre since `sinceFrame` for at
// least `frames` (sinceFrame < 0: not away).
inline bool Stray(float distanceSq, float radius, int sinceFrame, int frame, int frames) {
    return distanceSq > radius * radius && sinceFrame >= 0 && frame - sinceFrame >= frames;
}

} // namespace circuit::group_cohesion

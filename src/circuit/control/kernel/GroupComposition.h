#pragma once
// D-501 (battle-group-composition-proposal.md, phases 2 and 3): what a battle
// group template admits and how big its groups should be, engine-free
// (tests/group_composition_test.cpp).
//
// A template has ranks (screen, support, ...). A rank admits a unit type by
// role mask or by an explicit list; with neither it admits any type placed in
// it. Sizes are a target, not only a cap: a group below its target recruits,
// two groups merge only while the result fits the maximum, a group above the
// maximum splits. The group registry (control/group/GroupRegistry.h) applies
// these rules; the battle group controller parses them from the template.
#include <algorithm>
#include <cmath>
#include <cstdint>
#include <string>
#include <vector>

namespace circuit::group_composition {

struct RankSpec {
    std::string name;
    std::uint32_t roleMask = 0;    // roles: admits a type whose roles intersect (0: no role test)
    std::vector<int> defs;         // units: admits these type ids (sorted; empty: no list)
    int max = 0;                   // members of this rank in one group (0: the template size_max)
    float perScreen = 0.f;         // per_screen: this rank's target as a share of the screen rank's (0: size_target)
};
struct SizeSpec { int min = 1, target = 12, max = 24; };

// Does the rank admit a type? A listed type is admitted; otherwise the role
// mask decides; a rank with neither admits every type placed in it.
inline bool Admits(const RankSpec& rank, int defId, std::uint32_t roles) {
    if (!rank.defs.empty() && std::binary_search(rank.defs.begin(), rank.defs.end(), defId)) return true;
    if (rank.roleMask != 0) return (rank.roleMask & roles) != 0;
    return rank.defs.empty();
}

// The rank by name, or null.
inline const RankSpec* Find(const std::vector<RankSpec>& ranks, const std::string& name) {
    for (const RankSpec& r : ranks) if (r.name == name) return &r;
    return nullptr;
}

// The size a group of this rank aims for: the template target, or the rank's
// share of the screen's target; never above the rank's or the template's max.
inline int Target(const RankSpec* rank, const SizeSpec& size) {
    int target = size.target;
    if (rank != nullptr && rank->perScreen > 0.f) target = std::max(1, int(std::ceil(rank->perScreen * float(size.target))));
    const int cap = (rank != nullptr && rank->max > 0) ? std::min(rank->max, size.max) : size.max;
    return std::clamp(target, 1, std::max(1, cap));
}
inline int Max(const RankSpec* rank, const SizeSpec& size) {
    return (rank != nullptr && rank->max > 0) ? std::min(rank->max, size.max) : size.max;
}

// A group below its target recruits (walks to a compatible group to merge).
inline bool Recruits(int members, const RankSpec* rank, const SizeSpec& size) {
    return members < Target(rank, size);
}
// Two groups of one rank may merge while the result fits the rank's maximum.
inline bool CanMerge(int a, int b, const RankSpec* rank, const SizeSpec& size) {
    return a > 0 && b > 0 && a + b <= Max(rank, size);
}
// Members beyond the maximum leave the group (it splits).
inline int Excess(int members, const RankSpec* rank, const SizeSpec& size) {
    return std::max(0, members - Max(rank, size));
}

} // namespace circuit::group_composition

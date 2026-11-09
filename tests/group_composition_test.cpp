// D-501: the battle group composition kernel (control/kernel/GroupComposition.h):
// rank admission by list and role, rank targets and maxima, recruit, merge and split.
#include "control/kernel/GroupComposition.h"

#include <cassert>
#include <cstdio>

using namespace circuit;
using group_composition::RankSpec;
using group_composition::SizeSpec;

int main() {
    constexpr std::uint32_t ASSAULT = 0x10, SKIRM = 0x20, RIOT = 0x08;
    RankSpec screen{"screen", ASSAULT | RIOT, {}, 0, 0.f};
    RankSpec support{"support", SKIRM, {}, 12, .5f};
    RankSpec listed{"escort", 0, {5, 9, 12}, 2, 0.f};
    RankSpec open{"any", 0, {}, 0, 0.f};
    {  // Admission: roles intersect; an explicit list admits its types; a rank with neither admits any.
        assert(group_composition::Admits(screen, 1, ASSAULT));
        assert(group_composition::Admits(screen, 1, RIOT | 0x1));
        assert(!group_composition::Admits(screen, 1, SKIRM));
        assert(group_composition::Admits(listed, 9, 0));
        assert(!group_composition::Admits(listed, 10, ASSAULT));
        assert(group_composition::Admits(open, 42, 0));
    }
    {  // Targets and maxima.
        const SizeSpec size{3, 12, 24};
        assert(group_composition::Target(&screen, size) == 12);
        assert(group_composition::Target(&support, size) == 6);     // 0.5 per screen
        assert(group_composition::Max(&support, size) == 12);
        assert(group_composition::Max(&screen, size) == 24);
        assert(group_composition::Target(&listed, size) == 2);      // capped by the rank's max
        assert(group_composition::Target(nullptr, size) == 12);
    }
    {  // Recruit below the target; merge while the sum fits; split the excess.
        const SizeSpec size{3, 12, 24};
        assert(group_composition::Recruits(5, &screen, size));
        assert(!group_composition::Recruits(12, &screen, size));
        assert(group_composition::CanMerge(10, 14, &screen, size));
        assert(!group_composition::CanMerge(12, 13, &screen, size));
        assert(!group_composition::CanMerge(0, 3, &screen, size));
        assert(group_composition::Excess(30, &screen, size) == 6);
        assert(group_composition::Excess(12, &screen, size) == 0);
        assert(group_composition::Excess(14, &support, size) == 2);
    }
    {  // Find by name.
        std::vector<RankSpec> ranks{screen, support};
        assert(group_composition::Find(ranks, "support") != nullptr);
        assert(group_composition::Find(ranks, "anti_air") == nullptr);
    }
    std::puts("group_composition_test: ok");
    return 0;
}

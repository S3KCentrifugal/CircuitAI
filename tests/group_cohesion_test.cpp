// D-501: the battle group cohesion kernel (control/kernel/GroupCohesion.h):
// parts connected by direct ways within the link distance, the part that keeps
// the group, and the stray rule.
#include "control/kernel/GroupCohesion.h"

#include <cassert>
#include <cstdio>
#include <vector>

using namespace circuit;
using ranged::Point;

int main() {
    // A mountain along x = 500: a way is direct when it does not cross it.
    const auto passable = [](Point a, Point b) { return (a.x < 500.f) == (b.x < 500.f); };
    {  // Five west of the mountain, one east: two parts; the west keeps the group.
        const std::vector<Point> pos{{100.f, 0.f}, {160.f, 0.f}, {220.f, 0.f}, {280.f, 0.f}, {340.f, 0.f}, {620.f, 0.f}};
        std::vector<int> label;
        const int parts = group_cohesion::Components(pos, 400.f, passable, label);
        assert(parts == 2);
        assert(label[0] == label[4] && label[5] != label[0]);
        assert(group_cohesion::KeptPart(label, parts, 0) == label[0]);
        assert(group_cohesion::KeptPart(label, parts, 5) == label[0]);   // the larger part wins over the anchor's
    }
    {  // All on one side within the link: one part.
        const std::vector<Point> pos{{100.f, 0.f}, {200.f, 0.f}, {300.f, 0.f}};
        std::vector<int> label;
        assert(group_cohesion::Components(pos, 150.f, passable, label) == 1);
    }
    {  // Beyond the link distance: separate parts even on open ground.
        const std::vector<Point> pos{{0.f, 0.f}, {50.f, 0.f}, {0.f, 900.f}};
        std::vector<int> label;
        assert(group_cohesion::Components(pos, 300.f, passable, label) == 2);
    }
    {  // Stray: far for long enough.
        assert(group_cohesion::Stray(1000.f * 1000.f, 900.f, 100, 300, 180));
        assert(!group_cohesion::Stray(1000.f * 1000.f, 900.f, 200, 300, 180));
        assert(!group_cohesion::Stray(500.f * 500.f, 900.f, 100, 300, 180));
        assert(!group_cohesion::Stray(1000.f * 1000.f, 900.f, -1, 300, 180));
    }
    std::puts("group_cohesion_test: ok");
    return 0;
}

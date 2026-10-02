#include "task/fighter/AirGeometry.h"
#include <cassert>
#include <cmath>
#include <iostream>
#include <set>
#include <limits>
int main()
{
    using namespace circuit::air_geometry;
    std::set<std::pair<float,float>> positions;
    for (int i = 0; i < 300; ++i) {
        auto s = FormationSlot(i, 1320.f, 180.f, 240.f);
        assert(std::abs(s.lateral) <= 660.f);
        assert(positions.emplace(s.lateral, s.behind).second);
    }
    assert(FormationSlot(7, 1320, 180, 240).behind == 240);
    assert(FormationSlot(10, 0, 180, 240).lateral == 0);
    assert(FormationSlot(-1, 1320, 180, 240).behind == 0);
    auto extreme = FormationSlot(std::numeric_limits<int>::max(), std::numeric_limits<float>::max(),
        std::numeric_limits<float>::min(), std::numeric_limits<float>::max());
    assert(std::isfinite(extreme.lateral) && std::isfinite(extreme.behind));
    assert(FormationSlot(1, std::numeric_limits<float>::infinity(), 180, 240).lateral == 0);
    assert(LossAbort(20, 13, .35f));
    assert(!LossAbort(20, 14, .35f));
    assert(!LossAbort(0, 0, .35f));
    assert(TransitSeconds(6000, 150) == 40);
    assert(TransitSeconds(6000, 0) == 0);
    assert(TransitSeconds(std::numeric_limits<float>::infinity(), 150) == 0);
    assert(TransitSeconds(std::numeric_limits<float>::max(), .001f) == 300);
    std::cout << "air geometry: 300 unique bounded slots and loss thresholds passed\n";
}

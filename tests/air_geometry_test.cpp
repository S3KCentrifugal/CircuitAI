#include "task/fighter/AirGeometry.h"
#include <cassert>
#include <cmath>
#include <iostream>
#include <set>
#include <limits>
int main()
{
    using namespace circuit::air_geometry;
    // Cleanup admits support buildings but never confuses them with strategic
    // targets; mobile low-tier cleanup remains an explicit script opt-in.
    assert(OperationTargetClass(4, false, false, false, false, false));
    assert(!OperationTargetClass(5, false, false, false, false, false));
    assert(OperationTargetClass(5, false, false, false, false, true));
    assert(OperationTargetClass(3, false, false, true, false, false));
    assert(!OperationTargetClass(4, false, false, true, false, false));
    assert(OperationTargetClass(7, true, false, true, false, true));
    assert(!OperationTargetClass(7, true, false, true, false, false));
    assert(!OperationTargetClass(0, true, false, true, false, false));
    assert(OperationTargetClass(8, true, false, true, false, false));
    assert(!OperationTargetClass(8, true, true, true, false, false));
    assert(!OperationTargetClass(99, false, false, false, false, true));
    assert(!OperationTargetClass(4, false, false, false, false, true, 5));
    assert(!OperationTargetClass(0, false, false, false, false, true, 5));
    assert(!OperationTargetClass(4, false, false, false, true, false, 2));
    assert(OperationTargetClass(4, false, false, false, false, false, 5));
    assert(PreferDistrictTarget(true, true, false, 10, 10000));
    assert(!PreferDistrictTarget(true, false, true, 10000, 10));
    assert(PreferDistrictTarget(false, false, true, 10000, 10));
    assert(!PreferDistrictTarget(true, true, true, 10, 11));
    assert(CohortLegCount(6000, 600) == 5);
    assert(CohortLegCount(0, 600) == 1);
    assert(CohortLegCount(1000, -10) == 1);
    assert(CohortLegCount(1e30f, 400) == 256);
    assert(CohortLegCount(std::numeric_limits<float>::infinity(), 600) == 1);
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
    assert(RequiredForce(3000, 300, 1.2f, 0, .25f, 0) == 15);
    assert(RequiredForce(1000, 100, 1, 0, 0, 0) == 10);
    assert(RequiredForce(1000, 100, 1, .5f, .25f, .15f) == 19);
    assert(RequiredForce(1000, 0, 1, 0, 0, 0) == 0);
    assert(RequiredForce(std::numeric_limits<float>::infinity(), 100, 1, 0, 0, 0) == 0);
    assert(RequiredForce(1e30f, 1, 1, 0, 0, 0) == 1000000);
    assert(AttackDelay(20, 1500, 150) == 10);
    assert(AttackDelay(20, 4500, 150) == 0);
    assert(AttritionReserve(2460, 230, .5f) == 6);
    assert(AttritionReserve(820, 230, .5f) == 2);
    assert(AttritionReserve(820, 0, .5f) == 0);
    std::cout << "air geometry: 300 unique bounded slots and loss thresholds passed\n";
}

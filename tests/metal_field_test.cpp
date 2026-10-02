#include "circuit/resource/MetalField.h"
#include <cassert>
#include <iostream>
#include <limits>
using namespace circuit::metal_field;
int main() {
    Grid grid;
    assert(!grid.Init(0, 8, 7.5f, {}));
    assert(grid.Init(32, 32, 7.5f, std::vector<short>(1024, 79)));
    assert(grid.BroadField(24));
    std::vector<int> cells;
    int budget = 1000;
    assert(grid.Cells(128, 128, 24, budget, cells));
    assert(cells.size() == 4);
    assert(std::abs(grid.Isolated(cells, .001f) - 2.37f) < .0001f);
    budget = 1;
    assert(!grid.Cells(128, 128, 24, budget, cells) && cells.empty());
    budget = 100;
    assert(!grid.Cells(128, 128, std::numeric_limits<float>::infinity(), budget, cells));
    assert(grid.Cells(128, 128, 24, budget, cells));
    Claims claims;
    Claims::Record a;
    a.owner = 0; a.x = a.z = 128; a.radius = 24; a.depth = .001f;
    const Key first = claims.Allocate(0), ally = claims.Allocate(1), upgrade = claims.Allocate(0);
    budget = 100;
    assert(claims.Upsert(first, a, grid, budget));
    assert(claims.Marginal(grid, cells, .001f) == 0);
    a.owner = 1;
    assert(claims.Upsert(ally, a, grid, budget));
    claims.Erase(first);
    assert(claims.Marginal(grid, cells, .001f) == 0); // cancel doesn't erase ally
    a.owner = 0; a.depth = .004f; a.targetId = 42;
    assert(claims.Upsert(upgrade, a, grid, budget));
    assert(!claims.TargetAvailable(42));
    assert(!claims.Upsert(claims.Allocate(1), a, grid, budget));
    assert(std::abs(claims.Marginal(grid, cells, .004f, upgrade) - 7.11f) < .0001f);
    claims.Erase(ally); // old unit destruction must leave upgrade reservation
    assert(claims.Marginal(grid, cells, .004f) == 0);
    claims.Erase(upgrade);
    assert(claims.TargetAvailable(42));
    const Key restored = (Key(2) << 32) | 99;
    a.owner = 2; a.targetId = -1;
    assert(claims.Upsert(restored, a, grid, budget));
    assert(claims.Allocate(2) > restored);
    Grid speed;
    assert(speed.Init(32, 32, 10, std::vector<short>(1024, 255)));
    budget = 100;
    assert(speed.Cells(128, 128, 30, budget, cells) && cells.size() == 12);
    assert(std::abs(speed.Isolated(cells, .001f) - 30.6f) < .0001f);
    // A dense 4x2 module must retain every extractor's full marginal yield.
    // Validate both the ordinary field radius and the richer SpeedMetal radius.
    for (int radius : {24, 30}) {
        Claims dense;
        const int pitch = ((2 * radius + 15) / 16) * 16;
        budget = 10000;
        float sum = 0;
        for (int row = 0; row < 2; ++row) for (int col = 0; col < 4; ++col) {
            Claims::Record r;
            r.owner = 0; r.x = 96.f + col * pitch; r.z = 96.f + row * pitch;
            r.radius = float(radius); r.depth = .001f;
            assert(speed.Cells(r.x, r.z, r.radius, budget, cells));
            const float isolated = speed.Isolated(cells, r.depth);
            assert(std::abs(dense.Marginal(speed, cells, r.depth) - isolated) < .0001f);
            assert(dense.Upsert(dense.Allocate(0), r, speed, budget));
            sum += isolated;
        }
        assert(sum > 0 && dense.Records().size() == 8);
    }
    Grid barren;
    assert(barren.Init(32, 32, 10, std::vector<short>(1024, 0)) && !barren.BroadField(30));
    std::cout << "metal field: yield, budgets, overlap, cancellation, upgrade ownership and restored keys passed\n";
}

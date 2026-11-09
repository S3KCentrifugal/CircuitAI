// D-510: rush detection, the help a retreat heads for and the escape lean
// (control/kernel/RushResponse.h). Ranges and costs from the knowledge base:
// Thug 380 / 140 metal, Pawn 180 / 54, Grunt 215 / 43, Goblin 261 / 30,
// Rocketeer 475; an LLT costs 85 metal.
#include "control/kernel/RushResponse.h"

#include <cassert>
#include <cmath>
#include <cstdio>
#include <vector>

using namespace circuit;
using ranged::Point;

namespace {
constexpr float THUG_RANGE = 380.f, MARGIN = 60.f, CLOSING = 15.f, DETECT = 800.f;
bool Near(Point a, Point b) { return std::fabs(a.x - b.x) < 1e-3f && std::fabs(a.z - b.z) < 1e-3f; }
}

int main() {
    {  // Who rushes: shorter-ranged and closing, or already inside our reach.
        assert(rush_response::Rushes(600.f, 80.f, 180.f, THUG_RANGE, MARGIN, CLOSING, DETECT));   // Pawn
        assert(rush_response::Rushes(600.f, 70.f, 215.f, THUG_RANGE, MARGIN, CLOSING, DETECT));   // Grunt
        assert(rush_response::Rushes(600.f, 60.f, 261.f, THUG_RANGE, MARGIN, CLOSING, DETECT));   // Goblin: 321 <= 380
        assert(!rush_response::Rushes(600.f, 80.f, 380.f, THUG_RANGE, MARGIN, CLOSING, DETECT));  // a peer Thug
        assert(!rush_response::Rushes(600.f, 80.f, 475.f, THUG_RANGE, MARGIN, CLOSING, DETECT));  // Rocketeer outranges
        assert(!rush_response::Rushes(600.f, 0.f, 180.f, THUG_RANGE, MARGIN, CLOSING, DETECT));   // standing off
        assert(rush_response::Rushes(300.f, -20.f, 180.f, THUG_RANGE, MARGIN, CLOSING, DETECT));  // inside our reach
        assert(!rush_response::Rushes(900.f, 80.f, 180.f, THUG_RANGE, MARGIN, CLOSING, DETECT));  // beyond detection
    }
    {  // Rushed: enough raiders holding enough of our metal.
        rush_response::Detection six;
        for (int i = 0; i < 6; ++i) rush_response::Add(six, {float(i) * 50.f, 600.f}, 54.f);
        assert(six.count == 6 && std::fabs(six.value - 324.f) < 1e-3f && Near(six.centroid, {125.f, 600.f}));
        assert(rush_response::Rushed(six, 6 * 140.f, 2, .3f));          // 324 >= 252
        rush_response::Detection two;
        rush_response::Add(two, {0.f, 600.f}, 54.f); rush_response::Add(two, {50.f, 600.f}, 54.f);
        assert(!rush_response::Rushed(two, 6 * 140.f, 2, .3f));         // two Pawns against six Thugs: just shoot them
        assert(rush_response::Rushed(two, 2 * 140.f, 2, .3f));          // against two Thugs: kite
        rush_response::Detection one;
        rush_response::Add(one, {0.f, 600.f}, 500.f);
        assert(!rush_response::Rushed(one, 140.f, 2, .3f));             // one raider is not a rush
    }
    {  // A kite runs only while it buys something (measured: the D-510 arenas).
        rush_response::Detection pawns;
        rush_response::Add(pawns, {0.f, 800.f}, 54.f, 800.f, 87.f, 180.f);
        rush_response::Add(pawns, {50.f, 900.f}, 54.f, 900.f, 87.f, 180.f);
        assert(pawns.nearest == 800.f && pawns.speed == 87.f && pawns.range == 180.f);
        // 620 elmos of gap closing at 42/s: 14.8 s. Help 800 back takes a Thug 17.8 s: stand.
        assert(!rush_response::KiteWorthwhile(pawns, 45.f, 800.f, 1.f));
        assert(rush_response::KiteWorthwhile(pawns, 45.f, 350.f, 1.f));     // 7.8 s: kite to it
        assert(!rush_response::KiteWorthwhile(pawns, 45.f, -1.f, 1.f));     // no help: stand and fire
        assert(rush_response::KiteWorthwhile(pawns, 45.f, 800.f, 1.3f));    // more slack: 19.2 s
        rush_response::Detection caught = pawns;
        caught.nearest = 150.f;                                              // already on us
        assert(!rush_response::KiteWorthwhile(caught, 45.f, 350.f, 1.f));
        rush_response::Detection slow;
        rush_response::Add(slow, {0.f, 600.f}, 100.f, 600.f, 40.f, 200.f);
        assert(rush_response::KiteWorthwhile(slow, 45.f, -1.f, 1.f));      // we hold range: kite
    }
    {  // Needed help: at least MIN_HELP; more when the threat outweighs us.
        assert(rush_response::Needed(324.f, 840.f, 1.f) == rush_response::MIN_HELP);
        assert(std::fabs(rush_response::Needed(1200.f, 280.f, 1.f) - 920.f) < 1e-3f);
    }
    {  // Help: the nearest strong-enough cell within the cone away from the threat.
        const Point from{0.f, 0.f};
        const Point away{0.f, -1.f};   // the threat stands north at z = +1000
        std::vector<rush_response::Cell> cells;
        rush_response::AddHelp(cells, {0.f, -1500.f}, 85.f * 3.f);  // an LLT behind us: 255
        rush_response::AddHelp(cells, {0.f, 800.f}, 5000.f);        // a big ally beyond the enemy
        rush_response::AddHelp(cells, {1500.f, 0.f}, 5000.f);       // a big ally square to the side
        rush_response::AddHelp(cells, {0.f, -700.f}, 50.f);         // too weak, though nearest
        assert(cells.size() == 4);
        const int best = rush_response::ChooseHelp(cells, from, away, 100.f, 2500.f, 70.f);
        assert(best == 0 && Near(rush_response::Centre(cells[best]), {0.f, -1500.f}));
        rush_response::AddHelp(cells, {100.f, -1000.f}, 400.f);     // a nearer qualifying cell
        assert(rush_response::Centre(cells[rush_response::ChooseHelp(cells, from, away, 100.f, 2500.f, 70.f)]).z > -1100.f);
        assert(rush_response::ChooseHelp(cells, from, away, 100.f, 900.f, 70.f) == -1);   // none within the radius
        // Strength in one cell adds up: two Thugs beside each other reach the threshold together.
        std::vector<rush_response::Cell> pair;
        rush_response::AddHelp(pair, {10.f, -600.f}, 140.f); rush_response::AddHelp(pair, {60.f, -600.f}, 140.f);
        assert(pair.size() == 1 && rush_response::ChooseHelp(pair, from, away, 250.f, 2500.f, 70.f) == 0);
    }
    {  // The axis: toward an anchor behind us; away when the anchor lies ahead.
        const Point from{0.f, 0.f}, away{0.f, -1.f};
        assert(Near(rush_response::Axis(from, away, {600.f, -600.f}), rush_response::Unit({1.f, -1.f})));
        assert(Near(rush_response::Axis(from, away, {0.f, 600.f}), away));
        assert(rush_response::InCone(from, away, {300.f, -1000.f}, 70.f));
        assert(!rush_response::InCone(from, away, {1000.f, -100.f}, 70.f));
    }
    {  // The escape leans toward the axis, never toward the danger.
        const Point lean = rush_response::Lean({1.f, 0.f}, {0.f, -1.f}, .5f);
        assert(Near(lean, rush_response::Unit({1.f, -1.f})));
        assert(Near(rush_response::Lean({0.f, 1.f}, {0.f, -1.f}, .5f), {0.f, 1.f}));
        assert(Near(rush_response::Lean({1.f, 0.f}, {0.f, -1.f}, 0.f), {1.f, 0.f}));
    }
    std::puts("rush_response_test: ok");
    return 0;
}

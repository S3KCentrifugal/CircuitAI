// D-432: the support kernel (control/kernel/SupportStation.h). Station
// behind the screen from reaches and the separation band, the job's target
// weights, the step-between-shots window, the leak test and the tuck point.
#include "control/kernel/SupportStation.h"

#include <cassert>
#include <cmath>
#include <cstdio>
#include <vector>

using namespace circuit;
using ranged::Point;

namespace {
bool Near(float a, float b, float eps = .01f) { return std::fabs(a - b) <= eps; }
bool Near(Point a, Point b, float eps = .01f) { return Near(a.x, b.x, eps) && Near(a.z, b.z, eps); }
}

int main() {
    {  // Separation: reach advantage less margin, clamped to the band.
        assert(Near(support::Separation(475.f, 380.f, 48.f, 48.f, 96.f), 48.f));   // Aggravator behind Thugs: 47 -> minimum
        assert(Near(support::Separation(475.f, 325.f, 48.f, 48.f, 96.f), 96.f));   // behind Centurions: 102 -> maximum
        assert(Near(support::Separation(475.f, 380.f, 4.f, 48.f, 96.f), 91.f));    // the balanced margin 4
        assert(Near(support::Separation(475.f, 600.f, 4.f, 48.f, 96.f), 48.f));    // a longer screen: never ahead of it
        assert(Near(support::Separation(475.f, 380.f, 4.f, 96.f, 48.f), 91.f));    // a swapped band still clamps
        // D-433: from the bands (reach x range_fraction) less the station slack.
        assert(Near(support::Separation(475.f * .95f, 380.f * .97f, 48.f, 64.f, 96.f), 64.f));  // 451 - 369 - 48 = 34 -> the minimum 64
        assert(Near(support::Separation(475.f * .95f, 325.f * .97f, 48.f, 64.f, 96.f), 88.f));    // behind Centurions: 451.25 - 315.25 - 48
        assert(451.25f - 64.f - 369.f > 0.f);  // the Aggravator at the minimum stands 18 elmos inside its band of what the screen fights
    }
    {  // D-433: the no-screen fallback picks the nearest static that outranges the hostile, on the hull's side of it.
        const Point hull{0.f, 0.f}, hostile{0.f, 500.f};
        const std::vector<support::Post> posts{{{0.f, -300.f}, 430.f}, {{0.f, -100.f}, 300.f}, {{0.f, 700.f}, 600.f}, {{400.f, -50.f}, 700.f}};
        assert(support::NearestOutranging(hull, hostile, posts, 325.f) == 0);   // the LLT behind: nearest outranging a Thug
        assert(support::NearestOutranging(hull, hostile, posts, 450.f) == 3);   // against a longer hostile only the 700 post counts
        assert(support::NearestOutranging(hull, hostile, posts, 800.f) == -1);  // nothing outranges it
        assert(support::NearestOutranging(hull, hostile, {}, 0.f) == -1);
        assert(support::NearestOutranging(hull, hull, posts, 0.f) == 1);        // no hostile: the nearest armed static
    }
    {  // Station: the screen centre moved along the back direction.
        const Point station = support::Station({1000.f, 2000.f}, {0.f, -1.f}, 91.f);
        assert(Near(station, Point{1000.f, 1909.f}));
        const float d = std::sqrt(.5f);
        assert(Near(support::Station({0.f, 0.f}, {d, d}, 100.f), Point{70.71f, 70.71f}, .1f));
    }
    {  // Target weights: statics first, then beyond the screen, fast runners penalised unless close.
        support::Weights w;  // 1.5, 1.3, 70, .3, 250, 4
        assert(Near(support::TargetWeight(false, 500.f, 380.f, 0.f, 450.f, w), 1.5f));    // a Sentry
        assert(Near(support::TargetWeight(true, 500.f, 380.f, 45.f, 450.f, w), 1.3f));    // a Mace the Thugs cannot reach
        assert(Near(support::TargetWeight(true, 300.f, 380.f, 45.f, 450.f, w), 1.f));     // a Mace in the screen's reach
        assert(Near(support::TargetWeight(true, 300.f, 380.f, 90.f, 450.f, w), .3f));     // a Pawn: a wasted missile
        assert(Near(support::TargetWeight(true, 300.f, 380.f, 90.f, 200.f, w), 4.f));     // the same Pawn coming for us
        assert(Near(support::TargetWeight(true, 500.f, 380.f, 90.f, 200.f, w), 5.2f));    // beyond the screen and close
        assert(Near(support::TargetWeight(true, 500.f, 0.f, 45.f, 450.f, w), 1.f));       // no screen: no beyond bonus
    }
    {  // D-499: the screen's target (or the siege tower) weighs screen_target_bonus on top.
        support::Weights w;
        assert(Near(support::TargetWeight(true, 300.f, 380.f, 45.f, 450.f, w, true), 1.f));   // default 1: off
        w.screenTargetBonus = 2.f;
        assert(Near(support::TargetWeight(true, 300.f, 380.f, 45.f, 450.f, w, true), 2.f));   // the Mace the Thugs trade with
        assert(Near(support::TargetWeight(true, 300.f, 380.f, 45.f, 450.f, w, false), 1.f));  // another Mace
        assert(Near(support::TargetWeight(false, 500.f, 380.f, 0.f, 450.f, w, true), 3.f));   // the besieged Sentry: 2 x 1.5
        assert(Near(support::TargetWeight(true, 300.f, 380.f, 90.f, 450.f, w, true), .6f));   // a fast target stays penalised
    }
    {  // D-499: siege distance by weapon reaches: own reach less the slack, never inside the tower's reach plus the margin.
        // An Aggravator (475) against a Sentry (430 + safety margin 4): window 446..475, station 463.
        assert(Near(support::SiegeDistance(475.f, 434.f, 12.f, 12.f), 463.f));
        assert(Near(support::SiegeDistance(475.f, 439.f, 12.f, 12.f), 463.f));      // a Guard (435 + 4)
        assert(Near(support::SiegeDistance(475.f, 455.f, 12.f, 12.f), 467.f));      // a closer window: the margin wins
        assert(Near(support::SiegeDistance(475.f, 414.f, 12.f, 12.f), 463.f));      // a Maw (410 + 4)
        assert(support::SiegeDistance(475.f, 494.f, 12.f, 12.f) < 0.f);             // a Beamer or Twin Guard (490 + 4) outranges the rockets
        assert(support::SiegeDistance(475.f, 624.f, 12.f, 12.f) < 0.f);             // a heavy laser tower
        assert(Near(support::SiegeDistance(475.f, 463.f, 12.f, 12.f), 475.f));      // exactly at the edge: the own reach
        assert(support::SiegeDistance(475.f, 464.f, 12.f, 12.f) < 0.f);             // one past it
    }
    {  // D-499: shielded: a screen member between the hostile and the hull; no screen shields nothing.
        const Point hull{0.f, 0.f}, hostile{0.f, 400.f};
        assert(!support::Shielded(hull, hostile, {}, 96.f));
        assert(support::Shielded(hull, hostile, {{10.f, 200.f}}, 96.f));
        assert(!support::Shielded(hull, hostile, {{200.f, 200.f}}, 96.f));
    }
    {  // Step window: a ready weapon with a target holds; reload to spare steps; no target steps.
        assert(support::MayStep(1000, 1000 + 60, 24, true));
        assert(!support::MayStep(1000, 1000 + 20, 24, true));
        assert(!support::MayStep(1000, 990, 24, true));
        assert(support::MayStep(1000, 990, 24, false));
    }
    {  // Leak: a screen member on the segment blocks; one off to the side does not.
        const Point hull{0.f, 0.f}, hostile{0.f, 400.f};
        assert(support::Leaked(hull, hostile, {}, 96.f));
        assert(!support::Leaked(hull, hostile, {{10.f, 200.f}}, 96.f));
        assert(support::Leaked(hull, hostile, {{200.f, 200.f}}, 96.f));
        assert(!support::Leaked(hull, hostile, {{200.f, 200.f}, {-20.f, 300.f}}, 96.f));
        assert(support::Leaked(hull, hostile, {{0.f, 600.f}}, 96.f));  // behind the hostile, not between
        assert(!support::Leaked(hull, hull, {{10.f, 0.f}}, 96.f));     // coincident: distance to the point
    }
    {  // Tuck: the far side of the nearest `count` screen members.
        const Point hull{0.f, 0.f}, hostile{0.f, 400.f};
        const std::vector<Point> screen{{-50.f, 150.f}, {50.f, 150.f}, {0.f, 800.f}};
        const Point tuck = support::Tuck(hull, hostile, screen, 2, 96.f);
        assert(Near(tuck, Point{0.f, 150.f - 96.f}, .1f));
        assert(Near(support::Tuck(hull, hostile, {}, 2, 96.f), hull));
        assert(Near(support::Tuck(hull, hostile, screen, 0, 96.f), hull));
        const Point one = support::Tuck(hull, hostile, screen, 1, 50.f);
        assert(Near(one.z, 100.f, 1.f));  // the single nearest member, moved 50 away from the hostile
        assert(Near(support::Tuck(hull, {0.f, 150.f}, {{0.f, 150.f}}, 1, 50.f), Point{0.f, 150.f}));  // hostile on the member
    }
    std::puts("support_station_test: ok");
    return 0;
}

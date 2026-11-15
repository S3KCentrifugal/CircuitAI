// D-509: the battle group anti-air escort formula (control/kernel/AirDefence.h):
// how many escorts a group needs against the air near it, that the held air
// HP neither cancels a request when drones land nor grows with a hive that
// rebuilds them, that factories start exactly the shortfall (never twice for
// one order, a lost escort replaced once), and where an escort stands.
#include "control/kernel/AirDefence.h"

#include <cassert>
#include <cmath>
#include <cstdio>

using namespace circuit;

namespace {
constexpr int FPS = 30;
constexpr float ESCORT_DPS = 55.f;         // Crasher / Trasher against air (knowledge base)
constexpr float DRONE_HP = 325.f;          // Legion drone; a hive carries six
constexpr float KILL_SECONDS = 10.f;
constexpr int MEMORY_FRAMES = 20 * FPS;
constexpr float PER_SCREEN = .34f;
constexpr int RANK_MAX = 6;

int NeedFor(float air, int screens) {
    return air_defence::Need(air, ESCORT_DPS, KILL_SECONDS, air_defence::Cap(screens, PER_SCREEN, RANK_MAX));
}
}

int main() {
    {  // The need follows the air present: six drones, one, a gunship, none.
        assert(NeedFor(6 * DRONE_HP, 12) == 4);   // 1950 / 550 = 3.5 -> 4; cap ceil(4.08) = 5
        assert(NeedFor(6 * DRONE_HP, 6) == 3);    // the cap: ceil(0.34 x 6) = 3
        assert(NeedFor(DRONE_HP, 12) == 1);
        assert(NeedFor(1100.f, 12) == 2);         // one 1100 HP gunship
        assert(NeedFor(0.f, 12) == 0);            // no armed air: no escort asked for
        assert(NeedFor(50000.f, 32) == RANK_MAX); // never past the rank max
        assert(air_defence::Cap(0, PER_SCREEN, RANK_MAX) == 1);   // a group always may take one
        assert(air_defence::Need(100.f, 0.f, KILL_SECONDS, 3) == 3);  // unknown DPS: plan on the cap
    }
    {  // Held HP: drones landing to re-arm do not cancel the request; it decays to zero.
        air_defence::Memory m;
        assert(air_defence::Held(m, 6 * DRONE_HP, 0, MEMORY_FRAMES) == 6 * DRONE_HP);
        const float landed = air_defence::Held(m, 0.f, 5 * FPS, MEMORY_FRAMES);  // 5 s later, none in the air
        assert(std::fabs(landed - 6 * DRONE_HP * .75f) < 1.f);
        assert(air_defence::Need(landed, ESCORT_DPS, KILL_SECONDS, 5) == 3);
        assert(air_defence::Held(m, 0.f, 20 * FPS, MEMORY_FRAMES) == 0.f);     // gone after the memory
        // A fresh wave larger than the decayed peak replaces it at once.
        assert(air_defence::Held(m, 2 * DRONE_HP, 21 * FPS, MEMORY_FRAMES) == 2 * DRONE_HP);
    }
    {  // A hive that rebuilds its drones for minutes never grows the need.
        air_defence::Memory m;
        int most = 0;
        for (int frame = 0; frame < 300 * FPS; frame += 15) {
            const int alive = 6 - (frame / (8 * FPS)) % 3;   // drones shot down and rebuilt
            most = std::max(most, air_defence::Need(air_defence::Held(m, alive * DRONE_HP, frame, MEMORY_FRAMES),
                                                    ESCORT_DPS, KILL_SECONDS, air_defence::Cap(12, PER_SCREEN, RANK_MAX)));
        }
        assert(most == 4);
    }
    {  // Request: only the shortfall no existing or coming escort covers.
        assert(air_defence::Request(4, 0, 0) == 4);
        assert(air_defence::Request(4, 1, 2) == 1);
        assert(air_defence::Request(2, 0, 2) == 0);   // two already ordered: none twice
        assert(air_defence::Request(0, 3, 0) == 0);   // spare escorts never start more
        assert(air_defence::Request(1, 5, 0) == 0);
    }
    {  // A simulated lab: one decision a second, 18 s to build, six drones throughout.
        // It builds exactly the need and replaces a lost escort exactly once.
        const int need = NeedFor(6 * DRONE_HP, 12);
        int assigned = 0, building = 0, built = 0, finishAt[16] = {};
        for (int second = 0; second < 240; ++second) {
            for (int i = 0; i < building; ++i) {
                if (finishAt[i] != second) continue;
                finishAt[i] = finishAt[--building]; --i; ++assigned; ++built;
            }
            if (second == 120) { assert(assigned == need); --assigned; }   // one escort lost
            const int deficit = std::max(0, need - assigned);
            if (air_defence::Request(deficit, 0, building) > 0) finishAt[building++] = second + 18;
            assert(assigned + building <= need);   // never more than the need, at any moment
        }
        assert(assigned == need);
        assert(built == need + 1);
    }
    {  // Slot: `behind` past the screen's rear edge along the axis away from the enemy, a row across it.
        const ranged::Point center{1000.f, 1000.f}, back{0.f, 1.f};
        const auto one = air_defence::Slot(center, back, 50.f, 100.f, 0, 1, 64.f);
        assert(std::fabs(one.x - 1000.f) < .01f && std::fabs(one.z - 1150.f) < .01f);
        const auto a = air_defence::Slot(center, back, 50.f, 100.f, 0, 2, 64.f);
        const auto b = air_defence::Slot(center, back, 50.f, 100.f, 1, 2, 64.f);
        assert(std::fabs(a.z - 1150.f) < .01f && std::fabs(b.z - 1150.f) < .01f);
        assert(std::fabs(std::fabs(a.x - b.x) - 64.f) < .01f && std::fabs((a.x + b.x) * .5f - 1000.f) < .01f);
        // A negative rear depth (all members ahead of the centre) still stands behind the centre.
        assert(air_defence::Slot(center, back, -20.f, 100.f, 0, 1, 64.f).z > center.z);
    }
    std::puts("air_defence_test: ok");
    return 0;
}

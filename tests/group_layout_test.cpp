// D-501: the battle group layout kernel (control/kernel/GroupLayout.h): rows by
// depth, left-to-right order within a row, the engaged arc per row, travel lanes
// and the pull-in of a slot whose way is blocked.
#include "control/kernel/GroupLayout.h"

#include <cassert>
#include <cmath>
#include <cstdio>
#include <vector>

using namespace circuit;
using ranged::Point;

namespace {
bool Near(float a, float b, float eps = .01f) { return std::fabs(a - b) <= eps; }
const group_layout::Slot& SlotOf(const std::vector<group_layout::Slot>& slots, int id) {
    for (const auto& s : slots) if (s.id == id) return s;
    assert(false && "missing slot");
    return slots.front();
}
}

int main() {
    {  // Per row: the width at the spacing, at least one; no width is one row.
        assert(group_layout::PerRow(320.f, 64.f, 12) == 6);
        assert(group_layout::PerRow(320.f, 128.f, 12) == 3);   // the doubled spacing against splash
        assert(group_layout::PerRow(0.f, 64.f, 12) == 12);
        assert(group_layout::PerRow(10.f, 64.f, 12) == 1);
    }
    {  // Order: the nearest to the enemy take row 0; each row keeps the left-to-right order.
        const Point target{0.f, 0.f}, back{0.f, 1.f};   // the group stands north of the target
        std::vector<group_layout::Member> members{
            {1, {100.f, 400.f}}, {2, {-100.f, 400.f}}, {3, {0.f, 300.f}},   // 3 is nearest
            {4, {50.f, 500.f}}, {5, {-50.f, 500.f}}, {6, {200.f, 300.f}},
        };
        std::vector<group_layout::Slot> slots;
        group_layout::Order(target, back, 3, members, slots);
        assert(slots.size() == 6);
        // depths: 3 and 6 at 300, 1 and 2 at 400, 4 and 5 at 500 -> rows {3,6,2|1}, ...
        assert(SlotOf(slots, 3).row == 0 && SlotOf(slots, 6).row == 0);
        assert(SlotOf(slots, 4).row == 1 && SlotOf(slots, 5).row == 1);
        assert(SlotOf(slots, 3).rows == 2 && SlotOf(slots, 3).rowCount == 3);
        // lateral is the left normal of back (0,1): (-1,0), so larger x is further left
        const auto& a = SlotOf(slots, 6); const auto& b = SlotOf(slots, 3);
        assert(a.index < b.index);   // x 200 before x 0
    }
    {  // Ties fall to the id: the same layout for every member.
        std::vector<group_layout::Member> m1{{7, {0.f, 100.f}}, {3, {0.f, 100.f}}};
        std::vector<group_layout::Member> m2{{3, {0.f, 100.f}}, {7, {0.f, 100.f}}};
        std::vector<group_layout::Slot> s1, s2;
        group_layout::Order({0.f, 0.f}, {0.f, 1.f}, 4, m1, s1);
        group_layout::Order({0.f, 0.f}, {0.f, 1.f}, 4, m2, s2);
        assert(s1[0].id == s2[0].id && s1[1].id == s2[1].id && s1[0].id == 3);
    }
    {  // Engaged: one row on the band; two rows put the front row closer, every row inside the band.
        const Point target{0.f, 0.f}, back{1.f, 0.f};
        group_layout::Slot single{1, 0, 0, 1, 1};
        const Point p = group_layout::Engaged(target, back, 369.f, 64.f, 64.f, false, single);
        assert(Near(p.x, 369.f) && Near(p.z, 0.f));
        group_layout::Slot front{1, 0, 0, 1, 2}, rear{2, 1, 0, 1, 2};
        assert(Near(group_layout::Engaged(target, back, 369.f, 64.f, 64.f, false, front).x, 305.f));
        assert(Near(group_layout::Engaged(target, back, 369.f, 64.f, 64.f, false, rear).x, 369.f));
        // a static armed target: further rows behind, never inside its reach
        assert(Near(group_layout::Engaged(target, back, 500.f, 64.f, 64.f, true, rear).x, 564.f));
    }
    {  // Lanes: across the travel direction, further rows behind the anchor.
        const Point focus{1000.f, 1000.f}, back{0.f, 1.f};
        group_layout::Slot left{1, 0, 0, 3, 2}, mid{2, 0, 1, 3, 2}, behind{3, 1, 0, 1, 2};
        const Point l = group_layout::Lanes(focus, back, 64.f, 64.f, left);
        const Point m = group_layout::Lanes(focus, back, 64.f, 64.f, mid);
        const Point r = group_layout::Lanes(focus, back, 64.f, 64.f, behind);
        assert(Near(m.x, 1000.f) && Near(m.z, 1000.f));
        assert(Near(l.x, 1065.f) && Near(l.z, 1000.f));
        assert(Near(r.x, 1000.f) && Near(r.z, 1064.f));
    }
    {  // Pull-in: a blocked way is shortened along the line; nothing passable gives the centre.
        const Point centre{0.f, 0.f}, slot{400.f, 0.f};
        // a mountain from x 250 on: a segment is passable while it ends before it
        const auto passable = [](Point from, Point to) { return std::max(from.x, to.x) < 250.f; };
        const Point p = group_layout::PullIn(centre, slot, 32.f, passable);
        assert(p.x < 250.f && p.x > 200.f);
        const auto never = [](Point, Point) { return false; };
        const Point q = group_layout::PullIn(centre, slot, 32.f, never);
        assert(Near(q.x, 0.f) && Near(q.z, 0.f));
        const auto always = [](Point, Point) { return true; };
        assert(Near(group_layout::PullIn(centre, slot, 32.f, always).x, 400.f));
    }
    std::puts("group_layout_test: ok");
    return 0;
}

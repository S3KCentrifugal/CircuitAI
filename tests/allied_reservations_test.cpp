#include "circuit/terrain/AlliedReservations.h"
#include <iostream>

using circuit::allied_layout::Reservations;
using circuit::allied_layout::Rect;
int failures = 0, checks = 0;
void Check(bool value, const char* name) { ++checks; if (!value) { ++failures; std::cerr << name << '\n'; } }

void test_foreign_overlap_interior_is_blocked() {
    Reservations r; r.Put(1, Reservations::ZONE, 1, {10, 10, 100, 100});
    Check(r.OverlapsOther(2, {20, 20, 22, 22}), __func__);
}
void test_owner_can_place_inside_own_zone() {
    Reservations r; r.Put(1, Reservations::ZONE, 1, {10, 10, 100, 100});
    Check(!r.OverlapsOther(1, {20, 20, 22, 22}), __func__);
}
void test_touching_edges_leave_no_overlap() {
    Reservations r; r.Put(1, Reservations::SLOT, 1, {0, 0, 32, 32});
    Check(!r.OverlapsOther(2, {32, 0, 64, 32}), __func__);
}
void test_cross_bucket_footprint_detects_one_cell_overlap() {
    Reservations r; r.Put(1, Reservations::SLOT, 1, {31, 31, 34, 34});
    Check(r.OverlapsOther(2, {33, 33, 64, 64}), __func__);
}
void test_replacement_frees_old_ground() {
    Reservations r; r.Put(1, Reservations::SLOT, 7, {10, 10, 20, 20});
    r.Put(1, Reservations::SLOT, 7, {100, 100, 110, 110});
    Check(!r.OverlapsOther(2, {10, 10, 20, 20}) && r.OverlapsOther(2, {100, 100, 110, 110}), __func__);
}
void test_releasing_slot_keeps_overlapping_zone() {
    Reservations r; r.Put(1, Reservations::ZONE, 7, {10, 10, 20, 20});
    r.Put(1, Reservations::SLOT, 7, {10, 10, 20, 20});
    r.Erase(1, Reservations::SLOT, 7);
    Check(r.OverlapsOther(2, {10, 10, 20, 20}) && r.Size() == 1, __func__);
}
void test_release_is_owner_scoped() {
    Reservations r; r.Put(1, Reservations::SLOT, 1, {10, 10, 20, 20});
    r.Put(2, Reservations::SLOT, 1, {40, 40, 50, 50});
    r.RemoveOwner(1);
    Check(!r.OverlapsOther(3, {10, 10, 20, 20}) && r.OverlapsOther(3, {40, 40, 50, 50}), __func__);
}
void test_releasing_last_claim_frees_ground() {
    Reservations r; r.Put(1, Reservations::ZONE, 1, {10, 10, 20, 20});
    r.Erase(1, Reservations::ZONE, 1);
    Check(!r.OverlapsOther(2, {10, 10, 20, 20}) && r.Size() == 0, __func__);
}
void test_invalid_rectangle_cannot_hold_space() {
    Reservations r; r.Put(1, Reservations::ZONE, 1, {-1, 0, 2, 2});
    r.Put(1, Reservations::SLOT, 2, {10, 10, 10, 11});
    Check(r.Size() == 0, __func__);
}
void test_separate_alliances_do_not_share() {
    Reservations friendly, enemy; enemy.Put(2, Reservations::ZONE, 1, {10, 10, 20, 20});
    Check(!friendly.OverlapsOther(1, {10, 10, 20, 20}), __func__);
}
void test_dense_index_agrees_with_rectangle_reference() {
    Reservations r;
    for (int i = 0; i < 200; ++i) r.Put(i % 4, Reservations::SLOT, i, {i * 3, i % 10 * 7, i * 3 + 8, i % 10 * 7 + 6});
    bool equivalent = true;
    for (int x = 0; x < 630; x += 5) {
        const Rect query{x, 20, x + 10, 30};
        bool expected = false;
        for (int i = 0; i < 200; ++i) {
            const Rect reference{i * 3, i % 10 * 7, i * 3 + 8, i % 10 * 7 + 6};
            expected |= i % 4 != 1 && reference.Overlaps(query);
        }
        equivalent &= expected == r.OverlapsOther(1, query);
    }
    Check(equivalent, __func__);
}
int main() {
    test_foreign_overlap_interior_is_blocked(); test_owner_can_place_inside_own_zone();
    test_touching_edges_leave_no_overlap(); test_cross_bucket_footprint_detects_one_cell_overlap();
    test_replacement_frees_old_ground(); test_releasing_slot_keeps_overlapping_zone();
    test_release_is_owner_scoped(); test_releasing_last_claim_frees_ground();
    test_invalid_rectangle_cannot_hold_space(); test_separate_alliances_do_not_share();
    test_dense_index_agrees_with_rectangle_reference();
    std::cout << checks << " allied reservation tests; " << failures << " failures\n";
    return failures != 0;
}

#include "circuit/terrain/AlliedReservations.h"
#include <iostream>
#include <random>
#include "support/allied_reservations_legacy.h"

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
void test_three_roles_keep_private_clusters_but_share_forward_space() {
    Reservations r;
    // Owner IDs stand for AIR, SEA and TECH. Policy does not enter the index.
    for (int owner = 0; owner < 3; ++owner)
        r.Put(owner, Reservations::ZONE, 1, {owner * 100, 0, owner * 100 + 80, 80});
    bool isolated = true;
    for (int owner = 0; owner < 3; ++owner)
        for (int requester = 0; requester < 3; ++requester)
            isolated &= r.OverlapsOther(requester, {owner * 100 + 10, 10, owner * 100 + 12, 12}) == (requester != owner);
    Check(isolated, __func__);
    // A forward weapon/mex area has individual slots, not an exclusive envelope.
    r.Put(0, Reservations::SLOT, 9, {100, 200, 104, 204});
    r.Put(1, Reservations::SLOT, 9, {108, 200, 112, 204});
    Check(!r.OverlapsOther(2, {104, 200, 108, 204}), __func__);
    Check(r.OverlapsOther(2, {100, 200, 104, 204}), __func__);
}
void test_overlapping_owners_survive_independent_release() {
    Reservations r;
    // XOR can equal a real owner's ID; the distinct-owner count must disambiguate.
    for (int owner : {0, 1, 2, 3, -12, 1000000}) r.Put(owner, Reservations::ZONE, 1, {31, 31, 66, 66});
    for (int owner : {0, 1, 2, 3, -12, 1000000}) Check(r.OverlapsOther(owner, {32, 32, 33, 33}), __func__);
    for (int owner : {0, 1, 2, 3, -12}) r.RemoveOwner(owner);
    Check(!r.OverlapsOther(1000000, {31, 31, 66, 66}) && r.OverlapsOther(0, {65, 65, 66, 66}), __func__);
    r.RemoveOwner(1000000);
    Check(!r.OverlapsOther(0, {0, 0, 100, 100}) && r.Size() == 0, __func__);
    r.Put(3, Reservations::SLOT, 9, {63, 63, 64, 64});
    Check(r.OverlapsOther(0, {63, 63, 64, 64}), __func__);
}
void test_large_nested_claim_counts_do_not_clear_early() {
    Reservations r;
    for (int i = 0; i < 70000; ++i) r.Put(4, Reservations::SLOT, i, {31, 31, 33, 33});
    for (int i = 0; i < 69999; ++i) r.Erase(4, Reservations::SLOT, i);
    Check(r.Size() == 1 && r.OverlapsOther(5, {32, 32, 33, 33}), __func__);
    r.Erase(4, Reservations::SLOT, 69999);
    Check(!r.OverlapsOther(5, {31, 31, 33, 33}), __func__);
}
void test_invalid_replacement_releases_previous_claim() {
    Reservations r;
    r.Put(0, Reservations::ZONE, 1, {0, 0, 64, 64});
    r.Put(0, Reservations::ZONE, 1, {-1, 0, 64, 64});
    Check(r.Size() == 0 && !r.OverlapsOther(1, {0, 0, 64, 64}), __func__);
}
void test_full_and_partial_page_claims_release_independently() {
    Reservations r;
    r.Put(0, Reservations::ZONE, 1, {0, 0, 64, 64});
    r.Put(0, Reservations::ZONE, 2, {0, 0, 32, 32});
    r.Put(0, Reservations::SLOT, 1, {31, 31, 33, 33});
    r.Put(1, Reservations::SLOT, 1, {31, 31, 33, 33});
    Check(r.OverlapsOther(0, {31, 31, 32, 32}) && r.OverlapsOther(1, {0, 0, 1, 1}), __func__);
    r.Erase(1, Reservations::SLOT, 1);
    Check(!r.OverlapsOther(0, {0, 0, 64, 64}), __func__);
    r.Erase(0, Reservations::ZONE, 1);
    Check(r.OverlapsOther(1, {0, 0, 1, 1}) && !r.OverlapsOther(1, {63, 63, 64, 64}), __func__);
    r.Erase(0, Reservations::ZONE, 2);
    Check(!r.OverlapsOther(1, {0, 0, 1, 1}) && r.OverlapsOther(1, {32, 32, 33, 33}), __func__);
    r.RemoveOwner(0);
    Check(!r.OverlapsOther(1, {0, 0, 64, 64}), __func__);
}
void test_random_mutations_match_brute_force_and_legacy() {
    Reservations r;
    circuit::allied_layout_legacy::Reservations legacy;
    std::map<Reservations::Key, Rect> oracle;
    std::mt19937 random(1974001);
    const std::array<int, 8> owners{0, 1, 2, 3, -7, 67, 1000000, std::numeric_limits<int>::max()};
    for (int step = 0; step < 8000; ++step) {
        const int owner = owners[random() % owners.size()];
        const int id = int(random() % 300) - 150;
        const auto kind = Reservations::Kind(random() % 2);
        const auto oldKind = circuit::allied_layout_legacy::Reservations::Kind(kind);
        const auto key = Reservations::Key(owner, kind, id);
        const int operation = random() % 20;
        if (operation == 0) {
            r.RemoveOwner(owner); legacy.RemoveOwner(owner);
            for (auto it = oracle.begin(); it != oracle.end();) {
                if (std::get<0>(it->first) == owner) it = oracle.erase(it); else ++it;
            }
        } else if (operation < 4) {
            r.Erase(owner, kind, id); legacy.Erase(owner, oldKind, id); oracle.erase(key);
        } else {
            const int x = int(random() % 384) - 4, z = int(random() % 384) - 4;
            const Rect rect{x, z, x + int(random() % 90), z + int(random() % 90)};
            r.Put(owner, kind, id, rect);
            legacy.Put(owner, oldKind, id, {rect.x1, rect.z1, rect.x2, rect.z2});
            oracle.erase(key);
            if (rect.Valid()) oracle.emplace(key, rect);
        }
        Check(r.Size() == oracle.size(), "random ledger size");
        for (int q = 0; q < 12; ++q) {
            const int who = owners[random() % owners.size()];
            const int x = int(random() % 512) - 4, z = int(random() % 512) - 4;
            const Rect rect{x, z, x + int(random() % 110), z + int(random() % 110)};
            bool expected = false;
            if (rect.Valid()) for (const auto& [k, v] : oracle) expected |= std::get<0>(k) != who && v.Overlaps(rect);
            Check(r.OverlapsOther(who, rect) == expected, "random query matches brute-force rectangles");
            Check(r.OverlapsOther(who, rect) == legacy.OverlapsOther(who, {rect.x1, rect.z1, rect.x2, rect.z2}), "random query matches legacy index");
        }
        if (step % 500 == 0) {
            // Restore rebuilds from authoritative geometry, never serialized summaries.
            Reservations restored;
            for (const auto& [k, v] : oracle) restored.Put(std::get<0>(k), Reservations::Kind(std::get<1>(k)), std::get<2>(k), v);
            for (int who : owners) Check(restored.OverlapsOther(who, {0, 0, 512, 512}) == r.OverlapsOther(who, {0, 0, 512, 512}), "restored rectangle ledger");
        }
    }
}
static void test_ordinary_task_lifecycle() {
    Reservations r;
    int task = 0;
    const Rect a{20,20,24,24}, b{40,40,44,44};
    Check(r.ClaimTask(1,task,a) && task != 0, "ordinary task claims selected footprint");
    const auto revision = r.Revision();
    Check(r.ClaimTask(1,task,a) && revision == r.Revision(), "retry does not mutate index");
    Check(r.OverlapsOther(2,a) && !r.OverlapsOther(1,a), "ordinary task excludes ally only");
    for (auto kind : {Reservations::SLOT,Reservations::ZONE,Reservations::EXIT}) {
        r.Put(2,kind,1,b);
        Check(!r.ClaimTask(1,task,b), "ordinary task respects every planned exclusion");
        Check(r.OverlapsOther(2,a), "rejected relocation preserves old claim");
        r.Erase(2,kind,1);
    }
    Check(r.ClaimTask(1,task,b), "relocation succeeds after exclusion released");
    Check(!r.OverlapsOther(2,a) && r.OverlapsOther(2,b), "relocation frees old site");
    r.Put(1,Reservations::STRUCTURE,9,b);
    r.ReleaseTask(1,task);
    Check(task == 0 && r.OverlapsOther(2,b), "nanoframe survives task cancellation");
    r.Erase(1,Reservations::STRUCTURE,9);
    Check(!r.OverlapsOther(2,b), "destroyed structure releases footprint");
    Check(r.ClaimTask(1,task,a), "released task can claim again");
    r.Put(1,Reservations::SLOT,3,b);
    r.RemoveKind(1,Reservations::TASK);
    Check(!r.OverlapsOther(2,a) && r.OverlapsOther(2,b), "disable ordinary participation preserves plan");
    r.ReleaseTask(1,task);
    r.Put(1,Reservations::STRUCTURE,9,a);
    r.RemoveOwner(1);
    Check(!r.OverlapsOther(2,a) && !r.OverlapsOther(2,b), "AI teardown releases every kind");
    int invalid = 0;
    Check(!r.ClaimTask(1,invalid,{0,0,0,0}) && invalid == 0, "invalid site cannot allocate claim");
}
void test_priority_and_committed_work() {
    Reservations r;
    const Rect a{10,10,30,30};
    r.SetPriority(10,2); r.SetPriority(20,1);
    r.Put(30,Reservations::ZONE,1,a);
    Check(!r.OverlapsOther(10,a) && !r.OverlapsOther(20,a), "higher priorities supersede unstarted generic space");
    r.Put(20,Reservations::SLOT,1,a);
    Check(!r.OverlapsOther(10,a) && r.OverlapsOther(30,a), "TECH precedes AIR precedes generic");
    r.Put(20,Reservations::COMMITTED_SLOT,1,a);
    Check(r.OverlapsOther(10,a), "active AIR construction survives TECH priority");
    r.Erase(20,Reservations::SLOT,1);
    Check(!r.OverlapsOther(10,a), "release clears committed alias");
    r.Put(20,Reservations::COMMITTED_ZONE,1,a);
    Check(r.OverlapsOther(10,a), "activated AIR campus protects future bays");
    r.SetPriority(20,0);
    Check(r.OverlapsOther(10,a), "active campus survives role change");
    r.Erase(20,Reservations::ZONE,1);
    Check(!r.OverlapsOther(10,a), "zone release clears activated alias");
    r.Put(30,Reservations::EXIT,2,a);
    Check(r.OverlapsOther(10,a), "factory access survives priority");
    r.Erase(30,Reservations::EXIT,2);
    r.SetPriority(30,2);
    Check(r.OverlapsOther(10,a), "role change reindexes existing plans");
    r.SetPriority(30,0);
    int claim=0;
    Check(r.ClaimTask(30,claim,a), "uncontested construction admitted");
    Check(r.OverlapsOther(10,a), "ordinary task protects early factory");
    r.ReleaseTask(30,claim);
    r.Put(10,Reservations::ZONE,1,a);
    Check(!r.ClaimTask(30,claim,a), "lower task cannot claim TECH district");
    r.RemoveOwner(10);
    Check(r.ClaimTask(30,claim,a), "teardown releases district");
}
static void test_priority_mutations_match_rectangles() {
    Reservations r;
    std::map<Reservations::Key, Rect> oracle;
    std::array<int, 4> priority{};
    std::mt19937 rng(431);
    for (int step=0; step<1200; ++step) {
        const int owner=int(rng()%4), id=int(rng()%16), action=int(rng()%5);
        const auto kind=Reservations::Kind(rng()%7);
        if (action==0) {
            priority[owner]=int(rng()%3); r.SetPriority(owner,priority[owner]);
        } else {
            // SLOT and ZONE aliases represent one logical reservation each.
            auto logical=[](int k) { return k==Reservations::COMMITTED_SLOT ? int(Reservations::SLOT)
                : k==Reservations::COMMITTED_ZONE ? int(Reservations::ZONE) : k; };
            const auto erase=[&](int k) {
                for (auto it=oracle.begin();it!=oracle.end();) {
                    if (std::get<0>(it->first)==owner && logical(std::get<1>(it->first))==logical(k)
                        && std::get<2>(it->first)==id) it=oracle.erase(it); else ++it;
                }
            };
            if (action==1) {
                // Public release uses the uncommitted logical ID.
                r.Erase(owner,Reservations::Kind(logical(kind)),id); erase(kind);
            } else {
                const int x=int(rng()%64),z=int(rng()%64);
                const Rect rect{x,z,x+1+int(rng()%12),z+1+int(rng()%12)};
                r.Put(owner,kind,id,rect); erase(kind); oracle[{owner,kind,id}]=rect;
            }
        }
        for (int queryOwner=0;queryOwner<4;++queryOwner) {
            const int x=int(rng()%64),z=int(rng()%64); const Rect rect{x,z,x+8,z+8};
            bool expected=false;
            for (const auto& [key,held]:oracle) {
                const int who=std::get<0>(key),k=std::get<1>(key);
                const bool hard=k!=Reservations::SLOT && k!=Reservations::ZONE;
                expected|=who!=queryOwner && (hard || priority[who]>=priority[queryOwner]) && held.Overlaps(rect);
            }
            Check(r.OverlapsOther(queryOwner,rect)==expected,"priority mutations match rectangle oracle");
        }
    }
}
int main() {
    {
        Reservations r;
        r.SetPriority(1,2);
        r.Put(2,Reservations::ZONE,1,{0,0,10,10});
        Check(!r.OverlapsOther(1,{2,2,4,4}),"TECH district planning retains priority");
        Check(r.OverlapsAnyOther(1,{2,2,4,4}),"ordinary TECH construction respects soft allied zones");
        Check(!r.OverlapsAnyOther(2,{2,2,4,4}),"strict query excludes own claims");
        r.Erase(2,Reservations::ZONE,1);
        Check(!r.OverlapsAnyOther(1,{2,2,4,4}),"strict query releases removed zones");
    }
    test_priority_mutations_match_rectangles();
    test_priority_and_committed_work();
    test_ordinary_task_lifecycle();
    test_foreign_overlap_interior_is_blocked(); test_owner_can_place_inside_own_zone();
    test_touching_edges_leave_no_overlap(); test_cross_bucket_footprint_detects_one_cell_overlap();
    test_replacement_frees_old_ground(); test_releasing_slot_keeps_overlapping_zone();
    test_release_is_owner_scoped(); test_releasing_last_claim_frees_ground();
    test_invalid_rectangle_cannot_hold_space(); test_separate_alliances_do_not_share();
    test_dense_index_agrees_with_rectangle_reference();
    test_three_roles_keep_private_clusters_but_share_forward_space();
    test_overlapping_owners_survive_independent_release();
    test_large_nested_claim_counts_do_not_clear_early();
    test_invalid_replacement_releases_previous_claim();
    test_full_and_partial_page_claims_release_independently();
    test_random_mutations_match_brute_force_and_legacy();
    std::cout << checks << " allied reservation tests; " << failures << " failures\n";
    return failures != 0;
}

#include "task/static/TierTargeting.h"
#include <cassert>
#include <cmath>
#include <iostream>
#include <vector>
using namespace circuit::tier;

void test_first_candidate_is_taken()
{
    const Candidate c{1, 6, 50.f, 100.f};
    assert(Better(c, nullptr, -1));
}
void test_lower_tier_wins_whatever_the_cost_and_distance()
{
    const Candidate afus{1, 1, 9000.f, 9.e6f};
    const Candidate llt{2, 6, 90.f, 1.f};
    assert(Better(afus, &llt, -1));
    assert(!Better(llt, &afus, -1));
    // even when the cheaper tier is the one under fire
    assert(Better(afus, &llt, 2));
}
void test_current_target_is_kept_inside_its_tier()
{
    const Candidate fus{10, 4, 4000.f, 100.f};
    const Candidate com{11, 4, 1200.f, 900.f};
    assert(!Better(fus, &com, 11));
    assert(Better(com, &fus, 11));
}
void test_dearer_then_nearer_inside_a_tier()
{
    const Candidate dear{1, 3, 2000.f, 900.f};
    const Candidate cheap{2, 3, 1000.f, 100.f};
    assert(Better(dear, &cheap, -1));
    assert(!Better(cheap, &dear, -1));
    const Candidate near{3, 3, 1000.f, 50.f};
    assert(Better(near, &cheap, -1));
    assert(!Better(cheap, &near, -1));
}

Candidate At(int id, int tier, float cost, float x, float z)
{
    return Candidate{id, tier, cost, x * x + z * z, x, z};
}
void test_areas_rank_by_best_tier_then_metal()
{
    // an advanced fusion alone; three fusions together; one fusion alone
    const std::vector<Candidate> cs{
        At(1, 1, 9000.f, 0.f, 0.f),
        At(2, 4, 4000.f, 2000.f, 0.f), At(3, 4, 4000.f, 2100.f, 0.f), At(4, 4, 4000.f, 2000.f, 150.f),
        At(5, 4, 4500.f, 0.f, 3000.f),
    };
    const auto areas = BuildAreas(cs, 300.f, -1, 6);
    assert(areas.size() == 3);
    assert(areas[0].seedId == 1 && areas[0].tier == 1);
    // the cluster outranks the single dearer fusion: 12000 metal against 4500
    assert(areas[1].tier == 4 && areas[1].metal == 12000.f);
    assert(areas[2].seedId == 5);
}
void test_area_aims_at_its_best_target_and_keeps_the_one_under_fire()
{
    const std::vector<Candidate> cs{
        At(1, 6, 50.f, 0.f, 0.f), At(2, 4, 4000.f, 100.f, 0.f), At(3, 4, 3000.f, 0.f, 100.f),
    };
    auto areas = BuildAreas(cs, 300.f, -1, 6);
    assert(areas.size() == 1 && cs[areas[0].aim].id == 2 && areas[0].metal == 7050.f);
    areas = BuildAreas(cs, 300.f, 3, 6);
    assert(cs[areas[0].aim].id == 3);
}
void test_area_count_is_capped()
{
    std::vector<Candidate> cs;
    for (int i = 0; i < 10; ++i) cs.push_back(At(i, 6, 50.f + i, 1000.f * i, 0.f));
    const auto areas = BuildAreas(cs, 300.f, -1, 3);
    assert(areas.size() == 3);
    assert(areas[0].seedId == 9 && areas[1].seedId == 8 && areas[2].seedId == 7);
}
void test_rotation_dwells_by_time_and_wraps()
{
    Rotation r;
    Restart(r, 0);
    assert(!Advance(r, 6, 599, 600, 0) && r.index == 0);
    for (int k = 1; k < 6; ++k) assert(Advance(r, 6, 600 * k, 600, 0) && r.index == k);
    assert(Advance(r, 6, 3600, 600, 0) && r.index == 0);
    // fewer areas than the rotation: wraps at what there is
    r.index = 4;
    assert(Advance(r, 3, 4000, 600, 0) && r.index == 0);
}
void test_rotation_dwells_by_shots()
{
    Rotation r;
    Restart(r, 0);
    r.shots = 1;
    assert(!Advance(r, 3, 9000, 600, 2));
    r.shots = 2;
    assert(Advance(r, 3, 9000, 600, 2) && r.index == 1 && r.shots == 0);
    // one area only: it stays on it
    Rotation one;
    one.shots = 2;
    assert(!Advance(one, 1, 10, 600, 2) && one.index == 0 && one.shots == 0);
}
void test_top_change_needs_fresh_news()
{
    assert(TopChanged(-1, 5, false, false));  // first scan
    assert(!TopChanged(5, 5, true, true));
    assert(TopChanged(5, 7, false, true));    // the old top is gone
    assert(TopChanged(5, 7, true, false));    // a newly scouted target tops it
    assert(!TopChanged(5, 7, true, true));    // a reshuffle among known targets
}

void test_blast_ring_sits_outside_the_footprint_inside_the_bowl()
{
    // advanced fusion: blast 640, footprint 96 x 96
    const float afus = BlastRingRadius(640.f, 68.f);
    assert(afus == 192.f);
    // fusion: blast 240, footprint 80 x 64 (half diagonal 51): the footprint margin wins
    const float fus = BlastRingRadius(240.f, 51.f);
    assert(fus > 74.f && fus < 76.f);
    // too small a blast for the bowl to reach past the footprint
    assert(BlastRingRadius(120.f, 51.f) == 0.f);
    assert(BlastRingRadius(0.f, 10.f) == 0.f);
    // a wider footprint pushes the ring out, up to 0.45 of the blast
    assert(BlastRingRadius(240.f, 70.f) == 94.f);
    assert(BlastRingRadius(240.f, 90.f) == 0.f);
}
void test_ring_blast_needs_enough_sunk_points()
{
    const float before[BLAST_RING_POINTS] = {100, 100, 100, 100, 100, 100, 100, 100};
    const float crater[BLAST_RING_POINTS] = {90, 91, 100, 92, 95, 100, 97, 99};   // 5 sank 2+ (a building blocks two)
    const float shell[BLAST_RING_POINTS] = {97, 100, 100, 101, 100, 100, 100, 100};  // one shell bowl, the lip raised one
    assert(SunkPoints(before, crater, BLAST_RING_POINTS, 2.f) == 5);
    assert(RingBlasted(before, crater, BLAST_RING_POINTS, 2.f, 4));
    assert(!RingBlasted(before, crater, BLAST_RING_POINTS, 2.f, 6));
    assert(!RingBlasted(before, shell, BLAST_RING_POINTS, 2.f, 4));
    assert(!RingBlasted(before, before, BLAST_RING_POINTS, 2.f, 0));  // minPoints is at least 1
}
void test_likely_killed_target_falls_below_live_tiers()
{
    const Candidate afusGhost = Downranked(At(1, 1, 9000.f, 0.f, 0.f), 10);
    const Candidate llt = At(2, 6, 90.f, 50.f, 0.f);
    assert(afusGhost.tier == 11 && afusGhost.cost == 0.f);
    assert(Better(llt, &afusGhost, 1));       // even while the ghost is the one under fire
    assert(!Better(afusGhost, &llt, 1));
    // its area ranks under a live area and adds no metal to the one it joins
    const std::vector<Candidate> cs = {afusGhost, At(3, 4, 4000.f, 100.f, 0.f), At(4, 6, 90.f, 2000.f, 0.f)};
    const std::vector<Area> areas = BuildAreas(cs, 300.f, -1, 6);
    assert(areas.size() == 2);
    assert(areas[0].seedId == 3 && areas[0].metal == 4000.f);
    assert(areas[1].seedId == 4);
    // penalty 0: no change
    assert(Downranked(At(5, 2, 100.f, 0.f, 0.f), 0).tier == 2);
}

void test_drop_line_follows_the_engine_crater()
{
    // advanced fusion (blast 640, 10600: strength 6400), ring 192 (0.3 of the radius)
    const float pg = ExpectedRingDepth(640.f, 10600.f, 192.f, 125.f);    // bare formula at hardness 125
    assert(pg > 2.2f && pg < 3.2f);
    // a soft map near the restore runs' Forge depths: centre ~30 at hardness ~18
    const float centre = ExpectedRingDepth(640.f, 10600.f, 0.f, 18.f);
    assert(centre > 22.f && centre < 38.f);
    // depth ~ 1 / hardness, and the scale lever multiplies
    assert(std::abs(ExpectedRingDepth(640.f, 10600.f, 192.f, 50.f) * 2.f - ExpectedRingDepth(640.f, 10600.f, 192.f, 25.f)) < 1e-3f);
    assert(std::abs(ExpectedRingDepth(640.f, 10600.f, 192.f, 50.f, 2.f) - ExpectedRingDepth(640.f, 10600.f, 192.f, 25.f)) < 1e-3f);
    // the drop line: a share of it, never below the floor
    assert(std::abs(BlastDropLine(pg, 0.35f, 0.5f) - pg * 0.35f) < 1e-4f);
    assert(BlastDropLine(ExpectedRingDepth(640.f, 10600.f, 192.f, 0.f), 0.35f, 0.5f) == 0.5f);
    // a Starfall shell (crater radius 128, cratermult 0.1: strength 128, passed as damage) digs
    // under the advanced fusion's line even at its own centre, on any hardness
    for (float h : {18.f, 100.f, 125.f}) {
        const float shell = ExpectedRingDepth(128.f, 128.f, 0.f, h);
        const float line = BlastDropLine(ExpectedRingDepth(640.f, 10600.f, 192.f, h), 0.35f, 0.f);
        assert(shell < line);
    }
    // the profile: the bowl ends near 0.55 of the radius, a lip beyond
    assert(CraterProfile(0.5f) > 0.f && CraterProfile(0.6f) < 0.f && CraterProfile(1.f) == 0.f);
    // calibration (BAR\blastkill-runs 2026-11-12): scale 2.8 gives the measured ring sinks
    assert(std::abs(ExpectedRingDepth(640.f, 10600.f, 192.f, 350.f, 2.8f) - 2.5f) < 0.2f);   // Proving Grounds
    assert(std::abs(ExpectedRingDepth(640.f, 10600.f, 192.f, 200.f, 2.8f) - 4.4f) < 0.2f);   // Forge v2.3
}

int main()
{
    test_first_candidate_is_taken();
    test_lower_tier_wins_whatever_the_cost_and_distance();
    test_current_target_is_kept_inside_its_tier();
    test_dearer_then_nearer_inside_a_tier();
    test_areas_rank_by_best_tier_then_metal();
    test_area_aims_at_its_best_target_and_keeps_the_one_under_fire();
    test_area_count_is_capped();
    test_rotation_dwells_by_time_and_wraps();
    test_rotation_dwells_by_shots();
    test_top_change_needs_fresh_news();
    test_blast_ring_sits_outside_the_footprint_inside_the_bowl();
    test_ring_blast_needs_enough_sunk_points();
    test_likely_killed_target_falls_below_live_tiers();
    test_drop_line_follows_the_engine_crater();
    std::cout << "tier_targeting_test: PASS\n";
    return 0;
}

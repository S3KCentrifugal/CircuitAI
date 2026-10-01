void test_base_centre_blocks() { Check(PlacementMath::FootprintIntersectsCircle(100, 200, 8, 8, 100, 200, 1200)); }
void test_outside_circle_allows() { Check(!PlacementMath::FootprintIntersectsCircle(1309, 200, 8, 8, 100, 200, 1200)); }
void test_touching_boundary_blocks() { Check(PlacementMath::FootprintIntersectsCircle(1308, 200, 8, 8, 100, 200, 1200)); }
void test_centre_outside_but_footprint_inside_blocks() { Check(PlacementMath::FootprintIntersectsCircle(1304, 200, 8, 8, 100, 200, 1200)); }
void test_diagonal_circle_is_not_bounding_square() { Check(!PlacementMath::FootprintIntersectsCircle(1000, 1000, 8, 8, 0, 0, 1200)); }
void test_rectangle_corner_intersection_blocks() { Check(PlacementMath::FootprintIntersectsCircle(730, 1000, 10, 40, 0, 0, 1200)); }
void test_ally_base_blocks_outside_own_base() { Check(!PlacementMath::FootprintIntersectsCircle(3000, 0, 8, 8, 0, 0, 1200) && PlacementMath::FootprintIntersectsCircle(3000, 0, 8, 8, 3100, 0, 1200)); }
void test_negative_direction_is_symmetric() { Check(PlacementMath::FootprintIntersectsCircle(-1208, 0, 8, 8, 0, 0, 1200) && !PlacementMath::FootprintIntersectsCircle(-1209, 0, 8, 8, 0, 0, 1200)); }
void test_long_line_crossing_base_blocks() { Check(PlacementMath::FootprintIntersectsCircle(1600, 0, 496, 16, 0, 0, 1200)); }
void test_invalid_extents_fail_closed() { Check(PlacementMath::FootprintIntersectsCircle(5000, 0, -1, 8, 0, 0, 1200)); }

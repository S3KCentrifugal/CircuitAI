void test_rate_zero_power_returns_zero() { Check(ProductionMath::Rate(100.0f, 0.0f, 0.5f) == 0.0f); }
void test_rate_invalid_work_returns_zero() { Check(ProductionMath::Rate(-1.0f, 20.0f, 0.0f) == 0.0f); }
void test_rate_zero_work_returns_zero() { Check(ProductionMath::Rate(0.0f, 20.0f, 0.0f) == 0.0f); }
void test_rate_no_handoff_is_linear() { Check(ProductionMath::Rate(100.0f, 20.0f, 0.0f) == 0.2f); }
void test_rate_handoff_reduces_output() { Check(ProductionMath::Rate(11500.0f, 4600.0f, 0.5f) < 0.34f); }
void test_rate_more_power_diminishes_gain() {
    float a = ProductionMath::Rate(11500.0f, 3600.0f, 0.5f);
    float b = ProductionMath::Rate(11500.0f, 4600.0f, 0.5f);
    float c = ProductionMath::Rate(11500.0f, 5600.0f, 0.5f);
    Check(b > a && c > b && c - b < b - a);
}
void test_batch_single_matches_rate() { Check(ProductionMath::BatchRate(100.0f, 20.0f, 0.5f, 1) == ProductionMath::Rate(100.0f, 20.0f, 0.5f)); }
void test_batch_unequal_products_sums_cycle_time() { Check(ProductionMath::BatchRate(300.0f, 100.0f, 0.5f, 2) == 0.25f); }
void test_budget_energy_limits_output() { Check(ProductionMath::FundedRate(1.0f, 100.0f, 1000.0f, 100.0f, 500.0f) == 0.5f); }
void test_budget_zero_income_stops_growth() { Check(ProductionMath::FundedRate(1.0f, 100.0f, 1000.0f, 0.0f, 1000.0f) == 0.0f); }
void test_budget_commitments_count_once() { Check(ProductionMath::Funded(100.0f, 10.0f, 50.0f, 100.0f, 50.0f, 10.0f)); }
void test_budget_negative_income_rejected() { Check(!ProductionMath::Funded(1000.0f, -1.0f, 0.0f, 0.0f, 100.0f, 1.0f)); }
void test_support_soft_limit_caps_target() { Check(ProductionMath::SupportTarget(11500.0f, 600.0f, 200.0f, 0.5f, 2.0f, 20) == 20); }
void test_support_factory_enough_needs_none() { Check(ProductionMath::SupportTarget(100.0f, 100.0f, 200.0f, 0.5f, 0.5f, 20) == 0); }
void test_support_twenty_boundary() { Check(ProductionMath::SupportTarget(11500.0f, 600.0f, 200.0f, 0.5f, ProductionMath::Rate(11500.0f, 4600.0f, 0.5f), 21) == 20); }
void test_geometry_banks_are_separate() { Check(ProductionMath::BayAcross(0, 72.0f, 48.0f, 32.0f) == -ProductionMath::BayAcross(10, 72.0f, 48.0f, 32.0f)); }
void test_geometry_second_row_is_one_nano_deeper() { Check(ProductionMath::BayAcross(5, 72.0f, 48.0f, 32.0f) == ProductionMath::BayAcross(0, 72.0f, 48.0f, 32.0f) - 48.0f); }
void test_geometry_five_positions_fit_reach() { Check(ProductionMath::BayAlong(4, 48.0f) == 96.0f && ProductionMath::BayAlong(0, 48.0f) == -96.0f); }
void test_budget_invalid_cost_rejected() { Check(ProductionMath::FundedRate(1, -1, 20, 100, 100) == 0); }
void test_support_invalid_work_cannot_request_twenty_nanos() { Check(ProductionMath::SupportTarget(0, 600, 200, 0.5f, 1, 20) == 0); }
void test_bounds_negative_candidate_never_reaches_native_grid() { Check(!ProductionMath::Inside(-1, 500, 1024, 1024, 96)); }
void test_bounds_far_edge_is_outside_even_without_margin() { Check(!ProductionMath::Inside(1024, 500, 1024, 1024, 0) && !ProductionMath::Inside(500, 1024, 1024, 1024, 0)); }
void test_bounds_whole_margin_must_fit() { Check(!ProductionMath::Inside(1000, 500, 1024, 1024, 96)); }
void test_bounds_exact_inner_edge_is_valid() { Check(ProductionMath::Inside(96, 928, 1024, 1024, 96)); }
void test_capacity_six_and_eight_supported() { Check(ProductionMath::CapacityReady(5, 12, 600, 600, 2000, 2000) && ProductionMath::CapacityReady(7, 12, 600, 600, 2000, 2000)); }
void test_capacity_twelve_is_ceiling() { Check(!ProductionMath::CapacityReady(12, 12, 600, 600, 2000, 2000)); }
void test_capacity_bank_windfall_cannot_skip_sustained_income() { Check(!ProductionMath::CapacityReady(1, 12, 0, 600, 1000000, 2000)); }
void test_capacity_stable_but_unfunded_rejected() { Check(!ProductionMath::CapacityReady(1, 12, 600, 600, 1000, 2000)); }

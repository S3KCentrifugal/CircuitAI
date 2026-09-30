void test_rate_zero_power_returns_zero() { Check(ProductionMath::Rate(100.0f, 0.0f, 0.5f) == 0.0f); }
void test_screen_small_fleet_holds_rear() { Check(ProductionMath::Progress(4, 4, 40) == 0.0f); }
void test_screen_half_fleet_advances_halfway() { Check(ProductionMath::Progress(22, 4, 40) == 0.5f); }
void test_screen_loss_retracts_line() { Check(ProductionMath::Progress(10, 4, 40) < ProductionMath::Progress(30, 4, 40)); }
void test_screen_large_fleet_cannot_cross_front() { Check(ProductionMath::Progress(80, 4, 40) == 1.0f && ProductionMath::BoundedBlend(400, 2400, 2) == 2400); }
void test_screen_invalid_threshold_stays_at_rear() { Check(ProductionMath::Progress(40, 4, 4) == 0.0f); }
void test_screen_width_interpolates() { Check(ProductionMath::BoundedBlend(600, 6000, 0.5f) == 3300); }
void test_screen_invalid_value_rejects() { Check(ProductionMath::BoundedBlend(600, -1, 0.5f) == 0); }
void test_reach_leaves_margin_for_snapping() { Check(ProductionMath::WithinReach(284*284, 300) && !ProductionMath::WithinReach(285*285, 300)); }
void test_reach_rejects_invalid_inputs() { Check(!ProductionMath::WithinReach(-1, 300) && !ProductionMath::WithinReach(1, 8)); }
void test_crew_unfinished_third_does_not_release_assistant() { Check(!ProductionMath::CrewReady(2, 3)); }
void test_crew_three_complete_release_assistant() { Check(ProductionMath::CrewReady(3, 3)); }
void test_crew_losses_restore_assistance() { Check(!ProductionMath::CrewReady(1, 3) && !ProductionMath::CrewReady(0, 0)); }
void test_idle_factory_releases_commander_after_crew() { Check(!ProductionMath::FactoryAssistUseful(true, true, false)); }
void test_factory_cold_start_keeps_commander_when_recruit_queued() { Check(ProductionMath::FactoryAssistUseful(true, true, true)); }
void test_factory_frame_keeps_commander() { Check(ProductionMath::FactoryAssistUseful(true, false, false)); }
void test_factory_opening_keeps_commander_until_crew_complete() { Check(ProductionMath::FactoryAssistUseful(false, true, false)); }
void test_initial_screen_excludes_scout_drone() { Check(ProductionMath::DefenceRecruitTarget(6, 0, 1) == 7); }
void test_defence_other_tier_already_covers_floor() { Check(ProductionMath::DefenceRecruitTarget(4, 6, 3) == 3); }
void test_defence_wave_escorts_do_not_count_as_home() { Check(ProductionMath::DefenceRecruitTarget(4, 3, 2) == 3); }
void test_defence_other_tier_losses_restore_recruitment() { Check(ProductionMath::DefenceRecruitTarget(6, 2, 3) == 7); }
void test_defence_invalid_snapshot_cannot_increase_quota() { Check(ProductionMath::DefenceRecruitTarget(4, -1, 3) == 0); }
void test_workforce_rounds_up_shortage() { Check(ProductionMath::WorkforceTarget(161.0f, 60.0f, 2, 10) == 3); }
void test_workforce_exact_target_does_not_overbuild() { Check(ProductionMath::WorkforceTarget(180.0f, 60.0f, 2, 10) == 3); }
void test_workforce_keeps_t1_floor_after_transition() { Check(ProductionMath::WorkforceTarget(40.0f, 60.0f, 3, 10) == 3); }
void test_workforce_income_growth_respects_cap() { Check(ProductionMath::WorkforceTarget(10000.0f, 60.0f, 2, 10) == 10); }
void test_workforce_invalid_power_rejects() { Check(ProductionMath::WorkforceTarget(100.0f, 0.0f, 2, 10) == 0); }
void test_wind_cluster_has_three_columns() { Check(ProductionMath::ClusterAcross(0, 32.0f) == -32.0f && ProductionMath::ClusterAcross(2, 32.0f) == 32.0f && ProductionMath::ClusterAcross(3, 32.0f) == -32.0f); }
void test_wind_cluster_has_two_touching_rows() { Check(ProductionMath::ClusterAlong(2, 48.0f) == -24.0f && ProductionMath::ClusterAlong(3, 48.0f) == 24.0f); }
void test_wind_cluster_bounds_include_whole_footprints() { Check(ProductionMath::ClusterDiameterSquared(32.0f, 48.0f) == 18432.0f); }
void test_reactor_owned_basic_mex_blocks_even_when_deadline_passed() { Check(!ProductionMath::ReactorMayStart(1, 0, 0)); }
void test_reactor_upgrade_frame_is_not_completed_income() { Check(!ProductionMath::ReactorMayStart(0, 1, 0)); }
void test_reactor_reclaim_gap_and_queued_expansion_block() { Check(!ProductionMath::ReactorMayStart(0, 0, 1)); }
void test_reactor_all_mexes_finished_allows_start() { Check(ProductionMath::ReactorMayStart(0, 0, 0)); }
void test_reactor_negative_snapshot_is_rejected() { Check(!ProductionMath::ReactorMayStart(-1, 0, 0)); }
void test_mex_cloaked_basic_extraction_requires_upgrade() { Check(ProductionMath::MexNeedsUpgrade(1.0f, 4.0f)); }
void test_mex_advanced_variant_does_not_require_downgrade() { Check(!ProductionMath::MexNeedsUpgrade(8.0f, 4.0f)); }
void test_mex_missing_upgrade_definition_blocks_reactor() { Check(ProductionMath::MexNeedsUpgrade(1.0f, 0.0f)); }
void test_preparation_starts_at_eight_minutes_for_twenty_minute_goal() { Check(ProductionMath::PreparationDue(480, 1200, 720) && !ProductionMath::PreparationDue(479, 1200, 720)); }
void test_preparation_late_goal_still_has_no_mex_override() { Check(ProductionMath::PreparationDue(1500, 1200, 720) && !ProductionMath::ReactorMayStart(2, 0, 0)); }
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

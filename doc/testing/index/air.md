# AIR test definitions

Generated source inventory. Execution is not inferred.

## Combat / Checks

### [air_afus_handoff](../../../tools/playtest/checks/air/combat/air_afus_handoff.json)

- `expect: attack`
- `expect: cleanup`
- `expect: damage`
- `expect: dead`
- `expect: launch`
- `expect: loaded`
- `expect: screenshot`
- `expect: visible`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_arena](../../../tools/playtest/checks/air/combat/air_arena.json)

- `expect: combat`
- `expect: loaded`
- `expect: ready`
- `expect: refill`
- `expect: screenshot`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_attack](../../../tools/playtest/checks/air/combat/air_attack.json)

- `expect: damage`
- `expect: launch`
- `expect: outbound`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_cleanup](../../../tools/playtest/checks/air/combat/air_cleanup.json)

- `expect: airborne`
- `expect: cleanup-damage`
- `expect: cleanup-destroyed`
- `expect: cleanup-target`
- `expect: launch`
- `expect: loaded`
- `expect: screenshot`
- `expect: strategic`
- `expect: strategic-dead`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_cleanup_only](../../../tools/playtest/checks/air/combat/air_cleanup_only.json)

- `expect: airborne`
- `expect: cleanup-destroyed`
- `expect: cleanup-target`
- `expect: launch`
- `expect: loaded`
- `expect: screenshot`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_committed_incursion](../../../tools/playtest/checks/air/combat/air_committed_incursion.json)

- `expect: committed-attack`
- `expect: escort-retained-under-incursion`
- `expect: loaded`
- `expect: screenshot`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_defensive](../../../tools/playtest/checks/air/combat/air_defensive.json)

- `expect: bomber-hits-t3`
- `expect: defensive-launch`
- `expect: defensive-return`
- `expect: loaded`
- `expect: screenshot`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_direct](../../../tools/playtest/checks/air/combat/air_direct.json)

- `expect: afus-dead`
- `expect: direct-flown`
- `expect: direct-plan`
- `expect: flank-screenshot`
- `expect: launch`
- `expect: loaded`
- `expect: target-damage`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_edge](../../../tools/playtest/checks/air/combat/air_edge.json)

- `expect: afus-dead`
- `expect: edge-plan`
- `expect: flank-flown`
- `expect: flank-screenshot`
- `expect: launch`
- `expect: loaded`
- `expect: target-damage`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_frontline](../../../tools/playtest/checks/air/combat/air_frontline.json)

- `expect: bomber-hits-front`
- `expect: frontline-plan`
- `expect: loaded`
- `expect: screenshot`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_local_defence](../../../tools/playtest/checks/air/combat/air_local_defence.json)

- `expect: anti-geometry`
- `expect: anti-placement`
- `expect: anti-ready`
- `expect: engagement`
- `expect: layout`
- `expect: raid`
- `expect: response`
- `expect: return`
- `expect: transport-delivery`
- `expect: transport-priority`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [air_recon](../../../tools/playtest/checks/air/combat/air_recon.json)

- `expect: dispatch`
- `expect: formation`
- `expect: survey`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_screen](../../../tools/playtest/checks/air/combat/air_screen.json)

- `expect: actual-patrol`
- `expect: fixture`
- `expect: full-screen`
- `expect: loss`
- `expect: tech-anchor`
- `expect: transport`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: script`

### [air_strike_stages](../../../tools/playtest/checks/air/combat/air_strike_stages.json)

- `expect: damage`
- `expect: early-intercept`
- `expect: late`
- `expect: late-damage`
- `expect: late-intercept`
- `expect: mid`
- `expect: mid-intercept`
- `expect: observer`
- `expect: release`
- `expect: return`
- `expect: strike`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: script`

### [base-response-commitment](../../../tools/playtest/checks/air/combat/base-response-commitment.json)

- `expect: committed-attack`
- `expect: escort-retained-under-incursion`
- `expect: ground-emergency`
- `expect: loaded`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

## Combat / Scenario

### [afus-handoff-glitters](../../../tools/playtest/cases/air/combat/afus-handoff-glitters.json)

Map: All That Glitters v2.2.3

### [afus-reveal-glitters](../../../tools/playtest/cases/air/combat/afus-reveal-glitters.json)

Map: All That Glitters v2.2.3

### [base-response-commitment](../../../tools/playtest/cases/air/combat/base-response-commitment.json)

Map: selected by runner

### [blocked-backline](../../../tools/playtest/cases/air/combat/blocked-backline.json)

Map: selected by runner

### [glitters-bomber-cleanup](../../../tools/playtest/cases/air/combat/cleanup-glitters.json)

Map: All That Glitters v2.2.3

### [glitters-cleanup-only](../../../tools/playtest/cases/air/combat/cleanup-only-glitters.json)

Map: All That Glitters v2.2.3

### [committed-home-incursion](../../../tools/playtest/cases/air/combat/committed-home-incursion.json)

Map: selected by runner

### [defensive-t3](../../../tools/playtest/cases/air/combat/defensive-t3.json)

Map: selected by runner

### [direct-glitters](../../../tools/playtest/cases/air/combat/direct-glitters.json)

Map: All That Glitters v2.2.3

### [edge-glitters](../../../tools/playtest/cases/air/combat/edge-glitters.json)

Map: All That Glitters v2.2.3

### [edge-supreme](../../../tools/playtest/cases/air/combat/edge-supreme.json)

Map: Supreme Isthmus v1.7

### [gunship](../../../tools/playtest/cases/air/combat/gunship.json)

Map: selected by runner

### [t1-economy](../../../tools/playtest/cases/air/combat/t1-economy.json)

Map: selected by runner

### [t2-flak](../../../tools/playtest/cases/air/combat/t2-flak.json)

Map: selected by runner

### [t2-intercept](../../../tools/playtest/cases/air/combat/t2-intercept.json)

Map: selected by runner

### [torpedo-covered](../../../tools/playtest/cases/air/combat/torpedo-covered.json)

Map: selected by runner

### [torpedo](../../../tools/playtest/cases/air/combat/torpedo.json)

Map: selected by runner

### [air-cover](../../../tools/playtest/cases/sea/combat/air-cover.json)

Map: selected by runner

## Cooperation / Checks

### [air_transport](../../../tools/playtest/checks/air/cooperation/air_transport.json)

- `expect: delivered`
- `expect: ordered`
- `expect: queued`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

## Economy / Checks

### [air_build_power](../../../tools/playtest/checks/air/economy/air_build_power.json)

- `expect: completed-worker`
- `expect: mobile-t1`
- `expect: mobile-t2`
- `expect: static`
- `expect: working`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: script`

### [air_capacity](../../../tools/playtest/checks/air/economy/air_capacity.json)

- `expect: layout`
- `expect: six`
- `expect: support`
- `expect: wave`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_capacity_opening](../../../tools/playtest/checks/air/economy/air_capacity_opening.json)

- `expect: crew`
- `expect: factory-frame`
- `expect: fighter`
- `expect: layout`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_economy](../../../tools/playtest/checks/air/economy/air_economy.json)

- `expect: fighter`
- `expect: layout`
- `expect: observer`
- `expect: plant`
- `expect: scout`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: script`

### [air_economy_capacity](../../../tools/playtest/checks/air/economy/air_economy_capacity.json)

- `expect: adoption`
- `expect: inject`
- `expect: opening`
- `expect: overflow`
- `expect: peer`
- `expect: physical`
- `expect: release`
- `expect: relocation`
- `expect: six-labs`
- `expect: work`
- `forbid: crash`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

### [air_economy_natural](../../../tools/playtest/checks/air/economy/air_economy_natural.json)

- `expect: afus`
- `expect: economy-workers`
- `expect: opening`
- `forbid: crash`
- `forbid: guard`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

### [air_fusion_gift](../../../tools/playtest/checks/air/economy/air_fusion_gift.json)

- `expect: gift`
- `expect: mex-first`
- `expect: reactor`
- `expect: upgrades`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_growth](../../../tools/playtest/checks/air/economy/air_growth.json)

- `expect: bootstrap`
- `expect: income-phase`
- `expect: mass-production`
- `expect: self-built-afus`
- `expect: six-planned`
- `expect: two-completed`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_idle](../../../tools/playtest/checks/air/economy/air_idle.json)

- `expect: bounded-work`
- `expect: commander-work`
- `expect: handoff`
- `expect: idle`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: script`

### [air_income](../../../tools/playtest/checks/air/economy/air_income.json)

- `expect: bank-gate`
- `expect: bomber`
- `expect: fighter`
- `expect: lab-built`
- `expect: relocate`
- `expect: shuriken`
- `forbid: crash`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

### [air_local_economy](../../../tools/playtest/checks/air/economy/air_local_economy.json)

- `expect: layout`
- `expect: mex-first`
- `expect: reactor`
- `expect: upgrades`
- `expect: workforce`
- `forbid: crash`
- `forbid: invariant`
- `forbid: remote-workforce`
- `forbid: script`

### [air_opening](../../../tools/playtest/checks/air/economy/air_opening.json)

- `expect: crew`
- `expect: fighter`
- `expect: guard`
- `expect: handoff`
- `expect: patrol`
- `expect: scout`
- `expect: scouting`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: script`

### [air_sustained](../../../tools/playtest/checks/air/economy/air_sustained.json)

- `expect: income-gate`
- `expect: lab-built`
- `forbid: crash`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

### [air_transition](../../../tools/playtest/checks/air/economy/air_transition.json)

- `expect: layout`
- `expect: mex-first`
- `expect: reactor`
- `expect: t2`
- `expect: upgrades`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_wind_loss](../../../tools/playtest/checks/air/economy/air_wind_loss.json)

- `expect: cluster`
- `expect: fusion`
- `expect: mex-gate`
- `expect: mobile`
- `expect: packed`
- `expect: rebuild`
- `expect: static`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: script`

### [air_workforce_budget](../../../tools/playtest/checks/air/economy/air_workforce_budget.json)

- `expect: adoption`
- `expect: donor-stop`
- `expect: sample`
- `expect: work`
- `forbid: crash`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

## Economy / Scenario

### [workforce-donations](../../../tools/playtest/cases/air/economy/workforce-donations.json)

Map: Supreme Isthmus v1.7

### [workforce-energy-starved](../../../tools/playtest/cases/air/economy/workforce-energy-starved.json)

Map: Supreme Isthmus v1.7

### [workforce-lifecycle](../../../tools/playtest/cases/air/economy/workforce-lifecycle.json)

Map: Supreme Isthmus v1.7

### [workforce-six-labs](../../../tools/playtest/cases/air/economy/workforce-six-labs.json)

Map: Supreme Isthmus v1.7

## Fixtures / Fixture/Observer

### [air_arena_probe](../../../tools/playtest/air_arena_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [air_cluster_probe](../../../tools/playtest/air_cluster_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [air_economy_probe](../../../tools/playtest/air_economy_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [air_recon_probe](../../../tools/playtest/air_recon_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [air_support_probe](../../../tools/playtest/air_support_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [air_workforce_probe](../../../tools/playtest/air_workforce_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [air_arena](../../../tools/playtest/widgets/air_arena.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_command_watch](../../../tools/playtest/widgets/air_command_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_donation_fixture](../../../tools/playtest/widgets/air_donation_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_fixture](../../../tools/playtest/widgets/air_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_income_fixture](../../../tools/playtest/widgets/air_income_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_naval_support_watch](../../../tools/playtest/widgets/air_naval_support_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_opening_watch](../../../tools/playtest/widgets/air_opening_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_recon_watch](../../../tools/playtest/widgets/air_recon_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_response_watch](../../../tools/playtest/widgets/air_response_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_strike_fixture](../../../tools/playtest/widgets/air_strike_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_sustained_fixture](../../../tools/playtest/widgets/air_sustained_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_watch](../../../tools/playtest/widgets/air_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_workforce_fixture](../../../tools/playtest/widgets/air_workforce_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [air_workforce_watch](../../../tools/playtest/widgets/air_workforce_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

## Layout / Checks

### [air_clusters](../../../tools/playtest/checks/air/layout/air_clusters.json)

- `expect: cluster`
- `expect: fusion`
- `expect: mex-gate`
- `expect: mobile`
- `expect: packed`
- `expect: static`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: script`

### [air_economy_zone](../../../tools/playtest/checks/air/layout/air_economy_zone.json)

- `expect: afus`
- `expect: converters`
- `expect: inject`
- `expect: opening`
- `expect: physical`
- `expect: release`
- `expect: relocation`
- `expect: work`
- `forbid: crash`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

### [air_factory_clusters](../../../tools/playtest/checks/air/layout/air_factory_clusters.json)

- `expect: capacity`
- `expect: cluster`
- `expect: expansion-plan`
- `expect: relocation`
- `expect: retirement`
- `expect: wind-gone`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: probe`
- `forbid: script`

### [air_support](../../../tools/playtest/checks/air/layout/air_support.json)

- `expect: layout`
- `expect: second-lab-supported`
- `expect: sixth-lab-supported`
- `expect: third-lab-supported`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_support_repair](../../../tools/playtest/checks/air/layout/air_support_repair.json)

- `expect: physical-block`
- `expect: repair`
- `expect: six-built`
- `forbid: crash`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

### [dense-converters](../../../tools/playtest/checks/air/layout/dense-converters.json)

- `expect: converters`
- `forbid: runtime`

## Layout / Scenario

### [dense-converters](../../../tools/playtest/cases/air/layout/dense-converters.json)

Map: selected by runner

## Native / Suite

### [air_geometry_test](../../../tests/air_geometry_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

### [air_safety_test](../../../tests/air_safety_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

## Performance / Checks

### [air_workforce_performance](../../../tools/playtest/checks/air/performance/air_workforce_performance.json)

- `expect: commands`
- `expect: timing-cumulative`
- `expect: timing-minute`
- `forbid: instrumentation`
- `forbid: invariant`
- `forbid: script`

### [air_workforce_scaling](../../../tools/playtest/checks/air/performance/air_workforce_scaling.json)

- `expect: 100-workers`
- `expect: 1000-workers`
- `expect: 500-workers`
- `expect: factory`
- `expect: timing`
- `forbid: instrumentation`
- `forbid: invariant`
- `forbid: script`

## Policy / Suite

### [air_math_tests](../../../tests/air_math_tests.as)

- `test_advanced_defense_bombers_accept_foothold`
- `test_advanced_defense_bombers_accept_heavy`
- `test_advanced_defense_bombers_skip_t1_mobiles`
- `test_air_access_energy_floor_can_save_below_production_energy`
- `test_air_access_saving_preserves_early_opening`
- `test_air_access_saving_waits_for_energy_floor`
- `test_air_bad_opening_settings_are_bounded`
- `test_air_badly_losing_preserves_fighter_priority`
- `test_air_bomber_admission_requires_both_incomes`
- `test_air_bomber_admission_waits_for_complete_window`
- `test_air_campus_attempts_full_size_before_compacting`
- `test_air_campus_growth_cannot_overflow`
- `test_air_campus_negative_clearance_cannot_overlap`
- `test_air_campus_reserves_minimum_before_growth`
- `test_air_campus_tiles_touch_only_at_configured_clearance`
- `test_air_clear_sky_allocation_is_bounded`
- `test_air_compact_search_retries_large_then_medium_then_single`
- `test_air_completed_reactor_does_not_block_growth`
- `test_air_continuous_incursion_cannot_starve_workforce`
- `test_air_defence_does_not_wait_for_offensive_opening`
- `test_air_disappeared_intercept_frees_group_immediately`
- `test_air_economy_opening_preserves_draw`
- `test_air_energy_recovery_never_saves_lab_capital`
- `test_air_escort_below_minimum_stays_home`
- `test_air_escort_shortage_uses_smaller_feasible_sortie`
- `test_air_explicit_factory_limit_is_respected`
- `test_air_extreme_deficit_saturates_before_conversion`
- `test_air_extreme_wave_schedule_remains_capped`
- `test_air_first_afus_retires_advanced_solar`
- `test_air_fractional_deficit_rounds_up`
- `test_air_fractional_escort_capacity_rounds_down`
- `test_air_front_assault_uses_available_force_before_opening`
- `test_air_full_lab_bank_ends_saving`
- `test_air_fully_funded_contact_does_not_keep_extra_group`
- `test_air_funded_workforce_precedes_peacetime_replacements`
- `test_air_good_survival_relaxes_learned_resistance`
- `test_air_growth_deducts_existing_commitments`
- `test_air_growth_does_not_spend_nonfloating_bank`
- `test_air_growth_invalid_share_fails_closed`
- `test_air_growth_leaves_production_share`
- `test_air_growth_needs_energy_funding`
- `test_air_growth_never_overrides_recovery`
- `test_air_growth_never_starts_parallel_reactors`
- `test_air_held_fleet_counts_toward_reachable_size`
- `test_air_high_energy_cannot_mask_metal_shortfall`
- `test_air_high_metal_cannot_mask_energy_shortfall`
- `test_air_immediate_incursion_gets_first_combat_order`
- `test_air_income_spike_does_not_start_growth`
- `test_air_initial_screen_precedes_lab_saving`
- `test_air_insufficient_cohort_is_not_released`
- `test_air_interleave_is_exact_per_cycle`
- `test_air_invalid_campus_variant_preserves_full_plan`
- `test_air_invalid_contact_snapshot_releases_group`
- `test_air_invalid_payload_ratio_fails_closed`
- `test_air_invalid_resistance_is_safe`
- `test_air_invalid_sequence_cannot_recruit_strike`
- `test_air_large_reserve_does_not_require_linear_search`
- `test_air_later_raid_funds_target`
- `test_air_launch_does_not_replace_active_cohort`
- `test_air_low_income_can_save_first_lab_capital`
- `test_air_low_income_full_store_can_fund_transition_capacity`
- `test_air_met_workforce_does_not_expand_without_bound`
- `test_air_mixed_tier_defense_uses_value`
- `test_air_neutral_survival_keeps_resistance`
- `test_air_no_enemy_air_does_not_require_escorts`
- `test_air_one_expensive_bomber_can_be_emergency`
- `test_air_opening_does_not_waive_payload`
- `test_air_opening_random_bounds_are_inclusive`
- `test_air_overflow_funds_serial_growth`
- `test_air_parity_still_builds_bombers`
- `test_air_pending_fighter_value_removes_deficit`
- `test_air_queued_lab_ends_capital_saving`
- `test_air_queued_reactor_blocks_parallel_growth`
- `test_air_reactor_repair_is_not_new_construction`
- `test_air_repeated_losses_have_bounded_resistance`
- `test_air_reserve_does_not_inflate_sortie_escort`
- `test_air_retained_intercept_survives_snapshot_reorder`
- `test_air_second_lab_does_not_use_first_lab_budget`
- `test_air_shared_economy_keeps_reactors_and_converters`
- `test_air_shared_economy_retires_small_energy`
- `test_air_small_energy_does_not_block_reactors`
- `test_air_small_pool_waits`
- `test_air_success_cannot_erase_base_unknown_reserve`
- `test_air_sufficient_defense_does_not_veto_strike`
- `test_air_sustained_fifty_starts_growth`
- `test_air_timeout_does_not_waive_escort`
- `test_air_timeout_waives_schedule_not_minimum`
- `test_air_transition_storage_does_not_expand_after_t2`
- `test_air_transition_storage_does_not_spend_an_empty_bank`
- `test_air_transition_storage_stops_at_lab_capacity`
- `test_air_two_afus_completes_growth_objective`
- `test_air_unarmed_contact_does_not_stop_strike`
- `test_air_unfinished_reactor_blocks_parallel_growth`
- `test_air_unfunded_workforce_does_not_interrupt_defense`
- `test_air_unlimited_campus_keeps_expanding`
- `test_air_wave_is_energy_limited`
- `test_air_wave_is_factory_limited`
- `test_air_wave_is_metal_limited`
- `test_air_wave_never_exceeds_cap`
- `test_air_weak_energy_does_not_start_capital_budget`
- `test_air_wipeout_increases_next_resistance`
- `test_defense_counts_frames_and_orders_once`
- `test_defense_does_not_claim_frontline`
- `test_defense_radius_includes_boundary`
- `test_defense_stops_at_shared_target`
- `test_naval_deadline_preserves_route_safety`
- `test_naval_deficit_matches_local_gap`
- `test_naval_empty_reserve_never_launches`
- `test_naval_full_releases_without_timer`
- `test_naval_invalid_force_values_do_not_trigger`
- `test_naval_no_contact_does_not_launch`
- `test_naval_parity_needs_no_air_spending`
- `test_naval_partial_does_not_release_early`
- `test_naval_partial_releases_at_deadline`
- `test_naval_runtime_costs_round_up`
- `test_naval_sector_excludes_remote_support`
- `test_naval_sector_halo_keeps_nearby_friendly_formation`
- `test_naval_sector_includes_boundary`
- `test_naval_sector_rejects_invalid_distance`
- `test_naval_subs_need_asw_despite_surface_parity`
- `test_naval_trivial_gap_does_not_make_a_wave`
- `test_naval_wave_is_bounded`
- `test_naval_zero_cost_is_not_infinite_aircraft`
- `test_recon_columns_cannot_exceed_cohort`
- `test_recon_deadline_breaks_assembly_stall`
- `test_recon_degenerate_span_keeps_one_column`
- `test_recon_displaced_plane_is_not_ready`
- `test_recon_full_unassembled_wave_waits`
- `test_recon_full_wave_launches_early`
- `test_recon_full_width_line_has_no_extra_column`
- `test_recon_half_sight_overlap_uses_radius_pitch`
- `test_recon_invalid_spacing_fails_closed`
- `test_recon_must_visit_its_slot_before_dispatch`
- `test_recon_narrow_map_uses_multiple_ranks`
- `test_recon_never_launches_empty`
- `test_recon_partial_releases_at_deadline`
- `test_recon_partial_waits_until_deadline`
- `test_recon_reached_plane_can_circle_its_slot`
- `test_recon_zero_overlap_uses_diameter_pitch`
- `test_t1_defense_bombers_accept_light_intruders`
- `test_t1_opening_admits_funded_complete_opening`
- `test_t1_opening_defers_energy_recovery`
- `test_t1_opening_one_and_ten_are_inclusive`
- `test_t1_opening_waits_for_completed_crew`
- `test_t1_opening_waits_for_completed_support`

## Reliability / Checks

### [air_compile](../../../tools/playtest/checks/air/reliability/air_compile.json)

- `expect: economy`
- `expect: layout`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_legacy](../../../tools/playtest/checks/air/reliability/air_legacy.json)

- `expect: factory`
- `expect: role`
- `forbid: controller`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [air_switch](../../../tools/playtest/checks/air/reliability/air_switch.json)

- `expect: air`
- `expect: front`
- `expect: tech`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

## Runners / Runner Family

### [air_arena](../../../tools/playtest/air_arena.py)

Prepare, run and compare replenishing AIR combat arenas; no economic build-up.

### [run_air_natural](../../../tools/playtest/run_air_natural.py)

Run natural AIR/TECH games on the five standard AIR regression maps.

### [run_air_naval_support](../../../tools/playtest/run_air_naval_support.py)

Isolated radar patrol and torpedo fleet-relief acceptance games (D194).

- `scenario: aa`
- `scenario: basin`
- `scenario: danger`
- `scenario: factory`
- `scenario: full`
- `scenario: hover`
- `scenario: naval`
- `scenario: parity`
- `scenario: partial`
- `scenario: patrol`
- `scenario: remote`
- `scenario: stall`
- `scenario: sub`
- `scenario: zero`

### [run_air_response](../../../tools/playtest/run_air_response.py)

Isolated AIR scout-deadline and allied-base intrusion acceptance fixtures.

- `scenario: defense`
- `scenario: full`
- `scenario: outside`
- `scenario: partial`
- `scenario: small`
- `scenario: t1`

### [run_air_workforce](../../../tools/playtest/run_air_workforce.py)

Stage and run reproducible supplied AIR workforce fixtures, without live installs.

- `scenario: donations`
- `scenario: energy-starved`
- `scenario: lifecycle`
- `scenario: six-labs`

### [run_air_workforce_cohort](../../../tools/playtest/run_air_workforce_cohort.py)

Run matched natural workforce cohorts using immutable data snapshots.

## Tooling / Suite

### [test_air_arena](../../../tools/playtest/test_air_arena.py)

Focused regressions for arena measurements and scenario input contracts.

- `test_aa_damage_is_not_fighter_interception`
- `test_completed_sortie_does_not_count_later_losses_twice`
- `test_detection_to_actual_fighter_hit_and_target_damage`
- `test_gunship_damage_and_emp_are_measured_without_a_bomber_sortie`
- `test_legion_early_air_is_a_gunship_not_a_fictitious_bomber`
- `test_loss_only_counts_actual_launched_cohort`
- `test_paralysis_is_not_health_damage_and_other_target_is_not_credited`
- `test_screenshot_is_linked_to_actual_engine_file`
- `test_shutdown_overrun_cannot_turn_an_unfinished_sortie_into_success`
- `test_target_alias_defaults_to_defender_faction`
- `test_truncated_last_log_record_does_not_invent_damage`
- `test_unfinished_sortie_is_censored_not_failed_or_returned`
- `test_unsafe_strings_are_quoted_in_lua_config`
- `test_zero_refill_period_is_rejected_before_launch`

### [test_air_operations](../../../tools/playtest/test_air_operations.py)

Regression tests for evidence boundaries and independent AIR attribution.

- `test_command_observer_failure_is_retained_by_both_auditors`
- `test_fighter_last_hits_are_not_credited_to_bombers`
- `test_independent_air_observer_failure_is_not_lost_without_ai_tag`
- `test_shutdown_overrun_cannot_inflate_bomber_kills`
- `test_team_zero_completion_cannot_invent_enemy_air_milestones`

### [test_air_workforce](../../../tools/playtest/test_air_workforce.py)

- `test_absent_performance_measurements_are_not_zero_cost`
- `test_count_checks_accept_whole_large_counts_and_reject_small_ones`
- `test_duplicate_read_does_not_double_count`
- `test_eliminated_air_does_not_score_dead_time_as_zero_spending`
- `test_empty_metrics_are_unavailable`
- `test_full_bank_negative_own_balance_is_visible`
- `test_matched_cohort_accepts_comparison`
- `test_missing_metadata_rejects_comparison`
- `test_old_observer_missing_usage_is_unavailable`
- `test_performance_keeps_cumulative_and_minute_percentiles_separate`
- `test_sample_counts_whole_numbers`
- `test_seed_difference_rejects_comparison`
- `test_skipped_intervals_do_not_invent_resource_totals`
- `test_timing_keeps_ai_elimination_for_population_comparison`

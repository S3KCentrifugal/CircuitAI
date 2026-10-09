# SHARED test definitions

Generated source inventory. Execution is not inferred.

## Combat / Checks

### [amphibious](../../../tools/playtest/checks/shared/combat/amphibious.json)

- `expect: air-marauder-land`
- `expect: air-marauder-water`
- `expect: air-telchine-land`
- `expect: air-telchine-water`
- `expect: combat`
- `expect: foothold-secured`
- `expect: tech-marauder-land`
- `expect: tech-marauder-water`
- `expect: tech-telchine-land`
- `expect: tech-telchine-water`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [arquebus](../../../tools/playtest/checks/shared/combat/arquebus.json)

- `expect: east range and resume`
- `expect: west range and resume`
- `forbid: invariant`
- `forbid: range failure`
- `forbid: runtime`

### [artillery_fire](../../../tools/playtest/checks/shared/combat/artillery_fire.json)

- `expect: Calamity`
- `expect: Ragnarok`
- `expect: Starfall`
- `expect: veto`
- `forbid: invariant`
- `forbid: probe failed`
- `forbid: script error`

### [flank_effectiveness](../../../tools/playtest/checks/shared/combat/flank_effectiveness.json)

- `expect: east actual TECH`
- `expect: east factory`
- `expect: observer`
- `expect: west actual TECH`
- `expect: west factory`
- `forbid: invariant`
- `forbid: observer error`
- `forbid: script`

### [juno-edge-probe](../../../tools/playtest/checks/shared/combat/juno-edge-probe.json)

- `expect: all-impacts`
- `expect: launch`
- `expect: map`
- `expect: projectile`
- `forbid: invariant`
- `forbid: script`

### [ranged-arena](../../../tools/playtest/checks/shared/combat/ranged-arena.json)

- `expect: damage`
- `expect: loaded`
- `expect: orders`
- `expect: spawn`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [ranged-no-energy](../../../tools/playtest/checks/shared/combat/ranged-no-energy.json)

- `expect: loaded`
- `expect: orders`
- `expect: spawn`
- `forbid: crash`
- `forbid: energy`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [ranged-profile-load](../../../tools/playtest/checks/shared/combat/ranged-profile-load.json)

- `expect: loaded`
- `expect: ranged`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: policy`
- `forbid: script`

### [strategic_juno](../../../tools/playtest/checks/shared/combat/strategic_juno.json)

- `expect: advanced-jammer`
- `expect: advanced-radar`
- `expect: basic-jammer`
- `expect: launch`
- `expect: radar`
- `expect: scatter`
- `expect: stock`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [strategic_nuclear](../../../tools/playtest/checks/shared/combat/strategic_nuclear.json)

- `expect: building`
- `expect: launch`
- `expect: mobile-only`
- `expect: stock`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [telchine_allied_beachhead](../../../tools/playtest/checks/shared/combat/telchine_allied_beachhead.json)

- `expect: dry-hold`
- `expect: fixture`
- `expect: guard-persistence`
- `expect: guard-split`
- `expect: naval-hit`
- `expect: retreat`
- `expect: shared-claim`
- `expect: useful-beachhead`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [telchine_beachhead](../../../tools/playtest/checks/shared/combat/telchine_beachhead.json)

- `expect: dry-hold`
- `expect: fixture`
- `expect: guard-persistence`
- `expect: guard-split`
- `expect: naval-hit`
- `expect: retreat`
- `expect: useful-beachhead`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

### [telchine_inland_formation](../../../tools/playtest/checks/shared/combat/telchine_inland_formation.json)

- `expect: dry-travel`
- `expect: fixture`
- `expect: formation-combat`
- `expect: formation-order`
- `expect: kill`
- `expect: land-fire`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`
- `forbid: terrain`

### [telchine_land_formation](../../../tools/playtest/checks/shared/combat/telchine_land_formation.json)

- `expect: dry-travel`
- `expect: fixture`
- `expect: formation-combat`
- `expect: formation-order`
- `expect: kill`
- `expect: land-fire`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`
- `forbid: terrain`

### [telchine_match](../../../tools/playtest/checks/shared/combat/telchine_match.json)

- `expect: completed-match`
- `expect: landfall`
- `expect: natural-production`
- `expect: observer`
- `expect: secured`
- `forbid: crash`
- `forbid: invariant`
- `forbid: pursuit-review`
- `forbid: script`

### [telchine_perimeter](../../../tools/playtest/checks/shared/combat/telchine_perimeter.json)

- `expect: dry-hold`
- `expect: fixture`
- `expect: legal-terrain`
- `expect: naval-hit`
- `expect: perimeter`
- `expect: retreat`
- `expect: useful-beachhead`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`
- `forbid: terrain`

### [telchine_shore](../../../tools/playtest/checks/shared/combat/telchine_shore.json)

- `expect: dry-hold`
- `expect: enemy-control`
- `expect: fixture`
- `expect: naval-hit`
- `expect: retreat`
- `expect: secured`
- `forbid: crash`
- `forbid: invariant`
- `forbid: pursuit-review`
- `forbid: script`

### [turret_enemy_reclaim](../../../tools/playtest/checks/shared/combat/turret_enemy_reclaim.json)

- `expect: all variants`
- `expect: completed`
- `expect: fixture loaded`
- `expect: lifecycle or legacy completion`
- `expect: native interrupt`
- `expect: normal work resumes`
- `expect: physical reclaim`
- `forbid: fixture failure`
- `forbid: fixture removed`
- `forbid: invariant`
- `forbid: script error`

## Combat / Scenario

### [ranged-armfboy](../../../tools/playtest/cases/shared/combat/ranged-armfboy.json)

Map: All That Glitters v2.2.3

### [ranged-armfido](../../../tools/playtest/cases/shared/combat/ranged-armfido.json)

Map: All That Glitters v2.2.3

### [ranged-starlight-closing](../../../tools/playtest/cases/shared/combat/ranged-armmanni-closing-assault.json)

Map: All That Glitters v2.2.3

### [ranged-starlight-bait](../../../tools/playtest/cases/shared/combat/ranged-armmanni-repaired-bait.json)

Map: All That Glitters v2.2.3

### [ranged-armmanni](../../../tools/playtest/cases/shared/combat/ranged-armmanni.json)

Map: All That Glitters v2.2.3

### [ranged-sniper-closing](../../../tools/playtest/cases/shared/combat/ranged-armsnipe-closing-assault.json)

Map: All That Glitters v2.2.3

### [ranged-sniper-low-energy](../../../tools/playtest/cases/shared/combat/ranged-armsnipe-energy-starved.json)

Map: All That Glitters v2.2.3

### [ranged-sniper-bait](../../../tools/playtest/cases/shared/combat/ranged-armsnipe-repaired-bait.json)

Map: All That Glitters v2.2.3

### [ranged-armsnipe](../../../tools/playtest/cases/shared/combat/ranged-armsnipe.json)

Map: All That Glitters v2.2.3

### [ranged-corban-air](../../../tools/playtest/cases/shared/combat/ranged-corban-air.json)

Map: All That Glitters v2.2.3

### [ranged-corban](../../../tools/playtest/cases/shared/combat/ranged-corban.json)

Map: All That Glitters v2.2.3

### [ranged-cormort](../../../tools/playtest/cases/shared/combat/ranged-cormort.json)

Map: All That Glitters v2.2.3

### [ranged-cortrem](../../../tools/playtest/cases/shared/combat/ranged-cortrem.json)

Map: All That Glitters v2.2.3

### [ranged-foreign-death](../../../tools/playtest/cases/shared/combat/ranged-foreign-death.json)

Map: All That Glitters v2.2.3

### [ranged-legamcluster](../../../tools/playtest/cases/shared/combat/ranged-legamcluster.json)

Map: All That Glitters v2.2.3

### [ranged-legmed](../../../tools/playtest/cases/shared/combat/ranged-legmed.json)

Map: All That Glitters v2.2.3

### [ranged-legvcarry](../../../tools/playtest/cases/shared/combat/ranged-legvcarry.json)

Map: All That Glitters v2.2.3

### [ranged-mixed-flat](../../../tools/playtest/cases/shared/combat/ranged-mixed-flat.json)

Map: Comet Catcher Remake 1.8

### [ranged-mixed-sensors](../../../tools/playtest/cases/shared/combat/ranged-mixed-sensors.json)

Map: All That Glitters v2.2.3

### [ranged-population-120](../../../tools/playtest/cases/shared/combat/ranged-population-120.json)

Map: All That Glitters v2.2.3

### [ranged-profile-load](../../../tools/playtest/cases/shared/combat/ranged-profile-load.json)

Map: Comet Catcher Remake 1.8

### [ranged-sensor-advance](../../../tools/playtest/cases/shared/combat/ranged-sensor-advance.json)

Map: All That Glitters v2.2.3

### [ranged-splash-screen](../../../tools/playtest/cases/shared/combat/ranged-splash-screen.json)

Map: All That Glitters v2.2.3

## Cooperation / Checks

### [team_share](../../../tools/playtest/checks/shared/cooperation/team_share.json)

- `expect: AIR shares`
- `expect: FRONT shares`
- `expect: SEA shares`
- `expect: SUPPORT shares`
- `expect: TACTICAL shares`
- `expect: TECH shares`
- `expect: fixture`
- `forbid: fixture removed`
- `forbid: invariant`
- `forbid: script error`

## Economy / Checks

### [expansion](../../../tools/playtest/checks/shared/economy/expansion.json)

- `expect: air-bank`
- `expect: converters`
- `expect: first-mex`
- `expect: mex-drop`
- `expect: nearby-gift`
- `expect: tech-future`
- `expect: wall`
- `forbid: crash`
- `forbid: invariant`
- `forbid: observer`
- `forbid: script`

### [metal_cancel](../../../tools/playtest/checks/shared/economy/metal_cancel.json)

- `expect: completed mex`
- `expect: deferred audit`
- `expect: released pin`
- `forbid: converter`
- `forbid: invariant`
- `forbid: native`
- `forbid: script`

### [metal_field](../../../tools/playtest/checks/shared/economy/metal_field.json)

- `expect: 0`
- `expect: 1`
- `expect: 2`
- `expect: 3`
- `expect: 4`
- `forbid: 0`
- `forbid: 1`
- `forbid: 2`
- `forbid: 3`
- `forbid: native crash`

### [metal_legacy](../../../tools/playtest/checks/shared/economy/metal_legacy.json)

- `expect: field`
- `expect: observer`
- `forbid: converter`
- `forbid: invariant`
- `forbid: native`
- `forbid: script`

### [metal_normal_control](../../../tools/playtest/checks/shared/economy/metal_normal_control.json)

- `expect: AIR`
- `expect: TECH`
- `expect: observer`
- `expect: ordinary spots`
- `forbid: field branch`
- `forbid: invariant`
- `forbid: native`
- `forbid: script`

### [metal_normal_tech_control](../../../tools/playtest/checks/shared/economy/metal_normal_tech_control.json)

- `expect: TECH`
- `expect: observer`
- `expect: ordinary spots`
- `forbid: field branch`
- `forbid: invariant`
- `forbid: native`
- `forbid: script`

## Fixtures / Fixture/Observer

### [allied_layout_probe](../../../tools/playtest/allied_layout_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [dense_economy_probe](../../../tools/playtest/dense_economy_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [weapon_performance_probe](../../../tools/playtest/weapon_performance_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [allied_layout_fixture](../../../tools/playtest/widgets/allied_layout_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [amphibious_fixture](../../../tools/playtest/widgets/amphibious_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [amphibious_visual](../../../tools/playtest/widgets/amphibious_visual.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [arquebus_watch](../../../tools/playtest/widgets/arquebus_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [artillery_fire_watch](../../../tools/playtest/widgets/artillery_fire_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [build_area](../../../tools/playtest/widgets/build_area.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [dense_economy_watch](../../../tools/playtest/widgets/dense_economy_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [draw_test](../../../tools/playtest/widgets/draw_test.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [expansion_watch](../../../tools/playtest/widgets/expansion_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [flank_economy_fixture](../../../tools/playtest/widgets/flank_economy_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [flank_effectiveness](../../../tools/playtest/widgets/flank_effectiveness.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [flank_watch](../../../tools/playtest/widgets/flank_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [fortification_fixture](../../../tools/playtest/widgets/fortification_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [gantry_watch](../../../tools/playtest/widgets/gantry_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [intro_test](../../../tools/playtest/widgets/intro_test.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [juno_edge_probe](../../../tools/playtest/widgets/juno_edge_probe.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [lane_benchmark_watch](../../../tools/playtest/widgets/lane_benchmark_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [lane_ui_memory_watch](../../../tools/playtest/widgets/lane_ui_memory_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [metal_watch](../../../tools/playtest/widgets/metal_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [mountain_regression_watch](../../../tools/playtest/widgets/mountain_regression_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [mountain_startup_watch](../../../tools/playtest/widgets/mountain_startup_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [perf_spectator_cleanup](../../../tools/playtest/widgets/perf_spectator_cleanup.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [playtest_camera](../../../tools/playtest/widgets/playtest_camera.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [ranged_arena](../../../tools/playtest/widgets/ranged_arena.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [role_swap_test](../../../tools/playtest/widgets/role_swap_test.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [scorecard_metrics](../../../tools/playtest/widgets/scorecard_metrics.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [skirmish_perf_watch](../../../tools/playtest/widgets/skirmish_perf_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [smiley_watch](../../../tools/playtest/widgets/smiley_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [strategic_fixture](../../../tools/playtest/widgets/strategic_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [team_share_fixture](../../../tools/playtest/widgets/team_share_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [team_stats](../../../tools/playtest/widgets/team_stats.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [telchine_match_watch](../../../tools/playtest/widgets/telchine_match_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [telchine_shore_fixture](../../../tools/playtest/widgets/telchine_shore_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [theatres_multi_watch](../../../tools/playtest/widgets/theatres_multi_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [theatres_watch](../../../tools/playtest/widgets/theatres_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [turret_reclaim](../../../tools/playtest/widgets/turret_reclaim.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [unit_census](../../../tools/playtest/widgets/unit_census.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [wall_exclusion_fixture](../../../tools/playtest/widgets/wall_exclusion_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [workforce_perf_watch](../../../tools/playtest/widgets/workforce_perf_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [workforce_scaling](../../../tools/playtest/widgets/workforce_scaling.lua)

In-game fixture/observer; source inventory, not a claim of execution.

## Layout / Checks

### [allied_layout](../../../tools/playtest/checks/shared/layout/allied_layout.json)

- `expect: air-active`
- `expect: air-aware`
- `expect: air-replan`
- `expect: tech-active`
- `expect: tech-aware`
- `expect: tech-replan`
- `forbid: crash`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

### [fortification](../../../tools/playtest/checks/shared/layout/fortification.json)

- `expect: future-gantry`
- `expect: geo-plan`
- `expect: geo-wall`
- `expect: mex-wall`
- `expect: t2-line`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [wall_exclusion](../../../tools/playtest/checks/shared/layout/wall_exclusion.json)

- `expect: ally-base-asset`
- `expect: audit`
- `expect: forward-assets`
- `expect: forward-wall`
- `expect: rear-assets`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`
- `forbid: wall`

## Native / Suite

### [allied_reservations_test](../../../tests/allied_reservations_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

- `test_cross_bucket_footprint_detects_one_cell_overlap`
- `test_dense_index_agrees_with_rectangle_reference`
- `test_foreign_overlap_interior_is_blocked`
- `test_full_and_partial_page_claims_release_independently`
- `test_invalid_rectangle_cannot_hold_space`
- `test_invalid_replacement_releases_previous_claim`
- `test_large_nested_claim_counts_do_not_clear_early`
- `test_overlapping_owners_survive_independent_release`
- `test_owner_can_place_inside_own_zone`
- `test_random_mutations_match_brute_force_and_legacy`
- `test_release_is_owner_scoped`
- `test_releasing_last_claim_frees_ground`
- `test_releasing_slot_keeps_overlapping_zone`
- `test_replacement_frees_old_ground`
- `test_separate_alliances_do_not_share`
- `test_three_roles_keep_private_clusters_but_share_forward_space`
- `test_touching_edges_leave_no_overlap`

### [base_layout_geometry_test](../../../tests/base_layout_geometry_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

- `TestAirClustersPackSixWithoutOverlap`
- `TestBoundsAndIntersection`
- `TestFactoryClusters`
- `TestFactoryPairSymmetry`
- `TestFootprintSnapping`

### [custom_command_test](../../../tests/custom_command_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

### [enemy_reclaim_policy_test](../../../tests/enemy_reclaim_policy_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

### [lane_solver_test](../../../tests/lane_solver_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

- `TestCancellationAndGenerationAdmission`
- `TestFlatRoutesAndMasks`
- `TestInputValidationAndClearance`
- `TestIsolatedHillsAreNotStrategicLanes`
- `TestMountainSpecialistRoute`
- `TestNoCornerCuttingAndDisconnectedWater`
- `TestThreatSnapshotAndParallelDeterminism`
- `TestVisitingTwoEndsIsNotTraversingMountain`

### [layout_ranking_test](../../../tests/layout_ranking_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

- `TestBlockFillsAcrossRows`
- `TestCentroidAndNearest`
- `TestExitLanes`
- `TestFirstTurretNearestSeed`
- `TestFlushAndSetStep`
- `TestLeavesPocket`
- `TestNextConnectedNoneFree`
- `TestPackBeforeOrder`
- `TestRingOrderAndClearOf`
- `TestRingSkipsTheZone`
- `TestSameDefGrowsARectangle`
- `TestServedOutranksPlanned`
- `TestSiteAheadOfTheBlock`
- `TestSiteFlushBeforeNearer`
- `TestSiteNearestSeedPastEnough`
- `TestWeightedSlots`

### [local_reservations_test](../../../tests/local_reservations_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

- `test_ignore_consumed_and_nested_zone_release`
- `test_random_lifecycle_and_reconstruction`

### [metal_field_test](../../../tests/metal_field_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

### [naval_geometry_test](../../../tests/naval_geometry_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

### [production_math_test](../../../tests/production_math_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

### [ranged_geometry_test](../../../tests/ranged_geometry_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

### [strategic_targeting_test](../../../tests/strategic_targeting_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

- `test_allied_pulse_pending_claim_is_exclusive_and_cancellable`
- `test_nuclear_mobile_including_t3_is_rejected`
- `test_old_shots_survive_new_target_and_dead_unit_history_is_pruned`
- `test_pulse_launch_blocks_owner_and_allies_but_keeps_other_areas_available`
- `test_sensors_towers_outrank_mobile_and_radar`
- `test_silo_history_is_local_and_expires_at_five_minutes`

### [terrain_route_test](../../../tests/terrain_route_test.cpp)

Native executable; unnamed assertions remain inside the linked suite.

## Performance / Checks

### [lane_ui_memory](../../../tools/playtest/checks/shared/performance/lane_ui_memory.json)

- `expect: render stress`
- `forbid: UI memory`
- `forbid: invariant`

### [lane_workers](../../../tools/playtest/checks/shared/performance/lane_workers.json)

- `expect: all players requested`
- `expect: main postprocess`
- `expect: native result`
- `expect: refresh completed`
- `forbid: AI error`
- `forbid: benchmark observer`
- `forbid: invariant`

### [skirmish_cpu](../../../tools/playtest/checks/shared/performance/skirmish_cpu.json)

- `expect: commands`
- `expect: timing`
- `forbid: game-ended`
- `forbid: instrumentation`
- `forbid: invariant`
- `forbid: script`

### [skirmish_cpu_clean](../../../tools/playtest/checks/shared/performance/skirmish_cpu_clean.json)

- `expect: commands`
- `expect: competitive-roster`
- `expect: timing`
- `forbid: game-ended`
- `forbid: instrumentation`
- `forbid: invariant`
- `forbid: script`

### [weapon_work](../../../tools/playtest/checks/shared/performance/weapon_work.json)

- `expect: new-timer`
- `expect: old-timer`
- `expect: opening`
- `expect: probe`
- `forbid: invariant`
- `forbid: probe-failed`
- `forbid: script`

## Policy / Suite

### [amphibious_math_tests](../../../tests/amphibious_math_tests.as)

- `test_air_auxiliary_production_keeps_existing_start_policy`
- `test_brief_income_spike_cannot_recruit`
- `test_contested_land_cannot_be_secure`
- `test_empty_beach_is_never_valuable`
- `test_empty_wave_never_arrives`
- `test_energy_limits_recruitment_even_with_metal_float`
- `test_formation_spreads_centre_out_without_duplicate_slots`
- `test_full_wave_waits_for_late_member`
- `test_guard_split_preserves_assault_and_group_bound`
- `test_guard_survives_brief_observation_gap_but_releases_lost_claim`
- `test_marauder_economy_priority`
- `test_no_single_unit_trickle`
- `test_quorum_rounds_up`
- `test_recruit_reserves_economy_bank`
- `test_role_scope`
- `test_secure_timer_and_quorum_required`
- `test_simultaneous_claims_have_one_stable_winner`
- `test_stalled_crossing_cannot_skip_security`
- `test_tech_island_start_retains_telchine_production`
- `test_tech_supreme_start_keeps_ground_bot_production`
- `test_timeout_releases_partial_wave_only_when_gathered`
- `test_underwater_is_not_landing`

### [build_power_math_tests](../../../tests/build_power_math_tests.as)

- `test_assigned_energy_limited_workers_use_new_budget_first`
- `test_committed_and_outbound_capital`
- `test_energy_is_independent`
- `test_faster_factory_must_pass_earlier_cash_breakpoint`
- `test_full_bank_funds_negative_own_balance`
- `test_funded_power_uses_both_resources`
- `test_invalid_inputs_are_not_funding`
- `test_long_investments_reserve_unpaid_cost`
- `test_no_capacity_is_not_a_builder_batch`
- `test_no_donations_required_with_capital`
- `test_one_gift_is_not_recurring_refill_pressure`
- `test_persistent_full_does_not_require_rise`
- `test_project_arrivals_and_queued_support_count_once`
- `test_protected_lab_bank_cannot_fund_discretionary_workforce`
- `test_queue_and_arrivals_are_capacity`
- `test_repeated_refills_survive_overflow_sharing`
- `test_reserve_before_completion_not_just_end`
- `test_second_callback_cannot_reuse_first_cost_or_spending`
- `test_unaffordable_opening_turret_does_not_veto_constructor`

### [collection_helpers_tests](../../../tests/collection_helpers_tests.as)

- `test_dictionary_integer_miss_and_conversion_do_not_invent_coverage`

### [metal_math_tests](../../../tests/metal_math_tests.as)

- `test_afus_does_not_justify_removing_needed_wind`
- `test_energy_limits_rich_field_spending`
- `test_energy_surplus_allows_mex_growth`
- `test_field_is_not_a_reason_to_delay_factory`
- `test_float_stops_mexes`
- `test_full_small_bank_can_fund_future_lab`
- `test_funded_investment_passes`
- `test_metal_limits_balanced_spending`
- `test_new_lab_needs_energy_as_well_as_metal`
- `test_opening_has_time_and_count_limits`
- `test_replaced_wind_can_be_retired`
- `test_storage_stops_when_next_investment_fits`

### [placement_math_tests](../../../tests/placement_math_tests.as)

- `test_ally_base_blocks_outside_own_base`
- `test_base_centre_blocks`
- `test_centre_outside_but_footprint_inside_blocks`
- `test_coverage_center_inside_but_core_exposed_rejected`
- `test_coverage_core_larger_than_range_rejected`
- `test_coverage_distant_neighbour_cannot_be_promised`
- `test_coverage_missing_interceptor_rejected`
- `test_coverage_neighbour_close_enough_included`
- `test_coverage_own_core_retained_at_boundary`
- `test_diagonal_circle_is_not_bounding_square`
- `test_invalid_extents_fail_closed`
- `test_long_line_crossing_base_blocks`
- `test_negative_direction_is_symmetric`
- `test_outside_circle_allows`
- `test_rectangle_corner_intersection_blocks`
- `test_territory_equal_frontier_not_defensive`
- `test_territory_invalid_distance_rejected`
- `test_territory_nearer_allies_admitted`
- `test_territory_nearer_enemy_rejected`
- `test_touching_boundary_blocks`

### [production_math_tests](../../../tests/production_math_tests.as)

- `test_assist_finished_frame_rejected`
- `test_assist_invalid_horizon_rejected`
- `test_assist_saturated_frame_releases_next_builder`
- `test_assist_underpowered_frame_accepts_help`
- `test_batch_single_matches_rate`
- `test_batch_unequal_products_sums_cycle_time`
- `test_bounds_exact_inner_edge_is_valid`
- `test_bounds_far_edge_is_outside_even_without_margin`
- `test_bounds_negative_candidate_never_reaches_native_grid`
- `test_bounds_whole_margin_must_fit`
- `test_budget_commitments_count_once`
- `test_budget_energy_limits_output`
- `test_budget_invalid_cost_rejected`
- `test_budget_negative_income_rejected`
- `test_budget_zero_income_stops_growth`
- `test_capacity_bank_windfall_cannot_skip_sustained_income`
- `test_capacity_six_and_eight_supported`
- `test_capacity_stable_but_unfunded_rejected`
- `test_capacity_twelve_is_ceiling`
- `test_constructor_affordable_during_energy_recovery`
- `test_constructor_disabled_burst_rejected`
- `test_constructor_empty_metal_bank_rejected`
- `test_constructor_first_growth_order_admitted`
- `test_constructor_negative_cost_rejected`
- `test_constructor_no_energy_supply_rejected`
- `test_constructor_second_growth_order_admitted`
- `test_constructor_third_order_yields_to_fighter`
- `test_converter_can_fill_surplus_with_two_pending`
- `test_converter_counts_existing_and_queue`
- `test_converter_invalid_planned_count_rejected`
- `test_converter_negative_aircraft_demand_rejected`
- `test_converter_negative_reserve_rejected`
- `test_converter_no_surplus_no_capacity`
- `test_converter_parallel_limit`
- `test_converter_rejects_zero_draw`
- `test_converter_reserves_aircraft_and_economy`
- `test_converter_scales_without_metal_income_ceiling`
- `test_converter_small_surplus_rounds_up`
- `test_crew_losses_restore_assistance`
- `test_crew_three_complete_release_assistant`
- `test_crew_unfinished_third_does_not_release_assistant`
- `test_defence_invalid_snapshot_cannot_increase_quota`
- `test_defence_other_tier_already_covers_floor`
- `test_defence_other_tier_losses_restore_recruitment`
- `test_defence_wave_escorts_do_not_count_as_home`
- `test_expansion_invalid_snapshot_fails_closed`
- `test_expansion_rejects_unfinished_existing_lab`
- `test_expansion_requires_every_lab_not_total_turrets`
- `test_expansion_support_loss_closes_gate`
- `test_factory_cold_start_keeps_commander_when_recruit_queued`
- `test_factory_frame_keeps_commander`
- `test_factory_opening_keeps_commander_until_crew_complete`
- `test_first_lab_needs_no_existing_support`
- `test_float_target_includes_bank_drawdown`
- `test_float_target_rejects_zero_horizon`
- `test_float_target_small_bank_does_not_trigger`
- `test_geometry_banks_are_separate`
- `test_geometry_five_positions_fit_reach`
- `test_geometry_second_row_is_one_nano_deeper`
- `test_idle_factory_releases_commander_after_crew`
- `test_initial_screen_excludes_scout_drone`
- `test_lab_bank_exact_cost_bypasses_income_window`
- `test_lab_bank_large_surplus_passes`
- `test_lab_income_below_fifty_waits`
- `test_lab_income_exact_fifty_passes`
- `test_lab_income_incomplete_window_waits`
- `test_lab_negative_bank_rejected`
- `test_lab_negative_minimum_rejected`
- `test_lab_zero_cost_rejected`
- `test_lab_zero_threshold_rejected`
- `test_mex_advanced_variant_does_not_require_downgrade`
- `test_mex_cloaked_basic_extraction_requires_upgrade`
- `test_mex_missing_upgrade_definition_blocks_reactor`
- `test_nonfloating_construction_target_keeps_income_only`
- `test_overflow_short_recruitment_forecast_can_pay_for_worker`
- `test_parallel_support_cannot_exceed_cap`
- `test_parallel_support_fits_resource_budget`
- `test_parallel_support_rejects_energy_shortage`
- `test_parallel_support_without_overflow_stays_serial`
- `test_preparation_late_goal_still_has_no_mex_override`
- `test_preparation_starts_at_eight_minutes_for_twenty_minute_goal`
- `test_rate_handoff_reduces_output`
- `test_rate_invalid_work_returns_zero`
- `test_rate_more_power_diminishes_gain`
- `test_rate_no_handoff_is_linear`
- `test_rate_zero_power_returns_zero`
- `test_rate_zero_work_returns_zero`
- `test_reach_leaves_margin_for_snapping`
- `test_reach_rejects_invalid_inputs`
- `test_reactor_all_mexes_finished_allows_start`
- `test_reactor_negative_snapshot_is_rejected`
- `test_reactor_owned_basic_mex_blocks_even_when_deadline_passed`
- `test_reactor_reclaim_gap_and_queued_expansion_block`
- `test_reactor_upgrade_frame_is_not_completed_income`
- `test_reclaim_advanced_exact_tech_boundary`
- `test_reclaim_afus_completed_override`
- `test_reclaim_afus_frame_has_no_override`
- `test_reclaim_t1_below_tech_boundary`
- `test_reclaim_t1_exact_tech_boundary`
- `test_screen_half_fleet_advances_halfway`
- `test_screen_invalid_threshold_stays_at_rear`
- `test_screen_invalid_value_rejects`
- `test_screen_large_fleet_cannot_cross_front`
- `test_screen_loss_retracts_line`
- `test_screen_small_fleet_holds_rear`
- `test_screen_width_interpolates`
- `test_second_lab_accepts_twenty_completed`
- `test_second_lab_rejects_nineteen_completed`
- `test_strike_absent_home_fighters_waits`
- `test_strike_bomber_income_scales`
- `test_strike_invalid_caps_rejected`
- `test_strike_invalid_ratio_rejected`
- `test_strike_invalid_step_rejected`
- `test_strike_large_enemy_force_allows_proportional_screen`
- `test_strike_live_incursion_preempts_optional_aircraft`
- `test_strike_shuriken_income_scales`
- `test_strike_support_cap`
- `test_strike_support_floor`
- `test_strike_understrength_screen_waits`
- `test_support_factory_enough_needs_none`
- `test_support_invalid_work_cannot_request_twenty_nanos`
- `test_support_soft_limit_caps_target`
- `test_support_twenty_boundary`
- `test_wind_cluster_bounds_include_whole_footprints`
- `test_wind_cluster_has_three_columns`
- `test_wind_cluster_has_two_touching_rows`
- `test_workforce_exact_target_does_not_overbuild`
- `test_workforce_fifty_metal_needs_twenty_four_basic_builders`
- `test_workforce_float_exceeds_old_ten_builder_limit`
- `test_workforce_income_growth_respects_cap`
- `test_workforce_invalid_power_rejects`
- `test_workforce_keeps_t1_floor_after_transition`
- `test_workforce_rounds_up_shortage`

### [team_share_math_tests](../../../tests/team_share_math_tests.as)

- `test_budget_is_shared_between_recipients`
- `test_custom_budget_cannot_overdraw_bank`
- `test_minimum_and_recipient_capacity`
- `test_missing_storage_empty_bank_and_disabled_budget`
- `test_opening_bank_is_protected`
- `test_threshold_is_inclusive_and_uses_storage`

## Reliability / Checks

### [artillery_profiles](../../../tools/playtest/checks/shared/reliability/artillery_profiles.json)

- `expect: veto probe`
- `forbid: invariant`
- `forbid: probe failed`
- `forbid: script error`

### [smoke](../../../tools/playtest/checks/shared/reliability/smoke.json)

- `expect: exp on`
- `expect: opening mex`
- `expect: screenshot`
- `expect: widget`
- `forbid: invariant`
- `forbid: script error`

## Runners / Runner Family

### [analyze_sea_arena](../../../tools/playtest/analyze_sea_arena.py)

Independent SEA combat/order scorecard; never overwrites evidence.

### [audit_air_arena](../../../tools/playtest/audit_air_arena.py)

Audit actual AIR sorties and interception from streaming combat-arena events.

### [bench_loop](../../../tools/playtest/bench_loop.sh)

### [playtest](../../../tools/playtest/playtest.py)

Playtest: launch a BAR skirmish with the freshly built BARb, watch its log, stop it.

### [ranged_arena](../../../tools/playtest/ranged_arena.py)

Supplied-force ranged combat: unchanged AI commands team 0; fixture owns team 1.

### [run_dense_economy](../../../tools/playtest/run_dense_economy.py)

Physical dense economy / naval support acceptance, in isolated staged data.

- `scenario: air`
- `scenario: sea`
- `scenario: support`

### [run_reservation_performance](../../../tools/playtest/run_reservation_performance.py)

Rendered Shore 8v8 regression for the shared reservation index (D-197).

### [run_sea](../../../tools/playtest/run_sea.py)

Pin, run and archive an isolated SEA migration comparison (ordinary resources).

### [run_weapon_performance](../../../tools/playtest/run_weapon_performance.py)

Same-input old/new weapon work inside the pinned engine, plus profile loading.

### [run_workforce_performance](../../../tools/playtest/run_workforce_performance.py)

Serial paired 8v8 controls. AI timing scope is engine-wide, not per role.

### [run_workforce_regressions](../../../tools/playtest/run_workforce_regressions.py)

Metal-map and unchanged TECH sequence controls for the AIR workforce change.

- `scenario: all`
- `scenario: metal`
- `scenario: tech`

### [run_workforce_scaling](../../../tools/playtest/run_workforce_scaling.py)

Fixed idle-constructor populations: isolate census scaling from diverging battles.

### [run_native_tests](../../../tools/run_native_tests.sh)

### [run_performance_tests](../../../tools/run_performance_tests.sh)

## Terrain / Checks

### [mountain_startup](../../../tools/playtest/checks/shared/terrain/mountain_startup.json)

- `expect: qualified mountain published`
- `expect: team 0 native publication`
- `expect: team 1 native publication`
- `forbid: invariant`
- `forbid: script`

### [mountain_supreme](../../../tools/playtest/checks/shared/terrain/mountain_supreme.json)

- `expect: income gate 0`
- `expect: income gate 1`
- `expect: zero specialists`
- `forbid: flank production`
- `forbid: invariant`
- `forbid: script`
- `forbid: specialist lane`

### [mountain_survey](../../../tools/playtest/checks/shared/terrain/mountain_survey.json)

- `expect: zero specialists`
- `forbid: flank production`
- `forbid: invariant`
- `forbid: script`
- `forbid: specialist lane`

### [theatres_multi](../../../tools/playtest/checks/shared/terrain/theatres_multi.json)

- `expect: four surveys`
- `forbid: invariant`
- `forbid: script error`

### [theatres_supreme](../../../tools/playtest/checks/shared/terrain/theatres_supreme.json)

- `expect: all players`
- `expect: hidden refresh stays hidden`
- `expect: hide all`
- `expect: non-TECH survey`
- `expect: overlay received`
- `expect: overlay sent`
- `expect: pond opportunities`
- `expect: screenshot`
- `expect: selected player`
- `expect: strategic sites`
- `expect: switch player`
- `expect: visibility persists`
- `expect: water topology`
- `forbid: invariant`
- `forbid: overlay error`
- `forbid: pond navy`
- `forbid: script error`

## Tooling / Suite

### [test_index_test_cases](../../../tools/knowledge/test_index_test_cases.py)

Catalog tests protect definition discovery and evidence separation.

- `test_domains_follow_paths_and_suites`
- `test_every_categorized_definition_is_present_once`
- `test_standalone_probes_and_observers_are_discoverable`

### [test_ranged_profiles](../../../tools/knowledge/test_ranged_profiles.py)

- `test_neutralize_preserves_unrelated_definition_bytes`
- `test_span_braces_in_comments_do_not_end_object`
- `test_span_nested_threat_keeps_late_retreat_and_mixed_newlines`

### [test_analyze_sea](../../../tools/playtest/test_analyze_sea.py)

- `test_compile_only_log_cannot_pass_physical_opening`
- `test_eliminated_team_is_not_a_late_economy_checkpoint`
- `test_mex_remnants_do_not_count_as_an_operational_base`
- `test_runtime_violation_is_not_hidden_by_ship_egress`

### [test_analyze_sea_arena](../../../tools/playtest/test_analyze_sea_arena.py)

- `test_credit_latency_and_errors_remain_distinct`
- `test_gadget_orders_and_child_loss_have_separate_evidence`
- `test_production_start_is_not_completion`
- `test_truncated_log_tail_is_reported_without_inventing_damage`

### [test_lane_ui_memory](../../../tools/playtest/test_lane_ui_memory.py)

Run with lupa==2.8 (Lua 5.1); install into build-theatres/widget-test-deps.

- `test_all_players_frame_allocation_and_retained_memory`
- `test_batched_vertices_preserve_dashes_clipping_and_shorter_refresh`
- `test_player_selection_preserves_all_mode_and_follows_player_mode`

### [test_playtest_deadlines](../../../tools/playtest/test_playtest_deadlines.py)

Replay buffered log batches: polling must not forgive late milestones.

- `test_buffered_late_event_fails_deadline`
- `test_delayed_timely_record_uses_its_own_frame`
- `test_early_event_in_batch_after_deadline_passes`
- `test_event_after_missed_predecessor_fails_without_crashing`
- `test_event_exactly_at_deadline_passes`
- `test_event_without_deadline_passes`

### [test_ranged_benchmark](../../../tools/playtest/test_ranged_benchmark.py)

- `test_early_failure_uses_observed_command_window_and_fails_acceptance`
- `test_failed_watch_verdict_and_missing_sensor_movement_remain_failures`
- `test_logs_and_overkill_are_not_confused_with_fixture_events`
- `test_shutdown_grace_and_partial_events_do_not_extend_measurements`

### [test_scorecard](../../../tools/playtest/test_scorecard.py)

Boundary tests: mismatched conditions and censored games must not contaminate ratings.

- `test_compare_build_changed_accepts_conditions`
- `test_compare_changed_start_rejects`
- `test_compare_game_calendar_changed_rejects`
- `test_compare_legion_changed_rejects`
- `test_compare_map_checksum_changed_rejects`
- `test_compare_wall_clock_only_preserves_cohort`
- `test_confirmed_result_with_runtime_error_not_rated`
- `test_far_actual_start_rejects_comparison`
- `test_log_actual_role_and_observer_parse`
- `test_missing_samples_are_not_zero_economy`
- `test_options_preserve_embedded_semicolon`
- `test_postgame_snapshots_do_not_change_match_totals`
- `test_rating_censored_game_keeps_prior`
- `test_rating_confirmed_win_updates_winner_up`
- `test_rating_duplicate_selfplay_excluded`
- `test_rating_engine_draw_is_not_censored`
- `test_record_after_restaging_uses_archived_inputs_and_preserves_hashes`
- `test_role_mismatch_invalidates_measurement`
- `test_small_actual_start_rounding_remains_comparable`
- `test_team_without_opponent_never_rated`

### [test_storage](../../../tools/playtest/test_storage.py)

Storage boundaries: preserve history, resolve old commands, refuse collisions.

- `test_allocate_collision_preserves_existing_directory`
- `test_allocate_same_conditions_keeps_distinct_games`
- `test_append_busy_ledger_keeps_original_history`
- `test_archive_retains_original_checks_and_settings_after_restage`
- `test_capture_uses_staged_files_and_executable`
- `test_index_distinguishes_record_from_view_revision_and_ledger`
- `test_publish_changed_original_evidence_is_rejected`
- `test_publish_changed_selection_cannot_overwrite_existing_record`
- `test_publish_is_idempotent_and_preserves_failure`
- `test_publish_permanent_rename_failure_retains_pending_bundle`
- `test_publish_post_run_analysis_gets_its_own_hash`
- `test_publish_refuses_live_snapshot`
- `test_publish_retries_transient_rename_without_changing_evidence`
- `test_record_collision_does_not_replace_previous_benchmark`
- `test_record_identical_benchmark_is_idempotent`
- `test_resolve_all_legacy_paths_and_short_ids_preserves_definitions`
- `test_resolve_canonical_id_selects_category`
- `test_resolve_custom_path_remains_supported`
- `test_resolve_duplicate_short_name_requires_qualification`
- `test_resolve_missing_path_cannot_escape_category`

### [test_workforce_perf_watch](../../../tools/playtest/test_workforce_perf_watch.py)

Exercise the timing observer against the pinned engine's argument contract.

- `test_explicit_boolean_and_exact_cumulative_percentiles`

## Tooling / Tool

### [analyze_air_natural](../../../tools/playtest/analyze_air_natural.py)

Extract AIR milestones and command traffic from a natural playtest archive.

### [analyze_air_naval_support](../../../tools/playtest/analyze_air_naval_support.py)

Summarize observed AIR patrol/torpedo evidence without changing check verdicts.

### [analyze_air_operations](../../../tools/playtest/analyze_air_operations.py)

Read independent arena damage/death events and synchronized command counts.

### [analyze_air_workforce_cohort](../../../tools/playtest/analyze_air_workforce_cohort.py)

Compare matched workforce games over the same observed simulation interval.

### [analyze_performance_phases](../../../tools/playtest/analyze_performance_phases.py)

Summarize opt-in D-199 phases without double-counting nested scopes.

### [analyze_sea](../../../tools/playtest/analyze_sea.py)

Independent SEA economy/egress scorecard; never rewrites original reports.

### [analyze_sea_patrol](../../../tools/playtest/analyze_sea_patrol.py)

Summarize physical SEA patrol/AA evidence without rewriting a run verdict.

### [analyze_skirmish_performance](../../../tools/playtest/analyze_skirmish_performance.py)

Summarize observer evidence; no FPS/CPU attribution is inferred from APM.

### [analyze_workforce_performance](../../../tools/playtest/analyze_workforce_performance.py)

Aggregate engine AI timer and actual synchronized orders in paired 8v8 games.

### [analyze_workforce_scaling](../../../tools/playtest/analyze_workforce_scaling.py)

Analyze settled fixed-population windows, excluding the spawning minute.

### [audit_afus_handoff](../../../tools/playtest/audit_afus_handoff.py)

Audit independent local-LOS/engine-order observations from an AFUS arena.

### [audit_air_economy](../../../tools/playtest/audit_air_economy.py)

Summarize AIR worker allocation, milestones and bank occupancy from staged logs.

### [audit_air_raid_feedback](../../../tools/playtest/audit_air_raid_feedback.py)

Audit actual AIR mission choices against logged, unexpired failed-raid regions.

### [audit_air_workforce](../../../tools/playtest/audit_air_workforce.py)

Focused physical workforce evidence; never replaces a whole-game verdict.

### [audit_amphibious_check](../../../tools/playtest/audit_amphibious_check.py)

Audit actual amphibious movement/combat telemetry, not just route announcements.

### [audit_metal_check](../../../tools/playtest/audit_metal_check.py)

Audit observer measurements independently of the AI's own policy logs.

### [audit_strategic_check](../../../tools/playtest/audit_strategic_check.py)

Audit confirmed strategic launches independently of target-selection logging.

- `scenario: juno`
- `scenario: nuclear`

### [audit_team_share](../../../tools/playtest/audit_team_share.py)

Audit shared donation limits, cooldowns and opening protection in a played log.

### [audit_telchine_match](../../../tools/playtest/audit_telchine_match.py)

Summarize natural Telchine evidence, excluding simulation frames after GameOver.

### [benchmark](../../../tools/playtest/benchmark.py)

Benchmark tracker: turn a playtest run into a row of doc/benchmarks/tech-rush.md.

### [build_area](../../../tools/playtest/build_area.py)

Render and measure a map's buildable ground from the build_area widget's survey.

### [compare_air_runs](../../../tools/playtest/compare_air_runs.py)

Compare observed AIR economy/combat windows; never changes check verdicts.

### [lane_benchmark](../../../tools/playtest/lane_benchmark.py)

Prepare/record isolated, map-and-settings-specific lane worker benchmarks.

### [prepare_air_check](../../../tools/playtest/prepare_air_check.py)

Prepare isolated AIR fixtures after playtest.py stage; never edits production data.

- `scenario: attack`
- `scenario: capacity`
- `scenario: constructor`
- `scenario: defence`
- `scenario: growth`
- `scenario: idle`
- `scenario: legacy`
- `scenario: loss`
- `scenario: natural`
- `scenario: screen`
- `scenario: switch`
- `scenario: transport`
- `scenario: windloss`

### [prepare_air_cluster_check](../../../tools/playtest/prepare_air_cluster_check.py)

Add a compact-cluster observer to an already staged isolated game.

### [prepare_air_economy_check](../../../tools/playtest/prepare_air_economy_check.py)

Isolated AIR gift/capacity scenarios; supplied assets are never natural benchmarks.

- `scenario: capacity`
- `scenario: constructor`

### [prepare_air_economy_zone_check](../../../tools/playtest/prepare_air_economy_zone_check.py)

Inject the economic layout/guard regression probe into an isolated staged game.

### [prepare_air_operations_cases](../../../tools/playtest/prepare_air_operations_cases.py)

Generate terrain-specific supplied-combat cases from the real map start tables.

### [prepare_air_recon_check](../../../tools/playtest/prepare_air_recon_check.py)

Stage supplied radar/co-located factory checks without changing shipped policy.

### [prepare_air_strike_check](../../../tools/playtest/prepare_air_strike_check.py)

Rendered early/mid/late AIR combat capability checks; supplied units, not economy.

### [prepare_air_support_check](../../../tools/playtest/prepare_air_support_check.py)

Add a physical support-pin obstruction to an already staged AIR capacity game.

### [prepare_air_workforce](../../../tools/playtest/prepare_air_workforce.py)

Prepare an isolated AIR guard-recovery fixture; never edits deployment data.

### [prepare_allied_layout_check](../../../tools/playtest/prepare_allied_layout_check.py)

Stage the explicit shared-layout obstruction probe, never production data.

### [prepare_amphibious_check](../../../tools/playtest/prepare_amphibious_check.py)

Stage real-terrain amphibious capability fixtures without touching live data.

### [prepare_artillery_check](../../../tools/playtest/prepare_artillery_check.py)

Instrument an already-staged, isolated BARbTest artillery regression.

### [prepare_metal_check](../../../tools/playtest/prepare_metal_check.py)

Register explicit role/start fixtures in an isolated staged tree only.

### [prepare_mountain_regression](../../../tools/playtest/prepare_mountain_regression.py)

Stage connected-mountain regressions; never changes the live install.

### [prepare_strategic_check](../../../tools/playtest/prepare_strategic_check.py)

Install a controlled strategic-weapon fixture into an isolated staged playtest.

- `scenario: juno`
- `scenario: nuclear`

### [prepare_team_share_check](../../../tools/playtest/prepare_team_share_check.py)

Stage supplied metal/factory sharing probes in an isolated 16-AI game.

### [prepare_telchine_match](../../../tools/playtest/prepare_telchine_match.py)

Stage an unboosted Tundra 8v8 with paired role/faction rosters and explicit seeds.

### [prepare_telchine_shore_check](../../../tools/playtest/prepare_telchine_shore_check.py)

Reuse the amphibious harness for labelled shoreline and inland-combat probes.

### [prepare_turret_reclaim](../../../tools/playtest/prepare_turret_reclaim.py)

Stage a supplied, isolated turret interruption fixture; never writes the live install.

### [ranged_benchmark](../../../tools/playtest/ranged_benchmark.py)

Summarize immutable ranged fixtures, or run a serial supplied-force matrix.

### [scorecard](../../../tools/playtest/scorecard.py)

Immutable match evidence, strict comparison cohorts and a private OpenSkill ladder.

### [scorecard_run](../../../tools/playtest/scorecard_run.py)

Run a reproducible TECH duel and archive its scorecard without touching BAR's install.

### [stop_game](../../../tools/playtest/stop_game.py)

Stop the playtest engine (and only it): python tools/playtest/stop_game.py [--dir C:\bardev\barb-playtest]

### [storage](../../../tools/playtest/storage.py)

Organize game tests without replacing historical evidence.

### [summarize_air](../../../tools/playtest/summarize_air.py)

Summarize observed AIR outcomes without changing the playtest verdict.

### [verify_mountain_regression](../../../tools/playtest/verify_mountain_regression.py)

Verify archived lane/production/combat evidence and retain the global verdict.

### [workforce_metrics](../../../tools/playtest/workforce_metrics.py)

Observed workforce samples; no interpolation of missing resource intervals.

## Validation / Validator

### [check_doc_links](../../../tools/knowledge/check_doc_links.py)

Verify that every relative Markdown link in this repository's documentation

### [check_invariants](../../../tools/knowledge/check_invariants.py)

Enforce the invariant practice (D-076, doc/practice-invariants.md).

### [check_performance_policy](../../../tools/knowledge/check_performance_policy.py)

D-199: compile actual old/new policy bodies in the pinned AngelScript VM.

### [check_ranged_profiles](../../../tools/knowledge/check_ranged_profiles.py)

Validate the D-207 enrollment and unchanged classifications against its checkpoint.

### [check_role_docs](../../../tools/knowledge/check_role_docs.py)

Check that doc/roles/*.md is in step with data/script/src/roles/*.as.

### [check_script_api](../../../tools/knowledge/check_script_api.py)

Check that every native member the AngelScript policy uses is registered.

### [check_unit_helpers](../../../tools/knowledge/check_unit_helpers.py)

Validate data/script/src/helpers/unit_helpers.as (and other scripts) against the shared game cache.

### [check_weapon_work](../../../tools/knowledge/check_weapon_work.py)

Execute extracted old/new TECH weapon selection with identical scripted observations.

# SEA test definitions

Generated source inventory. Execution is not inferred.

## Combat / Checks

### [amphibious-blocked](../../../tools/playtest/checks/sea/combat/amphibious-blocked.json)

- `expect: occupied`
- `forbid: errors`

### [amphibious-transition](../../../tools/playtest/checks/sea/combat/amphibious-transition.json)

- `expect: backline`
- `expect: combat`
- `expect: complex`
- `expect: complex-production`
- `expect: complex-support`
- `expect: escort`
- `expect: gantry`
- `expect: gantry-backline`
- `expect: gantry-landing`
- `expect: gantry-production`
- `expect: gantry-support`
- `expect: landfall`
- `expect: partial-survey`
- `forbid: errors`

### [legion-t2-production](../../../tools/playtest/checks/sea/combat/legion-t2-production.json)

- `expect: observer`
- `expect: registration`
- `expect: t2-combat`
- `expect: t2-constructor`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-aa-legion](../../../tools/playtest/checks/sea/combat/sea-aa-legion.json)

- `expect: dedicated_aa_damage`
- `expect: dedicated_aa_response`
- `expect: loaded`
- `expect: orders`
- `expect: physical_air_damage`
- `expect: physical_patrol`
- `expect: screen`
- `expect: spawn`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-aa-screen](../../../tools/playtest/checks/sea/combat/sea-aa-screen.json)

- `expect: loaded`
- `expect: orders`
- `expect: physical_air_damage`
- `expect: physical_patrol`
- `expect: screen`
- `expect: spawn`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-aa-unarmed](../../../tools/playtest/checks/sea/combat/sea-aa-unarmed.json)

- `expect: loaded`
- `expect: orders`
- `expect: physical_air_damage`
- `expect: physical_patrol`
- `expect: screen`
- `expect: spawn`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-arena](../../../tools/playtest/checks/sea/combat/sea-arena.json)

- `expect: combat`
- `expect: loaded`
- `expect: orders`
- `expect: spawn`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-control-lost-yard](../../../tools/playtest/checks/sea/combat/sea-control-lost-yard.json)

- `expect: loaded`
- `expect: radar-removed`
- `expect: yard-damaged`
- `expect: yard-destroyed`
- `expect: yard-lost-from-vision`
- `expect: yard-visible`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-control-visible-yard](../../../tools/playtest/checks/sea/combat/sea-control-visible-yard.json)

- `expect: loaded`
- `expect: yard-damaged`
- `expect: yard-destroyed`
- `expect: yard-visible`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-fleet-escort](../../../tools/playtest/checks/sea/combat/sea-fleet-escort.json)

- `expect: combat`
- `expect: escort`
- `expect: fleet-search`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-fleet-search](../../../tools/playtest/checks/sea/combat/sea-fleet-search.json)

- `expect: contact-damage`
- `expect: loaded`
- `expect: search-orders`
- `expect: spawn`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-patrol](../../../tools/playtest/checks/sea/combat/sea-patrol.json)

- `expect: loaded`
- `expect: orders`
- `expect: physical_patrol`
- `expect: spawn`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-sub-production](../../../tools/playtest/checks/sea/combat/sea-sub-production.json)

- `expect: counter-started`
- `expect: loaded`
- `expect: new-counter-fired`
- `expect: response`
- `forbid: crash`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

### [sea-sub-screen](../../../tools/playtest/checks/sea/combat/sea-sub-screen.json)

- `expect: loaded`
- `expect: underwater-screen`
- `forbid: fixture`
- `forbid: invariant`
- `forbid: script`

## Combat / Scenario

### [amphibious-blocked](../../../tools/playtest/cases/sea/combat/amphibious-blocked.json)

Map: Supreme Isthmus v1.7

### [amphibious-transition](../../../tools/playtest/cases/sea/combat/amphibious-transition.json)

Map: Supreme Isthmus v1.7

### [armada-aa-screen](../../../tools/playtest/cases/sea/combat/armada-air-screen-supreme.json)

Map: Supreme Isthmus v1.7

### [carrier-release](../../../tools/playtest/cases/sea/combat/carrier-release.json)

Map: selected by runner

### [escort-search](../../../tools/playtest/cases/sea/combat/escort-search.json)

Map: selected by runner

### [herring-aa-flank](../../../tools/playtest/cases/sea/combat/herring-air-flank-supreme.json)

Map: Supreme Isthmus v1.7

### [herring-aa-screen](../../../tools/playtest/cases/sea/combat/herring-air-screen-supreme.json)

Map: Supreme Isthmus v1.7

### [herring-patrol](../../../tools/playtest/cases/sea/combat/herring-patrol-supreme.json)

Map: Supreme Isthmus v1.7

### [herring-aa-unarmed](../../../tools/playtest/cases/sea/combat/herring-unarmed-supreme.json)

Map: Supreme Isthmus v1.7

### [hover-screen](../../../tools/playtest/cases/sea/combat/hover-screen.json)

Map: selected by runner

### [large-fleet](../../../tools/playtest/cases/sea/combat/large-fleet.json)

Map: selected by runner

### [legion-aa-screen](../../../tools/playtest/cases/sea/combat/legion-air-screen-supreme.json)

Map: Supreme Isthmus v1.7

### [legion-t2-production](../../../tools/playtest/cases/sea/combat/legion-t2-production.json)

Map: selected by runner

### [response-air-limited](../../../tools/playtest/cases/sea/combat/response-air-limited.json)

Map: selected by runner

### [response-air-supported](../../../tools/playtest/cases/sea/combat/response-air-supported.json)

Map: selected by runner

### [response-sub-cortex-supported](../../../tools/playtest/cases/sea/combat/response-sub-cortex-supported.json)

Map: selected by runner

### [response-sub-cortex](../../../tools/playtest/cases/sea/combat/response-sub-cortex.json)

Map: selected by runner

### [response-sub-legion](../../../tools/playtest/cases/sea/combat/response-sub-legion.json)

Map: selected by runner

### [response-sub-limited](../../../tools/playtest/cases/sea/combat/response-sub-limited.json)

Map: selected by runner

### [response-sub-supported](../../../tools/playtest/cases/sea/combat/response-sub-supported.json)

Map: selected by runner

### [response-submarine](../../../tools/playtest/cases/sea/combat/response-submarine.json)

Map: selected by runner

### [scout-fog](../../../tools/playtest/cases/sea/combat/scout-fog.json)

Map: selected by runner

### [control-yard-lost](../../../tools/playtest/cases/sea/combat/sea-control-lost-yard-supreme.json)

Map: Supreme Isthmus v1.7

### [control-yard-seen](../../../tools/playtest/cases/sea/combat/sea-control-visible-yard-supreme.json)

Map: Supreme Isthmus v1.7

### [shore-siege](../../../tools/playtest/cases/sea/combat/shore-siege.json)

Map: selected by runner

### [submarine-screen](../../../tools/playtest/cases/sea/combat/submarine-screen.json)

Map: selected by runner

### [surface-line](../../../tools/playtest/cases/sea/combat/surface-line.json)

Map: selected by runner

### [surface-sub-danger](../../../tools/playtest/cases/sea/combat/surface-sub-danger.json)

Map: selected by runner

## Economy / Checks

### [sea-capacity-8v8](../../../tools/playtest/checks/sea/economy/sea-capacity-8v8.json)

- `expect: allied-repair`
- `expect: observer`
- `expect: start-count`
- `expect: sub-scaling`
- `expect: team-0-factory-1`
- `expect: team-0-factory-2`
- `expect: team-0-factory-3`
- `expect: team-1-factory-1`
- `expect: team-1-factory-2`
- `expect: team-1-factory-3`
- `expect: team-10-factory-1`
- `expect: team-10-factory-2`
- `expect: team-10-factory-3`
- `expect: team-11-factory-1`
- `expect: team-11-factory-2`
- `expect: team-11-factory-3`
- `expect: team-12-factory-1`
- `expect: team-12-factory-2`
- `expect: team-12-factory-3`
- `expect: team-13-factory-1`
- `expect: team-13-factory-2`
- `expect: team-13-factory-3`
- `expect: team-14-factory-1`
- `expect: team-14-factory-2`
- `expect: team-14-factory-3`
- `expect: team-15-factory-1`
- `expect: team-15-factory-2`
- `expect: team-15-factory-3`
- `expect: team-2-factory-1`
- `expect: team-2-factory-2`
- `expect: team-2-factory-3`
- `expect: team-3-factory-1`
- `expect: team-3-factory-2`
- `expect: team-3-factory-3`
- `expect: team-4-factory-1`
- `expect: team-4-factory-2`
- `expect: team-4-factory-3`
- `expect: team-5-factory-1`
- `expect: team-5-factory-2`
- `expect: team-5-factory-3`
- `expect: team-6-factory-1`
- `expect: team-6-factory-2`
- `expect: team-6-factory-3`
- `expect: team-7-factory-1`
- `expect: team-7-factory-2`
- `expect: team-7-factory-3`
- `expect: team-8-factory-1`
- `expect: team-8-factory-2`
- `expect: team-8-factory-3`
- `expect: team-9-factory-1`
- `expect: team-9-factory-2`
- `expect: team-9-factory-3`
- `forbid: errors`

### [sea-production-8v8](../../../tools/playtest/checks/sea/economy/sea-production-8v8.json)

- `expect: observer`
- `expect: start-count`
- `expect: sub-scaling`
- `forbid: errors`

### [sea-recovery-priorities](../../../tools/playtest/checks/sea/economy/sea-recovery-priorities.json)

- `expect: flagship-repair`
- `expect: observer`
- `expect: ordinary-repair`
- `expect: platform-producing`
- `expect: reclaim`
- `expect: resurrect`
- `expect: sub-scaling`
- `expect: t1-producing`
- `expect: t2-producing`
- `forbid: errors`

### [seaplane-natural](../../../tools/playtest/checks/sea/economy/seaplane-natural.json)

- `expect: aircraft`
- `expect: mex`
- `expect: platform`
- `expect: support`
- `forbid: errors`

### [seaplane-transition](../../../tools/playtest/checks/sea/economy/seaplane-transition.json)

- `expect: aircraft`
- `expect: footprint`
- `expect: income_hold`
- `expect: mex`
- `expect: platform`
- `expect: support`
- `forbid: errors`

## Economy / Scenario

### [migration-natural](../../../tools/playtest/cases/sea/economy/migration-natural.json)

Map: selected by runner

### [sea-capacity-8v8](../../../tools/playtest/cases/sea/economy/sea-capacity-8v8.json)

Map: Shore_to_Shore_V3

### [sea-production-8v8](../../../tools/playtest/cases/sea/economy/sea-production-8v8.json)

Map: Shore_to_Shore_V3

### [sea-recovery-priorities](../../../tools/playtest/cases/sea/economy/sea-recovery-priorities.json)

Map: Supreme Isthmus v1.7

### [seaplane-natural](../../../tools/playtest/cases/sea/economy/seaplane-natural.json)

Map: Supreme Isthmus v1.7

### [seaplane-transition](../../../tools/playtest/cases/sea/economy/seaplane-transition.json)

Map: Supreme Isthmus v1.7

## Fixtures / Fixture/Observer

### [sea_allied_base_probe](../../../tools/playtest/sea_allied_base_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [sea_economy_block_probe](../../../tools/playtest/sea_economy_block_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [sea_harbor_probe](../../../tools/playtest/sea_harbor_probe.as)

Scripted test probe; inspect the linked source for stages and assertions.

### [sea_allied_base_watch](../../../tools/playtest/widgets/sea_allied_base_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [sea_arena](../../../tools/playtest/widgets/sea_arena.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [sea_economy_block_watch](../../../tools/playtest/widgets/sea_economy_block_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [sea_harbor_fixture](../../../tools/playtest/widgets/sea_harbor_fixture.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [sea_invasion_watch](../../../tools/playtest/widgets/sea_invasion_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [sea_recovery_watch](../../../tools/playtest/widgets/sea_recovery_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [sea_transition_watch](../../../tools/playtest/widgets/sea_transition_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

### [sea_watch](../../../tools/playtest/widgets/sea_watch.lua)

In-game fixture/observer; source inventory, not a claim of execution.

## Layout / Checks

### [allied-bases-mixed](../../../tools/playtest/checks/sea/layout/allied-bases-mixed.json)

- `expect: AIR-SEA-economy`
- `expect: AIR-SEA-factory`
- `expect: AIR-TECH-economy`
- `expect: AIR-TECH-factory`
- `expect: SEA-AIR-economy`
- `expect: SEA-AIR-factory`
- `expect: SEA-TECH-economy`
- `expect: SEA-TECH-factory`
- `expect: TECH-AIR-economy`
- `expect: TECH-AIR-factory`
- `expect: TECH-SEA-economy`
- `expect: TECH-SEA-factory`
- `forbid: crash`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

### [allied-bases-supplied](../../../tools/playtest/checks/sea/layout/allied-bases-supplied.json)

- `expect: clusters`
- `expect: yard-0`
- `expect: yard-1`
- `expect: yard-2`
- `forbid: crash`
- `forbid: invariant`
- `forbid: probe`
- `forbid: script`

### [dense-economy](../../../tools/playtest/checks/sea/layout/dense-economy.json)

- `expect: advanced-converters`
- `expect: t1-converters`
- `expect: tidal-strip`
- `forbid: runtime`

### [dense-support](../../../tools/playtest/checks/sea/layout/dense-support.json)

- `expect: amphibious`
- `expect: shipyard`
- `forbid: runtime`

### [economy-block](../../../tools/playtest/checks/sea/layout/economy-block.json)

- `expect: amphibious`
- `expect: fusion-support`
- `expect: rear-fusion`
- `expect: shipyard`
- `expect: square`
- `expect: t1`
- `expect: t2`
- `forbid: errors`

### [harbor-lifecycle](../../../tools/playtest/checks/sea/layout/harbor-lifecycle.json)

- `expect: adoption`
- `expect: egress`
- `expect: physical-handover`
- `expect: reclaimed`
- `expect: removed`
- `expect: replan`
- `expect: retired`
- `forbid: runtime`

## Layout / Scenario

### [allied-bases-mixed](../../../tools/playtest/cases/sea/layout/allied-bases-mixed.json)

Map: selected by runner

### [allied-bases-supplied](../../../tools/playtest/cases/sea/layout/allied-bases-supplied.json)

Map: selected by runner

### [dense-economy](../../../tools/playtest/cases/sea/layout/dense-economy.json)

Map: selected by runner

### [dense-support](../../../tools/playtest/cases/sea/layout/dense-support.json)

Map: selected by runner

### [economy-block](../../../tools/playtest/cases/sea/layout/economy-block.json)

Map: selected by runner

### [harbor-lifecycle](../../../tools/playtest/cases/sea/layout/harbor-lifecycle.json)

Map: glacial

## Policy / Suite

### [sea_math_tests](../../../tests/sea_math_tests.as)

- `test_aa_screen_slots_stay_separate_and_overlap`
- `test_canceled_unframed_berth_is_retryable`
- `test_counter_admission_and_time_to_coverage`
- `test_interception_respects_speed_weapon_reach_and_horizon`
- `test_invasion_admission_needs_escort_predecessor_and_both_resources`
- `test_invasion_replans_only_uncommitted_or_dead_slots`
- `test_opening_exception_does_not_return_after_factory_loss`
- `test_rear_fusion_footprint_keeps_protected_margin`
- `test_recovery_fleet_and_income_both_scale_capacity`
- `test_recovery_low_metal_hysteresis`
- `test_safety_interruption_restarts_unchanged_site_timer`
- `test_sea_control_requires_complete_recent_coverage_and_quiet`
- `test_sea_policy_boundaries`
- `test_seaplane_preserves_full_cost_and_reserve_after_commitments`
- `test_seaplane_requires_sustained_income_even_with_gifted_bank`
- `test_seaplane_uses_actual_faction_and_modified_costs`
- `test_shared_factory_support_budget_and_pending_power`
- `test_yard_whole_footprint_stays_forward_of_economy`

## Reliability / Checks

### [sea_compile](../../../tools/playtest/checks/sea/reliability/sea_compile.json)

- `expect: first-ship-exit`
- `expect: observer`
- `expect: opening-yard`
- `forbid: crash`
- `forbid: invariant`
- `forbid: script`

## Runners / Runner Family

### [run_sea_allied_base](../../../tools/playtest/run_sea_allied_base.py)

Cross-role reservation probes or supplied three-SEA placement on Glacial.

### [run_sea_cohort](../../../tools/playtest/run_sea_cohort.py)

Paired, immutable SEA layout smoke benchmarks; not a win-rate experiment.

### [run_sea_combat](../../../tools/playtest/run_sea_combat.py)

Serial paired naval fixtures with pinned controls and independent scorecards.

### [run_sea_economy_block](../../../tools/playtest/run_sea_economy_block.py)

Supreme Isthmus physical economy-block acceptance, using real placement tasks.

### [run_sea_invasion](../../../tools/playtest/run_sea_invasion.py)

Supplied SEA transition fixtures. Actual AI builds, escorts and invades.

### [run_sea_recovery](../../../tools/playtest/run_sea_recovery.py)

SEA recovery fixture or 8v8 natural production benchmark, with immutable pins.

### [run_sea_transition](../../../tools/playtest/run_sea_transition.py)

Supreme SEA mex/seaplane acceptance with real role decisions (supplied capital).

### [sea_arena](../../../tools/playtest/sea_arena.py)

Isolated SEA combat fixtures. Assets are supplied; AI alone commands combat.

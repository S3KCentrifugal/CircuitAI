# Ranged land combat rework

Implementation on `codex/ranged-combat-rework`, based on checkpoint `24e0c4d7`.
The implementation, played cases and measured tradeoffs are documented here
and in the linked benchmark report. A designed case is not a passed test. The earlier [inventory](reviews/2026-10-05-balanced-siege-attributes.md)
records all existing siege definitions and why naval, air, hover and specialist
flank owners are outside this migration.

## Player tactics translated into policy

The official unit guides establish intended strengths and weaknesses. The
controller is an engineering interpretation of those mechanics, not a claim
that an official guide proves one optimal AI policy. Loaded game definitions
and actual engine shots take precedence over website stat snapshots.

| Unit | PvP use and implemented direction |
| --- | --- |
| [Fatboy](https://www.beyondallreason.info/unit/armfboy) | Slow area-damage support behind a screen. Preserve its heavy/assault accounting; favor useful splash clusters while keeping friendly units out of the blast area. |
| [Hound](https://www.beyondallreason.info/unit/armfido) | Mobile ranged skirmishing. Take in-range mobile targets and withdraw from closing enemies without issuing pursuit orders. |
| [Sharpshooter](https://www.beyondallreason.info/unit/armsnipe) | Fragile high-alpha precision support. Prefer useful heavy shots after range/safety checks, coordinate planned salvos, use affordable cloak, and retain turret fire during tactical withdrawal. Emergency repair retreat holds fire. |
| [Starlight](https://www.beyondallreason.info/unit/armmanni) | Long-range forward-facing beam. Wider spacing, predictive turn/acceleration allowance, committed withdrawal, and safe reorientation; no assumption of reverse driving or rearward fire. Health retreat is set to 0.65 in every migrated profile; the balanced profile previously used zero. |
| [Sheldon](https://www.beyondallreason.info/unit/cormort) | Ranged mobile fire support. Restore proactive mobile-target eligibility while preserving the original classifications and avoiding static coverage. |
| [Banisher](https://www.beyondallreason.info/unit/corban) | Strong opening missile, long reload, useful compatible AA. Loaded mount categories decide which targets it can shoot. Positioning must not erase air-target capability. |
| [Tremor](https://www.beyondallreason.info/unit/cortrem) | Sustained area bombardment across obstacles. Keep the firing position and salvo instead of restarting it every decision; prioritize known clusters and guard against friendly splash. |
| [Cleaver](https://www.beyondallreason.info/unit/legamcluster) | Cluster artillery support. Preserve forward-arc restrictions, exploit grouped targets, and prepare an exit before close combat. |
| [Medusa](https://www.beyondallreason.info/unit/legmed) | Long-range salvo rockets. Use the real damaging barrel rather than the zero-damage marking weapon for reach, damage and reload decisions. |
| [Mantis](https://www.beyondallreason.info/unit/legvcarry) | Protected drone carrier. The parent selects a safe deployment band and target; BAR's carrier gadget continues to own child production, attacks and docking. |

Research pins: BAR source `1d267c20d1`, Recoil source `92efda5e60`.
Runtime fixtures use `Beyond All Reason test-31479-433a460` and
`recoil_2026.07.04`. These are distinct provenance claims; runtime behavior is
verified against its loaded definitions, not inferred from matching dates.

## Scope and controls

Only the new `ranged` attribute admits a unit. It is appended without removing
roles or existing attributes. Target presets are `precision`, `skirmish`,
`bombardment`, and `carrier`; they are settings, not four more attribute bits.
Production weights, economy and the existing non-enrolled artillery path retain
their owners. Experimental script dispatch preserves ferry, static superweapon,
amphibious, flank and factory-spam admission before ordinary ranged combat.

| JSON setting | Unit/default | Purpose |
| --- | --- | --- |
| `target_mode` | `skirmish` | Precision efficiency, area bombardment or carrier handling. |
| `range_fraction` | 0.95 | Desired fraction of compatible weapon range. |
| `spacing` | 96 elmos | Minimum requested neighboring firing-slot separation. |
| `safety_margin` | 48 elmos | Buffer outside observed ground weapon coverage. |
| `range_hysteresis` | 48 elmos | Stable movement destination tolerance. |
| `reaction_seconds` | 1 second | Added to turn and acceleration escape estimate. |
| `target_hysteresis` | 1.2 multiplier | Preference for retaining a valid current target. |
| `sensor_offset` | 160 elmos | Forward vision / rear jammer displacement. |
| `cloak_on_reload` | false | Maintain affordable cloak intent; game controls actual recloak. |
| `cloak_reserve_seconds` | 3 seconds | Moving/stationary cloak reserve after allowing shot energy. |
| `allow_mobile`, `allow_static`, `allow_radar` | true | Explicit target-class/observation gates. |
| `advance_unknown_radar` | true; false for Starlight | Permit movement toward unidentified radar contacts independently of blind firing. Starlights wait for identification; cloaking, turreted Sharpshooters retain their approach policy. |
| `prefer_heavy` | false | Heavy preference after firing eligibility, never permission to pursue. |
| `prefer_screen` | true | Prefer positions with an existing allied combat screen. |
| `repaired_target_penalty` | 0.25 multiplier | Reduce preference after an engaged target makes negligible visible net progress over an observation window. |
| `splash_weight` | 0.5 | Weight of nearby observed enemy cost for non-precision area fire. |

Invalid enabled policies are disabled with a diagnostic. Missing `ranged`
membership leaves legacy behavior active. The observation service uses a
ten-second health window, short-lived salvo claims and frame-local snapshots.
Unknown radar dots never gain invented identities, costs, health or threat;
allowed blind shots rank below identified useful targets.

## Native and script ownership

- [CircuitDef](../src/circuit/unit/CircuitDef.h) and
  [RangedPolicy](../src/circuit/unit/RangedPolicy.h) store classification and JSON policy.
- [FactoryManager](../src/circuit/module/FactoryManager.cpp) validates policy once at load.
- [MilitaryManager](../src/circuit/module/MilitaryManager.cpp), its
  [binding](../src/circuit/script/MilitaryScript.cpp), and
  [experimental dispatch](../data/script/src/manager/military.as) admit tasks.
- [ArtilleryTask](../src/circuit/task/fighter/ArtilleryTask.cpp) retains lifecycle,
  damage retreat and task kind. It owns the opt-in
  [RangedEngagement](../src/circuit/task/fighter/RangedEngagement.cpp) component.
- [RangedWorld](../src/circuit/task/fighter/RangedWorld.cpp) shares legal contacts,
  mounted-weapon metadata, local formations, health history and shot reservations.
- [SupportTask](../src/circuit/task/fighter/SupportTask.cpp) follows safe ranged
  anchors without casting artillery into a squad. Existing squad escorts remain
  available; only surplus sensor-only staging groups are reconsidered.
- [RetreatTask](../src/circuit/task/RetreatTask.cpp) respects opted-in `ret_hold`
  when enabling cloak. Other cloaked units retain their existing behavior.

Movement uses validated firing slots and MOVE waypoints. BAR priority targeting
owns the shot independently. An ordinary ATTACK/FIGHT pursuit queue is never
the ranged controller's fallback. Static coverage is checked along each actual
path segment and rechecked as it is followed. A unit already exposed may move
monotonically away from danger. A path worker receives native snapshots; wrapper
calls and order issuance stay on the callback thread. Generation and lifetime
checks reject stale results after reassignment or destruction.

When the last objective disappears, an existing validated formation route is
retained and its static coverage is rechecked. A rear-only idle dispersal rule
was tried and rejected: Starlight bait clearance fell from nine targets to two
without improving closing-assault survival. The rejected results remain in the
benchmark record; restricting idle movement is not claimed as a final fix.

## Performance contracts

The world builds at most one contact/friendly/slot snapshot per AI frame in which
it is needed. D-221 retains fresh engine observations and the fixed-size
strategic shortlist. Friendly-ID ordering is O(F + I/64) for normal large inputs
(I is the engine ID bound), with comparison-sort fallback for small, duplicate
or out-of-bound inputs. It produces the same ascending IDs. The engine world
scan and position/definition callbacks remain; this is not a shared ally cache.

Map-sized dense spatial cells have sparse overflow and bounded allocation.
Clearing visits the preceding generation's touched cells, retaining capacity;
enumeration preserves z/x/insertion order. Queries cost intersecting occupied
bounds plus visited candidates, not universally O(1). Formation membership
retains its ordered ID map and O(log U) updates. History, claims and escort
bookkeeping retain their original ownership and costs.

Pure existence checks stop at the first decisive result. Static path safety
uses only static hazards and conservative bounds, retaining the exact segment
predicate. Sign-only danger tests short-circuit nonnegative finite costs and
fall back to the numeric ordered sum for exceptional values. Scored sums,
target ties, RNG draws, firing positions and response cadence are unchanged.
Coarse splash-density totals are built once, then queried by bounded weapon
footprint instead of doing a nested enemy scan for each shooter.

Unchanged live movement and targeting intent are retained. Missing queues and
lost BAR priority targets are repaired; threat response has no APM ceiling.
Optional `CIRCUIT_PERF_PHASES` phases separate shared snapshots, decisions and
escort work. `CIRCUIT_RANGED_TRACE` adds detailed diagnostics only when requested.
Detailed trace and expensive `CIRCUIT_VERIFY_RANGED_QUERIES` /
`CIRCUIT_VERIFY_RANGED_SNAPSHOT` oracles remain off for timing. Opt-in phase
timing may be enabled for attribution and must be recorded in the run pins.
After D-221 adds snapshot children, compare the inclusive snapshot parent
across builds; its exclusive residual is not a total-cost comparison. See
[maintenance contracts](performance/engineering-guide.md) and the
[D-221 implementation/evidence report](reviews/2026-10-06-extra-high-performance-remediation.md).

## Reproducible tests

[The runner](../tools/playtest/ranged_arena.py) stages pinned DLL/data into unique
directories and supplies both armies. Friendly combat orders remain AI-owned.
Economic builders/factories are frozen in staged scripts; enemy movement and
optional repair are declared fixture behavior. Legacy profile admission smokes exercise their native economy for one minute; staged experimental builder hooks do not freeze legacy economy. Spawn sites are checked against
loaded movement/build footprints and nearby terrain height. Radar and vision
come from real units; global LOS is not granted to the AI.

[The benchmark runner](../tools/playtest/ranged_benchmark.py) runs cases serially
and records damage (explicitly including overkill), deaths, metal destroyed,
mounted-barrel reload events, sampled spacing, command count and engine AI timing windows.
It refuses to overwrite a changed measurement. Screenshots and original failed
trials remain in each immutable game directory.

```powershell
python tools/playtest/ranged_benchmark.py --cases ranged-armsnipe ranged-armmanni --dll <candidate-DLL>
python tools/playtest/ranged_benchmark.py --cases ranged-armsnipe-repaired-bait --variant baseline --dll <baseline-DLL> --data <baseline-data>
python tools/playtest/ranged_benchmark.py --cases ranged-armsnipe-repaired-bait --variant siege --dll <baseline-DLL> --data <baseline-data>
```

Cases live under [shared/combat](../tools/playtest/cases/shared/combat/).
The ten per-unit smoke cases establish real firing and survival. Repaired bait,
closing assault, mixed sensors, Banisher AA, friendly splash and 120-unit load
cases test deeper contracts. Baseline, two-list siege proposal and candidate
must use identical scenario, game, engine, seed and observer for comparisons.
Smoke success alone does not establish PvP superiority or absence of FPS drops.

## Development findings retained for review

The first sniper candidate held position because its 32-elmo path-query radius
truncated to zero coarse cells. The corrected call uses at least one full path
cell and validates an exact final slot. Earlier smoke evidence also exposed
invalid hilltop spawns, a benchmark parser matching diagnostic text as events,
auto-fire bypassing policy selection, and canceled formation moves after the
last target died. These failures are preserved, not replaced with successful
run claims. Final acceptance and comparative measurements will be recorded in
the benchmark report after the corrected matrix completes.

## Regression fixes discovered in simulation

- Unrelated allied destruction broadcasts `ForgetUnit` to every task. Clearing
  an artillery component unconditionally left a live Medusa on the legacy path
  without a travel action. Cleanup now checks membership. The crash is retained
  with symbols, and the foreign-constructor-death fixture exercises the repair.
- Guided Medusa rockets hit an allied radar despite engine avoidance. Local
  friendly-hull corridor checks now cover StarburstLauncher as well as direct
  shots; high-trajectory metadata is not a license to skip that check. A repeat
  exposed a hillside height exemption: guided weapons now require a clear 2-D
  corridor including splash padding, because their path can curve or descend
  when the target disappears. Medusa's case requires zero allied damage.
- Secondary radar/jammer role labels populate `enemyRole`, not `respRole`.
  Ranged escort recognition accounts for that parser contract. An explicit
  task handover detaches a live sensor staging squad before assigning support;
  the idle-assignment overload does not perform that detach.
- Sensors reserve only safe, reachable positions. A nominal forward position
  inside static coverage falls back to the firing line or a different anchor.
  Jammer positions stay behind the line. Stale legacy squad-join paths cannot
  steal a sensor back after ranged escort assignment.
- Forward-facing escape accounts for a half-turn (32768 engine angle units),
  rather than a quarter-turn. The absolute timing regression guards that
  distinction; moving away must not assume instantaneous reverse driving.
- Starlights no longer use unidentified radar dots as forward movement
  objectives. The closing fixture exposed an approach toward fast assault
  before its identity and weapon threat were known. Applying the same rule to
  Sharpshooters reduced bait clearance from nine targets to four, so their
  cloaked/turreted approach remains enabled. The separate JSON gate preserves
  permitted shots from the current position; INV-149 checks gated movement.
- Low energy is not a blocked firing corridor. The no-shot reposition test
  requires shot funding, preventing aimless movement during an energy stall.
- The benchmark reader rejects incomplete final log events, measures commands
  over the observed order window, carries forward the original watch verdict,
  and fails incomplete observations. Versioned analyses preserve prior outputs.

## Limits to the evidence

Formation reservations are desired firing positions, not an engine-level
collision formation: units may pass close together in transit. Unknown radar
contacts remain uncertain. Terrain firing tests are conservative approximations;
loaded engine aim and collision remain authoritative. Internet synchronization,
long-running multiplayer and save/load/transfer combinations need separate
validation. Do not infer a universal win-rate or FPS guarantee from supplied
combat arenas. The final [benchmark report](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/ranged-combat.md) records
pins, results, exclusions and the performance comparison.

## Configuration migration and maintenance map

The migration audit covers 77 enrolled objects in 15 active fragments.
Existing roles, attributes, production limits, response weights and unrelated
JSON content are preserved. Its byte comparison outside enrolled objects allows
Git's CRLF/LF checkout conversion; it is not a raw line-ending identity test.
Sharpshooter appends `ret_hold`; Starlight's health
fallback is 0.65. Sample data is not changed.

| Profile | Active fragments |
| --- | --- |
| Shared defaults | [behaviour.json](../data/config/behaviour.json) |
| easy | [base](../data/config/easy/behaviour.json), [Legion](../data/config/easy/behaviour_leg.json) |
| medium | [base](../data/config/medium/behaviour.json), [Legion](../data/config/medium/behaviour_leg.json) |
| hard | [base](../data/config/hard/behaviour.json), [Legion](../data/config/hard/behaviour_leg.json) |
| hard_aggressive | [base](../data/config/hard_aggressive/behaviour.json), [Legion](../data/config/hard_aggressive/behaviour_leg.json) |
| experimental_balanced | [base](../data/config/experimental_balanced/behaviour.json), [Legion](../data/config/experimental_balanced/behaviour_leg.json) |
| experimental_hard | [base](../data/config/experimental_hard/behaviour.json), [Legion](../data/config/experimental_hard/behaviour_leg.json) |
| experimental_terrible | [base](../data/config/experimental_terrible/behaviour.json), [Legion](../data/config/experimental_terrible/behaviour_leg.json) |

Supporting implementation: [attribute registration](../src/circuit/unit/CircuitDef.cpp),
[script attribute](../data/script/src/unit.as),
[geometry and spatial index](../src/circuit/terrain/RangedGeometry.h),
[task interface](../src/circuit/task/fighter/RangedEngagement.h),
[shared observation interface](../src/circuit/task/fighter/RangedWorld.h),
[profiling phases](../src/circuit/util/Performance.h),
[phase implementation](../src/circuit/util/Performance.cpp),
[build graph](../CMakeLists.txt).

Verification: [native oracle](../tests/ranged_geometry_test.cpp),
[native runner](../tools/run_native_tests.sh), [test build](../tests/CMakeLists.txt),
[profile audit](../tools/knowledge/check_ranged_profiles.py),
[audit regressions](../tools/knowledge/test_ranged_profiles.py),
[measurement regressions](../tools/playtest/test_ranged_benchmark.py),
[observer](../tools/playtest/widgets/ranged_arena.lua),
[combat checks](../tools/playtest/checks/shared/combat/ranged-arena.json),
[energy checks](../tools/playtest/checks/shared/combat/ranged-no-energy.json),
[profile checks](../tools/playtest/checks/shared/combat/ranged-profile-load.json).
The [generated test catalog](testing/README.md) indexes every scenario.

## Snapshot optimization and blast safety

Phase measurements on 120 ranged units found shared snapshots consumed
489.7 ms over four game minutes, versus 205.6 ms of exclusive decision work.
The former reader called `UpdateFriendlyUnits`, rebuilding ally wrappers and
map nodes per frame. The new [Unit API](../src/circuit/spring/SpringUnit.h)
[implementation](../src/circuit/spring/SpringUnit.cpp) reads the same legal
friendly IDs and positions into reusable buffers. IDs are sorted to preserve
legacy map iteration order, positions receive the same terrain correction,
and definition classification still uses the ally authority. An opt-in
`CIRCUIT_VERIFY_RANGED_SNAPSHOT` differential check compares the two views.
This avoids changing other roles' cache ownership or update schedule.

Armor types are cached with immutable UnitDef metadata. Objective lists are
borrowed within the callback instead of copied per decision. Neither change
alters candidate order, tie-breaking, command fields or response frequency.

Separately, the energy-storage load case exposed explosive-target danger:
known death-blast radii now constrain routes/escape and firing eligibility.
Shots wait if the target explosion would catch the shooter or a nearby ally.
This is an intentional safety behavior change, not counted as an exact CPU
optimization. A newly revealed or instantaneously spawned explosive target
may still leave no escape time; test evidence distinguishes those cases.

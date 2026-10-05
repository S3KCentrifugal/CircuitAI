# SEA migration: implementation and staged acceptance

Date: 2026-10-04. Implementation decision: D-188. Baseline source:
`3d8c66d208d7c407e6d22d7d5178049dbbe7ab39`.

The [migration plan](sea-layout-migration-plan.md) has entered implementation
and simulation. **The production default remains disabled.** Physical harbor
replacement works in the controlled Glacial Gap case, but the natural economy
comparison does not yet meet the plan's non-regression gate. A smoke-test PASS
means its stated checks passed; it is neither a victory nor rollout approval.

## Implemented scope

- SEA-only dispatch through `SeaBuild`, `SeaFactories`, `SeaEconomy` and
  `SeaLayout`. Disabled SEA retains its old delegates. TECH's exact recycling,
  AIR's production/combat policy and the shared TACTICAL constructor ladder
  have not been edited.
- Ordinary shipyards receive atomic persistent building/exit reservations.
  Geometry uses the actual ship products' footprint, draft and native movement
  areas. A straight swept corridor must be deep and clear. These reservations
  use the same native allied exclusion mechanism as AIR/TECH.
- Three initial berths and six-slot support pads are planned. Economy fills
  footprint-sized groups; support slots must lie within actual assist reach.
  An unused obstructed group is discarded and replanned; a started group stays
  fixed. Canceled, unframed berths return to an available state.
- Resource-gated T2 admission uses the rolling income window, a metal bank
  requirement and a funded yard/constructor/support package. Workforce uses
  two-resource funding, actual usage, queued recruits and local useful work.
  Two opening/recovery constructors per tier are explicit exceptions.
- Naval mex upgrades check the requesting builder's capability and terrain.
  Repeated naval fusions and converters have their own priorities; metal-map
  converter rejection remains. Native resource/defense/repair services and
  SEA seaplane objectives remain available.
- T2 fleet quotas subtract pending recruits and enqueue only the deficit,
  one unit at a time. Legion's new production path selects its actual sub and
  flagship. Legacy donation defects remain separately registered.
- A protected forward berth must save travel, remain covered, and be funded.
  Old production continues until the same-capability replacement is complete
  and has physically released a ship. The old current product drains before
  retirement; reclaim also checks storage room. One relocation runs at a time.

Native changes are new query/planning mechanisms, not hardcoded naval build
orders. `PrepareWater` initializes the existing water survey for SEA without
turning on TECH/AIR lane policy. Placement attempts are bounded. The live census
indexes berth sites/producers in O(U + C + P); forward safety scans at most 16
deduplicated candidates. Local support/funding queries still need profiling.
Concurrent games below are not CPU/FPS benchmarks.

## Defects exposed and corrected during testing

1. The first geometry version used the hover speed-mod class instead of Ship.
   It produced no yard. That failed opening remains archived, including its
   original inadequate compile-only PASS and the independent failing audit.
2. Retaining every native task-added callback crashed the script array during
   removal of inactive build-chain children. Symbolized stacks reached
   `CScriptArray::Destruct/Resize`. The SEA ledger now retains only successful
   SEA-pinned orders; framed cost comes from validated owned units. Later
   full-window games did not reproduce those crashes.
3. Support pads at 144 elmos overlapped the factory. They now start at 224,
   validate every turret's reach, and physically produce support turrets.
4. Native discretionary tasks could monopolize builders before fusion or
   relocation rules. Native creation is now deferred for those workers;
   orphaned pinned orders are resumed rather than multiplying queues.
5. SEA had never initialized `WaterBody`, and friendly naval threat weights
   are intentionally zero in these profiles. Harbor safety now initializes
   the survey and uses completed naval combat-role value for friendly cover.
6. A safety interruption could leave the unchanged site's stability clock at
   -1 forever. The clock restarts after interruption.
7. A canceled claim could leave `active=true`, no unit, and reservation state
   zero. This prevented all subsequent construction. Reconciliation now
   restores that berth. Focused pure policy tests cover both this and the
   stability restart.
8. Coastal economy searches were anchored behind an inland commander start.
   Naval economy now anchors behind the first valid harbor. Cheap land rejection
   also accelerates coastal opening search without increasing its eight full
   geometry-query budget per slice.

## Physical harbor acceptance

The Glacial Gap fixture supplies six naval fusions, twelve naval advanced
converters, storage, four advanced construction subs and stationary cruiser
cover. It supplies startup liquidity once. Other teams' production is frozen.
It does **not** issue factory construction, factory production or reclaim orders.
This is lifecycle evidence, not a natural economy benchmark.

The balanced-profile `harbor-retry` run observed:

| Event | Game time |
| --- | --- |
| Replacement T1 yard completed | 3:24 |
| Its product passed the 480-elmo exit boundary | 4:20 |
| Original T1 yard entered retirement | 4:27 |
| Original T1 yard physically removed | 4:38 |
| Replacement T2 yard product passed its exit | 7:11 |
| Original T2 yard entered retirement | 11:11 |

The subsequent `harbor-observed` run loaded `experimental_terrible` and passed
20 minutes with an independent Lua observer. It connected a real produced ship
to its replacement factory, observed departure beyond 480 elmos, then observed
the original factory receive RECLAIM while no product remained inside. Removal
followed that reclaim. It also passed named-state adoption and an actual spawned
building obstructing an unused reserved berth. Named-state reinitialization is
not an engine save/load test.

## Natural benchmark interpretation

The initial pinned Glacial baseline reached T2 at 13:22 and naval fusion at
17:02. An intermediate `migration-support` candidate reached them at 10:27
and 15:31. Its 35-minute window differs from the baseline's 30 minutes; do not
claim a distributional improvement from those single runs or compare their
uncensored egress counts as equal exposures.

Two paired cohorts cover Glacial Gap, Supreme Isthmus, Tundra Continents,
Serene Caldera and Erebos Lakes. The first four-map cohort used an intermediate
build; the later five-map cohort pins a newer native build and revised scripts.
Each pair uses the same configured AI seed, profile, positions and nominal
speed, with ordinary resources. Engine-wide determinism is not established.
Both teams use the selected variant, so these are system benchmarks, not a
candidate-versus-baseline win-rate tournament.

The later Glacial pair regressed: T2 was 16:29 versus 12:25, and first fusion
22:47 versus 15:54. A roughly 105-second gap after the first completed mex
preceded the second opening mex and yard. This remains an opening/task-progress
investigation; the log alone does not prove walking caused it. Erebos improved
its opening after the coastal-anchor correction, but lost its shipyard and
failed to recover naval production in that cohort. That cohort predates the
canceled-berth recovery fix. Further paired acceptance is required.

The scorecard records elimination/no-owned-unit samples explicitly. Post-loss
checkpoints are not credited as zero-resource successful economy. Egress
statistics include constructors and measure 320-elmo observer departures;
harbor retirement uses 480. Old observer versions missed some delays, and do
not provide a complete censored-product denominator. All original reports,
failed attempts, staged data and raw logs remain in their allocated directories.

## Mixed-role control

The Glacial mixed test and matching disabled-SEA control both stopped on TECH's
`INV-013` (no forward cluster after 120 seconds), at about two minutes. They
remain FAIL observations. This reproduces the issue without enabled SEA;
it does not establish full mixed-base compatibility. The selected Glacial
spots fielded SEA/TECH, not AIR, despite AIR being in the runner's role filter.
An explicit AIR/SEA placement fixture remains necessary.

## Remaining rollout gates

- Resolve the repeated opening/economic regressions and retest recovery after
  hostile destruction using the final canceled-berth fix.
- Certify broad transit routes, large hulls/subs, disconnected ponds and narrow
  turning channels. Straight swept egress is not full-route path validation.
- Complete front-reversal and replacement-loss tests, including loss after old
  retirement begins; explicit recovery from that state is still missing.
- Certify auxiliary naval factories/seaplane placement, engine save/load,
  role changes, transfer/cancellation races, and the full faction/content matrix.
- Add early reserved advanced-economy districts (current economy groups are
  allocated on demand), water-metal-map growth/zero-converter tests and explicit
  AIR/TECH/TACTICAL cooperative fixtures.
- Measure serial performance and synchronized orders. Complete the plan's
  repeated seeds, side swaps, long games and representative 8v8 matrix before
  changing the default.

These are acceptance stop points from the approved migration strategy, not
permission requests. Open findings and verification limits are registered in
[known issues](known-issues.md). Reproduction commands and storage rules are in
the [playtest guide](../tools/playtest/README.md).


## Later paired cohort: complete records

The staged candidate in this cohort includes coastal search/anchor and priority
corrections, but predates the canceled-berth retry and indexed census correction.
The final harbor fixture below tests those later corrections. Do not relabel
these natural games as measurements of the final data tree.

Times are game minutes:seconds; `not observed` is censored/missing, never zero.
The Supreme baseline stopped early because no product departure was observed
by its six-minute deadline; it is not a thirty-minute comparison.

| Map | Variant / original record | First yard | First nano | T2 yard | Fusion | Observed minutes | Check verdict / survival |
| --- | --- | --- | --- | --- | --- | --- | --- |
| glacial | [baseline](benchmarks/records/sea/economy/cohort-baseline/2026-10-04/20261004T044516Z-f7cc36d5/README.md) | 1:02 | 5:37 | 12:25 | 15:54 | 30.0 | PASS; alive at last sample |
| glacial | [candidate](benchmarks/records/sea/economy/cohort-candidate/2026-10-04/20261004T044511Z-2a6408b9/README.md) | 2:25 | 11:34 | 16:29 | 22:47 | 30.1 | PASS; alive at last sample |
| erebos | [baseline](benchmarks/records/sea/economy/cohort-baseline/2026-10-04/20261004T044827Z-59db53a9/README.md) | 1:21 | 8:24 | 15:18 | 19:53 | 30.0 | PASS; alive at last sample |
| erebos | [candidate](benchmarks/records/sea/economy/cohort-candidate/2026-10-04/20261004T044821Z-cc434d12/README.md) | 0:53 | 7:06 | not observed | not observed | 30.0 | PASS; alive at last sample |
| supreme | [baseline](benchmarks/records/sea/economy/cohort-baseline/2026-10-04/20261004T044939Z-a1a36d16/README.md) | 1:19 | 6:04 | not observed | not observed | 6.2 | FAIL; alive at last sample |
| supreme | [candidate](benchmarks/records/sea/economy/cohort-candidate/2026-10-04/20261004T045246Z-d8973c38/README.md) | 1:09 | 8:54 | not observed | not observed | 30.0 | PASS; alive at last sample |
| tundra | [baseline](benchmarks/records/sea/economy/cohort-baseline/2026-10-04/20261004T045504Z-69e87924/README.md) | 1:23 | 6:32 | not observed | not observed | 30.0 | PASS; eliminated or no owned units |
| tundra | [candidate](benchmarks/records/sea/economy/cohort-candidate/2026-10-04/20261004T045758Z-edc97564/README.md) | 1:31 | 9:45 | not observed | not observed | 30.0 | PASS; eliminated or no owned units |
| caldera | [baseline](benchmarks/records/sea/economy/cohort-baseline/2026-10-04/20261004T050335Z-a7af7e03/README.md) | 1:11 | 6:42 | not observed | not observed | 30.0 | PASS; eliminated or no owned units |
| caldera | [candidate](benchmarks/records/sea/economy/cohort-candidate/2026-10-04/20261004T050704Z-6cf93e22/README.md) | 1:04 | 9:07 | not observed | not observed | 30.1 | PASS; alive at last sample |

All five candidate games reached their thirty-minute smoke window. The cohort
itself fails because the Supreme baseline failed its egress check; the economic
non-regression gate also remains unmet independently of that check result.

## Reproducible final harbor and published build

[Final balanced harbor acceptance](benchmarks/records/sea/layout/harbor-final/2026-10-04/20261004T050037Z-b941eb88/README.md)
passes twenty minutes with the final indexed census, canceled-claim recovery,
and independent physical exit/reclaim observer. The
[terrible-profile counterpart](benchmarks/records/sea/layout/harbor-observed/2026-10-04/20261004T044800Z-a38be670/README.md)
also passes. [All published SEA records](benchmarks/index/sea.md) retain original
verdicts and hashes, including the failed opening/crash and mixed controls.

The completed stripped DLL, matching debug symbols and current data were copied
together to `C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`.
DLL SHA256: `ac71826721992d8407da872b01e3001df4de47bb2d5c2ca7cea80d660c06d006`.
DBG SHA256: `0718d7fcf62dd1eb4526669662f99de76c39728a7b74c3f12881e62f0bdc9689`.
Every published data file matches the checkout; installed-output API parity
checks 280 used members with zero findings. The live BAR installation is untouched.

Final native/AngelScript regression suites pass, including three SEA policy test
functions (funding/quota/retirement boundaries, canceled-claim recovery, stability
restart) and naval corridor geometry. Three scorecard parser tests pass.
Invariant and role-document checks have zero findings. Documentation links retain
only the eight pre-existing missing-hover links (KI-404); unit-helper validation
retains 167 existing findings (KI-481/KI-473). No new SEA checker findings were
observed. `git diff --check` passes. Full rollout gates above remain open.

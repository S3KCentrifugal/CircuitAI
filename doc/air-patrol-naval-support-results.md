# AIR patrol and naval relief results (D-194)

2026-10-04. Implementation follows the [pre-implementation plan](air-patrol-naval-support-plan.md).
Experimental AIR owns the new policy; existing SEA/TECH policy and shared
threat weights are unchanged. The final paired DLL is 7,816,377 bytes, SHA-256
`d28b4dcb6a319109509202639ac142a919bbae93669a466b5ecab4cc1cc4d450`.
It and matching debug symbols/data are published to the Recoil build-output
`install/AI/Skirmish/BARb/stable`, not the live BAR installation.

## Gameplay and meta decisions

Waiting radar planes now fly distinct triangular patrols over friendly space.
The planner favors separation and positions nearer the friendly edge, checks
all legs plus approach corridors with turn padding, and retains valid routes.
Newly revealed AA invalidates only affected assignments. The existing weighted
AA grid is useful but not sufficient: some armed ships have zero profile threat
weights. An opt-in physical weapon-envelope floor makes such coverage nonzero
for radar safety. Unknown AA remains unknown; this is not an invulnerability
guarantee. Configured full waves and the 90-second partial deadline still launch.

Torpedo aircraft are appropriate for exposed fleets, submarines and submerged
amphibious threats, particularly where an ally has lost sea control or lacks
ASW. They do not counter hovers or dry-land armies. Open-water approaches avoid
dropping torpedoes into a shoreline; strong naval AA/fighters can make support
uneconomic. These constraints follow the [BAR sea guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare)
and official [Armada](https://www.beyondallreason.info/unit/armlance),
[Cortex](https://www.beyondallreason.info/unit/cortitan), and
[Legion](https://www.beyondallreason.info/unit/legatorpbomber) unit references.

The implemented assistance target uses runtime costs:

```
shortfall = max(0, enemy combat metal - nearby friendly combat metal,
                  submerged enemy metal - friendly ASW combat metal)
wave = clamp(ceil(shortfall * 1.25 / torpedo aircraft metal cost), 2, 60)
```

No demand is created below the default 300-metal minimum. Sectors are centered
on actual observed enemy concentrations, separated by water body. Friendly
ships have a configurable 1.25-radius support allowance. An allied fleet or
completed naval factory must anchor the area. The cost multiplier is a tunable
reserve allowance, not a researched claim that one metal of aircraft always
beats one metal of ships.

Factories count completed aircraft, frames and pending orders across the role.
Base emergencies, immediate interception and mandatory recovery retain priority.
The wave launches when full, or 90 seconds after its first available aircraft
if incomplete. It still needs a current target and acceptable open-water route.
Available fighters escort ahead through the existing ownership ledger; fighters
committed to another offensive wave are preserved. Defensive survivors return
when their support objective is resolved.

## Observed acceptance and corrections

* Three radar planes held distinct airborne patrols and launched at the exact
  90-second waiting deadline. A full twenty-plane cohort launched before its
  deadline. The tested waiting patrol footprint spanned roughly 6,800 by 5,900
  elmos. Patrol spacing is coverage allocation, not proof of optimal packing.
* Revealed AA moved the affected radar plane without reissuing all safe patrols.
  The explicit cruiser test observed weighted threat zero, physical threat one,
  escape beyond 1,500 elmos, and all eight planes alive at timed release.
* Armada and Legion factory-production cases built torpedo aircraft through the
  real production controller. Eleven available aircraft launched at the timeout;
  tests observed torpedo damage and six destroyer kills. Cortex's two-aircraft
  stalled-production case also launched at the timeout and dealt real damage.
* The submarine test requested support despite a larger friendly surface fleet
  without ASW. Eleven torpedo bombers killed six submarines. Heavy naval AA held
  the wave; hover, remote unsupported fleet and separate-water-body controls
  created no naval relief.
* The original parity case failed: overlapping arbitrary circle centers cut an
  eight-destroyer ally into a misleading two-ship subtotal. A friendly halo
  alone also failed. Enemy-centered sector accounting passed the repeated
  stronger-friendly-fleet control without recruitment or launch.
* Glacial supplied combat exposed an unintended spectator-team commander at
  `(64,64)`. Base defense correctly interrupted torpedo support. An initial
  diagnosis blaming ship classification was wrong; its classification changes,
  bindings and INV-143 were removed. The fixture now allies that spectator team.
  Original interrupted sorties and compile failures are preserved below.
  In the corrected final Glacial fixture, a single 17-aircraft sortie destroyed
  all six destroyers and returned all 17 bombers. Peak observed AIR orders were
  568/minute. The final heavy-AA repeat held its reserve and logged the blocked
  approach while preserving the timer.
* The existing bomber-commitment scenario retained all 24 offensive escorts
  during a real home incursion. A 20-minute AIR/SEA Supreme game completed
  without script/invariant errors. That natural smoke used an earlier D-194
  revision and did not produce a naval-relief wave; it is integration evidence,
  not a naval win-rate or economy-improvement benchmark.

The first AA-relocation run has a historical PASS under weak checks but lost
one radar plane. Treat it as a semantic failure. Its stronger repeated checks
require an actual escape and forbid death before escape. The first heavy-AA
fixture mistakenly used Brimstones (light AA); its failed blocking expectation
does not establish failure against actual heavy AA. The replacement uses eight
Dragonslayers. Early dry-shore factory fixtures and missing temporary bindings
also retain their original FAIL verdicts.

## Performance and checks

The controller uses the engine's normal AI update/task loop. Existing single
point `AirThreat` remains O(1). Corridor rasterization scales with corridor
length times width, not a diagonal bounding rectangle; the large diagonal unit
test inspected 4,090 cells. Physical AA facts are cached once per second.
Naval facts refresh every five seconds with O(N log N) deterministic ID sorting;
script accumulation touches at most 25 local sectors per friendly unit and nine
per enemy. Radar reallocation uses a 14x14 lattice, capped at 20x20; candidate
ranking can be quadratic in that bounded candidate count. Safe assignments
avoid reallocation. There is no artificial command rate limiter.

Observed team-0 AIR command counts are reported per run below. These count
unit command callbacks, including engine/game effects, not network bytes or
human UI group clicks. They do not prove zero FPS impact. Stable patrols and
shared attack tasks avoid repeated orders for unchanged routes/targets.

The complete native/pure suite passed; final AIR helpers pass 145 tests. The
script API checker verifies 295 manager/global members with no findings.
All three experimental profiles were compiled in actual engine games. Invariant
and role-document checks pass. Existing unrelated documentation links
to the absent `roles/hover.md` remain a known repository issue (KI-404).

## Limits

Supplied opponents hold their positions; these cases test behavior and firing,
not adaptation to a human fleet's maneuvers or sustained economic affordability.
No multi-AIR budget election, mixed-donation exact metal accounting, calibrated
zero-weight AA damage model or broad multiplayer FPS benchmark is claimed
([KI-495](known-issues.md#ki-495---naval-air-relief-does-not-coordinate-budgets-between-multiple-air-players)).
Inherited formation failure on pathological coincident/tiny starts remains
[KI-496](known-issues.md#ki-496---recon-formation-planning-still-assumes-separable-alliedenemy-starts).
Save/load, manual takeover during a new sortie, and moving shoreline targets
have not been certified by this test set.

## Immutable run ledger

Generated entries below preserve each original report/check verdict and add a
separate post-run analysis. Raw logs/replays remain in the local paths recorded
by each result; hashes, fixture overrides, screenshots and selected observations
are stored in the existing benchmark hierarchy.

<!-- D194_LEDGER -->

| Scenario / map | Original verdict | Launch | Damage / naval kills | Peak AIR orders/min | Evidence |
| --- | --- | --- | --- | --- | --- |
| an-partial-armada / supreme | PASS | 151s: 3 formed=3 spacing=1275 reason=deadline | 0 / 0 | 36 | [20261004T201951Z-e5615c77](benchmarks/records/air/combat/an-partial-armada/2026-10-04/20261004T201951Z-e5615c77/README.md) |
| an-naval-armada / supreme | FAIL | none | 0 / 0 | 399 | [20261004T202106Z-7536724b](benchmarks/records/air/combat/an-naval-armada/2026-10-04/20261004T202106Z-7536724b/README.md) |
| an-patrol-armada / supreme | PASS | 242s: 7 formed=7 spacing=1275 reason=deadline | 0 / 0 | 106 | [20261004T202121Z-10a9eccc](benchmarks/records/air/combat/an-patrol-armada/2026-10-04/20261004T202121Z-10a9eccc/README.md) |
| an-naval-armada / supreme | PASS | 161s: 11 wanted=14 | 23151 / 6 | 399 | [20261004T202511Z-e750ca14](benchmarks/records/air/combat/an-naval-armada/2026-10-04/20261004T202511Z-e750ca14/README.md) |
| an-patrol-armada / supreme | PASS | 241s: 8 formed=8 spacing=1275 reason=deadline | 0 / 0 | 114 | [20261004T202527Z-21c78fa2](benchmarks/records/air/combat/an-patrol-armada/2026-10-04/20261004T202527Z-21c78fa2/README.md) |
| an-stall-cortex / supreme | PASS | 151s: 2 wanted=14 | 26524 / 6 | 272 | [20261004T202857Z-9621ef7a](benchmarks/records/air/combat/an-stall-cortex/2026-10-04/20261004T202857Z-9621ef7a/README.md) |
| an-aa-legion / supreme | PASS | 61s: 13 wanted=13 | 26673 / 6 | 360 | [20261004T202913Z-332334a9](benchmarks/records/air/combat/an-aa-legion/2026-10-04/20261004T202913Z-332334a9/README.md) |
| an-parity-armada / supreme | FAIL | 61s: 11 wanted=11 | 23241 / 6 | 306 | [20261004T203138Z-c6627e7c](benchmarks/records/air/combat/an-parity-armada/2026-10-04/20261004T203138Z-c6627e7c/README.md) |
| an-sub-armada / supreme | PASS | 61s: 11 wanted=11 | 6840 / 6 | 315 | [20261004T203151Z-3ff765f9](benchmarks/records/air/combat/an-sub-armada/2026-10-04/20261004T203151Z-3ff765f9/README.md) |
| an-full-armada / supreme | PASS | 99s: 20 formed=20 spacing=1275 reason=full | 0 / 0 | 317 | [20261004T203600Z-2d4c08d8](benchmarks/records/air/combat/an-full-armada/2026-10-04/20261004T203600Z-2d4c08d8/README.md) |
| an-hover-armada / supreme | PASS | none | 0 / 0 | 272 | [20261004T203616Z-ff850415](benchmarks/records/air/combat/an-hover-armada/2026-10-04/20261004T203616Z-ff850415/README.md) |
| an-basin-armada / supreme | PASS | none | 0 / 0 | 272 | [20261004T203917Z-82153f66](benchmarks/records/air/combat/an-basin-armada/2026-10-04/20261004T203917Z-82153f66/README.md) |
| an-danger-armada / supreme | FAIL | 151s: 20 wanted=30 | 39499 / 6 | 338 | [20261004T203933Z-31f4b961](benchmarks/records/air/combat/an-danger-armada/2026-10-04/20261004T203933Z-31f4b961/README.md) |
| an-zero-armada / supreme | PASS | 241s: 8 formed=8 spacing=1275 reason=deadline | 0 / 0 | 102 | [20261004T204703Z-3ed8bd78](benchmarks/records/air/combat/an-zero-armada/2026-10-04/20261004T204703Z-3ed8bd78/README.md) |
| an-danger-armada / supreme | PASS | none | 0 / 0 | 272 | [20261004T204803Z-1ccbd873](benchmarks/records/air/combat/an-danger-armada/2026-10-04/20261004T204803Z-1ccbd873/README.md) |
| an-naval-legion / supreme | PASS | 161s: 11 wanted=12 | 23446 / 6 | 622 | [20261004T204817Z-633871ec](benchmarks/records/air/combat/an-naval-legion/2026-10-04/20261004T204817Z-633871ec/README.md) |
| naval-natural / supreme | PASS | none | 0 / 0 | 440 | [20261004T205254Z-b0090b40](benchmarks/records/air/combat/naval-natural/2026-10-04/20261004T205254Z-b0090b40/README.md) |
| base-response-commitment / supreme-isthmus-v1-7 | PASS | none | 0 / 0 | 1287 | [20261004T205154Z-ffa1adfe](benchmarks/records/air/combat/base-response-commitment/2026-10-04/20261004T205154Z-ffa1adfe/README.md) |
| naval-factory-armada / glacial | FAIL | 61s: 17 wanted=17; 86s: 11 wanted=11; additional launches | 14658 / 3 | 1289 | [20261004T205317Z-bb267b0c](benchmarks/records/air/combat/naval-factory-armada/2026-10-04/20261004T205317Z-bb267b0c/README.md) |
| recon-zero-armada / supreme | PASS | 241s: 8 formed=8 spacing=1275 reason=deadline | 0 / 0 | 103 | [20261004T205901Z-2112d7cc](benchmarks/records/air/combat/recon-zero-armada/2026-10-04/20261004T205901Z-2112d7cc/README.md) |
| naval-factory-armada / glacial | PASS | 61s: 17 wanted=17; 86s: 9 wanted=9; additional launches | 18828 / 5 | 964 | [20261004T205938Z-9e70d26b](benchmarks/records/air/combat/naval-factory-armada/2026-10-04/20261004T205938Z-9e70d26b/README.md) |
| naval-remote-armada / supreme | PASS | none | 0 / 0 | 272 | [20261004T210209Z-4a89d097](benchmarks/records/air/combat/naval-remote-armada/2026-10-04/20261004T210209Z-4a89d097/README.md) |
| naval-stall-cortex / supreme | PASS | 151s: 2 wanted=14 | 24056 / 6 | 272 | [20261004T210224Z-1d2bd43c](benchmarks/records/air/combat/naval-stall-cortex/2026-10-04/20261004T210224Z-1d2bd43c/README.md) |
| naval-parity-armada / supreme | FAIL | none | 0 / 0 | 40 | [20261004T210547Z-fd6000df](benchmarks/records/air/combat/naval-parity-armada/2026-10-04/20261004T210547Z-fd6000df/README.md) |
| naval-factory-armada / glacial | FAIL | none | 0 / 0 | 40 | [20261004T210556Z-1f39b8d6](benchmarks/records/air/combat/naval-factory-armada/2026-10-04/20261004T210556Z-1f39b8d6/README.md) |
| naval-parity-armada / supreme | FAIL | 61s: 14 wanted=14 | 23013 / 6 | 647 | [20261004T211112Z-69148673](benchmarks/records/air/combat/naval-parity-armada/2026-10-04/20261004T211112Z-69148673/README.md) |
| naval-factory-armada / glacial | PASS | 61s: 17 wanted=17; 86s: 17 wanted=17; additional launches | 20518 / 5 | 1095 | [20261004T211122Z-0758aa63](benchmarks/records/air/combat/naval-factory-armada/2026-10-04/20261004T211122Z-0758aa63/README.md) |
| naval-sub-armada / supreme | PASS | 61s: 11 wanted=11 | 6791 / 6 | 481 | [20261004T211218Z-60ddb7c7](benchmarks/records/air/combat/naval-sub-armada/2026-10-04/20261004T211218Z-60ddb7c7/README.md) |
| base-response-commitment / supreme-isthmus-v1-7 | PASS | none | 0 / 0 | 1185 | [20261004T211241Z-0e094273](benchmarks/records/air/combat/base-response-commitment/2026-10-04/20261004T211241Z-0e094273/README.md) |
| naval-parity-armada / supreme | PASS | none | 0 / 0 | 272 | [20261004T211346Z-d402ce3c](benchmarks/records/air/combat/naval-parity-armada/2026-10-04/20261004T211346Z-d402ce3c/README.md) |
| naval-naval-legion / supreme | PASS | 161s: 11 wanted=12 | 23465 / 6 | 611 | [20261004T211405Z-b6982c5d](benchmarks/records/air/combat/naval-naval-legion/2026-10-04/20261004T211405Z-b6982c5d/README.md) |
| naval-factory-armada / glacial | PASS | 61s: 17 wanted=17; 86s: 17 wanted=17; additional launches | 18447 / 4 | 882 | [20261004T211613Z-bcb3cafc](benchmarks/records/air/combat/naval-factory-armada/2026-10-04/20261004T211613Z-bcb3cafc/README.md) |
| naval-factory-armada / glacial | PASS | 61s: 17 wanted=17 | 22850 / 6 | 568 | [20261004T212029Z-25367a17](benchmarks/records/air/combat/naval-factory-armada/2026-10-04/20261004T212029Z-25367a17/README.md) |
| naval-danger-armada / supreme | PASS | none | 0 / 0 | 272 | [20261004T212412Z-8f045adf](benchmarks/records/air/combat/naval-danger-armada/2026-10-04/20261004T212412Z-8f045adf/README.md) |

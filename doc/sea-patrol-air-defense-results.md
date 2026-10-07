# D-202: Supreme naval patrol and AA verification

Baseline: `f353f926`. Candidate DLL SHA-256:
`9af405acf9a6180b3d060f9431f8531f1259a61247532b621e7b96cba29cc997`.
Engine `recoil_2026.07.04`, game `Beyond All Reason test-31479-433a460`,
map **Supreme Isthmus v1.7**, combat seed 1891. Every game has an isolated
write directory and pinned staged script hashes. The live installation was
not modified. [Design/settings](sea-patrol-air-defense.md).

## Behavior

- T1 scouts lease different navigable water sectors and run persistent patrols.
- Aircraft presence interrupts available AA ships in that sea, including
  unarmed aircraft and coastal flanks. Repair retreat and player/carrier
  ownership remain protected.
- A stable grid supplies rows/columns of separate water destinations. AA
  priority fire leaves movement queues intact; lost targets clear immediately.
- Patrol danger uses surface and underwater threat. Interception admits the
  aircraft being countered while excluding known naval/submarine weapon reach.
- After the contact and its movement memory expire, scouts resume coverage.
  Other roles retain their previous control paths.

## Controlled patrol comparison

Same supplied twelve Herrings, same map/start/faction/profile/seed; no enemy air.
These are physical engine observations rather than just intended destinations.

| Metric | Baseline | Final candidate |
| --- | ---: | ---: |
| Ships with a patrol queue at 90 seconds | 0/12 | 12/12 |
| Physical occupied bounding box at 90 seconds | 81 × 93 elmos | 1,711 × 2,087 elmos |
| Mean nearest-ship separation at 90 seconds | 22.4 elmos | 488.0 elmos |
| Minimum nearest-ship separation at 90 seconds | 8.0 elmos | 354.1 elmos |
| Team engine orders, minute 1 | 4,398 | 146 |
| Team engine orders, minute 2 | 5,441 | 1 |

The candidate's one minute-two order belongs to the frozen commander; the
Herrings retained their patrol queues. Minute-one orders fell 96.7%. This is
a behavior/control change with fewer redundant orders, not a measured FPS or
network-packet improvement. Shared native AA outside this SEA path remains
[KI-502](known-issues.md#ki-502---native-idle-aa-can-repeatedly-replace-identical-fight-orders).

## Final Supreme fixtures

Every final supplied-force case ran for six game minutes. Aircraft arrive at
about 100 seconds. Formation activation occurred within one game second of
arrival in each air case; movement and weapon engagement take additional time.
Aircraft kills below precede the fixture's administrative cleanup at 210 seconds.
Friendly losses include all tracked assets, including the radar: they are not
counts of destroyed AA ships alone. Losses show why responding correctly is not
the same as making cheap scout boats invulnerable to gunships.

| Case / original report | AA responders | Enemy aircraft killed | Friendly tracked losses | Peak team orders / game minute |
| --- | ---: | ---: | ---: | ---: |
| [12 Herrings, no aircraft](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-patrol-cand/2026-10-05/20261005T142552Z-707441e8/report.md) | 0 | 0 | 0 | 146 |
| [12 Herrings vs 6 gunships](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-aa-screen-cand/2026-10-05/20261005T142104Z-77715674/report.md) | 12 | 6 | 7 | 146 |
| [12 Herrings vs 8 flanking bombers](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-aa-flank-cand/2026-10-05/20261005T142415Z-effde436/report.md) | 12 | 8 | 0 | 150 |
| [12 Herrings vs 8 unarmed transports](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-aa-unarmed-cand/2026-10-05/20261005T142239Z-4c01ddbc/report.md) | 12 | 8 | 0 | 150 |
| [12 Skaters + 6 AA ships vs 6 gunships](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/armada-aa-screen-cand/2026-10-05/20261005T143115Z-2898e997/report.md) | 18 | 6 | 3 | 323 |
| [12 scouts + 6 Iapetus vs 6 gunships](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/legion-aa-screen-cand/2026-10-05/20261005T141927Z-e769f91c/report.md) | 6 | 6 | 9 | 244 |

All six final cases passed their original checks. Cortex used
`experimental_hard`, Armada `experimental_balanced`, and Legion
`experimental_terrible`. Legion's six Iapetus were the AA responders; its
twelve Hippocampus scouts retained independent scouting. The AA fixtures
record actual weapon damage and patrol resumption, not only script intent.

[Final patrol screenshot](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-patrol-cand/2026-10-05/20261005T142552Z-707441e8/screen_2026-10-05_14-25-12-750.png): twelve boats occupy separate patrol sectors.

![Herrings spread across their individual Supreme patrols](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/benchmarks/records/sea/combat/herring-patrol-cand/2026-10-05/20261005T142552Z-707441e8/screen_2026-10-05_14-25-12-750.png)

[Final flank screenshot](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-aa-flank-cand/2026-10-05/20261005T142415Z-effde436/screen_2026-10-05_14-23-41-935.png): separate movement destinations and overlapping AA ranges. Physical ships are still maneuvering; queued flags are not counted as physical separation.

![Separated Herring interception destinations with overlapping AA ranges](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/benchmarks/records/sea/combat/herring-aa-flank-cand/2026-10-05/20261005T142415Z-effde436/screen_2026-10-05_14-23-41-935.png)

## Ordinary economy game

[The normal-resource, two-SEA Supreme game](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/patrol-aa-screen/2026-10-05/20261005T142839Z-b06f2c20/report.md) reached frame 36,000
(20 game minutes) and passed its checks. Factory production and economy
construction continued alongside independent patrols. This used ordinary
construction rather than the frozen supplied-force arena. The observed Cortex
opening completed its first yard around 1.5 minutes and its first constructor
left the yard around 2.2 minutes. At the ten-minute screenshot it had about
+37.7 metal, +453.7 energy and 59 units. This is compatibility evidence, not a
new best economy benchmark.

![Ordinary Supreme SEA economy and fleet at ten minutes](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/benchmarks/records/sea/economy/patrol-aa-screen/2026-10-05/20261005T142839Z-b06f2c20/screen_2026-10-05_14-27-37-974.png)

## Preserved observations

The following immutable bundles preserve original checks, reports, input pins,
analysis and verdicts. `d202-review.json` distinguishes final evidence from a
superseded iteration. The scenario suffix `cand` is historical runner naming;
baseline/candidate identity comes from pinned inputs and the review record.

| Observation | Review |
| --- | --- |
| [baseline-run-2](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-patrol-cand/2026-10-05/20261005T134917Z-abee872f/report.md) | Original dry/beach spawn fixture failure; not an AI verdict. |
| [baseline-run-3](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-patrol-cand/2026-10-05/20261005T135131Z-9073e245/report.md) | Valid f353f926 baseline: reproduced clumping, original patrol FAIL retained. |
| [patrol-candidate-1](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-patrol-cand/2026-10-05/20261005T135732Z-2d830663/report.md) | First patrol prototype; superseded by final route refinements. |
| [aa-direct-1](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-aa-screen-cand/2026-10-05/20261005T135920Z-7957d909/report.md) | Direct-attack prototype; superseded. |
| [aa-flank-1](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-aa-flank-cand/2026-10-05/20261005T140306Z-b35bba27/report.md) | Flank prototype; superseded. |
| [aa-armada-1](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/armada-aa-screen-cand/2026-10-05/20261005T140538Z-849a5aab/report.md) | Armada prototype; superseded. |
| [aa-legion-1](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/legion-aa-screen-cand/2026-10-05/20261005T140806Z-065eb839/report.md) | Original broad check PASS rejected by detailed review: wrong hull ownership. |
| [aa-legion-2](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/legion-aa-screen-cand/2026-10-05/20261005T141255Z-d6326ed1/report.md) | Correct AA ownership, incomplete air engagement; superseded. |
| [12 Herrings, no aircraft](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-patrol-cand/2026-10-05/20261005T142552Z-707441e8/report.md) | Final PASS; see measured limits above. |
| [12 Herrings vs 6 gunships](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-aa-screen-cand/2026-10-05/20261005T142104Z-77715674/report.md) | Final PASS; see measured limits above. |
| [12 Herrings vs 8 flanking bombers](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-aa-flank-cand/2026-10-05/20261005T142415Z-effde436/report.md) | Final PASS; see measured limits above. |
| [12 Herrings vs 8 unarmed transports](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/herring-aa-unarmed-cand/2026-10-05/20261005T142239Z-4c01ddbc/report.md) | Final PASS; see measured limits above. |
| [12 Skaters + 6 AA ships vs 6 gunships](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/armada-aa-screen-cand/2026-10-05/20261005T143115Z-2898e997/report.md) | Final PASS; see measured limits above. |
| [12 scouts + 6 Iapetus vs 6 gunships](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/combat/legion-aa-screen-cand/2026-10-05/20261005T141927Z-e769f91c/report.md) | Final PASS; see measured limits above. |
| [Ordinary 20-minute game](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/patrol-aa-screen/2026-10-05/20261005T142839Z-b06f2c20/report.md) | Final PASS; see measured limits above. |

The [SEA benchmark index](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/index/sea.md) and [test inventory](testing/index/sea.md) include these cases without moving or overwriting older evidence.

## Implementation examples

Before, the hybrid response recognized Armada alone and switched it into the
native group-merging AA task; Cortex's AA-only profile excluded it from scout
operations altogether:

```cpp
return def.GetName() == "armpt" && def.HasSurfToAir();
// Later: Enqueue(TaskF::Common(Task::FightType::AA))
```

Now role-scoped script owns independent destinations and delegates movement and
priority fire to native mechanisms:

```cpp
if (!alarm) { Patrol(b, u); continue; }
// Choose a distinct reachable slot on the shared per-sea formation grid.
Order(b, u, points, false);              // MOVE, without chase-to-target
b.route.SetSeaTarget(FireTarget(b, u));  // fire priority, preserves the route
```

Performance decisions and invalidation rules are commented beside the code:
the water grid is built once, sector leases and formation slots persist,
candidate danger is shared only within one census, and priority commands are
sent only when the target changes. There is no blanket APM rate limit.

## Validation and limits

The native integration build and 12 standalone native executables passed;
372 embedded-VM test functions passed, including the new slot/overlap and
interception boundaries. API, role-document and invariant checks passed.
All three experimental profiles are exercised through faction combat fixtures.
The test inventory generator's three tests passed. Documentation still has
the existing eight missing-hover-reference failures; unit-helper validation
still reports the existing 167 findings. Neither unrelated register was hidden.

Distinct target positions do not promise minimum physical separation during
path crossings or narrow passages. The controller selects one primary coastal
air threat per connected sea while individual weapons pick aircraft in reach;
simultaneous widely separated raids are not demonstrated by these fixtures.
Combat fixtures supply forces and freeze economy; they do not prove funded
production, PvP victory, or immunity to stronger air fleets. The ordinary
20-minute two-SEA game is a separate compatibility check, not an 8v8 benchmark.

Original fixture and intermediate results are retained, including the rejected
Legion prototype whose broad automated damage check passed despite assigning
the wrong hulls. Stronger final checks require Iapetus assignment and damage.
The initial beach-spawn failure is a fixture failure, not an AI verdict.

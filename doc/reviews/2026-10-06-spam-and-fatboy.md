# Fatboy deployment and T1 pressure: diagnosis, policy and evidence

Date: 2026-10-06. Decision D-216. Built, Checked and Played in isolated BAR
games; this is not an 8v8 win-rate or multiplayer performance benchmark.

## What was wrong

1. TECH retired an already-idle opening lab by aborting the factory manager's
   **shared idle task**. That cleared other idle labs from the scheduler. In
   the corrected baseline fixture the economy floated roughly 200 M/s but
   produced **zero Pawns**. The native abort API now rejects shared idle,
   nil and player states, and the retirement call sites cancel only real work.
2. Completing a normal recruit calls cancellation, which clears the factory
   queue. The older TECH workaround disabled engine repeat. Recruitment now
   has an opt-in persistent owner: completion detaches only the finished
   offspring, while cancellation disables repeat and clears its production.
   Normal recruits keep their original lifecycle. A final native guard prevents
   another factory adopting a persistent recruit during the target-null interval
   between completed offspring; one persistent task has one factory owner.
3. `spam` collides as a native role and attribute name. The JSON loader resolves
   the role first, so the old attribute-only routing test missed Pawns. Route
   eligibility now uses the explicit configured factory-product roster, cached
   once, and routes offspring by their actual producer. It does not capture
   resurrection/support units merely because they have a broad spam role.
4. Unused friendly-side map start slots could become spam destinations. Actual
   enemy lobby starts now take precedence, then enemy-box/map/roster inference.
   Terrain connectivity checks repair cliff/water endpoints with nearby reachable
   ground. Each factory owns a separate lane to enemy backline terrain.
5. TECH had separate gates and counts for building and operating spam labs.
   Shared economic admission now reaches its reserved forward factory clusters
   after an advanced lab exists. Existing construction, including walking to a
   reserved site before a frame exists, is preserved. The general forward
   constructor path uses the same budget. Reclaim/rebuild timing is unchanged.
6. The construction regression exposed another retirement path: rear-base
   rezoning sent STOP without cancelling its recruit. An idle event restarted
   production after retirement. `ReclaimBaseFactory` now ends that task first;
   the existing three-factory reclaim threshold is unchanged.
7. Fatboy ranged control held its spawn when all normal firing-band sites were
   rejected by known static coverage. Fatboys now opt into a bounded search for
   a closer **safe staging position**, outside known weapons/death-blast discs.
   This does not claim the defense is attackable, relax retreat/path checks or
   change Sharpshooter/Starlight policy.

## PvP rationale and economic settings

The [official Fatboy description](https://www.beyondallreason.info/unit/armfboy)
describes a slow area-damage unit: it should advance behind a screen, not remain
at spawn or chase bait through static fire. The staging fallback applies that
distinction when its weapon is outranged.

The [official mechanics guide](https://www.beyondallreason.info/guide/important-knowledge-on-advanced-mechanics)
explains repeat orders and scout-swarm vulnerability to Juno. The
[player discussion of spam uses](https://www.reddit.com/r/beyondallreason/comments/1snglo0/what_is_the_best_spam_unit_in_different_scenarios/)
emphasizes vision, screening and different cheap units for different opponents.
The shared knowledge base's `knowledge/70-strategy/76-spam.md` also distinguishes
early raiding from disposable sustained pressure and notes splash/choke/energy
constraints. These sources support the purpose of spam, not a universal income
threshold. The following numbers are configurable engineering defaults.

| Condition | Default policy |
| --- | --- |
| Ordinary early raids | Remain under the role's normal combat production |
| Dedicated pressure | Last-ten-second minimum income at least **60 M/s and 1500 E/s**, no energy stall |
| Donated/full metal bank | Alternative: full metal, at least **1000 stored** and **30 M/s**; energy gate still required |
| Worker recovery | At least four native builder-manager workers before converting factories |
| Production scaling | One pump at admission, another per 100 M/s above 60, maximum six |
| Falling income | Stop repeats below 70% of the normal thresholds or immediately on the economy manager's energy-stall signal; full-bank alternative remains available |
| New land factory | Mobile non-commander builder, at least 1000 banked, valid build option and reachable enemy land |
| TECH | Its existing advanced-lab-first, turret-first reserved clusters; no mandatory +200 M/s or replacement-air-worker gate for initial spam admission |
| Other experimental roles | One dedicated land pump if absent; additional existing mapped factories can enroll within the shared budget |
| Water-confined starts | Do not produce stranded land spam; primary aircraft and naval factories stay role-owned |

Settings are in [Global::Spam](../../data/script/src/global.as), with pure
boundaries in [spam_math.as](../../data/script/src/helpers/spam_math.as).
The six experimental roles are FRONT, AIR, SEA, TECH, SUPPORT and TACTICAL.
Legacy difficulty profiles do not use this shared role controller; their normal
production remains native. Fatboy's opt-in ranged setting is present in all
eight existing Fatboy profile entries (root plus seven difficulty profiles).

## Orders and performance

Spam is plain MOVE to the enemy backline, firing opportunistically in transit.
Factories have separate lanes, and units within each lane retain formation
offsets. Reachability prevents deliberately assigning a disconnected island;
threat does not turn disposable spam into a retreating combat squad.

Repeat keeps one queued build rather than issuing a new build every tick or
every completion. Factory route versions change only when geometry changes.
The production census is once a second over enrolled pumps; stable sorting is
O(F²), with F limited to six by default. Existing offspring adoption is one
O(U) owned-unit scan per five seconds and sends no commands to units already
on their route. Roster membership is cached O(1). Endpoint repair tries at
most 64 cached connectivity lookups per rejected endpoint, during admission
or retargeting, not per unit. Fatboy staging tries at most 27 additional sites
only when the usual 17-site firing search fails, using the existing hazard and
path checks. No engine callbacks moved to worker threads and no command rate
limit was added. Small supplied games do not establish late-game FPS or peer
network behavior, so no percentage performance improvement is claimed.

## Verification

Native build and the complete engine-free native/script-policy test runner
passed. Three new economic-policy tests cover fifteen boundary checks, including
donations, energy starvation, hysteresis and lab scaling. Analyzer tests reject
repeat without production, incomplete movement, backward travel and duplicate
build entries. Script/DLL API parity and invariant checks pass.

Same-fixture three-minute TECH baseline: **0 Pawns**. Candidate: **26**, of which
**22** advanced more than 800 elmos toward the enemy on MOVE orders. All six
roles passed repeat, completed-offspring, independent-endpoint and single-build
queue checks. The income-removal scenario also confirmed repeats stop.

The Fatboy baseline left one of four hulls at spawn. The fixed hull advanced
**1736 elmos before 100 seconds**. All four fired; the candidate destroyed seven
targets with zero Fatboy losses in three minutes. A separate deployment analyzer
requires every primary hull to advance at least 500 elmos by 100 seconds; it
fails the original baseline and passes the candidate. That criterion is now
part of the reusable case and benchmark runner.

Final six-minute TECH construction tests also leave friendly builders active:
balanced produced **130 Pawns**, with **122** making the measured MOVE progress;
hard produced **140**, with **132** making that progress. Both completed without
retirement invariant violations. FRONT's construction case exercises the other
shared builder path. These fixtures supply income, workers and a T2 lab; they
do not prove a natural opening reaches the threshold at an optimal game minute.

Every row below preserves the original watcher verdict separately from the
semantic analysis. Failed iterations remain evidence: the initial hard
construction stall, then INV-001 from rear-lab retirement, were corrected and
retested. A preliminary movement analyzer counted any displacement; v2/v3
require enemy-directed progress, and v3 also requires a complete clean runtime.
The rejected exploratory case is not presented as a successful benchmark.

| Case / profile | Watch | Semantic result | Evidence |
| --- | --- | --- | --- |
| spam-repeat-tech / experimental_balanced / baseline | FAIL | FAIL (retained): 0 completed; 0 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-tech/2026-10-06/20261006T073011Z-b29ba241/README.md) |
| fatboy-hlt-front / experimental_balanced / baseline | PASS | FAIL (retained): minimum progress 0 elmos | [bundle](../benchmarks/records/shared/combat/fatboy-hlt-front/2026-10-06/20261006T064824Z-3682d89b/README.md) |
| spam-repeat-tech / experimental_balanced / ranged | PASS | PASS: 26 completed; 22 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-tech/2026-10-06/20261006T073652Z-ebb7416b/README.md) |
| fatboy-hlt-front / experimental_balanced / ranged | PASS | PASS: minimum progress 1736 elmos | [bundle](../benchmarks/records/shared/combat/fatboy-hlt-front/2026-10-06/20261006T073849Z-787bc143/README.md) |
| spam-repeat-front / experimental_balanced / ranged | PASS | PASS: 28 completed; 26 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-front/2026-10-06/20261006T073955Z-9904280c/README.md) |
| spam-repeat-air / experimental_balanced / ranged | PASS | PASS: 26 completed; 22 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-air/2026-10-06/20261006T074102Z-54e9e2c3/README.md) |
| spam-repeat-sea / experimental_balanced / ranged | PASS | PASS: 24 completed; 20 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-sea/2026-10-06/20261006T074209Z-18cf8152/README.md) |
| spam-repeat-support / experimental_balanced / ranged | PASS | PASS: 26 completed; 22 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-support/2026-10-06/20261006T074315Z-cc7f6bc7/README.md) |
| spam-repeat-tactical / experimental_balanced / ranged | PASS | PASS: 26 completed; 22 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-tactical/2026-10-06/20261006T074422Z-d7726e03/README.md) |
| spam-repeat-drain / experimental_balanced / ranged | PASS | PASS: 25 completed; 22 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-drain/2026-10-06/20261006T074848Z-5eb15d13/README.md) |
| spam-build-tech / experimental_balanced / ranged | PASS | PASS: 61 completed; 56 advanced | [bundle](../benchmarks/records/shared/combat/spam-build-tech/2026-10-06/20261006T075016Z-4bcfbef5/README.md) |
| spam-build-tech / experimental_hard / ranged | FAIL | FAIL (retained): 0 completed; 0 advanced | [bundle](../benchmarks/records/shared/combat/spam-build-tech/2026-10-06/20261006T075218Z-04b360a7/README.md) |
| spam-repeat-tech / experimental_terrible / ranged | PASS | PASS: 26 completed; 22 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-tech/2026-10-06/20261006T075324Z-f772de2a/README.md) |
| spam-build-tech / experimental_hard / ranged | FAIL | FAIL (retained): 30 completed; 22 advanced | [bundle](../benchmarks/records/shared/combat/spam-build-tech/2026-10-06/20261006T075619Z-aaffd1e0/README.md) |
| spam-build-tech / experimental_balanced / ranged | FAIL | FAIL (retained): 17 completed; 13 advanced | [bundle](../benchmarks/records/shared/combat/spam-build-tech/2026-10-06/20261006T075726Z-46b78da8/README.md) |
| spam-build-tech / experimental_hard / ranged | PASS | PASS: 140 completed; 132 advanced | [bundle](../benchmarks/records/shared/combat/spam-build-tech/2026-10-06/20261006T075928Z-fe86af12/README.md) |
| spam-build-tech / experimental_balanced / ranged | PASS | PASS: 130 completed; 122 advanced | [bundle](../benchmarks/records/shared/combat/spam-build-tech/2026-10-06/20261006T080057Z-fe009c9b/README.md) |
| spam-build-front / experimental_terrible / ranged | PASS | PASS: 51 completed; 50 advanced | [bundle](../benchmarks/records/shared/combat/spam-build-front/2026-10-06/20261006T080220Z-d81f446d/README.md) |
| fatboy-hlt-front / easy / ranged | PASS | PASS: minimum progress 1733 elmos | [bundle](../benchmarks/records/shared/combat/fatboy-hlt-front/2026-10-06/20261006T080325Z-bc406ee3/README.md) |
| fatboy-hlt-front / medium / ranged | PASS | PASS: minimum progress 1736 elmos | [bundle](../benchmarks/records/shared/combat/fatboy-hlt-front/2026-10-06/20261006T080430Z-8f560345/README.md) |
| fatboy-hlt-front / hard / ranged | PASS | PASS: minimum progress 1734 elmos | [bundle](../benchmarks/records/shared/combat/fatboy-hlt-front/2026-10-06/20261006T080535Z-796feafb/README.md) |
| fatboy-hlt-front / hard_aggressive / ranged | PASS | PASS: minimum progress 1736 elmos | [bundle](../benchmarks/records/shared/combat/fatboy-hlt-front/2026-10-06/20261006T080641Z-1430788a/README.md) |
| spam-repeat-dense / experimental_balanced / ranged | PASS | PASS: 28 completed; 26 advanced | [bundle](../benchmarks/records/shared/combat/spam-repeat-dense/2026-10-06/20261006T081325Z-e1d62919/README.md) |
| spam-build-tech / experimental_balanced / ranged | PASS | PASS: 134 completed; 126 advanced | [bundle](../benchmarks/records/shared/combat/spam-build-tech/2026-10-06/20261006T081453Z-66b86353/README.md) |

## Reproduction and limits

Cases/checks are categorized under `tools/playtest/{cases,checks}/shared/combat/`.
The [test index](../testing/index/shared.md) lists them. Run, for example:

```text
python tools/playtest/ranged_benchmark.py --cases spam-repeat-tech spam-repeat-air --dll <pinned DLL> --minutes 3 --speed 8
python tools/playtest/ranged_benchmark.py --cases spam-build-tech --dll <pinned DLL> --profile experimental_hard --minutes 6 --speed 8
python tools/playtest/ranged_benchmark.py --cases fatboy-hlt-front --dll <pinned DLL> --minutes 3 --speed 8
```

Game: BAR `test-31479-433a460`, Recoil `recoil_2026.07.04`, Glitters v2.2.3,
seed 2071. Baseline DLL SHA-256:
`9507e1c6b5eda75d3c4e7668f2eb052a3e82a672289e2dbd68b1b9337f368edb`.
Main candidate: `fff6f12b014ad65278f612f8d1ffbd8de35000690ba2c533eda36ce47cc315d3`.
Final single-owner build: `45eb0f2e89a285e336bcafdddcc550246f79619c2e747a9a73ad628b3d8b67ff`.
The profile matrix used the main candidate. The final native-only guard was
subsequently exercised by the adjacent-factory and TECH-construction runs.
Each bundle pins its actual staged scripts and observer separately, since
script corrections were tested without changing that native DLL.

The observer issues no friendly production/combat orders. Construction cases
leave friendly builders active; production-only cases freeze mobile builders.
Supplied buildings bypass normal placement, so the fixture disables TECH's
layout/economy invariant Tick while retaining lifecycle and spam invariants.
This isolation is recorded in every pin manifest. Screenshots and full local
logs remain available; compact immutable bundles carry checks, hashes and
derived measurements.

Unverified broader outcomes: natural-economy timing across maps/factions,
8v8 strategic strength, save/load persistence and network APM impact. The
170 existing unit-helper findings (KI-473/KI-481) and eight links to the missing
hover role document (KI-404) remain outside this change. They are not introduced
by the spam/Fatboy work; role-document, API and invariant checks are clean.

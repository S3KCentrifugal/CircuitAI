# SEA economy-block results

2026-10-04. D191 follows the Supreme Isthmus v1.7 screenshot and the
[placement plan](sea-economy-block-plan.md). Placement acceptance passes on
Supreme. Natural economy results are mixed; this is not a claim of improved
competitive strength or a general SEA rollout approval.

## What changed

SEA's default-on `CompactEconomy` now routes naval converters, tidals, fusions
and construction turrets through the layout owner even when the broader
`ExperimentalBuild` migration is off. The latter remains default off.
Coastal land construction, mex expansion, native production and combat retain
their ordinary decision paths. AIR and TECH policy are unchanged by D191.

The new economy block reserves a touching 4x4 turret grid and rear fusion
before filling dense converter sets. The fusion's whole footprint must stay
at least 64 elmos behind its harbor on the enemy-facing axis. The economy
envelope sits outside the factory support disc. Factory turrets must actually
reach their shipyard or amphibious factory; economy turrets serve the fusion.
T1 ships prepare the first two fusion turrets because T2 construction subs
cannot build those turrets. Additional support requires funded useful work.

Cheap completed T1 naval converters survive the T2 transition. Native
converter-tier reclaim is disabled only while this SEA placement owner is
enabled and its previous value is restored on role exit. Existing buildings
are not moved. Blocked unused blocks can be replanned; active blocks stay fixed.

## Physical placement and assistance

Both final supplied Supreme tests ran 12 game minutes with Armada. They use
100,000 starting metal and 1,000,000 energy, supplied factories/constructors,
two finite production waves, and requested economy demand. They exercise real
placement, construction, funding and assist tasks; they do **not** measure a
natural build order or fusion timing. Both use the same placement code with
different native/experimental builder movement settings.

| Physical check | Compact/default movement | Experimental movement |
| --- | --- | --- |
| 12 completed T1 converters in block | 5:56; 12 touching edges | 4:58; 17 touching edges |
| 8 completed advanced converters in block | 4:30; 4 touching edges | 3:44; 4 touching edges |
| Turrets assisting producing shipyard | 3:37 | 1:52 |
| Turrets assisting producing amphibious factory | 3:51 | 2:12 |
| Turrets assisting fusion construction | 3:35 | 4:02 |
| Rear fusion completed | 5:03 | 4:37 |
| Square-grid support, at least 2 rows and 2 columns | 4:50 | 3:56 |
| Completed T1 converter removals / orphan turrets | 0 / 0 | 0 / 0 |
| Unfinished T1 converter frame losses | 1 | 0 |

Original reports: [compact](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T171817Z-9ae5216e/report.md)
and [experimental](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block-exp/2026-10-04/20261004T171719Z-4a7ca5ff/report.md).
Each immutable bundle includes staged source hashes, DLL hash, inputs, checks
and screenshots. The raw log location remains in its report/publication.

![Supreme supplied layout at 11 minutes: separate factory support and rear economy block](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T171817Z-9ae5216e/screen_2026-10-04_17-18-12-180.png)

The screenshot shows the two factories above the rear economy block. Converter
footprints form touching groups around the reserved square turret grid; the
grid fills according to demand rather than purchasing all 16 turrets at once.

## Ordinary economy comparisons

Controls use the complete pre-D191 working-tree data, including prior D190
changes. Candidates use compact placement with full migration disabled.
Supreme ran two SEA teams; Glacial ran six SEA teams with mixed factions.
The scored team is Armada. All four final/control games passed startup,
opening shipyard, initial departure, script and invariant checks. Those checks
do not certify optimal economy, every later departure or combat strength.

| Map/build at 20 minutes | Metal/s | Energy/s | Total build power | Mexes | Turrets | Tidals | T1 naval converters |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Supreme control | 44.9 | 1,253.9 | 3,550 | 19 | 8 | 54 | 8 |
| Supreme candidate | 47.7 | 1,219.1 | 3,200 | 19 | 10 | 53 | 11 |
| Glacial control | 24.9 | 842.0 | 2,600 | 8 | 11 | 33 | 19 |
| Glacial candidate | 30.6 | 872.0 | 2,175 | 8 | 3 | 35 | 22 |

Supreme's first turret finished at 6:33 versus 6:00 in the control. At ten
minutes candidate metal/energy/build power was 36.3/590.4/1,400 versus
41.7/759.0/2,950. It caught up in mex count and factory turret count, but this
does not establish early-game non-regression. At 30 minutes the candidate had
11 turrets and 4,150 build power. Neither Supreme run reached T2 during its
observed window (25-minute control; 30-minute candidate).

Glacial candidate completed T2 at 17:34 and its first T2 constructor at 18:05;
the control did not reach T2 by 20 minutes. Candidate early growth was also
slower: at ten minutes 19.5 metal/s and 518 energy/s versus 32 and 686. Both
lost their commander later in combat. No natural run completed a naval fusion.

Observed successful-departure median/p95 seconds: Supreme control 8.1/160.9,
candidate 7.1/282.7; Glacial control 7.75/81.0, candidate 6.0/110.1. Different
unit mixes, lengths and combat trajectories prevent a causal conclusion.
The long tail and idle build power remain follow-up concerns, not fixed claims.
Self-play changes both sides; repeat fixed-opponent seeds before judging
strength. FPS/APM were not benchmarked by these acceptance cases.

Evidence: [Supreme control](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-control/2026-10-04/20261004T165401Z-cc9781a9/sea-score.json),
[Supreme candidate](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-release/2026-10-04/20261004T171713Z-8c419c58/sea-score.json),
[Glacial control](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-control/2026-10-04/20261004T170832Z-584d883a/sea-score.json),
[Glacial candidate](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-release/2026-10-04/20261004T171909Z-c1733636/sea-score.json).

## Corrections and retained failures

Earlier iterations exposed issues that the supplied placement fixture alone
could not catch: returning Wait instead of preserving native fallback stopped
mex expansion, retaining dormant native chain handles crashed, and overlapping
the factory assist disc with an economy envelope prevented turret placement.
These iterations are rejected even where their generic runtime report says
PASS. The earlier scenario names `final` and `release` are historical labels;
the final accepted run IDs are the ones linked above.

The strict earlier fixture rejected every T1 converter destruction. Its
[original FAIL](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T171420Z-dc1fa905/report.md)
is preserved: two unfinished frames disappeared before completion. The final
observer distinguishes unfinished frame loss from completed-converter removal
using UnitFinished. It still rejects any completed-converter loss in this
uncontested fixture. One unfinished loss recurred in the final compact test;
its cause is unresolved (KI-238), rather than being represented as fixed.

The complete observation inventory follows. Immutable original verdicts are
never rewritten to match the later diagnosis.

| Run/report | Scenario/map | Original verdict | Interpretation |
| --- | --- | --- | --- |
| [20261004T162552Z-9940fa19](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-compact/2026-10-04/20261004T162552Z-9940fa19/report.md) | d191-compact / supreme | FAIL | Rejected: naval task label/placement path incomplete. |
| [20261004T163046Z-af2c6ce0](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-compact/2026-10-04/20261004T163046Z-af2c6ce0/report.md) | d191-compact / supreme | FAIL | Rejected: dormant-chain handle crash at 19:18. |
| [20261004T163729Z-6eda5a58](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-compact/2026-10-04/20261004T163729Z-6eda5a58/report.md) | d191-compact / supreme | PASS | Rejected despite runtime PASS: tidal/expansion regression. |
| [20261004T164006Z-368ab930](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-compact/2026-10-04/20261004T164006Z-368ab930/report.md) | d191-compact / supreme | PASS | Rejected despite runtime PASS: tidal/expansion regression. |
| [20261004T164840Z-2fd14b7d](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-compact/2026-10-04/20261004T164840Z-2fd14b7d/report.md) | d191-compact / supreme | PASS | Rejected despite runtime PASS: expansion suppressed. |
| [20261004T170832Z-584d883a](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-control/2026-10-04/20261004T170832Z-584d883a/report.md) | d191-control / glacial | PASS | Pre-D191 Glacial control (20 minutes). |
| [20261004T165401Z-cc9781a9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-control/2026-10-04/20261004T165401Z-cc9781a9/report.md) | d191-control / supreme | PASS | Pre-D191 Supreme control (25 minutes). |
| [20261004T170117Z-cb35c282](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-final/2026-10-04/20261004T170117Z-cb35c282/report.md) | d191-final / glacial | PASS | Rejected despite runtime PASS: expansion suppressed. |
| [20261004T165546Z-f4060972](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-final/2026-10-04/20261004T165546Z-f4060972/report.md) | d191-final / supreme | FAIL | Rejected: no first departure by deadline; expansion suppressed. |
| [20261004T165932Z-d71c3895](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-final/2026-10-04/20261004T165932Z-d71c3895/report.md) | d191-final / supreme | PASS | Rejected despite runtime PASS: expansion suppressed. |
| [20261004T170732Z-983f7095](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-final/2026-10-04/20261004T170732Z-983f7095/report.md) | d191-final / supreme | PASS | Expansion restored; factory-support space still obstructed. |
| [20261004T171109Z-59f8c98c](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-release/2026-10-04/20261004T171109Z-59f8c98c/report.md) | d191-release / glacial | PASS | T2 reached; before final support-disc separation. |
| [20261004T171909Z-c1733636](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-release/2026-10-04/20261004T171909Z-c1733636/report.md) | d191-release / glacial | PASS | Final ordinary Glacial observation (20 minutes). |
| [20261004T171028Z-d8ee4b23](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-release/2026-10-04/20261004T171028Z-d8ee4b23/report.md) | d191-release / supreme | PASS | Rejected support geometry: no factory turrets. |
| [20261004T171713Z-8c419c58](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-release/2026-10-04/20261004T171713Z-8c419c58/report.md) | d191-release / supreme | PASS | Final ordinary Supreme observation (30 minutes). |
| [20261004T170252Z-89504213](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d191-workers/2026-10-04/20261004T170252Z-89504213/report.md) | d191-workers / supreme | PASS | Diagnostic worker-task snapshots; not release acceptance. |
| [20261004T163255Z-fe6ea1e1](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T163255Z-fe6ea1e1/report.md) | economy-block / supreme | FAIL | Fixture compile failure; conditional injection corrected. |
| [20261004T163531Z-7d750e6b](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T163531Z-7d750e6b/report.md) | economy-block / supreme | FAIL | Unbounded supplied production consumed economy budget. |
| [20261004T163800Z-912ccc56](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T163800Z-912ccc56/report.md) | economy-block / supreme | FAIL | No fusion: T2 sub cannot build initial T1 turrets. |
| [20261004T164720Z-b5abb934](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T164720Z-b5abb934/report.md) | economy-block / supreme | FAIL | Claimed travelling pins incorrectly cancelled. |
| [20261004T165358Z-47772981](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T165358Z-47772981/report.md) | economy-block / supreme | FAIL | Factory demand ended before support; added second finite wave. |
| [20261004T165959Z-9e3b4d88](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T165959Z-9e3b4d88/report.md) | economy-block / supreme | PASS | Earlier supplied acceptance, before final support-disc separation. |
| [20261004T171420Z-dc1fa905](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T171420Z-dc1fa905/report.md) | economy-block / supreme | FAIL | Original strict FAIL: two unfinished converter frame losses. |
| [20261004T171817Z-9ae5216e](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block/2026-10-04/20261004T171817Z-9ae5216e/report.md) | economy-block / supreme | PASS | Final compact physical acceptance; one unfinished frame loss. |
| [20261004T164148Z-89c69f9c](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block-exp/2026-10-04/20261004T164148Z-89c69f9c/report.md) | economy-block-exp / supreme | FAIL | No fusion: T2/T1 support handoff incomplete. |
| [20261004T165639Z-e6cfcb0f](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block-exp/2026-10-04/20261004T165639Z-e6cfcb0f/report.md) | economy-block-exp / supreme | PASS | Earlier supplied acceptance, before final support-disc separation. |
| [20261004T171719Z-4a7ca5ff](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/economy-block-exp/2026-10-04/20261004T171719Z-4a7ca5ff/report.md) | economy-block-exp / supreme | PASS | Final experimental physical acceptance. |

## Verification scope and remaining work

- Six SEA pure-math tests and 19 shared build-power tests pass.
- Script/DLL API parity, role documentation and invariant checks pass.
- The documentation checker retains the eight pre-existing missing-hover-guide
  links (KI-404); D191 links resolve.
- The pinned DLL is unchanged, SHA256
  `a293daae515d9f77945a095c2e84950177429b6b0da2b32366372bf347c1e28b`.
- D191 data differences are confined to SEA code, its shared settings namespace
  and SEA math. AIR, TECH, shared builder policy and profiles match the pinned
  pre-D191 data. No new native changes or sample-tree changes are part of D191.
- Build-output data is refreshed from the verified repository data; the live
  BAR installation is untouched.

Unresolved: native dormant-chain lifetime (KI-237), unfinished converter loss
(KI-238), broad movement/access and economy non-regression (KI-231/KI-235),
late role-entry adoption (KI-234). Save/load, blocked-block replacement,
physical Cortex/Legion block geometry and competitive repeated-seed performance
are not certified by these tests. See [known issues](known-issues.md).

# Allied base reservations and forward SEA shipyards

2026-10-04, D192. Implementation follows the [plan](sea-allied-base-plan.md).
The shared native allied reservation index was already enforcing slot/zone
ownership. SEA's small independent tidal patches allowed bases to alternate
patches, while ordinary SEA shipyards bypassed the berth planner entirely.

## Implemented behaviour

- SEA reserves a dense 48-site tidal cluster before its first building. Future
  empty sites belong to that owner, as do existing factory/economy zones.
- AIR/TECH retain their production and geometry policies. The existing native
  index rejects foreign reservations, ordinary placement and build retries.
  Weapon/forward-mex areas receive no new exclusive envelope; adjacent allied
  construction remains possible, but actual building footprints cannot overlap.
- Both SEA placement modes route later ordinary shipyards through pinned,
  enemy-facing berths. Their whole rear edge clears the naval economy frontier
  by 128 elmos. The frontier includes existing buildings and future reservations.
  Only the opening yard is exempt; its historical existence is persisted.
- Search begins around a harbor rather than an inland start. Later searches can
  reach 2400 elmos; the opening keeps 1200. Compact mode now preplans two future
  T2 berths by default, with the first search anchor 768 elmos forward. This
  reserves space without buying factories before the existing income gate.
- The shared builder's native fallback is filtered for SEA as well as direct
  role proposals. Existing frames and pins are retained. Placement calculations
  remain bounded and the economy-front snapshot refreshes once per second.

## Evidence and interpretation

The full standalone suite passed, including 14 allied reservation assertions
and eight SEA policy tests. Those cover reciprocal private ownership, legal
adjacent forward sites, release semantics, whole-footprint clearance and the
one-time opening exception. API parity, invariant practice and role-doc checks
pass. The existing eight missing `hover.md` links and 167 unit-helper findings
remain; no new unit definitions were introduced here.

The final results table and original observation inventory follow below.
Reports marked PASS certify their acceptance checks, not game strength.
The supplied tests override resources and yard admission, but use real
placement, construction, reservations, physical footprints and facing.

## Corrections and limits

A nearest-start ownership partition was tested and rejected: coastal starts
can lie on land, so the partition starved valid naval economy. Complete native
cluster reservations are the ownership boundary instead.

Earlier supplied fixtures used artificial opening-yard positions or waited
for expensive economy completion before requesting a yard. These are retained
as failed observations. Supplying metal alone did not override the ordinary
75-metal-income yard cap, so the final placement fixture explicitly raises
that cap when requesting a test yard. Ordinary games keep the actual gate.

The earlier compact candidate could lack a rear economy block behind its
unconstrained opening. At 20 minutes one Glacial run had only 22 metal/s and
311 energy/s while repeatedly deferring converters. It passed generic startup
checks but is rejected as the final implementation. Preplanning future compact
harbors addresses that spatial dependency; natural games and a pre-D192 data
control distinguish it from supplied placement success.

Mixed-role games can independently fail TECH's already-tracked INV-001,
INV-013 or INV-019. Their original FAIL verdicts are retained even where all
12 reservation probes passed. This work does not change TECH build rules.

Save/load, role switching, destruction of the opening yard, and physical
obstruction of an unused whole cluster were not replayed in this change's
engine tests. Existing release/replan mechanisms are retained and have native
unit coverage; that is not equivalent to those runtime lifecycle cases.
Existing SEA approach and throughput concerns (KI-231/KI-235) remain open.
There is no FPS/APM or fixed-opponent strength claim.

## Accepted final runs

| Scenario | Original report | Result |
| --- | --- | --- |
| Supreme, SEA/AIR/TECH on both teams, 6 minutes | [184926Z-a48f40a9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-mixed/2026-10-04/20261004T184926Z-a48f40a9/report.md) | PASS: all 12 directed factory/economy exclusion checks; no script/invariant/probe failures. |
| Glacial, six SEA players with supplied capital/crews, 15 minutes | [184751Z-038f3d53](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T184751Z-038f3d53/report.md) | PASS: western allies' later yards completed at 5:14, 8:38 and 11:38. All forward/enemy-facing; no foreign static inside observed tidal clusters. |
| Glacial ordinary resources, six SEA players, 25 minutes | [184737Z-485827e5](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-preplan/2026-10-04/20261004T184737Z-485827e5/report.md) | PASS: T2 at 17:35, T2 constructor 18:10, naval fusion 21:46. Observed later-yard geometry passes. |
| Supreme ordinary resources, two SEA players, 25 minutes | [184919Z-d208282c](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-preplan/2026-10-04/20261004T184919Z-d208282c/report.md) | PASS startup/egress/runtime; no T2 in this window, so later-yard geometry is covered by the supplied/mixed and Glacial cases. |

![Final ordinary Glacial game at 20 minutes](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/benchmarks/records/sea/economy/d192-preplan/2026-10-04/20261004T184737Z-485827e5/screen_2026-10-04_18-46-36-131.png)

![Final supplied three-neighbour test at 14 minutes](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T184751Z-038f3d53/screen_2026-10-04_18-47-44-580.png)

## Economy measurements, not a strength score

| Map/build | Minute | Metal income/s | Energy income/s | Build power |
| --- | ---: | ---: | ---: | ---: |
| Glacial pre-D192 control | 10 | 46.1 | 624.0 | 1600 |
| Glacial final | 10 | 25.8 | 495.0 | 1150 |
| Glacial pre-D192 control | 20 | 78.5 | 1213.0 | 4300 |
| Glacial final | 20 | 116.4 | 1075.0 | 3650 |
| Supreme final | 10 | 36.4 | 535.1 | 1400 |
| Supreme final | 20 | 58.9 | 1153.7 | 3000 |

The [Glacial control](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-control/2026-10-04/20261004T184512Z-4797543a/sea-score.json)
uses the entire captured pre-D192 working-tree data with the same DLL, map,
roles and requested seed. It reached T2 at 16:52 and did not complete a fusion
by 25 minutes. The final build grew more slowly early; donation/combat history
and changed self-play opponents prevent attributing the later metal-income
difference solely to the layout. This is not economy non-regression proof.
The concrete resolved failure is rear-block admission and subsequent converter,
T2 and fusion progress, not every existing SEA throughput problem.

The final production delta is exactly six scripts: `global.as`, `sea_math.as`,
`builder.as`, `sea_layout.as`, `sea_eco_layout.as`, and `sea_build.as`. Native
source, AIR/TECH policy and unit profiles match the captured turn baseline.
The published build uses DLL SHA-256
`a293daae515d9f77945a095c2e84950177429b6b0da2b32366372bf347c1e28b`
with matching debug symbols and current data. Staged hashes are retained in
every bundle; raw logs/replays remain at the recorded local archive paths.

## Original observation inventory

All 24 completed observations remain immutable, including rejected iterations.
Scenario names such as `final` and `release` are historical labels; only the
accepted IDs above identify the final implementation.

| Original report | Scenario / map | Verdict |
| --- | --- | --- |
| [20261004T180126Z-62060b97](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-compile/2026-10-04/20261004T180126Z-62060b97/report.md) | d192-compile / Glacial Gap v1.1 | PASS |
| [20261004T184512Z-4797543a](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-control/2026-10-04/20261004T184512Z-4797543a/report.md) | d192-control / Glacial Gap v1.1 | PASS |
| [20261004T183418Z-835583e4](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-final/2026-10-04/20261004T183418Z-835583e4/report.md) | d192-final / Glacial Gap v1.1 | PASS |
| [20261004T183203Z-4ecac210](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-final/2026-10-04/20261004T183203Z-4ecac210/report.md) | d192-final / Supreme Isthmus v1.7 | PASS |
| [20261004T182253Z-d5794d34](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-natural/2026-10-04/20261004T182253Z-d5794d34/report.md) | d192-natural / Glacial Gap v1.1 | PASS |
| [20261004T182232Z-2d772291](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-natural/2026-10-04/20261004T182232Z-2d772291/report.md) | d192-natural / Supreme Isthmus v1.7 | PASS |
| [20261004T184737Z-485827e5](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-preplan/2026-10-04/20261004T184737Z-485827e5/report.md) | d192-preplan / Glacial Gap v1.1 | PASS |
| [20261004T184919Z-d208282c](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-preplan/2026-10-04/20261004T184919Z-d208282c/report.md) | d192-preplan / Supreme Isthmus v1.7 | PASS |
| [20261004T184009Z-dc273d76](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-release/2026-10-04/20261004T184009Z-dc273d76/report.md) | d192-release / Glacial Gap v1.1 | PASS |
| [20261004T183942Z-d2a97b86](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/economy/d192-release/2026-10-04/20261004T183942Z-d2a97b86/report.md) | d192-release / Supreme Isthmus v1.7 | PASS |
| [20261004T181055Z-b3aab3d7](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-mixed/2026-10-04/20261004T181055Z-b3aab3d7/report.md) | allied-bases-mixed / Glacial Gap v1.1 | FAIL |
| [20261004T181203Z-7b197f4f](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-mixed/2026-10-04/20261004T181203Z-7b197f4f/report.md) | allied-bases-mixed / Supreme Isthmus v1.7 | FAIL |
| [20261004T181550Z-40e006d8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-mixed/2026-10-04/20261004T181550Z-40e006d8/report.md) | allied-bases-mixed / Supreme Isthmus v1.7 | PASS |
| [20261004T181845Z-9d061795](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-mixed/2026-10-04/20261004T181845Z-9d061795/report.md) | allied-bases-mixed / Supreme Isthmus v1.7 | PASS |
| [20261004T183653Z-9ea4c9b0](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-mixed/2026-10-04/20261004T183653Z-9ea4c9b0/report.md) | allied-bases-mixed / Supreme Isthmus v1.7 | FAIL |
| [20261004T184926Z-a48f40a9](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-mixed/2026-10-04/20261004T184926Z-a48f40a9/report.md) | allied-bases-mixed / Supreme Isthmus v1.7 | PASS |
| [20261004T181129Z-fcbeb64e](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T181129Z-fcbeb64e/report.md) | allied-bases-supplied / Glacial Gap v1.1 | FAIL |
| [20261004T181421Z-a4817bb4](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T181421Z-a4817bb4/report.md) | allied-bases-supplied / Glacial Gap v1.1 | FAIL |
| [20261004T181919Z-ce0e6532](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T181919Z-ce0e6532/report.md) | allied-bases-supplied / Glacial Gap v1.1 | FAIL |
| [20261004T182617Z-fadefac3](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T182617Z-fadefac3/report.md) | allied-bases-supplied / Glacial Gap v1.1 | FAIL |
| [20261004T182923Z-85a1e61b](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T182923Z-85a1e61b/report.md) | allied-bases-supplied / Glacial Gap v1.1 | FAIL |
| [20261004T183226Z-6a3aa745](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T183226Z-6a3aa745/report.md) | allied-bases-supplied / Glacial Gap v1.1 | FAIL |
| [20261004T183546Z-dcc652a5](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T183546Z-dcc652a5/report.md) | allied-bases-supplied / Glacial Gap v1.1 | PASS |
| [20261004T184751Z-038f3d53](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-supplied/2026-10-04/20261004T184751Z-038f3d53/report.md) | allied-bases-supplied / Glacial Gap v1.1 | PASS |

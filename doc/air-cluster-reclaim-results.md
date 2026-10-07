# AIR compact clusters and low-tier energy retirement: D-167 results

2026-10-02. Implementation follows the [written plan](air-cluster-reclaim-plan.md).
Dense clusters and wind retirement passed controlled games. Natural economy
improved in the last observed repeat, but **the twenty-minute T2 bomber-wave
target is not met**. The earlier two-completed-AFUS gate remains unchanged
pending the requested clarification. These runs do not establish optimal PvP
play, an FPS improvement, or a causal timing improvement from any single edit.

## Shipped behavior

- Each new factory compound reserves six lab sites. The first is one T1 plus
  five T2; later compounds contain six T2. There is no default total lab cap.
  A second compound preserves the previous minimum of six planned T2 sites.
- Native half-cell geometry, ordinary persistent building pins, per-building
  zones, and an enclosing reservation provide the same placement/ownership
  mechanism TECH uses. AIR adds an atomic compound geometry operation; it
  does not call TECH's controller or change TECH's factory-line state.
- Twenty distinct support pins surround each T2 site in tight two-column banks.
  The twenty-completed-turrets-per-standing-T2-lab expansion gate is unchanged.
  Six 9-by-9-cell labs with 3-by-3-cell nanos occupy a 1008-by-480-elmo envelope.
- Entire unused compounds revalidate before first use and relocate together
  when blocked. Once any member starts, the compound stays anchored; existing
  support repair remains available. Occupied legacy/gifted bays are retained.
- AIR shares TECH's exact scalar reclaim comparison: subtract all retiring-tier
  output, retain 1.25 times pull for wind/basic solar or 1.5 for advanced solar,
  with the existing completed-AFUS override. AIR additionally requires a
  completed reactor and no energy recovery/stall. It reclaims wind first,
  using at most TECH's configured concurrent jobs (default four).
- Retired wind pins are released. New wind is refused while retirement is
  affordable; every AIR placement caller refuses wind/basic/advanced solar
  while an AFUS stands. Loss of the AFUS restores ordinary recovery eligibility.
- AIR disables the legacy native energy-reclaim selector while it owns this
  policy and saves/restores the previous setting's float bits on role exit.
  Dead owned task handles are pruned and excluded from the reactor gate.

TECH's build/reclaim order, margins, targeting and action execution are
unchanged. Its only policy edit replaces two arithmetic comparisons with the
tested helper, preserving subtraction order and inputs.

## Controlled capacity tests

Engine `recoil_2026.07.04`, game `Beyond All Reason test-31479-433a460`, Supreme
Isthmus v1.7. Armada AIR versus a frozen enemy builder/factory controller.
At six minutes the fixture supplies 36 AFUS, 80 advanced converters and two
advanced aircraft constructors. Enemy static targets/global LOS are supplied.
These are capacity and lifecycle tests, **not natural timing benchmarks**.

| Run | Profile | Verdict | Wind count reaches zero | Sixth T2 lab completed | T2 labs by 25 min |
| --- | --- | --- | --- | --- | --- |
| `d167-clusters-1 / 20261002-103024` | experimental_balanced | PASS | 10.6 min | 17.12 min | 11 |
| `d167-final-clusters / 20261002-104715` | experimental_terrible | PASS | 10.6 min | 16.80 min | 11 |

Both planned the first two compounds at 0.1 minutes, physically blocked and
relocated a complete unused compound at 0.4, then passed the strict script,
invariant, probe and crash checks through 25 minutes. Wind stayed at zero in
later samples. Production reached the second compound and then reserved more
capacity. The final controlled run disabled native legacy energy reclaim;
the final natural run additionally includes the all-caller solar admission
guard. No controlled timing is used to claim the natural bomber goal.

The original `air_clusters` check file still covers wind packing and natural
fusion deadlines. The new `air_factory_clusters` file owns these compound
checks, so older regression expectations are retained.

![Controlled capacity, 15 minutes](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d167/capacity-15.png)

Tight lab/nano rows at 15 minutes in the first controlled game. The supplied
AFUS bank is on the right, separate from production.

![Controlled capacity, 24 minutes](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d167/capacity-24.png)

The first controlled game's later expansion. The growing army and artificial
income make this unsuitable as a CPU/FPS benchmark.

## Natural AIR/TECH games

Four AIs: Cortex AIR and Armada TECH versus Cortex TECH and Legion AIR;
experimental_hard, zero bonus, the same engine/game/map, engine and AI seed
1002164. No units, resources, targets or orders are injected. The cluster probe
is observe-only. Strict transition checks remain enabled, including all-team
invariants and the fourteen-minute first-T2-lab deadline.

| Run | First T2 lab | First fusion | First / second AFUS | First T2 wave | Overall |
| --- | --- | --- | --- | --- | --- |
| `d167-natural-1 / 20261002-103232` (30 min) | 16.71 | 19.13 | none completed | none | FAIL |
| `d167-natural-2 / 20261002-104108` (35 min) | 18.39 | 21.90 | 29.29 / 31.63 | 34.53, 17 bombers + 4 fighters | FAIL |
| `d167-natural-final / 20261002-110115` (40 min, final scripts) | 14.65 | 17.48 | 21.95 / 26.65 | 29.72, 20 bombers + 0 fighters | FAIL |

The first run stalled on an AFUS project after its frame was reclaimed: the
project gate remained set without a live reactor target and metal filled.
The exact removal/ownership cause is unproven. Dead-task guards were added,
but the repeat did not log a dead-project cleanup, so it does not establish
that guard as the solution. The competing native low-tier energy selector was
subsequently disabled for clear policy ownership; it only selects low-tier
energy and is not claimed to have reclaimed that AFUS. See KI-461.

In the second run wind fell from 53 at 20.1 minutes to 5 at 34.6 after the first
AFUS. It completed 17 T2 bombers and launched its first wave; this demonstrates
production/release, not target destruction or PvP effectiveness. The run also
reported INV-081 (commander guarding an idle factory) and TECH invariants;
these are not suppressed or attributed to the new scalar helper without proof.

The final natural game includes exclusive AIR reclaim ownership and the
all-caller wind/solar admission guard. It met the first-fusion goal and preserved
mex-first admission, but missed the fourteen-minute lab check and twenty-minute
bomber target. All wind was gone at 28.6 minutes and remained absent through
40.1; seven T2 labs and four AFUS completed. At 10.1/15.1/20.1 minutes the
observed metal income was approximately 23.1/46.8/57.7 per second, with
31/55/50 windmills. It built 25 advanced air constructors, 283 T2 fighters and
116 T2 bombers over the full run. These are produced totals, not survivors.

The opening wave had no escorts and zero survivors when evaluated at 31.78
minutes. Waves two, four and five also had zero survivors; wave three returned
6 of 16. Target health/damage is not established by these survival logs, but
this is plainly insufficient evidence of effective strikes. Update KI-457's
payload/route-risk and escort-admission investigation rather than claiming
success from production counts. The final strict verdict remains FAIL with
27 INV-081 observer lines and TECH invariant failures; there were no script
errors, crash markers, or new AIR compound/reclaim invariant reports.

![Natural economy at 20 minutes](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d167/natural-20.png)

Valid first-run capture: T1/T2 production and compact support banks, retained
wind clusters and ordinary fusion. It is not the later repeat.

## Verification and remaining work

- Native integration Built successfully with matching symbols. DLL SHA-256:
  `e4acf03e381e7818764797ebda0eeea3a921a0aa2491358ce5b57d39d41568e9`;
  stripped size 7,690,937 bytes. Symbols SHA-256:
  `0cd8ba1b9932c3fa23dc972f7d9a9c07a3baf76a779261d6f08ee350f728d44c`.
- `tools/run_native_tests.sh` passed, including compound rotations, alignment,
  mixed footprints, non-overlap, support reach, density, rejected seven-lab
  input and exact TECH scalar boundaries. Existing lane, targeting, terrain,
  air geometry and AngelScript math suites also passed.
- API parity checked 269 script members with zero findings. Required output
  published together: DLL, matching symbols and current data under the engine
  build's `AI/Skirmish/BARb/stable`, not the live BAR install.
- Invariant practice and role documentation checks passed. Documentation links
  retain eight pre-existing references to absent `roles/hover.md` (KI-404).
  Unit helpers retain two pre-existing unreachable sonar IDs in TECH weapons
  (KI-425). No new findings were added or suppressed.
- Rendered games loaded all three experimental profile families. A separate
  headless terrible-profile attempt timed out before AI initialization and is
  not counted as a script failure or a successful load.
- Later captures drifted off the intended base, even with explicit coordinates;
  they are not used as visual proof. Retained images above were inspected.
- Save/load continuation, role-exit setting restoration, reactor-loss recovery,
  and six-site fit on narrow/rough maps remain unplayed for this change.
  Existing native persistence is reused, but that is not runtime proof.
- No general AIR performance optimization or global command throttle was added.
  Reclaim selection is linear in owned units (three fixed tiers, at most four
  jobs); cluster perimeter enumeration visits each ring cell once, bounded by
  `EconomySearchRings`. Placement/engine query costs still need profiling.

Recommended next economy change: separate a funded opening bomber wave from
the two-AFUS mass-production milestone, retain escorts and emergency transport
priority, and measure transition capital and reactor work on the critical path.
This follows the [meta rationale and sources in the plan](air-cluster-reclaim-plan.md#bomber-timing-and-meta).
Do not claim that lifting the gate alone proves useful bombers by twenty minutes.

Machine-readable audits: [natural 1](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/d167-natural-1.json),
[natural 2](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/d167-natural-2.json),
[natural final](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/d167-natural-final.json),
[capacity 1](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/d167-clusters-1.json),
[capacity final](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/d167-final-clusters.json).
Worker assignment counters in these audits are zero because the cluster probe
does not emit the separate economy-worker probe schema; zero is not a finding
that no constructors worked. Full reports/logs/screenshots remain in each
named `build-theatres/<run>/runs/<stamp>/` directory.

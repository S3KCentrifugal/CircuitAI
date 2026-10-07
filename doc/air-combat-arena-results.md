# AIR combat arena results (D-165)

## What was implemented

A reusable, rendered combat-only arena with two experimental AIR opponents,
powered radar across the standard start sites, supplied scouts, replenished
aircraft/targets/AA, and no economic build-up. Bounded tests and endless mode
use the same combat loop. JSON cases and a UnitDef override cover new aircraft
without copying the widget. A serial matrix and comparison report make repeated
tests inexpensive. [Commands and case format](../tools/playtest/README.md#supplied-air-combat-arena-d-165).

Production AIR targeting, movement, learning and interception are unchanged;
TECH and the native DLL are unchanged. The staging manifest records the
test-only economic/escort bypasses, frozen builders/factories, supplied energy,
stockpile replenishment, version pins and script hashes. These bypasses are
never written to `data/` or the published build output.

The [plan](air-combat-arena-plan.md) was written before implementation. Its
measurement boundary matters: the unit pools are refill ceilings, not forced
wave sizes. Existing AIR policy chooses targets, routes, launches and returns.
Living aircraft are never teleported, healed or reassigned by the fixture.

## Environment and evidence

- Source baseline: `3dd2fdd3`; experimental_hard on Supreme Isthmus v1.7.
- Engine: `recoil_2026.07.04`; game: `Beyond All Reason test-31479-433a460`.
- Native DLL SHA-256: `ace9d657b26093f0e89e82676790e8d39159c68491e5b64f90b19fb917997352`.
- Primary radar baseline: `build-theatres/d165-intercept-final`, seed 1651,
  Armada bombers versus Cortex fighters, 18 game minutes at requested 12x.
- Faction matrix: `build-theatres/d165-matrix`, seed 1652, twelve cases,
  ten game minutes each at requested 20x, run serially. Defender is Cortex.
- Covered naval matrix: `build-theatres/d165-naval`, seed 1653, three cases,
  eight game minutes each at requested 20x. Defender is Cortex.
- Logs, exact manifests, screenshots and strict reports remain together in
  each directory's `runs/<timestamp>/` archive. Committed measurements and
  selected original screenshots are linked below.

The initial `d165-radar-smoke` failed because BAR regenerated the top-level
damage callback. Its original observer also merged immediate successive
sorties. `d165-radar-v2` passed integrity checks but reported resistance before
the evaluation completed. Both are retained as diagnostic history and excluded
from the final comparison. The final observer wraps BAR's handler method,
retains the observed task identity, and waits for its actual evaluation.

## Measured behavior

The final T2 radar baseline completed seven sorties, with an eighth unfinished
at the cutoff. The first three groups (18, 22 and 11 bombers) did no damage to
their chosen targets. Resistance rose from 1 to 1.5 to 2.25 to 3. Two later
35-bomber groups each destroyed a 3,350-metal fusion. The first lost all 35;
the second returned three aircraft. Fighters first damaged detected cohorts
after 9.83-16.87 seconds. Both successful attacks were intercepted before the
first target damage. Existing adaptation enables larger penetration attempts,
but these exchanges are not efficient.

The T1 Armada and Cortex cases actually attacked windmills and mexes and
returned surviving aircraft between raids. Costs still exceeded target value.
Legion's early aircraft is a gunship, so it is measured through attributed
damage and losses rather than being mislabeled as a bomber sortie.

Layered AA is a harder counter. Armada and Legion's T2 samples caused no
attributed bomber health damage. Cortex damaged and eventually destroyed the
air lab, but still lost far more metal than it destroyed. Increasing a scalar
resistance multiplier is not sufficient to solve interception, route exposure,
target value and return survival.

Shuriken results distinguish EMP from health damage: paralysis is useful
support behavior and does not count as destroyed economy. Native gunship and
torpedo cases use class totals even when no ordinary bomber-wave task exists.

All fifteen matrix cases passed the strict runtime checks. Values below
use the fixed 10-minute window (first matrix) or 8-minute window (covered
naval matrix), excluding shutdown overrun. Zero damage remains a failure
to penetrate, even when fixture integrity passes. See the
[complete per-wave measurements and archive identities](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/air-d165-arena.json).

| Case | Faction | Health damage / EMP | Attacker metal lost | Credited kill value |
| --- | --- | --- | --- | --- |
| gunship | armada | 10495 / 0 | 12825 | 2740 |
| gunship | cortex | 2 / 4282 | 7888 | 0 |
| gunship | legion | 7908 / 0 | 10560 | 2340 |
| t1-economy | armada | 4637 / 0 | 8850 | 666 |
| t1-economy | cortex | 5577 / 0 | 10350 | 820 |
| t1-economy | legion | 11934 / 0 | 12100 | 2520 |
| t2-flak | armada | 0 / 0 | 35190 | 0 |
| t2-flak | cortex | 8525 / 0 | 25110 | 2900 |
| t2-flak | legion | 0 / 0 | 22050 | 0 |
| torpedo | armada | 5905 / 0 | 0 | 5200 |
| torpedo | cortex | 6071 / 0 | 0 | 5200 |
| torpedo | legion | 59499 / 0 | 3360 | 47360 |
| torpedo-covered | armada | 41801 / 0 | 14000 | 36640 |
| torpedo-covered | cortex | 43457 / 0 | 9020 | 36400 |
| torpedo-covered | legion | 42878 / 0 | 12000 | 36480 |

The exposed naval case places targets outside the defending home screen.
The covered case changes positions, supplies sonar and adds a second floating AA tower;
both sides remain autonomous. Repeated underwater-fusion kills and fighter damage
were observed in that case. Its stronger results cannot isolate sonar from those
other changes, and neither case establishes moving-ship pursuit efficacy.

## Interpretation and next tuning work

The arena is ready for controlled comparisons; it is not evidence that AIR is
unbeatable or that every aircraft mission has been validated. Keep
[KI-457](known-issues.md#ki-457---air-strike-efficacy-still-needs-calibrated-payload-and-route-loss-models)
open. Compare candidate route/escort/abort policies against these cases and
multiple seeds before changing production defaults. In particular:

1. Compare early raid sizes against the value of exposed mex/wind clusters,
   including collateral, interception losses and survivors.
2. Test weak-side routes and coordinated escort/AA suppression against the
   flak case. A larger unescorted wave can merely increase losses.
3. Judge the fighter screen by attributed hits before target damage and target
   survival, not just an interception-order log. Scout contacts can activate
   the screen before a bomber cohort appears.
4. Treat specialist EMP/nuclear packages, transports, constructors and radar
   aircraft as separate missions with their own outcomes. A loaded UnitDef
   catalog and `--unit` support are not coverage claims.

Radar mode includes artificial scouts at target regions; it does not test
natural reconnaissance production. Global LOS is explicitly labeled and cannot
establish radar reaction. The supplied-force results also cannot establish
economic sustainability. The sample is one map, and fixed engine/AI seeds do
not establish bit-for-bit repeatability with asynchronous UI cheat commands.

Raw damage can include overkill. Per-sortie kill value includes only its chosen
target; class totals include collateral and opportunistic attacks. Class kill
credit uses the last observed damaging aircraft. Completed and unfinished
sorties are separate, and losses after a completed sortie are not charged to
that old cohort again.

## Verification

- 14 focused Python tests passed (cohort ownership, actual fighter hits, EMP,
  censoring, shutdown cutoff, aliases, malformed refill periods and screenshots).
- Seventeen final rendered observations passed: one 18-minute T2 baseline,
  twelve 10-minute faction cases, three 8-minute covered naval cases and the
  endless-mode observation. All preserved strict script/crash/invariant checks.
- Endless mode was configured with a nominal one-minute duration and advanced
  to frame 11097 before the external watcher stopped it.
  This confirms continued operation beyond fixture autoquit; it is a bounded
  lifecycle check, not an infinite-duration reliability claim. It used Legion
  defenders and explicitly labeled global LOS, not the radar baseline.
- API parity against the mandatory published DLL passed (268 members).
  No production scripts, profiles, native sources or published binaries changed.
- Invariant-practice and whitespace checks passed. Published `data/` matches
  the repository byte for byte. Documentation checking reports only the eight
  pre-existing missing hover-document links tracked under KI-404; new links resolve.
- All games launched here were stopped through their scoped playtest lifecycle.
  The original failed smoke and provisional observer run remain archived.


## Screenshots

![T2 bomber column intercepted before reaching the base](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d165/t2-intercept.png)

![A later, larger wave reaches the fusion](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d165/t2-fusion-strike.png)

![Cortex T1 bombers attack a metal extractor](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d165/t1-mex-strike.png)

![Cortex reaches the air lab under layered AA](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d165/layered-aa-strike.png)

![Torpedo aircraft strike underwater economy in the sonar-supplied case](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d165/torpedo-strike.png)

![Shurikens attack exposed radar; paralysis is recorded separately](https://raw.githubusercontent.com/S3KCentrifugal/CircuitAI.benchmarks/main/doc/images/d165/shuriken-strike.png)

# Connected mountain lanes: played verification

September 29, 2026 Halifax (September 30 UTC). D-145 / KI-434.

## Change

All all-terrain candidate generators now use one native qualification filter.
A route must make uninterrupted progress toward the enemy on one connected
mountain component above both endpoints by `high_ground_rise`. Its projected
span must reach both 1024 elmos and 45% of endpoint separation. These defaults
are JSON/script controls, not map-name exceptions. Isolated mesas, several
unconnected hills, sideways excursions, and two ridge visits joined through
the valley do not qualify. Ordinary land, water and air routes remain available.

The resulting qualification is published with the native route and used by
TECH before a dedicated factory is ordered. Failed refresh selection clears
production qualification, so a second production request cannot resume stale
recruitment. Existing units and already-started construction are not cancelled.

## Final build

- DLL: 7,563,930 bytes; SHA256 `40d6a99f177610aa5dd25fcdf71c6dbdffab631040bb092d2baccc8de2cdaf3f`.
- Matching debug symbols and all 229 current data files verified in the required
  `C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable` output.
- Eight native suites pass, including concurrent solver tests, isolated-hill
  counterexample, continuous ridge retention and valley-shortcut rejection.
- 233-member DLL/API check, role-document and invariant-practice checks pass.
- Document link check retains eight existing missing `hover.md` links (KI-404).
- Live game installation was not modified.

## Conditions and functional results

All final games use Recoil `recoil_2026.07.04`, game
`Beyond All Reason test-31450-6562fb1`, experimental_balanced, Legion enabled,
extra/player-Scavenger units disabled, normal weapon damage and headless mode.
The six-minute Supreme survey covers all 16 AI players. The other runs are
35-minute TECH duels. They supply only energy/conversion structures beginning
at six minutes; no factory, constructor or combat unit is supplied. Requested
speed is 12; concurrent runs are not performance benchmarks. Ascendancy uses
the disclosed staged-only TECH fallback override (KI-428).

| Run | Focused result |
| --- | --- |
| Supreme, all 16 players / 6 minutes | Every AI surveyed and refreshed; zero all-terrain lanes throughout. |
| Supreme, Legion versus Armada / 35 minutes | Both crossed +200 metal/s and explicitly rejected the flank; zero dedicated flank orders/recruits and zero all-terrain combat completions. |
| Glacial Gap, Legion versus Armada / 35 minutes | Both retained the mountain lane, built their own dedicated factory, recruited for more than five minutes, climbed the mountain and fought. |
| Ascendancy, Cortex versus Armada / 35 minutes | Both retained the mountain lane, built their own dedicated factory, recruited continuously, climbed and fought; Cortex reached the enemy base. |

The native/script lane publication invariants INV-070/071 and route ownership
INV-067 did not fire. No AI script or worker errors were recorded. The separate
archived verifier passes every functional criterion for all four runs.

## Observed combat at 35 minutes

These are units identified by the read-only observer as factory-origin attackers
with mountain waypoints, not every unit on the team. Damage is raw observed
weapon damage, not normalized economic value; kills/losses below use unit metal
cost. An enemy-base visit means entering 1800 elmos of the opposing start.

| Map / faction | Routed units tracked | Reached high ground | Enemy-base visits | Enemy metal killed | Own metal lost | Structures killed |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Glacial / Legion | 47 | 41 | 29 | 50,546 | 4,500 | 26 |
| Glacial / Armada | 65 | 52 | 0 | 3,750 | 26,000 | 0 |
| Ascendancy / Cortex | 86 | 73 | 14 | 26,780 | 25,380 | 1 |
| Ascendancy / Armada | 79 | 59 | 0 | 14,040 | 28,400 | 0 |

Legion's Glacial force achieved an 11.2:1 metal kill/loss ratio in this fixture;
Cortex's Ascendancy force achieved about 1.06:1 and reached the enemy base.
Armada's ratios were 0.14:1 and 0.49:1 respectively. Thus the routes and attacks
remain functional and can be effective, but this does **not** establish that
fixed Recluse production is efficient against these opposing forces. Recruitment
composition and combat micro were deliberately not retuned using these test
observers; their omniscient measurements must not become AI inputs.

## Global failures and limits

All four overall game checks remain **FAIL** because broader TECH invariants
fire. The exact IDs/counts are preserved in the [machine-readable results](2026-09-29-connected-mountain-results.json).
No invariant forbid was relaxed. These overlap the KI-427 family; this run does
not establish the cause of each warning. Supreme's Legion side completed only one ordinary combat unit versus Armada's
421, a
further observation of the problem family in KI-430. This is not a clean
whole-AI regression or a claim that ordinary TECH production is fixed.

The tests prove the specified maps and faction pairings with the supplied
economy, not general win-rate improvement or every possible start/terrain edit.
The failed-refresh production guard is source-reviewed; a forced in-game
qualification-loss scenario and save/load remain unplayed. Elevated starts
and short but valuable ridges may require tuning the conservative rise/span
settings. Isolated artillery-perch planning is a separate future feature.

## Archived evidence and scorecards

- Survey: [report](../../build-theatres/mountain-regression/final-survey/runs/20260929-231156/report.md), [functional evidence](../../build-theatres/mountain-regression/final-survey/runs/20260929-231156/mountain-results.json), [dated scorecard](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/scorecards/2026-09-30/20260930T020745.432085Z-35755fad.json).
- Supreme: [report](../../build-theatres/mountain-regression/final-supreme/runs/20260929-232407/report.md), [functional evidence](../../build-theatres/mountain-regression/final-supreme/runs/20260929-232407/mountain-results.json), [dated scorecard](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/scorecards/2026-09-30/20260930T020750.317765Z-9f77d770.json).
- Glacial: [report](../../build-theatres/mountain-regression/final-glacial/runs/20260929-232444/report.md), [functional evidence](../../build-theatres/mountain-regression/final-glacial/runs/20260929-232444/mountain-results.json), [dated scorecard](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/scorecards/2026-09-30/20260930T020747.074536Z-0303ea73.json).
- Ascendancy: [report](../../build-theatres/mountain-regression/final-ascendancy/runs/20260929-232452/report.md), [functional evidence](../../build-theatres/mountain-regression/final-ascendancy/runs/20260929-232452/mountain-results.json), [dated scorecard](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/scorecards/2026-09-30/20260930T020748.765928Z-ceba1ff3.json).

Earlier exploratory runs used DLL `741c3b16714499bc` before the continuous-
segment safeguard. They remain in the scorecard history; the three long runs
were stopped deliberately to validate the final build instead. They are not
used as final-build proof. Reproduction commands and the evidence verifier are
in [the playtest guide](../../tools/playtest/README.md#connected-mountain-regression-d-145).

## Additional profile compatibility

The shared script also loaded and published qualified native lanes for both
teams under `experimental_hard` and `experimental_terrible`, with zero script
errors or invariants in the one-minute startup probes. Together with the long
balanced runs, this exercises all three affected experimental profiles.

- [Hard startup PASS](../../build-theatres/mountain-regression/load-experimental_hard-probe/runs/20260929-233152/report.md)
- [Terrible startup PASS](../../build-theatres/mountain-regression/load-experimental_terrible-probe/runs/20260929-233159/report.md)

The original startup check incorrectly matched the `:::AI LOG` prefix that the
watcher removes before evaluating script log payloads. The reports initially
said missing expectation even though the raw logs already contained the native
publications and qualified routes. The check now matches native team-tagged
publication and the script payload. The linked PASS reports re-evaluate the
same byte-identical logs; original failed reports remain preserved. An explicit
early survey-request widget makes the fixture independent of automatic timing.

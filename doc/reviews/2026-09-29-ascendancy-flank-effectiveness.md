# Ascendancy: all-terrain attack effectiveness

The western flank made a useful combat contribution in both accelerated
Legion-versus-Armada runs, including a commander kill in the first. The eastern
Armada stream scored kills but failed to break through. A natural-economy
Cortex-versus-Armada run proved traversal but showed a much weaker realized
return by 45 minutes. This is evidence for the tactic's viability, not a claim
that perpetual production is always an efficient use of metal.

## Results

Only offspring of the observed dedicated factories are counted. Units must
have a long queued mountain route before joining the observer cohort. Metal
values are nominal UnitDef costs; kills use the engine's final attacker ID.
Shared damage and reclaimed wreckage are not credited. Surviving units remain
an asset, so killed metal divided by total production is not net profit.

| Run and side | Produced / lost | Kills / killed metal | Lost metal | Outcome |
| --- | --- | --- | --- | --- |
| Accelerated A, west Legion, last census 27 min | 43 / 11 | 18 / 8,090 | 8,250 | 13 Recluses, three mexes, one wind generator and the Armada commander; 11 units reached within 1,800 elmos of the enemy start |
| Accelerated A, east Armada | 19 / 19 | 10 / 6,710 | 7,600 | Eight Arquebuses and two Centurions; no base arrival; factory lost at 14.50 min |
| Visual repeat, west Legion, 30 min | 58 / 8 | 24 / 8,720 | 6,000 | 20 Recluses, one advanced constructor, two wind generators and one Fark; 22 units reached the enemy-start area |
| Visual repeat, east Armada | 22 / 22 | 9 / 5,960 | 8,800 | Seven Arquebuses and two Centurions; no base arrival |
| Natural economy, west Cortex, 45 min | 65 / 4 | 1 / 620 | 2,160 | One advanced mex; 22 Termites reached the enemy-start area, but little damage converted into kills |
| Natural economy, east Armada | 3 / 3 | 0 / 0 | 1,200 | Late factory activation; all three Recluses died before reaching high ground |

The first accelerated commander kill was by Arquebus 17111 at frame 42688,
23.72 minutes. Its explosion killed two flank Arquebuses. Ordinary armies also
fought and damaged the eastern base; this does not establish that the flank
alone caused victory. The visual repeat's western killed/lost metal ratio was
1.45, versus 0.68 for the east, excluding factory cost and surviving army value.

Natural-economy factory orders occurred at 30.33 min west (+205 metal) and
38.25 min east (+206). The western stream took roughly ten game minutes from
initial production to arrival near the enemy base. By 45 minutes it still held
32,940 metal of living Termites for only one confirmed kill. Arrival alone is
therefore not an adequate tactical-success criterion. The next policy work
should evaluate travel time, useful targets after descent and the amount of
metal committed to a stream whose realized payoff remains low. No such policy
changes were made in this experiment.

## Method and setup correction

Map: Ascendancy v2.2; game: Beyond All Reason test-31443-11f7f95. Pinned DLL:
`fe1b62f48707ccfcf61b413a1e2906055230f6602edd2813b1aa666ec2bb8b57`, unchanged
from D-136. API parity checks all 225 used members successfully.

The two preliminary runs named `ascendancy-effect` and `ascendancy-natural`
are invalid as TECH evidence. Ascendancy has no registered role map, and the
harness start fixture does not force runtime roles. Their actual logs show
FRONT/AIR. The corrected runs use a copy of `data/` under
`build-theatres/flank/ascendancy-tech-data/`, replacing only setup's default-role
selection with `AiRole::TECH`. Both corrected AIs log role=2 before building.
This is an isolated experiment override, not a production map registration.
See [KI-428](../known-issues.md#ki-428--harness-start-roles-do-not-force-runtime-roles-on-unregistered-maps).

Accelerated runs use experimental_hard, Legion west and Armada east, and the
same six-minute economy-only fixture as Glacial Gap: six advanced fusions and
24 converters per team. The AI builds all constructors, labs and combat units.
The natural run uses experimental_balanced, Cortex west and Armada east,
without supplied units or resources. All keep normal damage and AI visibility,
and temporarily extend the existing forward-cluster patience to 10,000 seconds
as in the earlier Glacial Gap tests. These scenarios are not a controlled
faction comparison and do not establish an inherent advantage for the west.

The raw UnitDamaged observer is not reliable across UI call-in replacement:
the visible run reports zero despite confirmed kills. Damage totals are
excluded from this report; UnitDestroyed attacker attribution is intact.
The retained observer now warns when its raw damage hook is replaced.

## Artifacts and checks

Preserved run reports and full logs:

- [Accelerated A](../../build-theatres/flank/ascendancy-tech/runs/20260929-112540/report.md): stopped at 27.6 minutes after the commander kill and observed breakthrough; last complete census at 27 minutes.
- [Visual repeat](../../build-theatres/flank/ascendancy-visual/runs/20260929-112615/report.md): completed 30 minutes.
- [Natural economy](../../build-theatres/flank/ascendancy-tech-natural/runs/20260929-112820/report.md): completed 45.2 minutes.

`build-theatres/flank/ascendancy-results.json` contains extracted orders, roles,
kill lists, losses, final censuses and invariant IDs. The extraction script is
beside it. [The observer](../../tools/playtest/widgets/flank_effectiveness.lua)
and [checks](../../tools/playtest/checks/flank_effectiveness.json) are retained.
The checks now explicitly require actual TECH role snapshots, rather than
trusting harness labels. Existing per-run reports are not rewritten.

Overall reports remain FAIL because broader TECH invariants fired. The natural
run also missed the accelerated test's 30-minute factory deadlines. No
INV-067, script compilation errors or observer Lua errors were found in the
three corrected runs. The command-heavy visual run reported bandwidth-limit
warnings; their impact on efficiency has not been isolated. The existing
invariant and documentation-link issues remain open. No live installation or
production AI policy was modified.

## Screenshots

At 18 minutes, the western units have crossed the northern passage:

![Northern passage](../../build-theatres/flank/ascendancy-visual/runs/20260929-112615/screen_2026-09-29_14-24-51-820.png)

At 27 minutes, units continue down the eastern cliffs toward the enemy start:

![Eastern descent and base arrival](../../build-theatres/flank/ascendancy-visual/runs/20260929-112615/screen_2026-09-29_14-25-51-946.png)

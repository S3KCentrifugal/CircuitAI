# Glacial Gap: all-faction production validation

The owner's workflow of copying `data/script`, `data/config` and the compiled
DLL separately is valid. This investigation tests production directly and does
not attribute the reported failure to that workflow. The live game installation
was not modified. All simulation writes are under
`build-theatres/faction-validation/`.

## Unmodified natural-economy faction tests

Three mirror matches exercised both TECH starts with each faction. They used
Glacial Gap v1.1, Beyond All Reason test-31450-6562fb1, recoil_2026.07.04 and
experimental_balanced. Income/weapon multipliers are 1, handicap is zero, no
economy or unit fixture is loaded, and no script settings are overridden.
In particular, the earlier extended forward-layout invariant timeout is absent.

All six cases passed the core observations: an AI builder constructed the
dedicated lab; at least eight completed units from it followed the flank over
at least five minutes of production; at least two reached the central northern
mountain checkpoint. Observer commands and unit positions are independent of
the AI's production-intent log. First completion times below are the native
completed-unit route assignments, not factory orders.

| Faction | Unit | First west / east (minutes) | Completed and routed west / east, at least | Run duration |
| --- | --- | --- | --- | --- |
| Armada | Recluse (`armsptk`) | 21.35 / 27.55 | 56 / 49 | 41.89 min |
| Cortex | Termite (`cortermite`) | 30.44 / 28.31 | 15 / 26 | 38.97 min |
| Legion | Arquebus (`legsrail`) | 27.16 / 30.39 | 23 / 15 | 38.46 min |

Counts deduplicate native routed-unit IDs, so are conservative if the engine
reuses a destroyed unit's ID. The observer separately proved sustained completed
production. Western Legion had +623 metal at minute 36 and +618 at minute 38
while maintaining its flank stream. The order-time ten-second minimum incomes
were Armada +208/+224, Cortex +216/+210 and Legion +219/+229.

These runs were stopped after the core observations passed, to free resources
for the 8v8 control. They did not reach their originally configured 55-minute
ceiling. Raw reports remain unchanged:

- [Armada](../../build-theatres/faction-validation/armada/runs/20260929-135002/report.md)
- [Cortex](../../build-theatres/faction-validation/cortex/runs/20260929-135002/report.md)
- [Legion](../../build-theatres/faction-validation/legion/runs/20260929-135002/report.md)

## Scope and unresolved checks

The overall reports are FAIL because existing TECH invariants fire. Armada east
and Cortex east did not satisfy the combined post-activation fast-bot plus spam
check during their observed durations; the reports retain their missing checks
with the original 45-minute deadlines. That is not proof they missed a deadline
the games did not reach, and is not an all-terrain failure. Other four sides
passed that combined ordinary-production observation. KI-430 remains open.

No script compile errors, native crashes, watcher errors or INV-067 route
ownership failures were found in the three faction runs. No production policy
was changed to obtain these results. They establish that all three factions can
produce under normal settings, not that every high-income full-team game does.

## Full-team control

A separate natural-economy 8v8 used Cortex TECH west (team 0) and Legion TECH
east (team 9). Its checks target those actual TECH IDs rather than treating
team 1, a FRONT ally, as the second TECH. The west TECH was overrun around
minute 25, with its last two-minute income sample at +107 at minute 24; the
western AIs were removed around minute 28. Eastern TECH remained below the
gate (+165 at minute 30). Neither TECH ordered a flank factory. This run was
stopped at 31.8 minutes after the western side was eliminated and is
**inconclusive for high-income flank activation**, not a production pass.
Its [raw report](../../build-theatres/faction-validation/full-team/runs/20260929-135422/report.md)
retains the invariant failures and unmet 55-minute expectations. A FRONT AI's
watcher observations are not counted as TECH evidence.

The owner's high-income full-team failure is therefore not reproduced or
resolved by these runs. The three faction mirror matches prove the requested
all-faction capability under their stated conditions; they do not replace that
remaining reproduction. All four isolated engines were stopped by exact write
directory and their watcher reports were archived.

## Inputs and reproducibility

The pinned DLL SHA-256 is
`fe1b62f48707ccfcf61b413a1e2906055230f6602edd2813b1aa666ec2bb8b57`.
Each simulation's 227 script/config/options files match the current workspace
byte-for-byte; only the playtest AI identity metadata differs. The API parity
checker found zero mismatches across 225 used members. See the
[input verification](../../build-theatres/faction-validation/input-verification.json)
and [structured observations](../../build-theatres/faction-validation/summary.json).
The [mirror runner](../../build-theatres/faction-validation/run_mirror.py) fixes
both faction declarations in each isolated start script and teams manifest;
the [full-team runner](../../build-theatres/faction-validation/run_full.py)
uses all registered map spots. All simulations are headless; no screenshots
are claimed.

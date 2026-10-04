# Arquebus range regression

D-143 fixes the dedicated route's uninterrupted movement through enemies and
adds opt-in weapon-range control to ordinary attack orders. All seven Legion
profiles enable it for legsrail at 0.90. Other units retain their settings.

Build: DLL `d1373c371868c2ef` (SHA-256 prefix), with matching symbols. The
225-member DLL/script API parity check passes. Source data is published to the
engine build output; the live installation is untouched.

## Isolated experiment

Stage Supreme Isthmus, TECH positions on both sides, profile hard, pinned DLL,
Legion enabled, speed 8, four minutes (the check permits up to six). Add `arquebus_watch.lua`, copy
`fixtures/arquebus_route.as` to staged `script/`, and include it in staged
`hard/main.as`. It assigns only gifted Arquebus units to preserved routes,
through a gifted enemy HLT. A MOVE waypoint lies beyond the turret, so the
endpoint FIGHT cannot mask the interrupted-travel defect. Radar supplies
continued contact beyond own sight; supplied fusion power prevents the firing
test from depending on the ordinary economy's energy surplus.
Production scripts are not instrumented. The observer checks distance, damage,
survival, target destruction, and continuing beyond the enemy after combat.
The test uses gifted units; it does not test the economic production ladder.

Baseline: prior artillery DLL `bf3bc9a63ddaa440` (standoff ignored).
Treatment: the new DLL, identical fixture and settings.

## Results

Treatment **PASS**, played through frame 7392 (4.1 game minutes):
`build-theatres/arquebus/after/runs/20260929-204940/report.md`.

| Side | Initial observed contact | Closest sampled distance | Minimum sampled health | Target destroyed | Resumed past target |
| --- | ---: | ---: | ---: | ---: | ---: |
| West / team 0 | 683 | 674 | 2200 | frame 1830 | frame 2670 |
| East / team 1 | 639 | 627 | 2200 | frame 1800 | frame 2640 |

Both retained their route task, killed the HLT, survived, and continued beyond
the target. First identification happens inside weapon range because sight is
shorter; the controller then backs away. Minimum health is not a damage-total
measurement: experience can raise maximum health during the fight. The target
attribution is contextual, not an instrumented count of damage by attacker.

Baseline **FAIL** with the identical final fixture and the old DLL: both
railguns died, east at frame 1560 and west at frame 1590. Thus the regression
distinguishes the original behavior from the fix on both sides.
Report: `build-theatres/arquebus/before/runs/20260929-205127/report.md`.

Earlier exploratory runs are not the final comparison: their endpoint FIGHT
began before the turret, allowing one baseline unit to stop and fire, and
ordinary energy production delayed the west treatment. The final paired
fixture fixes those confounders identically for both binaries. Initial watch
attempts also ended during slow loading or could not observe the elevated
engine. Live watchers should run with access to the engine process and allow
15 wall minutes. The completed final pair used that arrangement.

Headless PIP/shader initialization errors are separately tracked as KI-432.
The focused checks reject AI errors, invariant violations, observer errors,
deaths and insufficient range/health; they do not reject unavailable rendering
features. No AI or Arquebus observer error appeared in the completed treatment.

This verifies supplied units on flat terrain in both directions. Natural
factory production, cliff line-of-fire selection, and ordinary squad combat
were not separately exercised by this fixture. The production change is
map-independent; it does not change the calculated mountain routes.

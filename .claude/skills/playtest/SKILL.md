---
name: playtest
description: Play a BAR skirmish with the freshly built BARb, judge its log against a checks file, take screenshots, stop it. Use after a build to validate a behaviour change (opening, build order, placement) instead of asking the user to play.
---

# Playtest loop

The tool is `tools/playtest/playtest.py` (doc: `tools/playtest/README.md`).
It never writes under the BAR install and never kills a game the user
started: the engine runs on its own write dir, `C:\bardev\barb-playtest`.

## When

After a build that changes behaviour the user would otherwise verify by
playing: the TECH opening, the build sequence, placement, factory
production. Not for native crash hunting (use the crash runbook) and not
while the user is playing (one game at a time on this machine).

## Steps

1. Build first; wait for the build log's own `exit 0`; confirm the DLL in
   `C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\`
   is about 7 MB (a 300 MB file is a mid-build copy).
2. Run the checks that match the change, quick first:
   ```
   python tools/playtest/playtest.py run --checks smoke --roles TECH,FRONT --speed 3
   python tools/playtest/playtest.py run --checks tech_opening --roles TECH,FRONT --speed 3
   python tools/playtest/playtest.py run --checks tech_opening            # the real 8v8, slower
   python tools/playtest/playtest.py run --checks tech_opening --headless # log only, no window, fastest
   ```
   Run it in the background (a 14-minute game at speed 3 is about 6 minutes
   of wall clock plus loading) and wait for the notification.
3. Read `C:\bardev\barb-playtest\report.md`: verdict, the check table, the
   timeline. Read the screenshots in the run folder with the Read tool when
   placement is the question; send one to the user with SendUserFile if it
   says more than the log.
4. FAIL: diagnose from the timeline and `runs/<stamp>/infolog.txt`
   (`.claude/skills/ai-not-moving/SKILL.md` for a commander that stands
   still), fix, rebuild, run again. PASS: say so with the report path; the
   user still deploys by hand.
5. If a run hangs or the user wants the window gone:
   `python tools/playtest/stop_game.py`.

## Rush benchmarks (D-070)

`bash tools/playtest/bench_loop.sh <objectives...>` runs one headless
tech-versus-tech game per objective (`t2 fusion afus nuke gantry titan`),
sets `Tech::RushObjective` for the run, judges it with
`checks/rush_<objective>.json` (pass the moment the milestone finishes) and
records it in `doc/benchmarks/tech-rush.md` through `benchmark.py record`.
Two objectives per call fit the 10-minute tool limit at speed 8. Read the
chain with `benchmark.py record <run> --steps`; the `[TECH][Chain] step`
lines say what each builder did and why. Never take a simulator floor as a
bound: the in-game mex expansion outruns the six-spot simulation.

## Writing a checks file

`tools/playtest/checks/<name>.json`. Patterns are regexes over infolog
lines; use the `[Rule] <key>` names from `doc/roles/tech_rules.md` for the
sequence, `[TECH][Build]`/`[Eco] next` for the acts, `EXP:`/`RESERVE:` for
native. `expect` with `by_minute`/`after_key`, `forbid` with
`after_minute`, `stop_minute`. Keep `: ERR :` forbidden in every file.

## Traps

- The game and map come from the lobby's last `_script.txt`; pass `--map`
  and `--game` if the user played something else.
- Team 0 is always the AI under test; its role comes from the map file's
  `StartSpot` table, so `--role` must have a spot on the ally side.
- Speed above 1 needs CPU: if the frame counter in the progress line stalls,
  lower `--speed` or `--roles`.
- `LogFlush=1` is set in the playtest settings so lines arrive as written;
  do not read the install's infolog for a playtest, it is a different game.

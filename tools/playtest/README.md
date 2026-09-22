# Playtest: launch, watch, screenshot, stop

`tools/playtest/playtest.py` runs a BAR skirmish with the freshly built BARb,
follows its log against a checks file, takes screenshots of the AI under
test, and stops the engine. It is the loop "change, build, play, read the
log, repeat" as a command. Skill: [`.claude/skills/playtest/SKILL.md`](../../.claude/skills/playtest/SKILL.md).

```
python tools/playtest/playtest.py run  --roles TECH,FRONT --speed 3            # stage + launch + watch + stop
python tools/playtest/playtest.py run  --checks tech_opening                    # the full 8v8, 14 game minutes
python tools/playtest/playtest.py stage                                         # only copy the build and write the script
python tools/playtest/playtest.py launch                                        # only start the engine
python tools/playtest/playtest.py watch --checks tech_opening --no-stop         # only follow a running game's log
python tools/playtest/playtest.py stop                                          # kill the playtest engine
python tools/playtest/stop_game.py                                              # the same, standalone
```

## What it never does

It never writes under the BAR install. The engine gets its own write
directory (`--dir`, default `C:\bardev\barb-playtest`); the install is read
for the engine (`engine/<the one the lobby used last>/spring.exe`), the game
and map archives (`SpringData` in the playtest `springsettings.cfg`), and the
last lobby start script (`_script.txt`, for the modoptions and the default
game/map). The deployed `SMRTBARb` is untouched; the AI under test is staged
as `BARbTest/test` inside the playtest dir. `stop` kills only engine
processes whose command line names the playtest dir, never a game the user
started from the lobby.

## What a run does

1. **stage**: copies `SkirmishAI.dll` (+`.dbg`) from the docker build's
   install folder (`--dll` to override; a file over 50 MB is refused as a
   mid-build copy), `config/`, `script/` and `AIOptions.lua` from the repo's
   `data/` (`--data`), rewrites `AIInfo.lua` to `BARbTest/test`, writes
   `springsettings.cfg` (the user's, plus `SpringData`, windowed 1920x1080,
   `LogFlush=1`), stages the camera widget with its config, and writes
   `script.txt` + `teams.json`.
2. **script**: `StartPosType=3` with every team on a start spot from the AI's
   map file (`data/script/src/maps/<map>.as`, the `StartSpot` table), so the
   role each AI derives is known before the game. Team 0 is the AI under
   test on the ally side's spot of `--role` (TECH) with `--side`. `--roles`
   picks which spots are fielded on both sides (`all` = the real 8v8);
   `--others test|prod|none` says whether the other AIs are this build, the
   deployed `SMRTBARb`, or enemies only. The player is a spectator. The
   modoptions are the lobby's last (`mapmetadata_*` dropped, dates set,
   `allowuserwidgets=1`, Legion always on: `experimentallegionfaction=1`);
   `--modoption k=v` and `--ai-option k=v` override. The other AIs cycle
   armada, cortex, legion. The default map is the lobby's last, else
   Supreme Isthmus v1.7.
3. **launch**: `spring.exe --write-dir <dir> <dir>\script.txt` from the engine
   folder; the pid is recorded in `playtest.pid`; the old infolog and
   screenshots are cleared.
4. **widget** (`widgets/playtest_camera.lua`): forcestart, `setminspeed`/
   `setmaxspeed` to `--speed` at frame 1, the target from the BARb roster
   message (role + team) or the team's start position, `viewta` + camera on
   it and `screenshot png` at each `--shots` minute (`2@1500` = minute 2 at
   height 1500), `quitforce` half a minute after `--minutes`. Everything it
   does is a `[Playtest] ...` line in the infolog.
5. **watch**: tails `<dir>/infolog.txt`, finds team 0's skirmish AI id from
   its `[GameDetails]` line, and judges the game with a checks file
   (`checks/<name>.json`):
   - `expect`: `pattern` (regex), `by_minute` (must appear by then),
     `after_key` (must come after another expect), `scope` `tech` (team 0's
     AI lines) or `any`;
   - `forbid`: `pattern`, `scope`, optional `after_minute`;
   - `pass_on`: an optional early PASS; `stop_minute`: game minutes to play.
   The first failure stops the game (`--keep-going` to collect all); script
   errors (`: ERR :`) always fail. Wall-clock limit `--wall-minutes`.
6. **report**: `<dir>/report.md` and `<dir>/runs/<timestamp>/` with the
   report, the infolog and the screenshots: verdict, each check with the
   line that met or missed it, the team-0 timeline (`[Rule]`, `[Eco]`,
   `[TECH][Build]`, `[TECH][Factory]`, `[Playtest]`), and the native lines
   (`EXP:`, `RESERVE:`, `BUILDER:`). Exit code 0 = PASS, 1 = FAIL.

## Zero bonus is the baseline

Every playtest sets `ai_incomemultiplier=1` and `Handicap=0` for every team;
players often give the AI a bonus, so `--bonus 50` puts a handicap on team
0 alone to test the bonus behaviour (the chain logs `income bonus x1.5`,
D-072). Benchmarks are always recorded at zero bonus.

## Rush benchmarks (D-070)

```
SPEED=8 NOTE="what changed" bash tools/playtest/bench_loop.sh t2 fusion      # one headless tech-vs-tech run per objective
DLL=path/to/SkirmishAI.dll bash tools/playtest/bench_loop.sh afus            # a specific DLL
python tools/playtest/benchmark.py record C:ardevarb-playtestuns\<stamp> --steps
python tools/playtest/benchmark.py show
```

`bench_loop.sh` sets `Tech::RushObjective` for the run (`--set`), plays
`target + 6` minutes so a miss still shows its real time, judges with
`checks/rush_<objective>.json` (PASS the moment the milestone finishes) and
records the run in `doc/benchmarks/tech-rush.md`. `--set KEY=VALUE`
overrides any `Global::RoleSettings::Tech` setting in the staged script
only. The camera widget logs every structure team 0 finishes and its income
each minute; the tracker reads those lines. Two objectives per call fit the
10-minute tool limit at speed 8.

## Checks files

| File | Plays | Watches |
| --- | --- | --- |
| `checks/smoke.json` | 4 min | the AI and the widget load, the opening starts, a screenshot lands, no script error |
| `checks/tech_opening.json` | 14 min | D-066..D-068: opening mexes, first lab after them, energy, turret, advanced lab by 14; no mobile def packed, no combat production, no T1 lab re-ordered after 9 min, no native default tasks |
| `checks/rush_<objective>.json` | target + 1 | D-070: the chain announces the objective, the milestone finishes by the target; no script error, no combat production |

Add a file per behaviour under test; keep the `[Rule] <key>` names as the
patterns (they are the sequence's vocabulary, `doc/roles/tech_rules.md`).

## Reading a result

- `report.md` first: verdict, then the check table, then the timeline.
- Screenshots are PNGs in the run folder; the camera looks straight down on
  the AI's start position from `--cam-height` (2200) elmos.
- The full `infolog.txt` of the run sits beside them; the runbook for a
  commander that does not move is `.claude/skills/ai-not-moving/SKILL.md`.

## Two findings the design rests on

- **The spectator has its own allyteam.** BAR's `game_end` gadget marks every
  AI hosted by an inactive player as uncontrolled and wipes out that player's
  allyteam (not in 1v1). The local client is inactive until it has finished
  loading, and by then the sim is a few frames in, so a spectator listed in
  allyteam 0 killed the whole west side at frame 1. The script puts the
  spectator on a team of its own in allyteam 2; BAR spawns and kills that
  team's commander at the map corner at once, and the two AI sides are never
  evaluated.
- **BAR's Autoquit widget** exits the game when the mouse has not moved for
  a while; the camera widget disables it at load.

## Headless

`--headless` runs `spring-headless.exe`: no window, no rendering, several
times faster to load. LuaUI still runs, so the camera widget's speed, quit
and `[Playtest]` lines work, but `screenshot` produces nothing. Use it for
log-only checks and for the 8v8.

## Limits

- Screenshots need the display build (`spring.exe`, windowed). Speed above 1
  is bounded by the AIs' CPU time; 8v8 at speed 3 is slower than 2v2 at 3.
- Only the host machine's AIs answer roster messages, which this is.
- The map must have an AI map file with a `StartSpot` table
  (`--map-file` for one elsewhere); the archive must be in the install's
  `maps/`.
- A game the lobby is running at the same time shares the GPU and the CPU;
  stop one first.

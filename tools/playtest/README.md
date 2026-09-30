# Playtest: launch, watch, screenshot, stop

AIR commander/screen regression (D-150): stage an AIR game with both
`--extra-widget tools/playtest/widgets/air_watch.lua` and
`--extra-widget tools/playtest/widgets/air_opening_watch.lua`, then use
`prepare_air_check.py --dir <dir> --scenario natural` and `watch --checks
air_opening --minutes 25`. Judge the same completed log separately with
`watch --checks air_transition --minutes 25 --no-stop` to preserve the strict
20-minute fusion deadline. For screen growth/loss and real transport priority,
stage `--roles AIR,TECH --minutes 8`, prepare `--scenario screen`, then watch
with `--checks air_screen`. This controlled fixture supplies mixed T1/T2
fighters, raises the T2 home quota, injects real allied ferry requests, and
destroys fighters at six minutes. TECH's known INV-001 gift-provenance error
(KI-435) can fail the combined report; never remove its invariant forbid.
See [design and measured results](../../doc/air-opening-and-screen.md).

Artillery regression (D-142): stage a Supreme Isthmus test under
`build-theatres/artillery/<name>` using the pinned DLL, then run
`prepare_artillery_check.py --dir <dir> --mode profiles` (16 AIs / `--roles all`,
2 minutes) or `--mode fire` (2 AIs / `--roles TECH`, 5 minutes; stage
`--extra-widget tools/playtest/widgets/artillery_fire_watch.lua`). Then use
`playtest.py launch` and `watch --checks artillery_profiles|artillery_fire`.
Do not use `run` after preparation, as it stages again. The preparer installs
test-only script probes and writes `profile-order.json`. Profile mode cycles
all seven profiles; repeat with Legion disabled to cover conditional fragments.
Expect one veto PASS per AI (three definitions with Legion, two without).
Fire mode uses legacy hard to isolate shot events from TECH economy invariants,
gifts three cannons on dry ground and energy, and forces native ground targeting
at two minutes. Expect one `[Artillery]` line per cannon and 96 map strokes
total through subsequent salvos. This proves shot/drawing behavior, not
autonomous targeting or natural builds.

`tools/playtest/playtest.py` runs a BAR skirmish with the freshly built BARb,
follows its log against a checks file, takes screenshots of the AI under
test, and stops the engine. It is the loop "change, build, play, read the
log, repeat" as a command. Skill: [`.claude/skills/playtest/SKILL.md`](../../.claude/skills/playtest/SKILL.md).

```
python tools/playtest/playtest.py run  --roles TECH,FRONT --speed 3            # stage + launch + watch + stop
python tools/playtest/playtest.py run  --speed 20 --speed-plan "0:20,1.2:1,2.4:20" --shots "1.9,2.15"   # fast, 1x where it matters (D-127)
python tools/playtest/playtest.py run  --speed 20 --shots "14,22" --slow-near-shots   # 1x from 0.3 min before each shot
python tools/playtest/playtest.py run  --checks tech_opening                    # the full 8v8, 14 game minutes
python tools/playtest/playtest.py stage                                         # only copy the build and write the script
python tools/playtest/playtest.py launch                                        # only start the engine
python tools/playtest/playtest.py watch --checks tech_opening --no-stop         # only follow a running game's log
python tools/playtest/playtest.py stop                                          # kill the playtest engine
python tools/playtest/stop_game.py                                              # the same, standalone
```

Screenshot times schedule a camera move. Capture follows after at least three
rendered frames and one wall-clock second so terrain can settle (D-131). At 8x,
allow roughly eight additional game seconds before a screenshot deadline or
the run's end; closely spaced shots should use a slower speed plan.

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
   - `pass_on`: sets PASS early (the game still plays to `--minutes`);
     `stop_minute`: game minutes to play.
   The first failure stops the game (`--keep-going` to collect all); script
   errors (`: ERR  :`, two spaces: match `: ERR\s+:`) always fail. Wall-clock
   limit `--wall-minutes`. A crash is never named as the reason: grep the run's
   infolog for `Access violation`. The skill `.claude/skills/playtest` has the
   full list of traps.
6. **report**: `<dir>/report.md` and `<dir>/runs/<timestamp>/` with the
   report, the infolog and the screenshots: verdict, each check with the
   line that met or missed it, the team-0 timeline (`[Rule]`, `[Eco]`,
   `[TECH][Build]`, `[TECH][Factory]`, `[Playtest]`), and the native lines
   (`EXP:`, `RESERVE:`, `BUILDER:`). Exit code 0 = PASS, 1 = FAIL.

## Map/settings scorecards

`scorecard_run.py` stages a read-only telemetry observer, captures the exact map,
settings, factions, starts, DLL/data hashes and timestamps, runs an isolated TECH
duel, and archives a scorecard. `scorecard.py rebuild` updates the chronological
index and private OpenSkill ledger; `compare <a.json> <b.json>` rejects mismatched
cohorts, including Legion on/off. Timed-out matches are censored, not draws.
See the [design and commands](../../doc/benchmarks/scorecard-design.md).

## Zero bonus is the baseline

Every playtest sets `ai_incomemultiplier=1` and `Handicap=0` for every team;
players often give the AI a bonus, so `--bonus 50` puts a handicap on team
0 alone to test the bonus behaviour (the chain logs `income bonus x1.5`,
D-072). Benchmarks are always recorded at zero bonus.

## Rush benchmarks (D-070)

```
SPEED=8 NOTE="what changed" bash tools/playtest/bench_loop.sh t2 fusion      # one headless tech-vs-tech run per objective
DLL=path/to/SkirmishAI.dll DIR=C:/bardev/barb-playtest-sim2 bash tools/playtest/bench_loop.sh afus   # a specific DLL and dir
python tools/playtest/benchmark.py record C:\bardev\barb-playtest\runs\<stamp> --steps
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
times faster to load. LuaUI still runs, so the camera widget's speed, quit,
speed plans, extra widgets and `[Playtest]` lines work, but a `screenshot`
writes a blank 187-byte PNG (the `[Playtest] screenshot` line still appears).
Use it for log-only checks and for the 8v8.

## Limits

- Screenshots need the display build (`spring.exe`, windowed). Speed above 1
  is bounded by the AIs' CPU time; 8v8 at speed 3 is slower than 2v2 at 3.
- Only the host machine's AIs answer roster messages, which this is.
- The map must have an AI map file with a `StartSpot` table
  (`--map-file` for one elsewhere); the archive must be in the install's
  `maps/`.
- A game the lobby is running at the same time shares the GPU and the CPU;
  stop one first.

## Driving the BARb widget

`--extra-widget` stages any widget into the playtest's own write dir
(repeatable). Two go together:

- `tools/widgets/gui_barb_team_link.lua`, the BARb team link widget itself;
- `widgets/role_swap_test.lua`, which drives it through `WG.barblink` (the same
  code paths as its buttons): at minute 2 it checks the host may command every
  AI, flies the camera to team 0's commander (`GoTo`) and checks the camera
  landed on it, and opens the window; at minutes 20, 30 and 40 it swaps a TECH
  and an AIR AI of one ally team (`SetRole` on both) and logs each AI's reply 10 s
  later. Every line is `[RoleSwap] ...`.

```bash
python tools/playtest/playtest.py run --roles all --speed 3 --minutes 45   --shots "21@2600,31@2600,41@2600" --keep-going   --extra-widget tools/widgets/gui_barb_team_link.lua   --extra-widget tools/playtest/widgets/role_swap_test.lua
```

A game to watch and drive by hand: `--shots ""` (the camera widget then never
moves the camera), `--no-stop`, a long `--minutes`. The harness joins as a
spectator; the team link widget lets the spectating host command the AIs it
hosts.

The BARb AI window starts closed (owner: screenshots stay clear). The engine
also loads the copy installed in the game, and an older copy opens itself on a
fresh config, so `playtest_camera.lua` closes it in the first 10 seconds. A test
that needs it open opens it later with `WG.barblink.SetOpen(true)`, as
`role_swap_test.lua` does.

## Measuring widgets

Stage these with `--extra-widget`; each writes tagged lines to the infolog.

For the lane-renderer memory regression, install `lupa==2.8` into
`build-theatres/widget-test-deps` and run
`python tools/playtest/test_lane_ui_memory.py`. This uses Lua 5.1, disables
automatic GC while measuring each frame (as Recoil does), and checks actual
widget geometry and player selection. It does not substitute for engine rendering.
Stage `widgets/lane_ui_memory_watch.lua` with `../widgets/gui_barb_team_link.lua`
and use `checks/lane_ui_memory.json` for the engine check. Launch the graphical
`spring.exe --hidden --write-dir <isolated-dir> <isolated-dir>/script.txt`:
the observer calls the real widget DrawScreen from DrawGenesis's GL context,
pauses the simulation, clicks player rows for 90 seconds and logs memory.
Headless has no draw callbacks and correctly fails this check. Use a fresh
infolog before starting the watcher; all staging stays outside the live install.

| Widget | Lines | What it measures |
| --- | --- | --- |
| `widgets/build_area.lua` | `[BuildArea]` | The whole map's buildable ground at frame 30: a turret, a lab or an advanced fusion per 64-elmo cell, water by depth, tidal and wind. `build_area.py <infolog> --spot x,z --out map.png` draws it and measures it around a spot (D-120). |
| `widgets/team_stats.lua` | `[TeamStats]` | Every 2 minutes, per team: metal income, damage dealt and taken, kills, combat army value, units produced; the minute team 0 first reaches each income milestone. |
| `widgets/unit_census.lua` | `[Census]` | Live counts of watched unit types (T2 constructors, assist and assault bots, labs, turrets, spam units) and busy T1 labs (D-119). |
| `widgets/smiley_watch.lua` | `[Smiley]` | Turns on full map vision at minute 20, so a silo has a target, then screenshots each burst of AI map lines after minute 15 (a nuke's smiley, D-124). Run with `--shots ""`. |
| `widgets/gantry_watch.lua` | `[Gantry]` | The first TECH gantry: screenshots, build power, T3 production times. |
| `widgets/intro_test.lua` | `[IntroTest]` | The start-of-game drawing as a spectator receives it. |

## Pointing the camera

`--shots` takes `minute[@height[@x:z]]`: with `x:z` the camera centres on that
map position instead of the start (D-103), for structures placed away from it,
e.g. `--shots 25@1500@900:9660`.

## Connected mountain regression (D-145)

`prepare_mountain_regression.py --map supreme|glacial|ascendancy --dir
<repo>/build-theatres/<run> --dll <pinned DLL> [--side legion|cortex|armada]`
stages a 35-minute TECH duel with normal damage and an economy-only fixture.
It supplies no factories, constructors or combat units. `--survey-only` stages
a six-minute all-role survey (use Supreme). Legion is explicitly enabled;
extra and player Scavenger units are disabled. Ascendancy records a staged-only
TECH fallback override because its production role map is unregistered.

Launch with `playtest.py launch`, then watch with `--keep-going --minutes 35
--checks mountain_supreme` on Supreme or `--checks flank_effectiveness` on the
mountain maps. Use `--minutes 6 --checks mountain_survey` for the all-role survey.
Afterward run `verify_mountain_regression.py <directory> --run <archived run>`.
It requires every team to refresh its survey, explicit Supreme flank rejection
at sufficient income, or sustained recruitment and actual mountain movement
with observed combat on the positive maps. It writes `mountain-results.json`
and a dated map/settings scorecard. Functional success never overrides the
global invariant/error verdict; a diagnosed unrelated failure still exits 1.

# Playtest: launch, watch, screenshot, stop

## Organized storage

The [test definition catalog](../../doc/testing/README.md) indexes scenarios,
checks, native/AngelScript suites, tooling tests and parameterized runners by
domain. Regenerate with `python tools/knowledge/index_test_cases.py`; use
`--check` to detect stale documentation. Execution evidence remains separate.

[Storage conventions](../../doc/test-storage.md) define categories, naming,
immutable publications and history preservation. [Benchmark evidence](../../doc/benchmarks/README.md)
is indexed by domain without rewriting the historical records.

Cases now live under `cases/<domain>/<area>/`, checks under
`checks/<domain>/<area>/`. Existing short names and old explicit paths still
resolve. AIR arenas and scorecard runs allocate unique categorized directories
when `--dir` is omitted. Other preparers accept the directory returned by:

```powershell
$gameDir = python tools/playtest/storage.py allocate --domain tech --area economy --scenario rush-afus --map supreme --kind benchmark
python tools/playtest/playtest.py run --dir $gameDir --roles TECH --checks rush_afus --set 'RushObjective="afus"' --speed 8 --minutes 24
```

Archives use UTC IDs with a random suffix and retain setup/checks/build hashes
alongside their original report and log. `storage.py publish <archived-run>`
copies compact evidence into the categorized benchmark store; add
`--screenshot <filename.png>` for each selected image. It refuses conflicting
IDs and still-running snapshots. Raw game directories are never automatically
removed. Existing `--dir` workflows, scorecard comparison rules and rush history
remain supported.

Simulation updates must include actual in-game screenshots and analysis while
the match is running (owner instruction, 2026-10-01). Headless runs remain useful
for automated checks, but cannot provide visual evidence. Preserve screenshots
with the report and distinguish observations from log-derived conclusions.

D-179 radar/compact-factory fixture: allocate an AIR/combat supplied directory,
then `prepare_air_recon_check.py --dir <dir> --dll <pinned-dll> --map glacial`
(or `supreme --clusters`). Launch rendered and watch with
`--role AIR --checks air_recon --minutes 8`. It supplies twenty radar planes,
freezes building/production and keeps commanders passive. The cluster option
supplies six T2 labs and 120 turrets on native reservation positions. It checks
formation, MOVE ingress and base scouting, independently of economy or enemy-AA
penetration. See [settings and results](../../doc/air-opening-recon-plan.md).

D-171 committed AIR tests: `prepare_air_operations_cases.py --output
build-theatres/air-cases` generates supplied combat fixtures for five non-metal
maps. Run each with `air_arena.py run --case <json> --map <name> --side <faction>
--defender <faction> --dll <pinned-dll>`. `committed-home-incursion` verifies escort
ownership while an enemy raid appears at home; `defensive-t3` supplies one near
home heavy-unit incursion with real sight coverage. The arena's `once` and
`after_seconds` group fields support transient incursions without infinite
target replacement. `analyze_air_operations.py` separates actual bomber damage
and last-hit kills from the AI target cache's disappearance counters.

`run_air_natural.py --dir build-theatres/air-natural --dll <pinned-dll> --headless`
runs 45-minute ordinary-resource games on the same five maps. Glacial and the
north of Tundra need explicit test role assignments; Caldera uses an AIR duel
because its table has no TECH land start. `natural-fixture.json` records this.
Use `analyze_air_natural.py <write-dir>` for milestones and AIR command counts.
Counts are fixed sixty-game-second bins, not a rolling-window or FPS guarantee.
Headless staging disables automatic thread pinning only in that write directory:
multiple Recoil copies otherwise pin every main thread to the same preferred
CPU. Record host contention and affinity changes when comparing wall times.

D-170 metal maps: `prepare_metal_check.py --map "Full Metal Plate 1.7"
--output build-theatres/metal-map.as` supplies explicit start/role fixtures.
Stage with that `--map-file`, `--roles AIR,TECH`, `--minutes 30`, and
`--extra-widget tools/playtest/widgets/metal_watch.lua`; run the preparer again
with `--dir <staged-dir>` to register the fixture only in the isolated copy.
Also supported: SpeedMetal BAR V2 and Nine_Metal_Islands_V1. No resource gifts.
Watch with `metal_field`, then run `audit_metal_check.py <infolog> --metal
--output <audit.json>`. The audit reports the first forty-mex census, dense
neighbours, worker assignments, screen completion and factory events. Its focused
growth/converter verdict does not replace the full invariant verdict or guarantee
forty surviving mexes under combat. Use `metal_legacy` for `--ai-option profile=hard`.
Normal controls use `metal_normal_control` on Supreme and
`metal_normal_tech_control` on Glacial Gap, whose existing map has TECH starts.
See [implementation and validation](../../doc/metal-maps-implementation.md).

D-167 compact factory compounds: stage the `prepare_air_economy_check.py`
capacity fixture, then `prepare_air_cluster_check.py --dir <same-dir>`. Move the
capacity fixture's asset gift to six minutes to observe early wind before AFUS.
Watch with `--checks air_factory_clusters --minutes 25 --keep-going`: it
physically blocks an unused compound, verifies relocation, and observes wind
retirement plus expansion beyond the first six lab sites. The older
`air_clusters` checks still test six-wind clustering and natural fusion timing.
For natural runs, stage AIR/TECH and use the cluster preparer's `--observe-only`
option; retain strict `air_transition` checks. See
[design](../../doc/air-cluster-reclaim-plan.md) and
[results](../../doc/air-cluster-reclaim-results.md).

D-163 AIR campus obstruction: stage experimental AIR with `air_watch.lua` and
`air_opening_watch.lua`, then run `prepare_air_check.py --scenario capacity`
and `prepare_air_support_check.py` against that write directory. Launch rendered
and watch `--role AIR --checks air_support_repair --minutes 20 --keep-going`.
The fixture supplies late economy, places a real wall on a free support pin
after the first T2 lab starts, and requires twenty completed support turrets
with the original lab retained, then six or more labs. Native may remove a
ground-taken pin or retain it dead; the observer accepts either only with a
replacement pin, completed support and the original site still blocked.
For self-built AFUS milestones use `--scenario growth` / `--checks air_growth`:
ordinary reactors, converters and T2 constructors arrive at six minutes, with
zero advanced fusions supplied. These are capability fixtures, not natural
economic timings. See [D-163 results](../../doc/air-campus-strike-results.md).
For natural raid learning, run `audit_air_raid_feedback.py <retained-infolog>`.
It requires an observed resistance increase and a later mission while a failed
region is still excluded, then checks every later target against that region.
Its focused verdict does not replace the full match's invariant/deadline report.

Amphibious visual check (D-158): run `prepare_amphibious_check.py --map tundra
--dir build-theatres/<name> --dll <pinned-dll> --guarded --windowed --minutes 17`.
Then `playtest.py launch --dir <same-dir> --engine recoil_2026.07.04` without
`--headless`. The visual observer follows actual crossings and landfalls,
selects nearby wave members, and records labelled screenshots. Each capture
briefly slows game speed to 0.25 and then
restores it, allowing terrain and effects to render. The observer issues no unit
orders. Default rendered
speed is 3; override with `--speed`. Watch with `--checks amphibious`, then run
`audit_amphibious_check.py <same-dir> --log <retained-infolog>`. Units are supplied
and construction is frozen: this is a combat capability check, not an economy
or competitive benchmark. See [plan and results](../../doc/amphibious-operations-plan.md).

Strategic targeting (D-157): stage `--roles AIR,SUPPORT` for `juno` or `--roles AIR`
for `nuclear`, then run `prepare_strategic_check.py --dir <dir> --scenario <name>`.
The fixture pauses builders and its mobile probe only in the staged scripts,
injects stock, and preserves commanders. Launch headless and watch with
`strategic_juno` (9 minutes) or `strategic_nuclear` (11 minutes), then run
`audit_strategic_check.py <retained-infolog> --scenario <name>`. The independent
audit requires two launchers, respects actual launch times and checks five-minute
same-silo exclusion. These are controlled capability checks, not economy benchmarks.

Allied-layout/AIR-income regression (D-153): stage Cortex AIR with TECH allies,
`--roles AIR,TECH`, the final DLL, `allied_layout_fixture.lua` and `air_watch.lua`.
Run `prepare_air_check.py --dir <absolute-dir> --scenario natural`, then
`prepare_allied_layout_check.py --dir <absolute-dir>`. The latter appends
test-only probes to staged scripts. Use `allied_layout` checks for the first
four minutes. Add `air_income_fixture.lua` for the supplied low-income/full-bank
scenario (`air_income`, eighteen minutes), or `air_sustained_fixture.lua` for
income-only eligibility (`air_sustained`, twelve minutes). The sustained fixture
shares metal above 1,000 to team 1 while supplying generating assets; it must
log `player-team=0`. These are controlled fixtures, not PvP benchmarks.
See [design](../../doc/allied-layout-air-income-plan.md) and
[measured results](../../doc/allied-layout-air-income-results.md).

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
python tools/playtest/playtest.py launch --headless                             # explicitly launch the staged match without rendering
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
| `checks/shared/reliability/smoke.json` | 4 min | the AI and the widget load, the opening starts, a screenshot lands, no script error |
| `checks/tech/economy/tech_opening.json` | 14 min | D-066..D-068: opening mexes, first lab after them, energy, turret, advanced lab by 14; no mobile def packed, no combat production, no T1 lab re-ordered after 9 min, no native default tasks |
| `checks/rush_<objective>.json` | target + 1 | D-070: the chain announces the objective, the milestone finishes by the target; no script error, no combat production |
| `checks/shared/layout/wall_exclusion.json` + `widgets/wall_exclusion_fixture.lua` | 14.2 min | D-154: mixed AIR/TECH, rear own/allied-base assets remain unwalled while forward resource walls complete; global invariant forbid remains active |

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
and use `checks/shared/performance/lane_ui_memory.json` for the engine check. Launch the graphical
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

## AIR idle-factory regression (D-151)

AIR idle-factory regression (D-151): stage an AIR duel with `air_watch.lua`
and `air_opening_watch.lua`, then run `prepare_air_check.py --dir <absolute
workspace run directory> --scenario idle`. This staged-only controller pauses
team-0 recruitment from minute six through eight, without gifting resources.
Launch using an absolute `--dir` and watch with `--checks air_idle --minutes 10
--keep-going`. The natural `air_opening` suite now checks the first fighter
frame within five seconds of the third constructor, except an intervening
transport. The observer checks real factory queues and commander orders.

## AIR production and strike review (D-162)

`prepare_air_strike_check.py --dir build-theatres/<run> --dll <pin> --side
cortex --profile experimental_hard` stages a rendered thirteen-minute test.
Launch it with `playtest.py launch`, then watch with `--role AIR --checks
<run>/checks.json --minutes 13 --keep-going`. Repeat for Armada/balanced and
Legion/terrible. The fixture supplies early, mid and late fleets and targets,
freezes construction, and enables global LOS. It checks attributed ground
damage, air interception and return, with all invariants forbidden. Its
screenshots show interception, outbound aircraft, targets and impacts. It is
a capability test, not an economy benchmark or a human-PvP win-rate estimate.

The strike preparer pins both engine and AI RNGs with `--seed` (default 1621).
Use `--assembly-radius` only for a recorded staged calibration; production's
final radius is 600. Earlier D-162 natural runs and combat cases 01-13 omitted
the separate AI seed and are not reproducible paired experiments.

`prepare_air_economy_check.py --dir build-theatres/<run> --dll <pin> --scenario
constructor` supplies one T2 constructor at six minutes and freezes the enemy's
construction. Watch twenty-five minutes with `air_transition` to retain the
strict T2 deadline, and report `air_fusion_gift` separately for its intended
mex-before-fusion promise. `--scenario capacity` supplies a large economy;
watch forty-five minutes with `air_capacity` to exercise six T2 bays and their
twenty-turret prerequisites. Never count supplied assets as natural growth.

`air_capacity_opening` is a separate six-minute regression of the first lab,
three-constructor crew and immediate fighter order under the same gifts. It
does not replace the full capacity test. The opening observer records commands
before the first factory so an old mex order is not mistaken for a new one.
`air_watch.lua` logs remote constructor coordinates and commands on locality
failures; keep those failures visible rather than increasing the accepted radius.

For a natural comparison, stage the ordinary roster with `air_watch.lua`,
`air_opening_watch.lua`, `team_stats.lua` and `unit_census.lua`, then use
`prepare_air_check.py --scenario natural --seed <same seed>`. Pin the game,
map, engine, roster and DLL/data for each run. `compare_air_runs.py <logs...>
--output <report.json>` reports the 0–10, 10–25 and 25–50 minute windows without
altering verdicts. Damage, nominal kill value and aircraft loss are separate
metrics; missing kill instrumentation in old runs is not evidence of zero kills.

`prepare_air_check.py` now pins both RNGs too. A sandbox that cannot enumerate
the engine process can make `watch` report a false early exit while the engine
continues. Preserve that report and re-run observation with process access;
report the full captured game duration, not the second watcher's wall time.
Measured outcomes and limitations are in [the D-162 report](../../doc/air-enhancement-results.md).


## AIR completed-support regression (D-155)

Stage an Armada AIR duel with `widgets/air_watch.lua`, then prepare with
`prepare_air_check.py --dir <run> --scenario capacity`. Run 45 minutes with
`--checks air_support --wall-minutes 20 --keep-going`. The observer independently counts completed
turrets within reach, uniquely assigned to existing factories, at every new
T2 lab frame (INV-090); the check requires supported expansion through the
sixth lab. The fixture supplies an economy, so its timings are capacity evidence.
Use `--scenario constructor` with `--checks air_transition --minutes 25` for
the unboosted economy with a T2 constructor donated at six minutes.

The launcher and process lookup now resolve relative run directories before
starting or locating the engine; its working directory is the engine directory.

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

## Amphibious capability fixtures (D-158)

`prepare_amphibious_check.py --map tundra|supreme|serene --dir build-theatres/<run>
--dll <pinned DLL> [--profile experimental_balanced]` stages two allied TECH/AIR
controllers with both Telchine and Marauder waves. Launch with `playtest.py
launch`; judge with `playtest.py watch --checks amphibious`.

The fixture uses real map terrain and checks full unit footprints before giving
troops. It gives landing/backline economic targets and T1 defenders, enables
global LOS, keeps the target team alive with `deathmode=neverend`, freezes
autonomous builder/factory work, overrides only the staged role assignments and
TECH combat-income guard for injected troops, and observes real positions and
damage attribution. This is a movement/combat capability test, not an economic
opening or competitive win-rate benchmark. Original engine logs and each failed
attempt remain in the isolated directory's `runs/` archive.

Run `audit_amphibious_check.py <directory> --log <archived infolog.txt>` after
the watcher. Both checks must pass: the audit requires every injected member
to cross and land, substantial forward movement and a secured foothold for
each role/type, and attributed kills by both unit types. FRONT control units
must be present and must never enter the new controller. Add `--guarded` when
preparing Tundra to place a known torpedo tower across the approach; the audit
also requires actual underwater positions to remain outside its weapon radius.
On Serene use `--marauder-delay-seconds 120` to give Telchines independent combat
time before faster Marauders clear their shared landing targets. The manifest
records this fixture-only stagger; it does not alter production policy.

## Natural Telchine match and naval-retreat probe (D-159)

For an ordinary 16-AI Tundra game, stage `--map "Tundra Continents v2.3.1"
--roles all --role TECH --side legion --speed 8 --minutes 60 --shots ""`
with `--modoption experimentallegionfaction=1 --modoption deathmode=com
--modoption nowasting=disabled --modoption dynamiccheats=0` and
`--extra-widget tools/playtest/widgets/telchine_match_watch.lua`.
Add `team_stats.lua` and `unit_census.lua` for economy/army context. Use a pinned
DLL and game, verify script API parity, then launch. The observer gives no units,
income or orders. Check the roster: Tundra's existing role distribution is
asymmetric, so it is not a mirrored balance benchmark.

The observer captures actual landfalls and first combat, and logs production,
positions, naval hits and pursuit candidates. During a run, write a line
`unique-key X Z HEIGHT Caption` to `LuaUI/Config/telchine_camera.txt` for another
camera capture; `telchine_speed.txt` sets the requested speed after captures.
Both files belong in that isolated write directory. Show screenshots with
behavioral analysis during the run, as the owner requests.

Judge with `--checks telchine_match --keep-going`. After `TelMatch gameover`,
archive/stop promptly with `playtest.py watch` using the reached game minute.
Run `audit_telchine_match.py <archived infolog.txt> --output <summary.json>`;
it excludes every post-GameOver event from match results. A clean pursuit
counter without a naval encounter is inconclusive. Invariant failures remain
failures even when all landing checks pass.

`prepare_telchine_shore_check.py --dir build-theatres/<run> --dll <pinned DLL>`
stages a separate rendered twelve-minute Tundra capability probe. It injects
six TECH Telchines and freezes builders/production. After autonomous landings
and a dry hold at the final island, an enemy battleship retreats after a real
weapon hit. The fixture orders only enemy team 2. Recoil's `godmode 3` grants
spectator order permission, not invulnerability; spectator access is retained
to read all Telchine command queues. The screen explicitly labels the test as
controlled. Launch and judge with `--checks telchine_shore --keep-going`.
Passing requires a live ship over 1,000 elmos from the firing anchor, one minute
of dry Telchine samples in hold-position state and no submerged naval attack
orders. Onshore automatic firing is allowed. A killed/stationary
target or failed fixture must not be counted as a passing retreat test.

See [the Tundra results](../../doc/tundra-8v8-telchine-analysis.md) for timing,
strict failures, screenshots and production/garrison limitations.

## Retained beachheads and paired natural rosters (D-160)

`prepare_telchine_shore_check.py --beachhead --dir build-theatres/<run>
--dll <pin> [--owner-role AIR] [--profile experimental_hard]` injects twelve
Telchines and two allied island factories. Economy and production remain
frozen, every Telchine order remains autonomous, and only the enemy ship is
ordered to retreat. Judge with `--checks telchine_beachhead --keep-going`.
The test requires a three-unit retained guard, at least three advancing
attackers, surviving assets/ship and dry hold-position samples after escape.

Add `--allied-guards` with TECH ownership to inject twelve additional AIR
Telchines competing for the same island. Judge using
`--checks telchine_allied_beachhead`; use `--minutes 16`; exactly three units must remain on
that island after all twenty-one attackers advance, before the naval probe begins. This tests
inter-AI claims without providing any Telchine movement orders.

`prepare_telchine_match.py --dir build-theatres/<run> --dll <pin> --seed 1601`
stages all sixteen normal AIs with paired role/faction rosters and explicit
engine/AI seeds. Each allyteam gets one TECH, one AIR, two TACTICAL and four
SEA roles. Real start coordinates remain; Tundra terrain is not symmetric.
There are no unit gifts, resource boosts or production overrides. Launch,
watch with `telchine_match`, stop at GameOver and run the GameOver-aware audit.
Compare [the D-160 results](../../doc/telchine-beachhead-results.md), including
strict failures and the owner's decision to preserve TECH's lab cycle.

D-160 found that the spectator commander can survive on the extra team and
delay engine GameOver (KI-453). The audit now reports the first all-dead
competitive-side census separately, when `teams.json` and `team_stats` are
available. This is an upper bound, not the exact elimination timestamp.
Do not use later landfalls as competitive impact or these runs as clean
PvP benchmarks until the spectator-team startup issue is corrected.

## Telchine terrain and formations (D-161)

Prepare `prepare_telchine_shore_check.py --beachhead --minutes 16 --dir
build-theatres/<run> --dll <pin>` and watch with `--checks telchine_perimeter
--minutes 16 --keep-going`. For AIR add `--owner-role AIR` when preparing
and **`--role AIR` when watching**. The watcher otherwise cannot identify the
team under test. The stricter observer waits for exactly three retained guards
and nine onward attackers before presenting the ship. It measures actual dry
positions, at least 100 elmos minimum separation, at least 280 elmos perimeter
span, ten stable samples, and terrain-only `Spring.TestMoveOrder` legality.
All invariants and illegal movement targets remain forbidden.

`--land-attack --minutes 8` adds six land targets to the six-unit TECH fixture.
Watch with `--checks telchine_land_formation --minutes 8 --keep-going`.
This requires dry travel, fitted formation slots, attributed Telchine weapon
fire from dry ground, nearby dry formation spread and a destroyed target.
The fixture injects targets but never orders friendly Telchines. These are
controlled capability tests, not evidence of natural recruitment or PvP wins.
See [D-161 results](../../doc/telchine-perimeter-results.md).

For inland coverage, prepare `--land-attack --map supreme --minutes 8` and
watch with `--checks telchine_inland_formation --minutes 8 --keep-going`.
Land-combat samples are taken after minute one; the check requires formation
deployment before attributed fire and actual dry spread. This excludes firing
from the initial spawn cluster. Frozen fixture energy can limit heat-ray fire,
so the resulting casualty totals are not a combat-efficiency benchmark.

## AIR economic districts and constructor ownership (D-164)

After staging a rendered AIR game under `build-theatres`, prepare
`prepare_air_check.py --scenario growth --seed 1002164 --dir <run>` followed by
`prepare_air_economy_zone_check.py --dir <run>`. Watch with `--role AIR --checks
air_economy_zone --minutes 25 --keep-going`. Ordinary reactor income and two
T2 constructors are supplied at six minutes; no AFUS is supplied. A physical
wall blocks a planned unused reactor pin, and the probe requires relocation
before advanced economy placement. A confirmed three-minute factory guard
assigned to an advanced aircraft must release it within five seconds; its T1
peer must keep that same task. Module reinitialization checks saved slot/zone
adoption. This is controlled capability evidence, not a natural economy score.

For the larger capacity fixture use `--scenario capacity --seed 1002165` and
`--checks air_economy_capacity --minutes 20`. For natural AIR/TECH games use
`--scenario natural`, prepare the probe with `--observe-only`, and watch with
`--checks air_economy_natural --minutes 42`. Observation-only preparation adds
no orders, units or resources. `audit_air_economy.py <infolog> --output <json>`
summarizes worker tasks, reactor/factory completions, aircraft production and
sampled bank occupancy. See [results](../../doc/air-economy-zone-results.md).

## Supplied AIR combat arena (D-165)

`air_arena.py` runs two experimental AIR opponents without economic build-up.
Missing attackers, fighters, targets and AA are replenished; surviving aircraft
keep their real AI tasks. Radars cover both teams' standard start positions.
The default uses normal radar/LOS plus supplied scouts. All overrides and source
hashes are recorded in `arena-manifest.json`; the live installation is untouched.

```powershell
python tools/playtest/air_arena.py list
python tools/playtest/air_arena.py run --dir build-theatres/air-baseline --case t2-intercept --side armada --defender cortex --minutes 18 --speed 12
python tools/playtest/air_arena.py matrix --dir build-theatres/air-matrix --cases t1-economy,t2-intercept,t2-flak,gunship,torpedo --sides armada,cortex,legion --seeds 1651,1652 --minutes 18 --speed 12
python tools/playtest/air_arena.py summarize --dir build-theatres/air-matrix
python tools/playtest/air_arena.py run --dir build-theatres/air-continuous --case t2-flak --endless
python tools/playtest/playtest.py stop --dir build-theatres/air-continuous
```

Endless mode disables fixture autoquit and game victory termination. It keeps
running until explicitly stopped. Bounded runs use the same replenishment rules
and archive their exact log, manifest, screenshots, strict report and
`arena-results.json`/`.md` together. Matrix runs are serial and return failure
if any case fails. Use a fresh directory for each comparison. A live/stale PID
must be cleared through the scoped stop command before restaging.

Cases are JSON under `cases/air/combat/`. Change aircraft, counts, targets, AA, positions
and refill period there; a custom JSON path works with `--case`. `--unit armlance`
replaces the primary attacker, `--fighters 0` isolates static AA, and
`--visibility global` is an explicitly labeled omniscient diagnostic. Built-in
coordinates require Supreme Isthmus v1.7; other maps need a custom case. Case
counts are replenished pool ceilings, not forced AI wave sizes.

The optional `sensors` list can supply extra detection, such as sonar for
submerged targets. `torpedo` tests exposed forward naval targets;
`torpedo-covered` moves them closer to the defender and supplies attacker sonar.
The fighter AI still respects its normal friendly-territory boundary.

Ordinary T1/T2 bomber results identify actual launch cohorts, target damage,
target destruction, losses, survivors, home returns and detection-to-fighter-hit
latency. Completed and unfinished sorties are separate. Aircraft-class totals
also cover native gunships, paralysis and torpedo attacks without inventing
bomber waves for them. Radar detection and the home-screen response flag can
concern different contacts, so use attributed fighter fire for interception.
An AI policy hold is an outcome; the fixture never orders a raid to force a pass.
Bounded audits cut off at the configured game frame, excluding extra simulation
time while the watcher stops the process. Endless observations use the watcher's
reported cutoff. `summarize` compares one final archive per case without counting
its root convenience copy again.

Energy storage/production and stockpile ammunition are supplied. Economic and
escort launch gates are waived for the default bomber-only drill. These are
controlled combat measurements, not PvP balance or economy scores. The loaded
aircraft catalog includes support/optional units and is not behavior coverage:
transport delivery, construction, radar-plane missions and specialist payload
coordination need their own acceptance criteria. Legion's T1 preset uses its
gunship, not a fictitious level bomber. See the [plan](../../doc/air-combat-arena-plan.md)
and [measured results](../../doc/air-combat-arena-results.md).

For committed AIR operations, `committed-home-incursion` checks that all living
escorts stay assigned during a home raid. `defensive-t3` supplies enough payload
for a Shiva and requires an actual hit and completed home return.
`blocked-backline` supplies heavy economic AA and requires a frontline plan and
actual artillery damage. These cases select their own strict checks. The
five-map generator and natural-game runner are documented with their evidence
in [D-171 results](../../doc/air-committed-operations-results.md).


## Funded AIR workforce (D-181)

`run_air_workforce.py --dll <pinned-dll> --scenario donations --side armada`
allocates a fresh supplied game, checks script/DLL parity, stages the workforce
probe and independent observer, and runs sixteen simulated minutes. Scenarios
`donations`, `six-labs`, `energy-starved` and `lifecycle` have definitions under
`cases/air/economy/workforce-*.json`. Donor gifts use real allied transfers and
stop at ten minutes. Other teams are frozen; these are capability fixtures.
`audit_air_workforce.py <write-dir>` applies the case's physical observations
without suppressing the original whole-game invariant verdict.

`run_air_workforce_cohort.py --dll <dll> --baseline <data-snapshot>` pins both
data trees and runs five maps at thirty minutes for three seed/faction pairs.
Its default two concurrent games are correctness/economy measurements, not
wall-time performance measurements. `run_air_natural.py` also accepts explicit
`--seed` and `--side`; both engine and AI seeds are pinned. The analysis reports
actual usage, full-bank point samples and workforce observations. Missing or
nonmatching metadata invalidates comparison; samples cannot be integrated into
invented total donations or overflow.
`analyze_air_workforce_cohort.py <cohort>` compares common live AIR windows;
`--final <five-map-repeat>` compares a later Armada repeat with its original
matched baseline. AI elimination censors the window, even if the spectator
clock keeps advancing. Published initial analyses remain immutable; record a
new derived cohort analysis when correcting interpretation.

`run_workforce_regressions.py --dll <dll> [--subset metal|tech]` exercises three
metal maps plus the unchanged TECH opening/rush. `run_workforce_performance.py
--dll <dll> --baseline <data> --revised <data>` runs serial 8v8 controls with
one AIR per team and then multiple AIR roles. Run it while other simulations
are stopped. Its engine AI timer aggregates all AI callbacks; it is **not**
a per-role or per-census profiler. The command observer remains authoritative
for synchronized APM. See [results](../../doc/air-workforce-results.md).
`analyze_workforce_performance.py build-theatres/workforce-performance.json`
reports cumulative engine-wide p50/p95/max, minute speed observations and
AIR-role order counts. It never treats absent timing as zero cost or relabels
engine-wide timing as individual AIR CPU time.
Windows after an AI is eliminated are labeled as changed-population comparisons.
`run_workforce_scaling.py --dll <dll> --baseline <data> [--revised <data>]`
holds factory/builder production and supplies 100, 500 and 1,000 idle air
constructors. This isolates fixed-population observation overhead, not active
project or combat throughput. Compare full minute windows after each spawn
settles; spawn frames are not steady-state measurements.


## SEA migration benchmarks (D-188)

`python tools/playtest/run_sea.py --dll <pinned.dll> --map glacial --minutes 30`
allocates categorized storage, stages current data with SEA migration enabled,
checks the staged scripts against the DLL, and records screenshots plus the
independent `sea_watch.lua` census. `--legacy` disables migration in staged data;
`--data <tree>` selects another source and `--profile` selects the profile.
`--roles` filters existing map spots: inspect `teams.json`, since a filter does
not create a role for which the map has no selected spot.

`run_sea_cohort.py --dll <dll> --baseline <preserved-data> --maps glacial,supreme,tundra,caldera,erebos`
copies/hashes both trees before paired thirty-minute games. Concurrent runs
cannot establish CPU/FPS improvements. The same AI seed does not guarantee
engine-wide determinism. Both teams use one variant per match, not candidate
versus baseline in the same match.

`run_sea.py --dll <dll> --fixture harbor --profile experimental_balanced --minutes 20`
is a supplied Glacial Armada lifecycle fixture. It supplies economy, storage,
advanced builders and stationary cover, freezes other teams' construction,
and supplies no factory/reclaim orders. Tests require reservation adoption,
physical-blocker replan, actual replacement production/exit and old-yard reclaim.
An independent engine observer checks departure precedes reclaim and no product
remains in the old yard. This is not a natural-economy score.

`analyze_sea.py <archive/infolog.txt> --output <new-score.json>` writes an
immutable scorecard. Empty-team checkpoints indicate elimination; compile-only
or no-egress logs cannot pass physical checks. General departures use 320 elmos,
harbor retirement 480. Older observers lack complete censored-product/delay
denominators; retain original evidence and label limits. API checks accept
`--scripts <staged-script-root>` for a pinned cohort. Publish completed archives
with `storage.py publish`, preserving supplied versus benchmark metadata.
See [migration results](../../doc/sea-layout-migration-results.md).

## SEA combat and response (D-189)

`sea_arena.py --dll <dll> --case surface-line` supplies forces on Glacial Gap;
the AI retains all combat command ownership. Ordinary cases freeze constructors
and factories. Response cases supply economy and keep real factory production;
`support_turrets` permits static assistance and native recovery-submarine work
while economic constructors/commanders remain frozen. Production waits until
frame 600 so the supplied workforce exists before the first admission. Older
fixture versions froze recovery units too and raced initial constructor creation;
keep those original outcomes, but use matched harness versions for comparisons.
`run_sea_combat.py` pins paired control/candidate cases. The optional case
`checks` selects physical acceptance conditions: `legion-t2-production` requires
both an actual T2 constructor and an actual combat ship to finish. Use Legion
with `experimental_terrible` and `experimental_balanced` to exercise missing
and existing native factory metadata respectively.

`analyze_sea_arena.py <log> --output <new-score.json>` measures damage, loss,
production, detection/order timing and command sources. Gadget-generated orders
are reported separately where the observer supports it; engine callbacks are
not network bytes. `carrier-release` independently checks host destruction;
surviving released drones require a separate observation of resumed combat.
Do not count a reached-duration smoke PASS as a combat win. See the
[combat plan](../../doc/sea-combat-enhancement-plan.md) and
[unit/control review](../../doc/sea-unit-controls.md).


## Dense economy and naval support fixtures (D-190)

`python tools/playtest/run_dense_economy.py --case air|sea|support --dll <pinned DLL>`
stages isolated Glacial games with supplied constructors/resources. Cases and
checks live under `cases/{air,sea}/layout/` and `checks/{air,sea}/layout/`.
The Lua observer measures completed footprint adjacency with facing, and actual
turret repair/guard commands at busy shipyard/amphibious products. It rejects
dry naval spawns. The staged script probe owns finite fixture work; it is never
included by production data. Every run records staged hashes and overrides.
Use natural `run_sea_cohort.py` for economy comparison, not these supplied games.

## SEA economy blocks on Supreme (D-191)

`python tools/playtest/run_sea_economy_block.py --dll <pinned DLL>` verifies
ordinary builder movement; add `--experimental` for migrated movement. The
fixture supplies water factories/constructors and resource banks, then requests
finite converter/fusion work through production placement code and two finite
factory production waves. It does not test natural admission decisions. The
observer measures completed converter adjacency/retention, square turret grid,
actual factory/fusion assistance, orphan reach, and the rear reactor footprint.
Use normal `run_sea.py --legacy` to test the new placement adapter with existing
SEA decision rules. `--keep-going` preserves failed checks while continuing to
the requested horizon. Failed observations are never reclassified as passes.

## Allied naval bases (D-192)

`python tools/playtest/run_sea_allied_base.py --dll <pinned DLL>` runs six
SEA/AIR/TECH players on Supreme and attempts foreign placement inside every
role's empty economy/factory reservations. All 12 directed class checks must
pass; unrelated invariants still fail the overall report.

Add `--supplied` for six SEA players on Glacial. The opening shipyards are
built normally; the fixture then supplies constructors and resource banks,
requests economy and a later yard, and overrides the income-derived yard cap
only for that explicit test demand. It verifies placement, not tech timing.
The independent Lua observer checks all three western allies' completed yard
footprints/facing and foreign construction within claimed tidal blocks.
`run_sea.py --legacy --base-observer` retains ordinary economy decisions while
checking later yard geometry. Both runners use isolated categorized games;
publish original reports, failed iterations and screenshots with `storage.py`.


## AIR recon deadlines and base response (D-193)

`python tools/playtest/run_air_response.py --case partial --dll <pinned DLL>`
runs three radar planes through the normal waiting wall and deadline. `full`
checks the ordinary twenty-plane release. `defense` supplies parked T2 bombers
and real production against two northwest Marauder pushes on Supreme; `t1`
checks lower-tier faction fallbacks, `small` supplies only two parked bombers,
and `outside` checks visible intruders outside the base radius. Use `--side`
for Armada/Cortex/Legion, `--profile` for experimental profile compilation,
and matched `--data --dll --baseline` for old-build comparison. Resources are
supplied and builders frozen; these are response tests, not economy benchmarks.

The observer records actual damage, deaths, aircraft orders and screenshots
under ordinary LOS/radar. A twenty-unit reserve is a production target, not a
guarantee of defeating T3 with T1 aircraft. `air_arena.py run --case
base-response-commitment` adds simultaneous home ground/air contacts while
measuring retained offensive escort ownership. The natural runner and arena
API checks honor their pinned data rather than comparing an old DLL to current
repository scripts. See [results](../../doc/air-recon-base-defense-results.md).

## AIR patrol and naval relief fixtures (D-194)

`python tools/playtest/run_air_naval_support.py --case patrol --dll <pinned DLL>`
uses the live AIR controllers with ordinary LOS/radar/sonar. `partial`, `full`
and `zero` test recon deadlines, full waves and zero-weight physical AA.
`naval` permits real factory production; `stall` supplies only two aircraft.
`sub`, `aa`, `factory` exercise ASW mismatch, light AA and a shipyard-only ally.
Negative controls: `parity`, `hover`, `remote`, `basin`, `danger` (heavy naval AA).
Use `--side armada|cortex|legion`, `--map supreme|glacial`, `--profile` or
`--headless`. Cases are runner variants; generated checks/fixtures/manifests
are archived separately in categorized raw game directories. Supplied resources
and frozen economic builders make these combat tests, not economy benchmarks.

`python tools/playtest/analyze_air_naval_support.py <archive>` adds a separate
post-run summary of launches, actual damage, patrol commands, AA escape and
observed team-0 AIR orders. It never rewrites the original verdict. Publish
failed iterations and their explanations along with corrected repeats. See
[results](../../doc/air-patrol-naval-support-results.md).


## Whole-AI performance observations (D-195)

See the [ranked Shore review](../../doc/reviews/2026-10-04-skirmishai-performance-review.md)
for exact fixtures, pinned hashes and limitations. Stage `skirmish_perf_watch.lua`
and `air_command_watch.lua` as extra widgets in an isolated rendered game. The
scope observer enables engine profiling by default; `LuaUI/Config/skirmish_perf.lua`
can return `{profiling=false, changes={{minute=18,enabled=true},
{minute=19,enabled=false}}}` for within-match control intervals. Disabled scope
values are unavailable, not evidence of zero AI CPU. FPS remains observable.
Use normal-speed windows and retain achieved speed as well as requested speed.

`analyze_skirmish_performance.py <write-dir>` summarizes the completed infolog
into `skirmish-performance.json`. Run it before final publication, or use a new
filename when adding final analysis to an archive that already recorded an
interim snapshot. Never overwrite published evidence. Scope intervals overlap;
command events and `fromLua` observations are not network-packet counts.

`sample_process_instruction.ps1 -TargetPid <explicit-benchmark-pid>
-OutputPrefix <scratch-prefix> -Seconds 30 [-ThreadIds <comma-separated-ids>]`
provides a fallback when WPR is unavailable. It briefly suspends/resumes only
threads verified to belong to that spring process, records instruction locations
and before/after thread CPU, and requires matching symbols for attribution.
These are randomized wall-clock samples, not ETW CPU samples or runtime stacks.
Measure its overhead and keep it out of ordinary gameplay tests.

`perf_spectator_cleanup.lua` is a narrowly guarded fixture for the documented
16-AI/17th-spectator roster only; it removes the harness spectator commander,
not competing units. Use `shared/performance/skirmish_cpu_clean` checks and
require the explicit zero-spectator/16-AI verification. Do not silently substitute
it into arbitrary games. The discovery and failed control fixtures are retained
separately from the final clean-roster control.


The final D-195 observer also records `[SkirmishPerfEnd]` and
`[SkirmishPerfTeamDied]`; reusable performance checks forbid premature GameOver.
These hooks were added after the control's awards overlay exposed a missing
lifecycle observation. Do not call an elapsed forty-minute log a competitive
forty-minute match without checking these events and active-team state. The
original D-195 late control is explicitly excluded, not retroactively repaired.

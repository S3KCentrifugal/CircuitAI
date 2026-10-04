# AIR factory handoff and idle commander (D-151)

## Plan before implementation

The owner's game reproduces the fault after D-150. In the latest Supreme
Isthmus match in the live infolog, AIR teams 6 and 9 finish their crew and
then guard idle plants. At frames 4386/4389 energy income is about 130, banks
are above 1,150, and aircraft demand is 124. The fixed 160-income recruitment
gate still refuses fighters. First interception orders arrive only at frames
4799/4810. Commander placement is restricted to current reach once a flying
constructor exists, so an occupied local patch repeatedly falls through to
factory guard. The guard timeout works; the repeated decision is wrong.

1. After the scout and three completed constructors, recruit the initial
   defensive fighter floor before optional constructor scaling and ordinary
   income gates. Queue one aircraft per factory decision, retain pending-count
   accounting, and keep allied transport requests ahead of this rule. Energy
   recovery buildings retain higher priority than this initial fighter queue.
   Credit fighters of other types and exclude Legion's opening scout drone.
2. Treat an unfinished plant or a live RECRUIT task (including the brief
   pre-frame cold start) as useful factory work. Once the crew exists, never
   renew commander guard on a completed plant without recruitment.
3. Prefer reachable economy construction and assistance. If the plant is idle
   and no local site fits, allow a bounded move to nearby economy work or an
   unfinished project being built by an aircraft. Assist the actual structure,
   rather than following a flying constructor across the map. Keep mex work
   with the aircraft, retain six-wind clusters, and use an AIR-only search
   radius. If no useful task exists, wait briefly and re-evaluate.
4. Add pure decision tests, a runtime invariant against idle-factory guards,
   and independent game observation of the first fighter frame immediately
   after crew completion. Exercise a deliberately paused factory to prove the
   commander leaves for economy work. Run natural faction openings plus the
   controlled idle fixture; keep all invariant checks enabled.

TECH policy and the native DLL do not need changes. Publish updated scripts
with the existing pinned DLL, update role references and the actor matrix,
record all simulation results, and commit locally without pushing.

## Implementation and verification

The [recruiter](../data/script/src/manager/air_production.as) admits the initial
screen at NORMAL priority before ordinary income gates and constructor growth.
[Commander actions](../data/script/src/roles/air_build.as) read live recruitment
and select useful work. [Placement](../data/script/src/manager/air_layout.as)
retains local-first six-wind packing and adds a bounded nearby search. The
[AIR setting](../data/script/src/global.as) owns that radius; the role-neutral
[decision helper](../data/script/src/helpers/production_math.as) and
[tests](../tests/production_math_tests.as) cover idle, recruiting, unfinished
factory and unfinished crew states, plus scout exclusion from the screen.

The independent [observer](../tools/playtest/widgets/air_opening_watch.lua)
checks actual first-fighter frame timing and commander commands. The
[opening checks](../tools/playtest/checks/air/economy/air_opening.json) and
[idle checks](../tools/playtest/checks/air/economy/air_idle.json) retain all invariant forbids.
The [fixture preparer](../tools/playtest/prepare_air_check.py) pauses only the
staged team-0 production controller from minute six through eight; it supplies
no economy or units. This distinguishes a useful queued recruit's startup
delay from a truly idle factory. The [playtest guide](../tools/playtest/README.md)
describes how to repeat it.

References updated: [AIR](roles/air.md), [actions](roles/air_build.md),
[rules](roles/air_rules.md), [actor matrix](actor-matrix.md),
[invariants](invariants.md), [known issues](known-issues.md), [previous design](air-opening-and-screen.md), and
[D-151](decisions.md#d-151--air-leaves-idle-factories-and-immediately-recruits-its-first-screen).

67 executable policy tests pass; the script API check finds zero mismatches
against the unchanged build-06 DLL. Role-document and invariant checks pass.
The documentation link check retains only the eight existing missing-hover
links (KI-404). No native source, TECH controller, profile JSON or sample data
changed. Published scripts match the natural-run snapshot and the required
build output. DLL SHA-256 remains
`7f7941c38db5868ca7137989fbbfd38201ee363062151754904f89e0c1d1a8cb`, with its
existing matching debug symbols. The live game install is untouched.

The first run `d151-armada/runs/20260930-182104` confirmed a 0.97-second first
fighter handoff but failed the new actual-command invariant. Script chose
`commander.idle.wait` at frame 8833; the old engine GUARD remained at frame
9120. `CBWaitTask` intentionally preserves commands, so the final script calls
the existing `CCircuitUnit.CmdStop()` before an idle wait. The failed run is
retained, and the observer was not weakened. Other initial faction runs were
interrupted to use this correction. An earlier relative-directory launch
failed before loading; KI-438 records that separate harness issue.

Final Armada opening: `d151-final-armada/runs/20260930-182716`, PASS through
12 minutes, first fighter frame 1.07 seconds after the crew completed.
The forced-idle run `d151-final-idle/runs/20260930-182902` also passes; its
first fighter frame takes 0.83 seconds. During the actual six-to-eight-minute
pause, the independent observer sees commander REPAIR commands at frames
11100–14100 on windmills, a construction turret, energy storage and an advanced
solar. Their completions are recorded independently by `AirWatch`. No stale
guard, script error or other invariant is reported. The idle check requires
work inside the forced pause, not merely earlier natural idle assistance.

Final natural results, all through 12 minutes on Supreme Isthmus v1.7,
`test-31450-6562fb1`, `recoil_2026.07.04`, experimental_hard, seed 930146,
zero bonus and no gifted economy/units:

| Faction | Third constructor | First fighter frame delay | Verdict | Original report under `build-theatres/air/` |
| --- | --- | --- | --- | --- |
| Armada | 3:06.5 | 1.07 seconds | PASS | `d151-final-armada/runs/20260930-182716/report.md` |
| Cortex | 2:53.9 | 1.50 seconds | PASS | `d151-final-cortex/runs/20260930-182929/report.md` |
| Legion | 2:51.5 | 1.27 seconds | PASS | `d151-final-legion/runs/20260930-183008/report.md` |

Each final run has zero script/crash/invariant failures. The completed logs
also pass the tightened checks requiring both a first fighter frame and a
finished first fighter (separate matches), plus actual engine patrol orders.
The latest judged reports remain in each directory. These tests establish the
opening handoff and idle behavior, not a new 20-minute fusion result or PvP
win-rate measurement. The existing reactor timing issue remains KI-436.

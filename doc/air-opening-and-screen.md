# AIR commander opening and fighter screen

## Design before implementation (D-150)

The owner wants the commander to exploit its build power instead of walking
between mexes, with scouts first, three air constructors next, and then a
fighter wall initially protecting the backline/TECH player. Existing transport
requests remain the higher-priority exception. All owned mex upgrades still
precede fusion, and TECH policy must remain unchanged.

1. Keep the initial pre-factory resource opening. After an air factory is
   framed, the commander finishes it and guards production until three live,
   completed T1 air constructors exist. Aircraft then own remote mex work.
   The commander prefers local energy/support and factory assistance thereafter;
   energy-stall recovery may supply nearby energy to avoid a production deadlock.
2. Use one finite initial scout quota (default one), then three constructors,
   then fighters. Pending recruits and unfinished frames prevent duplicate
   orders but do not release the commander early. Scout losses must not restart
   the opening indefinitely. Retain minimum constructor recovery after losses,
   and retain transport-first recruitment.
3. Wind placement first tries existing free cluster slots in the commander's
   current build reach, then a complete new 3-by-2 group within that reach.
   Retain snapping margin, factory reservations, cluster separation and atomic
   rollback. Only the pre-aircraft opening may fall back to walking when no
   local site fits; later flying constructors perform remote growth.
4. Add a generic opt-in patrol traversal to the existing native route task,
   default off. Script owns fighter membership, anchor, width, progression and
   timings. Group fighters into short patrol segments across a line facing the
   enemy. Anchor at the nearest allied TECH start when known, otherwise AIR's
   own start. Use participating enemy starts to bound the forward direction;
   approach but do not cross the estimated front. Recompute from live fighters,
   shrink after losses, and clamp all endpoints inside the map.
5. Include T1 and T2 fighters in the screen, preserve exclusive bomber-wave
   escort membership, and clean up screen tasks on role exit. Width/advance
   grow from a small rear screen toward a bounded frontline screen; keep the
   settings in AIR and the geometry/count arithmetic pure and testable.

Validation will execute the shared AngelScript tests and native suites, then
load a pinned DLL/script pair in isolated games. An independent observer will
check production order, actual commander guard/build targets and movement,
wind distance from the commander, patrol commands/positions, screen growth
and losses. Natural opening runs and supplied-fighter screen fixtures will be
reported separately. Any reactor deadline failure remains visible. Commit
locally; the owner's latest instruction is to keep commits local.

## Implementation

D-151 corrects two D-150 choices: the initial fighter floor now bypasses the
ordinary income gate, and the commander can move a bounded distance for
economy work after the crew if its factory is idle. The original D-150 evidence
below is retained; see [the correction and validation](air-idle-factory.md).

[AIR production](../data/script/src/manager/air_production.as) latches the
finished scout in native layout state, counts pending frames separately from
completed constructors, and keeps bomber escorts exclusive with the screen.
[Economy counts](../data/script/src/manager/air_economy.as) resolve owned IDs.
[Ordered rules](../data/script/src/roles/air_rules.as) dispatch the commander
to [local work and factory guard](../data/script/src/roles/air_build.as) before
general economy work. [Placement](../data/script/src/manager/air_layout.as)
tries local cluster holes and an entire reachable group with a 16-elmo snap
margin; once a constructor completes, the commander cannot choose a remote group.

[AirScreen](../data/script/src/manager/air_screen.as) distributes individual
fighter routes across at most eight cells. Four or fewer fighters use a
600-elmo rear line; forty reach a 6,000-elmo line, ending 600 elmos behind the
midpoint toward the nearest participating enemy start. Intermediate values
interpolate, deaths retract the line, and endpoints are clamped to the map.
The nearest allied TECH roster start anchors the line; own start is the fallback.
All T1 fighters join, while T2 reserves use income/threat quotas before escorts.
Legion's first Noctua instead scouts enemy starts: its existing native unit
classification cannot use the native SCOUT task. No UnitDef is reclassified.

All policy settings are in [AIR globals](../data/script/src/global.as).
[ProductionMath](../data/script/src/helpers/production_math.as) supplies pure
progress, blend, reach and completion arithmetic covered by
[62 executable AngelScript tests](../tests/production_math_tests.as).
The opt-in native mechanism is [RouteTask.h](../src/circuit/task/fighter/RouteTask.h),
[RouteTask.cpp](../src/circuit/task/fighter/RouteTask.cpp) and its
[binding](../src/circuit/script/InitScript.cpp). Ordinary routes default to their
existing movement behavior. [AIR integration](../data/script/src/roles/air.as)
continues to try home/scout policy before waves and native fallback.

The [opening observer](../tools/playtest/widgets/air_opening_watch.lua),
[opening checks](../tools/playtest/checks/air/economy/air_opening.json), and updated
[economy checks](../tools/playtest/checks/air/economy/air_economy.json) inspect actual engine
events. The [fixture](../tools/playtest/widgets/air_fixture.lua) and
[preparer](../tools/playtest/prepare_air_check.py) supply mixed T1/T2 fighters
and losses for a separate geometry test. That fixture explicitly raises the
T2 defensive quota; it is not evidence of naturally funded production.

Ownership and promises are recorded in the [actor matrix](actor-matrix.md),
[invariants](invariants.md), [decision](decisions.md#d-150--air-uses-commander-factory-assistance-and-a-growing-fighter-screen),
[script API](angelscript-references.md), and the three role references:
[AIR](roles/air.md), [actions](roles/air_build.md), [rules](roles/air_rules.md).

## Validation

Native build 06 completed successfully. Pinned DLL SHA-256:
`7f7941c38db5868ca7137989fbbfd38201ee363062151754904f89e0c1d1a8cb`.
Matching debug symbols SHA-256:
`e31d223be215cd8134cedeb0f8213d626124e2ec6231ab4d2eb458ea061e6f44`.
The stripped DLL is 7,568,026 bytes. DLL, symbols and current scripts are
published together to the mandatory build output; no live game install changed.

The 62 shared policy tests, 76 native ranking checks, geometry suite and eight
lane suites pass. Script API, role-document and invariant checks pass. The
documentation link check retains the eight pre-existing missing-hover links
(KI-404). The unit-helper check retains the two pre-existing TECH sonar findings
(KI-425). Neither is introduced by this change.

Initial full-length validation passed the new opening checks on all factions:
`d150-armada/runs/20260930-174349`, `d150-cortex/runs/20260930-174359`,
and `d150-legion/runs/20260930-174527` under `build-theatres/air/`.
The commander moved 22.6 / 83.1 / 0.0 elmos from factory frame until the third
constructor completed at 190.2 / 187.9 / 201.2 seconds. Armada wind commands
were 88.8–94.8 elmos away; Legion's were 63.2–128.7, within their 145 reach.
Fighters received real engine patrol commands and inflicted air-to-air damage.

That first pass also exposed a mixed-tier quota interaction: the immediate
T2 floor must credit T1 defenders, just like the full defensive target. Without
that credit, fighters assigned to waves can keep raising the immediate T2
recruitment target and delay later production decisions. Both gates now share
`DefenceRecruitTarget`; four additional executable tests cover cross-tier
coverage, escort exclusion, losses and invalid snapshots. The initial fusion
deadline failures remain recorded: Armada 20:21.4, Legion 21:48.2, and Cortex
still building its first reactor at minute 23. Final reruns use the corrected gate.

The controlled mixed-team fixture `d150-screen/runs/20260930-174524` verified
TECH team 1 as the anchor, 600 → 6,000 elmos width at forty fighters (4:04.3),
and a return to 600 width / 400 forward offset after losses (6:02). Actual
positions returned toward TECH by 6:30–6:40. AIR ordered the requested
transport at 1:58.4, built it before the scout order at 2:09.9, and delivered
it at 2:22.
All AIR assertions were clean. The combined scorecard remains **FAIL** because
TECH reported the known gifted-transport provenance error KI-435 (INV-001);
its forbid remains enabled and TECH logic is deliberately unchanged.

### Final natural games after quota correction

All use Supreme Isthmus v1.7, game `test-31450-6562fb1`, engine
`recoil_2026.07.04`, experimental_hard, seed 930146, no income bonus or gifted units.
Each ran through 25 minutes. All opening checks passed with zero script, crash
or gameplay invariant failures. Different wall-clock scheduling can vary the
natural runs despite a fixed game seed; earlier runs are retained above.

| Faction | Scout out of factory | Three constructors | Commander travel during factory/crew phase | First fighter | First fusion |
| --- | --- | --- | --- | --- | --- |
| Armada | 1:58.7 | 2:51.9 | 96.1 elmos | 3:38.3 | 20:23.4 |
| Cortex | 2:54.1 | 3:37.5 | 95.9 elmos | 3:52.8 | 20:06.7 |
| Legion | 2:03.8 | 3:01.3 | 84.9 elmos | 3:45.2 | 20:22.6 |

The observer's `guardSeconds` counts explicit GUARD commands only; the engine
spends most factory assistance time issuing REPAIR against the factory or its
current aircraft frame. Commander traces show those targets, and no commander
mex order after the factory frame. All three scouts travelled over 500 elmos
from their production position. Every reactor began with zero basic or
unfinished owned mexes. The exact 20-minute reactor deadline still **fails**,
by 6.7–23.4 seconds; no threshold or check was relaxed (KI-436).

By minute 25, Armada had 6 T1/4 T2 constructors and 12 nanos; Cortex 7/5 and 15;
Legion 7/4 and 11. Natural screens reached 33, 37 and 39 fighters. Air-to-air
damage and real patrol positions were observed. These short games do not prove
long-run PvP win rate, save/load restoration or performance on every map.

Opening reports under `build-theatres/air/`:

- `d150-final-armada/runs/20260930-175554/report.md`
- `d150-final-cortex/runs/20260930-175603/report.md`
- `d150-final-legion/runs/20260930-175602/report.md`

The same completed logs were judged separately by the unchanged
`air_transition` checks; those failed reports remain alongside the opening
reports. The final scripts are pinned in `build-theatres/air/build-06/data-d150`.
The [screen checks](../tools/playtest/checks/air/combat/air_screen.json) retain all invariants.
See the [playtest instructions](../tools/playtest/README.md) and
[known limitations](known-issues.md).

### Final mixed-team fixture after quota correction

`d150-final-screen/runs/20260930-180018/report.md` repeats the controlled
AIR/TECH fixture with the final scripts. Every AIR expectation is present:
TECH team 1 anchors the screen, forty fighters reach 6,000 width at 4:04,
engine patrol commands are active, and the requested transport is ordered
at 1:48.4, completed before the scout order at 1:59.5, and delivered at 2:10.
Losses at 6:00 reduce the screen
from 44 fighters to four; at 6:02 its width is 600 and advance is 400 again.
Actual surviving aircraft move back toward TECH in the subsequent samples.

The combined report remains **FAIL**: at frame 8552, TECH team 1 reports
INV-019 (two unfinished turret frames versus one currently affordable).
This is another instance of the TECH invariant category tracked in KI-427;
the run establishes attribution, not a new root-cause diagnosis. It does not
repeat KI-435 from the initial fixture. No AIR invariant, script error or
crash occurs, and the global invariant check remains enabled.

# Spam routes

Economy-gated mass production of cheap units that run fixed, parallel routes
from their factory to a point behind the enemy line. Game background:
`../../rjm.bar.docs/knowledge/70-strategy/76-spam.md`.

## Pieces

| Piece | Where | Role |
| --- | --- | --- |
| Spam roster | `Global::Spam::UnitByFactory` | canonical route eligibility; native config treats colliding `spam` attributes as roles, so an attribute-only test misses them |
| `Global::Spam` | `data/script/src/global.as` | thresholds, lanes, distances, factory to unit map |
| `Spam::` | `data/script/src/manager/spam.as` | activation, focus, route geometry, hooks |
| `CRouteTask` | `src/circuit/task/fighter/RouteTask.cpp` | native task: holds a waypoint route, issues move orders only, no retreat |
| `TaskF::Route()` | `data/script/src/task.as` | creates a `CRouteTask` through `aiMilitaryMgr.Enqueue` |
| `aiTerrainMgr.GetTerrainWidth/Height` | `src/circuit/script/InitScript.cpp` | map size for clamping destinations |

## Behaviour

### Where a lane goes

A lane has three points, and two of them move for different reasons:

| Point | What it is | When it changes |
| --- | --- | --- |
| start | the spam factory | never |
| **front** | `aiMilitaryMgr.GetCombatFocusPos()` — the leader of the strongest ATTACK squad, or the enemy centroid when we have no army out | whenever it moves more than `FrontMoveThreshold` |
| **destination** | `BehindEnemyDistance` past the focus, an enemy start spot | on the `RefocusMinutes` rotation, or `SetFocus` |

The run goes **through the front, then on to the backline**. That is the point
of the feature: a spam unit is worth most crossing the fight, where it draws
fire and gives vision, and what survives carries on behind the enemy line.
Routing straight from factory to enemy start would miss the fight entirely.

`GetCombatFocusPos` is native because script can reach neither the fighter
tasks nor the enemy groups; it is the only thing added to the script surface
for this.

The lane offset is applied to **every** waypoint including the destination, so
parallel lanes stay parallel the whole way rather than converging on one point.

### The band within a lane

That factory-level offset separates *factories*. It did nothing for the units
of one factory, which followed the identical line in single file - one shell
took several, and the column saw exactly what one unit sees.

`CRouteTask::SetLanes(count, spacing, endSpread)` spreads the units of one
route across a band. Each unit assigned to the task is dealt a lane from the
centre outwards - 0, +1, -1, +2, -2 ... up to `UnitLanes` (5) - and follows
the same waypoints offset sideways by `UnitLaneSpacing` (160) per lane,
perpendicular to the leg it is on, so the band follows the line's bends. The
offset at the **final** waypoint is scaled by `EndSpread` (0.35): the run is
aimed at one backline, so the lanes converge most of the way back toward it
rather than arriving as a 1300-elmo-wide line. A shell now takes one lane's
worth, and the band's vision is the band's width.

`IssueDirect` (the retarget path) honours the lane too, so an in-flight band
stays a band.

### Retargeting

When a route changes, units already on the field are sent **direct to the new
destination** — one move order, lane waypoints dropped. Re-running the new
lane from its nearest waypoint would walk units backwards to pick the lane up,
and a spam unit's value is forward pressure, not formation. Units produced
after the change get the full lane from `Start()`.

### Threat is ignored, deliberately

`CRouteTask` overrides `Update`, `OnUnitIdle` and `OnUnitDamaged` and **none of
them call `IFighterTask`'s versions**, which is where every retreat path lives:
uncharged shield, the coward set, health below 20%, and threat above twice the
unit's own power. Orders are plain `CmdMoveTo`, not fight-move, so pathing does
not detour around the threat map either, and `CmdWantedSpeed(NO_SPEED_LIMIT)`
keeps them moving.

Dying in transit is the intended outcome, not a failure mode.

### Why the threshold is so high

The gate reserves dedicated pressure for a mature economy; it does not require a fusion building. Below that economy the units spam produces -
Pawn, Grunt, Goblin, Blitz, Seeker - are ordinary front-line combat units, and
the roles should keep spending them as such; diverting them into a fixed route
early would take the roles' army away. Spam is what a mature economy does with
the T1 factories it no longer needs for the front line. That is also why
`UnitByFactory` lists only T1 factories: the behaviour is defined by the gap
between a fusion economy and the cheap production it has outgrown.

A game where spam never activates is therefore not necessarily broken. A game
where it activates and then builds nothing is - see
[KI-109](known-issues.md#ki-109--spam-activates-and-then-produces-nothing-and-the-log-cannot-say-why).

1. **Activation.** `Spam::Update` (from `Main::AiUpdate`) turns spam on when
   the sliding 10 s minimum of metal and energy income both clear
   `MinMetalIncome` and `MinEnergyIncome`, and off when either falls under
   `ReleaseFraction` of its threshold. Both are settings; the widget is told.
2. **Production.** While active, `Factory::AiMakeTask` asks
   `Spam::FactoryMakeTask` first. A T1 factory listed in `UnitByFactory`
   gets a normal-priority persistent recruit with engine repeat enabled.
   Completed offspring release the target without cancelling the repeating
   build queue. Enrollment is income-scaled, requires workers and a reachable
   route, and stops on economic shortage or retirement. Factories not in the
   map (T2, gantries, aircraft labs and shipyards) keep their role logic.
3. **Routes per factory.** The first time a factory produces spam it gets a
   `CRouteTask` and a lane: 0, +1, -1, +2, -2 ... in creation order. The route
   is factory, a waypoint a third of the way, a waypoint two thirds of the way,
   both offset sideways by `LaneSpacing x lane`, then the destination. Several
   factories therefore run parallel lanes instead of one file.
4. **Units.** `Military::AiMakeTask` asks `Spam::MilitaryMakeTask` first. A
   configured spam product joins its actual producing factory's route.
   Gifts and units whose producer was destroyed use the nearest surviving
   pump. Already assembling offspring are adopted once. The task issues
   waypoints as shift-queued **move** orders,
   re-issues from the nearest waypoint ahead when a unit goes idle short of the
   end, ignores damage (no retreat), and holds units at the destination where
   their own weapons engage whatever comes into range.
5. **Focus and destination.** Actual enemy lobby starts take precedence.
   Otherwise use map start slots in enemy boxes, excluding our roster;
   without boxes this remains an estimate. With no map spots the mirror of our start
   through the map centre is used. The destination is `BehindEnemyDistance`
   beyond the focus on the line from our start, clamped to the map by
   `MapMargin`, so it lies behind the enemy line and past radar and LOS where
   the map allows. The focus rotates to the next enemy spot every
   `RefocusMinutes`; `Spam::SetFocus(pos)` retargets on demand.
6. **Refocus.** Every focus change rebuilds every factory's route and calls
   `SetRoute` on its task, which marks the task dirty; on its next update it
   re-issues the new route to every unit already on the field.
7. **Factory loss.** `Factory::AiUnitRemoved` aborts the factory's route task;
   its units go idle and join the nearest remaining spam route.

## Settings (`Global::Spam`)

| Setting | Default | Meaning |
| --- | ---: | --- |
| `Enabled` | true | master switch |
| `MinMetalIncome` / `MinEnergyIncome` | 60 / 1500 | activation thresholds (both). mature-economy default; no particular building is required |
| `ReleaseFraction` | 0.7 | deactivate below this fraction of a threshold |
| `FloatMetalIncome` / `MinMetalBank` | 30 / 1000 | full-bank alternative; energy must still be healthy |
| `LabMetalStep` / `MaxLabs` | 100 / 6 | one enrolled pump at the income gate, another per additional 100 M/s, capped at six |
| `MinWorkers` | 4 | worker recovery precedes factory conversion |
| `BehindEnemyDistance` | 2500 | elmos past the focus along our line of approach |
| `LaneSpacing` | 900 | sideways offset between factory lanes |
| `MapMargin` | 200 | keep waypoints this far from the map edge |
| `RefocusMinutes` | 6 | rotate the focus to the next enemy spot |
| `UnitByFactory` | bot labs and vehicle plants per side (hover plants removed, D-038) | which unit each T1 factory spams |
| `AllowLandLocked` | false | a land-locked start (`Global::Map::LandLocked`) never spams; its T1 factories keep their role logic. Logged once at level 1 (D-052) |

## Notes

- D-216 adds one dedicated land pump to other roles where their constructors
  can build it and bots can reach enemy territory. TECH uses its reserved
  forward clusters after the advanced lab stands; its initial lab retirement
  sequence is retained. A SEA start confined to water is not forced to spam
  stranded land units. Existing air and naval production stays role-owned.
- Route endpoints and formation offsets use connected movement areas. A
  commander start or behind-base offset on a cliff is replaced with nearby
  reachable ground, within a bounded 64-site search. Unchanged routes issue
  no new orders. Admission/cancellation runs once per second; adoption is one
  owned-unit scan per five seconds. This is not an FPS or network benchmark.
- See the [D-216 investigation](reviews/2026-10-06-spam-and-fatboy.md) for the
  shared-idle cancellation bug, evidence and the limits of supplied fixtures.

- Default route orders are plain moves. D-143 adds opt-in `standoff` range
  control for specialist Arquebus units; ordinary spam has no such setting.
- The route task keeps only units assigned through the normal task path and
  loses them through the normal removal path, so it cannot hold a freed
  pointer; the empty task idles until script aborts it.
- Widget topic `spam` reports `on`, `off` and `focus` events.

# Spam routes

Economy-gated mass production of cheap units that run fixed, parallel routes
from their factory to a point behind the enemy line. Game background:
`../../rjm.bar.docs/knowledge/70-strategy/76-spam.md`.

## Pieces

| Piece | Where | Role |
| --- | --- | --- |
| `spam` attribute | `data/config/<profile>/behaviour*.json`, `"attribute": ["spam"]` | marks the units that get the route behaviour (`Unit::Attr::SPAM`) |
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

### Retargeting

When a route changes, units already in the air are sent **direct to the new
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

The gate is fusion-era on purpose. Below that economy the units spam produces -
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
   gets a `NOW` recruit of its spam unit every time it is idle, so it produces
   spam on repeat and nothing else. Factories not in the map (T2, gantries,
   air, sea unless added) keep their role logic.
3. **Routes per factory.** The first time a factory produces spam it gets a
   `CRouteTask` and a lane: 0, +1, -1, +2, -2 ... in creation order. The route
   is factory, a waypoint a third of the way, a waypoint two thirds of the way,
   both offset sideways by `LaneSpacing x lane`, then the destination. Several
   factories therefore run parallel lanes instead of one file.
4. **Units.** `Military::AiMakeTask` asks `Spam::MilitaryMakeTask` first. A
   unit with the `spam` attribute joins the route task of the nearest spam
   factory. The task issues the waypoints as shift-queued **move** orders,
   re-issues from the nearest waypoint ahead when a unit goes idle short of the
   end, ignores damage (no retreat), and holds units at the destination where
   their own weapons engage whatever comes into range.
5. **Focus and destination.** The focus is an enemy start spot: the map's
   start spots minus our own (nearest to our start) and our allies' (from the
   team roster), nearest first. With no map spots the mirror of our start
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
| `MinMetalIncome` / `MinEnergyIncome` | 60 / 1500 | activation thresholds (both). **Fusion-era by design** - see below |
| `ReleaseFraction` | 0.7 | deactivate below this fraction of a threshold |
| `BehindEnemyDistance` | 2500 | elmos past the focus along our line of approach |
| `LaneSpacing` | 900 | sideways offset between factory lanes |
| `MapMargin` | 200 | keep waypoints this far from the map edge |
| `RefocusMinutes` | 6 | rotate the focus to the next enemy spot |
| `UnitByFactory` | bot labs, vehicle plants, hover plants per side | which unit each T1 factory spams |

## Notes

- Route orders are plain moves. The units still shoot: fire state is untouched.
- The route task keeps only units assigned through the normal task path and
  loses them through the normal removal path, so it cannot hold a freed
  pointer; the empty task idles until script aborts it.
- Widget topic `spam` reports `on`, `off` and `focus` events.

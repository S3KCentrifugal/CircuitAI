# Experimental build mode: stop at build range

Decision: [D-064](decisions.md#d-064--experimental-build-mode-builders-stop-at-the-engines-build-range).
Native: `IBuilderTask::TryEngage`, `EngageRange`, `CmdTimeout`
([`BuilderTask.cpp`](../src/circuit/task/builder/BuilderTask.cpp)),
`CBuilderManager::experimentalBuild`, `experimentalDirectRange`.
Script: `aiBuilderMgr.experimentalBuild`, set in `Tech_Init` from
`Global::RoleSettings::Tech::ExperimentalBuild`. Only TECH turns it on.

## The problem it fixes

Played (D-063, 2026-09-20): the commander walked past its second mex and
back before starting it, and stopped and restarted the nanolathe while
building. Three mechanisms in the stock builder task cause that:

1. **The AI paths to the site, not to the range.** `UpdatePath` asks the
   pathfinder for a path to the build position with goal range
   `buildDistance` only. The path's last waypoint is a 32-elmo grid node
   inside that circle, and the travel action walks the unit to the node. For
   a mex the site is a point the unit may walk over; the engine then has to
   move it off the footprint and back into range.
2. **Every arrival re-issues the command.** `OnTravelEnd` puts the unit in
   `traveled`; the next `Update` runs `Execute`, which gives a new build
   command. A new build command replaces the standing one: the nanolathe
   stops, the unit re-aims, the build restarts. Path re-evaluations that end
   in `StateFinish` do the same.
3. **The command times out.** Every `CmdBuild`/`CmdRepair` carries
   `frame + 60 s`. A mex that builds at the commander's 25 E/s trickle
   outlives it; the engine drops the command, the unit goes idle, the task
   retries with a fresh command (twice), then takes the unit off the task.

## What the engine does (the reference rule)

Recoil, `rts/Sim/Units/CommandAI/BuilderCAI.cpp`:

```cpp
float CBuilderCAI::GetBuildRange(const float targetRadius) const
{   return (ownerBuilder->buildDistance + targetRadius); }

bool CBuilderCAI::IsInBuildRange(const float3& objPos, const float objRadius) const
{   return f3SqDist(owner->pos, objPos) <= GetBuildRange(objRadius)^2; }

bool CBuilderCAI::MoveInBuildRange(const float3& objPos, float objRadius, ...)
{   if (!IsInBuildRange(objPos, objRadius)) {
        SetGoal(objPos, owner->pos, GetBuildRange(objRadius) * 0.9f);  // move until inside 90 % of range
        return false; }
    StopMoveAndKeepPointing(...); return true; }
```

The buildee radius for a new construction is the unit def's model radius
(`GetBuildOptionRadius`). So the engine, given a build command from far
away, already solves the approach optimally: its pathfinder targets the
*disc* of radius `0.9 (buildDistance + modelRadius)` around the site, stops
on its boundary, and starts. The stock AI code was fighting that with its
own waypoints.

## The theory chosen

**Goal-region approach with a single command.** The stopping set for a
builder with reach `r` and a buildee of model radius `rho` at site `P` is
the disc

```
D = { x : |x - P| <= 0.9 (r + rho) }
```

In free space the shortest path from the builder at `u` into `D` is the
straight segment to the boundary point

```
s = P + (u - P) * 0.9 (r + rho) / |u - P|
```

and with obstacles it is the shortest path to the *disc*, which is what a
goal-region search returns (A* that terminates on entering `D`, the same
thing the engine's `SetGoal(pos, radius)` and CircuitAI's path query with a
`range` both compute). Nothing about the builder's own footprint, the
structure's footprint corners or the path's final heading needs modelling:
the engine's rule is a disc, so the optimum is the disc boundary.

From that, three rules:

1. **The AI's goal is the range circle**, `EngageRange = 0.9 (r + rho)`,
   in `UpdatePath` (path goal range), in `Reevaluate` (the in-range test)
   and in `TryEngage`. No waypoint is ever placed inside the disc.
2. **The last leg is the engine's.** Inside `experimentalDirectRange`
   (1,600 elmos) on ground the threat map calls safe, the AI cancels its
   travel action and gives the construction command at once; the engine
   walks the shortest path to the disc and starts. Farther, or under threat,
   the threat-aware AI path is used up to the circle, then the command.
3. **One command per engagement.** A unit is `engaged` once its command is
   given; `Update`, `OnTravelEnd` and re-evaluations never issue another.
   The set is cleared for a unit when the engine reports it idle (finished
   or dropped) or the unit leaves the task. Commands carry no timeout
   (`INT_MAX`); the AI's own task timeout and watchdog remain the limits.

Alternatives looked at and not taken:

| Idea | Why not |
| --- | --- |
| Potential fields / steering toward the site | Oscillates at the boundary; the engine owns unit movement anyway. |
| Corner-aware stopping (nearest footprint edge instead of the centre) | The engine's rule is centre-plus-model-radius; a corner rule would stop short of what the engine accepts. |
| Solving site order as a TSP over pending sites | Over-engineering; the planner issues one site at a time. The nearest-neighbour heuristic is used where it is free: the packer breaks ties by the asking builder's position. |
| Distance-transform packing (Felzenszwalb EDT) | Same result as the brute-force nearest-turret scan for a 40 x 44-cell box; not worth the code. |
| Custom waypoint following with a range-aware last hop | Reimplements `MoveInBuildRange` worse. |

## Placement, the same idea

`Layout::Place(..., builder)` passes the asking builder's position as the
tie-break anchor of `PackNearGroup`: among cells equally close to a turret
(the primary key), the cell nearest the builder wins, so the walk to the
next structure is the shortest the plan allows.

## Settings

| Setting (`Global::RoleSettings::Tech`) | Default | Meaning |
| --- | --- | --- |
| `ExperimentalBuild` | true | `aiBuilderMgr.experimentalBuild` for this AI instance |
| `ExperimentalBuildDirectRange` | 1600 | elmos; nearer than this on safe ground the engine walks the last leg |

Native properties (any role's script may set them; only TECH does):
`aiBuilderMgr.experimentalBuild`, `aiBuilderMgr.experimentalDirectRange`.
The role-switch snapshot (`Commands::NativeState`) restores both.

## What to watch

Level-1 line at init: `[TECH][Build] experimental build mode on, direct
range 1600`. In game: the commander should stop at the edge of its build
range on the far side of the mex from where it came, never walk over the
spot, and the nanolathe should run without a restart until the mex stands.
Not Played: [KI-410](known-issues.md#ki-410--experimental-build-mode-is-not-yet-played).

## Related

- [`layout-design.md`](layout-design.md) - where structures go.
- [`eco-planner.md`](eco-planner.md) - what is built next.
- [`roles/tech.md`](roles/tech.md) - the role that turns the mode on.

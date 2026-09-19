# Mobile sensor escort

How mobile radar and jammer units attach themselves to squads, why they used to
pile up, and how the escort is rationed now.

## Contents

- [The pile-up](#the-pile-up)
- [Why one per squad is the right cap](#why-one-per-squad-is-the-right-cap)
- [How a sensor picks a squad](#how-a-sensor-picks-a-squad)
- [Surplus](#surplus)
- [Merged squads](#merged-squads)
- [Configuration](#configuration)
- [Known limits](#known-limits)
- [Related](#related)

## The pile-up

Two role vocabularies collide on the word *support*, and it matters here:

| | |
| --- | --- |
| **`support` config role** | a unit tag in `behaviour.json`'s def list. Drives native tasking. |
| **`SUPPORT` AiRole** | the AngelScript profile role in [`roles/support.md`](roles/support.md). |

This page is about the first. Mobile radar and jammer units - `armseer`,
`armjam`, `corvrad`, `coreter` and the rest - carry `support` as their main
config role, and `CMilitaryManager::MakeTask` sends every `support` unit to a
`CSupportTask`.

`CSupportTask` is a staging task. It walks its unit toward a squad and then
hands it over outright:

```cpp
// CSupportTask::ApplyPath, before the cap
IFighterTask* task = *tasks.begin();
// ... pick the nearest by leader position ...
manager->AssignTask(unit, task);
```

Nothing in that path counted anything. Every sensor on the map independently
solved the same problem - *which squad is nearest* - and independently reached
the same answer, so they arrived as a crowd. In a game on Eight Horses that was
**27 radar bots trailing a single sharpshooter**: one squad's worth of vision,
27 units of cost, all inside one splash radius.

## Why one per squad is the right cap

A squad moves as one body. The second jammer covers ground the first already
jams; the second radar bot sees what the first sees. Neither adds range, and
BAR's `separateJammers` rule means overlapping jam bubbles do not compound.
What the extras do add is a target - mobile sensors are unarmed or nearly so,
and a clump of them behind a squad is free metal for a bomber.

So the escort is rationed at one per squad, and the scarce sensors are pointed
at the squads that most repay covering.

## How a sensor picks a squad

`CSupportTask::FindCandidates` builds the list, and both `Update` (choosing
where to walk) and `ApplyPath` (choosing what to join) go through it:

1. Start from the live `ATTACK` tasks, or `DEFEND` if there are no attacks.
2. Drop squads with no leader, squads the unit cannot path to, and squads whose
   movement class does not match the unit's - all pre-existing filters.
3. **Drop squads already holding `max_per_squad` sensors.** The count is of
   live assignees, which is what "unless it dies" means: a squad whose escort
   dies is immediately a candidate again, with no timer and no bookkeeping.
4. **Rank what is left by squad value**, defined as the metal cost of the squad
   leader. The leader is the squad's most capable unit, so this is the
   highest-tier-first ordering without walking every member.
5. **Keep the best `top_candidates`** and hand those positions to the
   multi-path query, which picks the nearest of them.

Step 5 is the compromise that keeps the policy sane: pure value ranking would
send a sensor across the map to reach a marginally better squad, and pure
distance is what caused the pile-up. Nearest-of-the-best-few is both.

`ApplyPath` re-runs `FindCandidates` on arrival rather than trusting the list
`Update` built, because the walk takes time and another sensor may have taken
the slot meanwhile.

Non-sensor `support` units skip steps 3-5 entirely and behave exactly as
before.

## Surplus

When every reachable squad already has its escort, a sensor has no candidate,
and `FindCandidates` returns empty. The unit falls through to `Start`, which
parks it on a random radial position around the base rather than joining a
squad that cannot use it.

That is correct but unambitious - see [KI-107](known-issues.md#ki-107--a-surplus-mobile-sensor-has-no-job-of-its-own).

## Merged squads

The cap holds at the moment a sensor joins, but two squads that each hold their
one escort can still merge into one squad holding two - `ISquadTask::Merge`
absorbs the whole membership of the other task.

Rather than reach into `Merge`, which runs mid-iteration over the absorbed
squad's set, the surplus is swept up afterwards.
`CMilitaryManager::UpdateSensorGuards` runs every five seconds, finds squads
over the cap, and calls `AssignTask(unit)` on the extras: that detaches each
from its squad and runs `MakeTask`, which hands a `support` unit a fresh
`CSupportTask` that re-picks under the cap. It cannot pick the squad it just
left, because leaving made room for exactly one and the sensor that stayed
fills it.

## Configuration

`behaviour.json`, alongside `"pulse"` and `"bomber"`:

```json
"sensor": {
    "enabled": true,
    "jammer": "jammer",
    "radar": "radar",
    "max_per_squad": 1,
    "top_candidates": 3,
    "rebalance": true
}
```

| Key | Default | Effect |
| --- | --- | --- |
| `enabled` | `true` | Off restores the old nearest-squad behaviour exactly. |
| `jammer`, `radar` | `"jammer"`, `"radar"` | The config roles that mark a rationed escort. An unknown name disables the policy rather than silently rationing nothing. |
| `max_per_squad` | `1` | Live escorts a squad may hold. |
| `top_candidates` | `3` | How many of the most valuable uncovered squads the pathfinder chooses between. |
| `rebalance` | `true` | Run the five-second sweep that undoes a merge surplus. |

`jammer` and `radar` are the same tags the [`pulse`](juno-targets.md) policy
hunts for on the enemy side - a def worth pulsing over there is a def worth
rationing over here - so the two policies stay in step from one set of tags.

Note that a def's custom config roles live in `respRole`, not `role`:
`CCircuitDef::role` holds only the *binded implemented* roles, and `jammer` and
`radar` are neither. `CMilitaryManager::IsSensorUnit` tests `IsRespRoleAny`.

## Known limits

1. **Value is the leader's cost, not the squad's.** A squad of forty Pawns
   ranks below one Sharpshooter. Leader cost is a tier proxy, and tier is what
   was asked for, but a summed-cost or summed-threat ranking would treat a
   large cheap squad more fairly.
2. **The surplus has no job.** [KI-107](known-issues.md#ki-107--a-surplus-mobile-sensor-has-no-job-of-its-own).
3. **Production is not capped.** Nothing stops a factory from building sensors
   after every squad is covered. That is AngelScript's call, in
   `FactoryProduction`, and is not done.
4. **Not verified in a game.** The cap, the ranking and the sweep compile; no
   match has exercised them.

## Related

- [`juno-targets.md`](juno-targets.md) - the `jammer`/`radar` tags on the
  offensive side.
- [`roles/support.md`](roles/support.md) - the AngelScript `SUPPORT` role,
  which is a different thing with the same name.
- [`known-issues.md`](known-issues.md) - KI-107.

# Tactical launcher targets

How Perdition (`legperdition`, napalm, range 2300) and Catalyst (`cortron`,
tactical nuke, range 2250) pick what to fire at, why the generic super-weapon
scan never gave them a target, and the `stockpile` block in `behaviour.json`
that tunes it. The Armada launcher is an EMP and has its own policy in
[`emp-targets.md`](emp-targets.md). Weapon data lives in the shared knowledge
base ([`../../rjm.bar.docs/knowledge/`](../../rjm.bar.docs/knowledge/)).

Decisions: [D-035](decisions.md#d-035--a-stockpiled-shots-floor-decays-while-it-waits),
[D-036](decisions.md#d-036--tactical-launchers-aim-by-unit-scan-and-super-statics-bypass-role-policy).

## Contents

- [Why the group scan could not see anything](#why-the-group-scan-could-not-see-anything)
- [How a target is chosen](#how-a-target-is-chosen)
- [The floor](#the-floor)
- [Who gives the launcher its task](#who-gives-the-launcher-its-task)
- [Configuration](#configuration)
- [Known limits](#known-limits)

## Why the group scan could not see anything

Every super weapon that is neither a Juno nor an EMP is aimed by
`CSuperTask::Update`'s group scan: it walks `CEnemyManager::GetEnemyGroups()`
and takes the richest group whose **centroid** is inside the weapon's range.
The groups are k-means cells, `1 + sqrt(N)` of them for the whole map
(`KMeansIteration`, cap 32). With 150 hostiles that is 13 cells over the
entire map; a cell's centroid is almost never within 2300 elmos of a static
that sits inside one of our clusters, even when the cell's units are.

The diagnostic line said exactly that, every minute, for every launcher:

```
SUPER cortron(28588): no target | range=2250 regional=1 groups=8..14 inRange=0 ...
SUPER legperdition(11605): no target | range=2300 regional=1 groups=12..15 inRange=0 ...
```

`inRange=0` is "no group centroid inside range". The Juno (32 000) and the
nukes (72 000) never hit this because every centroid is inside their range;
the EMP escaped it because it already had a unit scan. The launchers had the
one range at which the granularity of the groups matters, and no scan of
their own.

## How a target is chosen

`CSuperTask::SelectLauncherTarget` runs for any stockpiled super weapon whose
range is shorter than the map diagonal (`IsAttrStock() && isRegional`) that
is not a Juno or an EMP. It reuses `SelectAreaTarget`, the scan the EMP and
Juno share:

1. Every hostile the weapon's target category allows is a candidate. A napalm
   missile cannot hit aircraft, so `cdef->GetTargetCategory() &
   edef->GetCategory()` decides, from the weapon def, not from a list.
2. A mobile candidate not currently in radar or LOS is used at its last known
   position while that is fresher than `launcher_mobile_max_age`.
3. Candidates outside range are dropped.
4. Each candidate is scored as an aim point: the sum of the metal cost of
   every candidate inside the weapon's AoE around it. The richest aim point
   wins. With `launcher_structures_first` any aim point containing a
   structure outranks one that does not.
5. The winning aim point must be worth at least the floor below, or the
   launcher holds.

The order is an attack-ground at the aim point, as for the EMP: the effect is
by area and the units may have moved.

## The floor

A stockpiled shot has already been paid for, so the floor is not a price but
a patience. `CSuperTask::StockedShotFloor` starts at the shot's
`metalpershot` (350 Perdition, 550 Catalyst, 1500 nuke) the moment a shot is
stocked and decays linearly to `min_fraction` of it over `patience_seconds`;
once `full_fire_count` shots are stocked the floor is `min_fraction`
immediately. The same function feeds the generic group scan, so a nuke
behaves the same way; the configured EMP and Juno (pulse) policies target
from their own branches and never reach the floor (CR-016). It is the fix for [KI-110](known-issues.md#ki-110--closed-a-stockpiled-super-weapon-holds-its-shot-until-it-dies).

## Who gives the launcher its task

All of these are `commandfire` weapons: they fire only on an explicit order,
and the only thing that orders them is the native `CSuperTask`. That task is
handed out by `Military::AiMakeTask` in `manager/military.as`, which used to
run the role's `MilitaryAiMakeTaskHandler` first. TECH's returns null for
every unit below +50 metal income, so a TECH Juno or Catalyst had no task
until the economy caught up (the idle task retries, so it was late rather
than never). `Military::AiMakeTask` now routes any immobile def carrying the
`super` role to `aiMilitaryMgr.DefaultMakeTask` before any policy sees it,
the same shape as the ferry-transport guard, logging
`[Military] super static <def>(<id>) -> native CSuperTask` at level 1.

## Configuration

The `stockpile` block in `data/config/<profile>/behaviour.json`, read by
`CMilitaryManager::ReadConfig` into `SStockInfo`:

```json
"stockpile": {
    "patience_seconds": 240,
    "min_fraction": 0.25,
    "full_fire_count": 2,
    "launcher_mobile_max_age": 30,
    "launcher_min_targets": 1,
    "launcher_structures_first": false
}
```

| Key | Effect |
| --- | --- |
| `patience_seconds` | the floor decays from the full shot cost to `min_fraction` of it over this |
| `min_fraction` | the floor never drops below this fraction of the shot cost |
| `full_fire_count` | with this many shots stocked the floor is `min_fraction` at once; 0 disables |
| `launcher_mobile_max_age` | seconds a mobile's last known position stays a usable aim point |
| `launcher_min_targets` | raise above 1 to require a clump inside the blast |
| `launcher_structures_first` | true ranks any aim point containing a structure above any without |

Present in `experimental_balanced`, `experimental_hard` and
`experimental_terrible`; the legacy profiles have no block and use the
defaults above. The startup line
`CONFIG <profile>: stockpile patience=... launcher(maxAge=... minTargets=... structuresFirst=...)`
confirms what was read.

## Known limits

1. **Range is still the range.** The scan only finds what is inside 2300 of
   the launcher; a launcher placed at the back of a cluster by the porc chain
   still reaches nothing until the enemy pushes. Where it is placed is
   [`porc-chain.md`](porc-chain.md)'s business, not this document's.
2. **Value is metal cost, not damage dealt.** Napalm's damage over time and
   the tactical nuke's burst are not modelled; a clump of cheap units at
   full health scores the same as one nearly dead.
3. **Not Played.** Built and checked against the log's numbers; the first
   game with a launcher in reach of the enemy will show `LAUNCHER ...` lines
   in place of the `SUPER ... inRange=0` ones.

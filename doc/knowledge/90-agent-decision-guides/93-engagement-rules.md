---
layer: 90
confidence: synthesis
sources:
  - 60-tactics/60-formations.md, 61-micro.md
  - 80-theory/81-lanchester-and-attrition.md, 82-manoeuvre-vs-attrition.md
  - 10-engine/14-experience-and-flanking.md
  - src/circuit/task/fighter/*.cpp, src/circuit/module/MilitaryManager.cpp
  - data/config/*/behaviour.json (retreat, defence blocks)
---

# Engagement rules

When to fight, when to wait, when to leave. Each rule gives the trigger, the
action, the mechanic it rests on, and where it would live in BARb.

## R1 - Stage before contact

- **Trigger**: a squad's target is farther than its slowest member can reach
  in `staging_time` (30 s) and the squad is below its planned size, or its
  members are spread over more than one weapon range.
- **Action**: rally at the last own-controlled sector on the path, wait until
  members are within one range of the rally point or `max_wait` (45 s), then
  advance at the slowest member's speed.
- **Mechanic**: square law - the whole force engaging beats a trickle
  ([81](../../../../rjm.bar.docs/knowledge/80-theory/81-lanchester-and-attrition.md)).
- **BARb**: `CSquadTask` merges squads but attacks from wherever units are.
  Native change in `CAttackTask::Update` path selection; no script hook.

## R2 - Fight where the numbers favour you

- **Trigger**: before committing, compare own squad metal `M_A` and enemy
  metal in the target sector `M_B` (threat map), with efficiency from the
  counter matrix `e_A`, `e_B`.
- **Action**: engage if `e_A x M_A^2 > 1.2 x e_B x M_B^2`; otherwise hold
  and merge, or pick a target sector where it holds.
- **Mechanic**: square law with a friction margin.
- **BARb**: `CAttackTask` already compares squad `attackPower` to threat at
  the target (the `maxPower <= threat` filter). The change is to square the
  comparison and to seek an alternative target instead of idling.

## R3 - Attack the engaged from a second axis

- **Trigger**: an enemy group is engaged with own units (taking damage from
  a known direction) and a second own squad is within 60 s.
- **Action**: route the second squad to arrive 60-120 degrees off the first's
  axis; do not merge them.
- **Mechanic**: flanking bonus up to 2x ([14](../../../../rjm.bar.docs/knowledge/10-engine/14-experience-and-flanking.md)).
- **BARb**: no concept of engagement axis; native path goal offset in
  `CSquadTask`.

## R4 - Raiders never join the blob

- **Trigger**: unit main role `raider`.
- **Action**: targets are constructors, extractors, energy, artillery,
  isolated units; path avoids sectors with threat above the raider group's
  power; leave when riots arrive.
- **Mechanic**: raider value is speed and DPS per metal, wasted in a line
  fight; the counter cycle ([40](../../../../rjm.bar.docs/knowledge/40-roles-and-counters/40-role-taxonomy.md)).
- **BARb**: `CRaidTask` exists and does roughly this; verify the target
  priority (constructors before mexes, per
  [53](../../../../rjm.bar.docs/knowledge/50-economy/53-expansion-and-territory.md)).

## R5 - Kite when you out-range and out-run

- **Trigger**: own unit range > enemy range and own speed >= enemy speed, no
  enemy raiders within the band.
- **Action**: hold distance in `(enemy_range, own_range]`; fire, back off,
  repeat.
- **Mechanic**: linear law with the enemy at zero engagement.
- **BARb**: `ret_fight` attribute fires while retreating; no explicit band
  hold. Native `IFighterTask` movement.

## R6 - Retreat thresholds

- **Trigger**: unit health below threshold `T`.
- **Action**: return to the nearest constructor or nano, not to base; rejoin
  when repaired.
- **Threshold**: `T = base` (0.3 for units faster than their attacker, 0.5
  for slower and expensive) `+ 0.1 x xp_grade` (veterans leave earlier)
  `- 0.3` if the unit cannot escape (fight on).
- **Mechanic**: repair is free; XP is lost on death.
- **BARb**: `behaviour.json` `retreat` fraction per config (flat). XP is
  not exposed to script; native `IFighterTask` health check.

## R7 - Detect culmination

- **Trigger**: over the last 30 s a squad's kill metal / loss metal falls
  below 1.0 while distance from the nearest own constructor exceeds its
  build range x 3.
- **Action**: pull back to the last wreck field in own control; reclaim and
  repair; resume when the squad is back to planned size.
- **Mechanic**: culminating point; defence is the stronger form
  ([82](../../../../rjm.bar.docs/knowledge/80-theory/82-manoeuvre-vs-attrition.md)).
- **BARb**: no kill/loss accounting per squad; threat-map abort only.

## R8 - Spread against area weapons

- **Trigger**: enemy artillery, bombers, cluster or fire weapons identified
  in range of the squad.
- **Action**: spacing >= the largest enemy AoE diameter; advance in a line
  not a blob.
- **Mechanic**: AoE super-linearity ([81](../../../../rjm.bar.docs/knowledge/80-theory/81-lanchester-and-attrition.md)).
- **BARb**: squads move as blobs; per-unit offsets in `CSquadTask`.

## R9 - Focus fire and overkill

- **Trigger**: multiple own units engaging.
- **Action**: target priority: highest enemy DPS/HP against us -> lowest
  remaining HP -> highest cost. Stop assigning shooters when assigned damage
  exceeds target HP.
- **Mechanic**: DPS removal per kill; XP concentration.
- **BARb**: engine auto-targeting per unit; squad target by threat/distance.
  Native.

## R10 - Never trickle into statics

- **Trigger**: target sector threat is mostly static (`static` role units).
- **Action**: artillery with a screen ([65](../../../../rjm.bar.docs/knowledge/60-tactics/65-siege-and-defence.md));
  no assault until the static threat is below the squad's power.
- **BARb**: artillery role targets statics by threat; no siege sequencing.

## R11 - AA stays inside; anti-heavy behind the screen

- **Trigger**: composition of the squad.
- **Action**: `anti_air` units path to the squad centroid; `anti_heavy` units
  path to `screen_depth` behind the front with LOS to the target.
- **BARb**: no intra-squad placement.

## R12 - Superweapon stock and coverage

- **Trigger**: enemy silo seen, or enemy T2 older than 5 minutes.
- **Action**: anti-nuke with coverage over the AFUS/gantry cluster; keep stock
  >= enemy silos seen ([74](../../../../rjm.bar.docs/knowledge/70-strategy/74-superweapons.md)).
- **BARb**: build chains place anti-nuke; no coverage or stock check.

## Priority for implementation

| Rule | Value | Cost | Where |
| --- | --- | --- | --- |
| R1 staging | very high (square law) | medium | C++ `CSquadTask` |
| R2 squared power check | high | low | C++ `CAttackTask` |
| R6 retreat by speed/XP | high | low-medium (expose XP) | C++ `IFighterTask` |
| R7 culmination | high | medium | C++ squad accounting |
| R8 spacing | medium | medium | C++ |
| R3 flank axis | medium | high | C++ |
| R12 coverage | medium | low | script |
| R9 overkill | low-medium | medium | C++ |
| R5 kite band | medium | medium | C++ |

## Related

- [90-decision-architecture.md](90-decision-architecture.md), [bomber-targeting.md](../../bomber-targeting.md).

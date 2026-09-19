# EMP target priority

How BARb aims an EMP silo: why the target must be chosen by arithmetic rather
than by value, the priority order, the config that drives it, and what happens
when nothing qualifies.

Game mechanics are **not** repeated here. The paralysis model, the immunity
roster, the mobile/building cap split and the playstyles are in the shared
knowledge base:
`../rjm.bar.docs/knowledge/20-game-mechanics/23-special-systems.md` ("EMP /
paralysis") and `../rjm.bar.docs/knowledge/70-strategy/74-superweapons.md`
("EMP and Juno as enablers"). This document covers only what BARb does.

## Contents

- [Why value is the wrong ranking](#why-value-is-the-wrong-ranking)
- [The viability test](#the-viability-test)
- [The priority order](#the-priority-order)
- [How a target is chosen](#how-a-target-is-chosen)
- [When nothing qualifies](#when-nothing-qualifies)
- [Configuration](#configuration)
- [Known limits](#known-limits)

## Why value is the wrong ranking

`armemp` (Paralyzer, 1600 M) has main role `emp`, bound to `SUPER`, so it gets
its own `CSuperTask`. The generic super-weapon scan ranks enemy **groups by
total metal cost** on the regional branch, then fires at the enemy nearest the
winning group's centre.

An EMP shot costs **500 M + 15 644 E** on a 65 s cycle and deals no health
damage. Ranked by metal, that scan will spend it on a commander push (every
commander is immune), a Juggernaut (immune), a flight of bombers (aircraft are
never `EMPABLE`) or a Titan (multiplier 1.0, but 69 000 max health puts it out
of reach of one shot). Metal cost and paralysability are close to unrelated.

`CSuperTask::SelectEmpTarget` replaces that scan for EMP weapons, sharing
`SelectAreaTarget` with the Juno pulse policy. Like the pulse policy it
**never falls back** to the group scan: holding the shot beats spending it on
something it cannot hold.

## The viability test

From Recoil `CUnit::DoDamage` with `modrules.paralyze.paralyzeOnMaxHealth`:

```text
effective = paralyzeDamage * paralyzemultiplier * salvo
stunned   iff effective > maxHealth
cap       = 1 + paralyzeTime / declineRate
seconds   = declineRate * (min(effective / maxHealth, cap) - 1)
```

`declineRate` is `modrules.paralyze.paralyzeDeclineRate`, 40 by default. For
`armemp` (50 000 paralysis damage, `paralyzetime` 35) a single shot therefore
gives the full 35 s against anything up to 26 667 max health, a shorter stun up
to 50 000, and **nothing at all above it**.

A candidate whose computed stun is below `min_stun` is rejected before it is
ranked. That is the whole point of the policy: it never fires a shot that does
nothing, and it never fires a one-second shot at an Epic Bulwark.

`salvo` is the number of our own stocked EMP silos, so a target too healthy for
one shot becomes viable when a second and third silo have stock — the Epic
Bulwark goes from no stun, to 1 s, to 21.5 s across one, two and three shots.

## The priority order

| Rank | Class | How it is identified |
| ---: | --- | --- |
| 0 | anti-nuke | the `anti_nuke` config role, and not mobile |
| 1 | any other structure | `!IsMobile()` |
| 2 | mobiles | only when `structures_first` is true; otherwise they join rank 1 |

Within a rank, candidates are ordered by **metal value**. That is deliberate
and is what keeps the table short: no tagging is needed for Ragnarok (70 000),
AFUS (9 700–10 500), gantry (7 900–8 400), nuclear silo (7 700–8 100), T2 LRPC
(4 500), Bastion (4 200) or Pulsar (3 500) — they sort themselves, in that
order, above a 730 M Scorpion. A new expensive structure in a future BAR
version is picked up with no config change at all.

Anti-nuke is the one class ranked above raw value, because 1 500 M badly
understates it: stunning it is what lets a nuke through, and the EMP missile
carries no `targetable`, so the anti-nuke cannot intercept it.

Structures outrank mobiles for a mechanical reason rather than a value one:
`unit_paralyze_damage_limit.lua` caps mobile paralysis at 20 s (10 s with
`emprework`) and explicitly skips buildings, so only a structure gets the
weapon's full `paralyzetime`.

## How a target is chosen

Every `TARGET_DELAY` (10 s) while the silo is idle, through the shared
`CSuperTask::SelectAreaTarget`:

1. **Collect candidates** from `CEnemyManager::GetHostileDatas()`, which
   retains enemies no longer visible at their last known position. Skip fakes,
   dead, dying and ignored.
2. **Classify** — reject anything without the `EMPABLE` category bit. Because
   BAR computes `EMPABLE = SURFACE and paralyzemultiplier != 0`, that single
   bit rejects aircraft, submerged units and every immune def at once. Then
   apply the viability test above, then assign rank and value.
3. **Freshness** — a mobile currently out of radar and LOS is kept only while
   its last-seen frame is within `mobile_max_age`.
4. **Range** — 3 650 for `armemp`, which binds constantly.
5. **Pick the aim point** — each candidate position is a possible impact point;
   score it by the best rank and summed value within the weapon's AoE (312 for
   `armemp`, so in practice a single building), require `min_targets`, then
   take lowest rank first and highest value second.
6. **Fire at the ground**, because the target may no longer be visible.

## When nothing qualifies

The silo **holds its shot**: `CmdStop`, clear target, retry in 10 s. It never
falls back to the group scan, and `commandfire = true` means the weapon never
self-fires. The stockpile keeps filling to its limit of 10 at 500 M + 15 644 E
each, so an idle silo can park 5 000 M and 156 440 E in unfired missiles.

Once a minute per unit it logs why:

```text
EMP armemp(1234): no target | range=3650 candidates=0 rejClass=14 rejRange=3 rejStale=0 minTargets=1
```

`rejClass` counts enemies rejected as immune, non-surface or unstunnable, which
distinguishes "nothing in range" from "everything in range is a Juggernaut".

## Configuration

Root block in `data/config/<profile>/behaviour.json`, read by
`CMilitaryManager::ReadConfig`:

```json
"emp": {
    "enabled": true,
    "role": "emp",
    "anti_nuke": "anti_nuke",
    "category": "EMPABLE",
    "decline_rate": 40,
    "min_stun": 5.0,
    "mobile_max_age": 30,
    "min_targets": 1,
    "structures_first": true
}
```

| Key | Effect |
| --- | --- |
| `enabled` | false restores the generic group scan for EMP weapons |
| `role` | the config role marking a def that carries an EMP weapon |
| `anti_nuke` | the config role for the one class ranked above value |
| `category` | the BAR category that means "can be paralysed" |
| `decline_rate` | mirrors `modrules.paralyze.paralyzeDeclineRate`; **set to 20 under `emprework`** |
| `min_stun` | seconds; a candidate that would be stunned for less is rejected |
| `mobile_max_age` | seconds a mobile target's last known position stays usable |
| `min_targets` | raise above 1 to require a cluster |
| `structures_first` | false lets a valuable mobile outrank a cheap structure |

Present in `experimental_balanced`, `experimental_hard` and
`experimental_terrible`. The legacy profiles have no `emp` block, so their
silos keep the generic scan.

The paralysis damage and `paralyzetime` are **not** configured: they are read
from the weapon def through `CWeaponDef::GetParalyzeDamage()` and
`GetParalyzeTime()`, so a BAR rebalance is picked up automatically. Per-target
resistance comes from `CCircuitDef::GetParalyzeMult()`, parsed from
`customparams.paralyzemultiplier`.

## Known limits

1. **EMP is Armada-only.** `armemp` is the game's only EMP silo; Cortex's
   `cortron` Catalyst is a damage missile and Legion has neither. This policy
   never runs for a Cortex or Legion AI.
2. **`salvo` is an over-estimate.** `CMilitaryManager::GetEmpSalvoSize()`
   counts every stocked EMP silo we own, not only those whose range covers the
   candidate point. Spread-out silos can therefore make a target look viable
   when only one shot can actually reach it. The firing silo always covers its
   own candidates, so the first shot is never wasted, but a follow-up may not
   arrive. Tracked as `KI-104` in [`known-issues.md`](known-issues.md).
3. **`emprework` is not detected.** That mod option halves `declineRate` to 20
   and the mobile cap to 10 s. `decline_rate` must be set by hand. Tracked as
   `KI-303`.
4. **No follow-up coordination.** EMP kills nothing: the window is only worth
   its cost if a push or a nuke lands inside it. BARb chooses the target well
   and does nothing with the result. This is the largest remaining gap and is
   bigger than target selection.

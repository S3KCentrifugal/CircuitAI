# Juno target priority

How BARb aims a Juno pulse: the target classes, their order, the config that
drives it, and what happens when nothing qualifies.

Game mechanics are **not** repeated here. The pulse geometry, the three
`customparams` flags, the full target lists and the `junorework` inversion are
in the shared knowledge base at
`../rjm.bar.docs/knowledge/20-game-mechanics/23-special-systems.md`, section
"Juno". This document covers only what BARb does with them.

## Contents

- [Why the generic super-weapon scan is wrong for a Juno](#why-the-generic-super-weapon-scan-is-wrong-for-a-juno)
- [The priority order](#the-priority-order)
- [How a target is chosen](#how-a-target-is-chosen)
- [Suspected jammers: the radar hole](#suspected-jammers-the-radar-hole)
- [When nothing qualifies](#when-nothing-qualifies)
- [Configuration](#configuration)
- [Which defs are classified](#which-defs-are-classified)
- [Which roles build one](#which-roles-build-one)
- [Known limits](#known-limits)

## Why the generic super-weapon scan is wrong for a Juno

A Juno is a `super`-role stockpile unit, so it gets its own `CSuperTask`
(`CanAssignTo` always returns false, one task per Juno). The generic
`CSuperTask::Update` scan ranks **enemy groups by total metal cost** and
requires the group to stand on enemy-dominated ground.

The pulse does 1 damage. Its effect is `unit_juno_damage.lua` deleting flagged
defs inside the blast. So the generic scan aims it at the richest enemy army -
which contains nothing it can hurt - while the 400 M Advanced Radar Tower
behind the lines loses every comparison to a 3,000 M blob, and the two targets
a Juno is best against (a minefield on our own expansion, a jamming push into
our own ground) are rejected outright by the influence gate.

`CSuperTask::SelectPulseTarget` replaces that scan for pulse weapons. A pulse
weapon **never falls back** to the group scan: spending 200 M + 12,000 E on a
blob it cannot damage is worse than holding the shot.

## The priority order

Default, configurable (see below):

| Rank | Class | What it is |
| ---: | --- | --- |
| 1 | `jammer_static` | Sneaky Pete, Veil, Castro, Shroud, Nyx, Erebus |
| 2 | `radar_static` | Radar Tower, Advanced Radar Tower, Naval Radar/Sonar Tower, Advanced Sonar Station |
| 3 | `jammer_mobile` | Umbra, Smuggler, Obscurer, Deceiver, Tiresias, and the naval jammers Bermuda and Phantasm |
| 4 | `radar_mobile` | Prophet, Compass, Augur, Omen, Euclid |

Jammers outrank radars because jamming denies our threat map outright, while a
radar only gives the enemy vision. Statics outrank mobiles because a static
target is still where we last saw it; a mobile one is a last-known-position
guess.

## How a target is chosen

Every `TARGET_DELAY` (10 s) while the Juno is idle:

1. **Collect candidates.** Walk `CEnemyManager::GetHostileDatas()` - which
   includes enemies no longer visible, at their last known position. Skip
   fakes, dead, dying and ignored. Keep anything whose def carries the `jammer`
   or `radar` config role (read from `respRole`, where `AddRole` puts custom
   config roles), classify it by jammer/radar x static/mobile, and drop classes
   the config excludes.
2. **Freshness.** A mobile target that is currently out of radar and LOS is
   kept only while its last-seen frame is within `mobile_max_age` (default
   60 s). This is the only way to hit a mobile jammer at all - it hides the
   very radar that would track it.
3. **Range.** Must be within the weapon's range of the Juno. At 32,000 that is
   the whole map, so it effectively never binds.
4. **Pick the aim point.** Each candidate's position is a possible impact
   point. For each, look at every candidate within the pulse's AoE (1,400) of
   it and take the best (lowest) rank covered and the summed metal covered.
   Choose the lowest rank first, then the highest covered metal. A point must
   cover at least `min_targets` candidates.
5. **Fire at the ground.** `SetTarget(nullptr)` and attack-ground at the aim
   point: the kill is by area, and the target may not be visible.

Deliberate differences from the generic scan, all of them the point of the
change: **no influence gate** (the best targets are often on our own ground),
**no own-squad exclusion** (the pulse cannot damage our units), and
**ground-attack rather than unit-attack**.

## Suspected jammers: the radar hole

A jammer sits inside its own `radardistancejam` bubble - 360 to 760 in BAR -
and hides itself along with everything near it. It is therefore a *known*
target only where we have LOS on it, which in practice means one of our units
is already standing next to it. Ranking known jammers first is correct, but on
its own it means the Juno almost never fires at a jammer at all, and never
fires at the front when the enemy has jammed it.

`CSuperTask::SelectSuspectedJammer` runs only when the known-target pass finds
nothing, and infers the jammer from the hole it makes. Probes are seeded from
known enemy contacts and thrown one `hole_probe_radius` outward, so the search
follows the front and recently contested ground rather than sweeping the map.
A probe is a suspected jammer when all four hold:

| Test | Why |
| --- | --- |
| inside our radar coverage (`CMapManager::IsInRadar`) | otherwise "no contact" only means "not looking" |
| **not** in our LOS (`IsInLOS`) | with eyes on the ground we would see the units directly |
| enemy influence >= `hole_min_enemy_infl` | the enemy operates here; empty rear ground is not evidence |
| no known contact within `hole_radius` | the hole itself |

Ranked by enemy influence, so the strongest belief wins. The pulse AoE (1400)
is wider than the widest jam radius (760), so aiming at the hole tends to catch
whatever made it.

**This is what lets a Juno walk a line.** Each shot that removes a jammer turns
its pocket into radar contacts, which moves the next hole further along the
front, so successive shots progressively strip the enemy's radar denial instead
of stalling on the first one.

**Known targets always outrank suspected ones.** A jammer or radar spotted deep
behind the enemy line keeps priority over any inferred hole, because its
position is certain while a hole is a guess about a 500-elmo circle.

The log distinguishes the two:

```text
PULSE armjuno(1234): suspected jammer, radar hole at (4210,3180) enemyInfl=0.412 (probes=96)
PULSE armjuno(1234): no suspected jammer | probes=96 rejRadar=40 rejLos=18 rejInfl=31 rejOccupied=7
```

`rejRadar` counts probes outside our radar coverage, which is the usual reason
the inference finds nothing: without radar over the enemy's ground there is no
hole to see. Extending radar coverage toward the front is a prerequisite for
this working at all.

## When nothing qualifies

No priority target **and** no suspected jammer means the Juno **holds its
shot**:

```cpp
unit->CmdStop();
SetTarget(nullptr);
targetFrame = frame;   // retry in 10 s
```

It does not fall back to the group scan, does not fire at anything else, and
`commandfire = true` means the weapon never self-fires. The stockpile keeps
filling to `stockpilelimit` (20) at 200 M + 12,000 E each - `CMilitaryManager`
re-issues `Stockpile` on every defence update at misc priority 2 - so an idle
Juno can park up to 4,000 M and 240,000 E in unfired missiles.

It is no longer silent about it. Once a minute per unit it logs:

```text
PULSE armjuno(1234): no target | range=32000 candidates=0 rejRange=0 rejStale=2 minTargets=1
```

`rejStale` counts mobile targets dropped for a stale last-known position, so a
Juno that never fires now says whether it saw nothing or only saw ghosts. The
generic super-weapon diagnostic was previously gated on regional weapons and so
never covered map-range Junos at all; that gate is gone too.

## Configuration

Root block in `data/config/<profile>/behaviour.json`, read by
`CMilitaryManager::ReadConfig`:

```json
"pulse": {
    "enabled": true,
    "role": "juno",
    "jammer": "jammer",
    "radar": "radar",
    "priority": ["jammer_static", "radar_static", "jammer_mobile", "radar_mobile"],
    "mobile_max_age": 60,
    "min_targets": 1
}
```

| Key | Effect |
| --- | --- |
| `enabled` | false restores the generic group scan for Junos |
| `role` | the config role marking a def that carries a pulse weapon |
| `jammer` / `radar` | the config roles marking targets |
| `priority` | order of the four classes; **omit a class and it is never targeted** |
| `mobile_max_age` | seconds a mobile target's last known position stays usable |
| `min_targets` | raise above 1 to require a cluster before spending a shot |
| `suspect_jammer` | false disables the radar-hole fallback entirely |
| `hole_probe_radius` | how far off a known contact to probe; the widest BAR jam radius |
| `hole_radius` | a probe with no known contact inside this is a hole |
| `hole_min_enemy_infl` | minimum enemy influence for the ground to count as enemy-held |
| `hole_probes` | probe directions per known contact |

An unknown role name disables the policy and logs `CONFIG <profile>: pulse
unknown role '<name>'` rather than silently targeting nothing. Present in
`experimental_balanced`, `experimental_hard` and `experimental_terrible`; the
legacy profiles have no `pulse` block, so their Junos keep the generic scan.

## Which defs are classified

Classification is entirely JSON: a def is a target because its
`behaviour.json` entry lists `jammer` or `radar` in `role`. The role is
**appended** - the first entry is the main role and drives task assignment, so
it must not move.

Tagged in this change: 22 defs in `behaviour.json` (Armada and Cortex) and 7 in
`behaviour_leg.json` (Legion), across all three experimental profiles. That is
every sensor and EW def BAR flags `juno_kill` except the three no builder can
build (`armsonar`, `corsonar`, `cormine4`).

To add one, append the role to its entry; no rebuild is needed for the tagging
itself, but the deployed `config/` tree must be refreshed.

## Which roles build one

The Juno reaches the map through one route only: position 7 of the porcupine
chain. Five of the six AngelScript roles keep that default.

**SUPPORT does not.** `Support_PorcChain` swaps its side's Juno for the side's
ranged tactical launcher — `armemp`, `cortron`, `legperdition` — so a SUPPORT
player builds no Junos at all. The reasoning, and what it costs, is in
[`roles/support.md`](roles/support.md#porcupine-chain-the-launcher-swap). This
policy still applies to the Junos a SUPPORT player captures or inherits, and
to every other role's.

## Known limits

1. **`legavjam` (Cicero) and `legavrad` (Pheme) have no `behaviour.json` entry
   in any profile**, so those two Legion mobile EW units are invisible to the
   policy. Add entries to tag them.
2. **A radar hole is a guess.** It is equally consistent with an enemy that
   simply has nothing there and whose influence bled in from neighbouring
   units. The influence threshold and the seeding from real contacts keep it
   plausible, but a wasted shot is possible; `hole_min_enemy_infl` is the dial.
3. **Mines and scout spam are not targeted.** They are flagged `mine` /
   `juno_deny` in BAR and a pulse deletes them, but they are not sensors and
   carry no `jammer` / `radar` role, so they fall outside the four classes.
   Covering them needs a third config role and two more classes.
4. **`junorework` is not detected.** Under that mod option the gadget inverts -
   scouts die, sensors and mines are only EMP-stunned for 30 s - which makes
   this whole priority order close to backwards. Nothing reads the option yet.
5. **The mobile mini-Juno is not covered.** `legcib` (Blindfold, Legion air,
   100 M) fires `juno_pulse_mini`, but it is *mobile*, so
   `CMilitaryManager::MakeTask` gives it an ATTACK task rather than a
   `CSuperTask`; `SelectPulseTarget` never sees it. Tagging it `juno` would
   change nothing. Covering it means handling pulse weapons in the mobile
   fighter path too.
6. **Aim-point search is O(n^2)** over classified candidates in range. With the
   few dozen sensors a game holds that is negligible; it would need a grid if
   the candidate set ever got large.

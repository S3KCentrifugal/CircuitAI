# Ranged support: safe firing positions and siege target selection

Reviewed 2026-10-05 against CircuitAI `ff1925d0` and `5dcf78bc`.
**Safe firing range and refusal to pursue bait are the primary acceptance
criteria.** Reduced heavy-target preference is an acceptable tradeoff when it
prevents greater unit losses while preserving useful damage and progress.
No runtime code or profile was changed for this review.

This document records source-confirmed mechanisms, reported gameplay failures,
and solutions grounded in the official PvP unit guidance linked below. The
proposed changes still require comparative combat tests. Numerical balance can
differ from the locally pinned game; recommendations must use loaded weapon
capabilities and legal enemy observations.

## PvP engagement priorities: survival and useful fire before target preference

A reported gameplay failure involves a Fatboy inside a repaired static line
baiting large numbers of ranged units into fatal exposure. The battle has not
been reproduced in a controlled fixture. Against that
failure, preserving an anti-heavy label is not a sufficient reason to keep the
existing behavior. Sharpshooters and Starlights must not be exempt from the
range/no-pursuit requirement merely because they have an anti-heavy niche.

Additional source tracing identified paths consistent with the report:

- [AntiHeavyTask::FindTarget](../../src/circuit/task/fighter/AntiHeavyTask.cpp)
  filters for HEAVY/COMM and compares aggregate squad power with threat at the
  target position. This is not a hard guarantee that each shooter's firing
  position and approach stay outside hostile static coverage.
- Its out-of-range target path query in `Update` uses pathfinder square size
  as the goal radius, not weapon range. A strong target preference can therefore
  request an approach far closer than the weapon requires.
- Its engagement calls [CircuitUnit::Attack](../../src/circuit/unit/CircuitUnit.cpp),
  whose ordinary path sends an attack and, by default, a queued FIGHT at the
  target position. That is not a persistent non-pursuit firing contract.
- Separately, [SquadTask::Attack](../../src/circuit/task/fighter/SquadTask.cpp)
  uses `RANGE_MOD` = 0.8 from
  [FighterTask.h](../../src/circuit/task/fighter/FighterTask.h). Against static
  or unseen targets it deliberately moves one unit of the first range row to
  80% of the smaller of weapon range and LOS radius. This sacrifices range for
  spotting and must not be inherited by protected ranged support.
- `CircuitUnit::KeepWeaponRange` already offers an opt-in no-chase mechanism,
  but Sharpshooter/Starlight do not enable it in the inspected experimental
  profiles. It also maintains distance from the selected enemy rather than
  proving the proposed position/path is outside other enemy weapons. Simply
  adding a standoff number is not a verified fix for the static bait case.

The engagement contract, in order, is:

1. Establish a reachable firing position near the usable maximum range, with
   line of fire and clearance from known hostile static coverage. A higher-value
   target cannot override that safety boundary. Do not move a ranged unit into
   LOS solely to spot its own target; use allied vision/radar where available.
2. Fire on useful targets already reachable from that safe position. Allow
   mobile targets without granting pursuit. Anti-heavy preference is a tie-break
   among safe firing opportunities, not permission to advance through defenses.
3. If bait retreats into protection, clear pursuit and attack an accessible
   static or another target in range. Account for repair/regen and exposure when
   estimating useful damage; do not fixate indefinitely on an unkillable tank.
4. Advance deliberately after the covering defenses are removed and the next
   firing position is safe. A motionless army that survives but never attacks
   is not a passing result.

Maximum range can reduce exposure and preserve separation; it does not itself
guarantee invisibility against enemy spotters/radar or safety against longer-range
weapons. Starlight's beam falloff does not justify charging into static coverage:
survival takes precedence over theoretical close-range DPS. The
[official Starlight guide](https://www.beyondallreason.info/unit/armmanni)
likewise recommends a protected, spread-out position; the
[Sharpshooter guide](https://www.beyondallreason.info/unit/armsnipe) emphasizes
vision support.

**Comparison experiment.** Compare (A) current profiles, (B) the uniform
artillery/siege patch, including Sharpshooter and Starlight, and (C) an explicit
safe-range/no-pursuit implementation. B is a credible conservative workaround,
whose loss of heavy-target preference is a measurable tradeoff. Its structure-only
selection/return-fire restrictions still require measurement. If B is materially
safer and useful against the defense line, reduced mobile-target specialization
is acceptable; preserve useful in-range fire in C without restoring bait pursuit.
Carrier and counter-classification effects remain independent checks.

The first mandatory fixture is a mobile Fatboy behind repair-supported turrets,
with targets visible to allied spotters. Move the bait forward/back, change its
target value and let it retreat out of range. Measure ranged-unit metal lost,
time spent under static fire, actual shot distance, damage to the defensive line,
target switches, and orders. Repeat without spotters, with mixed weapon ranges,
and after the static line dies. Require **both survival and useful progress**.
This diagnostic is recorded as KI-504; no comparative simulation has yet run.

## Implementation constraints and tradeoffs

### Target selection and fire state

[MilitaryManager::DefaultMakeTask](../../src/circuit/module/MilitaryManager.cpp)
maps the main artillery role to `CArtilleryTask`. Its
[FindTarget](../../src/circuit/task/fighter/ArtilleryTask.cpp) excludes
`edef->IsMobile()` in both passes. It selects known structures, not the first
arbitrary enemy entering range. Its safe-position pass also excludes enemy
definitions carrying `siege`.

`AssignTo` sets HOLD_POS, and for siege-tagged artillery sets RETURN fire state
and selects `CFightAction` instead of `CMoveAction`. The return-fire change is
intentional [D-031](../decisions.md#d-031--siege-artillery-holds-fire-for-anything-but-its-ordered-target):
Longbows were wasting shots on passing boats. Recoil's
`MobileCAI.cpp::ExecuteFight` only performs proactive nearby-target acquisition
when `fireState >= FIRESTATE_FIREATWILL`. Therefore FIGHT travel does not negate
the return-fire restriction. Explicit orders and retaliation remain possible;
this is not a claim that these units can never shoot a mobile unit.

Tradeoffs to measure include removing Sharpshooter/Starlight anti-heavy
selection and reducing Hound/Fatboy/Banisher proactive anti-army fire. These
costs must be weighed against survival and useful damage from safe positions. [AntiHeavyTask](../../src/circuit/task/fighter/AntiHeavyTask.cpp) currently
selects HEAVY/COMM targets; replacing its role removes that behavior.

### Shared classifications affect multiple roles

These are land units in shared per-profile UnitDefs. Every role using those
definitions, including FRONT and donated TECH units, can be affected. Scope
changes through explicit policy settings and verify other-role regressions.

[FactoryManager::ReadConfig](../../src/circuit/module/FactoryManager.cpp)
treats the first `role` entry as the own-unit main role. All role entries also
contribute enemy-response categories. Entries after the first are not extra
own-unit combat orders. Replacing `["assault", "heavy"]` for Fatboy and
`["artillery", "heavy"]` for Tremor with `["artillery"]` removes their HEAVY
enemy classification, changing counter accounting as well as own-unit control.
`attribute` can also contain extra own-unit roles: deleting Sheldon's
`skirmish` or Starlight's `artillery` removes those capabilities from native
role masks/factory-role mappings. Keeping the rest of each object byte-identical
does not make these changes behaviorally narrow.

Script production still has separate unit groupings in
[bot factory configuration](../../data/script/src/manager/factory_production/factory_configs_bot.as)
and [vehicle factory configuration](../../data/script/src/manager/factory_production/factory_configs_vehicle.as).
For example, Hound/Sharpshooter/Sheldon are selected as skirmish production,
Fatboy as riot, Starlight/Medusa as assault and Mantis as support. A JSON-only
rewrite would not align those production intentions with their new combat task.

### Carrier mechanics require separate acceptance

Mantis is a drone carrier, not a conventional damage-dealing artillery barrel.
The local `legvcarry.lua` has a zero-damage targeting weapon and carrier custom
parameters. BAR's `unit_carrier_spawner.lua` reads carrier orders/weapon target
and fire state, propagates fire state, and dispatches drone orders. Changing
the carrier's selected targets and fire state can therefore affect drone
engagement. Do not infer safety from its 1,000-elmo targeting range. The
[official Mantis guide](https://www.beyondallreason.info/unit/legvcarry)
describes harassment, catching raiders and point-attack patrols. Carrier
positioning and drone ownership need their own fixture before reclassification.

### Range control and formation safety

`CArtilleryTask::CanAssignTo` accepts one unit, so this is an independent
structure-hunting task, not a formation slot behind the allied frontline.
It uses weapon range as the path-query goal radius, safe-position fallback and
engine attack commands. `siege` changes travel/fire behavior; it is not an exact
range-boundary controller. Terrain, line of fire, weapon trajectory, splash,
enemy range and the allied screen still need explicit positioning policy.
Starlight also trades damage for distance: the
[official guide](https://www.beyondallreason.info/unit/armmanni) documents beam
damage falloff and recommends protected, spread-out positioning. Maximum range
is a safety preference, not a universally optimal damage position.

### Configuration edits must preserve unrelated data

The active source is `data/config/`; `stable/config/` is deployment output.
Do not edit the live BAR installation or `data_sample/`. The
[config loader](../../src/circuit/setup/SetupManager.cpp) loads each selected
profile fragment and falls back to the root fragment if that whole file is
absent; the root is not a universal per-unit merge beneath every profile file.
Legion fragments are selected by profile init/options. Game-side config can
also take precedence, so an acceptance run must capture actual loaded paths.

The inventory found 15 files, 77 relevant unit objects, 75 differing objects,
and 44 objects without an `attribute` key. Thus "change only those two lines"
is literally impossible for many entries: one property must be inserted.
The only already-exact objects are `cortrem` in hard/behaviour.json and
`legamcluster` in hard/behaviour_leg.json. Root behaviour_leg.json does not exist.

The files contain comments and mixed newline styles. In particular, Legion
files contain CRLF plus a final LF-only line. A future migration should patch
raw byte spans inside validated unit objects, preserve each existing line's
terminator, insert a missing attribute using its local terminator, and assert
that all bytes outside the permitted spans remain identical. Parse for
validation, but do not serialize/reformat whole files.

## Unit-by-unit recommendation

These are proposed behavior contracts, not blindly interchangeable existing
JSON recipes. Exact tuning requires controlled combat tests.

| Unit | Recommended control and reason |
| --- | --- |
| [Fatboy](https://www.beyondallreason.info/unit/armfboy) `armfboy` | Ranged anti-swarm support, screened and spread; preserve grouped mobile targets and avoid friendly splash. Its official use includes destroying grouped units and supporting snipers against Sheldons. Do not force structure-only artillery. |
| [Hound](https://www.beyondallreason.info/unit/armfido) `armfido` | Mobile skirmishing with spotters, maintaining a safe range while attacking T1 units. Keep anti-army selection. |
| [Sharpshooter](https://www.beyondallreason.info/unit/armsnipe) `armsnipe` | Preserve anti-heavy/commander targeting, vision support, cloak and reload-aware positioning. Long range alone is not a reason to replace its task with a static-target selector. |
| [Starlight](https://www.beyondallreason.info/unit/armmanni) `armmanni` | Preserve mobile-heavy targeting and useful static attacks; keep a screen and spacing. Account for the safety/damage tradeoff rather than requiring exact maximum range. |
| [Sheldon](https://www.beyondallreason.info/unit/cormort) `cormort` | Mobile skirmisher/fire support with radar/jammer support and defensive-line targets. Current experimental artillery+siege behavior already warrants correction; removing its skirmish attribute does not fix that. See KI-503. |
| [Banisher](https://www.beyondallreason.info/unit/corban) `corban` | Burst skirmish/anti-army targeting with reload withdrawal and supporting units; preserve opportunistic AA capability. The official guide specifically identifies Hounds and fast units as targets. |
| [Tremor](https://www.beyondallreason.info/unit/cortrem) `cortrem` | Strong artillery candidate, but select safe bombardment areas including mobile concentrations. Retain heavy enemy classification. Friendly splash checks and screening are essential. |
| [Cleaver](https://www.beyondallreason.info/unit/legamcluster) `legamcluster` | Strong artillery candidate with protected range and relocation; preserve swarm/formation suppression instead of limiting every attack to structures. |
| [Medusa](https://www.beyondallreason.info/unit/legmed) `legmed` | Protected long-range salvo control, prioritizing useful static targets and valuable mobile concentrations. Candidate for artillery-style movement, with volley completion and reload tests. |
| [Mantis](https://www.beyondallreason.info/unit/legvcarry) `legvcarry` | Carrier standoff and support behavior with explicit mobile/area target policy; preserve the game gadget's drone control, launch, recall, stockpile and repair behavior. Test independently. |

## Proposed solutions

1. Separate **target policy**, **range/formation policy**, **travel mode** and
   **fire state**. Keep their settings script/JSON-controlled. Preserve D-031's
   naval static-bombardment behavior as the default for existing users.
2. Correct ranged units entering unsafe range within their appropriate combat
   tasks, or add an opt-in ranged controller with static/mobile/area target
   modes. Do not change shared classes merely to compensate for positioning.
3. Preserve counter categories and additional roles unless a specific test
   justifies removing them. Align production groupings only when production
   intent changes, rather than silently changing them as collateral cleanup.
4. Review the existing Sheldon mismatch first; pilot Tremor/Cleaver/Medusa
   bombardment separately; use anti-heavy and carrier-specific fixtures for
   Sharpshooter/Starlight and Mantis respectively.
5. For configuration migrations, pin source and destination commits plus
   game/engine versions, generate a per-profile diff manifest, patch only
   approved properties with byte preservation, and run runtime checks against
   the actually loaded profile paths.

## Verification plan

This review performed source/data inspection and primary-source research only;
it did not run a modified candidate or assert a measured gameplay improvement.
Use categorized definitions under `tools/playtest/cases/shared/combat/` and
checks under `tools/playtest/checks/shared/combat/`, following the existing
[test storage convention](../test-storage.md). Proposed scenarios:

| Scenario | Required physical evidence |
| --- | --- |
| Mobile target enters range, no enemy buildings | Proactive shot/volley before target closes; exclude self-defense-only success. Sharpshooter/Starlight select heavy/commander targets. |
| Static target at range, across slopes/cliffs | Actual firing distance, line-of-fire success, no walk into enemy weapon coverage when a safe firing site exists. |
| Mixed mobile + static targets | Retain useful anti-army fire while selecting the intended siege target; no idle unit simply because the last building died. |
| Closing raiders during reload | Ranged unit preserves useful distance, allies screen it, movement does not continually reset a weapon volley. |
| Friendly screen beside enemy cluster | Track enemy damage, friendly splash losses, formation separation and useful firing uptime for Fatboy/Tremor/Cleaver/Medusa. |
| Fog/radar and target loss | Legal knowledge only; reacquisition, no permanent stale attack or idle stall. |
| Mantis vs moving raiders and static base | Drone launch, target adoption, pursuit/area patrol, recall/docking and carrier survival; no AI/gadget ownership fight. |
| Longbow / missile ship control regression | Existing D-031 structure-target preference and SEA control remain intact. |
| All profile load and production checks | Seven difficulties, Legion toggles and relevant extra-unit options; intended task IDs, fire states, production/counter-role accounting. |

Use identical seeded forces and supported economy for baseline/candidate runs.
Log actual commands, task ownership, target classes, distances, damage/losses,
CPU and orders per game minute. Do not count a config diff or "attack issued"
line as proof of maximum-range firing. More single-unit artillery tasks may
increase target/path-query work; measure rather than predicting an FPS gain.

## Exact current configuration inventory

The following rows are generated from every active behaviour.json and
behaviour_leg.json; a dash means the property is absent. No profile edits were
made. Grouping identical arrays does not merge the files or imply equal runtime
behavior across profiles.

<!-- Inventory appended by the review audit. -->

| Unit | Role | Attribute | Files |
| --- | --- | --- | --- |
| `armfboy` | `['assault', 'heavy']` | `-` | [root](../../data/config/behaviour.json), [easy](../../data/config/easy/behaviour.json), [experimental_balanced](../../data/config/experimental_balanced/behaviour.json), [experimental_hard](../../data/config/experimental_hard/behaviour.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour.json), [medium](../../data/config/medium/behaviour.json) |
| `armfboy` | `['heavy']` | `-` | [hard](../../data/config/hard/behaviour.json) |
| `armfido` | `['skirmish']` | `-` | [root](../../data/config/behaviour.json), [easy](../../data/config/easy/behaviour.json), [experimental_balanced](../../data/config/experimental_balanced/behaviour.json), [experimental_hard](../../data/config/experimental_hard/behaviour.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour.json), [medium](../../data/config/medium/behaviour.json) |
| `armfido` | `['assault']` | `['siege']` | [hard](../../data/config/hard/behaviour.json) |
| `armsnipe` | `['anti_heavy']` | `-` | [root](../../data/config/behaviour.json), [easy](../../data/config/easy/behaviour.json), [experimental_balanced](../../data/config/experimental_balanced/behaviour.json), [medium](../../data/config/medium/behaviour.json) |
| `armsnipe` | `['anti_heavy']` | `['siege']` | [experimental_hard](../../data/config/experimental_hard/behaviour.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour.json) |
| `armsnipe` | `['anti_heavy_ass']` | `['siege']` | [hard](../../data/config/hard/behaviour.json) |
| `armmanni` | `['anti_heavy']` | `['artillery']` | [root](../../data/config/behaviour.json), [easy](../../data/config/easy/behaviour.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour.json), [medium](../../data/config/medium/behaviour.json) |
| `armmanni` | `['anti_heavy', 'assault']` | `['artillery', 'siege']` | [experimental_balanced](../../data/config/experimental_balanced/behaviour.json), [experimental_hard](../../data/config/experimental_hard/behaviour.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour.json) |
| `armmanni` | `['anti_heavy_ass']` | `['siege']` | [hard](../../data/config/hard/behaviour.json) |
| `cormort` | `['artillery']` | `['skirmish']` | [root](../../data/config/behaviour.json), [easy](../../data/config/easy/behaviour.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour.json), [medium](../../data/config/medium/behaviour.json) |
| `cormort` | `['artillery']` | `['skirmish', 'siege']` | [experimental_balanced](../../data/config/experimental_balanced/behaviour.json), [experimental_hard](../../data/config/experimental_hard/behaviour.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour.json) |
| `cormort` | `['assault']` | `['support']` | [hard](../../data/config/hard/behaviour.json) |
| `corban` | `['skirmish']` | `-` | [root](../../data/config/behaviour.json), [easy](../../data/config/easy/behaviour.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour.json), [medium](../../data/config/medium/behaviour.json) |
| `corban` | `['skirmish']` | `['siege']` | [experimental_balanced](../../data/config/experimental_balanced/behaviour.json), [experimental_hard](../../data/config/experimental_hard/behaviour.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour.json) |
| `corban` | `['assault']` | `['siege']` | [hard](../../data/config/hard/behaviour.json) |
| `cortrem` | `['artillery', 'heavy']` | `-` | [root](../../data/config/behaviour.json), [easy](../../data/config/easy/behaviour.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour.json), [medium](../../data/config/medium/behaviour.json) |
| `cortrem` | `['artillery', 'heavy']` | `['siege']` | [experimental_balanced](../../data/config/experimental_balanced/behaviour.json), [experimental_hard](../../data/config/experimental_hard/behaviour.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour.json) |
| `cortrem` | `['artillery']` | `['siege']` | [hard](../../data/config/hard/behaviour.json) |
| `legamcluster` | `['artillery']` | `-` | [easy](../../data/config/easy/behaviour_leg.json), [experimental_balanced](../../data/config/experimental_balanced/behaviour_leg.json), [experimental_hard](../../data/config/experimental_hard/behaviour_leg.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour_leg.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour_leg.json), [medium](../../data/config/medium/behaviour_leg.json) |
| `legamcluster` | `['artillery']` | `['siege']` | [hard](../../data/config/hard/behaviour_leg.json) |
| `legmed` | `['assault']` | `-` | [easy](../../data/config/easy/behaviour_leg.json), [hard](../../data/config/hard/behaviour_leg.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour_leg.json), [medium](../../data/config/medium/behaviour_leg.json) |
| `legmed` | `['assault']` | `['siege']` | [experimental_balanced](../../data/config/experimental_balanced/behaviour_leg.json), [experimental_hard](../../data/config/experimental_hard/behaviour_leg.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour_leg.json) |
| `legvcarry` | `['riot']` | `-` | [easy](../../data/config/easy/behaviour_leg.json), [experimental_balanced](../../data/config/experimental_balanced/behaviour_leg.json), [experimental_hard](../../data/config/experimental_hard/behaviour_leg.json), [experimental_terrible](../../data/config/experimental_terrible/behaviour_leg.json), [hard](../../data/config/hard/behaviour_leg.json), [hard_aggressive](../../data/config/hard_aggressive/behaviour_leg.json), [medium](../../data/config/medium/behaviour_leg.json) |

# Experimental balanced: siege inventory and ranged-behavior attributes

2026-10-05. Reviewed CircuitAI `62ff92b2`, BAR `1d267c20d1`, Recoil
`92efda5e60`, the matching shared unit cache, mounted weapon definitions and
relevant unit scripts. Official PvP unit/command guidance was revisited.
**Proposal only: no gameplay/configuration implementation or new simulation.**

This refines the [implementation plan](../ranged-support-implementation-plan.md).
Game mechanics and their primary sources are recorded separately in
[ranged fire and withdrawal](../../../rjm.bar.docs/knowledge/60-tactics/69-ranged-fire-and-withdrawal.md).
The tactics below are informed proposals, not measured competitive win-rate
claims. Retain the baseline/config-only/controller comparison from D-204.

## Findings from the complete profile inventory

The authoritative profile is `data/config/experimental_balanced/`:

| Fragment | Existing `siege` objects | Loading |
| --- | ---: | --- |
| [behaviour.json](../../data/config/experimental_balanced/behaviour.json) | 36 | Base profile |
| [behaviour_leg.json](../../data/config/experimental_balanced/behaviour_leg.json) | 10 | Legion enabled in profile init |
| [behaviour_extra_units.json](../../data/config/experimental_balanced/behaviour_extra_units.json) | 0 | Extra Units option |
| [behaviour_scav_units.json](../../data/config/experimental_balanced/behaviour_scav_units.json) | 5 | Separate player Scavenger option |

The 46 standard/Legion entries comprise **20 land, 3 hover, 10 surface ships,
3 submarines, 8 aircraft and 2 static structures**. The ten-unit proposal adds
five definitions not currently tagged siege: Fatboy, Hound, Sharpshooter,
Cleaver and Mantis. Thus the union reviewed here is 51 standard definitions
plus five optional Scavenger definitions. The full per-unit inventory follows
at the end; counts refer to config entries, not guaranteed availability in a
particular match.

Important current facts:

- `siege` is overloaded. Multiple tasks select FIGHT travel from it; artillery
  additionally sets return fire and selects structures. Static `siege` can
  change whether other artillery considers that structure. It is not a general
  promise of safe range, good spacing, or shooting the first enemy encountered.
- In this profile Sharpshooter is `anti_heavy` with **no attributes** and
  `retreat:0.95`. Starlight is `anti_heavy,assault`, attributes
  `artillery,siege`, and **`retreat:0`**. The profile's fighter retreat defaults
  are `[0,0.2,1]`; the final multiplier is one. These are health-fraction gates,
  not turn-time or interception prediction.
- In `IFighterTask::OnUnitDamaged`, positive health with a zero retreat threshold
  normally returns before health-based retreat checks, unless another condition
  such as disarm applies. Starlight is therefore poorly configured for an early
  health-based escape. Sharpshooter's 0.95 gate can trigger after slight damage,
  but immediate retreat is still conditional on target/threat state.
- `CRetreatTask` can request cloak and uses MOVE by default. `ret_fight` changes
  that to FIGHT, which can stop to engage and undermine escape. Do not assign it
  as a shorthand for firing while moving away. Also, its cloak branch currently
  overwrites the earlier `ret_hold` fire state with RETURN: reusing `ret_hold`
  for cloaked emergency escapes needs a scoped correction.
- Mobile radar/jammer support searches ATTACK/DEFEND tasks. It does not currently
  offer an escort anchor for native AH/ARTY groups. Its candidate helper casts
  to `ISquadTask`, so simply adding ARTY to its task list would be unsafe.

Sources: [attributes](../../src/circuit/unit/CircuitDef.h),
[configuration parser](../../src/circuit/module/FactoryManager.cpp),
[health retreat](../../src/circuit/task/fighter/FighterTask.cpp),
[retreat initialization](../../src/circuit/task/RetreatTask.cpp),
[sensor selection](../../src/circuit/task/fighter/SupportTask.cpp).

## Minimal attribute proposal: add only `ranged`

Add **one** new native attribute, `ranged`, as the opt-in to the configured safe
ranged controller. Keep existing roles and attributes and their existing
semantics for all units not opted in. No new `sniper`, `fragile`, `beam`,
`cloak`, `kite`, `rear_fire`, `spread`, `screened` or `retreat_early` bits.

Weapon arc, ability to fire while moving, personal cloak, beam/burst duration,
turn/acceleration limits, reverse speed, collision size and death blast are
capabilities/values. Read them from the loaded game, with an explicit policy
override only for script/gadget restrictions not exposed by the wrapper. A
`turret:true` flag alone is insufficient: Starlight still has a frontal arc.

Use four small **target-policy presets**, not more attributes:

| JSON `target_mode` | Intended choice among safe legal shots |
| --- | --- |
| `precision` | Useful high-value/finishable targets; account for armor, energy, reload and already-committed shots. Heavy preference is secondary to safety and progress. |
| `skirmish` | Dangerous reachable mobile units and useful statics; permit fire during withdrawal when the weapon/aim allows it. |
| `bombardment` | Defensive positions, slow valuable targets and mobile concentrations; area damage/friendly clearance and projectile travel matter. |
| `carrier` | Delegate weapon/area targets to the carrier; preserve gadget ownership of drones and use actual drone effectiveness, not fake-barrel damage. |

Numeric spacing and range are tuning, not tags. Cloak-on-reload and fire-state
policy are a small settings block. Withdrawal selects its physically feasible
mode from capabilities. Existing `ret_hold` remains an emergency-repair retreat
instruction, not a ban on tactical fire while backing away.

### Proposed exact attribute lists for the ten-unit request

Existing roles, response categories and production membership remain intact.
Existing `siege` is retained for compatibility; when `ranged` owns combat it
does not use legacy siege FIGHT/RETURN logic for its movement/target selection.
Removing redundant old tags can be a later measured migration, not collateral
cleanup in this fix.

| Unit | Proposed complete `attribute` list | Target mode | Movement/formation policy |
| --- | --- | --- | --- |
| Fatboy `armfboy` | `["ranged"]` | skirmish | Anti-swarm fire support; preserve separation from its own screen and suppress pursuers; do not hide a durable riot unit behind every sniper by a fixed row rule. |
| Hound `armfido` | `["ranged"]` | skirmish | Mobile range control, screening and lateral/rear displacement when enemies close. |
| Sharpshooter `armsnipe` | `["ranged", "ret_hold"]` | precision | Safe aimed shots, independent turret during tactical withdrawal, cloak/reload control; full emergency escape prioritizes concealment. |
| Starlight `armmanni` | `["artillery", "siege", "ranged"]` | precision | Sparse enemy-facing line; preplanned turns/exits; early committed withdrawal and safe reorientation. |
| Sheldon `cormort` | `["skirmish", "siege", "ranged"]` | skirmish | Proactive mobile fire while maneuvering, with screen and sensor support. |
| Banisher `corban` | `["siege", "ranged"]` | skirmish | First-strike missile and long-reload safety; choose broadside posture when it shortens escape and maintains a shot; preserve opportunistic AA. |
| Tremor `cortrem` | `["siege", "ranged"]` | bombardment | Sustained area fire, target concentrations/defenses, screen and friendly splash protection. |
| Cleaver `legamcluster` | `["ranged"]` | bombardment | Cluster suppression; forward arc and turn cost require safe firing sites and early exits. |
| Medusa `legmed` | `["siege", "ranged"]` | bombardment | Preserve target-designation/rocket interaction and full salvos; plan around long reload and slow hull, not the zero-damage marking beam. |
| Mantis `legvcarry` | `["ranged"]` | carrier | Keep parent behind useful cover; drones provide harassment/vision; never drive the carrier into range because its nominal direct damage is zero. |

Sharpshooter example (proposed schema, not accepted by current code):

```json
"role": ["anti_heavy"],
"attribute": ["ranged", "ret_hold"],
"retreat": 0.95,
"ranged": {
  "target_mode": "precision",
  "range_fraction": 0.95,
  "spacing": 96,
  "screen": "prefer",
  "withdraw": "capability",
  "cloak_on_reload": true
}
```

Starlight example:

```json
"role": ["anti_heavy", "assault"],
"attribute": ["artillery", "siege", "ranged"],
"retreat": 0.65,
"ranged": {
  "target_mode": "precision",
  "range_fraction": 0.95,
  "spacing": 256,
  "screen": "prefer",
  "withdraw": "capability"
}
```

The new numbers are candidate settings, not validated optima. Sharpshooter's
existing health gate is initially preserved; Starlight's proposed 0.65 restores
a meaningful fallback while predictive withdrawal can act at full health.
Spacing is a minimum desired center separation, raised by loaded blast/collision
requirements and current threats. If terrain cannot fit it, use staggered
sections or another site, not forced packing or permanent deadlock.

`ranged` attribute membership is the single enable switch. This replaces the
earlier plan's independent `ranged.enabled` proposal. Do not keep both and risk
contradictory settings. The existing numeric `standoff` setting remains legacy
behavior; an opted-in controller consumes it only as a documented default if
no explicit new range fraction is set, never as a second movement controller.

## Targeting, observation and supporting units

Eligibility comes before scoring: target is legally known, its relevant weapon
can damage it, a usable trajectory exists, firing position/route are safe and
friendly splash is acceptable. Apply dynamic danger to the screen, useful
damage, exposed weapons, efficient kills and target specialization after that.
Do not hardcode commanders or T3 above every other target. The pinned sniper
and Starlight weapons both deal reduced damage to commanders.

Distinguish **own LOS**, **allied observation**, **radar accuracy** and **line of
fire**. Do not send a sniper with 455 sight to self-spot a 900-range shot or a
Starlight with 650 sight into danger for a 950-range shot. Use allied scouts,
existing frontline units, radar and observation positions. Prefer precise sight
for precision shots; allow radar shots when the estimated usefulness is good.
Jammed/lost contacts must not become omniscient target tracking. Ballistic,
beam, starburst and carrier weapons cannot share one naive straight-line test.

Reuse the sensor escort policy, but extend it with a safe **escort-anchor
interface** for ranged cohorts. A cohort is a local set sharing a firing line,
not a new gameplay attribute or a new task kind. Keep the individual artillery
task's one-unit ownership; sensor tasks follow a cohort anchor without being
cast/assigned as artillery members. Preserve old ATTACK/DEFEND support paths.
Allocate radar/vision and jammer coverage according to marginal coverage and
existing sensors, with explicit quotas and lifecycle cleanup. Do not repeat the
old behavior of many radar units following one shooter. Repair support stays
behind the escape line or receives injured units at a safe rendezvous.

Do not conscript a commander into frontline spotting/cover just because it is
nearby. A commander already fighting can contribute observations and screen
geometry, but its own role, economy and safety policy keep command ownership.

## Tactical withdrawal is different from retreating for repair

Use a small state machine owned by the ranged controller:

```text
ASSEMBLE -> SAFE_ADVANCE -> FIRE
                         /    \
              TACTICAL_WITHDRAW  RELOAD/HOLD
                         \    /
                      SAFE_REORIENT

Any state -> EMERGENCY_ESCAPE -> REPAIR -> REJOIN
```

Tactical withdrawal keeps the unit in its ranged task and may continue useful
shots without interrupting MOVE. Emergency escape clears dangerous firing
intent and hands movement to the existing retreat/repair owner. A health
percentage alone is too late for slow hulls: estimate enemy time to reach a
dangerous firing/intercept distance against own turn + acceleration + exit time,
including reaction margin and obstacles. Known incoming bursts/air threats can
override an otherwise safe range relationship. State hysteresis prevents
forward/back and target/escape oscillation.

**Sharpshooter sequence:** obtain a safe firing slot and useful observed target;
request cloak where affordable; allow a ready aimed shot; after firing retain
cloak intent and allow the game to recloak; move laterally/back only when useful
for safety or the next shot. During tactical withdrawal its turret can engage a
safe pursuer without turning the whole body back toward danger. Account for
aim time and shot energy. Once emergency escape is selected, hold fire and
maintain cloak intent instead of exposing the unit for a marginal extra shot.
Existing `ret_hold` can express this only after the cloak override is corrected.

**Starlight sequence:** occupy an enemy-facing, widely separated slot; fire a
complete beam; hold/reload or move to another validated safe slot. Detect a
closing threat early. If leaving is required, finish the beam only when the
remaining firing time still fits the escape budget, turn and commit to the
planned exit. Do not keep rotating back to attack a pursuer behind the hull.
After reaching cover, use a safe orientation waypoint and reacquire a target
in the frontal arc. Do not assume a reverse-driving command can overcome a
loaded reverse speed of zero.

Both can still be caught by faster enemies. Screening, lateral routes, terrain,
AA cover and killing dangerous pursuers matter; neither cloak nor range makes
them invulnerable. Maintaining distance alone must not prevent useful defense
against a raider that has already reached the line.

## Formation and group commands

Build local groups by movement compatibility and firing posture, then select
stable per-unit slots. Avoid a single point for all units or a leader that forces
every weapon to use its range. A useful order is forward spotters/screen,
ranged firing sections, offset sensors, then repair/reassembly space. It is
adapted to local coverage rather than a compulsory geometric parade.

- Sharpshooters use a dispersed line/shallow stagger, with screening against
  cheap fast units. Fatboys may support this by punishing an enemy closing on
  the snipers; firing lanes and friendly blast clearance still matter.
- Starlights use larger separation derived from death-blast radius and
  neighboring collision extent. Stagger depth to avoid straight penetration
  lines; reserve exits that do not pass through other Starlights or sensors.
- Advance by sections where useful: one holds coverage while another moves.
  If the holding section cannot safely stop a chase, disengage together.
- Let a formation widen, split or choose a different site when terrain cannot
  fit it. Do not compress it into an explosive ball to reach a nominal center.
- Issue movement for a changed group plan and target orders for changed firing
  intent; keep per-unit offsets stable. Do not rewrite all queues every update.
  Player line-drag UI does not imply one SkirmishAI/network packet. Measure
  actual commands and preserve immediate threat response without an APM cap.

## Required implementation refinements

1. Append `RANGED` to native attribute enum/mask/name registration in
   [CircuitDef.h](../../src/circuit/unit/CircuitDef.h) and
   [CircuitDef.cpp](../../src/circuit/unit/CircuitDef.cpp), preserving existing
   numeric values. Add `Unit::Attr::RANGED` in
   [unit.as](../../data/script/src/unit.as). Parse the optional tuning block
   in FactoryManager; derive enabled state from attribute membership.
2. Retain the prior plan's native geometry, no-pursuit firing and component
   lifecycle, but cache the **mounted compatible weapons**, arc restrictions,
   burst/beam time, blast geometry and movement capabilities. Ignore fake
   targeting barrels for direct damage/range; use the carrier/marking adapter.
3. Add escort anchors and sensor allocation through MilitaryManager/SupportTask.
   Do not cast ARTY into `ISquadTask` or increase artillery task membership to
   attach sensors. Keep snapshot/anchor versioning and transfer/death cleanup.
4. Introduce predictive tactical withdrawal in the component; preserve existing
   retreat/repair ownership. Scope the `ret_hold` versus cloak-fire-state fix
   to opted-in units until other-role tests justify a broader change.
5. Keep special mission ownership. Recluse/Arquebus can be TECH flank units;
   adding `ranged` must not discard their route/objective. They need a route-to-
   ranged-component adapter before migration. Default ten-unit dispatch can use
   the prior plan; detect conflicting specialist ownership rather than silently
   stealing it. AIR/SEA units in the inventory retain their current owners.
6. Only after fixtures pass, patch the active balanced profile lists/settings
   using byte-preserving edits. Follow with explicit per-profile rollout;
   review scope does not authorize silently changing every difficulty today.

## Required verification

Run the original bait/repair A/B/C case plus these specific checks:

| Fixture | Evidence required |
| --- | --- |
| Sharpshooter moving away, pursuer in range | Real shot while withdrawing, increasing separation, no replacement ATTACK/FIGHT pursuit. |
| Cloak/reload/energy | Actual cloak and reveal states, recloak delay, low-energy and nearby-enemy failures; no cloak-toggle spam. |
| Sniper emergency escape | No unwanted shot/retaliation breaking concealment under `ret_hold`; repair and rejoin work. |
| Starlight pursuer crosses arc boundary | Real shot in front, no impossible rear shot; early turn/escape and safe reorientation; no oscillation. |
| Starlight packed versus spaced | Healthy and damaged groups, actual blast casualties, separation during movement, useful firing density. |
| Radar-only, LOS, jammed, cliff | Legal targeting, measured precision/fire success, no sacrificial shooter self-spotting. |
| Mixed screen and sensors | Sensor coverage reaches AH/ARTY cohorts, no duplicates/unsafe casts; screen loss triggers appropriate withdrawal. |
| Different weapon families | Hound/Sheldon mobile fire; Fatboy splash; Banisher AA/turning; full Medusa salvos; carrier drone lifecycle. |
| Route ownership | TECH flank objective preserved for Recluse/Arquebus candidates; AIR and SEA command owners unchanged. |
| Late-game scale and lifecycle | CPU/command counts, no quadratic group scans, stale callback rejection, transfer/player/retreat/save-load transitions. |

Do not treat all sites as safe because profile threat weights are zero. Use
known weapon reach and legal observation; unknown threats remain uncertain.
Benchmark useful damage, losses and progress together with CPU/APM. No numerical
gain or exact spacing/retreat optimum is claimed before these tests.

### Checks performed for this review

- Reparsed all four behavior fragments: all 56 inventory rows match their
  source roles, attributes and retreat overrides; all four SHA-256 pins match.
- Invariant practice check: zero findings. Git whitespace check passed.
- CircuitAI documentation links: 7,543 checked, eight existing broken links to
  the missing `doc/roles/hover.md` (KI-404); none introduced by this review.
- Shared knowledge check: 759 files, zero broken links, zero missing images;
  five existing unknown IDs in `10-engine/17-air-mechanics.md`, none in the new
  withdrawal note. Its return status was successful.
- No runtime files were edited and no candidate combat simulation was run.

## Complete inventory and disposition

The following tables are generated from the current profile objects and the
pinned unit-name cache, then joined to the explicit review disposition. Existing
lists are reproduced exactly. `default` in the retreat column means no unit
override, not no retreat. New attribute assignment is proposed only, with the
ten-unit table above specifying the first migration. Later candidates require
their own geometry/mission tests.


### Land (25)

| Unit | Source fragment | Current role | Current attributes | Retreat override | Proposed disposition |
| --- | --- | --- | --- | --- | --- |
| Fatboy `armfboy` | `behaviour.json` | `assault,heavy` | (none) | default | First migration: ranged / skirmish; screen support and anti-swarm splash; preserve heavy classification. |
| Hound `armfido` | `behaviour.json` | `skirmish` | (none) | default | First migration: ranged / skirmish; mobile fire and flexible spacing. |
| Recluse `armsptk` | `behaviour.json` | `raider` | `siege` | default | Later ranged / skirmish candidate; preserve all-terrain flank route, three-shot volley and terrain-specific escape. |
| Sharpshooter `armsnipe` | `behaviour.json` | `anti_heavy` | (none) | 0.95 | First migration: ranged + ret_hold / precision; tactical shots while leaving, cloaked emergency escape. |
| Vanguard `armvang` | `behaviour.json` | `artillery,heavy` | `siege` | default | Later ranged / bombardment candidate; high-ground paths, compatible real barrels, volley and screen protection. |
| Shellshocker `armart` | `behaviour.json` | `artillery` | `siege` | default | Later ranged / bombardment candidate; forward arc, allied spotting, retreat before raiders close. |
| Starlight `armmanni` | `behaviour.json` | `anti_heavy,assault` | `artillery,siege` | 0 | First migration: ranged / precision; arc-aware turn/escape, blast spacing; replace zero health-retreat override. |
| Mauser `armmart` | `behaviour.json` | `artillery` | `siege` | default | Later ranged / bombardment candidate; frontal arc and slow hull turn; stable firing slots. |
| Ambassador `armmerl` | `behaviour.json` | `artillery,assault` | `siege` | default | Later ranged / bombardment candidate; valuable statics/slow targets, long reload and screened displacement. |
| Sheldon `cormort` | `behaviour.json` | `artillery` | `skirmish,siege` | default | First migration: ranged / skirmish; restore useful mobile selection without unsafe pursuit. |
| Arbiter `corhrk` | `behaviour.json` | `artillery` | `siege` | default | Later ranged / bombardment candidate; fragile missile support, useful mobile/static shots and long-range observation. |
| Catapult `corcat` | `behaviour.json` | `artillery,heavy` | `siege` | default | Later ranged / bombardment candidate; full rocket volley, avoid friendly splash and wasted overkill. |
| Wolverine `corwolv` | `behaviour.json` | `artillery` | `siege` | default | Later ranged / bombardment candidate; frontal-arc light artillery, exit before enemy contact. |
| Banisher `corban` | `behaviour.json` | `skirmish` | `siege` | default | First migration: ranged / skirmish; first strike, reload safety, broadside escape and legal AA. |
| Tremor `cortrem` | `behaviour.json` | `artillery,heavy` | `siege` | default | First migration: ranged / bombardment; sustained suppression, not tiny moving-target fixation. |
| Arquebus `legsrail` | `behaviour_leg.json` | `anti_heavy` | `siege` | default | Later ranged / precision candidate; preserve existing standoff 0.9 and TECH specialist route through adapter. |
| Thanatos `leghrk` | `behaviour_leg.json` | `artillery` | `siege` | default | Later ranged / bombardment candidate; narrow mount arc, salvo completion and turn-aware withdrawal. |
| Myrmidon `legeallterrainmech` | `behaviour_leg.json` | `skirmish,heavy,assault,anti_heavy` | `siege` | default | Later ranged / skirmish candidate; use real damage barrels, retain independent AA and mountain route capability. |
| Astraeus `legelrpcmech` | `behaviour_leg.json` | `artillery` | `siege` | default | Later ranged / bombardment candidate; very long-range observation, burst completion and protected repositioning. |
| Barrage `legbar` | `behaviour_leg.json` | `artillery,anti_spam,assault` | `siege,rare` | default | Later ranged / bombardment candidate; short-range area support, threat-dependent advance; do not assume it outranges every static. |
| Cleaver `legamcluster` | `behaviour_leg.json` | `artillery` | (none) | default | First migration: ranged / bombardment; cluster coverage and frontal-arc exit planning. |
| Boreas `legavroc` | `behaviour_leg.json` | `artillery` | `siege` | default | Later ranged / bombardment candidate; screened standoff, expensive long-reload rocket target selection. |
| Medusa `legmed` | `behaviour_leg.json` | `assault` | `siege` | default | First migration: ranged / bombardment; marking/rocket interaction, salvo completion and protected reload. |
| Mantis `legvcarry` | `behaviour_leg.json` | `riot` | (none) | default | First migration only with carrier adapter: ranged / carrier; parent safety and gadget-owned drones. |
| Inferno `leginf` | `behaviour_leg.json` | `artillery` | `siege` | default | Later ranged / bombardment candidate; incendiary area denial, forward arc and friendly field clearance. |

### Hover (3)

| Unit | Source fragment | Current role | Current attributes | Retreat override | Proposed disposition |
| --- | --- | --- | --- | --- | --- |
| Possum `armmh` | `behaviour.json` | `artillery` | `siege,rare` | default | Later ranged / bombardment candidate after hover tests; coastal routes, observations and expensive rocket selection. |
| Mangonel `cormh` | `behaviour.json` | `artillery` | `siege,rare` | default | Later ranged / bombardment candidate after hover tests; use coast mobility, screen and long-reload safety. |
| Salacia `legmh` | `behaviour_leg.json` | `artillery` | `siege,rare` | default | Later ranged / bombardment candidate after hover tests; coastal firing bands and safe missile reload. |

### Static (2)

| Unit | Source fragment | Current role | Current attributes | Retreat override | Proposed disposition |
| --- | --- | --- | --- | --- | --- |
| Pulsar `armanni` | `behaviour.json` | `static` | `siege` | 0 | Keep static owner; no movement attribute. Siege is also a target-selection marker here. |
| Catalyst `cortron` | `behaviour.json` | `super,static` | `siege,anti_spam` | default | Keep commandfire/stockpile launcher policy; no ground formation or kiting. |

### Air (8)

| Unit | Source fragment | Current role | Current attributes | Retreat override | Proposed disposition |
| --- | --- | --- | --- | --- | --- |
| Banshee `armkam` | `behaviour.json` | `raider,air` | `siege` | default | Keep AIR gunship owner; its attack/escape geometry is not land artillery geometry. |
| Highwind `armhawk` | `behaviour.json` | `anti_air,air` | `siege` | default | Keep fighter/interception owner and flight formations. |
| Blizzard `armpnix` | `behaviour.json` | `bomber,air,raider,riot,assault,skirmish` | `siege` | 0 | Keep bomber wave, target progression and mission-specific retreat policy. |
| Roughneck `armbrawl` | `behaviour.json` | `raider,air` | `siege` | default | Keep AIR gunship owner; preserve aerial threat response. |
| Liche `armliche` | `behaviour.json` | `bomber,air` | `siege` | default | Keep bomber strike and target policy; no land firing line. |
| Hailstorm `corhurc` | `behaviour.json` | `bomber,air` | `siege` | default | Keep bomber wave and mission-specific retreat policy. |
| Wasp `corape` | `behaviour.json` | `assault,air` | `siege` | default | Keep AIR gunship owner; preserve attack/withdrawal flight geometry. |
| Tyrannus `legfort` | `behaviour_leg.json` | `heavy,air` | `siege` | default | Keep heavy-air owner; do not route into single-unit ground artillery. |

### Ship (10)

| Unit | Source fragment | Current role | Current attributes | Retreat override | Proposed disposition |
| --- | --- | --- | --- | --- | --- |
| Ellysaw `armpship` | `behaviour.json` | `riot` | `siege` | default | Keep fleet riot/surface screen control; preserve water body, naval threats and fleet spacing. |
| Corsair `armroy` | `behaviour.json` | `skirmish,anti_sub` | `siege,rare` | 0 | Keep surface/anti-sub fleet control; compatible water targets and fleet screen. |
| Longbow `armmship` | `behaviour.json` | `artillery,naval` | `siege` | default | Keep established naval static bombardment; avoid wasting strategic salvos on passing small targets. |
| Dreadnought `armbats` | `behaviour.json` | `heavy,assault,naval` | `siege` | 0 | Keep battleship fleet control and multi-weapon surface engagement. |
| Epoch `armepoch` | `behaviour.json` | `artillery,assault,naval` | `super,siege` | default | Keep flagship/fleet bombardment owner; preserve multiple weapon roles and water routing. |
| Herring `corpt` | `behaviour.json` | `anti_air` | `siege` | default | Keep SEA scout/AA patrol/intercept owner; no artillery migration. |
| Oppressor `corroy` | `behaviour.json` | `skirmish,anti_sub` | `siege,support,rare` | 0 | Keep existing fleet/anti-sub/support policy; do not erase support or rare metadata. |
| Messenger `cormship` | `behaviour.json` | `artillery,naval` | `siege` | default | Keep established naval static bombardment and stand-off routing. |
| Despot `corbats` | `behaviour.json` | `heavy,naval` | `siege` | default | Keep battleship fleet/surface control; no land geometry controller. |
| Black Hydra `corblackhy` | `behaviour.json` | `super,naval` | `siege` | default | Keep flagship fleet owner; broadside/multiple weapons and naval objectives. |

### Sub (3)

| Unit | Source fragment | Current role | Current attributes | Retreat override | Proposed disposition |
| --- | --- | --- | --- | --- | --- |
| Eel `armsub` | `behaviour.json` | `sub` | `siege,rare` | 0 | Keep submarine/sonar owner; preserve rare availability and submerged combat. |
| Serpent `armserp` | `behaviour.json` | `sub,anti_naval` | `siege` | default | Keep submarine/sonar hunter control; no surface-only ranged targeting. |
| Kraken `corssub` | `behaviour.json` | `sub,anti_naval` | `siege` | default | Keep submarine hunter/sonar owner and water threat response. |

### Optional (5)

| Unit | Source fragment | Current role | Current attributes | Retreat override | Proposed disposition |
| --- | --- | --- | --- | --- | --- |
| Epic Stormbringer `armthundt4` | `behaviour_scav_units.json` | `bomber,static,assault` | `air,siege` | default | Keep optional aircraft policy; separate non-standard-content test before any attribute change. |
| Epic Liche `armlichet4` | `behaviour_scav_units.json` | `bomber` | `air,siege` | default | Keep optional bomber policy; outside standard PvP tuning. |
| Epic Recluse `armsptkt4` | `behaviour_scav_units.json` | `artillery` | `siege` | default | Optional future ranged candidate only after validating its own weapons/movement; do not copy base Recluse blindly. |
| Ratte `armrattet4` | `behaviour_scav_units.json` | `assault` | `heavy,siege` | 0.0 | Keep optional heavy-assault behavior; do not relabel as fragile ranged support. |
| Epic Arquebus `legsrailt4` | `behaviour_scav_units.json` | `super` | `siege` | 0.0 | Keep optional super-weapon behavior; verify special firing mechanics before a separate adapter. |

### Audit pins

Source objects were parsed with the repository's existing comment-tolerant
JSON reader. These SHA-256 hashes pin the unchanged input fragments:

- `behaviour.json`: `3013ecc0fd98cadb78d8bea864f70e8acfcb7e8772ee4a2895787fb817c24d1f`
- `behaviour_extra_units.json`: `aa536e4b54f2083f7d1fc5e371929fa3b3ea46239d2a3dac72b1dfd136930376`
- `behaviour_leg.json`: `11ba632b9faeb10c1db877f7b773dc0f0deb6bf8c1f6039491ff8514cd1bba69`
- `behaviour_scav_units.json`: `83d09789c66258b9bb4fbe5c3645ae6bc8a62ef394b866edf66ef0ac5d030c1c`

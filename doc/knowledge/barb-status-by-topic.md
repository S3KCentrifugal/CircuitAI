---
layer: 90
confidence: synthesis (status of this AI against the game knowledge base)
sources:
  - sections lifted from the game knowledge base documents when they moved to rjm.bar.docs (2026-09-16)
---

# BARb status by topic

Where CircuitAI/BARb stands against each topic of the shared game knowledge base
(`../../../rjm.bar.docs/knowledge/`). Each heading names the source document the section was lifted from;
keep this file in step when either side changes.

## 00-glossary.md - BARb attributes

Orthogonal flags on a unit, separate from roles: `melee`, `boost`, `no_jump`,
`no_strafe`, `stockpile`, `siege`, `ret_hold`, `ret_fight`, `solo`, `base`,
`dg_cost`, `dg_still`, `jump`, `onoff`, `vampire`, `rare`, `fence`, `rearm`,
`no_dgun`, `anti_stat`, `no_repair`, `no_disrupt`. `rare` matters most for
production: rare units are never a standard factory pick.

## 40-roles-and-counters/40-role-taxonomy.md - How BARb uses the main role

`CMilitaryManager::DefaultMakeTask` switches on `GetMainRole()`:
`raider` -> `CRaidTask`, `bomber` -> `CBombTask`, `anti_air` -> `CAntiAirTask`,
`artillery` -> `CArtilleryTask`, `scout` -> `CScoutTask`, `super` ->
`CSuperTask`, `support` -> `CSupportTask`, everything else -> `CAttackTask`
(squads). The **first** entry of the `role` list is the main role; later
entries only affect `response.json` matching and threat accounting. This is
why `armfast` with `["raider", ...]` raids, and why a unit configured
`["super","static","artillery","juno"]` is a super-weapon first.

## 40-roles-and-counters/40-role-taxonomy.md - Role assignment gaps found in the data

Generated per-unit notes flag two systematic gaps that this taxonomy inherits:

- **Units absent from every BARb behaviour config** fall back to native
  defaults and get no explicit role. The count per faction is on the
  [30-units index](../../../rjm.bar.docs/knowledge/30-units/README.md).
- **Buildable units in no factory list** are never produced. The per-unit
  notes name them; the aggregate is a task in
  [95-open-questions.md](90-agent-decision-guides/95-open-questions.md).

## 60-tactics/61-micro.md - bullet

- **BARb today**: `CAttackTask` picks a target per squad by threat and
  distance; individual units then use engine auto-targeting. No overkill
  control; no priority beyond threat.

## 60-tactics/61-micro.md - bullet

- **BARb today**: `CFighterTask` variants have no explicit kite; `ret_fight`
  attribute lets a unit fire while retreating.

## 60-tactics/61-micro.md - bullet

- **BARb today**: `behaviour.json` `retreat` block is a health fraction per
  config; `ret_hold` / `ret_fight` attributes change what the unit does while
  retreating. No XP awareness; no attacker-speed awareness.

## 60-tactics/62-information-warfare.md - Where BARb stands

- Threat map from radar and LOS; no identity model for blips.
- `scout` role exists; scout scheduling against the enemy base is not
  explicit.
- Bombers require identified targets ([bomber-targeting.md](../bomber-targeting.md)).
- No deception logic; no jammer placement logic beyond the `support` role.

## 60-tactics/63-air-tactics.md - Where BARb stands

- `air`, `bomber`, `anti_air`, `scout`, `transport` roles exist.
- `maxAAThreat = 1e30` in the experimental configs means the AI always builds
  air regardless of enemy AA (session change, 2026-09).
- Bomber target choice is by lowest current health; no group alpha
  calculation; no approach angle. Phased fix in
  [bomber-targeting.md](../bomber-targeting.md).
- No transport drop logic.

## 60-tactics/64-naval-tactics.md - Where BARb stands

- `sub`, `anti_sub`, and sea roles exist; sea configuration is a documented
  weak area (35 Legion sea units had no behaviour entry before the 2026-09
  Legion review; `legadvshipyard` missing from hard/terrible factory
  configs).
- Hover T1 retirement after T2 lab is a native gating behaviour; `rare`
  flags keep selected hovers in production.

## 60-tactics/65-siege-and-defence.md - Where BARb stands

- `static` role with `limit` counts per config; `defence` block in
  `behaviour.json` (`infl_rad`, `base_rad`, `comm_rad`, `escort`).
- No explicit range-ladder reasoning; artillery role picks targets by
  threat/distance. Siege sequencing (sensors, ladder, screen, assault) does
  not exist as a plan.

## 70-strategy/70-openings.md - What BARb does today

- `commander.json` scripts the commander's first builds per config;
  `factory.json` `tier0` weights choose the first factory by terrain analysis
  (`CTerrainManager`), and per-factory unit weights by tier.
- The Tech role's early build is analysed in [roles/tech.md](../roles/tech.md);
  the observed problems (T2 rush at 18 M/s, fast-assist-only production) are
  opening-phase problems in this vocabulary.

## 70-strategy/71-timing-and-tech.md - What BARb does today

- Tech role: T2 gate on metal income (`MetalIncomeThresholdForEarlyBotLabExpansion`),
  dynamic T2 lab count, rush-bot uncap at the income gate, reactor-assist
  redirect. Gantry gated on energy per gantry. Details and open issues in
  [roles/tech.md](../roles/tech.md).
- No window awareness: BARb does not attack *because* the enemy is teching,
  and does not delay teching *because* the enemy is massing.

## 70-strategy/72-map-control.md - What BARb does today

- Native terrain analysis and threat map; `defence` radii in
  `behaviour.json`; expansion by `CMetalManager` clustering.
- No objective model: BARb does not decide to *take the centre* or *hold a
  choke*; it expands to nearest safe spots and attacks the nearest threat.
  Named-position objectives are a `95` item.

## 70-strategy/73-army-composition.md - What BARb does today

- `factory.json`: per-factory unit weights by tier (`tier0`, `tier1`, ...)
  and terrain (`land`, `water`).
- `response.json`: per-role `vs` lists with `ratio` and `importance` - the
  AI's composition response, keyed on enemy roles seen. Unknown names in `vs`
  are skipped with a warning and shift later entries ([bomber-targeting.md](../bomber-targeting.md)).
- No phase model; no explicit share targets; no "drop" rule.

## 70-strategy/74-superweapons.md - Where BARb stands

- `super` role -> `CSuperTask` (script `SetTargetPos` is exposed);
  `stockpile` attribute; anti-nuke handled as a static defence build in
  `build_chain.json`/`economy.json` per config.
- No stockpile-race arithmetic; no coverage check over high-value clusters;
  no EMP/Juno follow-up coordination.

## 70-strategy/75-team-roles.md - Mapping to BARb

| Community role | BARb script | Notes |
| --- | --- | --- |
| Front | `roles/front.as` | lane pressure; native attack tasks |
| Eco / Tech | `roles/tech.as` | reviewed in roles/tech.md (CircuitAI `doc/roles/tech.md`): T2 lab dynamics, rush bots, reactor assist, gantry gating |
| Air | `roles/air.as` | `maxAAThreat = 1e30` in experimental configs so it always builds air |
| Sea | `roles/sea.as` | sea configuration gaps noted in [64](../../../rjm.bar.docs/knowledge/60-tactics/64-naval-tactics.md) |
| Support | `roles/support.as` | |
| Tactical / Hover | `roles/tactical.as`, `roles/hover.as` | roles/hover.md (CircuitAI `doc/roles/hover.md`): keep hover pressure late via `rare` |

Role selection happens in `main.as` per config; the `RoleConfig` delegates
dispatch the manager hooks (`Builder::AiMakeTask`, `Factory::AiMakeTask`,
`Economy::AiUpdateEconomy`, `Military::AiMakeTask`) to the chosen role.

## 70-strategy/75-team-roles.md - Coordination that matters

| Interaction | Mechanic | BARb today |
| --- | --- | --- |
| Metal sharing to fronts | team resource transfer | not modelled between BARb instances; each AI is its own economy |
| Air scouting for fronts | shared LOS/radar | shared automatically by the engine (ally team) |
| Anti-nuke coverage for the tech player | `coverage` radius over the AFUS cluster | per-AI build chains; no team-level placement |
| Timing pushes together | arrival time on multiple lanes | no cross-AI coordination |
| Front asking for artillery support | | none |

Team-level coordination between multiple BARb instances does not exist; each
instance plays its role as if alone. This is the largest single gap for team
play and a `95` item.

## gap-analysis.md - 3.4 BARb configuration gaps

**In no behaviour config at all (63)**:

| Group | Units |
| --- | --- |
| Seaplanes, all factions (T1.5 platform tree) | `armsb` `armseap` `armsehak` `armsfig` `armcsa` `corsb` `corseap` `corseah` `corsfig` `corhunt` `corcsa` `legspbomber` `legspcarrier` `legspcon` `legspfighter` `legspradarsonarplane` `legspsurfacegunship` `legsptorpgunship` |
| Air transports | `armatlas` `armdfly` `armhvytrans` `corvalk` `corhvytrans` |
| Legion navy (T2 shipyard tree) | `leganavyaaship` `leganavyantinukecarrier` `leganavyantiswarm` `leganavyartyship` `leganavybattleship` `leganavybattlesub` `leganavyconsub` `leganavycruiser` `leganavyengineer` `leganavyflagship` `leganavyheavysub` `leganavymissileship` `leganavyradjamship` |
| Legion land T2 support | `legafcv` `legavantinuke` `legavjam` `legavrad` `legvflak` |
| Other standard | `armcroc` `armdecom` `armlship` `corfship` `cordemon` |
| Extra pack | `armfify` `armzapper` `armexcalibur` `armseadragon` `cordeadeye` `corforge` `corsiegebreaker` `cortorch` `corvac` `corves` `corphantom` `coresuppt3` `corprince` `cordesolator` `coronager` `legapollyon` `legbunk` |

The seaplane tree and the whole Legion T2 navy are the two systematic
omissions; the second confirms the earlier "35 Legion sea units" finding
with an exact list.

**Buildable, in no factory list in any config (never produced) (32)**:
the 12 air units above (transports and seaplanes), `cordemon`,
`legavantinuke`, `armlship`, `corfship`, and 16 extra-pack units.
Transports being unproduced is consistent with BARb having no drop logic;
`cordemon` (T3, 6000 M) and `armlship`/`corfship` are plain omissions.

Per-config gaps: easy/medium miss 95 reachable mobile units each;
experimental configs 63-66; hard 69.

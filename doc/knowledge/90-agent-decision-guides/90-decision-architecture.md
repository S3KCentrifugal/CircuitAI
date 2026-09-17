---
layer: 90
confidence: synthesis
sources:
  - 80-theory/* (principles, OODA, logistics)
  - 60-tactics/*, 70-strategy/*
  - src/circuit/module/*Manager.cpp (BARb managers)
  - data/script/src/*.as (AngelScript hook contract)
  - doc/angelscript-references.md
  - doc/roles/tech.md, doc/roles/hover.md
---

# Decision architecture

How an agent should turn the knowledge base into play, expressed as an
observe -> orient -> decide -> act loop and mapped onto the hooks BARb already
has. Each stage names what exists today and what the knowledge base says is
missing.

## The loop

```text
OBSERVE   threat map, radar/LOS contacts, own economy, own army, game options
ORIENT    enemy composition by role, enemy tier, enemy centre of gravity, phase, lanes, windows
DECIDE    economy policy, production response, objective, engagement rules
ACT       build tasks, factory tasks, attack/raid/defend tasks, retreat
```

BARb runs a version of this every update; the gap is almost entirely in
**orient** - the AI acts on raw threat, not on a model of the enemy.

## Stage by stage

### Observe

| Signal | BARb today | Knowledge base says |
| --- | --- | --- |
| Enemy units | `CEnemyManager`, threat map by role/threat | blips have no identity; scouts convert blips to units ([62](../../../../rjm.bar.docs/knowledge/60-tactics/62-information-warfare.md)) - schedule scout runs |
| Own economy | `CEconomyManager` income/storage; script `AiUpdateEconomy` sets stall flags | add BP : income ratio and energy-as-ammunition margin ([83](../../../../rjm.bar.docs/knowledge/80-theory/83-logistics-as-economy.md)) |
| Own army | task lists, squads | add metal-in-army by role and by lane |
| Map | terrain sectors, metal clusters, threat per sector | add named positions: chokes, centre cluster, geo vents ([72](../../../../rjm.bar.docs/knowledge/70-strategy/72-map-control.md)) |
| Game options | config selection (`*_leg.json` on Legion option) | read resource multipliers, `unit_restrictions_*`, `deathmode` ([24](../../../../rjm.bar.docs/knowledge/20-game-mechanics/24-game-modes-and-options.md)) |

### Orient

The model the AI should hold, refreshed each scout run:

| Fact | Derived from | Used by |
| --- | --- | --- |
| Enemy composition (metal by role) | identified units | [92-response-tables.md](92-response-tables.md) |
| Enemy tier and tech windows | factories seen, T2 units seen | [71](../../../../rjm.bar.docs/knowledge/70-strategy/71-timing-and-tech.md): attack the window or match |
| Enemy centre of gravity | phase: spots -> factories -> AFUS/converters -> commander | bomber and raid targeting ([bomber-targeting.md](../../bomber-targeting.md)) |
| Enemy posture | army location, statics per lane | attrition vs manoeuvre ([82](../../../../rjm.bar.docs/knowledge/80-theory/82-manoeuvre-vs-attrition.md)) |
| Own phase | income, tier, BP ratio | [94-economy-policies.md](94-economy-policies.md) |
| Lane state | threat per lane vs own metal per lane | objective selection |

None of this exists as state in BARb today; `response.json` is the closest
(enemy role counts -> production ratios) and it has no memory between updates.

### Decide

| Decision | Hook | Guide |
| --- | --- | --- |
| What to build (structures) | `Builder::AiMakeTask` (mobile builders; `CBuilderManager`), role `*_BuilderAiMakeTask` | [94](94-economy-policies.md), [91](91-build-order-selection.md) |
| What to produce (units) | `Factory::AiMakeTask` (factories and nanos; `CFactoryManager`), `RequiredFireDef`, `factory.json` weights, `response.json` | [92](92-response-tables.md) |
| Economy flags | `Economy::AiUpdateEconomy` -> `isEnergyStalling`, `isMetalFull`, ... | [94](94-economy-policies.md) |
| Which task a combat unit gets | `Military::AiMakeTask` -> `CMilitaryManager::DefaultMakeTask` by main role | [40](../../../../rjm.bar.docs/knowledge/40-roles-and-counters/40-role-taxonomy.md) |
| Where squads attack | `CAttackTask`/`CSquadTask` target by threat and distance | [93](93-engagement-rules.md): objectives, staging, culmination |
| When units retreat | `behaviour.json` `retreat` fraction, `ret_*` attributes | [93](93-engagement-rules.md): XP- and attacker-aware thresholds |
| Bomber targets | `CBombTask::FindTarget` (lowest health) | [bomber-targeting.md](../../bomber-targeting.md) P0-P4 |
| Superweapons | `CSuperTask`, build chains | [74](../../../../rjm.bar.docs/knowledge/70-strategy/74-superweapons.md): coverage and stock arithmetic |

### Act

Engine commands via the task system. No change proposed here; the act stage
is not where BARb loses.

## Principles the architecture enforces

1. **Concentration**: one objective lane at a time; secondary lanes held by
   economy of force ([80](../../../../rjm.bar.docs/knowledge/80-theory/80-principles-of-war.md)).
2. **Staging**: squads gather out of range before attacking
   ([81](../../../../rjm.bar.docs/knowledge/80-theory/81-lanchester-and-attrition.md)).
3. **Windows**: tech and eco decisions read the enemy's state, not only our
   own ([71](../../../../rjm.bar.docs/knowledge/70-strategy/71-timing-and-tech.md)).
4. **Centre of gravity moves**: targeting shifts from mexes to reactors as the
   game progresses ([53](../../../../rjm.bar.docs/knowledge/50-economy/53-expansion-and-territory.md)).
5. **Information is bought, not inferred**: scout on a schedule
   ([62](../../../../rjm.bar.docs/knowledge/60-tactics/62-information-warfare.md)).
6. **Culmination is detected**: a push whose kill rate falls below its loss
   rate pulls back to reclaim ([82](../../../../rjm.bar.docs/knowledge/80-theory/82-manoeuvre-vs-attrition.md)).

## Implementation surface

Where each addition would live, given the current split of native C++ and
AngelScript ([angelscript-references.md](../../angelscript-references.md)):

| Addition | Layer | Why there |
| --- | --- | --- |
| Enemy composition model, phase, windows | AngelScript (`Economy::AiUpdateEconomy` cadence, new module) | script has `aiEnemyMgr` access; no engine change |
| Response tables | `response.json` + script overrides in `Factory::AiMakeTask` | config-first, script for phase logic |
| Scout scheduling | script `Military::AiMakeTask` for `scout` role | role dispatch exists |
| Staging and objectives | C++ `CSquadTask` / `CAttackTask` (no script hook into target selection) | task internals are native |
| Retreat thresholds by XP/attacker | C++ `IFighterTask` retreat check, or expose XP to script | XP not exposed to script today |
| Bomber value ranking | C++ `CBombTask::FindTarget` | documented in bomber-targeting.md |
| Anti-nuke coverage check | script build chain + `Builder::AiMakeTask` | structure placement is script-reachable |
| Economy policies (BP ratio, banking) | script `Economy::AiUpdateEconomy` and role economy hooks | flags are script-owned |

## Related

- [91](91-build-order-selection.md), [92](92-response-tables.md), [93](93-engagement-rules.md), [94](94-economy-policies.md), [95](95-open-questions.md).

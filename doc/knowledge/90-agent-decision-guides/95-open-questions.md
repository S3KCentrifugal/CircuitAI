---
layer: 90
confidence: synthesis (questions, not answers)
sources:
  - every layer; each item names the document that raised it
---

# Open questions

Things the theory and the data do not settle. Each item names what would
settle it - usually a replay query (phase F of the plan) or an in-game test -
and where the answer goes.

## Meta and timings (replay mining, F2-F4)

| # | Question | Settles with | Feeds |
| --- | --- | --- | --- |
| Q1 | Actual T2 timing distribution by map size and faction in competitive replays | first `armalab`/`coralab`/`legalab` creation time per game | [71](../../../../rjm.bar.docs/knowledge/70-strategy/71-timing-and-tech.md), [52](../../../../rjm.bar.docs/knowledge/50-economy/52-scaling-curves.md) |
| Q2 | First-factory choice by map | first factory unitdef per player per map | [70](../../../../rjm.bar.docs/knowledge/70-strategy/70-openings.md), [91](91-build-order-selection.md) |
| Q3 | Constructor count at minutes 3/5/8 | unit counts by role over time | [52](../../../../rjm.bar.docs/knowledge/50-economy/52-scaling-curves.md) BP curve |
| Q4 | Army composition by phase (metal by role at 5/10/15/20 min) | unit inventories | [73](../../../../rjm.bar.docs/knowledge/70-strategy/73-army-composition.md) baseline shares |
| Q5 | Which counters actually happen (enemy role share -> own production change lag) | production deltas after first sighting | [92](92-response-tables.md) magnitudes |
| Q6 | Win rate vs metal-lost ratio: does trading up predict winning as strongly as the square law says | per-game kill/loss metal | [81](../../../../rjm.bar.docs/knowledge/80-theory/81-lanchester-and-attrition.md) |
| Q7 | Wind-vs-solar choice vs map wind | first energy structures vs map wind range | [21](../../../../rjm.bar.docs/knowledge/20-game-mechanics/21-resources.md) threshold (~10) |

## Mechanics to verify in-game

| # | Question | Settles with | Feeds |
| --- | --- | --- | --- |
| Q8 | Exact XP grade -> range bonus curve in `unit_xp_range_bonus.lua` | read the gadget; test with a veteran unit | [14](../../../../rjm.bar.docs/knowledge/10-engine/14-experience-and-flanking.md) |
| Q9 | Whether the flanking bonus mode 1 swing rate makes two-axis attacks worth the coordination at T1 speeds | controlled test: 10 Pawns from one side vs 5+5 from two | [60](../../../../rjm.bar.docs/knowledge/60-tactics/60-formations.md), R3 in [93](93-engagement-rules.md) |
| Q10 | Wreck metal fraction per unit class (featuredefs) - is reclaim ~50% or higher for T2? | parse `featuredefs.dead.metal` across units (generator extension) | [15](../../../../rjm.bar.docs/knowledge/10-engine/15-construction-economy-rules.md), P9 |
| Q11 | Juno's exact target list under `junorework` | read `unit_juno_rework_damage.lua` | [23](../../../../rjm.bar.docs/knowledge/20-game-mechanics/23-special-systems.md) |
| Q12 | Real bomber alpha under AA: passes survived per Stormbringer group size | test | [63](../../../../rjm.bar.docs/knowledge/60-tactics/63-air-tactics.md) |
| Q13 | Depth-mod speed curve for amphibious units in deep water | `movedefs.lua` depthModParams + test | [10](../../../../rjm.bar.docs/knowledge/10-engine/10-movement-and-terrain.md) |

## BARb behaviour to confirm or fix

| # | Question | Settles with | Feeds |
| --- | --- | --- | --- |
| Q14 | Units absent from every behaviour config (count on the [30-units index](../../../../rjm.bar.docs/knowledge/30-units/README.md)): which are real omissions vs internal/unbuildable units | filter the generated notes by `built_by` non-empty; review the list | configs |
| Q15 | Buildable units in no factory list ("never produced") - intended or missed | same filter on factory lists | `factory*.json` |
| Q16 | `CRaidTask` target priority: constructors before extractors? | read `RaidTask.cpp`; log targets at LOG_LEVEL 3 | R4 |
| Q17 | Does `CScoutTask` ever fly scouts over the enemy base on a schedule | read `ScoutTask.cpp`; observe | [62](../../../../rjm.bar.docs/knowledge/60-tactics/62-information-warfare.md) |
| Q18 | `response.json` correctness across configs: array lengths equal, all `vs` names are roles | script check over all configs | [92](92-response-tables.md) |
| Q19 | Current `EconomyHelpers::Should*` constants beside each policy P1-P11 | read `economy_helpers.as` | [94](94-economy-policies.md) |
| Q20 | Team play: any coordination between BARb instances (shares, timing) | read `main.as` and managers for ally handling | [75](../../../../rjm.bar.docs/knowledge/70-strategy/75-team-roles.md) |
| Q21 | `transport` role: any load/unload logic at all | grep tasks for transport | [16](../../../../rjm.bar.docs/knowledge/10-engine/16-transport-and-air.md) |
| Q22 | Anti-nuke placement relative to AFUS/gantry clusters | read build chains; observe | [74](../../../../rjm.bar.docs/knowledge/70-strategy/74-superweapons.md), R12 |
| Q23 | Decision on the T2 constructor stall options (1/2/3) | user decision | [t2-constructor-stall.md](../../t2-constructor-stall.md) |
| Q24 | Bomber targeting P0-P4 landing order | user decision; rebuild per phase | [bomber-targeting.md](../../bomber-targeting.md) |
| Q25 | Legion sea units without behaviour entries; `legadvshipyard` in hard/terrible `factory_leg.json` | config edits | [64](../../../../rjm.bar.docs/knowledge/60-tactics/64-naval-tactics.md) |

## Knowledge base itself

| # | Question | Settles with |
| --- | --- | --- |
| Q26 | Counter matrix validity: does the score's direction match community consensus for the T1 cycle | compare [41](../../../../rjm.bar.docs/knowledge/40-roles-and-counters/41-counter-matrix.md) cells with [40](../../../../rjm.bar.docs/knowledge/40-roles-and-counters/40-role-taxonomy.md) cycle; list disagreements |
| Q27 | Speed in the counter score: add a catch/escape factor | extend `counter_scores` with `speed_A / speed_B` clamped; re-check Q26 |
| Q28 | Extend unit extraction with `featuredefs` (wreck metal), `sfxtypes` ignored, and per-weapon `customparams` (overpen, cluster) flags | generator |
| Q29 | Scavenger and Raptor trees for PvE | new extraction scope |
| Q30 | External research E2/E4 not yet performed: BAR wiki, Discord strategy channels, caster guides; primary texts for layer 80 | research sessions; cite with dates |

## Related

- [../knowledge-base-plan.md](../../../../rjm.bar.docs/knowledge/knowledge-base-plan.md) - the task list these map to.

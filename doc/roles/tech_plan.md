# TECH: the endgame plan (`tech_plan.as`)

What the TECH role does once its rush objective stands. Decision:
[D-080](../decisions.md#d-080--the-endgame-plans-the-metal-ladder-after-the-objective-and-the-income-gates-for-combat).
The role's contract is in [tech.md](tech.md); the chain that executes the
plan's phases is [tech_chain.md](tech_chain.md).

## The owner's list

The other roles hold the enemy while TECH builds the economy that ends the
game. TECH never produces a mobile combat unit under +200 metal a second
(+500 on the T3 rush). After the economic objective it follows one plan:

| Plan | Key | Phases after the rush objective |
| --- | --- | --- |
| A | `nuke` | a nuclear silo the fastest way (the silo step if the objective was not `nuke`), income +200; then the T2 air plant and income +500 |
| B | `t2rush` | the T2 air plant and income +200 (T2 fast assault units unlock at the gate); then income +500 and a gantry for T3 in mass with many turrets |
| C | `t3rush` | the T2 air plant, income +500 before any combat unit, then a gantry |
| D | `lrpc` | the T2 air plant, income +300, then the long-range plasma cannon; then income +500 |

`EndgamePlan` picks one; `auto` is deterministic from the team id (team 0
nuke, 1 t2rush, 2 t3rush, 3 lrpc, and round), so a lobby with several TECH
players spreads the plans and the same lobby gives the same plan.

## The metal ladder

An `income` step of the chain is climbed, not built: while metal income is
under the target, a builder that asks gets, in this order, nothing while
energy floats (the `energy.convert.float` row converts), the nearest T2 mex
upgrade it can build, the advanced fusion under construction to assist, or
the next advanced fusion to order; a full metal bank orders another
advanced fusion in parallel, up to `LadderParallelAfus`. Every plan climbs
the same ladder; the income targets are the plan's.

## Build power from +200

From `PlanAirConstructorsFromMetal` (200) the T2 air plant is a step of every
plan and T2 construction aircraft are the mobile build power: the T2 air
plant produces one per `PlanAirConstructorPerMetal` (40) of income, at most
`PlanMaxAirConstructors` (12), alongside the construction turrets the D-075
rule adds.

## Functions

| Function | Does |
| --- | --- |
| `Choose` | the plan from `EndgamePlan`, `auto` from the team id |
| `Init` | picks the plan, logs `[TECH][Plan] <plan> (combat gate +N metal; T2 air constructors from +M)` |
| `CombatGate` | the income under which no mobile combat unit is produced: `PlanT3RushCombatGate` for `t3rush`, else `PlanCombatGate`; `Tech_CombatGate` reads it |
| `AirConstructorsWanted` | T2 construction aircraft wanted at the current income; the T2 air plant's production reads it |
| `NextPhase` | the next phase's steps for the chain when a phase stands; empty when the plan is done |
| `PhaseName` | `<plan> phase <n>` for the chain's log |

## Phase 2, not built (native)

- KI-418: the nuke's first shot at the enemy tech location on the opposite
  side of the map, then the normal dice; the cannon on high ground with sight
  beyond the front and no mountain in its range.
- KI-417: with more than five T2 air constructors, every land constructor
  spread out guarding an allied land constructor, so TECH helps whatever
  the team is building.

## Settings (`Global::RoleSettings::Tech`)

| Setting | Default | Meaning |
| --- | --- | --- |
| `EndgamePlan` | `auto` | `nuke`, `t2rush`, `t3rush`, `lrpc`, or `auto` from the team id |
| `PlanCombatGate` / `PlanT3RushCombatGate` | 200 / 500 | metal income under which no mobile combat unit is produced |
| `PlanLrpcMetal` | 300 | the lrpc plan's income before the cannon |
| `PlanAirConstructorsFromMetal` / `PlanAirConstructorPerMetal` / `PlanMaxAirConstructors` | 200 / 40 / 12 | T2 construction aircraft as the mobile build power |
| `LadderParallelAfus` | 2 | advanced fusions under construction at once while the metal bank is full |
| `InvariantLadderFloatSeconds` | 60 | INV-011: the metal bank full this long with an income step unmet |

## Related

- [tech.md](tech.md), [tech_chain.md](tech_chain.md), [tech_rules.md](tech_rules.md)
- [../invariants.md](../invariants.md) (INV-010, INV-011), [../actor-matrix.md](../actor-matrix.md)

<!-- source: data/script/src/roles/tech_plan.as; blob: 8a4fbaa643337551283ed9cc727f4b0d6c120621; lines: 105 -->

# tech_chain.as - the rush chain: one objective, one computed build order

Script: [`data/script/src/roles/tech_chain.as`](../../data/script/src/roles/tech_chain.as),
namespace `TechChain`. Decision:
[D-070](../decisions.md#d-070--the-tech-rush-chain-one-objective-one-computed-build-order-then-the-economy).
Rule table row: `chain.next` in [`tech_rules.md`](tech_rules.md). Benchmarks:
[`../benchmarks/tech-rush.md`](../benchmarks/tech-rush.md). Game knowledge:
the rush table in the knowledge base's
[eco/tech playbook](../../../rjm.bar.docs/knowledge/70-strategy/77-eco-tech-player.md),
computed by `rjm.bar.docs/tools/knowledge/rush_sim.py`.

## Intent

A tech player who wants the advanced fusion at 16 minutes does not "do eco"
and hope; it follows the shortest line the numbers allow and puts every
builder on it. `Tech::RushObjective` names that line (`t2`, `fusion`,
`afus`, `nuke`, `gantry`, `titan`; `eco` for no chain; `auto` lets the role
pick, today `afus`). The chain is the ordered list of cumulative targets
the simulator found fastest for the map's wind; the rule table's
`chain.next` row executes it ahead of every economy row; when the last
target stands the chain is done and the ordinary rules continue.

## The chains (solar counts; turbines scaled to the same energy when the map's wind chooses turbines)

Common opening: the opening's home mexes (the spots within `OpeningMexRadius`
(700) of the start, at most `OpeningMexCap` (3): three on Supreme Isthmus,
one or none on other maps), the lab at once (2 constructors), 2 energy, the
far mexes to 6 (`ChainMexFarRadius`, constructors only), 6 energy, the
advanced lab. Then:

| Objective | Tail | T2 constructors |
| --- | --- | --- |
| `t2` | nothing: the economy rules take over | 1 |
| `fusion` | fusion | 1 |
| `afus` | 14 solars, 2 T2 mex, fusion, 2 turrets, advanced fusion | 2 |
| `nuke` | 14 solars, 2 T2 mex, fusion, 2 turrets, silo | 2 |
| `gantry` | 14 solars, 2 T2 mex, fusion, 2 turrets, gantry | 2 |
| `titan` | 14 solars, 4 T2 mex, fusion, 2 turrets, gantry (the gantry's own production makes the T3) | 2 |

An income bonus (D-072: the engine's per-team multiplier times the
`ai_incomemultiplier` modoption, logged as `income bonus x1.5`) divides the
energy counts. The T2 mex upgrades come before the fusion (owner's rule);
the energy block ahead of both because the upgrades drain 7,700 each.

Energy is chosen from the map's numbers (`EnergyChoice`): a turbine's
metal per E/s at the expected wind against the solar's 7.75, with the
margin and the max-wind floor; on Supreme Isthmus (wind 1 to 19) that is
4.3 against 7.75, turbines. The chain logs the calculation at init. The
current wind decides the very first generator: a solar when the wind is
down and nothing generates yet, because a turbine's 175 energy would come
out of a bank that has nothing coming in.

The tails differ from the simulator's lines where play showed the
simulator wrong: in the game energy, not metal, is the constraint after the
advanced lab (constructors, mexes and the T2 lab drain what the simulator
did not model), so the energy block and the fusion come before the T2 mex
upgrades; the advanced lab starves on four solars and floats energy on eight, so six
stand before it; the T2 construction turret needs the extra-units pack and is not in
play, so two T1 turrets carry the build power; two advanced solars cost
four minutes on a starved base and are gone.

Targets are cumulative counts of standing structures of that def, so the
chain is idempotent: it never re-orders what stands or is queued.

## How a step is executed (`Next`)

For each step in order whose target is not met:

1. a builder that cannot build it goes on to the next step it can (the
   commander never takes the far mex step; mex steps are ally-aware (the
   allies' ground and the spots nearer an ally's start are theirs, D-072);
   T1 constructors skip the fusion,
   the T2 mex and the advanced fusion); the chain is complete only when
   every target is met, not when one builder runs out of steps;
2. an order of this step that lost its builder (a queued task) is taken over
   by the next builder that can build it;
3. cheap items (under `ChainParallelCostM` metal: mexes, turbines, solars,
   turrets) are built one per builder in parallel; a builder with nothing
   left to add assists a frame near it, or the last frame anywhere, and
   otherwise goes on to the next step (the advanced lab once waited 84 s
   for the last turbine);
4. dear items get every builder within `ChainAssistRadius` on the one
   frame; while an order is out and no frame exists yet, the other
   builders belong to the economy rows;
5. the chain remembers its own last order per step until the step's count
   rises, its frame appears or two minutes pass, because a fresh order is
   invisible to both the queued and the unfinished counts;
6. a step with no progress for `ChainStepStallSeconds` is skipped, so an
   unreachable site cannot end the rush; never the objective step itself;
7. orders go through the acts that own the placement: mex
   `EnqueueMexWithin` nearest first; lab `TechBuild::StartFactory`; advanced
   lab `Layout::T2LabTask`; T2 mex the nearest un-upgraded mex; turret
   `Layout::NanoTask`; energy `Layout::Place` in the turret box, else the
   nearest free footprint to the base centre; silo `Builder::EnqueueNukeSilo`;
   gantry `Builder::EnqueueLandGantry`. Energy and turret orders time out in
   two minutes.

While a chain is active the fast-assist bot cap is two, the legacy
strategic rungs and the spam-lab row are quiet, and `Tick` raises the caps
of every def in the chain to its target. `Init` marks the opening complete
so its rows stay quiet, and sets `MinimumT1ConstructorBots` (2) and
`MinimumT2ConstructorBots` for the factory rules.

## Logs

- `[TECH][Chain] objective afus (wind 10 -> solar; 2 T1 cons, 1 T2 cons): mex 6, solar 2, lab 1, ...`
- `[TECH][Chain] step 5/9 alab 0/1: ordered by corck 1234` (level 1 on change)
- `[TECH][Chain] no open mex spot within 1500: the mex step ends at 5`
- `[TECH][Chain] complete: objective afus reached at 1012 s; the economy rules continue`

## Settings (`Global::RoleSettings::Tech`)

| Setting | Default | Meaning |
| --- | --- | --- |
| `RushObjective` | `auto` | the objective; `eco` disables the chain; `auto` = `afus` |
| `OpeningMexRadius` / `OpeningMexCap` | 700 / 3 | the commander's home mexes before the lab (the opening's settings) |
| `ChainMexFarRadius` | 2500 | the constructors' mex step after the lab |
| `ChainMaxMexes` | 6 | mexes the chain claims in all |
| `ChainWindMargin` | 1.25 | turbines when their metal per E/s at the expected wind ((min+max)/2, capped 25) is under the solar's by this factor |
| `ChainWindMaxMin` | 12 | ... and the max wind reaches this (a lull must be worth riding out) |
| `ChainWindBootstrap` | 5 | the first generator is a solar while the current wind is under this |
| `ChainAssistRadius` | 4000 | every builder inside it joins a dear item's frame |
| `ChainParallelCostM` | 400 | cheaper structures are built one per builder in parallel |
| `ChainStepStallSeconds` | 120 | a step with no progress for this long is skipped |

## Related

- [`tech_rules.md`](tech_rules.md) - the table the row sits in.
- [`tech_build.md`](tech_build.md) - the acts.
- [`../eco-planner.md`](../eco-planner.md) - the economy that continues after the chain.

<!-- source: data/script/src/roles/tech_chain.as; blob: ca241f47f838ddcb3141f85bd21c1adf4939d32b; lines: 389 -->

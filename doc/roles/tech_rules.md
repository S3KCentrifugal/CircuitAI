# tech_rules.as - TECH's build rules as one ordered table

Script: [`data/script/src/roles/tech_rules.as`](../../data/script/src/roles/tech_rules.as),
namespace `TechRules`. Decision:
[D-067](../decisions.md#d-067--techs-build-sequence-is-one-ordered-rule-table).
The acts it calls live in [`tech_build.md`](tech_build.md); the economy
pieces in [`../eco-planner.md`](../eco-planner.md); placement in
[`../layout-design.md`](../layout-design.md); the game reasoning behind the
rows in the knowledge base's
[eco/tech player playbook](../../../rjm.bar.docs/knowledge/70-strategy/77-eco-tech-player.md).

## How a decision is made

`TechRules::Evaluate(unit)` builds one context (`Build`) - who is asking,
the 10-second incomes, the planner's `State` (banks, counts, build power,
what the box can hold), the opening and T2 flags, lab and constructor counts,
the spam gate, and the derived flags `draining`, `floatingE`, `floatingM`,
`surplus`, `fusionEra` - then walks the table top to bottom. A row applies
when its `who` mask matches and every predicate in its `when` list holds;
its act runs and the first non-null task wins. Every winning row logs
`[Rule] <key> for <def> <id> | M +m E e/target T1|T2 [draining] [E-float]
[M-float]` at level 1 when the key changed for that unit, level 3 otherwise.

`OpeningDone` reads the opening's flag live rather than the context, because
the opening act sets it in the same pass in which the lab row is next.
Predicates are named once (`OpeningDone`, `IntoT2`, `NoT1Lab`,
`NoConstructors`, `MetalBottleneck`, `Draining`, `EnergyShort`,
`EnergyIdle`/`EnergyBusy`/`EnergyAssistable`, `ConverterSurplus`,
`MetalFloating`, `EnergyAhead`, `EnergyForMe`, `SpamGate`, ...) and reused
across rows, so a condition cannot be lost by one row when another moves.

## The table

| # | Key | Who | When | Act |
| --- | --- | --- | --- | --- |
| 1 | `turret.assist` | turrets | - | reclaim in reach, then the economy under construction in the D-065 order |
| 2 | `turret.any` | turrets | - | any structure of ours under construction within 700 elmos (30 s task) |
| 3 | `turret.wait` | turrets | - | wait 5 s |
| 4 | `keep.current` | mobile | - | the construction the builder is on, when native re-asks |
| 5 | `opening.mex` | commander | `OpeningPending` | the nearest `OpeningMexCap` mexes within `OpeningMexRadius` |
| 6 | `lab.t1.reclaim` | mobile | `IntoT2` | every builder in range reclaims the T1 lab |
| 6a00 | `lab.t2.reclaim` | mobile | `T2LabRetiring` | D-078: the advanced lab is retiring (an advanced fusion is under construction and the bank has room for its metal): every builder reclaims it, turrets in range are pulled on |
| 6a0 | `energy.reclaim` | mobile | `EnergyReclaimable`, `NotStalling` | D-077: a fusion stands; winds and solars reclaimed when income without them covers the pull by `ReclaimT1EnergyMargin`, advanced solars at `ReclaimAdvSolarMargin`, all once an advanced fusion stands; nearest the base centre first |
| 6a0c | `energy.convert.float` | mobile | `EnergyFloatsBank`, `NotStalling`, `NoDearOrderPending` | D-079: before the chain, so floating energy (the chain's bank-based `EnergyFloats`) is converted whatever the chain is doing (played: no converter during a four-minute advanced fusion at a full bank) |
| 6a | `power.turret` | mobile | `MetalAhead`, `StructureBuilding`, `NotStalling`, `NoDearOrderPending` (D-084) | D-075, the owner's rule: the metal bank full for `PowerAheadSeconds` or risen by `PowerAheadRise` (income above spending, read from the bank) with `PowerTurretBankFactor` turret costs banked while a structure is under construction: a turret on the box slot nearest a lab, `PowerTurretsConcurrent` at a time, until static build power reaches `PowerBuildPowerPerMetal` x metal income (no cap while the bank has been full for `PowerAheadSeconds`); else assist the turret going up |
| 6b | `chain.next` | mobile | `ChainActive` | the rush chain's current step (D-070, [`tech_chain.md`](tech_chain.md)): assist its frame, wait for its order, or order it |
| 7 | `lab.t1.opening` | mobile | `OpeningDone`, `NotIntoT2`, `NoT1Lab` | the throwaway first lab at the commander; a constructor uses the pair's slot |
| 8 | `lab.t1.recover` | commander | `OpeningDone`, `NoConstructors`, `NoLabAtAll` | every constructor and lab lost: rebuild a T1 lab |
| 9 | `mex.expand` | constructors | `OpeningDone`, `MetalBottleneck` | the nearest open spot within `EcoMexExpandRadius` |
| 10 | `energy.draining` | mobile | `Draining`, `EnergyIdle` | cheapest energy per E/s; a fusion in the fusion era |
| 11 | `energy.assist` | mobile | `Draining`, `EnergyBusy`, `EnergyAssistable` | assist the energy structure going up |
| 12 | `lab.t2` | constructors | `OpeningDone`, `NoAfusYet` | the advanced lab once +18 metal / 250 energy clear |
| 13 | `mex.upgrade` | T2 constructors | - | the nearest owned T1 mex within `MexUpgradeRadius`, one at a time |
| 14 | `energy.convert` | mobile | `ConverterWanted` (`ConverterSurplus` or `EnergyOutscalesMetal`: energy income past `EcoEnergyRatioHigh` x metal with metal not floating), `NotStalling` | a converter; when energy outscales metal a T1 converter's draw is granted without a measured surplus |
| 15 | `turret.build` | mobile | - | a turret when static build power is short or metal floats; else assist the one going up |
| 16 | `energy.short` | mobile | `EnergyShort`, `EnergyIdle`, `EnergyForMe` | cheapest energy per E/s |
| 17 | `energy.assist2` | mobile | `EnergyShort`, `EnergyBusy`, `EnergyAssistable` | assist the energy structure going up |
| 18 | `storage.energy` | mobile | - | one energy storage once winds carry the base or the bank is small |
| 19 | `storage.metal` | mobile | - | metal storage when the bank is full |
| 20 | `energy.float` | mobile | `MetalFloating`, `EnergyAhead`, `EnergyIdle` | best-payback energy anyway |
| 21 | `lab.t1.spam` | constructors | `SpamGate`, `T2LabStands`, `SpamLabsWanted`, `ChainInactive` | a T1 lab on the pair's slot for the spam economy |
| 22 | `legacy.strategic` | mobile | `ChainInactive` | the role's strategic rungs as they stand (nukes, anti-nuke, gantry, water factories, T2 constructor policy) |
| 23 | `defence.base` | constructors | `FirstTurretStands` | one light laser and one light AA near the factories |
| 24 | `order.repair` | constructors | - | native's queued repairs of our own unfinished structures within `ExpOrderRadius` |
| 25 | `assist.any` | mobile | - | the nearest structure under construction within the builder's assist radius (commander: home radius) |
| 26 | `guard.factory` | constructors | - | guard the primary T1 lab |
| 27 | `wait` | mobile | - | 3 s |

"Who" masks: `COMMANDER`, `CON_T1`, `CON_T2`, `TURRET`; `MOBILE` is the
first three, `CONSTRUCTORS` the middle two.

## The T1 bot lab, as the table reasons about it

| Case | Row | Condition |
| --- | --- | --- |
| Game start | `lab.t1.opening` | opening done, not into T2, no T1 lab standing or queued; a throwaway at the commander, reclaimed once the advanced lab begins (`lab.t1.reclaim`) |
| Every constructor lost | `lab.t1.recover` | no mobile constructor alive and no lab of any tier standing or ordered; the commander rebuilds one to get builders |
| Late-game spam | `lab.t1.spam` | the spam economy gate open (`Global::Spam::MinMetalIncome` / `MinEnergyIncome`), the advanced lab standing, fewer than `ExpSpamLabs` T1 labs; placed on the pair's planned slot |
| A T1 front | none | TECH does not fight T1 lane battles; the fronts do |
| A second early lab | none | "one factory with turrets beats two without" (official economy guide); build power goes to turrets and the T2 lab |

## What the table does not decide

Factory production. `Tech_FactoryAiMakeTask` (tech.as) still chooses what
the labs make: constructors and fast-assist bots first, and no combat unit
before `ExpCombatMetalIncome` (200) while the experimental system is on
([D-068](../decisions.md#d-068--tech-makes-no-combat-unit-before-the-combat-gate-packed-sites-are-for-structures-only)).

## Adding or changing a rule

1. If the condition is new, add a predicate: one named function over
   `Ctx`, nothing else reads the world.
2. If the action is new, add an act in `tech_build.as` (it names a def and
   asks `Layout`; it never computes a site) and a one-line wrapper here.
3. Insert the row where it belongs in the order; the order is the policy.
4. Add the row to the table above and, if the reasoning is game knowledge,
   to the playbook in the knowledge base.
5. Watch `[Rule] <key>` lines in the next game.

## Settings

`ExpSpamLabs` (1) and the build-power rule's `PowerAheadSeconds` (15) and `PowerAheadRise` (30) (the bank, not the pull),
`PowerTurretBankFactor` (1.5), `PowerTurretBatchSeconds` (20) and `PowerTurretsMax` (8) (D-097) and
`PowerBuildPowerPerMetal` (20) (D-075) here;
everything else the rows read is documented with
its owner: the opening in [`tech.md`](tech.md), the economy in
[`../eco-planner.md`](../eco-planner.md), the acts in
[`tech_build.md`](tech_build.md).

<!-- source: data/script/src/roles/tech_rules.as; blob: 5072fa0d7c3aa6ee741e246e225db8bfec97d74f; lines: 434 -->

# tech_build.as - TECH's experimental build system

Script: [`data/script/src/roles/tech_build.as`](../../data/script/src/roles/tech_build.as),
namespace `TechBuild`. Decision:
[D-066](../decisions.md#d-066--the-experimental-build-system-a-hard-split-tech-only-one-switch).
Role document: [`tech.md`](tech.md). Sequence: [`tech_rules.md`](tech_rules.md) (D-067). Not Played:
[KI-411](../known-issues.md#ki-411--the-experimental-build-system-is-not-yet-played).

## Intent

When `Global::RoleSettings::Tech::ExperimentalBuild` is on, `TechBuild::MakeTask`
is the only source of work for every TECH builder. `Tech_BuilderAiMakeTask`
hands each ask to it on its first line; native's chooser returns nothing
for the instance, so there is no fallback into stock sequencing, and native's
site search never spirals for the instance, so there is no fallback into
stock placement. With the switch off the file is never called.

`MakeTask` never returns null. A builder with nothing to build assists the
nearest structure under construction, guards the primary factory, or waits
three seconds and is asked again.

## The sequence

Since [D-067](../decisions.md#d-067--techs-build-sequence-is-one-ordered-rule-table)
the sequence is the rule table in [`tech_rules.md`](tech_rules.md);
`MakeTask` is `TechRules::Evaluate(u)` with a 3 s wait if the table
answers null (it cannot: its last row is `wait`). This file holds the acts
the rows call. Each names a def and asks `Layout` or native for the site; none
computes one.

| Act | Who calls it (row) | What |
| --- | --- | --- |
| `Tech_TurretAssist` (tech.as), `AssistAny`, `Wait` | `turret.assist`, `turret.any`, `turret.wait` | reclaim in reach, then the economy under construction in the D-065 order, then any structure under construction within 700 elmos, then wait 5 s |
| `KeepCurrent` | `keep.current` | the construction it is on (build type below `REPAIR`) when native re-asks while it walks |
| `Opening::MakeTask` (tech.as) | `opening.mex` | the nearest `OpeningMexCap` mexes, nearest to the commander first |
| `ReclaimT2Lab` | `lab.t2.reclaim` | D-078: the advanced lab, retired by `Tick` the moment an advanced fusion is under construction with bank room for its metal; every builder reclaims it and `PullTurrets` puts every turret in range on it |
| `EnergyAllowed` | (hook `Global::energyAllowed`) | D-077, D-079: the one answer to "may this energy def still be ordered": nothing while energy floats (`TechChain::EnergyFloats`); no wind or solar once a fusion stands, no advanced solar once an advanced fusion is under way; asked by the shared builder helpers and the eco planner |
| `MetalAhead` / `TrackMetal` | (used by `power.turret`) | D-075: the metal bank sampled once a second in `Tick`; ahead = full for `PowerAheadSeconds` or up by `PowerAheadRise` |
| `ReclaimEnergy` | `energy.reclaim` | D-077: with a fusion standing, reclaim winds and solars nearest the base centre once energy income without them covers the pull by `ReclaimT1EnergyMargin`; advanced solars at `ReclaimAdvSolarMargin`; everything once an advanced fusion stands; `ReclaimEnergyConcurrent` targets in flight |
| `ReclaimT1Lab` | `lab.t1.reclaim` | the throwaway lab only (D-076); once the advanced lab's frame exists and the metal bank has room for the lab's metal (D-072: reclaim past the cap is lost; the advanced lab's build makes the room), reclaim the T1 bot lab: one native reclaim task that every builder within `ExpAssistRadius` (commander: `ExpCommanderHomeRadius`) joins; turrets in reach take it first, and their assist tasks are 30 s so they re-ask soon |
| `StartFactory` | `lab.t1.opening`, `lab.t1.recover`, `lab.t1.spam` | a T1 bot lab. By the commander: on the nearest buildable footprint within `ExpFirstLabRadius` (224) of where it stands whose edge is at least `ExpFirstLabClearance` (32) from the commander (a factory ordered on top of its builder has its command dropped by the engine), reserved and pinned - it is a throwaway, reclaimed once the advanced lab begins, so no walking; `Tick` holds an exit cone in front of it while it stands. By a constructor: the pair's reserved slot. Native's start-factory job is silent and `holdStartFactory` stays on for the whole game. The `IntoT2` guard lives in the table, not here |
| `ExpandMex` | `mex.expand` | the nearest open spot the builder can reach within `EcoMexExpandRadius` (every spot inside it considered, nearest first), allied ground excluded; logs `expands to a mex at (x, z)` and, once a minute, `no open mex spot within R` |
| `EcoPlanner::Pick*` / `Enqueue`, `Layout::T2LabTask` (D-073: the advanced lab where the most turret slots reach it, front first) | `energy.*`, `lab.t2`, `mex.upgrade`, `energy.convert`, `turret.build`, `storage.*` | the planner's pieces, called one at a time by the rows that own them: energy, converters, the advanced lab, mex upgrades, turrets, storages, all packed into the turret box |
| `Tech_Commander_AiMakeTask` / `Strategic` | `legacy.strategic` | the role's strategic rungs as they stand (recycle, nukes, anti-nuke, gantry, water factories, T2 constructor policy) with a null default; the planner they used to call answers nothing in this mode |
| `Defence` | `defence.base` | once the first turret stands: `ExpDefenceLLT` (1) light laser and `ExpDefenceAA` (1) light AA turrets near the factories (packed by native within `ExpDefenceRadius` of the factory centre, outside the planned zones), at most `ExpDefenceMaxOrders` orders per def (D-075: native refused the site fifteen times in a row); nothing else, and native's porc chain is not asked (`Tech_AiMakeDefence` returns at once) |
| `QueuedOrder` | `order.repair` | native's queued repair orders for our own unfinished structures, nearest first (`aiBuilderMgr.FindQueuedTask`), within `ExpOrderRadius` of the base centre; native's defence, radar and sonar orders are left alone |
| `AssistAny` | `assist.any` | the nearest structure of ours under construction within `ExpAssistRadius` (commander: `ExpCommanderHomeRadius`) |
| `GuardFactory` | `guard.factory` | never a retiring lab (D-076); guard the primary T1 lab (`GuardHelpers::AssignWorkerGuard`) |
| `Wait` | `wait` | 3 s, then ask again |

## Placement

Nothing here computes a site. The planner places through `Layout::Place`
and `Layout::NanoTask` (the turret box); the strategic rungs and native's
queued orders name an anchor, and native packs the free footprint nearest
it within `ExperimentalSearchRadius` (`PackNearPoint`), reserved and served.
Mex and geo orders are exact spots.

## Settings

| Setting (`Global::RoleSettings::Tech`) | Default | Meaning |
| --- | --- | --- |
| `ExperimentalBuild` | true | the switch for the whole system |
| `ExperimentalSearchRadius` | 512 | how far from an anchor a site may be packed |
| `ExpAssistRadius` | 1500 | rung 9's radius |
| `ExpOrderRadius` | 2000 | rung 8's radius from the base centre |
| `ExpDefenceLLT` / `ExpDefenceAA` | 1 / 1 | rung 7b's counts |
| `ReclaimTurretMargin` | 48 | D-078: a turret within its build distance plus this of a reclaim target is pulled onto it |
| `ReclaimT1EnergyMargin` / `ReclaimAdvSolarMargin` | 1.25 / 1.5 | D-077: income-without-them over the pull that lets winds and solars, then advanced solars, be reclaimed |
| `ReclaimEnergyRadius` / `ReclaimEnergyConcurrent` | 2500 / 4 | D-077: how far from the base centre, how many at once |
| `ExpDefenceMaxOrders` / `ExpDefenceRadius` | 3 / 900 | rung 7b's orders per def and site radius (D-075) |
| `ExpCommanderHomeRadius` | 800 | the commander's assist radius after the opening; it never takes rung 8 |
| `EcoMexExpandRadius` / `EcoMexExpandUntilIncome` | 2500 / 60 | rung 5 |

## Logs

Level 1: `[TECH][Build] experimental build system on: ...` at init,
`[TECH][Build] start factory ordered on the reserved slot`. Level 2:
`[TECH][Build] <def> <id> expands a mex`. Native: `RESERVE: packed <def>
near (x, z) at (x, z), D away` for every packed site, `RESERVE: no site for
<def> within R of (x, z)` when none.

## Lifecycle (D-076)

`Tick` decides the throwaway once, the T1 lab standing when the advanced lab
first is under way (`throwawayLabId`; later spam labs are keepers), aborts
its native task (`aiFactoryMgr.AbortTask`, else the recruit task re-issues
the build on idle) and retires it: `Lifecycle::Retire` stops the unit and
its queue and logs `[LIFECYCLE] corlab N retiring`. INV-005 fires if any
other T1 lab is ever retiring. The advanced lab retires the same way the
moment an advanced fusion is under construction and the bank has room for
its metal (D-078, INV-007); every reclaim the role orders pulls the turrets
in range onto it (`PullTurrets`, native `TurretsOnReclaim`, INV-008). From then on the factory task maker returns
nothing for it, `GuardFactory` and the chain's commander help refuse it, and
`ReclaimT1Lab` is the only act that targets it (turrets joining the reclaim
are welcome). The state is read from `Lifecycle`, never kept here. See
[`../actor-matrix.md`](../actor-matrix.md) and
[`../invariants.md`](../invariants.md) (INV-001).

## Related

- [`tech.md`](tech.md) - the role, the split, the legacy ladder.
- [`../eco-planner.md`](../eco-planner.md) - rung 6.
- [`../layout-design.md`](../layout-design.md) - where the planner's structures go.

<!-- source: data/script/src/roles/tech_build.as; blob: 1061d026f8f2b80b2648b43100492aa11a2f86ec; lines: 756 -->

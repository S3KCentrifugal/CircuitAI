# Actor matrix

Who acts on what, for the TECH role. One row per actor, grouped by the object
it reads or orders on, with the state it reads. A change to how an object is
handled updates this table; `tools/knowledge/check_invariants.py` requires
every rule row of the TECH table ([`roles/tech_rules.md`](roles/tech_rules.md))
to appear here. The practice is [`practice-invariants.md`](practice-invariants.md).

States: framed (a frame is under construction), active (stands), retiring
(`Lifecycle::IsRetiring`, D-076), gone. Retiring is set once by the act that
decides the end; everything else reads it.

## The T1 bot lab (`Factory::primaryT1BotLab`)

| Actor | Reads | Does |
| --- | --- | --- |
| `TechBuild::Tick` | `IntoT2`, `throwawayLabId` | decides the throwaway once (the lab standing when the advanced lab begins); aborts its native task and sets retiring; INV-005 |
| `Lifecycle::Retire` | - | stops the unit and its queue (`CmdStop`), logs `[LIFECYCLE]` |
| `Tech_FactoryAiMakeTask` | retiring | returns nothing for a retiring lab; native's factory manager gets no production for it |
| `lab.t1.reclaim` (`ReclaimT1Lab`) | `throwawayLabId`, metal bank room (D-072) | the reclaim order for the throwaway only; the only act that may target a retiring lab |
| `lab.t1.opening`, `lab.t1.recover` (`StartFactory`) | none stands | orders a T1 lab at the commander or on the pair's slot |
| `guard.factory` (`GuardFactory`) | retiring | guards the lab; never a retiring one |
| `chain.next` (`CommanderOnFirstConstructor`) | retiring, T1 constructor count | the commander helps the first constructor out; never at a retiring lab |
| `lab.t1.spam` (`SpamLab`) | `ChainInactive`, T2 lab stands | further T1 labs for the spam economy |
| `turret.assist` (`Tech_TurretAssist`) | reclaim targets in reach | joins the reclaim, which is allowed on a retiring lab |
| `TechBuild::Tick` (exit cone) | lab stands | holds the exit cone until the lab is gone |
| `Factory::AiUnitAdded` / `AiUnitRemoved`, `Tech_FactoryAiUnitRemoved` | - | tracks the primary lab; `Lifecycle::Forget` on removal |
| INV-001 | retiring | a unit produced by a retiring factory is a violation |

## The advanced lab (`Factory::primaryT2BotLab`)

| Actor | Reads | Does |
| --- | --- | --- |
| `lab.t2` (`T2LabTask`, D-073) | build power near the pair's slot | orders it where the most turret slots reach |
| `chain.next` (step `alab`) | count, frame | orders or assists it as a dear step |
| `TechBuild::Tick` (exit cone) | lab stands | holds its exit cone (D-074) |
| `Tech_FactoryAiMakeTask` | retiring | production; nothing for a retiring lab |
| `TechBuild::Tick` (D-078) | `AfusUnderWay`, bank room | retires it the moment an advanced fusion is under construction and the bank has room; INV-007 |
| `lab.t2.reclaim` (`ReclaimT2Lab`, D-078) | retiring, bank room | every builder reclaims it; turrets in range are pulled on |
| `lab.t2` (`NoAfusYet`), `chain.next` (step `alab`) | `IntoAfus` | never order another advanced lab once an advanced fusion is under way |
| `mex.upgrade`, `legacy.strategic` | T2 constructors it produced | T2 mex upgrades, nukes, gantry |

## A structure frame under construction

| Actor | Reads | Does |
| --- | --- | --- |
| `keep.current` | the builder's own task | keeps the builder on the frame it is building (D-074) |
| `chain.next` (near-frame pre-pass, assist) | unfinished count, distance | finishes a cheap frame beside the builder, assists the dear frame |
| `power.turret` (D-075) | metal income vs pull, frame exists | a turret while a structure is under construction with build power short |
| `turret.any`, `assist.any`, `order.repair` | nearest unfinished, native's queued repairs | assist any frame within reach |
| `energy.assist`, `energy.assist2` | energy frame within `EcoAssistRadius` | assist the energy structure going up |
| native `BuilderManager` (D-074) | own frame at the site | adopts an orphan frame instead of reclaiming it |
| INV-002 | build power near the frame | a frame without build power for `InvariantFrameSeconds` is a violation |
| INV-003 | unfinished count at a chain skip | skipping a step whose frame exists is a violation |

## A turret slot and the turret rows

| Actor | Reads | Does |
| --- | --- | --- |
| `Layout::NanoTask` | box centre, consumed slots, box growth (D-077, D-072) | the slot nearest the box centre first, then the free slot nearest a taken one (`NextSlotConnected`); `ExpTurretCentreOut` off = nearest a standing lab (D-069) |
| `power.turret`, `turret.build`, `chain.next` (step `nano`) | build power, income, floating | order a turret on a slot |
| `turret.assist`, `turret.any`, `turret.wait` | reclaim in reach, unfinished in reach | what a standing turret does when asked |
| native `TurretsOnReclaim` via `TechBuild::PullTurrets` (D-078) | turrets within build distance + `ReclaimTurretMargin` of a reclaim target | takes every one of them off its task and onto the reclaim the moment it is ordered; INV-008 |
| `defence.base` (`Defence`, D-075) | first turret stands, orders per def | one light laser and one AA near the factory centre, at most `ExpDefenceMaxOrders` orders each |

## A metal spot

| Actor | Reads | Does |
| --- | --- | --- |
| `opening.mex` (`Opening`) | spots within `OpeningMexRadius`, ownership (D-072) | the commander's home mexes |
| `chain.next` (steps `mex`, `moho`) | own spots within `ChainMexFarRadius`, upgrade candidates | far mexes by constructors, T2 upgrades |
| `mex.expand`, `mex.upgrade` | metal bottleneck, T2 constructors | more spots, upgrades outside the chain |
| native `EconomyManager` (`IsOwnSpot`) | nearest start position | a spot belongs to the nearest start |

## The banks and energy

| Actor | Reads | Does |
| --- | --- | --- |
| `energy.draining`, `energy.short`, `energy.float` | energy bank, income, target | energy structures by payback |
| `energy.convert` | energy floating or outscaling metal | converters |
| `energy.convert.float` (before the chain, D-079) | `TechChain::EnergyFloats` | a converter whatever the chain is doing |
| `chain.next` (energy steps, D-079) | `TechChain::EnergyFloats` | passes a cheap energy step over and holds the fusion or advanced fusion while energy floats; the builder goes to `energy.convert` |
| INV-009 | `EnergyFloats`, energy frames | an energy frame appearing while energy floats is a violation |
| `Global::energyAllowed` = `TechBuild::EnergyAllowed` (D-077, D-079) | a fusion stands, an advanced fusion under way | vetoes wind and solar in the fusion era, advanced solars in the advanced-fusion era, and every energy def while energy floats, for every act that orders energy: the shared builder helpers, the planner, the legacy rows |
| `energy.reclaim` (`ReclaimEnergy`, D-077) | a fusion stands, income without the T1 sources vs the pull | reclaims winds and solars, then advanced solars, nearest the base centre; everything once an advanced fusion stands |
| INV-006 | advanced fusion stands, wind/solar/advanced-solar counts | T1 energy standing 180 s after the advanced fusion is a violation |
| `storage.energy`, `storage.metal` | winds, bank vs income | storages |
| `power.turret` | metal income vs pull | turrets while a structure is under construction |
| `legacy.strategic` | `ChainInactive`, the role's rungs | nukes, anti-nuke, gantry |
| `wait` | - | 3 s, then ask again |
| INV-004 | metal bank share, frame, static build power | floating metal during a construction with build power short is a violation |

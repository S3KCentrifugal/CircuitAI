# Actor matrix

## AIR compact lab clusters and early energy retirement (D-167)

| Object | Actor | State read or changed |
| --- | --- | --- |
| Six-lab compound | AirLayout::Reserve / native PlanAirFactoryCluster | Atomic footprint preflight; persistent per-building slots and shared envelope; named cluster ID links six bays. |
| Unused compound | AirLayout::Activate | All member slots checked before first use; any started slot anchors all members; otherwise physical blockage releases and relocates all six. |
| Factory/nano frame | AirBuild::Factory / Nano / AirEconomy::RefreshSupport | Existing required pins and exclusive nearest-bay turret assignment; twenty completed supports before another T2 lab. |
| Wind/basic/advanced solar | AirReclaim::Allowed / MakeTask / Tick | Completed reactor and shared TECH thresholds, fresh target ID, task ownership, bounded concurrency; Lifecycle retirement and release of gone wind pins. |
| Reclaim policy ownership | AirLayout::Init / Leave | Save native legacy reclaim setting in persistent named state, disable while AIR owns reclaim, restore on role exit; no concurrent native early-energy selector. |
| Replacement low-tier energy | AirLayout::Place / PlaceWind / AirBuild::Energy | All callers refuse wind/basic/advanced solar while AFUS stands; wind also stops while the shared retirement threshold is satisfied. Reactor loss restores recovery eligibility. |
| TECH early energy | TechBuild::ReclaimEnergy | Same ordered rule, arithmetic and thresholds; only the scalar predicate is shared with AIR. |

## AIR production and economy (D-147)

These actors are local to AIR. The TECH objects and rows below retain their
existing ownership and sequence.

| Object | Actors and reads | Actions |
| --- | --- | --- |
| Bay and support slots | `AirLayout::Reserve`, `AdoptSupport`, native reservation states, unit ownership/reach | Reserve factory and usable rear/side support banks atomically; restore persistent slots after loss; roll back unused candidates; `AirLayout::Leave` resets on role switch. |
| Builder projects | `AirBuild::Added`, `Record`, `Removed`, `Tick`, `Resume`; task identity/frame/assignee | Claim successful script enqueues; cancel unowned native completion-chain orders; resume owned orphans; release on removal; INV-076. |
| Opening/recovery | `recovery.resume`, `recovery.assist`, `recovery.energy`, `project.resume`, `opening.mex`, `opening.energy`, `transport.plant`, `opening.plant` | Retain current construction, stabilize energy, restore workers to orders, open/recover T1 transport capability. |
| Metal and supply | `mex.upgrade`, `mex.expand`, `production.support`, `storage.buffer`, `energy.assist`, `energy.grow` | Safe mexes and capable upgrades; useful live support before aspirational energy growth; first wind buffer. |
| Capacity and services | `transition.bay`, `intel.radar`, `defence.flak`, `storage.metal`, `production.bay`, `storage.energy`, `surplus.convert` | Fund first T2 independently of moving energy targets, then expand on sustained income; explicit radar/flak/storage/conversion. |
| Fallback work | `service.queued`, `project.assist`, `production.assist`, `wait` | Admit repair/defence/radar service; assist owned frames or utility plant; bounded retry. |
| Resource model | `AirEconomy::Tick`, `Transition`, `NanoTarget`; ten-second lows, banks, committed cost, physical work/reach | Distinguish live/future BP; assign each nano once; estimate mixed sortie cost; gate transitions; INV-073/074. |
| Aircraft orders | `AirProduction::MakeTask`, `Recruit`, native pending count plus frames | Transport prehook first; finite scout/constructor/strike/home quotas; heavy and wave production; no duplicate frame accounting. |
| Home and attack aircraft | `AirProduction::HomeTask`, `AirScreen`, `AirWaves`, native military tasks | T1 fighters and the income/threat T2 reserve patrol cells; exclusive escorted waves; release on role switch; INV-072/080. |
| Allied transport obligations | `Team::Ferry::HandleMessage`, `FactoryMakeTask`, `OnUnitAdded/Removed`, `Update` | Validate requestor; deduplicate/FIFO; NOW-priority recruit; retry losses; fly then transfer; start next obligation; INV-075. |


Who acts on what, for the TECH role. One row per actor, grouped by the object
it reads or orders on, with the state it reads. A change to how an object is
handled updates this table; `tools/knowledge/check_invariants.py` requires
every rule row of the TECH table ([`roles/tech_rules.md`](roles/tech_rules.md))
to appear here. The practice is [`practice-invariants.md`](practice-invariants.md).

States: framed (a frame is under construction), active (stands), retiring
(`Lifecycle::IsRetiring`, D-076), gone. Retiring is set once by the act that
decides the end; everything else reads it.

## Specialist flank factory (D-136)

| Actor | Reads | Does |
| --- | --- | --- |
| `flank.factory` / `TechFlank::Work` | income, pending task, factory ID, land connectivity, effective build menu | creates or repairs one extra factory |
| `TechFlank::Owns`, factory registration | saved ID/site, live unit | keeps dedicated lab out of primary-lab production |
| `TechFlank::Produce` | ownership, Lifecycle retirement, combat build menu | continuously recruits specialist combat units |
| `TechFactories::BaseLandFactory` | dedicated ownership | excludes flank lab from base reclaim |
| `TechFlank::MilitaryTask`, `Tick`, `TaskRemoved` | producer ID, persisted membership, live task | maintains mountain waypoint ownership and INV-067 |
| native `CRouteTask` | preserved-waypoint mode, arrival tolerance, per-definition `standoff`, observed enemies | follows the mountain; configured ranged units pause for combat and resume the same route after contact loss |
| `CCircuitUnit::KeepWeaponRange` | JSON range fraction, weapon reach, height difference, movement area | approaches a firing distance, holds or backs away; never appends a fight-to-target order |

## The harbour (an island TECH, D-121)

| Actor | Reads | Does |
| --- | --- | --- |
| `harbour.float` (`CommanderFloat`) | land-locked start, energy full, energy income | the commander's floating converters before the harbour |
| `harbour.yard` (`LandTask`) | `TechHarbour::Active`, a hover plant stands or is queued | a land constructor orders the hover plant on a reachable island footprint |
| `harbour.sea` (`SeaTask`) | the advanced shipyard, the yards, energy low or full | the advanced shipyard (site picked by ring search), help on a yard going up, floating turrets, then converters, tidals and naval fusions; INV-051 |
| `Tech_FactoryAiMakeTask` (`YardTask`, `HoldsLandCombat`) | the harbour runs | the hover plant makes hover constructors; the yards make construction ships and subs, then sea combat; land labs make no combat |
| INV-010 | `TechHarbour::IsHarbourUnit` | harbour sea units are exempt from the combat gate |

## Weapon clusters and lanes (TECH, D-126, D-127)

| Actor | Reads | Does |
| --- | --- | --- |
| `weapons.cluster` (`TechWeapons::Work`) | metal income over +200 and the kind's gate, the budget, `WeaponMaxConcurrent`, the ranked clusters | the highest-priority open slot the builder can build: kill zones, air defence, artillery, long range, coast, the super cannon's escort; INV-060, INV-061, INV-054 |
| `weapons.super` (`TechWeapons::SuperTask`) | a super-cannon cluster, +500 metal (+1000 or high need), energy for its fire | an air constructor frames the cannon, or assists the frame; `SuperTick` pulls every air constructor to it; INV-057, INV-058, INV-059 |
| `TechWeapons::Tick` / `Replan` | `aiBattle` routes, chokes, heat, composition, water, beaches | finds the strategic defence points and re-ranks the clusters every `WeaponReplanSeconds`; a started cluster keeps its point |
| `Lanes::Tick` | both teams' starts, the front | lanes per movement class at game start, again when the front moves or every `LaneRecalcSeconds`; drawn 30 s after the intro; `BestLane` for attack planning |

## The T1 bot lab (`Factory::primaryT1BotLab`)

| Actor | Reads | Does |
| --- | --- | --- |
| `TechBuild::Tick` | `IntoT2`, `throwawayLabId` | decides the throwaway once (the lab standing when the advanced lab begins); aborts its native task and sets retiring; INV-005 |
| `Lifecycle::Retire` | - | stops the unit and its queue (`CmdStop`), logs `[LIFECYCLE]` |
| `Tech_FactoryAiMakeTask` | retiring | returns nothing for a retiring lab; native's factory manager gets no production for it |
| `lab.t1.reclaim` (`ReclaimT1Lab`) | `throwawayLabId`, metal bank room (D-072) | the reclaim order for the throwaway only; the only act that may target a retiring lab |
| `lab.t1.opening`, `lab.t1.recover` (`StartFactory`) | none stands, `Layout::fallback` | orders a T1 lab at the commander (with no planned pair: any facing, up to 800 away, D-120) or on the pair's slot; INV-050 |
| `guard.factory` (`GuardFactory`) | retiring, `IsSpamLab` | guards the lab; never a retiring one, never a spam lab (D-119) |
| `chain.next` (`CommanderOnFirstConstructor`) | retiring, T1 constructor count, `IsSpamLab` | the commander helps the first constructor out; never at a retiring lab or a spam lab (D-119) |
| `lab.t1.spam` (`SpamLab`) | `ChainInactive`, T2 lab stands | further T1 labs for the spam economy |
| `turret.assist` (`Tech_TurretAssist`) | reclaim targets in reach | joins the reclaim, which is allowed on a retiring lab |
| `TechBuild::Tick` (exit cone) | lab stands | holds the exit cone until the lab is gone |
| `Factory::AiUnitAdded` / `AiUnitRemoved`, `Tech_FactoryAiUnitRemoved` | - | tracks the primary lab; `Lifecycle::Forget` on removal |
| INV-001 | retiring | a unit produced by a retiring factory is a violation |

## The advanced lab (`Factory::primaryT2BotLab`)

| Actor | Reads | Does |
| --- | --- | --- |
| turret gate (`Layout::NanoTask`, D-097, D-098) | turret orders in flight, dear frames under construction (one slot each), `TurretSlots()` (bank, income, nearby build power) | refuses a new turret when the in-flight count reaches the calculation; the chain step, `power.turret` and the economy rows then assist; INV-019 |
| layout packer (`PackCandidates`, D-096, D-099) | the exit lanes of every planned and standing factory; the zone, then the ring within a turret's reach | packs no footprint into an exit lane; the main cluster first, then the forward cluster (`Layout::Place`); INV-018, INV-020 |
| set packer (`PackSet`, `Layout::Place`, D-101) | turret slots (edge gap), the set's unserved slots | advanced fusions in sets of 3 and advanced converters in sets of 5, flush then outward; INV-022 |
| reclaim of our own structure (`CBuilderManager`, D-101) | the structure's layout slot | the slot is erased when it goes, not restored |
| `turret.spam` (D-109, D-114, D-117, D-119) | a front cluster's factory stands (a spam lab's: always) | the turrets behind it build its frame, then the units it produces; a spam lab's two are `no_disrupt` (never pulled onto a reclaim) and wait for their lab before it exists; asked from `Tech_FactoryAiMakeTask` (turrets are the native factory manager's) with factory-side tasks, or by the rule with builder tasks; INV-038, INV-048 |
| front factory cluster (`TechFactories::Work`, `Route`, D-114) | a land factory wanted from +200 metal | the cluster planned at least 20% toward the front on flat, roomy ground; its turret block first, the factory once every turret stands; INV-038, INV-045 |
| `lab.front` (D-114) | a standing front factory missing a turret; no advanced lab with the economy online; an open T2 or T3 front cluster (planned, factory not up) | any constructor reaching the row: the lost turret; a T2 front cluster planned; the open cluster's turrets, help on one going up, then its factory; INV-046 |
| `lab.base.reclaim` (D-114) | `FrontReclaimAtCount` land factories on the map | the base's land factories retired and reclaimed, never rebuilt there while a land factory stands; their ground goes to the economy; INV-044 |
| `ferry.cargo` (D-110, D-112) | the unit is a gift (in flight or queued) | in flight: the ferry's hold; queued: parked behind the base; nothing else until the drop-off; INV-041 |
| `CFerryTask` UNLOADING (native, D-122) | the transport's command queue, `IsAboard` | the run is delivered once the unload is over and the cargo not aboard (or it stands on the ground); `Team::Ferry::Update` gives it within a second; INV-052 |
| `land.recall` (D-109) | a tier's air constructors went down | its land constructors drop a forward job; INV-040 |
| `fwd.t2.defend` (D-109) | both dedicated T2 air roles held | T2 land constructors: long-range AA then flak at every mex cluster outside the base; INV-039 |
| `fwd.t1` (D-109, D-119) | more than 5 T1 air constructors | T1 land constructors: the spam cluster (labs, turrets, AA, pads); helps only structures going up there, never guards a spam lab or helps its production; INV-038, INV-039, INV-049 |
| `GuardHelpers::AssignWorkerGuard` (D-119) | `IsSpamLab`, `IsOwnTurret` | every guard of a lab passes here: a guard of a spam lab by anything but its own two turrets is refused; INV-049 |
| `DoTurretFactory` (turret rows, D-119) | producing factories in reach, `IsSpamLab` | a turret assists the nearest producing factory, never a spam lab |
| spam production (`Spam::FactoryMakeTask`, D-111, D-119) | spam active, a spam lab asks | the next spam unit at every ask (no repeat: native clears a factory's queue when a recruit finishes) |
| spam lanes (`TechForward::TickSpam`, `Spam::SetSpreadLanes`, D-119) | the standing spam labs, the combat front, the focus | one lane per spam lab, `LaneSpacing` apart across the front, straight on to the enemy backline; re-spread when the count changes and every 30 s |
| advanced lab production (`Tech_FactoryAiMakeTask`, D-103, D-119) | bank share, T2 construction bot count, fast assist cap | T2 construction bots to `T2BotConstructorCap` (10), fast assist bots to `FastAssistBotCap` (10), then fast assault bots; INV-028 |
| `air.dedicated` (D-107, D-108) | the first two T2 air constructors | one always builds advanced converters, the other always advanced fusions; with no site in the layout it builds defences meanwhile (D-123), else waits and says why; its structure's cap lifted while held; INV-034, INV-035, INV-036 |
| `air.defend` (`TechBuild::AirDefence`, D-123; D-126: `TechWeapons::Work` first) | an air constructor with nothing else to do | reserved resource/lane fortification first, then funded weapon-cluster slots (D-152); no expanding turret spiral; INV-053 |
| air role refill (`TechBuild::RefillAirRoles`, `ClaimOnBuilt`, D-108) | a dedicated builder gone; a T2 air constructor built | the role passes at once (advanced fusions first), the new holder drops its other job; the advanced aircraft plant makes one when none is free; the donation keeps dedicated units |
| advanced-fusion ground ahead (`Layout::HoldAfusSetAhead`, D-108) | the fusion role held, no set slot left | the next set of advanced-fusion ground reserved (zones, forward, then the ring within reach), retried every 10 s; INV-037 |
| dead slot (native `CTerrainManager`, D-108) | the engine refuses a pinned slot 3 times | the slot is never offered again, its ground stays held, the set moves on |
| `air.flex` (D-107) | energy floats, converters starve | other T2 air constructors: converters while energy floats, assist the advanced fusion when converters starve |
| turret assist order (`Tech_TurretAssist`, D-065, D-107) | reclaim in reach, converters starve | reclaim first; the advanced fusion first when converters starve, else the advanced converter first |
| overflow donation (`TechBuild::ShareOverflow`, `TeamEconomy`, D-106) | our metal bank, every teammate's snapshot (refreshed first) | up to 20% of our storage to the lowest-filled live teammates, filling their free storage, when over 95% after the opening; INV-033 |
| advanced-lab retirement gate (`TechBuild::AfusFunded`, D-105) | bank, income, the advanced fusion frame's progress and build power | the lab kept when 85% of the advanced fusion's cost will be earned; INV-031 |
| T2 constructor reclaim (`TechBuild::T2MayReclaim`, D-105) | other build power near the target | a T2 constructor reclaims only as a last resort |
| `power.t1` (D-105) | dear frame up, turret room | a T1 constructor adds a turret before assisting |
| `turret.factory` (D-105) | metal bank full, producing factory in reach | a turret assists factory production |
| converter rows (`energy.convert*`, D-105) | `MetalFullLong` | no converter while the metal bank is full; INV-032 |
| every factory order (`CBFactoryTask::FindBuildSite`, `PackFactoryFlush`, D-104) | registered clusters, front facing, air or ground | pinned flush against a turret; ground facing the front with its exit clear, air any facing; INV-029 |
| air plants (`ap`, `aap` plan steps, `Layout::OrderFactory`, D-103) | air constructors | a T1 air plant, its one air constructor, then the advanced aircraft plant; INV-027 |
| T2 constructor production (`Tech_FactoryAiMakeTask`, D-103) | metal bank share, T2 constructor count | one T2 constructor at the advanced lab while the bank is over half, to 60; INV-028 |
| replacement factory (`TechBuild::ResetFactory`, native `isReset`, D-102) | T1 constructors, metal income, advanced labs | none with 3+ T1 constructors under +200; else the advanced lab first; INV-025 |
| T1 lab after the first (`TechBuild::T1LabAllowed`, `StartFactory`, chain lab step, D-102) | constructors, advanced lab, `EcoOnline` | a restart always; else only with an advanced lab up and fewer than 3 T1 constructors or the economy online; INV-025 |
| lab retirement (`TechBuild::Tick`, D-066, D-078, D-102) | `EcoOnline` | no lab retired once the economy is online; INV-026 |
| factory placement (`ReserveFactorySite`, `Tech_SelectFactoryHandler`, `StartFactory`, D-101) | `TurretsStand()` | with a turret standing, the layout places the factory and native's replacement is pinned; anywhere only with none; INV-023 |
| any layout reservation (`ReserveBuildingEx`, D-099) | the exit lanes of every planned and standing factory | refuses a footprint in one; INV-018 |
| chain moho step (`TechChain`, D-100) | owned mexes within `ChainMohoRadius`, `TechBuild::MetalFullLong` | upgrades every one before the fusion; with metal floating a free builder goes on to the next step; INV-021 |
| economy rows' energy pick (`EcoPlanner::PickEnergy`, D-100) | `TechChain::MohosPending` | no fusion or advanced fusion while upgrades are pending |
| chain dear step (`TechChain`, D-098) | `Layout::BuildSlotFree()`, `Layout::TurretFrame()` | with no build-power slot free and a turret going up, finishes the turret before ordering the step |
| `lab.t2` (`T2LabTask`, D-073, D-085, D-086) | its planned footprint, standing turrets within `LayoutLabServedReach`, `Layout::TurretSeed` (the home mex centre) | faces `LabFacing()`, the nearest enemy (else a facing beside it, never away, D-096); orders it where the most slots reach, served ones weighing three, ahead of the block (D-096), flush with a turret slot (`LayoutLabFlushElmos`, D-095), nearest the block's seed among equals; INV-016, INV-017, INV-018 |
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
| `power.turret` (D-075, D-084) | the bank full or rising, frame exists, `DearOrderPending` | a turret while a structure is under construction with build power short, unless a dear chain order has no frame yet |
| `turret.any`, `assist.any`, `order.repair` | nearest unfinished, native's queued repairs | assist any frame within reach |
| `energy.assist`, `energy.assist2` | energy frame within `EcoAssistRadius` | assist the energy structure going up |
| native `BuilderManager` (D-074) | own frame at the site | adopts an orphan frame instead of reclaiming it |
| INV-002 | build power near the frame | a frame without build power for `InvariantFrameSeconds` is a violation |
| INV-003 | unfinished count at a chain skip | skipping a step whose frame exists is a violation |

## A turret slot and the turret rows

| Actor | Reads | Does |
| --- | --- | --- |
| `Layout::NanoTask` | box centre, consumed slots, box growth (D-077, D-081, D-072) | the free slot touching the block nearest the block's centroid (`NextSlotConnected`), so the block of touching rows fills across from its middle; the forward cluster's group once the main block is full; `ExpTurretCentreOut` off = nearest a standing lab (D-069) |
| `Layout::Place` (D-082, D-083) | the box zones, the turret groups, served slots | packs every economy structure nearest a served turret slot (planned slots 256 elmos further) inside the block's halo; INV-014 at the pack |
| `Layout::CanPlace` (D-083) | a memo per def | answers the planner from a 2 s memo of the native probe |
| `Layout::PlanBox`, `PlanForwardBox`, `CheckForward` (D-081, D-082) | ground score of the block and its halo, `IsZoneAlly` | the main block of four touching rows (three at least, INV-012), a forward cluster in clear ground (INV-013), moved on when an ally takes it |
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
| `energy.convert.float` (before the chain, D-079, D-084) | `TechChain::EnergyFloats`, `DearOrderPending` | a converter whatever the chain is doing, unless a dear chain order has no frame yet |
| `chain.next` (income steps, D-080) | the plan's income target, `EnergyFloats`, mex upgrades, the advanced fusion | climbs the metal ladder after the objective: converters while floating, T2 mex upgrades, the next advanced fusion; INV-011 |
| `Tech_CombatGate` = `TechPlan::CombatGate` (D-080) | the plan | no mobile combat production under +200 (+500 for t3rush); INV-010 |
| `Tech_FactoryAiMakeTask` (T2 air plant, D-080) | `TechPlan::AirConstructorsWanted` | T2 construction aircraft from +200 metal, one per 40 of income, at most 12 |
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

## A tactical lane survey (D-131)

| Actor | Reads | Does |
| --- | --- | --- |
| Native `CBattleAnalysis::RequestLanes` / `AnalyseLanes` | cached terrain, this AI's observed threats, starts and script settings | captures an owned request on main; admits one job; synchronous reference and worker use the same solver |
| `lane::Solver` / scheduler background job | immutable terrain and owned request only | searches routes off-thread; no engine wrappers, AI state, script calls or logging; cancelled work exits cooperatively |
| Native completion / `lane::JobGate` | weak owner, generation, complete result | publishes only a current result on main; retains old lanes during work/failure; shutdown cannot dereference a freed AI |
| Profile threat settings and native enemy damage | weapon capabilities and JSON domain/default multipliers | weight threat for both tactical routes and ordinary AI; D-131 restores AA-role air/default weights; INV-064 checks flak and KI-424 records remaining surface/water zeros |
| `CSetupManager::ParseScriptStarts` | participating TEAM/AI/PLAYER direct fields, ignoring nested AI options | caches actual playing starts; lane policy checks nonempty enemy destinations (INV-063) |
| `Lanes::Compute` / `Poll` / `Finish` | job state, published revision, JSON settings | requests, then validates a completed survey; checks INV-062/070; advances attack revision once and publishes teaching metadata on main |
| Native mountain/descent search / `Lanes::BuildLessons` (D-132/D-133) | ordinary-class smooth approach, reachable peak band, all-terrain traverse/descent, JSON bounds | preserves high-ground traverse before destination-side descent; rejects loops and excessive detours; script assigns lesson 5 and checks INV-065 |
| Native paired cliff search / widget cues (D-134) | reachable high passage, exclusive cliff grades at both ends, profile threat, detour budget | ranks steepness before cost; verifies a non-looping joined route; publishes both gates and quality, INV-066; widget only renders |
| Native mountain shelf search (D-135) | mean engine surface slope, reachable peak band, endpoint progress bands, script weights | penalizes lateral cliff-face traversal; tries a two-ended shelf fallback; widget only renders and the test independently checks Legion build sites |
| `Lanes::RequestOverlay` and command handler | survey age, refresh request, minimum refresh interval | requests an eligible calculation and publishes the current survey |
| Control widget | published geometry/metadata, local filter/focus/freeze preferences | renders, selects and hides; never calculates battle routes or issues combat orders |
| `Lanes::BestLane`, `Waypoints` | native lane cache | exposes ranked routes and waypoints to future attack consumers; current attack code is not rewired |

### Mountain qualification (D-145)

| Actor | Reads | Action |
| --- | --- | --- |
| `lane::Solver` candidate filter | owned terrain, endpoints, script-configured rise/span | removes all-terrain candidates without progress on one connected elevated component |
| `Lanes::Finish` | native `IsLaneSpecialist` | verifies INV-071 and reports specialist count |
| `TechFlank::Select` / `Work` | published qualification, native land connector | admits only qualified reachable mountain routes for a dedicated lab |
| `TechFlank::Produce` | successful current selection, survey revision | waits after failed requalification rather than resuming an old route on the next ask |

## AIR first fusion and owned mexes (D-148)

| Actor | Reads | Action |
| --- | --- | --- |
| `AirEconomy::MexesReady` | fresh owned IDs, loaded extraction rates, frame progress, queued MEX/MEXUP | Blocks reactor admission until all owned mexes are advanced and complete; includes far/gifted variants |
| `mex.upgrade`, `mex.assist` | live mex ownership, per-spot claim, capability/reach, energy health | Upgrade distinct owned spots and assist unfinished extractors before reactor work |
| `fusion.first` | target/preparation time, full mex completion, funding | Admit first ordinary fusion without any deadline exemption from mex priority |
| `fusion.access`, `fusion.prepare.assist` | existing advanced constructor, funded T2 access, owned projects | Buy a constructor path when needed; lend construction power to committed work |
| `mex.expand` | completed reactor, preparation phase, six-mex early bound | Stop creating an ever-growing pre-fusion upgrade backlog; count gifts independently |
| `AirBuild::Energy`, `Resume`, `Tick`, `Record` | reactor identity, live mex gate, frame ownership | Apply the gate to every reactor path, cancel invalid unstarted orders, retain already framed construction, check INV-077 |
| `AirProduction` | preparation phase, defensive quotas, transports | Reserve optional aircraft spending for the first reactor while retaining transport priority and interception |
| AIR playtest observer | engine UnitCreated, owned mex extraction/progress | Independently reject a reactor frame before all owned mex upgrades complete |

## AIR clustered wind and construction power (D-149)

D-150 adds `AirBuild::Commander` before general economy rules once a factory
exists. It reads live completed aircraft counts and factory retirement; the
recruiter separately reads projected counts. `AirLayout::WindPass` prefers the
commander's actual reach. D-151 permits a bounded economy move after crew
completion when `PlantHasWork` finds no live recruitment; queued recruitment
still counts during its cold start. `Commander` assists the nearest unfinished
reachable structure, or builds nearby energy, instead of following aircraft or
renewing an idle factory guard (INV-081). `AirProduction` queues the initial
fighter floor immediately after the crew, excluding the scouting drone and
crediting other defenders, before ordinary income gates (INV-082).
`AirScreen` resolves roster TECH starts, participating enemy starts,
live fighter IDs and retained route tasks; `AirProduction::HomeTask` excludes
held/launched escorts and the opening scout. Death and role exit remove route
ownership. Native `CRouteTask` reads its opt-in patrol flag; TECH never enables it.

| Actor | Reads | Action |
| --- | --- | --- |
| `AirLayout::PlaceWind` / `SaveWind` / `Init` | loaded footprint, six native slots, map/ally/reach checks, group gap | Reserve all six or roll back; fill and replace slots; adopt named metadata |
| `AirBuild::Record` | construction kind, planned build position or served reservation | Check INV-078 before accepting a wind construction task; repair does not own a slot |
| `AirEconomy::ConstructionTarget`, `ConstructorTarget`, `NanoTarget` | income, floating metal, loaded work, separate mobile/static capacity | Set bounded workforce quotas and bay support targets |
| `AirProduction::MakeTask` | pending recruits, frames, funding, immediate screen, ferry prehook | Grow funded mobile work before the full fighter quota; never count a nano as mobile work |
| `support.assist`, `production.support` | unfinished nano and native support slot states | Finish support and grow it before general project assistance |
| `AirBuild::FindAssistTarget` / factory nano policy | owned projects, physical reach, factory recruit target | Share one target selector; idle production nanos assist reachable construction; AIR tick ends that assistance when production resumes |
| AIR observer | engine positions, dimensions, completions and deaths | Verify packing and replacement; measure completed mobile work and turret counts |

## D-152 expansion, fortification and mex anchors

| Object | Actors | Shared state |
| --- | --- | --- |
| AIR T2 plant | Factory, Transition, Tick, Resume, Record | Fresh MexesReady; unstarted orders cancelled, frames completed |
| AIR converter | Convert, Commander, AirRules | Completed/framed/queued capacity and surplus energy |
| AIR future bays | PlanAhead, Reserve, Factory, Nano | Persistent bay slots; only factoryId >= 0 contributes demand |
| TECH future cluster | PlanAhead, OpenCluster, Work, OpenWork, CountTier, SpamClusters, invariants | ahead flag, native factory/turret/exit claims; activation alone grants spending |
| TECH fortification | `defence.fortify`, `defence.base`, Tick, Work | Site/Piece persistent claims, budget, outstanding tasks, owned asset |
| Weapon cluster | SortSlots, Site, Order | Walls first; exact reservation and pin respects expansion |
| First mex | Roster ObserveMex/Encode/Decode/Update, ferry TryCarry | Latched anchor, authenticated allied team, native saved integers |
| Cargo drop | TryCarry, _StartNext, CFerryTask | Safe drop search, threat limits, refused sites, queued/airborne ownership; bounded wait for arriving carrier |

## D-153: shared allied plans and activation

| Object | Actors | Authoritative state |
| --- | --- | --- |
| Allied reserved ground | Native reserve/zone admission, packing, normal placement, exact slot serving, mex/geo execution | CAllyTeam spatial registry, owner/kind/local ID; reconstructed after load, removed on release/reset/destruction |
| AIR unused bay/wind cluster | PlanAhead, Reserve, Activate, WindPass, Factory | Native slot claim/frame state plus persisted started flag; all members checked before activation; envelope belongs to that bay |
| TECH future factory cluster | PlanAhead, ReadyCluster, OpenCluster, Work | ahead/aheadKey plus native lab/group states; two future plans per tier; only authorized activation starts spending |
| TECH forward economy cluster | CheckForward, ReserveFactorySite, Place, turret placement | Native zone activation state; persisted fwd_started locks it after any member is claimed |
| AIR T2 plant | Transition, BankedLab, Factory, production.banked, Record | Ten-second minimum income/full window or current full-cost metal bank; cap and one unfinished plant; INV-083 |
| AIR T1 strike mix | AirProduction::MakeTask, Recruit, native combat assignment | Queued-aware counts, persisted mix phase, fighter floor, constructor funding, faction build capability; ferry request hook remains first |
| Placed building audit | LayoutHelpers::CheckAlliedPlacements | Exact task reservation position/facing and shared foreign footprints, INV-088 |

## Allied start areas and walls (D-154)

| Actor | Reads or changes | Guard |
| --- | --- | --- |
| WallHelpers | Own start, allied roster and playing-team start-script coordinates; shared configured radius | Cached union of known allied bases; footprint/circle geometry |
| TechFortifications::Add / Work | Persistent wall positions and actual snapped footprint | Shared wall admission before reservation and construction |
| TechFortifications::Lane / Protect | Forward direction, base circles, asset position | Forward lane lines; no rear-base asset rings |
| TechFortifications::Tick | Late start announcements, reservation state and task target | Release invalid unstarted wall claims; preserve existing frames |
| TechWeapons::Site / Order | Weapon-cluster wall slots and snapped positions | Same wall admission; other weapon roles keep existing rules |
| AirRules::MakeTask | Queued native defense services | AdmitQueued rejects walls in a base before accepting service |
| LayoutHelpers::CheckAlliedPlacements | Assigned AIR/TECH construction tasks | INV-089 audits wall footprints once per second |

## AIR support before expansion (D-155)

### AIR strike ownership and allocation (D-162)

| Object | Actors | Authoritative state |
| --- | --- | --- |
| Observed armed aircraft | BattleAnalysis, AirEconomy, AirScreen | Unique visible enemy IDs and weapon domains; exponentially fading observed-value memory, separate from generic role costs |
| Factory discretionary order | AirProduction, Ferry | Persisted per-plant interleave, pending/frame counts, actual defender value and emergency deficit; ferry hook retains first access |
| T2 bomber | AirWaves, AirProduction, native AirWaveTask | Exclusive held/release/active membership; separate immutable evaluation cohort; fixed staging routes; native flight/return state |
| T1 reusable bomber / light gunship | AirRaids, AirWaves::StagingTask, native AirWaveTask / RaidTask | Independent bomber held/joining/cohort sets; Legion Mosquitos explicitly use the existing threat-aware native RAID task |
| Strike target | AirWaveTask | Known hostile plus peaceful structure snapshots, loaded lethal pass estimate, health margin, sampled route exposure; no omniscient enemy reads |
| Aircraft state | AirScreen, staging routes, AirWaveTask, role leave | Explicit idle/fire settings owned by AIR, restored on departure; no static-weapon state writes |
| Completed construction | AIR native UnitFinished, AirProduction::Tick | Finish registered owner once; abort duplicate construction owners; preserve the completed structure and avoid repeating its build chain (INV-101) |


| Actor | Reads or changes | Guard |
| --- | --- | --- |
| AirEconomy::SupportBay / RefreshSupport | Fresh owned factory/turret IDs, retirement, completion, range | Each completed turret belongs to one nearest live bay; frames are separate future capacity |
| AirEconomy::ExistingT2SupportReady | All existing T2 plants, completed plants, minimum completed support | Every plant must finish and own twenty support turrets; newly gifted unadopted plants block expansion |
| AirBuild::Factory / Resume / Tick / Record | Fresh support gate on new/resumed/unstarted lab tasks | Banked metal cannot bypass INV-090; already framed work finishes |
| AirBuild::SupportCommitted / Nano | Native frames, unstarted owned tasks, exact slots, cost forecast | Count each support commitment once; bounded concurrency and reach |
| overflow.support / overflow.support.assist | Live floating bank, energy health, support target | Fund up to three support projects before converter growth, then assist |
| AirEconomy::ConstructionTarget / FundConstructor | Income, bank drawdown, energy, constructor cost | Grow funded mobile work during overflow without counting factory BP as economy construction |
| AIR observer | Engine UnitCreated and independent owned-unit range/completion scan | Audit twenty completed turrets per prior T2 lab at every new lab frame |


## D-156: local AIR economy and interception

| Object | Actors | Authoritative state |
| --- | --- | --- |
| AIR economic worker | ConstructorTarget, FundConstructor, Recruit, AirRules | Completed/projected crews, stable income, bank forecast, per-factory consecutive constructor count |
| Local economic project | Energy, AssignedPower, Assist, FindAssistTarget, Resume, Record, Tick | Native frame and live task targets; at most six energy commitments, useful remaining work, home geometry |
| New mex / distant owned mex | `mex.expand`, UpgradeMex, AssistMex, MexesReady | Fixed home expansion center; one remote owned upgrade task; all owned mexes still gate reactors |
| AIR static defense | Air_AiMakeDefence, AirDefence::MakeTask/Place, Planned, Added, Record, Tick | AIR-owned project, cross-faction count caps, native reservations, bounded base radius, actual coverage; no shared remote defense queue |
| AIR fighter | HomeTask, AirScreen::Tick/Intercept, AirWaves | Exclusive home/wave ledgers, fresh native observed aircraft, script territorial classification and cost allocation |
| Wind frame | WindPass, Record, native FinishReservation, observer | Native slot-to-unit identity after framing; independent observer disambiguates six possible grid origins |

## D-157: strategic targets

| Object | Actors | Authoritative state |
| --- | --- | --- |
| Juno target | SelectPulseTarget, SelectSuspectedJammer, SelectFogTarget, ExecuteAttack | Both known-enemy snapshots, configured sensor classes, current LOS, shared ally-team pending/recent-shot ledger |
| Nuclear target | SelectNuclearTarget, ExecuteAttack, script ground overrides | Known immobile structures; per-silo location history; friendly blast exclusion |
| Launch | WeaponFired, stockpile-drop fallback, OnLaunch | Confirmed launch frame and aim; deduplicated events; persistent attack command stopped after launch |
| Launcher lifecycle | RemoveAssignee, UnitDestroyed, allied friendly-unit refresh | Pending claims cancelled; fired Juno areas retained through flight; nuclear history retained across task recreation and cleared on destruction |

## D-158: amphibious operations

| Object | Actors | Authoritative state |
| --- | --- | --- |
| Telchine / Marauder wave | Military::AiMakeTask, AmphibiousOps::MilitaryTask/Tick/TaskRemoved/UnitRemoved/Reset | Stable owned IDs, exclusive route handle, surviving-member quorum, phase and quiet timer; load restarts assembly |
| Water crossing | AmphibiousOps::Plan/CheckCrossing, CBattleAnalysis::GetTerrainRoute, lane::Solver::PointRoute | Immutable terrain grid plus this AI's observed amphibious threat and weapon coverage; usable dry landings end a leg |
| Dry foothold | StrategicSites::LandAt, Objective, Staging, Tick | Connected dry component, current observed contacts, arrival quorum and uninterrupted secure interval |
| Compatible factory | Tech_FactoryAiMakeTask, AirProduction::MakeTask, AmphibiousOps::Produce | Existing constructor priorities, income gate, metal bank, actual build edge, owned plus pending bounded force |

## D-160 amphibious beachheads

| Object | Actors | Shared state and contract |
| --- | --- | --- |
| Telchine recruit | TECH factory, AIR auxiliary factory, AmphibiousOps::Produce | Existing constructor priority precedes admission. Economy sliding minima, bank reserve, energy buffer, pending count and team cooldown bound the optional budget. Marauders retain the caller gate. |
| Assault wave | MilitaryTask, Tick, native route task | Stable member IDs and one owning task; secure/regroup before crossing again. RetainGuard transfers only dry members and preserves the assault minimum. |
| Retained guard | RetainGuard, GuardTick, TaskRemoved, Reset | One GUARD route task, same dry component, hold-position. No amphibious route fallback. Lost assets or a winning allied claim release the group. |
| Beachhead claim | AmphibiousBeaches, Team::HandleMessage | Actual completed allied economy, advisory shared-sea geometry, expiring team/serial claims; no second movement owner. |
| Telchine firing slot | AmphibiousFormation::Form/Maintain, AmphibiousOps::Order/Arrived, CRouteTask | Stable member ID, validated dry connector and distinct endpoint. New group orders clear overrides; losses remove slots; arrival uses each assigned slot. Native code issues commands but chooses no formation. |

D-160 donation ownership: `Donation::OnConstructorBuilt` first preserves
dedicated air-constructor claims, then accepts only the same T2 bot roster
as `FactoryMakeTask`. Sea constructors cannot consume bot requests.
`ferry.cargo` precedes harbour work; INV-041 still checks every queued gift.
Native factory fallbacks in TECH/AIR temporarily exclude the two managed
amphibious definitions through `AmphibiousOps::DefaultFactoryTask`; the shared
producer alone admits them, and original caps are restored after the call.

## D-163 AIR growth and missions

| Object | Actors | Shared state and contract |
| --- | --- | --- |
| Production campus | AirLayout::Reserve/Activate/PlanAhead, AirBuild::Factory/Nano, AirEconomy::RefreshSupport | Persistent atomic factory/support slots; footprint lattice; one speculative bay beyond completed demand, at least six T2 and one T1; first-use blockage relocates. No TECH placement calls. |
| Economic growth phase | AirEconomy::UpdateMilestones, AirGrowth::MakeTask, EcoPlanner::Read/Decide | Saved ten-second 50M milestone; AIR-owned context and task execution. Default context remains TECH. Conversion admission is communicated to the chooser so rejected converters cannot starve reactors. |
| Bomber milestone and stock | AirEconomy::CompletedAfus/UpdateMilestones, AirProduction::Recruit/MakeTask, AirWaves::ProductionTarget | Two completed AFUS latch mass production. Transport/crew/emergency precede discretionary aircraft. Funded replacement stock is distinct from sortie size. INV-102. |
| Strike package | AirWaves::OpeningSize/_PlanWave/_Launch, AirRaids::Update, CAirWaveTask | Saved first draw; known target health, observed army and padded route risk with unknown reserve; no launch below selected requirement. Direct/edge commands, nominal synchronized static impact and latched return waypoints. INV-103. |
| Mobile fallback guards | AirRules::MakeTask, AirBuild::Record/Tick, native CBGuardTask | AIR uses non-interruptible five-second guards, which explicitly start the native expiry timer. Track actual task identity; a thirty-second lease violation logs INV-104. TECH guard policy is unchanged. |
| Failed support pin / factory cap | AirLayout::RepairSupport/UnlockCampus/Leave, AirEconomy::SupportBay | Replace dead support pins within actual reach and unique bay assignment; retain quarantine on failed ground. Lift only experimental AIR factory definition caps and restore original caps when leaving the role. |
| Failed raid / learned resistance | AirWaves::_EvaluateLastWave/_PlanWave, CAirWaveTask::ExcludeStrikeRegion | Immutable cohort evaluated after sortie termination; saved bounded resistance; up to eight script-owned temporary regions filtered by native targeting and independently checked by INV-105. Region memory resets on role reinitialization; learned resistance persists. |

## D-164 AIR economic workers and district

| Object | Actors | Shared state and contract |
| --- | --- | --- |
| Advanced aircraft constructor | AirRules::MakeTask, AirBuild::EconomyAircraft/ReturnEconomyWorkers/Record, native AssignTask | No new production guard. Reconcile existing builder guards by individual reassignment; no shared-task abort. Real construction/repair and player/ferry ownership remain valid. INV-106. |
| Advanced economy module | AirEcoLayout::Init/Save/Reserve/Activate/PlanAhead/Place/Leave, AirLayout::Reserve/Place/PlanAhead, native terrain layout | One persistent nine-slot module with enclosing zone and saved first-use state. Before first claim, a physical blocker relocates the entire module. Activated modules stay fixed; blocked pins are skipped. Shared native reservations exclude allied/local factories and defenses. INV-107. |
| Late surplus investment | AirGrowth::MakeTask, AirMath::OverflowGrowth, AirBuild::Committed, AirProduction | Shared chooser first, useful reactor assistance next, then a funded additional AFUS while metal floats after the bomber milestone. Deduct existing project costs, reserve the production income share and admit only one reactor. TECH policy unchanged. |
| Reactor commitment | AirBuild::ReactorPending/Record, AirMath::PendingReactor, AirGrowth::MakeTask, AirLayout::Place | Queued and unfinished owned reactor ENERGY tasks block new reactor starts. T1 energy, repairs and completed targets do not. AIR overrides the generic chooser context without changing TECH; INV-108. |


## D-170 continuous metal fields

| Object | Actors | Shared state and contract |
| --- | --- | --- |
| Map mode | EconomyManager::ReadConfig/InitMetalField, profile init fragments, TerrainManager::Init | BAR publication plus raw-field validation; normal mode takes the original path. |
| Extraction cells | MetalField::Grid/Claims, AllyTeam, GameAttribute, SyncFieldUnits | Game-owned raw grid; ally-owned maximum-depth occupancy from frames, units and owner-tagged tasks. |
| Field mex order | EnqueueFieldMex, BuilderManager::Enqueue, CBMexTask execute/cancel/finish/load | Exact build position, bounded admission, shared claim identity, no synthetic spot closure, frame promotion before claim release. |
| Field upgrade | EnqueueFieldUpgrade, CBMexUpTask, BAR replacement gadget | Actual owned target ID, exclusive upgrade lock, incremental depth, no nearest-neighbour reclaim after completion. |
| Converter order | Native enqueue/load, role cap updates, MetalEconomy::Read, metal_watch | Admission veto survives cap changes. Existing gifted units are preserved. INV-111. |
| Experimental field economy | MetalEconomy, AirRules, TechRules at mex.expand, shared Builder policy | Cached workload snapshot and funded resource decisions; exact TECH lab rows precede the economic adapter. |
| AIR constrained cluster | AirLayout::Reserve/Activate/PlanAhead, native layout engine | Full six-site search first, then atomic smaller metal-only clusters; actual allied reservations stay authoritative. |
| Legacy field economy | EconomyManager::UpdateMetalTasks, JSON metal_map settings | Separate configured native adapter; cached settings remain valid after SetupManager releases parsed JSON. |


| D-170 revised object | Actors | Shared state and contract |
| --- | --- | --- |
| Dense mex module | MetalLayout::Plan/Build/Release, TerrainManager::PlanMexCluster, BuilderTask::PinReservation, MexTask::Execute | Eight snapped slots plus envelope; atomic rollback; task blocker-to-slot handoff; first-use relocation; INV-112. |
| Opening workforce | MetalEconomy::Read/DedicatedTask/OpeningWorker, AirTask, TechRules at power.t1 and Trace | Saved first three T1 constructor IDs, death replacement, forty-mex and power assignments, initial third-constructor TECH transition after lab reclaim precedence; INV-113 prevents discretionary front/defense diversion. |
| AIR initial screen | MetalEconomy::AirScreenReady, AirEconomy::Transition, AirProduction | Completed fighter count reaches configured HomeFighterFloor; saved latch permits first T2 immediately. Existing twenty-nano gate remains for later labs. |

## D-171 AIR committed operations

`AirRules::transition.storage` lets a full pre-T2 metal bank expand to the
loaded lab cost, after mex upgrades and before optional spending. It changes
storage capacity only; factory income/banked-cost admission remains authoritative.

| Object | Actors | Shared state and contract |
| --- | --- | --- |
| Fighter group | AirScreen, AirOperations, AirProduction, CRouteTask | One live shared wall task or one committed wave per fighter; direct member transfers, persistent final commands; INV-115. |
| Bomber operation | AirRaids, AirWaves, AirOperations, CAirWaveTask | Immutable bomber membership, cohort formation and travel, prioritized targets, no offensive return; INV-116. Defensive T3 whitelist comes from loaded gantry build edges. |
| Radar cohort | AirRecon, AirProduction, CRouteTask | One designated completed T2 factory, friendly wall until twenty aircraft, synchronized persistent enemy sweep, next production cycle ten minutes after dispatch. |
| Opening lab | AirBuild::NearbyStarter/RetireStarter/Factory, AirLayout::PlanAhead, AirProduction, Lifecycle | Starter claimed near the lone commander before speculative campuses; shared retirement state stops production; planned T1 rebuild follows completed advanced construction capability. TECH rows unchanged. |
| Production readiness | AirEconomy, AirMath::SustainedProduction, AirGrowth | Ten-second metal/energy minima gate bomber production; completed AFUS count remains a separate economic objective. INV-102 updated. |
| AIR campus search | AirLayout::Reserve/Activate/PlanAhead, AirBuild::Factory, AirMath::CampusSize | Six-site plans first; rotated one/three-site terrain fallbacks retain twenty turret pins per T2 bay and aggregate future capacity. Builder requests respect the failed-search cooldown. INV-084/109. |
| Normal opening mex count | AirRules::MakeTask, AirEconomy::MexCount, AirBuild::Record | Three owned extractors end the opening mex stage. Native maxSpots only bounds candidate search. Metal maps keep their separate forty-mex sequence. INV-117. |
| Legion replacement scout | AirProduction::Tick/HomeTask, AirScreen, MilitaryManager::TransferUnit | Transfer one drone to the scout route without aborting its shared wall cell. Other group members retain their tasks. |
| AIR engine-command handoff | AirBuild::Record/ReturnEconomyWorkers/CancelUnstarted/Tick, native task removal, opening/eco observers | Clear the old command once when relinquishing a factory guard or cancelling an unstarted building. Stop only actual assignees; retain PLAYER and reassigned workers, framed projects and TECH semantics. INV-077/081/106. |

## D-172 AIR workforce and first-lab access

| Object | Actors | Shared state and contract |
| --- | --- | --- |
| Mobile economy aircraft | AirRules fallback, AirBuild::EconomyAircraft/ReturnEconomyWorkers/Record, air_workforce_watch | Both tiers stay on concrete economy projects; release native guards individually and stop their engine command once. Preserve player/ferry ownership. INV-106. |
| Workforce recruitment | AirProduction::Recruit/MakeTask, AirEconomy::ConstructorTarget/FundConstructor, AirMath::WorkforceTurn | Projected constructor counts and bank-aware target; per-plant combat streak permits a funded missing constructor after two combat orders during an incursion. Initial screen and transports retain precedence. INV-119. |
| First advanced lab | AirRules::transition.bay/transition.save, AirEconomy::SavingForFirstLab/Transition, AirGrowth | First placement attempted before discretionary growth; low-income, energy-ready economies save capital after preparation time. Full loaded lab bank or sustained income still gates admission. Additional plants retain support/capacity rules. INV-120. |

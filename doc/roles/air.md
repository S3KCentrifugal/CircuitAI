# AIR Role

D-194 adds [safe waiting radar patrols and deterministic naval relief](../air-patrol-naval-support-plan.md).
`AirRecon::Patrols` gives waiting radar planes separate triangular patrols in
friendly space. It checks padded corridors every two seconds, keeps safe routes,
and reassigns only affected aircraft. Unknown AA remains unknown; a physical
weapon-envelope floor catches known AA with zero profile threat weight. Existing
full-cohort and 90-second fallback launches remain independent of replanning.

`AirNavalSupport` requests real T2 torpedo aircraft for nearby allied fleets or
naval factories in the same water body. Demand is
`ceil(1.25 * max(0, enemyMetal-friendlyMetal, submergedMetal-friendlyASWMetal) / aircraftCost)`.
Defaults: minimum deficit 300 metal, wave 2-60, sector radius 2400, friendly
support radius factor 1.25, assessment five seconds, partial release 90 seconds.
It checks open-water ingress and known air threat before recruiting/launching;
the timeout never overrides those checks. Available fighters escort through
the shared operation ledger. Defensive survivors return when the local gap
is resolved. Base emergencies, interception, transport and required workforce
retain precedence. Production base-defense eligibility is unchanged.
All tuning is in `Global::RoleSettings::Air`; see [played evidence and limits](../air-patrol-naval-support-results.md).

D-193 adds [timed reconnaissance and immediate allied-base defense](../air-recon-base-defense-plan.md).
`RadarMaxWaitSeconds=90` releases an incomplete/unassembled available cohort;
full cohorts retain their normal early launch and ten-minute recruitment cycle.
T1 scouts loop over enemy starts. `AirBaseResponse` observes current land
contacts inside `BaseResponseRadius=1800` of participating allied/human starts.
It dispatches free gunships and held bombers immediately, independently of
strike sizing, while preserving PLAYER/RETREAT/FERRY and live wave ownership.
T2 bombers retain the heavy-mobile/structure target filter. Fighters escort or
answer simultaneous aircraft through the existing interceptor controller.
`BaseResponseGunships=20` is a shared live/frame/order reserve target; Cortex T1
uses lethal bombers plus up to `BaseResponseEmpSupport=4` Shurikens. Transport
and workforce recovery retain priority. Optional raids pause during contact;
`BaseResponseSearchSeconds=20` bounds last-seen search. Normal task assignment
resumes after the incident. Shared stable-target tasks avoid repeated attack
orders for unchanged visible enemies; no command rate limiter is added.


D-181 replaces independent constructor income ratios with `AirWorkforce`'s
once-per-second own-resource and workload snapshot. A full/refilling bank may
fund growth despite an own-income deficit; future donations are never assumed.
Factory and economy turret ownership are disjoint. See the
[workforce review and implementation map](../reviews/2026-10-03-air-build-power-review.md).

D-179 adds [earlier opening support, compact factory rows and wide recon](../air-opening-recon-plan.md).
`OpeningNanoCount=2` and `OpeningNanoMinEnergy=160` fund early support after the
three-constructor opening and initial fighter screen. A missing reservation no
longer reduces demand to zero: repair finds replacement sites near the starter.
`T1OpeningBomberMin=1` / `T1OpeningBomberMax=10` draw one persistent opening
batch; `T1OpeningRaidEnabled` controls it. Legion uses Mosquito gunships.
Recovery, transports and immediate interceptions retain precedence.

| D-179 AIR setting | Default | Meaning |
| --- | --- | --- |
| `OpeningNanoCount` | 2 | Completed starter support goal, capped by `T1NanoLimit`. |
| `OpeningNanoMinEnergy` | 160 | Minimum sustained energy for early support, with funding checks. |
| `T1OpeningRaidEnabled` | true | Enable the separate first T1 raid batch. |
| `T1OpeningBomberMin` / `T1OpeningBomberMax` | 1 / 10 | Inclusive persistent random batch; Legion recruits Mosquito gunships. |
| `RadarSightOverlap` | 0.5 | Linear overlap of ground-sight diameters, reduced spacing if terrain bounds require it. |
| `RadarAssemblyRadius` | 480 | Required initial slot visit; holding envelope is twice this radius. |
| `RadarBacklineInset` | 256 | Inset of MOVE destinations from the enemy-side map edge. |

D-171 adds [committed air operations](../air-committed-operations-plan.md): shared fighter wall groups, all available fighters committed to each bomber sortie, persistent offensive attacks, strategic district targeting, a fighter/radar production owner, and income-based bomber readiness. The nearby startup lab is retired and later rebuilt in the campus. Native changes are opt-in; TECH retains its existing policy. Validation is recorded with the plan.

D-170 adds an explicitly detected metal-field economy through
`MetalEconomy::AirTask`. It replaces converter/finite-mex priorities only in
metal mode. The first T1 constructor builds toward forty dense mexes, the second
meets power demand, and the first T2 lab follows the completed initial fighter
screen. Later investments consider power and support capacity. It reserves
reactor modules without converters. Crowded metal platforms may use
smaller atomic factory compounds after the six-site search deadline. Normal
AIR retains the rules below. See [implementation and validation](../metal-maps-implementation.md).

D-167 changes factory planning to compact native compounds of six labs total:
one T1 plus five T2 in the first, then six T2 per additional compound, without a
default overall cap. Each T2 site has twenty dedicated construction-turret pins.
AIR now reclaims early energy using TECH's threshold calculation and prevents
wind/solar reconstruction while a completed AFUS stands. See the
[cluster and reclaim plan](../air-cluster-reclaim-plan.md) and
[measured results](../air-cluster-reclaim-results.md).

Reference for the `AIR` AngelScript role: aircraft plants, air constructors and
the wind-economy opening. How it is registered, what it installs at init, how its
build-focus system works, and where it is currently wrong.

## Current air combat controller (D-171)

`Air_MilitaryAiMakeTask` offers radar missions, the shared fighter wall,
`AirRaids::MakeTask`, then `AirWaves::MakeTask`. All uncommitted fighters join
wall cells, including surplus Legion interceptors. Contact identity changes
replace a group's mission; identical routes leave existing commands intact.

T1 bombers raid mex/wind targets. T2 bombers select AFUS, advanced converters
and factories, clearing valuable local targets before moving to another base.
D-173 extends the existing armed-structure fallback with other economy/support
buildings, approved heavy ground units, then remaining structures.
Both launch admission and surviving waves use this fallback. Setting
`StrikeCleanupMobile=true` adds all remaining surface mobile units as the last
tier; it defaults to false to retain the earlier T1 exclusion. See the
[cleanup repair plan](../air-bomber-cleanup-plan.md). A known nearby T3 whose
minimum payload exceeds the available bombers holds an unlaunched wave until
it has a viable defensive force; already committed offense is unaffected.
All available fighters transfer to each bomber operation and remain committed
until that offensive wave has no bombers. New fighters defend home. Offensive
operations never return; nearby T3 defensive sorties may return and repair.
Bomber HOLD_FIRE plus explicit target orders avoids deliberate T1 ground-unit
attacks. Collateral splash is still possible. Legion's T1 Mosquito uses native
RAID because it is a gunship, not an ordinary bomber.

D-176 hands the final straight approach to ATTACK before its formation MOVE
would reach the victim. During a committed offensive run, a locally LOS-visible
AFUS can interrupt travel, search, or a lower-priority attack. It remains the
target while visible, preventing repeated switches between adjacent reactors.
Team LOS plus the bomber cohort's local radius is required; distant allied
reconnaissance does not cancel an edge route. Defensive sorties keep their T3
target policy and receive only the earlier final approach. See the
[attack handoff plan](../air-afus-attack-handoff-plan.md).

The first T2 economy raid keeps its configurable saved 10-20 draw. Defensive
sorties and frontline assaults use separate payload budgets; an inaccessible
backline can therefore produce a larger frontline wave before the opening
economy raid. Subsequent raids use target health, route exposure, local AA,
enemy army and unknown-threat allowances. Intended total attrition no longer
penalizes future offensive missions as a failed return.

Two completed advanced factories designate one live factory for fighters and
20-plane radar cohorts every ten minutes. Radar aircraft assemble at distinct
friendly positions with `RadarSightOverlap=0.5` (linear overlap of sight
diameters). Map-fitting parallel ranks preserve width; an off-centre start does
not anchor the entire wall to a side edge. Each member must visit its slot and
remain nearby; fixed-wing orbit phases need not coincide. The shared task then
issues separate straight MOVE legs to the enemy backline, followed by nearby
base patrols. PLAYER aircraft do not consume the eligible production quota. Economy
and emergency constructor/transport recovery can preempt normal production.
Sustained metal and energy admit bombers independently of the two-AFUS growth
objective. See [design and validation](../air-committed-operations-plan.md).

Home demand is `clamp(6,60,ceil(1.2*armedAirValue/fighterCost))`; the old income
coefficient is unused. `BomberOrdersClear=6` and `BomberOrdersParity=3` allocate
strike turns per ten combat orders, after utility and emergency work.
`StrikeFirstSize=8` is the later raid minimum and `StrikeWaveCap=80` bounds one
dispatch. `StrikeAssemblyRadius=600`, `StrikeAssemblyFraction=0.8`, and
`StrikeJoinSeconds=20` control assembly. Specialists (EMP/Liche) retain their
existing tasks. Escort lead is positional, not an engine speed lock. See the
[review](../air-enhancement-review.md) and [wave reference](../air-wave-attacks.md).

## Current building controller (D-147)

`Global::RoleSettings::Air::ExperimentalBuild = true` selects the independent
[AIR management controller](../air-management.md). `LayoutPlanHandler` delegates
to `AirLayout::Init`; `Air_BuilderAiMakeTask` and `Air_FactoryAiMakeTask`
dispatch to `AirRules::MakeTask` and `AirProduction::MakeTask`. Those total
dispatchers own building/production decisions while enabled. The build-focus,
commander wind and legacy factory flows described below remain the fallback
when the feature is disabled; they are not a second concurrent planner.

`Air_MainUpdate` reconciles task ownership, samples the economy, maintains
military assignments and draws the layout before the existing quota and wave
updates. The shared builder hook calls `AirBuild::Added` only for experimental
AIR; the registered `Air_BuilderAiTaskAdded` remains a legacy log hook.
`Air_BuilderAiTaskRemoved`
removes project handles. `Air_SelectFactoryHandler` returns `none` after its
initial selection and `Air_AiIsSwitchTime` returns false under this controller,
so native switching cannot add competing plants.

`Air_MilitaryAiMakeTask` assigns a home interceptor before calling the existing
wave handler. Unit removal clears both ledgers. T1 fighters join the patrol
screen; T2 fighters also stay on the wall until committed to an operation.
Armada/Cortex scouts keep native scouting. Legion's first fighter/scout drone
receives an explicit scouting route. Ferry requests run ahead of the role's factory handler.
Role switching releases AIR projects/holds and reservations before the next
role initializes. D-153 shares native reservation geometry and increases TECH's
speculative plan count; TECH retains its own spending sequence and economy.

D-151 admits the initial fighter floor immediately after the three completed
constructors, without the ordinary 160-energy-income gate. Production remains
one aircraft per decision, transport requests remain first, and energy recovery
construction has higher priority. The commander leaves an idle factory for
nearby economy construction/assistance. After the opening crew, D-163 requires
an actual unfinished aircraft frame for useful recruitment assistance.
See [handoff validation](../air-idle-factory.md).

| New AIR setting | Default | Meaning |
| --- | --- | --- |
| `ExperimentalBuild` | true | Enable this controller in experimental profiles |
| `CommanderEconomyRadius` | 900 | Maximum nearby economy search when the crew is complete and the factory is idle; try current reach first |
| `MaxProductionBays` | 0 | No default numerical T2 ceiling; positive values explicitly cap construction |
| `PlannedT2Bays` / `PlannedT1Bays` | 6 / 1 | Minimum speculative footprint/support blocks; extend beyond completed demand |
| `BaySpacing` / `BayExitClearance` | 16 / 64 | Additional footprint-lattice clearance and protected exit space |
| `TechEconomyMinMetal` / `MassBomberAfusCount` | 50 / 2 | Sustained ten-second income switches the shared chooser on; completed AFUS unlock mass bombers |
| `FirstBomberWaveMin` / `FirstBomberWaveMax` | 10 / 20 | Inclusive saved opening T2 draw |
| `MassBomberOrdersClear` / `MassBomberOrdersParity` | 8 / 5 | Post-milestone bomber orders per ten discretionary combat orders |
| `StrikeReserveSeconds` / `StrikeUnknownReserve` | 120 / 0.25 | Funded replacement stock horizon and base uncertainty allowance |
| `StrikeCleanupMobile` | false | Opt into all remaining surface mobile targets as the last offensive cleanup tier; default retains the T1-ground exclusion |
| `StrikeEarlyAttack` | true | Replace the last target-centre travel MOVE with persistent ATTACK before arrival |
| `StrikeImmediatePriority` / `StrikeImmediateRadius` | 4 / 1800 | During committed offense, interrupt for a stationary target at this priority or higher, currently in team LOS and within this many elmos of the bomber centre; priority 0 disables interruption |
| `StrikeRiskScale` / `StrikeArmyReserve` / `StrikeLocalAaReserve` | 0.002 / 0.15 / 0.5 | Route proxy, observed army and local AA resistance coefficients |
| `StrikeCorridorPadding` / `StrikeEdgeInset` / `StrikeSynchronize` | 320 / 480 / true | Padded route samples, edge candidates and nominal cohort static synchronization |
| `StrikeLossGrowth` / `StrikeRiskRecovery` / `StrikeLearnedRiskMax` | 1.5 / 0.9 / 3 | Learned resistance increases after heavy losses and decays after strong survival |
| `StrikeFailedSurvival` / `StrikeFailedRetrySeconds` / `StrikeFailedRegionRadius` | 0.25 / 300 / 640 | Failed-region admission, lifetime and target-exclusion radius |
| `T1NanoLimit` / `T2NanoSoftLimit` | 5 / 20 | Ordinary support limits per plant |
| `T2ExpansionSupport` / `NanoParallel` | 20 / 3 | Completed turrets required on every existing T2 lab before expansion; funded simultaneous turret projects while metal floats |
| `MaxT1EconomyBuilders` / `MaxT2EconomyBuilders` | 40 / 24 | Funded mobile construction ceilings; T1 remains available after T2 |
| `EconomyBuildPowerPerMetal` / `BuildPowerFloatFactor` | 24 / 1.5 | Income-based work target, raised when metal storage is at least 75% full (minimum 300 metal) |
| `BuildPowerBankDrainSeconds` | 60 | Construction target includes drawing floating metal down toward half storage over this horizon |
| `WindClusterGap` | 144 | Minimum gap between wind-cluster bounding circles; six touching footprints per 3-by-2 group |
| `EconomySearchRings` | 24 | Ordinary 96-elmo search rings; reactor search additionally covers the whole home disc with increasing angular samples |
| `FirstFusionTargetSeconds` / `FirstFusionLeadSeconds` | 1200 / 720 | Aim for fusion at 20 minutes; prepare from minute 8; mex completion always wins |
| `PreFusionMexLimit` | 6 | Bound own early expansion before first reactor; gifts still require upgrades |
| `FusionAccessMinMetal` / `FusionAccessMinEnergy` / `FusionAccessFundSeconds` | 12 / 450 / 300 | Historical settings retained; D-153 no longer uses this separate access gate |
| `WarmFactoryGapSeconds` | 0.5 | Configured prior, separate from cold startup |
| `ProductionIncomeShare` | 0.65 | Resource share used to size support |
| `TransitionMinMetal` | 50 | Minimum over a complete fresh ten-second window; full lab metal cost banked bypasses income |
| `TransitionMinEnergy` / `TransitionEarliestSeconds` / `TransitionFundSeconds` | 1200 / 480 / 100 | Historical settings retained; unused by the D-153 lab gate |
| `T1BomberMetalStep` / `T1BomberCap` | 8 / 12 | Income-scaled replenishing T1 bomber target |
| `T1SupportMetalStep` / `T1SupportCap` | 4 / 16 | Cortex Shuriken target; other factions keep three support gunships |
| `HomeFighterFloor` / `HomeFighterCeiling` / `HomeFightersPerMetal` | 6 / 60 / 0.5 | Armed-threat target; income coefficient retained but unused |
| `OpeningAirConstructors` | 3 | Completed T1 constructors before commander release and initial fighter production |
| `ScreenFullFighters` / `ScreenCells` | 40 / 8 | Fleet size for full advance, maximum patrol segments |
| `ScreenRearWidth` / `ScreenFrontWidth` | 600 / 6000 | Width grows with live screen fighters; endpoints stay inside map |
| `ScreenRearAdvance` / `ScreenFrontSetback` | 400 / 600 | Rear offset and setback from the midpoint toward nearest participating enemy start |
| `ScreenUpdateSeconds` | 10 | Refresh geometry; membership changes also refresh immediately |
| `BaySpacing` / `CapacityStableSeconds` | 560 / 20 | Factory separation and sustained-capacity gate |
| `BaySearchRings` | 25 | Bounded factory search in 128-elmo steps, including unused-bay relocation |
| `TelemetrySeconds` | 10 | Economy and per-bay reporting interval |
| `WaveAvoidHomeFocus` | true | Use an enemy start when the wave front is absent or near home |

See [ordered rules](air_rules.md), [building actions](air_build.md),
[commander opening and fighter screen](../air-opening-and-screen.md),
[simulation evidence](../benchmarks/air-management.md) and
[original feature trace](../air-layout-and-priority-plan.md).

Source: `data/script/src/roles/air.as` (1270 lines), namespace `RoleAir`.
Line references are as of branch `smrt`, 2026-09-17. Prefer function names over
line numbers when navigating.

## Contents

- [Intent](#intent)
- [Registration](#registration)
- [Settings](#settings)
- [Init: what AIR installs](#init-what-air-installs)
- [The build-focus system](#the-build-focus-system)
- [Mex upgrade priority](#mex-upgrade-priority)
- [Decision flows](#decision-flows)
- [T2 bomber waves](#t2-bomber-waves)
- [Commander wind opening](#commander-wind-opening)
- [Known defects](#known-defects)
- [Transport ferry](#transport-ferry)
- [Late-game expansion](#late-game-expansion)
- [Porc: air denial first](#porc-air-denial-first)
- [Related](#related)

## Intent

D-142: Legion's T2 land-defense allowance uses `legacluster`, not the T1
`legcluster`. All factions' T1 static artillery has a configuration construction
veto, independent of this role's temporary unit caps.

AIR commits to aircraft plants as the army source. It suppresses ground
production entirely at start, opens on wind energy where the map rewards it,
races a small number of air constructors, and funnels early build power into one
focused construction lane before releasing builders to general work.

It is the only role whose start limits zero out *both* land factory lines and all
T1 land defences - AIR does not intend to fight on the ground.

## Registration

`RoleAir::Register()` fills **20 of 26** slots: the common thirteen, factory
production, three military hooks, the porc chain, the layout hook and defense placement.

| Slot | Handler |
| --- | --- |
| `MainUpdateHandler` | `Air_MainUpdate` |
| `InitHandler` | `Air_Init` |
| `EconomyUpdateHandler` | `Air_EconomyUpdate` |
| `AiIsSwitchTimeHandler` | `Air_AiIsSwitchTime` |
| `AiIsSwitchAllowedHandler` | `Air_AiIsSwitchAllowed` |
| `MakeSwitchIntervalHandler` | `Air_MakeSwitchInterval` |
| `BuilderAiMakeTaskHandler` | `Air_BuilderAiMakeTask` |
| `BuilderAiTaskAddedHandler` | `Air_BuilderAiTaskAdded` |
| `BuilderAiTaskRemovedHandler` | `Air_BuilderAiTaskRemoved` |
| `BuilderAiUnitAdded` | `Air_BuilderAiUnitAdded` |
| `BuilderAiUnitRemoved` | `Air_BuilderAiUnitRemoved` |
| `FactoryAiMakeTaskHandler` | `Air_FactoryAiMakeTask` |
| `SelectFactoryHandler` | `Air_SelectFactoryHandler` |
| `RoleMatchHandler` | `Air_RoleMatch` |
| `MilitaryAiMakeTaskHandler` | `Air_MilitaryAiMakeTask` |
| `MilitaryAiUnitRemoved` | `Air_MilitaryAiUnitRemoved` |
| `MilitaryAiTaskRemovedHandler` | `Air_MilitaryAiTaskRemoved` |
| `PorcChainHandler` | `Air_PorcChain` |
| `LayoutPlanHandler` | `AirLayout::Init` |
| `AiMakeDefenceHandler` | `Air_AiMakeDefence` |

Not filled: both factory task hooks, both factory unit hooks,
`MilitaryAiUnitAdded`, `MilitaryAiTaskAddedHandler`.

## Settings

`Global::RoleSettings::Air` (`global.as:272`), 68 references.

**Posture**

| Setting | Value |
| --- | --- |
| `AllyRange` | 1600.0 |
| `MinAiSwitchTime` / `MaxAiSwitchTime` | 20 / 60 s |
| `MilitaryScoutCap` | 10 |
| `MilitaryAttackThreshold` | 1.0 |
| `MilitaryRaidMinPower` / `MilitaryRaidAvgPower` | 1.0 / 1.0 |

The raid and attack thresholds of 1.0 are the lowest in the role layer - AIR
attacks with almost anything it has.

**Constructor ramp** - staged on income rather than count alone:

| Stage | Metal | Energy |
| --- | --- | --- |
| 2nd T1 air constructor | 8.0 | 160.0 |
| 3rd T1 air constructor | 18.0 | 300.0 |
| 2nd T2 air constructor | 40.0 | 1200.0 |

with `MinT1AirConstructorCount` 3 and `MinT2AirConstructorCount` 2.

**Wind** - `GoodWindMinimumEnergy` 7.0, `CommanderWindTargetCount` 6,
`CommanderWindEnergyIncomeTarget` 300.0, `CommanderWindMinimumMetalCurrent` 80.0.

**Build focus** - `BuildFocusDeadlineSeconds` 6 min, `BuildFocusMetalIncome`
20.0, `BuildFocusEnergyIncome` 300.0, `BuildFocusAssistTimeoutSeconds` 15,
`BuildFocusIdleWaitSeconds` 5.

**Combat production** - `MinAirScoutCount` 1, `MinT1FighterCount` 2,
`T1CombatProductionMetalIncome` 12.0, `T1CombatProductionEnergyIncome` 250.0,
`T1StrikeOpenerSize` 3 (min 12.0 metal / 250.0 energy), `T2HeavyAirIncomeThreshold`
250.0, `T2HeavyAirTargetCount` 6, `T2HeavyAirBatchPerFactory` 2.

**T2 plant** - `RequiredMetalIncomeForT2AircraftPlant` 30.0,
`RequiredMetalCurrentForT2AircraftPlant` 50.0,
`RequiredEnergyIncomeForT2AircraftPlant` 1200.0, `MaxT2AircraftPlants` 1.

`UseDynamicFactoryProduction` is **false**.

**T2 bomber waves** (`BomberWave*`, see [T2 bomber waves](#t2-bomber-waves)):

| Setting | Value |
| --- | --- |
| `BomberWavesEnabled` | true |
| `BomberWaveFirstSize` / `BomberWaveMaxSize` | 20 / 300 |
| `BomberWaveFighterRatio` | 1.0 |
| `EscortMinEnemyAirCost` / `EscortFullEnemyAirCost` | 300.0 / 3000.0 |
| `BomberWaveLowSurvival` / `BomberWaveHighSurvival` | 0.4 / 0.8 |
| `BomberWaveGrowthOnHeavyLoss` / `Default` / `OnLightLoss` | 2.0 / 1.5 / 1.25 |
| `BomberWaveEvaluateSeconds` | 120 |
| `BomberWaveEnemyAAMetalFraction` | 0.5 |
| `BomberWaveMaxHoldSeconds` | 480 |
| `BomberWaveReleaseWindowSeconds` | 15 |
| `BomberWaveProductionMetalIncome` | 40.0 |

## Init: what AIR installs

`Air_Init`:

1. Clears all module state: `g_airStrategicFocusTask`,
   `g_airStrategicFocusLeaderId = -1`, `g_airBuildFocusReleased`,
   `g_airGunshipOpenerDone`, `g_airStrikeOpenerQueuedCount`,
   `g_airCommanderWindTask`.
2. `aiTerrainMgr.SetAllyZoneRange(1600.0)`.
3. Installs the four military quota values and logs them at level 3.
4. `Air_ApplyStartLimits()`, then `AirWaves::Init()` (wave roster and state).
5. `FactoryProduction::Initialize()` only if the flag is set - it is not, so the
   else-branch logs "using legacy factory selection".
6. `ObjectiveHelpers::LogAllObjectivesFromStart(AiRole::AIR, "AIR")`.

`Air_ApplyStartLimits` zeroes, by hardcoded name:

| Group | Units |
| --- | --- |
| Gantries | `armshltx`, `armshltxuw`, `corgant`, `corgantuw`, `leggant` |
| Vehicle plants | `armvp`, `corvp`, `legvp` |
| Bot labs | `armlab`, `corlab`, `leglab` |
| Nuke silos | `armsilo`, `corsilo`, `legsilo` |
| T1 land defences | all of `UnitHelpers::GetAllT1LandDefences()` |

Note the Legion gantry list is short one entry relative to Armada and Cortex -
`leggant` has no underwater counterpart listed.

## The build-focus system

AIR's distinguishing mechanism. Early build power is concentrated on one leader's
construction task instead of spreading across constructors.

| Function | Purpose |
| --- | --- |
| `Air_IsBuildFocusActive()` | true while before `BuildFocusDeadlineSeconds` and below the income gates, and `g_airBuildFocusReleased` is false |
| `Air_SetStrategicFocus(leader, task)` | records `g_airStrategicFocusTask` and `g_airStrategicFocusLeaderId` |
| `Air_HasTrackedTask(builder)` | whether this builder already holds the focus task |
| `Air_AssignFocusedFollower(builder)` | attaches a non-primary constructor to the focus lane |
| `Air_IsConstructionTask(task)` | filters what qualifies as focusable |

Focus releases when either the deadline passes or both
`BuildFocusMetalIncome` (20.0) and `BuildFocusEnergyIncome` (300.0) are met.

## Mex upgrade priority

Ahead of this role's energy ladder, `Builder_AiMakeTask` calls
`EconomyHelpers::EnqueueMexUpgradeIfFirst`. A metal extractor upgrade is the
best metal-per-metal available (roughly 1.9x a T2 converter once the
converter's 600 E/s is priced as advanced fusion) and metal spots are finite
while converters are not, so an upgrade outranks everything that merely
converts energy.

The gate answers only for constructors of tier 2 or above — a T1 builder
cannot place the advanced extractor and falls straight through — and it skips a
spot that is already being upgraded. Ownership and upgrade state come from
`Economy::MexTracker`, which is now fed role-independently from
`Builder::AiTaskAdded` / `AiTaskRemoved` rather than from TECH alone.

Settings: `Global::RoleSettings::MexUpgradeFirst`, `MexUpgradeRadius` (2500),
`MexUpgradeMaxConcurrent` (1). See `KI-213` in
[`../known-issues.md`](../known-issues.md).

## Decision flows

### Legacy builder (ExperimentalBuild disabled)

`Air_BuilderAiMakeTask(builder)`:

```text
null                               -> null
null circuitDef                    -> default task
commander                          -> Air_Commander_AiMakeTask(comm)
T1 air constructor (armca/corca/legca):
    is Builder::primaryT1AirConstructor    -> Air_T1Constructor_AiMakeTask
    is Builder::secondaryT1AirConstructor  -> default task, logged "AIR expansion"
    build focus active                     -> Air_AssignFocusedFollower
otherwise                          -> Builder::MakeDefaultTaskWithLog(id, "AIR")
```

`Air_GetAssignedT1Leader(builder)` returns the primary or secondary T1 air
constructor whose guard dictionary (`Builder::primaryT1AirConstructorGuards`,
`secondaryT1AirConstructorGuards`) contains the builder, or null; the focused
follower path uses it to decide whom to assist.

The T1 air constructor set is matched by **hardcoded name string comparison**
(`uname == "armca" || uname == "corca" || uname == "legca"`), not by a
`UnitHelpers` accessor.

### Legacy factory (ExperimentalBuild disabled)

`Air_FactoryAiMakeTask(u)` bails to `aiFactoryMgr.DefaultMakeTask(u)` unless the
factory is a T1 or T2 aircraft plant. For a T1 plant it uses the sliding-window
minimum metal income and prioritises in this order:

1. **First constructor** before anything else - economy control precedes the
   opening queue.
2. **One early scout** after that first constructor, gated on
   `ai.frame <= SCOUT_PRODUCTION_DEADLINE`, enqueued at `HIGH` priority so it
   is not starved.
3. **Combat aircraft** once `Air_IsEconomyHealthy()` and
   `Air_IsCombatProductionReady(metalIncome, energyIncome)` both pass.
4. **More constructors** up to the income-staged desired count.

`Air_TryT1StrikeOpener` queues `T1StrikeOpenerSize` (3) strike aircraft,
tracked by `g_airStrikeOpenerQueuedCount`; the strike type per side comes from
`GetT1StrikeAircraftNameForSide`.

For a T2 plant the order is: advanced constructors up to the income-staged
target, the bounded heavy-air package (Legion/Cortex), then
`AirWaves::MakeProductionTask` once `Air_IsCombatProductionReady` passes - it
queues one wave bomber or escort fighter per call until the hold reaches the
next wave's target - and only then dynamic production or the native default.

### Economy

`Air_EconomyUpdate()` is **empty**. Enabled AIR samples `AirEconomy` from the
main update and task entry points. Legacy economy shaping uses start limits
and the factory handler's income gates.

### Dynamic quotas

`Air_MainUpdate` calls `Air_UpdateDynamicMilitaryQuotas()`, which compares
`Air_GetArmyMetalCostEstimate()` - the sum of `costM x count` over
`GetAllT1AircraftCombatUnits()` and `GetAllT2AircraftCombatUnits()`, so **air
units only**, NaN-guarded - against `Military::GetEnemyAirCostPerPlayer() x
DynamicQuotaEnemyCostThresholdMultiplier`. Below the threshold the role is
"underpowered" and raises its air quotas. Unlike SEA, this deliberately ignores
the rest of the army.

### Military

`Air_MilitaryAiMakeTask(u)` asks `AirWaves::MakeTask(u)` first; it returns a
task only for T2 wave bombers and T2 fighters. Everything else, including all T1
bombers, seaplane bombers, torpedo bombers and the Harbinger minelayer, takes
`aiMilitaryMgr.DefaultMakeTask(u)`: a bomber becomes a native `CBombTask` the
moment it is built and attacks on its own, which is the intended early-game
trickle. `Air_MilitaryAiUnitRemoved` and `Air_MilitaryAiTaskRemoved` forward
deaths and task removals to the wave bookkeeping.

## T2 bomber waves

Implemented in `data/script/src/manager/air_waves.as` (namespace `AirWaves`);
the file header documents the native primitives and the reasoning. Strategy by
tier:

| Tier | Units | Strategy |
| --- | --- | --- |
| T1 | Stormbringer, Whirlwind, Legion Martyr (suicide drone, role `mine`) | native default: each bomber attacks as it is built |
| Seaplane | Tsunami, Dam Buster, Pyrphoros | native default |
| T2 strategic | `UnitHelpers::GetAllT2WaveBombers()`: Blizzard, Stiletto (EMP), Liche (nuclear), Hailstorm, Phoenix (heat ray) | held at base, released in escorted waves |
| T2 specialist | torpedo bombers Cormorant, Angler, Aesacus; Harbinger minelayer | native default (not strategic bombing) |
| T3 | none exist: gantries build no aircraft and the experimental aircraft plants are unreachable | roster is a list in `UnitHelpers`, add the id when BAR adds one |

Escorts are `UnitHelpers::GetAllT2Fighters()` (Highwind, Nighthawk, Venator,
Ajax); the T2 plant produces `GetT2FighterForSide` for waves.

**Hold.** A wave bomber or fighter asking for a task gets
`TaskF::Defend(check = MELEE, promote = BOMB | AA, power = 1e9)`. The native
`CDefendTask` parks it near the base position and engages only enemies inside
our defence influence. It would promote when its power reached the threshold or
when a task of type `check` existed; `MELEE` tasks are never created and the
threshold is unreachable, so the hold never promotes by itself. `promote` is not
`ATTACK` because `CMilitaryManager::UpdateDefenceTasks` rewrites the threshold of
ATTACK-promoting defend tasks every 5 s. Held ids live in `heldBombers` and
`heldFighters`.

**Launch** (`AirWaves::Update`, from `Air_MainUpdate`): when the hold has
`Required()` bombers and `FightersFor(Required())` fighters, or when
the full `Required()` bomber target has been held for `BomberWaveMaxHoldSeconds`
(escort requirement waived, bomber target still required). `Required()` is the survival-grown
`nextWaveSize` raised to the **income floor**: `BomberWaveSizePerIncomeStep`
(50) bombers per `BomberWaveIncomeStep` (100) of sliding-minimum metal income
- 50 at +100, 100 at +200 - see
[`../air-wave-attacks.md`](../air-wave-attacks.md#wave-size) (D-045). Every distinct hold task is aborted once; its units
fall back to the native idle task and re-enter `Military::AiMakeTask` within a
few seconds, where the launch queue hands out wave tasks for
`BomberWaveReleaseWindowSeconds`. Latecomers rejoin the hold.

**Wave tasks.** Every launched bomber is handed one native `CAirWaveTask`
(`TaskF::Wave()`) carrying the plan `AirWaves::_PlanWave` drew for the wave:
one of six attack methods - CARPET, FLANK, PINCER, STRIKE, DEEP, FEINT - a
line abreast at a stand-off, an attack vector, and parallel attack-move lanes
through the aim or a dive on a chosen high-value unit. When the run is over
the task aborts itself and each survivor gets the plain bomb task once
(`mopUp`) before rejoining the hold. All of it is
[`../air-wave-attacks.md`](../air-wave-attacks.md). What follows describes
that plain bomb task, which is also the fallback when no wave task could be
made. One `TaskF::Common(BOMB)` per bomber def. Native
`CBombTask::CanAssignTo` used to require an identical def, which made a mixed
Blizzard/Stiletto/Liche wave fly as parallel bomb groups each picking its own
target; with the `bomber` config block's `group_mixed_defs` (default true) any
bomber may join the leader's task, so a mixed wave forms one group and one
line. Target selection stays native and now ranks by value per HP with a
group kill-feasibility filter, two bombing modes and a line formation - see
`doc/bomber-targeting.md`, "What was implemented". Fighters get
`TaskF::Guard(vip)` on the wave's living bombers, round-robin, so they fly with
the wave; an escort whose bomber dies re-attaches to another living wave bomber.

**End.** There is no explicit end. `CBombTask` keeps bombing while it has
targets; survivors that come back idle rejoin the hold. Survival is measured
`BomberWaveEvaluateSeconds` after launch from the wave ids still alive.

**Sizing** (`AirWaves::ComputeNextWaveSize`, a pure function):

```text
growth  = survival < LowSurvival  ? GrowthOnHeavyLoss   (2.0)
        : survival > HighSurvival ? GrowthOnLightLoss   (1.25)
        :                           GrowthDefault       (1.5)
next    = round(previousWave * growth)
aaFloor = round(enemyAntiAirMetal * EnemyAAMetalFraction / waveBomberMetalCost)
result  = clamp(max(next, aaFloor), FirstSize, MaxSize)
```

With the defaults a wave that keeps 80% of its bombers grows 20, 25, 31, 39...;
one that loses more than 60% doubles: 20, 40, 80, 160, 300. The enemy anti-air
metal comes from `Military::GetCachedRoleCost("anti_air")`. Until the survival
ratio is known the next target is the previous size times `GrowthDefault`.

**Production.** `AirWaves::MakeProductionTask` queues, per call, an escort
fighter when fighters lag the held bombers, else a bomber while the hold is below
target, else a fighter while escorts are below target. Gated by
`BomberWaveProductionMetalIncome`.

**Escorts scale with enemy air.** `FightersFor` previously returned
`bombers x ratio` unconditionally. AA ranks bombers 0.1 against fighters 2
(`unit_aa_targeting_priority.lua`), so an escort never screens the run - it
only fights enemy aircraft. The ratio now scales from zero below
`EscortMinEnemyAirCost` to the full ratio at `EscortFullEnemyAirCost`, read
from the cached enemy `air` + `bomber` cost, so a wave is not delayed for
escorts against a purely ground defence.

**Limits.** The script cannot aim a wave (only `CSuperTask` exposes a target
position) and cannot read enemy groups, so targets, modes and formation are all
native; sizing uses aggregate enemy anti-air cost, which only began returning
real values once the role-mask cache was built unconditionally. A native `CFGuardTask` engages any enemy near its
vip; the C++ change in `GuardTask.cpp` restricts that to enemies the guards can
actually hit, so escort fighters no longer dive on ground units and leave the
bombers.

## Commander wind opening

`Air_ShouldPreferWind(side)` compares the map's wind against
`GoodWindMinimumEnergy` (7.0) and the side's wind generator, resolved by
`Air_GetWindNameForSide(side)`. When wind is favourable,
`Air_HasCommanderWindOpportunity(side)` and `Air_TryCommanderWind(commander)`
put the commander on wind generators up to `CommanderWindTargetCount` (6) or
until `CommanderWindEnergyIncomeTarget` (300.0) is reached, provided
`CommanderWindMinimumMetalCurrent` (80.0) is available. State is held in
`g_airCommanderWindTask`.

## Known defects

1. **`Air_EconomyUpdate` is empty but registered.** A delegate call per economy
   tick that does nothing. Either implement it or drop the registration.

2. **`Air::NukeLimit = 0` is never read.** Nuke suppression comes from the
   `armsilo`/`corsilo`/`legsilo` start limits instead.

3. **T1 air constructors are matched by hardcoded name.** `armca`, `corca`,
   `legca` inline in `Air_BuilderAiMakeTask`. A fourth faction, or a renamed
   def, silently falls through to the default task.

4. **Start limits hardcode faction names and are asymmetric.** The gantry group
   lists underwater variants for Armada and Cortex (`armshltxuw`, `corgantuw`)
   but not Legion. Only the T1 land defence group uses a `UnitHelpers`
   accessor.

5. **`SCOUT_PRODUCTION_DEADLINE` is a compile-time constant, not a setting.**
   Unlike almost every other AIR threshold, it cannot be tuned per profile.

6. **`Air_MainUpdate` gates on `AIR_DYNAMIC_QUOTA_DELAY_FRAMES`, a constant**,
   where SEA gates the equivalent path on a setting. See
   [README cross-role finding 7](README.md#cross-role-findings).

7. **`Air_SelectFactoryHandler` is a verbatim copy** of FRONT's and SEA's apart
   from its log prefix, and ignores `isReset`.

## Transport ferry

AIR builds air transports for teammates that ask. On receiving
`barbferry|req` - any role may send it; TECH does so on its own at +20 metal
income while it owns none - `Team::Ferry::FactoryMakeTask` preempts the air
plant's normal production for a single heavy transport, ahead of everything
else, then **flies it to the requester's base under AIR's own ownership** and
transfers it on arrival.

One request at a time: a `req` arriving while AIR is already serving one is
dropped, and the requester re-asks after its cooldown. The preemption ends as
soon as the transport exists, and one order is latched per request - the first
version queued a new transport on every factory idle poll. Each delivery costs
AIR one 190-metal unit and one air-plant slot. Details in
[`../transport-ferry.md`](../transport-ferry.md).

## Late-game expansion

AIR used to sit at max metal late in the game. Its T1 builder policy
(`Air_T1Constructor_AiMakeTask`) tops out at one T2 air plant
(`MaxT2AircraftPlants = 1`), nanos to an income-based target, converters and
solars - and its **T2 air constructors were never given a policy at all**:
`Air_BuilderAiMakeTask` sent them to `MakeDefaultTaskWithLog`, so nothing in
the role ever asked for a second plant, a fusion or a gantry. Once the bank
was full there was nothing left to spend on.

`Air_LateExpansion_AiMakeTask` runs while metal is **floating** -
`aiEconomyMgr.isMetalFull` (over 80% of storage) or current above
`LateMetalCurrent` (2500), with income above `LateMetalIncome` (35) either way
so a full bank on a dead economy does not fire it. T2 air constructors run it
before their native default; T1 air constructors run it before their normal
ladder. It returns null when not floating, or when every rung is capped,
queued or on cooldown, and the caller falls through.

The ladder, in order:

| # | Rung | Gate | Placement |
| --- | --- | --- | --- |
| 1 | T1 nanos | fewer than `LateNanosPerT2Plant` (4) per T2 plant, under `NanoMaxCount` | ring |
| 2 | another T2 air plant | fewer than `LateMaxT2AircraftPlants` (3), none queued | ring, next slot |
| 3 | fusion / advanced fusion | energy income below `LateEnergyPerT2Plant` (900) per plant, or energy empty; AFUS at `LateAFUSMetalIncome` 60 and `LateAFUSMetalCurrent` 6000 | ring |
| 4 | gantry | `LateGantryMetalIncome` 60 and `LateGantryMetalCurrent` 6000, none yet | `EnqueueLandGantry` |

**The ring is what grows the base.** "Building area" is not a setting -
`AllyRange` only stops us building inside an ally's zone, and each structure
is placed at an anchor plus a search radius. Every late structure is anchored
on a ring `LateExpansionRadius` (1400) out from the start position with a
`LateExpansionShake` (384) search radius; the slot is chosen by how many of
that structure already exist, so each new one lands on fresh ground. Slot 0
faces the map centre, so the first expansion leans toward the fight rather
than the map edge.

**T3 air.** The experimental air plant (`armhaap` / `corhaap` / `leghaap`)
is built **only** by the T3 air constructor (`armhaca` ...), and that comes
from the gantry - no T2 constructor can build the plant directly. So the
gantry is the T3 air step. Whether the gantry then *produces* a T3 air
constructor is `FactoryProduction`'s business (`EnqueueGantrySignatureBatch`)
and is not part of this ladder.

The gate is `Air_IsFloating`; ring slots come from `Air_RingAnchor`, clamped
to the map by `Air_ClampToMap`. Every rung logs at level 1 as
`[AIR][Late] ...`. Settings are in `Global::RoleSettings::Air`, the
`LATE-GAME EXPANSION` block.

## Porc: air denial first

AIR is the second role to register a `PorcChainHandler`
([`../porc-chain.md`](../porc-chain.md)). Three changes, all in `Air_Init`
and `Air_PorcChain`:

**The chain leads with AA.** Position in the porc chain is a budget
threshold, and the default land order never builds flak at all - `armflak`
is in the unit list but the `land` sequence never references it - while
Mercury sits at position 12 behind ~14 000 cumulative metal. `AirLandChain`
puts flak at positions 2 and 5, long-range AA at 7, and repeats both down
the chain (flak x4, Mercury/Screamer/Xyston x4). It pays for that by
dropping the duplicate beamers, the Overwatch and three of the six
Rattlesnakes. **Kept at their counts:** Juno (position 6), the three gates,
the three LRPCs, the two EMP/tactical launchers, Ragnarok. Water is the
default chain.

**Porc reaches full mode mid game.** `Global::Porc` decides when a cluster
gets the whole chain rather than the preventive count, and the per-visit
budget. AIR overrides it in `Air_Init`: `PorcLateGameMinutes` 12 (default
25), `PorcLateGameMetalIncome` 50 (120), `PorcLateGameEnergyIncome` 800
(1 500), `PorcLateBudgetMod` 1.5 (1.0).

**Allied clusters get AA too.** `aiMilitaryMgr.porcAllyAA = 1`
(`PorcAlliedClustersAA`). Natively, the porc pass only visited clusters this
AI owns, and `DefaultMakeDefence` returned immediately inside an ally's
zone. With the flag, the pass also visits every cluster in an ally's zone
and builds **only anti-air** there - `IsRoleAA()` defs from the chain, with
the ground entries skipped and not counted against the walk. The ally's
own porc still owns the ground defence.

## Related

- [README.md](README.md) - the role contract and cross-role findings.
- [front.md](front.md) - the land counterpart, and the other opener-driven role.
- `doc/bomber-targeting.md` - air target selection below the role layer.

<!-- source: data/script/src/roles/air.as; blob: 826425a69608d98cfbfa2a54a297c0e1a7ec2ed2; lines: 1284 -->

## D-152 expansion and access

AIR holds two T1 sites plus six T2 sites with complete twenty-turret banks
before building them. Counts and production support use actual factories.
T1 conversion follows surplus energy until every owned mex is upgraded.
Reactors keep that mex gate. D-153 replaces the lab gate with a ten-second
minimum of 50 metal/s or a fully banked lab cost; AIR can now self-tech before
all upgrades finish and continues requesting TECH's T2 constructor. See
[design](../air-tech-expansion-plan.md).

D-152 AIR settings: `PlannedT2Bays=6`, `PlannedT1Bays=2`,
`ConverterParallel=3`, `ConverterDraw=70`, `ConverterEnergyReserve=150`.
At D-152, `MaxProductionBays=12` bounded actual production expansion;
preplanned sites neither count as active plants nor authorize spending.

D-153 publishes native reservations to allied instances, protects production
bay interiors from ordinary defenses, and relocates unused blocked clusters.
See the [shared layout and income design](../allied-layout-air-income-plan.md).
T1 bombers and Cortex Shuriken support are replenished alongside the fighter
screen; fusion preparation no longer stops them indefinitely.

## D-158 amphibious units

Experimental AIR calls `Lanes::Tick` for shared terrain and island surveys.
The shared military hook gives owned Telchines and Marauders to
`AmphibiousOps::MilitaryTask` before ordinary army routing. `AmphibiousOps::Tick`
runs in each experimental profile and releases operations on role loss.
Existing compatible ground factories may produce bounded waves through
`AirProduction::MakeTask`; AIR does not build a new ground factory for them.
Aircraft production, requested transports and economic constructors keep their
existing priority. See the [operation design](../amphibious-operations-plan.md).

D-160 uses the same Telchine budget and beachhead claims as TECH, including
a native-fallback exclusion so an auxiliary lab cannot bypass recruitment
cadence. No aircraft queue or ground-factory construction priority changes.
Guard repositioning remains on the secured dry land component.
See [implementation and tests](../telchine-beachhead-results.md).

D-161 gives Telchines land-first, footprint-checked routes and distinct dry
shore perimeter or land assault slots. Marauder travel and AIR economy stay
unchanged. See the [formation plan](../telchine-perimeter-plan.md).

## D-163 dense campus and strategic bomber phase

Experimental AIR reserves at least six T2 aircraft bays and one T1 bay, tiled by actual footprints with dense independent twenty-turret banks. Growth continues without a default factory cap. Shared TECH economy decisions begin at a sustained +50 metal minimum; AIR keeps all placements and tasks. D-171 replaces the original two-AFUS bomber gate with sustained metal/energy admission; two AFUS remain an economy growth objective. The opening economy raid draws once from `FirstBomberWaveMin`/`FirstBomberWaveMax` (10-20); defensive and frontline sorties use their own payload budgets. Later raids use target and route budgets, with a separate funded replacement pool. T1 reusable bombers select mexes/wind. See [original design](../air-campus-strike-design.md) and [current operations](../air-committed-operations-plan.md).

D-164 reserves a separate advanced-economy district at the opening: four modules
of one AFUS/eight advanced-converter slots, expanding one unused module ahead.
The native reservations exclude other local and allied building placement;
unused blocked modules move at first use. T2 aircraft constructors no longer
renew production guards, and existing guards release only those workers.
Overflow may fund serial reactor growth alongside continued factory production.
See [design and verification plan](../air-economy-zone-plan.md).

D-172 extends `AirBuild::EconomyAircraft` to T1 as well as T2 aircraft:
mobile workers assist unfinished economy structures and do not renew factory
or constructor guards. `ReturnEconomyWorkers` releases any inherited builder
guard individually and clears its engine order. Once the initial fighter
screen exists, `AirMath::WorkforceTurn` gives funded missing constructors a
production turn; `CombatOrdersPerEconomyConstructor` defaults to two during
an incursion. This allocates factory output without delaying combat commands.
The first eligible T2 lab precedes shared reactor growth; `SavingForFirstLab`
reserves capital after the existing preparation time and energy threshold
while preserving recovery, mex upgrades, transport and immediate defense.
See [repair plan](../air-workforce-repair-plan.md).

AIR advanced converter banks now use zero footprint gaps in both axes. The
AFUS/support-bank separation, independent factory campus, and T1 economy
spacing are unchanged. Native snapped positions are checked by INV-136 at
reservation time. See the [compact economy plan](../dense-economy-plan.md)
and [physical verification](../dense-economy-results.md).

Dragon and Tyrannus opt into `target_min_cost` in behavior JSON (D-215).
Ordinary native squads favor eligible nearby valuable targets, retaining cheap
fallback. AIR base defense places these aircraft in a separate group with
cost-weighted, proportional target retention, so a cheap raider cannot keep
their guns off an expensive attacker. The former gunship/bomber/fighter groups
and production policy remain intact. See [design and evidence](../reviews/2026-10-06-fortress-targeting.md).

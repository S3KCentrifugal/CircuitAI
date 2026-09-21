# AIR Role

Reference for the `AIR` AngelScript role: aircraft plants, air constructors and
the wind-economy opening. How it is registered, what it installs at init, how its
build-focus system works, and where it is currently wrong.

Source: `data/script/src/roles/air.as` (1042 lines), namespace `RoleAir`.
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

AIR commits to aircraft plants as the army source. It suppresses ground
production entirely at start, opens on wind energy where the map rewards it,
races a small number of air constructors, and funnels early build power into one
focused construction lane before releasing builders to general work.

It is the only role whose start limits zero out *both* land factory lines and all
T1 land defences - AIR does not intend to fight on the ground.

## Registration

`RoleAir::Register()` fills **17 of 24** slots - the common thirteen plus
`FactoryAiMakeTaskHandler` and the three military hooks that drive the bomber
waves.

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

Not filled: both factory task hooks, both factory unit hooks,
`MilitaryAiUnitAdded`, `MilitaryAiTaskAddedHandler`, `AiMakeDefenceHandler`.

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

### Builder

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

### Factory

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

`Air_EconomyUpdate()` is **empty**. All AIR economy shaping happens through
start limits and the factory handler's income gates.

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
`BomberWaveFirstSize` bombers have been held for `BomberWaveMaxHoldSeconds`
(escort requirement waived). `Required()` is the survival-grown
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

<!-- source: data/script/src/roles/air.as; blob: e5c9e03c3c31e449d064b1a7cfe9fec5eb8253e2; lines: 1258 -->

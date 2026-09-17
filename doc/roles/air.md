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
- [Decision flows](#decision-flows)
- [Commander wind opening](#commander-wind-opening)
- [Known defects](#known-defects)
- [Related](#related)

## Intent

AIR commits to aircraft plants as the army source. It suppresses ground
production entirely at start, opens on wind energy where the map rewards it,
races a small number of air constructors, and funnels early build power into one
focused construction lane before releasing builders to general work.

It is the only role whose start limits zero out *both* land factory lines and all
T1 land defences - AIR does not intend to fight on the ground.

## Registration

`RoleAir::Register()` fills **14 of 22** slots - the common thirteen plus
`FactoryAiMakeTaskHandler`.

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

Not filled: both factory task hooks, both factory unit hooks, all three military
hooks, `AiMakeDefenceHandler`.

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

## Init: what AIR installs

`Air_Init`:

1. Clears all module state: `g_airStrategicFocusTask`,
   `g_airStrategicFocusLeaderId = -1`, `g_airBuildFocusReleased`,
   `g_airGunshipOpenerDone`, `g_airStrikeOpenerQueuedCount`,
   `g_airCommanderWindTask`.
2. `aiTerrainMgr.SetAllyZoneRange(1600.0)`.
3. Installs the four military quota values and logs them at level 3.
4. `Air_ApplyStartLimits()`.
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

There is no military handler: `Air_MilitaryAiMakeTask` exists only as a
commented-out stub, so air combat units take the native default task.

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

## Related

- [README.md](README.md) - the role contract and cross-role findings.
- [front.md](front.md) - the land counterpart, and the other opener-driven role.
- `doc/bomber-targeting.md` - air target selection below the role layer.

<!-- source: data/script/src/roles/air.as; blob: 113a5cd1c2522a0448b4dab3a86647f505c4de00; lines: 1043 -->

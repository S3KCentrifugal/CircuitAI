# FRONT Role

Reference for the `FRONT` AngelScript role: the land-army posture. How it is
registered, what it installs at init, how its builders and factories decide, and
where it is currently wrong.

Source: `data/script/src/roles/front.as` (1028 lines), namespace `RoleFront`.
Line references are as of branch `smrt`, 2026-09-17. Prefer function names over
line numbers when navigating.

## Contents

- [Intent](#intent)
- [Registration](#registration)
- [Settings](#settings)
- [Init: what FRONT installs](#init-what-front-installs)
- [Decision flows](#decision-flows)
- [Dynamic military quotas](#dynamic-military-quotas)
- [Known defects](#known-defects)
- [Related](#related)

## Intent

FRONT is the land-army role and the enum default (`AiRole::FRONT = 0`, and the
fallback in both `RoleConfig()` and `StartSpot()`). It builds a ground army from
bot or vehicle labs, pushes forward pressure early, and scales its aggression
against a running comparison of its own army cost versus cached enemy surface
cost.

It is the only role that touches the military manager's unit-added callback, and
the only role besides TECH with factory unit lifecycle hooks - FRONT is the most
fully wired of the six.

## Registration

`RoleFront::Register()` fills **17 of 22** slots.

| Slot | Handler |
| --- | --- |
| `MainUpdateHandler` | `Front_MainUpdate` |
| `InitHandler` | `Front_Init` |
| `EconomyUpdateHandler` | `Front_EconomyUpdate` |
| `AiIsSwitchTimeHandler` | `Front_AiIsSwitchTime` |
| `AiIsSwitchAllowedHandler` | `Front_AiIsSwitchAllowed` |
| `MakeSwitchIntervalHandler` | `Front_MakeSwitchInterval` |
| `BuilderAiMakeTaskHandler` | `Front_BuilderAiMakeTask` |
| `BuilderAiTaskAddedHandler` | `Front_BuilderAiTaskAdded` |
| `BuilderAiTaskRemovedHandler` | `Front_BuilderAiTaskRemoved` |
| `BuilderAiUnitAdded` | `Front_BuilderAiUnitAdded` |
| `BuilderAiUnitRemoved` | `Front_BuilderAiUnitRemoved` |
| `FactoryAiMakeTaskHandler` | `Front_FactoryAiMakeTask` |
| `FactoryAiUnitAdded` | `Front_FactoryAiUnitAdded` |
| `FactoryAiUnitRemoved` | `Front_FactoryAiUnitRemoved` |
| `MilitaryAiUnitAdded` | `Front_MilitaryAiUnitAdded` |
| `SelectFactoryHandler` | `Front_SelectFactoryHandler` |
| `RoleMatchHandler` | `Front_RoleMatch` |

Not filled: `FactoryAiTaskAddedHandler`, `FactoryAiTaskRemovedHandler`,
`MilitaryAiMakeTaskHandler`, `MilitaryAiUnitRemoved`, `AiMakeDefenceHandler`.

## Settings

`Global::RoleSettings::Front` (`global.as:415`), 83 references across the tree.

**Posture**

| Setting | Value | Note |
| --- | --- | --- |
| `AllyRange` | 900.0 | tightest of all six roles |
| `DefaultT1CombatFireState` | 3 | fire at everything, applied to all T1 combat defs at init |
| `MinAiSwitchTime` / `MaxAiSwitchTime` | 20 / 60 s | |
| `SwitchFactoryCostMultiplier` | 1.2 | |

**Military quotas** - two parallel sets, bots and vehicles:

| Setting | Bots | Vehicles |
| --- | --- | --- |
| `MilitaryScoutCap*` | 7 | 2 |
| `MilitaryAttackThreshold*` | 12.0 | 30.0 |
| `MilitaryRaidMinPower*` | 12.0 | 40.0 |
| `MilitaryRaidAvgPower*` | 60.0 | 180.0 |

`Front_Init` installs the **bots** set unconditionally and clears
`g_frontVehicleThresholdsApplied`; the vehicle set is swapped in later when a
vehicle factory becomes the production line.

**Openers**

| Setting | Value |
| --- | --- |
| `ScoutRushCount` | 1 |
| `RaiderOpenerCount` | 10 |
| `ScoutAssignmentLimit` | 5 |

**Economy gates** - `MetalIncomePerLab` 35.0, `MetalIncomePerT1Builder` 20.0,
`MetalIncomePerT2Builder` 40.0, `MinBuilderCap` 5, `MetalIncomeForGantry` 250.0,
`TimeTriggerForFirstT2LabSeconds` 22 min, `TimeTriggerForT2EcoGatingSeconds`
20 min, `MaxT2BotLabs` 1, `MaxT2VehicleLabs` 1, plus FUS and nano thresholds.

**Start caps** - `StartCapRezBots` 10, `StartCapT1AircraftPlants` 0,
`StartCapNukeSilos` 0.

**Dynamic quota** - `DynamicQuotaEnemyCostAttackThresholdMultiplier` 1.0,
`DynamicQuotaEnemyCostWithdrawThresholdMultiplier` 0.8 (hysteresis band),
`UnderpoweredAttackQuota` 100.0, `UnderpoweredRaidMinQuota` 100.0,
`UnderpoweredRaidAvgQuota` 200.0, `DynamicQuotaDelaySeconds` 2 min.

`UseDynamicFactoryProduction` is **false**.

## Init: what FRONT installs

`Front_Init`:

1. `aiTerrainMgr.SetAllyZoneRange(900.0)`.
2. Iterates `UnitHelpers::GetAllT1CombatUnits()` and calls
   `d.SetFireState(3)` on each - FRONT-only behaviour, so T1 land units shoot
   walls and obstacles rather than holding fire.
3. Installs the **bots** military quota set.
4. `Front_ApplyStartLimits()` - a hardcoded `dictionary`: `armrectr`/`cornecro`
   to `StartCapRezBots`, `armap`/`corap`/`legap` to `StartCapT1AircraftPlants`,
   `armsilo`/`corsilo`/`legsilo` to `StartCapNukeSilos`.
5. Skips `FactoryProduction::Initialize()` because the flag is false.
6. `ObjectiveHelpers::LogAllObjectivesFromStart(AiRole::FRONT, "FRONT")`.

## Decision flows

### Builder

`Front_BuilderAiMakeTask(builder)`:

```text
null builder                -> null
commander                   -> Front_Commander_AiMakeTask(comm, defaultTask)
T1 constructor              -> Front_T1Constructor_AiMakeTask(...)
T2 constructor              -> Front_T2Constructor_AiMakeTask(...)
otherwise                   -> Builder::MakeDefaultTaskWithLog(id, "FRONT")
```

The T1 and T2 constructor handlers take pre-computed economy state
(`metalIncome`, `energyIncome`, `isEnergyStalling`, `isEnergyFull`,
`metalCurrent`, `isEnergyLessThan90Percent`) as parameters rather than reading it
themselves - the widest parameter lists in the role layer, and the reason those
two functions are cheap to call repeatedly.

`Front_TryBuildNano(metalIncome)` is the nano-farm path, gated by
`NanoMinIncomeForFirst`, `NanoEnergyPerUnit`, `NanoMetalPerUnit`,
`NanoEnergyIncomeThresholdForMax` and `NanoMaxCount`.

### Factory

`Front_FactoryAiMakeTask(u)` runs two one-time openers before falling through:

| Opener | Function | State flag | Count |
| --- | --- | --- | --- |
| Scout rush | `Front_TryScoutRush` | `g_frontScoutRushFinished`, `g_frontScoutRushFactoryId` | `ScoutRushCount` (1) |
| T1 raider | `Front_TryT1RaiderOpener` | `g_frontRaiderOpenerDone` | `RaiderOpenerCount` (10) |

Both are keyed to the *first* suitable T1 land factory. After them the handler
reaches `aiFactoryMgr.DefaultMakeTask(u)`.

### Economy

`Front_EconomyUpdate` reads `Economy::GetMinMetalIncomeLast10s()` and
`Economy::GetMinEnergyIncomeLast10s()` - sliding-window minima, not instantaneous
income - then applies `Front_IncomeLimits`, which fans out to
`Front_IncomeLabLimits`, `Front_IncomeBuilderLimits` and `Front_IncomeNanoLimits`.

It also performs a **one-time irreversible role switch**: once
`metalIncome > 250.0`, every def in `GetAllT1CombatUnits()` has
`SetMainRole(raider)` applied and `g_frontT1CombatRoleSwitchDone` is latched.
There is no path back if income later falls.

## Dynamic military quotas

`Front_MainUpdate` returns early until `ai.frame >= FRONT_DYNAMIC_QUOTA_DELAY_FRAMES`,
then calls `Front_UpdateDynamicMilitaryQuotas()` every tick.

That function compares `Front_GetArmyMetalCostEstimate()` - which is just
`aiMilitaryMgr.armyCost`, NaN-guarded and clamped at zero - against cached enemy
surface cost, and flips `g_frontIsUnderpowered` using a two-sided band:
attack at `DynamicQuotaEnemyCostAttackThresholdMultiplier` (1.0), withdraw at
`DynamicQuotaEnemyCostWithdrawThresholdMultiplier` (0.8). `g_frontIsUnderpowered`
initialises to `true`, so FRONT starts every game in the cautious state.

Note `armyCost` includes static defences, so base fortification counts toward
"army strength" in this comparison. That is deliberate per the comment, but it
means a turtling FRONT reads as stronger than its mobile force is.

## Known defects

1. **Four settings are declared and never read.**
   `Front::MilitaryScoutCap`, `MilitaryAttackThreshold`, `MilitaryRaidMinPower`
   and `MilitaryRaidAvgPower` (the un-suffixed forms, values 2 / 20.0 / 40.0 /
   180.0) have zero references - only the `*Bots` and `*Vehicles` variants are
   used. They read as the live defaults and are not.

2. **`Front::NukeLimit = 0` is never read.** Same for `Air::NukeLimit` and
   `Sea::NukeLimit`. Only TECH consumes a nuke limit. Setting it here has no
   effect; nuke suppression for FRONT comes from `StartCapNukeSilos` instead.

3. **`MilitaryAiUnitAdded` has no matching `MilitaryAiUnitRemoved`.** FRONT is
   the only role registering the added-callback, and nothing unregisters. Any
   per-unit state `Front_MilitaryAiUnitAdded` accumulates is never cleaned up on
   unit death.

4. **The T1-combat raider switch is one-way and global.** It mutates shared
   `CCircuitDef` state via `SetMainRole`, at a hardcoded `250.0` threshold that
   is not a setting, with no reversal path.

5. **`Front_SelectFactoryHandler` ignores `isReset`.** Returns `""` for any
   non-start call, as do AIR, SEA and SUPPORT. See
   [README cross-role finding 2](README.md#cross-role-findings).

6. **Start limits hardcode faction unit names.** `armrectr`, `cornecro`,
   `armap`, `corap`, `legap`, `armsilo`, `corsilo`, `legsilo` inline, rather
   than the `UnitHelpers::GetAll*` accessors TACTICAL and TECH use. New units or
   a fourth faction will silently miss these caps.

## Related

- [README.md](README.md) - the role contract and cross-role findings.
- [air.md](air.md), [tech.md](tech.md) - the other fully-wired roles.
- `doc/angelscript-references.md` - callback contracts and registered API.

<!-- source: data/script/src/roles/front.as; blob: 2fadb6465491a651b312c4e742012f828aec9a8c; lines: 1029 -->

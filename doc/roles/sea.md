# SEA Role

Reference for the `SEA` AngelScript role: naval production and water expansion.
How it is registered, what it installs at init, how its objective system drives
construction, and where it is currently wrong.

Source: `data/script/src/roles/sea.as` (903 lines), namespace `RoleSea`.
Line references are as of branch `smrt`, 2026-09-17. Prefer function names over
line numbers when navigating.

## Contents

- [Intent](#intent)
- [Registration](#registration)
- [Settings](#settings)
- [Init: what SEA installs](#init-what-sea-installs)
- [Mex upgrade priority](#mex-upgrade-priority)
- [Decision flows](#decision-flows)
- [Strategic objectives](#strategic-objectives)
- [The donation path](#the-donation-path)
- [Known defects](#known-defects)
- [Related](#related)

## Intent

SEA builds a navy from shipyards and expands across water. It is one of three
roles running dynamic military quota adjustment, and one of two (with TACTICAL)
that drives construction through the strategic objective system rather than
purely through income gates.

Its quota posture is the second most aggressive after AIR -
`MilitaryAttackThreshold` 1.0 and `MilitaryRaidMinPower` 1.0 mean SEA commits
early with whatever it has floating.

## Registration

`RoleSea::Register()` fills **14 of 22** slots - the common thirteen plus
`FactoryAiMakeTaskHandler`.

| Slot | Handler |
| --- | --- |
| `MainUpdateHandler` | `Sea_MainUpdate` |
| `InitHandler` | `Sea_Init` |
| `EconomyUpdateHandler` | `Sea_EconomyUpdate` |
| `AiIsSwitchTimeHandler` | `Sea_AiIsSwitchTime` |
| `AiIsSwitchAllowedHandler` | `Sea_AiIsSwitchAllowed` |
| `MakeSwitchIntervalHandler` | `Sea_MakeSwitchInterval` |
| `BuilderAiMakeTaskHandler` | `Sea_BuilderAiMakeTask` |
| `BuilderAiTaskAddedHandler` | `Sea_BuilderAiTaskAdded` |
| `BuilderAiTaskRemovedHandler` | `Sea_BuilderAiTaskRemoved` |
| `BuilderAiUnitAdded` | `Sea_BuilderAiUnitAdded` |
| `BuilderAiUnitRemoved` | `Sea_BuilderAiUnitRemoved` |
| `FactoryAiMakeTaskHandler` | `Sea_FactoryAiMakeTask` |
| `SelectFactoryHandler` | `Sea_SelectFactoryHandler` |
| `RoleMatchHandler` | `Sea_RoleMatch` |

Not filled: both factory task hooks, both factory unit hooks, all three military
hooks, `AiMakeDefenceHandler`.

## Settings

`Global::RoleSettings::Sea` (`global.as:609`), 58 references.

**Posture**

| Setting | Value |
| --- | --- |
| `AllyRange` | 2000.0 |
| `MinAiSwitchTime` / `MaxAiSwitchTime` | 20 / 60 s |
| `MilitaryScoutCap` | 3 |
| `MilitaryAttackThreshold` | 1.0 |
| `MilitaryRaidMinPower` / `MilitaryRaidAvgPower` | 1.0 / 5.0 |

**Guard limits** - SEA is the only role overriding the builder guard defaults:
`BuilderMaxGuardsPerLeader` 2 (global default 10),
`BuilderMaxGuardsPerTacticalLeader` 0.

**Energy** - `TidalEnergyIncomeMinimum` 1200.0 (commented "tune per map; tidals
vary"), `AssistPrimaryWorkerEnergyIncomeMinimum` 500.0,
`EnergyStorageLowPercent` 0.90, converter gates at
`BuildT1ConvertersUntilMetalIncome` 40.0 / `MinimumEnergyIncome` 250.0 /
`MinimumEnergyCurrentPercent` 0.90, advanced converter at 18.0 metal /
1200.0 energy, FUS at 30.0 metal / 1200.0 energy with `MaxEnergyIncomeForFUS`
999999.0 (effectively uncapped).

**T2 shipyard** - `MinimumMetalIncomeForT2Shipyard` 40.0,
`MinimumEnergyIncomeForT2Shipyard` 800.0,
`RequiredMetalCurrentForT2Shipyard` 800.0, `MaxT2Shipyards` 1.

**Naval production** - `MinT2DestroyerCount` 5, `T2DestroyerBatchSize` 5,
`EnableEarlyRezSub` **false**, `MetalIncomePerRezSub` 60.0.

**Commander assist** - `CommanderFactoryAssistDeadlineSeconds` 3 min,
`CommanderFactoryAssistGuardTimeoutSeconds` 10.

**Dynamic quota** - `DynamicQuotaEnemyCostThresholdMultiplier` 1.0,
`UnderpoweredAttackQuota` 100.0, `UnderpoweredRaidMinQuota` 100.0,
`UnderpoweredRaidAvgQuota` 200.0, `DynamicQuotaDelaySeconds` 6 min - the longest
delay of the three dynamic-quota roles.

`UseDynamicFactoryProduction` is **false**.

## Init: what SEA installs

`Sea_Init`:

1. `aiTerrainMgr.SetAllyZoneRange(2000.0)`.
2. Installs the four military quota values.
3. `Sea_ApplyStartLimits()` - zeroes `armbanth`, `armmar`, `armcroc` and the
   three nuke silos.
4. Iterates `UnitHelpers::GetAllT1NavalCombatUnits()` and applies
   `d.SetFireState(3)`, mirroring FRONT's land behaviour for naval units.
5. `FactoryProduction::Initialize()` only if the flag is set.
6. `ObjectiveHelpers::LogAllObjectivesFromStart(AiRole::SEA, "SEA")`.

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

`Sea_BuilderAiMakeTask(builder)` routes commander to
`Sea_Commander_AiMakeTask`, T1 constructors to `Sea_T1Constructor_AiMakeTask`
and T2 to `Sea_T2Constructor_AiMakeTask`, each taking a pre-built `defaultTask`.

`Sea_BuilderAiUnitAdded` is the longest of the unit-added handlers in the role
layer (~34 lines) - it establishes primary/secondary constructor identity and
the guard relationships that `BuilderMaxGuardsPerLeader = 2` then bounds.

### Factory

`Sea_FactoryAiMakeTask(u)` is the second-largest factory handler after TECH's
(~200 lines). It drives shipyard production including the T2 destroyer batching
governed by `MinT2DestroyerCount` and `T2DestroyerBatchSize`.

### Economy

`Sea_EconomyUpdate` reads `aiEconomyMgr.metal.income` **directly** - not the
sliding-window minimum FRONT uses - and calls `Sea_IncomeLimits(metalIncome)`,
which fans out to `Sea_IncomeLabLimits` and `Sea_IncomeBuilderLimits`.

### Dynamic quotas

`Sea_MainUpdate` returns early until
`ai.frame >= Global::RoleSettings::Sea::DynamicQuotaDelaySeconds * SECOND`, then
runs `Sea_UpdateDynamicMilitaryQuotas()`, which compares
`Sea_GetArmyMetalCostEstimate()` - `aiMilitaryMgr.armyCost`, i.e. the **whole**
army, not sea units only (contrast AIR) - with
`Military::GetEnemyWaterCostPerPlayer()`. SEA is the only one of the three
dynamic-quota roles to gate on a *setting* rather than a compile-time constant.

## Strategic objectives

SEA and TACTICAL are the two roles wired into `Objectives::`.

| Function | Purpose |
| --- | --- |
| `Sea_GetObjectiveBuildPos(objective, fallback)` | resolve a build position for an objective, with fallback |
| `Sea_TryHandleObjective(builder, conLocation, unitSide, mi, ei)` | attempt to advance the current objective given income state |

Unlike TACTICAL, SEA has no builder-group partitioning and no objective chain
executor - it handles one objective at a time against the current constructor.

## The donation path

`sea.as` opens with a small nested namespace containing `IsT2SeaConstructor(d)`
and `TryDonate(u)`. `TryDonate` builds a one-element `array<CCircuitUnit@>` and
hands the unit away.

This is the only unit-donation path in the role layer. It exists so a T2 sea
constructor stranded without useful water work can be given to an ally rather
than idling.

## Known defects

1. **`Sea_ApplyStartLimits` logs the wrong role.** The function ends with
   `GenericHelpers::LogUtil("Tactical start limits applied", 3)` - copy-paste
   from `tactical.as`. Any log-driven diagnosis of SEA start limits will look
   for the wrong string.

2. **`Sea::NukeLimit = 0` is never read.** As with FRONT and AIR, suppression
   comes from the silo start limits instead.

3. **Start limits hardcode three Armada units with no Cortex or Legion
   equivalents.** `armbanth`, `armmar` and `armcroc` are zeroed; the
   corresponding `cor*` and `leg*` units are not. Whatever this rule intends, it
   applies to one faction only.

4. **`Sea_EconomyUpdate` uses instantaneous income.** `aiEconomyMgr.metal.income`
   rather than `Economy::GetMinMetalIncomeLast10s()`. SEA's income limits will
   oscillate with production spikes where FRONT's do not.

5. **`Sea_Init` has no else-branch log for the disabled dynamic factory
   production.** AIR, FRONT and TACTICAL all log "disabled; using legacy"; SEA
   logs nothing, so its factory-production mode is invisible in the log.

6. **`EnableEarlyRezSub = false` makes `MetalIncomePerRezSub = 60.0` dead** while
   the flag stays off.

7. **`MaxEnergyIncomeForFUS = 999999.0`** is a sentinel standing in for "no
   cap". FRONT uses 4000.0 and TECH 2000.0 for the same setting, so SEA's FUS
   behaviour diverges silently rather than by stated intent.

8. **`Sea_SelectFactoryHandler` is a verbatim copy** of FRONT's and AIR's apart
   from its log prefix, and ignores `isReset`.

## Related

- [README.md](README.md) - the role contract and cross-role findings.
- [tactical.md](tactical.md) - the other objective-driven role, and the one SEA's
  settings block was copy-pasted into.
- [hover.md](hover.md) - hover plants are reachable on water-ish maps and are not
  a role.

<!-- source: data/script/src/roles/sea.as; blob: 2ca62dfaf9951f26f4ba4572b99fea71a7f71a15; lines: 914 -->

# SUPPORT Role

Reference for the `SUPPORT` AngelScript role: the hybrid economic substitute.
How it is registered, what it installs at init, why its factories are not
role-controlled, and where it is currently wrong.

Source: `data/script/src/roles/support.as` (497 lines), namespace `RoleSupport`.
Line references are as of branch `smrt`, 2026-09-17. Prefer function names over
line numbers when navigating.

## Contents

- [Not to be confused with the `support` unit tag](#not-to-be-confused-with-the-support-unit-tag)
- [Intent](#intent)
- [Registration](#registration)
- [Settings](#settings)
- [Init: what SUPPORT installs](#init-what-support-installs)
- [Mex upgrade priority](#mex-upgrade-priority)
- [Porcupine chain: the launcher swap](#porcupine-chain-the-launcher-swap)
- [Decision flows](#decision-flows)
- [The missing factory handler](#the-missing-factory-handler)
- [Known defects](#known-defects)
- [Related](#related)

## Not to be confused with the `support` unit tag

`support` is also a **config role** in `behaviour.json`'s def list, and the two
have nothing to do with each other. The config tag is what mobile radar and
jammer units carry; it routes them to native `CSupportTask`, and its escort
rationing is documented in [`../sensor-escort.md`](../sensor-escort.md). This
page is about the AngelScript profile role.

## Intent

SUPPORT is the smallest role at 497 lines - roughly a quarter of TECH. The enum
comments it as "hybrid support / economic substitute (renamed from
ECO/FrontTech)", and the code matches: it disables its own T1 combat production
entirely, keeps a high resurrect-bot cap, and spends its effort on constructor
management and guard assignment rather than on shaping what its factories build.

It is best understood as an economy role that expects allies to fight, sitting
between TECH (pure economy, full factory control) and FRONT (pure army).

## Registration

`RoleSupport::Register()` fills **16 of 23** slots.

| Slot | Handler |
| --- | --- |
| `MainUpdateHandler` | `Support_MainUpdate` |
| `InitHandler` | `Support_Init` |
| `EconomyUpdateHandler` | `Support_EconomyUpdate` |
| `AiIsSwitchTimeHandler` | `Support_AiIsSwitchTime` |
| `AiIsSwitchAllowedHandler` | `Support_AiIsSwitchAllowed` |
| `MakeSwitchIntervalHandler` | `Support_MakeSwitchInterval` |
| `BuilderAiMakeTaskHandler` | `Support_BuilderAiMakeTask` |
| `BuilderAiTaskAddedHandler` | `Support_BuilderAiTaskAdded` |
| `BuilderAiTaskRemovedHandler` | `Support_BuilderAiTaskRemoved` |
| `BuilderAiUnitAdded` | `Support_BuilderAiUnitAdded` |
| `BuilderAiUnitRemoved` | `Support_BuilderAiUnitRemoved` |
| `FactoryAiUnitAdded` | `Support_FactoryAiUnitAdded` |
| `FactoryAiUnitRemoved` | `Support_FactoryAiUnitRemoved` |
| `SelectFactoryHandler` | `Support_SelectFactoryHandler` |
| `RoleMatchHandler` | `Support_RoleMatch` |
| `PorcChainHandler` | `Support_PorcChain` |

**`FactoryAiMakeTaskHandler` is not filled.** SUPPORT is the only role without
one - see [The missing factory handler](#the-missing-factory-handler).

Also not filled: both factory task hooks, all three military hooks,
`AiMakeDefenceHandler`.

## Settings

`Global::RoleSettings::Support` (`global.as:545`), 24 references - the second
smallest block after TACTICAL.

**Posture**

| Setting | Value |
| --- | --- |
| `AllyRange` | 1300.0 |
| `MilitaryScoutCap` | 2 |
| `MilitaryAttackThreshold` | 40.0 |
| `MilitaryRaidMinPower` / `MilitaryRaidAvgPower` | 60.0 / 80.0 |

`MilitaryAttackThreshold` 40.0 is the highest in the role layer - SUPPORT
commits to an attack far later than any other role, consistent with disabling its
own T1 combat units.

**Economy**

| Setting | Value |
| --- | --- |
| `SolarEnergyIncomeMinimum` | 160.0 |
| `BuildT1ConvertersUntilMetalIncome` | 18.0 |
| `BuildT1ConvertersMinimumEnergyIncome` | 250.0 |
| `BuildT1ConvertersMinimumEnergyCurrentPercent` | 0.90 |
| `AdvancedSolarEnergyIncomeMinimum` / `Maximum` | 600.0 / 1000.0 |

**T2** - `MinimumMetalIncomeForT2Lab` 17.0, `MinimumEnergyIncomeForT2Lab` 550.0,
`RequiredMetalCurrentForT2Lab` 800.0, `MaxT2BotLabs` 1. These are the lowest T2
gates of any role - SUPPORT techs earlier than TECH does (18.0 / 500.0 / 1000.0).

**Builders** - `MaxT1Builders` 5, `MaxT2Builders` 5,
`SecondaryT1AssistMetalIncomeMax` 80.0.

**Nano** - `NanoEnergyPerUnit` 200.0, `NanoMetalPerUnit` 10.0, `NanoMaxCount`
200, `NanoBuildWhenOverMetal` 1000.0.

**Commander assist** - `CommanderFactoryAssistDeadlineSeconds` 80 (the comment
says "first 2 minutes"; 80 seconds is not 2 minutes),
`CommanderFactoryAssistGuardTimeoutSeconds` 10.

SUPPORT does **not** declare `UseDynamicFactoryProduction`.

## Init: what SUPPORT installs

`Support_Init`:

1. `aiTerrainMgr.SetAllyZoneRange(1300.0)`.
2. Installs the four military quota values.
3. `Support_ApplyStartLimits()`.
4. `ObjectiveHelpers::LogAllObjectivesFromStart(AiRole::SUPPORT, "SUPPORT")`.

No fire-state pass (FRONT, SEA and TACTICAL each have one) and no
`FactoryProduction::Initialize()` branch.

`Support_ApplyStartLimits` is the only start-limit function that mixes styles:

```angelscript
startLimits.set("armap", 0);   // hardcoded aircraft plants
startLimits.set("corap", 0);
startLimits.set("legap", 0);
startLimits.set("armsilo", 0); // hardcoded nuke silos
startLimits.set("corsilo", 0);
startLimits.set("legsilo", 0);
startLimits.set("armrectr", 5); // resurrect bots allowed
startLimits.set("cornecro", 5);

RoleLimitHelpers::DisableT1Combat(startLimits, Global::AISettings::Side);
UnitHelpers::ApplyUnitLimits(startLimits);
```

`RoleLimitHelpers::DisableT1Combat` is used by no other role. It is the
side-aware way to do what AIR does by hand, and it is the reason SUPPORT's
`MilitaryAttackThreshold` of 40.0 is coherent: the role has no early combat units
to attack with.

`armrectr`/`cornecro` at 5 is the highest resurrect-bot allowance outside FRONT's
`StartCapRezBots` of 10. There is no Legion equivalent listed.

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

## Porcupine chain: the launcher swap

`Support_PorcChain` is SUPPORT's `PorcChainHandler`, and the only one any role
registers. It makes one edit to the land chain: **the side's Juno becomes the
side's ranged tactical launcher.**

| Side | Out | In | Name | Metal |
| --- | --- | --- | --- | --- |
| Armada | `armjuno` | `armemp` | Paralyzer, EMP Missile Launcher | 1600 |
| Cortex | `corjuno` | `cortron` | Catalyst, Tactical Missile Launcher | 1200 |
| Legion | `legjuno` | `legperdition` | Perdition, Long Range Napalm Launcher | 1250 |

### Why a swap, and not an insertion

`CMilitaryManager::DefaultMakeDefence` walks the chain accumulating
`totalCost`, and breaks as soon as it passes
`maxCost = amountFactor x metal income`, where `amountFactor` is 32-48
depending on map size. Position in the chain is therefore a budget threshold,
and the thresholds for this class of unit are out of reach:

| Chain position | Entry (Armada) | Cumulative metal | Income needed |
| --- | --- | --- | --- |
| 7 | `armjuno` | 2 565 | ~64 |
| 16 | `armemp` | 24 865 | ~620 |
| 25 | `armemp` | 48 025 | ~1 200 |

The launchers are already in the default chain, twice each, and **no cluster
has ever reached them**. Position 7 is the last entry a well-funded cluster
does reach. So the swap is not a preference between two units competing for a
slot; it is the only slot in which the launcher can exist at all.

Cortex and Legion have the same shape - the launcher at cumulative 24 045 and
23 140 respectively.

### What it costs

The point pays the price difference at position 7: **+960** Armada, **+540**
Cortex, **+590** Legion. Everything behind position 7 moves that much further
out of budget. Given that everything behind position 7 starts at `armamb`
(2 500) and the cluster reaching position 7 at all is already well funded, the
practical effect is one fewer Rattlesnake at the best-funded points.

Both units are T2. `DefaultMakeDefence` skips an unavailable def *before*
adding its cost, so the chain is byte-identical until an advanced constructor
exists.

### If one per point is not enough

The chain walk enqueues every entry it reaches, so a repeated entry builds
repeatedly. Getting a *second* launcher at one defence point means putting it
in a second reachable slot, and the reachable window ends around position 8 —
`armamb` (Rattlesnake, 2 500, cumulative 5 065) for Armada. Swapping that too
would double the launcher count at the richest points and cost the role its
pop-up plasma artillery. That trade has not been made; it is one
`PorcHelpers::Replace` call away in `Support_PorcChain` if a game says the
first swap was not enough.

### What SUPPORT gives up

All of its Junos. The Juno answers radar, jammers, minefields and scout spam -
[`../juno-targets.md`](../juno-targets.md) - and a role that disables its own
T1 combat production and expects allies to hold the line is the role least
placed to exploit that, and most able to use a stockpiled ranged strike fired
from behind its own porc. This was an explicit trade, not a side effect.

How the launcher then picks its target - and why, until
[D-036](../decisions.md#d-036--tactical-launchers-aim-by-unit-scan-and-super-statics-bypass-role-policy),
it never did - is [`../launcher-targets.md`](../launcher-targets.md).

The water chain is untouched: it contains neither unit, and neither is
buildable on water.

### Fallbacks

- An unrecognised side, or a table with no entry for it, logs and keeps the
  default chain.
- A chain that no longer holds the Juno - a config edit, or a mod option that
  rewrote the order - appends the launcher instead of losing it, which is no
  worse than the default it replaces.
- `SetPorcChain` already logs and skips a def that is not loaded, so a side
  whose launcher is absent from the game degrades to a chain without it.

## Decision flows

### Builder

`Support_BuilderAiMakeTask(u)` is the clearest statement of the role's shape:

```text
null u                              -> null
build a defaultTask once, cache it  (never recreated inside this function)
null circuitDef                     -> defaultTask
defaultTask is a builder task whose build type is
    MEX | MEXUP | GEO | GEOUP | ENERGY  -> return defaultTask unchanged
commander                           -> Support_Commander_AiMakeTask(u, defaultTask)
constructor tier 1:
    is primary or secondary T1 bot constructor -> Support_T1Constructor_AiMakeTask
    else if registered as a guard of primary   -> GuardHelpers::AssignWorkerGuard(primary, HIGH, 200s)
    else if registered as a guard of secondary -> GuardHelpers::AssignWorkerGuard(secondary, HIGH, 200s)
otherwise                           -> defaultTask
```

Two things distinguish it. First, the **early-out on resource tasks**: if the
native default already wants a mex, mex upgrade, geo, geo upgrade or energy
building, SUPPORT does not override it. Second, the explicit **guard fan-out** -
constructors that are neither primary nor secondary are put on `HIGH`-priority
200-second guard tasks against the leaders rather than given independent work.

### Economy

`Support_EconomyUpdate` reads `aiEconomyMgr.metal.income` directly and calls
`Support_IncomeBuilderLimits(metalIncome)` - builder caps only. It is commented
"similar to TECH" but implements a fraction of TECH's income-gated cap system.

### Main update

`Support_MainUpdate` has no body beyond a commented-out log line.

## The missing factory handler

Because `FactoryAiMakeTaskHandler` is null, every SUPPORT factory going idle
reaches the native path directly:

```text
factory idle -> CFactoryScript::MakeTask -> Factory::AiMakeTask
             -> RoleConfig.FactoryAiMakeTaskHandler is null
             -> aiFactoryMgr.DefaultMakeTask(u)
             -> CFactoryManager::CreateFactoryTask
```

Consequences worth holding:

- SUPPORT cannot run openers, batching, or priority enqueues. There is no
  equivalent of FRONT's scout rush or AIR's strike opener.
- SUPPORT's production is shaped **only** by unit caps - the start limits, the
  `DisableT1Combat` call, and `Support_IncomeBuilderLimits`. Caps are the entire
  control surface.
- The native `isActive` / `rare` gate described in [hover.md](hover.md) applies
  to SUPPORT with no script mediation at all. Once any non-T1 factory exists,
  SUPPORT's T1 factories are subject to the full native filter.

Whether this is intentional minimalism or an unfinished role is not recorded
anywhere in the source.

## Known defects

1. **`Support_BuilderAiMakeTask` logs with the `[FRONT]` prefix.** The
   early-out on MEX/MEXUP/GEO/GEOUP/ENERGY logs
   `"[FRONT] defaultTask is MEX/MEXUP/GEO/GEOUP/ENERGY; returning early"` from
   inside `support.as`. Copy-paste from `front.as`; makes log filtering by role
   wrong.

2. **`Support_MainUpdate` is empty but registered.** A delegate call per tick for
   nothing.

3. **No `FactoryAiMakeTaskHandler`.** Documented above. Whether deliberate is
   unknown; it is the single largest behavioural difference between SUPPORT and
   every other role.

4. **`CommanderFactoryAssistDeadlineSeconds = 80` contradicts its own comment**
   ("default: first 2 minutes"). Either the value or the comment is wrong. SEA
   uses `3 * 60` with the same misleading comment.

5. **T2 gates are lower than TECH's.** `MinimumMetalIncomeForT2Lab` 17.0 vs
   TECH's 18.0, energy 550.0 vs 500.0, metal current 800.0 vs 1000.0. A role
   described as an economic *substitute* techs sooner than the dedicated economy
   role. Probably unintended.

6. **`armrectr`/`cornecro` at 5 with no Legion equivalent.** Legion's resurrect
   bot is uncapped here where the other two factions are limited.

7. **Registers `FactoryAiUnitAdded`/`Removed` but no factory task handler.** It
   observes factory unit lifecycle without being able to act on production - an
   odd pairing worth confirming is intended.

## Related

- [README.md](README.md) - the role contract and cross-role findings.
- [tech.md](tech.md) - the dedicated economy role, and the cap system SUPPORT's
  economy update is modelled on.
- [hover.md](hover.md) - the native factory gate that reaches SUPPORT unmediated.
- [../sensor-escort.md](../sensor-escort.md) - the `support` *config* role, and how
  mobile sensors are rationed one per squad.

<!-- source: data/script/src/roles/support.as; blob: ca67e2411d2df9717c496fc5481f758e63b7c21b; lines: 575 -->

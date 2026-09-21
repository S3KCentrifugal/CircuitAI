# AngelScript roles

Reference index for the AngelScript role layer: what a role is, the contract
every role implements, which handlers each role fills, and where the roles
disagree with each other.

Source: `data/script/src/roles/`. Line references are as of branch `smrt`,
2026-09-17. Prefer function names over line numbers when navigating.

## Contents

- [The role set](#the-role-set)
- [Documents](#documents)
- [The contract](#the-contract)
- [Handler coverage matrix](#handler-coverage-matrix)
- [Unregistered contract slots](#unregistered-contract-slots)
- [Shared lifecycle](#shared-lifecycle)
- [Per-role settings](#per-role-settings)
- [Cross-role findings](#cross-role-findings)
- [Keeping these documents current](#keeping-these-documents-current)

## The role set

The role set is fixed at six, declared in `data/script/src/types/ai_role.as`:

```angelscript
enum AiRole {
    FRONT = 0,
    AIR = 1,
    TECH = 2,
    SEA = 3,
    SUPPORT = 4, // hybrid support / economic substitute (renamed from ECO/FrontTech)
    TACTICAL = 5, // Tactical role (formerly HOVER_SEA), favoring mobile builders (often hover-based)
}
```

One `.as` file per role in `data/script/src/roles/`, one namespace each.

| Role | File | Lines | Namespace | Documented |
| --- | --- | --- | --- | --- |
| `FRONT` | `front.as` | 1028 | `RoleFront` | [front.md](front.md) |
| `AIR` | `air.as` | 1042 | `RoleAir` | [air.md](air.md) |
| `TECH` | `tech.as` | 1923 | `RoleTech` | [tech.md](tech.md) |
| `TECH` | `tech_build.as` | 216 | `TechBuild` | [tech_build.md](tech_build.md) |
| `SEA` | `sea.as` | 903 | `RoleSea` | [sea.md](sea.md) |
| `SUPPORT` | `support.as` | 497 | `RoleSupport` | [support.md](support.md) |
| `TACTICAL` | `tactical.as` | 709 | `RoleTactical` | [tactical.md](tactical.md) |

6,102 lines total.

## Documents

| Document | Subject |
| --- | --- |
| [front.md](front.md) | FRONT - land army and forward pressure |
| [air.md](air.md) | AIR - aircraft plants, air constructors, wind economy |
| [tech.md](tech.md) | TECH - economy-first, T2/T3 race, unit-cap system |
| [tech_build.md](tech_build.md) | TECH - the experimental build system (D-066): the whole builder sequence when `Tech::ExperimentalBuild` is on |
| [sea.md](sea.md) | SEA - naval production and water expansion |
| [support.md](support.md) | SUPPORT - hybrid economic substitute, no factory task handler |
| [tactical.md](tactical.md) | TACTICAL - mobile-builder role, forces the hover plant opening |
| `hover.md` | **Outstanding - this document does not exist yet.** It is referenced from nine places as the deep reference for hover production and the T2 hover stall; see `KI-404` in [`../known-issues.md`](../known-issues.md). Hover is **not a role**: it is a factory family plus a production config, reachable by several roles, and is listed here because it is routinely mistaken for one. |

## The contract

A role is a `RoleConfig` instance registered into `RoleConfigs::registry`
(`data/script/src/types/role_config.as`). Every role file ends with a
`Register()` function that constructs the config, assigns a subset of delegate
slots, and calls `RoleConfigs::Register(cfg)`.

`RoleConfig` exposes **22 delegate slots** plus three plain fields:

| Slot | Funcdef | Called by |
| --- | --- | --- |
| `MainUpdateHandler` | `MainUpdateDelegate` | profile controller, per update tick |
| `EconomyUpdateHandler` | `EconomyUpdateDelegate` | economy manager |
| `InitHandler` | `InitDelegate` | `RoleConfigs::ApplyStartLimits()` at startup |
| `AiIsSwitchTimeHandler` | `AiIsSwitchTimeDelegate` | factory manager, switch gating |
| `AiIsSwitchAllowedHandler` | `AiIsSwitchAllowedDelegate` | factory manager, switch gating |
| `MakeSwitchIntervalHandler` | `MakeSwitchIntervalDelegate` | factory manager |
| `BuilderAiMakeTaskHandler` | `AiMakeTaskDelegate` | builder manager, on idle builder |
| `BuilderAiTaskAddedHandler` | `AiTaskAddedDelegate` | builder manager |
| `BuilderAiTaskRemovedHandler` | `AiTaskRemovedDelegate` | builder manager |
| `BuilderAiUnitAdded` | `AiUnitAddedDelegate` | builder manager |
| `BuilderAiUnitRemoved` | `AiUnitRemovedDelegate` | builder manager |
| `FactoryAiMakeTaskHandler` | `AiMakeTaskDelegate` | factory manager, on idle factory |
| `FactoryAiTaskAddedHandler` | `AiTaskAddedDelegate` | factory manager |
| `FactoryAiTaskRemovedHandler` | `AiTaskRemovedDelegate` | factory manager |
| `FactoryAiUnitAdded` | `AiUnitAddedDelegate` | factory manager |
| `FactoryAiUnitRemoved` | `AiUnitRemovedDelegate` | factory manager |
| `MilitaryAiMakeTaskHandler` | `AiMakeTaskDelegate` | military manager |
| `MilitaryAiTaskAddedHandler` | `AiTaskAddedDelegate` | military manager |
| `MilitaryAiTaskRemovedHandler` | `AiTaskRemovedDelegate` | military manager |
| `MilitaryAiUnitAdded` | `AiUnitAddedDelegate` | military manager |
| `MilitaryAiUnitRemoved` | `AiUnitRemovedDelegate` | military manager |
| `AiMakeDefenceHandler` | `AiMakeDefence` | defence placement |
| `SelectFactoryHandler` | `SelectFactoryDelegate` | factory selection at start / reset |
| `RoleMatchHandler` | `RoleMatchDelegate` | `RoleConfigs::Match()`, first match wins |
| `PorcChainHandler` | `PorcChainDelegate` | porcupine chain ordering, once at setup |
| `LayoutPlanHandler` | `LayoutPlanDelegate` | base layout reservations, once at setup after the porc chain |

Plain fields: `role` (the `AiRole`), `UnitMaxOverrides` (a `dictionary` of
unit name to cap) and `switchInterval` (int, managed per role).

Unassigned slots are null. Where the factory manager finds a null handler it
falls through to its native default - for factory task creation that means
`aiFactoryMgr.DefaultMakeTask(u)` and therefore
`CFactoryManager::CreateFactoryTask`. `RoleConfigs` supplies explicit defaults
for the three switching slots only (`DefaultAiIsSwitchTime`,
`DefaultAiIsSwitchAllowed`, `DefaultMakeSwitchInterval`).

## Runtime role switch

`Commands::SwitchRole` (`data/script/src/manager/commands.as`, driven by the
host-side widget through `Main::AiLuaMessage`) rebinds
`Global::profileController.RoleCfg` to another registered `RoleConfig` during a
game. Because every native hook resolves its delegate through that handle on
each call, the switch takes effect on the next decision. Before running the new
role's `InitHandler` it restores every def's `maxThisUnit`, ignore flag and main
role from the snapshot Setup takes before the first `InitHandler`, then
recomputes the merged map/role limits. Role-local state (one-way flags, counters)
is not reset; a role must tolerate being initialised twice and being entered
mid-game with those flags already set.

## Handler coverage matrix

Which roles fill which slot. Read down a column for one role's surface, across a
row to see how consistently a slot is used.

| Slot | FRONT | AIR | TECH | SEA | SUPPORT | TACTICAL |
| --- | :-: | :-: | :-: | :-: | :-: | :-: |
| `MainUpdateHandler` | yes | yes | yes | yes | yes | yes |
| `EconomyUpdateHandler` | yes | yes | yes | yes | yes | yes |
| `InitHandler` | yes | yes | yes | yes | yes | yes |
| `AiIsSwitchTimeHandler` | yes | yes | yes | yes | yes | yes |
| `AiIsSwitchAllowedHandler` | yes | yes | yes | yes | yes | yes |
| `MakeSwitchIntervalHandler` | yes | yes | yes | yes | yes | yes |
| `BuilderAiMakeTaskHandler` | yes | yes | yes | yes | yes | yes |
| `BuilderAiTaskAddedHandler` | yes | yes | yes | yes | yes | yes |
| `BuilderAiTaskRemovedHandler` | yes | yes | yes | yes | yes | yes |
| `BuilderAiUnitAdded` | yes | yes | yes | yes | yes | yes |
| `BuilderAiUnitRemoved` | yes | yes | yes | yes | yes | yes |
| `SelectFactoryHandler` | yes | yes | yes | yes | yes | yes |
| `RoleMatchHandler` | yes | yes | yes | yes | yes | yes |
| `FactoryAiMakeTaskHandler` | yes | yes | yes | yes | **no** | yes |
| `FactoryAiUnitAdded` | yes | no | yes | no | yes | no |
| `FactoryAiUnitRemoved` | yes | no | yes | no | yes | no |
| `MilitaryAiMakeTaskHandler` | no | yes | yes | no | no | no |
| `MilitaryAiUnitAdded` | yes | no | yes | no | no | no |
| `MilitaryAiUnitRemoved` | no | yes | no | no | no | no |
| `MilitaryAiTaskAddedHandler` | no | no | no | no | no | no |
| `MilitaryAiTaskRemovedHandler` | no | yes | yes | no | no | no |
| `AiMakeDefenceHandler` | no | no | yes | no | no | no |
| `PorcChainHandler` | no | yes | no | no | yes | no |
| `LayoutPlanHandler` | no | no | yes | no | no | no |
| `FactoryAiTaskAddedHandler` | no | no | no | no | no | no |
| `FactoryAiTaskRemovedHandler` | no | no | no | no | no | no |
| **Slots filled** | **17** | **18** | **19** | **14** | **16** | **14** |

Thirteen slots are filled by every role. That common set is the de-facto role
interface; everything below it in the table is an exception worth understanding
before changing.

## Unregistered contract slots

Four parts of the contract have no implementation anywhere in the tree:

| Slot | Status |
| --- | --- |
| `FactoryAiTaskAddedHandler` | never assigned by any role |
| `FactoryAiTaskRemovedHandler` | never assigned by any role |
| `MilitaryAiTaskAddedHandler` | never assigned by any role |
| `MilitaryAiUnitRemoved` | only AIR assigns it; FRONT assigns `MilitaryAiUnitAdded` with no matching removal |
| `UnitMaxOverrides` | declared on `RoleConfig`, never written and never read |

They are live plumbing with no consumer. Either a role should use them or they
should be retired from `role_config.as`.

## Shared lifecycle

Every role follows the same startup path:

```text
profile main.as
  -> Register()                         (per role, guarded by RoleConfigs::Get(role) !is null)
  -> RoleConfigs::Register(cfg)         (appends to registry)
  -> RoleConfigs::Match(...)            (first RoleMatchHandler returning true)
  -> RoleConfigs::ApplyStartLimits()    (calls the matched role's InitHandler)
       -> <Role>_Init()
            -> aiTerrainMgr.SetAllyZoneRange(...)
            -> aiMilitaryMgr.quota.scout / .attack / .raid.min / .raid.avg
            -> <Role>_ApplyStartLimits()
            -> FactoryProduction::Initialize()   [only if UseDynamicFactoryProduction]
            -> ObjectiveHelpers::LogAllObjectivesFromStart(...)
```

`<Role>_Init` is where the role's personality is actually installed: ally-zone
range, the four military quota values, and the start unit caps. Everything after
that is reaction to manager callbacks.

## Per-role settings

Each role reads its tunables from `Global::RoleSettings::<Role>` in
`data/script/src/global.as`:

| Namespace | global.as line | Reference count |
| --- | --- | --- |
| `Global::RoleSettings::Tech` | 63 | 103 |
| `Global::RoleSettings::Air` | 272 | 68 |
| `Global::RoleSettings::Front` | 415 | 83 |
| `Global::RoleSettings::Support` | 545 | 24 |
| `Global::RoleSettings::Sea` | 609 | 58 |
| `Global::RoleSettings::Tactical` | 718 | 21 |

Four settings blocks declare `UseDynamicFactoryProduction` (Air, Front, Sea,
Tactical). **All four are `false`**, so `FactoryProduction` and the five
`factory_production/factory_configs_*.as` tables never execute - see
[hover.md](hover.md) for the full consequence. TECH and SUPPORT do not declare
the flag at all.

## Cross-role findings

Behaviour that is easier to see across the six files than inside any one of
them. None of these are fixed.

1. **Every `RoleMatch` predicate is an identity test.** All six reduce to
   `preferredMapRole == AiRole::<SELF>`. The `RoleMatchDelegate` machinery,
   `RoleConfigs::Match()` and its first-match-wins ordering therefore add no
   behaviour over a direct `RoleConfigs::Get(preferredMapRole)`. The `side`,
   `pos` and `defaultStartFactory` parameters are accepted and ignored by all
   six. Registration order is currently irrelevant because the predicates are
   mutually exclusive - a future non-identity predicate would silently make it
   matter.

2. **`SelectFactoryHandler` is duplicated verbatim in four roles.** FRONT, AIR,
   SEA and SUPPORT are character-for-character identical apart from the log
   prefix: return `FactoryHelpers::SelectStartFactoryForRole(...)` when
   `isStart` and the map start position resolves, else the fallback selector,
   else `""`. Only TACTICAL differs meaningfully - it forces the side's land
   hover plant before deferring to the generic selector. No role handles
   `isReset`.

3. **SUPPORT has no `FactoryAiMakeTaskHandler`.** It is the only role whose
   factories always reach `aiFactoryMgr.DefaultMakeTask` unmediated. Any
   reasoning that assumes "the role decides what its factories build" does not
   hold for SUPPORT.

4. **Start-limit application uses two incompatible styles.** AIR, FRONT, SEA and
   SUPPORT build a `dictionary` of hardcoded unit names and call
   `UnitHelpers::ApplyUnitLimits`. TACTICAL and TECH call
   `UnitHelpers::BatchApplyUnitCaps` over `UnitHelpers::GetAllT1BotLabs()`-style
   accessors with values from `Global::RoleSettings`. The first style hardcodes
   faction unit names inline and silently omits Legion in places; the second
   does not.

5. **Four handlers are empty or near-empty.** `Support_MainUpdate` and
   `Tactical_MainUpdate` have no body beyond a comment; `Air_EconomyUpdate` and
   `Tactical_EconomyUpdate` are empty. They are registered, so they cost a
   delegate call per tick for nothing.

6. **Copy-paste defects across role files.** See each role document's *Known
   defects*; the index-level ones are:
   - `Sea_ApplyStartLimits` logs `"Tactical start limits applied"` (`sea.as`).
   - `Support_BuilderAiMakeTask` logs with the `[FRONT]` prefix
     (`support.as`).
   - The whole `Global::RoleSettings::Tactical` block is commented as SEA
     (`"SEA BASE SETTINGS"`, `"Scout unit cap for SEA role"`) and is indented at
     4 spaces where the other five role blocks use 8.

7. **Dynamic military quota adjustment is inconsistent.** FRONT, AIR and SEA all
   run a `<Role>_UpdateDynamicMilitaryQuotas` from `MainUpdate` after a delay,
   but FRONT and AIR gate on a compile-time constant
   (`FRONT_DYNAMIC_QUOTA_DELAY_FRAMES`, `AIR_DYNAMIC_QUOTA_DELAY_FRAMES`) while
   SEA gates on a setting (`Global::RoleSettings::Sea::DynamicQuotaDelaySeconds`).
   TECH, SUPPORT and TACTICAL have no dynamic quota logic at all.

## Keeping these documents current

These documents describe code that changes. The rule is:

> **Any change under `data/script/src/roles/` requires the matching
> `doc/roles/*.md` to be updated in the same commit.**

Specifically:

| Change in AngelScript | Document that must change |
| --- | --- |
| Add or remove an `AiRole` enum member | this README, plus a new/removed role document |
| Add or remove a `@cfg.<Slot> = ...` line in a role's `Register()` | that role's document *and* the [coverage matrix](#handler-coverage-matrix) here |
| Add, remove or rename a slot on `RoleConfig` | [the contract](#the-contract) and the matrix here |
| Change `<Role>_Init` quotas, ally range or start limits | that role's document |
| Add or remove a `Global::RoleSettings::<Role>` value | that role's settings table |
| Fix any defect listed under *Known defects* | remove the entry, and the matching entry in [cross-role findings](#cross-role-findings) |

Enforcement has two layers.

**Content check** - `python tools/knowledge/check_role_docs.py` verifies, for
every `roles/<role>.as`: a `doc/roles/<role>.md` exists; its source marker
(`<!-- source: ...; blob: <git hash>; lines: N -->`, last line of the document)
matches the script's current blob hash and line count; every `<Role>_*` function
and every wired `RoleConfig` slot is named in the document; and the coverage
matrix above agrees with the wiring. A stale marker means the script changed
after the document was last reviewed. Review and update the document, then run
`python tools/knowledge/check_role_docs.py --update` to refresh the marker.

**Staging check** - `.githooks/pre-commit` refuses a commit that stages a file
under `data/script/src/roles/` without also staging the corresponding
`doc/roles/*.md`, and runs the content check when either is staged. Install it with:

```sh
git config core.hooksPath .githooks
```

To bypass once with a deliberate reason, `git commit --no-verify`.

## Related

- `doc/angelscript-references.md` - callback contracts and registered C++ API.
- `doc/knowledge/barb-status-by-topic.md` - this AI against the shared game
  knowledge base.
- `../rjm.bar.docs/knowledge/40-roles-and-counters/40-role-taxonomy.md` - the
  game-level role vocabulary these AI roles are distinct from. An `AiRole` is a
  whole-AI strategic posture; a knowledge-base role is a per-unit behaviour
  class. They share no members.

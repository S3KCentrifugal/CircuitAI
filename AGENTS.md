# CircuitAI Agent Instructions

These instructions apply to the entire repository. This is the canonical agent guidance for Codex, Claude, Copilot, Cursor, Windsurf, Gemini CLI, Grok, Qwen Code, Cline, Zed, Aider, Junie, and any other coding agent. Vendor-specific instruction files exist only to route here; they must not duplicate or override this file. "Repository Map" below lists every one of those router files, and describes every other file and folder this document names.

## Project Context

CircuitAI is a C++ Skirmish AI for the Recoil RTS engine. Native behavior is under `src/circuit/`. The primary, active AngelScript implementation and profiles are under the root `data/` tree: policy code is in `data/script/` and JSON behavior profiles are in `data/config/`. The parallel `data_sample/` tree contains sample AngelScript and configuration for reference only; it is not the implementation target. The C++ code is normally integrated into an engine checkout as a Skirmish AI and depends on Recoil's generated C++ AI wrapper.

Read `data/script/README.md` before changing AngelScript policy code. Apply `skills/convention-angelscript/SKILL.md` when writing or reviewing AngelScript; it defines version-compatible language, ownership, functional-style, safety, and performance practices. Read `doc/angelscript-references.md` for the current script loading model, callback contracts, registered C++ API, ownership rules, and practical usage examples. Use the shared knowledge base (`../rjm.bar.docs/knowledge/30-units/`, see "Game and Engine Knowledge Base") together with `doc/units.md` for the BAR base roster and `doc/extra_units.md` for the `experimentalextraunits` roster before changing UnitDef classifications, factory edges, or behavior properties. Read `data/script/CHANGE_RECOMMENDATIONS.md` when investigating BAR compatibility or historical API drift. See `doc/TRUSTED_REFERENCE_REPOSITORIES.md` for the external-reference map.

For every AngelScript or profile change, inspect and modify `data/`. Use `data_sample/` only to understand examples or historical patterns, and do not implement, mirror, or apply the requested change there unless the user explicitly asks to update sample material.

Do not create or update repository changelog entries automatically. Only when
the user explicitly requests a changelog, invoke
`skills/maintain-changelog/SKILL.md`.

Before searching for where something lives, read "Repository Map": it describes every file and folder referenced in this document, marks the active implementation against reference-only trees, and records which external paths are writable and which are read-only.

## Repository Map

Every path named anywhere in this document is described below, together with the
paths an agent needs in order to locate work without searching. Paths are
relative to the repository root unless shown as absolute or prefixed with
`../`. Read this section before searching: it identifies the authoritative
location for a change and separates the active implementation from
reference-only material.

### Agent instructions and skills

| Path | Description |
| --- | --- |
| `AGENTS.md` | This file. Canonical, harness-neutral agent guidance for the whole repository. Every other instruction file routes here and must not duplicate or override it. |
| `CLAUDE.md` | Router for Claude Code and other Claude agents. |
| `GEMINI.md` | Router for Gemini CLI. |
| `GROK.md` | Router for Grok CLI. |
| `QWEN.md` | Router for Qwen Code. |
| `CONVENTIONS.md` | Router for Aider (`aider --read CONVENTIONS.md`). |
| `.rules` | Router for Zed's agent panel. |
| `.github/copilot-instructions.md` | Router for GitHub Copilot repository custom instructions. |
| `.cursor/rules/circuitai.mdc` | Router for Cursor, as an always-applied project rule. |
| `.windsurf/rules/circuitai.md` | Router for Windsurf and Cascade. |
| `.clinerules/circuitai.md` | Router for Cline. |
| `.junie/guidelines.md` | Router for JetBrains Junie. |
| `skills/` | Repository skills in the Agent Skills format; one subdirectory per skill, each with a `SKILL.md`. |
| `skills/convention-angelscript/SKILL.md` | AngelScript conventions: version-compatible language subset, ownership, functional style, safety, performance. Apply when writing or reviewing AngelScript. |
| `skills/convention-angelscript/references/` | Supporting detail for that skill: `idioms.md`, `performance-and-safety.md`, `version-compatibility.md`. |
| `skills/maintain-changelog/SKILL.md` | Changelog entry format, timestamping, and file layout. Opt-in: invoke only when the user explicitly asks for a changelog. |
| `skills/troubleshoot-bar-logs/SKILL.md` | BAR runtime log investigation: size discipline, crash-marker search, AI log filtering, and symbolising `SkirmishAI.dll` stack offsets. |
| `.agents/skills/` | Symlinks that expose `skills/` to harnesses which discover skills under `.agents/`. Add a symlink here when adding a skill. |

### Active implementation - `data/`

This is the implementation target for every AngelScript and profile change.

| Path | Description |
| --- | --- |
| `data/` | The deployed AI data tree: engine metadata, JSON behaviour profiles, and AngelScript policy. |
| `data/AIInfo.lua` | Skirmish AI identity presented to the engine: name, version, interface. |
| `data/AIOptions.lua` | Player-visible options, including the `profile` list whose entries map to the profile directories below. See `doc/Profile.md` to add one. |
| `data/config/` | JSON behaviour profiles. Root-level files are the shared defaults; each profile directory overrides them with the fragments its `init.as` selects. |
| `data/config/behaviour.json` | Per-UnitDef behaviour defaults: roles, attributes, unit limits, threat values. |
| `data/config/block_map.json` | Structure placement and blocking geometry defaults. |
| `data/config/build_chain.json` | Build-chain rules: what a completed structure implies should follow it. |
| `data/config/commander.json` | Commander and dynamic-commander selection and loadout. |
| `data/config/economy.json` | Economy tuning: income targets, storage, conversion, and pull limits. |
| `data/config/factory.json` | Factory rosters, tiers, and production weights. |
| `data/config/response.json` | Threat-response tables mapping observed enemy composition to answers. |
| `data/config/easy/`, `data/config/medium/`, `data/config/hard/`, `data/config/hard_aggressive/` | Configuration for the legacy, native-driven difficulty profiles. Their behaviour comes from CircuitAI's native defaults plus this JSON rather than the shared role framework. |
| `data/config/experimental_balanced/`, `data/config/experimental_hard/`, `data/config/experimental_terrible/` | Configuration for the profiles driven by the shared AngelScript role framework. |
| `data/config/<profile>/*_leg.json` | Legion variant of a fragment, loaded only when the Legion mod option is active. |
| `data/config/<profile>/behaviour_extra_units.json` | Additional behaviour entries loaded when `experimentalextraunits` is active; see `doc/extra_units.md`. |
| `data/config/<profile>/behaviour_scav_units.json` | Additional behaviour entries loaded for Scavenger content. |
| `data/script/` | The AngelScript policy layer: role selection, manager tuning, task enqueueing, strategic state. |
| `data/script/README.md` | Authoritative description of script loading, profile structure, the shared foundation, and the experimental runtime sequence. **Read before changing AngelScript policy code.** |
| `data/script/CHANGE_RECOMMENDATIONS.md` | Compatibility against the current C++ bindings and recommended migrations. Read when investigating BAR compatibility or historical API drift. |
| `data/script/HOVER_FACTORY_IMPLEMENTATION.md` | Implementation notes for hover production; pairs with `doc/roles/hover.md`. |
| `data/script/<profile>/init.as` | Returns `SInitInfo`, initialises armour and category masks, and selects this profile's JSON fragments. |
| `data/script/<profile>/main.as` | Profile entry hooks. Empty or commented in the legacy profiles; in the experimental profiles it registers maps, strategy weights, factory tiers, profile tuning, periodic threat and cost updates, and Lua message handling. |
| `data/script/src/` | The shared AngelScript graph that the experimental profiles include through `src/setup.as`. |
| `data/script/src/common.as` | Shared initialisation data - armour definitions and categories - used by every profile `init.as`. |
| `data/script/src/define.as` | Script constants, aliases, masks, priorities, and random helpers expected by all modules. |
| `data/script/src/global.as` | Global script state shared across modules. |
| `data/script/src/setup.as` | Include root for the shared graph. `Setup::setupMap()` resolves map, start spot, faction, role, unit-limit overlays, and role delegates, and logs the deterministic startup snapshot. |
| `data/script/src/unit.as` | Unit lifecycle hooks reaching script from the native managers. |
| `data/script/src/task.as` | Task hooks: `AiMakeTask`, `AiTaskAdded`, `AiTaskRemoved`, and related policy. |
| `data/script/src/maps.as` | Map registration and lookup for the per-map configurations. |
| `data/script/src/maps/` | One file per supported map, plus `default_map_config.as` as the fallback and `factory_mapping.as` for terrain-to-factory selection. |
| `data/script/src/manager/` | Script-side manager policy: `builder.as`, `economy.as`, `factory.as`, `military.as`, `team.as`, `objective_manager.as`, and `factory_production.as` with `factory_production/factory_configs_{air,bot,hover,sea,vehicle}.as`. |
| `data/script/src/roles/` | Role delegates that specialise shared manager behaviour: `air.as`, `front.as`, `sea.as`, `support.as`, `tactical.as`, `tech.as`. |
| `data/script/src/types/` | Script value types: `ai_role.as`, `building_type.as`, `map_config.as`, `opener.as`, `profile.as`, `profile_controller.as`, `role_config.as`, `start_spot.as`, `strategic_objectives.as`, `strategy.as`, `terrain.as`. |
| `data/script/src/helpers/` | Stateless helpers grouped by domain: builder, collection, defense, economy, factory, generic, guard, limits, map, objective (with `objective_executor.as`), role, role-limit, task, terrain, unit, and unitdef. |
| `data/script/src/misc/commander.as` | Commander-specific script policy. |

### Reference only - `data_sample/`

| Path | Description |
| --- | --- |
| `data_sample/` | Upstream sample AngelScript and JSON kept for reference and historical comparison. Mirrors the `data/` shape: `AIInfo.lua`, `AIOptions.lua`, `config/` (with `dev/`), and `script/` (`common.as`, `define.as`, `task.as`, `unit.as`, with `dev/`). Never implement, mirror, or apply a requested change here unless the user explicitly asks for sample maintenance. |

### Native C++ - `src/`

| Path | Description |
| --- | --- |
| `src/AIExport.cpp`, `src/AIExport.h` | Skirmish AI ABI entry points that the engine loads. |
| `src/circuit/CircuitAI.cpp`, `src/circuit/CircuitAI.h` | Top-level AI object: engine event dispatch, module ownership, lifecycle. |
| `src/circuit/module/` | Native managers - `BuilderManager`, `EconomyManager`, `FactoryManager`, `MilitaryManager` - over the `Module` and `TaskModule` bases. |
| `src/circuit/script/` | AngelScript integration and the registration surface: `InitScript`, `ModuleScript`, the per-manager `BuilderScript`, `EconomyScript`, `FactoryScript`, `MilitaryScript`, plus `Script.cpp` and `RefCounter.h`. **A native C++ method is not script-accessible unless it is registered here.** |
| `src/circuit/task/` | Task hierarchy: `UnitTask`, `IdleTask`, `NilTask`, `PlayerTask`, `RetreatTask`, plus the `builder/`, `common/`, `fighter/`, and `static/` task families. |
| `src/circuit/unit/` | `CircuitDef` (UnitDef wrapper and classification), `CircuitUnit`, `CircuitWDef` (weapon defs), `CoreUnit`, `FactoryData`, and the `action/`, `ally/`, `enemy/` subtrees. Classification and economy logic that reads BAR custom parameters lives here. |
| `src/circuit/map/` | `MapManager`, `ThreatMap`, `InfluenceMap`, `GridAnalyzer`. |
| `src/circuit/resource/` | Resource model: `MetalData`, `EnergyData`, `EnergyManager`, `EnergyGrid`, `EnergyLink`, `EnergyNode`, `GridLink`. |
| `src/circuit/terrain/` | `TerrainManager`, `TerrainData`, blocking-map geometry (`BlockingMap`, `BlockCircle`, `BlockMask`, `BlockRectangle`), and `path/` with `PathFinder`, `MicroPather`, `PathQuery`, `PathInfo`, and the cost and line query maps. |
| `src/circuit/setup/` | `SetupManager`, `SetupData`, `DefenceData`: start position, faction selection, and defence layout. |
| `src/circuit/scheduler/` | `Scheduler` and `SchedulerJob` for deferred and periodic work. |
| `src/circuit/spring/` | Adapters over Recoil's generated C++ AI wrapper: `SpringCallback`, `SpringEngine`, `SpringMap`, `SpringUnit`. |
| `src/circuit/util/` | Shared utilities: `Action` and `ActionList`, `AvailList`, `Container`, `Data`, `Defines.h`, `ExtAS.h`, `FileSystem.h`, `GameAttribute`, `DebugDrawer`, and math and geometry helpers. |
| `src/lib/` | Vendored third-party libraries: `angelscript/`, `asbind20/`, `json/`, `kdtree/`, `lemon/`, `triangulate/`. Do not edit unless the task explicitly targets them. |
| `src/lib/README.md` | Provenance and upstream source for each vendored library. |

### Documentation - `doc/`

| Path | Description |
| --- | --- |
| `doc/TRUSTED_REFERENCE_REPOSITORIES.md` | The external-reference map: how the read-only BAR and Recoil clones and the writable shared knowledge base inform work here. |
| `doc/angelscript-references.md` | The current script loading model, callback contracts, registered C++ API, ownership rules, and practical usage examples. Read before AngelScript work. |
| `doc/units.md` | Catalog of the 659 effective non-Scavenger BAR UnitDefs (215 Armada, 213 Cortex, 231 Legion). Use with the shared knowledge base before changing UnitDef classifications, factory edges, or behaviour properties. |
| `doc/extra_units.md` | Catalog of the 41 UnitDefs made player-buildable by BAR's `experimentalextraunits=true` option. |
| `doc/Profile.md` | How profiles are deployed and how to add a custom one, including the `AIOptions.lua` `profile` list and the `BARb/stable/` install layout. |
| `doc/roles/tech.md` | Deep reference for the `TECH` AngelScript role: loading, callbacks, registered APIs it depends on, gating, and known breakage. |
| `doc/roles/hover.md` | Deep reference for hover production: ownership, build decisions, the native contract, and the cause of hover production stalling once a T2 factory exists. |
| `doc/bomber-targeting.md` | Diagnosed but unfixed bomber-targeting investigation with a phased remediation plan. |
| `doc/t2-constructor-stall.md` | Diagnosed but unfixed T2 constructor stall after mex upgrades, with three options awaiting a decision. |
| `doc/knowledge/README.md` | Index of CircuitAI-specific knowledge and the pointer to the shared game knowledge base. |
| `doc/knowledge/90-agent-decision-guides/` | Agent decision guides tied to this AI's hooks: `90-decision-architecture.md`, `91-build-order-selection.md`, `92-response-tables.md`, `93-engagement-rules.md`, `94-economy-policies.md`, `95-open-questions.md`. |
| `doc/knowledge/barb-unit-config.md` | Generated: every reachable unit's roles, attributes, limits, threat, factory lists, and script references across all profiles, joined to the shared unit cache, plus the configuration gap lists. |
| `doc/knowledge/barb-status-by-topic.md` | Where this AI stands against each game-knowledge topic. |

### Tooling, build, and support

| Path | Description |
| --- | --- |
| `tools/knowledge/barb_report.py` | Regenerates `doc/knowledge/barb-unit-config.md`. Run `python tools/knowledge/barb_report.py` after profile or unit-cache changes. |
| `CMakeLists.txt` | Native build definition. Building requires integration into an engine checkout and Recoil's generated C++ AI wrapper. |
| `VERSION` | AI version string. |
| `platform/angelscript/jit/` | AngelScript JIT compiler sources (`as_jit.cpp`, `virtual_asm*`). Platform support, not policy. |
| `util/` | Development aids that are not shipped: `boost_log.sh`, `cpu_load.cpp`, `crash_test.py`, the `fibR.as` and `fibR.lua` benchmarks, `gdb.cmd` and `gdb.sh`, `head.script`, `tracy.txt`, `weight_normal.txt`. |
| `util/LuaRules/Gadgets/ai_chokepoint.lua`, `util/LuaRules/Gadgets/ai_dbg_map.lua` | In-game debug gadgets for visualising chokepoints and AI map data. |
| `Vagrantfile` | Vagrant build environment definition. |
| `CircuitAI.uxf` | UMLet class diagram of the native design. |
| `.cproject`, `.project` | Eclipse CDT project files. |
| `README.md` | Upstream build and run notes; self-marked as needing an update. |
| `LICENSE` | License text. |
| `BARB5_CHANGELOG.md` | Historical BARb5 changelog, superseded by `changelog/`. |
| `changelog/YYYY/MM/DD/` | Date-partitioned changelog entries. Created only on explicit request, via `skills/maintain-changelog/SKILL.md`. |

### External paths

| Path | Access | Description |
| --- | --- | --- |
| `../rjm.bar.docs/` (`C:\bardev\rjm.bar.docs`) | writable | Shared game knowledge base for every project under `C:\bardev`, and the central source of game truth. See "Game and Engine Knowledge Base". |
| `../rjm.bar.docs/AGENTS.md` | writable | That repository's own agent instructions; follow them when writing there. |
| `../rjm.bar.docs/knowledge/README.md` | writable | Entry point for every game and engine question - search here first. |
| `../rjm.bar.docs/knowledge/30-units/<faction>/<id>.md` | writable | One page per unit, factions `armada`, `cortex`, `legion`; `39-unit-schema.md` defines the page shape. |
| `../rjm.bar.docs/knowledge/20-game-mechanics/20-lua-mechanics-catalog.md` | writable | Engine and Lua mechanics catalog, alongside `21-resources.md`, `22-tech-tiers.md`, `23-special-systems.md`, `24-game-modes-and-options.md`. |
| `../rjm.bar.docs/knowledge/` (remainder) | writable | `00-glossary.md`, `10-engine/`, `40-roles-and-counters/`, `50-economy/`, `60-tactics/`, `70-strategy/`, `80-theory/`, `appendix/`, `img/`. |
| `../rjm.bar.docs/tools/knowledge/extract.py` | writable | Refreshes the shared unit cache that `tools/knowledge/barb_report.py` joins against. |
| `C:\bardev\bar-Beyond-All-Reason` | **read-only** | BAR game clone: UnitDefs, WeaponDefs, MoveDefs, build menus, custom parameters, faction and mod options, Lua rules, models, unit scripts. |
| `C:\bardev\bar-Beyond-All-Reason\gamedata\unitdefs.lua` | **read-only** | Recursively loads `units/**/*.lua` and gates Legion, Scavenger, Raptor, and extra content on game and mod options. |
| `C:\bardev\bar-Beyond-All-Reason\gamedata\unitdefs_post.lua` | **read-only** | Normalises and transforms UnitDefs after loading. |
| `C:\bardev\bar-Beyond-All-Reason\gamedata\alldefs_post.lua` | **read-only** | Further post-processing that can alter build options and properties. |
| `C:\bardev\bar-Beyond-All-Reason\gamedata\unitDefRenames.lua` | **read-only** | Legacy-to-descriptive unit name mappings. This repository's configuration still uses legacy internal names. |
| `C:\bardev\bar-RecoilEngine` | **read-only** | Engine clone: Skirmish AI ABI, callbacks, events, commands, C++ wrapper generation, loading, engine integration. |
| `C:\bardev\bar-RecoilEngine\.gitmodules` | **read-only** | Declares `AI/Skirmish/BARb` and `AI/Skirmish/CircuitAI` as submodules. Verify the layout of any given checkout rather than assuming it. |
| `%LOCALAPPDATA%\Programs\Beyond-All-Reason\data\` | runtime | BAR's writeable data directory: `infolog.txt`, `log/`, `demos/`, `_script.txt`, `ClientGameState-*.txt`. See "Runtime Logs and Diagnostics". |

## Game and Engine Knowledge Base

Game knowledge that is not specific to this AI lives in the sibling
repository `C:\bardev\rjm.bar.docs` (relative: `../rjm.bar.docs`). It is the
central source of game truth for every project under `C:\bardev`: one page per
unit with thumbnails, engine and Lua mechanics, economy arithmetic, counters,
tactics, strategy and theory, all with provenance front-matter.

- For any question about the game or engine - a unit's stats or counters, a
  mechanic, a mod option, an economy number, how something is played - search
  `../rjm.bar.docs/knowledge/` **first**: start at `knowledge/README.md`,
  units at `knowledge/30-units/<faction>/<id>.md`, mechanics at
  `knowledge/20-game-mechanics/20-lua-mechanics-catalog.md`. Read the BAR or
  Recoil trees only when the knowledge base lacks the fact, and then record
  the fact there (it is writable; follow its `AGENTS.md`).
- Knowledge specific to CircuitAI stays in this repository:
  `doc/knowledge/README.md` indexes it (agent decision guides, the generated
  `barb-unit-config.md` joining our profiles to the shared unit cache, and
  `barb-status-by-topic.md`). Regenerate the join with
  `python tools/knowledge/barb_report.py` after profile or cache changes.
- Do not copy game facts into this repository; link or name the path in the
  knowledge base instead. Do not put AI-implementation detail into the
  knowledge base.

## Trusted Read-Only References

Two sibling repositories are authoritative local references:

| Repository | Path | Use |
| --- | --- | --- |
| Beyond All Reason game | `C:\bardev\bar-Beyond-All-Reason` | UnitDefs, WeaponDefs, MoveDefs, build menus, custom parameters, faction/mod options, Lua rules, models, and unit scripts |
| RecoilEngine | `C:\bardev\bar-RecoilEngine` | Skirmish AI ABI, callbacks, events, commands, C++ wrapper generation, loading, and engine integration |

Treat both paths as strictly read-only, even when a requested change appears to belong there.

- Never edit, create, delete, rename, format, or generate files in either tree.
- Never run builds, tests, package installation, code generation, formatters, checkout, reset, clean, submodule update, or other write-producing commands there.
- Limit commands with an external repository as their working directory to inspection such as file reads, directory listings, `git status`, `git log`, `git show`, `git diff`, `git grep`, and `git ls-files`.
- Put every requested implementation or documentation change in this CircuitAI repository. If an upstream change is needed, report it and identify its target file without applying it.
- Do not follow a path into an external tree and then write through it. Resolve links and repository boundaries before editing.

Recoil's `.gitmodules` declares `AI/Skirmish/BARb` and `AI/Skirmish/CircuitAI` as Git submodules. In the currently inspected checkout they are ordinary submodule worktree directories, not symbolic links. Do not assume another checkout has the same filesystem layout; verify it read-only when integration details matter.

## Source-of-Truth Routing

Use the narrowest authoritative source for a question:

- CircuitAI behavior, bindings, and configuration: this repository.
- Game and engine facts, mechanics, unit data and doctrine: `../rjm.bar.docs/knowledge/` first (see "Game and Engine Knowledge Base"), then the read-only BAR and Recoil trees for anything it lacks.
- Names and properties visible after BAR game-data loading: BAR's effective UnitDef pipeline, not a raw unit file alone.
- Engine callback availability or ABI behavior: Recoil's C interface and generated C++ wrapper inputs, not stale Spring documentation.
- AngelScript availability: registration code under `src/circuit/script/`. A native C++ method is not script-accessible unless it is registered.

For BAR compatibility work, account for this pipeline:

1. `gamedata/unitdefs.lua` recursively loads `units/**/*.lua` and gates Legion, Scavenger, Raptor, and extra content using game and mod options.
2. `gamedata/unitdefs_post.lua` normalizes and transforms definitions; `gamedata/alldefs_post.lua` and Scavenger post-processing can further alter build options and properties.
3. Invalid build options are removed when their target UnitDef is absent.
4. `gamedata/unitDefRenames.lua` records legacy-to-descriptive name mappings. CircuitAI configuration currently uses legacy internal names, so verify the actual runtime name before migrating identifiers.

When changing classification or economy logic, check BAR values used by CircuitAI, including `level`, `pylonrange`, `income_energy`, `energyconv_capacity`, `energyconv_efficiency`, `isairbase`, `canjump`, `jump_range`, `is_drone`, `dynamic_comm`, `iscommander`, and relevant weapon custom parameters. Treat optional-faction units as unavailable unless the corresponding BAR option makes them loadable.

## Engineering Workflow

- Start from the failing behavior, binding, profile, or configuration entry and trace to the code that controls it.
- Preserve existing C++ and AngelScript style and keep changes scoped.
- Make AngelScript and profile changes in `data/`, never `data_sample/`; the latter is reference-only unless the user explicitly requests sample maintenance.
- Do not edit vendored libraries under `src/lib/` unless the task explicitly targets them.
- Do not assume a generic AngelScript interface exposes derived-type members. Use registered casts and handle a null cast result.
- Do not infer a valid factory edge merely because both UnitDefs exist. Verify the builder's effective BAR `buildoptions` under the relevant mod options.
- Avoid changing the legacy profiles (`easy`, `medium`, `hard`, `hard_aggressive`) and the shared-framework profiles (`experimental_balanced`, `experimental_hard`, `experimental_terrible`) together unless the requirement explicitly spans them.

## Runtime Logs and Diagnostics

Beyond All Reason writes its runtime log to the writeable data directory of the
local install. Do not hard-code a username; the layout is portable:

| Artifact | Path |
| --- | --- |
| Current run | `%LOCALAPPDATA%\Programs\Beyond-All-Reason\data\infolog.txt` |
| Archived runs | `%LOCALAPPDATA%\Programs\Beyond-All-Reason\data\log\<YYYYMMDDHHMMSS>_infolog.txt` |
| Replays, setup, desync dumps | `demos\`, `_script.txt`, `ClientGameState-*.txt` in the same data directory |

In Git Bash, `$LOCALAPPDATA` expands correctly. If the install is relocated,
the log records the authoritative directory on its `FindWriteableDataDir` line.

`infolog.txt` is overwritten on every launch, and `RotateLogFiles = 1` archives
the previous run under `log/`. These files are frequently hundreds of megabytes
and over a million lines, dominated by CircuitAI's own `:::AI LOG` output.
Never read one whole. Establish size, locate the incident with `grep -n`, then
read a bounded window. Apply `skills/troubleshoot-bar-logs/SKILL.md` when
investigating a crash, a runtime misbehaviour, a desync, or a startup failure;
it covers size discipline, crash-marker search, AI log filtering, and
symbolising `SkirmishAI.dll` stack offsets.

## Validation

Use the cheapest focused validation available in this repository, then broaden according to risk.

- Run diagnostics for edited C++ or AngelScript files.
- For configuration changes, parse the changed JSON and check referenced UnitDef names/build edges against the effective BAR data pipeline.
- Use `git diff --check` before finishing.
- Runtime AngelScript changes require loading the affected profile in BAR because this repository has no standalone AngelScript compilation target.
- Native integration builds require Recoil's C++ AI wrapper. Never build inside the trusted read-only Recoil checkout; use a separate writable checkout/build environment or report that runtime validation remains pending.

Record validation performed and distinguish static checks from in-game or engine-runtime verification.

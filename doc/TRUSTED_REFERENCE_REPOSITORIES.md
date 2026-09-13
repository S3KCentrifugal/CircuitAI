# Trusted Reference Repositories

This document records how the local Beyond All Reason and RecoilEngine clones inform CircuitAI development. Both repositories are trusted evidence and strictly read-only. The operational rules are in [`../AGENTS.md`](../AGENTS.md).

## Beyond All Reason

Path: `C:\bardev\bar-Beyond-All-Reason`

BAR is the authority for game content presented to CircuitAI. A raw unit file is only one input; Lua loading and post-processing determine the effective definitions and build graph.

### Effective UnitDef Pipeline

1. `gamedata/unitdefs.lua` discovers `units/**/*.lua` recursively.
2. It conditionally includes Legion, Scavenger, Raptor, and extra-unit content from game type and mod options such as `experimentallegionfaction`, `experimentalextraunits`, `scavunitsforplayers`, `ruins`, `zombies`, and `forceallunits`.
3. `gamedata/unitdefs_post.lua` lowercases keys, ensures `customparams`, `buildoptions`, `weapondefs`, and `weapons` tables exist, creates variants, and applies broader post-processing.
4. `gamedata/alldefs_post.lua` and `gamedata/scavengers/unitdef_post.lua` can add, remove, filter, or deduplicate build options.
5. `gamedata/unitdefs.lua` removes definitions with missing models and strips build options whose target UnitDef did not load.

Consequences for CircuitAI:

- Validate names and builder edges against effective definitions for the intended mod options.
- A UnitDef existing on disk does not prove it is available in a match.
- A target UnitDef existing does not prove a particular factory can build it.
- Optional Legion and Scavenger configuration must remain gated.
- `gamedata/unitDefRenames.lua` is useful for relating legacy internal names to descriptive names, but a rename mapping alone does not establish the identifier exposed through the Skirmish AI callback.

BAR includes a real-definition test harness at `spec/gamedata/unitdefs_spec.lua`; it demonstrates loading processed UnitDefs and checking representative legacy IDs such as `armcom`, `corcom`, `armpw`, and `corak`. Run such tests only in a separate writable checkout.

### Content Map

| Concern | BAR source |
| --- | --- |
| Raw units and builder `buildoptions` | `units/Arm*`, `units/Cor*`, `units/Legion`, `units/Scavengers`, and other `units/` subtrees |
| Unit loading and filtering | `gamedata/unitdefs.lua` |
| Unit transformations and variants | `gamedata/unitdefs_post.lua`, `gamedata/alldefs_post.lua`, `gamedata/scavengers/` |
| Legacy/descriptive name mapping | `gamedata/unitDefRenames.lua` |
| Movement classes and terrain limits | `gamedata/movedefs.lua` plus each unit's `movementclass` |
| Weapon definitions | Embedded unit `weapondefs`, `weapons/`, `gamedata/weapondefs.lua`, and `gamedata/weapondefs_post.lua` |
| Factions and commanders | `gamedata/sidedata.lua`, `gamedata/sides_enum.lua` |
| Game feature gates | `modoptions.lua` and game-type utilities used by `gamedata/unitdefs.lua` |
| Models and animations | `objects3d/`, `anims/`, and unit `objectname` fields |
| Unit animation/behavior scripts | `scripts/` and unit `script` fields |
| Synced gameplay behavior | `luarules/` and shared code under `common/` and `modules/` |

### Fields Consumed by CircuitAI

CircuitAI reads standard UnitDef/WeaponDef data and BAR custom parameters. Current native consumers include:

- Economy and grid: `level`, `pylonrange`, `income_energy`, `energyconv_capacity`, `energyconv_efficiency`, `isairbase`.
- Unit classification: `canjump`, `jump_range`, `is_drone`, `dynamic_comm`, `iscommander`, `midposoffset`.
- Weapon valuation: `fake_weapon`, `disarmdamageonly`, `timeslow_onlyslow`, `timeslow_damagefactor`, `is_capture`, `extra_damage`, `area_damage_dps`, `area_damage_is_impulse`, `statsdamage`.

Search both raw definitions and BAR post-processing when one of these fields changes. Some fields are synthesized or normalized after the raw file loads.

## RecoilEngine

Path: `C:\bardev\bar-RecoilEngine`

Recoil is the authority for CircuitAI's engine-facing ABI and generated C++ wrapper. Its root `.gitmodules` declares two CircuitAI-family submodules:

- `AI/Skirmish/BARb`, tracking the `barbarian` branch.
- `AI/Skirmish/CircuitAI`, tracking the `zk` branch.

The inspected directories are ordinary Git submodule worktrees, not symbolic links. Other local setups may differ, so inspect rather than assume.

### ABI and Wrapper Map

| Concern | Recoil source |
| --- | --- |
| AI library lifecycle and `handleEvent` entrypoint | `rts/ExternalAI/Interface/SSkirmishAILibrary.h` |
| Stable event topic IDs and payload structs | `rts/ExternalAI/Interface/AISEvents.h` |
| Stable command topic IDs and payload structs | `rts/ExternalAI/Interface/AISCommands.h` |
| Read callbacks and command dispatch | `rts/ExternalAI/Interface/SSkirmishAICallback.h` |
| AI and interface data-directory metadata | `rts/ExternalAI/Interface/SSkirmishAILibrary.h`, `rts/ExternalAI/Interface/SAIInterfaceLibrary.h` |
| Engine-side loading and dispatch | `rts/ExternalAI/SkirmishAILibrary.*`, `SkirmishAIWrapper.*`, `SkirmishAIHandler.*`, `EngineOutHandler.*` |
| Generated object-oriented callback wrapper | `AI/Wrappers/Cpp/CMakeLists.txt`, `AI/Wrappers/Cpp/bin/`, generated `src-generated/` build output |

Important boundaries:

- `SSkirmishAILibrary` defines per-instance `init`, `release`, and `handleEvent` lifecycle hooks.
- `AISEvents.h` defines engine-to-AI events, including frame updates, unit lifecycle, LOS/radar changes, damage, commands, save/load, and Lua messages.
- `SSkirmishAICallback` exposes read-only queries and routes state-changing operations through `Engine_handleCommand` or `Engine_executeCommand`.
- `AISCommands.h` owns command topic values and payload contracts. Topic numeric values are ABI-stable and must not be inferred or reordered.
- Recoil's CMake wrapper generation parses the C interface into generated `Abstract*`, `Stub*`, and `Wrapp*` sources. CircuitAI's `CMakeLists.txt` consumes the resulting `Cpp_AIWRAPPER_TARGET` and include directories.
- Data directories such as `dataDir` and `dataDirCommon` are engine-provided Skirmish AI properties. Packaging and profile lookup should follow those contracts rather than hard-coded installation paths.

## AngelScript Boundary

Recoil supplies the native Skirmish AI substrate, but CircuitAI defines its own AngelScript surface. The authoritative registrations are under `src/circuit/script/`, especially `InitScript.cpp` and module-specific registration files. Compare script calls against those registrations, not merely against native class declarations.

For changes crossing all three layers, trace in this order:

1. BAR effective game data and options.
2. Recoil C ABI or generated wrapper type.
3. CircuitAI native adaptation and AngelScript registration.
4. `data/script/` policy usage and profile configuration.

This ordering separates missing game content, engine API drift, binding omissions, and script type errors instead of treating them as one compatibility problem.
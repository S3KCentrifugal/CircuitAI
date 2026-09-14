# CircuitAI Agent Instructions

These instructions apply to the entire repository. This is the canonical agent guidance for Codex, Copilot, Claude, Grok, and other coding agents. Vendor-specific files should only route here and must not duplicate or override it.

## Project Context

CircuitAI is a C++ Skirmish AI for the Recoil RTS engine. Native behavior is under `src/circuit/`. The primary, active AngelScript implementation and profiles are under the root `data/` tree: policy code is in `data/script/` and JSON behavior profiles are in `data/config/`. The parallel `data_sample/` tree contains sample AngelScript and configuration for reference only; it is not the implementation target. The C++ code is normally integrated into an engine checkout as a Skirmish AI and depends on Recoil's generated C++ AI wrapper.

Read `data/script/README.md` before changing AngelScript policy code. Apply `skills/convention-angelscript/SKILL.md` when writing or reviewing AngelScript; it defines version-compatible language, ownership, functional-style, safety, and performance practices. Read `doc/angelscript-references.md` for the current script loading model, callback contracts, registered C++ API, ownership rules, and practical usage examples. Use `doc/units.md` for the BAR base roster and `doc/extra_units.md` for the `experimentalextraunits` roster before changing UnitDef classifications, factory edges, or behavior properties. Read `data/script/CHANGE_RECOMMENDATIONS.md` when investigating BAR compatibility or historical API drift. See `doc/TRUSTED_REFERENCE_REPOSITORIES.md` for the external-reference map.

For every AngelScript or profile change, inspect and modify `data/`. Use `data_sample/` only to understand examples or historical patterns, and do not implement, mirror, or apply the requested change there unless the user explicitly asks to update sample material.

Do not create or update repository changelog entries automatically. Only when
the user explicitly requests a changelog, invoke
`skills/maintain-changelog/SKILL.md`.

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
- Avoid changing legacy, experimental, and `data_v2` implementations together unless the requirement explicitly spans them.

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
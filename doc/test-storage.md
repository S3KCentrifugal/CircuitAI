# Gameplay test and benchmark storage

Current storage (2026-10-07): published benchmarks, historical images and raw
`build-theatres` archives now live in the sibling `CircuitAI.benchmarks`
checkout. Set `CIRCUIT_BENCHMARK_REPO` for another location. See the
[migration and current commands](benchmark-repository.md). Historical paths below are
preserved for provenance; this machine retains an ignored raw-path junction.


## Review and migration plan (2026-10-03)

The starting inventory has 81 flat check definitions, 16 AIR arena cases,
70 committed benchmark files, 60 screenshots and 306 directories under
`build-theatres/` (129,211 files including staged game data and caches).
Cases, launch directories, raw observations and benchmark conclusions need
different lifecycles.

The scorecard store already has immutable IDs, dated records and strict
comparison cohorts. Retain it and its ratings unchanged. The TECH rush ledger
also retains every historical row. Do not convert missing historical metadata
into invented settings, successful verdicts or comparable performance numbers.

Implement the following structure without moving historical run directories:

```text
tools/playtest/
  cases/<role-or-shared>/<area>/<scenario>.json
  checks/<role-or-shared>/<area>/<check>.json
  fixtures/                     reusable scripts and observers remain here
  widgets/
  storage.py                    resolution, allocation, archiving and indexing
  storage-aliases.json           old case/check paths mapped to canonical files

build-theatres/                  ignored, machine-local
  games/<domain>/<area>/<scenario>/<map>/<utc-id>/
    run-plan.json               classification and requested experiment
    AI/, LuaUI/, cache/         disposable engine working state
    runs/<utc-id>/              retained raw run snapshots
      infolog.txt, report.md, result.json, checks.json
      script.txt, teams.json, staged.json, launched.json
      run-inputs.json           actual staged build/settings hashes
      <fixture metadata>, <screenshots>
  <historical directories>/     retain their original paths

doc/benchmarks/                  versioned, portable evidence and indices
  README.md, catalog.json, index/<domain>.md
  records/<domain>/<area>/<scenario>/<date>/<utc-id>/
    result.json, report.md, checks.json, run-inputs.json
    <selected screenshots>
  scorecards/, lane-workers/    existing dated stores remain authoritative
  <historical files>            unchanged; indexed rather than renamed
```

Domains are `air`, `tech`, `front`, `sea`, `tactical`, `support`, or `shared`.
Areas are `combat`, `economy`, `layout`, `strategy`, `terrain`, `performance`,
`cooperation`, or `reliability`. Scenario and map directory names are short
lowercase kebab-case; full map version, faction, profile and seed belong in
metadata, not a long Windows path. Keep decision IDs such as D-177 as metadata
or documentation links, rather than the only way to discover an experiment.

Distinguish `natural`, `supplied`, `benchmark`, and `regression` runs. Supplied
combat results must never enter natural economy leaderboards. Keep map/game
versions and checksums, engine identity, conditions, side swaps, seeds, tested
build/data identity, verdict and observation duration with each comparison.
Missing values remain missing. Use scorecard's existing comparison contract
for strength claims; a directory category does not establish comparability.

New run/archive IDs use UTC seconds plus a random suffix. Allocation must be
exclusive, never silently reuse an existing directory. An immutable publication
must be idempotent for identical content and reject a conflicting ID. Generated
indices can be rebuilt; raw evidence, failures, censored games and historical
benchmark rows cannot be silently replaced or pruned.

Migration must preserve each moved case/check byte-for-byte, retain old short
CLI names and old explicit paths through aliases, update repository links,
and make the invariant checker recursive. Snapshot historical benchmark/image
hashes before the move and compare afterward. Add tests for aliases, ambiguity,
path containment, collision handling, archive provenance and immutable results.
No AI gameplay policy or simulation result is changed by the migration.

Do not recursively index engine caches or duplicate all DLLs into Git. Keep
raw logs/replays locally, commit compact measurements and selected screenshots,
and never automatically delete historical working directories. Archive backups
or an external artifact store are needed before any later storage cleanup.

## Implementation and validation

Implemented the layout above. All 81 checks and 16 AIR scenarios were moved
without content changes; all 70 historical benchmark files and 60 historical
images retained their paths and bytes. The [migration inventory](test-storage-moves.md)
links every moved definition; the [cutover manifest](test-storage-migration.json)
records the original SHA-256 values. This is a one-time migration audit, not a
rule forbidding future intentional scenario edits or a cross-platform newline
normalization test. Old short names and old explicit paths resolve through
[aliases](../tools/playtest/storage-aliases.json).

AIR and scorecard runners allocate unique directories by default. The TECH
rush loop allocates one per objective unless `DIR` explicitly requests reuse;
its `lobby-map` folder is a placeholder until `teams.json` records the actual
lobby-selected map. The generic runner retains its legacy default for command
compatibility; allocate a categorized path for new experiments:

```powershell
$gameDir = python tools/playtest/storage.py allocate --domain tech --area economy --scenario rush-afus --map supreme --kind benchmark
python tools/playtest/playtest.py run --dir $gameDir --roles TECH --checks rush_afus --set 'RushObjective="afus"' --speed 8 --minutes 24
python tools/playtest/storage.py publish <printed-archive-path> --screenshot <selected-filename.png>
python tools/playtest/storage.py find --domain air --area combat --kind supplied
python tools/playtest/storage.py index
python tools/playtest/storage.py verify-migration
```

The watcher snapshots actual staged AI, observer and engine hashes before
launch, then retains original checks, setup and reports in the archive. It
records stopped failures as well as passes. `complete` means observation has
stopped, not that the match ended in a confirmed victory. A live `--no-stop`
snapshot cannot be published as completed. Post-run analyses have separate
publication hashes and cannot silently replace the original observation.
Git preserves the exact bytes of published bundles with a scoped attribute.

The rush ledger uses an exclusive writer lock and atomic replacement. An
identical row is a no-op; a conflicting run ID fails without changing history.
After a crashed writer, inspect and remove its `tech-rush.md.lock` only after
confirming no writer is active. Scorecard processing reads archived inputs
before any reusable working directory and keeps runtime enrichment separate.
Existing cohort, rating and censoring rules remain unchanged.

Validation includes alias coverage for all 97 definitions, collisions,
containment, immutable publication, failure preservation, original-input
provenance, scorecard processing after restaging, and rush-ledger concurrency.
All 66 playtest tooling tests pass. The invariant and role-document checkers
pass; the documentation-link checker reports only the eight pre-existing
missing `hover.md` links tracked as KI-404. `git diff --check` is clean.
One rendered four-minute Cortex arena on All That Glitters exercised allocation,
staging, launch, archive, analysis, publication and indexing end to end:
[original report and selected screenshot](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/air/combat/direct-glitters/2026-10-03/20261003T130427Z-8c8bf821/README.md).
The strict direct-route checks passed; the AFUS was destroyed at 2:14 game time.
This validates the tooling path, not an AI strength improvement or a full-match
win. No production AI code or binary changed.

Raw logs, engine caches and replays remain local. The publisher records the raw
log hash and path but does not put the log, replay, DLL or cache into Git. Replays
remain in the engine write directory, separate from the report snapshot.
Back up those directories before any future cleanup. Generated indices are
disposable; published bundles, failures and scorecard revisions are not.

## Reducing Windows disk usage without discarding evidence

First distinguish file **Size** from **Size on disk**. The October 6 audit found
that most space was staged `SkirmishAI.dbg` debug symbols, not replays. Symbols
must match the tested DLL to investigate historical crashes; do not remove them
merely because they are not committed to Git.

With simulations stopped, use the narrowly scoped maintenance utility:

```powershell
python tools/playtest/compress_symbols.py
python tools/playtest/compress_symbols.py --apply --workers 4
```

The first command only lists the eligible count and allocated file-data size.
The second applies transparent Windows LZX compression to uncompressed `.dbg`
files of at least 32 MiB under this checkout's `build-theatres/`. Ordinary file
access and symbolisation keep the same paths and bytes. It skips existing
compression, shared hard links and reparse points, checks for running game
processes between bounded batches, and records before/after SHA-256, sizes and
timestamps under `build-theatres/storage-audit/<UTC-id>/`. Verification failure
stops new batches; existing files are never deleted by this utility.

Run it after a batch of simulations when disk usage grows. It does not change
the playtest staging path, so later runs can create more uncompressed copies.
Compression adds decompression work when reading symbols; runtime DLLs, scripts,
engine caches and gameplay commands are untouched.

Do not replace staged symbols with shared hard links: `stage()` copies into the
existing destination, which could then overwrite historical symbols belonging
to another run. Do not delete an entire game folder on the strength of a
published summary; the full log and replay are usually only in that local
folder. Moving those originals to another drive requires a verified backup and
an updated artifact-location record. See the [disk cleanup audit](storage-cleanup-2026-10-06.md).

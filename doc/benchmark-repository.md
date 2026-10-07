# Benchmark repository and migration

Benchmark evidence now belongs to
[CircuitAI.benchmarks](https://github.com/S3KCentrifugal/CircuitAI.benchmarks).
Clone it beside CircuitAI as `../CircuitAI.benchmarks`, or set
`CIRCUIT_BENCHMARK_REPO` to its absolute checkout path. The
[shared path resolver](../tools/playtest/benchmark_store.py) is used by evidence
publishers, scorecards, the TECH rush ledger and simulation directory guards.
A missing checkout fails before the default allocator/publisher creates data.

| Content | Owner and location |
| --- | --- |
| AI code, test definitions, fixtures, benchmark programs and runners | CircuitAI: `src/`, `tests/`, `tools/` |
| Implementation plans, analysis and code-review documentation | CircuitAI: `doc/`; evidence links point to the benchmark repository |
| Published results, scorecards, ledgers, indices and compact run bundles | CircuitAI.benchmarks: `doc/benchmarks/` |
| Historical gameplay screenshots | CircuitAI.benchmarks: `doc/images/` |
| Raw game archives, logs, replays, pinned DLLs/symbols and working caches | CircuitAI.benchmarks: `build-theatres/`, Git-ignored |
| Preservation manifest and migration verification | CircuitAI.benchmarks: `migrations/2026-10-07-circuitai/` |

The migration moved 9,045 published benchmark files and 60 historical images
(939,599,164 bytes combined), plus 427,219 raw workspace files reporting
487,775,956,918 logical bytes. Logical sizes include repeated hard links and
compressed symbols; they are not additional disk allocation. Moving within the
same volume preserved the original directories, hard links and compression.

All published files were checked with SHA-256 before and after the move. The
raw workspace was checked by original directory identity and the complete
file/directory/link inventory, including sizes, modification times and file
attributes. Raw contents were not all rehashed. The compressed inventory and
verification result preserve that distinction. No verdict, measurement or
immutable publication was reformatted or regenerated during migration. After
verification, eight source-document links in three navigation/summary files
were repaired and two derived catalog hashes updated. All four original files
remain under the migration manifest with before/after hashes.

## Running and publishing

Run the existing commands from the CircuitAI source checkout:

```powershell
git clone git@github.com:S3KCentrifugal/CircuitAI.benchmarks.git ../CircuitAI.benchmarks
# Optional, when the checkout is elsewhere:
$env:CIRCUIT_BENCHMARK_REPO = 'D:/benchmarks/CircuitAI.benchmarks'
python tools/playtest/benchmark_store.py raw
python tools/playtest/storage.py allocate --domain sea --area combat --scenario subs --map supreme --kind supplied
python tools/playtest/storage.py publish <completed-archive>
python tools/playtest/storage.py find --domain sea
python tools/playtest/storage.py index
```

The archive returned by `allocate` is in the benchmark checkout. Pass it to
stage/run/watch/stop as before. Shell performance runners honor the same
environment variable; their output and native-cache mounts use the external
store. Explicit test-only stores remain supported for isolated unit tests.

Historical raw records and old commands contain the original `build-theatres`
path. This machine retains an ignored directory junction at that old location,
pointing to the moved workspace. The junction is a compatibility alias, not a
second copy or tracked benchmark directory. New installations can use the
canonical paths printed above without an alias. Do not replace or remove an
existing directory to create an alias without first preserving its contents.

Git tracks compact evidence and the migration inventory. Raw logs, replays,
binaries and caches still require separate backup: cloning the benchmark
repository does not restore ignored artifacts. This move neither frees disk
space nor purges the original CircuitAI Git history. History rewriting and
artifact deletion are separate operations.

## Verification

The [migration utility](../tools/playtest/migrate_benchmark_repository.py) is
read-only with respect to evidence: `snapshot` records the inventory and
`verify` compares the destination. Directory moves are a separate, explicitly
scoped operation. [Regression tests](../tools/playtest/test_benchmark_store.py)
cover external allocation/publication, a missing checkout, legacy path
resolution, byte changes, added/missing raw files and original directory identity.

Existing storage and scorecard tests continue to exercise immutability,
failure preservation, duplicate IDs, comparison cohorts and rating behavior.
No AI gameplay code or simulation conditions change in this migration.

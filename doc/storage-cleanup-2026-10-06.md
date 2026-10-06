# Playtest disk usage and lossless cleanup — 2026-10-06

The audit targets `C:\bardev\s3k-CircuitAI`, particularly `build-theatres/`.
It does not include other checkouts, the live BAR installation or other drives.

## What occupied the space

The initial scan covered 381,916 files. It skipped five
existing skill-directory links and counted hard-linked file data only once.
Logical file lengths totalled **393.56 GiB**; allocated file data totalled
approximately **321.06 GiB**, of which **319.77 GiB** was in `build-theatres/`.

| File category, whole checkout | Files | Allocated file data before cleanup |
| --- | ---: | ---: |
| Debug symbols (`.dbg`/`.pdb`) | 1,043 | 278.74 GiB |
| Images, predominantly simulation screenshots | 7,032 | 13.64 GiB |
| Native binaries and build products | 4,237 | 13.35 GiB |
| Logs | 2,401 | 4.77 GiB |
| Engine-cache-classified files | 2,053 | 4.27 GiB |
| Replay files (`.sdfz`) | 1,068 | 0.021 GiB, approximately 22 MiB |

Categories above are not exhaustive. The entire `doc/` tree was 0.65 GiB and
`.git/` was 0.62 GiB. These were not the storage problem. Reported data sizes
use `GetCompressedFileSizeW`; they account for NTFS/WOF compression, but do not
include every filesystem metadata block or uncompressed cluster slack. Volume
free space can also change because of unrelated applications and paging.

The principal cause is [playtest staging](../tools/playtest/playtest.py):
`stage()` copies both the pinned DLL and its debug symbol file into each game
directory. Hundreds of separate copies of roughly 300–360 MiB symbols dwarf
the reports and replays. Preserving matching historical symbols remains useful
for crash analysis.

## Preservation method

Use [compress_symbols.py](../tools/playtest/compress_symbols.py), a Windows-only,
dry-run-first utility limited to this checkout's `build-theatres/**/*.dbg`.
It applies Windows LZX compression in place and checks SHA-256, file identity,
length and last-write timestamp before and after. Already compressed/sparse
files, shared hard links, reparse points and small files are excluded.
Four concurrent operations bound memory and I/O pressure; the tool checks for
game processes before each batch and stops new batches on verification failure.

No benchmark record, original verdict, log, replay, screenshot, staged DLL,
script/configuration snapshot or debug symbol is deleted or renamed. The
logical file lengths stay the same: Explorer's **Size on disk** shows savings.
The tool does not modify gameplay or claim a gameplay performance improvement.
Reading compressed symbols incurs decompression work during crash analysis.

The preliminary trials preserved content hashes: an ordinary NTFS trial shrank
one 306 MiB symbol file to 131 MiB; an LZX trial shrank another 361 MiB file to
80 MiB. The bulk pass selects LZX and leaves already compressed files alone.

Shared hard-link deduplication was rejected because restaging uses `copy2` into
an existing filename; a shared inode could let a later staging write corrupt
another game's pinned symbols. Deleting raw games was rejected because the
published bundles contain compact evidence, not every full log, replay or DLL.

## Results and retained audit

Machine-local detail lives under
`build-theatres/storage-audit/`: the original inventory, protected benchmark and
definition hashes, trial results and per-file compression records. Existing
benchmark paths and indices remain unchanged.

For subsequent maintenance and remaining storage choices, see
[storage conventions](test-storage.md#reducing-windows-disk-usage-without-discarding-evidence).

## Completed result

| Measurement | Result |
| --- | ---: |
| Original symbol files compressed and SHA-256 verified | **830** |
| File data reclaimed | **211.02 GiB** |
| Whole-checkout allocated file data | approximately **321.06 → 110.18 GiB** |
| Debug-symbol allocated file data | **278.74 → 67.72 GiB** |
| Original evidence files present with unchanged identity, length and last-write time | **379,035** |
| Benchmark and case/check files rehashed, all unchanged | **7,322** |
| Missing evidence / content verification failures | **0 / 0** |
| Remaining eligible uncompressed symbols in the final dry run | **0** |

The bulk pass verified 828 files in 33 minutes 46 seconds with four workers;
the two preliminary trials bring the total to 830. The final read-only census
covered 382,078 files with no directory or file-read errors. It used full read
access after the restricted scanner encountered a dependency-directory denial;
about 10 MiB of additional dependency data is included in that final census.
New audit manifests also account for a small difference between the whole-folder
delta and the measured symbol savings. The observed C: free space rose from
approximately **38.4 GiB to 250.8 GiB**; volume free space also reflects unrelated
applications, so the per-file measurement is the attributable cleanup result.

The [portable verification manifest](storage-cleanup-2026-10-06.json) retains
per-symbol before/after hashes and allocated sizes. Full initial inventory,
protected-file hashes and command logs remain in the local audit directory.
Existing independent symbol copies were compressed, not deduplicated into shared
hard links. No external backup was created; preserve raw game directories.

Validation: real NTFS/LZX trials, path-boundary and shared-link refusal checks,
all 830 content/identity checks, all 7,322 protected hashes, full original-file
metadata comparison, Python compilation and invariant checker passed. The global
documentation-link checker still reports the eight existing missing hover.md
links tracked as KI-404; none belongs to this change. No game simulation is
needed for this storage-only operation, and no gameplay performance claim is made.

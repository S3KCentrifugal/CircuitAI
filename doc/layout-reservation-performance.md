# Reservation occupancy optimization (D-197)

## Contract and scope

Replace `AlliedReservations::OverlapsOther`'s bucket/member/tree search with exact
cell occupancy. For a fixed building/cluster footprint, query work must be
independent of reservation count, including many overlapping same-owner claims.
Queries must allocate nothing and traverse no reservation or owner tree.

This is O(1) **with respect to reservation count**, not O(1) for arbitrarily large
rectangles. A query visits its intersecting grid pages and occupied footprint
cells, bounded by footprint area. Fully constant rectangle sums would shift
unacceptable map-wide work into speculative reservation mutations. Local
`TerrainManager` placement searches, engine build tests and candidate generation
remain outside this optimization; no whole-placement constant-time claim applies.

Keep exact half-open geometry, own-owner exclusions, nested claims, invalid
rectangle replacement, owner removal and separate-alliance isolation. No role,
priority, timing, candidate order, logging level or command policy changes.

## Mechanism

- Keep the authoritative key-to-rectangle ledger for replacement/removal.
- Address 32-by-32 cell pages directly through arrays. Allocate occupied pages
  on mutation, never on query; release page contents after the last claim.
- Count overlapping claims per owner and cell. Maintain each cell's distinct
  owner count and XOR of owner IDs. A cell is foreign when it has multiple
  owners or its sole owner differs from the requester. No limit of 32/64 players.
- Keep occupied-row bit masks to skip empty cells. A page with only the querying
  owner can be skipped entirely. These are exact summaries, not coarse blockers.
- Fully covered pages store owner reference counts without rasterizing or allocating
  cell arrays. Only partial-page boundaries need cell updates. Full and partial
  coverage are tested independently and their results OR together.
- Publish changes synchronously from existing `Put`, `Erase`, and `RemoveOwner`.
  A nested slot release cannot clear its containing zone or another owner's claim.
  Saved geometry still rebuilds through the existing `Put` lifecycle.

## Verification plan

1. Preserve existing tests; compare randomized mixed mutations and queries
   against a brute-force rectangle oracle. Include page boundaries, negative and
   very large owner IDs, invalid replacements, nested/foreign overlap, complete
   owner teardown, reuse and reconstruction from saved rectangles.
2. Benchmark old and new query and mutation costs on identical fixed inputs,
   varying reservation counts and density. Include own-only, foreign, mixed-page
   misses and empty-area queries. Report memory tradeoffs and footprint scaling.
3. Run the complete standalone native suite, build the AI, publish the stripped
   DLL/matching symbols/current data to the required build output, check API parity.
4. Play a rendered Shore 8v8 with unchanged current policy, retaining screenshots,
   original invariant failures and measured timings. Check mixed-role reservation
   isolation. Gameplay divergence prevents treating whole-game FPS ratios as an
   exact-equivalence proof; the deterministic oracle checks API parity on the
   generated mutation/query inputs.

## Measured query cost

Three serial runs on the same Windows host, outside build/game activity, using
the same optimized MinGW compiler for both implementations. Values below are
medians of the three run means, in nanoseconds per query. A `noinline,noipa`
benchmark wrapper prevents the compiler from hoisting repeated constant queries;
production code remains normally inlined. Inputs are synthetic scaling tests,
not a replay of the complete game's query distribution.

| Query case | Claims | Previous | Occupancy |
| --- | ---: | ---: | ---: |
| Own crowded page | 100 | 205.14 | 4.96 |
| Own crowded page | 1,000 | 4,089.00 | 4.86 |
| Own crowded page | 10,000 | 46,176.56 | 4.77 |
| Own crowded page | 50,000 | 292,167.19 | 4.88 |
| Mixed-owner miss | 100 | 510.18 | 23.94 |
| Mixed-owner miss | 50,000 | 1,743,017.19 | 23.71 |
| Foreign hit | 100 | 8.24 | 6.02 |
| Foreign hit | 50,000 | 51.56 | 5.64 |
| Scattered miss | 100 | 59.68 | 4.97 |
| Scattered miss | 50,000 | 9,240.62 | 6.11 |

Queries stay approximately flat as claim count grows. Mutation cost is not
constant: it includes the ledger lookup and affected page/cell updates. A tiny
two-claim 16-cell reserve/release transaction increases from 206 to 1,013 ns;
with 1,000 reads, its complete transaction rises from 7.49 to 17.09 microseconds.
The 64- and 128-cell aligned transactions with 1,000 reads improve from 5.92 to
5.46 and 8.43 to 6.54 microseconds respectively. These counterexamples matter:
the new representation is not universally faster on sparse, short-lived work.
It removes the growth with reservation count from the identified hot query.

Memory also trades against query cost. A partial page uses about 8 KiB for
cell summaries, 128 bytes for occupied rows and about 4 KiB per participating
owner for claim counts, plus container overhead. Fully covered pages need only
owner counts. Empty contents are released; array directory capacity persists.
This is more memory than the old index for an isolated one-claim page. No
whole-game memory or FPS improvement is claimed from these measurements.

## Correctness and build verification

- Full standalone native suite passes. The reservation test reports **200,159
  checks, zero failures**, including deterministic comparisons against both the
  frozen previous implementation and a brute-force oracle, 70,000 nested
  claims, whole/partial-page release and reconstructed ledger state.
- The final native build succeeds. Stripped DLL SHA256 is
  `585949b1f419e865844ea2bbed67681df6b8a2a30db04e5670a6cb160dced277`
  (7,814,329 bytes); symbols SHA256 is
  `ff8f71d2966ccf2782838fbe0243f962767aa770be88d549b23f82fd9ff02d2f`.
  DLL, matching symbols and current data are published together to the required
  engine build install output. API validation finds 295 members and zero issues.
- The build includes the pre-existing uncommitted AIR/SEA work. Retained input
  hashes identify that state; the eventual D-197 commit alone does not recreate
  every runtime input. This optimization changes only the shared reservation
  header in production.
- ASan/UBSan were unavailable in the installed MinGW build image; no sanitizer
  pass is claimed. Actual engine save/load, role switch and allied owner teardown
  remain unplayed here; mutation/reconstruction unit coverage is not those tests.

## Runtime evidence

Supreme's six-minute mixed-role regression passes all **12 directed AIR/TECH/SEA
factory/economy exclusion checks**, with zero script/invariant failures. The
probe asks each role to place inside the other roles' held areas; the runtime
continues normal construction alongside these negative tests.

Shore reaches frame 72,002 (40 minutes), with no GameOver and no competing-team
death recorded. Only the fixture's spectator team is removed. No script errors
or INV-088 overlap violations occur. Its original report is **FAIL**, retained:
existing TECH planning, spacing, reclaim and economy invariants fire. These
observations do not certify all gameplay or an exact old/new complete-game trace.

| End minute | Units | Median FPS | AI mean ms/frame | AI p95 | AI p99 |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 4 | 292 | 230 | 1.44 | 3.85 | 6.91 |
| 10 | 505 | 161 | 2.16 | 5.72 | 9.06 |
| 20 | 828 | 114 | 3.15 | 8.10 | 12.31 |
| 30 | 1,395 | 126 | 3.14 | 7.33 | 10.45 |
| 40 | 1,661 | 8 | 23.96 | 194.59 | 225.25 |

These are normal-speed measurement windows within a rendered, profiled 4x run,
using a fixed requested camera position. The last minute takes 62.18 wall seconds
and ends at reported speed 0.921. **Severe late-game hitching remains.** Different
game trajectories, inherited dirty inputs, observer/render work and the lack of
a matched control prevent interpreting the FPS table as this change's effect.
This is not a whole-game performance PASS or a claim of universal speedup.

A separate 30-second instruction sample before the final window captures 1,923
locations from the benchmark's highest accumulated-CPU thread, including 304 in
the AI DLL. Only one AI sample resolves through AlliedReservations (query);
none resolves through its mutation helper. AngelScript execution/dispatch and
other placement work remain visible. Capture sections total 61.407 ms and report
zero failures. This is randomized wall-clock sampling, not CPU-cycle percentages
or full runtime stacks. Its small sample does not attribute the final minute's
225 ms p99 hitches or establish a causal old/new ratio. Retain D-195's other
recommendations and KI-497 rather than broadening this behavior-preserving fix.

The observer also records 320,301 reservation log lines. Peak all-team command
events are 16,435 per game minute; TACTICAL team 10 reaches 4,699. These include
game/Lua commands and do not measure network packets. No command behavior or
diagnostic cadence was changed.

Follow-up analysis: [D-198's updated ranking](reviews/2026-10-04-skirmishai-performance-rerank.md)
breaks down the already captured per-team timers. TECH team 1 accounts for
84.88% of final-minute AI time, both TECHs 87.41%, and both AIRs 2.30%. The log
contains 647 failed T1-converter packing attempts with the same zone/candidate
signature in that minute. This localizes the next investigation to TECH's
repeated decision path, without claiming the exact costly function is proven.

## Retained evidence

- [Supreme mixed-role regression](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/sea/layout/allied-bases-mixed/2026-10-04/20261004T232406Z-f0fcdb18/README.md):
  original PASS, all twelve probes, screenshots and build/input hashes.
- [Shore 8v8](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/reservation-occupancy/2026-10-04/20261004T234203Z-870e40cb/README.md):
  original FAIL, checks, timings, lifecycle markers, screenshots and input hashes.
- [Native tests and three raw benchmark runs](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/reservation-occupancy/2026-10-04/20261004T234203Z-870e40cb/reservation-measurements.json):
  complete test log, CSV text and median calculations.
- [Instruction sample summary](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/reservation-occupancy/2026-10-04/20261004T234203Z-870e40cb/instruction-sample-summary.json)
  and [raw observations/resolved inline chains](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/records/shared/performance/reservation-occupancy/2026-10-04/20261004T234203Z-870e40cb/instruction-sample-raw.json).

All publication bundles are immutable. Original reports, failure counts and raw
observation hashes remain unchanged; post-run analysis is identified separately.

## Reusable benchmark

`tests/allied_reservations_benchmark.cpp` compares the current index with the
frozen pre-D-197 implementation in `tests/support/allied_reservations_legacy.h`.
Compile separately with C++20, `-O3 -DNDEBUG`, include path `src`, and run while
no build/game is consuming benchmark CPU. It emits CSV for same-owner crowded
pages, mixed-owner misses, foreign hits and sparse occupied pages. Every query
checks an expected result. The `churn-*` rows report nanoseconds per complete
two-claim reserve/query/release transaction in the `query_ns` column, not latency
of a single query. Those rows expose update cost rather than hiding it in setup.

The renderer runner is `python tools/playtest/run_reservation_performance.py
--dll <pinned DLL>`. It retains the D-195 mixed-faction/role sixteen-AI starting
roster, removes only the harness spectator commander, and records GameOver.
It uses profiling and 1x measurement windows among 4x sections. The full script
records inherited modoptions; no economy, AI policy or role settings are altered.
The all-role exclusion probe is `run_sea_allied_base.py --dll <pinned DLL>`;
its test-only AngelScript attempts foreign construction in each role's held
factory and economy clusters on Supreme.

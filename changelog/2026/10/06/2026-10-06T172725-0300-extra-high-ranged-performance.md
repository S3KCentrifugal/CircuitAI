# Reduce ranged query and snapshot overhead without changing policy

## Summary

D-221 implements the CircuitAI portion of the first extra-high performance
round. Pure spatial predicates stop when their answer is known; snapshots use
reusable spatial storage and exact ascending ID ordering. Gameplay scripts,
configuration, cadence, command policy and RNG behavior are unchanged.
The upstream engine finding and residual snapshot observation cost remain open.

## Changes

- Added pure-existence queries, static-hazard indexing and sign-only danger
  queries, retaining ordered numeric fallback for exceptional inputs.
- Replaced spatial hash lookups on normal map cells with bounded dense storage,
  sparse overflow and touched-cell clearing. Fresh legal engine observations
  remain per AI; storage reuse does not cache positions across frames.
- Replaced large friendly-ID comparison sorts with a reusable bounded bit
  inventory, preserving ascending order and small/malformed-input fallback.
- Added nested snapshot attribution, live legacy-predicate verification,
  ordered differential tests and reproducible component benchmarks. Timing
  runners reject enabled correctness oracles; summaries retain inclusive
  parent costs instead of presenting new child scopes as savings.
- Updated the ranged specification, performance maintenance guide, decision
  and known-issue registers, invariant/actor contracts, and C++, AngelScript
  and playtest skills. Regenerated test and benchmark discovery indices.
- Preserved original test verdicts, input hashes, screenshots and compact
  telemetry from five combat fixtures and two 8v8 diagnostic games.

The [implementation report](../../../../doc/reviews/2026-10-06-extra-high-performance-remediation.md)
links every mechanism, test and evidence bundle, with before/after examples.

## Reasoning

Early exit is valid for pure existence predicates, not ordered scoring, RNG
or side effects. Dense storage reduces hashing while sparse overflow preserves
off-map coordinates. Bounded ID ordering preserves tie order. No observation
cadence reduction, command suppression, AI-thread engine callbacks or stale
cross-AI cache was introduced. The engine references are read-only under
AGENTS.md; engine animation/movement proposals remain upstream work.

## Validation

- Native integration build and full standalone native/AngelScript regressions
  pass. Ordered legacy/brute-force geometry comparisons and seven Python
  telemetry tests pass. All three updated skills validate.
- Five rendered combat fixtures pass original checks with both live snapshot
  and query oracles enabled; no INV-148/161 or script errors. The Starlight
  fixture retains its allowed one casualty.
- Same-input 10,000-point median kernels: rebuild/enumeration 84.439 to
  58.416 microseconds (1.45x); ID ordering 305.186 to 11.958 (25.52x); local
  existence miss 0.131 to 0.092 (1.42x). These are not whole-game FPS gains.
- Metal Plate completes 30 game minutes and Glacial Gap 60, with all 16 AIs
  active and no script errors. Their strict gameplay verdicts remain FAIL:
  49 and 412 invariant events respectively. Populations/query counts differ;
  Glacial minute-60 whole-AI p99 worsens and Metal minute-30 p99 is unchanged.
  The report does not claim a passing full-game regression or universal FPS gain.
- Published the tested stripped DLL, matching symbols and current data to the
  required development output. All 336 data files match; 310-member script/DLL
  parity passes. No live BAR installation was modified.
- Existing hover-document links remain KI-404 documentation debt. Rank one
  engine work, residual KI-527 observation cost and lower-severity D-220
  findings remain unresolved. Initial push of `f8fc38eb` was rejected by
  automatic approval review pending explicit payload/destination approval.

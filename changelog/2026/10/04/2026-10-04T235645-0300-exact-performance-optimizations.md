# Exact performance optimizations and measured weapon-work fix

## Summary

Completed at 2026-10-04T23:56:45-03:00. D-199 removes redundant TECH
planning work, indexes exact local occupancy, reduces script/command temporary
allocations, and adds disabled-by-default timing/oracle diagnostics. Policy
gates, task selection order, placement attempts, reaction cadence and dispatched
commands are preserved. Whole-game hitch and multiplayer acceptance remain open.

## Changes

- `TechWeapons::Work` reuses outstanding counts within one unchanged invocation,
  invalidating on dead-slot changes and every order attempt. Old slots skip a
  pure definition lookup after the existing 300-second age boundary.
- `Layout::CanPlace` removes a costly probe whose failures were already accepted.
  Actual placement and newly available-site response remain live.
- `LocalReservations` supplies exact paged slot/envelope occupancy with synchronous
  create/release/consume/load updates. INV-144 optionally compares the old predicate.
- `EcoPlanner` owns one energy-option array and preserves stable ranking/filtering;
  TECH reuses an existing constructor observation. No shared scratch objects.
- Custom command helpers borrow payloads through the same synchronous generated
  engine bridge, preserving options, timeout, call count and exceptions.
- Added phase/rule/GC diagnostics, differential tests, isolated engine fixtures,
  immutable benchmark records, provenance, decision/actor/API documentation and
  [the detailed write-up](../../../../doc/reviews/2026-10-04-high-severity-performance-implementation.md)
  with before/after code and measurement limitations.

## Reasoning

Named rule timings localized the remaining late TECH cost to repeated weapon
work, including the air-defense fallback. The count was redundantly recomputed
for each eligible cluster. Invocation-local reuse avoids unsafe cross-frame
caching while removing quadratic repeated work. Exact occupancy indexing trades
additional mutation writes/memory for fast repeated queries. No APM cap, command
suppression, coarse updates, GC tuning or engine calls on extra threads were used.

## Validation

- Full native suite passed: 200,038 local and 200,159 allied reservation checks,
  geometry/targeting/reclaim and script policy suites. Final extracted old/new
  tests pass 20,000 option, 20,000 admission and 20,000 three-call weapon cases.
- Real-engine 32-cluster x 16-slot workload: 1,000 old asks take 62.34-63.03 s;
  1,000 new asks take 2.06-2.07 s, 30.22-30.49x function throughput. Balanced and
  terrible profile checks PASS. Hard workload completed cleanly; its original
  FAIL from a too-narrow opening expectation is retained and explained.
- Fixed 2x2-cell occupancy misses stay 6.93-7.56 ns from 100 to 20,000 slots;
  the old scan grows from 228 ns to 151,412 ns. Small-slot replacement adds
  approximately 65-145 ns; memory and large-zone update limits are documented.
- Array-component time decreases 51.3%; tracked array objects 400,000 to 100,000.
  10,000 custom orders allocate zero temporary payloads instead of 20,000;
  50 exact bridge contract/error cases pass. Order/network counts are unchanged.
- Supreme mixed AIR/SEA/TECH exclusion PASS; the 40-minute diagnostic performs
  at least 8,900,012 old/new predicate checks with zero mismatches. Full Shore
  games and a 45-minute soak retain their gameplay FAILs. Combat removed the
  comparable TECH workload in final reruns, so no whole-game FPS gain is claimed.
- Rebuilt DLL, matching symbols and data published to the development install;
  API parity passes. Engine save/reload, targeted transfer and host/peer network
  checks remain unperformed. Existing unrelated AIR/SEA work is excluded from
  the scoped commit. See the detailed report for every original verdict.

Final repository checks: role documentation, invariant practice, script/DLL API
parity and staged whitespace pass. Documentation links retain eight preexisting
references to the missing hover role guide (KI-404); no new broken link was found.

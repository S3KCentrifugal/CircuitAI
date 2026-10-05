# Performance maintenance contracts and categorized test discovery

Completed 2026-10-05T02:02:25-03:00.

## Summary

Documented the exact D-199 performance optimizations and made existing test
definitions discoverable without moving historical evidence.

## Changes

- Added `doc/performance/engineering-guide.md` and a CircuitAI/Recoil C++ skill.
- Updated AngelScript, playtest and log-investigation skills with complexity,
  ownership, invalidation, callback/thread and measurement contracts.
- Added explanatory comments at local occupancy, command borrowing, layout,
  economy-array and weapon-order hot paths; no new optimization behavior.
- Added a generated domain index of 341 source files under `doc/testing/`, with
  source hashes, named assertions, fixture/observer and runner-family distinctions.
- Added three tests for catalog coverage, classification and non-inference of results.

## Reasoning

Future maintainers need the semantic proof and cost variables, not an isolated
speedup claim. Fixed-footprint reservation lookup is constant in reservation
count; full placement search is not. A local engine order is not a network
packet measurement. Reusing one guide avoids contradictory skill copies.

## Validation

Native/embedded-VM suite and performance oracles pass. Three catalog tests and
four skill validators pass. Existing evidence was hashed before publication:
4,985 files remained unchanged. Role/invariant/API checks pass; the doc-link
checker retains eight pre-existing missing-hover links. See D-200 and
`doc/performance/engineering-guide.md`; no new whole-game speedup is asserted.

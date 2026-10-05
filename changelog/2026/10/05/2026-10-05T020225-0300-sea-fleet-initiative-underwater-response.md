# SEA scouting, fleet initiative and underwater response

Completed 2026-10-05T02:02:25-03:00.

## Summary

SEA independently runs adaptive fleet control with either economic path.
Scouts search water, combat cohorts have finite release/objective deadlines,
surface-only hulls withdraw from unsupported sub threats, and yards select
weapon-qualified counters sooner. Other roles do not opt into this policy.

## Changes

- Added `SeaOperations` cohort routes, water-checked lanes, stable linear cleanup, escort positioning,
  screening, native contact handover and preservation of artillery/AA/player tasks.
- Added a SEA-only legal contact extension including unidentified sonar contacts;
  retained AIR's original naval snapshot and ordinary route behavior.
- Added body-local completed cover, thirty-second threat-cost memory, early
  emergency production, bounded scout replenishment and Legion T2 metadata gating.
- Added `DictIntOr` and actual-VM tests after a failed dictionary output produced
  phantom coverage in the initial implementation; unrelated call sites are unchanged.
- Added production, fog, escort and sub-screen cases, damage-by-new-counter
  observation, full scenario folder names and an explicit Shore runner map alias.
- Recorded design, all-faction unit uses, source trace, settings, invariants and
  original runtime results in `doc/sea-fleet-rework*.md` and SEA benchmark records.

## Reasoning

Sonar contact is not a known UnitDef. Surface range is not torpedo range.
Legion destroyers cannot substitute for frigates/subs against underwater units.
Native contact and special-unit mechanisms are retained instead of imposing
global orders, classification changes or an unconditional four-minute charge.
This is an authorized SEA behavior change, distinct from exact performance work.

## Validation

Twelve final combat fixtures plus three twenty-minute natural games: fourteen
PASS and one retained Cortex FAIL. Glacial, Supreme and Shore completed without
script/invariant failures. Armada, Legion and supported Cortex newly produced
counters damaged submarines. An unsupported Cortex yard lost its first unfinished
sub (KI-501); an assisted case is separately PASS. Pending queue credit across
disconnected seas remains KI-500. One earlier screen PASS and a final linear-cleanup surface PASS are also published. Seventeen original observations are retained.

Native/VM suite, 301-member API check, role and invariant checks pass. Final
DLL/debug symbols/data are published to the required development output, not
the live installation. Full save/load, role-switch stress, all-unit special
mechanics and multiplayer/FPS superiority remain unverified. Natural games
remained T1 at twenty minutes; this release does not claim optimal economy.

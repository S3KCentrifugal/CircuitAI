# Independent SEA scouting and dispersed AA interception

Completed 2026-10-05T11:47:51-03:00.

## Summary

Herrings and other SEA scouts now patrol separate safe water sectors. Available
AA ships interrupt those patrols for aircraft in their sea, including flanks and
unarmed transits, and move to separated rows/columns with overlapping weapon
coverage. After the threat expires they resume patrols. Changes are restricted
to adaptive SEA; AIR, TECH, other roles, economy and production are unchanged.

## Changes

- Added SeaPatrol ownership, stable sector leases/AA slots, legal contact
  prediction, naval danger checks and script tuning. Excluded those hulls from
  surface cohort ownership. Legion Iapetus now receives the AA response while
  weak scout guns do not determine the formation's spacing.
- Added opt-in native SEA priority fire and movement-area validation. Commands
  preserve routes and clear only their owned target ID; no global target stub
  or native AA behavior was changed. Performance/lifetime choices are commented.
- Added six Supreme scenarios, four check files, physical observations,
  analysis, two VM regressions and fifteen immutable benchmark records.
  Updated the test inventory, role/API docs, invariant and actor matrix.
- Recorded the remaining shared native idle-AA command issue as KI-502.

## Reasoning

The old Herring AA task merged ships and repeatedly issued FIGHT commands.
Individual persistent routes prevent that owner from collapsing SEA scouts.
Dedicated AA keeps overlapping coverage without every ship chasing one target.
Known naval/sub danger still constrains interception, while enemy aircraft do
not repel their own AA counter through the general surface threat map. Existing
player, carrier and repair-retreat ownership remains protected.

## Validation

All six final supplied-force Supreme fixtures and a separate normal 20-minute
two-SEA game passed. Cortex, Armada and Legion exercise all three experimental
profiles. Twelve native executables and 372 embedded VM functions passed.
The twelve-Herring patrol fixture reduced first-minute team engine orders from
4,398 to 146 and increased mean nearest separation at 90 seconds from 22.4 to
488 elmos. This does not measure FPS, network packets or multiplayer victory.
Ships can still cross closely while navigating narrow terrain.

Final DLL SHA-256: `9af405acf9a6180b3d060f9431f8531f1259a61247532b621e7b96cba29cc997`.
Matched development DLL/debug/data are published; live installation untouched.
API, role, invariant and inventory checks pass; eight existing missing-hover
documentation links and 167 existing unit-helper findings remain.

See the [full results and screenshots](../../../../doc/sea-patrol-air-defense-results.md),
[design and settings](../../../../doc/sea-patrol-air-defense.md) and
[D-202 decision](../../../../doc/decisions.md#d-202---sea-scouts-patrol-independently-and-aa-intercepts-without-merging).

# Repeatable AIR combat arena (D-165)

## Purpose

Run combat immediately, independently of economic build orders. One experimental
AIR controls the strike force and another controls defensive fighters. Both
receive radar across the normal map start region. Targets and defenses are
restored and aircraft replenished indefinitely; a bounded run is a measurement
window in that continuous arena. No live game installation is modified.

## Test architecture

1. Reuse `playtest.py` staging, launch, camera and archive ownership. Pin the
   engine, game, DLL, source revision, engine seed and AI seed in a manifest.
   Each case/seed uses a separate write directory and starts fresh AI learning.
   Never reset risk memory between waves inside a case.
2. JSON defines aircraft pools, fighter counts, radar sites, target groups,
   AA groups, observation mode, refill period and time limit. Standard map
   start coordinates supply sensor/target locations. Support explicit positions
   for water, flank and specialist tests. Validate against loaded UnitDefs.
3. Test-only staged hooks freeze builders/factories, waive the economic
   two-AFUS launch milestone and, for bomber-only drills, escort prerequisites.
   The manifest lists every override. Normal target selection, route planning,
   assembly, attacks, returns, learning and fighter interception stay active.
   Resource storage is supplied for sensors/weapons; no economy is built.
4. Default visibility is real radar/LOS. Supply reconnaissance aircraft so
   targets can be identified; a separately labeled global-LOS diagnostic can
   isolate tactics from reconnaissance. Spectator full view is not AI vision.
   Never publish global-LOS results as proof of radar reaction.
5. Refill only missing aircraft and destroyed targets on a fixed timer. Do not
   delete living sortie members, teleport them, heal them during combat, or
   reset their tasks to force launches. A held attack is a measured outcome.
   Ground AA fires normally. Persistent targets expose repeat-target behavior.
6. Observe actual AI launch cohorts and targets through a staged read-only
   script probe. Damage/loss accounting uses engine callbacks and stable unit
   IDs. Record detection, first response, first fighter/AA hit, first target
   damage, target death, completed return and survivors per real sortie.
   Separate damage from paralysis, and combat deaths from fixture setup.
7. Compare repeated sorties under the same case using target value destroyed,
   aircraft metal lost, target survival, reaction latency and successful
   returns. Show sample counts and censored unfinished sorties. Difficulty
   changes and refills must not masquerade as learning improvements.
8. Run a matrix with one command, initially across ordinary T1/T2 bombers,
   fighters, ground-attack gunships and torpedo aircraft. Accept any loaded air
   UnitDef so new combat cases require data, not copied widgets. Scouts/radar,
   EMP, nuclear payloads, transports and constructors need class-specific
   outcomes; an aircraft merely spawning never counts as behavior coverage.

## Initial cases

- Exposed mex/wind targets; no AA, then light AA and a T1 fighter screen.
- T2 bomber repeated raids versus T2 fighters protecting dispersed fusion,
  converter and factory targets.
- Static flak, long-range AA and mixed overlapping coverage, including weak
  outer approaches and targets behind the defended front.
- Radar/LOS versus omniscient diagnostic with identical force counts and seed.
- Gunship harassment and torpedo attacks against valid water targets.

The user asks for bomber-only versus fighter drills. Real PvP often needs
fighter escorts; the harness therefore explicitly disables the escort gate
only for those drills. A separate escort case can use normal prerequisites.
This is an isolation choice, not a proposed change to production doctrine.

## Evidence and implementation boundary

The official [air guide](https://www.beyondallreason.info/guide/basics-of-air-warfare)
describes fighter walls and flak against bomber groups. The
[early raid guide](https://www.beyondallreason.info/guide/early-air-raids)
emphasizes scouting and exposed economy, while the
[radar guide](https://www.beyondallreason.info/guide/radar) distinguishes contacts
from visual identification. Consult the shared air roster/mechanics and loaded
definitions for payload differences; Legion's early gunship is not an ordinary
level bomber. Do not infer a common success threshold from unit class names.

All initial implementation is test tooling. Any observed production defect is
either fixed with its own focused regression or recorded in `known-issues.md`.
TECH's policy remains unchanged. The existing KI-457 combat calibration limits
remain open until repeated measurements demonstrate an improvement.

## Verification

Validate configuration and metric arithmetic with engine-free tests. Run an
actual rendered smoke test for hooks, powered sensors, real combat, repeated
refills and screenshots. Run multiple bounded cases/seeds with strict Lua,
AngelScript, crash and invariant checks; retain failures. Verify endless mode
has no fixture quit/GameOver trigger and provide an explicit stop command.
Publish reports, raw per-wave metrics and screenshot evidence. Commit locally.

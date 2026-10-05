# AIR reconnaissance deadline and immediate base defense

2026-10-04. Implementation plan for D-193; experimental AIR only.

## Verified causes

- `AirRecon::Tick` requires `RadarWaveSize` assembled aircraft and has no deadline.
  The ten-minute production cycle is separate from waiting for a formed wave.
- `AirScreen` measures aircraft intrusions only. The D-174 ground-base response
  remains a proposal (KI-482). Factory production has no ground-emergency branch.
- `AirWaves` considers defensive T3 strikes only after bomber/escort admission,
  target payload sizing and the existing-operation gate. Idle bombers can thus
  remain parked during an invasion. Legion's opening scout has a finite route.

## Changes

1. Keep full radar waves and their production interval. Start a maximum-wait
   clock with the first eligible waiting plane; after 90 seconds dispatch the
   available cohort even if incomplete or formation assembly stalled. Never
   count player-controlled planes. Do not reset the deadline on another birth
   or loss. Reset it after launch or an empty cohort. Log full/timeout launches.
   Give surviving T1 scouts looping reconnaissance instead of a terminal route.
2. Add an AIR base-response controller using current allied-visible ground
   contacts and participating allied/human starts. A configurable 1,800-elmo
   base radius is independent of ground reachability and wall settings.
   Expose contact IDs/definition IDs from the existing native snapshot; do not
   change its membership or another role's classification.
3. Immediately transfer free ground-capable aircraft, including held T1/T2
   bombers, to shared defensive attack tasks. No wave/escort/AFUS gate. T2
   bombers keep the existing no-T1-mobile-target rule, using qualifying heavy
   units or structures. Fighters handle air contacts and escort the response.
   Retain stable attack targets while valid; retarget on death/leash/visibility
   changes, using existing route command deduplication, not a rate limit.
4. Use a shared per-AIR force deficit of 20 lethal gunships (completed, frames,
   pending orders counted once), not 20 per contact or factory. Choose available
   T2 Roughneck/Wasp/Stronghold, falling back to T1 Banshee/Mosquito; Cortex T1
   uses bombers with a small separate EMP group. Emergency admission precedes
   optional raids, scouting batches and capital saving; preserve transport and
   constructor recovery. Maintain bounded workforce turns during long attacks.
5. Stop new emergency recruitment after contacts leave the protected area;
   retain a short last-seen search before returning survivors to normal tasks.
   Never steal PLAYER/RETREAT/FERRY/carrier ownership or a live offensive wave.
   This preserves the owner's earlier explicit committed-escort instruction.
   New optional raids pause while defense has current contacts.

## Verification

- Pure AngelScript tests: deadline boundary/empty/full/unready cohorts, base
  radius, shared deficit and target-tier rules. Exercise ownership in the
  committed-wave engine control; separately report unplayed ownership paths.
- Compile all experimental profiles with the new registered snapshot API.
- Rendered Supreme fixtures: fewer-than-20 radar planes and full-wave control;
  landed Phoenixes without escorts versus Marauders near an allied start;
  persistent intrusions with T1/T2 factories for all factions; visible damage,
  response latency, repeated targets, force accounting and no repeated orders
  on unchanged missions. Include out-of-base and committed-wave controls.
- Natural AIR smoke game; preserve original evidence, screenshots and explicit
  limits. No claim to reproduce the user's match without its replay.
- Full native/pure suite, script API parity, invariant/role/doc checks; publish
  matched DLL/debug/data to required build output. Preserve existing SEA work.

## Gameplay basis

The official [Roughneck](https://www.beyondallreason.info/unit/armbrawl) and
[Wasp](https://www.beyondallreason.info/unit/corape) guidance recommends these
gunships for allied-base protection. Local BAR definitions and shared unit
references confirm Shuriken is EMP-only and Stronghold is a hybrid transport.
Twenty is a configurable response target, not a measured optimal force size.
The broader D-174 multi-AIR election, expanded live campus geography and AA-aware
incident routing remain separate work; this fix must not imply they were tested.

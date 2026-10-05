# AIR radar patrols and naval relief (D-194)

## Scope and evidence

This plan precedes implementation. Change experimental AIR only. Preserve SEA
production/combat, TECH policy, offensive bomber commitments and their fighter
escorts, transport requests, emergency base defence and workforce recovery.

The existing reconnaissance controller holds planes at single points without
checking AA. `aiBattle.AirThreat` reads one cell of the existing native threat
grid in constant time; it is an estimate of known threat, not proof that unseen
AA is absent. Its ordinary range slack remains useful. Check whole patrol and
approach corridors with additional turn clearance. Never equate unobserved enemy
territory with safe territory. No new global path search per aircraft per tick.

Torpedo aircraft have sonar and can hit ships, submarines and submerged
amphibious units. They cannot solve a hover attack. A shoreline approach can
put torpedoes into sand: choose an open-water attack run. Aircraft are vulnerable
to naval AA and fighters; raw fleet metal parity is an assistance signal, not a
prediction of victory. Sources: [BAR naval guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare),
[Cormorant](https://www.beyondallreason.info/unit/armlance),
[Angler](https://www.beyondallreason.info/unit/cortitan),
[Aesacus](https://www.beyondallreason.info/unit/legatorpbomber).
Use runtime UnitDef costs and weapon eligibility rather than copying website
statistics into production policy. The pinned game, not a historical range bug
report, determines real firing behaviour in simulations.

## Radar patrol policy

* Spread waiting aircraft over a bounded grid of friendly airspace. Give each a
  distinct triangular patrol; favour separation and coverage near the friendly
  edge. Test all three legs and the ingress corridor against known AA, including
  a configurable padding for aircraft turns. Keep aircraft airborne.
* Retain safe assignments. Recheck at a configurable interval and relocate only
  invalid patrols. Use a nearby escape point if a new threat covers the current
  position. This is threat-driven order suppression, not an APM rate limiter.
* Keep cohort membership and the oldest waiting plane's deadline independent of
  patrol replanning. Full cohorts use the established spread sweep geometry;
  partial cohorts launch at the existing 90-second deadline. The new request
  supersedes a stationary waiting line, while the outgoing sweep still uses
  distinct lanes and straight MOVE commands. Do not delay launch to form a
  pretty line while a scouting deadline expires.
* If no safe patrol exists, keep the aircraft airborne near the least exposed
  friendly fallback and log the limitation. No claim of safety against unseen
  weapons or instantaneous enemy movement.

## Naval relief policy

* Native code provides copied, currently observed enemy naval facts and a lazy
  allied naval snapshot. Include IDs, local definition IDs, position, cost,
  water-body identity and submerged state. Resolve allied definitions through
  this AI's table; never retain another AI's borrowed definition pointer.
* Script groups facts by water body and bounded spatial sectors centered on
  the observed enemy concentrations in occupied buckets. A second bounded pass
  gathers nearby forces around those centers, avoiding artificial deficits at
  empty grid points. A sector must
  contain allied combat navy or a completed naval factory to request support.
  Enemy contacts elsewhere or in another pond do not trigger production.
* Let `E` be local enemy combat metal, `F` friendly combat metal, `S` enemy
  submerged combat metal and `A` friendly anti-submarine combat metal. The
  shortfall is `max(0, E-F, S-A)`. Do not count builders or hovers. A configured
  minimum shortfall avoids reacting to trivial differences.
  Friendly support uses a configurable 1.25-radius halo around each sampled
  sector. The parity fixture exposed a circle-boundary artifact that counted
  only two of eight nearby allied destroyers; the halo preserves the nearby
  formation while still excluding remote ships and other water bodies.
* The desired wave is `ceil(shortfall * reserveFactor / aircraftMetalCost)`,
  bounded by configurable minimum/maximum counts. Default reserve factor is
  1.25; this is a tunable allowance for losses and uncertain information, not
  an asserted unit counter ratio. For a 4,000-metal gap and 400-metal aircraft,
  the target is 13; a 410-metal aircraft yields 13 and a 480-metal aircraft 11.
* Account for completed aircraft, frames and queued recruits once. Use a shared
  demand across factories. Real T2 aircraft factories recruit the best
  compatible torpedo bomber; do not wait for two AFUS. Base emergencies,
  immediate air interception and mandatory constructor recovery remain ahead
  of naval relief. Excessively dangerous approaches pause new investment.
* Release a full available wave or the available partial cohort after 90 seconds
  from the first waiting member. Deadline changes neither visibility nor route
  feasibility: if there is no current target/open-water ingress, retain the
  reserve and state why. A safe route becoming available must release an
  overdue cohort immediately.
* Group approach and target commands. Approach over water, attack an observed
  eligible target, retarget when it disappears, and return survivors to reserve
  when the local naval threat is removed. This is defensive fleet relief, not
  an offensive economy suicide wave. Never commandeer committed bomber escorts.
  Reuse `AirOperations` escort ownership to send available fighters ahead of
  the torpedo wave. This preserves the earlier all-bomber escort instruction;
  fighters already committed elsewhere remain unavailable. Naval relief yields
  to an allied-base emergency because this mission is defensive. Known
  fighter/AA danger still constrains the approach. The initial implementation
  draft omitted this escort; review caught and corrected that conflict before
  final acceptance.

## Implementation and performance

`BattleAnalysis.{h,cpp}` and `InitScript.cpp`: add opt-in naval value snapshot
queries and a bounded, padded corridor threat query over the existing grid.
Keep existing SEA contact/sample APIs unchanged. No per-plane enemy scans.

Validation found that some armed ships have explicitly zero profile threat
weights. The new corridor API therefore adds an opt-in actual AA-range floor:
a cached, currently observed weapon envelope makes a nominally zero corridor
nonzero. This protects radar patrol exclusion without changing shared threat
weights or SEA policy. It is a presence safeguard, not calibrated AA damage.
Its snapshot scans known enemies at most once per second, then corridor checks
test the copied envelopes. Native fleet snapshot sorting is O(N log N) every
five seconds; script sector accumulation is O(N), at most 25 memberships per
friendly unit and nine per enemy. Default patrol lattice is 14 by 14, capped
at 20 by 20; reallocation can perform bounded quadratic candidate ranking.

Glacial interruption diagnosis was corrected by a contact-definition probe:
the isolated runner's spectator team spawned an enemy commander at (64,64).
Base defense correctly preempted naval support. Ally that fixture-only team;
retain production base-defense policy. The attempted classification change and
its native bindings were removed. Failed intermediate runs remain evidence.

`air_recon.as`: safe patrol allocation and stable route ownership;
`air_naval_support.as` (new): sector accounting, deterministic demand,
production and reserve/approach/attack transitions;
`air_math.as`: pure sizing and release decisions;
`global.as`: AIR settings;
`air_production.as` and `roles/air.as`: lifecycle, recruitment and task hooks.

Bound candidate work independently of total map units. Snapshot fleet facts
once per policy interval; distribute each fact to a fixed set of nearby sectors.
Retain stable target IDs and route geometry. Commands only on state/target/route
changes; no repeated ATTACK against an unchanged target.

## Verification

1. Pure tests: naval shortfall and submarine mismatch, zero/negative/invalid
   costs, rounding/clamps, parity/no demand, partial release/no aircraft and
   deadline boundaries. Corridor tests cover padding, edges and obstacles.
2. Actual engine compile of all experimental profiles with paired DLL/scripts;
   native suite, API checker and documentation/invariant checks.
3. Supplied radar scenarios on Supreme Isthmus: distinct patrols, actual patrol
   commands and airborne movement, new AA invalidates only affected routes,
   partial deadline and full sweep still launch. Capture screenshots and orders.
4. Supplied naval scenarios: outnumbered allied ships and subs, equal/stronger
   allies, unsupported remote fleet/other water body, hovering enemies, stalled
   production partial release, real torpedo hits for all three factions and
   open-water ingress under moderate AA. Archive unsuccessful runs too.
5. Run existing base-response/escort controls and natural-game smoke checks as
   appropriate. Report measured response time, damage, orders and limits;
   supplied combat does not establish economic sustainability or a PvP win rate.
6. Publish immutable evidence under the existing categorized benchmark structure;
   update role/API docs, actor matrix, D-194 and runtime invariants. Record
   diagnosed unresolved limitations. Publish the paired completed build to the
   mandatory Recoil build output; do not modify the live BAR install.

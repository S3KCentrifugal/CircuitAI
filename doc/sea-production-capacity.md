# SEA production capacity and harbor planning

2026-10-06. Implementation and verification plan; results are recorded below as
they become available. Scope: CircuitAI SEA policy and opt-in native mechanisms.
No Recoil changes, AIR/TECH build-order changes, or global production rewrites.

## Findings and player economy rationale

The default SEA profile enables compact layouts but leaves ExperimentalBuild
off. Fixing only the latter would miss normal games. The legacy builder creates
native resource work before checking the commander, and its factory guard
expires after three minutes. Support construction ignores a factory between
products, requires a current product, and splits funding only over busy yards.
Reservations use small rear rectangles; a future berth can fit while its support
cannot. Later yards check economy separation but only replacements check friendly
cover. Zero observed threat is not evidence that fog is safe.

The official [economy guide](https://www.beyondallreason.info/guide/in-depth-look-at-economy)
supports balancing income, energy and usable local build power, and assisting an
existing factory before purchasing another merely for construction speed. The
[naval guide](https://www.beyondallreason.info/guide/basics-on-sea-warfare)
emphasizes protecting expensive ships, efficient repair and reclaim. These are
reasons to preserve expansion/recovery ships and to reserve safe production
space, rather than spend every resource on additional shipyards. Exact costs,
reach and footprints come from loaded UnitDefs; the local
[naval economy research](../../rjm.bar.docs/knowledge/50-economy/54-naval-economy-planning.md)
documents where generalized guide numbers differ from current unit data.

## Changes

1. Give the SEA commander a common policy before either construction path.
   Preserve player control, retreat, enemy reclaim and active construction.
   Assist the closest productive shipyard until a completed T2 yard has **four
   completed, usable construction turrets within build reach**. Then assist
   economic construction by urgency, with local distance as a tie-breaker.
   Avoid holding an idle factory forever; emergency energy recovery remains
   available if production is stalled. Count completed turrets, not reserved
   slots, frames or mobile builders. No elapsed-time substitute for handoff.
2. Keep support investment available between products. Preserve the last
   product for costing, use a buildable constructor as cold-start fallback,
   account for all completed production factories, and recognize a funded
   positive metal balance or sustained high/refilling metal bank. Count gifts
   only once; do not assume future gifts. Check energy and live same-callback
   commitments. Admit at most one new support construction project at a time;
   keep the first expansion ship free for mexes. Existing queued work is part
   of capacity. Do not add an actions-per-minute limiter.
3. Replace failed all-or-nothing rear rectangles for factory support with a
   deterministic dense rear/side arrangement. Every pad must reach the factory;
   the forward exit stays open. Use actual footprints and shared native allied
   reservations. Reserve a useful minimum atomically, cap the finite footprint
   in settings, and own/release unused pads with their berth. Terrain may reduce
   the number of legal pads; a maximum is not a build quota.
4. Reserve the first T2 yard and a provisional amphibious gantry site early,
   with support and exits. Keep capital economy behind the factory/support
   footprint. The existing sea-control and enemy-shore invasion gates remain:
   early reservation does not authorize early gantry construction. Release the
   untouched provisional site when a protected forward invasion site is ready.
5. Later shipyards face the enemy, clear planned economy, and require a visible
   forward buffer at admission. Preplanning can precede scouting. If all useful
   support pads are served, preplan another forward yard instead of searching
   occupied banks repeatedly. Building it still requires economic eligibility.
   A player with no surviving/queued yard may recover immediately; shared ally
   reservations and physical terrain/exit safety are never bypassed.
6. Preserve native largest-product water-depth and exit checks; lengthen the
   protected corridor for SEA clusters so neighboring reservations cannot pinch
   the initial flagship departure. No claim that a local corridor proves an
   arbitrary route across the entire sea. Shared private reservations provide
   collaboration without chat traffic or nearest-start ownership partitions.
7. Ordinary Glacial trials exposed an interaction hidden by supplied capital:
   keeping the commander on the yard removes its previous incidental energy and
   mex construction. Keep the second construction ship on needed home energy,
   and permit dense six-tidal rows when the larger block cannot fit. Do not send
   both opening ships to follow the same remote mex worker.
8. BAR's builder priority is binary. Native ENERGY re-evaluation can make a
   constructor passive at full energy/empty metal, while a full-priority
   commander consumes the metal assisting combat production. The opt-in
   `CCircuitUnit.SetBuildPriorityOverride(-1|0|1)` mechanism lets SEA keep economic
   builders active and make routine commander/turret combat assistance passive.
   Constructor production and urgent counters keep active assistance. Native
   requests are retained and restored when the override ends; duplicate effective
   priorities send no new engine command. Other roles never enable this lever.
   SEA resets overrides on role exit and external/retreat ownership.
9. Keep needed home energy ahead of discretionary support purchases in both
   construction paths. Otherwise donated metal can repeatedly fund turrets while
   the experimental worker ladder postpones tidal construction. Existing frames
   retain ownership; the first expansion ship remains on mexes. Correct the test
   observers too: natural games must not enable synced GlobalLOS.

## Verification

- Actual AngelScript VM tests: 3/4 turret boundary, incomplete/distant turrets,
  low energy, gift-supported deficit, sustained high bank, stale observations,
  simultaneous commitments, emergency versus ordinary harbor eligibility.
- Native geometry tests: all corridor facings, in-range pads, no footprint/exit
  overlap, large hull clearance, map-edge rejection and deterministic ordering.
  The cached-LOS rectangle is reviewed and exercised by live placement; it does
  not yet have a standalone visibility-grid unit test.
- Build and load the complete script graph; check DLL/API parity before launch.
- Rendered supplied Supreme tests exercise the commander transition, abundant
  bank pressure, support placement and factory egress. Retain failures and
  screenshots, distinguishing forced fixtures from natural economy. They do not
  prove real donation timing or adjacent allied cluster saturation.
- Natural Supreme and Glacial games exercise both compact and experimental
  paths. Compare commander work, completed/queued local support, resource banks,
  factory completion/production and invariant reports. Include mixed AIR/TECH
  allies to check reservation coexistence.
- Performance review: cached once-per-second economy census; finite layout
  planning only on new/invalid sites; no unit micro loop or worker-thread engine
  callbacks. Report measured costs separately from complexity reasoning.

## Results

The [trial index](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/sea-production-capacity.json) retains original
verdicts, source-log hashes, 30-second samples and visibility flags. Reproduce it
with `python tools/playtest/analyze_sea_capacity.py`. Compact immutable records
and screenshots are linked in the [SEA evidence index](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/index/sea.md).

| Test | Result | What it establishes |
| --- | --- | --- |
| Full native/AngelScript suite | PASS | 15 native suites and VM suites, including 21 SEA policy tests; [output](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/sea-production-capacity-tests.txt) |
| Armada supplied, compact, 12 min | PASS | Constructed support and commander handoff at 3:35; earlier native candidate before the resource-priority correction |
| Legion supplied, compact, 12 min | PASS | Four completed in-range turrets by 3:35, economy handoff at 3:40 on the final native DLL |
| Cortex supplied, experimental, 12 min | PASS | Four turrets by 3:25, handoff at 3:35 on the final native DLL |
| Glacial normal fog, compact, 20 min | PASS | Commander assist, mex growth, tidal growth and constructed support; five construction ships, three nanos, ten mexes and twenty tidals at the horizon |
| Supreme normal fog, mixed AIR/TECH/SEA, experimental, 25 min | FAIL overall | SEA's four growth checks pass; existing TECH invariants remain visible. Exposed the experimental home-energy ordering problem, corrected afterward |
| Supreme final home-energy ordering, normal fog, mixed, 25 min | FAIL overall | SEA's four checks pass and ten nanos finish. TECH reclaim/layout invariants persist; energy still stalls at twelve tidals and about +310 E, with repeated inland-geo approaches |

Supplied T2 yards and large banks establish transitions, **not natural tech
timing**. Neither an ordinary 20-minute Glacial T2 yard nor its natural commander
handoff was observed: income remained below the existing T2 gate. The old Glacial
baseline had two construction ships, three nanos, 17 mexes and about +44 metal at
20 minutes; the new commander policy had five ships, three nanos, ten mexes and
about +25 metal. More mobile capacity is demonstrated; a superior opening,
economic win rate or earlier T2 timing is not. The commander no longer collects
land mexes incidentally, as requested.

The first natural trials exposed passive tidal frames competing with active
factory assistance. Preserve those smoke PASS results as failed economic
evidence. Later review found the base observer enabled global visibility, so
those runs cannot prove fog-buffer safety. Both SEA observers now restrict it to
supplied fixtures, and natural checks forbid the engine's GlobalLOS log marker.
The Cortex watcher's first truncated report is retained separately: sandboxed
process inspection falsely reported an exit; the elevated watcher observed the
same game through its full horizon. It is not an independent second match.

The final repeat verifies that funded support grows, but does **not** resolve
the experimental path's energy-placement/access problem (KI-235/KI-532). Keep
`ExperimentalBuild` off by default; this change does not enable it. The compact
path remains the deployed default. Shared reservation invariants and the native allied-reservation suites
cover coexistence; these runs do not force every blocked-pad replan, save/load,
fully saturated harbor, or flagship hull through every island passage.

## Performance and maintenance

The final stripped DLL SHA-256 is
`7b443ae28869953bc2b63713441a41f3640babc942a0f58b8db2d2d0a6bd59c1`
(7,985,416 bytes). Its matching debug symbols and all 336 data files are
byte-verified in the required development output; script API parity passes
313 used members. Role-document, invariant and test-index checks pass. The
documentation-link check retains eight pre-existing missing `roles/hover.md`
links (KI-404); unit-helper findings remain the same 170 baseline findings.

No Recoil source or global role policy changed. Resource-priority maintenance
adds one pass over the existing once-per-second SEA census, with O(1) dictionary
product lookup per eligible builder. The native effective-priority cache avoids
resending unchanged priority commands. Bank pressure uses a bounded ten-sample
window; gifts are not counted again as income.

Support geometry enumerates a footprint grid within build reach and sorts its
legal sites: O(G log G) time and O(G) temporary memory. At current BAR footprint
sizes G is small, but this is not a constant-time candidate search. Reservation
queries reuse the shared index. The planned-berth and existing-factory scans can
each attempt one support transaction per second (two total), with ten-second
owner retry backoff. Each reserves at most 64 configured pads, with a native
128-pad safety bound. Failed minimum fits roll back. Other placement paths keep
their own existing budgets. Nearby support eligibility still scans owned units
and projects per yard; this change does not claim to remove that cost.

Visibility admission reads the cached bounded LOS-cell rectangle, O(cells), with
no engine calls, map copies or allocations. Engine callbacks and mutation remain
on the AI's owning thread. No worker-thread access or APM limiter was introduced.
The 20 ms layout warning remains enabled, including `PlanNavalSupport`. These
gameplay runs are not controlled FPS or multiplayer packet benchmarks; no FPS
gain or absence of all frame-time spikes is claimed.

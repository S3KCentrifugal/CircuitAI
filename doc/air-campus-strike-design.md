# AIR production campus and target-sized raids (D-163)

2026-10-02. Baseline: `d7f55eea`. Written before implementation.

## Contract and PvP interpretation

AIR uses mobile constructors to serve a compact production campus. Reserve at
least six complete T2 lab/twenty-turret blocks and one T1 lab when terrain permits;
reserve further blocks incrementally without a default numerical factory cap.
Physical map space, allied reservations, supported existing labs and sustainable
income still constrain construction. Preserve six-wind clusters and spaced
converter fields. AFUS structures stay separated from the production campus.

At a sustained minimum of 50 metal/s over ten seconds, enter a persistent
economic growth phase. Reuse TECH's economic decision function and thresholds
with AIR state and placement; never call TECH's layout, lab replacement, rush
chain or build executor on AIR's behalf. Aim for two completed AFUS, preserving
owned-mex-before-reactor, stall recovery, transport requests and home air defense.
After two completed AFUS, latch mass T2 bomber production on. Destruction of a
reactor triggers ordinary recovery, not a reset of the opening bomber milestone.

This is an owner-selected growth strategy, not a universal timing claimed by
the meta. Keep early T1 raids and defensive fighters. Do not divert all income
to bombers while losing air control or stalling energy. TECH's seven-step economy
priorities are shared; AIR supplies a two-AFUS objective and its mobile-workforce
and aircraft-demand inputs. Existing TECH defaults must evaluate identically.

The official [early-air guide](https://www.beyondallreason.info/guide/early-air-raids)
supports scouting, fragile economic targets, single-pass payload planning and
avoiding known AA. The [air-warfare guide](https://www.beyondallreason.info/guide/basics-of-air-warfare)
supports fighters protecting bombers and recognizes aircraft's substantial
energy costs. [Advanced mechanics](https://www.beyondallreason.info/guide/important-knowledge-on-advanced-mechanics)
describes explosive economy structures and bomber control. Therefore density is
for the factory/turret campus; reactors and converters must not become one blast
chain through it. Guide counts are examples, not loaded-unit damage constants.

## Implementation

1. **Layout.** Replace radial 560-elmo lab separation with a footprint-derived
   lattice of atomic factory/support reservations. Keep full twenty-slot support
   banks, exit clearance, allied exclusion and first-building relocation. Search
   only friendly home space and retry blocked unused blocks. A zero production
   limit means unlimited; maintain six speculative T2 blocks or one free block
   beyond the existing production count, whichever is larger. Never reserve an
   infinite area in advance. Keep existing layouts adopted after load.
   Lift profile factory caps only while experimental AIR owns the role, restoring
   them on exit. A started lab stays in place; engine-rejected support pins get
   replacement sites within reach and unique bay ownership, without counting a
   failed pin toward the twenty-completed-turret expansion gate.
2. **Economy.** Add an explicit AIR context to the existing EcoPlanner state.
   Its default remains TECH. Only AIR opts out of TECH placement/chain queries;
   shared ranking and economic thresholds remain one implementation. AIR's
   executor maps economy choices into its reservations and local assists. While
   below two AFUS, the energy objective includes that reactor ladder even when
   the ordinary income-ratio target is satisfied. Queue-aware converter and
   storage decisions and focused reactor assistance keep expansion funded.
   Mobile fallback factory guards use expiring five-second leases so the
   workforce keeps reconsidering economic construction after a temporary lull.
   Reactor searches retain their rear preference but cover the entire home
   disc, increasing angular samples with distance. A rear anchor off the map
   must not exclude free ground on the campus's opposite side. Post-opening
   commander assistance requires a real unfinished aircraft frame.
3. **First T2 wave.** Draw one inclusive random integer from AIR settings
   `FirstBomberWaveMin=10` and `FirstBomberWaveMax=20`, persist it in layout state,
   and never reroll on a failed target search. It is the first launch's size;
   an unsafe or underpowered target must wait or be replaced, not force a launch.
   Supplied combat fixtures must explicitly satisfy the two-AFUS gate.
4. **Subsequent sizing.** Replace linear wave-index growth as the primary demand
   with selected target health divided by conservative loaded pass damage,
   inflated for padded route AA exposure, nearby resistance, observed enemy army
   investment and an explicit unknown-threat reserve. Keep all coefficients and
   bounds in AIR settings. Threat-map units are a calibrated risk proxy, not
   weapon DPS or a guaranteed casualty forecast. Never assume unseen space safe.
   Add a separate local-AA metal reserve (`StrikeLocalAaReserve=0.5`). Production
   also funds replacement stock for `StrikeReserveSeconds=120`; that stock is
   not automatically committed to a sortie with a smaller target budget.
5. **Routes and objectives.** Compare direct and edge-ingress candidates using
   corridor samples (centre and both padded sides), distance and ingress/egress
   exposure. Known economic structures support backline edge raids; frontline
   static targets support synchronized packages. Store and execute the selected
   waypoints instead of merely scoring a path the units do not follow. Keep
   formation width/ranks bounded and abort when the force is no longer adequate.
6. **Synchronized attack.** Aircraft assemble as one cohort, then begin their
   terminal passes against a common nominal impact time adjusted for remaining
   distance/speed. This synchronizes one AI's package; it does not claim allied
   multi-AI command coordination. Log the release spread and actual damage.
7. **T1 targeting.** Prefer known metal extractors and wind clusters, scoring
   nearby fragile economy without reading hidden enemies. Do not force attacks
   through strong AA merely because the target is a mex. Legion's early gunship
   remains correctly classified; reusable T1 bombers get the economy target policy.

## Verification and boundaries

Natural-run correction: a complete loss must affect the next mission. Evaluate
the immutable cohort only after the native sortie ends, increase a bounded
learned resistance multiplier after heavy losses, and relax it after good
survival. Persist the multiplier. For five minutes, exclude a configurable
640-elmo region around a failed raid's aim from target selection (at most eight
recent regions). Native code only filters regions supplied by script; AIR owns
loss thresholds, expiry and budgeting. This prevents immediate repeated small
raids into a proven defensive pocket while permitting different objectives.
The opening draw remains unchanged. Verify exclusion and feedback in a repeated
natural match, retaining the original two wipeouts as failed evidence.

AIR feedback settings: `StrikeLossGrowth=1.5`, `StrikeRiskRecovery=0.9`,
`StrikeLearnedRiskMax=3`, `StrikeFailedSurvival=0.25`,
`StrikeFailedRetrySeconds=300`, `StrikeFailedRegionRadius=640`. Existing
`BomberWaveLowSurvival`/`BomberWaveHighSurvival` select increase/recovery.
The multiplier scales route, army and local-AA reserves and adds uncertainty;
it does not change the opening random draw. After a role reinitialization the
saved multiplier is restored but temporary region memory starts empty.

Add dependency-free tests for unlimited expansion, lattice spacing, milestone
gates, inclusive first-wave bounds, risk-adjusted payload sizes and impact-time
offsets. Exercise the shared economy branch with unchanged TECH defaults. Add
invariants for complete speculative support, no premature mass bomber orders,
first-wave size, and route-sized minimum force. Keep every global invariant
forbidden in checks, including existing unrelated failures.

Build/publish a stripped DLL, matching symbols and current data together. Run a
short script-load test first, then rendered layout/economy and combat fixtures:
six-plus labs with dense support, a blocked first slot, the 50M transition, two
completed AFUS before mass production, stable first-wave randomization, T1 mex/
wind selection, edge bypass of a defended corridor, and synchronized frontal
attack. Follow with natural economy/combat windows and TECH regression evidence.
Provide screenshots during runs. Supplied assets are capability checks, never
natural timing claims. Preserve failed runs and record remaining limitations.

No live-install writes, no changes in `data_sample/`, no static-weapon firing
changes, and no push. Commit the completed changes locally.

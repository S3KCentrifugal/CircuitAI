# AIR economic workers and reserved reactor districts (D-164)

## Problem and scope

AIR's five-second factory guard expires, but an advanced aircraft constructor
can renew it indefinitely whenever the economic chooser returns no task.
An empty chooser can mean that both banks are full, or that its selected
construction-turret action cannot be performed by that constructor. Meanwhile
AIR reserves its aircraft campus at the opening but finds advanced economy
sites only when ordering them. Wind, converters and allied buildings can use
the space first. These are AIR policy changes; TECH's ordered rules, lab
reclaim/rebuild sequence and native guard mechanism stay unchanged.

## Evidence and policy

BAR's [advanced aircraft constructor guide](https://www.beyondallreason.info/unit/coraca)
describes upgrading extractors, then reactors and advanced converters as its
usual progression. Its mobility supports a separate economic district.
The [air warfare guide](https://www.beyondallreason.info/guide/basics-of-air-warfare)
also calls out energy and construction turrets as valuable bombing targets.
Separating economy from production reduces co-location; it does not promise
protection from reactor explosions or a determined bomber attack. Effective
footprints and costs come from the loaded UnitDefs, not duplicated constants.

1. Advanced aircraft constructors cannot take fallback production guards.
   Reconcile existing builder GUARD tasks once per second by moving only that
   constructor to a brief wait/recheck; do not abort a task shared with other
   workers. Real unfinished construction and its useful repair assistance
   remain valid, including building new labs and their support.
2. Preserve mex priority, transport priority, the two-AFUS bomber milestone,
   twenty completed support turrets per existing T2 lab, and AIR's production
   income share. Retain the shared TECH chooser unchanged. If its selected
   action cannot execute, try useful reactor assistance. After the two-AFUS
   milestone, a full metal bank can fund one additional reactor using the
   economic share of projected income after existing commitments. Do not
   generate extra metal while metal is overflowing. Never start parallel
   reactors merely because multiple workers ask.
3. At the opening, reserve four separate economic modules. Each holds one AFUS
   and eight advanced-converter slots, with spacing between the reactor and
   converter bank. Reserved capacity is not a build order or a required ratio.
   Funding/surplus policies determine when each building is ordered. Keep at
   least one unused module ahead as the district grows; no arbitrary late-game
   module cap. The aircraft campus still plans at least six T2 labs and one T1.
4. Use the existing native persistent slots and enclosing zones, rotated by
   the shared layout helper. Search rear-first within AIR's friendly home
   region, outside the production campus. Reserve all slots atomically before
   publishing a module. Both allied layout checks and AIR's own factory search
   see these zones. Adjacent district boundaries are allowed; an AFUS retains
   separation from aircraft lab centres. Ground gifts must be able to reach
   the selected slot; flying constructors may reposition across the home area.
5. Persist slot IDs, zone IDs, faction and activation state in native named
   layout state. Before the first building starts, revalidate every slot and
   relocate the whole module if blocked. Once any slot is claimed or built,
   freeze the module; skip blocked free slots and grow another module rather
   than moving occupied structures. Release unused reservations on role exit.
   AFUS and advanced converters use these slots exclusively; ordinary fusion
   and early dispersed economy keep their existing placement rules.

## Verification planned before implementation

- Engine-free AngelScript tests for overflow-growth admission and income
  allocation, including insufficient energy, queued commitments and stalling.
- Actual AngelScript compile in a rendered staged game, using the matching
  stripped build-6 DLL and current data. No live installation writes.
- Supplied late-economy simulation: physically block an unused economic slot,
  prove the module moves before first use, inject a factory guard into a T2
  aircraft constructor, and observe its departure and subsequent economy work.
  Check early economic-module/six-lab reservations, completed structures and no
  invariant failures. Capture screenshots during the run.
- Natural AIR/TECH simulation through late economy: inspect construction,
  factory production, metal overflow, reactor completion and constructor
  tasks. Preserve unrelated TECH failures in the report rather than hiding
  them. Publish observed limits separately from intended behavior.
- API, role-document, invariant and documentation checks; local commit only.

Implementation and measured results will be recorded after these checks.

## Simulation-driven revision

The first natural AIR/TECH run reserved only four of six intended T2 bays and
exhausted advanced-economy placement after two AFUS. A 700-elmo exclusion disc
around every reactor excluded much more land than the actual economic module.
The final design uses 384 elmos between reactor and factory centres, 512 between
reactors, and four early reserved modules. Native non-overlapping envelopes
remain mandatory. This accepts explosion coupling between districts; neither
700 nor 384 is a blast-safety guarantee. An AIR-only half-pitch fallback fits
complete factory/turret modules between terrain and allied reservations when
the initial factory lattice has no remaining candidate. TECH geometry is
unchanged. These changes address spatial starvation rather than assigning idle
T2 aircraft to production again.

The next mixed-role run still exposed a planning-order dependency: the campus
was not reserved until the first lab's construction order, after early wind
and allied plans had consumed space. Reserve the starter during the first
layout tick, then grow both speculative districts immediately. Actual building
admission remains in the existing rule sequence, and reserving ground spends
no metal or energy.

The final-opening run then isolated an independent growth blocker:
`EcoPlanner::Read` reports any queued T1 energy as `energyBuilding`, even when
there is no unfinished reactor. AIR must override this context using its own
actual queued/unfinished reactor projects; a leftover wind/solar order must
not suppress the entire advanced economy. Keep the shared TECH context as-is.
Serialize all AIR reactor starts through the same project predicate and audit
new admissions, excluding completed targets and repair/guard tasks.

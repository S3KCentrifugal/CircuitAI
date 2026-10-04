# Metal-map proposal: source verification and normal-map isolation

Date: 2026-10-02. **Verdict: revise before implementation. No gameplay code or
configuration changed by this review.**

Reviewed [the proposal](../metal-maps-proposal.md) at CircuitAI
`aacbfc8acd427109991fd133ab9586cbc483551a`, including D-167's committed AIR work.
Engine reference: Recoil `92efda5e60fb6df54a8f17a87e4f4cdb4aa2de31`.
Game reference: BAR `1d267c20d1e2d27586dfb39aaa622698b203c303`.
Proposal line numbers below refer to that revision, before its review notice.

The main diagnosis is correct: the native fallback reduces a continuous metal
field to a sparse spot list, while economy policy still assumes scarce metal
and useful converters. A positional field service and separate metal-map
economy policy are reasonable. The proposal does **not yet establish its central
promise that normal-map behavior stays unchanged**. Its initialization contract,
income units, opening termination and task persistence need correction first.

**Follow-up (2026-10-02):** the [researched design](../metal-maps-revised-design.md)
proposes solutions to F1–F9 and a staged validation matrix. These findings remain
implementation work; the shared extraction-mechanics documentation error has
been corrected separately. The original review and its failed-run verdicts
remain evidence, not successful runtime validation.

## Findings requiring a design change

### F1 — High: the proposed ungated repair changes valid normal-map behavior

Proposal sections 8 and OD-2 (lines 1010–1014, 1111) say the bounds guards and
`spotId = 0` to `-1` repair change only undefined behavior. These are different
changes. In [MexTask.cpp](../../src/circuit/task/builder/MexTask.cpp),
`Reevaluate` releases the original local spot and then sets the index to zero
before aborting. `Cancel` accepts any nonnegative index and reopens spot zero
in both the allied and local managers. Zero is a valid index on normal maps.
Changing that sentinel fixes a real ownership bug, but changes a defined path.

Keep bounds checks and the cancellation repair as a separately reviewed native
correctness change, with its own normal-map baseline. Do not hide the latter
under the metal-map feature's no-change guarantee. Invalid indexed access must
be rejected before indexing; a positional task's legitimate `-1` sentinel must
not itself fail an invariant. The current unguarded accessors in
[EconomyManager.h](../../src/circuit/module/EconomyManager.h),
[EconomyManager.cpp](../../src/circuit/module/EconomyManager.cpp) and
[MetalManager.cpp](../../src/circuit/resource/MetalManager.cpp) still require
repair. Test canceling a task for spot N while an ally occupies spot zero.

### F2 — High: mode selection conflicts with initialization and shared ownership

Sections 6.1–6.2 propose one flag in CMetalData, per-profile JSON settings and a
MapConfig override passed from Setup. In the current code:

- [GameAttribute.h](../../src/circuit/util/GameAttribute.h) owns shared CMetalData.
- [AllyTeam.cpp](../../src/circuit/unit/ally/AllyTeam.cpp) owns CMetalManager per
  ally team, including authority handover. It is not private to each player.
- [MetalManager.cpp](../../src/circuit/resource/MetalManager.cpp), constructor
  and ParseMetalSpots, parses only when that shared data is uninitialized.
- [CircuitAI.cpp](../../src/circuit/CircuitAI.cpp), initialization around
  lines 608–707, initializes the allied metal manager before role setup.
- [setup.as](../../data/script/src/setup.as) resolves the script map configuration
  later. ConfigFloat/ConfigInt in
  [InitScript.cpp](../../src/circuit/script/InitScript.cpp) are readers, not a
  mechanism to rewrite the already initialized shared configuration.

Consequently the first initialized AI could determine everyone else's field
representation from its own profile. A late script override cannot safely
rebuild shared spots after terrain, economy and other teams have consumed them.

Separate immutable map facts from the effective policy mode. Resolve overrides
before selecting a representation, and explicitly choose either a consistent
game-wide mode or separate legacy/field views for mixed opt-in profiles. Keep
allied claims shared; never share reservations with enemies. Reversing AI
initialization order must not change classification or active policy. Do not
ship automatic detection until this contract and its mixed-profile tests exist.

`mex_count <= 0` is an absence of a usable list, not proof of a metal map. Define
what happens for a missing/not-yet-published parameter, a barren map and a forced
mode. With `calc_mex=true` and a positive BAR spot count, the original native
fallback must still run unchanged when metal mode is false. Define the median's
sample population too: taking the median over every map cell would reject a
useful field covering less than half the map. Coverage and yield thresholds are
calibration proposals, not proven classification criteria.

### F3 — High: the skeleton changes the units of existing income fields

Section 6.4 (lines 618–622) stores isolated T1 M/s in SMetal::income and claims
existing consumers retain their meaning. They do not.
[EconomyManager.cpp](../../src/circuit/module/EconomyManager.cpp),
mexFinishedHandler and GetMetalMake, multiply spot income by GetExtractsM.
[CircuitDef.cpp](../../src/circuit/unit/CircuitDef.cpp) reads that extraction
multiplier from the UnitDef; ordinary T1 extractors use 0.001.

For the proposal's Full Metal Plate example, storing **2.37** produces an
estimate of **0.00237 M/s**. The compatible unextracted deposit value is **2370**:
2370 × 0.001 = 2.37, and 2370 × 0.004 = 9.48 for the proposed moho example.
Use explicit units for raw deposit potential, isolated yield, marginal available
yield and observed income. Keep the existing normal-map field's meaning intact.

Section 6.5 also feeds marginal Yield into mexFinishedHandler. Once the new
extractor or its reservation already claims the cells, marginal available yield
can be zero. Accounting for an existing extractor needs attributed income or
an explicitly self-excluding calculation, not the next site's marginal yield.
Test completion before/after claim reconciliation and overlapping T1/T2 units.

### F4 — High: positional upgrades and restored tasks need a full lifecycle

Section 6.5 says CBMexUpTask needs only bounds guards. Its
[Load](../../src/circuit/task/builder/MexUpTask.cpp) instead requires
IsSpotValid(spotId, position) and rejects a positional `-1` task. Bounds guards
alone would silently drop those upgrades on load. They also remove the current
indexed upgrade lock without replacing duplicate-upgrade exclusion.

The upgrade half of
[UpdateMetalTasks](../../src/circuit/module/EconomyManager.cpp), around
lines 1399–1465, still searches around the spot list. Changing only the fresh-mex
branch at 1468 onward leaves most field extractors invisible to that chooser.
Enumerate eligible owned/allied extractors under an explicit upgrade policy;
give a field upgrade its own target and reservation identity.

Specify reserve, assignment, frame creation, completion, cancellation, engine
refusal, destruction, transfer, role switch and load reconciliation for both
task types. BAR's unit_mex_upgrade_reclaimer gadget can transfer a new upgrade
to the original extractor owner and later remove/refund the old extractor.
Those events must not leak claims or count two independent sites.

[BuilderManager::Load](../../src/circuit/module/BuilderManager.cpp) constructs
tasks directly instead of passing through Enqueue.
[IBuilderTask::Load](../../src/circuit/task/builder/BuilderTask.cpp) restores
blockers without checking IsBuildAllowed. Therefore an enqueue-time converter
veto does not alone cover restored converter orders. Add metal-mode restore
reconciliation and an explicit versioned save contract. Exercise queued orders,
live frames, upgrades and partial clusters, including loading existing saves.

### F5 — High: the unchanged AIR opener can exhaust a field before building a lab

Section 6.5 promises existing mex-helper callers can become positional without
script changes. In [air_rules.as](../../data/script/src/roles/air_rules.as),
the commander calls EnqueueMexWithin(start, 700, 3) while no air lab exists.
[EnqueueMexWithin](../../src/circuit/module/EconomyManager.cpp) limits the next
search to three **open, reachable candidates**. It does not limit the lifetime
opening to three completed mexes. Repeated asks on a field can keep finding new
sites until the home radius is exhausted, delaying scouts and constructors.

Implement an explicit metal-map opening budget and completion/deadline state.
Use the design already demonstrated by
[RoleTech::Opening](../../data/script/src/roles/tech.as): count distinct opening
orders independently of the native search limit. Do not alter TECH's existing
normal-map opener. Separate API parameters for search work, queued task count
and opening/economy targets; they are not interchangeable.

Test a large unobstructed home field: after the selected opening budget, AIR
must build its lab, scouts and initial constructors despite thousands of free
sites. Test cancellation and re-asks so they do not double-count the budget.

### F6 — High: the energy decision is circular and can suppress needed growth

Section 6.8 defines need_E from spendable income, then limits spendable income
by the current energy supply. It can conclude that the constrained economy
already has enough energy. Example with a full energy bank and no active
production drain: M=100, E=1000, upkeep=30, r=20, m=0.05 gives spendable=48.5
and need_E=1000. The condition 1000 < 950 is false, although sustaining the
available 100 M/s at that ratio would require 2030 E/s. The loop can request
more spending capacity instead of the missing energy. If drains represents
that same production, adding it again double-counts the energy requirement.

Define a desired spending target from actual projects, army/economy allocation
and available build power. Compute a sustainable budget separately, with
max(0, E - upkeep - other_nonoverlapping_costs) / r. Choose energy against the
desired target and bank horizon; choose production capacity against that
sustainable budget. State precisely which costs are already represented by r.
Use actual UnitDef/upkeep inputs where possible and bound every denominator.

The energy choice also has an uncovered range: wind 16–22 with no T2 builder.
Advanced solar below 16 is not a complete stall-recovery policy because it
costs energy to finish. Add affordable, buildable recovery choices, including
basic solar where available, and water/terrain alternatives. Test zero wind,
empty energy storage, no T2 access, lost reactors and positive/negative banks.

Fixed spending ratios and timing targets are hypotheses. In particular,
40 M/s of sustainable AIR spending at r=28 already needs 1120 E/s before
upkeep; the proposed generic 500 E/s T2 threshold does not fund that workload.

### F7 — High: field searches must distinguish owned layout slots from exclusions

Section 6.3 excludes bay reservations, while sections 6.11–6.12 put mexes inside
reserved economy layouts. Specify a free-field search and an exact owned-slot
admission path. Only the matching owner/task may claim the latter; do not make
all of a role's reserved space generally buildable.

The proposed 128-elmo retry in CBMexTask must respect
[BuilderTask's](../../src/circuit/task/builder/BuilderTask.cpp) required pins.
It cannot silently move a pinned mex outside its slot. Relocate an unused
cluster atomically before first construction, or fail/replan through its layout
owner. Keep occupied clusters anchored and retain cross-role allied exclusion.

[AIR eco modules](../../data/script/src/manager/air_eco_layout.as) currently
encode one reactor and eight converter slots. Introduce a distinct persistent
metal-map module kind/schema. Do not reinterpret an existing normal-map module
after load or role change. Preserve normal AIR/TECH geometry and reclaim policy;
[AIR's post-AFUS low-tier energy guard](../../data/script/src/manager/air_reclaim.as)
also needs an explicit metal-only policy if dense wind remains desirable there.

### F8 — Medium: the extraction field needs provenance and bounded search work

A deepest-depth value alone cannot correctly release overlapping contributors.
Recoil's ExtractorBuilding stores the depth delta attributed to each extractor
and recalculates neighbors when extraction is removed. Track contribution
identities and reconcile active extractors separately from planned reservations.
Test duplicate events, cancellation, upgrades, activation changes and transfers.
Enemy observations must use knowledge available to the AI, not hidden occupancy.

Keep immutable raw terrain separate from buildability for each extractor def,
faction and facing. The first AI's mex definition cannot define a process-wide
buildability mask for every later faction or amphibious extractor.

The skeleton's S=max(cluster_range/2, sqrt(area/400)) does not prove an at-most-400
count once rows/columns are rounded, particularly on long narrow maps. Enforce
an integer bound. The existing
[ClusterizeMetal](../../src/circuit/resource/MetalManager.cpp) already uses
geometric distances above 300 sites; 400 sites do not currently imply 160,000
engine path queries. Its triangular matrix contains 79,800 pairs.

Tile caches are useful, but a fresh whole-home scan per builder ask still scales
with both workers and sites. Specify a candidate budget, resumable/cached query
results and invalidation revisions for terrain, claims and reservations. Measure
AI update time, path/buildability callback counts and orders per minute under
late-game density. No FPS or linear-runtime guarantee has been measured here.

### F9 — Medium: converter and legacy-profile promises are broader than the design

The existing SetBuildAllowed/Enqueue veto is the right mechanism for new
construction; script caps alone are insufficient. However, the twelve named
base converter IDs do not cover optional Scavenger converter structures.
Classify effective buildable converter structures rather than blocking every
UnitDef with a conversion parameter: evolving commanders can also carry one.

The invariant "none queued, framed or standing" also includes gifts, captures
and preexisting saves. Promise no AI-issued converter construction instead,
with explicit handling of restored orders and externally received structures.
Do not silently reclaim gifts to make the test pass. The normal-map invariant
must mean no *metal-map-induced* cap changes; normal roles already use caps.

Legacy easy/medium/hard profiles do not run the experimental shared role
controller. Including their mechanism while leaving their policy unchanged is
not full support for section 6.8's shared economic behavior. Stage experimental
roles first, then implement a separately gated native-profile policy adapter
with JSON/script control. Document unsupported profiles until that is verified.

## Evidence and factual corrections

Verified in source:

- ParseMetalSpots subsamples native fallback sites and consumes rand(); ordinary
  maps with a published list have a distinct branch. Preserve both false-mode
  paths, including RNG call order, rather than testing only the published branch.
- BAR can publish mex_count=-1 for a continuous field or no usable spots. The
  sentinel alone is insufficient for automatic classification.
- Recoil extraction uses a circle over 16-elmo cell centers, with a strict
  squared-distance comparison. The independently recounted Appendix B cell
  counts are 4/12/16/44/60/80/96/120/172 for its listed radii. Its isolated
  Full Metal Plate and SpeedMetal yield arithmetic is consistent with this model.
- The current native fallback's radius rounding differs from that engine model.
  A corrected model belongs behind the new mode if normal estimates must stay
  unchanged. Physical build footprint and extraction radius are separate inputs.

Corrections to the narrative and strength of evidence:

- Section 2's default-role explanation is wrong: an air factory does not
  automatically produce the AIR role. Air plants are in GetArmadaT1LandLabs and
  equivalent faction lists in
  [unit_helpers.as](../../data/script/src/helpers/unit_helpers.as), and
  [DefaultRoleForFactory](../../data/script/src/helpers/role_helpers.as) applies
  the weighted land-role draw. Keep map registration separate from economy
  activation because registering starts/roles itself changes behavior.
- Random fallback sampling can change between initializations; an explicit
  seed and identical RNG state may reproduce it. Do not claim every load
  necessarily changes IDs. Positional upgrade rejection is independently
  established by its Load implementation.
- The shared knowledge page
  [27-metal-maps-and-spots](../../../rjm.bar.docs/knowledge/20-game-mechanics/27-metal-maps-and-spots.md)
  incorrectly describes extraction as summing a rectangular building footprint.
  Its cited CMetalMap rectangle overload is not the extractor's circle loop.
  Prefer the actual ExtractorBuilding source for this design; KB correction
  remains recorded in KI-471.
- The official [economy guide](https://www.beyondallreason.info/guide/in-depth-look-at-economy)
  supports balancing build power and resources and using affordable energy
  recovery. It does not validate these metal-map timing targets, fixed ratios,
  unit-cap arrival times or PvP superiority. Those remain model outputs and
  playtest hypotheses, not established meta outcomes.
- This review did not reproduce the entire 261-map scan or economic simulator.
  The temporary map_scan.csv exists, but generated thresholds should be backed
  by retained fixtures, scripts, map versions and reproducible commands before
  being treated as a tested detector. No new simulations were run.

### Audit of the three existing simulations

Read the retained reports and bounded infolog evidence in the proposal's
Appendix C paths. All three reports say **FAIL (deadline)**, missing the TECH
opening/experimental-mode checks and screenshots. There were no matching
script-crash/error markers in the audited logs. Headless runs do not supply
visual evidence. They demonstrate current symptoms, not successful validation
of this proposal or the current D-167 build.

| Run | Actual team-0 initial role | Completion events: T1 mex / moho / T1 converter | At 12 min: metal income; bank |
| --- | --- | --- | --- |
| metal1 / 20261002-103300, SpeedMetal | FRONT | 7 / 7 / 0 | +858.8; 8781/8900 |
| metal2 / 20261002-104126, Full Metal Plate | AIR | 6 / 0 / 7 | +23.2; 922/1400 |
| metal3 / 20261002-104125, Nine Metal Islands | FRONT | 15 / 0 / 11 | +27.8; 1268/4850 |

Completion events are cumulative, not a census of surviving units. The
proposal already identifies these actual roles, but its harness labels team 0
TECH and the smoke verdicts are not disclosed in its table. Nine Islands'
final bank is about 26%; the table's "near 0 for most of the game" is not its
12-minute bank measurement. The staged DLL hash prefix is ace9d657b26093f0;
the proposal explicitly used an older script snapshot excluding D-167's new
cluster call. Do not use this baseline to certify current TECH or new AIR layouts.

## Corrected rollout and acceptance contract

1. **Freeze a normal-map baseline.** Decide and verify the separate native
   bounds/cancellation repair. Record effective config, RNG seed and initialization
   order. Retain complete build/script hashes and role logs.
2. **Implement map facts and explicit opt-in mode.** Keep legacy spots and their
   consumers intact for false mode. Resolve configuration before initialization;
   reject ambiguous automatic classification. Do not add normal-map RNG calls,
   new rule evaluation, cap mutations or field scans. Keep automatic mode disabled
   until the map corpus and mixed-profile contract pass.
3. **Implement the field/task mechanism.** Typed yield quantities, bounded site
   search, separate positional task identities, exact pin ownership and lifecycle
   reconciliation first. Prove cancellation/save/load/gift/upgrade behavior in
   controlled fixtures before enabling mass construction.
4. **Add experimental-role policy and distinct layout variants.** Use explicit
   opening budgets, corrected energy/spending math and metal-only rule branches.
   Retain the original normal-map rule table order, factory sequence, geometry,
   converter handling, reclaim thresholds, transport and combat behavior.
5. **Validate natural growth and combat, then legacy profiles and auto detection.**
   Measure economically funded production rather than raw income or mex count.
   Repeat normal-map comparisons at every stage, not only after all phases land.

Minimum regression matrix:

| Case | Required evidence |
| --- | --- |
| Normal map with positive published spots, e.g. Supreme | Same ordered spots/income/clusters, RNG continuation, rule decisions, task descriptors, layout pins and caps for the same inputs |
| Same normal map with calc_mex=true | Original fallback ordering, random calls and outputs preserved |
| No-metal map; missing parameter; sparse/vein map without published spots | New policy remains off unless deliberately forced; no classifier false positive or startup deadlock |
| Water/island map, e.g. Tundra, and mixed terrain | Existing mex reachability, shores, factory sites and allied reservations unchanged |
| Metal map with mode=off | Full legacy path still usable, including its known limitations |
| Metal mode across Armada/Cortex/Legion; optional content | Correct land/water yield, buildability, converter admission and affordable energy choices |
| Mixed profiles, allied/enemy teams, reversed init order | Agreed mode semantics, no first-profile-wins leakage, no enemy reservation sharing |
| AIR/TECH role exit/reentry, partial clusters, save/load | Stable claims and pin ownership; exact restoration of non-metal policy/settings |
| Opening, energy crash, upgrades, gifted/captured mexes | Bounded opening; recovery progress; no duplicate task, leaked claim or income double count |
| Late dense base plus army production | Bounded update/query cost, stable APM, no factory/ground-route blockage |

Use small deterministic scalar/native tests for classification, extraction,
units, overlapping claim removal, ordering and economy decisions. Use runtime
scenarios for engine lifecycle, terrain and production. The invariant checker
only checks that declarations, logging and actors are documented; it cannot
prove safe C++ indexing or behavioral equivalence. Keep read-only detector
diagnostics on normal maps if useful; prohibit activation/mutations rather than
all log lines with a MetalMap prefix.

Normal games can diverge because of runtime scheduling; do not claim whole-game
byte equality from one replay. Compare deterministic decision inputs/outputs
and RNG use, then check natural openings and milestones over repeated games.
For rendered simulations, provide the requested screenshots and ongoing
behavior analysis; failed checks remain failures. Successful source review is
not a runtime performance or gameplay guarantee.

## Review disposition

Keep the proposal as a research record with this correction notice; implement
only after its contracts above are incorporated into the actual design.
No owner-rule exceptions, new map registration, converter restrictions or native
bug repairs were applied by this review. D-168 records this decision. Current
unresolved implementation problems and the KB discrepancy are indexed as
KI-469–471 in [known issues](../known-issues.md).

Review checks: independent strict-circle counts matched all nine Appendix B
entries; the income-unit and energy counterexamples reproduced as stated.
The invariant practice checker reports zero findings, and git diff --check
reports no whitespace errors. The documentation link checker finds only the
eight preexisting references to the missing hover role document (KI-404), with
no new broken links. Native/script tests and new games were not run because
this change contains documentation only.

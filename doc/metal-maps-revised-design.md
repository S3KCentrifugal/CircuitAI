# Metal maps: researched solutions and implementation design

Date: 2026-10-02. **Status: implemented with the owner amendment below.**
The original research sections remain as design history; the dedicated forty-mex
opening supersedes their bank-limited initial expansion. See
[implementation](metal-maps-implementation.md) and [measured results](metal-maps-results.md)
for what was actually built and verified, including remaining failures.

This design answers F1–F9 in the
[source review](reviews/2026-10-02-metal-maps-proposal-review.md). It supersedes
the corresponding implementation recommendations in the
[original proposal](metal-maps-proposal.md), preserving that document as evidence.
The [gameplay research](../../rjm.bar.docs/knowledge/70-strategy/79-metal-map-pvp.md)
contains the pinned mechanics, source links, economics and limits of the player
evidence. All normal-map AIR/TECH behavior remains the baseline, including
TECH's exact lab reclaim/rebuild sequence. Proposed metal-only exceptions below
are recommendations, not changes already applied or owner decisions already made.

## 1. Gameplay conclusions that drive the design

1. **Abundant extraction sites do not mean unlimited usable income.** A rich
   SpeedMetal mex and a moderate-yield plate mex create very different demands
   on energy and production. Grow whichever resource or local build capacity
   limits the next useful workload; never optimize mex count by itself.
2. **The first factory cannot wait for the field to be exhausted.** Choose a
   small opening extraction budget, then start scouts, builders and defense.
   Nearby construction preserves commander time. Protected economy expansion
   continues with mobile builders and local nano support.
3. **Keep cheap T1 economy while it remains useful.** On constant high wind,
   wind has a strong construction-cost advantage. A moho costs much more than
   equally productive free-ground T1 expansion. Reactors and upgrades earn
   their place through density, safety, access, operational simplicity and
   funded output, not simply a tier or clock threshold.
4. **Budget the actual units.** A fixed AIR 28:1 energy ratio substantially
   underestimates fighter/T2 bomber workloads. Include power for weapons and
   ammunition. An idle or energy-starved factory is not a reason to add another.
5. **Fight for safe space, access and production.** A bridge, open exit, covered
   landing zone, worker group or power district may matter more than another
   resource tile. Raiding must assess the output denied rather than defaulting
   to any mex or blindly preferring the most expensive structure.
6. **Economy and combat must progress together.** Scout, retain interception,
   fulfill transport requests and respond to contact while growing. Rich maps
   accelerate threats too. An all-economy opening or naked strategic rush is
   not established as the winning meta.

The research supports these priorities. It does **not** establish one optimal
human build order, a universal six-minute T2/nuke deadline or a guaranteed bomber
win rate. The cited video transcripts were unavailable; a sampled private
Cloud9 game and its author's description are limited evidence. BAR's quick-start
lists are an optional instant-build feature, not a normal opening benchmark.

## 2. Resolve every review finding

| Finding | Proposed solution | Player-facing result | Acceptance proof |
| --- | --- | --- | --- |
| F1: indexed task safety | Separate native repair; explicit indexed versus field site identity; ownership release never uses spot zero as a sentinel | Canceling a mex never steals another player's spot; normal-map repair is disclosed | Spot-zero ally fixture, invalid-index checks, indexed-task baseline |
| F2: shared mode/init | Immutable shared raw facts; per-AI frozen mode from early JSON; separate allied field claims; retain legacy data | A teammate's profile or initialization order cannot change another role's economy mode | Reversed initialization and mixed enabled/disabled profiles |
| F3: income units | Typed deposit potential, isolated/marginal/observed M/s; keep SMetal unchanged; no economic use of a new skeleton | Income estimates match real production and do not vanish on completion | Uniform fields, overlap, completion accounting |
| F4: persistence | Explicit field task payload and version; lifecycle reconciliation from unit/task IDs; separate upgrade target lock; metal-only restore veto | No duplicate upgrades, lost saved jobs or resurrected forbidden converter orders | Save/load at every reservation/frame/upgrade stage |
| F5: opening | Metal-only opening state machine and budget, distinct from candidate search limit | AIR gets a lab and its first units even on an enormous field | Unlimited-home-field fixture with queued/canceled orders |
| F6: economy | Desired workload, sustainable funding and local capacity calculated separately; cost-aware candidate ranking | Energy grows before production demand starves the base | Mixed queues, energy crash, surplus and reactor-loss cases |
| F7: layout ownership | Free search versus exact owned-slot admission; versioned metal module kinds; atomic unused-cluster relocation | Mexes use planned space without occupying allied clusters or exits | Blocker, mixed AIR/TECH, partial-load and pinned-retry cases |
| F8: claims/performance | Sparse keyed contributors, actual/reserved layers, budgeted resumable search, phase-staggered updates | Large mex fields remain responsive without issuing duplicate orders | Overlap lifecycle fixtures; dense 8v8 callback/APM timing |
| F9: veto/profile scope | Reasoned native construction veto plus metal policy; optional-content classification; separate legacy adapter phase | No new converter construction in enabled roles; received units handled explicitly | All factions/content, restored orders, mode-off exact path |

## 3. Initialization and the normal-map boundary

### Recommended ownership

| Object | Owner | Contents and restrictions |
| --- | --- | --- |
| Existing CMetalData and CMetalManager | Existing process/ally owners | Keep legacy spots, statistics, clustering and RNG behavior; do not replace their data with field sites |
| New MetalFieldFacts | GameAttribute, lazy shared cache | Raw bytes, dimensions, scale, extraction radius, source fingerprint and raw topology; no first-faction buildability or profile mode |
| New MetalMapContext | Each CCircuitAI instance | Frozen enabled/mode/config version, candidate policy inputs, selected compatible economic path |
| New MetalFieldClaims | AllyTeam | Keyed reservations, known extractor contributions and upgrade locks, with authority handover; visibility-limited enemy observations |
| Field search cache | Enabled AI or compatible keyed ally service | UnitDef/facing/terrain/claim revision in key; results may never grant another owner's slot |

**Keep the initial legacy graph even for enabled AIs in the first implementation.**
It remains a coarse tactical compatibility graph, not an economic site catalog.
This costs the existing startup work but avoids changing every legacy consumer
or first-initializer behavior at once. Positional construction and counts bypass
the graph in metal mode. Defer a separate field strategic atlas until profiling
shows a need; never overload SMetal with differently dimensioned values.

Read a new economy.metal_map policy from already loaded native configuration,
before CTerrainManager::Init applies mex preblocking. Native map-name overrides
live in that same JSON and are selected deterministically. Setup later **reads**
the frozen context. Remove the proposed late MapConfig-to-JSON mutation. Mode
does not change on role switches, and the active save records it and its version.

Initial rollout defaults to off. An explicit enable requires compatible game
placement rules and nonzero usable extraction; it is not permission to put mexes
anywhere on an ordinary spot map. An ordinary positive BAR spot list remains
outside automatic field mode, including when calc_mex=true requests the original
native analyzer. Unknown/missing publication is a distinct pending/unsupported
case, not equivalent to BAR's published -1. Resolve before field orders; otherwise
remain on the existing path with a diagnostic.

Auto mode comes later. Validate game classification, broad/local field opportunity,
and actual buildable positive-yield candidates. Use the game's metal-map shape
rules/map metadata as evidence that its mex-order denier permits field placement;
coverage alone is not a substitute. Separate barren, ordinary, broad field and
vein-like unknown cases. The positive-site yield median excludes zero/invalid
samples and is computed for the actual eligible UnitDef. Do not reject a useful
platform because most of the total map is void. Ambiguous vein maps stay off
until explicitly tested. A future game rules flag would help, but this design
does not depend on modifying BAR or Recoil.

On mode=false, do not initialize or scan the field, call new RNG, rewrite caps,
change shared rule order, reinterpret saves or alter layout geometry. A single
dispatch at existing task/economy entry points chooses the existing body. All
new scoring is deterministic and uses a separate tie-break if needed. Generic
mechanical correctness repairs are separate commits with a separately recorded
normal-map behavior change; the feature itself compares against that baseline.

Mixed enabled/disabled allies share observations of finished mexes and frames.
Only enabled AIs publish field reservations. A legacy AI or human can issue an
unpublished order; exact preflight and graceful refusal handle that race, just
as with human building today. Do not claim perfect coordination with hidden
human queues, or modify the disabled AI's commands to obtain it.

## 4. Extraction and site selection

Give the API quantities explicit meanings:

| Quantity | Units | Use |
| --- | --- | --- |
| DepositPotential(def, snappedPos) | Scaled raw deposit sum, before extraction multiplier | Isolated geometric comparison and compatible conversion to yield |
| IsolatedYield(def, snappedPos) | M/s | Potential with no other extractor or reservation |
| MarginalYield(def, snappedPos, excludeClaimKey) | Additional team M/s | Admit a new site or calculate an upgrade after excluding its own reservation |
| ObservedOwnedIncome(unitId) | M/s | Existing extractor accounting, separate from speculative claims |
| ProductiveFreeSites(queryBudget) | Partial count plus complete/incomplete flag | Density decisions; budget exhaustion must not mean no sites remain |

Calculate the circle at the final engine-snapped position, with strict cell-center
inclusion and runtime modifiers. Store sparse contributor records keyed by unit
ID or (AI ID, task serial), with active/completed and planned layers separate.
Dirty only the affected tiles on add/remove/transfer. Recompute the local maximum
when an overlapping contributor disappears; decrementing an unowned scalar is
insufficient. One reservation becoming a live frame is a transition, not two claims.

Use authoritative team resource samples for the budget. Avoid injecting the
same speculative completion yield into every income sample and then counting
it again through observed income. When observed per-unit income is unavailable,
label geometric attribution as an estimate and reconcile to measured team income;
do not invent exact ownership under overlap. Expected upgrade benefit is a team
delta, not the moho's full isolated yield plus the still-existing T1 income.

Site selection is lexicographic: legality/ownership/reachability, survivable
location, preservation of corridors and future districts, then positive marginal
benefit versus travel/build cost. Consider safe rear cells before exposed higher
yield. Avoid traversing front lines with economic air constructors merely because
flight makes the site reachable. Threat and unknown-route padding remain policy.

Use measured runtime footprints, extraction radius and terrain rather than one
universal 64-elmo pitch. Start with a conservative non-overlap pattern; permit
denser extraction only if its marginal yield and space value justify it. A search
may temporarily return Pending; the worker should perform a valid local task
or bounded wait instead of creating another expensive search or walking away.

## 5. Tasks, pins and save/load

Use a tagged site reference: LegacySpot(index) or FieldSite(position, claimKey,
owner, revision). A field upgrade additionally names targetUnitId and a stable
upgrade key. Do not send -1 into legacy arrays and rely on no-op bounds guards
as the task's ownership model. Keep indexed task serialization readable.

| Event | Required transition |
| --- | --- |
| Enqueue | Validate ability, mode and policy; atomically acquire field claim and optional exact layout pin |
| Re-ask | Return the same live task/claim; do not count a second opening mex |
| Create frame | Attach unit ID; convert provisional occupancy to observed frame without doubling contribution |
| Complete | Replace reservation by active extraction; release builder assignment but retain observed unit contribution |
| Abort before frame | Release only that task's claim and pin; leave allied/observed occupancy intact |
| Engine refusal | Revalidate required pin; ask layout owner to relocate an unused cluster or cancel; no silent 128-elmo escape |
| Upgrade | Lock the extractor target; tolerate BAR transfer/refund ordering; reconcile old and new unit IDs |
| Destroy/transfer/deactivate | Remove or change the relevant observed contribution once; rescore local affected tiles |
| Load | Restore mode/schema, unit observations and tasks; rebuild derived claims; check conflicts in stable order before issuing any order |

Native load currently bypasses Enqueue. Add metal-only admission at restoration
as well, so an old converter order cannot return through that path. Existing
received/unfinished structures are explicit recovery cases, not proof that the
AI illegally requested them. Never reclaim a teammate's building to satisfy an
invariant. An unsupported newer save version fails clearly rather than silently
dropping work. Old saves without a field tag load in legacy mode; switching them
to field mode is a separate, explicit migration, not an automatic side effect.

Use CBMexTask/CBMexUpTask service methods to share stable construction mechanics,
but keep type-specific ownership in the tagged adapter. Avoid cloning entire
task classes or replacing the legacy indexed state wholesale.

## 6. A workload-based economy controller

Implement a pure AngelScript decision core over one periodically assembled
snapshot; perform enqueue/claim changes only at the callback boundary. Costs,
work time and builder capability already have script-facing data; new native
queries should expose facts, not secretly choose build priorities.

### Demand, funding and capacity are separate

For project j with desired output q_j units per second:

    desired_M = sum(q_j * metalCost_j)
    desired_E = sum(q_j * energyCost_j) + upkeep + weapons + stockpiles
    desired_BP = sum(q_j * buildTime_j)

For each active project, cap actual progress by assigned reachable build power
and available funding. Allocate construction work only once: a nano shared
between two labs cannot count at full capacity for both. Use factory cycle time
buildTime/BP + measured startup/launch delay to estimate throughput. Do not
estimate delay from total unit time while resource-starved; distinguish stalls.

Bank allowance is max(0, bank - protectedReserve)/planningHorizon. Protected
reserves cover agreed emergency combat, strategic ammunition and recovery work.
Build sustainability from measured local generation and ongoing external inflow;
temporary reclaim or a one-off gift belongs in the bank, not a permanent income
promise. Define whether each engine callback is gross income, usage, attempted
pull or net balance before using it. Separate conversion usage and upkeep from
construction to prevent double subtraction.

The desired plan is **not clamped to current energy before checking energy
deficit**. Sustainable funding limits how much of the plan to execute now; the
gap guides new economy. On the review's M=100/E=1000 example, the unmet desired
energy remains 1030 E/s rather than disappearing through the spendable formula.

### Decide what investment advances the plan

Evaluate a bounded set of candidates: finish a useful frame, add affordable
energy, add extraction, add a mobile worker, add local nano support, add a lab,
upgrade density, buy/get construction access, or wait/reduce optional demand.

Compare completion time under actual resource and local BP constraints, useful
output gained over the planning horizon, travel, risk and space/slot cost.
Unstarted reservations provide no income. Finishing a nearly ready reactor can
beat starting many scattered wind frames; a long unaffordable AFUS can be worse
than incremental wind. Count committed projects so every builder does not choose
the same missing capacity. Keep explicit hysteresis and a commitment cooldown
except for danger/stalls, avoiding oscillating build/cancel orders.

Recommended decision order:

1. Immediate survival, valid transport delivery and critical recovery.
2. Finish viable critical work and restore a failing resource reserve.
3. Deliver the role's protected production/intelligence allocation.
4. Fund and construct the best affordable economic/capacity investment.
5. Use remaining capacity for optional expansion or strategic projects.

"Priority" includes a bounded funding allocation, not only queue position. A
transport request should get the next compatible production slot and adequate
funding; it need not repeatedly cancel a nearly completed fighter. Track request
IDs and fulfillment so several requestors do not cause duplicate transports.

Expose tuning in MetalMap settings: horizon, confidence margin, reserve seconds,
growth allocation, opening cap/deadline, search work limits, upgrade density
threshold and risk weights. Begin with conservative explicit tuning and log
decisions; do not label untested numbers as human meta. Existing normal-map
settings remain untouched.

### Concrete AIR workload example

Twenty armpnix plus twenty armhawk cost **7600 M, 372000 E and 730000 build work**
at the pinned definitions. Delivering that example batch every 120 seconds needs
63.3 M/s, 3100 E/s and 6083 effective BP before economy, upkeep, other units,
loss replacement or factory startup overhead. One 600-BP T2 lab plus twenty
200-BP nanos needs at least 158.7 seconds for the build work alone.

This is a workload illustration, not the mandated raid composition. It shows
why +50 raw metal, a lab cost in storage, or two AFUS cannot independently prove
that another lab or a bomber wave is affordable. Recompute from the chosen units
and actual cycle delays. [Arithmetic inputs/results](https://github.com/S3KCentrifugal/CircuitAI.benchmarks/blob/main/doc/benchmarks/metal-map-economics.json)
are reproducible with [the analysis calculator](../tools/knowledge/metal_map_economics.py).

## 7. Opening, midgame, late game and recovery

### Opening state machine

Bootstrap -> FirstFactory -> FirstWorkersAndScouts -> BalancedGrowth.
Emergency recovery can interrupt any state; it does not erase already fulfilled
milestones. Save each state's distinct task IDs and completed/claimed budget.

For ordinary plate starts, test a one- or two-mex initial budget with enough
nearby energy to fund the first lab and worker/scout stream. For very rich
extraction, test one mex before lab/energy rather than another automatic mex.
Select the budget using actual starting banks, local yield and intended costs;
these counts are candidates for comparison, not a fixed new universal opener.
A small hard ceiling and deadline prevent an unbounded field from holding the
factory. Canceling an unstarted task returns its budget; a repeated ask does not
consume it. Adopt quick-start/gifted structures without rebuilding milestones.

AIR retains scouts first, then three constructors with commander help and
immediate fighter production. If production is idle, commander work returns to
reachable economy or a useful assist. Seed local wind clusters of six as the
owner requested; do not require the commander to walk to distant fields. Additional
workers are demand-driven: enough to maintain the home construction backlog,
not an unbounded constructor queue. Emergency interception can interrupt growth.

TECH retains its exact lab reclaim/rebuild rules. Adapt only the metal-mode
economy predicates and opening inputs. Before reclaiming a lab when that exact
rule calls for it, preserve enough existing T1 constructors to continue the
required wind/mex work; do not change the lab rule to compensate for a missing
worker plan. Other experimental roles use the shared scalar economy decision
but retain their production domain and combat duties.

### Transition and continuing growth

T2 access needs a useful next job and a funded transition budget, not upgraded
everywhere or +50 raw metal alone. Prefer an available allied constructor when
delivery is faster/cheaper and safe. Purchase/transport protocols stay reusable;
receiving a constructor is not a command to stop T1 growth.

Keep T1 mex expansion while good safe sites and worker capacity exist. Compare
an upgrade with **three additional T1 mexes** for the same extra output, including
travel, upkeep, space and risk; never use the moho's total output as its increment.
Power growth can precede mass upgrades. Add worker/nano capacity when existing
resources could fund useful projects faster; add factories only for throughput,
independent queues, tech access or reduced startup overhead.

For AIR retain the owner's twenty completed construction turrets per current
T2 lab before another T2 lab. This is a necessary policy gate, not proof of
resource affordability. Track the support assigned to each lab and add further
labs in six-site compounds with no global maximum. Preserve at least one T1
plant for affordable scouts, transports and workers. T2 air constructors seed
economy and density work; factory assist is temporary and released when a
funded economic job exists or the factory is idle.

### Density and recovery

Switch when forecast economy/army slots, safe build area or worker travel become
constraints. Do not wait for a hard 2000-unit cap or assume that cap is universal:
read the effective team limit, reserve slots for army/replacement workers and
use the remaining budget. Prefer local healthy upgrades and affordable reactors;
retire replaced wind in small batches only after measured capacity is online.

On energy loss, pause discretionary growth/raids, retain essential military and
rebuild affordable power. Basic solar's zero energy build cost is a recovery
option where buildable; choose wind/tidal when the bank/inflow can fund them.
Do not wait for an energy-expensive advanced solar or AFUS to finish unaided.
When mexes are lost, reserve energy and worker time to restore extraction before
building more labs. Keep the last capable T1/T2 worker and enough production
access to replace it. Recovery is resource/terrain-dependent, not timer-dependent.

## 8. Layouts, territory and combat

Reuse the existing native layout geometry, reservations, allied exclusion and
pin lifecycle. Add script-owned **module specifications**, not a second layout
engine or calls into TECH's role controller. Keep the existing normal spec and
serialized namespace intact. Metal variants have explicit kind/version keys.

| Module | Purpose | Placement rules |
| --- | --- | --- |
| Wind block | Six densely packed turbines | Separate neighboring blocks for raid loss containment; reachable construction; use actual explosion/footprint geometry |
| Extraction block | Yield-aware mex positions and optional upgrade targets | Preserve future factory/eco districts and ground routes; bounded blocks instead of an endless carpet |
| Construction hub | Nano reach over funded economy work | Connect to work sites; do not count its support simultaneously at full power for every project |
| AIR production compound | Up to six dense lab sites and their support | Existing AIR pattern; safe home location, at least one T1 in first compound, no economy intrusions |
| Reactor district | Fusion/AFUS with dedicated construction access | Separate from production and other critical power; damage-risk budget and repair access, no compulsory eight-mex ring |
| Strategic defense edge | Radar/AA/anti-nuke and appropriate front defense | Coverage without occupying economy/factory reservations; respect no walls in allied base radius |

All maps need traversable exits. Fixed 64–96-elmo gaps are not automatically
enough for every ground unit; preflight representative movement classes and
reserve bridges before economic packing. Empty-cluster replanning is atomic
across all slots and allied reservations. A started cluster stays anchored and
repairs individual missing/blocked sites without moving working structures.

**Target selection:** estimate bottleneck-adjusted output denied for an economic
target using observed/estimated power, production and reconstruction time. Divide
the benefit by the raid's resource/time cost and expected attrition. Cheap
extractors can be a poor raid compared with power/workers on a plate, but a
high-yield rich-map mex remains attractive. Include construction turrets,
factories and clustered army where the resulting tempo advantage is larger.
No hidden enemy income, unobserved anti-air or exact unseen production queues.

**Air tactics:** maintain scouts and a fighter reserve over friendly territory;
intercept projected bomber routes with a home-defense return leash. Send bomber
waves only when target, route, escort and expected surviving payload justify them.
Re-scout a stale route; account for known AA and uncertain approach/egress.
Use map edges when safer, not as a fixed waypoint ritual. Synchronize static
suppression with a funded land push; gunships/EMP support follow a concrete
frontline opportunity. Do not continually feed a discovered flak trap.

**Nuclear defense:** plan completion **and first loaded interceptor** before the
credible threat window. Cover the closest neighbor where legal and useful without
opening a gap over one's own critical assets. Account for existing coverage,
ammunition, simultaneous launches, obstruction and construction cost. Use enemy
scouting plus conservative risk insurance rather than a universal minute-eight
order. Offensive nukes retain static targets and the per-silo location cooldown.

## 9. Proposed exceptions and preserved owner requirements

| Existing instruction | Metal-map recommendation | Non-metal behavior |
| --- | --- | --- |
| TECH lab reclaim/rebuild sequence exact | Preserve exactly; plan T1 worker stock beforehand | Unchanged |
| AIR late economy follows TECH after +50 M/s | Replace raw-income trigger with funded workload/tech opportunity | Existing trigger and sequence unchanged |
| Upgrade every mex before reactors | Do not require an unbounded field to be upgraded; compare marginal investments | Existing admission unchanged |
| Retire wind after first AFUS | Retain productive wind until space/slots/risk justify replacement and enough power survives | Existing D-167 reclaim unchanged |
| Two AFUS before mass T2 bombers | Recommend a metal-only funded-wave gate; high-wind economies may support raids without two AFUS | Existing two-AFUS gate unchanged |
| First bomber wave random 10–20 | Keep the configurable opening range; budget real units/escorts and defer an unaffordable launch | Unchanged |
| Twenty nanos per existing T2 air lab before another | Preserve, plus actual funding and assignment checks | Unchanged |
| No converter construction on metal maps | Enforce as requested; external gifts and existing units are separate accounting/recovery cases | Existing converters and caps unchanged |
| Friendly transport requests prioritized | Preserve and generalize request IDs/ownership for future requestors | Unchanged |
| No economic/factory overlap between allies; walls outside allied base | Preserve with exact pins and field-specific reservations | Unchanged |

The economic exceptions are supported recommendations for the new mode. They
should be adopted explicitly in its policy settings during implementation; do
not quietly amend normal AIR/TECH rules. The no-converter rule is a design
constraint even in rare trapped-base cases where converting surplus energy
could be economically defensible. In that case report site exhaustion and
choose safe expansion, access, sharing or army action rather than deadlocking.

## 10. Performance, interfaces and implementation sequence

Native additions expose geometric yield, bounded field searches, claim/pin
ownership, mode facts, effective unit limits and resource/cycle measurements.
AngelScript owns choices, allocation, role exceptions and search tuning. Existing
costM/costE/GetBuildTime/GetWorkerTime inputs can be reused. Any proposed new
interface must be registered and tested; these names are design contracts, not
claims that current bindings already exist.

For search, charge cell evaluation and engine callbacks against explicit budgets,
not just a number of candidate sites: extraction discs have different sizes.
Use local invalidation, deterministic candidate order and negative-result caches.
Batch owned counts and workload aggregation once per economic snapshot. Avoid
cross-products of all workers, sites and tasks. Keep combat event responses
independent of a slow economic search; stagger periodic work across AI instances.
Reissue commands only for meaningful destination/target/task changes. Profile
normal-mode overhead and enabled-mode p95/p99 update cost, not average FPS alone.

Implementation stages and release gates:

1. **Independent correctness baseline:** F1 bounds/cancel repair, indexed save
   regression, explicit documented normal-map change. No economy retuning.
2. **Off-by-default facts and field:** typed calculations and deterministic field
   tests; no role activation. Mode=false follows the same branches and RNG calls.
3. **Task lifecycle and controlled fixtures:** positions, pins, upgrade/gift/load,
   dense/restricted terrain; actual engine yield compared with predicted deltas.
4. **Experimental-role openings and economy:** all factions, no converters,
   bounded AIR start, balanced spending and unchanged TECH lab sequence.
5. **Layouts and battle goals:** factory/eco/field coexistence, allied separation,
   funded raids, interception, naval/void cases and strategic defense readiness.
6. **Natural games and performance:** repeated 8v8 plate games, rich strip and
   platform/water games; same seed/mod options/build hashes with normal controls.
7. **Legacy profiles and auto detection:** separate JSON-controlled adapter;
   enable only after effective normal-map and mixed-profile tests pass.

Every stage repeats the review's normal-map matrix: published spots, calc_mex
fallback, barren/missing metadata, sparse veins, mixed profiles, water, role
switch and save/load. No blanket invariant disabling. Introduce field-specific
promises for identity uniqueness, claimed income, opening termination, pin
ownership, converter order admission, ammunition-ready defense and bounded work.

## 11. Validation that measures useful play

At opening, five, ten, twenty and late-game checkpoints record: actual role,
map/mode facts, local gross output, sustainable workload, banks/excess, stall
seconds, constructor travel/idle time, completed support per lab, factory funded
utilization, T1/T2 construction access, unit-slot headroom and pending project
commitments. A screenshot of the map/layout should accompany each rendered run.

Combat evidence must include threat-to-response delay, bomber payload delivered,
value/output denied, escort/bomber losses, defensive interception before target
death, air-constructor losses, strategic ammo and territory secured. Report
declined raids and their reasons. A wave count or rapidly increasing mex count
alone is not success. Preserve failed checks and resource-supplied fixture labels.

Compare opening candidates and economic choices under identical resource and
pressure scenarios, including early raids and reactor destruction. Then compare
with a versioned human replay sample as described in the gameplay research.
Accept timing thresholds only after that evidence; do not inherit the original
proposal's economic-model growth curve as a performance guarantee.

Current verification: source-traced design, scalar cost checks and independently
reproduced arithmetic only. No new engine simulation, code deployment or claim
of an optimal/unbeatable metal-map AI. The provided calculator is an analysis
tool, not a replacement for the required gameplay tests.

Static verification on 2026-10-02:

- The analysis calculator ran successfully and cross-checked its scalar inputs
  against the pinned BAR files.
- The invariant-practice checker reported zero findings.
- CircuitAI's documentation link check found only the eight existing references
  to the missing hover-role document (KI-404); links added here resolve.
- The shared knowledge checker found zero broken links or missing images. Its
  five unit-ID warnings are in the pre-existing air-mechanics page, outside this
  research change; this is not a claim that the entire knowledge tree is clean.
- Whitespace checks passed for the changed tracked documentation. No native,
  AngelScript, profile or deployed-game file was changed.


## Owner amendment: dedicated 40-mex opening (2026-10-02)

This supersedes the earlier bank-limited initial field expansion. For AIR and
TECH, the first T1 constructor owns extraction until at least forty owned mexes
stand or are under active construction. Reserve compact, atomic eight-mex
modules through the shared native layout engine, with footprint and extraction
radius spacing, allied exclusion and first-use relocation. Preplan five modules;
continue the bounded search when terrain blocks a candidate. The second T1
constructor owns power construction (efficient wind first, solar/tidal fallback).
Worker identities persist in layout state, with replacement after death.

TECH's third T1 constructor initiates its T2 lab as soon as it exists; the first
two remain on their assignments. Keep the exact TECH lab reclaim/rebuild rows.
AIR starts its first T2 lab after the configured initial fighter screen, before
ordinary economy expansion, then adds support and workers rapidly. Later AIR
labs retain the twenty-completed-turrets-per-existing-T2-lab gate. Energy and
build-power shortages still require remedies; abundant metal is not free energy.
The forty-mex target is explicit owner policy, not a claimed universal PvP rule.

Other roles use positional field extraction near their moving constructor and
keep their existing production/combat domain. All new behavior remains gated by
metal mode. Re-run metal-map observations for the worker assignments, cluster
spacing, forty-mex progress and transition timing, then repeat ordinary Supreme
and Glacial controls after these changes.

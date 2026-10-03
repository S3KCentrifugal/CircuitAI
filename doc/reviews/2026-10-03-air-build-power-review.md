# AIR build-power scaling review

Reviewed 2026-10-03 against D-179 at commit `2eb25a0f`. This is a
review and proposed correction plan; no gameplay, settings or native code
changed. TECH's exact build/reclaim sequence remains the regression baseline.

## Conclusion

AIR does not currently use TECH's complete response to spending falling behind
metal income. It shares an economy chooser, but keeps independent workforce,
factory-support, opening-budget and assistance rules. Those rules can disagree
about whether more build power is needed and whether it is allowed to be built.
Raising the constructor ceilings alone will not address this.

Use a common **metal spending gap** and resource-feasibility decision, followed
by role-specific allocation of constructors and turrets. A positive gap means
available metal exceeds actual spending; a metal shortage is the opposite and
does not justify more builders by itself. Requested metal **pull is not actual
usage**. Retain energy recovery and explicitly distinguish planned savings from
involuntary accumulation.

The donation amendment below makes this explicit: a positive recurring spending
gap is **not required** when sustained high storage and a funded useful project
justify investing banked capital. Spending above self-produced income alone is
not a metal-shortage veto.

## What TECH actually does

- [TechBuild::TrackMetal/MetalAhead](../../data/script/src/roles/tech_build.as)
  samples the bank once a second. Defaults: bank rises by 30 metal across up to
  15 seconds, or remains at least 90% full for 15 seconds. The rising test can
  qualify before a complete window. It intentionally avoids the engine's pull.
- [TechRules::DoPowerTurret](../../data/script/src/roles/tech_rules.as) requires
  an unfinished structure, no energy stall, no conflicting dear order and a
  bank of 1.5 turret costs. Before T2 it requires the sustained-full condition.
  Above 20 static BP per metal/s it normally stops, but sustained-full overrides
  that ratio. If another turret cannot start, workers assist existing work.
- [EcoPlanner::PickTurret](../../data/script/src/manager/eco_planner.as) provides
  a separate baseline: 8 static BP per metal/s, multiplied by 1.5 while metal
  floats, with income and bank gates.
- [Layout::TurretSlots/TurretsAllowed](../../data/script/src/manager/layout.as)
  derives parallelism from nearby BP, bank, income and construction time, then
  subtracts expensive frames already occupying the construction budget.

Thus TECH is already more nuanced than a single `income - pull` calculation.
Do not replace its tested rules with that expression.

## Findings

### R1 — High: AIR has targets, but no sustained spending-gap response (KI-486)

[ConstructionPower](../../data/script/src/helpers/production_math.as) uses
gross income times 24, plus a bank-drain allowance only after metal reaches
`max(75% of storage, 300)`. Neither actual usage, a rising-bank history nor
actual project progress is an input.
[ConstructorTarget/NanoTarget](../../data/script/src/manager/air_economy.as)
consume that target independently. The constructor ceilings remain 40 T1 and
24 T2 even with persistent overflow; after T2, a fixed 45%/55% split decides
the two tiers. Factory support separately uses the gross target, production
forecast and fixed per-lab limits. This can both underreact to a real shortage
and overbuy nominal capacity when the current workers already spend everything.

For example, at +20 metal/s and 2,000 storage, raising the bank from 200 to
1,400 leaves the calculated target at 480 BP. With a 60-BP constructor that
is eight aircraft in both cases, regardless of actual expenditure. At 1,600
bank the target abruptly becomes 1,080 BP. These are executed helper examples,
not timings or unit stats measured in the retained game.

**Correction:** one sampled pressure state, backed by actual usage and bank
trend/fullness, plus a budget for draining existing excess. Account for queued
capacity and allocate the shortage to useful work. Keep safety ceilings visible
in telemetry; allow a measured shortage to request appropriate additional
capacity rather than silently treating a ceiling as proof of sufficiency.

### R2 — High: opening and lab savings override funded constructor demand (KI-487)

[AirProduction::MakeTask](../../data/script/src/manager/air_production.as)
requires `!saving && !supportBudget && !openingTurn` before its workforce turn.
The D-172 anti-starvation rule therefore cannot help through any of these holds.
The three-constructor/fighter opening is intentional. The later absolute holds
are the problematic interaction, including new D-179 behavior, not just legacy
code.

[OpeningSupportBudget](../../data/script/src/roles/air_build.as) can hold
production merely because a turret slot exists and minimum energy is 160.
It does not check the same affordability test as `Nano`. A real example through
the current pure helpers: 500 metal bank, 1,000 energy bank, +20 metal/+160 energy
can fund a 110M/2,100E constructor but cannot fund a 230M/3,200E turret. The hold
can therefore reject a useful, affordable worker while the preferred support
project cannot be admitted. This is a delay risk, not proof of permanent deadlock:
existing builders can still grow energy.

After support completes, the opening bomber recruitment batch takes precedence
over additional workers. It need not wait for the raid to end. First-lab saving
also pauses new construction in AirRules/Commander, retaining existing assists,
mex work and recovery. Banking a lab is useful; an unqualified workforce pause
can slow the economy that must fund it.

**Correction:** reserve a concrete funded amount for opening support/first lab;
permit a proven, affordable workforce deficit to compete within that budget.
Keep the random bomber batch and its three-constructor/two-turret prerequisite,
but permit workforce recruitment between bomber orders when needed. Do not
remove transport priority, the initial fighter screen or T2 capital protection.

### R3 — High: factory power is treated as economic capacity across districts (KI-488)

[EcoPlanner::Read](../../data/script/src/manager/eco_planner.as) counts all
completed static assist BP within AIR's 2,400-elmo home radius. That includes
factory support regardless of whether it can reach the reactor or is occupied
producing aircraft. [AirProduction](../../data/script/src/manager/air_production.as)
assigns bay turrets to their producing factory first, borrowing them for nearby
economy only when that factory has no production frame.

Meanwhile [AirEcoLayout](../../data/script/src/manager/air_eco_layout.as) reserves
reactor/converter slots without an economic turret bank, and `AirBuild::Nano`
only places factory-bay support. Separated districts therefore rely on mobile
workers while a base-wide static count can tell the shared chooser that enough
economic power exists.

**Correction:** reserve reachable economy support alongside reactor modules.
Maintain separate production/economy assignments and credit each turret only
where it can actually work. Aircraft should seed jobs, reposition and expand;
local turrets should provide efficient bulk assistance. Do not count the same
power against both simultaneous workloads. Preserve shared allied reservations.

### R4 — Medium: AIR's support batch rule and chooser disagree (KI-489)

`AirBuild::Nano` permits one unfinished/queued turret globally, or three when
the instantaneous bank crosses the floating threshold. TECH instead computes
a funded batch from local BP and existing projects. AIR can have ample resources
and several production districts but still be restricted to three support jobs.

After the +50 growth transition, `AirGrowth::MakeTask` first runs TECH's
8-BP-per-metal chooser using the broad static count. It can return reactor
assistance before AirRules reaches `production.support`, even when AIR's separate
24-BP target or twenty-per-T2-lab goal remains unmet. The earlier overflow branch
helps only while the floating threshold is met. Sharing the chooser has not
made the two roles' build-power rules equivalent.

**Correction:** derive a single funded capacity request before the chooser;
calculate a bounded batch from available local workers, completion time and
resource budgets. Allocate it by district. Retain the requirement for twenty
completed, uniquely credited turrets per existing T2 lab before another lab.
That production-support requirement is not a universal cap on economic turrets.

### R5 — Medium: fixed assistance horizons cap usable economic power (KI-490)

[FindAssistTarget](../../data/script/src/roles/air_build.as) calls
`ProductionMath::AssistUseful` with a fixed 120-second reactor horizon or
12-second small-project horizon. It refuses another assistant when assigned
nominal BP could finish within that time, irrespective of a full metal bank.
Assigned power includes workers travelling to the task, not just workers whose
build progress is observed. New constructors can therefore exist without being
admitted to the slow economic project.

At 80% completion, 312,500 total work and 600 assigned BP, the helper rejects
another assistant: 62,500 / 600 is already below 120 seconds. On the reference
9,700-metal AFUS, 600 BP spends only about 18.6 metal/s before resource stalls.
A well-funded +100-metal economy can still be severely underspending. Existing
assistants are not forcibly removed by this test; it restricts new assignments.

**Correction:** size assistance from the affordable spend rate and remaining
work, with diminishing-return/travel safeguards. Track actual progress and
arriving capacity. Reuse the no-progress investigation under KI-443 rather than
treating more aircraft as the remedy for stuck workers.

### R6 — Medium: native recruitment can lower a funded constructor's priority (KI-491)

[CRecruitTask::Update](../../src/circuit/task/static/RecruitTask.cpp) tests
`averageMetalIncome * 2 > metalPull`. When false it sets both engine and BAR
resource priority to zero, including a script-requested HIGH BUILDPOWER recruit.
There is no stored-metal exemption and no AIR opt-in distinction. This affects
resource priority, not a direct cancel/stop command; actual starvation depends
on competing demand and BAR's resource scheduler. No retained telemetry proves
this caused the Glacial delay.

**Correction:** reproduce with a funded constructor plus a high-pull economic
frame, observing actual unit progress and resource priority. If confirmed,
expose an opt-in script policy for funded workforce priority. Preserve the
default native behavior for TECH and other roles; do not globally rewrite this
condition during an AIR repair.

## Suspected stale behavior ruled out

- Legacy `MinT1AirConstructorCount=3`, second/third-constructor income gates and
  the old dynamic factory chooser are bypassed by the active experimental AIR
  factory delegate. Builder selection similarly delegates to AirRules first.
- The native constructor-ratio chooser is not an additional admission gate on
  AIR's explicit recruit path. `CRecruitTask::CanAssignTo` checks buildability,
  absence of a frame and producer proximity. Its later priority update remains
  relevant as described above.
- Donations are not absent from the income model:
  [UpdateResourceIncome](../../src/circuit/module/EconomyManager.cpp) includes
  engine RECEIVED metal. The ten-second minimum can reject intermittent receipt
  peaks, while the bank still contains those resources. Do not add receipts to
  this smoothed income again and double-count them.
- T1/T2 economy aircraft are already excluded from production guards. Keep the
  D-172 ownership fix; diagnose any surviving engine movement stall separately.

## Recommended shared design

1. Sample own INCOME, USAGE, RECEIVED, SENT, EXCESS and bank once per second via
   existing [TeamEconomy](../../data/script/src/manager/team_economy.as) /
   `GetOwnEco` bindings. No new C++ API is required for these measurements.
   Use consistent engine sampling intervals; do not mix raw rates with the
   native smoothed/receipt-inclusive income or repeatedly accumulate the same
   transfer sample. Bank trend/fullness supplies a cross-check.
2. Separate recurring spendable income from finite donated/reclaimed/banked
   capital and explicit lab reserves. Compute a positive spending gap, allowing
   a configurable drain time for excess capital. Account for metal sent away
   so overflow donations cannot hide a sustained capacity shortage. Independently
   admit bank-funded growth under the donation/full-bank policy below, even when
   the recurring gap is zero or negative.
3. Distinguish missing useful work, insufficient energy, insufficient reachable
   BP and delayed/idle workers. Finish energy with existing reachable BP when
   energy is the limiter. Add builders only when they have a funded useful job.
4. Allocate economic and factory capacity separately. Derive work needed from
   loaded target `buildtime / metalCost`, subtract available/arriving BP once,
   and choose turrets for reachable stationary work or aircraft for mobile work.
   Aircraft cold-start/output delay remains in the production calculation.
5. Extract pure arithmetic and bank-pressure helpers, first locking down TECH's
   existing outcomes in tests. Preserve its call order, thresholds, reclaim
   rules and pre-T2 exception exactly. AIR adopts the reusable signal with its
   own allocation; it does not call TECH's mutable role state.

This follows the official guidance that excess resources need spending capacity,
and that aircraft constructors have low BP while turrets provide efficient local
assistance: [economy guide](https://www.beyondallreason.info/guide/in-depth-look-at-economy),
[air guide](https://www.beyondallreason.info/guide/basics-of-air-warfare).
The specific controller above is an engineering recommendation, not a published
optimal PvP formula. Metal maps must keep their energy-limited sustainable-metal
budget, dedicated opening workers, dense mexes and converter prohibition.

## Donation and full-bank amendment (2026-10-03)

The owner points out that allied donations can keep AIR at maximum metal while
its own economy spends more than it produces. The controller must distinguish
three observations: self-produced income minus actual usage, net external
support, and spendable stored capital. None alone describes the whole economy.
A full bank is also a saturated observation: it cannot rise further, so requiring
a positive bank slope would fail precisely when capacity is most needed.

### Admission: capacity shortage plus either flow or capital funding

Consider additional BP when a useful reachable workload lacks available or
arriving workers, and **either** of these funding paths passes:

- **Recurring funding:** conservative own income plus credible net support can
  carry additional spending, with energy available.
- **Stored-capital funding:** the bank stays high or repeatedly refills, and the
  bank itself can fund a small BP investment plus useful work without consuming
  protected reserves. This path does not require a positive own-income balance
  or a positive recurring balance. It can also serve a one-off donation, with
  the scale limited to what the bank funds.

Use configurable high/low storage bands and a short persistence window to avoid
oscillation. TECH's existing 90%/15-second signal is a candidate initial AIR
pressure setting, not an established optimum or a prerequisite for replacement
of lost opening workers. Record bank pressure before voluntary overflow sharing,
then check fresh spendable capital after any actual or committed outbound share.
Keep the existing all-role donation threshold and percentage unchanged.

Before admitting a batch, project metal and energy over a configurable horizon
(60 seconds is an initial test value). Deduct the new constructor/turret cost,
existing expected spending, incremental spending on its intended job and
protected reserves. Count queued investments and commitments once; do not
subtract the same project as both a lump sum and a spend-rate forecast. Evaluate
the reserve floor throughout the horizon, including the interval before the BP
finishes. Reject an investment that only appears affordable because future
unconfirmed donations are assumed to continue.

For a conservative first batch, set future donations to zero. Repeated observed
net receipts can inform the next batch and longer-term capacity target, with
bounded forecasts and rapid decay when support stops. Re-evaluate actual bank
drawdown, arrivals and spending after each admitted batch. Stop further growth
when the reserve/runway condition fails; finish already funded useful work
instead of cancelling jobs or reclaiming workers immediately.

Example, illustrative rather than a game measurement:

| Input | Value |
| --- | ---: |
| Own income | 30 metal/s |
| Current actual spending | 80 metal/s |
| Bank / protected reserve | 8,000 / 2,000 metal |
| Proposed turret cost | 230 metal |
| Additional funded workload | 15 metal/s |

Even if all donations stop now, the approximate runway above reserve is
`(8000 - 2000 - 230) / (80 + 15 - 30) = 88.8 seconds`. That can support a
60-second admission test, subject to energy, other commitments and local BP
need. An own-income deficit of 50 metal/s therefore must not reject it.
With only 2,500 metal bank, the same proposal has about 4.2 seconds of runway
and should be deferred. If the net drain is zero or negative, metal imposes no
finite runway in this simplified calculation; energy and useful work still do.

### Avoid false signals

- Sample RECEIVED and SENT separately and estimate retained external support.
  Repeated transfers around a full team are not permanent productive income
  (existing KI-484). A transfer out is not construction spending.
- A saturated bank can clip actual accepted receipts; do not infer that zero
  received while full means there was no support. The stored-capital path still
  works, without inventing the amount allies attempted to send.
- Do not require the ten-second minimum receipt rate to be positive: periodic
  donations have zero-receipt intervals. Track window totals at the engine's
  sampling cadence and keep these separate from stable self-production.
- The pinned engine exposes previous team resource-update amounts. Team resource
  state resets every 30 frames; sample a given completed interval once, using
  simulation time. Do not count repeated reads as additional transfers or
  pretend skipped intervals were observed. Existing `metal.income` already
  averages production plus receipts; do not add the receipt estimate to it again.
- Full metal with energy starvation or unused reachable workers does not justify
  indiscriminate BP growth. Reassign existing workers to energy first. A further
  worker/turret remains eligible only if its own energy cost is funded and it
  improves the identified energy-construction bottleneck.

Prefer local turrets for funded stationary work and air constructors when work
needs mobility or construction initiation. Preserve twenty completed support
turrets per existing T2 lab, economy/factory separation, transport priority,
metal-map isolation and TECH's exact sequence. Full storage is a funding and
pressure signal, not permission to buy power with no useful destination.

### Required donation cases

Add policy tests and later matched fixtures for: full bank with negative own
balance; full bank with negative total recurring balance but sufficient runway;
five-second donor bursts; receipts clipped at full storage; one-off gifts;
donations stopping abruptly; a whole team circulating metal; outgoing sharing
between sampling and admission; queued BP already sufficient; and full metal
with insufficient energy. Verify increased actual useful spending, maintained
reserves and continued aircraft production. Do not merely assert more workers.

This amendment is design only. Sampling contracts were traced through
`TeamEconomy::OwnMetal`, `CEconomyManager::GetOwnEco/UpdateResourceIncome`, and
the reference engine's `CTeamHandler::GameFrame/CTeam::ResetResourceState`.
The two runway examples were calculated directly. No gameplay policy or native
priority override has been implemented or simulated by this amendment.

## Implementation map and acceptance contract (2026-10-03)

The following maps the known findings to implementation and verification. It is
an implementation checklist, **not a list of completed changes**. R1-R5 have
identified script paths; R6 requires a causal reproduction before a native fix.
Unexpected failures during implementation must extend this map and the issue
register rather than silently broaden the change. Proposed new paths below are
written as code because the files do not exist yet.

### Code changes, in dependency order

| Step | Files and entry points | Required change | Verification |
| --- | --- | --- | --- |
| 1. Deterministic budget | New `data/script/src/helpers/build_power_math.as`; existing [production_math.as](../../data/script/src/helpers/production_math.as) (`ConstructionPower`, `ConstructorFunded`, `SupportQueueReady`, `AssistUseful`, `WorkforceTarget`); [air_math.as](../../data/script/src/helpers/air_math.as) (`WorkforceTurn`, `SaveForLab`) | Pure calculations for bank pressure, resource runway, committed capacity, affordable assistance and batch size. Reuse existing funding arithmetic where equivalent; replace AIR call sites that disagree. Inputs distinguish actual usage, requested pull, transfers and capital. Do not silently change a shared helper's behavior for other roles. | V1, V2 |
| 2. One AIR observation and decision | New `data/script/src/manager/air_workforce.as`; [air_economy.as](../../data/script/src/manager/air_economy.as) (`Tick`, `Reset`, `ConstructorTarget`, `NanoTarget`, `RefreshSupport`, `SupportBay`, `ExistingT2SupportReady`); [global.as](../../data/script/src/global.as) (`RoleSettings::Air`) | Sample once per resource interval. Build an AIR-owned snapshot of funding, useful projects, assignments, available/arriving BP, queued investments and production demand. Replace independent income-ratio targets with a funded capacity request, keeping production cold-start estimates and unique twenty-per-lab accounting. Expose pressure bands/window, forecast horizon, reserve and safety bounds in AIR settings. Give every rejection a reason; a safety ceiling is not evidence of sufficient BP. Include the new modules through the existing AIR include graph. | V1, V3, V4, V7 |
| 3. Builder admission and assistance | [air_build.as](../../data/script/src/roles/air_build.as) (`Commander`, `OpeningSupportBudget`, `Nano`, `SupportCommitted`, `Committed`, `FindAssistTarget`, `AssignedPower`, `Assist`, `Tick`, `Added`, `Removed`, `Leave`); [air_rules.as](../../data/script/src/roles/air_rules.as) (`MakeTask`) | Use the same funded decision for the commander branch, ordinary builders, opening support and first-lab savings. Reserve real costs; do not let an unaffordable preferred turret veto an affordable useful constructor. Allocate bounded support batches and assistance to actual reachable work. Distinguish travel from working BP, retain guard recovery, and account for newly accepted orders immediately so simultaneous callbacks cannot spend one budget twice. | V1, V3, V4 |
| 4. Factory admission and turret dispatch | [air_production.as](../../data/script/src/manager/air_production.as) (`MakeTask`, `Recruit`, `Tick`, `Reset`, `Leave`); [air_growth.as](../../data/script/src/manager/air_growth.as) (`MakeTask`, `AssistReactor`) | Replace blanket `saving/supportBudget/openingTurn` workforce holds with the common admission result. Preserve transport precedence and opening prerequisites; interleave funded workforce with the opening bomber batch. Dispatch economy-owned turrets explicitly instead of falling through to the default factory task. Feed reachable economic BP into AIR's shared chooser and handle the workforce request before discretionary reactor assistance can hide it. | V3, V4, V6 |
| 5. Economic support reservations and ownership | [air_eco_layout.as](../../data/script/src/manager/air_eco_layout.as) (`Module`, `Save`, `Init`, `Reserve`, `Activate`, `ReleaseUnused`, `PlanAhead`, `Place`, `Leave`); [air_layout.as](../../data/script/src/manager/air_layout.as) (`Init`, `PlanAhead`, `RepairSupport`, `Place`, `Leave`) | Reserve economy-local turret slots through the existing native layout engine, separate from factory bays. Add a versioned support-slot collection, preserving the reactor/converter slot meanings. Adopt old named state safely; reconcile completed, queued, gifted, destroyed and retiring units. Release unused claims on role exit. Keep occupied modules anchored, relocate blocked unstarted modules, and never encroach on allied reservations. | V3, V4, V5 |
| 6. Metal-map bypass | [metal_economy.as](../../data/script/src/manager/metal_economy.as) (`AirTask`, `EconomyTask`, `DedicatedTask`); AIR's workforce snapshot and production caller above | The early metal-map return bypasses ordinary AirRules: integrate the new decision in its AIR branches too. Preserve the dedicated mex/energy opening workers, energy-limited sustainable spending, dense mex layout, converter prohibition and TECH rules. Do not substitute unlimited raw metal for an energy-funded budget. | V4, V6 |
| 7. Conditional native priority | [RecruitTask.cpp](../../src/circuit/task/static/RecruitTask.cpp) / [RecruitTask.h](../../src/circuit/task/static/RecruitTask.h) (`Update` and task state); [FactoryManager.h](../../src/circuit/module/FactoryManager.h) (`TaskS::SRecruitTask`) / [FactoryManager.cpp](../../src/circuit/module/FactoryManager.cpp) (`Enqueue`); [FactoryScript.cpp](../../src/circuit/script/FactoryScript.cpp); [task.as](../../data/script/src/task.as) (`TaskS::Recruit`); AIR recruit caller | Only if V8 demonstrates harmful demotion: expose a script-controlled, task-scoped funded-workforce exception, default disabled. Define initialization, revocation when funding expires and role-exit behavior before implementation. Never infer permission from role names in native code or change all recruits globally. If the task needs a renewable lease, register that control as well; the fixture decides whether this branch is needed. | V3, V8 |
| 8. Tests, observability and records | Files in the verification map below; [invariants.as](../../data/script/src/manager/invariants.as), [invariants.md](../invariants.md), [actor-matrix.md](../actor-matrix.md), [AIR reference](../roles/air.md), [build reference](../roles/air_build.md), [rule reference](../roles/air_rules.md), [base-layout.md](../base-layout.md), [angelscript-references.md](../angelscript-references.md), [decisions.md](../decisions.md), [known-issues.md](../known-issues.md) | Pair each implemented fix with its runtime invariant, all relevant actors, measured evidence and current source markers. Update API documentation only if the conditional binding is added. Mark Built versus Played accurately; close findings only to the extent demonstrated. | All |

The existing lifecycle callbacks in [builder.as](../../data/script/src/manager/builder.as)
and [air.as](../../data/script/src/roles/air.as) already deliver AIR task events.
Use those hooks and AIR Init/Leave; do not add duplicate global callbacks without
evidence of a missing event. Persist stable IDs, not borrowed native handles.
Reconcile ownership after load, transfers, deaths, cancellation and role changes;
ordinary production turrets may lend spare capacity, but cannot be credited to
production and economy simultaneously.

Avoid the current project-by-worker rescan in assistance selection. Index
assignments by task/unit ID once per snapshot and use local candidate lookups.
The recurring census should scale with owned units, active tasks and reservations,
not their product. Geometry searches remain event-driven, separately bounded
and profiled; do not claim the complete planner is O(n) merely because the census
is. Refresh admission resources at enqueue time and commit a local budget delta;
this avoids stale snapshot overspending without rescanning every unit per ask.

**Save/adoption detail:** the current economic module loader accepts at most nine
reactor/converter slots, and placement depends on slot zero being the reactor.
Appending nanos to that array would break adoption and converter iteration.
Keep a separate support array/count/schema version. For an occupied old module,
reserve a validated supplementary support area or continue using mobile BP;
do not move the reactor or expand its claim into an ally's area. Roll back every
new reservation if the support batch cannot be reserved atomically. Keep the
existing reactor/converter completeness assertion (INV-107) and add separate
support/ownership assertions.

**Protected boundaries:** retain [TECH's rules](../../data/script/src/roles/tech_rules.as),
[build actions](../../data/script/src/roles/tech_build.as),
[layout](../../data/script/src/manager/layout.as) and
[shared chooser defaults](../../data/script/src/manager/eco_planner.as).
AIR can override its chooser snapshot without changing TECH's read/decide path.
Extracting TECH's existing bank arithmetic into a shared pure helper is optional
and must follow exact parity tests; it is not a prerequisite for repairing AIR.
Reuse stateless arithmetic, not TECH's mutable samples or rule execution.
Keep [TeamEconomy::ShareOverflow](../../data/script/src/manager/team_economy.as)
thresholds/percentages and the existing own-resource bindings unchanged. No
`data_sample/`, roster, combat-routing or legacy profile change is required.

### Verification files and fixtures

| Surface | Implementation of verification |
| --- | --- |
| Pure policy and geometry | Add `tests/build_power_math_tests.as` to [tests/CMakeLists.txt](../../tests/CMakeLists.txt) and [run_native_tests.sh](../../tools/run_native_tests.sh), using the existing standalone AngelScript runner. Extend [production tests](../../tests/production_math_tests.as) and [AIR tests](../../tests/air_math_tests.as) where call contracts change. Keep existing geometry/allied-reservation tests; add geometry cases only for any new shared geometry primitive. |
| Controlled workforce experiments | Extend [prepare_air_workforce.py](../../tools/playtest/prepare_air_workforce.py) with named staged scenarios and add a staged-only `tools/playtest/air_workforce_probe.as`. Add `tools/playtest/cases/air/economy/workforce-*.json` and `tools/playtest/checks/air/economy/air_workforce_budget.json`. Inject resources, blockers, losses and orders only in isolated test directories. |
| Independent observations | Extend [air_workforce_watch.lua](../../tools/playtest/widgets/air_workforce_watch.lua) to measure actual engine usage, transfers in/out, excess, unit progress, working/travelling/idle BP, factory progress and task transitions. Join these with policy decision reasons and intended ownership; a policy log claiming assignment is not proof of useful work. Retain [air_command_watch.lua](../../tools/playtest/widgets/air_command_watch.lua) for APM. |
| Natural games and comparisons | Extend [run_air_natural.py](../../tools/playtest/run_air_natural.py) to select explicit seeds/factions for paired runs; extend [analyze_air_natural.py](../../tools/playtest/analyze_air_natural.py) with workforce/funding measurements. Add tests for interval deduplication, missing observations, event parsing and cohort comparison in `tools/playtest/test_air_workforce.py`. |
| Existing checks to audit | Replace the narrow/prefix-matching constructor-count assertions in [air_build_power.json](../../tools/playtest/checks/air/economy/air_build_power.json) (KI-492) with scenario-specific completion and useful-spending checks. Review [air_economy_capacity.json](../../tools/playtest/checks/air/economy/air_economy_capacity.json) and [air_economy_probe.as](../../tools/playtest/air_economy_probe.as): preserve the individual guard-release assertion, while separately checking that both T1/T2 economy workers eventually leave idle production guards. Do not weaken invariant forbids or rewrite archived checks/results. |
| Metal and TECH regressions | Reuse [prepare_metal_check.py](../../tools/playtest/prepare_metal_check.py), [metal_watch.lua](../../tools/playtest/widgets/metal_watch.lua), [audit_metal_check.py](../../tools/playtest/audit_metal_check.py) and the existing TECH opening/rush checks. Observe the unchanged TECH sequence as well as outcomes. |

### Acceptance matrix

The timing bounds below apply to controlled fixtures where required sites,
energy, builders and the requested task callback are available. Natural games
have combat and placement constraints and must be measured separately.

| ID | Experiment | Pass condition |
| --- | --- | --- |
| V1 | Pure arithmetic: rising/full/falling storage, negative own and total recurring balance, finite donated capital, five-second bursts, clipped receipts, repeated reads, skipped intervals, outbound sharing, donor loss, energy deficit, queues and travel | Full-bank negative-income fixtures admit a useful funded investment; insufficient runway, no useful job or already-sufficient queued capacity reject it. Every interval and commitment is counted once. Both resource reserves hold throughout the forecast, including before worker completion. Zero/near-zero costs or net drain produce defined finite decisions without division errors. |
| V2 | TECH protection | If shared arithmetic is extracted, compare old/new outcomes at threshold boundaries, early/complete sample windows and float/full exceptions before changing a caller. TECH thresholds, rule ordering, reclaim/rebuild and twenty-BP exception remain identical. If callers stay unchanged, verify that source boundary and run the same opening/rush regression checks. Natural multiplayer timings need not be bit-identical when AIR changes. |
| V3 | Compile and lifecycle | All three experimental profiles compile against the staged DLL; script/API parity passes before launch. Exercise AIR entry/exit, cancellation, gifts, destruction and re-adoption. No new ERR/crash/invariant lines, duplicate allocation or dangling ownership. AIR economy aircraft resume useful work after idle guard release; active PLAYER/ferry ownership is preserved. |
| V4 | Isolated opening, donated capital and one/six-lab workloads, all three factions | With an idle eligible factory/builder, a funded shortage is admitted on its next applicable task request after the snapshot (snapshot no older than one second). A worker/turret physically completes and increases useful resource spending. Unaffordable opening support does not veto an affordable worker; protected first-lab capital remains funded. Donor removal prevents further admissions once the next sample shows insufficient runway. Energy-starved and already-sufficient controls do not buy unnecessary BP. Twenty completed turrets are uniquely credited to each existing T2 lab before expansion; economy turrets do not satisfy that production gate. |
| V5 | Separated districts, blockers and old named state | Reactor assistance works while distant bay turrets continue aircraft production. Each turret has one credited workload. Test old nine-slot modules, metal-map reactor-only modules, blocked unstarted support, occupied modules, allied TECH/AIR reservations and role handoff. Reservations remain valid, occupied reactors remain anchored and failed batches leave no leaked pins. Screenshots show physical placement and assistance. |
| V6 | Natural and map regressions | Run paired baseline/fix games on Glacial Gap v1.1, Supreme Isthmus v1.7, All That Glitters v2.2.3, Tundra Continents v2.3.1 and Serene Caldera v1.3. Use three paired seeds per map, covering Armada/Cortex/Legion across the cohort; observe at least 30 minutes, extending to 45 where needed for late scaling. Compare opening completion, actual expenditure, overflow duration, idle/reachable BP, energy stalls, T2/fusion/AFUS/bomber times and transport/combat progress. Repeat metal-map controls on Full Metal Plate 1.7, SpeedMetal BAR V2 and Nine_Metal_Islands_V1: dense mex/energy opening and zero converters must hold. |
| V7 | Cost and command overhead | Profile the census at increasing worker/project counts, and paired full 8v8 games with one and multiple AIR roles. Confirm no per-project full unit scan, duplicate command spam or new combat-response delay. Measure AI update p50/p95/max, engine speed and actual synchronized commands per simulation minute. An unexplained repeatable p95 update regression over 5% requires investigation; do not hide it in run-to-run noise. Flag any sustained AIR APM above the owner's 3,000 threshold. Do not introduce a blanket rate limiter. |
| V8 | Conditional native recruit-priority reproduction | Compare identical funded constructor requests with low/high competing pull, recording engine/BAR priority and physical build progress. Only implement step 7 if demotion measurably delays the funded recruit. Then verify the opt-in restores progress, expires safely when funding fails and leaves non-opted-in TECH/other-role recruits unchanged. A priority log alone is insufficient evidence. |

For V6, report both the whole-game verdict and AIR-specific measurements. A
known TECH invariant failure still makes the whole-game check fail; it does not
disappear from the archive because AIR improved. Require all controlled fixes
to pass and an improvement in useful spending or persistent overflow in each
previously failing reproducible scenario. Investigate natural-game regressions
in energy stalls, first T2 timing, transport and combat production before calling
the change verified. Report first fusion and effective T2 raid timing against
the owner's twenty-minute targets; a missed target remains visible, with its
cause, rather than being treated as an automatic success. Three seeds provide
regression evidence, not proof of globally optimal gameplay.

Capture rendered opening, midgame and late-game screenshots, including the
funded support project and separated factory/economy workers. Share behavior
updates and screenshots while simulations run. Store unique raw games and
immutable published evidence using [test-storage.md](../test-storage.md), with
source/DLL/data hashes, engine/game/map versions, seeds, settings, supplied versus
natural classification and original checks. Do not modify the live game install
or an unrelated running match.

### Implementation completion gate

Proceed in this order: baseline fixtures and tests; pure decisions and sampled
state; caller integration and layout ownership; focused reproductions; matched
natural/metal/TECH games; performance checks; documentation and evidence. Step 7
can be omitted with a recorded negative reproduction. An unavailable map or
unexecuted test is a verification gap, never a pass. No additional user policy
decision is needed to implement R1-R5; R6's branch is an engineering evidence
gate. The current review commits contain no gameplay implementation or new
simulation result.

## Evidence and validation

Executed the current pure AngelScript helpers in the existing standalone
interpreter: **133 production tests and 113 AIR tests passed**, plus five
temporary review probes confirming R1's below-threshold target, R2's funding
mismatch, R4's fixed batch ceiling, R5's assistance refusal and the non-waived
40/24 constructor ceilings. Passing probes demonstrate current behavior, not
that the proposed correction is implemented. No new full-game simulation ran.
The invariant register and whitespace checks pass. Documentation link checking
reports only the eight existing missing-hover links (KI-404), with none in the
new review or its register entries.

Re-read the retained D-179 natural Glacial log (2,541,482 bytes / 18,793 lines),
team 0 only, from the [documented archive](../air-opening-recon-plan.md):

| Game time | Observed event |
| --- | --- |
| 2.16 min | Third constructor recruitment ordered. |
| 6.10 min | Three T1 constructors versus target seven; +14M/+325E; banks 1,460M/5,442E; `savingLab=false`. |
| 6.87 min | Opening bomber ordered after support completion. |
| 7.05 min | First `constructor.expand`, projected four versus target eight. |
| 9.10 min | Eight versus target nine, `savingLab=true`. |
| 12.10 min | Sixteen versus target twenty, `savingLab=true`. |

This establishes that AIR stayed below its own workforce target and that growth
resumed after the opening batch. It does not attribute every intervening second
to one gate: the old telemetry lacks per-gate rejection/funding reasons. The
archived full-game result still fails unrelated TECH invariants; it is not a
clean whole-game benchmark. The review's helper examples use explicit reference
stats, while these logs reflect their own staged game version and modifiers.

Before implementing, add tests for rising/full/falling banks, one-off and
repeated donations, donations out, low-wind energy recovery, queued BP, travelling
workers, separated economy/factory districts, both constructor tiers and all
factions. Integrate checks that a funded reachable shortage cannot be hidden by
an unrelated opening budget, and that BP is never credited to two concurrent
projects. Keep twenty-per-lab and TECH sequence invariants intact.

Then compare matched baseline/fix runs on Glacial, Supreme, Glitters, Caldera
and Tundra, plus a separately classified metal-map regression. Record actual
spend, bank trend, overflow/donations, energy stalls, active versus idle BP,
constructor/turret completion, T2/fusion/bomber timing and command count. Include
supplied-metal/energy-isolated fixtures and natural games; provide screenshots
of allocation while those games run. Preserve failed results and benchmark
cohorts under the existing [storage conventions](../test-storage.md).

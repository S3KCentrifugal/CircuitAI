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
   so overflow donations cannot hide a sustained capacity shortage.
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

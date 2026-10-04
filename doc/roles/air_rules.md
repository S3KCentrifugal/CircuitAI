# AIR ordered building rules

D-181 replaces the metal-floating-only support row with a funded `Nano` request
before shared growth. The first-lab savings branch also permits that request
above its protected lab reserve. `AirWorkforce` owns the budget; failure falls
through to existing assistance/energy behavior. Metal maps already call the
same `Nano`/`Assist` actions from `MetalEconomy::EconomyTask`, while dedicated
mex and energy workers retain precedence. TECH's table is unchanged.

D-179 inserts `opening.support` / `opening.support.assist` after starter/transport
factory recovery and before discretionary expansion. They require three
completed air constructors, funded resources, and no energy recovery. The
commander handles the same support goal through its local action path. The
metal-map dispatch stays ahead of these normal-map rows. See
[opening and recon plan](../air-opening-recon-plan.md).

`transition.storage` expands a nearly full pre-T2 metal store when it cannot
hold the loaded advanced lab cost. Mex upgrades/recovery retain priority; the
existing factory income or fully banked-cost admission is unchanged. The
metal-map branch remains separate.

D-171 checks `starter.reclaim` immediately after preserving current
construction. A retired opener does not repeat the initial mex/energy sequence.
T1 reconstruction waits for T2 access and its bank, except transport recovery.
Bomber admission now reads sustained income; the two-AFUS growth objective
remains separate. See [D-171](../air-committed-operations-plan.md).
The normal opening checks three owned mexes explicitly: native `maxSpots=3`
limits search candidates, not the total opening. This prevents extra commander
walks before the first lab; metal-mode forty-mex policy remains separate.

D-170 dispatches explicitly detected metal maps to `MetalEconomy::AirTask`
before the ordinary AIR table. This preserves the ordinary-map sequence while
providing dedicated mex/power workers and fighter-screen-triggered first T2.

`AirRules::MakeTask` is a total dispatcher for a valid owned builder while
`Air.ExperimentalBuild` is enabled. A successful action ends evaluation;
otherwise the next action is tried. Every construction action rechecks current
capability, queue and reservation state. Economy observations are cached once
per second; existing construction stays assigned.

D-172 excludes both T1 and T2 aircraft constructors from the final `production.assist`
fallback. They finish/assist real construction or wait three seconds for the
next economic decision. Existing factory guards are individually removed by
`AirBuild::ReturnEconomyWorkers`. After the bomber milestone, `AirGrowth` may
invest overflowing metal in one AFUS after deducting commitments and leaving
the configured production share of projected income available. TECH's chooser
and ordered rules are unchanged. See [design](../air-economy-zone-plan.md).

D-156 removes `service.queued`: shared defense/radar jobs must not take AIR
constructors to allied resource clusters. `AirDefence` admits bounded own-base
flak, long-range AA and an anti-nuke; AIR has no wall planner. Other roles keep
the [wall base exclusion](../wall-base-exclusion.md).

| Order | Rule | Purpose |
| --- | --- | --- |
| 1 | current construction | Finish committed work before choosing another project |
| 1a | `opening.commander.guard`, `commander.energy.assist`, `commander.energy.local`, `commander.local.assist`, `commander.factory.guard`, `commander.idle.assist`, `commander.idle.energy`, `commander.idle.wait` | Finish/guard production through three completed T1 constructors; local recovery may prevent a stall; after the crew, an idle plant releases the commander to nearby economy work |
| 2 | `recovery.resume`, `recovery.energy`, `recovery.assist` | Recover an energy order, add quickly payable local supply, then assist useful energy work during a sustained stall |
| 2a | `project.resume` | Reassign an owned orphan order before adding another project |
| 3 | `opening.mex`, `opening.energy` | Three nearby mexes and initial energy before the starter |
| 4 | `transport.plant`, `opening.plant` | Recover or build the T1 air plant, retaining transport capability |
| 4a | `production.banked` | Bank-funded T2 admission; between the growth milestone and two AFUS, allow the first T2 lab only; existing support gate always applies |
| 5 | `mex.upgrade`, `mex.assist` | Upgrade all owned basic mexes, at most one remote upgrade at a time; additional helpers stay local |
| 5a | `transition.storage` | One queued/unfinished metal store at a time when a nearly full pre-T2 bank cannot hold the advanced lab cost |
| 5.0 | `energy.reclaim` | Retire wind, then basic and advanced solar using TECH's shared margin and completed-reactor guard; completed AFUS admits retirement outside recovery |
| 5.05 | `transition.bay`, `transition.finish`, `transition.save` | Attempt first eligible T2 access before discretionary growth; finish existing work while saving its capital on an energy-ready economy |
| 5.1 | `overflow.support`, `overflow.support.assist` | While metal floats, open up to three funded turret projects, then help finish them before converters or optional capital work |
| 5.2 | `mex.phase.convert`, `economy.shared.*` | Pending-upgrade T1 conversion, then shared TECH economy choices with AIR state, placement and reactor assistance after sustained +50 metal |
| 5a | `fusion.first` | Target fusion by 20 minutes; no reactor until all mexes finish |
| 5b | `support.assist`, `production.support` | Finish a support turret or grow funded support before general preparation assistance |
| 5c | `defence.base`, `fusion.access` | Bounded own-base protection and T2 access |
| 5d | `mex.expand` | Expand only within 1,400 elmos of start; before first reactor, at most six mexes and no expansion after preparation starts |
| 6 | `storage.buffer` | Fund the first wind buffer without starvation |
| 7 | `energy.grow`, `energy.assist` | Open funded parallel energy work, then help frames that need more power |
| 8 | `intel.radar` | One local radar |
| 9 | `storage.metal` | Save income needed for a funded T2 package |
| 10 | `production.bay` | Fund first T2 or one additional independent bay |
| 11 | `storage.energy`, `surplus.convert` | Buffer fluctuations; convert only surplus with metal capacity |
| 13 | `project.assist`, `production.assist`, `wait` | Useful nearby work, short working-factory guard for eligible ground workers, or bounded retry; both aircraft tiers keep their economy role |

The factory recruiter separately prioritizes allied transport obligations, then
one initial scout, three completed constructors, an immediate fighter screen,
funded income/bank-scaled economic builders (at most two consecutive
constructor orders before a fighter). During an incursion, two combat orders
may precede a funded missing worker; this prevents indefinite starvation.
Then come the interception floor, finite T1 strikes, land-threat-gated gunships and escorted
waves. T1 land support remains available after T2; a live incursion suspends
optional T2 strike/heavy recruitment.
Task priority controls engine resource priority; admission gates and available
build power also limit competing spending.
First-fusion preparation retains funded aircraft after the defensive floor
and constructor quotas. Transports remain first. The 20-minute target cannot
override any pending owned mex upgrade, including distant or gifted mexes.
The initial scout is latched on completion, so its loss cannot restart the
opening. Legion uses its first Noctua as that scout. Completed constructor
counts control the commander; frames and pending recruits only suppress duplicate orders.

The D-171 sequence retires the temporary T1 lab for funded T2 access and later
rebuilds utility production in the planned campus. It uses AIR's separate
reactor district and shares economy decisions without a TECH rush chain.
Turning the feature off returns AIR to its existing legacy dispatcher.

See [building actions](air_build.md), [AIR integration](air.md),
[implementation/evidence](../air-management.md).

<!-- source: data/script/src/roles/air_rules.as; blob: 3b507b060bbe9180f74d4dc2bb70048e94560677; lines: 172 -->

## D-152 sequencing

`mex.phase.convert` follows mex upgrade and assist, before optional growth.
Advanced conversion only follows completed mex upgrades. D-153 supersedes the T2 plant mex gate: all plant paths use the sustained
income/full-bank test. `production.banked` runs just after the starter plant,
before mex upgrades. Reactors still require completed mex upgrades. Existing recovery and opening
crew/scout/fighter/transport ordering remains.

D-155 applies the completed twenty-turret requirement to every expansion path,
including `production.banked`. The first T2 lab retains its income/full-bank
test. Overflow support follows mex work and precedes converters and fusion;
energy recovery stays first. See [plan and evidence](../air-support-before-expansion.md).

D-153 recruitment removes the blanket fusion-preparation wait. After transports,
the opening crew and the home screen, constructor growth and a bounded strike
mix continue: one strike per two fallback fighters, with income-scaled bombers
and Cortex Shurikens; other factions retain their small gunship opener. T1
production remains useful below 50 metal/s even if a bank-funded T2 plant exists.

D-156 keeps finite T1 support available above that income too. Optional strikes
require available completed fighters worth at least 1.25 times known enemy air
and no friendly-territory incursion. This replaces the fixed enemy-air cutoff
that suppressed Shurikens even with a superior friendly force. Funded economic
constructors are interleaved with fighters before optional strike spending.

## D-163 shared growth phase

`economy.shared.*` calls `AirGrowth::MakeTask` after mex work and T1 conversion, before the first-fusion and general support rows. Sustained ten-second minimum income of 50 metal activates the shared TECH economy chooser, with AIR placement and state. D-171 replaces the former two-AFUS readiness test for additional labs with sustained bomber-workload income readiness (`MassBombers`); the first lab and twenty-turret support remain eligible. Two AFUS are still a growth objective, not the production prerequisite. `energy.grow` is the pre-transition fallback. TECH rule ordering is unchanged. See [design](../air-campus-strike-design.md) and [D-171](../air-committed-operations-plan.md).

# AIR building actions

`Record` audits the pre-T2 `transition.storage` exception with INV-118: the
nearly full bank must still lack capacity for the loaded advanced lab cost.

D-171 adds `NearbyStarter` for a commander with no lab and no other completed
mobile constructor. It pins a physically valid nearby lab before speculative
campus planning. `StarterReadyToRetire` requires the opening crew, fighter wall,
advanced-lab affordability and a reserved advanced site; ferry requests take
precedence. `RetireStarter` retires one idle starter and owns its reclaim task.
`Factory` later rebuilds T1 on a planned campus bay after T2 access is secured.
Adopted starter/gifted bays never substitute for future campus reservations.
TECH's lab lifecycle is unchanged. See [D-171](../air-committed-operations-plan.md).

D-170 permits a metal-mode T2 order after the initial fighter screen without
the normal income/bank gate. Existing per-lab support requirements still govern
additional labs. `Pinned` logs failed metal-only placement attempts at a
bounded frequency for the field-economy simulations.

`AirBuild` is the action layer for [AIR's ordered rules](air_rules.md), enabled
by `Air.ExperimentalBuild`. It does not call TECH's building controller.

`Can` checks capabilities, availability and unit caps. `Busy` combines native
unfinished frames with orders that have no frame; completed units are counted
once by `AirEconomy::Planned`. `Record` owns the task handle, traces the rule
for each worker, and `Removed` drops ownership on completion or cancellation.
`Committed` budgets remaining construction cost, excluding repair/guard/wait.
`Resume` reacquires an owned pinned order after its builder dies or changes
task, checking native assignment and reachability before creating more work.
`Added` observes construction orders; `Tick` cancels unclaimed native completion
chain orders after script enqueue has returned. This prevents a native nano
order outside the layout from blocking the role's pinned support job (INV-076).

`EconomyAircraft` identifies economic workers by aircraft constructor
type and tier. `ReturnEconomyWorkers`, called by `Tick`, removes an advanced
aircraft constructor from a builder GUARD using individual `AssignTask` and a
one-second wait. Other assignees, player tasks and ferry tasks retain their
owners. `Record` audits new fallback production guards for these workers
(INV-106). Genuine unfinished construction assistance remains useful work.
See [the economic district design](../air-economy-zone-plan.md).

`ReactorPending` reads only owned ENERGY projects with a reactor definition and
no target or an unfinished target, excluding dead tasks. `Tick` prunes dead
project handles. `AirGrowth` uses it for serialization so a
leftover T1 wind/solar order cannot block all advanced economy. `AirLayout::Place`
checks the same predicate before admitting any reactor; `Record` audits INV-108.

D-167 delegates low-tier energy retirement to `AirReclaim`, using TECH's shared
income-minus-retiring-output comparison. It requires a completed reactor,
reclaims wind first with bounded concurrency, and releases retired wind pins.
`Tick` reconciles these jobs; `Leave` drops their handles. Once AFUS stands,
all AIR placement callers reject new wind, basic solar and advanced solar.
See [cluster and reclaim results](../air-cluster-reclaim-results.md).

`Factory` reserves one funded site, reuses a free surviving factory slot after
loss, and keeps the T1 transport plant. `Energy` chooses affordable wind, solar,
advanced solar, tidal or capable-builder fusion/AFUS. The first reactor is
ordinary fusion; AFUS needs an observed completed reactor as well as its income
and bank gates. An unfinished frame supplies no reactor income. Expensive reactors use a
separate rear search region for ordinary fusion; AFUS and advanced converters
use the persistent `AirEcoLayout` modules reserved during the opening. `Nano` fills actual free bank slots using live
assistant counts and the funded throughput target; T1 constructors remain
necessary because T2 air constructors do not build ordinary T1 nanos.
`Utility` provides queued-aware storage and radar. `AirDefence` owns flak, long-range AA and anti-nukes.
`Assist` repairs the nearest unfinished reachable local project within 1,800 elmos and respects retirement. `Leave` aborts the
owned tasks, releases military holds and removes AIR reservations before native
role settings are restored.

`FindAssistTarget` is shared by mobile assistance and idle production turrets.
`AssignedPower` sums completed workers whose current builder/repair task targets
that frame, excluding the asking worker. Small projects stop admitting helpers
when assigned work can finish the remaining frame in twelve seconds; reactors
use 120 seconds. `Energy` may open six funded energy projects instead of one
frame per definition. Recovery starts small local energy work before helping
an existing frame. An owned remote mex can still be upgraded, with one remote
upgrade order at a time; `AssistMex` keeps the rest of the crew home.

`Added`/`Tick` also reconcile defense and radar orders. Experimental AIR never
accepts native distributed defense/radar service queues. `Record` checks the
home-defense radius, local new-mex radius and loaded anti-nuke core coverage
(INV-091/092/094). See [D-156 design and evidence](../air-local-economy-plan.md).
It supports an optional definition filter (finish a nano) and an actual-reach
filter for immobile turrets, plus an optional search radius. `Assist` wraps it in the mobile repair task. Wind
placement gives commanders existing local slots, then a new entire six-slot
cluster inside build reach with a 16-elmo snapping margin. Once a flying
constructor exists, normal commander work remains local. D-151 permits a
bounded economy move when the factory is idle after the three-constructor crew.
`NearestPlant` resolves live non-retiring factory IDs. `Commander` finishes
the factory and guards it until three T1 constructors complete, with nearby
energy recovery permitted during a stall. Thereafter it uses local energy,
local project assistance or useful factory guard. `PlantHasWork` recognizes
unfinished factories and live RECRUIT tasks, including their pre-frame delay.
An idle plant releases the commander to nearby project assistance or energy
construction, within `CommanderEconomyRadius` (900 elmos); the commander assists
the structure rather than chasing its air constructor. If nothing useful fits,
it waits one second instead of guarding an empty plant (INV-081). Aircraft
retain remote work. INV-079
forbids new commander mex orders after an air factory exists. Wind
orders use the six-slot clusters in `AirLayout`; `Record` checks INV-078 using
the planned position before the required pin is served, and its native slot ID
after assignment. Repair tasks carry the target's definition but do not create
wind orders or own placement slots, so this check applies to ENERGY tasks.

`UpgradeMex` chooses the nearest live owned basic extractor the builder can
reach, using extraction rates and per-spot upgrade claims, with no home-radius
limit. `AssistMex` gives nearby unfinished extractors assistance before new
capital work. `FirstFusion` uses the 20-minute goal and a funding forecast but
requires `AirEconomy::MexesReady`. `IsReactor` identifies the role's reactor
orders: `Energy`, `Resume` and `Tick` apply the same mex gate; `Tick` cancels
invalid unstarted orders and `Record` checks INV-077. Already framed reactors
continue when new mexes are acquired.

Native slots own claims, frames and completed structures. `AirLayout::Pinned`
rejects an absent, occupied or dead slot and aborts an enqueue if the exact pin
cannot be acquired. Ordinary economy patches also use required reservations.
AIR's flying-builder approach option lets the engine position airborne builders
for the last leg. Its default is false, preserving TECH's ground approach.

See [implementation and evidence](../air-management.md),
[design plan](../air-layout-and-priority-plan.md), and
[actor matrix](../actor-matrix.md).

<!-- source: data/script/src/roles/air_build.as; blob: 2811e9d0b427baab5d146e3dbce105381b8d0b47; lines: 619 -->

## D-153: income-gated plants and mex-first reactors

`RequiresMexes` covers reactors. `Factory` requires a full ten-second window
with minimum income at least 50 metal/s or a bank covering the full plant cost.
A fully banked plant bypasses spare-capacity waits. D-155 requires twenty
completed, uniquely assigned turrets on every existing T2 lab before any
additional T2 lab, including bank-funded expansion. `AirEconomy::Transition` owns
that shared admission rule; `Record` checks INV-083 against the fresh inputs.
An admitted plant is not canceled because income falls or another mex arrives.
`AirLayout::Activate` validates every unused bay member before the first order,
relocating a blocked plan and preserving claimed or previously started bays.

`Convert` scales T1 conversion with surplus energy until owned mex upgrades
finish, permitting three concurrent orders. `Tick`, `Resume`, and `Record`
retain the reactor mex gate (INV-077).

## D-155: completed support before expansion

`Factory`, `Resume`, and `Tick` use `AirEconomy::ExistingT2SupportReady` to
recheck gifts, deaths and completion; invalid unstarted orders are cancelled,
while already framed labs finish. `Record` checks INV-090. New T2 reservations
require the complete twenty-slot support bank.

`SupportCommitted` counts completed turrets, frames and unstarted owned orders
once per bay. `Nano` permits up to `NanoParallel` (three) funded projects during
metal overflow, otherwise one, with native reach checks and high task priority.
Only completed turrets satisfy expansion. See [plan and evidence](../air-support-before-expansion.md).

D-162 removes `FirstFusion`'s additional 500-metal bank veto. Completed owned
mex upgrades, recovery state and conservative 180-second metal/energy funding
including committed projects still gate admission. Continuous factory spending
must not indefinitely block a funded first reactor. See [the review](../air-enhancement-review.md).

## D-163 campus and reactor-era updates

`Factory` has no default policy ceiling (`MaxProductionBays=0`); an explicitly positive setting remains a cap. Every expansion still requires twenty completed support turrets per existing T2 plant. Before the shared growth phase, `Energy` retains the original reactor ladder. After sustained +50 metal, `AirGrowth` selects reactors through the shared chooser, so a funded advanced fusion may be the first reactor. T1 workers stop ordinary small-energy fallback once reactor income exists; emergency recovery stays available. See [design](../air-campus-strike-design.md).

`Nano` repairs dead support pins within the started lab's reach. `PlantHasWork`
requires an unfinished aircraft frame after the opening crew; a queued recruit
task alone cannot keep the commander on an idle lab. T1 mobile fallback guards
start an explicit five-second expiry and `Tick` checks their task-identity leases
(INV-104). D-164 excludes advanced aircraft from this fallback entirely;
expiration alone did not prevent them repeatedly renewing the same activity.

D-171 records commander factory-guard intent in `commanderFactoryGuards`.
`Record` clears that engine command once before a different AIR action waits
for a path. `ReturnEconomyWorkers` also stops the released T2 constructor's old
guard. Native task expiry alone leaves these engine queues intact. The Legion
45-minute repeat passed INV-081 after this handoff change.

`CancelUnstarted` stops only a cancelled task's current assignees before
aborting it. `Tick` uses it for a newly invalid reactor/mex prerequisite,
insufficient support for another T2 lab and unclaimed native building orders.
It preserves already framed buildings and workers now owned by another task.

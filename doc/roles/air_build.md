# AIR building actions

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

`Factory` reserves one funded site, reuses a free surviving factory slot after
loss, and keeps the T1 transport plant. `Energy` chooses affordable wind, solar,
advanced solar, tidal or capable-builder fusion/AFUS. The first reactor is
ordinary fusion; AFUS needs an observed completed reactor as well as its income
and bank gates. An unfinished frame supplies no reactor income. Expensive reactors use a
separate rear search region. `Nano` fills actual free bank slots using live
assistant counts and the funded throughput target; T1 constructors remain
necessary because T2 air constructors do not build ordinary T1 nanos.
`Utility` provides queued-aware storage, radar and flak. `Assist` repairs an
existing project within 1,800 elmos and respects retirement. `Leave` aborts the
owned tasks, releases military holds and removes AIR reservations before native
role settings are restored.

`FindAssistTarget` is shared by mobile assistance and idle production turrets.
It supports an optional definition filter (finish a nano) and an actual-reach
filter for immobile turrets. `Assist` wraps it in the mobile repair task. Wind
placement gives commanders existing local slots, then a new entire six-slot
cluster inside build reach with a 16-elmo snapping margin. Once a flying
constructor exists, the commander cannot fall back to distant wind placement.
`NearestPlant` resolves live non-retiring factory IDs. `Commander` finishes
the factory and guards it until three T1 constructors complete, with nearby
energy recovery permitted during a stall. Thereafter it uses local energy,
local project assistance or factory guard; aircraft own remote work. INV-079
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

<!-- source: data/script/src/roles/air_build.as; blob: 7622c70e61c5120ed2c493fe353f045b1df72103; lines: 326 -->

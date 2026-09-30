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

Native slots own claims, frames and completed structures. `AirLayout::Pinned`
rejects an absent, occupied or dead slot and aborts an enqueue if the exact pin
cannot be acquired. Ordinary economy patches also use required reservations.
AIR's flying-builder approach option lets the engine position airborne builders
for the last leg. Its default is false, preserving TECH's ground approach.

See [implementation and evidence](../air-management.md),
[design plan](../air-layout-and-priority-plan.md), and
[actor matrix](../actor-matrix.md).

<!-- source: data/script/src/roles/air_build.as; blob: e6616b7bcf60b1995e46cb362464790c9c1b7532; lines: 196 -->

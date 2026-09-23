# Transport ferry

How a donated T2 constructor gets flown to its recipient instead of walking,
and how AIR and TECH arrange it between them.

## Contents

- [Why](#why)
- [The sequence](#the-sequence)
- [The protocol](#the-protocol)
- [Message scope](#message-scope)
- [The native side](#the-native-side)
- [Seven traps that broke the first versions](#seven-traps-that-broke-the-first-versions)
- [Failure paths](#failure-paths)
- [Configuration](#configuration)
- [Known limits](#known-limits)
- [Related](#related)

## Why

`Team::Donation` hands a finished T2 constructor to an ally with
`ai.GiveUnits`, and the unit then **walks** to its new owner across whatever
lies between. That is 410-470 metal of unescorted builder crossing a contested
map, and it was the slowest part of the whole TECH-to-ally tech transfer.

Two things blocked flying it, both now fixed:

1. **A transport was sent to fight.** The role-task map in
   `CMilitaryManager::DefaultMakeTask` had no entry for `ROLE_TYPE(TRANS)`, so
   a transport fell through to the `else` branch and was given a
   Defend/ATTACK task. It joined the army and died there.
2. **Nothing could fly cargo.** `CCircuitUnit` wrapped no cargo commands, even
   though the C++ wrapper has had `LoadUnits`, `LoadUnitsInArea`, `Unload` and
   `UnloadUnitsInArea` all along. The "not implemented: transport" note at
   `CircuitDef.h:47` was about this gap.

## The sequence

In the order the units actually move:

| # | Who | What |
| --- | --- | --- |
| 1 | any | A teammate calls `Ferry::RequestTransport` -> broadcast `req`. TECH does so on its own at `RequestMinMetalIncome` while owning no transport, and again after `RequestCooldownSeconds` if that is still true |
| 2 | AIR | Takes the request; the next air-plant task is a transport, ahead of everything else |
| 3 | AIR | Transport finishes -> **AIR flies it to TECH's base itself**, still owning it |
| 4 | AIR | On arrival -> `ai.GiveUnits` to TECH, send `give` |
| 5 | TECH | Receives it -> `CFerryTask` holds it at TECH's base; it is never an army unit |
| 6 | TECH | A teammate's constructor request is fulfilled (`Team::Donation`, [D-041](decisions.md#d-041--tech-donates-t2-bots-by-plan-and-t2-constructors-only-on-request)) -> `SetCargo(unit, recipient base)`: pick up, fly, drop |
| 7 | TECH | Drop lands -> TECH gives the constructor to the recipient; the transport flies home |

Step 3 is the part worth being deliberate about. Handing the transport over at
*AIR's* base would leave TECH owning a unit on the far side of the map with no
task that knows where to send it. AIR keeps ownership for the flight and
transfers only once the unit is where TECH wants it, so the hand-over is also
the arrival.

**The request is decoupled from the T2 lab.** The first version fired on the
lab task being *enqueued* — `Builder::AiTaskAdded` — which is when TECH plans
the lab, well before any builder touches it, so the transport arrived far too
early. Now any role may call `RequestTransport()`, and TECH does so itself
once its sliding-minimum metal income clears `RequestMinMetalIncome` (20)
while it owns no transport. The cooldown covers the two ways that stays true:
the transport died, or AIR was already serving someone and dropped the request.

AIR serves one request at a time and **drops** any that arrive while it is
busy — it does not queue them. The requester's cooldown re-sends, by which
time the current delivery is done. Dropping is simpler than a queue and loses
nothing but a few minutes.

## The protocol

Three messages over `AiSendMessage`, the channel the roster already uses:

```
barbferry|req|<x>|<z>     requester -> all, wants a transport
barbferry|ack             AIR  -> TECH, "I am building one for you"
barbferry|give|<unitId>   AIR  -> TECH, "it is over your base and yours"
```

**Not `ai.CallUI`.** That is the AI-to-LuaUI channel: one way, local to the
machine hosting the AI, and it never reaches another AI. It is used here only
to mirror ferry events to the debug widget under the `ferry` topic. Anything
that has to reach another AI goes over `AiSendMessage`, which
`CInitScript::SendMessage` already confines to one ally team.

## Message scope

`AiSendMessage` is not a Lua or engine broadcast. `CInitScript::SendMessage`
walks the in-process list of BARb instances and calls `ReceiveMessage` on
each one directly, and **both** of its branches require
`ai->GetAllyTeamId() == circuit->GetAllyTeamId()` - the broadcast form
(`toTeamId < 0`) delivers to every *allied* instance, the targeted form to
one allied team only. An enemy AI, a human, or a non-BARb AI never receives
it, because none of them is in that list or on that ally team.

The script re-checks. `Team::HandleMessage` drops and logs any message whose
`fromTeamId` is not in `ai.GetTeamIds()` before Roster, Ferry, SeaAssist or
Orphan see it, so the native filter and the script filter both have to fail
for a foreign message to reach a handler.

Within the ally team every instance receives a broadcast, and each handler
gates on its own **AiRole**: `req` acts only on `AiRole::AIR`, `ack`/`give`
only matter to the requester, `barbnavy|ctor` only to the team it was sent
to. So "a player requests a unit and only its own team handles it" is true by
construction - and on the same team, only the role that can fill it responds.

`ai.CallUI` is the other channel and is unrelated: one-way, to the LuaUI of
the machine hosting the AI, for the debug widget. It cannot carry
coordination and is not used for any.

`req` carries the requester's base position so AIR does not have to have
received its roster line yet; when the roster does have the sender, its entry wins,
because the message may predate a start-position correction.

## The native side

**`CFerryTask`** (`src/circuit/task/fighter/FerryTask.h/.cpp`), reached as
`FightType::FERRY`. One transport per task, for the transport's whole life.

```
IDLE -> TO_CARGO -> LOADING -> TO_DROP -> UNLOADING -> DONE
                 \-----------------------------------> FAILED
```

`IDLE` is a hold at `holdPos`, which is what keeps a transport out of the army
now that `ROLE_TYPE(TRANS)` maps here. `DONE` and `FAILED` are latched: script
polls `GetState()`, acts once, and calls `Reset()`.

Script surface: `SetHoldPos(pos)`, `SetCargo(unitId, dropPos)`, `GetState()`,
`GetCargoId()`, `Reset()`. Cargo is addressed **by unit id, not handle** —
the script side holds it across frames and `CFerryTask` resolves it through
`CCircuitAI::GetTeamUnit`.

**D-091 supersedes the queued flight below.** The load is ordered alone, only
for a finished cargo off its factory's yard; the flight to the drop is ordered
when the cargo is seen lifted, and a cargo back on the ground in flight is
loaded again. Landing spots come from `CTerrainManager::FindDropSpot` (free of
structures, reachable by the cargo's move type, dry for a land unit, never a
spot the engine refused). See
[D-091](decisions.md#d-091--the-ferry-loads-only-a-finished-unit-off-its-factory-yard-flies-only-once-the-cargo-is-aboard-and-lands-only-where-the-cargo-can-stand).

**Load verification is by height, and the flight does not wait for it.**
The C++ wrapper exposes no `GetTransporter`, so the task infers the load from
the cargo being **lifted off the terrain** at all - `FERRY_LIFT_HEIGHT` is
4 elmos (`IsLifted`) - with 2D proximity to the transport as a secondary
check; the flight to the drop is **queued behind the load order**
(`CmdMoveTo` with the shift option), so the transport leaves the moment the
engine finishes loading whatever the task has detected. The unload is "on
the ground exactly (`FERRY_GROUND_TOLERANCE` 1 elmo) for two updates
running" (`landedTicks`). It was originally 2D proximity alone, which cannot
separate "carried" from "stood under the hovering transport" (trap 5), and
then a 24-elmo lift bar an Atlas never cleared (trap 8).

**Every state has a deadline** — 90 s travel, 20 s load, 20 s unload, with two
load retries. Transports in Spring fail to load for reasons the AI cannot
observe (capacity, mass, the cargo walking off mid-approach), and a hung
transport is strictly worse than the walk this replaces.

**Cargo commands** on `CCircuitUnit`: `CmdLoadUnits`, `CmdLoadUnitsInArea`,
`CmdUnloadUnit`, `CmdUnloadUnitsInArea`, each a thin wrapper in the shape of
the existing `Cmd*` methods.

## Seven traps that broke the first versions

The first three showed up in one game: the transport flew at the enemy front
instead of being donated, and AIR went on building transports forever. The
fourth showed up in the next: the transport was built, once, and then sat
idle over AIR's base. The fifth in the one after: the transport reached the
cargo, started the pickup, and left without it - and logged a clean delivery.
The sixth: with the ferry finally working, AIR built a *second* transport that
nobody asked for, and it idled over the advanced air plant. The seventh: the
transport was delivered to TECH every time, and TECH never flew a single
constructor with it.

**1. A flying unit's main role is always AIR.** `CFactoryManager`'s constructor
runs `if (cdef.IsAbleToFly()) setRoles(ROLE_TYPE(AIR))`, which overwrites the
main role of every aircraft *after* the config has been read. So the
`{ROLE_TYPE(TRANS), FERRY}` entry in `DefaultMakeTask`'s role-task map — which
is keyed on **main role** — could never match an air transport. The map entry
is gone; the check is now `cdef->IsRoleTrans()` on the role **mask**, tested
before the support branch and the map. The mask keeps `TRANS` because the
config's `AddRole` put it there; only the main role is clobbered.

**2. The transports were not tagged at all.** `armhvytrans`, `armatlas`,
`corhvytrans` and `corvalk` had no entry in `behaviour.json`, and
`legatrans`/`leglts` were tagged `["support", "air"]`. Untagged meant no
`TRANS` in the mask and a fall-through to `Defend/ATTACK` — flown at the
enemy. `support` was worse: it routed the Legion transports into
`CSupportTask`, which walks a unit to the nearest squad and joins it. All six
are now `["transport", "air"]`.

Because a missing tag is what broke it, `Ferry::IsFerryTransport` accepts the
unit either by the `TRANS` role mask **or** by matching
`Global::Ferry::TransportBySide`, so the script setting alone is enough to
identify the ferry.

**3. The order latch was missing.** `FactoryMakeTask` only checked
`buildingId >= 0`, which is set when the unit *exists*. The factory asks for a
task every time it idles, so every poll between the order and the unit popping
queued another transport. `orderedFrame` now latches the order; it clears when
the unit appears, when the transport dies in transit, or after
`OrderTimeoutSeconds` if the order produced nothing.

**4. The hold was set at a moment the task did not exist yet.** `OnUnitAdded`
did `TaskOf(unit).SetHoldPos(...)` once. But natively,
`CMilitaryManager`'s `attackerFinishedHandler` puts a new unit on the
**idle** task and *then* raises `UnitAdded`; the `CFerryTask` is only
assigned afterwards, by `UpdateIdle -> MakeTask`. So at that moment
`TaskOf()` was null, the call was silently skipped, and the log still printed
"flying to" because it did not check. With an invalid hold `CFerryTask::Start`
does nothing, nothing retried, and the transport idled at AIR's base for the
rest of the game.

The hold is now applied from `Update()`, retried every tick until the task
exists (`_ApplyHold`), on both sides — AIR's flight to the requester and the
requester's hold at home. The "flying to" line is only logged once the hold
has actually been applied, and the `give` message also records the unit id on
the receiving side in case a gifted unit arrives through a different native
handler than a built one.

**5. "Loaded" was a 2D distance, and so was "unloaded".** `LOADING` advanced
to `TO_DROP` when the cargo was within 32 elmos of the transport in the
horizontal plane. The transport issues the load while hovering **directly
over** the cargo, so on the very next tick that distance was ~0, the check
passed vacuously, and `GoTo(dropPos)` was issued with options `0` - which
replaces the command queue and **cancels the load**. The transport flew off
empty. Then `UNLOADING` declared "landed" when the cargo was *not* within 32
elmos of the transport - and a cargo that was never picked up is also not at
the transport - so the run reported `delivered`, and `GiveUnits` handed the
constructor to the recipient while it still stood at TECH's base.

The log for that run had no `load retry` and no `run failed`; it looked like
a success. Both tests are now on the cargo's **height above terrain**
(`IsLifted`): loaded means lifted, landed means back on the ground. Height is
the one observable that separates "carried" from "stood under the transport".

**8. An Atlas hovers low with its load.** Played (D-056): team 9's Valkyrie
delivered every run; team 10's Atlas picked its cargo up and sat there -
`load retry 1`, `load retry 2`, `run failed (load did not take)` - and the
fallback gave the constructor to the recipient **while it hung under the
transport**, which the engine does not detach on a team change. The 24-elmo
lift bar was the cause: the Atlas holds its load a few elmos up until it is
told to move, and the move was only sent once the bar was cleared. Now any
lift counts, and the flight to the drop is queued behind the load order so
the transport leaves on the engine's say-so, not the task's. The landed test
went the other way - exactly on the ground for two updates - so a give can
never come one update early.

**6. A role entry makes a transport ordinary air production.** Trap 2's fix
gave the six transport defs a `["transport", "air"]` entry in
`behaviour.json`. That entry is also what the **native recruiter** reads when
it fills an air plant's queue, so a transport became a legitimate air unit to
build whenever the air roster wanted one - and, having a `CFerryTask` and no
hold, it idled where it popped. The ferry's own transports were fine; the log
showed two clean runs and then an unlogged extra.

Every transport def is now capped at 0 for every role from the first tick
(`Global::Ferry::AllTransportDefs`, `_CapAll`). AIR raises the def it owes to
owned+1 for exactly as long as a request is open (`_OpenSlot` before the
Recruit, `_CloseSlot` after the transfer), so the ferry's explicit Recruit is
the only order that can ever produce one. `FactoryMakeTask` no longer tests
`IsAvailable()` - the cap is 0 at that moment by design.

**7. TECH's military policy starved the transport of a task.** The log showed
`received and reserved; hold pending task` at f~4400 and `flying to` - the
hold finally applied - at f~13600, with every donation in between taking the
walk path. `_ApplyHold` and `TryCarry` both refuse a transport whose
`CFerryTask` does not exist yet, and it did not exist because
`Tech_MilitaryAiMakeTask` ends with `if (metalIncome < 50) return null;` for
**every** military unit - correct for TECH's army, which it does not want
roaming early, and fatal for a transport requested at +20. `UpdateIdle` asked
every interval and got null every time until TECH's income crossed 50.

`Military::AiMakeTask` now hands any ferry transport straight to
`aiMilitaryMgr.DefaultMakeTask` before Spam or any role handler sees it. A
transport is never spam and never army; the only task that carries is the
native one, and no role policy should be able to withhold it.

## Failure paths

All of them end in the old behaviour — give the constructor and let it walk:

| Failure | Result |
| --- | --- |
| No transport yet | `TryCarry` returns false; immediate `GiveUnits` |
| One already in the air | **Queued** (`queuedCargo`), started by `_Finish` when the run ends; D-044 |
| Transport dies before a run | Same as no transport; the queue walks (`_WalkQueue`) |
| Transport dies mid-run | `Update` sees a null task, gives the cargo where it stands |
| Cargo dies | Run fails; nothing to give |
| Load never takes | Two retries, then `FAILED`; cargo given where it stands. A cargo that *is* lifted (any height) goes through `DUMPING` first, so it is never given while hanging |
| Drop occupied | The unload is ordered at the nearest clear footprint (`FindLandingSpot`); two widening retries; then the cargo is **set down where the transport is** (`DUMPING`) before `FAILED` |
| AIR never builds one | TECH simply never gets a ferry |

Played finding (D-044): the drop was the recipient's start position, which
is its base. The engine refuses an unload onto occupied ground and says
nothing, so the transport hovered for the 20 s deadline, the run failed,
and the fallback gave the constructor away **while it still hung under the
transport** - the "transferred without delivery" report. Two runs in that
game delivered and two failed that way; two more failed to load because
the constructor had taken a build order and walked off. `SetCargo` now parks
the cargo in a builder `Wait` and stops it.

The donation accounting (`given`, `givenTo`) runs exactly once on every path,
so a ferried donation consumes the same slot a walked one would.

**Every refusal is logged at level 1.** `define.as` sets `LOG_LEVEL = 1`, so
a level-2 line never reaches `infolog.txt`; a `TryCarry` that returned false
silently was indistinguishable from a pickup, and it cost a whole game of not
knowing whether the transport had ever been asked. `TryCarry` now prints
`not carrying - <reason>; constructor walks`, `_Finish` prints why a run did
not complete, and `Team::Donation` prints one line per T2 constructor
(`T2 constructor #N: <def>(id) planned=P given=G keep=K`) plus its decision.
If those lines are absent, the hook did not run - and that is itself the
finding.

## Configuration

`Global::Ferry` (`data/script/src/global.as`):

| Setting | Default | Meaning |
| --- | --- | --- |
| `Enabled` | `true` | Off restores the walk everywhere |
| `TransportBySide` | `armatlas` / `corvalk` / `leglts` | Which transport AIR builds |
| `AllTransportDefs` | all six | Capped at 0 for every role; AIR opens one slot while it owes a transport |
| `RequestMinMetalIncome` | 20 | TECH asks on its own at this sliding-minimum metal income, if it owns no transport |
| `RequestCooldownSeconds` | 180 | A requester waits this long before asking again |
| `ArriveRadius` | 320 | How close to the requester's base before ownership transfers |
| `OrderTimeoutSeconds` | 120 | Safety net: re-order if one order produces nothing |

The **light** transports are the default. They carry `transportsize` <= 3
and mass <= 750; a T2 constructor is 2x2 and weighs 410-470, because Recoil
defaults a unit's mass to its metal cost when the def sets none
(`rts/Sim/Units/UnitDef.cpp`: `GetFloat("mass", cost.metal)`). The first
version used the heavy transports (`armhvytrans` / `corhvytrans` /
`legatrans`, 190 metal) because that mass was not in the shared unit cache and
an unverified lift was not worth 120 metal; reading the engine settled it.
All six come from the **T1** air plant, so AIR can build one the moment it is
asked.

## Known limits

1. **Not verified in a game.** The native side compiles and the script
   type-checks against the registered API; no match has exercised it. The
   positional load check in particular wants a real load to confirm the
   tolerance.
2. **One transport, one run at a time.** A second constructor while a run is
   in flight waits in `queuedCargo` and flies next; it works normally until
   its turn.
3. **One request at a time per AIR.** A `req` that arrives while AIR is
   serving another is dropped, not queued; the requester re-asks after its
   cooldown. Two requesters therefore get served in the order their cooldowns
   happen to land, not in the order they first asked.
4. **The drop is aimed at the recipient's start position**; the landing is
   the nearest footprint the engine calls clear within 320 elmos of it (then
   640, 960 on retries). A base that has been overrun gets a drop into
   whatever is there now.
5. **No escort.** The transport flies alone. On a map with live enemy air this
   is a 70-metal unit carrying a 430-metal one with no cover.
6. **The route is a straight line.** `CFerryTask::GoTo` is one `CmdMoveTo`;
   it does not consult the threat map. See below.

## Beyond donations: a forward-base ferry

The question "could a heavy transport get T3 near the front without entering
AA range" has a short answer and a useful one.

Short: **no transport can lift a T3 combat unit.** Every one of them - Titan,
Thor, Juggernaut, Behemoth, Razorback, Vanguard, Marauder, Shiva, Karganeth,
Sol Invictus, Apollyon and the rest - carries `cantbetransported = true`, and
several are 5x5 to 8x8 besides. That is a game-design decision and no
transport setting overrides it.

Useful: the things a transport *can* lift are **constructors**, including the
T3 ones (Butler, Twitcher; 2x2, mass 2 700 - heavy transport only). So the
strategy is not "fly the Titan", it is "fly the builder that makes the
gantry". A TECH player with a forward gantry spawns T3 at the front instead of
walking it across the map, and a forward T2 lab does the same one tier down.

What that needs from the ferry, none of which exists yet:

- **A threat-aware route.** `CSupportTask` already does this for ground units
  with `CPathFinder::CreatePathMultiQuery(unit, threatMap, ...)`; the air
  threat layer is the same map. A `CFerryTask` that asked the pathfinder for a
  path around air threat and issued its waypoints, rather than one straight
  `CmdMoveTo`, would keep the transport out of AA range where a route exists
  and report `FAILED` where none does.
- **A drop site chosen by script**, not the recipient's start position: a
  point behind the front with room for a gantry, from the same influence and
  threat maps the porc chain uses.
- **The heavy transport for that job**, since a T3 constructor exceeds the
  light one's mass cap. `TransportBySide` is per-side, not per-cargo; it
  would need to become per-request.

This is a design note, not a plan. It is recorded here because the question
will come up again and the answer is "constructors, not combat units".

## Related

- [`known-issues.md`](known-issues.md) - KI-216, the original analysis.
- [`roles/tech.md`](roles/tech.md) - the donation policy the ferry serves.
- [`roles/air.md`](roles/air.md) - AIR's production, which the request preempts.
- [`intent.md`](intent.md#the-architectural-rule) - why the sequencing is
  native and the coordination is script.

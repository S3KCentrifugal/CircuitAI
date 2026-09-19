# Transport ferry

How a donated T2 constructor gets flown to its recipient instead of walking,
and how AIR and TECH arrange it between them.

## Contents

- [Why](#why)
- [The sequence](#the-sequence)
- [The protocol](#the-protocol)
- [The native side](#the-native-side)
- [Three traps that broke the first version](#three-traps-that-broke-the-first-version)
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
| 1 | TECH | Its **first** T2 lab is enqueued -> broadcast `req` |
| 2 | AIR | Takes the request; the next air-plant task is a transport, ahead of everything else |
| 3 | AIR | Transport finishes -> **AIR flies it to TECH's base itself**, still owning it |
| 4 | AIR | On arrival -> `ai.GiveUnits` to TECH, send `give` |
| 5 | TECH | Receives it -> `CFerryTask` holds it at TECH's base; it is never an army unit |
| 6 | TECH | Donates a constructor -> `SetCargo(unit, recipient base)`: pick up, fly, drop |
| 7 | TECH | Drop lands -> TECH gives the constructor to the recipient; the transport flies home |

Step 3 is the part worth being deliberate about. Handing the transport over at
*AIR's* base would leave TECH owning a unit on the far side of the map with no
task that knows where to send it. AIR keeps ownership for the flight and
transfers only once the unit is where TECH wants it, so the hand-over is also
the arrival.

The trigger is the lab being **enqueued**, not finished, so the transport is
flying while the lab is still building and is on station before the first T2
constructor exists.

## The protocol

Three messages over `AiSendMessage`, the channel the roster already uses:

```
barbferry|req|<x>|<z>     TECH -> all,  first T2 lab started
barbferry|ack             AIR  -> TECH, "I am building one for you"
barbferry|give|<unitId>   AIR  -> TECH, "it is over your base and yours"
```

**Not `ai.CallUI`.** That is the AI-to-LuaUI channel: one way, local to the
machine hosting the AI, and it never reaches another AI. It is used here only
to mirror ferry events to the debug widget under the `ferry` topic. Anything
that has to reach another AI goes over `AiSendMessage`, which
`CInitScript::SendMessage` already confines to one ally team.

`req` carries TECH's base position so AIR does not have to have received
TECH's roster line yet; when the roster does have the sender, its entry wins,
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

**Load verification is positional.** The C++ wrapper exposes no
`GetTransporter`, so the task infers the load from the cargo's position
tracking the transport's, within `FERRY_LOADED_DIST`. The unload is the same
test inverted.

**Every state has a deadline** — 90 s travel, 20 s load, 20 s unload, with two
load retries. Transports in Spring fail to load for reasons the AI cannot
observe (capacity, mass, the cargo walking off mid-approach), and a hung
transport is strictly worse than the walk this replaces.

**Cargo commands** on `CCircuitUnit`: `CmdLoadUnits`, `CmdLoadUnitsInArea`,
`CmdUnloadUnit`, `CmdUnloadUnitsInArea`, each a thin wrapper in the shape of
the existing `Cmd*` methods.

## Three traps that broke the first version

All three showed up in one game: the transport flew at the enemy front
instead of being donated, and AIR went on building transports forever.

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

## Failure paths

All of them end in the old behaviour — give the constructor and let it walk:

| Failure | Result |
| --- | --- |
| No transport yet, or one already in the air | `TryCarry` returns false; immediate `GiveUnits` |
| Transport dies before a run | Same |
| Transport dies mid-run | `Update` sees a null task, gives the cargo where it stands |
| Cargo dies | Run fails; nothing to give |
| Load or unload never takes | `FAILED` after the deadline; cargo given where it stands |
| AIR never builds one | TECH simply never gets a ferry |

The donation accounting (`given`, `givenTo`) runs exactly once on every path,
so a ferried donation consumes the same slot a walked one would.

## Configuration

`Global::Ferry` (`data/script/src/global.as`):

| Setting | Default | Meaning |
| --- | --- | --- |
| `Enabled` | `true` | Off restores the walk everywhere |
| `TransportBySide` | `armhvytrans` / `corhvytrans` / `legatrans` | Which transport AIR builds |
| `ArriveRadius` | 320 | How close to TECH's base before ownership transfers |
| `OrderTimeoutSeconds` | 120 | Safety net: re-order if one order produces nothing |

The **heavy** transports are the default deliberately: `transportsize` 4
against a T2 constructor's 2x2 footprint and no `transportmass` cap, so the
lift is certain. The light transports (`armatlas`, `corvalk`, `leglts`) are
cheaper and faster but carry a 750 mass cap that the shared unit cache does
not record a constructor's mass against, so the lift is unverified. All six
come from the **T1** air plant, so AIR can build one the moment it is asked.

## Known limits

1. **Not verified in a game.** The native side compiles and the script
   type-checks against the registered API; no match has exercised it. The
   positional load check in particular wants a real load to confirm the
   tolerance.
2. **One transport, one run at a time.** A second donation while a run is in
   flight walks. Sequential donations reuse the transport.
3. **One TECH per AIR.** The first `req` an AIR takes commits it; a second
   TECH on the same team is ignored, and its donations walk.
4. **The drop is the recipient's start position**, not a chosen safe spot near
   it. A recipient whose base has moved or been overrun gets a drop into
   whatever is there now.
5. **No escort.** The transport flies alone. On a map with live enemy air this
   is a 190-metal unit carrying a 430-metal one with no cover.

## Related

- [`known-issues.md`](known-issues.md) - KI-216, the original analysis.
- [`roles/tech.md`](roles/tech.md) - the donation policy the ferry serves.
- [`roles/air.md`](roles/air.md) - AIR's production, which the request preempts.
- [`intent.md`](intent.md#the-architectural-rule) - why the sequencing is
  native and the coordination is script.

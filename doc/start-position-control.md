# Start position control from the AI

Research (2026-09-20) into letting the Skirmish AI DLL choose where it
starts, with no engine or game change. Outcome: the engine path exists and
BARb already implements it, but BAR discards it for AI teams; BAR does
provide a sanctioned placement message that a player-side widget can send,
and this repo already ships that widget. Proposal at the end; nothing built.

Decision: [D-049](decisions.md#d-049--start-positions-are-brokered-through-the-host-widget-proposal).

## Contents

- [What the engine allows](#what-the-engine-allows)
- [What BAR does with it](#what-bar-does-with-it)
- [What BARb already has](#what-barb-already-has)
- [The channel that works](#the-channel-that-works)
- [Proposal](#proposal)
- [Limits](#limits)
- [Fallback without a widget](#fallback-without-a-widget)
- [Sources](#sources)

## What the engine allows

The Skirmish AI C interface has `Game_sendStartPosition(ready, pos)`
(`COMMAND_SEND_START_POS`, `AISCommands.h`), served by
`CAICallback::SendStartPos`, which sends `NETMSG_STARTPOS` from the AI's
**host player** for the AI's team. The server (`GameServer.cpp`,
`NETMSG_STARTPOS`) accepts it only when the game was set up with
`startpostype=2` (choose in game) and the sending player hosts a skirmish AI
on that team; it then stores the team's start position and broadcasts it.
`ready = false` sends `PLAYER_RDYSTATE_UPDATED`, which does **not** ready the
host player; `ready = true` would.

Every client then runs `CGame::ClientReadNet` (`NetCommands.cpp`): the
position is clamped into the start box and passed to the LuaRules callin
`AllowStartPosition(playerID, teamID, readyState, clamped, raw)`. Only if that
returns true is `CTeam::SetStartPos` applied. So the game decides.

AIs are created during `CGame::Load` (`LoadSkirmishAIs`, step 8 of the load),
before the placement phase and before `GameStart`, so an AI can act during
placement. There are no sim frames yet, so it cannot rely on `Update`; it
can act from `Init` and from events such as `EVENT_LUA_MESSAGE`.

## What BAR does with it

`luarules/gadgets/game_initial_spawn.lua`:

- `gadget:AllowStartPosition` **returns false for AI teams** (line ~478:
  `if select(4, spGetTeamInfo(teamID)) then return false end`). The AI's
  own `NETMSG_STARTPOS` therefore never reaches `SetStartPos` on any client.
  This is the one line that makes the engine path useless for AIs, and it
  is game code.
- At `GameStart`, every team without a genuine entry in `startPointTable`
  gets one from `GuessStartSpot` (`common/lib_startpoint_guesser.lua`):
  heuristics in the box, then the box middle. That is where AIs start
  today.
- **But** `gadget:RecvLuaMsg` accepts, from a non-spectator player,
  `aiPlacedPosition:<teamID>:<x>:<z>` (line ~376). It refuses a player on
  another ally team unless the modoption `allow_enemy_ai_spawn_placement`
  is set, validates only that the point is not within `tooCloseToSpawn` of
  another placed team, then calls `Spring.SetTeamStartPosition(teamID, x, y,
  z)`, records `startPointTable[teamID] = {x, z}` and, with the modoption,
  publishes `aiManualPlacement` as a team rules param. `x = z = 0` resets.
  `spawnRegularly` then spawns the AI's commander at that position. This is
  the path BAR's own `luaui/Widgets/map_startbox.lua` uses when a human
  drags an AI's marker in the pre-game.

So: the game has a supported way to place an AI; it just insists a player
on the AI's side sends it.

## What BARb already has

- `CSetupManager::PickStartPos(type)` computes a start position - a metal
  cluster in the start box ranked by income and distance to the map centre,
  claimed per ally team through `CAllyTeam::OccupyCluster`, or a random
  box point - and calls `circuit->GetGame()->SendStartPosition(false, pos)`.
  It is dead code: `CSetupData::CanChooseStartPos()` is hard-wired `false`
  and the call in `CCircuitAI::Init` is commented out ("FIXME: finish start
  factory and position selection"). Only the `/aipos`-style text command
  (`cmdPos`) reaches it.
- Per-map start spots with intended roles: `types/start_spot.as`
  (`pos`, `aiRole`, `landLocked`) in `data/script/src/maps/*.as`, and the
  role today is *derived from* the captured start position
  (`GenericHelpers::RecordStart`, `Setup`).
- A host-side UI channel: `ai.CallUI` -> LuaUI `RecvSkirmishAIMessage`
  (`WidgetLink`), and `Spring.SendSkirmishAIMessage(teamId, "barb|...")` ->
  `Main::AiLuaMessage` -> `Commands::Handle` (`query`, `setrole`). The
  widget is `tools/widgets/gui_barb_team_link.lua`; it already refreshes
  team lists in `Initialize` and answers per-AI queries.
- Roster messages between allied BARb instances (`AiSendMessage`,
  in-process).

## The channel that works

```
 pre-game, host machine
 ┌──────────────┐  barb|startpos|<team>   ┌────────────────────┐
 │ LuaUI widget │ ──────────────────────► │ BARb (script)      │
 │ (host player)│ ◄────────────────────── │ picks spot + role  │
 └──────┬───────┘  barb|startpos|team|ally│ from map config    │
        │            |x|z|role            └────────────────────┘
        │ Spring.SendLuaRulesMsg("aiPlacedPosition:team:x:z")
        ▼
 ┌────────────────────────────┐   Spring.SetTeamStartPosition(team, x, y, z)
 │ game_initial_spawn (synced)│   startPointTable[team] = {x, z}
 └────────────────────────────┘   -> spawnRegularly at GameStart
```

Every hop exists today. `LuaUnsyncedCtrl::SendSkirmishAIMessage` has no
"game started" guard (`CEngineOutHandler::SendLuaMessages` walks the local
AIs), and BAR's own pre-game widgets send `RecvLuaMsg` lines before
`GameStart` (`changeStartUnit`, `ready_to_start_game`).

## Proposal

**Widget-brokered placement.** No engine or game change; one widget (already
in the repo) and one script command.

1. **Script: choose the spot.** `Commands::Handle` gains `startpos`:
   from `Global::Map::Config.StartSpots` inside this AI's start box, take the
   spots in a deterministic order (role priority TECH, AIR, SEA, SUPPORT,
   TACTICAL, FRONT, then distance from the box middle) and assign the *n*-th
   to the *n*-th allied BARb by team id - every instance computes the same
   table, so no negotiation is needed before the roster exists. Validate with
   native `CTerrainManager::CanBeBuiltAt(commander, pos)` (registered as a
   script call) and the `tooCloseToSpawn` rule against the other chosen
   spots. Answer `barb|startpos|<team>|<ally>|<x>|<z>|<role>`; when the map
   has no spots, answer with `PickStartPos(METAL_SPOT)`'s choice (re-enable
   the native picker as a query that returns the position instead of sending
   it).
2. **Widget: broker it.** In `Initialize` (pre-game) and again on
   `GameSetup`, for each local BARb team query `barb|startpos|<team>`; on
   the reply, `Spring.SendLuaRulesMsg("aiPlacedPosition:" .. team .. ":" ..
   x .. ":" .. z)`. Show the placed marker in the existing panel; let the
   host veto by dragging (BAR's `map_startbox.lua` sends the same message,
   last write wins).
3. **Role follows the spot.** `RecordStart` keeps deriving the role from
   the commander's actual position, so a spot the widget could not place
   (refused as too close, modoption missing) degrades to today's behaviour
   with no special case.
4. **Readiness untouched.** The AI never sends `ready = true`; the host's
   ready state is the host's.

Cost: ~60 lines script, ~40 lines widget, and a `CanBeBuiltAt` registration
on the script API - which is a native change and therefore a DLL rebuild
(the placement logic itself needs no other native change).

## Limits

1. **Needs the widget on the host.** An AI hosted by a headless autohost
   (SPADS) is hosted by a spectator; `RecvLuaMsg` refuses spectators and
   there is no LuaUI there. Those AIs keep the guessed start.
2. **Enemy-hosted AIs need the modoption.** In a lobby where the host adds
   AIs to the opposing team, the host player is on another ally team;
   `aiPlacedPosition` is refused unless `allow_enemy_ai_spawn_placement` is
   on (it lives under "cheats" in `modoptions.lua`, default off).
3. **`startpostype=2` only.** Fixed (0), random (1) and choose-before-game
   (3) take positions from the map or the lobby; nothing in-game can move
   them.
4. **One map config per map.** Maps without `StartSpots` fall back to the
   metal-cluster picker, which knows nothing about roles.
5. **Draft spawn order.** With BAR's draft mode on, AI placement follows
   the same `aiPlacedPosition` path, but turn order applies to players
   only; untested.

## Fallback without a widget

Relocation after spawn, AI-side only: capture the guessed spawn, pick the
intended spot as above, and if it is farther than a threshold walk the
commander there before the first factory (`CSetupManager::SetBasePos`,
`FindNewBase`, a builder `Wait`+move). Costs the walk (a commander at ~37
elmos/s crosses 1 000 elmos in ~27 s) and the layout plan must be pushed at
arrival rather than at setup. Worth having behind the broker as the
autohost case, not instead of it.

## Sources

- Engine (read-only): `rts/ExternalAI/Interface/AISCommands.h`
  (`SSendStartPosCommand`), `rts/ExternalAI/SSkirmishAICallbackImpl.cpp`
  (`COMMAND_SEND_START_POS`), `rts/ExternalAI/AICallback.cpp`
  (`SendStartPos`), `rts/Net/GameServer.cpp` (`NETMSG_STARTPOS`),
  `rts/Net/NetCommands.cpp` (client `AllowStartPosition`),
  `rts/Game/Game.cpp` (`LoadSkirmishAIs`),
  `rts/Lua/LuaUnsyncedCtrl.cpp` (`SendSkirmishAIMessage`).
- Game (read-only): `luarules/gadgets/game_initial_spawn.lua`
  (`AllowStartPosition`, `RecvLuaMsg` `aiPlacedPosition`, `GameStart`,
  `spawnRegularly`), `common/lib_startpoint_guesser.lua`,
  `luaui/Widgets/map_startbox.lua`, `modoptions.lua`
  (`allow_enemy_ai_spawn_placement`).
- This repo: `src/circuit/setup/SetupManager.cpp` (`PickStartPos`),
  `src/circuit/setup/SetupData.h` (`CanChooseStartPos`),
  `src/circuit/CircuitAI.cpp` (`Init`, `LuaMessage`),
  `data/script/src/manager/commands.as`, `manager/widget_link.as`,
  `types/start_spot.as`, `tools/widgets/gui_barb_team_link.lua`.

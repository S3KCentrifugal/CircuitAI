# Test widgets

A test widget is a LuaUI widget staged with
`--extra-widget tools/playtest/widgets/<file>.lua`. It watches the game and
logs tagged lines; some also move the camera and take screenshots. Never copy
widgets into the install's `LuaUI/Widgets`.

## Skeleton

```lua
function widget:GetInfo()
	return { name = "BARb <what> watch", desc = "tools/playtest: <what>", author = "s3k-CircuitAI",
	         date = "YYYY-MM-DD", layer = 10, enabled = true }
end
local TAG = "[What] "
local function echo(s) Spring.Echo(TAG .. s) end
local START = 15 * 60 * 30          -- act from minute 15 (30 frames a second)

function widget:Initialize() echo("loaded") end
function widget:GameFrame(f)
	if f < START then return end
	-- ... watch, then camera + screenshot:
	-- Spring.SetCameraTarget(x, Spring.GetGroundHeight(x, z), z, 0)
	-- Spring.SetCameraState({ height = 2600, dist = 2600 }, 0)
	-- six frames later: Spring.SendCommands("screenshot png")
end
```

## Rules

- **One tag per widget.** Every line is `Spring.Echo("[Tag] ...")`. Checks on
  it need `"scope": "any"`, and only `[Playtest]` lines reach the report
  timeline, so grep the run's infolog for the tag.
- **Errors never fail a run.** A Lua error prints
  `Error in <CallIn>(): [string "LuaUI/Widgets/<file>.lua"]:<line>` and
  `Removed widget: <Name>`, or `Failed to load: <file>.lua`; the widget's
  later steps silently never run. No Lua checker is installed. After a new
  widget:
  - run a short game;
  - expect its `loaded` echo;
  - grep for those three lines.
  To fail a run on it, forbid `Removed widget: <your GetInfo name>` (scope
  any), never a bare `Error in`: every headless run removes `gui_pip`.
- **Frames, not time.** Gate on `Spring.GetGameFrame()` (1800 a minute); for
  drawings see SKILL.md section 4.
- **Camera.** Pass `--shots ""` when the widget drives the camera (SKILL.md
  section 5). Shoot at least 6 frames after moving it.
- **Give the AI targets.** Silos and similar fire only at what the AI has
  seen. For a test, at a fixed frame:
  `Spring.SendCommands("cheat 1", "globallos", "cheat 0")`. Every AI sees all
  from then on, so keep it out of benchmarks.
- **Count map strokes.** Count received strokes in
  `widget:MapDrawCmd(playerID, cmdType, x, y, z, ...)`, returning false,
  before blaming the AI for missing lines. The server drops a player's draw
  messages after 25 in a row each under 50 ms apart, until a 50 ms pause; every
  AI on the host counts as that one player.
- **Structures.** Use `ud.isImmobile`: `ud.isBuilding` needs a yardmap, and
  BAR nano turrets have none.
- **AI to widget.**
  - BAR never calls `widget:RecvSkirmishAIMessage`. Hook the LuaUI global
    the way `tools/widgets/gui_barb_team_link.lua` does (`getfenv(0)`,
    `rawset`, `Script.UpdateCallIn`); only one widget can hold it.
  - Widget to AI: `Spring.SendSkirmishAIMessage(teamID, "barb|...")`
    (`commands.as`).
  - `ai.CallUI` reaches only the host's LuaUI.
- **Installed widgets still load**, through SpringData. The BARb team link's
  window is closed by the camera widget until frame 300: call
  `WG.barblink.SetOpen(true)` after that if a test needs it. To test the repo
  copy, stage it with the same file name.
- **Saved widget state.** Widget config persists in `<dir>/LuaUI/Config/BYAR.lua`.
  A widget once saved as disabled stays off: if its `loaded` line is missing,
  remove its entry there.
- **Team numbers.** Skip the spectator and Gaia teams in per-team loops
  (SKILL.md section 3).

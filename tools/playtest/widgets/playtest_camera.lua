-- Playtest camera (tools/playtest): staged into the playtest write dir's
-- LuaUI/Widgets by playtest.py with CFG filled in. It never ships with the AI.
--
-- What it does, all logged as "[Playtest] ..." lines in the infolog so the
-- watcher can pair them with the AI's own lines:
--   * forcestart in the pregame and the game speed at frame 1,
--   * finds the AI under test from the BARb roster message (role + team) or
--     the team's start position, points the overhead camera at it and takes a
--     screenshot at each configured minute (screenshots/screenNNNNN.png),
--   * quits the engine at end_minute.
local CFG = __CFG__

function widget:GetInfo()
	return {
		name    = "Playtest camera",
		desc    = "Screenshots of the AI under test and a timed quit (tools/playtest)",
		author  = "s3k-CircuitAI",
		date    = "2026-09-21",
		layer   = 0,
		enabled = true,
	}
end

local FPS = 30
local target = { team = CFG.team, x = nil, z = nil, found = false }
local shots = {}
local pending = nil
local ended = false

local function echo(s)
	Spring.Echo(CFG.log_prefix .. " " .. s)
end

local function split(s, sep)
	local out = {}
	for piece in string.gmatch(s .. sep, "([^" .. sep .. "]*)" .. sep) do
		out[#out + 1] = piece
	end
	return out
end

function widget:Initialize()
	for i, s in ipairs(CFG.shots or {}) do
		shots[i] = { minute = s.minute, frame = math.floor(s.minute * 60 * FPS), height = s.height or 2200, done = false }
	end
	echo(string.format("widget loaded: role %s, team %s, speed %s, %d shots, end at %s min",
		tostring(CFG.role), tostring(CFG.team), tostring(CFG.speed), #shots, tostring(CFG.end_minute)))
	Spring.SendCommands("specfullview 3")
	-- BAR's Autoquit widget exits the game when the mouse has not moved; nobody moves it here
	Spring.SendCommands("luaui disablewidget Autoquit")
	if widgetHandler and widgetHandler.DisableWidget then
		widgetHandler:DisableWidget("Autoquit")
	end
	echo("Autoquit widget disabled")
	if CFG.forcestart and Spring.GetGameFrame() <= 0 then
		Spring.SendCommands("forcestart")
	end
end

function widget:GameStart()
	if CFG.forcestart then
		Spring.SendCommands("forcestart")
	end
end

-- roster line: "barb|roster|<team>|<ally>|roster|?|teamId|aiId|role|side|factory|x|z|landLocked|spot|leader"
function widget:RecvSkirmishAIMessage(aiTeam, dataStr)
	if type(dataStr) ~= "string" or string.sub(dataStr, 1, 5) ~= "barb|" then return end
	local p = split(dataStr, "|")
	if p[2] ~= "roster" then return end
	local teamId, role, x, z = tonumber(p[7]), p[9], tonumber(p[12]), tonumber(p[13])
	if target.found then return end
	if role == CFG.role and (CFG.team == nil or teamId == CFG.team) then
		target.found, target.team, target.x, target.z = true, teamId, x, z
		echo(string.format("target team %d (%s) at (%d, %d) from the roster", teamId, role, x or -1, z or -1))
	end
end

local function resolveTarget()
	if target.found then return true end
	local team = CFG.team or 0
	local x, y, z = Spring.GetTeamStartPosition(team)
	if x and z then
		target.found, target.team, target.x, target.z = true, team, x, z
		echo(string.format("target team %d at (%d, %d) from its start position", team, x, z))
		return true
	end
	return false
end

local function lookAt(x, z, height)
	local y = Spring.GetGroundHeight(x, z) or 0
	Spring.SendCommands("viewta")
	Spring.SetCameraTarget(x, y, z, 0)
	Spring.SetCameraState({ height = height, dist = height }, 0)
end

local function dumpTeams(n)
	for _, t in ipairs(Spring.GetTeamList()) do
		local _, leader, isDead, isAI, side, ally = Spring.GetTeamInfo(t, false)
		local x, y, z = Spring.GetTeamStartPosition(t)
		echo(string.format("frame %d team %d ally %s side %s ai %s dead %s start (%d, %d) units %d",
			n, t, tostring(ally), tostring(side), tostring(isAI), tostring(isDead), x or -1, z or -1, Spring.GetTeamUnitCount(t) or -1))
	end
end

-- every structure the team under test finishes, and any unit costing 2,000+ metal
-- (T3), as "[Playtest] finished <def> team <t> at <min>" for the benchmark tracker
function widget:UnitFinished(unitID, unitDefID, unitTeam)
	local ud = UnitDefs[unitDefID]
	if not ud then return end
	local team = CFG.team or 0
	if unitTeam ~= team then return end
	if ud.isBuilding or (ud.metalCost or 0) >= 2000 then
		local n = Spring.GetGameFrame()
		echo(string.format("finished %s team %d at %.2f min", ud.name, unitTeam, n / (60 * FPS)))
	end
end

local function dumpEco(n)
	local team = CFG.team or 0
	local m, ms, _, mi = Spring.GetTeamResources(team, "metal")
	local e, es, _, ei = Spring.GetTeamResources(team, "energy")
	echo(string.format("eco team %d at %.1f min: metal +%.1f bank %d/%d, energy +%.1f bank %d/%d, units %d",
		team, n / (60 * FPS), mi or 0, m or 0, ms or 0, ei or 0, e or 0, es or 0, Spring.GetTeamUnitCount(team) or 0))
end

function widget:GameFrame(n)
	if n % 1800 == 0 then dumpEco(n) end
	if n == 1 then Spring.SendCommands("luaui disablewidget Autoquit") end
	if n == 1 or n == 90 then dumpTeams(n) end
	if n == 1 and CFG.speed and CFG.speed > 1 then
		Spring.SendCommands({ "setmaxspeed " .. CFG.speed, "setminspeed " .. CFG.speed })
		echo("speed " .. CFG.speed)
	end
	if pending and n >= pending.frame then
		Spring.SendCommands("screenshot png")
		echo(string.format("screenshot at %.1f min of team %d at (%d, %d)", pending.minute, target.team or -1, target.x or -1, target.z or -1))
		pending = nil
	end
	for _, s in ipairs(shots) do
		if not s.done and n >= s.frame then
			s.done = true
			if resolveTarget() then
				lookAt(target.x, target.z, s.height)
				pending = { frame = n + 6, minute = s.minute }
			else
				echo(string.format("no target for the %.1f min screenshot", s.minute))
			end
		end
	end
	if not ended and CFG.end_minute and n >= math.floor(CFG.end_minute * 60 * FPS) then
		ended = true
		echo(string.format("end at %.1f min: quitting", n / (60 * FPS)))
		Spring.SendCommands("quitforce")
	end
end

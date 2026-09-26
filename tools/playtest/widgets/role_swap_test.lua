-- Playtest driver for the BARb team link widget (tools/widgets/gui_barb_team_link.lua):
-- exercises the same code paths as its buttons, through WG.barblink.
--
--   * minute 2: checks the host may command every listed AI, and flies the
--     camera to team 0's commander once (GoTo), logging where it went;
--   * SWAP_MINUTES: swaps the roles of a TECH and an AIR AI of the same ally
--     team (SetRole on both), then logs each AI's reply.
--
-- Staged by: playtest.py run --extra-widget tools/widgets/gui_barb_team_link.lua
--            --extra-widget tools/playtest/widgets/role_swap_test.lua
-- Every line starts "[RoleSwap]" for the report.

function widget:GetInfo()
	return {
		name    = "BARb role swap test",
		desc    = "tools/playtest: drives WG.barblink (role swaps, camera fly-to)",
		author  = "s3k-CircuitAI",
		date    = "2026-09-25",
		layer   = 10,
		enabled = true,
	}
end

local FPS = 30
local SWAP_MINUTES = { 20, 30, 40 }
-- CHAIN: one AI switched through a sequence of roles, as the owner did before a
-- crash (build98, team 12: TECH -> FRONT -> AIR -> SEA -> FRONT, crash 21.3 min).
-- Set CHAIN = nil for the swap test only.
local CHAIN = { { 8.5, "FRONT" }, { 11.1, "AIR" }, { 13.4, "SEA" }, { 18.5, "FRONT" } }
local chainTeam = nil
local chainDone = {}
local CHECK_MINUTE = 2

local swaps = {}          -- { frame, done }
local checkDone = false
local pair = nil          -- { a = teamId, b = teamId, ally }: the two AIs swapped
local pendingReplies = {} -- { frame, teams }
local camCheck = nil      -- the camera target one second after GoTo

local function echo(s) Spring.Echo("[RoleSwap] " .. s) end

function widget:Initialize()
	for i, m in ipairs(SWAP_MINUTES) do swaps[i] = { frame = math.floor(m * 60 * FPS), minute = m, done = false } end
	echo("loaded: swaps at " .. table.concat(SWAP_MINUTES, ", ") .. " min")
end

local function findPair(roster)
	-- an ally team with one TECH and one AIR AI
	local byAlly = {}
	for id, r in pairs(roster) do
		byAlly[r.allyTeam] = byAlly[r.allyTeam] or {}
		byAlly[r.allyTeam][r.role] = byAlly[r.allyTeam][r.role] or id
	end
	for ally, roles in pairs(byAlly) do
		if roles.TECH and roles.AIR then return { a = roles.TECH, b = roles.AIR, ally = ally } end
	end
	return nil
end

local function check(api, n)
	local roster = api.Roster()
	local total, may = 0, 0
	for id, r in pairs(roster) do
		total = total + 1
		if api.MayCommand(id) then may = may + 1 end
	end
	echo(string.format("check at %.1f min: %d AIs announced, host may command %d, spectator %s",
		n / (60 * FPS), total, may, tostring(Spring.GetSpectatingState())))
	local ok, uid, kind = api.GoTo(0)
	if ok then
		local ux, _, uz = Spring.GetUnitPosition(uid)
		camCheck = { frame = n + FPS, uid = uid, kind = kind, x = ux, z = uz }
		echo(string.format("GoTo(0): %s %d at (%d, %d)", tostring(kind), uid, ux or -1, uz or -1))
	else
		echo("GoTo(0) found no commander or factory")
	end
	api.SetOpen(true)   -- the window open for the screenshot: the role grid's state shows
end

function widget:GameFrame(n)
	local api = WG.barblink
	if not api or not api.SetRole then
		if n % 1800 == 0 then echo("WG.barblink missing: the team link widget is not loaded") end
		return
	end
	if not checkDone and n >= CHECK_MINUTE * 60 * FPS then
		checkDone = true
		check(api, n)
	end
	if camCheck and n >= camCheck.frame then
		local cs = Spring.GetCameraState()
		local tx, tz = cs and cs.px, cs and cs.pz
		local d = (tx and camCheck.x) and math.sqrt((tx - camCheck.x) ^ 2 + (tz - camCheck.z) ^ 2) or -1
		echo(string.format("camera target 1 s after GoTo: (%d, %d), %d elmos from the %s (%s)",
			tx or -1, tz or -1, d, camCheck.kind, (d >= 0 and d < 200) and "on it" or "NOT on it"))
		camCheck = nil
	end
	if CHAIN then
		for i, step in ipairs(CHAIN) do
			if not chainDone[i] and n >= math.floor(step[1] * 60 * FPS) then
				chainDone[i] = true
				if not chainTeam then
					for id, r in pairs(api.Roster()) do
						if r.role == "TECH" and (chainTeam == nil or id < chainTeam) and not (pair and (id == pair.a or id == pair.b)) then chainTeam = id end
					end
				end
				if chainTeam then
					local ok = api.SetRole(chainTeam, step[2])
					echo(string.format("chain step %d at %.1f min: team %d -> %s (%s)", i, step[1], chainTeam, step[2], ok and "delivered" or "NOT delivered"))
				else
					echo("chain: no TECH AI to switch")
				end
			end
		end
	end
	for _, s in ipairs(swaps) do
		if not s.done and n >= s.frame then
			s.done = true
			local roster = api.Roster()
			if not pair then pair = findPair(roster) end
			if not pair then
				echo(string.format("swap at %d min: no ally team with a TECH and an AIR AI", s.minute))
			else
				local ra, rb = roster[pair.a] and roster[pair.a].role, roster[pair.b] and roster[pair.b].role
				echo(string.format("swap at %d min: team %d %s -> %s, team %d %s -> %s (ally %d)",
					s.minute, pair.a, tostring(ra), tostring(rb), pair.b, tostring(rb), tostring(ra), pair.ally))
				local okA = api.SetRole(pair.a, rb)
				local okB = api.SetRole(pair.b, ra)
				echo(string.format("sent: team %d %s, team %d %s", pair.a, okA and "delivered" or "NOT delivered", pair.b, okB and "delivered" or "NOT delivered"))
				pendingReplies[#pendingReplies + 1] = { frame = n + 10 * FPS, minute = s.minute }
			end
		end
	end
	for i = #pendingReplies, 1, -1 do
		local p = pendingReplies[i]
		if n >= p.frame then
			table.remove(pendingReplies, i)
			local roster = api.Roster()
			echo(string.format("replies 10 s after the %d min swap: team %d says '%s' (now %s), team %d says '%s' (now %s)",
				p.minute, pair.a, tostring(api.LastReply(pair.a)), tostring(roster[pair.a] and roster[pair.a].role),
				pair.b, tostring(api.LastReply(pair.b)), tostring(roster[pair.b] and roster[pair.b].role)))
		end
	end
end

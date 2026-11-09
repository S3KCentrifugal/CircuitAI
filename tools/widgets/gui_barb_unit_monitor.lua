-- BARb unit monitor
--
-- One of the BARb widgets around the BARb team link (D-497, D-498): a tile in
-- the BARb launcher column opening a window in the same style. It shows how one
-- locally hosted BARb AI has organised its army and lets you find any group
-- on the battlefield:
--
--   * Selected unit: select any unit of a BARb team in the game and the card
--     shows what it belongs to (battle group, screen or support cohort, task or squad),
--     its controller, stance, order and cohort mode. Every membership is a
--     chip that opens that group. The monitor follows the unit's team.
--   * Groups: every battle group (group controller), cohort (formation bucket of the
--     ranged and skirmisher units), squad and multi-unit fighter task, with
--     filter chips and member counts. Hover a row to preview, click to select,
--     double-click to fly the camera there.
--   * Details: the selected group's state (order, stances, activity, mode,
--     reason, threat mix, values), why it does it (every factor that held when
--     it decided), its composition and its parent and child groups, with
--     Select units and Go to. The selected unit shows its own activity and
--     factors too (D-508).
--   * Glow: the selected group's units glow in its colour with a pulsing ring,
--     a centre marker, its facing arrow (battle groups) and a label; the hovered row
--     previews with rings. "All" rings every listed group in its own colour.
--
-- Data: the AI publishes the state keys "groups" and "unitinfo" while this
-- widget holds the "monitor" lease, and "monitorcodes" once per lease: the
-- names of the activity indexes and factor bits the records carry (D-508,
-- native src/circuit/control/kernel/ActionWhy.h). Both go through the BARb team link
-- (WG.barb): its state-file reader delivers the values, its counted lease
-- renews "barb|monitor|<team>|on". Wire format:
-- src/circuit/control/group/GroupMonitor.h; script side:
-- data/script/src/systems/presentation/widget_link.as (MonitorTick).
-- Host only: the AI must run on this machine. A playing host sees only allied
-- AIs; a spectator sees every AI it hosts.
--
-- Install: copy into <BAR data dir>/LuaUI/Widgets/ with gui_barb_team_link.lua.
-- Open/close: the Units tile, /barbmonitor or Ctrl+Alt+M. Escape closes it
-- while the mouse is over it. Over the window: Up/Down move through the list,
-- Enter selects the group's units, G flies the camera to it.
--
-- Cost: the team list and the game selection are read once per POLL_SECONDS
-- while the window is open; a snapshot is parsed only when the AI's value
-- changed. Drawing touches only the selected and hovered groups (at most
-- MAX_GLOW_MODELS model passes, MAX_RINGS rings), or every listed group's
-- rings with "All". Nothing runs while the window is closed.

function widget:GetInfo()
	return {
		name    = "BARb unit monitor",
		desc    = "BARb AI groups: battle groups, cohorts, squads and tasks; what a selected unit belongs to; glowing selections (host only)",
		author  = "s3k-CircuitAI",
		date    = "2026-11-08",
		layer   = 1,
		enabled = true,
	}
end

-- ---------------------------------------------------------------- constants

local WIN_W, WIN_H = 360, 680          -- unscaled px
local LAUNCHER = 26                    -- unscaled px, as the team link's
local ROW_H = 20
local DETAIL_H = 236
local UNIT_CARD_H = 100
local POLL_SECONDS = 1.0
local LEASE_RENEW_SECONDS = 15
local DOUBLE_CLICK_SECONDS = 0.35
local MAX_GLOW_MODELS = 160
local MAX_RINGS = 600
local GLOW_ALPHA = 0.55
local PULSE_SPEED = 3.2
local STALE_SECONDS = 8                -- game seconds without a fresh snapshot
local FORMAT = 2   -- D-500: battle group records "G", unit key "group"

local KIND_ORDER = { group = 1, cohort = 2, squad = 3, task = 4 }
local KIND_LABEL = { group = "Battle group", cohort = "Cohort", squad = "Squad", task = "Task" }
local KIND_HINT = {
	group = "Battle group: a group controller riding a screen cohort and the support cohort paired behind it",
	cohort = "Cohort: ranged or skirmisher units the AI moves and assesses as one formation bucket",
	squad = "Squad: a native attack, defend, raid, bomb, anti-air or anti-heavy group with a leader",
	task = "Task: any other fighter task with two or more units",
}
local FILTERS = { "all", "group", "cohort", "squad", "task" }
local FILTER_LABEL = { all = "All", group = "Groups", cohort = "Cohorts", squad = "Squads", task = "Tasks" }

-- the same art and palette as the team link
local ICON = {
	launcher = "icons/eye.png",
	close    = "LuaUI/Images/advplayerslist/cross.dds",
	camera     = "LuaUI/Images/advplayerslist/camera.dds",
	select   = "LuaUI/Images/advplayerslist/indicator.dds",
	all      = "icons/radar_t2.png",
	group    = "icons/bot_t2.png",
	cohort   = "icons/bot.png",
	squad    = "icons/air.png",
	task     = "icons/worker.png",
}
local C = {
	onSurface        = { 0.93, 0.93, 0.93, 1 },
	onSurfaceVariant = { 0.66, 0.66, 0.68, 1 },
	outline          = { 1, 1, 1, 0.12 },
	outlineStrong    = { 1, 1, 1, 0.28 },
	primary          = { 1, 0.9, 0.66, 1 },
	primaryContainer = { 1, 0.9, 0.66, 0.2 },
	surface          = { 0.07, 0.07, 0.08, 0.93 },
	surfaceHigh      = { 1, 1, 1, 0.06 },
	hoverLayer       = { 1, 1, 1, 0.08 },
	pressLayer       = { 1, 1, 1, 0.14 },
	ok               = { 0.55, 0.85, 0.55, 1 },
	warn             = { 1, 0.75, 0.4, 1 },
	error            = { 1, 0.5, 0.5, 1 },
}
-- distinct, saturated group colours; a group keeps its colour by its key
local PALETTE = {
	{ 0.30, 0.85, 1.00 }, { 1.00, 0.55, 0.20 }, { 0.55, 1.00, 0.35 }, { 1.00, 0.35, 0.65 },
	{ 0.75, 0.55, 1.00 }, { 1.00, 0.90, 0.30 }, { 0.25, 1.00, 0.75 }, { 1.00, 0.40, 0.35 },
	{ 0.45, 0.65, 1.00 }, { 0.90, 1.00, 0.55 },
}
local SOUND_CLICK = "LuaUI/Sounds/buildbar_click.wav"

-- ---------------------------------------------------------------- engine locals

local glColor, glRect, glText, glTexture, glTexRect = gl.Color, gl.Rect, gl.Text, gl.Texture, gl.TexRect
local spGetGameFrame, spGetMouseState = Spring.GetGameFrame, Spring.GetMouseState
local spGetTeamList, spGetTeamInfo, spGetAIInfo, spGetTeamColor = Spring.GetTeamList, Spring.GetTeamInfo, Spring.GetAIInfo, Spring.GetTeamColor
local spGetMyTeamID, spAreTeamsAllied, spGetSpectatingState = Spring.GetMyTeamID, Spring.AreTeamsAllied, Spring.GetSpectatingState
local spSendSkirmishAIMessage, spPlaySoundFile = Spring.SendSkirmishAIMessage, Spring.PlaySoundFile
local spGetMyPlayerID, spGetUnitDefID, spGetUnitTeam = Spring.GetMyPlayerID, Spring.GetUnitDefID, Spring.GetUnitTeam
local spGetUnitPosition, spSetCameraTarget, spGetSelectedUnits = Spring.GetUnitPosition, Spring.SetCameraTarget, Spring.GetSelectedUnits
local spGetUnitHealth, spGetUnitRadius, spWorldToScreenCoords = Spring.GetUnitHealth, Spring.GetUnitRadius, Spring.WorldToScreenCoords
local spIsUnitVisible, spGetGroundHeight = Spring.IsUnitVisible, Spring.GetGroundHeight
local mathFloor, mathMax, mathMin, mathSin, mathAbs = math.floor, math.max, math.min, math.sin, math.abs

-- ---------------------------------------------------------------- the hub (D-498)

local OWNER, PANEL_ID, PANEL_ORDER = "barbmonitor", "barbmonitor", 20

local function hub()
	local h = WG.barb
	if h and (h.version or 0) >= 1 then return h end
	return nil
end
local function mayMonitor(teamId)
	local h = hub()
	return teamId ~= nil and h ~= nil and h.MayCommand(teamId) == true
end

-- ---------------------------------------------------------------- state

local vsx, vsy = Spring.GetViewGeometry()
local panel = nil
local saved = nil
local subscribed = false
local open = false          -- mirrors panel.open (onOpen keeps it in step)
local teams = {}            -- ordered hosted teams: { id, name, color, role }
local team = nil            -- the monitored team
local filter = "all"
local showAll = false
local listScroll = 0
local selectedKey, hoverKey = nil, nil
local lastClick = nil       -- { key, timer }
local snapshot = nil        -- the parsed "groups" payload of the monitored team
local unitInfo = nil        -- the parsed "unitinfo" payload
local focusUnit = nil       -- the game's selected unit, when it belongs to a BARb team
local focusSent = nil
local lastPoll = nil
local status = ""
local visible = {}          -- the filtered, sorted groups shown in the list
local startTimer = Spring.GetTimer()

-- ---------------------------------------------------------------- helpers

local function split(s, sep)
	local out = {}
	for piece in string.gmatch(s .. sep, "([^" .. sep .. "]*)" .. sep) do out[#out + 1] = piece end
	return out
end

local function playClick() end   -- the panel kit plays the click on release

local function colourFor(key)
	local h = 0
	for i = 1, #key do h = (h * 31 + string.byte(key, i)) % 1000003 end
	return PALETTE[(h % #PALETTE) + 1]
end

local function unitName(defID)
	local d = defID and UnitDefs[defID]
	if not d then return "unit" end
	return d.translatedHumanName or d.humanName or d.name
end

local function send(teamId, msg)
	local h = hub()
	if h and mayMonitor(teamId) then h.Send(teamId, "barb|" .. msg) end
end

local function roleOf(teamId)
	for _, t in ipairs(teams) do if t.id == teamId then return t.role end end
	return nil
end

local function refreshTeams()
	teams = {}
	local h = hub()
	if h then
		for _, t in ipairs(h.Teams()) do
			if t.hosted and mayMonitor(t.id) then
				teams[#teams + 1] = { id = t.id, name = t.name or ("Team " .. t.id), color = t.color or { 1, 1, 1, 1 }, role = t.role }
			end
		end
	end
	local found = false
	for _, t in ipairs(teams) do if t.id == team then found = true end end
	if not found then team = teams[1] and teams[1].id or nil end
end

-- ---------------------------------------------------------------- parsing

local function members(field)
	local out = {}
	if field and field ~= "" then
		for v in string.gmatch(field, "[^:]+") do
			local n = tonumber(v)
			if n then out[#out + 1] = n end
		end
	end
	return out
end

local function parseGroups(payload)
	local records = split(payload, ";")
	if tonumber(records[1]) ~= FORMAT then return nil end
	local s = { frame = tonumber(records[2]) or 0, battleGroups = {}, cohorts = {}, tasks = {}, groups = {}, byKey = {}, byUnit = {} }
	for i = 3, #records do
		local f = split(records[i], ",")
		if f[1] == "G" and #f >= 25 then
			s.battleGroups[#s.battleGroups + 1] = {
				key = tonumber(f[2]), template = f[3], partner = tonumber(f[4]),
				order = f[5], scriptOrder = f[6], ownOrder = f[7], screenStance = f[8], rearStance = f[9],
				spread = tonumber(f[10]) or 1, separation = tonumber(f[11]) or 0,
				fx = tonumber(f[12]) or 0, fz = tonumber(f[13]) or 0, facingSet = f[14] == "1",
				scripted = f[15] == "1", standFirm = f[16] == "1",
				screens = tonumber(f[17]) or 0, rears = tonumber(f[18]) or 0,
				threat = { short = tonumber(f[19]) or 0, peer = tonumber(f[20]) or 0, long = tonumber(f[21]) or 0,
					static = tonumber(f[22]) or 0, commander = tonumber(f[23]) or 0 },
				hostileMetal = tonumber(f[24]) or 0, orderAge = tonumber(f[25]) or -1,
				-- D-501: the screen size target and maximum (0: no size policy)
				sizeTarget = tonumber(f[26]) or 0, sizeMax = tonumber(f[27]) or 0,
				groupWhy = f[28],   -- D-508: the order's factors (hex)
				-- D-509: anti-air escorts needed, the most it takes, the air HP planned for, the escorts
				airNeed = tonumber(f[29]) or 0, airCap = tonumber(f[30]) or 0, airHeld = tonumber(f[31]) or 0,
				escorts = members(f[32]),
			}
		elseif f[1] == "C" and #f >= 17 then
			local c = {
				key = tonumber(f[2]), mode = f[3], reason = f[4], x = tonumber(f[5]) or 0, z = tonumber(f[6]) or 0,
				radius = tonumber(f[7]) or 0, rear = f[8] == "1", partner = tonumber(f[9]) or -1,
				committed = f[10] == "1", supporting = f[11] == "1", rush = f[12] == "1",
				own = tonumber(f[13]) or 0, hostile = tonumber(f[14]) or 0, advantage = tonumber(f[15]) or 0,
				target = tonumber(f[16]) or -1, members = members(f[17]),
				recruit = tonumber(f[18]) or -1,   -- D-501: the group it walks to and merges with
				activity = tonumber(f[19]), planWhy = f[20],   -- D-508: activity index, plan factors (hex)
			}
			s.cohorts[c.key] = c
		elseif f[1] == "T" and #f >= 8 then
			s.tasks[#s.tasks + 1] = {
				id = f[2], fight = f[3], leader = tonumber(f[4]) or -1, x = tonumber(f[5]) or 0, z = tonumber(f[6]) or 0,
				power = tonumber(f[7]) or 0, members = members(f[8]),
			}
		end
	end
	return s
end

local function addGroup(s, g)
	g.color = colourFor(g.key)
	s.groups[#s.groups + 1] = g
	s.byKey[g.key] = g
	for _, id in ipairs(g.members) do
		local list = s.byUnit[id]
		if not list then list = {}; s.byUnit[id] = list end
		list[#list + 1] = g
	end
end

-- Builds the group list and the unit index: battle groups own their two cohorts.
local function buildGroups(s)
	local lineOf = {}
	for _, l in ipairs(s.battleGroups) do
		local front, rear = s.cohorts[l.key], s.cohorts[l.partner]
		local ids = {}
		if front then for _, id in ipairs(front.members) do ids[#ids + 1] = id end end
		if rear then for _, id in ipairs(rear.members) do ids[#ids + 1] = id end end
		for _, id in ipairs(l.escorts or {}) do ids[#ids + 1] = id end   -- D-509: anti-air escorts
		local g = { key = "G" .. l.key, kind = "group", data = l, members = ids,
			label = "Battle group " .. l.key .. (l.template ~= "" and (" · " .. l.template) or ""),
			badge = l.order ~= "none" and l.order or l.screenStance, screen = front, children = {} }
		addGroup(s, g)
		if front then lineOf[l.key] = { g, "screen" } end
		if rear then lineOf[l.partner] = { g, "support" } end
	end
	for key, c in pairs(s.cohorts) do
		local parent = lineOf[key]
		local role = parent and parent[2] or (c.rear and "support" or nil)
		local g = { key = "C" .. key, kind = "cohort", data = c, members = c.members,
			label = (role == "screen" and "Screen cohort " or role == "support" and "Support cohort " or "Cohort ") .. key,
			badge = c.mode, parent = parent and parent[1] or nil, role = role, children = {} }
		addGroup(s, g)
		if parent then parent[1].children[#parent[1].children + 1] = g end
	end
	for _, t in ipairs(s.tasks) do
		local squad = t.leader >= 0
		local g = { key = "T" .. t.id, kind = squad and "squad" or "task", data = t, members = t.members,
			label = (squad and "Squad · " or "Task · ") .. t.fight, badge = t.fight, children = {} }
		addGroup(s, g)
	end
	s.unitCount = 0
	for _ in pairs(s.byUnit) do s.unitCount = s.unitCount + 1 end
	table.sort(s.groups, function(a, b)
		if a.kind ~= b.kind then return KIND_ORDER[a.kind] < KIND_ORDER[b.kind] end
		if #a.members ~= #b.members then return #a.members > #b.members end
		return a.key < b.key
	end)
end

local function parseUnitInfo(payload)
	local p = split(payload, ";")
	if tonumber(p[1]) ~= FORMAT then return nil end
	local info = { frame = tonumber(p[2]) or 0, unit = tonumber(p[3]), fields = {} }
	for kv in string.gmatch(p[4] or "", "[^,]+") do
		local k, v = kv:match("^([^=]+)=(.*)$")
		if k then info.fields[k] = v end
	end
	return info
end

-- D-508: activities and factors arrive as codes (an index, hex bit sets);
-- "monitorcodes" holds their names, one list per kind (A activities, P plan,
-- U unit, G group factors), entry i for bit i. PHRASE only makes a name
-- readable: a name it lacks shows with spaces, a bit without a name as
-- "bit <N>", so a newer AI never breaks this widget.
local CODES_VERSION = 1
local codes = nil
local PHRASE = {
	objective = "heading to its objective on the lane", joining = "walking to join the main group",
	recalled = "recalled to the main group (too small to fight alone)", arrived = "at its goal",
	lost_contact = "lost sight of a commander or reclaimer", ally_engaged = "own units or allies are fighting",
	target_in_sight = "enemy in sight", favorable = "trade is favourable", outmatched = "trade too costly",
	unknown_contact = "unseen enemy near the firing point", hazard_on_path = "commander, reclaimer or blast on the approach",
	battery = "too many towers", target_repaired = "target is being repaired", too_far = "too far to reach in time",
	off_map = "firing point off the map", static_cover = "towers cover the approach", outranged = "enemy outranges it",
	siege = "support outranges the towers: stands off", assembling = "waiting for members",
	spread_out = "column too long: front waits", jammer_hold = "in our jammer cover: holds instead of withdrawing",
	screening = "screening allied support", rush = "rush campaign", rush_cooldown = "rush cooling down",
	follows_screen = "follows its screen",
	rushed = "rushed by shorter-ranged raiders: kiting them", toward_help = "retreating toward allied help",
	down_lane = "retreating back down the lane", to_base = "retreating toward the base",
	stands = "raiders too fast to kite and help too far: stands and fires",
	escape = "inside an enemy's reach: stepping out", poke_in = "weapon ready: stepping in", poke_out = "reloading: stepping out",
	hold_incoming = "letting a closing enemy into range", shooting = "has a shot: stays and fires", to_slot = "walking to its place in the rows",
	siege_station = "on the siege station", siege_step = "last step into range of the tower", tuck = "enemy leaked: tucking behind the screen",
	no_screen = "no screen left", cover_delay = "covering while the support leaves", behind_support = "retreat stops at the support line",
	jammer_no_back = "in our jammer cover: never steps back", group_hold = "the battle group holds it", group_withdraw = "script withdraw",
	staged = "stops short of tower coverage", no_safe_move = "no safe move: holds", wait_reload = "moves only between shots", settled = "at its point",
	script_order = "script order", order_held = "order held (changes wait a few seconds)", stand_firm = "standing firm against a push",
	staggered = "screen and support move at different times",
	air_threat = "enemy air near: anti-air escorts needed",
}
local function parseCodes(payload)
	local p = split(payload, ";")
	if tonumber(p[1]) ~= CODES_VERSION then return nil end
	local out = {}
	for i = 2, #p do
		local tag, list = p[i]:match("^(%a)=(.*)$")
		if tag then out[tag] = list ~= "" and split(list, ":") or {} end
	end
	return out
end
local function phrase(code) return PHRASE[code] or (string.gsub(code, "_", " ")) end
local function activityName(index)
	if index == nil then return nil end
	local list = codes and codes.A
	return list and list[index + 1] or ("activity " .. index)
end
-- The names of the set bits of a hex factor set, appended to out. O(bits).
local function factorList(hex, tag, out)
	out = out or {}
	local n = tonumber(hex or "", 16)
	if not n then return out end
	local list = codes and codes[tag]
	local bit = 0
	while n > 0 and bit < 32 do
		if n % 2 == 1 then out[#out + 1] = (list and list[bit + 1]) or ("bit " .. bit) end
		n = mathFloor(n / 2); bit = bit + 1
	end
	return out
end
local function factorText(list)
	local parts = {}
	for i, code in ipairs(list) do parts[i] = phrase(code) end
	return table.concat(parts, " · ")
end
-- A list row's badge: the cohort's activity (a battle group's is its screen's).
local function badgeOf(g)
	local d = g.kind == "group" and g.screen or (g.kind == "cohort" and g.data or nil)
	return (d and activityName(d.activity)) or g.badge or ""
end
-- Why a group does what it does: a battle group's order factors and its screen's plan factors.
local function whyOf(g)
	if g.kind == "group" then
		local list = factorList(g.data.groupWhy, "G")
		if g.screen then factorList(g.screen.planWhy, "P", list) end
		return factorText(list)
	elseif g.kind == "cohort" then
		return factorText(factorList(g.data.planWhy, "P"))
	end
	return ""
end

local function applyState(key, value)
	if key == "monitorcodes" then
		local payload = value and value:match("^barb|monitorcodes|%d+|%d+|(.*)$")
		codes = payload and parseCodes(payload) or nil
	elseif key == "groups" then
		local payload = value and value:match("^barb|groups|%d+|%d+|(.*)$")
		local s = payload and parseGroups(payload) or nil
		if s then buildGroups(s) end
		snapshot = s
	elseif key == "unitinfo" then
		local payload = value and value:match("^barb|unitinfo|%d+|%d+|(.*)$")
		unitInfo = payload and parseUnitInfo(payload) or nil
	end
end

-- ---------------------------------------------------------------- monitoring

-- Reapplies the monitored team's current values from the hub's store.
local function reload()
	local h = hub()
	applyState("groups", h and team and h.Value(team, "groups") or nil)
	applyState("unitinfo", h and team and h.Value(team, "unitinfo") or nil)
	applyState("monitorcodes", h and team and h.Value(team, "monitorcodes") or nil)
end

local function setTeam(id)
	if id == team then return end
	local h = hub()
	if h and team and open then h.Release(OWNER, team, "monitor") end
	team = id
	snapshot, unitInfo, selectedKey, hoverKey, listScroll = nil, nil, nil, nil, 0
	focusSent = nil
	if h and team and open then h.Lease(OWNER, team, "monitor", LEASE_RENEW_SECONDS) end
	reload()
end

-- The panel's onOpen: the lease follows the window.
local function onOpen(v)
	open = v
	local h = hub()
	if v then
		refreshTeams()
		if h and team then h.Lease(OWNER, team, "monitor", LEASE_RENEW_SECONDS) end
		focusSent = nil
		reload()
	else
		if h and team then h.Release(OWNER, team, "monitor") end
		snapshot, unitInfo, focusSent = nil, nil, nil
	end
end

local function setOpen(v)
	if panel then panel.SetOpen(v) end
end

local function stepTeam(d)
	if #teams == 0 then return end
	local index = 1
	for i, t in ipairs(teams) do if t.id == team then index = i end end
	index = ((index - 1 + d) % #teams) + 1
	setTeam(teams[index].id)
end

local function groupCentre(g)
	local sx, sz, n = 0, 0, 0
	for _, id in ipairs(g.members) do
		local x, _, z = spGetUnitPosition(id)
		if x then sx, sz, n = sx + x, sz + z, n + 1 end
	end
	if n > 0 then return sx / n, sz / n, n end
	local d = g.data
	if d and d.x then return d.x, d.z, 0 end
	return nil
end

local function goToGroup(g)
	local x, z = groupCentre(g)
	if x then spSetCameraTarget(x, spGetGroundHeight(x, z), z, 0.6) end
end

local function selectUnits(g)
	local ids = {}
	for _, id in ipairs(g.members) do if spGetUnitPosition(id) then ids[#ids + 1] = id end end
	if #ids > 0 then Spring.SelectUnitArray(ids) end
end

local function selectGroup(key)
	selectedKey = key
end

local function filtered()
	local out = {}
	if not snapshot then return out end
	for _, g in ipairs(snapshot.groups) do
		if filter == "all" or g.kind == filter then out[#out + 1] = g end
	end
	return out
end

local function counts()
	local n = { all = 0, group = 0, cohort = 0, squad = 0, task = 0 }
	if snapshot then
		for _, g in ipairs(snapshot.groups) do n.all = n.all + 1; n[g.kind] = n[g.kind] + 1 end
	end
	return n
end

local function composition(g, limit)
	local byDef, order = {}, {}
	for _, id in ipairs(g.members) do
		local def = spGetUnitDefID(id)
		if def then
			if not byDef[def] then byDef[def] = 0; order[#order + 1] = def end
			byDef[def] = byDef[def] + 1
		end
	end
	table.sort(order, function(a, b) return byDef[a] > byDef[b] end)
	local parts = {}
	for i = 1, mathMin(limit, #order) do parts[#parts + 1] = byDef[order[i]] .. " " .. unitName(order[i]) end
	if #order > limit then parts[#parts + 1] = "+" .. (#order - limit) .. " more" end
	return table.concat(parts, " · ")
end

-- ---------------------------------------------------------------- drawing (the hub's panel kit)
-- Bound from the panel when it is made (bindPanel); every drawing function
-- below runs only inside the panel's draw or after it exists.
local px, inside, roundRect, outlineRect, text, textWidth, fitText, icon, stateLayer, register, divider, iconButton, labelButton, chip
local font, font2

local function bindPanel(P)
	px, inside, roundRect, outlineRect, text, textWidth, fitText = P.px, P.inside, P.roundRect, P.outlineRect, P.text, P.textWidth, P.fitText
	icon, stateLayer, register, divider, iconButton, labelButton, chip = P.icon, P.stateLayer, P.register, P.divider, P.iconButton, P.labelButton, P.chip
end

-- label / value pairs in two columns
local function fields(left, right, y, rows)
	local colW = (right - left) / 2
	local size = px(8.5)
	for i, r in ipairs(rows) do
		local col = (i - 1) % 2
		local row = mathFloor((i - 1) / 2)
		local x = left + col * colW
		local ty = y - row * px(13)
		text(font, r[1], x, ty, size, "o", C.onSurfaceVariant)
		local lw = textWidth(font, r[1] .. " ", size)
		text(font2, fitText(font2, tostring(r[2]), size, colW - lw - px(4)), x + lw, ty, size, "o", r[3] or C.onSurface)
	end
	return y - mathFloor((#rows + 1) / 2) * px(13)
end

-- ---------------------------------------------------------------- the window

local function teamEntry(id)
	for _, t in ipairs(teams) do if t.id == id then return t end end
	return nil
end

-- D-508: up to maxLines lines of s at most width wide, by words; the last ends "..." when cut.
local function wrapText(f, s, size, width, maxLines)
	local lines, line, cut = {}, "", false
	for word in string.gmatch(s, "%S+") do
		local try = line == "" and word or (line .. " " .. word)
		if line == "" or textWidth(f, try, size) <= width then line = try
		elseif #lines + 1 >= maxLines then cut = true; break
		else lines[#lines + 1] = line; line = word end
	end
	if line ~= "" then lines[#lines + 1] = cut and fitText(f, line .. " ...", size, width) or line end
	return lines
end

-- D-508: "Why: ..." in at most maxLines lines; the whole text is the tooltip.
local function drawWhy(why, left, right, y, id, maxLines)
	if why == "" then return y end
	local line = "Why: " .. why
	local lines = wrapText(font, line, px(8.5), right - left, maxLines)
	for i, l in ipairs(lines) do text(font, l, left, y - px(8) - (i - 1) * px(12), px(8.5), "o", C.primary) end
	register(left, y - #lines * px(12), right, y, id, function() end, line)
	return y - #lines * px(12) - px(2)
end

local function drawUnitCard(left, right, top)
	local y = top
	text(font2, "Selected unit", left, y - px(10), px(9), "o", C.onSurfaceVariant)
	y = y - px(16)
	if not focusUnit then
		text(font, "Select a unit of a BARb team to see what it belongs to.", left, y - px(9), px(8.5), "o", C.onSurfaceVariant)
		return top - px(UNIT_CARD_H)
	end
	local def = spGetUnitDefID(focusUnit)
	local hp, maxHp = spGetUnitHealth(focusUnit)
	local name = unitName(def) .. "  #" .. focusUnit
	text(font2, fitText(font2, name, px(10), right - left - px(70)), left, y - px(10), px(10), "o", C.onSurface)
	if hp and maxHp and maxHp > 0 then
		local frac = mathMax(0, mathMin(1, hp / maxHp))
		local bx1, bx2 = right - px(64), right
		roundRect(bx1, y - px(9), bx2, y - px(4), px(2), C.surfaceHigh)
		local col = frac > 0.6 and C.ok or (frac > 0.3 and C.warn or C.error)
		roundRect(bx1, y - px(9), bx1 + (bx2 - bx1) * frac, y - px(4), px(2), col)
	end
	y = y - px(18)
	-- memberships, outermost first: battle group, cohort, squad/task
	local groups = snapshot and snapshot.byUnit[focusUnit] or nil
	local cx = left
	if groups and #groups > 0 then
		local ordered = {}
		for _, g in ipairs(groups) do ordered[#ordered + 1] = g end
		table.sort(ordered, function(a, b) return KIND_ORDER[a.kind] < KIND_ORDER[b.kind] end)
		for i, g in ipairs(ordered) do
			if cx > right - px(40) then break end
			if i > 1 then text(font, "›", cx + px(1), y - px(10), px(10), "o", C.onSurfaceVariant); cx = cx + px(9) end
			cx = chip(cx, y - px(16), px(16), g.label, "member" .. i, function() playClick(); selectGroup(g.key); filter = "all" end,
				"Open " .. g.label, g.key == selectedKey, g.color, right - cx) + px(3)
		end
	else
		text(font, "Not in any listed group", left, y - px(10), px(8.5), "o", C.onSurfaceVariant)
	end
	y = y - px(22)
	-- the AI's own record of the unit
	local f = unitInfo and unitInfo.unit == focusUnit and unitInfo.fields or nil
	if f and f.missing then
		text(font, "The AI no longer has this unit.", left, y - px(9), px(8.5), "o", C.warn)
	elseif f then
		local parts = {}
		if f.task then parts[#parts + 1] = (f.fight and (f.task .. ":" .. f.fight) or f.task) end
		if f.controller and f.controller ~= "none" then parts[#parts + 1] = "controller " .. f.controller end
		if f.stance then parts[#parts + 1] = "stance " .. f.stance end
		if f.order and f.order ~= "none" then parts[#parts + 1] = "order " .. f.order end
		local act = activityName(tonumber(f.act))
		if act then parts[#parts + 1] = act .. (f.mode and f.mode ~= act and (" (mode " .. f.mode .. ")") or "")
		elseif f.mode then parts[#parts + 1] = "mode " .. f.mode .. (f.reason and (" (" .. f.reason .. ")") or "") end
		if f.external == "1" then parts[#parts + 1] = "externally controlled" end
		if f.escort then parts[#parts + 1] = "anti-air escort of battle group " .. f.escort end   -- D-509
		local line = table.concat(parts, " · ")
		text(font, fitText(font, line, px(8.5), right - left), left, y - px(9), px(8.5), "o", C.onSurface)
		register(left, y - px(12), right, y, "unitinfo", function() end, line)
		-- D-508: its own factors first, then its cohort's.
		drawWhy(factorText(factorList(f.pf, "P", factorList(f.uf, "U"))), left, right, y - px(14), "unitwhy", 1)
	else
		text(font, "Waiting for the AI's record of this unit...", left, y - px(9), px(8.5), "o", C.onSurfaceVariant)
	end
	return top - px(UNIT_CARD_H)
end

local function drawList(left, right, top, bottom)
	visible = filtered()
	local rowH = px(ROW_H)
	local rows = mathMax(1, mathFloor((top - bottom) / rowH))
	local maxScroll = mathMax(0, #visible - rows)
	listScroll = mathMax(0, mathMin(listScroll, maxScroll))
	register(left, bottom, right, top, "area", function() end, nil)
	if #visible == 0 then
		local msg = not snapshot and "Waiting for the AI's groups..." or "No groups of this kind right now."
		text(font, msg, (left + right) / 2, (top + bottom) / 2, px(9), "oc", C.onSurfaceVariant)
		return
	end
	local scrollW = maxScroll > 0 and px(4) or 0
	for i = 1, rows do
		local g = visible[i + listScroll]
		if not g then break end
		local y2 = top - (i - 1) * rowH
		local y1 = y2 - rowH + px(2)
		local id = "row:" .. g.key
		if g.key == selectedKey then roundRect(left, y1, right - scrollW - px(2), y2, px(4), C.primaryContainer) end
		stateLayer(left, y1, right - scrollW - px(2), y2, px(4), id)
		local cy = (y1 + y2) / 2
		roundRect(left + px(4), cy - px(4), left + px(12), cy + px(4), px(4), { g.color[1], g.color[2], g.color[3], 1 })
		local indent = (g.kind == "cohort" and g.parent) and px(8) or 0
		local tx = left + px(17) + indent
		icon(ICON[g.kind], tx, cy - px(6), tx + px(12), cy + px(6), C.onSurfaceVariant)
		tx = tx + px(15)
		local countText = tostring(#g.members)
		local badge = badgeOf(g)
		local rightEdge = right - scrollW - px(6)
		local bw = textWidth(font, badge, px(8)) + px(6)
		text(font, badge, rightEdge, cy - px(3), px(8), "or", C.onSurfaceVariant)
		local cw = textWidth(font2, countText, px(9))
		text(font2, countText, rightEdge - bw - px(4), cy - px(3.2), px(9), "or", C.onSurface)
		text(font2, fitText(font2, g.label, px(9), rightEdge - bw - cw - px(10) - tx), tx, cy - px(3.2), px(9), "o",
			g.key == selectedKey and C.primary or C.onSurface)
		register(left, y1, right - scrollW - px(2), y2, id, function()
			local now = Spring.GetTimer()
			if lastClick and lastClick[1] == g.key and Spring.DiffTimers(now, lastClick[2]) < DOUBLE_CLICK_SECONDS then
				goToGroup(g); lastClick = nil
			else
				playClick(); selectGroup(g.key); lastClick = { g.key, now }
			end
		end, KIND_HINT[g.kind] .. ". Click to select, double-click to fly there.", g.key)
	end
	if maxScroll > 0 then
		local trackH = top - bottom
		local thumbH = mathMax(px(16), trackH * rows / #visible)
		local t = listScroll / maxScroll
		local ty2 = top - (trackH - thumbH) * t
		roundRect(right - scrollW, bottom, right, top, px(2), C.surfaceHigh)
		roundRect(right - scrollW, ty2 - thumbH, right, ty2, px(2), C.outlineStrong)
	end
end

local function detailRows(g)
	local d = g.data
	if g.kind == "group" then
		local mix = string.format("%d short · %d peer · %d long · %d static · %d comm",
			d.threat.short, d.threat.peer, d.threat.long, d.threat.static, d.threat.commander)
		local act = g.screen and activityName(g.screen.activity) or nil
		return {
			{ "Activity", act or "-", (act == "withdraw" or act == "regroup") and C.warn or nil },
			{ "Order", d.order, d.order == "withdraw" and C.warn or nil },
			{ "Source", d.scripted and "script" or "group" },
			{ "Screen", d.screenStance }, { "Support", d.rearStance },
			{ "Screens", d.sizeTarget > 0 and string.format("%d / %d (max %d)", d.screens, d.sizeTarget, d.sizeMax) or d.screens,
				(d.sizeTarget > 0 and d.screens < d.sizeTarget) and C.warn or nil },
			{ "Support", d.rears },
			{ "Spread", string.format("%.2fx", d.spread) }, { "Separation", string.format("%d", d.separation) },
			{ "Stand firm", d.standFirm and "yes" or "no" },
			-- D-509: escorts with it / needed (the most it takes)
			{ "Anti-air", string.format("%d / %d (max %d)", #(d.escorts or {}), d.airNeed or 0, d.airCap or 0),
				(#(d.escorts or {}) < (d.airNeed or 0)) and C.warn or nil },
			{ "Order age", d.orderAge >= 0 and (d.orderAge .. " s") or "-" },
			{ "Hostile metal", string.format("%d", d.hostileMetal) }, { "Template", d.template ~= "" and d.template or "-" },
		}, mix
	elseif g.kind == "cohort" then
		local act = activityName(d.activity)
		return {
			{ "Activity", act or d.mode, (act == "withdraw" or act == "kite" or act == "regroup") and C.warn or nil },
			{ "Mode", d.mode }, { "Reason", d.reason },
			{ "Role", g.role or "free" }, { "Committed", d.committed and "yes" or "no" },
			{ "Own value", string.format("%d", d.own) }, { "Hostile value", string.format("%d", d.hostile) },
			{ "Advantage", string.format("%.2f", d.advantage), d.advantage < 0 and C.warn or C.ok },
			{ "Rush", d.rush and "yes" or "no" },
			{ "Radius", string.format("%d", d.radius) }, { "Target", d.target >= 0 and ("#" .. d.target) or "-" },
			{ "Joining", d.recruit >= 0 and ("cohort " .. d.recruit) or "-" },
		}, nil
	else
		return {
			{ "Type", d.fight }, { "Leader", d.leader >= 0 and ("#" .. d.leader) or "-" },
			{ "Power", string.format("%d", d.power) }, { "Members", #g.members },
			{ "Goal", string.format("%d, %d", d.x, d.z) },
		}, nil
	end
end

local function drawDetail(left, right, top)
	local g = selectedKey and snapshot and snapshot.byKey[selectedKey] or nil
	local y = top
	if not g then
		text(font2, "Details", left, y - px(10), px(9), "o", C.onSurfaceVariant)
		text(font, "Pick a group from the list, or a membership of the selected unit.", left, y - px(26), px(8.5), "o", C.onSurfaceVariant)
		return
	end
	roundRect(left, y - px(12), left + px(8), y - px(4), px(4), { g.color[1], g.color[2], g.color[3], 1 })
	text(font2, fitText(font2, g.label, px(10), right - left - px(150)), left + px(12), y - px(11), px(10), "o", C.onSurface)
	local bh = px(18)
	local bx2 = right
	labelButton(bx2 - px(60), y - bh + px(2), bx2, y + px(2), ICON.camera, "Go to", "goto", function() playClick(); goToGroup(g) end,
		"Fly the camera to the group (G, or double-click its row)")
	labelButton(bx2 - px(140), y - bh + px(2), bx2 - px(64), y + px(2), ICON.select, "Select", "selectunits", function() playClick(); selectUnits(g) end,
		"Select the group's units in the game (Enter)")
	y = y - px(24)
	text(font, fitText(font, KIND_HINT[g.kind], px(8), right - left), left, y - px(8), px(8), "o", C.onSurfaceVariant)
	y = y - px(16)
	local rows, extra = detailRows(g)
	y = fields(left, right, y - px(8), rows)
	y = drawWhy(whyOf(g), left, right, y, "detailwhy", 2)
	if extra then
		text(font, "Threat near the group: " .. extra, left, y - px(8), px(8.5), "o", C.onSurface)
		y = y - px(14)
	end
	local comp = composition(g, 3)
	text(font, fitText(font, "Units: " .. (comp ~= "" and comp or "none visible"), px(8.5), right - left), left, y - px(8), px(8.5), "o", C.onSurface)
	y = y - px(18)
	-- relations: parent and children
	local cx = left
	if g.parent then
		cx = chip(cx, y - px(16), px(16), "Part of " .. g.parent.label, "parent", function() playClick(); selectGroup(g.parent.key) end,
			"Open the battle group this cohort belongs to", false, g.parent.color, right - cx) + px(4)
	end
	for i, child in ipairs(g.children or {}) do
		if cx > right - px(40) then break end
		cx = chip(cx, y - px(16), px(16), child.label, "child" .. i, function() playClick(); selectGroup(child.key) end,
			"Open " .. child.label, false, child.color, right - cx) + px(4)
	end
end

local function drawBody(P, left, right, top, bottom)
	font, font2 = P.Fonts()
	hoverKey = P.hoverKey
	-- team stepper
	local y = top
	local th = px(20)
	if #teams == 0 then
		text(font, "No BARb AI is hosted on this machine.", left, y - px(14), px(9), "o", C.warn)
		text(font, "The monitor reads the AI's state file, so it works only where the AI runs.", left, y - px(28), px(8), "o", C.onSurfaceVariant)
		return
	end
	iconButton(left, y - th, th, nil, "teamPrev", function() playClick(); stepTeam(-1) end, "Previous BARb team", false, "<")
	iconButton(right - th, y - th, th, nil, "teamNext", function() playClick(); stepTeam(1) end, "Next BARb team", false, ">")
	local t = teamEntry(team)
	local cx1, cx2 = left + th + px(4), right - th - px(4)
	outlineRect(cx1, y - th, cx2, y, px(4), C.outlineStrong)
	if t then
		roundRect(cx1 + px(6), y - th * 0.5 - px(4), cx1 + px(14), y - th * 0.5 + px(4), px(2), t.color)
		local role = roleOf(t.id)
		local label = string.format("Team %d · %s%s", t.id, t.name, role and (" · " .. role) or "")
		text(font2, fitText(font2, label, px(9), cx2 - cx1 - px(24)), cx1 + px(20), y - th * 0.5 - px(3.2), px(9), "o", C.onSurface)
	end
	register(cx1, y - th, cx2, y, "teamLabel", function() playClick(); stepTeam(1) end, "The monitored AI. Click for the next one.")
	y = y - th - px(8)

	y = drawUnitCard(left, right, y)
	divider(left, right, y)
	y = y - px(6)

	-- filter chips with counts
	local n = counts()
	local cx = left
	for _, key in ipairs(FILTERS) do
		cx = chip(cx, y - px(17), px(17), FILTER_LABEL[key] .. " " .. n[key], "filter:" .. key, function()
			playClick(); filter = key; listScroll = 0
		end, "Show " .. string.lower(FILTER_LABEL[key]), filter == key) + px(4)
	end
	y = y - px(23)

	local footerH = px(16)
	local listBottom = bottom + footerH + px(DETAIL_H)
	drawList(left, right, y, listBottom)
	divider(left, right, listBottom - px(4))
	drawDetail(left, right, listBottom - px(10))

	-- footer: freshness and totals
	local msg, col
	if status ~= "" then msg, col = status, C.warn
	elseif not snapshot then msg, col = "Asking the AI for its groups (it needs this build of BARb)...", C.onSurfaceVariant
	else
		local age = (spGetGameFrame() - snapshot.frame) / 30
		msg = string.format("Updated %ds ago · %d groups · %d units in groups", mathMax(0, mathFloor(age)), #snapshot.groups, snapshot.unitCount)
		col = age > STALE_SECONDS and C.warn or C.onSurfaceVariant
	end
	text(font, fitText(font, msg, px(8), right - left), left, bottom + px(3), px(8), "o", col)
end

-- ---------------------------------------------------------------- world drawing

local function membersOf(key)
	local g = key and snapshot and snapshot.byKey[key] or nil
	return g
end

local function ring(id, color, alpha, radiusScale)
	local x, y, z = spGetUnitPosition(id)
	if not x then return false end
	local r = (spGetUnitRadius(id) or 20) * (radiusScale or 1.1)
	glColor(color[1], color[2], color[3], alpha)
	gl.DrawGroundCircle(x, y, z, r, 24)
	return true
end

local function drawGlow(g, pulse)
	local col = g.color
	local drawn = 0
	gl.DepthTest(GL.LEQUAL)
	gl.PolygonOffset(-10, -10)
	gl.Blending(GL.SRC_ALPHA, GL.ONE)
	glColor(col[1], col[2], col[3], GLOW_ALPHA * (0.55 + 0.45 * pulse))
	for _, id in ipairs(g.members) do
		if drawn >= MAX_GLOW_MODELS then break end
		if spIsUnitVisible == nil or spIsUnitVisible(id, 64, false) then
			gl.Unit(id, true)
			drawn = drawn + 1
		end
	end
	gl.Blending(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA)
	gl.PolygonOffset(false)
	gl.DepthTest(false)
end

local function drawRings(g, alpha, width, budget)
	gl.LineWidth(width)
	for _, id in ipairs(g.members) do
		if budget <= 0 then break end
		if ring(id, g.color, alpha) then budget = budget - 1 end
	end
	gl.LineWidth(1)
	return budget
end

local function drawCentre(g, pulse)
	local x, z, n = groupCentre(g)
	if not x or n == 0 then return end
	local y = spGetGroundHeight(x, z)
	local col = g.color
	gl.LineWidth(2)
	glColor(col[1], col[2], col[3], 0.35)
	gl.BeginEnd(GL.LINES, function()
		for _, id in ipairs(g.members) do
			local ux, uy, uz = spGetUnitPosition(id)
			if ux then gl.Vertex(x, y + 4, z); gl.Vertex(ux, uy + 4, uz) end
		end
	end)
	glColor(col[1], col[2], col[3], 0.6 + 0.4 * pulse)
	gl.DrawGroundCircle(x, y, z, 18 + 6 * pulse, 4)
	local d = g.data
	if g.kind == "group" and d.facingSet and (d.fx ~= 0 or d.fz ~= 0) then
		local len = 220
		local ex, ez = x + d.fx * len, z + d.fz * len
		gl.LineWidth(3)
		gl.BeginEnd(GL.LINES, function()
			gl.Vertex(x, y + 6, z); gl.Vertex(ex, spGetGroundHeight(ex, ez) + 6, ez)
			local hx, hz = -d.fz * 30, d.fx * 30
			local bx, bz = ex - d.fx * 40, ez - d.fz * 40
			gl.Vertex(ex, spGetGroundHeight(ex, ez) + 6, ez); gl.Vertex(bx + hx, spGetGroundHeight(bx, bz) + 6, bz + hz)
			gl.Vertex(ex, spGetGroundHeight(ex, ez) + 6, ez); gl.Vertex(bx - hx, spGetGroundHeight(bx, bz) + 6, bz - hz)
		end)
	end
	gl.LineWidth(1)
end

function widget:DrawWorld()
	if not open or not snapshot then return end
	-- wall-clock pulse, so it keeps breathing while the game is paused
	local pulse = 0.5 + 0.5 * mathSin(Spring.DiffTimers(Spring.GetTimer(), startTimer) * PULSE_SPEED)
	local budget = MAX_RINGS
	if showAll then
		for _, g in ipairs(visible) do
			if budget <= 0 then break end
			if g.key ~= selectedKey then budget = drawRings(g, 0.45, 1.5, budget) end
		end
	end
	local hover = hoverKey ~= selectedKey and membersOf(hoverKey) or nil
	if hover then budget = drawRings(hover, 0.7, 2, budget) end
	local sel = membersOf(selectedKey)
	if sel then
		drawGlow(sel, pulse)
		drawRings(sel, 0.75 + 0.25 * pulse, 2.5, budget)
		drawCentre(sel, pulse)
	end
	glColor(1, 1, 1, 1)
end

local function drawWorldLabel()
	local g = membersOf(selectedKey)
	if not g then return end
	local x, z, n = groupCentre(g)
	if not x or n == 0 then return end
	local sx, sy, sz = spWorldToScreenCoords(x, spGetGroundHeight(x, z) + 40, z)
	if not sx or sz > 1 or sx < 0 or sy < 0 or sx > vsx or sy > vsy then return end
	local label = g.label .. "  (" .. #g.members .. ")"
	local size = px(10)
	local w = textWidth(font2, label, size) + px(12)
	roundRect(sx - w / 2, sy, sx + w / 2, sy + px(16), px(4), { 0, 0, 0, 0.55 })
	text(font2, label, sx, sy + px(4), size, "oc", { g.color[1], g.color[2], g.color[3], 1 })
end

-- ---------------------------------------------------------------- selection and polling

local function focusFromSelection()
	local sel = spGetSelectedUnits() or {}
	local id = sel[1]
	if not id then focusUnit = nil; return end
	local owner = spGetUnitTeam(id)
	if owner and owner ~= team and mayMonitor(owner) then
		for _, t in ipairs(teams) do if t.id == owner then setTeam(owner) end end
	end
	focusUnit = (owner == team) and id or nil
end

function widget:SelectionChanged()
	if open then focusFromSelection() end
end

-- Every state value the hub delivers; only the monitored team's two keys matter.
local function onMessage(fromTeam, line, key)
	if fromTeam ~= team then return nil end
	if not key and line then key = line:match("^barb|(%a+)|") end
	if key == "groups" or key == "unitinfo" or key == "monitorcodes" then applyState(key, line) end
	return nil
end

local function ensurePanel()
	if panel then return panel end
	local h = hub()
	if not h then return nil end
	panel = h.NewPanel({
		id = PANEL_ID, order = PANEL_ORDER, widget = widget, title = "Unit monitor", icon = ICON.launcher, fallback = "U",
		width = WIN_W, height = WIN_H, shortcut = "Ctrl+Alt+M",
		tooltipClosed = "BARb unit monitor: groups, formations, what a unit belongs to (Ctrl+Alt+M)",
		tooltipOpen = "Close the unit monitor (Ctrl+Alt+M)",
		onOpen = onOpen,
		headerButtons = function(P, bx, by, bs)
			P.iconButton(bx, by, bs, ICON.all, "showall", function() showAll = not showAll end,
				"Ring every listed group's units in its colour on the battlefield", showAll, "*")
		end,
		draw = drawBody,
	})
	bindPanel(panel)
	if not subscribed then
		subscribed = true
		h.OnMessage(OWNER, onMessage)
	end
	local wasOpen = saved and saved.panel and saved.panel.open
	if saved and saved.panel then
		panel.SetConfig({ open = false, offX = saved.panel.offX, offY = saved.panel.offY })
	end
	if wasOpen then panel.SetOpen(true) end
	return panel
end

function widget:Update()
	ensurePanel()
	if not open then return end
	local now = Spring.GetTimer()
	if lastPoll and Spring.DiffTimers(now, lastPoll) < POLL_SECONDS then return end
	lastPoll = now
	refreshTeams()
	focusFromSelection()
	if not team then return end
	status = ""
	local want = focusUnit or -1
	if want ~= focusSent then
		send(team, "monitor|" .. team .. "|unit|" .. want)
		focusSent = want
	end
	if selectedKey and snapshot and not snapshot.byKey[selectedKey] then
		-- the group dissolved or merged
		selectedKey = nil
	end
end

-- ---------------------------------------------------------------- lifecycle and input

function widget:Initialize()
	WG.barbmonitor = {
		version = 1,
		IsOpen = function() return open end,
		SetOpen = function(v) local p = ensurePanel(); if p then p.SetOpen(v) end end,
		ButtonRect = function(id) return panel and panel.ButtonRect(id) or nil end,
		MousePress = function(x, y, b) return widget:MousePress(x, y, b) end,
		MouseRelease = function(x, y, b) return widget:MouseRelease(x, y, b) end,
		MouseMove = function(x, y, dx, dy, b) return widget:MouseMove(x, y, dx, dy, b) end,
	}
end

function widget:Shutdown()
	local h = hub()
	if h then
		if open and team then h.Release(OWNER, team, "monitor") end
		h.Unsubscribe(OWNER)
	end
	if panel then panel.Remove() end
	WG.barbmonitor = nil
end

function widget:ViewResize(newX, newY)
	vsx, vsy = newX, newY
end

function widget:DrawScreen()
	local p = ensurePanel()
	if not p then return end
	if open then drawWorldLabel() end
	p.Draw()
end

function widget:IsAbove(mx, my) return panel ~= nil and panel.IsAbove(mx, my) end
function widget:GetTooltip(mx, my) return panel and panel.GetTooltip(mx, my) or nil end
function widget:MousePress(mx, my, mb) return panel ~= nil and panel.MousePress(mx, my, mb) end
function widget:MouseMove(mx, my) if panel then panel.MouseMove(mx, my) end end
function widget:MouseRelease(mx, my, mb) if panel then panel.MouseRelease(mx, my, mb) end; return false end

local function overWindow(mx, my)
	return open and panel ~= nil and mx >= panel.win.x1 and mx <= panel.win.x2 and my >= panel.win.y1 and my <= panel.win.y2
end

function widget:MouseWheel(up, value)
	local mx, my = spGetMouseState()
	if not overWindow(mx, my) then return false end
	listScroll = listScroll + (up and -1 or 1)
	return true
end

local function moveSelection(d)
	if #visible == 0 then return end
	local index = 0
	for i, g in ipairs(visible) do if g.key == selectedKey then index = i end end
	index = mathMax(1, mathMin(#visible, index + d))
	selectedKey = visible[index].key
	local rows = mathMax(1, mathFloor((WIN_H - DETAIL_H - UNIT_CARD_H - 120) / ROW_H))
	if index <= listScroll then listScroll = index - 1 elseif index > listScroll + rows then listScroll = index - rows end
end

function widget:KeyPress(key, mods, isRepeat)
	if key == 109 and mods.ctrl and mods.alt and not isRepeat then   -- m
		local p = ensurePanel(); if p then p.Toggle() end
		return true
	end
	if not open then return false end
	local mx, my = spGetMouseState()
	if not overWindow(mx, my) then return false end
	if key == 27 then setOpen(false); return true end                -- escape
	if key == 273 then moveSelection(-1); return true end            -- up
	if key == 274 then moveSelection(1); return true end             -- down
	local g = membersOf(selectedKey)
	if g and (key == 13 or key == 271) then selectUnits(g); return true end   -- enter
	if g and key == 103 and not isRepeat then goToGroup(g); return true end   -- g
	return false
end

function widget:TextCommand(cmd)
	local arg = cmd:match("^barbmonitor%s*(%a*)$")
	if not arg then return false end
	local p = ensurePanel()
	if not p then Spring.Echo("[BARb unit monitor] needs the BARb team link widget"); return true end
	if arg == "off" or arg == "close" then p.SetOpen(false)
	elseif arg == "on" or arg == "open" then p.SetOpen(true)
	else p.Toggle() end
	return true
end

function widget:GetConfigData()
	return { panel = panel and panel.GetConfig() or (saved and saved.panel), filter = filter, showAll = showAll }
end

function widget:SetConfigData(data)
	if type(data) ~= "table" then return end
	saved = data
	if data.filter and FILTER_LABEL[data.filter] then filter = data.filter end
	showAll = data.showAll == true
end

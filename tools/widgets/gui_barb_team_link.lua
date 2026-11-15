-- BARb team link (the hub)
--
-- The allied BARb AIs' control window and the shared services of the BARb
-- widgets (D-498, widget-decomposition-proposal.md). Opened from the first
-- tile of the BARb launcher column beside the player list.
--
-- Inside the window: buttons that open the other BARb windows, then the
-- selector that every tab follows, always visible: the ally-team chips and the
-- allied AIs as a list (colour, name, role, side). Under it a tab bar (D-506,
-- widget-ux-overhaul-proposal.md):
--   AI          the selected AI's details, a role grid that switches its role at
--               runtime, the aggression offset, query and query-all, go to, and
--               the event log (this widget);
--   Lanes       scope, layers, lane list, legend, inspect (BARb plans);
--   Blueprints  the planned bases (BARb plans).
-- Another widget adds a tab with WG.barb.AddTab; it draws with the kit this
-- window hands it, so its buttons behave like the window's own. Every button
-- has an icon from the game's own art.
--
-- The other overlays live in their own widgets:
--   BARb map              gui_barb_map.lua            Terrain and Landmarks (window and tile)
--   BARb plans            gui_barb_plans.lua          the Lanes and Blueprints tabs (no window)
--   BARb unit monitor     gui_barb_unit_monitor.lua   groups and what a unit belongs to (window and tile)
-- They need this widget: it publishes WG.barb, the shared services:
--   * one reader of the AI state files, delivering each changed value (and
--     each ai.CallUI message) to every subscriber;
--   * the hosted BARb teams, the permission rules (CR-008) and the selected
--     AI and ally team, with a change callback;
--   * commands to an AI, and counted leases on AI feeds;
--   * the launcher dock and a panel kit (window shell, drag, header, tile,
--     palette, buttons, chips), so every window looks and behaves the same;
--   * the hand-off of the settings the single widget saved before the split.
-- WG.barblink stays as a facade over all four widgets for tools/playtest.
--
-- Install: copy into <BAR data dir>/LuaUI/Widgets/ and enable it (F11),
-- together with the BARb widgets you want.
-- Open/close: the tile, /barblink or Ctrl+Alt+B (the AI tab); Ctrl+Alt+P or
-- /barbplans opens the Lanes tab. Escape closes it while the mouse is over it.
--
-- Both directions only work on the machine that runs the AIs (the host),
-- playing or spectating:
--   AI -> widget   a state file the AI rewrites a short while after changes (D-300):
--                  <writeDir>/LuaUI/Config/BARb/state/team<N>.txt, polled here once
--                  a second. Each record carries the old "barb|<topic>|<team>|<allyTeam>|<payload>"
--                  line. BAR's user-widget sandbox (BAR PRs #9547/#9658/#9660) no longer
--                  lets a user widget receive RecvSkirmishAIMessage (KI-617).
--   widget -> AI   Spring.SendSkirmishAIMessage(teamId, "barb|<command>|<teamId>|...")
-- Commands carry the target team id and the AI ignores any other; the widget
-- never broadcasts, so hosting two ally teams locally cannot cross-steer them.
-- Wire formats: data/script/src/systems/presentation/widget_link.as and commands.as.
-- Topics shown here: roster, aggression, role, orphan, donation, ferry, spam, seaassist.

function widget:GetInfo()
	return {
		name    = "BARb team link",
		desc    = "Allied BARb AIs: roster, roles, aggression, events; the shared services of the BARb widgets (host only)",
		author  = "s3k-CircuitAI",
		date    = "2026-09-25",
		layer   = -1,   -- before the BARb client widgets, so WG.barb exists when they start
		enabled = true,
	}
end

-- ---------------------------------------------------------------- constants

local ROLES = { "FRONT", "AIR", "TECH", "SEA", "SUPPORT", "TACTICAL" }
local ROLE_HINT = {
	FRONT = "Land army and forward pressure",
	AIR = "Aircraft plants, bomber waves",
	TECH = "Economy first, T2/T3 race",
	SEA = "Naval production",
	SUPPORT = "Economic support",
	TACTICAL = "Mobile builders, hover opening",
}
-- the game's own art (VFS paths); a missing file falls back to text only
local ICON = {
	FRONT    = "icons/bot_t2.png",
	AIR      = "icons/air.png",
	TECH     = "icons/fusion.png",
	SEA      = "icons/ship.png",
	SUPPORT  = "icons/worker.png",
	TACTICAL = "icons/hover.png",
	ai       = "LuaUI/Images/advplayerslist/cpu.dds",
	team     = "LuaUI/Images/advplayerslist/ally.dds",
	query    = "LuaUI/Images/advplayerslist/ping.dds",
	queryall = "icons/radar_t2.png",
	overlay  = "icons/eye.png",
	close    = "LuaUI/Images/advplayerslist/cross.dds",
	camera     = "LuaUI/Images/advplayerslist/camera.dds",
	lead     = "LuaUI/Images/advplayerslist/indicator.dds",
}
local MAX_EVENTS = 120
local QUERY_INTERVAL_FRAMES = 1800
local WIN_W, WIN_H = 340, 500   -- unscaled px: windows row, roster, tab bar, the tab (D-498, D-506)
local LAUNCHER = 26             -- unscaled px

local C = {
	onSurface        = { 0.93, 0.93, 0.93, 1 },
	onSurfaceVariant = { 0.66, 0.66, 0.68, 1 },
	outline          = { 1, 1, 1, 0.12 },
	outlineStrong    = { 1, 1, 1, 0.28 },
	primary          = { 1, 0.9, 0.66, 1 },
	primaryContainer = { 1, 0.9, 0.66, 0.2 },
	surface          = { 0.07, 0.07, 0.08, 0.93 },
	surfaceHigh      = { 1, 1, 1, 0.06 },
	surfaceMenu      = { 0.12, 0.12, 0.13, 0.98 },
	hoverLayer       = { 1, 1, 1, 0.08 },
	pressLayer       = { 1, 1, 1, 0.14 },
	ok               = { 0.55, 0.85, 0.55, 1 },
	warn             = { 1, 0.75, 0.4, 1 },
	error            = { 1, 0.5, 0.5, 1 },
}
local SOUND_CLICK = "LuaUI/Sounds/buildbar_click.wav"

-- ---------------------------------------------------------------- engine locals

local glColor, glRect, glText, glTexture, glTexRect = gl.Color, gl.Rect, gl.Text, gl.Texture, gl.TexRect
local spEcho, spGetGameFrame, spGetMouseState = Spring.Echo, Spring.GetGameFrame, Spring.GetMouseState
local spGetTeamList, spGetTeamInfo, spGetAIInfo, spGetTeamColor = Spring.GetTeamList, Spring.GetTeamInfo, Spring.GetAIInfo, Spring.GetTeamColor
local spGetMyTeamID, spAreTeamsAllied, spGetSpectatingState = Spring.GetMyTeamID, Spring.AreTeamsAllied, Spring.GetSpectatingState
local spSendSkirmishAIMessage, spPlaySoundFile = Spring.SendSkirmishAIMessage, Spring.PlaySoundFile
local spGetMyPlayerID, spGetTeamUnits, spGetUnitDefID = Spring.GetMyPlayerID, Spring.GetTeamUnits, Spring.GetUnitDefID
local spGetUnitPosition, spSetCameraTarget, spGetTeamStartPosition = Spring.GetUnitPosition, Spring.SetCameraTarget, Spring.GetTeamStartPosition
local mathFloor, mathMax, mathMin = math.floor, math.max, math.min

-- Only teams allied with the local player are listed, drawn and commanded
-- (CR-008): a host playing in a game must not see the enemy BARb's plan or
-- steer its builders. A spectator sees every AI. Commanding needs the AI to be
-- hosted by this client (it runs here, and only here does the message reach
-- it): a spectating host commands every AI it hosts (an AI-only game, the
-- owner's usual set-up; before this, every role button was greyed out there),
-- a playing host only its allies.
local function isSpectator() return spGetSpectatingState() == true end
local function isPermittedTeam(teamId)
	if isSpectator() then return true end
	return spAreTeamsAllied(teamId, spGetMyTeamID()) == true
end
local function hostedHere(teamId)
	local _, _, host = spGetAIInfo(teamId)
	return host ~= nil and host == spGetMyPlayerID()
end
local function mayCommand(teamId)
	if not hostedHere(teamId) then return false end
	if isSpectator() then return true end
	return spAreTeamsAllied(teamId, spGetMyTeamID()) == true
end

-- ---------------------------------------------------------------- state

local vsx, vsy = Spring.GetViewGeometry()
local scale = 1
local RectRound, RectRoundOutline, UiElement
local font, font2
local hasFlowUI = false

local open = false               -- the window is shown
local firstRun = true            -- no saved config yet (owner: the window starts closed; the launcher shows it is there)
local offX, offY = 0, 0          -- the user's drag, from the default place (scaled px)
local launcher = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }
local win = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }
local dragging = nil             -- { mx, my, offX, offY } while the header is dragged

local hit = {}                   -- rebuilt every draw: { x1, y1, x2, y2, id, action, tooltip }
local aggressionDrag
local hoverId, pressedId = nil, nil

local ais = {}                   -- teamId -> { teamId, name, color, allyTeam, roster, lastReply, replyKind }
local aiOrder = {}
local allyTeams = {}
local selectedAlly, selected = nil, nil
local events = {}
local eventScroll, listScroll = 0, 0
local lastQueryFrame = -1
local firstAnnounceFrame = nil
local stateFiles = {} -- D-300 AI state file reader; initialized with the message code
local hookAIMessages, unhookAIMessages   -- defined with the message code below
local lastRowClick = nil                 -- a row's last click (double-click flies the camera)

-- ---------------------------------------------------------------- helpers

local function split(s, sep)
	local out = {}
	for piece in string.gmatch(s .. sep, "([^" .. sep .. "]*)" .. sep) do out[#out + 1] = piece end
	return out
end

local function frameToClock(f)
	local s = mathFloor((f or 0) / 30)
	return string.format("%d:%02d", mathFloor(s / 60), s % 60)
end

local function addEvent(text, kind)
	events[#events + 1] = { frame = spGetGameFrame(), text = text, kind = kind or "info" }
	if #events > MAX_EVENTS then table.remove(events, 1) end
end

local function aisOfAlly(allyTeam)
	local out = {}
	for _, id in ipairs(aiOrder) do
		if ais[id].allyTeam == allyTeam then out[#out + 1] = id end
	end
	return out
end

local function refreshTeams()
    local live={}
	for _, teamId in ipairs(spGetTeamList() or {}) do
		local _, _, isDead, isAI, _, allyTeam = spGetTeamInfo(teamId)
		if isAI and not isDead and isPermittedTeam(teamId) then
            live[teamId]=true
			local _, name = spGetAIInfo(teamId)
			local r, g, b = spGetTeamColor(teamId)
			local e = ais[teamId] or { teamId = teamId }
			e.name = name or ("AI " .. teamId)
			e.allyTeam = allyTeam or 0
			e.color = { r or 1, g or 1, b or 1, 1 }
			ais[teamId] = e
		end
	end
    for id in pairs(ais) do if not live[id] then ais[id]=nil end end
	aiOrder = {}
	for id in pairs(ais) do aiOrder[#aiOrder + 1] = id end
	table.sort(aiOrder, function(a, b)
		local ea, eb = ais[a], ais[b]
		if ea.allyTeam ~= eb.allyTeam then return ea.allyTeam < eb.allyTeam end
		return a < b
	end)
	allyTeams = {}
	local seen = {}
	for _, id in ipairs(aiOrder) do
		local at = ais[id].allyTeam
		if not seen[at] then seen[at] = true; allyTeams[#allyTeams + 1] = at end
	end
	table.sort(allyTeams)
	if selectedAlly == nil or not seen[selectedAlly] then
		local _, _, _, _, _, myAlly = spGetTeamInfo(spGetMyTeamID())
		selectedAlly = seen[myAlly] and myAlly or allyTeams[1]
	end
	if selected == nil or not ais[selected] or ais[selected].allyTeam ~= selectedAlly then
		selected = aisOfAlly(selectedAlly)[1]
	end
end

local function parseRoster(line)
	local p = split(line, "|")
	if p[1] ~= "roster" then return nil end
	return {
		teamId = tonumber(p[3]), aiId = tonumber(p[4]), role = p[5], side = p[6], factory = p[7],
		x = tonumber(p[8]), z = tonumber(p[9]), landLocked = (p[10] == "1"), spot = tonumber(p[11]), leader = (p[12] == "1"),
	}
end

local function send(teamId, msg)
	local ok = spSendSkirmishAIMessage(teamId, msg)
	if not ok then addEvent(string.format("Team %d: no local AI received the command (not hosted here?)", teamId), "warn") end
	return ok
end

local function queryAll()
	for _, id in ipairs(aiOrder) do send(id, "barb|query|" .. id) end
	lastQueryFrame = spGetGameFrame()
end

local function playClick() spPlaySoundFile(SOUND_CLICK, 0.5, "ui") end

-- a role switch request: the role grid's buttons and WG.barblink.SetRole
local function requestRole(teamId, role)
	if not mayCommand(teamId) then
		addEvent(string.format("Team %d: switch to %s refused here (this AI is not hosted by you)", teamId, role), "warn")
		return false
	end
	addEvent(string.format("Team %d: switch to %s requested", teamId, role), "info")
	return send(teamId, "barb|setrole|" .. teamId .. "|" .. role)
end

local function requestAggression(teamId, value)
    if not mayCommand(teamId) or type(value) ~= "number" or value ~= value
        or value < -1 or value > 1 then return false end
    -- Release-to-send: dragging is local preview, one targeted message at the
    -- end. The AI reply owns the displayed value; there is no polling/relay.
    return send(teamId, string.format("barb|aggression|%d|%.4f", teamId, value))
end

local function dragAggression(mx)
    if aggressionDrag then
        aggressionDrag.value = mathMax(-1, mathMin(1,
            2 * (mx - aggressionDrag.x1) / (aggressionDrag.x2 - aggressionDrag.x1) - 1))
    end
end

-- Fly the camera to an AI: its commander, else its factory nearest its start
-- (the owner's request). Only when asked: the widget never moves the camera
-- by itself.
local commanderDef, factoryDef = {}, {}
for id, ud in pairs(UnitDefs) do
	if ud.customParams and ud.customParams.iscommander then commanderDef[id] = true end
	if ud.isFactory then factoryDef[id] = true end
end
local function focusUnit(teamId)
	local units = spGetTeamUnits(teamId)
	if not units then return nil end
	local e = ais[teamId]
	local bx, bz = e and e.roster and e.roster.x, e and e.roster and e.roster.z
	if not bx then local sx, _, sz = spGetTeamStartPosition(teamId); bx, bz = sx, sz end
	bx, bz = bx or 0, bz or 0
	local best, bestD, bestKind = nil, math.huge, nil
	for _, uid in ipairs(units) do
		local d = spGetUnitDefID(uid)
		local kind = (d and commanderDef[d]) and "commander" or ((d and factoryDef[d]) and "factory" or nil)
		if kind and (bestKind ~= "commander" or kind == "commander") then
			local x, _, z = spGetUnitPosition(uid)
			if x then
				local dist = (x - bx) * (x - bx) + (z - bz) * (z - bz)
				if (kind == "commander" and bestKind ~= "commander") or dist < bestD then
					best, bestD, bestKind = uid, dist, kind
				end
			end
		end
	end
	return best, bestKind
end
local function goTo(teamId)
	local uid, kind = focusUnit(teamId)
	if not uid then
		addEvent(string.format("Team %d: no commander or factory in view", teamId), "warn")
		return false
	end
	local x, y, z = spGetUnitPosition(uid)
	spSetCameraTarget(x, y, z, 0.4)
	local name = UnitDefs[spGetUnitDefID(uid)] and UnitDefs[spGetUnitDefID(uid)].translatedHumanName or kind
	addEvent(string.format("Camera: team %d's %s (%s)", teamId, kind, name or "?"), "info")
	return true, uid, kind
end

local function setOpen(v)
	open = v
	if v then refreshTeams() end
	if not v and WG.guishader then WG.guishader.RemoveRect("barblink") end
end


-- ---------------------------------------------------------------- shared services (WG.barb)
-- D-498. Everything the BARb widgets share lives here once: message
-- subscribers, the selection, the launcher dock, counted leases and the
-- settings saved before the split. Kept in one table: Lua 5.1 limits the
-- main chunk's locals. Cost: listeners run only when a state value changes or
-- an ai.CallUI message arrives; leases renew once per their period; the dock
-- is a sort of at most a handful of panels when one registers.
local svc = {
	listeners = {},     -- array of {owner, fn}: fn(team, line, key) on every changed state value or message
	selectFns = {},     -- array of {owner, fn}: fn(selectedTeam, selectedAlly) when the selection changes
	panels = {},        -- dock: id -> {id, order, isAbove}
	leases = {},        -- "team|topic" -> {owners = {owner = true}, renew = seconds, last = timer}
	legacy = {},        -- section -> the table the single widget saved, until a client takes it
	-- D-506 (widget-ux-overhaul-proposal.md): tabs other widgets draw in this
	-- window under the AI selector. tabs: array of {id, title, order, owner,
	-- draw(K, left, right, top, bottom), onWheel(up), actions = {id = fn}},
	-- sorted by order; activeTab: "ai" (this widget's own) or a tab id.
	tabs = {},
	activeTab = "ai",
}

function svc.findTab(id)
	for _, t in ipairs(svc.tabs) do if t.id == id then return t end end
	return nil
end

-- Adds or replaces a tab; O(T log T) for T tabs, once per registration.
function svc.addTab(spec)
	if type(spec) ~= "table" or type(spec.id) ~= "string" or spec.id == "ai" or type(spec.draw) ~= "function" then return false end
	for i = #svc.tabs, 1, -1 do if svc.tabs[i].id == spec.id then table.remove(svc.tabs, i) end end
	svc.tabs[#svc.tabs + 1] = spec
	-- the tab shown when the game was saved, restored once its widget registers it
	if svc.savedTab == spec.id then svc.activeTab = spec.id; svc.savedTab = nil end
	table.sort(svc.tabs, function(a, b)
		local oa, ob = a.order or 50, b.order or 50
		if oa ~= ob then return oa < ob end
		return a.id < b.id
	end)
	return true
end

function svc.removeTabs(owner, id)
	for i = #svc.tabs, 1, -1 do
		local t = svc.tabs[i]
		if (id ~= nil and t.id == id) or (id == nil and owner ~= nil and t.owner == owner) then table.remove(svc.tabs, i) end
	end
	if svc.activeTab ~= "ai" and not svc.findTab(svc.activeTab) then svc.activeTab = "ai" end
end
local API_VERSION = 1
local HUB_DOCK_ID, HUB_DOCK_ORDER = "hub", 10

function svc.dispatch(team, line, key)
	local ack = nil
	for _, l in ipairs(svc.listeners) do
		local ok, result = pcall(l.fn, team, line, key)
		if not ok then spEcho("[BARb link] listener " .. tostring(l.owner) .. " error: " .. tostring(result))
		elseif result ~= nil and ack == nil then ack = result end
	end
	return ack
end

function svc.notifySelect()
	for _, l in ipairs(svc.selectFns) do
		local ok, err = pcall(l.fn, selected, selectedAlly)
		if not ok then spEcho("[BARb link] selection listener " .. tostring(l.owner) .. " error: " .. tostring(err)) end
	end
end

local function removeOwner(list, owner)
	for i = #list, 1, -1 do if list[i].owner == owner then table.remove(list, i) end end
end

-- 0-based slot of a panel in the launcher column, by order then id.
function svc.dockSlot(id)
	local mine = svc.panels[id]
	if not mine then return 0 end
	local n = 0
	for otherId, p in pairs(svc.panels) do
		if p.order < mine.order or (p.order == mine.order and otherId < id) then n = n + 1 end
	end
	return n
end

-- The tile of a docked panel: beneath the player list's top-left corner, one
-- tile and gap per slot; without a player list, down from the old place.
function svc.dockRect(id)
	local list = WG.advplayerlist_api and WG.advplayerlist_api.GetPosition and WG.advplayerlist_api.GetPosition()
	local ls = mathFloor(LAUNCHER * scale)
	local gap = mathFloor(4 * scale)
	local slot = svc.dockSlot(id)
	local ax, ay
	if list and list[1] then
		ax, ay = list[2] - gap, list[1] - ls - slot * (ls + gap)
	else
		ax, ay = vsx - gap, mathFloor(220 * scale) - slot * (ls + gap)
	end
	return ax - ls, ay, ax, ay + ls, gap
end

function svc.overAnyPanel(mx, my)
	for _, p in pairs(svc.panels) do
		if p.isAbove and p.isAbove(mx, my) then return true end
	end
	return false
end

-- Counted leases: the first holder sends "on", renewals go out every `renew`
-- seconds while anyone holds it, the last release sends "off".
function svc.lease(owner, team, topic, renew)
	if not mayCommand(team) then return false end
	local key = team .. "|" .. topic
	local l = svc.leases[key]
	if not l then
		l = { owners = {}, renew = renew or 15, team = team, topic = topic }
		svc.leases[key] = l
	end
	local first = next(l.owners) == nil
	l.owners[owner] = true
	if first then
		spSendSkirmishAIMessage(team, "barb|" .. topic .. "|" .. team .. "|on")
		l.last = Spring.GetTimer()
	end
	return true
end

function svc.release(owner, team, topic)
	local key = team .. "|" .. topic
	local l = svc.leases[key]
	if not l or not l.owners[owner] then return end
	l.owners[owner] = nil
	if next(l.owners) == nil then
		svc.leases[key] = nil
		if mayCommand(team) then spSendSkirmishAIMessage(team, "barb|" .. topic .. "|" .. team .. "|off") end
	end
end

function svc.renewLeases()
	local now = Spring.GetTimer()
	for _, l in pairs(svc.leases) do
		if Spring.DiffTimers(now, l.last) >= l.renew and mayCommand(l.team) then
			spSendSkirmishAIMessage(l.team, "barb|" .. l.topic .. "|" .. l.team .. "|on")
			l.last = now
		end
	end
end

-- ---------------------------------------------------------------- panel kit
-- One window shell for every BARb window: a docked tile, a window to its
-- left with a 24 px header (drag handle, title, actions, close), the shared
-- palette and controls, hover and press states, tooltips, a saved offset.
-- Each widget owns its panel object and forwards its input callins to it.
local kit = {}
do
	local function flowDraw() return WG.FlowUI and WG.FlowUI.Draw or nil end
	local function fonts()
		if WG.fonts then return WG.fonts.getFont(), WG.fonts.getFont(2) end
		return nil, nil
	end
	local iconOk = {}

	function kit.New(spec)
		local P = { open = false, offX = 0, offY = 0, spec = spec, hoverKey = nil,
			tile = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }, win = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }, C = C, ICON = ICON }
		local hit, hoverId, pressedId, dragging = {}, nil, nil, nil
		local font, font2 = nil, nil

		local function px(v) return mathFloor(v * scale + 0.5) end
		local function inside(x, y, x1, y1, x2, y2) return x >= x1 and x <= x2 and y >= y1 and y <= y2 end
		local function roundRect(x1, y1, x2, y2, cs, color)
			local F = flowDraw()
			if F then F.RectRound(x1, y1, x2, y2, cs, 1, 1, 1, 1, color, color)
			else glColor(color); glRect(x1, y1, x2, y2) end
		end
		local function outlineRect(x1, y1, x2, y2, cs, color)
			local F = flowDraw()
			if F then F.RectRoundOutline(x1, y1, x2, y2, cs, mathMax(1, px(1)), 1, 1, 1, 1, color, color)
			else
				glColor(color)
				glRect(x1, y1, x2, y1 + 1); glRect(x1, y2 - 1, x2, y2); glRect(x1, y1, x1 + 1, y2); glRect(x2 - 1, y1, x2, y2)
			end
		end
		local function text(f, s, x, y, size, opts, color)
			if f then
				f:Begin()
				f:SetTextColor(color[1], color[2], color[3], color[4] or 1)
				f:SetOutlineColor(0, 0, 0, 0.6)
				f:Print(s, x, y, size, opts or "o")
				f:End()
			else
				glColor(color); glText(s, x, y, size, opts or "o")
			end
		end
		local function textWidth(f, s, size)
			if f then return f:GetTextWidth(s) * size end
			return gl.GetTextWidth(s) * size
		end
		local function fitText(f, s, size, maxW)
			local out = s
			while textWidth(f, out, size) > maxW and #out > 3 do out = string.sub(out, 1, #out - 2) .. "." end
			return out
		end
		local function icon(path, x1, y1, x2, y2, color)
			if not path then return false end
			if iconOk[path] == nil then iconOk[path] = VFS.FileExists(path) == true end
			if not iconOk[path] then return false end
			glColor(color or { 1, 1, 1, 1 })
			glTexture(path)
			glTexRect(x1, y1, x2, y2)
			glTexture(false)
			return true
		end
		local function stateLayer(x1, y1, x2, y2, cs, id)
			if pressedId == id then roundRect(x1, y1, x2, y2, cs, C.pressLayer)
			elseif hoverId == id then roundRect(x1, y1, x2, y2, cs, C.hoverLayer) end
		end
		local function register(x1, y1, x2, y2, id, action, tooltip, key)
			hit[#hit + 1] = { x1, y1, x2, y2, id, action, tooltip, key }
		end
		local function divider(x1, x2, y)
			glColor(C.outline)
			glRect(x1, y, x2, y + mathMax(1, px(1)))
		end
		local function iconButton(x1, y1, size, path, id, action, tooltip, on, fallback)
			local x2, y2 = x1 + size, y1 + size
			if on then roundRect(x1, y1, x2, y2, px(4), C.primaryContainer) end
			stateLayer(x1, y1, x2, y2, px(4), id)
			local m = px(4)
			if not icon(path, x1 + m, y1 + m, x2 - m, y2 - m, on and C.primary or C.onSurface) then
				text(font2, fallback or "?", (x1 + x2) / 2, y1 + size * 0.5 - px(3.5), px(10), "oc", on and C.primary or C.onSurface)
			end
			register(x1, y1, x2, y2, id, action, tooltip)
			return x1 - size - px(2)
		end
		local function labelButton(x1, y1, x2, y2, path, label, id, action, tooltip, active, enabled)
			local cs = px(4)
			if active then roundRect(x1, y1, x2, y2, cs, C.primaryContainer)
			else outlineRect(x1, y1, x2, y2, cs, C.outlineStrong) end
			if enabled ~= false then stateLayer(x1, y1, x2, y2, cs, id) end
			local h = y2 - y1
			local isz = h - px(6)
			local col = (enabled == false) and C.onSurfaceVariant or (active and C.primary or C.onSurface)
			local tx = x1 + px(5)
			if icon(path, tx, y1 + px(3), tx + isz, y1 + px(3) + isz, col) then tx = tx + isz + px(4) end
			text(font2, fitText(font2, label, px(9), x2 - tx - px(3)), tx, y1 + h * 0.5 - px(3.4), px(9), "o", col)
			if enabled ~= false then register(x1, y1, x2, y2, id, action, tooltip) end
		end
		-- a rounded pill; returns its right edge
		local function chip(x1, y1, h, label, id, action, tooltip, active, color, maxW)
			local size = px(8.5)
			local w = textWidth(font2, label, size) + px(12) + (color and px(10) or 0)
			if maxW then w = mathMin(w, maxW) end
			local x2, y2 = x1 + w, y1 + h
			if active then roundRect(x1, y1, x2, y2, px(8), C.primaryContainer)
			else outlineRect(x1, y1, x2, y2, px(8), C.outlineStrong) end
			if action then stateLayer(x1, y1, x2, y2, px(8), id) end
			local tx = x1 + px(6)
			if color then
				roundRect(tx, y1 + h * 0.5 - px(3), tx + px(6), y1 + h * 0.5 + px(3), px(3), { color[1], color[2], color[3], 1 })
				tx = tx + px(10)
			end
			text(font2, fitText(font2, label, size, x2 - tx - px(4)), tx, y1 + h * 0.5 - px(3.2), size, "o", active and C.primary or C.onSurface)
			if action then register(x1, y1, x2, y2, id, action, tooltip) end
			return x2
		end
		-- a row label on the left and up to three equal buttons: {path, label, id, action, tooltip, active, enabled}
		local function buttonRow(left, right, y, title, buttons)
			text(font2, title, left, y - px(14), px(9), "o", C.onSurfaceVariant)
			local bl = left + px(64)
			local n = #buttons
			local bw = (right - bl - (n - 1) * px(4)) / n
			for i, b in ipairs(buttons) do
				local bx1 = bl + (i - 1) * (bw + px(4))
				labelButton(bx1, y - px(22), bx1 + bw, y, b[1], b[2], b[3], b[4], b[5], b[6], b[7])
			end
			return y - px(26)
		end
		local function statusLine(left, right, y, s, color, id)
			text(font, fitText(font, s, px(8), right - left), left, y - px(9), px(8), "o", color or C.onSurfaceVariant)
			if id then register(left, y - px(12), right, y, id, function() end, s) end
			return y - px(14)
		end

		P.px, P.inside, P.roundRect, P.outlineRect, P.text, P.textWidth, P.fitText = px, inside, roundRect, outlineRect, text, textWidth, fitText
		P.icon, P.stateLayer, P.register, P.divider, P.iconButton, P.labelButton, P.chip = icon, stateLayer, register, divider, iconButton, labelButton, chip
		P.buttonRow, P.statusLine = buttonRow, statusLine
		function P.Fonts() return font, font2 end

		function P.SetOpen(v)
			v = v == true
			if v == P.open then return end
			P.open = v
			if not v and WG.guishader then WG.guishader.RemoveRect(spec.id) end
			if spec.onOpen then spec.onOpen(v) end
		end
		function P.Toggle() P.SetOpen(not P.open) end

		function P.Layout()
			local x1, y1, x2, y2, gap = svc.dockRect(spec.id)
			P.tile.x1, P.tile.y1, P.tile.x2, P.tile.y2 = x1, y1, x2, y2
			local w, h = mathFloor(spec.width * scale), mathMin(mathFloor(spec.height * scale), vsy - 2 * gap)
			local wx2 = x1 - gap + P.offX
			local wy2 = y2 + P.offY
			wx2 = mathMax(w + gap, mathMin(vsx - gap, wx2))
			wy2 = mathMax(h + gap, mathMin(vsy - gap, wy2))
			P.win.x1, P.win.y1, P.win.x2, P.win.y2 = wx2 - w, wy2 - h, wx2, wy2
		end
		function P.WindowRect() if P.open then return P.win end return nil end

		local function drawTile()
			local t = P.tile
			local F = flowDraw()
			if F and F.Element then F.Element(t.x1, t.y1, t.x2, t.y2, 1, 1, 1, 1, 1, 1, 1, 1, WG.FlowUI.clampedOpacity)
			else roundRect(t.x1, t.y1, t.x2, t.y2, px(4), C.surface) end
			if WG.guishader then WG.guishader.InsertRect(t.x1, t.y1, t.x2, t.y2, spec.id .. "tile", spec.widget or widget) end
			if P.open then roundRect(t.x1 + px(2), t.y1 + px(2), t.x2 - px(2), t.y2 - px(2), px(3), C.primaryContainer) end
			stateLayer(t.x1, t.y1, t.x2, t.y2, px(4), "tile")
			local m = px(5)
			if not icon(spec.icon, t.x1 + m, t.y1 + m, t.x2 - m, t.y2 - m, P.open and C.primary or C.onSurface) then
				text(font2, spec.fallback or "?", (t.x1 + t.x2) / 2, t.y1 + (t.y2 - t.y1) * 0.5 - px(4), px(10), "oc", P.open and C.primary or C.onSurface)
			end
			register(t.x1, t.y1, t.x2, t.y2, "tile", function() P.Toggle() end, P.open and spec.tooltipOpen or spec.tooltipClosed)
		end

		local function drawWindow()
			local w = P.win
			local F = flowDraw()
			if F and F.Element then F.Element(w.x1, w.y1, w.x2, w.y2, 1, 1, 1, 1, 1, 1, 1, 1, WG.FlowUI.clampedOpacity)
			else roundRect(w.x1, w.y1, w.x2, w.y2, px(6), C.surface) end
			if WG.guishader then WG.guishader.InsertRect(w.x1, w.y1, w.x2, w.y2, spec.id, spec.widget or widget) end
			local pad = px(7)
			local left, right = w.x1 + pad, w.x2 - pad
			local hh = px(24)
			local hy1 = w.y2 - hh
			roundRect(w.x1 + px(1), hy1, w.x2 - px(1), w.y2 - px(1), px(5), C.surfaceHigh)
			icon(spec.icon, left, hy1 + px(5), left + px(14), hy1 + px(19), C.primary)
			text(font2, spec.title, left + px(18), hy1 + hh * 0.5 - px(4), px(11), "o", C.onSurface)
			local sub = spec.subtitle and spec.subtitle() or nil
			if sub then
				text(font, sub, left + px(18) + textWidth(font2, spec.title, px(11)) + px(6), hy1 + hh * 0.5 - px(3.5), px(8.5), "o", C.onSurfaceVariant)
			end
			register(w.x1, hy1, w.x2, w.y2, "header", function() end, "Drag to move")
			local bs = px(20)
			local bx = right - bs
			local by = hy1 + (hh - bs) / 2
			bx = iconButton(bx, by, bs, ICON.close, "close", function() P.SetOpen(false) end,
				"Close" .. (spec.shortcut and (" (" .. spec.shortcut .. ")") or ""), false, "x")
			if spec.headerButtons then spec.headerButtons(P, bx, by, bs) end
			if spec.draw then spec.draw(P, left, right, hy1 - px(6), w.y1 + pad) end
		end

		function P.Draw()
			hit = {}
			font, font2 = fonts()
			P.Layout()
			drawTile()
			if P.open then drawWindow() end
			local mx, my = spGetMouseState()
			local newHover, newKey = nil, nil
			for _, r in ipairs(hit) do
				if inside(mx, my, r[1], r[2], r[3], r[4]) and r[5] ~= "header" and r[5] ~= "area" then
					newHover = r[5]
					if r[8] then newKey = r[8] end
				end
			end
			hoverId, P.hoverKey = newHover, newKey
			glColor(1, 1, 1, 1)
		end

		function P.IsAbove(mx, my)
			if inside(mx, my, P.tile.x1, P.tile.y1, P.tile.x2, P.tile.y2) then return true end
			return P.open and inside(mx, my, P.win.x1, P.win.y1, P.win.x2, P.win.y2)
		end
		function P.GetTooltip(mx, my)
			local tip = nil
			for _, r in ipairs(hit) do
				if inside(mx, my, r[1], r[2], r[3], r[4]) and r[7] then tip = r[7] end
			end
			return tip
		end
		function P.ButtonRect(id)
			for _, r in ipairs(hit) do if r[5] == id then return { r[1], r[2], r[3], r[4] } end end
			return nil
		end
		function P.MousePress(mx, my, mb)
			if not P.IsAbove(mx, my) then return false end
			if mb ~= 1 then return true end
			local top = nil
			for _, r in ipairs(hit) do
				if inside(mx, my, r[1], r[2], r[3], r[4]) then top = r end
			end
			if top and top[5] == "header" then
				dragging = { mx, my, P.offX, P.offY }
				return true
			end
			pressedId = top and top[5] or nil
			return true
		end
		function P.MouseMove(mx, my)
			if dragging then
				P.offX = dragging[3] + (mx - dragging[1])
				P.offY = dragging[4] + (my - dragging[2])
				P.Layout()
				return true
			end
			return false
		end
		function P.MouseRelease(mx, my, mb)
			if dragging then dragging = nil; return true end
			if pressedId then
				for _, r in ipairs(hit) do
					if r[5] == pressedId and inside(mx, my, r[1], r[2], r[3], r[4]) then
						pressedId = nil
						spPlaySoundFile(SOUND_CLICK, 0.5, "ui")
						r[6]()
						return true
					end
				end
				pressedId = nil
			end
			return false
		end
		function P.GetConfig() return { open = P.open, offX = P.offX / mathMax(scale, 0.01), offY = P.offY / mathMax(scale, 0.01) } end
		function P.SetConfig(t)
			if type(t) ~= "table" then return end
			P.open = t.open == true
			P.offX = (tonumber(t.offX) or 0) * scale
			P.offY = (tonumber(t.offY) or 0) * scale
		end
		function P.Remove()
			svc.panels[spec.id] = nil
			if WG.guishader then
				WG.guishader.RemoveRect(spec.id)
				WG.guishader.RemoveRect(spec.id .. "tile")
			end
		end
		svc.panels[spec.id] = { id = spec.id, order = spec.order or 50, isAbove = P.IsAbove }
		return P
	end
end

-- The other BARb windows' tables, for the facade and the "open" buttons.
local CLIENTS = { "barbmap", "barbplans", "barbmonitor" }

-- Builds WG.barb. Called from Initialize, once the roster helpers exist.
local function publishServices()
	WG.barb = {
		version = API_VERSION,
		-- teams, permissions, selection
		Teams = function()
			local out = {}
			for _, id in ipairs(aiOrder) do
				local e = ais[id]
				local r = e.roster
				out[#out + 1] = { id = id, name = e.name, color = e.color, allyTeam = e.allyTeam, hosted = hostedHere(id),
					role = r and r.role or nil, side = r and r.side or nil, roster = r }
			end
			return out
		end,
		MayCommand = function(team) return mayCommand(team) end,
		IsPermitted = function(team) return isPermittedTeam(team) end,
		HostedHere = function(team) return hostedHere(team) end,
		Selected = function() return selected end,
		SelectedAlly = function() return selectedAlly end,
		OnSelect = function(owner, fn) removeOwner(svc.selectFns, owner); svc.selectFns[#svc.selectFns + 1] = { owner = owner, fn = fn } end,
		-- messages: every changed state value and every ai.CallUI message, replayed once at subscribe
		OnMessage = function(owner, fn)
			removeOwner(svc.listeners, owner)
			svc.listeners[#svc.listeners + 1] = { owner = owner, fn = fn }
			for _, id in ipairs(aiOrder) do
				local states = stateFiles.States and stateFiles.States(id)
				if states then
					for key, value in pairs(states) do
						local ok, err = pcall(fn, id, value, key)
						if not ok then spEcho("[BARb link] listener " .. tostring(owner) .. " error: " .. tostring(err)) end
					end
				end
			end
		end,
		Unsubscribe = function(owner) removeOwner(svc.listeners, owner); removeOwner(svc.selectFns, owner); svc.removeTabs(owner) end,
		-- D-506: tabs in this window, under the AI selector
		AddTab = function(spec) return svc.addTab(spec) end,
		RemoveTab = function(id) svc.removeTabs(nil, id) end,
		ActiveTab = function() return svc.activeTab end,
		-- Opens the window on a tab; with toggle, a second call on the shown tab closes it.
		ShowTab = function(id, toggle)
			if id ~= "ai" and not svc.findTab(id) then return false end
			if toggle and open and svc.activeTab == id then setOpen(false); return true end
			svc.activeTab = id
			setOpen(true)
			return true
		end,
		IsOpen = function() return open end,
		SetOpen = function(v) setOpen(v == true) end,
		Value = function(team, key) local s = stateFiles.States and stateFiles.States(team); return s and s[key] or nil end,
		Seq = function(team) return stateFiles.Seq and stateFiles.Seq(team) end,
		-- commands and leases
		Send = function(team, message)
			if not mayCommand(team) then return false end
			return spSendSkirmishAIMessage(team, message)
		end,
		Lease = function(owner, team, topic, renew) return svc.lease(owner, team, topic, renew) end,
		Release = function(owner, team, topic) svc.release(owner, team, topic) end,
		-- dock, panels, look
		NewPanel = kit.New,
		OverAnyPanel = function(mx, my) return svc.overAnyPanel(mx, my) end,
		Scale = function() return scale end,
		Colors = C,
		Icons = ICON,
		-- the settings the single widget saved before the split, once per section
		LegacyConfig = function(section)
			local t = svc.legacy[section]
			svc.legacy[section] = nil
			return t
		end,
		AddEvent = function(textLine, kind) addEvent(textLine, kind) end,
	}
end
-- ---------------------------------------------------------------- placement

-- The player list's box: { top, left, bottom, right, scale }, or nil.
local function playerList()
	local api = WG.advplayerlist_api
	if api and api.GetPosition then
		local p = api.GetPosition()
		if p and p[1] then return p end
	end
	return nil
end

-- The launcher is the first tile of the BARb column, left of the player list's top-left corner, the
-- window to its left over the map; without a player list, the bottom-right
-- corner. The user's drag is an offset from that place, clamped on screen.
local function updatePlacement()
	local list = playerList()
	if list then
		scale = list[5] or 1
	else
		scale = (vsy / 1080) * (1 + (Spring.GetConfigFloat("ui_scale", 1) - 1) / 1.25)
	end
	local ls = mathFloor(LAUNCHER * scale)
	local gap = mathFloor(4 * scale)
	-- D-498: the hub's tile is the first slot of the BARb launcher column
	launcher.x1, launcher.y1, launcher.x2, launcher.y2 = svc.dockRect(HUB_DOCK_ID)
	local w, h = mathFloor(WIN_W * scale), mathMin(mathFloor(WIN_H * scale), vsy - 2 * gap)
	local x2 = launcher.x1 - gap + offX
	local y2 = launcher.y2 + offY
	x2 = mathMax(w + gap, mathMin(vsx - gap, x2))
	y2 = mathMax(h + gap, mathMin(vsy - gap, y2))
	win.x1, win.y1, win.x2, win.y2 = x2 - w, y2 - h, x2, y2
end

-- ---------------------------------------------------------------- lifecycle

local function initFlowUI()
	hasFlowUI = WG.FlowUI ~= nil and WG.FlowUI.Draw ~= nil
	if hasFlowUI then
		RectRound = WG.FlowUI.Draw.RectRound
		RectRoundOutline = WG.FlowUI.Draw.RectRoundOutline
		UiElement = WG.FlowUI.Draw.Element
	end
	if WG.fonts then
		font = WG.fonts.getFont()
		font2 = WG.fonts.getFont(2)
	end
end

function widget:ViewResize(newX, newY)
	vsx, vsy = newX, newY
	initFlowUI()
	updatePlacement()
end

-- BAR's public notification, not spectator LOS or hidden projectile reads.
-- Spectator alerts lack an unambiguous enemy side, so never relay them.
-- The gadget emits NukeLaunched only to players outside the launcher's allyteam.
local lastNuclearWarning=-100000
function widget:NotificationEvent(message)
    local recipient=type(message)=="string" and message:match("^NukeLaunched (%d+)$")
    if not recipient or isSpectator() or tonumber(recipient)~=spGetMyPlayerID() then return end
    local frame=Spring.GetGameFrame()
    if frame==lastNuclearWarning then return end
    lastNuclearWarning=frame
    for _,id in ipairs(aiOrder) do
        if mayCommand(id) then spSendSkirmishAIMessage(id,"barb|nuclear-warning|"..id) end
    end
end

-- The tools/playtest facade (WG.barblink): every member the watchers call,
-- forwarded to the widget that now owns it (D-498). A member whose widget is
-- not loaded returns nil. ButtonRect and the mouse calls look through every
-- BARb window, and a press goes to the window that laid out the button.
local function client(name) return WG[name] end
local function forward(name, member)
	return function(...)
		local c = client(name)
		local f = c and c[member]
		if f then return f(...) end
		return nil
	end
end
local facadePress = nil
local function publishFacade()
	local link = {
		IsOpen = function() return open end,
		-- open every BARb window, so the tests find every button laid out
		SetOpen = function(v)
			setOpen(v)
			for _, name in ipairs(CLIENTS) do
				local c = client(name)
				if c and c.SetOpen then c.SetOpen(v) end
			end
		end,
		SetRole = function(teamId, role) return requestRole(teamId, role) end,
		SetAggression = requestAggression,
		GetAggression = function(teamId)
			local e = ais[teamId]
			return e and e.aggression, e and e.automaticAggression
		end,
		GoTo = function(teamId) return goTo(teamId) end,
		MayCommand = function(teamId) return mayCommand(teamId) end,
		-- teamId -> { role, allyTeam, name } of every listed AI that announced itself
		Roster = function()
			local out = {}
			for id, e in pairs(ais) do
				if e.roster then out[id] = { role = e.roster.role, allyTeam = e.allyTeam, name = e.name } end
			end
			return out
		end,
		LastReply = function(teamId) local e = ais[teamId]; return e and e.lastReply end,
		EventCount = function() return #events end,
		StateSeq = function(teamId) return stateFiles.Seq and stateFiles.Seq(teamId) end,
		ButtonRect = function(id)
			for _, r in ipairs(hit) do
				if r[5] == id then facadePress = "hub"; return { r[1], r[2], r[3], r[4] } end
			end
			for _, name in ipairs(CLIENTS) do
				local c = client(name)
				local rect = c and c.ButtonRect and c.ButtonRect(id)
				if rect then facadePress = name; return rect end
			end
			-- D-506: a button of a tab that is not shown is pressed through the
			-- tab's actions (the watchers click Plans buttons by id).
			for _, t in ipairs(svc.tabs) do
				local fn = t.actions and t.actions[id]
				if fn then facadePress = fn; return { 0, 0, 1, 1 } end
			end
			return nil
		end,
		MousePress = function(x, y, b)
			local target = facadePress
			if type(target) == "function" then return true end
			if target and target ~= "hub" and client(target) and client(target).MousePress then
				return client(target).MousePress(x, y, b)
			end
			return widget:MousePress(x, y, b)
		end,
		MouseRelease = function(x, y, b)
			local target = facadePress
			if type(target) == "function" then facadePress = nil; target(); return false end
			if target and target ~= "hub" and client(target) and client(target).MouseRelease then
				return client(target).MouseRelease(x, y, b)
			end
			return widget:MouseRelease(x, y, b)
		end,
		MouseMove = function(x, y, dx, dy, b)
			local target = facadePress
			if type(target) == "function" then return false end
			if target and target ~= "hub" and client(target) and client(target).MouseMove then
				return client(target).MouseMove(x, y, dx, dy, b)
			end
			return widget:MouseMove(x, y, dx, dy, b)
		end,
	}
	-- BARb plans
	for _, m in ipairs({ "SetTheatres", "SetBlueprints", "BlueprintSnapshot", "BlueprintStatus", "TheatreSnapshot",
		"TheatreStatus", "TheatreOptions", "TheatreConfig", "SelectLane", "SetStrategy", "StrategySnapshot", "StrategyConfig" }) do
		link[m] = forward("barbplans", m)
	end
	-- BARb map
	for _, m in ipairs({ "SetField", "FieldStatus", "FieldSnapshot", "FieldOptions", "FieldConfig", "FieldLayer",
		"FieldFocus", "FieldBlueprint", "FieldLegend", "FieldSide", "MarksShow", "MarksStatus", "MarksSnapshot",
		"MarksPhase", "MarksSelect", "MarksFaction", "MarksLegend" }) do
		link[m] = forward("barbmap", m)
	end
	WG.barblink = link
end

function widget:Initialize()
	svc.panels[HUB_DOCK_ID] = { id = HUB_DOCK_ID, order = HUB_DOCK_ORDER,
		isAbove = function(mx, my)
			local function over(r) return mx >= r.x1 and mx <= r.x2 and my >= r.y1 and my <= r.y2 end
			return over(launcher) or (open and over(win))
		end }
	self:ViewResize(Spring.GetViewGeometry())
	refreshTeams()
	hookAIMessages()
	publishServices()
	publishFacade()
end

function widget:Shutdown()
	unhookAIMessages()
	for key, l in pairs(svc.leases) do
		if mayCommand(l.team) then spSendSkirmishAIMessage(l.team, "barb|" .. l.topic .. "|" .. l.team .. "|off") end
		svc.leases[key] = nil
	end
	WG.barb = nil
	WG.barblink = nil
	if WG.guishader then
		WG.guishader.RemoveRect("barblink")
		WG.guishader.RemoveRect("barblinklauncher")
	end
end

-- The overlay sections the single widget saved are kept until their new
-- widget takes them (WG.barb.LegacyConfig), and saved back meanwhile, so a
-- client enabled in a later game still finds them.
local LEGACY_SECTIONS = { "theatres", "field", "marks", "seaLanes", "territory", "strategy" }

function widget:GetConfigData()
	local data = { open = open, offX = offX / mathMax(scale, 0.01), offY = offY / mathMax(scale, 0.01), tab = svc.activeTab }
	for _, section in ipairs(LEGACY_SECTIONS) do
		if svc.legacy[section] ~= nil then data[section] = svc.legacy[section] end
	end
	return data
end

function widget:SetConfigData(data)
	if type(data) ~= "table" then return end
	for _, section in ipairs(LEGACY_SECTIONS) do
		if data[section] ~= nil then svc.legacy[section] = data[section] end
	end
	if type(data.tab) == "string" and data.tab ~= "ai" then svc.savedTab = data.tab end   -- D-506
	if data.open ~= nil then
		firstRun = false   -- a config of this version: its open state stands
		open = data.open == true
	end
	offX = (tonumber(data.offX) or 0) * scale
	offY = (tonumber(data.offY) or 0) * scale
end

function widget:Update()
	if stateFiles.Poll then stateFiles.Poll() end
	svc.renewLeases()
end

function widget:GameFrame(n)
	if n < 90 then return end
	if lastQueryFrame < 0 or n % QUERY_INTERVAL_FRAMES == 0 then
		local missing = false
		for _, id in ipairs(aiOrder) do
			if not (ais[id] and ais[id].roster) then missing = true end
		end
		if missing then queryAll() end
	end
end
-- ---------------------------------------------------------------- messages

local function onAIMessage(aiTeam, dataStr)
	-- D-498: every BARb widget sees the line first (lanes answer ai.CallUI with an ack)
	local ack = svc.dispatch(aiTeam, dataStr, nil); if ack then return ack end
	if type(dataStr) ~= "string" or string.sub(dataStr, 1, 5) ~= "barb|" then return end
	local p = split(dataStr, "|")
	local topic, sender, senderAlly = p[2], tonumber(p[3]), tonumber(p[4])
	if sender and not isPermittedTeam(sender) then return end   -- CR-008
	if sender and not ais[sender] then refreshTeams() end
	local e = sender and ais[sender]
	if e and senderAlly then e.allyTeam = senderAlly end
	local rest = table.concat(p, " ", 5)
	if topic == "roster" then
		local r = parseRoster(table.concat(p, "|", 6))
		if r and ais[r.teamId] then
			local target = ais[r.teamId]
			firstAnnounceFrame = firstAnnounceFrame or spGetGameFrame()
			if not target.roster then
				addEvent(string.format("Team %d announced: %s, %s%s", r.teamId, r.role, r.side, r.leader and ", lead" or ""), "info")
			elseif target.roster.role ~= r.role then
				addEvent(string.format("Team %d role changed: %s to %s", r.teamId, target.roster.role, r.role), "ok")
			end
			target.roster = r
			if target.lastReply and string.sub(target.lastReply, 1, 2) == "?:" then target.lastReply = nil; target.replyKind = nil end   -- "not ready" is answered
		end
    elseif topic == "aggression" and e then
        local delta, automatic=tonumber(p[5]),tonumber(p[6])
        if delta and delta>=-1 and delta<=1 and automatic and automatic>=-1 and automatic<=1 then
            e.aggression, e.automaticAggression=delta,automatic
        end
	elseif topic == "role" and e then
		local role, status = p[5] or "?", p[6] or ""
		e.lastReply = string.format("%s: %s", role, status)
		e.replyKind = (status == "ok") and "ok" or ((string.sub(status, 1, 7) == "already") and "info" or "warn")
		if status == "ok" and e.roster then e.roster.role = role end
		addEvent(string.format("Team %d replied: %s (%s)", sender, status, role), e.replyKind)
	elseif topic == "orphan" and e then
		addEvent(string.format("Team %d orphan rescue: %s", sender, rest), "warn")
	elseif topic == "donation" and e then
		addEvent(string.format("Team %d gave %s to team %s (%s of %s)", sender, p[5] or "?", p[6] or "?", p[7] or "?", p[8] or "?"), "ok")
	elseif topic == "ferry" and e then
		addEvent(string.format("Team %d ferry: %s", sender, rest), (p[5] == "done" or p[5] == "gave") and "ok" or ((p[5] == "fallback") and "warn" or "info"))
	elseif topic == "spam" and e then
		local what = p[5] or "?"
		if what == "on" then addEvent(string.format("Team %d spam on (+%s metal, +%s energy)", sender, p[6] or "?", p[7] or "?"), "ok")
		elseif what == "off" then addEvent(string.format("Team %d spam off (+%s metal, +%s energy)", sender, p[6] or "?", p[7] or "?"), "warn")
		else addEvent(string.format("Team %d spam %s (%s, %s)", sender, what, p[6] or "?", p[7] or "?"), "info") end
	elseif topic == "seaassist" and e then
		addEvent(string.format("Team %d sea assist: %s", sender, rest), "info")
	end
end

-- D-300: the AI state files. Each locally hosted BARb rewrites
-- LuaUI/Config/BARb/state/team<N>.txt a short while after its widget state
-- changes (src/circuit/util/WidgetState.h):
--   barbstate|<format>|<team>|<allyTeam>|<seq>|<frame>
--   s|<key>|<barb line>      latest value per key (roster, aggression, layout)
--   e|<id>|<barb line>       the latest 64 events, ids increasing
--   end|<seq>                trailer: a torn or half-written file is skipped
-- Cost: one VFS read per hosted AI per POLL_SECONDS of wall time; the header
-- sequence skips parsing an unchanged file, and only changed values or new
-- event ids reach onAIMessage. No per-frame work.
do
    local FORMAT, POLL_SECONDS = 1, 1.0
    local files = {}           -- teamId -> { seq, event, states = {key -> line}, layoutShown }
    local lastPoll = nil
    local readError = nil
    local function path(id) return "LuaUI/Config/BARb/state/team" .. id .. ".txt" end
    local function load(id)
        if not (VFS and VFS.LoadFile) then return nil, "VFS.LoadFile is unavailable" end
        local ok, text = pcall(VFS.LoadFile, path(id), VFS.RAW)
        if not ok then return nil, tostring(text) end
        return text
    end
    local function apply(id, text)
        local f = files[id] or { seq = -1, event = 0, states = {} }
        files[id] = f
        local format, team, _, seq, frame = text:match("^barbstate|(%d+)|(%d+)|(%d+)|(%d+)|(%d+)")
        format, team, seq, frame = tonumber(format), tonumber(team), tonumber(seq), tonumber(frame)
        if format ~= FORMAT or team ~= id or not seq then return end
        if seq == f.seq then return end
        -- A file from a longer earlier game: the AI deletes it on start, so this
        -- is only a leftover when the AI is not running here.
        if frame and frame > spGetGameFrame() + 900 then return end
        if not text:find("\nend|" .. seq .. "\n", 1, true) then return end   -- torn: next poll
        if seq < f.seq then f.event = 0; f.states = {} end   -- the AI restarted
        f.seq = seq
        local seen = {}
        for line in text:gmatch("[^\n]+") do
            local kind = line:sub(1, 2)
            if kind == "s|" then
                local key, value = line:match("^s|([^|]+)|(.*)$")
                if key then
                    seen[key] = true
                    if key == "layout" then
                        -- the whole planned base: BARb plans reads it with WG.barb.Value (D-498)
                        f.states.layout = value
                    elseif f.states[key] ~= value then
                        f.states[key] = value
                        onAIMessage(id, value)
                    end
                end
            elseif kind == "e|" then
                local eid, value = line:match("^e|(%d+)|(.*)$")
                eid = tonumber(eid)
                if eid and eid > f.event then
                    f.event = eid
                    onAIMessage(id, value)
                end
            end
        end
        for key in pairs(f.states) do
            if not seen[key] then f.states[key] = nil; svc.dispatch(id, nil, key) end   -- a key the AI cleared
        end
    end
    function stateFiles.Poll()
        local now = Spring.GetTimer()
        if lastPoll and Spring.DiffTimers(now, lastPoll) < POLL_SECONDS then return end
        lastPoll = now
        for _, id in ipairs(aiOrder) do
            if hostedHere(id) and isPermittedTeam(id) then
                local text, err = load(id)
                if err and readError ~= err then
                    readError = err
                    spEcho("[BARb link] cannot read AI state file " .. path(id) .. ": " .. err)
                elseif type(text) == "string" and #text > 0 then
                    local ok, perr = pcall(apply, id, text)
                    if not ok then spEcho("[BARb link] state file error team " .. id .. ": " .. tostring(perr)) end
                end
            end
        end
    end
    function stateFiles.Seq(id) return files[id] and files[id].seq or nil end
    function stateFiles.States(id) return files[id] and files[id].states or nil end
end

-- BAR's widget handler (luaui/barwidgets.lua) does not forward the engine's
-- RecvSkirmishAIMessage callin to widgets: it is not in its callInLists, and
-- RegisterGlobal refuses engine callin names. So the widget installs the LuaUI
-- global itself (getfenv(0) is LuaUI's global table; Script.UpdateCallIn makes
-- the engine call it), chaining to any handler already there, and restores it
-- on shutdown. Should the handler ever forward the callin, widget:Recv... is
-- used instead and the global is left alone.
local AI_CALLIN = "RecvSkirmishAIMessage"
local hooked, previousGlobal = false, nil

function widget:RecvSkirmishAIMessage(aiTeam, dataStr)
	if hooked then return end
	return onAIMessage(aiTeam, dataStr)
end

hookAIMessages = function()
	local G = getfenv and getfenv(0)
	if type(G) ~= "table" or not (Script and Script.UpdateCallIn) then return end
	previousGlobal = rawget(G, AI_CALLIN)
	if previousGlobal ~= nil then return end   -- the handler (or another widget) delivers it: widget:Recv... gets it
	rawset(G, AI_CALLIN, function(aiTeam, dataStr)
		local ok, err = pcall(onAIMessage, aiTeam, dataStr)
		if not ok then spEcho("[BARb link] message error: " .. tostring(err)) end
		return ok and err or nil
	end)
	Script.UpdateCallIn(AI_CALLIN)
	hooked = true
end

unhookAIMessages = function()
	if not hooked then return end
	local G = getfenv and getfenv(0)
	if type(G) == "table" then
		rawset(G, AI_CALLIN, previousGlobal)
		Script.UpdateCallIn(AI_CALLIN)
	end
	hooked = false
end

-- ---------------------------------------------------------------- drawing primitives

local function px(v) return mathFloor(v * scale + 0.5) end
local function inside(x, y, x1, y1, x2, y2) return x >= x1 and x <= x2 and y >= y1 and y <= y2 end

local function roundRect(x1, y1, x2, y2, cs, color)
	if hasFlowUI then
		RectRound(x1, y1, x2, y2, cs, 1, 1, 1, 1, color, color)
	else
		glColor(color); glRect(x1, y1, x2, y2)
	end
end

local function outlineRect(x1, y1, x2, y2, cs, color)
	if hasFlowUI then
		RectRoundOutline(x1, y1, x2, y2, cs, mathMax(1, px(1)), 1, 1, 1, 1, color, color)
	else
		glColor(color)
		glRect(x1, y1, x2, y1 + 1); glRect(x1, y2 - 1, x2, y2); glRect(x1, y1, x1 + 1, y2); glRect(x2 - 1, y1, x2, y2)
	end
end

local function text(f, s, x, y, size, opts, color)
	if f then
		f:Begin()
		f:SetTextColor(color[1], color[2], color[3], color[4] or 1)
		f:SetOutlineColor(0, 0, 0, 0.6)
		f:Print(s, x, y, size, opts or "o")
		f:End()
	else
		glColor(color); glText(s, x, y, size, opts or "o")
	end
end

local function textWidth(f, s, size)
	if f then return f:GetTextWidth(s) * size end
	return gl.GetTextWidth(s) * size
end

local function fitText(f, s, size, maxW)
	local out = s
	while textWidth(f, out, size) > maxW and #out > 3 do out = string.sub(out, 1, #out - 2) .. "." end
	return out
end

local iconOk = {}
local function icon(path, x1, y1, x2, y2, color)
	if not path then return false end
	if iconOk[path] == nil then iconOk[path] = VFS.FileExists(path) == true end
	if not iconOk[path] then return false end
	glColor(color or { 1, 1, 1, 1 })
	glTexture(path)
	glTexRect(x1, y1, x2, y2)
	glTexture(false)
	return true
end

local function stateLayer(x1, y1, x2, y2, cs, id)
	if pressedId == id then roundRect(x1, y1, x2, y2, cs, C.pressLayer)
	elseif hoverId == id then roundRect(x1, y1, x2, y2, cs, C.hoverLayer) end
end

local function register(x1, y1, x2, y2, id, action, tooltip)
	hit[#hit + 1] = { x1, y1, x2, y2, id, action, tooltip }
end

local function divider(x1, x2, y)
	glColor(C.outline)
	glRect(x1, y, x2, y + mathMax(1, px(1)))
end

-- a square icon button; `on` shows it pressed in (a toggle)
local function iconButton(x1, y1, size, path, id, action, tooltip, on, fallback)
	local x2, y2 = x1 + size, y1 + size
	if on then roundRect(x1, y1, x2, y2, px(4), C.primaryContainer) end
	stateLayer(x1, y1, x2, y2, px(4), id)
	local m = px(4)
	if not icon(path, x1 + m, y1 + m, x2 - m, y2 - m, on and C.primary or C.onSurface) then
		text(font2, fallback or "?", (x1 + x2) / 2, y1 + size * 0.5 - px(3.5), px(10), "oc", C.onSurface)
	end
	register(x1, y1, x2, y2, id, action, tooltip)
	return x1 - size - px(2)
end

-- a button with a leading icon and a label
local function labelButton(x1, y1, x2, y2, path, label, id, action, tooltip, active, enabled)
	local cs = px(4)
	if active then roundRect(x1, y1, x2, y2, cs, C.primaryContainer)
	else outlineRect(x1, y1, x2, y2, cs, C.outlineStrong) end
	if enabled ~= false then stateLayer(x1, y1, x2, y2, cs, id) end
	local h = y2 - y1
	local isz = h - px(6)
	local col = (enabled == false) and C.onSurfaceVariant or (active and C.primary or C.onSurface)
	local tx = x1 + px(5)
	if icon(path, tx, y1 + px(3), tx + isz, y1 + px(3) + isz, col) then tx = tx + isz + px(4) end
	text(font2, fitText(font2, label, px(9), x2 - tx - px(3)), tx, y1 + h * 0.5 - px(3.4), px(9), "o", col)
	if enabled ~= false then register(x1, y1, x2, y2, id, action, tooltip) end
end

-- D-506: the drawing kit a tab receives: the same members as a panel kit's P
-- (WG.barb.NewPanel), bound to this window's hit list, so a tab's buttons
-- hover, press and show tooltips like the window's own. Built once.
function svc.tabKit()
	if svc.kit then return svc.kit end
	local K = { C = C, ICON = ICON }
	K.px, K.inside, K.roundRect, K.outlineRect, K.text, K.textWidth, K.fitText = px, inside, roundRect, outlineRect, text, textWidth, fitText
	K.icon, K.stateLayer, K.divider, K.iconButton, K.labelButton = icon, stateLayer, divider, iconButton, labelButton
	K.register = function(x1, y1, x2, y2, id, action, tooltip) register(x1, y1, x2, y2, id, action, tooltip) end
	K.Fonts = function() return font, font2 end
	K.Selected = function() return selected end
	K.SelectedAlly = function() return selectedAlly end
	-- a rounded pill; returns its right edge
	K.chip = function(x1, y1, h, label, id, action, tooltip, active, color, maxW)
		local size = px(8.5)
		local w = textWidth(font2, label, size) + px(12) + (color and px(10) or 0)
		if maxW then w = mathMin(w, maxW) end
		local x2, y2 = x1 + w, y1 + h
		if active then roundRect(x1, y1, x2, y2, px(8), C.primaryContainer)
		else outlineRect(x1, y1, x2, y2, px(8), C.outlineStrong) end
		if action then stateLayer(x1, y1, x2, y2, px(8), id) end
		local tx = x1 + px(6)
		if color then
			roundRect(tx, y1 + h * 0.5 - px(3), tx + px(6), y1 + h * 0.5 + px(3), px(3), { color[1], color[2], color[3], 1 })
			tx = tx + px(10)
		end
		text(font2, fitText(font2, label, size, x2 - tx - px(4)), tx, y1 + h * 0.5 - px(3.2), size, "o", active and C.primary or C.onSurface)
		if action then register(x1, y1, x2, y2, id, action, tooltip) end
		return x2
	end
	-- a row label on the left and equal buttons: {path, label, id, action, tooltip, active, enabled}
	K.buttonRow = function(left, right, y, title, buttons)
		text(font2, title, left, y - px(14), px(9), "o", C.onSurfaceVariant)
		local bl = left + px(64)
		local n = #buttons
		local bw = (right - bl - (n - 1) * px(4)) / n
		for i, b in ipairs(buttons) do
			local bx1 = bl + (i - 1) * (bw + px(4))
			labelButton(bx1, y - px(22), bx1 + bw, y, b[1], b[2], b[3], b[4], b[5], b[6], b[7])
		end
		return y - px(26)
	end
	K.statusLine = function(left, right, y, s, color, id)
		text(font, fitText(font, s, px(8), right - left), left, y - px(9), px(8), "o", color or C.onSurfaceVariant)
		if id then register(left, y - px(12), right, y, id, function() end, s) end
		return y - px(14)
	end
	svc.kit = K
	return K
end

-- The tab bar under the selector: the AI tab and every registered tab, equal
-- widths. Returns the y below it.
function svc.drawTabBar(left, right, y)
	local list = { { id = "ai", title = "AI", tip = "This AI: role, aggression, query, events (Ctrl+Alt+B)" } }
	for _, t in ipairs(svc.tabs) do list[#list + 1] = t end
	if svc.activeTab ~= "ai" and not svc.findTab(svc.activeTab) then svc.activeTab = "ai" end
	local h, gap = px(20), px(3)
	local w = (right - left - (#list - 1) * gap) / #list
	for i, t in ipairs(list) do
		local x1 = left + (i - 1) * (w + gap)
		local id = t.id
		labelButton(x1, y - h, x1 + w, y, t.icon, t.title, "tab_" .. id, function() playClick(); svc.activeTab = id end,
			t.tip or t.title, svc.activeTab == id)
	end
	return y - h - px(6)
end

-- ---------------------------------------------------------------- draw

local function drawLauncher()
	local x1, y1, x2, y2 = launcher.x1, launcher.y1, launcher.x2, launcher.y2
	if hasFlowUI then
		UiElement(x1, y1, x2, y2, 1, 1, 1, 1, 1, 1, 1, 1, WG.FlowUI.clampedOpacity)
	else
		roundRect(x1, y1, x2, y2, px(4), C.surface)
	end
	if WG.guishader then WG.guishader.InsertRect(x1, y1, x2, y2, "barblinklauncher", widget) end
	if open then roundRect(x1 + px(2), y1 + px(2), x2 - px(2), y2 - px(2), px(3), C.primaryContainer) end
	stateLayer(x1, y1, x2, y2, px(4), "launcher")
	local m = px(5)
	if not icon(ICON.ai, x1 + m, y1 + m, x2 - m, y2 - m, open and C.primary or C.onSurface) then
		text(font2, "AI", (x1 + x2) / 2, y1 + (y2 - y1) * 0.5 - px(4), px(10), "oc", C.onSurface)
	end
	register(x1, y1, x2, y2, "launcher", function() playClick(); setOpen(not open) end,
		open and "Close the BARb window (Ctrl+Alt+B)" or "Allied BARb AIs: roster, roles, lanes, blueprints, events (Ctrl+Alt+B)")
end

local function drawWindow()
	local x1, y1, x2, y2 = win.x1, win.y1, win.x2, win.y2
	if hasFlowUI then
		UiElement(x1, y1, x2, y2, 1, 1, 1, 1, 1, 1, 1, 1, WG.FlowUI.clampedOpacity)
	else
		roundRect(x1, y1, x2, y2, px(6), C.surface)
	end
	if WG.guishader then WG.guishader.InsertRect(x1, y1, x2, y2, "barblink", widget) end
	local pad = px(7)
	local left, right = x1 + pad, x2 - pad
	local w = right - left

	-- header: title (drag handle), actions on the right
	local hh = px(24)
	local hy1 = y2 - hh
	roundRect(x1 + px(1), hy1, x2 - px(1), y2 - px(1), px(5), C.surfaceHigh)
	icon(ICON.ai, left, hy1 + px(5), left + px(14), hy1 + px(19), C.primary)
	text(font2, "BARb AIs", left + px(18), hy1 + hh * 0.5 - px(4), px(11), "o", C.onSurface)
	text(font, string.format("%d allied", #aiOrder), left + px(18) + textWidth(font2, "BARb AIs", px(11)) + px(6), hy1 + hh * 0.5 - px(3.5), px(8.5), "o", C.onSurfaceVariant)
	register(x1, hy1, x2, y2, "header", function() end, "Drag to move")
	local bs = px(20)
	local bx = right - bs
	local by = hy1 + (hh - bs) / 2
	bx = iconButton(bx, by, bs, ICON.close, "close", function() playClick(); setOpen(false) end, "Close (Ctrl+Alt+B)", false, "x")
	bx = iconButton(bx, by, bs, ICON.queryall, "queryall", function() playClick(); queryAll() end, "Ask every AI for its details", false, "*")
	local cy = hy1 - px(5)
	-- D-498: the other BARb windows, each also on its own tile in the column.
	-- D-506: lanes and blueprints are tabs of this window, not a window.
	text(font2, "Windows", left, cy - px(14), px(9), "o", C.onSurfaceVariant)
	local wins = {
		{ "barbmonitor", "Units", ICON.camera, "the unit monitor: groups and what a unit belongs to (Ctrl+Alt+M)" },
		{ "barbmap", "Map", ICON.overlay, "the map: terrain and landmarks (Ctrl+Alt+T)" },
	}
	local wl = left + px(52)
	local ww = (right - wl - (#wins - 1) * px(4)) / #wins
	for i, entry in ipairs(wins) do
		local c = WG[entry[1]]
		local x0 = wl + (i - 1) * (ww + px(4))
		if c then
			labelButton(x0, cy - px(22), x0 + ww, cy, entry[3], entry[2], "window_" .. entry[2], function()
				playClick(); local t = WG[entry[1]]; if t and t.SetOpen then t.SetOpen(not t.IsOpen()) end
			end, "Open or close " .. entry[4], c.IsOpen and c.IsOpen(), true)
		else
			labelButton(x0, cy - px(22), x0 + ww, cy, entry[3], entry[2], "window_" .. entry[2], nil, nil, false, false)
			register(x0, cy - px(22), x0 + ww, cy, "window_" .. entry[2], function() end,
				"Enable the BARb " .. (entry[1] == "barbmonitor" and "unit monitor" or string.lower(entry[2])) .. " widget (F11) for " .. entry[4])
		end
	end
	cy = cy - px(30)
	-- ally-team chips (only when more than one ally team has an AI)
	if #allyTeams > 1 then
		local chH = px(18)
		local cx = left
		for _, at in ipairs(allyTeams) do
			local label = "Team " .. (at + 1)
			local cw = textWidth(font2, label, px(9)) + px(28)
			labelButton(cx, cy - chH, cx + cw, cy, ICON.team, label, "ally" .. at, function()
				playClick(); selectedAlly = at; selected = aisOfAlly(at)[1]; listScroll = 0
				svc.notifySelect()   -- D-498: lanes and blueprints follow in BARb plans
			end, string.format("Show team %d's AIs (%d)", at + 1, #aisOfAlly(at)), at == selectedAlly)
			cx = cx + cw + px(4)
			if cx > right - px(40) then break end
		end
		cy = cy - chH - px(5)
	end

	-- the AI list
	local ids = aisOfAlly(selectedAlly)
	local rowH = px(19)
	local maxRows = mathMin(5, mathMax(1, #ids))
	local listH = maxRows * rowH
	listScroll = mathMax(0, mathMin(listScroll, mathMax(0, #ids - maxRows)))
	if #ids == 0 then
		text(font, #aiOrder == 0 and "No allied BARb AI in this game." or "No AI on this team.", left, cy - px(12), px(9.5), "o", C.onSurfaceVariant)
		cy = cy - px(18)
	else
		roundRect(left, cy - listH, right, cy, px(4), C.surfaceHigh)
		for i = 1, maxRows do
			local id = ids[i + listScroll]
			if not id then break end
			local a = ais[id]
			local ry2 = cy - (i - 1) * rowH
			local ry1 = ry2 - rowH
			local sel = (id == selected)
			if sel then roundRect(left + px(1), ry1 + px(1), right - px(1), ry2 - px(1), px(3), C.primaryContainer) end
			stateLayer(left + px(1), ry1 + px(1), right - px(1), ry2 - px(1), px(3), "row" .. id)
			roundRect(left + px(6), ry1 + rowH / 2 - px(4), left + px(14), ry1 + rowH / 2 + px(4), px(4), a.color)
			local role = a.roster and a.roster.role or nil
			local rx = right - px(4)
			if role then
				local rw = textWidth(font, role, px(8.5))
				text(font, role, rx, ry1 + rowH * 0.5 - px(3.2), px(8.5), "or", sel and C.primary or C.onSurfaceVariant)
				rx = rx - rw - px(3)
				icon(ICON[role], rx - px(13), ry1 + px(3), rx, ry1 + rowH - px(3), sel and C.primary or C.onSurfaceVariant)
				rx = rx - px(16)
			end
			if a.roster and a.roster.leader then
				icon(ICON.lead, rx - px(11), ry1 + px(4), rx, ry1 + rowH - px(4), C.primary)
				rx = rx - px(14)
			end
			text(font, fitText(font, a.name, px(9.5), rx - left - px(22)), left + px(19), ry1 + rowH * 0.5 - px(3.4), px(9.5), "o", sel and C.onSurface or C.onSurfaceVariant)
			register(left, ry1, right, ry2, "row" .. id, function()
				playClick()
				local now = Spring.GetTimer()
				if selected == id and lastRowClick and Spring.DiffTimers(now, lastRowClick) < 0.4 then goTo(id) end
				selected = id
				svc.notifySelect()   -- D-498: lanes and blueprints follow in BARb plans
				lastRowClick = now
			end,
				string.format("Team %d: %s%s", id, a.name, a.roster and (", " .. a.roster.role .. ", " .. (a.roster.side or "?")) or ""))
		end
		if #ids > maxRows then
			text(font, string.format("%d-%d of %d, scroll", listScroll + 1, listScroll + maxRows, #ids), right, cy - listH - px(9), px(7.5), "or", C.onSurfaceVariant)
		end
		cy = cy - listH - px(12)
	end

	-- D-506: the tab bar; a registered tab draws the rest of the window
	cy = svc.drawTabBar(left, right, cy)
	if svc.activeTab ~= "ai" then
		local t = svc.findTab(svc.activeTab)
		if t then
			local ok, err = pcall(t.draw, svc.tabKit(), left, right, cy, y1 + pad)
			if not ok then spEcho("[BARb link] tab " .. tostring(t.id) .. " error: " .. tostring(err)); svc.activeTab = "ai" end
			return
		end
	end

	-- the selected AI: details, role grid, query
	local e = selected and ais[selected]
	if e then
		local r = e.roster
		local cmd = mayCommand(e.teamId)
		local line
		if r then
			line = string.format("team %d · %s · start %d, %d · %s%s", e.teamId, r.side or "?", r.x or 0, r.z or 0, r.factory or "-", r.landLocked and " · landlocked" or "")
		else
			line = (firstAnnounceFrame == nil and spGetGameFrame() > 60 * 30) and "no announcement: is this AI hosted here?" or "waiting for the AI's announcement"
		end
		local qs = px(18)
		local qx = iconButton(right - qs, cy - qs + px(3), qs, ICON.query, "query", function() playClick(); send(e.teamId, "barb|query|" .. e.teamId) end,
			"Ask this AI for its details", false, "?")
		iconButton(qx, cy - qs + px(3), qs, ICON.camera, "goto", function() playClick(); goTo(e.teamId) end,
			"Fly the camera to this AI's commander (else its factory nearest its start); double-click a row does the same", false, ">")
		text(font, fitText(font, line, px(8.5), w - 2 * qs - px(6)), left, cy - px(10), px(8.5), "o", C.onSurfaceVariant)
		cy = cy - px(18)

		local segH = px(22)
		local sgap = px(3)
		local segW = (w - 2 * sgap) / 3
		for i, role in ipairs(ROLES) do
			local row = mathFloor((i - 1) / 3)
			local col = (i - 1) % 3
			local sx1 = left + col * (segW + sgap)
			local sy2 = cy - row * (segH + sgap)
			local active = r and r.role == role
			labelButton(sx1, sy2 - segH, sx1 + segW, sy2, ICON[role], role, "role" .. role, function()
				if active then return end
				playClick()
				requestRole(e.teamId, role)
			end, role .. ": " .. (ROLE_HINT[role] or "") .. (cmd and "" or " (only this AI's host can switch its role)"), active, cmd)
		end
		cy = cy - 2 * segH - sgap - px(4)
        local value=(aggressionDrag and aggressionDrag.team==e.teamId) and aggressionDrag.value or (e.aggression or 0)
        text(font, string.format("Aggression %+.2f",value),left,cy-px(11),px(9),"o",C.onSurfaceVariant)
        local ax1,ax2,ay=left+px(105),right-px(35),cy-px(8)
        roundRect(ax1,ay-px(2),ax2,ay+px(2),px(2),C.onSurfaceVariant)
        glColor(C.onSurfaceVariant); glRect((ax1+ax2)/2,ay-px(5),(ax1+ax2)/2+px(1),ay+px(5))
        local knob=ax1+(value+1)*.5*(ax2-ax1)
        roundRect(knob-px(4),ay-px(6),knob+px(4),ay+px(6),px(3),cmd and C.ok or C.onSurfaceVariant)
        hit[#hit+1]={ax1,ay-px(10),ax2,ay+px(10),"aggression",function() end,
            "Aggression offset: -1 defensive, 0 automatic, +1 aggressive. Drag, then release to apply to this AI.",cmd and e.teamId or nil}
        labelButton(right-px(31),cy-px(18),right,cy, nil,"0","aggressionReset",function()
            requestAggression(e.teamId,0)
        end,"Reset this AI's aggression offset to zero",false,cmd)
        cy=cy-px(25)
		local replyColor = C.onSurfaceVariant
		if e.replyKind == "ok" then replyColor = C.ok elseif e.replyKind == "warn" then replyColor = C.warn end
		text(font, fitText(font, e.lastReply and ("reply: " .. e.lastReply) or (cmd and "pick a role to switch this AI" or "read-only: this AI is not hosted by you"), px(8.5), w),
			left, cy - px(9), px(8.5), "o", replyColor)
		cy = cy - px(14)
	end
	divider(x1 + px(4), x2 - px(4), cy)
	cy = cy - px(4)

	-- events
	local bottom = y1 + pad
	local lineH = px(12)
	local rows = mathFloor((cy - bottom) / lineH)
	if rows >= 1 then
		local total = #events
		eventScroll = mathMax(0, mathMin(eventScroll, mathMax(0, total - rows)))
		local shown = 0
		for i = total - eventScroll, 1, -1 do
			if shown >= rows then break end
			local ev = events[i]
			local ey = cy - shown * lineH
			local col = C.onSurfaceVariant
			if ev.kind == "ok" then col = C.ok elseif ev.kind == "warn" then col = C.warn elseif ev.kind == "error" then col = C.error end
			text(font, frameToClock(ev.frame), left, ey - px(9.5), px(8), "o", C.onSurfaceVariant)
			text(font, fitText(font, ev.text, px(8), w - px(30)), left + px(30), ey - px(9.5), px(8), "o", col)
			shown = shown + 1
		end
		if total == 0 then text(font, "No events yet.", left, cy - px(9.5), px(8.5), "o", C.onSurfaceVariant) end
	end
end

function widget:DrawScreen()
	hit = {}
	if not hasFlowUI or not font then initFlowUI() end
	updatePlacement()
	drawLauncher()
	if open then drawWindow() end

	local mx, my = spGetMouseState()
	local newHover = nil
	for _, r in ipairs(hit) do
		if inside(mx, my, r[1], r[2], r[3], r[4]) and r[5] ~= "header" then newHover = r[5] end
	end
	hoverId = newHover
	glColor(1, 1, 1, 1)
end

-- ---------------------------------------------------------------- input

local function overLauncher(mx, my) return inside(mx, my, launcher.x1, launcher.y1, launcher.x2, launcher.y2) end
local function overWindow(mx, my) return open and inside(mx, my, win.x1, win.y1, win.x2, win.y2) end

function widget:IsAbove(mx, my)
	return overLauncher(mx, my) or overWindow(mx, my)
end

function widget:GetTooltip(mx, my)
	local tip = nil
	for _, r in ipairs(hit) do
		if inside(mx, my, r[1], r[2], r[3], r[4]) and r[7] then tip = r[7] end
	end
	return tip
end

function widget:MousePress(mx, my, mb)
	if not (overLauncher(mx, my) or overWindow(mx, my)) then return false end
	if mb ~= 1 then return true end
	local top = nil
	for _, r in ipairs(hit) do
		if inside(mx, my, r[1], r[2], r[3], r[4]) then top = r end
	end
	if top and top[5] == "header" then
		dragging = { mx, my, offX, offY }
		return true
	end
    if top and top[5]=="aggression" then
        if top[8] then
            aggressionDrag={team=top[8],x1=top[1],x2=top[3],value=0}
            dragAggression(mx)
        end
        return true
    end
	if top then pressedId = top[5] end
	return true
end

function widget:MouseMove(mx, my, dx, dy, mb)
    if aggressionDrag then dragAggression(mx); return end
	if dragging then
		offX = dragging[3] + (mx - dragging[1])
		offY = dragging[4] + (my - dragging[2])
		updatePlacement()
	end
end

function widget:MouseRelease(mx, my, mb)
    if aggressionDrag then
        dragAggression(mx)
        requestAggression(aggressionDrag.team,aggressionDrag.value)
        aggressionDrag=nil
        return false
    end
	if dragging then
		dragging = nil
		return false
	end
	if pressedId then
		for _, r in ipairs(hit) do
			if r[5] == pressedId and inside(mx, my, r[1], r[2], r[3], r[4]) then
				pressedId = nil
				r[6]()
				return false
			end
		end
		pressedId = nil
	end
	return false
end

function widget:MouseWheel(up, value)
	local mx, my = spGetMouseState()
	if not overWindow(mx, my) then return false end
	-- over the AI list: scroll the list; elsewhere: the events
	for _, r in ipairs(hit) do
		if string.sub(r[5], 1, 3) == "row" and inside(mx, my, r[1], r[2], r[3], r[4]) then
			listScroll = listScroll + (up and -1 or 1)
			return true
		end
	end
	-- D-506: elsewhere on a registered tab, the tab scrolls (its list)
	local t = svc.activeTab ~= "ai" and svc.findTab(svc.activeTab) or nil
	if t then
		if t.onWheel then pcall(t.onWheel, up) end
		return true
	end
	eventScroll = eventScroll + (up and 1 or -1)
	return true
end

function widget:TextCommand(cmd)
	if cmd == "barblink" then setOpen(not open); return true end
	return false
end

function widget:KeyPress(key, mods, isRepeat)
	if key == 98 and mods.ctrl and mods.alt and not isRepeat then   -- b: the AI tab (D-506)
		if open and svc.activeTab == "ai" then setOpen(false) else svc.activeTab = "ai"; setOpen(true) end
		return true
	end
	-- Escape closes this window only while the mouse is over it, so one key
	-- never closes several BARb windows (D-498).
	if key == 27 and open then
		local mx, my = spGetMouseState()
		if overWindow(mx, my) then setOpen(false); return true end
	end
	return false
end

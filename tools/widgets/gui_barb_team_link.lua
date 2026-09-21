-- BARb team link
--
-- An "AI" tab beside the player list. The game's bottom-right player list
-- (AdvPlayersList) gets a two-tab strip docked on top of its stack - "Player"
-- and "AI". The AI tab opens a panel of the list's width ABOVE the strip, so
-- it adds to the stack and covers nothing: a Team menu and an AI menu at the
-- top, and under them the selected AI's status, its role selector (switches
-- the AI's role at runtime), the actions and the event log. "Player" folds
-- the panel away and leaves the strip.
--
-- Install: copy into <BAR data dir>/LuaUI/Widgets/ and enable it (F11).
-- Toggle the tab: click it, /barblink, or Ctrl+Alt+B. Escape returns to Player.
--
-- Layout overlay (D-053): the Overlay button or /barblayout draws every
-- allied BARb's planned base on the ground - grey zones, red corridors, green
-- armed slots, yellow held slots, cyan slots being built, blue built, orange
-- tenants - and an arrow from the complex's origin toward its front.
--
-- Both directions only work on the machine that runs the AIs (the host),
-- playing or spectating:
--   AI -> widget   ai.CallUI  -> RecvSkirmishAIMessage(aiTeam, "barb|<topic>|<team>|<allyTeam>|<payload>")
--   widget -> AI   Spring.SendSkirmishAIMessage(teamId, "barb|<command>|<teamId>|...")
-- Commands carry the target team id and the AI ignores any other; the widget
-- never broadcasts, so hosting two ally teams locally cannot cross-steer them.
-- Wire formats: data/script/src/manager/widget_link.as and commands.as.
--
-- Docking follows the player list's module convention (unit totals, game
-- info, music, mascot): every module publishes GetPosition() = { top, left,
-- bottom, right, scale } and the next one stacks on it. This widget stacks on
-- whatever is topmost and publishes WG.barblink.GetPosition() for anything
-- that wants to stack on it in turn. Nothing overlaps: the strip sits on the
-- stack's top edge and the panel, when open, sits on the strip.
--
-- The game's widget handler orders both drawing and mouse input by layer with
-- the LOWEST layer on top (DrawScreen runs the list reversed, MousePress runs
-- it forwards); -6 keeps this widget above anything drawn in the corner.
--
-- Styling follows the game's FlowUI (WG.FlowUI element, rounded rects,
-- fonts) on Material 3 patterns at compact density: exposed dropdown menus
-- for Team and AI, assist chips for status, a segmented button for the role,
-- text buttons for actions, a dense list for events.

function widget:GetInfo()
	return {
		name    = "BARb team link",
		desc    = "Allied BARb AIs as an AI tab beside the player list: roster, events, runtime role switching (host only)",
		author  = "s3k-CircuitAI",
		date    = "2026-09-20",
		layer   = -6,     -- lowest layer is on top in this handler: drawn last, first to the mouse; the widget overlaps nothing
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
local MAX_EVENTS = 80
local QUERY_INTERVAL_FRAMES = 1800
local STRIP_HEIGHT = 20          -- the tab strip, unscaled px (the unit-totals module is 22)
local PANEL_HEIGHT = 236         -- the open AI panel, unscaled px; clamped to the screen

-- Material 3 dark scheme, mapped onto the game's warm accent
local C = {
	onSurface        = { 0.92, 0.92, 0.92, 1 },
	onSurfaceVariant = { 0.66, 0.66, 0.68, 1 },
	outline          = { 1, 1, 1, 0.14 },
	outlineStrong    = { 1, 1, 1, 0.3 },
	primary          = { 1, 0.9, 0.66, 1 },        -- BAR's tab accent
	primaryContainer = { 1, 0.9, 0.66, 0.22 },
	surfaceLow       = { 1, 1, 1, 0.035 },
	surfaceHigh      = { 1, 1, 1, 0.08 },
	surfaceMenu      = { 0.13, 0.13, 0.14, 0.98 },
	hoverLayer       = { 1, 1, 1, 0.08 },
	pressLayer       = { 1, 1, 1, 0.12 },
	ok               = { 0.55, 0.85, 0.55, 1 },
	warn             = { 1, 0.75, 0.4, 1 },
	error            = { 1, 0.5, 0.5, 1 },
}
local SOUND_CLICK = "LuaUI/Sounds/buildbar_click.wav"
local SOUND_HOVER = "LuaUI/Sounds/hover.wav"

-- ---------------------------------------------------------------- engine locals

local glColor, glRect, glText = gl.Color, gl.Rect, gl.Text
local spEcho, spGetGameFrame, spGetMouseState = Spring.Echo, Spring.GetGameFrame, Spring.GetMouseState
local spGetTeamList, spGetTeamInfo, spGetAIInfo, spGetTeamColor = Spring.GetTeamList, Spring.GetTeamInfo, Spring.GetAIInfo, Spring.GetTeamColor
local spGetMyTeamID, spAreTeamsAllied, spGetSpectatingState = Spring.GetMyTeamID, Spring.AreTeamsAllied, Spring.GetSpectatingState
local spSendSkirmishAIMessage, spPlaySoundFile = Spring.SendSkirmishAIMessage, Spring.PlaySoundFile
local mathFloor, mathMax, mathMin = math.floor, math.max, math.min

-- Only teams allied with the local player are listed, drawn and commanded
-- (CR-008): a host running both sides must not see the enemy BARb's plan
-- or steer its builders. A spectator sees every AI's overlay but may route
-- none of them.
local function isSpectator()
	return spGetSpectatingState() == true
end

local function isPermittedTeam(teamId)
	if isSpectator() then return true end
	return spAreTeamsAllied(teamId, spGetMyTeamID()) == true
end

local function mayCommand(teamId)
	if isSpectator() then return false end
	return spAreTeamsAllied(teamId, spGetMyTeamID()) == true
end

-- ---------------------------------------------------------------- state

local vsx, vsy = Spring.GetViewGeometry()
local scale = 1
local RectRound, RectRoundOutline, UiElement
local font, font2
local hasFlowUI = false

local strip = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }
local panel = { x1 = 0, y1 = 0, x2 = 0, y2 = 0 }
local docked = false
local activeTab = "player"       -- "player" | "ai"

local hit = {}                   -- rebuilt every draw: { x1, y1, x2, y2, id, action }
local menuHit = {}               -- the open menu's items, checked before `hit`
local hoverId, pressedId = nil, nil
local lastHoverSoundId = nil
local openMenu = nil             -- "team" | "ai" | nil
local menuRect = nil             -- { x1, y1, x2, y2 } of the open menu

local ais = {}                   -- teamId -> { teamId, name, shortName, color, allyTeam, roster, lastReply, replyKind }
local aiOrder = {}
local allyTeams = {}             -- sorted ally team ids that have a permitted AI
local selectedAlly = nil
local selected = nil
local events = {}
local eventScroll = 0
local lastQueryFrame = -1
local firstAnnounceFrame = nil

-- ---------------------------------------------------------------- helpers

local function split(s, sep)
	local out = {}
	for piece in string.gmatch(s .. sep, "([^" .. sep .. "]*)" .. sep) do
		out[#out + 1] = piece
	end
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
	local list = spGetTeamList() or {}
	for _, teamId in ipairs(list) do
		local _, _, isDead, isAI, _, allyTeam = spGetTeamInfo(teamId)
		if isAI and not isDead and isPermittedTeam(teamId) then
			local _, name, _, shortName = spGetAIInfo(teamId)
			local r, g, b = spGetTeamColor(teamId)
			local e = ais[teamId] or { teamId = teamId }
			e.name = name or ("AI " .. teamId)
			e.shortName = shortName or ""
			e.allyTeam = allyTeam or 0
			e.color = { r or 1, g or 1, b or 1, 1 }
			ais[teamId] = e
		end
	end
	aiOrder = {}
	for id in pairs(ais) do aiOrder[#aiOrder + 1] = id end
	table.sort(aiOrder, function(a, b)
		local ea, eb = ais[a], ais[b]
		if (ea.allyTeam or 0) ~= (eb.allyTeam or 0) then return (ea.allyTeam or 0) < (eb.allyTeam or 0) end
		return a < b
	end)
	allyTeams = {}
	local seen = {}
	for _, id in ipairs(aiOrder) do
		local at = ais[id].allyTeam or 0
		if not seen[at] then seen[at] = true; allyTeams[#allyTeams + 1] = at end
	end
	table.sort(allyTeams)
	-- keep the selection valid: the player's own ally team first
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
	if not ok then
		addEvent(string.format("Team %d: no local AI received the command (not hosted here?)", teamId), "warn")
	end
	return ok
end

local function queryAll()
	for _, id in ipairs(aiOrder) do send(id, "barb|query|" .. id) end
	lastQueryFrame = spGetGameFrame()
end

local function playClick() spPlaySoundFile(SOUND_CLICK, 0.5, "ui") end

local function setTab(tab)
	activeTab = tab
	openMenu = nil
	if tab == "ai" then refreshTeams() end
	if tab ~= "ai" and WG.guishader then WG.guishader.RemoveRect("barblink") end
end

-- ---------------------------------------------------------------- docking

-- The topmost published position of the player-list stack: { top, left, bottom, right, scale }.
local function stackTop()
	local function tableOf(f)
		local p1, p2, p3, p4, p5 = f()
		if type(p1) == "table" then return p1 end
		if type(p1) == "number" and p5 then return { p1, p2, p3, p4, p5 } end
		return nil
	end
	if WG.advplayerlist_mascot and WG.advplayerlist_mascot.GetPosition then
		local p = tableOf(WG.advplayerlist_mascot.GetPosition)
		if p and p[1] then return p end
	end
	if WG.displayinfo and WG.displayinfo.GetPosition then
		local p = tableOf(WG.displayinfo.GetPosition)
		if p and p[1] then return p end
	end
	if WG.unittotals and WG.unittotals.GetPosition then
		local p = tableOf(WG.unittotals.GetPosition)
		if p and p[1] then return p end
	end
	if WG.music and WG.music.GetPosition then
		local p = tableOf(WG.music.GetPosition)
		if p and p[1] then return p end
	end
	if WG.advplayerlist_api and WG.advplayerlist_api.GetPosition then
		return WG.advplayerlist_api.GetPosition()
	end
	return nil
end

-- The strip sits on the top edge of the stack; the open panel sits on the
-- strip. Both take the list's width. Nothing is covered.
local function updateDock()
	local listPos = WG.advplayerlist_api and WG.advplayerlist_api.GetPosition and WG.advplayerlist_api.GetPosition()
	local top = stackTop()
	local x1, x2, base
	if listPos and listPos[1] and top and top[1] then
		docked = true
		scale = listPos[5] or 1
		x1, x2, base = listPos[2], listPos[4], mathFloor(top[1])
	else
		docked = false
		scale = (vsy / 1080) * (1 + (Spring.GetConfigFloat("ui_scale", 1) - 1) / 1.25)
		x1, x2, base = vsx - mathFloor(220 * scale), vsx, 0
	end
	local stripH = mathFloor(STRIP_HEIGHT * scale)
	strip.x1, strip.x2, strip.y1, strip.y2 = x1, x2, base, base + stripH
	local panelH = mathMin(mathFloor(PANEL_HEIGHT * scale), mathMax(0, vsy - strip.y2 - mathFloor(4 * scale)))
	panel.x1, panel.x2 = x1, x2
	panel.y1 = strip.y2
	panel.y2 = strip.y2 + ((activeTab == "ai") and panelH or 0)
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
	updateDock()
end

function widget:Initialize()
	self:ViewResize(Spring.GetViewGeometry())
	refreshTeams()
	WG.barblink = {}
	---Where this widget's stack ends, so a neighbour can stack against it: { top, left, bottom, right, scale }.
	WG.barblink.GetPosition = function()
		local top = (activeTab == "ai") and panel.y2 or strip.y2
		return { top, strip.x1, strip.y1, strip.x2, scale }
	end
end

function widget:Shutdown()
	WG.barblink = nil
	if WG.guishader then
		WG.guishader.RemoveRect("barblink")
		WG.guishader.RemoveRect("barblinkstrip")
	end
end

function widget:GetConfigData()
	return { tab = activeTab }
end

function widget:SetConfigData(data)
	if data and (data.tab == "player" or data.tab == "ai") then activeTab = data.tab end
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

function widget:RecvSkirmishAIMessage(aiTeam, dataStr)
	if type(dataStr) ~= "string" or string.sub(dataStr, 1, 5) ~= "barb|" then return end
	local p = split(dataStr, "|")
	local topic, sender, senderAlly = p[2], tonumber(p[3]), tonumber(p[4])
	if sender and not ais[sender] then refreshTeams() end
	local e = sender and ais[sender]
	if e and senderAlly then e.allyTeam = senderAlly end
	if topic == "roster" then
		local r = parseRoster(table.concat(p, "|", 6))
		if r and ais[r.teamId] then
			local target = ais[r.teamId]
			firstAnnounceFrame = firstAnnounceFrame or spGetGameFrame()
			if not target.roster then
				addEvent(string.format("Team %d announced: %s, %s, start (%d, %d)%s", r.teamId, r.role, r.side, r.x or 0, r.z or 0,
					r.leader and ", lead team" or ""), "info")
			elseif target.roster.role ~= r.role then
				addEvent(string.format("Team %d role changed: %s to %s", r.teamId, target.roster.role, r.role), "ok")
			end
			target.roster = r
		end
	elseif topic == "role" and e then
		local role, status = p[5] or "?", p[6] or ""
		e.lastReply = string.format("%s: %s", role, status)
		e.replyKind = (status == "ok") and "ok" or ((string.sub(status, 1, 7) == "already") and "info" or "warn")
		if status == "ok" and e.roster then e.roster.role = role end
		addEvent(string.format("Team %d replied: %s (%s)", sender, status, role), e.replyKind)
	elseif topic == "orphan" and e then
		addEvent(string.format("Team %d orphan rescue: %s", sender, table.concat(p, " ", 5)), "warn")
		spEcho("[BARb link] team " .. sender .. " orphan " .. table.concat(p, " ", 5))
	elseif topic == "donation" and e then
		addEvent(string.format("Team %d gave %s to team %s (%s of %s)", sender, p[5] or "?", p[6] or "?", p[7] or "?", p[8] or "?"), "ok")
	elseif topic == "ferry" and e then
		addEvent(string.format("Team %d ferry: %s", sender, table.concat(p, " ", 5)), "info")
	elseif topic == "layout" and sender then
		layoutReceive(sender, tonumber(p[5]) or 0, tonumber(p[6]) or 0, table.concat(p, "|", 7))
	end
end

-- ---------------------------------------------------------------- layout overlay (D-053)

layoutShown = false
local layoutData = {}   -- [teamId] = { parts = {}, total = n, entries = {...} }
local glDrawGroundQuad, glLineWidth, glBeginEnd, glVertex, glDepthTest = gl.DrawGroundQuad, gl.LineWidth, gl.BeginEnd, gl.Vertex, gl.DepthTest
local GL_LINES = GL.LINES
local spGetGroundHeight = Spring.GetGroundHeight
local LAYOUT_COLOURS = {
	zone = {0.65, 0.65, 0.65, 0.18},
	corridor = {0.9, 0.2, 0.2, 0.22},
	p = {0.2, 0.9, 0.2, 0.35},   -- planned, armed
	h = {0.9, 0.8, 0.2, 0.30},   -- held
	s = {0.2, 0.8, 0.9, 0.40},   -- served, being built
	b = {0.2, 0.4, 1.0, 0.45},   -- built
	t = {1.0, 0.6, 0.1, 0.35},   -- tenant
}

local function layoutParse(teamId, text)
	local entries = {}
	for _, item in ipairs(split(text, ";")) do
		local f = split(item, ":")
		if #f >= 8 then
			entries[#entries + 1] = {
				kind = f[1], name = f[2], x = tonumber(f[3]) or 0, z = tonumber(f[4]) or 0, facing = tonumber(f[5]) or 0,
				w = tonumber(f[6]) or 0, d = tonumber(f[7]) or 0, state = f[8],
			}
		end
	end
	layoutData[teamId].entries = entries
	local slots, built = 0, 0
	for _, e in ipairs(entries) do
		if e.kind == "slot" then slots = slots + 1; if e.state:sub(1, 1) == "b" then built = built + 1 end end
	end
	addEvent(string.format("Team %d layout: %d slots, %d built", teamId, slots, built), "info")
end

function layoutReceive(teamId, idx, total, payload)
	if not isPermittedTeam(teamId) then return end   -- CR-008: never draw a non-allied plan
	if total <= 0 then
		layoutData[teamId] = nil
		addEvent(string.format("Team %d has no planned layout", teamId), "info")
		return
	end
	local d = layoutData[teamId]
	if not d or idx == 1 then d = { parts = {}, total = total, entries = {} }; layoutData[teamId] = d end
	d.parts[idx] = payload
	d.total = total
	for i = 1, total do if not d.parts[i] then return end end
	layoutParse(teamId, table.concat(d.parts, "", 1, total))
	d.parts = {}
end

local function setOverlay(on)
	layoutShown = on
	refreshTeams()
	for _, id in ipairs(aiOrder) do send(id, "barb|layout|" .. id .. "|" .. (layoutShown and "on" or "off")) end
	addEvent(layoutShown and "Layout overlay on: zones grey, corridors red, slots green (armed) / yellow (held) / cyan (building) / blue (built), tenants orange"
		or "Layout overlay off", "info")
end

local FACING_DIR = { [0] = {0, 1}, [1] = {1, 0}, [2] = {0, -1}, [3] = {-1, 0} }

function widget:DrawWorld()
	if not layoutShown then return end
	glDepthTest(false)
	for teamId, d in pairs(layoutData) do
		for _, e in ipairs(d.entries or {}) do
			if e.kind == "complex" then
				local dir = FACING_DIR[e.facing] or FACING_DIR[0]
				local x1, z1 = e.x, e.z
				local x2, z2 = e.x + dir[1] * 240, e.z + dir[2] * 240
				glColor(1, 1, 1, 0.9)
				glLineWidth(3)
				glBeginEnd(GL_LINES, function()
					glVertex(x1, spGetGroundHeight(x1, z1) + 8, z1)
					glVertex(x2, spGetGroundHeight(x2, z2) + 8, z2)
				end)
				glLineWidth(1)
			elseif e.w > 0 and e.d > 0 then
				local c
				if e.kind == "zone" or e.kind == "corridor" then
					c = LAYOUT_COLOURS[e.kind]
				else
					c = LAYOUT_COLOURS[e.state:sub(1, 1)] or LAYOUT_COLOURS.p
					if e.state:sub(2, 2) == "t" and e.state:sub(1, 1) ~= "b" then c = LAYOUT_COLOURS.t end
				end
				glColor(c[1], c[2], c[3], c[4])
				local hw, hd = e.w / 2 - 2, e.d / 2 - 2
				glDrawGroundQuad(e.x - hw, e.z - hd, e.x + hw, e.z + hd)
			end
		end
	end
	glColor(1, 1, 1, 1)
	glDepthTest(true)
end

-- ---------------------------------------------------------------- drawing primitives

local function px(v) return mathFloor(v * scale + 0.5) end

local function inside(x, y, x1, y1, x2, y2)
	return x >= x1 and x <= x2 and y >= y1 and y <= y2
end

local function roundRect(x1, y1, x2, y2, cs, color, color2)
	if hasFlowUI then
		RectRound(x1, y1, x2, y2, cs, 1, 1, 1, 1, color, color2 or color)
	else
		glColor(color)
		glRect(x1, y1, x2, y2)
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
		glColor(color)
		glText(s, x, y, size, opts or "o")
	end
end

local function textWidth(f, s, size)
	if f then return f:GetTextWidth(s) * size end
	return gl.GetTextWidth(s) * size
end

local function fitText(f, s, size, maxW)
	local out = s
	while textWidth(f, out, size) > maxW and #out > 3 do
		out = string.sub(out, 1, #out - 2) .. "."
	end
	return out
end

local function stateLayer(x1, y1, x2, y2, cs, id)
	if pressedId == id then
		roundRect(x1, y1, x2, y2, cs, C.pressLayer)
	elseif hoverId == id then
		roundRect(x1, y1, x2, y2, cs, C.hoverLayer)
	end
end

local function register(x1, y1, x2, y2, id, action)
	hit[#hit + 1] = { x1, y1, x2, y2, id, action }
end

local function registerMenu(x1, y1, x2, y2, id, action)
	menuHit[#menuHit + 1] = { x1, y1, x2, y2, id, action }
end

local function divider(x1, x2, y)
	glColor(C.outline)
	glRect(x1, y, x2, y + mathMax(1, px(1)))
end

-- M3 assist chip, compact density
local function chip(x, y, label, filled, color)
	local h = px(15)
	local w = textWidth(font, label, px(9)) + px(11)
	if filled then
		roundRect(x, y, x + w, y + h, px(4), color or C.primaryContainer)
	else
		outlineRect(x, y, x + w, y + h, px(4), C.outlineStrong)
	end
	text(font, label, x + w / 2, y + h * 0.5 - px(3.3), px(9), "oc", filled and C.onSurface or C.onSurfaceVariant)
	return x + w + px(4)
end

-- M3 text / tonal button, compact
local function button(x1, y1, x2, y2, label, id, action, tonal)
	local cs = px(4)
	if tonal then roundRect(x1, y1, x2, y2, cs, C.primaryContainer) end
	stateLayer(x1, y1, x2, y2, cs, id)
	text(font2, label, (x1 + x2) / 2, y1 + (y2 - y1) * 0.5 - px(3.8), px(10), "oc", tonal and C.onSurface or C.primary)
	register(x1, y1, x2, y2, id, action)
end

-- M3 exposed dropdown menu (outlined text field with a trailing arrow); the
-- open menu is drawn last so it overlays the content below it.
local function dropdown(x1, y1, x2, y2, label, value, id, valueColor)
	local cs = px(4)
	local open = (openMenu == id)
	outlineRect(x1, y1, x2, y2, cs, open and C.primary or C.outlineStrong)
	if open then roundRect(x1 + px(1), y1 + px(1), x2 - px(1), y2 - px(1), cs, C.surfaceLow) end
	stateLayer(x1, y1, x2, y2, cs, "dd" .. id)
	-- floating label on the top edge
	local lw = textWidth(font, label, px(7.5))
	glColor(0.07, 0.07, 0.08, 1)
	glRect(x1 + px(7), y2 - px(3), x1 + px(9) + lw, y2 + px(3))
	text(font, label, x1 + px(8), y2 - px(2.5), px(7.5), "o", open and C.primary or C.onSurfaceVariant)
	text(font, fitText(font, value, px(10), x2 - x1 - px(24)), x1 + px(8), y1 + (y2 - y1) * 0.5 - px(3.5), px(10), "o", valueColor or C.onSurface)
	text(font2, open and "\226\150\180" or "\226\150\190", x2 - px(11), y1 + (y2 - y1) * 0.5 - px(3.5), px(9), "oc", C.onSurfaceVariant)
	register(x1, y1, x2, y2, "dd" .. id, function()
		playClick()
		openMenu = (openMenu == id) and nil or id
	end)
end

-- the open menu's list, drawn after everything else
local function drawMenu(x1, x2, yTop, items, onPick)
	local rowH = px(18)
	local h = mathMax(1, #items) * rowH + px(6)
	local y1 = yTop - h
	if y1 < panel.y1 then y1 = panel.y1; yTop = y1 + h end
	menuRect = { x1, y1, x2, yTop }
	roundRect(x1, y1, x2, yTop, px(4), C.surfaceMenu)
	outlineRect(x1, y1, x2, yTop, px(4), C.outlineStrong)
	if WG.guishader then WG.guishader.InsertRect(x1, y1, x2, yTop, "barblinkmenu", widget) end
	local y = yTop - px(3)
	if #items == 0 then
		text(font, "nothing", x1 + px(8), y - rowH * 0.5 - px(3.5), px(10), "o", C.onSurfaceVariant)
	end
	for _, it in ipairs(items) do
		local iy1, iy2 = y - rowH, y
		local mid = "mi" .. it.id
		if it.selected then roundRect(x1 + px(2), iy1, x2 - px(2), iy2, px(3), C.primaryContainer) end
		stateLayer(x1 + px(2), iy1, x2 - px(2), iy2, px(3), mid)
		local tx = x1 + px(8)
		if it.color then
			roundRect(tx, iy1 + rowH / 2 - px(3.5), tx + px(7), iy1 + rowH / 2 + px(3.5), px(3.5), it.color)
			tx = tx + px(11)
		end
		text(font, fitText(font, it.label, px(10), x2 - tx - px(6)), tx, iy1 + rowH * 0.5 - px(3.5), px(10), "o", it.selected and C.onSurface or C.onSurfaceVariant)
		registerMenu(x1, iy1, x2, iy2, mid, function() playClick(); onPick(it); openMenu = nil end)
		y = y - rowH
	end
end

-- ---------------------------------------------------------------- draw: the tab strip

local function drawStrip()
	local x1, y1, x2, y2 = strip.x1, strip.y1, strip.x2, strip.y2
	local open = (activeTab == "ai")
	if hasFlowUI then
		UiElement(x1, y1, x2, y2, open and 0 or 1, open and 0 or 1, 0, 0, 1, 1, 1, 1, WG.FlowUI.clampedOpacity)
	else
		glColor(0.08, 0.08, 0.09, 0.92)
		glRect(x1, y1, x2, y2)
	end
	if WG.guishader then WG.guishader.InsertRect(x1, y1, x2, y2, "barblinkstrip", widget) end
	local tabs = { { id = "player", label = "Player" }, { id = "ai", label = "AI" } }
	local tabW = (x2 - x1) / #tabs
	for i, t in ipairs(tabs) do
		local tx1 = x1 + (i - 1) * tabW
		local tx2 = tx1 + tabW
		local active = (activeTab == t.id)
		local hid = "strip" .. t.id
		stateLayer(tx1, y1, tx2, y2, px(3), hid)
		if i > 1 then
			glColor(C.outlineStrong)
			glRect(tx1, y1 + px(4), tx1 + mathMax(1, px(1)), y2 - px(4))
		end
		text(font2, t.label, (tx1 + tx2) / 2, y1 + (y2 - y1) * 0.5 - px(4), px(10.5), "oc", active and C.onSurface or C.onSurfaceVariant)
		if active then
			roundRect(tx1 + px(10), y1, tx2 - px(10), y1 + px(2), px(1), C.primary)
		end
		register(tx1, y1, tx2, y2, hid, function() playClick(); setTab(t.id) end)
	end
end

-- ---------------------------------------------------------------- draw: the AI panel, in the list's frame

local function drawPanel()
	local x1, y1, x2, y2 = panel.x1, panel.y1, panel.x2, panel.y2
	local w, h = x2 - x1, y2 - y1
	if w < px(80) or h < px(40) then return end
	if hasFlowUI then
		UiElement(x1, y1, x2, y2, 1, 1, 0, 0, 1, 1, 1, 1, WG.FlowUI.clampedOpacity)
	else
		glColor(0.08, 0.08, 0.09, 0.92)
		glRect(x1, y1, x2, y2)
	end
	if WG.guishader then WG.guishader.InsertRect(x1, y1, x2, y2, "barblink", widget) end

	local pad = px(6)
	local left, right = x1 + pad, x2 - pad
	local bottom = y1 + pad
	local cy = y2 - pad - px(4)          -- room for the floating labels

	-- the two menus, side by side: Team | AI
	local ddH = px(22)
	local gap = px(5)
	local teamW = mathFloor((right - left - gap) * 0.36)
	local teamLabel = selectedAlly and ("Team " .. (selectedAlly + 1)) or "-"
	local e = selected and ais[selected]
	local aiLabel = e and e.name or (#aiOrder == 0 and "no allied AI" or "-")
	dropdown(left, cy - ddH, left + teamW, cy, "Team", teamLabel, "team")
	dropdown(left + teamW + gap, cy - ddH, right, cy, "AI", aiLabel, "ai", e and e.color or nil)
	local menuTop = cy - ddH - px(2)
	cy = cy - ddH - px(6)

	-- the selected AI: status chips, one detail line
	if e then
		local r = e.roster
		local cx = left
		if r then
			cx = chip(cx, cy - px(15), r.role, true)
			cx = chip(cx, cy - px(15), r.side, false)
			if r.landLocked then cx = chip(cx, cy - px(15), "landlocked", false) end
			if r.leader then cx = chip(cx, cy - px(15), "lead", false) end
		else
			local waited = firstAnnounceFrame == nil and spGetGameFrame() > 60 * 30
			chip(cx, cy - px(15), waited and "not hosted here?" or "waiting for announcement", false)
		end
		cy = cy - px(18)
		if r then
			text(font, fitText(font, string.format("team %d · start %d, %d · %s · spot %s", e.teamId, r.x or 0, r.z or 0, r.factory or "-",
				(r.spot and r.spot >= 0) and tostring(r.spot) or "none"), px(8.5), w - 2 * pad), left, cy - px(9), px(8.5), "o", C.onSurfaceVariant)
			cy = cy - px(12)
		end
		-- role: M3 segmented button in two rows of three
		if cy - 2 * px(17) - px(3) >= bottom then
			local segH = px(17)
			local sgap = px(2)
			local segW = (right - left - 2 * sgap) / 3
			for i, role in ipairs(ROLES) do
				local row = mathFloor((i - 1) / 3)
				local col = (i - 1) % 3
				local sx1 = left + col * (segW + sgap)
				local sy2 = cy - row * (segH + sgap)
				local sy1 = sy2 - segH
				local active = r and r.role == role
				local sid = "role" .. e.teamId .. role
				if active then
					roundRect(sx1, sy1, sx1 + segW, sy2, px(4), C.primaryContainer)
				else
					outlineRect(sx1, sy1, sx1 + segW, sy2, px(4), C.outlineStrong)
				end
				stateLayer(sx1, sy1, sx1 + segW, sy2, px(4), sid)
				text(font2, role, sx1 + segW / 2, sy1 + segH * 0.5 - px(3.5), px(8.5), "oc", active and C.onSurface or C.onSurfaceVariant)
				register(sx1, sy1, sx1 + segW, sy2, sid, function()
					if r and r.role == role then return end
					playClick()
					addEvent(string.format("Team %d: switch to %s requested", e.teamId, role), "info")
					send(e.teamId, "barb|setrole|" .. e.teamId .. "|" .. role)
				end)
			end
			cy = cy - 2 * segH - sgap - px(3)
			local replyColor = C.onSurfaceVariant
			if e.replyKind == "ok" then replyColor = C.ok elseif e.replyKind == "warn" then replyColor = C.warn end
			text(font, fitText(font, e.lastReply and ("reply: " .. e.lastReply) or "tap a role to switch this AI", px(8.5), w - 2 * pad), left, cy - px(9), px(8.5), "o", replyColor)
			cy = cy - px(12)
		end
		-- actions: text buttons in one row
		if cy - px(18) >= bottom then
			local bh = px(18)
			local bw = (right - left - 2 * gap) / 3
			button(left, cy - bh, left + bw, cy, "Query", "query", function() playClick(); send(e.teamId, "barb|query|" .. e.teamId) end, false)
			button(left + bw + gap, cy - bh, left + 2 * bw + gap, cy, layoutShown and "Overlay on" or "Overlay", "overlay", function() setOverlay(not layoutShown) end, layoutShown)
			button(left + 2 * (bw + gap), cy - bh, right, cy, "Query all", "queryall", function() playClick(); queryAll() end, false)
			cy = cy - bh - px(4)
		end
	else
		text(font, #aiOrder == 0 and "No allied BARb AI in this game." or "Pick an AI above.", left, cy - px(10), px(9.5), "o", C.onSurfaceVariant)
		cy = cy - px(14)
	end
	divider(x1, x2, cy)
	cy = cy - px(2)

	-- events: whatever height is left
	local lineH = px(11.5)
	local rows = mathFloor((cy - bottom) / lineH)
	if rows >= 1 then
		local total = #events
		eventScroll = mathMax(0, mathMin(eventScroll, mathMax(0, total - rows)))
		local first = total - eventScroll
		local shown = 0
		for i = first, 1, -1 do
			if shown >= rows then break end
			local ev = events[i]
			local ey = cy - shown * lineH
			local col = C.onSurfaceVariant
			if ev.kind == "ok" then col = C.ok elseif ev.kind == "warn" then col = C.warn elseif ev.kind == "error" then col = C.error end
			text(font, frameToClock(ev.frame), left, ey - px(9.5), px(8), "o", C.onSurfaceVariant)
			text(font, fitText(font, ev.text, px(8), w - 2 * pad - px(27)), left + px(27), ey - px(9.5), px(8), "o", col)
			shown = shown + 1
		end
		if total == 0 then
			text(font, "No events yet.", left, cy - px(9.5), px(8.5), "o", C.onSurfaceVariant)
		elseif total > rows then
			text(font, string.format("%d more", total - rows), right, cy - px(9.5), px(8), "or", C.onSurfaceVariant)
		end
	end

	-- the open menu, last
	menuHit = {}
	menuRect = nil
	if openMenu == "team" then
		local items = {}
		for _, at in ipairs(allyTeams) do
			items[#items + 1] = { id = "team" .. at, label = "Team " .. (at + 1) .. " (" .. #aisOfAlly(at) .. " AI)", selected = (at == selectedAlly), ally = at }
		end
		drawMenu(left, left + teamW, menuTop, items, function(it)
			selectedAlly = it.ally
			selected = aisOfAlly(selectedAlly)[1]
		end)
	elseif openMenu == "ai" then
		local items = {}
		for _, id in ipairs(aisOfAlly(selectedAlly)) do
			local a = ais[id]
			items[#items + 1] = { id = "ai" .. id, label = (a.name or ("AI " .. id)) .. (a.roster and (" · " .. a.roster.role) or ""), selected = (id == selected), color = a.color, teamId = id }
		end
		drawMenu(left + teamW + gap, right, menuTop, items, function(it) selected = it.teamId end)
	elseif WG.guishader then
		WG.guishader.RemoveRect("barblinkmenu")
	end
end

function widget:DrawScreen()
	hit = {}
	if not hasFlowUI or not font then initFlowUI() end
	updateDock()
	if not docked and activeTab ~= "ai" then return end
	drawStrip()
	if activeTab == "ai" then drawPanel() else menuHit = {}; menuRect = nil end

	local mx, my = spGetMouseState()
	local newHover = nil
	for _, r in ipairs(hit) do
		if inside(mx, my, r[1], r[2], r[3], r[4]) then newHover = r[5] end
	end
	for _, r in ipairs(menuHit) do
		if inside(mx, my, r[1], r[2], r[3], r[4]) then newHover = r[5] end
	end
	hoverId = newHover
	if hoverId and hoverId ~= lastHoverSoundId then
		spPlaySoundFile(SOUND_HOVER, 0.04, "ui")
		lastHoverSoundId = hoverId
	end
	glColor(1, 1, 1, 1)
end

-- ---------------------------------------------------------------- input

local function overStrip(mx, my)
	return docked and inside(mx, my, strip.x1, strip.y1, strip.x2, strip.y2)
end

local function overPanel(mx, my)
	return activeTab == "ai" and inside(mx, my, panel.x1, panel.y1, panel.x2, panel.y2)
end

function widget:IsAbove(mx, my)
	return overStrip(mx, my) or overPanel(mx, my)
end

function widget:GetTooltip(mx, my)
	for _, r in ipairs(hit) do
		if inside(mx, my, r[1], r[2], r[3], r[4]) then
			local id = r[5]
			for _, role in ipairs(ROLES) do
				if string.sub(id, -#role) == role and string.sub(id, 1, 4) == "role" then
					return role .. ": " .. (ROLE_HINT[role] or "")
				end
			end
			if id == "stripai" then return "Allied BARb AIs (Ctrl+Alt+B, /barblink)" end
			if id == "stripplayer" then return "The player list" end
			if id == "query" then return "Ask this AI for its current details" end
			if id == "queryall" then return "Ask every AI for its details" end
			if id == "overlay" then return "Draw every AI's planned base on the map (/barblayout)" end
		end
	end
	return nil
end

function widget:MousePress(mx, my, mb)
	if mb ~= 1 then return false end
	if openMenu then
		-- a press outside the open menu closes it; inside picks
		if menuRect and inside(mx, my, menuRect[1], menuRect[2], menuRect[3], menuRect[4]) then
			for _, r in ipairs(menuHit) do
				if inside(mx, my, r[1], r[2], r[3], r[4]) then pressedId = r[5]; return true end
			end
			return true
		end
		openMenu = nil
		if not (overStrip(mx, my) or overPanel(mx, my)) then return true end
	end
	if not (overStrip(mx, my) or overPanel(mx, my)) then return false end
	for _, r in ipairs(hit) do
		if inside(mx, my, r[1], r[2], r[3], r[4]) then
			pressedId = r[5]
			return true
		end
	end
	return true   -- a click on the panel's own surface stops here
end

function widget:MouseRelease(mx, my, mb)
	if pressedId then
		for _, list in ipairs({ menuHit, hit }) do
			for _, r in ipairs(list) do
				if r[5] == pressedId and inside(mx, my, r[1], r[2], r[3], r[4]) then
					r[6]()
					pressedId = nil
					return false
				end
			end
		end
		pressedId = nil
	end
	return false
end

function widget:MouseWheel(up, value)
	local mx, my = spGetMouseState()
	if not overPanel(mx, my) then return false end
	eventScroll = eventScroll + (up and 1 or -1)
	return true
end

function widget:TextCommand(cmd)
	if cmd == "barblink" then
		setTab(activeTab == "ai" and "player" or "ai")
		return true
	end
	if cmd == "barblayout" then
		setOverlay(not layoutShown)
		return true
	end
	return false
end

function widget:KeyPress(key, mods, isRepeat)
	if key == 98 and mods.ctrl and mods.alt and not isRepeat then   -- b
		setTab(activeTab == "ai" and "player" or "ai")
		return true
	end
	if key == 27 and activeTab == "ai" then   -- escape
		if openMenu then openMenu = nil else setTab("player") end
		return true
	end
	return false
end

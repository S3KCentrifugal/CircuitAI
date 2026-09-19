-- BARb team link
--
-- A dialog listing the allied BARb AIs: one tab per AI (team colour), the
-- details each AI announced (role, side, start, factory), a segmented role
-- selector that switches the AI's role at runtime, and an event log.
--
-- Install: copy into <BAR data dir>/LuaUI/Widgets/ and enable it (F11).
-- Toggle: /barblink, or Ctrl+Alt+B. Escape closes it. Position is remembered.
--
-- Both directions only work on the machine that runs the AIs (the host),
-- playing or spectating:
--   AI -> widget   ai.CallUI  -> RecvSkirmishAIMessage(aiTeam, "barb|<topic>|<team>|<allyTeam>|<payload>")
--   widget -> AI   Spring.SendSkirmishAIMessage(teamId, "barb|<command>|<teamId>|...")
-- Commands carry the target team id and the AI ignores any other; the widget
-- never broadcasts, so hosting two ally teams locally cannot cross-steer them.
-- Wire formats: data/script/src/manager/widget_link.as and commands.as.
--
-- Styling follows the game's FlowUI (WG.FlowUI element, rounded rects, fonts,
-- ui_scale / ui_opacity) laid out on Material 3 patterns: top app bar, primary
-- tabs with an active indicator, assist chips, a single-select segmented button,
-- tonal / outlined buttons, state layers on hover and press, a list for events.

function widget:GetInfo()
	return {
		name    = "BARb team link",
		desc    = "Allied BARb AIs: roster, events and runtime role switching (host only)",
		author  = "s3k-CircuitAI",
		date    = "2026-09-18",
		layer   = -5,
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
local MAX_EVENTS = 60
local QUERY_INTERVAL_FRAMES = 1800

-- Material 3 dark scheme, mapped onto the game's warm accent
local C = {
	onSurface        = { 0.92, 0.92, 0.92, 1 },
	onSurfaceVariant = { 0.66, 0.66, 0.68, 1 },
	outline          = { 1, 1, 1, 0.14 },
	outlineStrong    = { 1, 1, 1, 0.28 },
	primary          = { 1, 0.9, 0.66, 1 },        -- BAR's tab accent
	onPrimary        = { 0.12, 0.09, 0.03, 1 },
	primaryContainer = { 1, 0.9, 0.66, 0.22 },
	surfaceLow       = { 1, 1, 1, 0.035 },
	surfaceHigh      = { 1, 1, 1, 0.07 },
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
local spSendSkirmishAIMessage, spPlaySoundFile = Spring.SendSkirmishAIMessage, Spring.PlaySoundFile
local mathFloor, mathMax, mathMin = math.floor, math.max, math.min

-- ---------------------------------------------------------------- state

local vsx, vsy = Spring.GetViewGeometry()
local scale = 1
local RectRound, RectRoundOutline, UiElement, elementCorner, elementPadding
local font, font2
local hasFlowUI = false

local win = { x = nil, y = nil, w = 700, h = 470, visible = true }
local dragging, dragDX, dragDY = false, 0, 0
local hit = {}              -- rebuilt every draw: { x1, y1, x2, y2, id, action }
local hoverId, pressedId = nil, nil
local lastHoverSoundId = nil

local ais = {}              -- teamId -> { teamId, name, shortName, color, roster, lastReply, replyKind }
local aiOrder = {}
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

local function refreshTeams()
	local list = spGetTeamList() or {}
	for _, teamId in ipairs(list) do
		local _, _, isDead, isAI, _, allyTeam = spGetTeamInfo(teamId)
		if isAI and not isDead then
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
	-- group tabs by ally team, then team id
	table.sort(aiOrder, function(a, b)
		local ea, eb = ais[a], ais[b]
		if (ea.allyTeam or 0) ~= (eb.allyTeam or 0) then return (ea.allyTeam or 0) < (eb.allyTeam or 0) end
		return a < b
	end)
	if selected == nil and #aiOrder > 0 then selected = aiOrder[1] end
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

local function setVisible(v)
	win.visible = v
	if v then refreshTeams() end
	if not v and WG.guishader then WG.guishader.RemoveRect("barblink") end
end

-- ---------------------------------------------------------------- lifecycle

local function initFlowUI()
	hasFlowUI = WG.FlowUI ~= nil and WG.FlowUI.Draw ~= nil
	if hasFlowUI then
		RectRound = WG.FlowUI.Draw.RectRound
		RectRoundOutline = WG.FlowUI.Draw.RectRoundOutline
		UiElement = WG.FlowUI.Draw.Element
		elementCorner = WG.FlowUI.elementCorner
		elementPadding = WG.FlowUI.elementPadding
	end
	if WG.fonts then
		font = WG.fonts.getFont()
		font2 = WG.fonts.getFont(2)
	end
end

function widget:ViewResize(newX, newY)
	vsx, vsy = newX, newY
	scale = (vsy / 1080) * (1 + (Spring.GetConfigFloat("ui_scale", 1) - 1) / 1.25)
	win.w = mathFloor(700 * scale)
	win.h = mathFloor(470 * scale)
	if win.x == nil then
		win.x = mathFloor((vsx - win.w) / 2)
		win.y = mathFloor((vsy - win.h) / 2)
	end
	win.x = mathMax(0, mathMin(win.x, vsx - win.w))
	win.y = mathMax(0, mathMin(win.y, vsy - win.h))
	initFlowUI()
end

function widget:Initialize()
	self:ViewResize(Spring.GetViewGeometry())
	refreshTeams()
end

function widget:Shutdown()
	if WG.guishader then WG.guishader.RemoveRect("barblink") end
end

function widget:GetConfigData()
	return { x = win.x, y = win.y, visible = win.visible }
end

function widget:SetConfigData(data)
	if data then
		if data.x then win.x = data.x end
		if data.y then win.y = data.y end
		if data.visible ~= nil then win.visible = data.visible end
	end
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
	end
end

-- ---------------------------------------------------------------- drawing primitives

local function px(v) return mathFloor(v * scale) end

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

-- text with the shared font; size in scaled px, opts as gl.Text ("o" outline, "c" centre, "r" right)
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

-- ---------------------------------------------------------------- components

local function iconButton(cx, cy, r, glyph, id, action)
	stateLayer(cx - r, cy - r, cx + r, cy + r, r, id)
	text(font2, glyph, cx, cy - r * 0.45, r * 1.2, "oc", C.onSurfaceVariant)
	register(cx - r, cy - r, cx + r, cy + r, id, action)
end

local function chip(x, y, label, filled, color)
	local h = px(26)
	local w = textWidth(font, label, px(12)) + px(22)
	if filled then
		roundRect(x, y, x + w, y + h, h / 2, color or C.primaryContainer)
	else
		outlineRect(x, y, x + w, y + h, h / 2, C.outlineStrong)
	end
	text(font, label, x + w / 2, y + h * 0.5 - px(4.5), px(12), "oc", filled and C.onSurface or C.onSurfaceVariant)
	return x + w + px(8)
end

local function tonalButton(x1, y1, x2, y2, label, id, action, primary)
	local cs = (y2 - y1) / 2
	roundRect(x1, y1, x2, y2, cs, primary and C.primaryContainer or C.surfaceHigh)
	stateLayer(x1, y1, x2, y2, cs, id)
	text(font2, label, (x1 + x2) / 2, y1 + (y2 - y1) * 0.5 - px(5), px(13), "oc", C.onSurface)
	register(x1, y1, x2, y2, id, action)
end

local function outlinedButton(x1, y1, x2, y2, label, id, action)
	local cs = (y2 - y1) / 2
	outlineRect(x1, y1, x2, y2, cs, C.outlineStrong)
	stateLayer(x1, y1, x2, y2, cs, id)
	text(font2, label, (x1 + x2) / 2, y1 + (y2 - y1) * 0.5 - px(5), px(13), "oc", C.primary)
	register(x1, y1, x2, y2, id, action)
end

-- single-select segmented button
local function segmented(x1, y1, x2, y2, items, selectedItem, idPrefix, onSelect)
	local n = #items
	local segW = (x2 - x1) / n
	local cs = (y2 - y1) / 2
	outlineRect(x1, y1, x2, y2, cs, C.outlineStrong)
	for i, item in ipairs(items) do
		local sx1 = x1 + (i - 1) * segW
		local sx2 = sx1 + segW
		local active = (item == selectedItem)
		local id = idPrefix .. item
		local tl = (i == 1) and 1 or 0
		local tr = (i == n) and 1 or 0
		if active then
			if hasFlowUI then
				RectRound(sx1 + px(1), y1 + px(1), sx2 - px(1), y2 - px(1), cs, tl, tr, tr, tl, C.primaryContainer, C.primaryContainer)
			else
				roundRect(sx1, y1, sx2, y2, cs, C.primaryContainer)
			end
		end
		if pressedId == id or hoverId == id then
			if hasFlowUI then
				RectRound(sx1 + px(1), y1 + px(1), sx2 - px(1), y2 - px(1), cs, tl, tr, tr, tl,
					pressedId == id and C.pressLayer or C.hoverLayer, pressedId == id and C.pressLayer or C.hoverLayer)
			else
				stateLayer(sx1, y1, sx2, y2, cs, id)
			end
		end
		if i > 1 then
			glColor(C.outlineStrong)
			glRect(sx1, y1 + px(4), sx1 + mathMax(1, px(1)), y2 - px(4))
		end
		local label = active and ("\226\128\162 " .. item) or item
		text(font2, label, (sx1 + sx2) / 2, y1 + (y2 - y1) * 0.5 - px(5), px(12.5), "oc", active and C.onSurface or C.onSurfaceVariant)
		register(sx1, y1, sx2, y2, id, function() onSelect(item) end)
	end
end

local function divider(x1, x2, y)
	glColor(C.outline)
	glRect(x1, y, x2, y + mathMax(1, px(1)))
end

-- ---------------------------------------------------------------- draw

function widget:DrawScreen()
	if not win.visible then return end
	hit = {}
	if not hasFlowUI or not font then initFlowUI() end

	local mx, my = spGetMouseState()
	local x, y, w, h = win.x, win.y, win.w, win.h
	local pad = px(20)
	local left, right = x + pad, x + w - pad

	-- surface (blur behind it like other game panels)
	if hasFlowUI then
		UiElement(x, y, x + w, y + h, 1, 1, 1, 1, 1, 1, 1, 1, WG.FlowUI.clampedOpacity)
	else
		glColor(0.08, 0.08, 0.09, 0.92)
		glRect(x, y, x + w, y + h)
	end
	if WG.guishader then WG.guishader.InsertRect(x, y, x + w, y + h, "barblink", widget) end

	-- top app bar
	local barH = px(56)
	local top = y + h
	text(font2, "BARb team link", left, top - px(28), px(20), "o", C.onSurface)
	text(font, "Allied BARb instances on this machine", left, top - px(46), px(12), "o", C.onSurfaceVariant)
	iconButton(right - px(14), top - barH / 2, px(16), "\195\151", "close", function() setVisible(false) end)
	local hint = "Ctrl+Alt+B or /barblink"
	text(font, hint, right - px(40), top - px(34), px(11), "or", C.onSurfaceVariant)
	local rowY = top - barH
	divider(x, x + w, rowY)

	-- primary tabs
	local tabH = px(44)
	local tabY = rowY - tabH
	local n = mathMax(1, #aiOrder)
	local tabW = mathMin(px(150), (w - 2 * pad) / n)
	local tx = left
	local prevAlly = nil
	for _, id in ipairs(aiOrder) do
		local e = ais[id]
		local tid = "tab" .. id
		local active = (id == selected)
		if prevAlly ~= nil and e.allyTeam ~= prevAlly then
			glColor(C.outlineStrong)
			glRect(tx, tabY + px(8), tx + mathMax(1, px(1)), rowY - px(8))
		end
		prevAlly = e.allyTeam
		stateLayer(tx, tabY, tx + tabW, rowY, px(6), tid)
		-- team colour dot
		local label = e.name or ("AI " .. id)
		local maxW = tabW - px(30)
		while textWidth(font2, label, px(13)) > maxW and #label > 3 do
			label = string.sub(label, 1, #label - 2) .. "."
		end
		local lw = textWidth(font2, label, px(13))
		local cx = tx + tabW / 2 - lw / 2 - px(9)
		roundRect(cx - px(5), tabY + tabH / 2 - px(5), cx + px(5), tabY + tabH / 2 + px(5), px(5), e.color)
		text(font2, label, tx + tabW / 2 + px(7), tabY + tabH / 2 - px(5), px(13), "oc", active and C.onSurface or C.onSurfaceVariant)
		if active then
			roundRect(tx + px(10), tabY, tx + tabW - px(10), tabY + px(3), px(1.5), e.color)
		end
		register(tx, tabY, tx + tabW, rowY, tid, function() selected = id end)
		tx = tx + tabW
	end
	divider(x, x + w, tabY)

	-- content
	local e = selected and ais[selected]
	local cy = tabY - px(18)
	if not e then
		text(font, "No AI teams in this game.", left, cy - px(14), px(14), "o", C.onSurfaceVariant)
	else
		local r = e.roster
		text(font2, string.format("%s", e.name or ""), left, cy - px(20), px(18), "o", e.color)
		text(font, string.format("team %d  ·  ally team %s  ·  %s", e.teamId, tostring(e.allyTeam or "?"), e.shortName or ""), left + textWidth(font2, e.name or "", px(18)) + px(12), cy - px(19), px(12), "o", C.onSurfaceVariant)
		-- chips
		local chipY = cy - px(56)
		local cx2 = left
		if r then
			cx2 = chip(cx2, chipY, r.role, true)
			cx2 = chip(cx2, chipY, r.side, false)
			if r.landLocked then cx2 = chip(cx2, chipY, "landlocked start", false) end
			if r.leader then cx2 = chip(cx2, chipY, "lead team", false) end
		else
			cx2 = chip(cx2, chipY, "waiting for announcement", false)
		end
		-- details
		local dy = chipY - px(30)
		local colW = (right - left) / 3
		local function detail(i, label, value)
			local dx = left + (i - 1) * colW
			text(font, label, dx, dy, px(11), "o", C.onSurfaceVariant)
			text(font, value, dx, dy - px(17), px(13.5), "o", C.onSurface)
		end
		if r then
			detail(1, "Start position", string.format("%d, %d", r.x or 0, r.z or 0))
			detail(2, "Start factory", r.factory or "-")
			detail(3, "Start spot", r.spot and r.spot >= 0 and tostring(r.spot) or "none")
		else
			local waited = firstAnnounceFrame == nil and spGetGameFrame() > 60 * 30
			detail(1, "Status", waited and "Nothing received in 60 s: AIs not hosted here?" or "AI has not announced itself yet")
		end
		divider(left, right, dy - px(34))

		-- role section
		local sy = dy - px(56)
		text(font2, "Role", left, sy, px(14), "o", C.onSurface)
		text(font, r and (ROLE_HINT[r.role] or "") or "", left + px(50), sy + px(1), px(11.5), "o", C.onSurfaceVariant)
		local segY2 = sy - px(10)
		local segY1 = segY2 - px(38)
		segmented(left, segY1, right, segY2, ROLES, r and r.role or nil, "role" .. e.teamId, function(role)
			if r and r.role == role then return end
			playClick()
			addEvent(string.format("Team %d: switch to %s requested", e.teamId, role), "info")
			send(e.teamId, "barb|setrole|" .. e.teamId .. "|" .. role)
		end)
		-- supporting text: last reply
		local replyColor = C.onSurfaceVariant
		if e.replyKind == "ok" then replyColor = C.ok elseif e.replyKind == "warn" then replyColor = C.warn end
		text(font, e.lastReply and ("Last reply  " .. e.lastReply) or "Select a role to switch this AI. Takes effect on its next decisions.",
			left, segY1 - px(18), px(11.5), "o", replyColor)

		-- actions
		local ay2 = segY1 - px(30)
		local ay1 = ay2 - px(34)
		outlinedButton(right - px(110), ay1, right, ay2, "Refresh", "refresh", function() playClick(); send(e.teamId, "barb|query|" .. e.teamId) end)
		tonalButton(right - px(230), ay1, right - px(120), ay2, "Query all", "queryall", function() playClick(); queryAll() end, false)

		-- events list
		local ly = ay1 - px(14)
		divider(left, right, ly)
		text(font2, "Events", left, ly - px(20), px(13), "o", C.onSurface)
		local lineH = px(16)
		local listTop = ly - px(30)
		local rows = mathMax(1, mathFloor((listTop - (y + px(14))) / lineH))
		local total = #events
		eventScroll = mathMax(0, mathMin(eventScroll, mathMax(0, total - rows)))
		local first = total - eventScroll
		local shown = 0
		for i = first, 1, -1 do
			if shown >= rows then break end
			local ev = events[i]
			local ey = listTop - shown * lineH
			local col = C.onSurfaceVariant
			if ev.kind == "ok" then col = C.ok elseif ev.kind == "warn" then col = C.warn elseif ev.kind == "error" then col = C.error end
			text(font, frameToClock(ev.frame), left, ey - px(12), px(11), "o", C.onSurfaceVariant)
			text(font, ev.text, left + px(44), ey - px(12), px(11.5), "o", col)
			shown = shown + 1
		end
		if total == 0 then
			text(font, "Nothing yet.", left, listTop - px(12), px(11.5), "o", C.onSurfaceVariant)
		end
		if total > rows then
			text(font, string.format("%d more (scroll)", total - rows), right, ly - px(20), px(11), "or", C.onSurfaceVariant)
		end
	end

	-- hover bookkeeping (after layout so hit rects are current)
	local newHover = nil
	if inside(mx, my, x, y, x + w, y + h) then
		for _, r in ipairs(hit) do
			if inside(mx, my, r[1], r[2], r[3], r[4]) then newHover = r[5] end
		end
	end
	if newHover ~= hoverId then
		hoverId = newHover
		if hoverId and hoverId ~= lastHoverSoundId then
			spPlaySoundFile(SOUND_HOVER, 0.04, "ui")
			lastHoverSoundId = hoverId
		end
	end
	glColor(1, 1, 1, 1)
end

-- ---------------------------------------------------------------- input

function widget:IsAbove(mx, my)
	return win.visible and inside(mx, my, win.x, win.y, win.x + win.w, win.y + win.h)
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
			if id == "close" then return "Close (Escape)" end
			if id == "refresh" then return "Ask this AI for its current details" end
			if id == "queryall" then return "Ask every AI for its details" end
		end
	end
	return nil
end

function widget:MousePress(mx, my, mb)
	if not win.visible or mb ~= 1 then return false end
	if not inside(mx, my, win.x, win.y, win.x + win.w, win.y + win.h) then return false end
	for _, r in ipairs(hit) do
		if inside(mx, my, r[1], r[2], r[3], r[4]) then
			pressedId = r[5]
			return true
		end
	end
	if my >= win.y + win.h - px(56) then
		dragging, dragDX, dragDY = true, mx - win.x, my - win.y
	end
	return true
end

function widget:MouseMove(mx, my)
	if dragging then
		win.x = mathMax(0, mathMin(mx - dragDX, vsx - win.w))
		win.y = mathMax(0, mathMin(my - dragDY, vsy - win.h))
	end
end

function widget:MouseRelease(mx, my, mb)
	dragging = false
	if pressedId then
		for _, r in ipairs(hit) do
			if r[5] == pressedId and inside(mx, my, r[1], r[2], r[3], r[4]) then
				r[6]()
				break
			end
		end
		pressedId = nil
	end
	return false
end

function widget:MouseWheel(up, value)
	if not win.visible then return false end
	local mx, my = spGetMouseState()
	if not inside(mx, my, win.x, win.y, win.x + win.w, win.y + win.h) then return false end
	eventScroll = eventScroll + (up and 1 or -1)
	return true
end

function widget:TextCommand(cmd)
	if cmd == "barblink" then
		setVisible(not win.visible)
		return true
	end
	return false
end

function widget:KeyPress(key, mods, isRepeat)
	if key == 98 and mods.ctrl and mods.alt and not isRepeat then   -- b
		setVisible(not win.visible)
		return true
	end
	if key == 27 and win.visible then   -- escape
		setVisible(false)
		return true
	end
	return false
end

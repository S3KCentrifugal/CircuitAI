-- BARb plans (the Lanes and Blueprints tabs)
--
-- What the allied BARb AIs intend to do on the map. D-506
-- (widget-ux-overhaul-proposal.md): no window of its own; the Lanes and
-- Blueprints tabs of the BARb window (the team link), under its AI selector,
-- registered with WG.barb.AddTab. The Lanes tab: scope (selected AI, ally
-- team, off), layer chips (FRONT lanes, sea lanes, theatre routes, strategic
-- sites, territory, repair points), a More row (live, refresh, labels,
-- teaching, shores, cues, the floating Battlefield guide, route classes), a
-- lane list (click highlights, double-click flies there), a legend and the
-- strategy view toggle. Every lane layer draws in one style (laneStyle).
-- The modules (D-498, widget-decomposition-proposal.md), moved from the team
-- link:
--
--   Blueprints (D-053): the selected AI's (or ally team's) planned base, the
--     state key "layout" on a lease (/barblayout [player|team|off]).
--   Lanes: one renderer for FRONT's land lanes ("frontlanes"), SEA lanes
--     ("sealanes", D-345) and the theatre lanes and strategic sites
--     ("barbtheatre", ai.CallUI, unavailable for user widgets: KI-617)
--     (/barblanes, /barblandlanes, /barbsealanes [player|team|off]).
--   Tactical view (D-349): lanes, Territory and Repair points together
--     (/barbtactical, /barbtacticallanes, /barbrepair).
--   Territory (D-352): mex claims and lane spines (/barbterritory).
--   Strategy: the strategic inspection of corridor assignments, commander
--     decisions and advisory assistance (/barbstrategy). It reads the terrain
--     model of the BARb map widget.
--
-- Needs the BARb team link (WG.barb): it reads the AI state files, holds
-- the roster and the selected AI the tabs follow, and draws the tabs.
--
-- Install: copy into <BAR data dir>/LuaUI/Widgets/ with gui_barb_team_link.lua
-- (and gui_barb_map.lua for the strategy view).
-- Open: Ctrl+Alt+P or /barbplans opens the BARb window on the Lanes tab (a
-- second press closes it); every lane slash command above still works.

function widget:GetInfo()
	return {
		name    = "BARb plans",
		desc    = "BARb AI plans: the Lanes and Blueprints tabs of the BARb window (host only)",
		author  = "s3k-CircuitAI",
		date    = "2026-11-08",
		layer   = 0,
		enabled = true,
	}
end

-- BEGIN DIALOG METRICS
local dialogUI = {}
function dialogUI.Scale(width,height,panelWidth,panelHeight)
    local preference=Spring.GetConfigFloat and Spring.GetConfigFloat("ui_scale",1) or 1
    if type(preference)~="number" or preference~=preference then preference=1 end
    local desired=1.25*math.max(1,height/1080)*math.max(.75,math.min(2,preference))
    return math.min(desired,math.max(1,width)/(panelWidth+24),math.max(1,height)/(panelHeight+24))
end
function dialogUI.Fit(text,size,width)
    local measure=gl.GetTextWidth and gl.GetTextWidth(text)
    local function pixels(t) return (gl.GetTextWidth and gl.GetTextWidth(t) or #t*.55)*size end
    if (measure or #text*.55)*size<=width then return text end
    local lo,hi=0,#text
    while lo<hi do
        local mid=math.ceil((lo+hi)/2)
        if pixels(string.sub(text,1,mid).."...")<=width then lo=mid else hi=mid-1 end
    end
    return string.sub(text,1,lo).."..."
end
-- END DIALOG METRICS

-- ---------------------------------------------------------------- the hub's state, mirrored (D-498)
-- The modules below were written inside the team link and read its roster
-- variables directly. Here they are locals mirrored from WG.barb once a
-- second (refreshTeams); the closures see each reassignment. Without the hub
-- the roster is empty and nothing is requested from any AI.
local spEcho, spGetGameFrame, spSendSkirmishAIMessage = Spring.Echo, Spring.GetGameFrame, Spring.SendSkirmishAIMessage
local aiOrder, ais = {}, {}
local selected, selectedAlly = nil, nil

local function hub()
	local h = WG.barb
	if h and (h.version or 0) >= 1 then return h end
	return nil
end

local function split(s, sep)
	local out = {}
	for piece in string.gmatch(s .. sep, "([^" .. sep .. "]*)" .. sep) do out[#out + 1] = piece end
	return out
end

local function isPermittedTeam(teamId)
	local h = hub()
	return h ~= nil and h.IsPermitted(teamId) == true
end

local function mayCommand(teamId)
	local h = hub()
	return h ~= nil and h.MayCommand(teamId) == true
end

local function refreshTeams()
	local h = hub()
	local nextAis, nextOrder = {}, {}
	if h then
		for _, t in ipairs(h.Teams()) do
			nextAis[t.id] = { teamId = t.id, name = t.name, color = t.color, allyTeam = t.allyTeam, roster = t.roster }
			nextOrder[#nextOrder + 1] = t.id
		end
		selected, selectedAlly = h.Selected(), h.SelectedAlly()
	end
	ais, aiOrder = nextAis, nextOrder
end

-- the terrain model, from the BARb map widget (the strategy view reads it)
local field = {
	Model = function() local m = WG.barbmap; return m and m.Model and m.Model() or nil end,
	Status = function()
		local m = WG.barbmap
		if m and m.Status then return m.Status() end
		return "Needs the BARb map widget for the terrain model"
	end,
}

local blueprints = {} -- the read-only layout observer; filled below
local territory

-- D-505, D-506: one lane style for every lane layer (FRONT and sea strands,
-- theatre routes, territory spines): LINE_PX dashes of DASH_PX with GAP_PX
-- gaps over an OUTLINE_PX dark outline, the same on screen at every zoom; a
-- selected lane is solid and SELECTED_PX wide. A world-space period is never
-- shorter than DASH_MIN_ELMOS, which bounds the dashes drawn when zoomed in
-- (at most length / that per lane). Kept in one table: Lua 5.1 limits the
-- main chunk's locals.
local laneStyle = { LINE_PX = 4, SELECTED_PX = 6, DASH_PX = 18, GAP_PX = 10, OUTLINE_PX = 3, DASH_MIN_ELMOS = 48 }
-- Elmos covered by one screen pixel at the camera's focus (vertical FOV).
function laneStyle.elmosPerPixel()
	local _, cy = Spring.GetCameraPosition()
	local _, vsy = Spring.GetViewGeometry()
	local fov = math.rad(Spring.GetCameraFOV() or 45)
	return math.max(0.2, 2 * math.max(200, cy or 2000) * math.tan(fov / 2) / math.max(1, vsy or 1080))
end
-- The world dash period and dash length for the current camera.
function laneStyle.worldPeriod()
	local s = laneStyle
	local period = math.max(s.DASH_MIN_ELMOS, (s.DASH_PX + s.GAP_PX) * s.elmosPerPixel())
	return period, period * s.DASH_PX / (s.DASH_PX + s.GAP_PX)
end
-- Dashes are [k * period, k * period + on] for whole k, walked by k from
-- floor(d0 / period) until k * period >= d1, so a loop always ends. The old
-- loop stepped s = s + on - (s % period); Lua 5.1's % is a - floor(a/b)*b and
-- rounds, so the step could be under one ulp of s and the loop spun for ever
-- (the game froze on the Ally team scope, 2026-11-09). Inlined at each call
-- site: no closure per segment in the draw path. dashOk refuses a period or a
-- span that is not a finite positive number (NaN would never end the walk).
function laneStyle.dashOk(d0, d1, period)
	return period > 0 and period < math.huge and d1 > d0 and d1 - d0 < math.huge
end
-- GL.LINES vertex pairs for the dashes of a screen-space polyline: screen is
-- {x1, y1, x2, y2, ...} with false where a point is off screen; the dash
-- phase runs on in pixels across segments. O(points + dashes).
function laneStyle.screenDashes(screen, count, on, period)
	local along = 0
	for i = 2, count do
		local a, b = (i - 2) * 2 + 1, (i - 1) * 2 + 1
		local ax, ay, bx, by = screen[a], screen[a + 1], screen[b], screen[b + 1]
		if ax and bx then
			local dx, dy = bx - ax, by - ay
			local len = math.sqrt(dx * dx + dy * dy)
			if len > 0 and laneStyle.dashOk(along, along + len, period) then
				local k = math.floor(along / period)
				while k * period < along + len do
					local s = math.max(k * period, along) - along
					local e = math.min(k * period + on, along + len) - along
					if e > s then gl.Vertex(ax + dx * s / len, ay + dy * s / len); gl.Vertex(ax + dx * e / len, ay + dy * e / len) end
					k = k + 1
				end
				along = along + len
			end
		end
	end
end
-- The same along a world polyline pts = {{x, y, z}, ...}, the phase in elmos
-- (2D distance), lifted by dy. O(points + dashes).
function laneStyle.worldDashes(pts, on, period, dy)
	local along = 0
	for i = 2, #pts do
		local p, q = pts[i - 1], pts[i]
		local dx, dz = q[1] - p[1], q[3] - p[3]
		local len = math.sqrt(dx * dx + dz * dz)
		if len > 0 and laneStyle.dashOk(along, along + len, period) then
			local k = math.floor(along / period)
			while k * period < along + len do
				local t0 = (math.max(k * period, along) - along) / len
				local t1 = (math.min(k * period + on, along + len) - along) / len
				if t1 > t0 then
					gl.Vertex(p[1] + dx * t0, p[2] + (q[2] - p[2]) * t0 + dy, p[3] + dz * t0)
					gl.Vertex(p[1] + dx * t1, p[2] + (q[2] - p[2]) * t1 + dy, p[3] + dz * t1)
				end
				k = k + 1
			end
			along = along + len
		end
	end
end


local theatres = (function()
local surveys, staging = {}, {}
local PREFIX = "barbtheatre|1|"
local mode = nil
local function groupMode() return mode=="team" or mode=="all" end
local activeTeams = {}
-- D-506: guide = the floating Battlefield guide panel; off by default, the
-- Lanes tab holds its controls (its More row turns the guide on for detail).
local options = {live=true, routes=true, sites=false, shores=false, cues=true, teaching=true, labels=true, context=true, opacity=0.85, collapsed=false, guide=false}
local revision = 0   -- D-506: bumped when the surveys or the mode change (the Lanes tab's list cache)
local classFilter = {[0]=true,true,true,true,true,true,true}
local selectedLane, selectedTeam, controls, badges = nil,nil,{},{}
local refreshRequested, refreshAction = {}, nil
local dockX,dockY,drag,pressed
local lessonTitles = {[0]="RECON / ADVANCE", "CONTAIN THE CHOKE", "SPECIALIST FLANK", "CONTEST THE SEA", "AIR APPROACH", "PASSAGE / CLIFF DESCENT"}
local lessons = {
    [0]={"Scout the approach before committing your army.","Spread out in open ground; preserve a retreat route."},
    {"Cover the narrow approach with overlapping fire.","Scout both flanks. Do not feed units into a bottleneck."},
    {"This route crosses terrain ordinary bots cannot use.","Scout the exit; bring units that can cross the whole route."},
    {"Sea access can open a second front along the coast.","Protect your shipyard exit and scout for torpedoes."},
    {"Aircraft can bypass terrain, but not enemy anti-air.","Scout AA, choose an approach, then concentrate the strike."},
    {"Follow the high passage to the far-side cliff exit.","Descend with crawlers; scout the landing before committing."},
}
local previous, wrapper, globals
local names = {[0]="LAND", "BOT", "AMPHIBIOUS", "HOVER", "ALL-TERRAIN", "NAVAL", "AIR"}
local colours = {
    [0]={1,0.75,0.30,1}, {1,0.85,0.45,1}, {0.3,0.88,0.68,1}, {0.3,0.88,0.68,1},
    {0.75,0.86,0.40,1}, {0.22,0.76,1,1}, {0.78,0.62,1,1},
}
local mint, muted, ink = {0.35,0.9,0.73,1}, {0.65,0.73,0.8,1}, {0.025,0.045,0.07,0.94}
local occupied = {}
local function freeRect(x,y,w,h)
    for _,r in ipairs(occupied) do
        if x < r[3]+6 and x+w > r[1]-6 and y < r[4]+6 and y+h > r[2]-6 then return false end
    end
    return true
end
local function split(s, delimiter)
    local t = {}
    for v in (s .. delimiter):gmatch("(.-)" .. delimiter) do t[#t+1] = v end
    return t
end
local function numbers(s)
    local t = {}
    for v in s:gmatch("[^,]+") do
        local n = tonumber(v)
        if not n or n ~= n or math.abs(n) > 1e12 then return nil end
        t[#t+1] = n
    end
    return t
end
local function permitted(team)
    local spec = Spring.GetSpectatingState()
    return spec or Spring.AreTeamsAllied(team, Spring.GetMyTeamID())
end
local function receive(team, msg)
    if type(msg) ~= "string" or msg:sub(1,#PREFIX) ~= PREFIX then return nil end
    local f = split(msg,"|")
    if #f < 5 or tonumber(f[3]) ~= team or not permitted(team) then return nil end
    local topic = f[4]
    if topic == "remove" then surveys[team],staging[team]=nil,nil; return "theatre-v1" end
    if topic == "begin" then
        local n = numbers(f[5]); if not n or #n ~= 2 then return nil end
        staging[team] = {lanes={}, bodies={}, geos={}, islands={}, beaches={}, seconds=math.max(1,math.min(120,n[1])), tidal=n[2]}
        return "theatre-v1"
    end
    if topic == "hide" then
        if surveys[team] then surveys[team].untilFrame = 0 end
        return "theatre-v1"
    end
    local s = staging[team]
    if not s then return nil end
    if topic == "lane" and f[6] then
        local n = numbers(f[5]); if not n or #n ~= 2 or not names[n[2]] then return nil end
        local pts = {}
        for row in f[6]:gmatch("[^;]+") do
            local p = numbers(row); if p and #p == 2 then pts[#pts+1] = p end
        end
        s.lanes[#s.lanes+1] = {id=n[1], class=n[2], points=pts}
    elseif topic == "body" then
        local n = numbers(f[5]); if not n or #n ~= 14 then return nil end
        s.bodies[n[1]] = {id=n[1], pond=n[2]==1, shared=n[3]==1, friendly=n[4]==1,
            x=n[5], z=n[6], area=n[7], yard={n[8],n[9]}, tidal={n[10],n[11]}, plane={n[12],n[13]}, facing=n[14], shore={}}
    elseif topic == "laneinfo" then
        local n=numbers(f[5])
        if not n or #n~=11 then return nil end
        for _,l in ipairs(s.lanes) do if l.id==n[1] then
            l.length,l.width,l.threat,l.front,l.mask=n[2],n[3],n[4],n[5],n[6]
            l.lesson,l.anchor,l.calcFrame,l.revision=n[7],{n[8],n[9]},n[10],n[11]
        end end
    elseif topic == "cliffinfo" then
        local n=numbers(f[5]); if not n or #n~=5 then return nil end
        for _,l in ipairs(s.lanes) do if l.id==n[1] then l.ascent={n[2],n[3]}; l.cliffQuality={n[4],n[5]} end end
    elseif topic == "shore" and f[6] then
        local b = s.bodies[tonumber(f[5])]; if not b then return nil end
        for row in f[6]:gmatch("[^;]+") do
            local p = numbers(row); if p and #p==4 then b.shore[#b.shore+1]=p end
        end
    elseif topic == "geo" then
        local n=numbers(f[5]); if n and #n==6 then s.geos[#s.geos+1]=n end
    elseif topic == "island" then
        local n=numbers(f[5]); if n and #n==5 then s.islands[#s.islands+1]=n end
    elseif topic == "beach" and f[6] then
        local n=numbers(f[5]); if not n or #n~=2 then return nil end
        local b={use=n[2],edges={}}
        for row in f[6]:gmatch("[^;]+") do local e=numbers(row); if e and #e==6 then b.edges[#b.edges+1]=e end end
        s.beaches[#s.beaches+1]=b
    elseif topic == "show" or topic == "refresh" then
        s.frame = Spring.GetGameFrame()
        s.untilFrame = topic=="show" and (Spring.GetGameFrame()+s.seconds*30) or (surveys[team] and surveys[team].untilFrame or 0)
        if options.live or not surveys[team] or refreshRequested[team] then surveys[team]=s; revision=revision+1 end
        staging[team],refreshRequested[team] = nil,nil
        Spring.Echo("[TheatresUI] received " .. #s.lanes .. " lanes for team " .. team)
    end
    return "theatre-v1"
end

local function setMode(value, teams)
    if value~=mode then selectedLane,selectedTeam=nil,nil end
    mode=value
    revision=revision+1
    activeTeams={}
    if value=="all" or value=="team" then
        for _,id in ipairs(teams or Spring.GetTeamList()) do if permitted(id) then activeTeams[id]=true end end
    elseif type(value)=="number" and permitted(value) then activeTeams[value]=true end
end
local function snapshot(team)
    local s=surveys[team]; if not s or not permitted(team) then return nil end
    local r={lanes=#s.lanes,ponds=0,seas=0,yards=0,pondYards=0,tidals=0,planes=0,
        geos=#s.geos,islands=#s.islands,beaches=#s.beaches,visible=activeTeams[team]==true,frame=s.frame,
        live=options.live,classes={},details={}}
    for _,l in ipairs(s.lanes) do
        r.classes[l.class]=(r.classes[l.class] or 0)+1
        r.details[#r.details+1]={id=l.id,class=l.class,mask=l.mask,lesson=l.lesson,anchor=l.anchor,ascent=l.ascent,cliffQuality=l.cliffQuality,revision=l.revision,calcFrame=l.calcFrame,threat=l.threat,points=l.points}
    end
    for _,l in ipairs(s.lanes) do if l.class==6 and l.points[1] then r.airOrigin={l.points[1][1],l.points[1][2]}; break end end
    for _,b in pairs(s.bodies) do
        if b.pond then r.ponds=r.ponds+1 else r.seas=r.seas+1 end
        if b.yard[1]>=0 then r.yards=r.yards+1; if b.pond then r.pondYards=r.pondYards+1 end end
        if b.tidal[1]>=0 then r.tidals=r.tidals+1 end
        if b.plane[1]>=0 then r.planes=r.planes+1 end
    end
    return r
end

local function project(x,z)
    if x < 0 or z < 0 or x > Game.mapSizeX or z > Game.mapSizeZ then return nil end
    -- Screen-space rendering deliberately floats above the water, never on the seabed.
    local sx,sy,sz = Spring.WorldToScreenCoords(x,math.max(0,Spring.GetGroundHeight(x,z))+12,z)
    if not sx or not sz or sz < 0 or sz > 1 then return nil end
    return sx,sy
end
local function lineVertices(x,y,a,b)
    gl.Vertex(x,y); gl.Vertex(a,b)
end
local function line(x,y,a,b,width,c)
    gl.Color(c[1],c[2],c[3],(c[4] or 1)*options.opacity); gl.LineWidth(width)
    gl.BeginEnd(GL.LINES,lineVertices,x,y,a,b)
end
-- One reusable projection buffer for all lanes, and two batches per
-- route. Per-segment closures/tables can allocate tens of MB each DrawScreen
-- with all players visible; the engine deliberately stops automatic Lua GC.
local routeContextInk = {0.025,0.045,0.07,0.2}
local routeScreen = {}
local function routeVertices(screen,count)
    for i=2,count do
        local a,b=(i-2)*2+1,(i-1)*2+1
        if screen[a] and screen[b] then
            gl.Vertex(screen[a],screen[a+1]); gl.Vertex(screen[b],screen[b+1])
        end
    end
end
local function path(points,x,y,size,c,width)
    gl.Color(c); gl.LineWidth(width or 1.7)
    gl.BeginEnd(GL.LINE_STRIP,function()
        for i=1,#points,2 do gl.Vertex(x+points[i]*size,y+points[i+1]*size) end
    end)
end
local function disk(x,y,r,c)
    gl.Color(c)
    gl.BeginEnd(GL.TRIANGLE_FAN,function()
        gl.Vertex(x,y)
        for i=0,32 do local a=i*math.pi/16; gl.Vertex(x+math.cos(a)*r,y+math.sin(a)*r) end
    end)
end
local function ring(x,y,r,c)
    gl.Color(c); gl.LineWidth(1.4)
    gl.BeginEnd(GL.LINE_LOOP,function()
        for i=0,31 do local a=i*math.pi/16; gl.Vertex(x+math.cos(a)*r,y+math.sin(a)*r) end
    end)
end
local function icon(kind,x,y,c)
    disk(x,y,17,ink); ring(x,y,17,c)
    if kind=="yard" then
        path({-10,-7,-10,7,-3,7,-3,0,3,0,3,7,10,7,10,-7},x,y,1,c)
        path({-12,-10,12,-10},x,y,1,c)
        path({-4,-5,0,-8,4,-5},x,y,1,c)
    elseif kind=="tidal" then
        path({2,11,-4,2,2,2,-2,-7,6,3,1,3},x,y,1,c)
        path({-10,-10,-5,-8,0,-10,5,-8,10,-10},x,y,1,c)
    elseif kind=="plane" or kind=="air" then
        path({0,-10,0,11,-2,4,-11,-2,-11,-4,-2,-1,-2,-7,-6,-10,0,-8,6,-10,2,-7,2,-1,11,-4,11,-2,2,4,0,11},x,y,1,c)
        if kind=="plane" then path({-11,-13,-6,-11,0,-13,6,-11,11,-13},x,y,1,c) end
    elseif kind=="naval" then
        ring(x,y+8,3,c)
        path({0,5,0,-10,-6,-7,-10,-2,-6,-4},x,y,1,c)
        path({0,-10,6,-7,10,-2,6,-4},x,y,1,c)
        path({-7,2,7,2},x,y,1,c)
    else
        path({-10,-7,10,-7,10,6,-10,6,-10,-7},x,y,1,c)
        path({-5,-3,5,-3,5,3,-5,3,-5,-3},x,y,1,c)
        path({0,3,0,12},x,y,1,c)
    end
end
local function label(x,y,title,subtitle,c)
    local w = math.max(gl.GetTextWidth(title)*13,gl.GetTextWidth(subtitle or "")*10)+20
    local ox,oy=x,y
    local vw,vh=gl.GetViewSizes()
    local choices={{0,0},{0,48},{0,-48},{-w-48,0},{0,96},{-w-48,48},{-w-48,-48},{0,-96},{-w-48,96},{0,144}}
    for _,o in ipairs(choices) do
        local cx=math.max(12,math.min(vw-w-12,ox+o[1]))
        local cy=math.max(44,math.min(vh-145,oy+o[2]))
        if freeRect(cx,cy-30,w,39) then x,y=cx,cy; break end
    end
    occupied[#occupied+1]={x,y-30,x+w,y+9}
    if x~=ox or y~=oy then line(ox-7,oy-8,x+2,y-8,1,c) end
    gl.Color(ink); gl.Rect(x,y-30,x+w,y+9)
    gl.Color(c); gl.Rect(x,y-30,x+2,y+9)
    gl.Text(title,x+10,y-5,13,"o")
    gl.Color(0.82,0.88,0.94,1); gl.Text(subtitle or "",x+10,y-21,10,"o")
end
local function marker(p,kind,title,detail,c,offset)
    if p[1]<0 then return end
    local x,y=project(p[1],p[2]); if not x then return end
    if not options.labels then icon(kind,x,y,c); return end
    local vw,vh=gl.GetViewSizes()
    local w=math.max(gl.GetTextWidth(title)*13,gl.GetTextWidth(detail)*10)+20
    local ox,oy = math.max(25,math.min(vw-w-45,x+38)),math.max(150,math.min(vh-160,y+(offset or 0)))
    local baseY=oy
    for _,dy in ipairs({0,54,-54,108,-108,162,-162}) do
        local cy=math.max(150,math.min(vh-160,baseY+dy))
        if freeRect(ox-18,cy-23,w+43,42) then oy=cy; break end
    end
    line(x,y,ox-18,oy,2,ink); line(x,y,ox-18,oy,1,c)
    ring(x,y,4,c); icon(kind,ox,oy,c); label(ox+23,oy+8,title,detail,c)
    occupied[#occupied+1]={ox-18,oy-18,ox+18,oy+18}
end

local function drawSurvey(team,s,first,index,count)
    local shift=groupMode() and (index-(count+1)/2)*12 or 0
    local tr,tg,tb=Spring.GetTeamColor(team)
    local teamColour={tr,tg,tb,1}
    -- Geometry, classifications and extents arrive from the AI.
    for _,b in pairs(options.shores and s.bodies or {}) do
        local c=b.pond and (b.friendly and mint or muted) or colours[5]
        gl.Color(c[1],c[2],c[3],0.42); gl.LineWidth(1.2)
        gl.BeginEnd(GL.LINES,function()
            for _,e in ipairs(b.shore) do
                local x,y=project(e[1],e[2]); local a,d=project(e[3],e[4])
                if x and a then gl.Vertex(x,y); gl.Vertex(a,d) end
            end
        end)
    end
    local ordered={}
    for _,l in ipairs(s.lanes) do if not (team==selectedTeam and l.id==selectedLane) then ordered[#ordered+1]=l end end
    for _,l in ipairs(s.lanes) do if team==selectedTeam and l.id==selectedLane then ordered[#ordered+1]=l end end
    for _,l in ipairs(options.routes and ordered or {}) do
      if classFilter[l.class] and (options.context or (selectedTeam==team and selectedLane==l.id)) then
        local chosen=selectedTeam==team and selectedLane==l.id
        local base=colours[l.class]
        local c={base[1],base[2],base[3],chosen and 1 or 0.25}
        -- Shared scratch storage is consumed immediately; it never retains
        -- old surveys or grows with the number of teams/frames.
        local screen=routeScreen
        local count=#l.points
        for i,p in ipairs(l.points) do
            local x,y=project(p[1],p[2]); screen[i*2-1],screen[i*2]=x or false,y or false
        end
        -- D-506: the shared lane style: dashes over a dark outline, the class
        -- colour kept (it is the route's meaning); the chosen route solid.
        local border=chosen and ink or routeContextInk
        local S=laneStyle
        local width=chosen and S.SELECTED_PX or S.LINE_PX
        local period=S.DASH_PX+S.GAP_PX
        gl.Color(border[1],border[2],border[3],border[4]*options.opacity); gl.LineWidth(width+S.OUTLINE_PX)
        if chosen then gl.BeginEnd(GL.LINES,routeVertices,screen,count)
        else gl.BeginEnd(GL.LINES,S.screenDashes,screen,count,S.DASH_PX+S.OUTLINE_PX*0.5,period) end
        gl.Color(c[1],c[2],c[3],c[4]*options.opacity); gl.LineWidth(width)
        if chosen then gl.BeginEnd(GL.LINES,routeVertices,screen,count)
        else gl.BeginEnd(GL.LINES,S.screenDashes,screen,count,S.DASH_PX,period) end
        -- Small directional chevrons instead of oversized repeated unit silhouettes.
        for i=14,count-1,24 do
            local a,b=(i-1)*2+1,i*2+1
            if screen[a] and screen[b] then
                local x,y=screen[a],screen[a+1]
                local dx,dy=screen[b]-x,screen[b+1]-y; local d=math.sqrt(dx*dx+dy*dy)
                if d>0.1 then
                    dx,dy=dx/d,dy/d
                    line(x-dx*7-dy*4,y-dy*7+dx*4,x,y,2,c)
                    line(x-dx*7+dy*4,y-dy*7-dx*4,x,y,2,c)
                end
            end
        end
        local p=(math.max(1,math.floor(count*(l.id%2==0 and 0.62 or 0.38)))-1)*2+1
        if count>0 and screen[p] and options.labels then
            local x,y=screen[p],screen[p+1]
            if chosen or freeRect(x-22,y-12,44,24) then
                gl.Color(ink); gl.Rect(x-22,y-12,x+22,y+12)
                gl.Color(base); gl.Text("P"..team.." / "..l.id,x,y-4,11,"oc")
                badges[#badges+1]={x-22,y-12,x+22,y+12,team=team,lane=l.id}
                occupied[#occupied+1]={x-22,y-12,x+22,y+12}
            end
        end
        if chosen and options.cues and l.anchor then
          for cueIndex,cueAnchor in ipairs(l.ascent and {l.anchor,l.ascent} or {l.anchor}) do
            local x,y=project(cueAnchor[1],cueAnchor[2])
            -- Orient the symbol along the published route at its actual anchor.
            -- The route midpoint can face a different direction from a cliff exit.
            local nearest,bestDistance=1,math.huge
            for i,p in ipairs(l.points) do
                local distance=(p[1]-cueAnchor[1])^2+(p[2]-cueAnchor[2])^2
                if distance<bestDistance then nearest,bestDistance=i,distance end
            end
            local before=l.points[math.max(1,nearest-2)]
            local after=l.points[math.min(#l.points,nearest+2)]
            if x and before and after then
                local a,b=project(before[1],before[2]); local d,e=project(after[1],after[2])
                if a and d then
                    local dx,dy=d-a,e-b; local len=math.sqrt(dx*dx+dy*dy)
                    if len>1 then
                        dx,dy=dx/len,dy/len
                        local c=base
                        if l.lesson==1 then
                            -- Battle-position bracket faces the enemy avenue of approach.
                            line(x-dy*27,y+dx*27,x+dy*27,y-dx*27,5,ink)
                            line(x-dy*27,y+dx*27,x+dy*27,y-dx*27,3,mint)
                            for _,side in ipairs({-1,1}) do
                                local px,py=x+dy*27*side,y-dx*27*side
                                line(px,py,px+dx*13,py+dy*13,3,mint)
                            end
                        else
                            -- Open axis-of-advance arrow: an opportunity, not an order.
                            for _,side in ipairs({-1,1}) do
                                line(x-dx*35+dy*7*side,y-dy*35-dx*7*side,x+dy*7*side,y-dx*7*side,3,c)
                                line(x-dx*8+dy*19*side,y-dy*8-dx*19*side,x+dx*20,y+dy*20,3,c)
                            end
                        end
                        if options.teaching then label(x+32,y+32,cueIndex==2 and "STEEP CLIFF / WALKERS" or (lessonTitles[l.lesson] or "SCOUT"),names[l.class].." / terrain opportunity",c) end
                    end
                end
            end
          end
        end
        if chosen and options.cues and l.front and l.front>=0 then
            local p=l.points[math.min(#l.points,1+math.floor(l.front*(#l.points-1)))]
            local x,y=project(p[1],p[2]); if x then
                path({0,13,13,0,0,-13,-13,0,0,13},x,y,1,{1,0.4,0.3,1},2)
                if options.labels then label(x+20,y+12,"OBSERVED THREAT","Scout before crossing",{1,0.4,0.3,1}) end
            end
        end
      end
    end
    for _,b in pairs(options.sites and s.bodies or {}) do
        local x,y=project(b.x,b.z)
        if x and first and options.labels then
            local c=b.pond and (b.friendly and mint or muted) or colours[5]
            local title=(b.pond and "POND " or "SEA ") .. (b.id+1)
            local detail=b.shared and "shared naval theatre" or (groupMode() and "isolated water" or (b.friendly and "friendly rear water" or "enemy / neutral water"))
            if b.pond then detail=detail .. " / no navy" end
            label(x-60,y+35,title,detail,c)
        end
        marker(b.yard,"yard","SHIPYARD","player " .. team .. " / clear exit",colours[5],-38)
        marker(b.tidal,"tidal","TIDAL",s.tidal .. " E/s / candidate",mint,-38)
        marker(b.plane,"plane","SEAPLANES","player " .. team .. " / platform",mint,35)
    end

    for _,g in ipairs(options.sites and s.geos or {}) do
        local x,y=project(g[2],g[3])
        if x and (not groupMode() or first) then
            local c=groupMode() and {1,0.83,0.4,1} or (g[4]==1 and {1,0.62,0.3,1} or mint)
            disk(x,y,12,ink)
            path({0,11,10,0,0,-11,-10,0,0,11},x,y,1,c,2)
            gl.Color(c); gl.Text(mode=="all" and "G" or (g[4]==1 and "+" or "~"),x,y-4,13,"oc")
            if options.labels then gl.Text(groupMode() and "GEO" or (g[5] .. "%"),x,y-24,10,"oc") end
            local mx,my=Spring.GetMouseState()
            if (mx-x)^2+(my-y)^2<500 then
                -- Group duplicate map positions for presentation, preserving every AI's assessment.
                local rows={}
                for id in pairs(activeTeams) do
                    local other=surveys[id]
                    if other and permitted(id) then
                        for _,item in ipairs(other.geos) do
                            if item[2]==g[2] and item[3]==g[3] then
                                rows[#rows+1]={id=id,use=item[4],coverage=item[5],friendly=item[6]}
                            end
                        end
                    end
                end
                table.sort(rows,function(a,b) return a.id<b.id end)
                local vw,vh=gl.GetViewSizes()
                local h=38+#rows*19
                local tx,ty=math.max(12,math.min(vw-350,x+20)),math.max(h+12,math.min(vh-40,y+20))
                gl.Color(ink); gl.Rect(tx,ty-h,tx+335,ty)
                gl.Color(1,0.9,0.65,1); gl.Text("GEOTHERMAL / FORWARD TERRAIN VIEW",tx+10,ty-19,12,"o")
                for n,row in ipairs(rows) do
                    gl.Color(row.use==1 and {1,0.62,0.3,1} or mint)
                    gl.Text("P" .. row.id .. "  " .. (row.use==1 and "BATTERY" or "POWER") .. "  " .. row.coverage .. "%" .. (row.friendly==1 and "  friendly" or "  capture / contested"),tx+10,ty-20-n*19,11,"o")
                end
            end
        end
    end
    if first and options.sites then
        for _,p in ipairs(s.islands) do
            local x,y=project(p[2],p[3]); if x then
                path({0,7,7,0,0,-7,-7,0,0,7},x,y,1,colours[6],1.5)
                local mx,my=Spring.GetMouseState()
                if (mx-x)^2+(my-y)^2<350 then label(x+14,y+8,"ISLAND / AIR FIRST","isolated land / sea landing later",colours[6]) end
            end
        end
    end
    for _,b in ipairs(options.cues and options.shores and s.beaches or {}) do
        local c=groupMode() and teamColour or (b.use==0 and mint or {1,0.48,0.32,1})
        for i,e in ipairs(b.edges) do
            local x,y=project(e[1],e[2]); local a,d=project(e[3],e[4])
            if x and a then
                y,d=y+shift,d+shift
                line(x,y,a,d,5,ink); line(x,y,a,d,2.4,c)
                -- Same continuous shoreline ribbon; bars defend, teeth point inland to assault.
                if i%3==1 then
                    local mx,mz=(e[1]+e[3])/2,(e[2]+e[4])/2
                    local sx,sy=project(mx,mz); local tx,ty=project(mx+e[5]*110,mz+e[6]*110)
                    if sx and tx then
                        sy,ty=sy+shift,ty+shift
                        local dx,dy=tx-sx,ty-sy; local len=math.sqrt(dx*dx+dy*dy)
                        if len>0 then
                            dx,dy=dx/len,dy/len
                            if b.use==0 then line(sx-dx*4,sy-dy*4,sx+dx*7,sy+dy*7,2,c)
                            else
                                line(sx-dy*4,sy+dx*4,sx+dx*8,sy+dy*8,2,c)
                                line(sx+dy*4,sy-dx*4,sx+dx*8,sy+dy*8,2,c)
                            end
                        end
                    end
                end
            end
        end
    end
end
local function button(id,x,y,w,title,on,action)
    gl.Color(on and {0.12,0.30,0.34,0.98} or {0.09,0.13,0.18,0.98}); gl.Rect(x,y,x+w,y+26)
    gl.Color(on and mint or {0.83,0.87,0.93,1}); gl.Text(title,x+w/2,y+8,11,"oc")
    controls[#controls+1]={x,y,x+w,y+26,id=id,action=action}
end
local function config(data)
    if type(data)~="table" then return end
    for k,v in pairs(options) do if type(v)=="boolean" and type(data[k])=="boolean" then options[k]=data[k] end end
    if type(data.opacity)=="number" then options.opacity=math.max(0.25,math.min(1,data.opacity)) end
    if type(data.x)=="number" and type(data.y)=="number" then dockX,dockY=data.x,data.y end
    if type(data.classes)=="table" then for k=0,6 do if type(data.classes[k])=="boolean" then classFilter[k]=data.classes[k] end end end
end
local function getConfig()
    local result={}; for k,v in pairs(options) do result[k]=v end
    result.x,result.y=dockX,dockY; result.classes={}
    for k=0,6 do result.classes[k]=classFilter[k] end
    return result
end
local function draw(panel)
    controls,badges={},{}
    if not mode or Spring.IsGUIHidden() then return end
    local vw,vh=gl.GetViewSizes()
    local w,h=420,options.collapsed and 38 or 550
    dockX=math.max(8,math.min(vw-w-8,dockX or vw-w-22))
    dockY=math.max(h+8,math.min(vh-65,dockY or vh-80))
    local x,top=dockX,dockY
    occupied={{0,vh-350,350,vh},{vw-440,0,vw,210}}
    if options.guide then occupied[#occupied+1]={x,top-h,x+w,top} end
    if panel then occupied[#occupied+1]={panel.x1,panel.y1,panel.x2,panel.y2} end
    local ids,rows={},{}
    for id in pairs(activeTeams) do if permitted(id) and surveys[id] then ids[#ids+1]=id end end
    table.sort(ids)
    for _,id in ipairs(ids) do for _,l in ipairs(surveys[id].lanes) do
        if classFilter[l.class] then rows[#rows+1]={team=id,lane=l} end
    end end
    local selected,selectedIndex=nil,1
    for i,r in ipairs(rows) do if r.team==selectedTeam and r.lane.id==selectedLane then selected,selectedIndex=r,i end end
    if not selected and rows[1] then selected=rows[1]; selectedTeam,selectedLane=selected.team,selected.lane.id end
    for i,id in ipairs(ids) do if id~=selectedTeam then drawSurvey(id,surveys[id],i==1,i,#ids) end end
    for i,id in ipairs(ids) do if id==selectedTeam then drawSurvey(id,surveys[id],i==1,i,#ids) end end
    -- D-506: the floating guide only on request; the Lanes tab is its home.
    if not options.guide then gl.LineWidth(1); gl.Color(1,1,1,1); return end
    gl.Color(0.025,0.04,0.06,0.97); gl.Rect(x,top-h,x+w,top)
    gl.Color(mint); gl.Rect(x,top-3,x+w,top)
    gl.Color(0.93,0.96,1,1); gl.Text("BATTLEFIELD GUIDE",x+14,top-25,15,"o")
    controls[#controls+1]={x,top-36,x+w-100,top,id="guideDrag",action=function() end}
    button("guideCollapse",x+w-98,top-31,42,options.collapsed and "+" or "-",false,function() options.collapsed=not options.collapsed end)
    button("guideHide",x+w-50,top-31,42,"Hide",false,function() options.guide=false end)   -- D-506: hides the guide, not the lanes
    if options.collapsed then return end
    local y=top-58
    gl.Color(muted); gl.Text((mode=="team" and "TEAM" or (mode=="all" and "ALL PLAYERS" or "PLAYER "..mode)).."  /  "..(options.live and "LIVE" or "FROZEN VIEW"),x+14,y,11,"o")
    y=y-36
    button("guideLive",x+12,y,124,options.live and "Live updates: ON" or "Live updates: OFF",options.live,function() options.live=not options.live end)
    button("guideRefresh",x+144,y,124,"Refresh now",false,function() if refreshAction then refreshAction() end end)
    button("guideTeach",x+276,y,132,"Teaching: "..(options.teaching and "ON" or "OFF"),options.teaching,function() options.teaching=not options.teaching end)
    y=y-33
    for i,k in ipairs({"routes","sites","shores","cues"}) do
        local key=k
        button("guide_"..key,x+12+(i-1)*99,y,93,key:sub(1,1):upper()..key:sub(2)..(options[key] and " +" or " -"),options[key],function() options[key]=not options[key] end)
    end
    y=y-32
    for i,k in ipairs({"labels","context","opacity","reset"}) do
        local key=k
        local title=key=="labels" and (options.labels and "Labels: ON" or "Labels: OFF") or (key=="context" and (options.context and "Context: ON" or "Focus only") or (key=="opacity" and ("Ink: "..math.floor(options.opacity*100).."%") or "Reset view"))
        button("guide_"..key,x+12+(i-1)*99,y,93,title,false,function()
            if key=="labels" then options.labels=not options.labels
            elseif key=="context" then options.context=not options.context
            elseif key=="opacity" then options.opacity=options.opacity>0.8 and 0.55 or (options.opacity>0.5 and 0.3 or 0.85)
            else config({live=true,routes=true,sites=false,shores=false,cues=true,teaching=true,labels=true,context=true,opacity=0.85}); for c=0,6 do classFilter[c]=true end; dockX,dockY=nil,nil end
        end)
    end
    y=y-27
    gl.Color(muted); gl.Text("ROUTE TYPES  /  click to filter",x+14,y,10,"o")
    y=y-31
    local short={[0]="Land","Bot","Amph","Hover","Cliff","Sea","Air"}
    for c=0,6 do local cls=c
        button("guideClass"..c,x+12+c*57,y,53,short[c],classFilter[c],function() classFilter[cls]=not classFilter[cls] end)
    end
    y=y-35
    button("guidePrev",x+12,y,32,"<",false,function()
        local r=rows[(selectedIndex-2)%math.max(1,#rows)+1]; if r then selectedTeam,selectedLane=r.team,r.lane.id end
    end)
    button("guideNext",x+w-44,y,32,">",false,function()
        local r=rows[selectedIndex%math.max(1,#rows)+1]; if r then selectedTeam,selectedLane=r.team,r.lane.id end
    end)
    if selected then
        local l=selected.lane; local c=colours[l.class]
        gl.Color(c); gl.Text(names[l.class].."  /  P"..selected.team.." ROUTE "..l.id,x+54,y+8,13,"o")
        y=y-23
        gl.Color(muted); gl.Text(selectedIndex.." of "..#rows.." routes  /  select a map badge or use arrows",x+14,y,10,"o")
        y=y-24
        gl.Color(0.9,0.94,1,1); gl.Text((l.length or 0).." elmos   /   "..(l.width and l.width>0 and ("narrowest ~"..l.width) or "no ground choke"),x+14,y,12,"o")
        y=y-21
        local age=math.max(0,math.floor((Spring.GetGameFrame()-(l.calcFrame or surveys[selected.team].frame))/30))
        local threat=l.threat and l.threat>1 and ("Reported "..(l.class==6 and "AA" or "surface").." threat: "..string.format("%.1f",l.threat)) or "No reported threat - this does not mean safe"
        gl.Color(l.threat and l.threat>1 and {1,0.55,0.35,1} or muted); gl.Text(threat,x+14,y,11,"o")
        y=y-21
        gl.Color(muted); gl.Text("Survey "..age.."s ago / rev "..(l.revision or "?").." / AI sight + profile weights",x+14,y,11,"o")
        y=y-21
        local capable={}
        for cls=0,6 do if l.mask and math.floor(l.mask/2^cls)%2==1 then capable[#capable+1]=short[cls] end end
        gl.Color(muted); gl.Text("Terrain fits: "..table.concat(capable," / "),x+14,y,10,"o")
        if options.teaching then
            y=y-28
            gl.Color(mint); gl.Text(lessonTitles[l.lesson or 0],x+14,y,13,"o")
            local teaching=l.ascent and {"Use steep walker-only cliffs at both ends of the passage.","Scout both landings before committing walkers."} or (lessons[l.lesson or 0] or lessons[0])
            for _,txt in ipairs(teaching) do y=y-20; gl.Color(0.91,0.93,0.96,1); gl.Text(txt,x+14,y,11,"o") end
        end
    else
        gl.Color(muted); gl.Text(#ids==0 and "Waiting for an AI survey..." or "No routes match these filters",x+56,y+8,12,"o")
    end
    gl.Color(muted); gl.Text("Arrows: approach   Brackets: contain   Diamonds: observed threat",x+14,top-h+30,10,"o")
    gl.Text("Terrain estimate, not orders. Sites are candidates. Drag header to move.",x+14,top-h+13,10,"o")
    gl.LineWidth(1); gl.Color(1,1,1,1)
end
local function hitAt(x,y)
    for i=#controls,1,-1 do local r=controls[i]; if x>=r[1] and y>=r[2] and x<=r[3] and y<=r[4] then return r end end
    for _,r in ipairs(badges) do if x>=r[1] and y>=r[2] and x<=r[3] and y<=r[4] then return r end end
end
local function mousePress(x,y,b)
    if not mode or Spring.IsGUIHidden() then return false end
    if not options.guide then
        -- D-506: without the guide only a lane badge on the map takes a click.
        for _,r in ipairs(badges) do
            if x>=r[1] and y>=r[2] and x<=r[3] and y<=r[4] then if b==1 then pressed=r end; return true end
        end
        return false
    end
    local r=hitAt(x,y)
    if r then
        if b==1 then pressed=r; if r.id=="guideDrag" then drag={x,y,dockX,dockY} end end
        return true
    end
    return dockX and x>=dockX and x<=dockX+420 and y<=dockY and y>=dockY-(options.collapsed and 38 or 550) or false
end
local function mouseRelease(x,y,b)
    local was=pressed~=nil
    if drag then drag=nil
    elseif pressed and b==1 then
        local r=hitAt(x,y)
        if r and r.id==pressed.id and r.team==pressed.team and r.lane==pressed.lane then
            if r.action then r.action() else selectedTeam,selectedLane=r.team,r.lane end
        end
    end
    pressed=nil; return was
end
return {Receive=receive,Draw=draw,SetMode=setMode,Mode=function() return mode end,Snapshot=snapshot,
    ShowsTeam=function(team) return activeTeams[team]==true and permitted(team) end,
    Config=config,GetConfig=getConfig,Live=function() return options.live end,
    SetRefresh=function(fn) refreshAction=fn end,Requested=function(id) refreshRequested[id]=true end,
    Select=function(team,lane) selectedTeam,selectedLane=team,lane end,
    -- D-506: for the Lanes tab's list
    Selected=function() return selectedTeam,selectedLane end,
    Revision=function() return revision end,
    ClassName=function(c) return names[c] end,
    ClassColour=function(c) return colours[c] end,
    ClassFilter=function(c,v) if v~=nil then classFilter[c]=v==true end return classFilter[c] end,
    Option=function(k,v) if v~=nil and type(options[k])==type(v) then options[k]=v end return options[k] end,
    Refresh=function() if refreshAction then refreshAction() end end,
    -- The routes in view, in team then survey order: {team, id, class, length, width, threat, mid = {x, z}}.
    -- O(routes); called when Revision changes, not per frame.
    Routes=function(out)
        out=out or {}
        local ids={}
        for id in pairs(activeTeams) do if permitted(id) and surveys[id] then ids[#ids+1]=id end end
        table.sort(ids)
        for _,id in ipairs(ids) do for _,l in ipairs(surveys[id].lanes) do
            local p=l.points[math.max(1,math.floor((#l.points+1)/2))]
            out[#out+1]={team=id,id=l.id,class=l.class,length=l.length,width=l.width,threat=l.threat,mid=p and {p[1],p[2]} or nil}
        end end
        return out
    end,
    ButtonRect=function(id) for _,r in ipairs(controls) do if r.id==id then return {r[1],r[2],r[3],r[4]} end end end,
    MousePress=mousePress,MouseRelease=mouseRelease,
    MouseMove=function(x,y) if drag then dockX=drag[3]+x-drag[1]; dockY=drag[4]+y-drag[2]; return true end end}
end)()

-- D-345: SEA lanes, calculated by each locally hosted SEA AI (AngelScript,
-- data/script/src/systems/sea/sea_lanes.as) and published as the state-file
-- key "sealanes" (D-300), like the layout. Payload:
--   1;<frame>;<factory>,<kind>,<contact index>,x,z,x,z,...;...
-- kind 0 ends in the water by an enemy start box, kind 1 at a landing beach.
-- Drawn in the owning team's colour: a ring at the factory, the line, a dot
-- at the nearest last known enemy, a square (start box) or triangle (beach)
-- at the end. Visualisation only. /barbsealanes [on|off] toggles it.
-- D-349: the same module is the Tactical view: tactical positions placed on
-- the map as waypoints. Repair points ("searepair": 1;<ship>,<x>,<z>,<retreating>;...)
-- are a pin standing out of the water with a diamond head and a "repair"
-- label, in the team colour; one pin per position, however many ships share
-- it, with the count in the label. A retreating ship gets a line from its
-- current position. /barbtactical [on|off] (alias /barbtactics) toggles the
-- view, /barbrepair and /barbsealanes its layers.
-- Cost: parsing only when the file changes; DrawWorld draws a few hundred
-- vertices; no per-frame engine queries beyond ground height per vertex.
-- D-498: named `lanes` here; it draws FRONT's land lanes and the SEA lanes alike.
local lanes = (function()
    local show = true          -- the whole Tactics overlay
    local showLanes, showRepair = true, true
    -- D-506: the Lanes tab's FRONT and Sea layers; selectedKey is the strand
    -- the tab's list selected (drawn solid); revision bumps on every rebuild.
    local showFront, showSea = true, true
    local selectedKey, revision = nil, 0
    local byTeam = {}
    local frontByTeam = {}    -- same geometry protocol; independent land/sea publications
    local repairByTeam = {}    -- team -> { {ship, x, y, z, retreating} }
    local function receiveRepair(team, payload)
        local list = {}
        local first = true
        for part in (payload .. ";"):gmatch("(.-);") do
            if first then first = false
            else
                local id, x, z, r = part:match("^(%d+),(%-?%d+),(%-?%d+),(%d)$")
                if id then
                    x, z = tonumber(x), tonumber(z)
                    list[#list + 1] = { ship = tonumber(id), x = x, y = math.max(0, Spring.GetGroundHeight(x, z) or 0) + 10, z = z, retreating = r == "1" }
                end
            end
        end
        repairByTeam[team] = list
    end      -- team -> { frame, lanes = { {factory, kind, contact, pts={{x,y,z}}} } }
    -- Front lanes (D-359): record kind 2 is the seat's fixed lane, whose
    -- contact field is the first vertex of its unsupplied section (-1: all
    -- supplied); record kind 3 is the fork link to the corridor the seat is
    -- assisting. The fixed lane is always drawn; nothing changes colour.
    local function ground(x, z) return math.max(0, Spring.GetGroundHeight(x, z) or 0) + 10 end
    -- D-350: friendly lanes that run together are drawn like a metro map: a
    -- bundle of parallel strands, one per lane in its owner's colour, which
    -- separate again where the lanes branch. Every lane is resampled every
    -- STEP elmos; a sample shares a bundle with other lanes' samples within
    -- NEAR (50) elmos heading the same way (|cos| > 0.7) and owned by the same ally
    -- team. Each lane takes a fixed
    -- slot in a bundle (ordered by team, then factory) and is shifted
    -- sideways by one line width per slot; shifts are smoothed over a few samples so
    -- strands ease in and out. Rebuilt only when a lane file changes:
    -- O(samples x neighbours) with a 128-elmo cell hash, a few thousand
    -- samples at most; drawing then costs only the stored vertices.
    -- Strands sit exactly side by side on screen: a lane's sideways shift is
    -- stored in strand slots and turned into elmos each frame from the
    -- camera's elmos per pixel, so neighbours touch at every zoom. Lines
    -- keep their normal width; only the bundle reads wider.
    local STEP, NEAR, CELL = 64, 50, 128
    -- Owner 2026-11-08 (D-505): bold dashed lines with a dark outline; the
    -- style is laneStyle (D-506), shared with every lane layer.
    local LINE_PX = laneStyle.LINE_PX   -- strand width in pixels, and the slot pitch
    local strands = {}         -- { team, lane, front, key, pts = {{x, y, z, nx, nz, slot, dim, along}} }
    local function resample(pts)
        local out = {}
        for i = 1, #pts - 1 do
            local a, b = pts[i], pts[i + 1]
            local dx, dz = b[1] - a[1], b[3] - a[3]
            local len = math.sqrt(dx * dx + dz * dz)
            local n = math.max(1, math.floor(len / STEP))
            for k = 0, n - 1 do
                out[#out + 1] = { x = a[1] + dx * k / n, z = a[3] + dz * k / n, dx = dx / math.max(len, 1), dz = dz / math.max(len, 1), v = i - 1 }
            end
        end
        local last, prev = pts[#pts], out[#out]
        out[#out + 1] = { x = last[1], z = last[3], dx = prev and prev.dx or 1, dz = prev and prev.dz or 0, v = #pts - 1 }
        return out
    end
    local function rebuild()
        strands = {}
        local all = {}
        for _, entries in ipairs({byTeam, frontByTeam}) do
        local front = entries == frontByTeam
        for team, entry in pairs(entries) do
            if isPermittedTeam(team) then
                for _, lane in ipairs(entry.lanes) do
                    if #lane.pts >= 2 then
                        local ally = select(6, Spring.GetTeamInfo(team, false)) or team
                        all[#all + 1] = { team = team, ally = ally, lane = lane, front = front, key = team * 100000 + (lane.factory or 0), samples = resample(lane.pts) }
                    end
                end
            end
        end
        end
        table.sort(all, function(a, b) return a.key < b.key end)
        local grid = {}
        for li, l in ipairs(all) do
            for si, p in ipairs(l.samples) do
                local c = math.floor(p.x / CELL) .. ":" .. math.floor(p.z / CELL)
                grid[c] = grid[c] or {}
                local bucket = grid[c]; bucket[#bucket + 1] = { li, si }
            end
        end
        for li, l in ipairs(all) do
            local raw = {}
            for si, p in ipairs(l.samples) do
                local present = { [li] = true }
                local cx, cz = math.floor(p.x / CELL), math.floor(p.z / CELL)
                for ox = -1, 1 do for oz = -1, 1 do
                    local bucket = grid[(cx + ox) .. ":" .. (cz + oz)]
                    if bucket then
                        for _, ref in ipairs(bucket) do
                            local oli = ref[1]
                            -- Only friendly lanes bundle: a spectator sees both
                            -- sides, and opposing lanes in one channel stay apart.
                            if oli ~= li and not present[oli] and all[oli].ally == l.ally then
                                local q = all[oli].samples[ref[2]]
                                local ddx, ddz = q.x - p.x, q.z - p.z
                                if ddx * ddx + ddz * ddz <= NEAR * NEAR and math.abs(q.dx * p.dx + q.dz * p.dz) > 0.7 then present[oli] = true end
                            end
                        end
                    end
                end end
                local ids = {}
                for id in pairs(present) do ids[#ids + 1] = id end
                table.sort(ids)
                local slot = 1
                for k, id in ipairs(ids) do if id == li then slot = k end end
                -- A canonical sideways direction, so every lane in a bundle
                -- agrees which side is which whatever its own heading.
                local nx, nz = -p.dz, p.dx
                if nx < 0 or (nx == 0 and nz < 0) then nx, nz = -nx, -nz end
                raw[si] = { off = slot - (#ids + 1) / 2, nx = nx, nz = nz }
            end
            local pts = {}
            -- D-359: a front lane (kind 2) with contact >= 0 is unsupplied from
            -- that vertex on while its seat assists a neighbour: those samples
            -- are drawn translucent, in the same colour. A fork link (kind 3)
            -- is an ordinary strand of its owner's colour.
            local dimFrom = (l.lane.kind == 2 and l.lane.contact and l.lane.contact >= 0) and l.lane.contact or nil
            local along = 0
            for si, p in ipairs(l.samples) do
                local sum, n = 0, 0
                for k = math.max(1, si - 2), math.min(#raw, si + 2) do sum = sum + raw[k].off; n = n + 1 end
                if si > 1 then
                    local q = l.samples[si - 1]
                    along = along + math.sqrt((p.x - q.x) ^ 2 + (p.z - q.z) ^ 2)
                end
                -- [8]: distance along the lane, the dash phase (rebuilt with the strand).
                pts[#pts + 1] = { p.x, ground(p.x, p.z), p.z, raw[si].nx, raw[si].nz, sum / n, dimFrom ~= nil and p.v >= dimFrom, along }
            end
            -- A stable key for the tab's selection: layer, team, factory, kind.
            local key = (l.front and "f" or "s") .. l.team .. ":" .. (l.lane.factory or 0) .. ":" .. (l.lane.kind or 0)
            strands[#strands + 1] = { team = l.team, lane = l.lane, front = l.front, key = key, pts = pts }
        end
    end
    local function receive(team, payload, front)
        local parts = {}
        for v in (payload .. ";"):gmatch("(.-);") do parts[#parts + 1] = v end
        if parts[1] ~= "1" then return end
        local entry = { frame = tonumber(parts[2]) or 0, lanes = {} }
        for i = 3, #parts do
            local n = {}
            for v in parts[i]:gmatch("[^,]+") do n[#n + 1] = tonumber(v) end
            if #n >= 7 and n[1] and n[2] and n[3] then
                local lane = { factory = n[1], kind = n[2], contact = n[3], pts = {} }
                for j = 4, #n - 1, 2 do
                    local x, z = n[j], n[j + 1]
                    if x and z then lane.pts[#lane.pts + 1] = { x, ground(x, z), z } end
                end
                entry.lanes[#entry.lanes + 1] = lane
            end
        end
        if front then frontByTeam[team] = entry else byTeam[team] = entry end
        rebuild()
        revision = revision + 1
    end
    local function colour(team, alpha)
        local r, g, b = Spring.GetTeamColor(team)
        return r or 1, g or 1, b or 1, alpha
    end
    local PIN = 140            -- waypoint pin height (elmos above the water)
    local MERGE = 160          -- repair points closer than this share one waypoint
    local function waypoints()
        -- One waypoint per (team, position): ships sharing a point share a pin.
        local pins = {}
        for team, list in pairs(repairByTeam) do
            if isPermittedTeam(team) then
                -- Points within MERGE elmos of a pin join it (ships that are
                -- already clear each hold where they are): O(points x pins).
                local own = {}
                for _, p in ipairs(list) do
                    local w
                    for _, q in ipairs(own) do
                        local dx, dz = q.x - p.x, q.z - p.z
                        if dx * dx + dz * dz <= MERGE * MERGE then w = q; break end
                    end
                    if not w then
                        w = { team = team, x = p.x, y = p.y, z = p.z, ships = 0, retreating = 0, kind = "repair" }
                        own[#own + 1] = w; pins[#pins + 1] = w
                    end
                    w.ships = w.ships + 1
                    if p.retreating then w.retreating = w.retreating + 1 end
                end
            end
        end
        return pins
    end
    -- D-506: the layer a strand belongs to is shown, and its team is in scope.
    local function strandShown(st)
        if st.front then if not showFront then return false end elseif not showSea then return false end
        return theatres.ShowsTeam(st.team)
    end
    local DIM = 0.28           -- alpha of an unsupplied lane section (D-359)
    -- GL.LINES pairs for the dashes of one strand: the parts of each sample
    -- segment where (distance along the lane mod period) < on. O(samples +
    -- dashes); period >= DASH_MIN_ELMOS keeps dashes <= length / that.
    local function dashVertices(st, k, period, on, dy, r, g, b, a)
        local pts = st.pts
        local function at(p, q, t)
            local slot = p[6] + (q[6] - p[6]) * t
            local nx, nz = p[4] + (q[4] - p[4]) * t, p[5] + (q[5] - p[5]) * t
            gl.Vertex(p[1] + (q[1] - p[1]) * t + nx * slot * k, p[2] + (q[2] - p[2]) * t + dy, p[3] + (q[3] - p[3]) * t + nz * slot * k)
        end
        for i = 1, #pts - 1 do
            local p, q = pts[i], pts[i + 1]
            local d0, d1 = p[8], q[8]
            local span = d1 - d0
            if span > 0 then
                if r then gl.Color(r, g, b, p[7] and a * DIM or a) end
                if laneStyle.dashOk(d0, d1, period) then
                    local n = math.floor(d0 / period)   -- dash index (laneStyle.dashOk)
                    while n * period < d1 do
                        local lo, hi = math.max(n * period, d0), math.min(n * period + on, d1)
                        if hi > lo then at(p, q, (lo - d0) / span); at(p, q, (hi - d0) / span) end
                        n = n + 1
                    end
                end
            end
        end
    end
    local function drawRepair()
        -- World part of a repair waypoint: a thin stem and a ground ring; the
        -- wrench badge and label are drawn on screen (drawScreen).
        for _, w in ipairs(waypoints()) do
            local r, g, b = Spring.GetTeamColor(w.team)
            gl.LineWidth(1.5); gl.Color(r or 1, g or 1, b or 1, w.retreating > 0 and 0.9 or 0.5)
            gl.BeginEnd(GL.LINES, function() gl.Vertex(w.x, w.y, w.z); gl.Vertex(w.x, w.y + PIN, w.z) end)
            gl.DrawGroundCircle(w.x, w.y, w.z, 40, 20)
        end
        for team, list in pairs(repairByTeam) do
            if isPermittedTeam(team) then
                local r, g, b = Spring.GetTeamColor(team)
                for _, p in ipairs(list) do
                    if p.retreating then
                        local ux, uy, uz = Spring.GetUnitPosition(p.ship)
                        if ux then
                            gl.LineWidth(1); gl.Color(r or 1, g or 1, b or 1, 0.5)
                            gl.BeginEnd(GL.LINES, function() gl.Vertex(ux, math.max(0, uy) + 10, uz); gl.Vertex(p.x, p.y, p.z) end)
                        end
                    end
                end
            end
        end
        gl.LineWidth(1); gl.Color(1, 1, 1, 1)
    end
    local function drawWorld()
        if not show then return end
        if showRepair then drawRepair() end
        if not showLanes then return end
        local S = laneStyle
        local epp = S.elmosPerPixel()
        local k = LINE_PX * epp
        local period, on = S.worldPeriod()
        -- The outline dash is a little longer, so it frames each dash's ends.
        local pad = math.min((period - on) * 0.5, S.OUTLINE_PX * 0.5 * epp)
        local selected = nil
        gl.LineWidth(LINE_PX + S.OUTLINE_PX)
        for _, st in ipairs(strands) do
            if strandShown(st) then
                if st.key == selectedKey then selected = st
                else gl.BeginEnd(GL.LINES, dashVertices, st, k, period, on + pad, -1, 0, 0, 0, 0.6) end
            end
        end
        gl.LineWidth(LINE_PX)
        for _, st in ipairs(strands) do
            if strandShown(st) and st ~= selected then
            local r, g, b = colour(st.team, 1)
            gl.BeginEnd(GL.LINES, dashVertices, st, k, period, on, 0, r, g, b, 0.95)
            end
        end
        if selected then
            -- D-506: the lane selected in the Lanes tab, solid and wider (one
            -- dash as long as the lane; finite: Lua 5.1's x % math.huge is NaN).
            local SOLID_PERIOD = 1e12
            local r, g, b = colour(selected.team, 1)
            gl.LineWidth(S.SELECTED_PX + S.OUTLINE_PX)
            gl.BeginEnd(GL.LINES, dashVertices, selected, k, SOLID_PERIOD, SOLID_PERIOD, -1, 0, 0, 0, 0.75)
            gl.LineWidth(S.SELECTED_PX)
            gl.BeginEnd(GL.LINES, dashVertices, selected, k, SOLID_PERIOD, SOLID_PERIOD, 0, r, g, b, 1)
        end
        gl.LineWidth(1); gl.Color(1, 1, 1, 1)
    end
    -- Screen-space badges: a dark disc with a team-coloured ring and a white
    -- symbol, the same size at every zoom. (x, y) is the badge centre.
    local BADGE = 12
    local function disc(x, y, radius)
        gl.BeginEnd(GL.TRIANGLE_FAN, function()
            gl.Vertex(x, y)
            for a = 0, 24 do local t = a / 24 * 2 * math.pi; gl.Vertex(x + math.cos(t) * radius, y + math.sin(t) * radius) end
        end)
    end
    local function ring(x, y, radius, from, to)
        gl.BeginEnd(GL.LINE_STRIP, function()
            for a = 0, 20 do local t = from + (to - from) * a / 20; gl.Vertex(x + math.cos(t) * radius, y + math.sin(t) * radius) end
        end)
    end
    local function badge(x, y, r, g, b, symbol, angle)
        gl.Color(0.04, 0.06, 0.09, 0.85); disc(x, y, BADGE)
        gl.LineWidth(2); gl.Color(r, g, b, 1); ring(x, y, BADGE, 0, 2 * math.pi)
        gl.Color(1, 1, 1, 1); gl.LineWidth(2)
        if symbol == "wrench" then
            -- Handle from lower left to an open jaw at upper right.
            gl.BeginEnd(GL.LINES, function() gl.Vertex(x - 6, y - 6); gl.Vertex(x + 1, y + 1) end)
            ring(x + 3.5, y + 3.5, 3.5, math.rad(-20), math.rad(250))
        elseif symbol == "anchor" then
            gl.BeginEnd(GL.LINES, function()
                gl.Vertex(x, y + 7); gl.Vertex(x, y - 6)
                gl.Vertex(x - 4, y + 4); gl.Vertex(x + 4, y + 4)
            end)
            ring(x, y - 1, 6, math.rad(200), math.rad(340))
            ring(x, y + 8, 1.5, 0, 2 * math.pi)
        elseif symbol == "target" then
            ring(x, y, 6, 0, 2 * math.pi); ring(x, y, 2, 0, 2 * math.pi)
            gl.BeginEnd(GL.LINES, function()
                gl.Vertex(x - 10, y); gl.Vertex(x - 7, y); gl.Vertex(x + 7, y); gl.Vertex(x + 10, y)
                gl.Vertex(x, y - 10); gl.Vertex(x, y - 7); gl.Vertex(x, y + 7); gl.Vertex(x, y + 10)
            end)
        elseif symbol == "landing" then
            -- Two chevrons pointing along `angle` (towards the shore).
            local dx, dy = math.cos(angle or math.pi / 2), math.sin(angle or math.pi / 2)
            local nx, ny = -dy, dx
            for c = 0, 1 do
                local bx, by = x + dx * (c * 5 - 1), y + dy * (c * 5 - 1)
                gl.BeginEnd(GL.LINE_STRIP, function()
                    gl.Vertex(bx - dx * 4 + nx * 5, by - dy * 4 + ny * 5); gl.Vertex(bx, by); gl.Vertex(bx - dx * 4 - nx * 5, by - dy * 4 - ny * 5)
                end)
            end
        elseif symbol == "enemy" then
            gl.LineWidth(2.5)
            gl.BeginEnd(GL.LINES, function() gl.Vertex(x, y + 7); gl.Vertex(x, y - 1) end)
            disc(x, y - 5, 1.6)
        end
        gl.LineWidth(1)
    end
    local function toScreen(x, y, z)
        local sx, sy, sz = Spring.WorldToScreenCoords(x, y, z)
        if sx and sz and sz < 1 then return sx, sy end
    end
    local function drawScreen()
        if not show then return end
        if showLanes then
            -- One badge per distinct position: lanes sharing a start, contact or
            -- end share its badge. O(lanes).
            local seen = {}
            local function once(key) if seen[key] then return false end seen[key] = true return true end
            for team, entry in pairs(showSea and byTeam or {}) do
                if theatres.ShowsTeam(team) then
                    local r, g, b = colour(team, 1)
                    for _, lane in ipairs(entry.lanes) do
                        local pts = lane.pts
                        if #pts >= 2 then
                            local s0, e = pts[1], pts[#pts]
                            local sx, sy = toScreen(s0[1], s0[2], s0[3])
                            if sx and once("s" .. team .. ":" .. math.floor(s0[1] / 64) .. ":" .. math.floor(s0[3] / 64)) then
                                badge(sx, sy, r, g, b, "anchor")
                            end
                            local c = pts[(lane.contact or -1) + 1]
                            if lane.contact and lane.contact >= 0 and c then
                                local cx, cy = toScreen(c[1], c[2], c[3])
                                if cx and once("c" .. math.floor(c[1] / 128) .. ":" .. math.floor(c[3] / 128)) then
                                    badge(cx, cy, 1, 0.25, 0.2, "enemy")
                                end
                            end
                            local ex, ey = toScreen(e[1], e[2], e[3])
                            if ex and once("e" .. math.floor(e[1] / 200) .. ":" .. math.floor(e[3] / 200)) then
                                local angle
                                if lane.kind == 1 then
                                    local p = pts[#pts - 1]
                                    local px, py = toScreen(p[1], p[2], p[3])
                                    if px then angle = math.atan2(ey - py, ex - px) end
                                end
                                badge(ex, ey, r, g, b, lane.kind == 1 and "landing" or "target", angle)
                                gl.Color(1, 1, 1, 0.9)
                                gl.Text(lane.kind == 1 and "landing" or "enemy base", ex, ey + BADGE + 4, 12, "co")
                            end
                        end
                    end
                end
            end
        end
        if not showRepair then return end
        for _, w in ipairs(waypoints()) do
            local sx, sy = toScreen(w.x, w.y + PIN, w.z)
            if sx then
                local r, g, b = Spring.GetTeamColor(w.team)
                badge(sx, sy + BADGE, r or 1, g or 1, b or 1, "wrench")
                gl.Color(r or 1, g or 1, b or 1, w.retreating > 0 and 1 or 0.75)
                gl.Text(w.ships > 1 and string.format("repair x%d", w.ships) or "repair", sx, sy + 2 * BADGE + 4, 12, "co")
            end
        end
        gl.Color(1, 1, 1, 1)
    end
    local function drawMiniMap(sx, sy)
        if not show or not showLanes then return end
        local mx, mz = Game.mapSizeX, Game.mapSizeZ
        gl.PushMatrix()
        gl.Translate(0, sy, 0); gl.Scale(sx / mx, -sy / mz, 1)
        gl.LineWidth(1.5)
        for _, st in ipairs(strands) do
            if strandShown(st) then
            local r, g, b = colour(st.team, 1)
            gl.BeginEnd(GL.LINE_STRIP, function() for _, p in ipairs(st.pts) do gl.Color(r, g, b, p[7] and 0.9 * DIM or 0.9); gl.Vertex(p[1], p[3], 0) end end)
            end
        end
        gl.PopMatrix(); gl.LineWidth(1); gl.Color(1, 1, 1, 1)
    end
    local function textCommand(cmd)
        local what, state = cmd:match("^barb(%a+)%s*(%a*)$")
        if what == "tactics" then what = "tactical" end
        -- barblanes/barblandlanes/barbsealanes are the shared player/team/off
        -- lane selection (widget:TextCommand, D-354); the tactical view's own
        -- lane layer is barbtacticallanes (D-356: the old alias was unreachable).
        if what ~= "tactical" and what ~= "tacticallanes" and what ~= "repair" then return false end
        local function set(current) if state == "on" then return true elseif state == "off" then return false end return not current end
        if what == "tactical" then show = set(show); territory.Set(show)
        elseif what == "tacticallanes" then showLanes = set(showLanes); if showLanes then show = true end
        else showRepair = set(showRepair); if showRepair then show = true end end
        Spring.Echo(string.format("[BARb link] tactical view %s (lanes %s, repair %s)", show and "on" or "off",
            showLanes and "on" or "off", showRepair and "on" or "off"))
        return true
    end
    return {
        Receive = receive, ReceiveRepair = receiveRepair, DrawWorld = drawWorld, DrawScreen = drawScreen, DrawMiniMap = drawMiniMap, TextCommand = textCommand,
        GetConfig = function() return { show = show, lanes = showLanes, repair = showRepair, front = showFront, sea = showSea } end,
        EnableLanes = function() show, showLanes = true, true end,
        Config = function(c)
            if type(c) ~= "table" then return end
            if c.show ~= nil then show = c.show == true end
            if c.lanes ~= nil then showLanes = c.lanes == true end
            if c.repair ~= nil then showRepair = c.repair == true end
            if c.front ~= nil then showFront = c.front == true end
            if c.sea ~= nil then showSea = c.sea == true end
        end,
        -- D-506: the Lanes tab's list and selection
        Revision = function() return revision end,
        Select = function(key) selectedKey = key end,
        SelectedKey = function() return selectedKey end,
        -- The strands in view: {key, team, front, kind, length, mid = {x, z}};
        -- O(strands), called when Revision or the scope changes, not per frame.
        Strands = function(out)
            out = out or {}
            for _, st in ipairs(strands) do
                if strandShown(st) then
                    local pts = st.pts
                    local m = pts[math.max(1, math.floor((#pts + 1) / 2))]
                    out[#out + 1] = { key = st.key, team = st.team, front = st.front, kind = st.lane.kind or 0,
                        length = pts[#pts] and pts[#pts][8] or 0, mid = m and { m[1], m[3] } or nil }
                end
            end
            return out
        end,
    }
end)()


-- D-352: the Territory layer of the Tactical view. Each hosted BARb publishes
-- the state key "territory" (WidgetLink::SetState from Team::MexClaim::Tick):
--   barb|territory|<team>|<allyTeam>|1;<frame>;<landWindow><theatreWindow>;<homeRadius>
--     ;S,<x>,<z>,<mask>,<rule>,<owner>,<lane>    one per metal spot
--     ;L,<id>,<midX>,<midZ>,<chokeX>,<chokeZ>,<width>,<members t+t>,<spine x:z ...>
--     ;H,<team>,<x>,<z>                           one per claim (the home circle)
-- Every ally resolves the same owners, so one sender per ally team is drawn
-- (the lowest hosted team id). A spot is a ring in its owner's colour, its
-- shape by rule: disc = home, ring = walk, diamond = sea, triangle = race
-- (secured, contested, air), square = lane cluster, cross = forward (nobody's,
-- past the midpoint), dotted grey = open / nobody. Lane spines are dashed lines
-- in the shared lane style (D-506), 1 px thinner than a lane, in the founding
-- member's colour, with a ring at the midpoint and an X at
-- the choke. Home circles are faint rings. Labels on screen name the rule and
-- owner for spots near the cursor. /barbterritory [on|off] toggles the layer;
-- it is part of /barbtactical. Cost: parsing only when the state changes;
-- a few hundred vertices per frame; no per-frame engine queries beyond ground
-- height at parse time.
territory = (function()   -- declared before the lanes module, which calls territory.Set (D-498)
    local show = true
    local byAlly = {}          -- allyTeam -> { team, frame, windows, home, spots, lanes, homes }
    local RULE = { [0] = "none", "home", "sea", "lane", "walk", "forward", "secured", "contested", "air", "open-land", "open-class" }
    local function ground(x, z) return math.max(0, Spring.GetGroundHeight(x, z) or 0) + 8 end
    local function receive(team, payload)
        local parts = {}
        for v in (payload .. ";"):gmatch("(.-);") do parts[#parts + 1] = v end
        if parts[1] ~= "1" then return end
        local ally = select(6, Spring.GetTeamInfo(team, false)) or team
        local entry = byAlly[ally]
        if entry and entry.team ~= team and entry.team < team then return end   -- one sender per ally team
        entry = { team = team, frame = tonumber(parts[2]) or 0, windows = parts[3] or "00", home = tonumber(parts[4]) or 0, spots = {}, lanes = {}, homes = {} }
        for i = 5, #parts do
            local f = {}
            for v in parts[i]:gmatch("[^,]+") do f[#f + 1] = v end
            if f[1] == "S" and #f >= 7 then
                local x, z = tonumber(f[2]), tonumber(f[3])
                entry.spots[#entry.spots + 1] = { x = x, y = ground(x, z), z = z, mask = tonumber(f[4]) or 8, rule = tonumber(f[5]) or 0, owner = tonumber(f[6]) or -1, lane = tonumber(f[7]) or -1 }
            elseif f[1] == "L" and #f >= 8 then
                local lane = { id = tonumber(f[2]), mid = { tonumber(f[3]), tonumber(f[4]) }, choke = { tonumber(f[5]), tonumber(f[6]) }, width = tonumber(f[7]) or -1, members = {}, pts = {} }
                for m in (f[8] or ""):gmatch("[^+]+") do lane.members[#lane.members + 1] = tonumber(m) end
                for j = 9, #f do
                    local x, z = f[j]:match("^(%-?%d+):(%-?%d+)$")
                    if x then x, z = tonumber(x), tonumber(z); lane.pts[#lane.pts + 1] = { x, ground(x, z), z } end
                end
                entry.lanes[#entry.lanes + 1] = lane
            elseif f[1] == "H" and #f >= 4 then
                entry.homes[#entry.homes + 1] = { team = tonumber(f[2]), x = tonumber(f[3]), z = tonumber(f[4]) }
            end
        end
        byAlly[ally] = entry
    end
    local function colour(team, alpha)
        if team == nil or team < 0 then return 0.75, 0.75, 0.75, alpha end
        local r, g, b = Spring.GetTeamColor(team)
        return r or 1, g or 1, b or 1, alpha
    end
    local function ring(x, y, z, radius, n)
        gl.BeginEnd(GL.LINE_LOOP, function()
            for a = 0, (n or 20) - 1 do local t = a / (n or 20) * 2 * math.pi; gl.Vertex(x + math.cos(t) * radius, y, z + math.sin(t) * radius) end
        end)
    end
    local function disc(x, y, z, radius)
        gl.BeginEnd(GL.TRIANGLE_FAN, function()
            gl.Vertex(x, y, z)
            for a = 0, 20 do local t = a / 20 * 2 * math.pi; gl.Vertex(x + math.cos(t) * radius, y, z + math.sin(t) * radius) end
        end)
    end
    local function poly(x, y, z, radius, sides, turn)
        gl.BeginEnd(GL.LINE_LOOP, function()
            for a = 0, sides - 1 do local t = (turn or 0) + a / sides * 2 * math.pi; gl.Vertex(x + math.cos(t) * radius, y, z + math.sin(t) * radius) end
        end)
    end
    local function cross(x, y, z, r)
        gl.BeginEnd(GL.LINES, function()
            gl.Vertex(x - r, y, z - r); gl.Vertex(x + r, y, z + r); gl.Vertex(x - r, y, z + r); gl.Vertex(x + r, y, z - r)
        end)
    end
    local SPOT = 44
    -- Membership checks reuse the lane selection; no geometry rebuild or
    -- per-frame filtered arrays. Territory spots remain a separate layer.
    local function laneVisible(lane)
        for _, team in ipairs(lane.members) do if theatres.ShowsTeam(team) then return true end end
        return false
    end
    local function drawSpot(s)
        local r, g, b = colour(s.owner, 1)
        local rule = s.rule
        if rule == 1 then gl.Color(r, g, b, 0.35); disc(s.x, s.y, s.z, SPOT); gl.Color(r, g, b, 0.95); ring(s.x, s.y, s.z, SPOT)
        elseif rule == 2 then gl.Color(r, g, b, 0.95); poly(s.x, s.y, s.z, SPOT, 4, 0)
        elseif rule == 3 then gl.Color(r, g, b, 0.95); poly(s.x, s.y, s.z, SPOT, 4, math.pi / 4)
        elseif rule == 4 then gl.Color(r, g, b, 0.9); ring(s.x, s.y, s.z, SPOT)
        elseif rule == 5 then gl.Color(0.9, 0.3, 0.3, 0.9); cross(s.x, s.y, s.z, SPOT * 0.7)
        elseif rule == 6 or rule == 7 or rule == 8 then gl.Color(r, g, b, 0.95); poly(s.x, s.y, s.z, SPOT * 1.1, 3, -math.pi / 2)
        else gl.Color(0.7, 0.7, 0.7, 0.6); ring(s.x, s.y, s.z, SPOT * 0.8, 8) end
    end
    local function drawWorld()
        if not show then return end
        for ally, entry in pairs(byAlly) do
            if isPermittedTeam(entry.team) then
                gl.LineWidth(1.2)
                for _, h in ipairs(entry.homes) do
                    local r, g, b = colour(h.team, 1)
                    gl.Color(r, g, b, 0.25); ring(h.x, ground(h.x, h.z), h.z, entry.home, 48)
                end
                -- D-506: spines in the shared lane style, 1 px thinner than a
                -- lane: dashes over a dark outline (laneStyle.worldDashes).
                local S = laneStyle
                local period, on = S.worldPeriod()
                local width = S.LINE_PX - 1
                for _, lane in ipairs(entry.lanes) do
                    if laneVisible(lane) then
                    local r, g, b = colour(lane.members[1], 1)
                    if #lane.pts >= 2 then
                        gl.LineWidth(width + S.OUTLINE_PX); gl.Color(0, 0, 0, 0.5)
                        gl.BeginEnd(GL.LINES, S.worldDashes, lane.pts, on, period, -1)
                        gl.LineWidth(width); gl.Color(r, g, b, 0.85)
                        gl.BeginEnd(GL.LINES, S.worldDashes, lane.pts, on, period, 0)
                    end
                    gl.LineWidth(1.6)
                    local mx, mz = lane.mid[1], lane.mid[2]
                    if mx and mx >= 0 then gl.Color(1, 1, 1, 0.8); ring(mx, ground(mx, mz), mz, 60, 12) end
                    local cx, cz = lane.choke[1], lane.choke[2]
                    if cx and cx >= 0 then gl.Color(1, 0.85, 0.3, 0.9); gl.LineWidth(2.2); cross(cx, ground(cx, cz) + 4, cz, 70); gl.LineWidth(1.6) end
                    end
                end
                gl.LineWidth(2)
                for _, s in ipairs(entry.spots) do drawSpot(s) end
            end
        end
        gl.LineWidth(1); gl.Color(1, 1, 1, 1)
    end
    local function drawMiniMap(sx, sy)
        if not show then return end
        local mx, mz = Game.mapSizeX, Game.mapSizeZ
        gl.PushMatrix()
        gl.Translate(0, sy, 0); gl.Scale(sx / mx, -sy / mz, 1)
        gl.PointSize(4)
        for _, entry in pairs(byAlly) do
            if isPermittedTeam(entry.team) then
                gl.BeginEnd(GL.POINTS, function()
                    for _, s in ipairs(entry.spots) do
                        local r, g, b = colour(s.owner, 1)
                        if s.rule == 0 or s.rule == 5 then r, g, b = 0.6, 0.6, 0.6 end
                        gl.Color(r, g, b, 0.9); gl.Vertex(s.x, s.z, 0)
                    end
                end)
                gl.LineWidth(1)
                for _, lane in ipairs(entry.lanes) do
                    if laneVisible(lane) then
                    local r, g, b = colour(lane.members[1], 1)
                    gl.Color(r, g, b, 0.6)
                    gl.BeginEnd(GL.LINE_STRIP, function() for _, p in ipairs(lane.pts) do gl.Vertex(p[1], p[3], 0) end end)
                    end
                end
            end
        end
        gl.PointSize(1); gl.PopMatrix(); gl.LineWidth(1); gl.Color(1, 1, 1, 1)
    end
    local function toScreen(x, y, z)
        local sx, sy, sz = Spring.WorldToScreenCoords(x, y, z)
        if sx and sz and sz < 1 then return sx, sy end
    end
    local function drawScreen()
        if not show then return end
        local mx, my = Spring.GetMouseState()
        local _, pos = Spring.TraceScreenRay(mx, my, true)
        for _, entry in pairs(byAlly) do
            if isPermittedTeam(entry.team) then
                local n = 0
                for _, s in ipairs(entry.spots) do
                    if pos and (s.x - pos[1]) ^ 2 + (s.z - pos[3]) ^ 2 <= 600 * 600 then
                        local sx, sy = toScreen(s.x, s.y, s.z)
                        if sx then
                            local r, g, b = colour(s.owner, 1)
                            gl.Color(0, 0, 0, 0.6); gl.Text(string.format("%s %s%s", RULE[s.rule] or "?", s.owner >= 0 and ("P" .. s.owner) or "free", s.lane >= 0 and (" L" .. s.lane) or ""), sx + 1, sy + 13, 11, "o")
                            gl.Color(r, g, b, 1); gl.Text(string.format("%s %s%s", RULE[s.rule] or "?", s.owner >= 0 and ("P" .. s.owner) or "free", s.lane >= 0 and (" L" .. s.lane) or ""), sx, sy + 14, 11, "o")
                            n = n + 1
                        end
                    end
                end
                for _, lane in ipairs(entry.lanes) do
                    if laneVisible(lane) then
                    local cx, cz = lane.choke[1], lane.choke[2]
                    if cx and cx >= 0 then
                        local sx, sy = toScreen(cx, ground(cx, cz), cz)
                        if sx then
                            gl.Color(1, 0.85, 0.3, 1)
                            gl.Text(string.format("lane %d choke %s  P%s", lane.id or 0, lane.width >= 0 and (math.floor(lane.width) .. " wide") or "", table.concat(lane.members, "+")), sx, sy + 16, 11, "oc")
                        end
                    end
                    end
                end
                local sx, sy = 12, 12
                gl.Color(0.85, 0.9, 1, 0.9)
                gl.Text(string.format("territory P%d: %d spots, %d lanes, window %s/%s, home %d", entry.team, #entry.spots, #entry.lanes,
                    entry.windows:sub(1, 1) == "1" and "land" or "open", entry.windows:sub(2, 2) == "1" and "sea" or "open", entry.home), sx, sy, 10, "o")
            end
        end
        gl.Color(1, 1, 1, 1)
    end
    local function textCommand(cmd)
        local what, state = cmd:match("^barb(%a+)%s*(%a*)$")
        if what ~= "territory" then return false end
        if state == "on" then show = true elseif state == "off" then show = false else show = not show end
        Spring.Echo(string.format("[BARb link] territory layer %s", show and "on" or "off"))
        return true
    end
    return {
        Receive = receive, DrawWorld = drawWorld, DrawScreen = drawScreen, DrawMiniMap = drawMiniMap, TextCommand = textCommand,
        GetConfig = function() return { show = show } end,
        Config = function(c) if type(c) == "table" and c.show ~= nil then show = c.show == true end end,
        Set = function(on) show = on end,
        Snapshot = function() return byAlly end,
    }
end)()


-- BEGIN STRATEGY MODULE
-- Embedded by tools/widgets/embed_strategy.py into gui_barb_team_link.lua.
-- Pure renderer of AI publications. No unit enumeration, orders or ownership inference.
local strategy = (function()
    local advanceReasons={"Advancing","At safe station","Contact stand-off","Lane combat boundary","No reachable route","Threat at destination","Return-home policy","No front goal","Observation stale"}
    local show, frozen, inspect = false, nil, false
    local frozenTerritory=nil
    local live, revision, built, modelSeen = {}, 0, -1, nil
    local lastPayload, lastTerritory = {}, {}
    local mode, cls, team, selectedCorridor = 1, 0, -1, nil
    local side=nil
    local heat=true
    local territoryOpacity=.28
    local zoneColours={[2]={1,.65,.1},[3]={1,.15,.15},[4]={.8,.3,1}}
    local modes = {"Overview", "Territory", "Commander", "Diagnostics"}
    local classes = {[0]="Vehicle", "Bot", "Amphibious", "Hover", "All-terrain", "Ship", "Sub"}
    -- Lane query classes differ from the field's class enum.
    local laneClass = {[0]=0, [1]=1, [2]=2, [3]=3, [4]=4, [5]=5}
    local controls, lists, terrainLists, job, inspection = {}, {}, {}, nil, nil
    local terrainKey=""
    local heatCache={}
    local view, panel, freezeFrame = {}, nil, nil
    local displayTeams={}
    local function split(s, sep)
        local out, at = {}, 1
        while true do
            local a,b=string.find(s or "",sep,at,true)
            if not a then out[#out+1]=string.sub(s or "",at);return out end
            out[#out+1]=string.sub(s,at,a-1);at=b+1
        end
    end
    local function numbers(s)
        local out={}
        for _,v in ipairs(split(s,",")) do
            local n=tonumber(v)
            if not n or n~=n or math.abs(n)>1e12 then return nil end
            out[#out+1]=n
        end
        return out
    end
    local function route(s)
        local n=numbers(s);local out={}
        if not n or #n<3 or (#n-3)%2~=0 or #n>8195 then return out end
        for i=4,#n,2 do
            if n[i]<0 or n[i+1]<0 or n[i]>Game.mapSizeX or n[i+1]>Game.mapSizeZ then return {} end
            out[#out+1]={n[i],n[i+1]}
        end
        return out
    end
    local function front(s)
        local parts=split(s or "","|")
        local stamp=tonumber(parts[1]);local zones={}
        if not stamp or stamp<0 or #parts>129 then return nil end
        local last=0
        for i=2,#parts do
            local n=numbers(parts[i])
            if not n or #n~=3 or n[1]<last or n[2]<=n[1] or n[2]>1000000
                or n[3]<0 or n[3]>4 or n[3]~=math.floor(n[3]) then return nil end
            zones[#zones+1]=n;last=n[2]
        end
        return {frame=stamp,zones=zones}
    end
    local function receive(id,payload)
        if not isPermittedTeam(id) or #payload>150000 or lastPayload[id]==payload then return false end
        local f=split(payload,";")
        if f[1]~="1" or #f<15 then return false end
        local frame,assignment,class,corridor,rank,count=tonumber(f[2]),tonumber(f[3]),tonumber(f[4]),tonumber(f[5]),tonumber(f[6]),tonumber(f[7])
        local pos,help=numbers(f[8]),numbers(f[10])
        if not frame or frame<0 or not assignment or not class or not corridor or not rank or not count or not pos or #pos~=2 or not help or #help~=3 then return false end
        if live[id] and live[id].frame>frame then return false end
        local samples={}
        for _,v in ipairs(split(f[15],"|")) do
            local n=numbers(v)
            if n and #n==3 and #samples<33 then samples[#samples+1]=n end
        end
        local ally=Spring.GetTeamInfo and select(6,Spring.GetTeamInfo(id,false)) or -1
        if side==nil then side=ally end
        live[id]={team=id,ally=ally,frame=frame,assignment=assignment,class=laneClass[class],corridor=corridor,rank=rank,count=count,
            pos=pos,progress=tonumber(f[9]) or -1,help=help,request=tonumber(f[11]) or -1,fieldRevision=f[12],
            route=route(f[13]),proposal=route(f[14]),samples=samples,native=numbers(f[16] or ""),status=f[17] or "legacy snapshot",proposalStatus=f[18] or "unknown",front=front(f[19]),defense=string.sub(f[20] or "unavailable",1,180)}
        lastPayload[id]=payload;revision=revision+1
        return true
    end
    local function receiveFront(id,payload)
        if not isPermittedTeam(id) or #payload>12000 then return false end
        local f=split(payload,";");local s=live[id]
        if #f~=2 or not s or tonumber(f[1])~=s.assignment then return false end
        local value=front(f[2])
        if not value or (s.front and value.frame<=s.front.frame) then return false end
        -- Copy the record: Freeze owns the preceding immutable table.
        local copy={};for k,v in pairs(s) do copy[k]=v end
        copy.front=value;live[id]=copy;revision=revision+1
        return true
    end
    local function invalidate() built=-1 end
    local function clearLists()
        for _,id in ipairs(lists) do gl.DeleteList(id) end
        for _,id in ipairs(terrainLists) do gl.DeleteList(id) end
        for _,entry in pairs(heatCache) do gl.DeleteList(entry.id) end
        heatCache={}
        lists={};terrainLists={};terrainKey="";job=nil
    end
    local function colour(id,alpha)
        if id==nil or id<0 then gl.Color(.52,.56,.61,alpha);return end
        local r,g,b=Spring.GetTeamColor(id);gl.Color(r or 1,g or 1,b or 1,alpha)
    end
    local function vertex(x,z) gl.Vertex(x,math.max(0,Spring.GetGroundHeight(x,z))+9,z) end
    local function line(points,dashed)
        gl.BeginEnd(GL.LINES,function()
            for i=2,#points do
                local a,b=points[i-1],points[i]
                if dashed then
                    local dx,dz=b[1]-a[1],b[2]-a[2];local length=math.sqrt(dx*dx+dz*dz)
                    for d=0,length,128 do
                        local u,v=d/math.max(1,length),math.min(length,d+64)/math.max(1,length)
                        vertex(a[1]+dx*u,a[2]+dz*u);vertex(a[1]+dx*v,a[2]+dz*v)
                    end
                else vertex(a[1],a[2]);vertex(b[1],b[2]) end
            end
        end)
    end
    local function cross(x,z,r)
        gl.BeginEnd(GL.LINES,function() vertex(x-r,z);vertex(x+r,z);vertex(x,z-r);vertex(x,z+r) end)
    end
    -- Sparse categorical heat cells, not an enemy-density estimate. Rebuilt only
    -- with publication/filter changes in Update; DrawWorld only calls lists.
    -- At most 128x128 map cells per team; overlapping samples keep the strongest
    -- category instead of accumulating opacity. Route sampling scales with length.
    local function drawHeat(s,m)
        if not heat or not s.front then return end
        local cell=math.max(96,math.max(Game.mapSizeX,Game.mapSizeZ)/128)
        local gw=math.ceil(Game.mapSizeX/cell)
        local corridor=m.corridors[s.corridor]
        local radius=math.max(cell,math.min(384,(corridor and corridor.width or 512)*.5))
        local length=0
        for i=2,#s.route do
            local a,b=s.route[i-1],s.route[i]
            length=length+math.sqrt((b[1]-a[1])^2+(b[2]-a[2])^2)
        end
        local step=math.max(cell*.5,length/2048)
        local cells,keys={},{}
        local priority={[2]=1,[4]=2,[3]=3}
        local function stamp(x,z,kind)
            local reach=radius+cell*.71
            for gz=math.max(0,math.floor((z-reach)/cell)),math.min(math.ceil(Game.mapSizeZ/cell)-1,math.floor((z+reach)/cell)) do
                for gx=math.max(0,math.floor((x-reach)/cell)),math.min(gw-1,math.floor((x+reach)/cell)) do
                    local distance=math.sqrt(((gx+.5)*cell-x)^2+((gz+.5)*cell-z)^2)
                    if distance<reach then
                        local weight=math.max(.12,1-distance/reach)
                        local key=gz*gw+gx;local old=cells[key]
                        if not old then keys[#keys+1]=key end
                        if not old or priority[kind]>priority[old.kind] then
                            cells[key]={x=gx*cell,z=gz*cell,kind=kind,weight=weight}
                        elseif old.kind==kind then old.weight=math.max(old.weight,weight) end
                    end
                end
            end
        end
        local zi,progress=1,0
        for i=2,#s.route do
            local a,b=s.route[i-1],s.route[i]
            local dx,dz=b[1]-a[1],b[2]-a[2];local len=math.sqrt(dx*dx+dz*dz)
            local finish=progress+len
            while s.front.zones[zi] and s.front.zones[zi][2]<=progress do zi=zi+1 end
            local j=zi
            while len>0 and s.front.zones[j] and s.front.zones[j][1]<finish do
                local zone=s.front.zones[j]
                local lo,hi=math.max(progress,zone[1]),math.min(finish,zone[2])
                if zone[3]>=2 and hi>lo then
                    local count=math.max(1,math.ceil((hi-lo)/step))
                    for k=0,count do
                        local t=(lo+(hi-lo)*k/count-progress)/len
                        stamp(a[1]+dx*t,a[2]+dz*t,zone[3])
                    end
                end
                if zone[2]>=finish then break end
                j=j+1
            end
            zi=j;progress=finish
        end
        gl.BeginEnd(GL.QUADS,function()
            for _,key in ipairs(keys) do
                local q=cells[key];local c=zoneColours[q.kind]
                if s.frontStale then gl.Color(.55,.58,.62,.12+q.weight*.12)
                else gl.Color(c[1],c[2],c[3],.12+q.weight*.42) end
                local right,bottom=math.min(Game.mapSizeX,q.x+cell),math.min(Game.mapSizeZ,q.z+cell)
                vertex(q.x,q.z);vertex(right,q.z);vertex(right,bottom);vertex(q.x,bottom)
            end
        end)
    end
    local function drawFront(s)
        if not s.front then return end
        -- Both intervals and route segments are ordered: sweep once, O(P+Z),
        -- rather than projecting every zone over the entire polyline.
        local zones=s.front.zones
        local zi,progress=1,0
        for i=2,#s.route do
            local a,b=s.route[i-1],s.route[i]
            local dx,dz=b[1]-a[1],b[2]-a[2];local len=math.sqrt(dx*dx+dz*dz)
            local finish=progress+len
            while zones[zi] and zones[zi][2]<=progress do zi=zi+1 end
            local j=zi
            while len>0 and zones[j] and zones[j][1]<finish do
                local zone=zones[j];local kind=zone[3]
                local lo,hi=math.max(zone[1],progress),math.min(zone[2],finish)
                if kind>=2 and hi>lo then
                    if s.frontStale then gl.Color(.6,.6,.6,.45)
                    elseif kind==3 then gl.Color(1,.15,.15,.85)
                    elseif kind==2 then gl.Color(1,.65,.1,.8)
                    else gl.Color(.8,.3,1,.7) end
                    gl.LineWidth(kind==3 and 12 or 8)
                    local u,v=(lo-progress)/len,(hi-progress)/len
                    local points={{a[1]+dx*u,a[2]+dz*u},{a[1]+dx*v,a[2]+dz*v}}
                    line(points,kind~=3 or s.frontStale)
                    if kind==3 and not s.frontStale then cross((points[1][1]+points[2][1])*.5,(points[1][2]+points[2][2])*.5,45) end
                end
                if zone[2]>=finish then break end
                j=j+1
            end
            zi=j;progress=finish
        end
    end
    local function at(runs,cell)
        local lo,hi=1,#(runs or {})
        while lo<=hi do
            local mid=math.floor((lo+hi)/2);local r=runs[mid]
            if cell<r[1] then hi=mid-1 elseif cell>=r[1]+r[3] then lo=mid+1 else return r[2] end
        end
        return nil
    end
    local function snapshot()
        local out={}
        local m=field.Model()
        for id,s in pairs(frozen or live) do
            if isPermittedTeam(id) and (not m or not m.corridorRevision or s.fieldRevision==m.corridorRevision) and (side==nil or side<0 or side==s.ally) and (team<0 or team==id) and s.class==cls and (not selectedCorridor or s.corridor==selectedCorridor) then out[#out+1]=s end
        end
        table.sort(out,function(a,b)return a.team<b.team end)
        return out
    end
    local function prepare(m)
        view=snapshot();built=revision;displayTeams={}
        for _,s in ipairs(view) do displayTeams[s.team]=true end
        local key=tostring(m)..":"..cls..":"..mode..":"..tostring(selectedCorridor)..":"..team..":"..tostring(side)
        for _,s in ipairs(view) do key=key..":"..s.team.."/"..s.assignment.."/"..s.corridor end
        local rebuild=key~=terrainKey
        if rebuild then clearLists() else
            for _,id in ipairs(lists) do gl.DeleteList(id) end
            lists={};job=nil
        end
        modelSeen=m
        local owners={}
        for _,s in ipairs(view) do
            owners[s.corridor]=owners[s.corridor] or {};table.insert(owners[s.corridor],s.team)
        end
        job=coroutine.create(function()
            -- Each list holds at most 128 row spans. Build only in Update, never
            -- DrawWorld; yield between chunks. Revision/filter changes own invalidation.
            if rebuild and (mode==1 or mode==2 or mode==4) then
                local batch={}
                local function flush()
                    if #batch==0 then return end
                    terrainLists[#terrainLists+1]=gl.CreateList(function()
                        gl.BeginEnd(GL.QUADS,function()
                            for _,q in ipairs(batch) do
                                local own=owners[q[5]];local id=own and own[1] or -1
                                if own and #own>1 then gl.Color(1,.62,.12,math.min(.65,territoryOpacity+.12)) else colour(id,own and territoryOpacity or .06) end
                                vertex(q[1],q[2]);vertex(q[3],q[2]);vertex(q[3],q[4]);vertex(q[1],q[4])
                            end
                        end)
                    end)
                    batch={};coroutine.yield()
                end
                for _,r in ipairs(m.corridorRuns[cls] or {}) do
                    local first,last=r[1],r[1]+r[3]
                    while first<last do
                        local row=math.floor(first/m.gw);local stop=math.min(last,(row+1)*m.gw)
                        if r[2]>=0 and (not selectedCorridor or selectedCorridor==r[2]) then
                            batch[#batch+1]={(first%m.gw)*m.cell,row*m.cell,(stop-row*m.gw)*m.cell,(row+1)*m.cell,r[2]}
                            if #batch==128 then flush() end
                        end
                        first=stop
                    end
                end
                flush()
            end
            if rebuild then
            for id,c in pairs(m.corridors) do
                if c.class==cls and (not selectedCorridor or id==selectedCorridor) then
                    terrainLists[#terrainLists+1]=gl.CreateList(function()
                        local own=owners[id];colour(own and own[1],.65)
                        local points={};for _,p in ipairs(c.spine) do points[#points+1]={p[1],p[2]} end
                        gl.LineWidth(2);line(points,false);cross(c.x,c.z,40);gl.LineWidth(1)
                    end)
                    coroutine.yield()
                end
            end
            terrainKey=key
            end
            if mode==2 then
                for _,entry in pairs(frozenTerritory or territory.Snapshot()) do
                    local ally=Spring.GetTeamInfo and select(6,Spring.GetTeamInfo(entry.team,false)) or -1
                    if isPermittedTeam(entry.team) and (side==nil or side<0 or side==ally) then
                        displayTeams[entry.team]=true
                        lists[#lists+1]=gl.CreateList(function()
                            for _,spot in ipairs(entry.spots) do
                                if team<0 or spot.owner==team then
                                    local cell=math.floor(spot.z/m.cell)*m.gw+math.floor(spot.x/m.cell)
                                    local corridor=at(m.corridorRuns[cls],cell)
                                    local assigned=owners[corridor];local mismatch=assigned and spot.owner>=0
                                    for _,id in ipairs(assigned or {}) do if id==spot.owner then mismatch=false end end
                                    if not selectedCorridor or corridor==selectedCorridor then
                                        colour(spot.owner,1);cross(spot.x,spot.z,35)
                                        if mismatch then
                                            gl.Color(1,.4,.8,1)
                                            line({{spot.x-55,spot.z},{spot.x,spot.z+55},{spot.x+55,spot.z},{spot.x,spot.z-55},{spot.x-55,spot.z}},false)
                                        end
                                    end
                                end
                            end
                        end)
                        coroutine.yield()
                    end
                end
            end
            for _,s in ipairs(view) do
                -- Frame stamps alone do not change geometry. Keep the heat list
                -- across 1 Hz publications when route, bands and freshness agree.
                local parts={tostring(heat),tostring(s.frontStale or false),tostring(s.corridor)}
                for _,p in ipairs(s.route) do parts[#parts+1]=p[1]..","..p[2] end
                parts[#parts+1]="zones"
                for _,z in ipairs(s.front and s.front.zones or {}) do parts[#parts+1]=table.concat(z,",") end
                local key=table.concat(parts,";")
                local cached=heatCache[s.team]
                if not cached or cached.key~=key then
                    if cached then gl.DeleteList(cached.id) end
                    heatCache[s.team]={key=key,id=gl.CreateList(function()drawHeat(s,m)end)}
                end
                lists[#lists+1]=gl.CreateList(function()
                    colour(s.team,.75);gl.LineWidth(2);line(s.route,false)
                    drawFront(s)
                    if s.help[1]>=0 then gl.Color(1,.74,.25,.9);gl.LineWidth(2);line(s.proposal,true) end
                    if s.pos[1]>=0 then colour(s.team,1);cross(s.pos[1],s.pos[2],75) end
                    if mode==3 and s.native and #s.native>=10 and s.native[8]>=0 then
                        gl.Color(.4,1,.7,1);cross(s.native[8],s.native[9],105)
                    end
                    if mode==4 then
                        for _,p in ipairs(s.samples) do
                            gl.Color(p[3]>3 and 1 or .4,p[3]>3 and .25 or .85,.2,.85);cross(p[1],p[2],25)
                        end
                    end
                    gl.LineWidth(1)
                end)
                coroutine.yield()
            end
        end)
    end
    local function update()
        if not show then return end
        if not frozen then
            for id,s in pairs(live) do
                local stale=s.front and Spring.GetGameFrame()-s.front.frame>90 or false
                if stale~=(s.frontStale or false) then
                    local copy={};for k,v in pairs(s) do copy[k]=v end
                    copy.frontStale=stale;live[id]=copy;revision=revision+1
                end
            end
        end
        for id in pairs(displayTeams) do if not isPermittedTeam(id) then invalidate();break end end
        local m=field.Model();if not m then return end
        if built<0 or modelSeen~=m or (not frozen and built~=revision and not job) then prepare(m) end
        if job then
            local t=Spring.GetTimer()
            repeat
                local ok,err=coroutine.resume(job)
                if not ok then Spring.Echo("[BARb strategy] "..tostring(err));job=nil;break end
                if coroutine.status(job)=="dead" then job=nil end
            until not job or Spring.DiffTimers(Spring.GetTimer(),t)>=.002
        end
    end
    local function drawWorld()
        if not show or Spring.IsGUIHidden() then return end
        -- Permission changes also invalidate frozen/display-list state.
        for id in pairs(displayTeams) do if not isPermittedTeam(id) then clearLists();invalidate();return end end
        gl.DepthTest(false)
        for _,id in ipairs(terrainLists) do gl.CallList(id) end
        for _,s in ipairs(view) do local entry=heatCache[s.team];if entry then gl.CallList(entry.id) end end
        for _,id in ipairs(lists) do gl.CallList(id) end
        gl.LineWidth(1);gl.Color(1,1,1,1);gl.DepthTest(true)
    end
    local function inside(x,y,r) return r and x>=r[1] and x<=r[3] and y>=r[2] and y<=r[4] end
    local function drawScreen()
        if not show or Spring.IsGUIHidden() then return end
        for id in pairs(displayTeams) do if not isPermittedTeam(id) then invalidate();return end end
        controls={}
        local sx,sy=gl.GetViewSizes();local w,h=560,560
        local scale=dialogUI.Scale(sx,sy,w,h)
        sx,sy=sx/scale,sy/scale
        local x,y=12,sy-42
        gl.PushMatrix();gl.Scale(scale,scale,1)
        -- Dock below a top-left minimap instead of drawing underneath it.
        if Spring.GetMiniMapGeometry then
            local mx,my,mw,mh=Spring.GetMiniMapGeometry()
            if mx then mx,my,mw,mh=mx/scale,my/scale,mw/scale,mh/scale end
            if mx and x<mx+mw and x+w>mx and y+30>my and y-(h-30)<my+mh then
                if my>=h+12 then y=my-42 else x=math.min(sx-w-12,mx+mw+12) end
            end
        end
        x=math.max(12,math.min(sx-w-12,x));y=math.max(h-18,math.min(sy-42,y))
        panel={x,y-(h-30),x+w,y+30};gl.Color(.025,.04,.06,.95);gl.Rect(unpack(panel));gl.Color(1,1,1,1)
        gl.Text("Battlefield overview",x+12,y+10,17,"o")
        local function button(label,bx,by,bw,action,active)
            local r={bx,by,bx+bw,by+30,action,label=label};controls[#controls+1]=r
            local mx,my
            if Spring.GetMouseState then mx,my=Spring.GetMouseState();mx,my=mx/scale,my/scale end
            local hover=mx and inside(mx,my,r)
            gl.Color(active and .16 or (hover and .15 or .075),active and .32 or (hover and .22 or .12),active and .4 or .2,1);gl.Rect(bx,by,bx+bw,by+30)
            if active then gl.Color(.55,.84,1,1);gl.Rect(bx,by,bx+bw,by+2) end
            gl.Color(1,1,1,1);gl.Text(dialogUI.Fit(label,12,bw-14),bx+7,by+9,12,"o")
        end
        button(heat and "Heatmap ON" or "Heatmap OFF",x+w-126,y,114,function()heat=not heat;invalidate()end,heat)
        local bw=(w-24)/4
        for i,label in ipairs(modes) do button(label,x+12+(i-1)*bw,y-34,bw-3,function()mode=i;invalidate()end,mode==i) end
        button(classes[cls].." >",x+12,y-70,125,function()cls=(cls+1)%7;selectedCorridor=nil;inspection=nil;invalidate()end)
        button(team<0 and "All teams >" or "Team "..team.." >",x+143,y-70,125,function()
            local ids={};for id in pairs(frozen or live) do if isPermittedTeam(id) and (side==nil or side<0 or (frozen or live)[id].ally==side) then ids[#ids+1]=id end end;table.sort(ids)
            local nextId=-1;for _,id in ipairs(ids) do if id>team then nextId=id;break end end;team=nextId;invalidate()
        end)
        button((side==nil or side<0) and "All sides >" or "Side "..tostring(side).." >",x+274,y-70,110,function()
            local set,ids={},{}
            for id,s in pairs(frozen or live) do if isPermittedTeam(id) then set[s.ally]=true end end
            for id in pairs(set) do ids[#ids+1]=id end;table.sort(ids)
            local nextId=-1;for _,id in ipairs(ids) do if id>(side or -1) then nextId=id;break end end
            side=nextId;team=-1;invalidate()
        end)
        button("Close",x+w-80,y-70,68,function()show=false;clearLists()end)
        button(frozen and "Resume live" or "Freeze",x+12,y-106,110,function()
            if frozen then frozen=nil;frozenTerritory=nil;freezeFrame=nil else frozen={};for id,s in pairs(live) do frozen[id]=s end;frozenTerritory={};for id,s in pairs(territory.Snapshot()) do frozenTerritory[id]=s end;freezeFrame=Spring.GetGameFrame() end;invalidate()
        end,frozen~=nil)
        button(inspect and "Inspect ON" or "Inspect map",x+128,y-106,120,function()inspect=not inspect end,inspect)
        button("Reset filters",x+254,y-106,115,function()team=-1;side=-1;cls=0;mode=1;selectedCorridor=nil;inspection=nil;invalidate()end)
        local now=Spring.GetGameFrame();local oldest=now
        for _,s in ipairs(view) do oldest=math.min(oldest,s.frame) end
        button("Territory: "..math.floor(territoryOpacity*100).."%",x+w-170,y-106,158,function()
            territoryOpacity=territoryOpacity>=.45 and .16 or territoryOpacity+.12;terrainKey="";invalidate()
        end)
        local function text(t) y=y-21;gl.Color(.85,.9,.94,1);gl.Text(dialogUI.Fit(t,13,w-24),x+12,y,13,"o") end
        y=y-116
        text((frozen and "FROZEN  " or (now-oldest>900 and "STALE  " or "LIVE  "))..(#view==0 and "Waiting for FRONT snapshots" or string.format("%d team(s) | oldest %.0fs old",#view,math.max(0,now-oldest)/30))..(job and " | preparing" or ""))
        local legendY=y-36;local legendW=(w-24)/4
        local labels={"Active combat","Contact","Enemy reach","Stale evidence"}
        local colours={zoneColours[3],zoneColours[2],zoneColours[4],{.55,.58,.62}}
        for i,label in ipairs(labels) do
            local bx=x+12+(i-1)*legendW;local c=colours[i]
            gl.Color(c[1],c[2],c[3],.28);gl.Rect(bx,legendY,bx+legendW-4,legendY+28)
            gl.Color(c[1],c[2],c[3],1);gl.Rect(bx,legendY,bx+3,legendY+28)
            gl.Color(1,1,1,1);gl.Text(label,bx+7,legendY+9,12,"o")
        end
        y=legendY-4
        text("Heat = assessed lane zones; colour is evidence, not enemy count.")
        text("Team-coloured areas = assigned lanes. Orange = shared assignment.")
        text(mode==2 and "Mex + = current policy owner. Pink diamond = differs from lane assignment." or "Solid = commander route. Dashed amber = proposal only. + = choke/position.")

        text("Terrain = map geometry. Threats = observed or remembered enemies.")
        local m=field.Model()
        if not m then text(field.Status())
        elseif inspection then
            local c=m.corridors[inspection.corridor]
            text(c and string.format("Corridor %d | %s | narrowest %.0f | length %.0f",c.id,classes[c.class],c.width,c.length) or "No corridor at inspected cell")
            text("Conservative clearance: "..(inspection.clearance and string.format("%.0f elmos",inspection.clearance*16/3) or "unavailable"))
        else text("Enable Inspect map, then click terrain to isolate a corridor.") end
        local s=view[1]
        if s then
            text(s.front and string.format("Assessment %.0fs old; contacts may be remembered",math.max(0,now-s.front.frame)/30) or "Front evidence unavailable")
            text(string.format("Team %d | r%d | seat %d/%d | %.0f elmos | %s",s.team,s.assignment,s.rank+1,s.count,s.progress,s.status))
            if s.native and #s.native>=10 and s.native[1]>=0 then
                local n=s.native
                text(string.format("Screens %d | bound %.0f | %s | decision %.0fs old",n[3],n[5],n[7]==1 and "return-home latch" or (n[10]==1 and "working" or "front active"),math.max(0,now-n[1])/30))
                if n[11] then
                    text("Movement: "..(advanceReasons[n[11]+1] or "Unknown"))
                    text(string.format("Last reclaim headroom: %.0f metal / %.0f energy",n[12] or 0,n[13] or 0))
                end
            else text("Commander front decision: not available yet (opening or inactive).") end
            text("Defense: "..(s.defense or "unavailable"))
            text(s.help[1]>=0 and ("ADVISORY: assist team "..s.help[1]..(s.help[3]==1 and " (income-loss suspect)" or " (pressure)")) or ("Proposal: "..s.proposalStatus..". Other units keep existing behavior."))
        end
        gl.PopMatrix()
        for _,r in ipairs(controls) do for i=1,4 do r[i]=r[i]*scale end end
        for i=1,4 do panel[i]=panel[i]*scale end
        gl.Color(1,1,1,1)
    end
    local function mousePress(x,y,button,blocked)
        if not show then return false end
        for _,r in ipairs(controls) do if inside(x,y,r) then if button==1 then r[5]() end;return true end end
        if inside(x,y,panel) then return true end
        if not inspect or blocked or button~=1 then return false end
        local kind,p=Spring.TraceScreenRay(x,y,true)
        local m=field.Model()
        if kind~="ground" or not p or not m then return false end
        local gx,gz=math.floor(p[1]/m.cell),math.floor(p[3]/m.cell)
        if gx<0 or gz<0 or gx>=m.gw or gz>=m.gh then return false end
        local cell=gz*m.gw+gx;local corridor=at(m.corridorRuns[cls],cell)
        inspection={corridor=corridor,clearance=at(m.clearanceRuns[cls],cell)}
        selectedCorridor=corridor and corridor>=0 and corridor or nil;invalidate();return true
    end
    return {Receive=receive,ReceiveFront=receiveFront,TerritoryChanged=function(id,payload)if lastTerritory[id]~=payload then lastTerritory[id]=payload;revision=revision+1 end end,Update=update,DrawWorld=drawWorld,DrawScreen=drawScreen,MousePress=mousePress,
        PanelRect=function()return panel end,
        ButtonRect=function(label) for _,r in ipairs(controls) do if r.label==label then return {r[1],r[2],r[3],r[4]} end end end,
        Mode=function()return show end,Set=function(v)show=v==true;invalidate();if not show then clearLists() end end,
        Shutdown=clearLists,Snapshot=function()return {teams=snapshot(),mode=mode,class=cls,side=side,frozen=frozen~=nil,preparing=job~=nil,ready=field.Model()~=nil and built>=0 and job==nil,terrainLists=#terrainLists,dynamicLists=#lists,status=field.Status()}end,
        TextCommand=function(cmd) if cmd=="barbstrategy" then show=not show;invalidate();if not show then clearLists() end;return true end return false end,
        At=at,GetConfig=function()return {show=show,class=cls,mode=mode,side=side,heat=heat,territoryOpacity=territoryOpacity}end,
        Config=function(c)if type(c)=="table" then heat=c.heat~=false;if type(c.territoryOpacity)=="number" and c.territoryOpacity==c.territoryOpacity then territoryOpacity=math.max(.12,math.min(.6,c.territoryOpacity)) end;if c.side~=nil then side=math.floor(tonumber(c.side) or -1) end;terrainKey="";show=c.show==true;cls=math.floor(math.max(0,math.min(6,tonumber(c.class) or 0)));mode=math.floor(math.max(1,math.min(4,tonumber(c.mode) or 1)));invalidate();if not show then clearLists() end end end}
end)()
-- END STRATEGY MODULE

-- ---------------------------------------------------------------- blueprints
-- Keep rendering state inside a closure: Lua 5.1 limits top-level locals. Parsing,
-- ground samples and GL list creation happen only on a CHANGED complete snapshot.
-- No per-frame unit/terrain scans, no orders to units and no synced map drawing.
do
    local mode, wanted, data = nil, {}, {}
    local colours = {zone={0.18,0.55,0.9,0.5}, corridor={0.45,0.8,1,0.6},
        p={0.3,0.8,1,0.9}, h={0.35,0.55,0.75,0.6}, c={1,0.85,0.35,0.95},
        s={0.4,1,0.8,0.95}, b={0.3,0.55,0.7,0.35}, t={1,0.65,0.3,0.8},
        resource={1,0.55,0.25,0.9}}
    local dirs = {[0]={0,1}, {1,0}, {0,-1}, {-1,0}}
    local function dispose(d) if d and d.list then gl.DeleteList(d.list); d.list=nil end end
    local function finite(v) return v and v==v and v~=math.huge and v~=-math.huge end
    local function compile(d)
        dispose(d)
        -- A display list is owned by exactly one committed team snapshot.
        -- Water plans must be drawn at the surface, not hidden on the seabed.
        d.list=gl.CreateList(function()
            for _,e in ipairs(d.entries) do
                local c=colours[e.kind] or colours[e.state:sub(1,1)] or colours.p
                if e.state:sub(2,2)=='t' and e.state:sub(1,1)~='b' then c=colours.t end
                local x1,z1,x2,z2=e.x-e.w/2,e.z-e.d/2,e.x+e.w/2,e.z+e.d/2
                local y=math.max(0,Spring.GetGroundHeight(e.x,e.z),Spring.GetGroundHeight(x1,z1),
                    Spring.GetGroundHeight(x2,z2),Spring.GetGroundHeight(x1,z2),Spring.GetGroundHeight(x2,z1))+5
                gl.Color(c[1],c[2],c[3],c[4]); gl.LineWidth(e.kind=='slot' and 1.5 or 1)
                gl.BeginEnd(GL.LINES,function()
                    local function line(ax,az,bx,bz) gl.Vertex(ax,y,az); gl.Vertex(bx,y,bz) end
                    line(x1,z1,x2,z1); line(x2,z1,x2,z2); line(x2,z2,x1,z2); line(x1,z2,x1,z1)
                    if e.kind=='resource' then line(x1,z1,x2,z2); line(x1,z2,x2,z1)
                    elseif e.kind=='corridor' then
                        -- Corridors export axis-aligned bounds, not a facing.
                        if e.w>e.d then line(x1,e.z,x2,e.z) else line(e.x,z1,e.x,z2) end
                    elseif e.kind=='slot' then
                        local r=math.min(8,e.w/4,e.d/4)
                        line(e.x-r,e.z,e.x+r,e.z); line(e.x,e.z-r,e.x,e.z+r)
                        local ud=UnitDefNames and UnitDefNames[e.name]
                        if ud and ud.isFactory then
                            local dir=dirs[e.facing] or dirs[0]
                            local length=math.min(e.w,e.d)*0.4
                            local tx,tz=e.x+dir[1]*length,e.z+dir[2]*length
                            line(e.x,e.z,tx,tz)
                            line(tx,tz,tx-dir[1]*12+dir[2]*8,tz-dir[2]*12-dir[1]*8)
                            line(tx,tz,tx-dir[1]*12-dir[2]*8,tz-dir[2]*12+dir[1]*8)
                        end
                    else
                        -- Survey ticks give large reserved envelopes a blueprint outline.
                        for x=x1+64,x2-1,64 do line(x,z1,x,z1+8); line(x,z2,x,z2-8) end
                        for z=z1+64,z2-1,64 do line(x1,z,x1+8,z); line(x2,z,x2-8,z) end
                    end
                end)
            end
        end)
    end
    local function commit(id,payload)
        local d=data[id] or {}; data[id]=d; d.parts=nil
        if d.text==payload then return end
        local entries,slots,built,zones,resources={},0,0,0,0
        for item in payload:gmatch('[^;]+') do
            local f=split(item,':')
            local x,z,w,h=tonumber(f[3]),tonumber(f[4]),tonumber(f[6]),tonumber(f[7])
            local kind=f[1]
            if (kind=='slot' or kind=='zone' or kind=='corridor' or kind=='resource') and
                finite(x) and finite(z) and finite(w) and finite(h) and w>0 and h>0 and
                x-w/2>=0 and z-h/2>=0 and x+w/2<=Game.mapSizeX and z+h/2<=Game.mapSizeZ then
                entries[#entries+1]={kind=kind,name=f[2],x=x,z=z,w=w,d=h,facing=tonumber(f[5]) or 0,state=f[8] or 'p'}
                if kind=='slot' then slots=slots+1; if (f[8] or ''):sub(1,1)=='b' then built=built+1 end
                elseif kind=='resource' then resources=resources+1 else zones=zones+1 end
            end
        end
        d.text=payload; d.entries=entries; d.slots=slots; d.built=built; d.zones=zones; d.resources=resources
        d.frame=spGetGameFrame()
        d.label=nil
        for _,e in ipairs(entries) do if e.kind=='slot' then
            d.label={e.x,math.max(0,Spring.GetGroundHeight(e.x,e.z))+65,e.z}; break
        end end
        compile(d)
    end
    function blueprints.Receive(id,idx,total,payload)
        if not wanted[id] or not mayCommand(id) or not isPermittedTeam(id) then return end
        -- CallUI sends a whole snapshot synchronously, ordered on the AI thread.
        -- Ignore gaps/duplicates, cap memory, and keep the old list until complete.
        if total==0 and idx==0 then commit(id,''); return end
        if total<1 or total>1024 or total~=math.floor(total) or idx~=math.floor(idx) or idx<1 or idx>total or #payload>3000 then return end
        local d=data[id] or {}; data[id]=d
        if idx==1 then d.parts={}; d.total=total; d.next=1 end
        if not d.parts or d.total~=total or d.next~=idx then d.parts=nil; return end
        d.parts[idx]=payload; d.next=idx+1
        if idx==total then commit(id,table.concat(d.parts)) end
    end
    -- D-300: the state file carries the whole snapshot ("none" = no plan); the
    -- reader only calls this when the stored value changed.
    function blueprints.Whole(id,payload)
        if not wanted[id] or not mayCommand(id) or not isPermittedTeam(id) then return end
        commit(id,payload=='none' and '' or payload)
    end
    function blueprints.Wanted(id) return wanted[id]==true end
    function blueprints.SetMode(value)
        if value~=nil and value~='team' and type(value)~='number' then return end
        mode=value; refreshTeams()
        if type(value)=='number' and ais[value] and mayCommand(value) then
            selected=value; selectedAlly=ais[value].allyTeam
        end
        local nextWanted={}
        for _,id in ipairs(aiOrder) do
            if mayCommand(id) and isPermittedTeam(id) and (id==value or (value=='team' and ais[id].allyTeam==selectedAlly)) then nextWanted[id]=true end
        end
        for id in pairs(wanted) do
            if not nextWanted[id] then
                spSendSkirmishAIMessage(id,'barb|layout|'..id..'|off'); dispose(data[id]); data[id]=nil
            end
        end
        local previous=wanted; wanted=nextWanted -- receive can re-enter while sending
        for id in pairs(wanted) do
            if not previous[id] then spSendSkirmishAIMessage(id,'barb|layout|'..id..'|on') end
        end
    end
    function blueprints.Tick()
        blueprints.SetMode(mode) -- prune permission loss, dead teams, changed team selection
        for id in pairs(wanted) do spSendSkirmishAIMessage(id,'barb|layout|'..id..'|renew') end
    end
    function blueprints.Mode() return mode end
    function blueprints.Snapshot(id)
        local d=data[id]
        return {visible=wanted[id] and true or false,slots=d and d.slots or 0,built=d and d.built or 0,
            zones=d and d.zones or 0,resources=d and d.resources or 0,x=d and d.label and d.label[1],z=d and d.label and d.label[3],frame=d and d.frame,ready=d and d.entries~=nil or false}
    end
    function blueprints.Status()
        if mode==nil then return 'Blueprints hidden' end
        local n,slots,built,pending=0,0,0,0
        for id in pairs(wanted) do
            n=n+1; local d=data[id]
            if d and d.entries then slots=slots+d.slots; built=built+d.built else pending=pending+1 end
        end
        if n==0 then return 'No permitted locally hosted AI selected' end
        return string.format('%d AI | %d slots | %d built%s',n,slots,built,pending>0 and ' | awaiting plans' or '')
    end
    function blueprints.Draw()
        if mode==nil or Spring.IsGUIHidden() then return end
        gl.DepthTest(false)
        for id,d in pairs(data) do
            if wanted[id] and isPermittedTeam(id) and mayCommand(id) then
                if d.list then gl.CallList(d.list) end
                -- One cached label anchor per team; no entry traversal or terrain callback per draw.
                if d.label then
                    local a=ais[id]; local c=a and a.color or colours.p
                    gl.Color(c[1],c[2],c[3],1); gl.PushMatrix()
                    gl.Translate(d.label[1],d.label[2],d.label[3]); gl.Billboard()
                    gl.Text((a and a.name or ('AI '..id))..' / '..(a and a.roster and a.roster.role or 'layout'),0,0,14,'oc')
                    gl.PopMatrix()
                end
            end
        end
        gl.LineWidth(1); gl.Color(1,1,1,1); gl.DepthTest(true)
    end
end

-- ---------------------------------------------------------------- wiring (D-498, D-506)
local OWNER = "barbplans"
local ROSTER_SECONDS = 1.0
local saved = nil
local legacyTaken = false
local lastRoster = nil
local shownLayout = {}    -- team -> the layout state value last handed to the blueprints

-- Lanes: the request and the five-second reply watch, as in the team link.
local theatrePending = {}
local theatreStatus = ""
local function setTheatres(value)
	theatrePending = {}
	theatreStatus = value and "Requesting lanes..." or ""
	local ids = {}
	-- Keep the old all-player API for benchmark fixtures. The visible Team
	-- control requests/draws only the selected ally team, even for spectators.
	for _, id in ipairs(aiOrder) do
		if mayCommand(id) and (value ~= "team" or ais[id].allyTeam == selectedAlly) then ids[#ids + 1] = id end
	end
	theatres.SetMode(value, ids)
	if value ~= nil then lanes.EnableLanes() end
	local function request(id)
		theatrePending[id] = { time = Spring.GetTimer(), frame = spGetGameFrame() }
		theatres.Requested(id)
		spSendSkirmishAIMessage(id, "barb|theatres|" .. id .. "|refresh")
	end
	if value == "all" or value == "team" then
		for _, id in ipairs(ids) do request(id) end
		if #ids == 0 then theatreStatus = "Lanes require a locally hosted BARb AI." end
	elseif type(value) == "number" and mayCommand(value) then
		request(value)
	elseif value ~= nil then theatreStatus = "Lanes require a locally hosted BARb AI."
	end
end

-- Every state value and ai.CallUI message the hub delivers.
local function onMessage(team, line, key)
	if not line or key == "layout" then return nil end   -- the whole layout is synced from WG.barb.Value
	local ack = theatres.Receive(team, line)
	if ack then return ack end
	if string.sub(line, 1, 5) ~= "barb|" then return nil end
	local p = split(line, "|")
	local topic, sender = p[2], tonumber(p[3])
	if not sender or sender ~= team or not isPermittedTeam(sender) then return nil end
	if topic == "sealanes" then lanes.Receive(sender, table.concat(p, "|", 5))
	elseif topic == "lane_front" then strategy.ReceiveFront(sender, table.concat(p, "|", 5))
	elseif topic == "strategy" then strategy.Receive(sender, table.concat(p, "|", 5))
	elseif topic == "frontlanes" then lanes.Receive(sender, table.concat(p, "|", 5), true)
	elseif topic == "territory" then
		territory.Receive(sender, table.concat(p, "|", 5))
		strategy.TerritoryChanged(sender, table.concat(p, "|", 5))
	elseif topic == "searepair" then lanes.ReceiveRepair(sender, table.concat(p, "|", 5))
	elseif topic == "layout" then   -- the chunked ai.CallUI form
		blueprints.Receive(sender, tonumber(p[5]) or 0, tonumber(p[6]) or 0, table.concat(p, "|", 7))
	end
	return nil
end

-- The planned base of every wanted team, from the hub's state store: shown
-- when it changes, and again when a team becomes wanted (the team link's
-- layoutShown rule).
local function syncLayouts()
	local h = hub()
	if not h then return end
	for _, id in ipairs(aiOrder) do
		if blueprints.Wanted(id) then
			local value = h.Value(id, "layout")
			if value and value ~= shownLayout[id] then
				local payload = value:match("^barb|layout|%d+|%d+|(.*)$")
				if payload then blueprints.Whole(id, payload); shownLayout[id] = value end
			end
		else
			shownLayout[id] = nil
		end
	end
end

local function followSelection()
	refreshTeams()
	if type(theatres.Mode()) == "number" then setTheatres(selected)
	elseif theatres.Mode() == "team" then setTheatres("team") end
	if type(blueprints.Mode()) == "number" then blueprints.SetMode(selected)
	elseif blueprints.Mode() == "team" then blueprints.SetMode("team") end
end

-- ---------------------------------------------------------------- the tabs (D-506)
-- widget-ux-overhaul-proposal.md: no window of its own. The Lanes and
-- Blueprints tabs are drawn in the BARb window (the team link) under its AI
-- selector, with the kit it hands over (WG.barb.AddTab). Scope follows the
-- selector; layers are chips. Kept in one table: Lua 5.1 limits the main
-- chunk's locals. Cost: the lane list is rebuilt only when a lane module's
-- revision, the scope or the layers change (O(lanes)); a frame draws at most
-- the rows that fit.
local tabUI = {
	layers = { front = true, sea = true, routes = false, sites = false, territory = false, repair = false },
	more = false,                 -- the More row: live, refresh, labels, teaching, shores, cues, guide, route classes
	rows = {}, rowsLane = -1, rowsTheatre = -1, rowsMask = -1,
	listScroll = 0, lastClick = nil, lastClickKey = nil,
	hubRef = nil, restoreScope = nil,
	LAYERS = {
		{ "front", "FRONT lanes", "FRONT's land lanes, one dashed strand per lane in its team's colour; faint past the assist fork" },
		{ "sea", "Sea lanes", "SEA's lanes from the shipyard to the enemy start or a landing beach" },
		{ "routes", "Theatre routes", "The theatre survey's routes, coloured by movement class" },
		{ "sites", "Strategic sites", "Shipyard, tidal, seaplane, geothermal and island sites" },
		{ "territory", "Territory", "Mex claims by owner rule, lane spines and home circles" },
		{ "repair", "Repair points", "Naval repair points and retreating ships" },
	},
	CLASS_SHORT = { [0] = "Land", "Bot", "Amph", "Hover", "Cliff", "Sea", "Air" },
}

-- The layers onto the modules (lanes, theatres, territory).
function tabUI.apply()
	local L = tabUI.layers
	lanes.Config({ front = L.front, sea = L.sea, lanes = L.front or L.sea, repair = L.repair, show = L.front or L.sea or L.repair })
	theatres.Option("routes", L.routes)
	theatres.Option("sites", L.sites)
	territory.Set(L.territory)
	tabUI.rowsMask = -1
end

-- Layers from saved module settings (the Plans window's, or the single
-- widget's sections): read once when no tab settings were saved yet.
function tabUI.migrate(src)
	if type(src) ~= "table" then return end
	local L = tabUI.layers
	local sea, th, te = src.seaLanes, src.theatres, src.territory
	if type(sea) == "table" then
		if sea.lanes ~= nil then L.front, L.sea = sea.lanes == true, sea.lanes == true end
		if sea.repair ~= nil then L.repair = sea.repair == true and sea.show ~= false end
	end
	if type(th) == "table" then
		if th.routes ~= nil then L.routes = th.routes == true end
		if th.sites ~= nil then L.sites = th.sites == true end
	end
	if type(te) == "table" and te.show ~= nil then L.territory = te.show == true end
end

function tabUI.scope()
	local m = theatres.Mode()
	if m == nil then return "off" elseif type(m) == "number" then return "selected" end
	return "team"
end

function tabUI.setScope(v)
	refreshTeams()
	if v == "selected" then setTheatres(selected or "team")
	elseif v == "team" then setTheatres("team")
	else setTheatres(nil) end
	tabUI.rowsMask = -1
end

-- The lane list, rebuilt when a source or the layers change.
function tabUI.buildRows()
	local L = tabUI.layers
	local mask = (L.front and 1 or 0) + (L.sea and 2 or 0) + (L.routes and 4 or 0)
	local lr, tr = lanes.Revision(), theatres.Revision()
	if lr == tabUI.rowsLane and tr == tabUI.rowsTheatre and mask == tabUI.rowsMask then return tabUI.rows end
	tabUI.rowsLane, tabUI.rowsTheatre, tabUI.rowsMask = lr, tr, mask
	local rows = lanes.Strands({})
	for _, r in ipairs(rows) do
		r.label = string.format("P%d  %s", r.team, r.front and (r.kind == 3 and "fork link" or "FRONT lane")
			or (r.kind == 1 and "sea lane to a landing" or "sea lane"))
		r.detail = string.format("%.1fk", (r.length or 0) / 1000)
	end
	if L.routes then
		for _, rt in ipairs(theatres.Routes({})) do
			local width = rt.width and rt.width > 0 and string.format(" · %d wide", rt.width) or ""
			rows[#rows + 1] = { key = "r" .. rt.team .. ":" .. rt.id, team = rt.team, route = rt.id, class = rt.class, mid = rt.mid,
				label = string.format("P%d  route %d  %s", rt.team, rt.id, theatres.ClassName(rt.class) or "?"),
				detail = string.format("%.1fk%s", (rt.length or 0) / 1000, width) }
		end
	end
	for _, r in ipairs(rows) do
		local cr, cg, cb = Spring.GetTeamColor(r.team)
		r.color = { cr or 1, cg or 1, cb or 1, 1 }
	end
	tabUI.rows = rows
	return rows
end

function tabUI.isSelected(r)
	if r.route then
		local team, lane = theatres.Selected()
		return lanes.SelectedKey() == nil and team == r.team and lane == r.route
	end
	return lanes.SelectedKey() == r.key
end

function tabUI.select(r)
	if r.route then lanes.Select(nil); theatres.Select(r.team, r.route)
	else lanes.Select(r.key) end
	local now = Spring.GetTimer()
	if tabUI.lastClickKey == r.key and tabUI.lastClick and Spring.DiffTimers(now, tabUI.lastClick) < 0.4 and r.mid then
		Spring.SetCameraTarget(r.mid[1], Spring.GetGroundHeight(r.mid[1], r.mid[2]) or 0, r.mid[2], 0.5)
	end
	tabUI.lastClick, tabUI.lastClickKey = now, r.key
end

-- Chips that wrap under a row title: items {label, id, action, tooltip, active, colour}.
function tabUI.flow(K, left, right, y, title, items)
	local px = K.px
	local _, f2 = K.Fonts()
	K.text(f2, title, left, y - px(13), px(9), "o", K.C.onSurfaceVariant)
	local x0 = left + px(64)
	local x, h, gap = x0, px(18), px(4)
	for _, it in ipairs(items) do
		local w = K.textWidth(f2, it[1], px(8.5)) + px(12) + (it[6] and px(10) or 0)
		if x > x0 and x + w > right then x = x0; y = y - h - gap end
		x = K.chip(x, y - h, h, it[1], it[2], it[3], it[4], it[5], it[6], right - x0) + gap
	end
	return y - h - px(8)
end

-- The buttons the watchers press by id, also when their tab is not shown
-- (WG.barblink.ButtonRect falls back to a tab's actions).
tabUI.actions = {
	lanesPlayer = function() tabUI.setScope("selected") end,
	lanesTeam = function() tabUI.setScope("team") end,
	lanesOff = function() tabUI.setScope(nil) end,
	plansPlayer = function() refreshTeams(); blueprints.SetMode(selected) end,
	plansTeam = function() refreshTeams(); blueprints.SetMode("team") end,
	plansOff = function() blueprints.SetMode(nil) end,
	strategyShow = function() strategy.Set(not strategy.Mode()) end,
	territoryShow = function() tabUI.layers.territory = not tabUI.layers.territory; tabUI.apply() end,
}
for _, layer in ipairs(tabUI.LAYERS) do
	local k = layer[1]
	tabUI.actions["layer_" .. k] = function() tabUI.layers[k] = not tabUI.layers[k]; tabUI.apply() end
end

function tabUI.drawLanes(K, left, right, top, bottom)
	local I, C, px = K.ICON, K.C, K.px
	local f1, f2 = K.Fonts()
	local A = tabUI.actions
	local sc = tabUI.scope()
	local y = K.buttonRow(left, right, top, "Scope", {
		{ I.overlay, "Selected AI", "lanesPlayer", A.lanesPlayer, "Lanes of the AI selected in the list above", sc == "selected" },
		{ I.team, "Ally team", "lanesTeam", A.lanesTeam, "Lanes of every locally hosted AI on the selected ally team", sc == "team" },
		{ I.close, "Off", "lanesOff", A.lanesOff, "Hide the lanes", sc == "off" },
	})
	if theatreStatus ~= "" then y = K.statusLine(left, right, y, theatreStatus, C.warn, "laneStatus") end
	local items = {}
	for _, layer in ipairs(tabUI.LAYERS) do
		local k = layer[1]
		items[#items + 1] = { layer[2], "layer_" .. k, A["layer_" .. k], layer[3], tabUI.layers[k] }
	end
	items[#items + 1] = { tabUI.more and "Less" or "More", "layerMore", function() tabUI.more = not tabUI.more end,
		"Live updates, refresh, labels, teaching, shores, cues, the floating guide and route classes", tabUI.more }
	y = tabUI.flow(K, left, right, y, "Layers", items)
	if tabUI.more then
		local opt = theatres.Option
		local function toggle(k) return function() opt(k, not opt(k)) end end
		y = tabUI.flow(K, left, right, y, "Options", {
			{ "Live", "guideLiveTab", toggle("live"), "Redraw the routes whenever the AI re-surveys", opt("live") },
			{ "Refresh", "guideRefreshTab", function() theatres.Refresh() end, "Ask the AIs in scope for a fresh survey now", false },
			{ "Labels", "guideLabelsTab", toggle("labels"), "Route badges and site labels on the map", opt("labels") },
			{ "Teaching", "guideTeachTab", toggle("teaching"), "Short lessons at the selected route's terrain cue", opt("teaching") },
			{ "Shores", "guideShoresTab", toggle("shores"), "Shorelines and beach fronts", opt("shores") },
			{ "Cues", "guideCuesTab", toggle("cues"), "Approach arrows, containment brackets and observed threats", opt("cues") },
			{ "Guide", "guideShowTab", toggle("guide"), "The floating Battlefield guide: the selected route's detail", opt("guide") },
		})
		local classes = {}
		for c = 0, 6 do
			local cls = c
			classes[#classes + 1] = { tabUI.CLASS_SHORT[c], "guideClassTab" .. c, function() theatres.ClassFilter(cls, not theatres.ClassFilter(cls)); tabUI.rowsMask = -1 end,
				"Show " .. (theatres.ClassName(c) or "?") .. " routes", theatres.ClassFilter(c), theatres.ClassColour(c) }
		end
		y = tabUI.flow(K, left, right, y, "Routes", classes)
	end
	-- the lane list, above the legend and the inspect row
	local footer = px(14) + px(26) + px(16) + (strategy.Mode() and px(14) or 0)
	local rowH = px(17)
	local rows = tabUI.buildRows()
	local maxRows = math.max(0, math.floor((y - bottom - footer) / rowH))
	tabUI.listScroll = math.max(0, math.min(tabUI.listScroll, math.max(0, #rows - maxRows)))
	if sc == "off" then
		K.text(f1, "Pick a scope to show lanes.", left, y - px(11), px(8.5), "o", C.onSurfaceVariant); y = y - px(16)
	elseif #rows == 0 then
		K.text(f1, "No lanes yet: an AI publishes its lanes a few seconds into the game.", left, y - px(11), px(8.5), "o", C.onSurfaceVariant); y = y - px(16)
	elseif maxRows > 0 then
		local shown = math.min(maxRows, #rows)
		K.roundRect(left, y - shown * rowH, right, y, px(4), C.surfaceHigh)
		for i = 1, shown do
			local r = rows[i + tabUI.listScroll]
			if not r then break end
			local ry2 = y - (i - 1) * rowH
			local ry1 = ry2 - rowH
			local id = "lane_" .. r.key
			local on = tabUI.isSelected(r)
			if on then K.roundRect(left + px(1), ry1 + px(1), right - px(1), ry2 - px(1), px(3), C.primaryContainer) end
			K.stateLayer(left + px(1), ry1 + px(1), right - px(1), ry2 - px(1), px(3), id)
			K.roundRect(left + px(6), ry1 + rowH / 2 - px(4), left + px(14), ry1 + rowH / 2 + px(4), px(4), r.color)
			local dw = K.textWidth(f1, r.detail, px(8)) + px(4)
			K.text(f1, r.detail, right - px(4), ry1 + rowH * 0.5 - px(3), px(8), "or", on and C.primary or C.onSurfaceVariant)
			K.text(f1, K.fitText(f1, r.label, px(9), right - left - px(26) - dw), left + px(19), ry1 + rowH * 0.5 - px(3.2), px(9), "o", on and C.onSurface or C.onSurfaceVariant)
			local row = r
			K.register(left, ry1, right, ry2, id, function() tabUI.select(row) end, row.label .. ": click to highlight, double-click to fly there")
		end
		y = y - shown * rowH - px(2)
		if #rows > shown then
			K.text(f1, string.format("%d-%d of %d, scroll", tabUI.listScroll + 1, tabUI.listScroll + shown, #rows), right, y - px(8), px(7.5), "or", C.onSurfaceVariant)
		end
		y = y - px(12)
	end
	-- legend and inspect at the bottom
	local L = tabUI.layers
	local legend = "dashed = lane in its team's colour, solid = selected"
	if L.front then legend = legend .. " · faint = unsupplied past the assist fork" end
	if L.routes then legend = legend .. " · route colour = movement class" end
	if L.territory then legend = legend .. " · ring = lane middle, X = choke" end
	if L.repair then legend = legend .. " · wrench = repair point" end
	local ly = bottom + px(26) + px(14)
	K.statusLine(left, right, ly, legend, C.onSurfaceVariant, "laneLegend")
	local iy = K.buttonRow(left, right, bottom + px(26), "Inspect", {
		{ I.overlay, "Strategy view", "strategyShow", A.strategyShow,
			"Inspect corridor assignments, commander decisions and advisory assistance (/barbstrategy)", strategy.Mode() },
	})
	if strategy.Mode() and not WG.barbmap then
		K.statusLine(left, right, ly + px(14), "The strategy view needs the BARb map widget (terrain model).", C.warn)
	elseif strategy.Mode() then
		K.statusLine(left, right, ly + px(14), "The strategy view draws the lanes and territory while it is on.", C.onSurfaceVariant)
	end
	return iy
end

function tabUI.drawBlueprints(K, left, right, top, bottom)
	local I = K.ICON
	local A = tabUI.actions
	local mode = blueprints.Mode()
	local y = K.buttonRow(left, right, top, "Blueprints", {
		{ I.overlay, "Selected AI", "plansPlayer", A.plansPlayer, "The live blueprint of the AI selected in the list above", type(mode) == "number" },
		{ I.team, "Ally team", "plansTeam", A.plansTeam, "Blueprints of every locally hosted AI on the selected ally team", mode == "team" },
		{ I.close, "Hide", "plansOff", A.plansOff, "Hide blueprints and stop requesting snapshots", mode == nil },
	})
	y = K.statusLine(left, right, y, blueprints.Status(), nil, nil)
	y = K.statusLine(left, right, y, "cyan = planned, grey = held or built, yellow = claimed, mint = under construction", nil, "planLegend")
	y = K.statusLine(left, right, y, "orange X = protected metal or geo, arrows = factory exit; updates within 4 game seconds", nil, nil)
	return y
end

local function applyLegacy(h)
	if legacyTaken then return end
	legacyTaken = true
	if saved and (saved.theatres or saved.strategy) then return end
	local th, sl, te, st = h.LegacyConfig("theatres"), h.LegacyConfig("seaLanes"), h.LegacyConfig("territory"), h.LegacyConfig("strategy")
	if th then theatres.Config(th) end
	if sl then lanes.Config(sl) end
	if te then territory.Config(te) end
	if st then strategy.Config(st) end
	-- D-506: the single widget's sections become the Lanes tab's layers
	if th or sl or te then tabUI.migrate({ theatres = th, seaLanes = sl, territory = te }); tabUI.apply() end
end

-- The hub's services, (re)attached whenever WG.barb is a new table (the
-- team link loaded or reloaded): subscriptions, the legacy hand-off, the tabs.
local function ensureHub()
	local h = hub()
	if not h then return nil end
	if tabUI.hubRef ~= h then
		tabUI.hubRef = h
		refreshTeams()
		h.OnMessage(OWNER, onMessage)
		h.OnSelect(OWNER, function() followSelection(); tabUI.rowsMask = -1 end)
		applyLegacy(h)
		if h.AddTab then
			h.AddTab({ id = "lanes", title = "Lanes", order = 20, owner = OWNER, actions = tabUI.actions,
				tip = "Lanes of the AI or ally team selected above: scope, layers, list (Ctrl+Alt+P)",
				draw = tabUI.drawLanes, onWheel = function(up) tabUI.listScroll = tabUI.listScroll + (up and -1 or 1) end })
			h.AddTab({ id = "blueprints", title = "Blueprints", order = 30, owner = OWNER, actions = tabUI.actions,
				tip = "Planned bases of the AI or ally team selected above (/barblayout)", draw = tabUI.drawBlueprints })
		end
	end
	return h
end

local function showLanesTab()
	local h = ensureHub()
	if h and h.ShowTab then h.ShowTab("lanes", true) end
end

function widget:Initialize()
	theatres.SetRefresh(function() if theatres.Mode() then setTheatres(theatres.Mode()) end end)
	if saved then
		theatres.Config(saved.theatres)
		lanes.Config(saved.seaLanes)
		territory.Config(saved.territory)
	end
	strategy.Config(saved and saved.strategy)
	-- D-506: the tab's layers: saved, else from the module settings saved by the Plans window.
	if saved and type(saved.tab) == "table" then
		if type(saved.tab.layers) == "table" then
			for k in pairs(tabUI.layers) do if type(saved.tab.layers[k]) == "boolean" then tabUI.layers[k] = saved.tab.layers[k] end end
		end
		tabUI.more = saved.tab.more == true
		if saved.tab.scope == "selected" or saved.tab.scope == "team" then tabUI.restoreScope = saved.tab.scope end
	elseif saved then
		tabUI.migrate(saved)
	end
	tabUI.apply()
	WG.barbplans = {
		version = 2,
		-- D-506: no window; "open" is the BARb window on a lanes or blueprints tab
		IsOpen = function()
			local h = hub()
			if not (h and h.IsOpen and h.IsOpen()) then return false end
			local t = h.ActiveTab and h.ActiveTab()
			return t == "lanes" or t == "blueprints"
		end,
		SetOpen = function(v) local h = ensureHub(); if h and h.SetOpen and v then h.SetOpen(true) end end,
		ShowTab = function(id) local h = ensureHub(); return h ~= nil and h.ShowTab ~= nil and h.ShowTab(id) end,
		ButtonRect = function(id) return theatres.ButtonRect(id) end,
		MousePress = function(x, y, b) return widget:MousePress(x, y, b) end,
		MouseRelease = function(x, y, b) return widget:MouseRelease(x, y, b) end,
		MouseMove = function(x, y, dx, dy, b) return widget:MouseMove(x, y, dx, dy, b) end,
		-- tools/playtest (forwarded by WG.barblink); a test that sets the lanes
		-- directly also gets the floating guide, whose buttons it presses.
		SetTheatres = function(v) refreshTeams(); if v ~= nil then theatres.Option("guide", true) end; return setTheatres(v) end,
		SetBlueprints = function(v) refreshTeams(); return blueprints.SetMode(v) end,
		BlueprintSnapshot = blueprints.Snapshot,
		BlueprintStatus = blueprints.Status,
		TheatreSnapshot = theatres.Snapshot,
		TheatreStatus = function() return theatreStatus end,
		TheatreOptions = theatres.Config,
		TheatreConfig = theatres.GetConfig,
		SelectLane = theatres.Select,
		SetStrategy = function(v) strategy.Set(v) end,
		StrategySnapshot = function() return strategy.Snapshot() end,
		StrategyConfig = function(c) strategy.Config(c) end,
		LaneLayers = function() return tabUI.layers end,
		SetLaneLayer = function(k, v) if tabUI.layers[k] ~= nil then tabUI.layers[k] = v == true; tabUI.apply() end end,
	}
end

function widget:Shutdown()
	blueprints.SetMode(nil)
	strategy.Shutdown()
	local h = hub()
	if h then
		h.Unsubscribe(OWNER)
		if h.RemoveTab then h.RemoveTab("lanes"); h.RemoveTab("blueprints") end
	end
	if WG.barbmap and WG.barbmap.RequestData then WG.barbmap.RequestData(OWNER, false) end
	WG.barbplans = nil
end

function widget:GetConfigData()
	local sc = tabUI.scope()
	return { tab = { scope = sc ~= "off" and sc or nil, layers = tabUI.layers, more = tabUI.more },
		theatres = theatres.GetConfig(), seaLanes = lanes.GetConfig(), territory = territory.GetConfig(), strategy = strategy.GetConfig() }
end

function widget:SetConfigData(data)
	if type(data) == "table" then saved = data end
end

function widget:Update()
	ensureHub()
	local now = Spring.GetTimer()
	if not lastRoster or Spring.DiffTimers(now, lastRoster) >= ROSTER_SECONDS then
		lastRoster = now
		refreshTeams()
		syncLayouts()
		-- the scope saved last game, once the roster has an AI
		if tabUI.restoreScope and #aiOrder > 0 then tabUI.setScope(tabUI.restoreScope); tabUI.restoreScope = nil end
	end
	if WG.barbmap and WG.barbmap.RequestData then WG.barbmap.RequestData(OWNER, strategy.Mode()) end
	strategy.Update()
	local waiting = false
	for id, p in pairs(theatrePending) do
		local result = theatres.Snapshot(id)
		if result and result.frame >= p.frame then theatrePending[id] = nil
		elseif Spring.DiffTimers(now, p.time) > 5 then
			theatrePending[id] = nil
			theatreStatus = "No lane reply: this BAR build does not pass AI messages to widgets (KI-617)."
			local h = hub()
			if h then h.AddEvent("Player " .. id .. ": " .. theatreStatus, "warn") end
			spEcho("[BARb plans] " .. theatreStatus)
		else waiting = true end
	end
	if not waiting and next(theatrePending) == nil and theatreStatus == "Requesting lanes..." then theatreStatus = "" end
end

function widget:GameFrame(n)
	if n % 600 == 0 then blueprints.Tick() end
	if n < 90 then return end
	if n % 900 == 0 and theatres.Mode() and theatres.Live() then setTheatres(theatres.Mode()) end
end

function widget:DrawWorld()
	blueprints.Draw()
	if not strategy.Mode() then lanes.DrawWorld(); territory.DrawWorld() end
	strategy.DrawWorld()
end

function widget:DrawInMiniMap(sx, sy)
	lanes.DrawMiniMap(sx, sy)
	territory.DrawMiniMap(sx, sy)
end

function widget:DrawScreen()
	ensureHub()
	theatres.Draw(nil)
	if not strategy.Mode() then lanes.DrawScreen(); territory.DrawScreen() end
	strategy.DrawScreen()
end

function widget:MousePress(mx, my, mb)
	local h = hub()
	local overUi = h and h.OverAnyPanel(mx, my) or false
	if strategy.MousePress(mx, my, mb, overUi) then return true end
	if overUi then return false end
	return theatres.MousePress(mx, my, mb)
end

function widget:MouseMove(mx, my, dx, dy, mb)
	theatres.MouseMove(mx, my)
end

function widget:MouseRelease(mx, my, mb)
	theatres.MouseRelease(mx, my, mb)
	return false
end

function widget:TextCommand(cmd)
	if strategy.TextCommand(cmd) then return true end
	local laneCommand, laneMode = cmd:match("^barb(%a+)%s*(%a*)$")
	if laneCommand == "lanes" or laneCommand == "landlanes" or laneCommand == "sealanes" then
		refreshTeams()
		-- D-356: with no player selected, "on"/"player" show the member team's
		-- lanes rather than nothing (the older barbtheatres fell back the same way).
		if laneMode == "off" or laneMode == "hide" then setTheatres(nil)
		elseif laneMode == "team" then setTheatres("team")
		elseif laneMode == "player" or laneMode == "on" then setTheatres(selected or "team")
		elseif laneMode == "" then if theatres.Mode() then setTheatres(nil) else setTheatres(selected or "team") end
		else return false end
		-- D-506: the land or sea command also turns its layer on
		if laneCommand == "landlanes" and theatres.Mode() then tabUI.layers.front = true; tabUI.apply() end
		if laneCommand == "sealanes" and theatres.Mode() then tabUI.layers.sea = true; tabUI.apply() end
		return true
	end
	if lanes.TextCommand(cmd) then
		-- the tactical commands toggle layers: mirror them in the tab
		local c = lanes.GetConfig()
		tabUI.layers.repair = c.show and c.repair
		tabUI.layers.territory = territory.GetConfig().show
		if not (c.show and c.lanes) then tabUI.layers.front, tabUI.layers.sea = false, false
		elseif not (tabUI.layers.front or tabUI.layers.sea) then tabUI.layers.front, tabUI.layers.sea = true, true end
		tabUI.apply()
		return true
	end
	if territory.TextCommand(cmd) then tabUI.layers.territory = territory.GetConfig().show; return true end
	if cmd == "barbtheatres" then refreshTeams(); if theatres.Mode() then setTheatres(nil) else setTheatres(selected or "all") end; return true end
	if cmd == "barblayout" then
		refreshTeams()
		if blueprints.Mode() then blueprints.SetMode(nil) else blueprints.SetMode("team") end
		return true
	end
	if cmd == "barblayout player" then refreshTeams(); blueprints.SetMode(selected); return true end
	if cmd == "barblayout team" then refreshTeams(); blueprints.SetMode("team"); return true end
	if cmd == "barblayout off" then blueprints.SetMode(nil); return true end
	if cmd == "barbplans" then showLanesTab(); return true end
	return false
end

function widget:KeyPress(key, mods, isRepeat)
	if key == 112 and mods.ctrl and mods.alt and not isRepeat then   -- p: the Lanes tab (D-506)
		showLanesTab()
		return true
	end
	return false
end

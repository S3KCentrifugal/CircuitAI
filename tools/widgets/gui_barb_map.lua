-- BARb map
--
-- The map analysis one BARb computed at game start, as a window of its own in
-- the BARb launcher column (D-498, widget-decomposition-proposal.md). Moved
-- unchanged from the BARb team link:
--
--   Terrain (D-323, D-326): <writeDir>/LuaUI/Config/BARb/field/map.txt, written
--     once: the ground class of every cell (deep, water, shallows, flat, rough,
--     steep, cliff, lava), land masses, seas and ponds, regions, crossings and
--     cliffs, shores (beach / steep / sheer), chokes, high ground and summits,
--     geos, islands. Its legend panel holds the layers, detail and focus.
--   Landmarks (field-landmarks proposal, section 7): field/landmarks.txt,
--     written right after map.txt: start positions and territories, landmarks
--     by phase window, and the selected position's opening card.
--
-- Read-only: it asks no AI anything. BARb plans' strategy view reads the
-- terrain model through WG.barbmap (Model, RequestData), so the strategy view
-- needs this widget too.
-- The window and its tile need the BARb team link (WG.barb); without it the
-- views still work from /barbterrain and /barbmarks.
--
-- Install: copy into <BAR data dir>/LuaUI/Widgets/ with gui_barb_team_link.lua.
-- Open/close: the Map tile, /barbmap or Ctrl+Alt+T. Escape closes the window
-- while the mouse is over it. /barbterrain and /barbmarks as before.

function widget:GetInfo()
	return {
		name    = "BARb map",
		desc    = "BARb's map analysis: terrain classes, seas, chokes, summits, and landmarks with opening cards (host only)",
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

-- ---------------------------------------------------------------- field
-- The battlefield map analysis (D-323): one file per game written once by the
-- BARb AI that ran the analysis, LuaUI/Config/BARb/field/map.txt, drawn here as
-- a terrain map (D-326): ground classes, coastlines, crossings, cliffs, summits.
-- The widget asks no AI for anything: it reads the
-- file when the view is turned on, parses it once (spread over Update calls),
-- compiles bounded display-list batches and never reads again. Explicit widget
-- settings choose Terrain, Approaches or Positions; camera/selection do not.
-- Patterns and shapes supplement colour. Physical lines never fall back to
-- watershed partition lines. Partitions are explicit diagnostic data only.
-- Grammar: projects/circuitai/battlefield-analysis-implementation.md, 6.4.
local field = (function()
local PATH = "LuaUI/Config/BARb/field/map.txt"
local LAYERS = {"ground","theatres","regions","crossings","barriers","shores","chokes","key","labels"}
local options = {legend=false}
local layers = {}
for _,k in ipairs(LAYERS) do layers[k]=true end
local on = false                 -- the view is shown
local model = nil                -- parsed records
local lists = {}                 -- layer -> display list id
local labelsAll = {}             -- {x,y,z,text,size,minH,maxH,r,g,b}
local status = "Terrain map hidden"
local parse = nil                -- incremental parse state
local parseJob = nil             -- permits yielding inside long RLE records
local lastExists = nil           -- wall timer of the last VFS.FileExists check
local groundOff = false          -- Spring.SetDrawGround(false) is in effect
local focus = nil                -- {kind, id} focused record
local focusList = nil
local hover = nil                -- inspector text lines
local hoverTimer = nil
local controls = {}              -- legend panel hit regions {x1,y1,x2,y2,id=,action=}
local legendRect = nil           -- the panel's screen box as last drawn: clicks inside never reach the game
local dockX, dockY, drag, pressed
local seq = nil

-- Okabe-Ito, colour-blind safe. Every colour difference is repeated by a line style.
local K = {
    white  = {1,1,1},
    grey   = {0.72,0.72,0.74},
    orange = {0.90,0.62,0.00},
    sky    = {0.34,0.71,0.91},
    green  = {0.00,0.62,0.45},
    yellow = {0.94,0.89,0.26},
    blue   = {0.00,0.45,0.70},
    verm   = {0.84,0.37,0.00},
    purple = {0.80,0.47,0.65},
    teal   = {0.15,0.65,0.62},
    ink    = {0.025,0.045,0.07},
}
local AVENUE_PALETTE = {K.orange, K.sky, K.green, K.yellow, K.purple, K.blue, K.verm, K.grey}
local CLASS_NAMES = {[0]="vehicle","bot","amphibious","hover","all-terrain","ship","submarine"}
local BIT_VEH, BIT_BOT, BIT_AMPH, BIT_HOVER = 0, 1, 2, 3
local mint, muted = {0.35,0.9,0.73,1}, {0.65,0.73,0.8,1}
local inkPanel = {0.025,0.045,0.07,0.94}

local function split(s, sep)
    local out, from = {}, 1
    while true do
        local a, b = string.find(s, sep, from, true)
        if not a then out[#out+1] = string.sub(s, from); break end
        out[#out+1] = string.sub(s, from, a-1); from = b+1
    end
    return out
end
local function poly(s)
    local p = {}
    if not s then return p end
    for x, z in string.gmatch(s, "(-?%d+),(-?%d+)") do p[#p+1] = tonumber(x); p[#p+1] = tonumber(z) end
    return p
end
local function loops(s)
    -- theatre and region outlines: several closed loops joined by '/'
    local out = {}
    if not s then return out end
    for part in string.gmatch(s, "[^/]+") do
        local p = poly(part)
        if #p >= 4 then out[#out+1] = p end
    end
    return out
end
local function spine(s)
    local p = {}
    if not s then return p end
    for x, z, w in string.gmatch(s, "(-?%d+),(-?%d+),(-?%d+)") do p[#p+1] = {tonumber(x), tonumber(z), tonumber(w)} end
    return p
end
local function ints(s)
    local out = {}
    if not s then return out end
    for v in string.gmatch(s, "-?%d+") do out[#out+1] = tonumber(v) end
    return out
end
local function num(v, d) return tonumber(v) or d or 0 end
local function hasBit(mask, bit) return math.floor((mask or 0) / 2^bit) % 2 == 1 end
local function loose(name) return string.lower((string.gsub(name or "", "[%s%._%-]", ""))) end
local function groundY(x, z) return math.max(0, Spring.GetGroundHeight(x, z)) + 6 end

local function isWaterChar(c) return c=="water" or c=="deep" or c=="coast" or c=="strait" end

-- ---- file discovery and incremental parsing
local function newModel()
    return {classes={}, theatres={}, regions={}, boundaries={}, chokes={}, avenues={}, landings={}, standoff={},
        sides={}, contact={}, keys={}, corridors={}, corridorRuns={}, clearanceRuns={}, runs={}, groundRuns={}, rowRun={}, gw=0, gh=0, cell=32, name="", settings={}}
end
local function parseRecord(m, line)
    local f = split(line, "|")
    local k = f[1]
    if k == "corridor" then
        local id, cls = num(f[2],-1), num(f[3],-1)
        if id<0 or cls<0 or cls>6 then error("invalid corridor identity") end
        m.corridors[id]={id=id,class=cls,name=f[4],length=num(f[5]),width=num(f[6]),
            x=num(f[7]),z=num(f[8]),meanWidth=num(f[9]),specialist=num(f[10])==1,
            routes=num(f[11]),lateral=num(f[12]),lane=num(f[13]),lanes=num(f[14]),extent=num(f[15]),spine=spine(f[16])}
    elseif k == "corridorcells" or k == "clearance" then
        local cls=num(f[2],-1)
        if cls<0 or cls>6 then error("invalid corridor raster class") end
        local runs,start={},0
        for id,count in string.gmatch(f[3] or "", "(-?%d+)%*(%d+)") do
            id,count=tonumber(id),tonumber(count)
            if count<=0 or start+count>m.gw*m.gh or id< -1 or (k=="clearance" and (id<0 or id>255)) then error("invalid corridor raster") end
            runs[#runs+1]={start,id,count};start=start+count
            if #runs%256==0 then coroutine.yield() end
        end
        if start~=m.gw*m.gh then error("incomplete corridor raster") end
        if k=="corridorcells" then m.corridorRuns[cls]=runs else m.clearanceRuns[cls]=runs end
    elseif k == "experience" then
        m.experience = num(f[2])
    elseif k == "access" then
        m.accessRuns = {}; local start, runCount = 0, 0
        for id, count in string.gmatch(f[2] or "", "(%d+)%*(%d+)") do
            local n = tonumber(count)
            if n <= 0 or tonumber(id)>255 or start + n > m.gw * m.gh then error("invalid access run") end
            m.accessRuns[#m.accessRuns+1] = {start, tonumber(id), n}; start = start + n
            runCount=runCount+1;if runCount%256==0 then coroutine.yield() end
        end
        m.accessCount = start
    elseif k == "passage" then
        m.passages = m.passages or {}
        m.passages[#m.passages+1] = {id=num(f[2]), mask=num(f[3]), width=num(f[4]), line=poly(f[5])}
    elseif k == "landingdir" then
        m.landingDirs=m.landingDirs or {};m.landingDirs[num(f[2])]={x=num(f[3]),z=num(f[4]),dx=num(f[5]),dz=num(f[6])}
    elseif k == "site" then
        m.sites = m.sites or {}
        m.sites[#m.sites+1] = {id=num(f[2]), category=f[3], name=f[4], x=num(f[5]), z=num(f[6]), mask=num(f[7]),
            ally=num(f[8], -1), reason=f[9], basis=f[10]}
    elseif k == "theatre" then
        local id = num(f[2])
        m.theatres[id] = {id=id, kind=f[3], name=f[4] or "", cells=num(f[5]), x=num(f[6]), z=num(f[7]), holders=num(f[8]), outline=loops(f[9])}
    elseif k == "region" then
        local id = num(f[2])
        m.regions[id] = {id=id, theatre=num(f[3]), character=f[4] or "plain", cells=num(f[5]), medianW=num(f[6]), lowW=num(f[7]),
            minH=num(f[8]), maxH=num(f[9]), lx=num(f[10]), lz=num(f[11]), outline=loops(f[12])}
    elseif k == "boundary" then
        m.boundaries[#m.boundaries+1] = {id=num(f[2]), kind=f[3], a=num(f[4]), b=num(f[5]), mask=num(f[6]), width=num(f[7]),
            slope=num(f[8]), line=poly(f[9])}
    elseif k == "choke" then
        m.chokes[#m.chokes+1] = {id=num(f[2]), a=num(f[3]), b=num(f[4]), x=num(f[5]), z=num(f[6]), dx=num(f[7]), dz=num(f[8]), width=num(f[9])}
    elseif k == "avenue" then
        m.avenues[#m.avenues+1] = {id=num(f[2]), class=num(f[3]), name=f[4] or "", specialist=num(f[5])==1, length=num(f[6]),
            regions=ints(f[7]), crossings=ints(f[8]), spine=spine(f[9]), outline=poly(f[10])}
    elseif k == "landing" then
        local so = ints(f[12])
        local ov = f[13] and f[13] ~= "-" and ints(f[13]) or nil
        m.landings[#m.landings+1] = {id=num(f[2]), kind=f[3], sea=num(f[4]), region=num(f[5]), side=num(f[6], -1), assault=num(f[7])==1,
            rank=num(f[8]), mask=num(f[9]), width=num(f[10]), inland=num(f[11]), standoff={so[1] or -1, so[2] or -1, so[3] or -1},
            overlook=ov, line=poly(f[14])}
    elseif k == "standoff" then
        m.standoff[#m.standoff+1] = {sea=num(f[2]), depth=num(f[3]), line=poly(f[4])}
    elseif k == "side" then
        m.sides[#m.sides+1] = {ally=num(f[2]), box=poly(f[3]), cells=num(f[4]), lx=num(f[5]), lz=num(f[6])}
    elseif k == "contact" then
        m.contact[#m.contact+1] = poly(f[2])
    elseif k == "key" then
        m.keys[#m.keys+1] = {kind=f[2], x=num(f[3]), z=num(f[4]), value=num(f[5]), region=num(f[6], -1), side=num(f[7], -1), avenue=f[8]}
    elseif k == "class" then
        m.classes[num(f[2])] = {name=f[3] or "", slope=num(f[4]), minDepth=num(f[5]), maxDepth=num(f[6]), flags=num(f[7])}
    elseif k == "settings" then
        for key, v in string.gmatch(f[2] or "", "([%w_]+)=([^;]+)") do m.settings[key] = tonumber(v) or v end
    elseif k == "ground" then
        -- D-326: run-length ground class per cell, same form as the region ids
        local runs, start, runCount = m.groundRuns, 0, 0
        for id, count in string.gmatch(f[2] or "", "(%d+)%*(%d+)") do
            if tonumber(count)<=0 or tonumber(id)>7 or start+tonumber(count)>m.gw*m.gh then error("invalid ground run") end
            runs[#runs+1] = {start, tonumber(id), tonumber(count)}
            start = start + tonumber(count)
            runCount=runCount+1;if runCount%256==0 then coroutine.yield() end
        end
        m.groundCellCount=start
    elseif k == "cells" then
        -- Run-length region ids, kept as runs: regionOf(cell) scans the few runs of its row.
        local runs, start, runCount = m.runs, 0, 0
        for id, count in string.gmatch(f[2] or "", "(%d+)%*(%d+)") do
            runs[#runs+1] = {start, tonumber(id), tonumber(count)}
            start = start + tonumber(count)
            runCount=runCount+1;if runCount%256==0 then coroutine.yield() end
        end
        m.cellCount = start
    end
end
local function indexRuns(m)
    local gw = math.max(1, m.gw)
    m.rowRun = {}
    for i, r in ipairs(m.runs) do
        local row0 = math.floor(r[1] / gw)
        local row1 = math.floor((r[1] + r[3] - 1) / gw)
        for row = row0, row1 do if not m.rowRun[row] then m.rowRun[row] = i end end
    end
end
local function regionOf(m, x, z)
    if not m or m.gw == 0 then return nil end
    local cx, cz = math.floor(x / m.cell), math.floor(z / m.cell)
    if cx < 0 or cz < 0 or cx >= m.gw or cz >= m.gh then return nil end
    local c = cz * m.gw + cx
    local i = m.rowRun[cz]; if not i then return nil end
    while m.runs[i] do
        local r = m.runs[i]
        if c < r[1] then return nil end
        if c < r[1] + r[3] then return r[2] end
        i = i + 1
    end
    return nil
end

local compileAll   -- forward
local function beginParse(text)
    local fmt, name, gw, gh, cell, fseq = string.match(text, "^barbfield|(%d+)|([^|]*)|(%d+)|(%d+)|(%d+)|(%d+)")
    if not fmt then return false, "unexpected header" end
    if tonumber(fmt) ~= 1 then return false, "format " .. tostring(fmt) end
    local trailer = "\nend|" .. fseq
    local tp = string.find(text, trailer, 1, true)
    if not tp then return false, "torn file" end
    local after = string.sub(text, tp + #trailer, tp + #trailer)
    if after ~= "" and after ~= "\n" and after ~= "\r" then return false, "torn file" end
    if name ~= "" and Game.mapName and loose(name) ~= loose(Game.mapName) then
        return false, "file is for map '" .. name .. "'"
    end
    local m = newModel()
    m.name, m.gw, m.gh, m.cell = name, tonumber(gw), tonumber(gh), tonumber(cell)
    if m.gw < 1 or m.gh < 1 or m.gw * m.gh > 4194304 or m.cell < 1 then return false, "invalid grid" end
    -- the header's ninth field: the analysis fingerprint the landmarks file must repeat
    m.fingerprint = string.match(text, "^barbfield|[^|]*|[^|]*|[^|]*|[^|]*|[^|]*|[^|]*|[^|]*|([^|\r\n]+)")
    -- Recoil Lua uses FLOAT numbers: even a 9-digit revision loses precision.
    -- Long division keeps every intermediate digit <= 19, preserving the native
    -- fingerprint % 1000000007 + 1 as an exact decimal string. Once per file.
    local rem,divisor="0","1000000007"
    for digit in string.gmatch(m.fingerprint or "","%d") do
        rem=(rem=="0" and "" or rem)..digit
        while #rem>#divisor or (#rem==#divisor and rem>=divisor) do
            local out,borrow="",0
            for i=#rem,1,-1 do
                local j=i-(#rem-#divisor)
                local d=tonumber(rem:sub(i,i))-(j>0 and tonumber(divisor:sub(j,j)) or 0)-borrow
                borrow=d<0 and 1 or 0;if d<0 then d=d+10 end
                out=tostring(d)..out
            end
            rem=out:gsub("^0+","");if rem=="" then rem="0" end
        end
    end
    local out,carry="",1
    for i=#rem,1,-1 do local d=tonumber(rem:sub(i,i))+carry;carry=d>=10 and 1 or 0;out=tostring(d%10)..out end
    m.corridorRevision=(carry>0 and "1" or "")..out
    parse = {text=text, pos=1, m=m, total=#text, seq=tonumber(fseq)}
    return true
end
local function stepParse()
    if not parse then return end
    local t0 = Spring.GetTimer()
    local text, pos = parse.text, parse.pos
    local lines = 0
    while true do
        local e = string.find(text, "\n", pos, true)
        local line = e and string.sub(text, pos, e-1) or string.sub(text, pos)
        if string.sub(line, -1) == "\r" then line = string.sub(line, 1, -2) end
        if #line > 0 and not string.find(line, "^barbfield") and not string.find(line, "^end|") then parseRecord(parse.m, line) end
        pos = e and e + 1 or #text + 1
        lines = lines + 1
        if pos > #text then break end
        if lines % 64 == 0 and Spring.DiffTimers(Spring.GetTimer(), t0) > 0.002 then break end
    end
    parse.pos = pos
    if pos > #text then
        local m = parse.m
        if m.cellCount ~= m.gw * m.gh or (m.experience == 2 and (m.accessCount ~= m.cellCount or m.groundCellCount ~= m.cellCount)) then
            parse = nil; status = "Incomplete terrain grid"; return
        end
        indexRuns(m)
        model, seq = m, parse.seq
        parse = nil
        if on then compileAll() else status="Terrain analysis ready" end
    else
        status = string.format("Reading terrain analysis %d%%", math.floor(100 * pos / math.max(1, #text)))
    end
end
local function tryLoad()
    -- Recoil changes cwd to the write directory. Direct IO deliberately avoids
    -- VFS's fallback to a stale same-map export in another data directory.
    -- Native clears its previous file during frame-zero initialization.
    if Spring.GetGameFrame and Spring.GetGameFrame()<1 then return end
    if not (io and io.open) then status="Local terrain file access unavailable";return end
    local now = Spring.GetTimer()
    if lastExists and Spring.DiffTimers(now, lastExists) < 2 then return end
    lastExists = now
    local ok, text = pcall(function()
        local f=io.open(PATH,"rb");if not f then return nil end
        local value=f:read(64*1024*1024+1);f:close();return value
    end)
    if ok and not text then
        status = "Terrain analysis not published (needs a locally hosted BARb with field.enabled)"
        return
    end
    if not ok or type(text) ~= "string" or #text == 0 then status = "Cannot read " .. PATH; return end
    if #text>64*1024*1024 then status="Terrain file exceeds size limit";return end
    local good, err = beginParse(text)
    if not good then status = "Terrain file skipped: " .. tostring(err) end
end

-- ---- line generation helpers
-- Every stroke goes through seg(). In world space seg() splits long segments so the
-- line follows the terrain; the legend swaps in a flat screen-space emitter (`emit`)
-- and shrinks the pattern lengths (`patScale`), so a legend row is drawn by exactly
-- the code that draws the map. Every line layer is compiled twice into its display
-- list: an ink under-stroke three pixels wider (`haloPass`) and then the colour, so a
-- line keeps its contrast over bright sand, dark forest or another line.
local SEG_MAX = 128   -- elmos; longer segments are split so the line follows the terrain
local emit = nil      -- nil: world space; else function(ax, az, bx, bz) emitting 2D vertices
local patScale = 1    -- pattern lengths are in elmos; the legend scales them to pixels
local haloPass = false
local function seg(ax, az, bx, bz)
    if emit then emit(ax, az, bx, bz); return end
    local dx, dz = bx - ax, bz - az
    local len = math.sqrt(dx*dx + dz*dz)
    local n = math.max(1, math.ceil(len / SEG_MAX))
    local px, pz = ax, az
    for i = 1, n do
        local f = i / n
        local x, z = ax + dx*f, az + dz*f
        gl.Vertex(px, groundY(px, pz), pz); gl.Vertex(x, groundY(x, z), z)
        px, pz = x, z
    end
end
local function tri(ax, az, bx, bz, cx, cz)
    -- a filled triangle (inside gl.BeginEnd(GL.TRIANGLES)); small enough to sit on the ground
    if emit then gl.Vertex(ax, az); gl.Vertex(bx, bz); gl.Vertex(cx, cz); return end
    gl.Vertex(ax, groundY(ax, az), az); gl.Vertex(bx, groundY(bx, bz), bz); gl.Vertex(cx, groundY(cx, cz), cz)
end
local function solid(p)
    for i = 3, #p, 2 do seg(p[i-2], p[i-1], p[i], p[i+1]) end
end
local function solidLoops(ls) for _, p in ipairs(ls) do solid(p) end end
-- Chaikin corner cutting: the file's lines follow 32-elmo cell edges (a staircase on any
-- diagonal); two passes turn them into readable curves within a quarter cell of the edge.
-- A loop (first point == last point) stays closed; an open chain keeps its end points.
local SMOOTH_PASSES = 2
local SMOOTH_TOL = 32   -- elmos; set from the model's cell size (one cell) when it loads
-- Douglas-Peucker on a flat x,z list between point indices i0 and i1 (1-based point
-- numbers); appends kept points (excluding i0) to out. A 32-elmo staircase on a
-- diagonal deviates about 11 elmos from the straight line and a 2:1 staircase about
-- 28, so one cell collapses both to their diagonal while real bends survive.
local function dpSegment(p, i0, i1, tol, out)
    local ax, az = p[2*i0-1], p[2*i0]
    local bx, bz = p[2*i1-1], p[2*i1]
    local dx, dz = bx-ax, bz-az
    local len = math.sqrt(dx*dx + dz*dz)
    local best, bestI = -1, nil
    for i = i0+1, i1-1 do
        local x, z = p[2*i-1], p[2*i]
        local d
        if len == 0 then d = math.sqrt((x-ax)^2 + (z-az)^2)
        else d = math.abs(dx*(z-az) - dz*(x-ax)) / len end
        if d > best then best, bestI = d, i end
    end
    if bestI and best > tol then
        dpSegment(p, i0, bestI, tol, out)
        dpSegment(p, bestI, i1, tol, out)
    else
        out[#out+1] = bx; out[#out+1] = bz
    end
end
local function simplify(p, tol, closed)
    local n = math.floor(#p / 2)
    if n < 3 then return p end
    local out = {p[1], p[2]}
    if closed then
        -- anchor a loop at its first point and the point farthest from it
        local far, farI = -1, 2
        for i = 2, n-1 do
            local d = (p[2*i-1]-p[1])^2 + (p[2*i]-p[2])^2
            if d > far then far, farI = d, i end
        end
        dpSegment(p, 1, farI, tol, out)
        dpSegment(p, farI, n, tol, out)
    else
        dpSegment(p, 1, n, tol, out)
    end
    return out
end
local function smooth(p)
    if #p < 6 then return p end
    local closed = p[1] == p[#p-1] and p[2] == p[#p]
    local cur = simplify(p, SMOOTH_TOL, closed)
    if #cur < 6 then return cur end
    for _ = 1, SMOOTH_PASSES do
        local out = {}
        local n = #cur - (#cur % 2)   -- flat x,z pairs; ignore a dangling odd value
        if not closed then out[1], out[2] = cur[1], cur[2] end
        for i = 3, n, 2 do
            local ax, az, bx, bz = cur[i-2], cur[i-1], cur[i], cur[i+1]
            out[#out+1] = ax*0.75 + bx*0.25; out[#out+1] = az*0.75 + bz*0.25
            out[#out+1] = ax*0.25 + bx*0.75; out[#out+1] = az*0.25 + bz*0.75
        end
        if closed then out[#out+1] = out[1]; out[#out+1] = out[2]
        else out[#out+1] = cur[n-1]; out[#out+1] = cur[n] end
        cur = out
    end
    return cur
end
local function smoothLoops(ls) local out = {}; for i, p in ipairs(ls) do out[i] = smooth(p) end; return out end
-- Patterns: on/off run lengths in elmos repeated along the line, phase carried across
-- vertices. The pattern, not the colour, is what tells two kinds of line apart.
local PAT = {
    longdash = {64, 24},
}
local function pattern(p, seq)
    local n = #seq
    local k, phase = 1, 0
    for i = 3, #p, 2 do
        local ax, az, bx, bz = p[i-2], p[i-1], p[i], p[i+1]
        local dx, dz = bx-ax, bz-az
        local len = math.sqrt(dx*dx + dz*dz)
        if len > 0 then
            dx, dz = dx/len, dz/len
            local t = 0
            while t < len do
                local run = seq[k] * patScale - phase
                local t2 = math.min(len, t + run)
                if k % 2 == 1 then seg(ax+dx*t, az+dz*t, ax+dx*t2, az+dz*t2) end
                if t2 >= len then phase = phase + (len - t) else phase = 0; k = k % n + 1 end
                t = t2
            end
        end
    end
end
local function hachures(p, every, length, towardLeft)
    -- short ticks on one side of the line, every `every` elmos
    every, length = every * patScale, length * patScale
    local acc = every / 2
    for i = 3, #p, 2 do
        local ax, az, bx, bz = p[i-2], p[i-1], p[i], p[i+1]
        local dx, dz = bx-ax, bz-az
        local len = math.sqrt(dx*dx + dz*dz)
        if len > 0 then
            dx, dz = dx/len, dz/len
            local nx, nz = -dz, dx
            if not towardLeft then nx, nz = dz, -dx end
            local t = acc
            while t < len do
                local x, z = ax+dx*t, az+dz*t
                seg(x, z, x+nx*length, z+nz*length)
                t = t + every
            end
            acc = t - len
        end
    end
end
local function double(p, off)
    -- the line and a parallel copy `off` elmos to its left
    solid(p)
    off = off * patScale
    for i = 3, #p, 2 do
        local ax, az, bx, bz = p[i-2], p[i-1], p[i], p[i+1]
        local dx, dz = bx-ax, bz-az
        local len = math.sqrt(dx*dx+dz*dz)
        if len > 0 then
            local nx, nz = -dz/len*off, dx/len*off
            seg(ax+nx, az+nz, bx+nx, bz+nz)
        end
    end
end
local function polyMid(p)
    -- the point half way along the polyline's length
    if #p < 2 then return 0, 0 end
    if #p < 4 then return p[1], p[2] end
    local total = 0
    for i = 3, #p, 2 do local dx, dz = p[i]-p[i-2], p[i+1]-p[i-1]; total = total + math.sqrt(dx*dx+dz*dz) end
    local half, acc = total / 2, 0
    for i = 3, #p, 2 do
        local dx, dz = p[i]-p[i-2], p[i+1]-p[i-1]
        local len = math.sqrt(dx*dx+dz*dz)
        if acc + len >= half and len > 0 then
            local f = (half - acc) / len
            return p[i-2] + dx*f, p[i-1] + dz*f
        end
        acc = acc + len
    end
    return p[#p-1], p[#p]
end
local function ibeam(x, z, dx, dz, half, serif)
    -- a choke: the width bar perpendicular to (dx,dz) with a serif at each end along the crossing
    local len = math.sqrt(dx*dx+dz*dz); if len == 0 then dx, dz, len = 1, 0, 1 end
    dx, dz = dx/len, dz/len
    local s = (serif or 14) * patScale
    local lx, lz, rx, rz = x - dz*half, z + dx*half, x + dz*half, z - dx*half
    seg(lx, lz, rx, rz)
    seg(lx - dx*s, lz - dz*s, lx + dx*s, lz + dz*s)
    seg(rx - dx*s, rz - dz*s, rx + dx*s, rz + dz*s)
end
local function triangle(x, z, r)
    -- an upright triangle of "radius" r centred on (x, z); returns its corners for a fill
    local lx, lz, rx, rz, tx, tz = x - r, z + r*0.75, x + r, z + r*0.75, x, z - r
    seg(lx, lz, rx, rz); seg(lx, lz, tx, tz); seg(rx, rz, tx, tz)
    return lx, lz, rx, rz, tx, tz
end
local function ngon(x, z, r, n)
    local px, pz
    for i = 0, n do
        local a = i * 2 * math.pi / n
        local cx, cz = x + math.cos(a)*r, z + math.sin(a)*r
        if px then seg(px, pz, cx, cz) end
        px, pz = cx, cz
    end
end
local function stroke(c, a, w)
    -- the current line colour and width; in the halo pass every line is a wider ink stroke
    if haloPass then gl.Color(K.ink[1], K.ink[2], K.ink[3], 0.85); gl.LineWidth((w or 2) + 3)
    else gl.Color(c[1], c[2], c[3], a or 1); gl.LineWidth(w or 2) end
end
local function setColour(c, a) gl.Color(c[1], c[2], c[3], a or 1) end   -- fills and marks only

-- The style of every line. No two differ in colour alone, because the legend is read
-- by colour-blind players too: the pattern carries the meaning and the colour only
-- repeats it. Five line types in all: solid heavy (coast), solid thin (open border),
-- long dash (a crossing some unit class can use; which one, the inspector says),
-- double (ford), solid with ticks (nobody crosses; the ticks point down or to the water).
local STYLE = {
    coast    = {pat="solid",    w=3,   c=K.white,  a=0.9},
    region   = {pat="solid",    w=1,   c=K.grey,   a=0.6},
    crossing = {pat="longdash", w=2.5, c=K.white,  a=0.95},
    ford     = {pat="double",   w=1.5, c=K.white,  a=0.9},
    blocked  = {pat="ticked",   w=3,   c=K.verm,   a=0.95},
    choke    = {pat="solid",    w=2.5, c=K.white,  a=0.95},
    key      = {pat="solid",    w=1.5, c=K.yellow, a=0.95},
}
-- The ground classes the AI writes per cell (D-326), in file order. Each is a fill, a
-- mark, or both; the mark alone tells the class on a monochrome print. The text is
-- the legend row.
local GROUND = {
    [0] = {name="deep",    fill=K.blue,   alpha=0.30, mark=nil,       text="Deep water: ships sail it"},
    [1] = {name="water",   fill=K.sky,    alpha=0.22, mark="wave",    text="Water, no ships: hovers and amphibious only"},
    [2] = {name="shallow", fill=K.teal,   alpha=0.32, mark="dash",    text="Shallows, marsh: land units wade, slowed"},
    [3] = {name="flat",    fill=nil,      alpha=0,    mark=nil,       text="Flat: vehicles drive"},
    [4] = {name="rough",   fill=nil,      alpha=0,    mark="hatch",   text="Rough: vehicles slowed, bots fine"},
    [5] = {name="steep",   fill=K.orange, alpha=0.12, mark="hatch2",  text="Steep: bots and amphibious climb, no vehicles"},
    [6] = {name="cliff",   fill=K.verm,   alpha=0.16, mark="cross",   text="Cliff: all-terrain only, or nobody"},
    [7] = {name="harm",    fill=K.verm,   alpha=0.30, mark="dot",     text="Lava, acid: deadly to everything that is not flying"},
}
local MARK_COLOUR = {wave=K.sky, dash=K.teal, hatch=K.grey, hatch2=K.orange, cross=K.verm, dot=K.verm}
local function drawPat(st, p, left)
    -- polyline p in style st's pattern (inside gl.BeginEnd(GL.LINES)); left: tick side
    local pat = st.pat
    if pat == "solid" then solid(p)
    elseif pat == "double" then double(p, 10)
    elseif pat == "ticked" then solid(p); hachures(p, 40, 18, left)
    elseif PAT[pat] then pattern(p, PAT[pat])
    else solid(p) end
end
local function strokeStyle(st, a) stroke(st.c, a or st.a, st.w) end

local function regionIsWater(m, id) local r = m.regions[id]; return r and isWaterChar(r.character) end
local function regionLabel(m, id) local r = m.regions[id]; if r then return r.lx, r.lz end return nil end
local FILL_MAX_CELLS = 4   -- a fill quad spans at most this many cells so it can follow the ground
local fillColour = {1, 1, 1, 0.2}   -- set by fillWith() before fillRuns(); per-vertex alpha needs it
local function fillWith(c, a) fillColour = {c[1], c[2], c[3], a} end
local function fillRuns(m, runs, table, want, waterY)
    -- quads per run for the ids in `want` (set) over run-length `runs` ({start, id, count})
    -- whose per-cell expansion is `table`: a flat fill with no triangulation.
    -- waterY: a flat surface height for water fills; nil samples the ground at every corner.
    -- Soft edge: a grid node whose four cells are not all in `want` gets alpha 0, so the
    -- fill fades out over the border cell instead of showing a hard cell staircase
    -- beside the smoothed border line. Cells with any faded corner are drawn one by
    -- one; full-alpha runs are merged up to FILL_MAX_CELLS. The map edge counts as inside.
    local gw, gh, cell = m.gw, m.gh, m.cell
    local cr, cg, cb, ca = fillColour[1], fillColour[2], fillColour[3], fillColour[4]
    local function y(x, z) if waterY then return waterY end return math.max(0, Spring.GetGroundHeight(x, z)) + 4 end
    local function inside(col, row)
        if col < 0 or row < 0 or col >= gw or row >= gh then return true end
        local id = table[row * gw + col]
        return id == nil or want[id] == true
    end
    -- node (nx, nz) is full when the four cells around it are inside
    local function nodeFull(nx, nz)
        return inside(nx-1, nz-1) and inside(nx, nz-1) and inside(nx-1, nz) and inside(nx, nz)
    end
    gl.BeginEnd(GL.QUADS, function()
        local function vertex(nx, nz, full)
            gl.Color(cr, cg, cb, full and ca or 0)
            local x, z = nx*cell, nz*cell
            gl.Vertex(x, y(x, z), z)
        end
        local function quad(row, col, take)
            vertex(col, row, nodeFull(col, row)); vertex(col+take, row, nodeFull(col+take, row))
            vertex(col+take, row+1, nodeFull(col+take, row+1)); vertex(col, row+1, nodeFull(col, row+1))
        end
        for _, r in ipairs(runs) do
            if want[r[2]] then
                local startCol, count, row = nil, 0, nil
                for c = r[1], r[1] + r[3] - 1 do
                    local rw, col = math.floor(c / gw), c % gw
                    -- a cell is mergeable only when its four corners are all full
                    local plain = nodeFull(col, rw) and nodeFull(col+1, rw) and nodeFull(col, rw+1) and nodeFull(col+1, rw+1)
                    if plain and startCol and rw == row and count < FILL_MAX_CELLS then
                        count = count + 1
                    else
                        if startCol then quad(row, startCol, count) end
                        if plain then startCol, count, row = col, 1, rw
                        else startCol, count = nil, 0; quad(rw, col, 1) end
                    end
                end
                if startCol then quad(row, startCol, count) end
            end
        end
    end)
    gl.Color(cr, cg, cb, ca)
end
local function markCell(kind, x, z, q)
    -- one cell's mark, centred on (x, z) with half size q (inside gl.BeginEnd(GL.LINES))
    if kind == "hatch" then seg(x-q, z+q, x+q, z-q)
    elseif kind == "hatch2" then seg(x-q, z+q, x+q, z-q); seg(x-q, z, x, z-q)
    elseif kind == "cross" then seg(x-q, z-q, x+q, z+q); seg(x-q, z+q, x+q, z-q)
    elseif kind == "dash" then seg(x-q, z, x+q, z)
    elseif kind == "wave" then seg(x-q, z+q*0.3, x-q*0.3, z-q*0.3); seg(x-q*0.3, z-q*0.3, x+q*0.3, z+q*0.3); seg(x+q*0.3, z+q*0.3, x+q, z-q*0.3)
    elseif kind == "dot" then seg(x-2, z, x+2, z) end
end
local function cellMarks(m, runs, want, kind, every)
    -- a per-cell mark for the ids in `want`: every cell (every = 1) or every other (2)
    local gw, cell = m.gw, m.cell
    gl.BeginEnd(GL.LINES, function()
        for _, r in ipairs(runs) do
            if want[r[2]] then
                for c = r[1], r[1] + r[3] - 1 do
                    local row, col = math.floor(c / gw), c % gw
                    if (row + col) % every == 0 then
                        markCell(kind, col*cell + cell/2, row*cell + cell/2, cell * 0.3)
                    end
                end
            end
        end
    end)
end

local function addLabel(x, z, textValue, size, minH, maxH, c)
    if #labelsAll >= 200 then return end
    labelsAll[#labelsAll+1] = {x, groundY(x, z) + 10, z, textValue, size, minH, maxH, c}
end
local function spaced(s) return (string.gsub(string.upper(s), ".", "%0 ")) end

local function disposeLists()
    for k, l in pairs(lists) do gl.DeleteList(l) end
    lists = {}
    if focusList then gl.DeleteList(focusList); focusList = nil end
    labelsAll = {}
end

local function compileLayer(name, fn)
    if lists[name] then gl.DeleteList(lists[name]) end
    lists[name] = gl.CreateList(fn)
end
local function lineLayer(name, fn)
    -- a line layer is compiled twice into one list: the ink under-stroke, then the colour
    compileLayer(name, function() haloPass = true; fn(); haloPass = false; fn() end)
end
-- A summit is a plateau no land unit reaches: every one of its borders is a cliff, a
-- sheer shore or the map edge, so only all-terrain units and aircraft get there.
local REACHABLE = {open=true, ramp=true, climb=true, pass=true, ford=true, beach=true, steep=true}
local function findSummits(m)
    local reach = {}
    for _, b in ipairs(m.boundaries) do
        if REACHABLE[b.kind] then reach[b.a] = true; reach[b.b] = true end
    end
    m.summits = {}
    for id, r in pairs(m.regions) do
        if r.character == "plateau" and not reach[id] then m.summits[id] = true end
    end
end

-- Geometry is compiled incrementally by the experience controller below.

-- ---- blueprint mode
local function setGround(off)
    if off == groundOff then return end
    groundOff = off
    if Spring.SetDrawGround then Spring.SetDrawGround(not off) end
    if Spring.SetDrawWater then Spring.SetDrawWater(not off) end
end

local setMode, setBlueprint, setLayer, setFocus
local drawWorld, drawMiniMap, drawScreen, update

local function button(id, x, y, w, title, isOn, action)
    gl.Color(isOn and {0.12,0.30,0.34,0.98} or {0.09,0.13,0.18,0.98}); gl.Rect(x, y, x+w, y+24)
    gl.Color(isOn and mint or {0.83,0.87,0.93,1}); gl.Text(dialogUI.Fit(title,12,w-12), x+w/2, y+6, 12, "oc")
    controls[#controls+1] = {x, y, x+w, y+24, id=id, action=action}
end
local function hitAt(x, y)
    for i = #controls, 1, -1 do local r = controls[i]; if x >= r[1] and y >= r[2] and x <= r[3] and y <= r[4] then return r end end
end
local mousePress
local function mouseRelease(x, y, b)
    local was = pressed ~= nil or drag ~= nil
    if drag then drag = nil
    elseif pressed and b == 1 then
        local r = hitAt(x, y)
        if r and r.id == pressed.id and r.action then r.action() end
    end
    pressed = nil
    return was
end
local function mouseMove(x, y)
    if drag then dockX = drag[3] + x - drag[1]; dockY = drag[4] + y - drag[2]; return true end
end
local function snapshot()
    local out = {loaded = model ~= nil, seq = seq, theatres = 0, land = 0, seas = 0, ponds = 0, regions = 0, boundaries = 0, chokes = 0,
        summits = 0, keys = 0, avenues = 0, landings = 0, assault = 0, ground = {}, layers = {},
        items = {theatres = {}, chokes = {}, summits = {}, landings = {}, avenues = {}}, on = on, status = status}
    for k, v in pairs(layers) do out.layers[k] = v end
    local m = model
    if not m then return out end
    for _, t in pairs(m.theatres) do
        out.theatres = out.theatres + 1
        if t.kind == "sea" then out.seas = out.seas + 1 elseif t.kind == "pond" then out.ponds = out.ponds + 1 else out.land = out.land + 1 end
        out.items.theatres[#out.items.theatres+1] = {id=t.id, kind=t.kind, name=t.name, x=t.x, z=t.z, cells=t.cells}
    end
    for _ in pairs(m.regions) do out.regions = out.regions + 1 end
    out.boundaries, out.chokes, out.keys = #m.boundaries, #m.chokes, #m.keys
    for cls, n in pairs(m.groundCount or {}) do out.ground[cls] = n end
    for id in pairs(m.summits or {}) do
        local r = m.regions[id]
        out.summits = out.summits + 1
        if r then out.items.summits[#out.items.summits+1] = {region=id, x=r.lx, z=r.lz, cells=r.cells, minH=r.minH, maxH=r.maxH} end
    end
    for _, c in ipairs(m.chokes) do
        local ra, rb = m.regions[c.a], m.regions[c.b]
        local land = ra ~= nil and rb ~= nil and not isWaterChar(ra.character) and not isWaterChar(rb.character)
        out.items.chokes[#out.items.chokes+1] = {id=c.id, x=c.x, z=c.z, width=c.width, a=c.a, b=c.b, land=land}
    end
    return out
end
local config, getConfig, textCommand, shutdown

-- Experience v2. All semantic state belongs to this widget. The immutable
-- model and explicit settings are the only inputs; no selection/roster/time
-- callbacks participate. Preparation yields between bounded geometry batches.
local ux = {schemaVersion=2, view="terrain", primary=0, compare=-1, side=-1,
    detail="essential", labels="names", background="normal", opacity=0.55,
    inspect=false, debug=false, advanced=false, collapsed=false,
    categories={resources=true, coastal_access=true}, preset="Terrain overview"}
local presets, legacyConfig = {}, nil
local uxLists, uxFeatures, uxJob, uxFocus, uxMenu = {}, {}, nil, nil, nil
local uxLabelFeatures = {}
local uxNotice = "Initial-map analysis; temporary obstacles and enemy coverage are not assessed"
local uxMetrics = {prepareMs=0, maxSliceMs=0, batches=0}
local movement = {{0,"Vehicles"},{1,"Bots"},{3,"Hover"},{2,"Amphibious"},{5,"Surface ships"},{7,"Deep-draft ships"},{6,"Submarines"},{4,"All-terrain"}}
local categoryNames = {{"resources","Resources"},{"staging","Staging"},{"defensive","Defensive candidates"},{"coastal_access","Coastal access"},{"starts","Start positions"}}
local function copy(v)
    if type(v) ~= "table" then return v end
    local t = {}; for k,x in pairs(v) do t[k] = copy(x) end; return t
end
local function clearUxLists()
    for _, id in ipairs(uxLists) do gl.DeleteList(id) end
    uxLists = {}; uxJob = nil; uxFeatures = {}; uxLabelFeatures = {}; uxFocus = nil; uxMenu = nil
end
local function accepts(mask)
    return hasBit(mask, ux.primary) or (ux.compare >= 0 and hasBit(mask, ux.compare))
end
local function selectionColour(mask)
    local a, b = hasBit(mask, ux.primary), ux.compare >= 0 and hasBit(mask, ux.compare)
    if a and b then return K.grey, 0 end
    if b then return K.orange, 2 end
    return K.sky, 1
end
local function featureVisible(f)
    if f.debugCandidate then return ux.debugCandidates end
    if f.debug then return ux.debug end
    if ux.view == "terrain" then return f.view == "terrain" end
    if ux.view == "approaches" then return f.view == "approaches" and (not f.mask or accepts(f.mask)) end
    return f.view == "positions" and ux.categories[f.category] and accepts(f.mask or 0)
        and (ux.side < 0 or f.ally == nil or f.ally < 0 or f.ally == ux.side)
end
local function appendFeature(f)
    if not featureVisible(f) then return end
    f.y = groundY(f.x, f.z)
    uxFeatures[#uxFeatures+1] = f
    if ux.detail=="detailed" or f.category or string.find(f.id,"^theatre:") or string.find(f.id,"^passage:") or ux.debugIds then
        uxLabelFeatures[#uxLabelFeatures+1] = f
    end
end
local function uxBatch(fn)
    local id = gl.CreateList(fn)
    if id then uxLists[#uxLists+1] = id end
    uxMetrics.batches = uxMetrics.batches + 1
    coroutine.yield()
end
local function uxPrepare()
    local m = model
    -- RLE cell surfaces are the native mobility mask itself, not a buffered
    -- route. O(G) preparation only; draw calls reuse lists until settings/model
    -- change. Each chunk is <=128 row fragments, limiting height callbacks.
    local runs = ux.view == "approaches" and m.accessRuns or m.groundRuns
    if ux.view ~= "positions" and runs then
        local batch = {}
        local function flush()
            local items = batch; batch = {}
            uxBatch(function()
                gl.BeginEnd(GL.QUADS, function()
                    for _,q in ipairs(items) do
                        gl.Color(q.c[1],q.c[2],q.c[3],ux.opacity * q.alpha)
                        gl.Vertex(q.x,q.y,q.z); gl.Vertex(q.x+q.w,q.y,q.z)
                        gl.Vertex(q.x+q.w,q.y,q.z+m.cell); gl.Vertex(q.x,q.y,q.z+m.cell)
                    end
                end)
                gl.LineWidth(1)
                gl.BeginEnd(GL.LINES, function()
                    for _,q in ipairs(items) do if q.pattern and q.pattern > 0 then
                        gl.Color(q.c[1],q.c[2],q.c[3],ux.opacity)
                        -- Sparse native-cell pattern: slash vs cross remains
                        -- distinguishable in monochrome. No per-frame work.
                        local spacing=ux.detail=="essential" and 8 or 4
                        if math.floor(q.z/m.cell)%spacing == 0 then
                            local first=q.x+((spacing-(q.x/m.cell)%spacing)%spacing)*m.cell
                            for x=first,q.x+q.w-m.cell,spacing*m.cell do
                                gl.Vertex(x,q.y+1,q.z); gl.Vertex(x+m.cell,q.y+1,q.z+m.cell)
                                if q.pattern==2 then gl.Vertex(x+m.cell,q.y+1,q.z); gl.Vertex(x,q.y+1,q.z+m.cell) end
                            end
                        end
                    end end
                end)
            end)
        end
        for _,r in ipairs(runs) do
            local colour, pattern, alpha
            if ux.view == "approaches" then
                if accepts(r[2]) then colour,pattern=selectionColour(r[2]); alpha=0.55 end
            else
                local gd = GROUND[r[2]]
                if gd and r[2] ~= 3 and (ux.detail=="detailed" or r[2]~=4) then
                    colour=gd.fill or K.verm; alpha=0.4; pattern=r[2]>=5 and 2 or nil
                end
            end
            if colour then
                local c, left = r[1],r[3]
                while left>0 do
                    local cx,cz=c%m.gw,math.floor(c/m.gw); local n=math.min(left,m.gw-cx,16)
                    local x,z=cx*m.cell,cz*m.cell
                    batch[#batch+1]={x=x,z=z,w=n*m.cell,y=groundY(x+n*m.cell/2,z+m.cell/2),c=colour,pattern=pattern,alpha=alpha}
                    c=c+n;left=left-n
                    if #batch>=128 then flush() end
                end
            end
        end
        if #batch>0 then flush() end
    end
    local ids = {}; for id in pairs(m.theatres) do ids[#ids+1]=id end; table.sort(ids)
    for _,id in ipairs(ids) do local t=m.theatres[id]
        appendFeature({id="theatre:"..id,view=ux.view=="approaches" and "approaches" or "terrain",name=t.name,x=t.x,z=t.z,loops=t.kind~="land" and t.outline or nil,
            reason="Connected "..t.kind.." area",basis="Terrain-derived",colour=K.white})
    end
    for _,b in ipairs(m.boundaries) do
        local physical=b.kind=="cliff" or b.kind=="sheer" or (m.experience==2 and (b.kind=="ramp" or b.kind=="pass" or b.kind=="climb" or b.kind=="ford"))
        if #b.line>=4 then
            appendFeature({id="boundary:"..b.id,view="terrain",debug=not physical,name=physical and b.kind or "Analysis partition",
                x=b.line[1],z=b.line[2],line=b.line,colour=physical and K.verm or K.grey,
                pattern=physical and ((b.kind=="cliff" or b.kind=="sheer") and "blocked" or "crossing") or nil,
                reason=physical and "Physical terrain transition; movement families have different limits" or "Internal watershed partition; not a terrain restriction",
                basis="Terrain-derived",mask=b.mask})
        end
    end
    for i,k in ipairs(m.keys) do if k.kind=="high" then
        appendFeature({id="height:"..i,view="terrain",category="high",name=m.summits[k.region] and "Isolated high ground" or "High ground",
            x=k.x,z=k.z,colour=K.yellow,basis="Terrain-derived",
            reason="Raised terrain in the initial grid. Access has unit exceptions; height is not a universal weapon range bonus"})
    end end
    for _,p in ipairs(m.passages or {}) do if #p.line>=4 then
        appendFeature({id="passage:"..p.id,view="approaches",name="Local constriction",mask=p.mask,
            x=(p.line[1]+p.line[3])/2,z=(p.line[2]+p.line[4])/2,line=p.line,colour=K.white,
            measurement=string.format("%.0f elmos",p.width),
            reason=string.format("%.0f elmo obstacle cross-section; wider connected approaches on both sides",p.width),basis="Terrain-derived"})
    end end
    for _,c in ipairs(m.chokes) do
        appendFeature({id="candidate:"..c.id,debugCandidate=true,name="Clearance candidate",x=c.x,z=c.z,
            category="debug",colour=K.grey,reason="Unqualified watershed contact; not a measured passage",basis="Analysis diagnostic"})
    end
    for _,l in ipairs(m.landings) do if #l.line>=4 then
        local side=m.sides[l.side+1]
        local ally=side and side.ally or -1
        local water=m.theatres[l.sea]
        local land=m.regions[l.region];land=land and m.theatres[land.theatre]
        appendFeature({id="landing:"..l.id,view="approaches",name=(water and water.name or "Water").." access",mask=l.mask,
            x=l.line[1],z=l.line[2],line=l.line,colour=K.sky,ally=ally,
            arrow=ux.side>=0 and ally==ux.side and m.landingDirs and m.landingDirs[l.id] or nil,
            reason="Connects "..(water and water.name or "water").." and "..(land and land.name or "inland ground").."; initial terrain only",basis="Terrain-derived"})
    end end
    local categoryCount, categorySites = {}, {}
    local separation=math.min(1024,math.max(Game.mapSizeX,Game.mapSizeZ)/10)
    for _,s in ipairs(m.sites or {}) do
        if ux.side<0 or s.ally<0 or s.ally==ux.side then
            local group=s.category=="resources" and s.name or s.category
            local count=categoryCount[group] or 0
            local nearby=false
            if ux.detail=="essential" and s.category~="starts" then
                for _,p in ipairs(categorySites[group] or {}) do
                    if (p.x-s.x)^2+(p.z-s.z)^2<separation^2 then nearby=true;break end
                end
            end
            if accepts(s.mask) and not nearby and (ux.detail=="detailed" or count<(s.category=="resources" and 3 or 6)) then
                categoryCount[group]=count+1
                categorySites[group]=categorySites[group] or {};table.insert(categorySites[group],s)
                local name=s.category=="starts" and ((s.basis=="Tactical candidate" and "Predicted " or "Recorded ")..s.name) or s.name
                local reason=s.reason
                if s.category=="coastal_access" then
                    local sea,region=string.match(reason or "","^Sea (%d+) to land region (%d+)")
                    local water=m.theatres[tonumber(sea)];local land=m.regions[tonumber(region)]
                    land=land and m.theatres[land.theatre]
                    name=(water and water.name or "Water").." access"
                    reason="Connects "..(water and water.name or "water").." and "..(land and land.name or "inland ground").."; initial terrain transition, occupancy unknown"
                end
                appendFeature({id="site:"..s.id,view="positions",category=s.category,name=name,x=s.x,z=s.z,
                    mask=s.mask,ally=s.ally,reason=reason,basis=s.basis,colour=s.category=="resources" and K.yellow or K.sky})
            end
        end
    end
    for first=1,#uxFeatures,32 do
        local last=math.min(#uxFeatures,first+31)
        uxBatch(function()
            gl.LineWidth(2)
            gl.BeginEnd(GL.LINES,function()
                for i=first,last do local f=uxFeatures[i]; local c=f.colour
                    gl.Color(c[1],c[2],c[3],math.min(1,ux.opacity+0.35))
                    if f.line then
                        if f.pattern then drawPat(STYLE[f.pattern],f.line) else solid(f.line) end
                        if f.arrow then
                            local a=f.arrow;local tx,tz=a.x+a.dx*100,a.z+a.dz*100
                            seg(a.x,a.z,tx,tz);seg(tx,tz,tx-a.dx*30-a.dz*20,tz-a.dz*30+a.dx*20)
                            seg(tx,tz,tx-a.dx*30+a.dz*20,tz-a.dz*30-a.dx*20)
                        end
                        if string.find(f.id,"^passage:") then
                            local p=f.line; local dx,dz=p[3]-p[1],p[4]-p[2];local len=math.sqrt(dx*dx+dz*dz)
                            if len>0 then for j=1,3,2 do seg(p[j]-dz/len*24,p[j+1]+dx/len*24,p[j]+dz/len*24,p[j+1]-dx/len*24) end end
                        end
                    elseif f.loops then solidLoops(f.loops)
                    elseif f.category then
                        if f.category=="defensive" or f.category=="high" then triangle(f.x,f.z,48)
                        elseif f.category=="staging" then ngon(f.x,f.z,48,4)
                        elseif f.category=="resources" then ngon(f.x,f.z,40,6)
                        else ngon(f.x,f.z,40,8) end
                    end
                end
            end)
        end)
    end
    status = string.format("%s: %d features · initial-map analysis",ux.view,#uxFeatures)
    if m.experience~=2 then status="Legacy terrain: physical crossings and movement access unavailable" end
end
compileAll = function()
    disposeLists(); clearUxLists()
    if not model then return end
    model.cellGround={};model.groundCount={}
    for _,r in ipairs(model.groundRuns) do model.groundCount[r[2]]=(model.groundCount[r[2]] or 0)+r[3] end
    findSummits(model)
    if ux.side>=0 then
        local found=false;for _,s in ipairs(model.sides) do if s.ally==ux.side then found=true end end
        if not found then ux.side=-1;uxNotice="Saved ally team is absent; perspective reset to Neutral" end
    end
    uxMetrics={prepareMs=0,maxSliceMs=0,batches=0}
    uxJob=coroutine.create(uxPrepare)
    status="Preparing "..ux.view.." geometry"
end
local function uxChange(key,value)
    ux[key]=value;ux.preset="Custom"
    if ux.compare==ux.primary then ux.compare=-1 end
    if key=="background" then setGround(on and value=="off") end
    if key~="inspect" and key~="labels" and key~="advanced" and key~="collapsed" then compileAll() end
    if key=="inspect" and not value then uxFocus=nil end
end
local function uxPreset(name)
    if presets[name] then
        local shown=on; config(copy(presets[name])); on=shown;ux.preset=name;compileAll();return
    end
    ux.categories={resources=true,coastal_access=true};ux.primary=0;ux.compare=-1;ux.side=-1;ux.debug=false;ux.debugCandidates=false;ux.debugIds=false
    ux.detail="essential";ux.labels="names";ux.background="normal";ux.opacity=0.55
    ux.view=name=="Ground approaches" and "approaches" or name=="Coastal access" and "positions" or "terrain"
    if name=="Coastal access" then ux.primary=3;ux.compare=2;ux.categories={coastal_access=true} end
    ux.preset=name;setGround(false);compileAll()
end
local originalSnapshot=snapshot
snapshot=function()
    local out=originalSnapshot();out.settings=copy(ux);out.features={};out.metrics=copy(uxMetrics)
    out.layers={ground=ux.view=="terrain",access=ux.view=="approaches",positions=ux.view=="positions",regions=ux.debug,labels=ux.labels~="off"}
    out.ready=model~=nil and uxJob==nil;out.fingerprint=model and model.fingerprint
    for _,f in ipairs(uxFeatures) do out.features[#out.features+1]={id=f.id,name=f.name,reason=f.reason,basis=f.basis} end
    return out
end
config=function(data)
    if type(data)~="table" then return end
    if data.schemaVersion~=2 then
        legacyConfig=copy(data);ux.detail=data.detail=="tactical" and "detailed" or "essential"
        ux.background=data.blueprint and "off" or data.dim and "dim" or "normal";ux.debug=false
    else
        local enums={view={terrain=true,approaches=true,positions=true},detail={essential=true,detailed=true},labels={off=true,names=true,measurements=true},background={normal=true,dim=true,off=true}}
        for k,values in pairs(enums) do if values[data[k]] then ux[k]=data[k] end end
        for _,k in ipairs({"inspect","debug","debugCandidates","debugIds","advanced","collapsed"}) do if type(data[k])=="boolean" then ux[k]=data[k] end end
        for _,k in ipairs({"primary","compare"}) do if type(data[k])=="number" and data[k]==math.floor(data[k]) and data[k]>= (k=="compare" and -1 or 0) and data[k]<=7 then ux[k]=data[k] end end
        if ux.primary==ux.compare then ux.compare=-1 end
        if type(data.side)=="number" and data.side==math.floor(data.side) and data.side>=-1 then ux.side=data.side end
        if type(data.opacity)=="number" and data.opacity==data.opacity then ux.opacity=math.max(0.1,math.min(0.8,data.opacity)) end
        if type(data.categories)=="table" then ux.categories={};for _,c in ipairs(categoryNames) do ux.categories[c[1]]=data.categories[c[1]]==true end end
        if type(data.presets)=="table" then presets=copy(data.presets) end
        if type(data.preset)=="string" then ux.preset=data.preset end
        legacyConfig=data.legacyConfig
        if type(data.shown)=="boolean" then on=data.shown end
    end
    options.legend=data.legend~=false
    if type(data.dock)=="table" and type(data.dock.x)=="number" and type(data.dock.y)=="number" then dockX,dockY=data.dock.x,data.dock.y end
    if model then compileAll() end
end
getConfig=function()
    local out=copy(ux);out.shown=on;out.legend=options.legend;out.dock={x=dockX,y=dockY};out.presets=copy(presets);out.legacyConfig=legacyConfig
    return out
end
setMode=function(value)
    local was=on;on=value==true;options.legend=on
    setGround(on and ux.background=="off")
    if on and model and #uxLists==0 and not uxJob then compileAll() end
    return was~=on
end
update=function(dataRequested)
    if not on and not dataRequested then return end
    if on then setGround(ux.background=="off") end
    if parse then
        -- A single access/ground record can contain thousands of runs. The
        -- line-count budget alone cannot bound that work. Yield every 256
        -- runs within a record; Lua 5.1 must use resume, not pcall, to yield.
        local started=Spring.GetTimer()
        repeat
            if not parseJob then parseJob=coroutine.create(stepParse) end
            local ok,err=coroutine.resume(parseJob)
            if not ok then parse=nil;parseJob=nil;status="Invalid terrain file: "..tostring(err)
            elseif coroutine.status(parseJob)=="dead" then parseJob=nil end
        until not parse or Spring.DiffTimers(Spring.GetTimer(),started)>=0.002
    elseif not model then tryLoad() end
    if uxJob then
        local t=Spring.GetTimer()
        repeat
            local ok,err=coroutine.resume(uxJob)
            if not ok then uxJob=nil;status="Geometry preparation failed: "..tostring(err);break end
            if coroutine.status(uxJob)=="dead" then uxJob=nil end
        until not uxJob or Spring.DiffTimers(Spring.GetTimer(),t)>=0.002
        local ms=Spring.DiffTimers(Spring.GetTimer(),t)*1000
        uxMetrics.prepareMs=uxMetrics.prepareMs+ms;uxMetrics.maxSliceMs=math.max(uxMetrics.maxSliceMs,ms)
    end
end
drawWorld=function()
    if not on or not model or Spring.IsGUIHidden() then return end
    gl.DepthTest(false)
    if ux.background=="dim" then
        gl.Color(0.02,0.03,0.04,0.5)
        gl.BeginEnd(GL.QUADS,function() gl.Vertex(0,0,0);gl.Vertex(Game.mapSizeX,0,0);gl.Vertex(Game.mapSizeX,0,Game.mapSizeZ);gl.Vertex(0,0,Game.mapSizeZ) end)
    end
    for _,id in ipairs(uxLists) do gl.CallList(id) end
    local f=uxFocus and uxFeatures[uxFocus]
    if f then gl.Color(1,1,1,1);gl.LineWidth(3);gl.BeginEnd(GL.LINES,function() ngon(f.x,f.z,75,12) end) end
    gl.LineWidth(1);gl.Color(1,1,1,1);gl.DepthTest(true)
end
drawMiniMap=function() end -- world view owns the configured feature set; no hidden minimap layers
local function uxChoose(id,x,y,w,title,items,key)
    button(id,x,y,w,title,false,function() uxMenu={x=x,y=y,items=items,key=key,w=w} end)
end
drawScreen=function()
    controls={};legendRect=nil
    if not on or Spring.IsGUIHidden() then return end
    local vw,vh=gl.GetViewSizes()
    if ux.labels~="off" then
        local occupied={};local projected=0
        -- Eligibility is cached with geometry; never scan unnamed borders each frame.
        for _,f in ipairs(uxLabelFeatures) do
            local sx,sy,sz=Spring.WorldToScreenCoords(f.x,f.y,f.z);projected=projected+1
            if sx and sz and sz>0 and sz<1 and sx>0 and sx<vw and sy>0 and sy<vh then
                local bx,by=math.floor(sx/150),math.floor(sy/24);local key=bx..":"..by
                if not occupied[key] then
                    occupied[key]=true;gl.Color(f.colour[1],f.colour[2],f.colour[3],1)
                    local label=f.name
                    if ux.labels=="measurements" and ux.detail=="detailed" and f.measurement then label=label.." "..f.measurement end
                    if ux.debugIds then label=label.." ["..f.id.."]" end
                    gl.Text(label,sx,sy,11,"oc")
                end
            end
            if projected>=200 then break end
        end
    end
    if not options.legend then return end
    local w=480;local h=ux.collapsed and 40 or (440+(ux.advanced and 130 or 0)+(uxFocus and ux.inspect and 90 or 0))
    -- Keep the complete panel reachable on small/resized viewports. Only UI
    -- geometry scales; terrain features and display settings stay unchanged.
    local scale=dialogUI.Scale(vw,vh,w,h)
    dockX=math.max(8,math.min(vw-w*scale-8,dockX or vw-w*scale-20))
    dockY=math.max(h*scale+8,math.min(vh-8,dockY or vh-110))
    local x,top=dockX/scale,dockY/scale;legendRect={x,top-h,x+w,top}
    local function finishPanel()
        gl.PopMatrix()
        for _,r in ipairs(controls) do for i=1,4 do r[i]=r[i]*scale end end
        for i=1,4 do legendRect[i]=legendRect[i]*scale end
        gl.Color(1,1,1,1)
    end
    gl.PushMatrix();gl.Scale(scale,scale,1)
    local vw,vh=vw/scale,vh/scale
    gl.Color(inkPanel);gl.Rect(x,top-h,x+w,top)
    gl.Color(mint);gl.Text("MAP ANALYSIS",x+12,top-24,14,"o")
    controls[#controls+1]={x,top-34,x+w-100,top,id="fieldDrag",action=function() end}
    button("fieldCollapse",x+w-94,top-32,40,ux.collapsed and "+" or "-",false,function() ux.collapsed=not ux.collapsed end)
    button("fieldHide",x+w-50,top-32,42,"Hide",false,function() setMode(false) end)
    if ux.collapsed then finishPanel();return end
    local y=top-66
    for i,v in ipairs({"terrain","approaches","positions"}) do
        button("view_"..v,x+12+(i-1)*150,y,144,v,ux.view==v,function() uxChange("view",v) end)
    end
    y=y-34
    local title="Movement: "..(CLASS_NAMES[ux.primary] or "deep-draft")
    if ux.view~="terrain" then
        uxChoose("movement",x+12,y,220,title,movement,"primary")
        local cmp={{-1,"None"}};for _,v in ipairs(movement) do if v[1]~=ux.primary then cmp[#cmp+1]=v end end
        uxChoose("compare",x+240,y,220,"Compare: "..(ux.compare<0 and "None" or CLASS_NAMES[ux.compare] or "deep-draft"),cmp,"compare")
    else gl.Color(muted);gl.Text("Movement filters inactive: Terrain is a physical overview",x+12,y+8,12,"o") end
    y=y-32
    local sides={{-1,"Neutral"}};for _,s in ipairs(model and model.sides or {}) do if s.ally>=0 then sides[#sides+1]={s.ally,"Ally team "..s.ally.." (setup)"} end end
    uxChoose("perspective",x+12,y,220,ux.side<0 and "Perspective: Neutral" or "Setup ally team "..ux.side,sides,"side")
    uxChoose("detail",x+240,y,220,"Detail: "..ux.detail,{{"essential","Essential"},{"detailed","Detailed"}},"detail")
    y=y-32
    uxChoose("labels",x+12,y,220,"Labels: "..ux.labels,{{"off","Off"},{"names","Names"},{"measurements","Measurements"}},"labels")
    uxChoose("background",x+240,y,220,"Background: "..ux.background,{{"normal","Normal"},{"dim","Dim"},{"off","Off"}},"background")
    y=y-32
    local choices={{"Terrain overview","Terrain overview"},{"Ground approaches","Ground approaches"},{"Coastal access","Coastal access"}}
    local names={};for name in pairs(presets) do names[#names+1]=name end;table.sort(names);for _,name in ipairs(names) do choices[#choices+1]={name,name} end
    uxChoose("preset",x+12,y,220,"Preset: "..ux.preset,choices,"preset")
    button("savePreset",x+240,y,106,"Save preset",false,function()
        local name="Saved "..(#names+1);local p=copy(ux);p.schemaVersion=2;presets[name]=p;ux.preset=name
    end)
    button("resetView",x+354,y,106,"Reset view",false,function()
        ux.detail="essential";ux.labels="names";ux.debug=false;ux.debugCandidates=false;ux.debugIds=false;ux.inspect=false
        if ux.view~="terrain" then ux.primary=0;ux.compare=-1;ux.side=-1 end
        if ux.view=="positions" then ux.categories={resources=true,coastal_access=true} end
        compileAll()
    end)
    y=y-32
    button("inspect",x+12,y,144,"Inspect: "..(ux.inspect and "On" or "Off"),ux.inspect,function() uxChange("inspect",not ux.inspect) end)
    button("advanced",x+162,y,144,"Advanced",ux.advanced,function() ux.advanced=not ux.advanced end)
    button("opacity",x+312,y,148,string.format("Opacity: %.0f%%",ux.opacity*100),false,function() uxChange("opacity",ux.opacity>=0.75 and 0.15 or ux.opacity+0.1) end)
    y=y-28
    if ux.view=="positions" then
        for i,c in ipairs(categoryNames) do
            button("category_"..c[1],x+12+((i-1)%3)*150,y-math.floor((i-1)/3)*28,144,c[2],ux.categories[c[1]],function() ux.categories[c[1]]=not ux.categories[c[1]];ux.preset="Custom";compileAll() end)
        end
        y=y-58
    else
        gl.Color(muted);gl.Text(ux.view=="approaches" and "Slash: primary only   Cross: comparison only   Plain: shared" or "Edges: physical transitions   Open ground: no partition lines",x+12,y+6,12,"o");y=y-28
    end
    if ux.inspect then
        local fs={};for i,f in ipairs(uxFeatures) do
            fs[#fs+1]={i,f.name..(ux.debugIds and (" ("..f.id..")") or (" #"..i))}
        end
        uxChoose("feature",x+12,y,350,uxFocus and uxFeatures[uxFocus] and uxFeatures[uxFocus].name or "Choose a visible feature",fs,"focus")
        button("clearFocus",x+370,y,90,"Clear",false,function() uxFocus=nil end);y=y-30
    end
    local f=uxFocus and uxFeatures[uxFocus]
    if f and ux.inspect then
        gl.Color(mint);gl.Text(f.basis or "Terrain-derived",x+12,y+5,12,"o");y=y-16
        local types={};for cls=0,7 do if hasBit(f.mask or 0,cls) then types[#types+1]=CLASS_NAMES[cls] or "deep-draft" end end
        gl.Color(muted);gl.Text(#types>0 and ("Movement: "..table.concat(types,", ")) or "Physical geography; no movement claim",x+12,y,12,"o");y=y-16
        -- Wrapped card text stays inside the panel at small resolutions.
        local line="";for word in string.gmatch(f.reason or "", "%S+") do
            if #line+#word>68 then gl.Color(muted);gl.Text(line,x+12,y,12,"o");y=y-14;line="" end
            line=line..word.." "
        end
        gl.Color(muted);gl.Text(line,x+12,y,12,"o");y=y-18
    end
    if ux.advanced then
        button("debugBoundaries",x+12,y,280,"Debug: analysis boundaries",ux.debug,function() uxChange("debug",not ux.debug) end)
        button("resetAll",x+300,y,160,"Reset all",false,function()
            uxPreset("Terrain overview");ux.inspect=false;ux.advanced=false;ux.collapsed=false;dockX=nil;dockY=nil
        end);y=y-30
        button("debugCandidates",x+12,y,280,"Debug: clearance candidates",ux.debugCandidates,function() uxChange("debugCandidates",not ux.debugCandidates) end)
        button("debugIds",x+300,y,160,"Source IDs",ux.debugIds,function() uxChange("debugIds",not ux.debugIds) end);y=y-30
        local cl=model and model.classes[ux.primary]
        gl.Color(muted);gl.Text(cl and string.format("Representative: slope %.0f deg; depth %.0f..%.0f (-1 unbounded)",cl.slope,cl.minDepth,cl.maxDepth) or "Representative movement assumptions unavailable",x+12,y,12,"o")
        y=y-18;gl.Text("Terrain-derived, not engine-checked for every unit. Initial map only.",x+12,y,12,"o")
    end
    gl.Color(muted);gl.Text(dialogUI.Fit(status,12,w-24),x+12,top-h+28,12,"o");gl.Text(dialogUI.Fit(uxNotice,11,w-24),x+12,top-h+12,11,"o")
    if uxMenu then
        local menu=uxMenu;local mh=math.min(#menu.items,12)*25
        local mx=math.max(8,math.min(vw-358,menu.x))
        local my=math.min(vh-8,math.max(mh+(#menu.items>12 and 33 or 8),menu.y))
        gl.Color(inkPanel);gl.Rect(mx,my-mh,mx+350,my)
        local offset=menu.offset or 0
        for n=1,math.min(12,#menu.items-offset) do local item=menu.items[n+offset]
            button("menu_"..n,mx,my-n*25,350,item[2],false,function()
                uxMenu=nil
                if menu.key=="focus" then uxFocus=item[1]
                elseif menu.key=="preset" then uxPreset(item[1])
                else uxChange(menu.key,item[1]) end
            end)
        end
        if #menu.items>12 then
            button("menuNext",mx,my-mh-25,350,"Next page",false,function() menu.offset=(offset+12<#menu.items) and offset+12 or 0 end)
        end
    end
    finishPanel()
end
mousePress=function(x,y,b)
    if not on or Spring.IsGUIHidden() then return false end
    local r=hitAt(x,y)
    if r then if b==1 then pressed=r;if r.id=="fieldDrag" then drag={x,y,dockX,dockY} end end;return true end
    if uxMenu then uxMenu=nil;return true end
    if legendRect and x>=legendRect[1] and x<=legendRect[3] and y>=legendRect[2] and y<=legendRect[4] then return true end
    if ux.inspect and b==1 then
        local best,dist=nil,28*28
        for i,f in ipairs(uxFeatures) do local sx,sy,sz=Spring.WorldToScreenCoords(f.x,f.y,f.z)
            if sx and sz and sz>0 and sz<1 then local d=(sx-x)^2+(sy-y)^2;if d<dist then best,dist=i,d end end
        end
        uxFocus=best;return true
    end
    return false
end
setLayer=function(name,value)
    if name=="regions" then uxChange("debug",value==true);return true end
    if name=="labels" then uxChange("labels",value and "names" or "off");return true end
    return false
end
setFocus=function(kind,id)
    uxFocus=nil;if kind then for i,f in ipairs(uxFeatures) do if f.id==kind..":"..tostring(id) then uxFocus=i;break end end end
end
setBlueprint=function(v) uxChange("background",v and "off" or "normal") end
textCommand=function(cmd)
    if cmd=="barbterrain" or cmd=="barbfield" then setMode(not on);return true end
    local sub=string.match(cmd,"^barbterrain%s+(.+)$") or string.match(cmd,"^barbfield%s+(.+)$")
    if not sub then return false end
    if sub=="on" or sub=="show" then setMode(true)
    elseif sub=="off" or sub=="hide" then setMode(false)
    elseif sub=="legend" then options.legend=not options.legend
    elseif sub=="pick" then uxChange("inspect",not ux.inspect)
    elseif sub=="blueprint" then setBlueprint(ux.background~="off")
    elseif sub=="dim" then uxChange("background",ux.background=="dim" and "normal" or "dim")
    elseif sub=="detail strategic" or sub=="detail auto" then uxChange("detail","essential")
    elseif sub=="detail tactical" then uxChange("detail","detailed")
    else Spring.Echo("[BARb] Configure Map Analysis in the widget panel") end
    return true
end
shutdown=function() clearUxLists();disposeLists();setGround(false);on=false end
return {SetMode=setMode, Mode=function() return on end, Status=function() return status end, Snapshot=snapshot,
    View=function() return ux.view end,
    SetLayer=setLayer, SetFocus=setFocus, SetBlueprint=setBlueprint, SetLegend=function(v) options.legend = v and true or false end,
    SetSide=function(v) uxChange("side",(type(v)=="number" and v>=0) and v or -1) end,
    Legend=function() return options.legend end, Config=config, GetConfig=getConfig, TextCommand=textCommand,
    Update=update, DrawWorld=drawWorld, DrawScreen=drawScreen, DrawMiniMap=drawMiniMap, Shutdown=shutdown,
    SetAllyProvider=function() end, -- compatibility only; roster never drives map analysis
    -- read-only access for the landmarks view: the parsed map.txt (grid, fingerprint, chokes)
    -- and the soft-edged run-length fill, so both views fill territory the same way
    Model=function() return model end,
    FillRuns=function(m, runs, cells, want, c, a) fillWith(c, a); fillRuns(m, runs, cells, want, nil) end,
    ButtonRect=function(id) for _, r in ipairs(controls) do if r.id == id then return {r[1], r[2], r[3], r[4]} end end end,
    MousePress=mousePress, MouseRelease=mouseRelease, MouseMove=mouseMove}
end)()

-- ---------------------------------------------------------------- marks
-- Strategic landmarks and the opening per start position (field-landmarks
-- proposal, section 7): a second file written once by the same BARb field
-- service right after map.txt, LuaUI/Config/BARb/field/landmarks.txt. Like the
-- terrain map it is read once when the view is turned on, parsed over Update
-- calls (64 lines per step, 2 ms), and drawn from one display list per layer.
-- Cost: after load nothing is parsed or scanned per frame; drawing is about ten
-- CallList calls plus at most 200 labels. The lists are compiled a few per
-- Update (the incremental compile KI-643 asks of Terrain), and the territory
-- cell expansion and border edges are built in time-boxed steps before that.
-- A new selection recompiles only the selection layers (territory fill,
-- landings, ring, minimap) and the card; a new phase only the mark layers; a
-- roster change (polled every 2 s while shown) only the position layer.
-- D-325: every kind of mark differs by shape first; colour (Okabe-Ito) only
-- repeats it, and every line is cased in ink (the halo pass).
-- Grammar: the landmarks.txt record list (format 1); unknown records are ignored.
local marks = (function()
local PATH = "LuaUI/Config/BARb/field/landmarks.txt"
local FACTIONS = {"armada", "cortex", "legion"}
local FACTION_NAME = {armada="Armada", cortex="Cortex", legion="Legion"}
local PHASES = {
    {key="0-5", lo=0, hi=5}, {key="5-15", lo=5, hi=15}, {key="15-25", lo=15, hi=25}, {key="25+", lo=25, hi=1e9}, {key="all"},
}
local PHASE_KEYS = {}
local PHASE_BY_KEY = {}
for i, p in ipairs(PHASES) do PHASE_KEYS[i] = p.key; PHASE_BY_KEY[p.key] = p end
-- every display list, in compile order; DRAW_ORDER is the world draw order
local LAYER_ORDER = {"dim", "terrOutline", "terrSel", "seazone", "economy", "land", "sea", "late", "landing", "positions", "selRing", "minimap"}
local DRAW_ORDER = {"terrOutline", "terrSel", "seazone", "economy", "land", "sea", "late", "landing", "positions", "selRing"}
-- "late" reads the selection too: only the selected side's anti-nuke coverage circles are drawn
local BY_SELECTION = {"terrSel", "landing", "late", "selRing", "minimap"}
-- above LABEL_HEIGHT (the strategic view) the mark layers switch to a second list in which
-- the labelled marks' glyphs are FAR_SCALE times larger, so they stay readable from far
local FAR_SCALE = 3
local BY_PHASE = {"seazone", "economy", "land", "sea", "late", "landing", "minimap"}
local BY_ROSTER = {"positions"}
local CLASS_WORD = {bot="Bot lab", vehicle="Vehicle plant", hover="Hover plant", ship="Shipyard", air="Aircraft plant"}
local MATCH_RADIUS = 800      -- elmos: a roster start this close to a position is that position's AI
local POS_R = 80              -- position disc radius, elmos
local LABEL_CAP = 200
local LABEL_HEIGHT = 6000     -- above this camera height labels shrink and labelled glyphs draw FAR_SCALE larger
local options = {legend=false, phase="all", faction=nil}
local on = false
local model, parse, prep, seq = nil, nil, nil, nil
local lastExists = nil
local status = "Landmarks hidden"
local lists = {}
local pending, pendingSet = {}, {}
local labelsAll = {}
local selected = nil          -- the selected position index
local inspectLines = nil      -- the clicked mark's record
local fieldApi = nil          -- the terrain module: map.txt grid, fingerprint and chokes, its fill routine
local rosterProvider = nil    -- function() -> {{teamId=, allyTeam=, role=, side=, factory=, x=, z=}, ...}
local mineProvider = nil      -- function() -> x, z of the viewer's start (spectating: the panel's selected AI)
local rosterSig, rosterTimer = "", nil
local panelRects = {}
local card = nil              -- the selected position's opening card

local K = {
    white  = {1,1,1},
    grey   = {0.72,0.72,0.74},
    orange = {0.90,0.62,0.00},
    sky    = {0.34,0.71,0.91},
    green  = {0.00,0.62,0.45},
    yellow = {0.94,0.89,0.26},
    blue   = {0.00,0.45,0.70},
    verm   = {0.84,0.37,0.00},
    purple = {0.80,0.47,0.65},
    teal   = {0.15,0.65,0.62},
    ink    = {0.025,0.045,0.07},
}
local mint, muted = {0.35,0.9,0.73,1}, {0.65,0.73,0.8,1}
local inkPanel = {0.025,0.045,0.07,0.94}

local function split(s, sep)
    local out, from = {}, 1
    while true do
        local a, b = string.find(s, sep, from, true)
        if not a then out[#out+1] = string.sub(s, from); break end
        out[#out+1] = string.sub(s, from, a-1); from = b+1
    end
    return out
end
local function poly(s)
    local p = {}
    if not s then return p end
    for x, z in string.gmatch(s, "(-?%d+%.?%d*),(-?%d+%.?%d*)") do p[#p+1] = tonumber(x); p[#p+1] = tonumber(z) end
    return p
end
local function num(v, d) return tonumber(v) or d or 0 end
local function loose(name) return string.lower((string.gsub(name or "", "[%s%._%-]", ""))) end
local function groundY(x, z) return math.max(0, Spring.GetGroundHeight(x, z)) + 8 end
local function words(s, sep)
    local out = {}
    if not s or s == "" or s == "-" then return out end
    for _, v in ipairs(split(s, sep)) do
        local t = string.match(v, "^%s*(.-)%s*$")
        if t and t ~= "" then out[#out+1] = t end
    end
    return out
end
local function normFaction(side)
    local s = string.lower(side or "")
    if string.find(s, "arm", 1, true) then return "armada" end
    if string.find(s, "cor", 1, true) then return "cortex" end
    if string.find(s, "leg", 1, true) then return "legion" end
    return nil
end
local function fieldModel() return fieldApi and fieldApi.Model and fieldApi.Model() or nil end

-- ---- parsing
local function newModel()
    return {name="", fieldFp="", marksFp="", env={minWind=0, maxWind=0, tidal=0, diag=0}, factories={},
        positions={}, order={}, features={}, openings={}, marks={}, terrRuns={}, terrCount=0, cellPos={}, edges={}, byLayer={},
        gw=0, gh=0, cell=32, terrOk=false}
end
local function parseRecord(m, line)
    local f = split(line, "|")
    local k = f[1]
    if k == "mark" then
        local pl = f[15]
        m.marks[#m.marks+1] = {id=num(f[2]), group=f[3] or "", kind=f[4] or "", x=num(f[5]), z=num(f[6]), value=num(f[7]),
            pos=num(f[8], -1), ally=num(f[9], -1), contested=f[10] == "1", from=num(f[11], 0), to=num(f[12], -1),
            labelled=f[13] == "1", reason=f[14] or "", line=(pl and pl ~= "-" and pl ~= "") and poly(pl) or nil}
    elseif k == "position" then
        local i = tonumber(f[2])
        if i then
            if not m.positions[i] then m.order[#m.order+1] = i end
            m.positions[i] = {index=i, name=f[3] or ("P" .. i), ally=num(f[4], -1), n=num(f[5]), x=num(f[6]), z=num(f[7]),
                source=f[8] or "predicted", label=f[9] or "", sublabel=f[10] or "-", frontShare=num(f[11]), rearRank=num(f[12]), cells=num(f[13])}
        end
    elseif k == "opening" then
        local i = tonumber(f[2])
        if i then m.openings[i] = {class=f[3] or "", fallbacks=words(f[4], ","), energy=f[5] or "", second=f[6] or "", reasons=words(f[7], ";")} end
    elseif k == "feature" then
        local i = tonumber(f[2])
        if i then
            local g = {}
            for v in string.gmatch(f[3] or "", "-?%d+") do g[#g+1] = tonumber(v) end
            local yx, yz = string.match(f[11] or "", "(-?%d+),(-?%d+)")
            m.features[i] = {ground=g, openWidth=num(f[4]), vehShare=num(f[5]), metal=num(f[6]), clusters=num(f[7]), geos=num(f[8]),
                geoDist=num(f[9], -1), sea=num(f[10], -1), yardX=num(yx, -1), yardZ=num(yz, -1), yardDist=num(f[12], -1),
                pondCells=num(f[13]), assaultRank=num(f[14]), island=f[15] == "1"}
        end
    elseif k == "territory" then
        -- run-length position index per cell (-1 = none), the same form as map.txt cells|
        local runs, start = m.terrRuns, m.terrCount
        for id, count in string.gmatch(f[2] or "", "(-?%d+)%*(%d+)") do
            local n = tonumber(count)
            runs[#runs+1] = {start, tonumber(id), n}
            start = start + n
        end
        m.terrCount = start
    elseif k == "env" then
        m.env = {minWind=num(f[2]), maxWind=num(f[3]), tidal=num(f[4]), diag=num(f[5])}
    elseif k == "factory" and f[2] then
        local function id(v) if v == nil or v == "" or v == "-" then return nil end return v end
        m.factories[f[2]] = {armada=id(f[3]), cortex=id(f[4]), legion=id(f[5])}
    end
end

local function beginParse(text)
    local fmt, name, ffp, mfp, fseq = string.match(text, "^barbmarks|(%d+)|([^|]*)|([^|]*)|([^|]*)|(%d+)")
    if not fmt then return false, "unexpected header" end
    if tonumber(fmt) ~= 1 then return false, "format " .. tostring(fmt) end
    local trailer = "\nend|" .. fseq
    local tp = string.find(text, trailer, 1, true)
    if not tp then return false, "torn file" end
    local after = string.sub(text, tp + #trailer, tp + #trailer)
    if after ~= "" and after ~= "\n" and after ~= "\r" then return false, "torn file" end
    if name ~= "" and Game.mapName and loose(name) ~= loose(Game.mapName)
        and not string.find(loose(Game.mapName), loose(name), 1, true) and not string.find(loose(name), loose(Game.mapName), 1, true) then
        return false, "file is for map '" .. name .. "'"
    end
    local fm = fieldModel()
    if fm and fm.fingerprint and ffp ~= fm.fingerprint then return false, "fingerprint differs from map.txt" end
    local m = newModel()
    m.name, m.fieldFp, m.marksFp = name, ffp, mfp
    parse = {text=text, pos=1, m=m, seq=tonumber(fseq)}
    return true
end

local finishModel   -- forward
local function stepParse()
    if not parse then return end
    local t0 = Spring.GetTimer()
    local text, pos = parse.text, parse.pos
    local lines = 0
    while true do
        local e = string.find(text, "\n", pos, true)
        local line = e and string.sub(text, pos, e-1) or string.sub(text, pos)
        if string.sub(line, -1) == "\r" then line = string.sub(line, 1, -2) end
        if #line > 0 and not string.find(line, "^barbmarks") and not string.find(line, "^end|") then parseRecord(parse.m, line) end
        pos = e and e + 1 or #text + 1
        lines = lines + 1
        if pos > #text then break end
        if lines % 64 == 0 and Spring.DiffTimers(Spring.GetTimer(), t0) > 0.002 then break end
    end
    parse.pos = pos
    if pos > #text then
        local m, s = parse.m, parse.seq
        parse = nil
        finishModel(m, s)
    else
        status = string.format("Reading landmarks %d%%", math.floor(100 * pos / math.max(1, #text)))
    end
end
local function tryLoad()
    if not (VFS and VFS.LoadFile and VFS.FileExists) then status = "VFS unavailable"; return end
    local now = Spring.GetTimer()
    if lastExists and Spring.DiffTimers(now, lastExists) < 2 then return end
    lastExists = now
    if not VFS.FileExists(PATH, VFS.RAW) then
        if string.sub(status, 1, 15) ~= "Landmarks file " then status = "Landmarks: waiting for file" end
        return
    end
    local ok, text = pcall(VFS.LoadFile, PATH, VFS.RAW)
    if not ok or type(text) ~= "string" or #text == 0 then status = "Cannot read " .. PATH; return end
    local good, err = beginParse(text)
    if not good then status = "Landmarks file skipped: " .. tostring(err) end
end

-- ---- line generation: the same emitter idea as the terrain map. In world space seg()
-- splits long segments so a line follows the ground; for a legend sample `flatY` is the
-- sample's screen y and a map z is mirrored about it, so north stays up and every
-- legend glyph is drawn by exactly the code that draws the map. Line layers are
-- compiled twice: an ink under-stroke three pixels wider, then the colour.
local SEG_MAX = 128
local flatY = nil
local patScale = 1
local haloPass = false
local function vtx(x, z)
    if flatY then gl.Vertex(x, 2*flatY - z) else gl.Vertex(x, groundY(x, z), z) end
end
local function seg(ax, az, bx, bz)
    if flatY then vtx(ax, az); vtx(bx, bz); return end
    local dx, dz = bx - ax, bz - az
    local n = math.max(1, math.ceil(math.sqrt(dx*dx + dz*dz) / SEG_MAX))
    local px, pz = ax, az
    for i = 1, n do
        local x, z = ax + dx*i/n, az + dz*i/n
        vtx(px, pz); vtx(x, z)
        px, pz = x, z
    end
end
local function solid(p) for i = 3, #p, 2 do seg(p[i-2], p[i-1], p[i], p[i+1]) end end
local function dashed(p, onLen, offLen)
    local runs = {onLen * patScale, offLen * patScale}
    local k, phase = 1, 0
    for i = 3, #p, 2 do
        local ax, az, bx, bz = p[i-2], p[i-1], p[i], p[i+1]
        local dx, dz = bx-ax, bz-az
        local len = math.sqrt(dx*dx + dz*dz)
        if len > 0 then
            dx, dz = dx/len, dz/len
            local t = 0
            while t < len do
                local run = runs[k] - phase
                local t2 = math.min(len, t + run)
                if k == 1 then seg(ax+dx*t, az+dz*t, ax+dx*t2, az+dz*t2) end
                if t2 >= len then phase = phase + (len - t) else phase = 0; k = 3 - k end
                t = t2
            end
        end
    end
end
local function stroke(c, a, w)
    if haloPass then gl.Color(K.ink[1], K.ink[2], K.ink[3], 0.85); gl.LineWidth((w or 2) + 3)
    else gl.Color(c[1], c[2], c[3], a or 1); gl.LineWidth(w or 2) end
end
local function ngon(x, z, r, n, dash)
    local px, pz
    for i = 0, n do
        local a = i * 2 * math.pi / n
        local cx, cz = x + math.cos(a)*r, z + math.sin(a)*r
        if px and (not dash or i % 2 == 0) then seg(px, pz, cx, cz) end
        px, pz = cx, cz
    end
end
local function disc(x, z, r)
    -- a filled disc (inside gl.BeginEnd(GL.TRIANGLES))
    local n = 20
    for i = 0, n - 1 do
        local a1, a2 = i * 2 * math.pi / n, (i + 1) * 2 * math.pi / n
        vtx(x, z); vtx(x + math.cos(a1)*r, z + math.sin(a1)*r); vtx(x + math.cos(a2)*r, z + math.sin(a2)*r)
    end
end
local function polyMid(p)
    if #p < 4 then return p[1] or 0, p[2] or 0 end
    local total = 0
    for i = 3, #p, 2 do local dx, dz = p[i]-p[i-2], p[i+1]-p[i-1]; total = total + math.sqrt(dx*dx+dz*dz) end
    local half, acc = total / 2, 0
    for i = 3, #p, 2 do
        local dx, dz = p[i]-p[i-2], p[i+1]-p[i-1]
        local len = math.sqrt(dx*dx+dz*dz)
        if acc + len >= half and len > 0 then
            local f = (half - acc) / len
            return p[i-2] + dx*f, p[i-1] + dz*f
        end
        acc = acc + len
    end
    return p[#p-1], p[#p]
end
local function hatch(p, step)
    -- 45-degree hatching inside the closed polygon p (lines x + z = c, even-odd rule)
    local n = math.floor(#p / 2)
    if n < 3 then return end
    local umin, umax = math.huge, -math.huge
    for i = 1, n do
        local u = p[2*i-1] + p[2*i]
        if u < umin then umin = u end
        if u > umax then umax = u end
    end
    step = math.max(step, (umax - umin) / 300)
    local xs = {}
    local c = umin + step * 0.5
    while c < umax do
        local cnt = 0
        for i = 1, n do
            local j = (i % n) + 1
            local ax, az, bx, bz = p[2*i-1], p[2*i], p[2*j-1], p[2*j]
            local ua, ub = ax + az, bx + bz
            if (ua <= c and ub > c) or (ub <= c and ua > c) then
                cnt = cnt + 1
                xs[cnt] = ax + (bx - ax) * (c - ua) / (ub - ua)
            end
        end
        for q = #xs, cnt + 1, -1 do xs[q] = nil end
        table.sort(xs)
        for q = 1, cnt - 1, 2 do seg(xs[q], c - xs[q], xs[q+1], c - xs[q+1]) end
        c = c + step
    end
end

-- ---- glyphs: one shape per kind, centred on (x, z), size r (inside gl.BeginEnd(GL.LINES))
local function square(x, z, r) seg(x-r, z-r, x+r, z-r); seg(x+r, z-r, x+r, z+r); seg(x+r, z+r, x-r, z+r); seg(x-r, z+r, x-r, z-r) end
local function ibeam(x, z, dx, dz, half, serif)
    -- the Terrain choke glyph: a width bar perpendicular to (dx, dz), a serif at each end
    local len = math.sqrt(dx*dx + dz*dz); if len == 0 then dx, dz, len = 0, 1, 1 end
    dx, dz = dx/len, dz/len
    local lx, lz, rx, rz = x - dz*half, z + dx*half, x + dz*half, z - dx*half
    seg(lx, lz, rx, rz)
    seg(lx - dx*serif, lz - dz*serif, lx + dx*serif, lz + dz*serif)
    seg(rx - dx*serif, rz - dz*serif, rx + dx*serif, rz + dz*serif)
end
local function star(x, z, r)
    local px, pz
    for i = 0, 10 do
        local a = -math.pi / 2 + i * math.pi / 5
        local rr = (i % 2 == 0) and r or r * 0.42
        local cx, cz = x + math.cos(a)*rr, z + math.sin(a)*rr
        if px then seg(px, pz, cx, cz) end
        px, pz = cx, cz
    end
end
local function arcUp(x, z, r, n)
    -- the upper half circle (north), a dome
    local px, pz
    for i = 0, n do
        local a = math.pi + i * math.pi / n
        local cx, cz = x + math.cos(a)*r, z + math.sin(a)*r
        if px then seg(px, pz, cx, cz) end
        px, pz = cx, cz
    end
end
local function arcDown(x, z, r, n)
    local px, pz
    for i = 0, n do
        local a = i * math.pi / n
        local cx, cz = x + math.cos(a)*r, z + math.sin(a)*r
        if px then seg(px, pz, cx, cz) end
        px, pz = cx, cz
    end
end
local function dot(x, z, d) seg(x - d, z, x + d, z); seg(x, z - d, x, z + d) end
local function glyph(kind, x, z, r, mk)
    if kind == "metal" then square(x, z, r * 0.7)
    elseif kind == "centre" then star(x, z, r)
    elseif kind == "geo" then
        -- a downward triangle (the Terrain view's upright triangle is high ground)
        seg(x - r, z - r*0.7, x + r, z - r*0.7); seg(x + r, z - r*0.7, x, z + r); seg(x, z + r, x - r, z - r*0.7)
    elseif kind == "tidal" then
        for _, oz in ipairs({-0.3, 0.3}) do
            local zz = z + r * oz
            seg(x - r, zz, x - r*0.5, zz - r*0.25); seg(x - r*0.5, zz - r*0.25, x, zz)
            seg(x, zz, x + r*0.5, zz - r*0.25); seg(x + r*0.5, zz - r*0.25, x + r, zz)
        end
    elseif kind == "choke" then ibeam(x, z, mk.dx or 0, mk.dz or 1, mk.half and math.max(mk.half, r) or r, r * 0.35)
    elseif kind == "killzone" then
        ibeam(x, z, mk.dx or 0, mk.dz or 1, r, r * 0.35)
        seg(x - r*0.6, z - r*0.6, x + r*0.6, z + r*0.6); seg(x - r*0.6, z + r*0.6, x + r*0.6, z - r*0.6)
    elseif kind == "radar" then arcUp(x, z + r*0.3, r, 8); arcUp(x, z + r*0.3, r * 0.55, 6); dot(x, z + r*0.3, r * 0.12)
    elseif kind == "perch" then seg(x - r, z + r*0.4, x, z - r*0.5); seg(x, z - r*0.5, x + r, z + r*0.4)
    elseif kind == "lrpc" then
        -- a tall, narrow double chevron
        for _, oz in ipairs({0, 0.5}) do
            local zz = z + r * oz
            seg(x - r*0.55, zz + r*0.6, x, zz - r*1.1); seg(x, zz - r*1.1, x + r*0.55, zz + r*0.6)
        end
    elseif kind == "forward" then square(x, z, r * 0.8); square(x, z, r * 0.15)
    elseif kind == "yard" then
        -- an anchor: ring, stock, shank, the arms as the lower half circle
        ngon(x, z - r*0.9, r*0.16, 8)
        seg(x - r*0.45, z - r*0.5, x + r*0.45, z - r*0.5)
        seg(x, z - r*0.74, x, z + r*0.8)
        arcDown(x, z, r * 0.8, 8)
    elseif kind == "strait" then seg(x - r, z - r*0.28, x + r, z - r*0.28); seg(x - r, z + r*0.28, x + r, z + r*0.28)
    elseif kind == "emergence" then
        for i = -2, 2 do
            for j = -2, 2 do
                if (i + j) % 2 == 0 and math.abs(i) + math.abs(j) <= 2 then dot(x + i*r*0.4, z + j*r*0.4, r * 0.08) end
            end
        end
    elseif kind == "coastfire" then ngon(x, z, r * 0.8, 16); dot(x, z, r * 0.25)
    elseif kind == "seaplane" then
        seg(x, z - r, x, z + r)
        seg(x - r, z + r*0.2, x, z - r*0.2); seg(x, z - r*0.2, x + r, z + r*0.2)
        seg(x - r*0.4, z + r*0.85, x + r*0.4, z + r*0.85)
    elseif kind == "island" then ngon(x, z, r, 6); ngon(x, z, r * 0.55, 6)
    elseif kind == "antinuke" then
        -- a ring with three spokes; the 2000-elmo coverage circle is drawn by the late layer
        -- for the selected side only (drawn for every site it crossed the whole map as dashes)
        ngon(x, z, r * 0.45, 12)
        for _, a in ipairs({-math.pi / 2, math.pi / 6, 5 * math.pi / 6}) do
            seg(x + math.cos(a) * r * 0.45, z + math.sin(a) * r * 0.45, x + math.cos(a) * r, z + math.sin(a) * r)
        end
    end
end
local function landingGlyph(mk, assault, L)
    -- the beach line; an arrow inland for an assault landing, out to sea for a home landing
    if mk.contested then dashed(mk.line, 40, 20) else solid(mk.line) end
    if assault == nil or not mk.mx then return end
    local dx, dz = mk.nx, mk.nz
    if not assault then dx, dz = -dx, -dz end
    local tx, tz = mk.mx + dx*L, mk.mz + dz*L
    seg(mk.mx - dx*L*0.2, mk.mz - dz*L*0.2, tx, tz)
    local px, pz = -dz, dx
    seg(tx, tz, tx - dx*L*0.4 + px*L*0.3, tz - dz*L*0.4 + pz*L*0.3)
    seg(tx, tz, tx - dx*L*0.4 - px*L*0.3, tz - dz*L*0.4 - pz*L*0.3)
end

-- The style of every kind: shape (above) first, colour second; the text is the legend row.
local KIND = {
    metal     = {c=K.white,  w=1.5, r=28, text="Hollow square: metal cluster (number: metal per second)"},
    centre    = {c=K.white,  w=2,   r=70, text="Star: map centre"},
    geo       = {c=K.yellow, w=2,   r=40, text="Downward triangle: geothermal vent"},
    tidal     = {c=K.sky,    w=2,   r=40, text="Two waves: tidal generator site"},
    choke     = {c=K.white,  w=2.5, r=40, text="Bar with serifs: choke (number: width in elmos)"},
    killzone  = {c=K.verm,   w=2.5, r=50, text="Crossed bar: kill zone, hold the approach here"},
    radar     = {c=K.green,  w=2,   r=45, text="Two arcs over a dot: radar hill"},
    perch     = {c=K.orange, w=2.5, r=45, text="Wide chevron: artillery perch"},
    forward   = {c=K.green,  w=2,   r=45, text="Square with a dot: forward base site"},
    emergence = {c=K.purple, w=2,   r=50, text="Dot cluster: emergence band, amphibious units come ashore"},
    island    = {c=K.teal,   w=2,   r=60, text="Double hexagon: island (its class is in the record)"},
    yard      = {c=K.blue,   w=2,   r=50, text="Anchor: shipyard site"},
    seazone   = {c=K.blue,   w=1.5, r=40, text="Hatched area: sea control zone"},
    strait    = {c=K.sky,    w=2.5, r=50, text="Double bar: strait"},
    coastfire = {c=K.orange, w=2,   r=40, text="Circle with a cross: coast-fire station on the standoff line"},
    seaplane  = {c=K.sky,    w=2,   r=45, text="Plane: seaplane platform site"},
    lrpc      = {c=K.verm,   w=2.5, r=50, text="Tall double chevron: long-range cannon perch"},
    antinuke  = {c=K.purple, w=2,   r=40, text="Ring with three spokes: anti-nuke site; thin circle: the selected side's 2000 coverage"},
    landing   = {c=K.white,  w=2.5, r=40, text="Beach line: landing"},
}
local KIND_ORDER = {"metal", "centre", "geo", "tidal", "choke", "killzone", "radar", "perch", "forward", "emergence", "island",
    "yard", "strait", "coastfire", "seaplane", "lrpc", "antinuke"}

local function phaseVisible(mk)
    local ph = PHASE_BY_KEY[options.phase]
    if not ph or not ph.lo then return true end
    local to = (mk.to < 0) and 1e9 or mk.to
    return mk.from < ph.hi and to > ph.lo
end
local function layerOf(mk)
    if mk.kind == "seazone" then return "seazone" end
    if mk.kind == "landing" then return "landing" end
    if mk.group == "economy" or mk.group == "land" or mk.group == "sea" or mk.group == "late" then return mk.group end
    return "land"
end
-- Lua numbers here are single precision floats, so %g printed 65.6 as 65.5999985: round
-- to a whole number when within 0.05 of one, else to one decimal.
local function fmtNum(v)
    v = tonumber(v) or 0
    local r = math.floor(v + 0.5)
    if math.abs(v - r) < 0.05 then return string.format("%d", r) end
    return string.format("%.1f", v)
end
local function markWord(mk)
    local v = mk.value or 0
    if mk.kind == "metal" then return string.format("%.1f m/s", v) end   -- metal per second
    if mk.kind == "choke" then return fmtNum(v) end
    if v ~= 0 then return mk.kind .. " " .. fmtNum(v) end
    return mk.kind
end

-- ---- selection-independent preparation (time-boxed steps before the first compile)
local function prepMarks(m)
    local fm = fieldModel()
    m.byLayer = {}
    for _, mk in ipairs(m.marks) do
        local layer = layerOf(mk)
        local bl = m.byLayer[layer]; if not bl then bl = {}; m.byLayer[layer] = bl end
        local list = bl[mk.kind]; if not list then list = {}; bl[mk.kind] = list end
        list[#list+1] = mk
        if mk.kind == "choke" or mk.kind == "killzone" then
            if mk.kind == "choke" then mk.half = math.max(16, math.min(400, (mk.value or 0) / 2)) end
            -- borrow the crossing direction of the terrain map's choke at the same place
            mk.dx, mk.dz = 0, 1
            if fm and fm.chokes then
                local best = 160 * 160
                for _, c in ipairs(fm.chokes) do
                    local d = (c.x - mk.x)^2 + (c.z - mk.z)^2
                    if d < best then best = d; mk.dx, mk.dz = c.dx, c.dz end
                end
            end
        elseif mk.kind == "landing" and mk.line and #mk.line >= 4 then
            local p = mk.line
            local mx, mz = polyMid(p)
            local tx, tz = p[#p-1] - p[1], p[#p] - p[2]
            local len = math.sqrt(tx*tx + tz*tz); if len == 0 then tx, tz, len = 1, 0, 1 end
            local nx, nz = -tz/len, tx/len
            -- inland is the side of the beach whose ground stands higher
            local ha = Spring.GetGroundHeight(mx + nx*120, mz + nz*120)
            local hb = Spring.GetGroundHeight(mx - nx*120, mz - nz*120)
            if hb > ha then nx, nz = -nx, -nz end
            mk.mx, mk.mz, mk.nx, mk.nz = mx, mz, nx, nz
        end
    end
end
local function verticalEdges(m, col)
    -- borders between columns col-1 and col, merged down the rows
    local gw, gh, cell, c, edges = m.gw, m.gh, m.cell, m.cellPos, m.edges
    local runA, runB, start = nil, nil, nil
    for row = 0, gh do
        local a, b = nil, nil
        if row < gh then a, b = c[row*gw + col - 1], c[row*gw + col] end
        local diff = row < gh and a ~= b
        if not (diff and start and a == runA and b == runB) then
            if start then edges[#edges+1] = {col*cell, start*cell, col*cell, row*cell, runA, runB} end
            if diff then start, runA, runB = row, a, b else start = nil end
        end
    end
end
local function horizontalEdges(m, row)
    local gw, cell, c, edges = m.gw, m.cell, m.cellPos, m.edges
    local runA, runB, start = nil, nil, nil
    for col = 0, gw do
        local a, b = nil, nil
        if col < gw then a, b = c[(row-1)*gw + col], c[row*gw + col] end
        local diff = col < gw and a ~= b
        if not (diff and start and a == runA and b == runB) then
            if start then edges[#edges+1] = {start*cell, row*cell, col*cell, row*cell, runA, runB} end
            if diff then start, runA, runB = col, a, b else start = nil end
        end
    end
end
local function queue(names)
    for _, n in ipairs(names) do
        if not pendingSet[n] then pendingSet[n] = true; pending[#pending+1] = n end
    end
end
local function stepPrep()
    local m = model
    local t0 = Spring.GetTimer()
    local steps = 0
    while prep do
        if prep.stage == 1 then
            prepMarks(m)
            prep.stage, prep.i = (m.terrOk and 2 or 5), 1
        elseif prep.stage == 2 then
            local r = m.terrRuns[prep.i]
            if not r then prep.stage, prep.i = 3, 1
            else
                local cells = m.cellPos
                for c = r[1], r[1] + r[3] - 1 do cells[c] = r[2] end
                prep.i = prep.i + 1
            end
        elseif prep.stage == 3 then
            if prep.i > m.gw - 1 then prep.stage, prep.i = 4, 1 else verticalEdges(m, prep.i); prep.i = prep.i + 1 end
        elseif prep.stage == 4 then
            if prep.i > m.gh - 1 then prep.stage = 5 else horizontalEdges(m, prep.i); prep.i = prep.i + 1 end
        else
            prep = nil
            queue(LAYER_ORDER)
            break
        end
        steps = steps + 1
        if steps % 8 == 0 and Spring.DiffTimers(Spring.GetTimer(), t0) > 0.002 then break end
    end
end

-- ---- labels (screen space, rebuilt on selection and phase changes; never per frame)
local function addLabel(x, z, s, size, maxH, c, centre, dzFar)
    -- dzFar: the label's z offset in the strategic view, below a FAR_SCALE glyph (nil: z as given)
    if #labelsAll >= LABEL_CAP then return end
    labelsAll[#labelsAll+1] = {x, groundY(x, z) + 12, z, s, size, maxH, c, centre, dzFar}
end
local function buildLabels()
    labelsAll = {}
    local m = model
    if not m then return end
    for _, i in ipairs(m.order) do
        local p = m.positions[i]
        local c = (i == selected) and K.yellow or K.white
        -- the rank on the disc: ink on a solid (script) disc, white in a hollow (predicted) one
        addLabel(p.x, p.z, tostring(p.n), 13, 1e9, p.source == "script" and K.ink or K.white, true)
        addLabel(p.x, p.z + POS_R * 1.9 + 40, p.name .. "  " .. p.label, 12, 1e9, c, false)
    end
    for _, mk in ipairs(m.marks) do
        if mk.labelled and KIND[mk.kind] and phaseVisible(mk) then
            local x, z = mk.x, mk.z
            if mk.mx then x, z = mk.mx, mk.mz end
            -- labelled marks keep their text at every height (the strategic view too); the cap is 200
            local r = KIND[mk.kind].r
            addLabel(x, z + r + 30, markWord(mk), 11, 1e9, KIND[mk.kind].c, false, r * FAR_SCALE + 60 - (r + 30))
        end
    end
end

-- ---- the opening card
local function factoryFor(class, faction)
    local f = model and model.factories[class]
    return f and f[faction] or nil
end
local function viewerFaction()
    if options.faction then return options.faction end
    local ok, _, _, _, _, side = pcall(Spring.GetTeamInfo, Spring.GetMyTeamID(), false)
    return (ok and normFaction(side)) or "armada"
end
local function buildCard()
    card = nil
    if not model or not selected then return end
    local p = model.positions[selected]
    if not p then return end
    local o = model.openings[selected]
    local faction = viewerFaction()
    local c = {name=p.name, label=p.label, sublabel=p.sublabel, source=p.source, faction=faction, reasons={}, lines={}}
    local function line(head, body, col) c.lines[#c.lines+1] = {head, body, col or {0.91, 0.93, 0.96}} end
    local sub = (p.sublabel ~= "" and p.sublabel ~= "-") and ("  /  " .. p.sublabel) or ""
    local src = p.source
    if p.actual and p.actualDist then src = string.format("%s, %d from actual", src, math.floor(p.actualDist + 0.5)) end
    line(p.name, string.format("%s%s   (%s)", p.label, sub, src), K.white)
    if o then
        c.class, c.factory, c.next = o.class, factoryFor(o.class, faction) or "-", o.fallbacks[1] or "-"
        c.energy, c.second, c.reasons = o.energy, o.second, o.reasons
        local e = model.env
        c.wind, c.tidal = (e.minWind + e.maxWind) / 2, e.tidal
        line("Ideal factory", string.format("%s  %s   next: %s", CLASS_WORD[o.class] or o.class, c.factory, c.next))
        line("Energy", string.format("%s  (wind %.1f avg, tidal %s)", o.energy ~= "" and o.energy or "-", c.wind, fmtNum(c.tidal)))
        line("Then", o.second ~= "" and o.second or "-")
        if #o.reasons == 0 then line("Why", "-") end
        for k = 1, math.min(3, #o.reasons) do line(k == 1 and "Why" or "", o.reasons[k]) end
    else
        line("Opening", "none in the file", K.verm)
    end
    local r = p.actual
    if r then
        local tf = normFaction(r.side) or faction
        local ideal = o and factoryFor(o.class, tf)
        local verdict = "differs"
        if ideal and r.factory == ideal then verdict = "matches"
        elseif o and o.fallbacks[1] and r.factory == factoryFor(o.fallbacks[1], tf) then verdict = "fallback" end
        c.chosen = {factory=r.factory, team=r.teamId, role=r.role, verdict=verdict}
        line("Chosen", string.format("%s   (team %s, %s)   %s", r.factory or "-", tostring(r.teamId), r.role or "?", verdict),
            verdict == "matches" and K.green or (verdict == "differs" and K.verm or K.yellow))
    else
        c.chosen = {verdict="no AI"}
        line("Chosen", "no AI", K.grey)
    end
    card = c
end

-- ---- display lists
local function compileLayer(name, fn)
    if lists[name] then gl.DeleteList(lists[name]); lists[name] = nil end
    if fn then lists[name] = gl.CreateList(fn) end
end
local function lineLayer(name, fn)
    compileLayer(name, function() haloPass = true; fn(); haloPass = false; fn() end)
end
local function markLayer(name)
    -- two lists per mark layer: `name` (near) and `name .. "Far"` (strategic view), in which
    -- the labelled marks' glyphs are FAR_SCALE larger; drawWorld picks one by camera height
    local byKind = (model and model.byLayer[name]) or {}
    local sel = selected and model and model.positions[selected]
    local function body(far)
        local function size(st, mk) return (far and mk.labelled) and st.r * FAR_SCALE or st.r end
        for _, kind in ipairs(KIND_ORDER) do
            local ms, st = byKind[kind], KIND[kind]
            if ms and st then
                stroke(st.c, 0.95, st.w)
                gl.BeginEnd(GL.LINES, function()
                    for _, mk in ipairs(ms) do if phaseVisible(mk) then glyph(kind, mk.x, mk.z, size(st, mk), mk) end end
                end)
            end
        end
        -- anti-nuke coverage: a thin solid circle, only for the selected position's side
        local nukes = byKind.antinuke
        if nukes and sel then
            stroke(KIND.antinuke.c, 0.8, 1.2)
            gl.BeginEnd(GL.LINES, function()
                for _, mk in ipairs(nukes) do if mk.ally == sel.ally and phaseVisible(mk) then ngon(mk.x, mk.z, 2000, 96) end end
            end)
        end
        -- contested: a dashed (split) vermilion outline around the glyph
        stroke(K.verm, 0.95, 1.5)
        gl.BeginEnd(GL.LINES, function()
            for _, kind in ipairs(KIND_ORDER) do
                local ms, st = byKind[kind], KIND[kind]
                if ms and st then
                    for _, mk in ipairs(ms) do if mk.contested and phaseVisible(mk) then ngon(mk.x, mk.z, size(st, mk) * 1.5, 12, true) end end
                end
            end
        end)
    end
    lineLayer(name, function() body(false) end)
    lineLayer(name .. "Far", function() body(true) end)
end
local BUILD = {}
BUILD.dim = function()
    compileLayer("dim", function()
        local w, h = Game.mapSizeX, Game.mapSizeZ
        gl.Color(K.ink[1], K.ink[2], K.ink[3], 0.45)
        gl.BeginEnd(GL.QUADS, function()
            gl.Vertex(-512, 0, -512); gl.Vertex(w+512, 0, -512); gl.Vertex(w+512, 0, h+512); gl.Vertex(-512, 0, h+512)
        end)
    end)
end
BUILD.terrOutline = function()
    local m = model
    if not m.terrOk then compileLayer("terrOutline", nil); return end
    -- a light boundary between territories; no halo, it sits under everything
    compileLayer("terrOutline", function()
        gl.Color(K.grey[1], K.grey[2], K.grey[3], 0.5); gl.LineWidth(1.2)
        gl.BeginEnd(GL.LINES, function() for _, e in ipairs(m.edges) do seg(e[1], e[2], e[3], e[4]) end end)
    end)
end
BUILD.terrSel = function()
    local m = model
    if not m.terrOk or not selected or not m.positions[selected] then compileLayer("terrSel", nil); return end
    local sel = selected
    compileLayer("terrSel", function()
        if fieldApi and fieldApi.FillRuns then
            fieldApi.FillRuns({gw=m.gw, gh=m.gh, cell=m.cell}, m.terrRuns, m.cellPos, {[sel]=true}, K.yellow, 0.16)
        end
        for pass = 1, 2 do
            haloPass = pass == 1
            stroke(K.yellow, 0.9, 2)
            gl.BeginEnd(GL.LINES, function()
                for _, e in ipairs(m.edges) do if e[5] == sel or e[6] == sel then seg(e[1], e[2], e[3], e[4]) end end
            end)
        end
        haloPass = false
    end)
end
BUILD.seazone = function()
    local list = (model.byLayer.seazone or {}).seazone or {}
    lineLayer("seazone", function()
        local st = KIND.seazone
        stroke(st.c, 0.7, 1.2)
        gl.BeginEnd(GL.LINES, function()
            for _, mk in ipairs(list) do if mk.line and phaseVisible(mk) then hatch(mk.line, 120) end end
        end)
        stroke(st.c, 0.95, 2)
        gl.BeginEnd(GL.LINES, function()
            for _, mk in ipairs(list) do
                if mk.line and phaseVisible(mk) then if mk.contested then dashed(mk.line, 60, 30) else solid(mk.line) end end
            end
        end)
    end)
end
BUILD.economy = function() markLayer("economy") end
BUILD.land = function() markLayer("land") end
BUILD.sea = function() markLayer("sea") end
BUILD.late = function() markLayer("late") end
BUILD.landing = function()
    local list = (model.byLayer.landing or {}).landing or {}
    local sel = selected and model.positions[selected]
    -- the selected position's side reads each landing: an assault landing (arrow inland) when
    -- the landing's defending ally is another team, a home landing (arrow out to sea) when it is its own
    local groups = {{c=K.verm, want=true}, {c=K.green, want=false}, {c=K.white}}
    lineLayer("landing", function()
        for _, g in ipairs(groups) do
            stroke(g.c, 0.95, KIND.landing.w)
            gl.BeginEnd(GL.LINES, function()
                for _, mk in ipairs(list) do
                    if mk.line and phaseVisible(mk) then
                        local assault = nil
                        if sel then assault = mk.ally ~= sel.ally end
                        if assault == g.want then landingGlyph(mk, assault, 110) end
                    end
                end
            end)
        end
    end)
end
BUILD.positions = function()
    local m = model
    lineLayer("positions", function()
        if not haloPass then
            gl.Color(K.white[1], K.white[2], K.white[3], 0.85)
            gl.BeginEnd(GL.TRIANGLES, function()
                for _, i in ipairs(m.order) do local p = m.positions[i]; if p.source == "script" then disc(p.x, p.z, POS_R) end end
            end)
        end
        stroke(K.white, 0.95, 2)
        gl.BeginEnd(GL.LINES, function()
            for _, i in ipairs(m.order) do
                local p = m.positions[i]
                ngon(p.x, p.z, POS_R, 24)
                if p.source ~= "script" then ngon(p.x, p.z, POS_R * 0.7, 24) end
            end
        end)
        -- a thin dashed line from a predicted position to the actual start the roster reports
        stroke(K.sky, 0.9, 1.5)
        gl.BeginEnd(GL.LINES, function()
            for _, i in ipairs(m.order) do
                local p = m.positions[i]
                local r = p.actual
                if r and p.source ~= "script" and p.actualDist and p.actualDist > POS_R then
                    dashed({p.x, p.z, r.x, r.z}, 40, 24)
                    dot(r.x, r.z, 30)
                end
            end
        end)
    end)
end
BUILD.selRing = function()
    local p = selected and model.positions[selected]
    if not p then compileLayer("selRing", nil); return end
    lineLayer("selRing", function()
        stroke(K.yellow, 1, 3)
        gl.BeginEnd(GL.LINES, function() ngon(p.x, p.z, POS_R * 1.5, 32); ngon(p.x, p.z, POS_R * 1.8, 32) end)
    end)
end
BUILD.minimap = function()
    local m = model
    compileLayer("minimap", function()
        local function ring(x, z, r, n)
            for i = 0, n - 1 do
                local a1, a2 = i * 2 * math.pi / n, (i + 1) * 2 * math.pi / n
                gl.Vertex(x + math.cos(a1)*r, z + math.sin(a1)*r); gl.Vertex(x + math.cos(a2)*r, z + math.sin(a2)*r)
            end
        end
        gl.LineWidth(1.5)
        gl.Color(K.white[1], K.white[2], K.white[3], 0.95)
        gl.BeginEnd(GL.LINES, function()
            for _, i in ipairs(m.order) do local p = m.positions[i]; ring(p.x, p.z, 150, 12) end
        end)
        gl.Color(K.yellow[1], K.yellow[2], K.yellow[3], 0.95)
        gl.BeginEnd(GL.LINES, function()
            for _, mk in ipairs(m.marks) do
                if mk.labelled and KIND[mk.kind] and phaseVisible(mk) and mk.kind ~= "landing" and mk.kind ~= "seazone" then
                    local s = 60
                    gl.Vertex(mk.x - s, mk.z - s); gl.Vertex(mk.x + s, mk.z + s); gl.Vertex(mk.x - s, mk.z + s); gl.Vertex(mk.x + s, mk.z - s)
                end
            end
        end)
        local p = selected and m.positions[selected]
        if p then gl.LineWidth(2.5); gl.BeginEnd(GL.LINES, function() ring(p.x, p.z, 260, 16) end) end
    end)
end

local function loadedStatus()
    if not model then return end
    local s = string.format("%d positions, %d marks", #model.order, #model.marks)
    if prep or #pending > 0 then s = s .. "  (drawing)" end
    if model.terrCount > 0 and not model.terrOk then s = s .. "  (territory grid mismatch)" end
    status = s
end
local function compileSome()
    local t0 = Spring.GetTimer()
    local n = 0
    while #pending > 0 do
        local name = table.remove(pending, 1)
        pendingSet[name] = nil
        local b = BUILD[name]
        if b then b() end
        n = n + 1
        if n >= 3 or Spring.DiffTimers(Spring.GetTimer(), t0) > 0.002 then break end
    end
    loadedStatus()
end
local function disposeLists()
    for _, l in pairs(lists) do gl.DeleteList(l) end
    lists = {}
end

-- ---- selection, roster
local function selectIndex(i)
    if not model or not model.positions[i] then return false end
    selected = i
    inspectLines = nil
    queue(BY_SELECTION)
    buildLabels()
    buildCard()
    return true
end
local function nearestPosition(x, z, radius)
    if not model or not x or not z then return nil end
    local best, bd = nil, radius * radius
    for _, i in ipairs(model.order) do
        local p = model.positions[i]
        local d = (p.x - x)^2 + (p.z - z)^2
        if d < bd then best, bd = i, d end
    end
    return best
end
local function selectMine()
    if not model then return false end
    local x, z = nil, nil
    if mineProvider then x, z = mineProvider() end
    local i = nearestPosition(x, z, 1500)
    if not i then i = model.order[1] end
    return i ~= nil and selectIndex(i)
end
local function refreshRoster(force)
    if not model then return end
    local now = Spring.GetTimer()
    if not force and rosterTimer and Spring.DiffTimers(now, rosterTimer) < 2 then return end
    rosterTimer = now
    local rs = rosterProvider and rosterProvider() or {}
    local parts = {}
    for _, r in ipairs(rs) do
        parts[#parts+1] = tostring(r.teamId) .. ":" .. tostring(r.x) .. ":" .. tostring(r.z) .. ":" .. tostring(r.factory) .. ":" .. tostring(r.role) .. ":" .. tostring(r.side)
    end
    local sig = table.concat(parts, ";")
    if sig == rosterSig and not force then return end
    rosterSig = sig
    for _, i in ipairs(model.order) do
        local p = model.positions[i]
        local best, bd = nil, MATCH_RADIUS * MATCH_RADIUS
        for _, r in ipairs(rs) do
            if r.x and r.z then
                local d = (r.x - p.x)^2 + (r.z - p.z)^2
                if d < bd then best, bd = r, d end
            end
        end
        p.actual = best
        p.actualDist = best and math.sqrt(bd) or nil
    end
    queue(BY_ROSTER)
    buildCard()
end
finishModel = function(m, s)
    local fm = fieldModel()
    if fm and fm.gw and fm.gw > 0 then m.gw, m.gh, m.cell = fm.gw, fm.gh, fm.cell or 32
    else m.cell = 32; m.gw = math.max(1, math.floor(Game.mapSizeX / 32)); m.gh = math.max(1, math.floor(Game.mapSizeZ / 32)) end
    m.terrOk = m.terrCount > 0 and m.terrCount == m.gw * m.gh
    m.fpChecked = fm ~= nil and fm.fingerprint ~= nil
    disposeLists()
    pending, pendingSet = {}, {}
    model, seq = m, s
    selected, inspectLines, card = nil, nil, nil
    rosterSig = ""
    prep = {stage=1, i=1}
    refreshRoster(true)
    if not selectMine() then buildLabels() end
    -- what the two calls queued is a subset of the full queue stepPrep adds when it ends
    pending, pendingSet = {}, {}
    loadedStatus()
end
local function checkFingerprint()
    -- the terrain file may load after this one: compare once it has
    if not model or model.fpChecked then return end
    local fm = fieldModel()
    if not (fm and fm.fingerprint) then return end
    model.fpChecked = true
    if fm.fingerprint ~= model.fieldFp then
        disposeLists()
        model, prep, selected, card, inspectLines = nil, nil, nil, nil, nil
        pending, pendingSet, labelsAll = {}, {}, {}
        status = "Landmarks file skipped: fingerprint differs from map.txt"
    end
end

-- ---- public state changes
local function setMode(value)
    local was = on
    on = value and true or false
    if on then
        if not model and not parse then status = "Landmarks: waiting for file"; lastExists = nil end
    else
        parse = nil
        if not model then status = "Landmarks hidden" end
    end
    return was ~= on
end
local function setPhase(p)
    if type(p) == "string" then p = string.lower(p) end
    if p == "0" then p = "0-5" elseif p == "5" then p = "5-15" elseif p == "15" then p = "15-25" elseif p == "25" then p = "25+" end
    if not PHASE_BY_KEY[p] then return false end
    if options.phase ~= p then
        options.phase = p
        if model then queue(BY_PHASE); buildLabels() end
    end
    return true
end
local function setFaction(f)
    f = normFaction(f)
    if not f then return false end
    options.faction = f
    buildCard()
    return true
end
local function selectName(name)
    if not model or not name then return false end
    -- exact name, then any case (P0.3 / p0.3); never a punctuation-blind match (P1.12 vs P11.2)
    local lower = string.lower(tostring(name))
    for _, i in ipairs(model.order) do if model.positions[i].name == name then return selectIndex(i) end end
    for _, i in ipairs(model.order) do if string.lower(model.positions[i].name) == lower then return selectIndex(i) end end
    local n = tonumber(name)
    if n and model.positions[n] then return selectIndex(n) end
    return false
end
local function step(d)
    if not model or #model.order == 0 then return false end
    local at = 0
    for k, i in ipairs(model.order) do if i == selected then at = k end end
    local n = #model.order
    local k = ((at - 1 + d) % n) + 1
    if at == 0 then k = 1 end
    return selectIndex(model.order[k])
end

-- ---- picking
local function markRecord(mk)
    local owner = (mk.pos >= 0 and model.positions[mk.pos]) and model.positions[mk.pos].name or "none"
    local to = mk.to < 0 and "end" or fmtNum(mk.to)
    return {
        string.format("%s  (%s)  value %s%s", string.upper(mk.kind), mk.group, fmtNum(mk.value), mk.contested and "  contested" or ""),
        string.format("owner %s  ally %d  minutes %s-%s", owner, mk.ally, fmtNum(mk.from), to),
        mk.reason ~= "" and mk.reason or "-",
    }
end
local function pickAt(mx, my)
    local kind, pos = Spring.TraceScreenRay(mx, my, true)
    if kind ~= "ground" or not pos then return false end
    local x, z = pos[1], pos[3]
    local i = nearestPosition(x, z, POS_R * 1.6)
    if i then selectIndex(i); return true end
    local best, bd = nil, 80 * 80
    for _, mk in ipairs(model.marks) do
        if (KIND[mk.kind]) and phaseVisible(mk) then
            local px, pz = mk.x, mk.z
            if mk.mx then px, pz = mk.mx, mk.mz end
            local d = (px - x)^2 + (pz - z)^2
            if d < bd then best, bd = mk, d end
        end
    end
    if best then inspectLines = markRecord(best); return true end
    inspectLines = nil
    return false
end

-- ---- drawing
local function drawWorld()
    if not on or not model or Spring.IsGUIHidden() then return end
    gl.DepthTest(false)
    -- with the terrain map off the marks draw over a dim sheet of their own
    if not (fieldApi and fieldApi.Mode and fieldApi.Mode()) and lists.dim then gl.CallList(lists.dim) end
    local _, cy = Spring.GetCameraPosition()
    local far = (cy or 0) > LABEL_HEIGHT
    for _, name in ipairs(DRAW_ORDER) do
        local l = lists[name]
        if far and lists[name .. "Far"] then l = lists[name .. "Far"] end
        if l then gl.CallList(l) end
    end
    gl.LineWidth(1); gl.Color(1, 1, 1, 1); gl.DepthTest(true)
end
local function drawMiniMap(sx, sy)
    if not on or not model or not lists.minimap then return end
    gl.PushMatrix()
    gl.Translate(0, sy, 0)
    gl.Scale(sx / Game.mapSizeX, -sy / Game.mapSizeZ, 1)
    gl.CallList(lists.minimap)
    gl.PopMatrix()
    gl.LineWidth(1); gl.Color(1, 1, 1, 1)
end
local function drawLabels()
    local _, cy = Spring.GetCameraPosition()
    cy = cy or 0
    local vw, vh = gl.GetViewSizes()
    local far = cy > LABEL_HEIGHT
    local shrink = far and math.max(0.55, math.min(1, LABEL_HEIGHT / cy)) or 1
    for _, l in ipairs(labelsAll) do
        if cy <= l[6] then
            local sx, sy, sz = Spring.WorldToScreenCoords(l[1], l[2], l[3] + ((far and l[9]) or 0))
            if sx and sz and sz > 0 and sz < 1 and sx > 0 and sx < vw and sy > 0 and sy < vh then
                local size = math.max(9, l[5] * shrink)
                local opt = l[8] and "cv" or "c"
                gl.Color(K.ink[1], K.ink[2], K.ink[3], 0.85)
                gl.Text(l[4], sx+1, sy-1, size, opt); gl.Text(l[4], sx-1, sy-1, size, opt); gl.Text(l[4], sx+1, sy+1, size, opt); gl.Text(l[4], sx-1, sy+1, size, opt)
                local c = l[7]
                gl.Color(c[1], c[2], c[3], 0.95); gl.Text(l[4], sx, sy, size, opt)
            end
        end
    end
    gl.Color(1, 1, 1, 1)
end
-- legend samples: the map's own glyph code in screen space (flatY), halo pass then colour
local function legendSample(cx, cy, fn)
    flatY, patScale = cy, 0.2
    haloPass = true; fn(cx, cy)
    haloPass = false; fn(cx, cy)
    flatY, patScale = nil, 1
    gl.LineWidth(1)
end
local function kindSample(kind)
    return function(cx, cy)
        local st = KIND[kind]
        stroke(st.c, 0.95, st.w)
        gl.BeginEnd(GL.LINES, function() glyph(kind, cx, cy, 8, {}) end)
    end
end
local function legendRows()
    local rows = {}
    local function head(t) rows[#rows+1] = {nil, t} end
    local function add(sample, t) rows[#rows+1] = {sample, t} end
    head("POSITIONS")
    add(function(cx, cy)
        if not haloPass then gl.Color(1, 1, 1, 0.85); gl.BeginEnd(GL.TRIANGLES, function() disc(cx, cy, 7) end) end
        stroke(K.white, 0.95, 2); gl.BeginEnd(GL.LINES, function() ngon(cx, cy, 7, 16) end)
    end, "Filled disc: a start position from the start script (number: rank from the rear)")
    add(function(cx, cy)
        stroke(K.white, 0.95, 2); gl.BeginEnd(GL.LINES, function() ngon(cx, cy, 7, 16); ngon(cx, cy, 4.5, 12) end)
    end, "Hollow double ring: a predicted start position")
    add(function(cx, cy)
        stroke(K.yellow, 1, 3); gl.BeginEnd(GL.LINES, function() ngon(cx, cy, 6, 16); ngon(cx, cy, 8, 16) end)
    end, "Double yellow ring: the selected position (the opening card describes it)")
    add(function(cx, cy)
        stroke(K.sky, 0.9, 1.5); gl.BeginEnd(GL.LINES, function() dashed({cx - 20, cy, cx + 14, cy}, 40, 24); dot(cx + 18, cy, 3) end)
    end, "Thin dashed line: prediction to the actual start")
    add(function(cx, cy)
        if not haloPass then
            gl.Color(K.yellow[1], K.yellow[2], K.yellow[3], 0.3); gl.Rect(cx - 22, cy - 6, cx, cy + 6)
            gl.Color(K.grey[1], K.grey[2], K.grey[3], 0.6); gl.LineWidth(1.2)
            gl.BeginEnd(GL.LINES, function() seg(cx + 6, cy - 7, cx + 6, cy + 7); seg(cx + 6, cy, cx + 22, cy) end)
        end
    end, "Soft fill: selected territory; thin grey lines: other territories")
    head("ECONOMY")
    for _, k in ipairs({"metal", "geo", "tidal", "centre"}) do add(kindSample(k), KIND[k].text) end
    head("LAND")
    for _, k in ipairs({"choke", "killzone", "radar", "perch", "forward", "emergence", "island"}) do add(kindSample(k), KIND[k].text) end
    head("SEA")
    add(kindSample("yard"), KIND.yard.text)
    add(function(cx, cy)
        local p = {cx - 16, cy - 7, cx + 16, cy - 7, cx + 16, cy + 7, cx - 16, cy + 7, cx - 16, cy - 7}
        stroke(KIND.seazone.c, 0.95, 1.2); gl.BeginEnd(GL.LINES, function() hatch(p, 5); solid(p) end)
    end, KIND.seazone.text)
    add(kindSample("strait"), KIND.strait.text)
    local function landingRow(assault, c)
        return function(cx, cy)
            local mk = {line={cx - 18, cy + 4, cx + 18, cy + 4}, mx=cx, mz=cy + 4, nx=0, nz=-1}
            stroke(c, 0.95, 2.5); gl.BeginEnd(GL.LINES, function() landingGlyph(mk, assault, 11) end)
        end
    end
    add(landingRow(true, K.verm), "Beach line, arrow inland: assault landing for the selected side")
    add(landingRow(false, K.green), "Beach line, arrow out to sea: home landing (the selected side defends it)")
    for _, k in ipairs({"coastfire", "seaplane"}) do add(kindSample(k), KIND[k].text) end
    head("LATE GAME")
    add(kindSample("lrpc"), KIND.lrpc.text)
    add(function(cx, cy)
        kindSample("antinuke")(cx, cy)
        stroke(KIND.antinuke.c, 0.8, 1.2); gl.BeginEnd(GL.LINES, function() ngon(cx, cy, 13, 24) end)
    end, KIND.antinuke.text)
    head("ANY MARK")
    add(function(cx, cy)
        kindSample("metal")(cx, cy)
        stroke(K.verm, 0.95, 1.5); gl.BeginEnd(GL.LINES, function() ngon(cx, cy, 12, 12, true) end)
    end, "Dashed ring around a mark: contested, near the contact line")
    return rows
end
local legendCache = nil
local ROW_H, HEAD_H = 17, 20
local function panel(x, top, w, h)
    gl.Color(inkPanel); gl.Rect(x, top - h, x + w, top)
    gl.Color(K.sky[1], K.sky[2], K.sky[3], 1); gl.Rect(x, top - 3, x + w, top)
    panelRects[#panelRects+1] = {x, top - h, x + w, top}
end
-- The panels dock on the left just below the minimap (BAR draws the minimap over anything
-- placed under it; the first played run hid the card there). The minimap's bottom edge in
-- GL coordinates is the y of Spring.GetMiniMapGeometry (BAR's minimap_utils reads it so);
-- the picture-in-picture minimap reports its own box through WG.minimap.getScreenBounds.
local function dockTop(vh)
    local bottom = nil
    local wm = WG and WG.minimap
    local okPip, pip = pcall(function() return wm and wm.isPipMinimapActive and wm.isPipMinimapActive() end)
    if okPip and pip and wm.getScreenBounds then
        local ok, _, b = pcall(wm.getScreenBounds)
        if ok and type(b) == "number" then bottom = b end
    end
    if not bottom and Spring.GetMiniMapGeometry then
        local ok, _, py, _, sy, minimized = pcall(Spring.GetMiniMapGeometry)
        if ok and type(py) == "number" and type(sy) == "number" and sy > 0 and not minimized then bottom = py end
    end
    if not bottom or bottom <= 0 or bottom > vh then bottom = vh - 60 end
    return bottom - 12
end
local function drawPanels()
    panelRects = {}
    if Spring.IsGUIHidden() then return end
    local vw, vh = gl.GetViewSizes()
    local dock = dockTop(vh)
    local x, top = 12, dock
    local w = 460
    -- the opening card, with the clicked mark's record under it
    local lines = card and card.lines or {}
    local h = 40 + #lines * 15 + (inspectLines and (20 + #inspectLines * 14) or 0) + 8
    if not model then h = 40 + 18 end
    top = math.max(h + 10, math.min(vh - 10, top))
    panel(x, top, w, h)
    gl.Color(0.93, 0.96, 1, 1); gl.Text("LANDMARKS  /  OPENING CARD", x + 14, top - 24, 13, "o")
    local y = top - 44
    if not model then
        gl.Color(muted); gl.Text(status, x + 14, y, 10, "o")
    else
        for _, l in ipairs(lines) do
            gl.Color(mint); gl.Text(l[1], x + 14, y, 10, "o")
            local c = l[3]
            gl.Color(c[1], c[2], c[3], 1); gl.Text(l[2], x + 112, y, 10, "o")
            y = y - 15
        end
        if inspectLines then
            y = y - 6
            gl.Color(mint); gl.Text("MARK", x + 14, y, 10, "o"); y = y - 14
            for _, l in ipairs(inspectLines) do gl.Color(0.91, 0.93, 0.96, 1); gl.Text(l, x + 14, y, 10, "o"); y = y - 14 end
        end
    end
    -- the legend, beside the card
    if options.legend then
        if not legendCache then legendCache = legendRows() end
        local lw = 470
        local lh = 40
        for _, row in ipairs(legendCache) do lh = lh + (row[1] and ROW_H or HEAD_H) end
        local lx = x + w + 8
        if lx + lw > vw - 8 then lx = math.max(8, vw - lw - 8) end
        local ltop = math.max(lh + 10, math.min(vh - 10, dock))
        panel(lx, ltop, lw, lh)
        gl.Color(0.93, 0.96, 1, 1); gl.Text("LANDMARKS LEGEND  /  shape carries the meaning, colour repeats it", lx + 14, ltop - 24, 11, "o")
        local ly = ltop - 40
        for _, row in ipairs(legendCache) do
            if row[1] then
                legendSample(lx + 40, ly, row[1])
                gl.Color(0.9, 0.93, 0.97, 1); gl.Text(row[2], lx + 76, ly - 4, 10, "o")
                ly = ly - ROW_H
            else
                ly = ly - 4
                gl.Color(mint); gl.Text(row[2], lx + 14, ly - 2, 10, "o")
                ly = ly - (HEAD_H - 4)
            end
        end
    end
    gl.LineWidth(1); gl.Color(1, 1, 1, 1)
end
local function drawScreen()
    if not on then panelRects = {}; return end
    if model then drawLabels() end
    drawPanels()
end
local function update()
    if not on then return end
    if parse then stepParse(); return end
    if not model then tryLoad(); return end
    checkFingerprint()
    if not model then return end
    if prep then stepPrep(); loadedStatus(); return end
    refreshRoster(false)
    if #pending > 0 then compileSome() end
end
local function mousePress(x, y, b, overUi)
    if not on or Spring.IsGUIHidden() then return false end
    for _, r in ipairs(panelRects) do
        if x >= r[1] and x <= r[3] and y >= r[2] and y <= r[4] then return true end
    end
    if overUi or b ~= 1 or not model or prep then return false end
    return pickAt(x, y)
end

local function snapshot()
    local out = {loaded = model ~= nil, on = on, status = status, seq = seq, positions = 0, marks = 0, selected = nil,
        phase = options.phase, faction = viewerFaction(), legend = options.legend, compiled = false, pending = #pending,
        kinds = {}, items = {positions = {}}, card = nil, inspect = inspectLines, panels = {}}
    -- the card (and legend) boxes as last drawn, screen coordinates {x1, y1, x2, y2}
    for i, r in ipairs(panelRects) do out.panels[i] = {r[1], r[2], r[3], r[4]} end
    local m = model
    if not m then return out end
    out.compiled = prep == nil and #pending == 0
    out.positions, out.marks = #m.order, #m.marks
    out.territory = m.terrOk
    out.fieldFingerprint = m.fieldFp
    for _, mk in ipairs(m.marks) do out.kinds[mk.kind] = (out.kinds[mk.kind] or 0) + 1 end
    for _, i in ipairs(m.order) do
        local p, o = m.positions[i], m.openings[i]
        out.items.positions[#out.items.positions+1] = {index=i, name=p.name, label=p.label, sublabel=p.sublabel, source=p.source,
            ally=p.ally, n=p.n, x=p.x, z=p.z, opening = o ~= nil, class = o and o.class or nil,
            factory = o and factoryFor(o.class, out.faction) or nil, energy = o and o.energy or nil, next = o and o.fallbacks[1] or nil}
    end
    local sp = selected and m.positions[selected]
    out.selected = sp and sp.name or nil
    if card then
        local text = {}
        for _, l in ipairs(card.lines) do text[#text+1] = (l[1] ~= "" and (l[1] .. ": ") or "") .. l[2] end
        out.card = {name=card.name, label=card.label, sublabel=card.sublabel, source=card.source, faction=card.faction,
            class=card.class, factory=card.factory, next=card.next, energy=card.energy, wind=card.wind, tidal=card.tidal,
            second=card.second, reasons=card.reasons, chosen=card.chosen, lines=text}
    end
    return out
end
local function config(data)
    if type(data) ~= "table" then return end
    if type(data.legend) == "boolean" then options.legend = data.legend end
    if type(data.phase) == "string" and PHASE_BY_KEY[data.phase] then options.phase = data.phase end
    if type(data.faction) == "string" and FACTION_NAME[data.faction] then options.faction = data.faction end
    if data.show == true then setMode(true) end
end
local function getConfig()
    return {show=on, legend=options.legend, phase=options.phase, faction=options.faction}
end
local function textCommand(cmd)
    if cmd == "barbmarks" then setMode(not on); return true end
    local sub = string.match(cmd, "^barbmarks%s+(.+)$")
    if not sub then return false end
    sub = string.match(sub, "^%s*(.-)%s*$")
    if sub == "show" or sub == "on" then setMode(true)
    elseif sub == "hide" or sub == "off" then setMode(false)
    elseif sub == "legend" then options.legend = not options.legend; if options.legend and not on then setMode(true) end
    else
        local ph = string.match(sub, "^phase%s+(%S+)$")
        local pos = string.match(sub, "^pos%s+(%S+)$")
        local fac = string.match(sub, "^faction%s+(%a+)$")
        if ph then
            if not setPhase(ph) then Spring.Echo("[BARb link] /barbmarks phase <0-5|5-15|15-25|25+|all>") end
        elseif pos then
            if not selectName(pos) then Spring.Echo("[BARb link] no landmarks position " .. pos) end
        elseif fac then
            if not setFaction(fac) then Spring.Echo("[BARb link] /barbmarks faction <armada|cortex|legion>") end
        else
            Spring.Echo("[BARb link] /barbmarks [show|hide|legend|phase <0-5|5-15|15-25|25+|all>|pos <name>|faction <armada|cortex|legion>]")
        end
    end
    return true
end
local function shutdown()
    disposeLists()
    on = false
end
return {SetMode=setMode, Mode=function() return on end, Status=function() return status end, Snapshot=snapshot,
    SetLegend=function(v) options.legend = v and true or false end, Legend=function() return options.legend end,
    SetPhase=setPhase, Phase=function() return options.phase end, Phases=function() return PHASE_KEYS end,
    SetFaction=setFaction, Faction=viewerFaction, Factions=function() return FACTIONS end,
    FactionName=function(f) return FACTION_NAME[f] or tostring(f) end,
    Select=selectName, SelectMine=selectMine, Step=step,
    SelectedName=function() local p = model and selected and model.positions[selected]; return p and p.name or nil end,
    SetField=function(api) fieldApi = api end, SetRosterProvider=function(fn) rosterProvider = fn end,
    SetMineProvider=function(fn) mineProvider = fn end,
    Config=config, GetConfig=getConfig, TextCommand=textCommand,
    Update=update, DrawWorld=drawWorld, DrawScreen=drawScreen, DrawMiniMap=drawMiniMap, Shutdown=shutdown,
    MousePress=mousePress}
end)()

-- ---------------------------------------------------------------- wiring (D-498)
-- The window, the tile, the providers the landmarks card reads, and the
-- callins. The modules above are the team link's, unchanged.
local MAP_ID, MAP_ORDER = "barbmap", 30
local MAP_W, MAP_H = 340, 300
local VIEWS = { "terrain", "approaches", "positions" }
local panel = nil
local saved = nil            -- this widget's own saved settings, if any
local legacyTaken = false
local dataRequests = {}      -- owner -> true: another widget needs the terrain model (BARb plans' strategy)

local function hub()
	local h = WG.barb
	if h and (h.version or 0) >= 1 then return h end
	return nil
end

local function overUi(mx, my)
	local h = hub()
	if h then return h.OverAnyPanel(mx, my) end
	return false
end

local function drawBody(P, left, right, top, bottom)
	local I = P.ICON
	local y = top
	y = P.buttonRow(left, right, y, "Terrain", {
		{ I.overlay, "Show", "fieldShow", function() field.SetMode(true) end,
			"Show the terrain map: ground classes, land masses, seas, ponds, crossings, cliffs, summits (/barbterrain)", field.Mode() },
		{ I.team, "Legend", "fieldLegend", function()
			field.SetLegend(not field.Legend()); if field.Legend() and not field.Mode() then field.SetMode(true) end
		end, "Open or close the legend panel: layers, terrain shown / dim / off, detail, focus", field.Legend() },
		{ I.close, "Hide", "fieldOff", function() field.SetMode(false) end, "Hide the terrain map and restore the view", not field.Mode() },
	})
	y = P.statusLine(left, right, y, field.Status(), nil, "fieldStatus")
	local views = {}
	for _, view in ipairs(VIEWS) do
		views[#views + 1] = { nil, view, "analysis_" .. view, function()
			marks.SetMode(false)
			local cfg = field.GetConfig(); cfg.view = view; cfg.preset = "Custom"; field.Config(cfg); field.SetMode(true)
		end, "Configure " .. view .. " in Map Analysis", field.Mode() and field.View() == view }
	end
	y = P.buttonRow(left, right, y - P.px(2), "Views", views)
	P.divider(left, right, y - P.px(2))
	y = y - P.px(8)
	y = P.buttonRow(left, right, y, "Landmarks", {
		{ I.overlay, "Show", "marksShow", function() marks.SetMode(true) end,
			"Show start positions, territories, landmarks by phase and the opening card (/barbmarks)", marks.Mode() },
		{ I.team, "Legend", "marksLegend", function()
			marks.SetLegend(not marks.Legend()); if marks.Legend() and not marks.Mode() then marks.SetMode(true) end
		end, "Open or close the landmarks legend", marks.Legend() },
		{ I.close, "Hide", "marksOff", function() marks.SetMode(false) end, "Hide the landmarks", not marks.Mode() },
	})
	y = P.statusLine(left, right, y, marks.Status(), nil, "marksStatus")
	-- phase window and faction, as chips
	local font, font2 = P.Fonts()
	P.text(font2, "Phase", left, y - P.px(12), P.px(9), "o", P.C.onSurfaceVariant)
	local cx = left + P.px(64)
	for _, key in ipairs(marks.Phases() or {}) do
		if cx > right - P.px(30) then break end
		cx = P.chip(cx, y - P.px(17), P.px(17), key, "phase_" .. key, function() marks.SetPhase(key); if not marks.Mode() then marks.SetMode(true) end end,
			"Landmarks of the " .. key .. " phase window", marks.Phase() == key, nil, right - cx) + P.px(4)
	end
	y = y - P.px(23)
	P.text(font2, "Faction", left, y - P.px(12), P.px(9), "o", P.C.onSurfaceVariant)
	cx = left + P.px(64)
	for _, f in ipairs(marks.Factions() or {}) do
		cx = P.chip(cx, y - P.px(17), P.px(17), marks.FactionName(f), "faction_" .. f, function() marks.SetFaction(f) end,
			"Opening cards for " .. marks.FactionName(f), marks.Faction() == f, nil, right - cx) + P.px(4)
	end
	y = y - P.px(23)
	if field.Mode() and marks.Mode() then
		P.statusLine(left, right, y, "Landmarks are hidden while the terrain map is shown.", P.C.warn)
	end
end

local function ensurePanel()
	if panel then return panel end
	local h = hub()
	if not h then return nil end
	panel = h.NewPanel({
		id = MAP_ID, order = MAP_ORDER, widget = widget, title = "Map", icon = "icons/radar_t2.png", fallback = "M",
		width = MAP_W, height = MAP_H, shortcut = "Ctrl+Alt+T",
		subtitle = function() return field.Mode() and "terrain" or (marks.Mode() and "landmarks" or nil) end,
		tooltipClosed = "BARb map: terrain classes, seas, chokes, summits, landmarks and opening cards (Ctrl+Alt+T)",
		tooltipOpen = "Close the BARb map window (Ctrl+Alt+T)",
		draw = drawBody,
	})
	if saved and saved.panel then panel.SetConfig(saved.panel) end
	-- the first time after the split: the settings the single widget saved
	if not legacyTaken and not (saved and saved.field) then
		legacyTaken = true
		local f, m = h.LegacyConfig("field"), h.LegacyConfig("marks")
		if f then field.Config(f) end
		if m then marks.Config(m) end
	end
	return panel
end

function widget:Initialize()
	-- the landmarks card reads the terrain module's grid and fingerprint, the roster's
	-- starts and factories (the card's Chosen line), and the viewer's own start (Mine)
	field.SetAllyProvider(function() local h = hub(); return h and h.SelectedAlly() or nil end)
	marks.SetField(field)
	marks.SetRosterProvider(function()
		local out = {}
		local h = hub()
		if not h then return out end
		for _, t in ipairs(h.Teams()) do
			local r = t.roster
			if r then out[#out + 1] = { teamId = t.id, allyTeam = t.allyTeam, role = r.role, side = r.side, factory = r.factory, x = r.x, z = r.z } end
		end
		return out
	end)
	marks.SetMineProvider(function()
		if not Spring.GetSpectatingState() then
			local x, _, z = Spring.GetTeamStartPosition(Spring.GetMyTeamID())
			if x and (x > 0 or z > 0) then return x, z end
		end
		local h = hub()
		local sel = h and h.Selected()
		if sel then
			for _, t in ipairs(h.Teams()) do
				if t.id == sel and t.roster then return t.roster.x, t.roster.z end
			end
		end
		return nil, nil
	end)
	if saved then
		if saved.field then field.Config(saved.field) end
		if saved.marks then marks.Config(saved.marks) end
	end
	WG.barbmap = {
		version = 1,
		IsOpen = function() return panel ~= nil and panel.open end,
		SetOpen = function(v) local p = ensurePanel(); if p then p.SetOpen(v) end end,
		ButtonRect = function(id)
			local r = field.ButtonRect(id)
			if r then return r end
			return panel and panel.ButtonRect(id) or nil
		end,
		MousePress = function(x, y, b) return widget:MousePress(x, y, b) end,
		MouseRelease = function(x, y, b) return widget:MouseRelease(x, y, b) end,
		MouseMove = function(x, y, dx, dy, b) return widget:MouseMove(x, y, dx, dy, b) end,
		-- the terrain model for BARb plans' strategy view
		Model = function() return field.Model() end,
		Status = function() return field.Status() end,
		RequestData = function(owner, on) dataRequests[owner] = on and true or nil end,
		-- tools/playtest (forwarded by WG.barblink)
		SetField = function(v) return field.SetMode(v) end,
		FieldStatus = field.Status, FieldSnapshot = field.Snapshot, FieldOptions = field.Config, FieldConfig = field.GetConfig,
		FieldLayer = field.SetLayer, FieldFocus = field.SetFocus, FieldBlueprint = field.SetBlueprint,
		FieldLegend = field.SetLegend, FieldSide = field.SetSide,
		MarksShow = function(v) return marks.SetMode(v) end, MarksStatus = marks.Status, MarksSnapshot = marks.Snapshot,
		MarksPhase = function(p) return marks.SetPhase(p) end, MarksSelect = function(name) return marks.Select(name) end,
		MarksFaction = function(f) return marks.SetFaction(f) end, MarksLegend = function(v) marks.SetLegend(v) end,
	}
end

function widget:Shutdown()
	field.Shutdown()
	marks.Shutdown()
	if panel then panel.Remove() end
	WG.barbmap = nil
end

function widget:GetConfigData()
	return { panel = panel and panel.GetConfig() or (saved and saved.panel), field = field.GetConfig(), marks = marks.GetConfig() }
end

function widget:SetConfigData(data)
	if type(data) == "table" then saved = data end
end

function widget:Update()
	ensurePanel()
	field.Update(next(dataRequests) ~= nil)
	marks.Update()
end

function widget:DrawWorld()
	field.DrawWorld()
	if not field.Mode() then marks.DrawWorld() end
end

function widget:DrawInMiniMap(sx, sy)
	field.DrawMiniMap(sx, sy)
	marks.DrawMiniMap(sx, sy)
end

function widget:DrawScreen()
	local p = ensurePanel()
	field.DrawScreen(p and p.WindowRect() or nil)
	if not field.Mode() then marks.DrawScreen() end
	if p then p.Draw() end
end

function widget:IsAbove(mx, my) return panel ~= nil and panel.IsAbove(mx, my) end
function widget:GetTooltip(mx, my) return panel and panel.GetTooltip(mx, my) or nil end

function widget:MousePress(mx, my, mb)
	if field.MousePress(mx, my, mb) then return true end
	-- landmarks: clicks on its panels are kept from the game; a left click on a position
	-- disc or a mark (never under a BARb window) selects or inspects it
	if marks.MousePress(mx, my, mb, overUi(mx, my)) then return true end
	return panel ~= nil and panel.MousePress(mx, my, mb)
end

function widget:MouseMove(mx, my, dx, dy, mb)
	if field.MouseMove(mx, my) then return end
	if panel then panel.MouseMove(mx, my) end
end

function widget:MouseRelease(mx, my, mb)
	if field.MouseRelease(mx, my, mb) then return false end
	if panel then panel.MouseRelease(mx, my, mb) end
	return false
end

function widget:TextCommand(cmd)
	if field.TextCommand(cmd) then return true end
	if marks.TextCommand(cmd) then return true end
	if cmd == "barbmap" then local p = ensurePanel(); if p then p.Toggle() end; return true end
	return false
end

function widget:KeyPress(key, mods, isRepeat)
	if key == 116 and mods.ctrl and mods.alt and not isRepeat then   -- t
		local p = ensurePanel(); if p then p.Toggle() end
		return true
	end
	if key == 27 and panel and panel.open then
		local mx, my = Spring.GetMouseState()
		if panel.IsAbove(mx, my) then panel.SetOpen(false); return true end
	end
	return false
end

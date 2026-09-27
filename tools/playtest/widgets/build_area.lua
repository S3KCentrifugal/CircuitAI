-- Playtest survey: what can be built where, before anything is built. At frame
-- 30 every CELL-elmo cell of the map is tested with the engine's own build test
-- (Spring.TestBuildOrder) for a construction turret, a T1 bot lab and an
-- advanced fusion, and the grid is written to the infolog as "[BuildArea]" rows
-- for tools/playtest/build_area.py to render and measure. One character a cell:
--   w  water under 15 deep (nothing floats)
--   ~  water 15 to 25 deep (floating converters, turrets)
--   W  water 25+ deep (naval fusion; 30+ shipyards)
--   #  land nothing of ours builds on (slope, cliff)
--   n  a turret fits (features such as trees count as reclaimable)
--   L  a T1 bot lab fits (centred on the cell)
--   A  an advanced fusion fits (implies L)
-- Staged by: playtest.py run --extra-widget tools/playtest/widgets/build_area.lua

function widget:GetInfo()
	return {
		name    = "BARb build area survey",
		desc    = "tools/playtest: the map's buildable ground, cell by cell",
		author  = "s3k-CircuitAI",
		date    = "2026-09-27",
		layer   = 10,
		enabled = true,
	}
end

local CELL = 64
local done = false

local function def(names)
	for _, n in ipairs(names) do
		local ud = UnitDefNames[n]
		if ud then return ud.id end
	end
end

local function test(udid, x, z)
	if not udid then return 0 end
	local y = Spring.GetGroundHeight(x, z)
	return Spring.TestBuildOrder(udid, x, y, z, 0) or 0
end

function widget:GameFrame(f)
	if done or f < 30 then return end
	done = true
	local nano = def({ "armnanotc" })
	local lab = def({ "armlab" })
	local afus = def({ "armafus" })
	local w, h = Game.mapSizeX, Game.mapSizeZ
	Spring.Echo(string.format("[BuildArea] begin %d %d %d", w, h, CELL))
	Spring.Echo(string.format("[BuildArea] tidal %.1f wind %.1f to %.1f", Game.tidal or -1, Game.windMin or -1, Game.windMax or -1))
	for z = CELL / 2, h, CELL do
		local row = {}
		for x = CELL / 2, w, CELL do
			local c
			local tn = test(nano, x, z)
			if tn == 0 then
				local gh = Spring.GetGroundHeight(x, z)
				if gh >= 0 then c = "#"
				elseif gh > -15 then c = "w"      -- too shallow for anything floating
				elseif gh > -25 then c = "~"      -- floating converters and turrets (15+)
				else c = "W" end                  -- naval fusion (25+), shipyards (30+)
			else
				-- 2: features (trees, rocks) in the way, buildable once reclaimed
				c = "n"
				if test(lab, x, z) >= 2 then
					c = "L"
					if test(afus, x, z) >= 2 then c = "A" end
				end
			end
			row[#row + 1] = c
		end
		Spring.Echo("[BuildArea] r " .. table.concat(row))
	end
	Spring.Echo("[BuildArea] end")
end

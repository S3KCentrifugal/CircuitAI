-- Playtest census: every 5 game minutes, how many of each watched unit type
-- every team has alive (D-119: the caps on T2 construction bots and fast assist
-- bots, and the fast assault bots the advanced bot lab makes instead). Every
-- line is "[Census] ...".
--
-- Staged by: playtest.py run --extra-widget tools/playtest/widgets/unit_census.lua

function widget:GetInfo()
	return {
		name    = "BARb unit census",
		desc    = "tools/playtest: live counts of watched unit types per team",
		author  = "s3k-CircuitAI",
		date    = "2026-09-26",
		layer   = 10,
		enabled = true,
	}
end

local FPS = 30
local EVERY = 5 * 60 * FPS
-- label -> unit names (all factions)
local WATCH = {
	{ "t2con",   { "armack", "corack", "legack" } },
	{ "assist",  { "armfark", "corfast", "legaceb" } },
	{ "assault", { "armfast", "corpyro", "legstr" } },
	{ "t1lab",   { "armlab", "corlab", "leglab" } },
	{ "gantry",  { "armshltx", "corgant", "leggant" } },
	{ "nano",    { "armnanotc", "cornanotc", "legnanotc" } },
	{ "spam",    { "armpw", "corak", "leggob", "armflea", "corfav" } },
}
local defLabel = {}
for _, w in ipairs(WATCH) do
	for _, n in ipairs(w[2]) do
		local ud = UnitDefNames[n]
		if ud then defLabel[ud.id] = w[1] end
	end
end

function widget:GameFrame(f)
	if f == 0 or f % EVERY ~= 0 then return end
	for _, team in ipairs(Spring.GetTeamList() or {}) do
		local c = {}
		for _, u in ipairs(Spring.GetTeamUnits(team) or {}) do
			local l = defLabel[Spring.GetUnitDefID(u) or -1]
			if l then
				local _, _, _, _, bp = Spring.GetUnitHealth(u)
				if (bp or 1) >= 1 then c[l] = (c[l] or 0) + 1 end
			end
		end
		local busy = 0
		for _, u in ipairs(Spring.GetTeamUnits(team) or {}) do
			if defLabel[Spring.GetUnitDefID(u) or -1] == "t1lab" and Spring.GetUnitIsBuilding(u) then busy = busy + 1 end
		end
		local parts = {}
		for _, w in ipairs(WATCH) do parts[#parts + 1] = w[1] .. "=" .. (c[w[1]] or 0) end
		parts[#parts + 1] = "t1busy=" .. busy
		Spring.Echo(string.format("[Census] %.0f min team %d: %s", f / (60 * FPS), team, table.concat(parts, " ")))
	end
end

-- Playtest stats: how each team plays, for comparing the role under test (team
-- 0) with its allies. Every 2 game minutes, per team: metal income, the damage
-- it dealt and took, units it killed, the metal value of its combat army
-- (mobile units that are not builders) and of what it has produced. Also the
-- first minute team 0's metal income reaches each MILESTONE. Lines:
--   [TeamStats] <min> team <id> ally <a> ...
--   [TeamStats] milestone team 0 +<n> metal at <min> min
-- Staged by: playtest.py run --extra-widget tools/playtest/widgets/team_stats.lua

function widget:GetInfo()
	return {
		name    = "BARb team stats",
		desc    = "tools/playtest: per-team income, damage, kills and army value",
		author  = "s3k-CircuitAI",
		date    = "2026-09-27",
		layer   = 10,
		enabled = true,
	}
end

local FPS = 30
local EVERY = 2 * 60 * FPS
local MILESTONES = { 100, 200, 250, 500, 750, 1000, 1500 }
local reached = {}

local combatCost = {}
for id, ud in pairs(UnitDefs) do
	if ud.canMove and not ud.isBuilder and (ud.weapons and #ud.weapons > 0) then
		combatCost[id] = ud.metalCost or 0
	end
end

local function army(team)
	local m, n = 0, 0
	for _, u in ipairs(Spring.GetTeamUnits(team) or {}) do
		local c = combatCost[Spring.GetUnitDefID(u) or -1]
		if c then
			local _, _, _, _, bp = Spring.GetUnitHealth(u)
			if (bp or 1) >= 1 then m = m + c; n = n + 1 end
		end
	end
	return m, n
end

local function stats(team)
	local len = Spring.GetTeamStatsHistory(team) or 0
	if len < 1 then return nil end
	local h = Spring.GetTeamStatsHistory(team, len)
	return h and h[1]
end

function widget:GameFrame(f)
	if f % (10 * FPS) == 0 then
		local _, _, _, income = Spring.GetTeamResources(0, "metal")
		for _, m in ipairs(MILESTONES) do
			if not reached[m] and (income or 0) >= m then
				reached[m] = true
				Spring.Echo(string.format("[TeamStats] milestone team 0 +%d metal at %.1f min", m, f / (60 * FPS)))
			end
		end
	end
	if f == 0 or f % EVERY ~= 0 then return end
	local minute = f / (60 * FPS)
	for _, team in ipairs(Spring.GetTeamList() or {}) do
		local _, _, dead, _, _, allyTeam = Spring.GetTeamInfo(team, false)
		local _, _, _, income = Spring.GetTeamResources(team, "metal")
		local s = stats(team)
		local am, an = army(team)
		if s then
			Spring.Echo(string.format("[TeamStats] %.0f team %d ally %d%s: metal +%.0f, dealt %.0f, taken %.0f, killed %d, army %d units %.0f metal, produced %d units, used %.0f metal",
				minute, team, allyTeam or -1, dead and " dead" or "", income or 0, s.damageDealt or 0, s.damageReceived or 0,
				s.unitsKilled or 0, an, am, s.unitsProduced or 0, s.metalUsed or 0))
		end
	end
end

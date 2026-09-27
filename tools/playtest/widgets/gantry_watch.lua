-- Playtest watcher: the first land gantry a TECH AI finishes (any TECH team,
-- from the BARb team link widget's roster; team 0 without it). Screenshots of it, then a resource and build power log every 30 s,
-- and the time every unit it produces takes. Every line is "[Gantry] ...".
--
-- Staged by: playtest.py run --extra-widget tools/playtest/widgets/gantry_watch.lua
-- (with --shots "" so the camera widget does not move the camera too).

function widget:GetInfo()
	return {
		name    = "BARb gantry watch",
		desc    = "tools/playtest: the first TECH gantry, its build power and T3 production times",
		author  = "s3k-CircuitAI",
		date    = "2026-09-26",
		layer   = 10,
		enabled = true,
	}
end

local FPS = 30
local TEAM = 0   -- set to the gantry's team when it finishes
local GANTRIES = { armshltx = true, corgant = true, leggant = true }
local REPORT_FRAMES = 30 * FPS
local SHOT_HEIGHT = 1300

local gantryId, gantryPos, gantryFrame = nil, nil, nil
local building = {}        -- unitID -> { frame, name, metal, buildTime }
local produced = 0
local lastReport = -1
local pendingShot = nil    -- { frame, why }
local unitShotDone = false
local nanoDefs = {}

for id, ud in pairs(UnitDefs) do
	if ud.isBuilder and not ud.canMove and not ud.isFactory and (ud.buildSpeed or 0) > 0 then nanoDefs[id] = ud end
end

local function echo(s) Spring.Echo("[Gantry] " .. s) end
local function minutes(n) return n / (60 * FPS) end

local function shoot(why)
	if not gantryPos then return end
	Spring.SendCommands("viewta")
	Spring.SetCameraTarget(gantryPos[1], gantryPos[2], gantryPos[3], 0)
	Spring.SetCameraState({ height = SHOT_HEIGHT, dist = SHOT_HEIGHT }, 0)
	pendingShot = { frame = Spring.GetGameFrame() + 6, why = why }
end

local function buildPower(n)
	local gx, _, gz = gantryPos[1], gantryPos[2], gantryPos[3]
	local target = Spring.GetUnitIsBuilding(gantryId)
	local nanos, assisting, nanoBP, assistBP = 0, 0, 0, 0
	for _, u in ipairs(Spring.GetTeamUnits(TEAM) or {}) do
		local d = Spring.GetUnitDefID(u)
		local ud = d and nanoDefs[d]
		if ud then
			local x, _, z = Spring.GetUnitPosition(u)
			local reach = (ud.buildDistance or 0) + 100   -- the gantry's radius, roughly
			if x and (x - gx) ^ 2 + (z - gz) ^ 2 <= reach * reach then
				nanos = nanos + 1
				nanoBP = nanoBP + (ud.buildSpeed or 0)
				local b = Spring.GetUnitIsBuilding(u)
				if target and b == target then
					assisting = assisting + 1
					assistBP = assistBP + (ud.buildSpeed or 0)
				end
			end
		end
	end
	local gud = UnitDefs[Spring.GetUnitDefID(gantryId)]
	local m, ms, mp, mi = Spring.GetTeamResources(TEAM, "metal")
	local e, es, ep, ei = Spring.GetTeamResources(TEAM, "energy")
	local tname = target and UnitDefs[Spring.GetUnitDefID(target)] and UnitDefs[Spring.GetUnitDefID(target)].name or "nothing"
	local _, _, _, _, prog = Spring.GetUnitHealth(target or gantryId)
	echo(string.format("%.1f min: metal +%.1f (pull %.1f) bank %d/%d, energy +%.1f (pull %.1f) bank %d/%d; gantry %d BP building %s (%.0f%%); turrets in reach %d (%d BP), assisting %d (%d BP); total on the build %d BP",
		minutes(n), mi or 0, mp or 0, m or 0, ms or 0, ei or 0, ep or 0, e or 0, es or 0, gud and gud.buildSpeed or 0, tname,
		(target and prog or 0) * 100, nanos, nanoBP, assisting, assistBP, (gud and gud.buildSpeed or 0) + assistBP))
end

function widget:UnitFinished(unitID, unitDefID, unitTeam)
	local ud = UnitDefs[unitDefID]
	if not ud then return end
	local n = Spring.GetGameFrame()
	local roster = WG.barblink and WG.barblink.Roster and WG.barblink.Roster() or nil
	local isTech = (roster and roster[unitTeam] and roster[unitTeam].role == "TECH") or (not roster and unitTeam == 0)
	if isTech and not gantryId and GANTRIES[ud.name] then
		TEAM = unitTeam
		gantryId = unitID
		local x, y, z = Spring.GetUnitPosition(unitID)
		gantryPos = { x, y, z }
		gantryFrame = n
		echo(string.format("first TECH gantry %s %d (team %d) finished at %.2f min at (%d, %d)", ud.name, unitID, unitTeam, minutes(n), x, z))
		shoot("the gantry finished")
		buildPower(n)
		lastReport = n
		return
	end
	local b = building[unitID]
	if b then
		building[unitID] = nil
		produced = produced + 1
		echo(string.format("unit %d: %s finished at %.2f min: took %.0f s (%d metal, %d energy, build time %d); started at %.2f min",
			produced, b.name, minutes(n), (n - b.frame) / FPS, b.metal, b.energy, b.buildTime, minutes(b.frame)))
		if not unitShotDone then unitShotDone = true; shoot("its first unit finished") end
	end
end

function widget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	if not gantryId or builderID ~= gantryId then return end
	local ud = UnitDefs[unitDefID]
	if not ud then return end
	building[unitID] = { frame = Spring.GetGameFrame(), name = ud.name, metal = ud.metalCost or 0, energy = ud.energyCost or 0, buildTime = ud.buildTime or 0 }
	echo(string.format("gantry started %s (%d metal, build time %d) at %.2f min", ud.name, ud.metalCost or 0, ud.buildTime or 0, minutes(Spring.GetGameFrame())))
end

function widget:UnitDestroyed(unitID)
	if unitID == gantryId then
		echo(string.format("the gantry was destroyed at %.2f min", minutes(Spring.GetGameFrame())))
		gantryId = nil
	end
	building[unitID] = nil
end

function widget:GameFrame(n)
	if pendingShot and n >= pendingShot.frame then
		Spring.SendCommands("screenshot png")
		echo(string.format("screenshot at %.2f min: %s", minutes(n), pendingShot.why))
		pendingShot = nil
	end
	if gantryId and n - lastReport >= REPORT_FRAMES then
		lastReport = n
		buildPower(n)
	end
end

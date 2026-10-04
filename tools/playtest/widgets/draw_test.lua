-- Playtest driver: the AI draws on the map (barb|draw), a screenshot of it,
-- then the AI clears it and a second screenshot shows the map clean. Uses the
-- whole-map overview camera. Every line is "[DrawTest] ...".
function widget:GetInfo()
	return {
		name    = "BARb draw test",
		desc    = "tools/playtest: the AI's map drawing, drawn, shot, cleared, shot",
		author  = "s3k-CircuitAI",
		date    = "2026-09-26",
		layer   = 10,
		enabled = true,
	}
end

local TEAM = 0
local STEPS = {
	{ frame = 300, act = "draw" },
	{ frame = 306, act = "overview" },
	{ frame = 540, act = "shot", why = "the commander drawn" },   -- the AI sends 20 lines a second
	{ frame = 570, act = "clear" },
	{ frame = 780, act = "shot", why = "after clear" },
	{ frame = 786, act = "overview" },
}
local nextStep = 1

local function echo(s) Spring.Echo("[DrawTest] " .. s) end

function widget:GameFrame(n)
	local s = STEPS[nextStep]
	if not s or n < s.frame then return end
	nextStep = nextStep + 1
	if s.act == "draw" then
		local ok = Spring.SendSkirmishAIMessage(TEAM, "barb|draw|" .. TEAM .. "|commander")
		echo("draw sent to team " .. TEAM .. ": " .. tostring(ok))
	elseif s.act == "clear" then
		local ok = Spring.SendSkirmishAIMessage(TEAM, "barb|draw|" .. TEAM .. "|clear")
		echo("clear sent to team " .. TEAM .. ": " .. tostring(ok))
	elseif s.act == "overview" then
		Spring.SendCommands("toggleoverview")
		echo("overview toggled")
	elseif s.act == "shot" then
		Spring.SendCommands("screenshot png")
		echo("screenshot: " .. s.why)
	end
end

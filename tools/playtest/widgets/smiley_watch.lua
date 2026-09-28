-- Playtest watcher for D-124: the smiley face an AI draws over a nuke's target.
-- After MIN_FRAME the AI draws nothing else, so a burst of map lines is a
-- smiley: the camera goes over the burst's centre and a screenshot is taken
-- when the burst has settled. Every line is "[Smiley] ...".
-- Staged by: playtest.py run --extra-widget tools/playtest/widgets/smiley_watch.lua (with --shots "")

function widget:GetInfo()
	return {
		name    = "BARb smiley watch",
		desc    = "tools/playtest: screenshots of the AI's nuke smileys",
		author  = "s3k-CircuitAI",
		date    = "2026-09-27",
		layer   = 10,
		enabled = true,
	}
end

local MIN_FRAME = 15 * 60 * 30
local SETTLE = 90            -- frames with no new line: the face is drawn
local HEIGHT = 2600
local burst = nil            -- { n, sx, sz, last }
local pendingShot = nil
local shots = 0

local function echo(s) Spring.Echo("[Smiley] " .. s) end

function widget:MapDrawCmd(playerID, cmdType, x, y, z, a, b, c)
	if cmdType ~= "line" or Spring.GetGameFrame() < MIN_FRAME then return end
	local f = Spring.GetGameFrame()
	if not burst then burst = { n = 0, sx = 0, sz = 0, last = f } end
	burst.n = burst.n + 1
	burst.sx = burst.sx + x
	burst.sz = burst.sz + z
	burst.last = f
end

function widget:GameFrame(f)
	if pendingShot and f >= pendingShot then
		Spring.SendCommands("screenshot png")
		pendingShot = nil
		shots = shots + 1
		echo("screenshot " .. shots)
	end
	if burst and f - burst.last >= SETTLE then
		local cx, cz = burst.sx / burst.n, burst.sz / burst.n
		echo(string.format("a drawing of %d lines around (%d, %d) at %.1f min", burst.n, cx, cz, f / 1800))
		Spring.SetCameraTarget(cx, Spring.GetGroundHeight(cx, cz), cz, 0)
		Spring.SetCameraState({ height = HEIGHT, dist = HEIGHT }, 0)
		pendingShot = f + 6
		burst = nil
	end
end

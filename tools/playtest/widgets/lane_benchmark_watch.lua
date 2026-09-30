function widget:GetInfo()
    return {name="Lane worker benchmark",desc="Requests all-player surveys without gameplay orders",author="CircuitAI",layer=110,enabled=true}
end
local config=VFS.Include("LuaUI/Config/scorecard_run.lua")
function widget:GameFrame(frame)
    -- Initial all-player survey, duplicate requests while queued, then a refresh
    -- after the normal cooldown. Non-TECH completion is part of this test.
    if frame==1800 or frame==1830 or frame==7200 then
        for _,team in ipairs(config.teams) do
            Spring.SendSkirmishAIMessage(team,"barb|theatres|"..team.."|refresh")
        end
        Spring.Echo("[LaneBenchmark] requested all players frame="..frame.." teams="..#config.teams)
    end
end

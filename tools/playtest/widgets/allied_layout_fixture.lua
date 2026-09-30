function widget:GetInfo()
    return {name="Allied layout fixture",desc="Physical blockers for unused AIR/TECH clusters",author="CircuitAI",layer=120,enabled=true}
end
local queue={}
local prior,handler
local function receive(team,text)
    local x,z=text:match("^barb|layoutprobe|%d+|%d+|block|([^|]+)|([^|]+)$")
    if x then
        x,z=tonumber(x),tonumber(z)
        queue[#queue+1]={team=team,x=x,z=z}
    end
end
function widget:Initialize()
    local global=getfenv(0)
    prior=rawget(global,"RecvSkirmishAIMessage")
    handler=function(team,text)
        receive(team,text)
        if prior then return prior(team,text) end
    end
    rawset(global,"RecvSkirmishAIMessage",handler)
    Script.UpdateCallIn("RecvSkirmishAIMessage")
    Spring.Echo("[LayoutProbe] physical blocker fixture enabled")
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    if f%30==0 and #queue>0 then
        local p=table.remove(queue,1)
        Spring.SendCommands("give armdrag "..p.team.." @"..p.x..","..Spring.GetGroundHeight(p.x,p.z)..","..p.z)
        Spring.Echo("[LayoutProbe] inject blocker team="..p.team.." at="..p.x..","..p.z)
    end
end
function widget:UnitFinished(id,def,team)
    if UnitDefs[def].name=="armdrag" then Spring.Echo("[LayoutProbe] physical wall exists team="..team.." id="..id) end
end
function widget:Shutdown()
    local global=getfenv(0)
    if rawget(global,"RecvSkirmishAIMessage")==handler then
        rawset(global,"RecvSkirmishAIMessage",prior); Script.UpdateCallIn("RecvSkirmishAIMessage")
    end
end

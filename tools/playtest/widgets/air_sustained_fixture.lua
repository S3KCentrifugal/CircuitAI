function widget:GetInfo()
    return {name="AIR sustained income fixture",desc="Income gate with metal bank held below lab cost",author="CircuitAI",layer=122,enabled=true}
end
local queue={}
local function give(name,x,z,count)
    queue[#queue+1]="give "..count.." "..name.." 0 @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
function widget:Initialize()
    Spring.Echo("[SustainedFixture] controlled income; injected assets and bank sharing are not natural-game evidence")
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1","team 0") end
    if f==900 then
        local x,_,z=Spring.GetTeamStartPosition(0)
        give("corfus",x+1600,z-1000,12)
        give("cormmkr",x+1600,z-500,8)
        give("corestor",x+1100,z-200,4)
    end
    if #queue>0 and f%30==0 then Spring.SendCommands(table.remove(queue,1)) end
    if f>=330 and f%30==0 then
        local bank,_,_,income=Spring.GetTeamResources(0,"metal")
        if bank>1000 then Spring.ShareResources(1,"metal",bank-1000) end
        if f%900==0 then
            Spring.Echo("[SustainedFixture] bank="..math.floor(bank).." income="..math.floor(income).." player-team="..Spring.GetMyTeamID())
        end
    end
end
function widget:UnitFinished(id,def,team)
    if team==0 and UnitDefs[def].name=="coraap" then
        Spring.Echo("[SustainedFixture] finished coraap frame="..Spring.GetGameFrame())
    end
end

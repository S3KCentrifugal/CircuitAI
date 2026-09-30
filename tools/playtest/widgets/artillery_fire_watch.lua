-- Isolated firing fixture: these are gifted cannons, not a natural build test.
function widget:GetInfo()
    return {name="Artillery firing regression",desc="All three super cannons and their first-shot drawings",author="CircuitAI",layer=112,enabled=true}
end
local pending = {}
local function give(name,team,x,z,count)
    pending[#pending+1]="give "..(count and (count.." ") or "")..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
local lines=0
function widget:MapDrawCmd(_,kind)
    if kind=="line" and Spring.GetGameFrame()>=3600 then lines=lines+1 end
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    if f==600 then
        give("armafus",0,1800,9700,25)
        give("armuwadves",0,2200,9700,30)
        give("armvulc",0,1200,9000)
        give("corbuzz",0,1200,9800)
        give("legstarfall",0,1200,9400)
        Spring.Echo("[ArtilleryFixture] gifting three cannons and energy; staged probe will force a native ground aim")
    end
    if f>600 and f%30==0 and #pending>0 then Spring.SendCommands(table.remove(pending,1)) end
    if f==3600 then
        for _,id in ipairs(Spring.GetTeamUnits(0)) do
            local d=UnitDefs[Spring.GetUnitDefID(id)]
            if d and (d.name=="armvulc" or d.name=="corbuzz" or d.name=="legstarfall") then
                Spring.SendSkirmishAIMessage(0,"artillery-aim|"..id)
            end
        end
    end
    if f%900==0 and f>=1800 then
        local count=0
        for _,id in ipairs(Spring.GetTeamUnits(0)) do
            local d=UnitDefs[Spring.GetUnitDefID(id)]
            if d and (d.name=="armvulc" or d.name=="corbuzz" or d.name=="legstarfall") then count=count+1 end
        end
        local energy,storage=Spring.GetTeamResources(0,"energy")
        Spring.Echo("[ArtilleryFixture] cannons="..count.." map-lines="..lines.." energy="..math.floor(energy).." storage="..math.floor(storage))
    end
end

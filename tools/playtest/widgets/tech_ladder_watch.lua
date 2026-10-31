function widget:GetInfo() return {name="TECH income ladder verification",layer=126,enabled=true} end
local created={}
local function give(name,x,z)
    Spring.SendCommands("give 1 "..name.." 0 @"..x..","..Spring.GetGroundHeight(x,z)..","..z)
end
function widget:GameFrame(frame)
    if frame==90 then Spring.SendCommands("cheat 1") end
    if frame==150 then Spring.SendSkirmishAIMessage(0,"tech-ladder|setup") end
    if frame==240 then
        give("corack",1400,10100)
    end
end
function widget:UnitCreated(id,def,team,builder)
    if team==0 and builder and UnitDefs[def].name=="corafus" then
        created[id]=true
        local x,_,z=Spring.GetUnitPosition(id)
        for i=0,11 do give("cornanotc",x-96+(i%4)*64,z+180+math.floor(i/4)*64) end
        Spring.Echo("[TechLadderTest] reactor_started id="..id)
    end
end
function widget:UnitFinished(id,def,team)
    if created[id] then Spring.Echo("[TechLadderTest] PASS reactor_completed id="..id) end
end

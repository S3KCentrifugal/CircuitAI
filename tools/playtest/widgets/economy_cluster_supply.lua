function widget:GetInfo() return {name="Economy cluster supplied regression",layer=126,enabled=true} end
local function give(name,x,z)
    Spring.SendCommands("give 1 "..name.." 0 @"..x..","..Spring.GetGroundHeight(x,z)..","..z)
end
function widget:GameFrame(f)
    if f==90 then Spring.SendCommands("cheat 1") end
    if f==150 then Spring.SendSkirmishAIMessage(0,"cluster-init") end
    if f==240 then
        for i=1,12 do give("corca",10984+i*20,1928) end
        for i=1,3 do give("coraca",11284+i*32,1928) end
        for i=1,4 do give("corafus",10484+i*128,1828) end
    end
end

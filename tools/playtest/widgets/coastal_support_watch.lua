function widget:GetInfo() return {name="Coastal support verification",layer=126,enabled=true} end
local function give(name,x,z)
    Spring.SendCommands("give 1 "..name.." 0 @"..x..","..Spring.GetGroundHeight(x,z)..","..z)
end
function widget:GameFrame(f)
    if f==90 then Spring.SendCommands("cheat 1") end
    if f==150 then Spring.SendSkirmishAIMessage(0,"coastal-init") end
    if f==240 then give("corcs",2800,320);give("coraca",2800,800);give("corck",2750,850) end
end

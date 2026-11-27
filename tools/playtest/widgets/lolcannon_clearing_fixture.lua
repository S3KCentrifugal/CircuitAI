function widget:GetInfo() return {name="Lolcannon clearing regression",layer=150,enabled=true} end
local function give(name,team,x,z)
 Spring.SendCommands("give 1 "..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z)
end
function widget:GameFrame(f)
 if f==150 then Spring.SendCommands({"cheat 1","globallos"}) end
 if f==300 then
  give("armllt",0,1008,6928)
  give("armsolar",1,1248,6928)
  give("armack",0,816,6928)
  give("armack",1,1400,7000)
 end
end
function widget:UnitCreated(id,def,team,builder)
 if builder and UnitDefs[def].name=="armdrag" and Spring.GetGameFrame()>=600 and Spring.GetGameFrame()<900 then
  Spring.Echo("[ClearingProbe] FAIL ordinary replacement actually built team="..team)
 end
end

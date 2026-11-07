function widget:GetInfo() return {name="TECH Air Foundry fixture",layer=115,enabled=true} end
local workers={}
local passed=false
local expected=6
local heavy,lab,plant
local probed=false
function widget:UnitFinished(id,def,team)
 if team~=0 then return end
 local name=UnitDefs[def].name
 if name=="armca" then workers[#workers+1]=id end
 if name=="armfboy" then heavy=id end
 if name=="armlab" then lab=id end
 if name=="armap" then plant=id end
end
function widget:GameFrame(f)
 if f==300 then Spring.SendCommands("cheat 1") end
 if f==600 then
  local x,_,z=Spring.GetTeamStartPosition(0)
  Spring.SendCommands("give armap 0 @"..(x+400)..",0,"..(z+400))
 end
 if f==750 then
  local x,_,z=Spring.GetTeamStartPosition(0)
  Spring.SendCommands("give armfboy 0 @"..(x+600)..",0,"..(z+500))
  Spring.SendCommands("give armlab 0 @"..(x+900)..",0,"..(z+500))
 end
 if f==900 then
  local x,_,z=Spring.GetTeamStartPosition(0)
  Spring.SendCommands("give 8 armca 0 @"..(x+400)..",300,"..(z+500))
 end
 if f>=3600 and not probed and #workers>=8 and heavy and lab then
  probed=true
  Spring.SendSkirmishAIMessage(0,"tech-ownership|"..expected.."|"..workers[8].."|"..heavy.."|"..lab)
 end
 if f>=1800 and f%150==0 and not passed and #workers>=8 then
  local guards=0
  for i=1,expected do
   local cmd,_,_,target=Spring.GetUnitCurrentCommand(workers[i])
   local def=target and Spring.ValidUnitID(target) and UnitDefs[Spring.GetUnitDefID(target)]
   if f%600==0 then Spring.Echo("[TechAirFoundryTest] sample worker="..workers[i].." cmd="..tostring(cmd).." target="..tostring(target).." def="..tostring(def and def.name)) end
   -- Native factory guard assists its live product with REPAIR while busy.
   -- Require this exact factory's current product, not any construction plane.
   local product=plant and Spring.GetUnitIsBuilding(plant)
   if (cmd==CMD.GUARD and target==plant) or (cmd==CMD.REPAIR and product and target==product) then guards=guards+1 end
  end
  if guards==expected then
   passed=true
   Spring.Echo("[TechAirFoundryTest] PASS guards="..expected.."; eight aircraft supplied")
  end
 end
end

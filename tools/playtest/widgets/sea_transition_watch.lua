function widget:GetInfo() return {name="SEA transition observer",layer=126,enabled=true} end
local cfg=VFS.Include("LuaUI/Config/sea_transition.lua")
local names={armada={"armsy","armasy","armplat","armcs","armuwfus","armnanotcplat"},
 cortex={"corsy","corasy","corplat","corcs","coruwfus","cornanotcplat"},
 legion={"legsy","legadvshipyard","legsplab","legnavyconship","leganavalfusion","legnanotcplat"}}
local n=names[cfg.side]
local first,t2,platform
local builtBy={}
local passed={}
local function log(s) Spring.Echo("[SeaTransition] "..s) end
local function pass(key,s) if not passed[key] then passed[key]=true;log("PASS "..s) end end
local function give(name,x,z)
 if not UnitDefNames[name] then log("FAIL missing fixture unit "..name);return end
 local y=Spring.GetGroundHeight(x,z)
 if y>=-30 then log("FAIL dry fixture "..name.." height="..y);return end
 Spring.SendCommands("give 1 "..name.." 0 @"..x..","..y..","..z)
end
function widget:UnitDestroyed(id)
 if id==platform then platform=nil end
 builtBy[id]=nil
end
function widget:GameFrame(f)
 if f==150 then Spring.SendCommands({"cheat 1","globallos"}) end
 if cfg.supplied~=false then
  if f==300 then give(n[1],5824,10736) end
  if f==330 then give(n[5],6400,11400) end
  if f==3600 then give(n[2],6600,10736) end
 end
 if f%150==0 and platform then
  local x,_,z=Spring.GetUnitPosition(platform)
  local count,assist=0,0
  for _,id in ipairs(Spring.GetTeamUnits(0)) do
   local d=UnitDefs[Spring.GetUnitDefID(id)]
   if d.name==n[6] then
    local nx,_,nz=Spring.GetUnitPosition(id)
    local _,_,_,_,bp=Spring.GetUnitHealth(id)
    if bp==1 and (nx-x)^2+(nz-z)^2<=d.buildDistance^2 then
     count=count+1
     local cmd,_,_,target=Spring.GetUnitCurrentCommand(id)
     if (cmd==CMD.REPAIR or cmd==CMD.GUARD) and (target==platform or target==Spring.GetUnitIsBuilding(platform)) then assist=assist+1 end
    end
   end
  end
  if count>=2 and assist>0 then pass("support","platform assistance turrets="..count.." assisting="..assist) end
 end
end
function widget:UnitCreated(id,def,team,builder)
 if team~=0 then return end
 local d=UnitDefs[def]
 builtBy[id]=builder
 if d.name==n[3] then
  if not t2 then log("FAIL platform before T2") end
  log("platform frame at="..Spring.GetGameSeconds())
 end
 if first and builder==first and (d.customParams or {}).unitgroup=="metal" then log("first ship metal structure "..d.name) end
 if first and builder==first and (d.name:find("fmkr") or d.name=="leganavalconv") and not passed.mex then log("FAIL first ship converter before mex") end
end
function widget:UnitFinished(id,def,team)
 if team~=0 then return end
 local d=UnitDefs[def]
 if d.name==n[4] and not first then first=id;log("first construction ship="..id) end
 if d.name==n[2] then t2=id;log("T2 finished at="..Spring.GetGameSeconds()) end
 if d.name==n[3] then platform=id;pass("platform","platform completed "..d.name) end
 if d.extractsMetal and d.extractsMetal>0 and first and builtBy[id]==first then pass("mex","mex completed by first construction ship") end
 if d.canFly and platform and builtBy[id]==platform then pass("aircraft","aircraft produced "..d.name) end
end

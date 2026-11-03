function widget:GetInfo() return {name="FRONT opening order probe",layer=115,enabled=true} end
local workers,seen={},{}
local commander,factory,turret
local turretDone=false
local completedFrame
local cons={armck=true,armcv=true,corck=true,corcv=true,legck=true,legcv=true}
local nanos={armnanotc=true,cornanotc=true,legnanotc=true}
local energy={armwin=true,armsolar=true,armadvsol=true,corwin=true,corsolar=true,coradvsol=true,
 legwin=true,legsolar=true,legadvsol=true}
local combat={armflea=true,armpw=true,armflash=true,corak=true,corgator=true,corfav=true,
 leggob=true,leghelios=true,legscout=true}
local function emit(key,text)
 if seen[key] then return end
 seen[key]=true
 Spring.Echo("[FrontOpeningProbe] "..key.." "..(text or ""))
end
function widget:UnitCreated(id,defId,team,builder)
 if team~=0 then return end
 local d=UnitDefs[defId]
 if energy[d.name] and builder==workers[1] then emit('energy_by_first','builder='..builder) end
 if nanos[d.name] and builder==workers[2] and not turret then
  turret=id
  emit('turret_by_second','builder='..builder..' target='..id)
 end
end
function widget:UnitFinished(id,defId,team)
 if team~=0 then return end
 local d=UnitDefs[defId]
 if d.name=='armcom' or d.name=='corcom' or d.name=='legcom' then commander=id end
 if d.isFactory and not factory then factory=id end
 if cons[d.name] then
  workers[#workers+1]=id
  Spring.Echo("[FrontOpeningProbe] constructor="..#workers.." id="..id)
 elseif combat[d.name] and not seen.first_combat then
  emit('first_combat','constructors='..#workers)
  if #workers<2 then Spring.Echo('[INVARIANT] FrontOpeningProbe combat before two constructors') end
 end
 if id==turret then
  turretDone=true;completedFrame=Spring.GetGameFrame();emit('turret_finished','target='..id)
 end
end
local function assisting(id,target)
 if not id or not target then return false end
 local cmd,_,_,param=Spring.GetUnitCurrentCommand(id)
 return (cmd==CMD.REPAIR or cmd==CMD.GUARD) and param==target
end
function widget:GameFrame(frame)
 if frame%5~=0 then return end
 if frame%900==0 and not turretDone then
  for index,id in ipairs(workers) do
   if index<=2 and Spring.ValidUnitID(id) then
    local cmd,_,_,param=Spring.GetUnitCurrentCommand(id)
    local x,_,z=Spring.GetUnitPosition(id)
    Spring.Echo('[FrontOpeningProbe] pending worker='..index..' id='..id..' command='..tostring(cmd)
     ..' target='..tostring(param)..' x='..tostring(x)..' z='..tostring(z))
   end
  end
 end
 if not turret and commander and factory then
  if assisting(commander,factory) or assisting(commander,Spring.GetUnitIsBuilding(factory)) then
   emit('commander_factory')
  end
 end
 if turret and not turretDone and assisting(commander,turret) then emit('commander_turret') end
 if turretDone and factory then
  if assisting(turret,factory) or assisting(turret,Spring.GetUnitIsBuilding(factory)) then
   emit('turret_factory')
   if frame>=completedFrame+1800 then emit('turret_factory_later') end
  end
 end
end

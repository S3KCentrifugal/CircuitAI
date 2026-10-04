function widget:GetInfo() return {name="AIR recon observer",layer=126,enabled=true,handler=true} end
local cfg=VFS.Include("LuaUI/Config/air_recon.lua")
local planes,queue,shots={},{},{}
local prior,hook,camera
local function log(s) Spring.Echo("[AirReconWatch] "..s) end
local function photo(key,x,z,height)
    if camera or shots[key] then return end
    shots[key]=true
    Spring.SendCommands({"setminspeed 0.25","setmaxspeed 0.25"})
    camera={key=key,at=Spring.GetTimer(),draws=0,state={mode=1,px=x,py=math.max(0,Spring.GetGroundHeight(x,z)),pz=z,height=height or 7500,angle=0.8}}
end
local function receive(team,text)
    if team~=0 then return end
    local phase,id,x,z,pitch=text:match("^barb|reconprobe|%d+|%d+|([^|]+)|([^|]+)|([^|]+)|([^|]+)|([^|]+)$")
    if phase then
        id,x,z=tonumber(id),tonumber(x),tonumber(z)
        if not id then return end
        planes[id]={phase=phase,x=x,z=z,pitch=tonumber(pitch),frame=Spring.GetGameFrame()}
        log("phase="..phase.." unit="..id.." x="..x.." z="..z.." pitch="..pitch)
        return
    end
    local name,gx,gz=text:match("^barb|reconprobe|%d+|%d+|give|([^|]+)|([^|]+)|([^|]+)$")
    if name then queue[#queue+1]="give "..name.." 0 @"..gx..","..Spring.GetGroundHeight(tonumber(gx),tonumber(gz))..","..gz end
end
function widget:Initialize()
    local global=getfenv(0); prior=rawget(global,"RecvSkirmishAIMessage")
    hook=function(team,text) receive(team,text); if prior then return prior(team,text) end end
    rawset(global,"RecvSkirmishAIMessage",hook); Script.UpdateCallIn("RecvSkirmishAIMessage")
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    if f==1800 then
        Spring.SendCommands("give 20 "..cfg.radar.." 0 @"..cfg.home[1]..",300,"..cfg.home[2])
        log("supplied twenty radar planes; AI commands remain enabled")
    end
    if f%15==0 and #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if f%30~=0 then return end
    local count,stage,sweep,survey,xsum,zsum,arrived=0,0,0,0,0,0,0
    for id,p in pairs(planes) do
        local x,_,z=Spring.GetUnitPosition(id)
        if x then
            count=count+1; xsum=xsum+x; zsum=zsum+z
            if p.phase=="stage" then
                stage=stage+1
                if (x-p.x)^2+(z-p.z)^2<=480^2 then arrived=arrived+1 end
            elseif p.phase=="sweep" then sweep=sweep+1 else survey=survey+1 end
            local cmd=Spring.GetUnitCommands(id,1)
            if p.phase=="sweep" and f-p.frame>30 and cmd and cmd[1] and (cmd[1].id==CMD.FIGHT or cmd[1].id==CMD.ATTACK) then
                Spring.Echo("[INVARIANT] INV-123 recon ingress uses combat order")
            end
        end
    end
    if count>0 then
        if stage==20 and arrived>=16 then photo("assembled",xsum/count,zsum/count,math.max(Game.mapSizeX,Game.mapSizeZ)*0.8) end
        if sweep>=18 then photo("crossing",xsum/count,zsum/count,math.max(Game.mapSizeX,Game.mapSizeZ)*0.8) end
        if survey>=18 then photo("survey",xsum/count,zsum/count,5500) end
    end
    if f==5400 and #queue==0 then photo("factories",cfg.home[1],cfg.home[2],3500) end
    if f%300==0 then log("census stage="..stage.." arrived="..arrived.." sweep="..sweep.." survey="..survey) end
end
function widget:UnitDestroyed(id,def,team,attacker,attackerDef,attackerTeam)
    if planes[id] then log("death unit="..id.." attacker="..tostring(attacker).." attackerDef="..tostring(attackerDef).." attackerTeam="..tostring(attackerTeam)) end
end
function widget:Update()
    if not camera then return end
    Spring.SetCameraState(camera.state,0); camera.draws=camera.draws+1
    if camera.draws>=5 and Spring.DiffTimers(Spring.GetTimer(),camera.at)>=1 then
        Spring.SendCommands("screenshot png"); log("screenshot="..camera.key)
        Spring.SendCommands({"setmaxspeed "..cfg.speed,"setminspeed "..cfg.speed}); camera=nil
    end
end
function widget:Shutdown()
    local global=getfenv(0)
    if rawget(global,"RecvSkirmishAIMessage")==hook then rawset(global,"RecvSkirmishAIMessage",prior); Script.UpdateCallIn("RecvSkirmishAIMessage") end
end

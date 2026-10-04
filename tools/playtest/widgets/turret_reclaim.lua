function widget:GetInfo()
    return {name="Turret enemy reclaim fixture", author="CircuitAI", layer=126, enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/turret_reclaim.lua")
local roles={"TECH","AIR","FRONT","SEA","TACTICAL","SUPPORT"}
local names={"armnanotc","armnanotct2","cornanotc","cornanotct2","legnanotc","legnanotct2",
    "armnanotcplat","armnanotc2plat","cornanotcplat","cornanotc2plat","legnanotcplat","legnanotct2plat"}
local sites,queue={},{}
local phase=0
local cameraUntil=0
local function log(s) Spring.Echo("[TurretFixture] "..s) end
local function valid(id) return id and Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) end
local function give(name,team,x,z)
    queue[#queue+1]="give 1 "..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
local function locate(name,water)
    local def=UnitDefNames[name]
    if not def then log("FAIL unavailable="..name);return end
    for z=512,Game.mapSizeZ-512,256 do for x=512,Game.mapSizeX-512,256 do
        local h=Spring.GetGroundHeight(x,z)
        local separated=true
        for _,s in ipairs(sites) do if (s.x-x)^2+(s.z-z)^2<850^2 then separated=false;break end end
        local repair=UnitDefNames[water and "armuwfus" or "armafus"]
        local eh=Spring.GetGroundHeight(x+180,z)
        if separated and ((water and h < -25 and eh < -25) or (not water and h>0 and eh>0))
            and Spring.TestBuildOrder(def.id,x,h,z,0)>0
            and Spring.TestBuildOrder(repair.id,x,Spring.GetGroundHeight(x,z+150),z+150,0)>0 then return x,z end
    end end
    log("FAIL no_site="..name)
end
function widget:Initialize() log("loaded supplied=1") end
function widget:Update()
    if Spring.GetGameFrame()<cameraUntil and sites[1] then
        local s=sites[1]
        Spring.SetCameraState({mode=1,px=s.x+90,py=math.max(0,Spring.GetGroundHeight(s.x,s.z)),pz=s.z,height=900,angle=0},0)
    end
end
function widget:UnitCreated(id,def,team)
    local d=UnitDefs[def]
    local x,_,z=Spring.GetUnitPosition(id)
    if not x then return end
    for _,s in ipairs(sites) do
        if team==0 and d.name==s.name and (s.x-x)^2+(s.z-z)^2<100^2 then s.nano=id end
        if team==0 and d.name==s.repairName and (s.x-x)^2+(s.z+150-z)^2<100^2 then s.repair=id end
        if team==1 and (d.name=="armck" or d.name=="armcs" or d.name=="armmstor" or d.name=="armuwms") and (s.x+180-x)^2+(s.z-z)^2<100^2 then
            s.enemy=id;s.spawn=Spring.GetGameFrame();s.hp=Spring.GetUnitHealth(id);s.started=false;s.hurt=false;s.orders=0
        end
    end
end
function widget:UnitDestroyed(id,def,team)
    if team~=1 then return end
    for _,s in ipairs(sites) do if s.enemy==id and s.started and s.hurt then
        s.killed=true;log("destroyed role="..roles[phase].." nano="..s.name.." target="..id)
    end end
end
function widget:UnitCommand(id,def,team,cmd,params)
    if cmd~=CMD.RECLAIM then return end
    for _,s in ipairs(sites) do if id==s.nano and params and params[1]==s.enemy then s.orders=(s.orders or 0)+1 end end
end
function widget:GameFrame(f)
    if f==150 then
        Spring.SendCommands({"cheat 1","globallos"})
    end
    if f==300 then
        for i,name in ipairs(names) do
            local water=i>6
            local x,z=locate(name,water)
            if x then
                local s={name=name,x=x,z=z,repairName=water and "armuwfus" or "armafus",water=water}
                sites[#sites+1]=s;give(name,0,x,z);give(s.repairName,0,x,z+150)
            end
        end
        log("sites="..#sites)
    end
    if f%3==0 and #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if not cfg.roles and f==600 then
        -- Legacy has no role/task hooks to freeze. Keep only the supplied arena assets.
        local keep={}
        for _,s in ipairs(sites) do if s.nano then keep[s.nano]=true end;if s.repair then keep[s.repair]=true end end
        local remove={}
        for team=0,1 do for _,id in ipairs(Spring.GetTeamUnits(team)) do
            if not keep[id] then remove[#remove+1]=id end
        end end
        if #remove>0 then Spring.SendLuaRulesMsg("$dev$:removeunits "..table.concat(remove," ")) end
    end
    local nextPhase=math.floor((f-1800)/2100)+1
    if nextPhase>=1 and nextPhase<=6 and nextPhase~=phase then
        -- Preserve the prior phase's verdict before replacing its observations.
        if phase>0 then for _,s in ipairs(sites) do
            if not s.killed then log("FAIL missing_kill role="..roles[phase].." nano="..s.name) end
            if not s.resumed then log("FAIL missing_resume role="..roles[phase].." nano="..s.name) end
        end end
        phase=nextPhase
        if cfg.roles then Spring.SendSkirmishAIMessage(0,"barb|setrole|0|"..roles[phase]) end
        for _,s in ipairs(sites) do
            if valid(s.enemy) then Spring.SendLuaRulesMsg("$dev$:removeunits "..s.enemy) end
            s.enemy=nil;s.killed=false;s.resumed=false;s.repairing=false
            if valid(s.repair) then Spring.SendLuaRulesMsg("$dev$:sethealth "..s.repair..":10") end
        end
        log("phase="..roles[phase])
    end
    local age=(f-1800)%2100
    if phase>0 and phase<=6 and f>=1800 and f<14400 then
        if age==450 then
            for _,s in ipairs(sites) do
                if not s.repairing then log("FAIL no_prior_repair role="..roles[phase].." nano="..s.name) end
                local target=cfg.roles and (s.water and "armcs" or "armck") or (s.water and "armuwms" or "armmstor")
                give(target,1,s.x+180,s.z)
            end
        end
        if f%15==0 then for _,s in ipairs(sites) do if valid(s.nano) then
            local cmd,_,_,target=Spring.GetUnitCurrentCommand(s.nano)
            if cmd==CMD.REPAIR and target==s.repair then
                if not s.repairing then log("repair role="..roles[phase].." nano="..s.name) end
                s.repairing=true
                if s.killed and not s.resumed then s.resumed=true;log("resumed role="..roles[phase].." nano="..s.name) end
            end
            if valid(s.enemy) then
                if cmd==CMD.RECLAIM and target==s.enemy and not s.started then
                    s.started=true
                    local metal,storage=Spring.GetTeamResources(0,"metal")
                    log("interrupt role="..roles[phase].." nano="..s.name.." delay="..(f-s.spawn).." metal="..math.floor(metal).." storage="..math.floor(storage))
                end
                local hp=Spring.GetUnitHealth(s.enemy)
                if s.started and hp and hp<s.hp-1 and not s.hurt then
                    s.hurt=true;log("physical_reclaim role="..roles[phase].." nano="..s.name.." hp="..math.floor(hp))
                end
                if f-s.spawn>75 and not s.started then log("FAIL late_interrupt nano="..s.name) end
                if s.orders>4 then log("FAIL repeated_orders nano="..s.name.." orders="..s.orders) end
            end
        end end end
        if phase==1 and age==540 and sites[1] then
            cameraUntil=f+360
            local s=sites[1]
            Spring.SetCameraState({mode=1,px=s.x+90,py=math.max(0,Spring.GetGroundHeight(s.x,s.z)),pz=s.z,height=900,angle=0},0)
            Spring.SendCommands({"setminspeed 1","setmaxspeed 1"})
        end
        if phase==1 and age==555 then Spring.SendCommands("screenshot png") end
        if phase==1 and age==900 then Spring.SendCommands({"setmaxspeed 5","setminspeed 5"}) end
    end
    if f==14400 then
        for _,s in ipairs(sites) do
            if not s.killed or not s.resumed then log("FAIL incomplete_final nano="..s.name) end
        end
        log("complete variants="..#sites.." phases="..phase)
    end
    if cfg.roles and f==14430 then
        for i=1,5 do local s=sites[i];give("armck",1,s.x+180,s.z) end
    end
    if cfg.roles and f==14520 then
        for i=1,5 do
            local s=sites[i]
            local cmd,_,_,target=Spring.GetUnitCurrentCommand(s.nano)
            if cmd~=CMD.RECLAIM or target~=s.enemy then log("FAIL lifecycle_not_reclaiming case="..i) end
        end
        Spring.SendLuaRulesMsg("$dev$:transferunits "..sites[1].enemy..":0")
        Spring.SendLuaRulesMsg("$dev$:neutralize "..sites[2].enemy..":1")
        Spring.SendLuaRulesMsg("$dev$:relocate "..sites[3].x.." "..(sites[3].z+2500).." "..sites[3].enemy)
        Spring.SendLuaRulesMsg("$dev$:removeunits "..sites[4].nano)
        Spring.SendSkirmishAIMessage(0,"turretfixture|player|"..sites[5].nano)
    end
    if cfg.roles and f==14580 then
        for _,i in ipairs({1,2,3}) do
            local s=sites[i]
            local cmd,_,_,target=Spring.GetUnitCurrentCommand(s.nano)
            if not valid(s.enemy) or (cmd==CMD.RECLAIM and target==s.enemy) then
                log("FAIL lifecycle_release case="..i)
            else log("lifecycle_release case="..i) end
        end
        if valid(sites[4].nano) then log("FAIL lifecycle_destroy") else log("lifecycle_destroy") end
        -- A player-owned task may retain its last engine command; stop it explicitly.
        Spring.SendCommands("team 0")
    end
    if cfg.roles and f==14595 then Spring.GiveOrderToUnit(sites[5].nano,CMD.STOP,{},0) end
    if cfg.roles and f==14610 then
        local s=sites[3];Spring.SendLuaRulesMsg("$dev$:relocate "..(s.x+180).." "..s.z.." "..s.enemy)
    end
    if cfg.roles and f==14655 then
        local s=sites[3];local cmd,_,_,target=Spring.GetUnitCurrentCommand(s.nano)
        if cmd~=CMD.RECLAIM or target~=s.enemy then log("FAIL lifecycle_reacquire") else log("lifecycle_reacquire") end
        local p=sites[5];local pc,_,_,pt=Spring.GetUnitCurrentCommand(p.nano)
        if not valid(p.enemy) or (pc==CMD.RECLAIM and pt==p.enemy) then log("FAIL player_control") else log("player_control") end
        log("lifecycle_complete")
    end
    if not cfg.roles and f==14655 then log("legacy_complete") end
end

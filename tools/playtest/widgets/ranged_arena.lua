function widget:GetInfo() return {name="Ranged combat arena",layer=125,enabled=true,handler=true} end
local cfg=VFS.Include("LuaUI/Config/ranged_arena.lua")
local tracked,queue,pending,seen,orders,lastReload={}, {}, nil, {}, {}, {}
local priorDamage,damageHook,priorCommand,commandHook
local camera,photos=nil,{}
local function log(s) Spring.Echo("[RangedArena] frame="..Spring.GetGameFrame().." "..s) end
local occupied={}
local function site(g,x,z)
    local def=UnitDefNames[g.unit]
    if not def then log("ERROR missing_unit="..g.unit);return end
    -- BAR factories expose canMove for their command queue, but are immobile.
    -- A movement test always rejects them; validate their building footprint.
    local mobile=UnitDefs[def.id].canMove and not UnitDefs[def.id].isFactory and (UnitDefs[def.id].speed or 0)>0
    local reference=Spring.GetGroundHeight(g.position[1],g.position[2])
    -- Supplied units must not begin on isolated mountain tops. Validate the
    -- loaded movement footprint and same-height approach before spawning;
    -- record adjusted coordinates so baseline/candidate inputs are auditable.
    for ring=0,8 do
        for direction=0,(ring==0 and 0 or 15) do
            local angle=direction*math.pi/8
            local px,pz=x+math.cos(angle)*ring*64,z+math.sin(angle)*ring*64
            local y=Spring.GetGroundHeight(px,pz)
            local free=y>=0 and math.abs(y-reference)<=64
            if free and mobile and not UnitDefs[def.id].canFly then free=Spring.TestMoveOrder(def.id,px,y,pz,0,0,0,true,true,false) end
            if free and not mobile then free=Spring.TestBuildOrder(def.id,px,y,pz,0)>0 end
            for _,p in ipairs(occupied) do if (px-p[1])^2+(pz-p[2])^2<96^2 then free=false;break end end
            if free then occupied[#occupied+1]={px,pz};return px,y+(UnitDefs[def.id].canFly and 160 or 0),pz end
        end
    end
    log("ERROR unbuildable_spawn="..g.unit.." x="..x.." z="..z)
end
local function child(id)
    if not id or tracked[id] then return end
    local host=Spring.GetUnitRulesParam(id,"carrier_host_unit_id")
    if host and tracked[host] then
        local def,team=Spring.GetUnitDefID(id),Spring.GetUnitTeam(id)
        if def and team then tracked[id]={def=def,team=team,child=true};log("child id="..id.." team="..team.." unit="..UnitDefs[def].name.." host="..host) end
    end
end
local function damage(id,def,team,amount,paralyzer,weapon,projectile,attacker,attackerDef,attackerTeam)
    child(id);child(attacker)
    if tracked[id] or tracked[attacker] then
        log("damage id="..id.." team="..team.." amount="..math.floor(amount).." attacker="..tostring(attacker).." attackerTeam="..tostring(attackerTeam).." weapon="..tostring(weapon))
    end
end
local function command(id,def,team,cmd,params,options,tag,player,fromSynced,fromLua)
    if not tracked[id] then return end
    local count=orders[team] or {all=0,lua=0,nonlua=0};orders[team]=count
    count.all=count.all+1
    if fromLua==true then count.lua=count.lua+1 elseif fromLua==false then count.nonlua=count.nonlua+1 end
    if team==0 and cmd==34923 and cfg.trace_orders~=false then
        local x,_,z=Spring.GetUnitPosition(id)
        log("priority id="..id.." unit="..UnitDefs[def].name.." target="..tostring(params[1]).." x="..math.floor(x).." z="..math.floor(z))
    end
end
function widget:Initialize()
    priorDamage=widgetHandler.UnitDamaged
    damageHook=function(self,...) damage(...);if priorDamage then return priorDamage(self,...) end end
    widgetHandler.UnitDamaged=damageHook;widgetHandler:UpdateCallIn("UnitDamaged")
    priorCommand=widgetHandler.UnitCommand
    commandHook=function(self,...) command(...);if priorCommand then return priorCommand(self,...) end end
    widgetHandler.UnitCommand=commandHook;widgetHandler:UpdateCallIn("UnitCommand")
    log("loaded case="..cfg.name.." variant="..cfg.variant)
end
function widget:UnitCreated(id,def,team,builder)
    if pending and team==pending.g.team and UnitDefs[def].name==pending.g.unit then
        tracked[id]={team=team,def=def};log("spawn id="..id.." team="..team.." unit="..UnitDefs[def].name.." x="..math.floor(pending.x).." z="..math.floor(pending.z));pending=nil
    elseif builder and (tracked[builder] or (cfg.builders and team==0)) then
        tracked[id]={team=team,def=def,child=true,parent=builder};log("child id="..id.." parent="..builder.." unit="..UnitDefs[def].name)
    end
end
function widget:UnitDestroyed(id,def,team)
    if tracked[id] then log("death id="..id.." team="..team.." unit="..UnitDefs[def].name.." cost="..UnitDefs[def].metalCost);tracked[id]=nil end
end
function widget:UnitFinished(id,def,team)
    if cfg.production and tracked[id] then
        log("finished id="..id.." team="..team.." unit="..UnitDefs[def].name.." cost="..UnitDefs[def].metalCost)
    end
end
function widget:GameFrame(f)
    if f==150 then Spring.SendCommands("cheat 1");log("ready") end
    if f<300 then return end
    if cfg.drop_energy_after_seconds and not cfg.energy_dropped and f>=cfg.drop_energy_after_seconds*30 then
        cfg.energy_dropped=true
        local ids={}
        for id,u in pairs(tracked) do
            if u.team==0 and (UnitDefs[u.def].name=="armafus" or UnitDefs[u.def].name=="armmmkr") then ids[#ids+1]=id end
        end
        Spring.SelectUnitArray(ids,false);Spring.SendCommands("destroy");Spring.SelectUnitArray({},false)
        log("fixture_energy_removed count="..#ids)
    end
    for _,g in ipairs(cfg.groups) do
        if not g.queued and f>=(g.after_seconds or 10)*30 then
            g.queued=true
            for i=1,g.count do
                local columns=g.columns or 4;local spacing=g.spacing or 120
                local x=g.position[1]+((i-1)%columns)*spacing
                local z=g.position[2]+math.floor((i-1)/columns)*spacing
                local px,y,pz=site(g,x,z)
                if px then queue[#queue+1]={g=g,x=px,y=y,z=pz} end
            end
        end
    end
    if f%3==0 and not pending and #queue>0 then
        pending=table.remove(queue,1);pending.sent=f
        Spring.SendCommands(string.format("give 1 %s %d @%d,%d,%d",pending.g.unit,pending.g.team,pending.x,pending.y,pending.z))
    end
    if pending and f-pending.sent>300 then log("ERROR spawn_timeout="..pending.g.unit);pending=nil end
    if f%30==0 then
        for id,u in pairs(tracked) do
            local d=UnitDefs[u.def]
            if u.team==1 and not seen[id] then
                local visibility=Spring.GetUnitLosState(id,0,false)
                if visibility and (visibility.los or visibility.radar) then seen[id]=f;log("detected id="..id.." unit="..d.name) end
            end
            if cfg.trace_spam and u.team==0 and d.isFactory then
                local states=Spring.GetUnitStates(id) or {}
                local commands=Spring.GetFactoryCommands(id,-1) or {}
                local builds=0
                for _,c in ipairs(commands) do if c.id<0 then builds=builds+1 end end
                log("factory id="..id.." unit="..d.name.." repeat="..tostring(states["repeat"] or false).." builds="..builds.." building="..tostring(Spring.GetUnitIsBuilding(id) or -1))
            end
            if u.team==0 and d.canMove and (not u.child or cfg.observe_children) then
                for index,w in ipairs(d.weapons or {}) do
                    local reload=Spring.GetUnitWeaponState(id,index,"reloadFrame")
                    local key=id..":"..index
                    if reload and lastReload[key] and reload>lastReload[key] and reload>f then
                        local kind,_,target=Spring.GetUnitWeaponTarget(id,index)
                        local distance=-1
                        if kind==1 and target then
                            local x,_,z=Spring.GetUnitPosition(id);local tx,_,tz=Spring.GetUnitPosition(target)
                            if tx then distance=math.floor(math.sqrt((x-tx)^2+(z-tz)^2)) end
                        end
                        log("shot id="..id.." unit="..d.name.." weapon="..index.." target="..tostring(kind==1 and target or -1).." distance="..distance.." intent="..tostring(Spring.GetUnitRulesParam(id,"unitTargetID") or -1))
                    end
                    lastReload[key]=reload
                end
                if f%150==0 then
                    local x,_,z=Spring.GetUnitPosition(id)
                    local health=Spring.GetUnitHealth(id)
                    local host=Spring.GetUnitRulesParam(id,"carrier_host_unit_id") or -1
                    log("unit id="..id.." unit="..d.name.." x="..math.floor(x).." z="..math.floor(z).." hp="..math.floor(health).." cloak="..tostring(Spring.GetUnitIsCloaked(id) or false).." target="..tostring(Spring.GetUnitRulesParam(id,"unitTargetID") or -1).." command="..tostring(Spring.GetUnitCurrentCommand(id) or -1).." host="..host)
                    if cfg.trace_spam and u.parent then
                        local commands=Spring.GetUnitCommands(id,-1) or {}
                        local last=commands[#commands]
                        log("lane id="..id.." parent="..u.parent.." count="..#commands.." endcmd="..tostring(last and last.id or -1).." endx="..tostring(last and last.params[1] or -1).." endz="..tostring(last and last.params[3] or -1))
                    end
                end
            end
        end
    end
    if f%300==0 then
        if cfg.trace_spam then
            local m,ms,mp,mi,me=Spring.GetTeamResources(0,"metal")
            local e,es,ep,ei,ee=Spring.GetTeamResources(0,"energy")
            log(string.format("economy metal=%.1f storage=%.1f income=%.1f expense=%.1f energy=%.1f eincome=%.1f eexpense=%.1f",m,ms,mi,me,e,ei,ee))
        end
        for team,c in pairs(orders) do log("orders team="..team.." total="..c.all.." nonlua="..c.nonlua.." lua="..c.lua) end
        log("render fps="..Spring.GetFPS())
    end
    if not cfg.headless then
        for _,second in ipairs(cfg.photos or {45,120,210}) do
            if f>=second*30 and not photos[second] and not camera then
                photos[second]=true
                local p=cfg.camera or {4000,5000,2600}
                Spring.SendCommands({"setmaxspeed 0.25","setminspeed 0.25","setmaxspeed 0.25"})
                local state={mode=1,px=p[1],py=math.max(0,Spring.GetGroundHeight(p[1],p[2])),pz=p[2],height=p[3],angle=.9}
                Spring.SetCameraState(state,0)
                local ids={};for id,u in pairs(tracked) do if u.team==0 and UnitDefs[u.def].name==cfg.unit then ids[#ids+1]=id end end
                Spring.SelectUnitArray(ids,false)
                camera={frame=f,draws=0,time=Spring.GetTimer(),state=state}
            end
        end
    end
end
function widget:DrawScreen()
    if not camera then return end
    Spring.SetCameraState(camera.state,0)
    camera.draws=camera.draws+1
    if camera.draws>6 and Spring.DiffTimers(Spring.GetTimer(),camera.time)>.5 then
        Spring.SendCommands("screenshot png")
        log("screenshot")
        Spring.SendCommands({"setmaxspeed "..cfg.speed,"setminspeed "..cfg.speed,"setmaxspeed "..cfg.speed})
        camera=nil
    end
end
function widget:Shutdown()
    if widgetHandler.UnitDamaged==damageHook then widgetHandler.UnitDamaged=priorDamage;widgetHandler:UpdateCallIn("UnitDamaged") end
    if widgetHandler.UnitCommand==commandHook then widgetHandler.UnitCommand=priorCommand;widgetHandler:UpdateCallIn("UnitCommand") end
end

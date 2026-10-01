-- Read-only combat observer for full matches; camera selection never orders units.
function widget:GetInfo()
    return {name="Telchine match observer",desc="Natural production, shore combat and pursuit evidence",author="CircuitAI",layer=115,enabled=true}
end
local units, totals, captured, queue = {}, {}, {}, {}
local pending, caption, lastControl, desiredSpeed = nil, "", "", nil
local config=VFS.FileExists("LuaUI/Config/telchine_observer.lua",VFS.RAW_FIRST)
    and VFS.Include("LuaUI/Config/telchine_observer.lua",nil,VFS.RAW_FIRST) or {}
local controlled=config.controlled==true
local tel=UnitDefNames.legamph.id
local function echo(s) Spring.Echo("[TelMatch] "..s) end
local function total(team)
    if not totals[team] then totals[team]={built=0,lost=0,damage=0,kills=0,killMetal=0,navalDamage=0,wetLoss=0,landings=0,navalChecks=0,chase=0} end
    return totals[team]
end
local function valid(id) return id and Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) end
local function navy(def)
    return def and not def.isImmobile and not def.canFly and (def.minWaterDepth or 0)>0
end
local function shot(key,x,z,label,height)
    if captured[key] then return end
    captured[key]=true;queue[#queue+1]={x=x,z=z,label=label,height=height or 1700}
end
local function nearCoast(x,z)
    for i=0,7 do if Spring.GetGroundHeight(x+400*math.cos(i*math.pi/4),z+400*math.sin(i*math.pi/4))<-30 then return true end end
    return false
end
local function assets(x,z)
    local mex,geo=0,0
    for _,id in ipairs(Spring.GetUnitsInCylinder(x,z,1100) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(id)]
        if d then
            if (d.extractsMetal or 0)>0 then mex=mex+1 end
            if d.needGeo then geo=geo+1 end
        end
    end
    return mex,geo
end
function widget:Initialize() echo(controlled and "loaded controlled=1 observer_no_orders=1" or "loaded natural=1 no_gifts=1 no_orders=1") end
function widget:UnitFinished(id,def,team)
    if def~=tel then return end
    local x,y,z=Spring.GetUnitPosition(id)
    units[id]={team=team,x=x,z=z,born=Spring.GetGameFrame(),wet=false,dryHold=0,navyUntil=0}
    total(team).built=total(team).built+1
    echo(string.format("finished team=%d id=%d frame=%d at=%.0f,%.0f",team,id,Spring.GetGameFrame(),x,z))
    shot("first:"..team,x,z,"Team "..team..(controlled and " - injected Telchine fixture" or " - first naturally produced Telchine"))
end
function widget:UnitDamaged(id,def,team,damage)
    local attacker=Spring.GetUnitLastAttacker(id)
    local u=units[attacker]
    if not u or Spring.AreTeamsAllied(u.team,team) then return end
    local s=total(u.team);s.damage=s.damage+math.max(0,damage or 0)
    local isNavy=navy(UnitDefs[def]);local x,y,z=Spring.GetUnitPosition(attacker)
    if isNavy then s.navalDamage=s.navalDamage+math.max(0,damage or 0);u.navyUntil=Spring.GetGameFrame()+900 end
    if x then
        shot((isNavy and "naval:" or "combat:")..u.team,x,z,"Team "..u.team..(isNavy and " - Telchine firing at navy from shore" or " - Telchine ground combat"),1300)
    end
    if isNavy then echo(string.format("naval_hit frame=%d attacker=%d team=%d target=%d type=%s damage=%.1f ground=%.1f",Spring.GetGameFrame(),attacker,u.team,id,UnitDefs[def].name,damage or 0,Spring.GetGroundHeight(x,z))) end
end
function widget:UnitDestroyed(id,def,team,attacker)
    local u=units[id]
    if u then
        local s=total(u.team);s.lost=s.lost+1
        if Spring.GetGroundHeight(u.x,u.z)<-30 then s.wetLoss=s.wetLoss+1 end
        echo(string.format("lost team=%d id=%d frame=%d ground=%.1f",u.team,id,Spring.GetGameFrame(),Spring.GetGroundHeight(u.x,u.z)))
        units[id]=nil
    end
    local a=units[attacker]
    if a and not Spring.AreTeamsAllied(a.team,team) then
        local s=total(a.team);s.kills=s.kills+1;s.killMetal=s.killMetal+(UnitDefs[def].metalCost or 0)
        echo(string.format("kill team=%d attacker=%d target=%s metal=%.0f",a.team,attacker,UnitDefs[def].name,UnitDefs[def].metalCost or 0))
    end
end
function widget:GameOver(winners) echo("gameover winners="..table.concat(winners or {},",")) end
function widget:GameFrame(f)
    if f%30~=0 then return end
    local speed=tonumber(VFS.LoadFile("LuaUI/Config/telchine_speed.txt",VFS.RAW_FIRST))
    if speed and speed>=0.25 and speed<=100 and speed~=desiredSpeed then
        desiredSpeed=speed
        if not pending then Spring.SendCommands({"setmaxspeed "..speed,"setminspeed "..speed,"setmaxspeed "..speed}) end
    end
    local control=VFS.LoadFile("LuaUI/Config/telchine_camera.txt",VFS.RAW_FIRST)
    if control and control~=lastControl then
        lastControl=control
        local key,x,z,h,label=control:match("^(%S+)%s+(%d+)%s+(%d+)%s+(%d+)%s+(.+)")
        if key then shot("manual:"..key,tonumber(x),tonumber(z),label,tonumber(h)) end
    end
    for id,u in pairs(units) do
        if valid(id) then
            local x,y,z=Spring.GetUnitPosition(id);local ground=Spring.GetGroundHeight(x,z)
            local s=total(u.team);local cmd=(Spring.GetUnitCommands(id,1) or {})[1]
            local target=cmd and cmd.id==CMD.ATTACK and #cmd.params==1 and cmd.params[1] or nil
            local isNavy=valid(target) and navy(UnitDefs[Spring.GetUnitDefID(target)])
            if ground<-30 then
                u.wet=true;u.dryHold=0
                shot("water:"..u.team,x,z,"Team "..u.team.." - Telchine underwater transit")
                if isNavy and not u.warned then
                    u.warned=true;s.chase=s.chase+1
                    echo(string.format("CHASE_CANDIDATE frame=%d team=%d id=%d target=%d ground=%.1f",f,u.team,id,target,ground))
                    shot("chase:"..id,x,z,"CHECK: submerged Telchine with naval attack order")
                end
            elseif ground>=0 then
                if u.wet then
                    s.landings=s.landings+1;u.wet=false
                    local mex,geo=assets(x,z)
                    echo(string.format("landfall frame=%d team=%d id=%d at=%.0f,%.0f mex=%d geo=%d",f,u.team,id,x,z,mex,geo))
                    shot("land:"..u.team..":"..math.floor(f/1800),x,z,"Team "..u.team.." - Telchines reaching dry shore")
                end
                local states=Spring.GetUnitStates(id) or {}
                if (x-u.x)^2+(z-u.z)^2<32^2 and nearCoast(x,z) then u.dryHold=u.dryHold+30 else u.dryHold=0 end
                if u.dryHold==900 then
                    local mex,geo=assets(x,z)
                    echo(string.format("coast_stationary frame=%d team=%d id=%d at=%.0f,%.0f mex=%d geo=%d move=%s cmd=%s",f,u.team,id,x,z,mex,geo,tostring(states.movestate),tostring(cmd and cmd.id)))
                    shot("guard:"..u.team..":"..math.floor(f/5400),x,z,"Team "..u.team.." - 30 seconds holding dry coast; nearby mex "..mex)
                end
                if isNavy or f<u.navyUntil then
                    s.navalChecks=s.navalChecks+1
                    if f%150==0 then echo(string.format("naval_standoff frame=%d team=%d id=%d ground=%.1f move=%s cmd=%s",f,u.team,id,ground,tostring(states.movestate),tostring(cmd and cmd.id))) end
                end
            end
            u.x,u.z=x,z
            if f%900==0 then echo(string.format("unit frame=%d team=%d id=%d at=%.0f,%.0f ground=%.1f cmd=%s",f,u.team,id,x,z,ground,tostring(cmd and cmd.id))) end
        end
    end
    if f%1800==0 then
        local alive=0
        for _,team in ipairs(Spring.GetTeamList()) do
            local _,_,dead,isAI=Spring.GetTeamInfo(team,false)
            if isAI and not dead then alive=alive+1 end
        end
        echo("heartbeat frame="..f.." alive_ai="..alive)
        for team,s in pairs(totals) do
            echo(string.format("metrics frame=%d team=%d built=%d lost=%d wet_loss=%d damage=%.1f kills=%d kill_metal=%.0f naval_damage=%.1f landings=%d naval_checks=%d chase_candidates=%d",f,team,s.built,s.lost,s.wetLoss,s.damage,s.kills,s.killMetal,s.navalDamage,s.landings,s.navalChecks,s.chase))
        end
    end
end
local function restore()
    if pending then Spring.SendCommands({"setmaxspeed "..pending.speed,"setminspeed "..pending.speed,"setmaxspeed "..pending.speed}) end
end
function widget:Shutdown() restore() end
function widget:Update()
    if pending then
        if pending.draws>=3 and Spring.DiffTimers(Spring.GetTimer(),pending.started)>1.3 then
            Spring.SendCommands("screenshot png");echo("screenshot frame="..Spring.GetGameFrame().." "..pending.label)
            restore();pending=nil
        end
        return
    end
    if #queue==0 or Spring.GetGameFrame()<180 then return end
    local item=table.remove(queue,1)
    Spring.SendCommands("viewta")
    Spring.SetCameraTarget(item.x,math.max(0,Spring.GetGroundHeight(item.x,item.z)),item.z,0)
    Spring.SetCameraState({height=item.height,dist=item.height},0)
    item.speed=desiredSpeed or Spring.GetGameSpeed();item.started=Spring.GetTimer();item.draws=0
    caption=item.label..string.format(" | %.2f game minutes",Spring.GetGameFrame()/1800)
    pending=item;Spring.SendCommands({"setminspeed 0.25","setmaxspeed 0.25"})
end
function widget:DrawScreen()
    if pending then pending.draws=pending.draws+1 end
    if caption=="" then return end
    local w,h=Spring.GetViewGeometry()
    gl.Color(0,0,0,0.8);gl.Rect(310,h-95,w-15,h-40)
    gl.Color(1,1,1,1);gl.Text(caption,322,h-64,18,"o")
    gl.Text(controlled and "CONTROLLED SHORE TEST - injected units; enemy ship orders only"
        or "Full 8v8 - natural economy and production - observer issues no unit orders",322,h-84,13,"o")
end

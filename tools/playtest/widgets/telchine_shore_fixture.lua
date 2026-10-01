function widget:GetInfo()
    return {name="Telchine shore fixture",desc="Controlled naval retreat after autonomous landing",author="CircuitAI",layer=116,enabled=true}
end
local tracked, queue, ship, candidate, anchor, retreat = {}, {}, nil, nil, nil, nil
local hitFrame, retreatFrame, samples, wet, pursuit, nonHold, reported = nil, nil, 0, 0, 0, 0, false
local config=VFS.FileExists("LuaUI/Config/telchine_shore.lua",VFS.RAW_FIRST)
    and VFS.Include("LuaUI/Config/telchine_shore.lua",nil,VFS.RAW_FIRST) or {}
local beachhead=config.beachhead==true
local guards, assets, advanced, guardStart, shot = {}, {}, {}, nil, nil
local coordinationReported=false
local function echo(s) Spring.Echo("[ShoreProbe] "..s) end
local function valid(id) return id and Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) end
local function give(name,team,x,z)
    queue[#queue+1]="give "..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
local function dry(x,z)
    for r=0,600,64 do for i=0,15 do
        local px,pz=x+r*math.cos(i*math.pi/8),z+r*math.sin(i*math.pi/8)
        if Spring.GetGroundHeight(px,pz)>=0 and Spring.TestMoveOrder(UnitDefNames.legamph.id,px,Spring.GetGroundHeight(px,pz),pz,0,0,0,true,true,false) then return px,pz end
    end end
end
local function sea(x,z)
    for r=520,580,20 do for i=0,31 do
        local dx,dz=math.cos(i*math.pi/16),math.sin(i*math.pi/16)
        local good=true
        for id in pairs(tracked) do if valid(id) then
            local ux,uy,uz=Spring.GetUnitPosition(id)
            if (ux-x-dx*r)^2+(uz-z-dz*r)^2<520^2 then good=false;break end
        end end
        for d=r,r+900,32 do
            local px,pz=x+dx*d,z+dz*d
            if px<96 or pz<96 or px>Game.mapSizeX-96 or pz>Game.mapSizeZ-96
                or Spring.GetGroundHeight(px,pz)>-35 then good=false;break end
        end
        if good then return {x=x+dx*r,z=z+dz*r,ex=x+dx*(r+900),ez=z+dz*(r+900)} end
    end end
end
function widget:Initialize() echo("loaded controlled=1 gifted="..(beachhead and 12 or 6).." allied_gifted="..(config.alliedGuards and 12 or 0).." no_telchine_orders=1 beachhead="..tostring(beachhead)) end
function widget:UnitFinished(id,def,team)
    if (team==0 or (config.alliedGuards and team==1)) and def==UnitDefNames.legamph.id then tracked[id]={wet=false,landed=false,still=0} end
    if team==2 and def==UnitDefNames.corbats.id then ship=id end
    if beachhead and team==1 and (def==UnitDefNames.leglab.id or def==UnitDefNames.legalab.id) then assets[id]=true end
end
function widget:UnitDamaged(id,def,team,damage)
    if id~=ship then return end
    local attacker=Spring.GetUnitLastAttacker(id)
    if tracked[attacker] and not hitFrame then
        hitFrame=Spring.GetGameFrame()
        echo("naval_hit frame="..hitFrame.." telchine="..attacker.." damage="..damage)
    end
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands({"cheat 1","globallos"}) end
    -- Preserve spectator read access to AI command queues. Recoil godmode grants
    -- order permission, not invulnerability; this fixture orders enemy team 2 only.
    if f==330 then Spring.SendCommands("godmode 3") end
    if f==600 then
        for _,id in ipairs(Spring.GetTeamUnits(2)) do
            -- Enemy commander leaves the target beach; the test never orders team 0.
            local ok=Spring.GiveOrderToUnit(id,CMD.MOVE,{9500,0,11000},{})
            echo("enemy_command_move="..tostring(ok))
            Spring.GiveOrderToUnit(id,CMD.FIRE_STATE,{0},{})
        end
    end
    if f==900 then
        local sx,_,sz=Spring.GetTeamStartPosition(0)
        local fx,fz=dry(sx-240,sz+160);give("leglab",0,fx,fz)
        if beachhead then
            -- Two completed allied production assets make a useful central
            -- beachhead. Production is frozen; the AI owns every Telchine order.
            local ax,az=dry(4700,4200);give("legalab",1,ax,az)
            local bx,bz=dry(4900,4200);give("leglab",1,bx,bz)
        end
        for i=1,(beachhead and 12 or 6) do local x,z=dry(sx+160+(i%4)*70,sz+160+math.floor(i/4)*70);give("legamph",0,x,z) end
        if config.alliedGuards then
            local ax,_,az=Spring.GetTeamStartPosition(1)
            for i=1,12 do local x,z=dry(ax+160+(i%4)*70,az+160+math.floor(i/4)*70);give("legamph",1,x,z) end
        end
        echo("injected frame="..f)
    end
    if valid(ship) then
        if not retreatFrame then Spring.GiveOrderToUnit(ship,CMD.FIRE_STATE,{0},{}) end
        if hitFrame and not retreatFrame then
            local ok=Spring.GiveOrderToUnit(ship,CMD.MOVE,{retreat.ex,0,retreat.ez},{})
            if ok then retreatFrame=f;echo("retreat_order frame="..f.." ship="..ship) end
        end
    end
    if f%30==0 then
        local beachCount,advancedCount=0,0
        for id in pairs(tracked) do if valid(id) then
            local x,y,z=Spring.GetUnitPosition(id)
            if z>3500 and z<5200 then beachCount=beachCount+1 end
            if z>8000 then advancedCount=advancedCount+1 end
        end end
        local guardOnly=not config.alliedGuards or (beachCount==3 and advancedCount==21)
        if config.alliedGuards and guardOnly and not coordinationReported then
            coordinationReported=true
            echo("ally_coordination held="..beachCount.." advancing="..advancedCount)
        end
        for id,u in pairs(tracked) do if valid(id) then
            local x,y,z=Spring.GetUnitPosition(id);local h=Spring.GetGroundHeight(x,z)
            if h<-30 then u.wet=true end
            if u.wet and h>=0 then u.landed=true end
            local cmd=(Spring.GetUnitCommands(id,1) or {})[1]
            local states=Spring.GetUnitStates(id) or {}
            local guardedSite=beachhead and z>3500 and z<5200 or (not beachhead and z>10400)
            if u.landed and guardedSite and h>=0 and not cmd then u.still=u.still+30 else u.still=0 end
            if beachhead and u.landed and z>8000 then advanced[id]=true end
            if not candidate and guardOnly and u.still>=1800 then
                local site=sea(x,z)
                if site then
                    candidate=id;anchor={x=x,z=z};retreat=site
                    if beachhead then
                        for other in pairs(tracked) do if valid(other) then
                            local gx,gy,gz=Spring.GetUnitPosition(other)
                            if (gx-x)^2+(gz-z)^2<400^2 and Spring.GetGroundHeight(gx,gz)>=0 then guards[other]=true end
                        end end
                        guardStart=f
                    end
                    give("corbats",2,site.x,site.z)
                    shot={x=x,z=z,label="Retained Telchine guards protect allied island factories"}
                    echo(string.format("naval_target frame=%d telchine=%d at=%.0f,%.0f ground=%.1f ship=%.0f,%.0f",f,id,x,z,h,site.x,site.z))
                end
            end
            if retreatFrame and f>retreatFrame and f<=retreatFrame+1800 and (not beachhead or guards[id]) then
                samples=samples+1
                if h<0 then wet=wet+1 end
                -- Engine-generated ATTACK commands while holding dry ground are
                -- legal autofire. Only submerged naval attack orders imply chase.
                if h<0 and cmd and cmd.id==CMD.ATTACK and cmd.params[1]==ship then pursuit=pursuit+1 end
                if states.movestate~=0 then nonHold=nonHold+1 end
                if f%150==0 then echo(string.format("hold frame=%d id=%d ground=%.1f move=%s cmd=%s",f,id,h,tostring(states.movestate),tostring(cmd and cmd.id))) end
            end
        end end
        if retreatFrame and f>=retreatFrame+1800 and not reported then
            reported=true
            local x,y,z=Spring.GetUnitPosition(ship)
            local distance=x and math.sqrt((x-anchor.x)^2+(z-anchor.z)^2) or -1
            echo(string.format("result samples=%d wet=%d wet_ship_attack_orders=%d non_hold=%d ship_alive=%s ship_distance=%.0f",samples,wet,pursuit,nonHold,tostring(valid(ship)),distance))
            if beachhead then
                local g,a,v=0,0,0
                for id in pairs(guards) do if valid(id) then g=g+1 end end
                for id in pairs(assets) do if valid(id) then a=a+1 end end
                for id in pairs(advanced) do if valid(id) then v=v+1 end end
                echo(string.format("beachhead guards=%d assets=%d advancing=%d retained_seconds=%.0f",g,a,v,(f-guardStart)/30))
                shot={x=anchor.x,z=anchor.z,label="Ship retreated - beachhead guards remain on dry land"}
            end
        end
    end
    if #queue>0 then Spring.SendCommands(queue);queue={} end
end
function widget:Update()
    if not shot then return end
    local file=io.open("LuaUI/Config/telchine_camera.txt","w")
    if file then file:write(string.format("beach%d %d %d 2100 %s",Spring.GetGameFrame(),shot.x,shot.z,shot.label));file:close() end
    shot=nil
end

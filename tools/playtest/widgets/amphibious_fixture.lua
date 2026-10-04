function widget:GetInfo()
    return {name="Amphibious capability fixture",desc="Actual crossings, landfalls and kills on real terrain",author="CircuitAI",layer=114,enabled=true}
end
local tracked, targets, stats, queue, lastHit = {}, {}, {}, {}, {}
local delayed={}
local previousDamage, damageHook
local config=VFS.Include("LuaUI/Config/amphibious_fixture.lua")
local guard,guardDistance= nil,math.huge
local spawned, enemy, ex, ez, regions, width, height = false
local function echo(s) Spring.Echo("[AmphFixture] "..s) end
local function give(name,team,x,z)
    queue[#queue+1]="give "..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
local function land(x,z) return Spring.GetGroundHeight(x,z)>=0 end
local function key(team,name) return team..":"..name end
local function dry(x,z,name)
    for radius=0,1200,64 do
        for k=0,15 do
            local px=math.max(96,math.min(Game.mapSizeX-96,x+radius*math.cos(k*math.pi/8)))
            local pz=math.max(96,math.min(Game.mapSizeZ-96,z+radius*math.sin(k*math.pi/8)))
            if Spring.TestMoveOrder(UnitDefNames[name or "legamph"].id,px,Spring.GetGroundHeight(px,pz),pz,0,0,0,true,true,false) and land(px,pz) then return px,pz end
        end
    end
    return nil
end
local function region(x,z)
    local gx,gz=math.floor(x/64),math.floor(z/64)
    if not regions or gx<0 or gz<0 or gx>=width or gz>=height then return -1 end
    return regions[gz*width+gx] or -1
end
local function survey()
    width,height=math.floor(Game.mapSizeX/64),math.floor(Game.mapSizeZ/64); regions={}
    for z=0,height-1 do for x=0,width-1 do regions[z*width+x]=land(x*64+32,z*64+32) and -2 or -1 end end
    local nr=0
    for cell=0,width*height-1 do
        if regions[cell]==-2 then
            local q={cell}; regions[cell]=nr; local n=1
            while n<=#q do
                local c=q[n];n=n+1;local x,z=c%width,math.floor(c/width)
                local neighbours={x>0 and c-1 or -1,x<width-1 and c+1 or -1,z>0 and c-width or -1,z<height-1 and c+width or -1}
                for _,v in ipairs(neighbours) do if v>=0 and regions[v]==-2 then regions[v]=nr;q[#q+1]=v end end
            end
            nr=nr+1
        end
    end
    echo("survey land components="..nr)
end
function widget:UnitCreated(id,def,team)
    if Spring.GetGameFrame()<600 then return end
    local name=UnitDefs[def].name
    if team<2 and (name=="legamph" or name=="armmar") then
        local x,y,z=Spring.GetUnitPosition(id)
        tracked[id]={name=name,team=team,x=x,z=z,wet=false,lastRegion=region(x,z)}
        local k=key(team,name);stats[k]=stats[k] or {wet=0,landed=0,progress=0,kills=0,regions={}}
    elseif team==enemy and (name=="legamph" or name=="armmar") then echo("scope control FRONT unit="..name.." id="..id)
    elseif team==enemy and (name=="armsolar" or name=="armwar") then targets[id]=true
    elseif team==enemy and name=="coratl" then
        local x,y,z=Spring.GetUnitPosition(id);guard={x=x,z=z,id=id,alive=true}
        echo("guard at="..x..","..z.." radius="..WeaponDefs[UnitDefs[def].weapons[1].weaponDef].range)
    end
end
function widget:UnitDestroyed(id,def,team,attacker,attackerDef,attackerTeam)
    if guard and guard.id==id then guard.alive=false;echo("guard destroyed id="..id) end
    if targets[id] then
        attacker=attacker or lastHit[id]
        if attacker and tracked[attacker] then
            local t=tracked[attacker];stats[key(t.team,t.name)].kills=stats[key(t.team,t.name)].kills+1
            echo("kill team="..t.team.." unit="..t.name.." target="..id)
        else echo("target destroyed id="..id.." attacker="..tostring(attacker)) end
        targets[id]=nil
    end
end
local function installDamageObserver()
    -- Observe the original LuaUI damage call-in: BAR's widget dispatcher drops attacker IDs.
    local env=getfenv(0);previousDamage=rawget(env,"UnitDamaged")
    damageHook=function(id,def,team,damage,paralyzer,weapon,projectile,attacker,attackerDef,attackerTeam)
        if tracked[attacker] then lastHit[id]=attacker end
        if previousDamage then return previousDamage(id,def,team,damage,paralyzer,weapon,projectile,attacker,attackerDef,attackerTeam) end
    end
    rawset(env,"UnitDamaged",damageHook);Script.UpdateCallIn("UnitDamaged")
end
function widget:Shutdown()
    local env=getfenv(0)
    if rawget(env,"UnitDamaged")==damageHook then rawset(env,"UnitDamaged",previousDamage);Script.UpdateCallIn("UnitDamaged") end
end
function widget:GameFrame(f)
    if f==150 then installDamageObserver() end
    if f==300 then
        Spring.SendCommands({"cheat 1","globallos"});survey()
        for _,team in ipairs(Spring.GetTeamList()) do
            if team~=Spring.GetGaiaTeamID() and not Spring.AreTeamsAllied(0,team) and #Spring.GetTeamUnits(team)>0 then
                enemy=team;ex,_,ez=Spring.GetTeamStartPosition(team);break
            end
        end
    end
    if f>=900 and not spawned then
        spawned=true
        if not enemy then echo("INVALID missing enemy");return end
        for team=0,1 do
            local x,_,z=Spring.GetTeamStartPosition(team)
            local fx,fz=dry(x-240,z+160)
            if fx then give(team==0 and "leglab" or "armap",team,fx,fz) end
            for _,name in ipairs({"legamph","armmar"}) do
                local count=name=="legamph" and 6 or 4
                for i=1,count do
                    local px,pz=dry(x+160+(i%3)*70,z+160+math.floor(i/3)*70+(name=="armmar" and 250 or 0),name)
                    if px then
                        if name=="armmar" and (config.marauderDelay or 0)>0 then delayed[#delayed+1]={name,team,px,pz}
                        else give(name,team,px,pz) end
                    else echo("INVALID dry spawn "..team) end
                end
            end
            echo("injected team="..team.." start="..x..","..z)
        end
        for i=1,12 do
            local x,z=dry(ex+(i%4)*150-250,ez+math.floor(i/4)*150+400)
            if x then give("armsolar",enemy,x,z) end
        end
        for _,name in ipairs({"legamph","armmar"}) do
            local x,z=dry(ex+1500,ez+1500,name)
            if not x then x,z=dry(ex,ez,name) end
            if x then give(name,enemy,x,z) else echo("INVALID FRONT control spawn "..name) end
        end
    end
    if #delayed>0 and f>=900+(config.marauderDelay or 0)*30 then
        for _,item in ipairs(delayed) do give(unpack(item)) end
        delayed={}
    end
    if f==600 and config.guarded and enemy then
        local sx,_,sz=Spring.GetTeamStartPosition(0)
        local cx,cz=(sx+ex)*0.5,(sz+ez)*0.5
        local placed=false
        for radius=0,2000,128 do
            for i=0,15 do
                local x,z=cx+radius*math.cos(i*math.pi/8),cz+radius*math.sin(i*math.pi/8)
                local y=Spring.GetGroundHeight(x,z)
                if not placed and y<-40 and Spring.TestBuildOrder(UnitDefNames.coratl.id,x,y,z,0)>0 then
                    give("coratl",enemy,x,z);placed=true
                    -- Global LOS alone does not guarantee underwater AI callbacks;
                    -- provide real allied sonar coverage for this known-threat test.
                    give("armason",0,x+1200,z)
                end
            end
            if placed then break end
        end
        if not placed then echo("INVALID no guard site") end
    end
    if f%90==0 then
        for id,t in pairs(tracked) do
            if Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) then
                local x,y,z=Spring.GetUnitPosition(id)
                if x then
                    local s,r=stats[key(t.team,t.name)],region(x,z)
                    if Spring.GetGroundHeight(x,z)<-30 and not t.wet then t.wet=true;s.wet=s.wet+1;echo("water team="..t.team.." unit="..t.name.." id="..id) end
                    if Spring.GetGroundHeight(x,z)<-30 then t.wasWet=true end
                    if guard and guard.alive and Spring.GetGroundHeight(x,z)<-30 then guardDistance=math.min(guardDistance,math.sqrt((x-guard.x)^2+(z-guard.z)^2)) end
                    if t.wasWet and r>=0 then
                        t.wasWet=false
                        s.landed=s.landed+1;s.regions[r]=true;t.lastRegion=r
                        echo("landed team="..t.team.." unit="..t.name.." region="..r.." id="..id.." at="..math.floor(x)..","..math.floor(z))
                        if not s.target then
                            local tx,tz=dry(x+220,z)
                            if tx and region(tx,tz)==r then
                                give("armsolar",enemy,tx,tz)
                                local bx,bz=dry(tx+180,tz,"armwar")
                                if bx and region(bx,bz)==r then give("armwar",enemy,bx,bz) end
                                s.target=true;echo("landing target team="..t.team.." unit="..t.name)
                            end
                        end
                    end
                    s.progress=math.max(s.progress,math.sqrt((x-t.x)^2+(z-t.z)^2))
                end
            end
        end
    end
    if f%1800==0 then
        if guard then
            echo("guard minimum underwater distance="..math.floor(guardDistance))
            local state=Spring.GetUnitLosState(guard.id,0) or {}
            echo("guard detected los="..tostring(state.los).." radar="..tostring(state.radar).." typed="..tostring(state.typed))
        end
        for k,s in pairs(stats) do echo("metrics "..k.." wet="..s.wet.." landed="..s.landed.." progress="..math.floor(s.progress).." kills="..s.kills) end
        if f==9000 then for id,t in pairs(tracked) do
            if Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) then
                local x,y,z=Spring.GetUnitPosition(id);local command=Spring.GetUnitCommands(id,1)
                local p=command and command[1] and command[1].params or {}
                echo("unit "..id.." "..key(t.team,t.name).." at="..math.floor(x)..","..math.floor(z).." next="..tostring(p[1])..","..tostring(p[3]))
            end
        end end
    end
    if #queue>0 then Spring.SendCommands(queue);queue={} end
end

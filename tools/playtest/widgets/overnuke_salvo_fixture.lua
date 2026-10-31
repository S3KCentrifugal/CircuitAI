-- Overnuke salvo fixture (owner 2026-10-30). Supplied preconditions only: the
-- AI under test (team 0) is given its silos and the income to stock them; the
-- defender (team 1, NullAI) is given a target cluster ringed by antinukes.
-- The AI chooses, stocks and fires the salvo itself. Read-only after setup:
-- every silo missile is followed to its end and classed as landed (ended
-- near the ground) or intercepted (ended in the air).
function widget:GetInfo()
    return {name="Overnuke salvo fixture",desc="Silos and antinukes supplied; salvo outcome observed",layer=121,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/overnuke_salvo.lua")
local queue={}
local silos,antis,targets={}, {}, {}
local missiles={}            -- projectile id -> {x,y,z,frame}
local launched,landed,intercepted,interceptors=0,0,0,0
local seenInterceptor={}
local firstLaunch,lastEnd=nil,nil
local done=false
local ex,ez,wx,wz
local function echo(s) Spring.Echo("[SalvoTest] "..s) end
local function give(name,team,x,z)
    queue[#queue+1]="give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z)
end
function widget:Initialize()
    echo(string.format("config salvo=%d silos=%d antis=%d",cfg.salvo,cfg.silos,cfg.antis))
end
function widget:GameFrame(f)
    if f==30 then Spring.SendCommands("cheat 1") end
    if f==60 then
        wx,_,wz=Spring.GetTeamStartPosition(0)
        ex,_,ez=Spring.GetTeamStartPosition(1)
        -- the AI's silos and the income to stock them, 700-1900 out from its
        -- start toward the map's inside (starts sit near an edge)
        local dx=(wx<ex) and 1 or -1
        for i=0,cfg.silos-1 do give("armsilo",0,wx+dx*(700+(i%3)*200),wz-300+math.floor(i/3)*220) end
        for i=0,5 do give("armafus",0,wx+dx*(1350+(i%2)*170),wz-450+math.floor(i/2)*170) end
        for i=0,7 do give("armmmkr",0,wx+dx*(1700+(i%2)*90),wz-400+math.floor(i/2)*90) end
        give("armuwadvms",0,wx+dx*1900,wz+200); give("armuwadves",0,wx+dx*1900,wz+350)
        -- the defender: a cluster worth nuking, ringed by antinukes that cover it
        for i=0,3 do give("armafus",1,ex-170+(i%2)*170,ez-170+math.floor(i/2)*170) end
        for i=0,5 do give("armmmkr",1,ex+260,ez-250+i*90) end
        for i=0,cfg.antis-1 do
            local a=2*math.pi*i/cfg.antis
            give("armamd",1,ex+650*math.cos(a),ez+650*math.sin(a))
        end
        echo("supplied silos, income and the antinuke ring")
    end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if f==(cfg.look or 1800) then
        -- the AI's ally team sees the whole map (later with look: the antinukes stock up first): the target is known without a
        -- scout of ours inside the blast (the silo never fires at ground holding
        -- its own unit)
        Spring.SendCommands("globallos 0")
        echo("the AI has looked at the target cluster")
    end
    if f%1800==0 then
        -- The runner idles the AI's factories (only the nuke matchup is under
        -- test). Evidence that nothing else reaches the defender: the AI's
        -- army and its statics with reach beyond 3000 (LRPC, EMP, Juno).
        local army,guns=0,0
        for _,u in ipairs(Spring.GetTeamUnits(0) or {}) do
            local d=UnitDefs[Spring.GetUnitDefID(u)]
            if d and d.name~="armsilo" and d.name~="armamd" then
                if d.canMove and (d.buildSpeed or 0)<=0 then army=army+1 end
                if (not d.canMove) and (d.maxWeaponRange or 0)>3000 then guns=guns+1 end
            end
        end
        echo("AI army="..army.." longRange="..guns.." frame="..f)
    end
    if f%30==0 then
        for _,u in ipairs(Spring.GetAllUnits()) do
            local d=UnitDefs[Spring.GetUnitDefID(u)]
            if d and d.name=="armsilo" and Spring.GetUnitTeam(u)==0 then silos[u]=true end
            if d and d.name=="armamd" and Spring.GetUnitTeam(u)==1 then antis[u]=true end
        end
    end
    if f%900==0 then
        local s,a={},{}
        for u in pairs(silos) do local c=Spring.GetUnitStockpile(u); s[#s+1]=tostring(c or -1) end
        for u in pairs(antis) do local c=Spring.GetUnitStockpile(u); a[#a+1]=tostring(c or -1) end
        echo(string.format("stock frame=%d silos=%s antis=%s",f,table.concat(s,","),table.concat(a,",")))
    end
    -- follow every projectile of a silo or antinuke
    local live={}
    for _,p in ipairs(Spring.GetProjectilesInRectangle(0,0,Game.mapSizeX,Game.mapSizeZ,false,false) or {}) do
        local o=Spring.GetProjectileOwnerID(p)
        if o and silos[o] then
            live[p]=true
            local x,y,z=Spring.GetProjectilePosition(p)
            if not missiles[p] then
                launched=launched+1; firstLaunch=firstLaunch or f
                echo(string.format("launch n=%d frame=%d silo=%d",launched,f,o))
            end
            missiles[p]={x=x,y=y,z=z}
        elseif o and antis[o] and not seenInterceptor[p] then
            seenInterceptor[p]=true; interceptors=interceptors+1
        end
    end
    for p,m in pairs(missiles) do
        if not live[p] then
            local h=m.y-Spring.GetGroundHeight(m.x,m.z)
            local d=math.sqrt((m.x-ex)^2+(m.z-ez)^2)
            if h<250 then landed=landed+1 else intercepted=intercepted+1 end
            echo(string.format("end %s frame=%d height=%.0f fromTarget=%.0f",h<250 and "landed" or "intercepted",f,h,d))
            missiles[p]=nil; lastEnd=f
        end
    end
    -- done: the whole salvo has ended, or 90 s without a launch (the overnuke
    -- ended early: nothing left at the target, or a short release)
    if not done and next(missiles)==nil and lastEnd and f>lastEnd+((launched>=cfg.salvo) and 150 or 2700) then
        done=true
        local antisAlive,stockLeft=0,0
        for u in pairs(antis) do
            if Spring.ValidUnitID(u) and not Spring.GetUnitIsDead(u) then
                antisAlive=antisAlive+1; stockLeft=stockLeft+(Spring.GetUnitStockpile(u) or 0)
            end
        end
        local cluster=0
        for _,u in ipairs(Spring.GetTeamUnits(1) or {}) do
            local d=UnitDefs[Spring.GetUnitDefID(u)]
            if d and (d.name=="armafus" or d.name=="armmmkr") then cluster=cluster+1 end
        end
        echo(string.format("RESULT salvo=%d silos=%d antis=%d launched=%d landed=%d intercepted=%d interceptorsFired=%d antisAlive=%d antiStockLeft=%d clusterLeft=%d/10 firstLaunch=%d salvoSeconds=%.0f",
            cfg.salvo,cfg.silos,cfg.antis,launched,landed,intercepted,interceptors,antisAlive,stockLeft,cluster,
            firstLaunch or -1,((lastEnd or 0)-(firstLaunch or 0))/30))
    end
end

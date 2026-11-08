-- Mixed overnuke fixture (owner 2026-11-08). Supplied preconditions only:
-- three allied SMRTBARb AIs of three factions each get the nuclear silo of
-- their own faction (Armada armsilo = Armageddon, Cortex corsilo = Apocalypse,
-- Legion legsilo = Supernova) at staggered minutes, and the income to stock
-- them; the enemy (NullAI) gets three structure clusters of different worth.
-- The AIs choose, stock and fire. Read-only after setup: every silo missile is
-- followed to its end; each launch and end prints with the silo's team, kind
-- and the end point, so the runner can tell whether the silos of all three AIs
-- hit one shared target once the third silo stands.
function widget:GetInfo()
    return {name="Mixed overnuke fixture",desc="Allied silos of three factions supplied; shared overnuke observed",layer=121,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/overnuke_mixed.lua")
local SILO={armada="armsilo",cortex="corsilo",legion="legsilo"}
local isSilo={armsilo=true,corsilo=true,legsilo=true}
local queue={}
local allies,enemy={},nil
local starts={}
local silos={}       -- unit -> {team, name}
local missiles={}    -- projectile -> {x,y,z,team,silo,name,frame}
local launches=0
local function echo(s) Spring.Echo("[MixedNukeTest] "..s) end
local function give(name,team,x,z)
    x=math.max(64,math.min(Game.mapSizeX-64,x)); z=math.max(64,math.min(Game.mapSizeZ-64,z))
    queue[#queue+1]="give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z)
end
local function sideOf(team)
    local _,_,_,_,side=Spring.GetTeamInfo(team,false)
    side=string.lower(side or "")
    if side:find("arm") then return "armada" elseif side:find("cor") then return "cortex" elseif side:find("leg") then return "legion" end
    return side
end
local function income(team,x,z,dx)
    for i=0,5 do give("armafus",team,x+dx*(1100+(i%2)*170),z-450+math.floor(i/2)*170) end
    for i=0,7 do give("armmmkr",team,x+dx*(1450+(i%4)*90),z-400+math.floor(i/4)*90) end
    give("armuwadvms",team,x+dx*1800,z+200); give("armuwadves",team,x+dx*1800,z+350)
end
-- cfg.plan: {{ally index (1-based), minute, count, kind or nil (own faction)}, ...}
local planned={}
local clusters={}
function widget:GameFrame(f)
    if f==30 then Spring.SendCommands("cheat 1") end
    if f==60 then
        local _,_,_,_,_,ally0=Spring.GetTeamInfo(0,false)
        for _,t in ipairs(Spring.GetTeamList()) do
            if t~=Spring.GetGaiaTeamID() then
                local _,_,_,_,_,ally=Spring.GetTeamInfo(t,false)
                if ally==ally0 then allies[#allies+1]=t elseif enemy==nil then enemy=t end
            end
        end
        table.sort(allies)
        local ex,_,ez=Spring.GetTeamStartPosition(enemy)
        for i,t in ipairs(allies) do
            local x,_,z=Spring.GetTeamStartPosition(t)
            starts[t]={x,z}
            income(t,x,z,(x<ex) and 1 or -1)
            echo(string.format("ally %d team=%d side=%s start=(%d,%d)",i,t,sideOf(t),x,z))
        end
        -- three enemy clusters: rich at its start, two poorer ones 2200 to either side;
        -- cfg.refill adds two more and re-gives any cluster left with no structure
        clusters={
            {ex,ez,function(cx,cz) for i=0,3 do give("armafus",enemy,cx-170+(i%2)*170,cz-170+math.floor(i/2)*170) end
                for i=0,5 do give("armmmkr",enemy,cx+260,cz-250+i*90) end end},
            {ex-2200,ez+300,function(cx,cz) for i=0,1 do give("armfus",enemy,cx+i*150,cz) end
                for i=0,5 do give("armmmkr",enemy,cx+(i%3)*90,cz+200+math.floor(i/3)*90) end end},
            {ex+200,ez+2200,function(cx,cz) for i=0,2 do give("armfus",enemy,cx+i*150,cz) end
                for i=0,3 do give("armmmkr",enemy,cx+(i%2)*90,cz+200+math.floor(i/2)*90) end end}}
        if cfg.refill then
            clusters[4]={ex-4400,ez+600,clusters[2][3]}
            clusters[5]={ex-1500,ez+4600,clusters[3][3]}
        end
        for k,c in ipairs(clusters) do c[3](c[1],c[2]) end
        local s={}
        for k,c in ipairs(clusters) do s[#s+1]=string.format("(%d,%d)",c[1],c[2]) end
        echo(string.format("supplied income to %d allies; enemy=%d clusters at %s%s",
            #allies,enemy,table.concat(s," "),cfg.refill and " refill" or ""))
    end
    if f>60 then
        for k,p in ipairs(cfg.plan) do
            if not planned[k] and f>=math.floor(p[2]*1800) and allies[p[1]] then
                planned[k]=true
                local t=allies[p[1]]
                local name=p[4] or SILO[sideOf(t)] or "armsilo"
                local s=starts[t]
                local ex=Spring.GetTeamStartPosition(enemy)
                local dx=(s[1]<ex) and 1 or -1
                for i=0,(p[3] or 1)-1 do give(name,t,s[1]+dx*(600+i*220),s[2]+300+k*60) end
                echo(string.format("minute %.1f: %d %s to ally %d team=%d",p[2],p[3] or 1,name,p[1],t))
            end
        end
    end
    if cfg.refill and f>60 and f%600==0 then
        for k,c in ipairs(clusters) do
            local left=0
            for _,u in ipairs(Spring.GetUnitsInCylinder(c[1],c[2],700,enemy) or {}) do
                local d=UnitDefs[Spring.GetUnitDefID(u)]; if d and not d.canMove then left=left+1 end
            end
            if left==0 then c[3](c[1],c[2]); echo(string.format("refill cluster %d at (%d,%d) frame=%d",k,c[1],c[2],f)) end
        end
    end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if f==1800 then Spring.SendCommands("globallos 0"); echo("ally team 0 sees the map") end
    if f%30==0 then
        for _,u in ipairs(Spring.GetAllUnits()) do
            local d=UnitDefs[Spring.GetUnitDefID(u)]
            if d and isSilo[d.name] and not silos[u] then
                silos[u]={team=Spring.GetUnitTeam(u),name=d.name}
                echo(string.format("silo %d %s team=%d frame=%d",u,d.name,silos[u].team,f))
            end
        end
    end
    if f%900==0 then
        local s={}
        for u,v in pairs(silos) do
            if Spring.ValidUnitID(u) and not Spring.GetUnitIsDead(u) then
                s[#s+1]=string.format("%s(%d,t%d)=%d",v.name,u,v.team,Spring.GetUnitStockpile(u) or -1)
            end
        end
        table.sort(s)
        echo(string.format("stock frame=%d %s",f,table.concat(s," ")))
    end
    local live={}
    for _,p in ipairs(Spring.GetProjectilesInRectangle(0,0,Game.mapSizeX,Game.mapSizeZ,false,false) or {}) do
        local o=Spring.GetProjectileOwnerID(p)
        if o and silos[o] then
            live[p]=true
            local x,y,z=Spring.GetProjectilePosition(p)
            local m=missiles[p]
            if not m then
                launches=launches+1
                local tx,ty,tz
                local tt,tgt=Spring.GetProjectileTarget(p)
                if type(tgt)=="table" then tx,tz=tgt[1],tgt[3] elseif tt and tgt then tx,_,tz=Spring.GetUnitPosition(tgt) end
                m={team=silos[o].team,silo=o,name=silos[o].name,frame=f}
                missiles[p]=m
                echo(string.format("launch n=%d frame=%d team=%d silo=%s(%d) target=(%d,%d)",launches,f,m.team,m.name,o,tx or -1,tz or -1))
            end
            m.x,m.y,m.z=x,y,z
        end
    end
    for p,m in pairs(missiles) do
        if not live[p] then
            local h=(m.y or 0)-Spring.GetGroundHeight(m.x or 0,m.z or 0)
            echo(string.format("end frame=%d team=%d silo=%s(%d) at=(%d,%d) %s",f,m.team,m.name,m.silo,m.x or -1,m.z or -1,h<250 and "landed" or "intercepted"))
            missiles[p]=nil
        end
    end
end

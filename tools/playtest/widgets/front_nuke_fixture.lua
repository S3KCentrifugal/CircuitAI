-- FRONT nuke fixture (owner 2026-11-01). Supplied preconditions only: TECH
-- (team 0) gets cfg.techSilos silos, its allied FRONT cfg.frontSilos silos,
-- both the income to stock them; FRONT also gets the income for its own silo
-- grid gate (10 s minimum 175 metal / 5000 energy) and, at cfg.conMinute, two
-- T2 constructors. The enemy (NullAI) gets a target cluster. The AIs choose,
-- stock and fire; read-only after setup: launches per team, FRONT silo count.
function widget:GetInfo()
    return {name="FRONT nuke fixture",desc="Allied silos supplied; shared overnuke and FRONT grid observed",layer=121,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/front_nuke.lua")
local queue={}
local front,enemy
local silos={}
local missiles={}
local launches={}
local function echo(s) Spring.Echo("[FrontNukeTest] "..s) end
local function give(name,team,x,z)
    queue[#queue+1]="give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z)
end
local function income(team,x,z,dx,afus,conv)
    for i=0,afus-1 do give("armafus",team,x+dx*(1100+(i%2)*170),z-450+math.floor(i/2)*170) end
    for i=0,conv-1 do give("armmmkr",team,x+dx*(1450+(i%4)*90),z-400+math.floor(i/4)*90) end
    give("armuwadvms",team,x+dx*1800,z+200); give("armuwadves",team,x+dx*1800,z+350)
end
function widget:GameFrame(f)
    if f==30 then Spring.SendCommands("cheat 1") end
    if f==60 then
        local _,_,_,_,_,ally0=Spring.GetTeamInfo(0,false)
        for _,t in ipairs(Spring.GetTeamList()) do
            local _,_,_,isAI,_,ally=Spring.GetTeamInfo(t,false)
            if t~=0 and ally==ally0 and front==nil and t~=Spring.GetGaiaTeamID() then front=t end
            if ally~=ally0 and enemy==nil and t~=Spring.GetGaiaTeamID() then enemy=t end
        end
        local wx,_,wz=Spring.GetTeamStartPosition(0)
        local fx,_,fz=Spring.GetTeamStartPosition(front)
        local ex,_,ez=Spring.GetTeamStartPosition(enemy)
        local dx=(wx<ex) and 1 or -1
        for i=0,cfg.techSilos-1 do give("armsilo",0,wx+dx*(700+(i%3)*200),wz-300) end
        for i=0,cfg.frontSilos-1 do give("armsilo",front,fx+dx*(600+(i%3)*200),fz+300) end
        income(0,wx,wz,dx,6,8)
        income(front,fx,fz,dx,cfg.frontAfus,cfg.frontConv)
        for i=0,3 do give("armafus",enemy,ex-170+(i%2)*170,ez-170+math.floor(i/2)*170) end
        for i=0,5 do give("armmmkr",enemy,ex+260,ez-250+i*90) end
        echo(string.format("supplied: tech=0 front=%d enemy=%d techSilos=%d frontSilos=%d",front,enemy,cfg.techSilos,cfg.frontSilos))
    end
    if f==cfg.conMinute*1800 then
        local fx,_,fz=Spring.GetTeamStartPosition(front)
        give("armack",front,fx+150,fz); give("armack",front,fx-150,fz)
        echo("two T2 constructors given to FRONT")
    end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if f==1800 then Spring.SendCommands("globallos 0"); echo("ally team 0 sees the map") end
    if f%30==0 then
        for _,u in ipairs(Spring.GetAllUnits()) do
            local d=UnitDefs[Spring.GetUnitDefID(u)]
            if d and (d.name=="armsilo" or d.name=="corsilo" or d.name=="legsilo") then silos[u]=Spring.GetUnitTeam(u) end
        end
    end
    if f%1800==0 and front then
        local n,b={0,0},{0,0}
        for u,t in pairs(silos) do
            if Spring.ValidUnitID(u) and not Spring.GetUnitIsDead(u) then
                local k=(t==0) and 1 or ((t==front) and 2 or nil)
                if k then
                    local _,_,_,_,bp=Spring.GetUnitHealth(u)
                    if (bp or 1)>=1 then n[k]=n[k]+1 else b[k]=b[k]+1 end
                end
            end
        end
        echo(string.format("minute=%d silos tech=%d front=%d (front frames %d) launches tech=%d front=%d",
            math.floor(f/1800),n[1],n[2],b[2],launches[0] or 0,launches[front] or 0))
    end
    if f%300==0 and front then
        -- FRONT's silo frames: progress and who builds them
        for u,t in pairs(silos) do
            if t==front and Spring.ValidUnitID(u) and not Spring.GetUnitIsDead(u) then
                local _,_,_,_,bp=Spring.GetUnitHealth(u)
                if bp and bp<1 then
                    local n,near=0,0
                    local x,_,z=Spring.GetUnitPosition(u)
                    for _,b in ipairs(Spring.GetTeamUnits(front) or {}) do
                        if Spring.GetUnitIsBuilding(b)==u then n=n+1 end
                        local d=UnitDefs[Spring.GetUnitDefID(b)]
                        if d and (d.buildSpeed or 0)>0 and d.canMove then
                            local bx,_,bz=Spring.GetUnitPosition(b)
                            if (bx-x)^2+(bz-z)^2<600*600 then near=near+1 end
                        end
                    end
                    local m,_,_,inc=Spring.GetTeamResources(front,"metal")
                    echo(string.format("frame %d progress=%.3f builders=%d mobileBuildersNear=%d metal bank=%d income=%.0f",u,bp,n,near,m or -1,inc or -1))
                end
            end
        end
    end
    local live={}
    for _,p in ipairs(Spring.GetProjectilesInRectangle(0,0,Game.mapSizeX,Game.mapSizeZ,false,false) or {}) do
        local o=Spring.GetProjectileOwnerID(p)
        if o and silos[o] then
            live[p]=true
            if not missiles[p] then
                local t=silos[o]; launches[t]=(launches[t] or 0)+1
                echo(string.format("launch frame=%d team=%d silo=%d",f,t,o))
            end
            missiles[p]=true
        end
    end
    for p in pairs(missiles) do if not live[p] then missiles[p]=nil end end
end

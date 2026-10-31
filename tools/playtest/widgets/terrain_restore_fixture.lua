-- Terrain restore fixture (owner 2026-10-31). Supplied damage only: a
-- commander self-destructs on a metal spot near the AI's base (the "bomb"
-- crater on a place it wants to build), and an enemy silo nukes a point inside
-- its base. The AI under test (team 0) finds and restores the ground itself.
-- Read-only after setup: every site's ground is compared with the engine's
-- original heightmap and its lava, and one [RestoreTest] RESULT line closes.
function widget:GetInfo()
    return {name="Terrain restore fixture",desc="Craters supplied; restore observed",layer=122,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/terrain_restore.lua")
local queue={}
local sites={}               -- {name, x, z, frame (impact or -1), state, ...}
local silo,bomber=nil,nil
local siloOrdered=false
local bombOrdered=false
local done=false
local wx,wz,ex,ez
local function echo(s) Spring.Echo("[RestoreTest] "..s) end
local function give(name,team,x,z)
    queue[#queue+1]="give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z)
end
local function lavaLevel()
    local l=Spring.GetGameRulesParam("lavaLevel")
    if l==nil or l<-9e4 then return nil end
    return l
end
-- damage at a site: the largest |ground - original| on a 16-elmo grid in r,
-- the number of points off by 12+ and the points under fixable lava
local function measure(x,z,r)
    local depth,count,lava=0,0,0
    local ll=lavaLevel()
    for dz=-r,r,16 do
        for dx=-r,r,16 do
            local px,pz=x+dx,z+dz
            if px>=0 and pz>=0 and px<Game.mapSizeX and pz<Game.mapSizeZ then
                local g=Spring.GetGroundHeight(px,pz)
                local o=Spring.GetGroundOrigHeight(px,pz)
                local d=math.abs(g-o)
                if d>depth then depth=d end
                if d>=12 then count=count+1 end
                if ll and g<ll and o>=ll+4 then lava=lava+1 end
            end
        end
    end
    return depth,count,lava
end
local function structureNear(x,z,r)
    for _,u in ipairs(Spring.GetUnitsInCylinder(x,z,r,0) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(u)]
        if d and not d.canMove then return d.name end
    end
    return nil
end
local function pickBombSpot()
    -- the nearest metal spot 400-1400 from the AI's start with none of its
    -- units within 350 (the blast must not take the commander with it)
    local n=Spring.GetGameRulesParam("mex_count") or 0
    local best,bestD=nil,math.huge
    for i=1,n do
        local x=Spring.GetGameRulesParam("mex_x"..i); local z=Spring.GetGameRulesParam("mex_z"..i)
        if x and z then
            local d=math.sqrt((x-wx)^2+(z-wz)^2)
            if d>=400 and d<=1400 and d<bestD and #(Spring.GetUnitsInCylinder(x,z,350,0) or {})==0
                and not structureNear(x,z,60) then
                best,bestD={x=x,z=z},d
            end
        end
    end
    return best
end
function widget:UnitCreated(id,def,team)
    local name=UnitDefs[def].name
    if team==1 and name=="armsilo" and not silo then silo=id end
    if team==1 and name==cfg.bomb and not bomber and Spring.GetGameFrame()>=cfg.bombFrame then bomber=id end
end
function widget:GameFrame(f)
    if f==30 then Spring.SendCommands("cheat 1") end
    if f==45 then Spring.SendCommands("godmode 3") end
    if f==60 then
        wx,_,wz=Spring.GetTeamStartPosition(0)
        ex,_,ez=Spring.GetTeamStartPosition(1)
        echo(string.format("config case=%s units=%s ai_start=(%.0f,%.0f) lava=%s",cfg.case,cfg.units,wx,wz,tostring(lavaLevel())))
        if cfg.t2 and cfg.t2~="" then
            give(cfg.t2,0,wx+(ex>wx and 250 or -250),wz)
            echo("gave the AI a T2 constructor "..cfg.t2)
        end
    end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end

    -- the bomb: a commander self-destructs on a metal spot the AI will want
    if (cfg.case=="bomb" or cfg.case=="both") and f==cfg.bombFrame then
        local s=pickBombSpot()
        if s then
            sites[#sites+1]={name="bomb",x=s.x,z=s.z,frame=-1,state="waiting"}
            give(cfg.bomb,1,s.x,s.z)
            echo(string.format("bomb site (%.0f,%.0f) %.0f from the AI start",s.x,s.z,math.sqrt((s.x-wx)^2+(s.z-wz)^2)))
        else
            echo("no free metal spot for the bomb")
        end
    end
    if bomber and not bombOrdered then
        Spring.GiveOrderToUnit(bomber,CMD.SELFD,{},0)
        bombOrdered=true
        echo("bomb self-destruct ordered id="..bomber)
    end
    -- the nuke: an enemy silo far away, stocked, fires at a point in the base
    if (cfg.case=="nuke" or cfg.case=="both") and f==cfg.nukeFrame then
        give("armsilo",1,ex,ez)
    end
    if silo and f==cfg.nukeFrame+60 then Spring.SendLuaRulesMsg("$dev$:loadmissiles") end
    if silo and not siloOrdered and f>=cfg.nukeFrame+120 and (Spring.GetUnitStockpile(silo) or 0)>0 then
        local dx,dz=ex-wx,ez-wz
        local len=math.sqrt(dx*dx+dz*dz)
        local tx,tz=wx+dx/len*cfg.nukeOffset,wz+dz/len*cfg.nukeOffset
        local ok=Spring.GiveOrderToUnit(silo,CMD.ATTACK,{tx,Spring.GetGroundHeight(tx,tz),tz},0)
        siloOrdered=true
        sites[#sites+1]={name="nuke",x=tx,z=tz,frame=-1,state="waiting"}
        echo(string.format("nuke ordered accepted=%s target=(%.0f,%.0f) %d from the AI start",tostring(ok),tx,tz,cfg.nukeOffset))
    end

    -- observe every site once a second
    if f%30==0 then
        for _,s in ipairs(sites) do
            local depth,count,lava=measure(s.x,s.z,cfg.radius)
            if s.state=="waiting" and count>=4 then
                s.state="damaged"; s.frame=f; s.maxDepth=depth; s.maxCount=count; s.maxLava=lava
                echo(string.format("%s damaged frame=%d depth=%.0f points=%d lava=%d",s.name,f,depth,count,lava))
            elseif s.state=="damaged" then
                s.maxDepth=math.max(s.maxDepth,depth); s.maxCount=math.max(s.maxCount,count); s.maxLava=math.max(s.maxLava,lava)
                if count==0 and lava==0 then
                    s.state="restored"; s.restoredFrame=f
                    echo(string.format("%s restored frame=%d seconds=%.0f maxDepth=%.0f maxPoints=%d maxLava=%d",
                        s.name,f,(f-s.frame)/30,s.maxDepth,s.maxCount,s.maxLava))
                elseif f%300==0 then
                    echo(string.format("%s still damaged frame=%d depth=%.0f points=%d lava=%d",s.name,f,depth,count,lava))
                end
            elseif s.state=="restored" and not s.built then
                local b=structureNear(s.x,s.z,cfg.radius)
                if b then
                    s.built=b; s.builtFrame=f
                    echo(string.format("%s built on after restore: %s frame=%d seconds_after_restore=%.0f",s.name,b,f,(f-s.restoredFrame)/30))
                end
            end
        end
    end

    -- result: every site settled, or the end frame
    if not done and #sites>0 then
        local settled=true
        for _,s in ipairs(sites) do
            if s.state~="restored" or (s.name=="bomb" and not s.built and f<cfg.endFrame) then settled=false end
        end
        if settled or f>=cfg.endFrame then
            done=true
            local parts={}
            for _,s in ipairs(sites) do
                parts[#parts+1]=string.format("%s=%s seconds=%s maxDepth=%.0f lava=%d built=%s",s.name,s.state,
                    s.restoredFrame and string.format("%.0f",(s.restoredFrame-s.frame)/30) or "-",
                    s.maxDepth or 0,s.maxLava or 0,tostring(s.built or "-"))
            end
            echo("RESULT case="..cfg.case.." units="..cfg.units.." "..table.concat(parts," | "))
        end
    end
end

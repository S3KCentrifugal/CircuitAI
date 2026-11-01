-- Terrain restore fixture (owner 2026-10-31). Supplied damage only; the AI
-- under test (team 0) finds and restores the ground itself.
--   bomb  a commander self-destructs on a metal spot near the AI's base (the
--         crater on a place it wants to build)
--   nuke  an enemy silo nukes a point inside the base
--   path  the silo nukes one point on the lane between the starts
--         cfg.pathNukes times (a crater a Thor cannot climb)
--   lava  the silo nukes low ground on the lane, original height a little
--         above the lava, so the crater fills with lava (lava maps)
-- Read-only after setup. Every site is compared with the engine's original
-- heightmap once a second: damaged points, crater lava, points a Thor cannot
-- stand on (TestMoveOrder against the site's own count before the strike)
-- and whether a probe building can be placed at the centre (TestBuildOrder).
-- One [RestoreTest] RESULT line closes.
function widget:GetInfo()
    return {name="Terrain restore fixture",desc="Craters supplied; restore observed",layer=122,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/terrain_restore.lua")
local cases={}
for c in string.gmatch(cfg.case,"[^,]+") do cases[c]=true end
if cases.both then cases.bomb=true; cases.nuke=true end
local queue={}
local sites={}               -- {name, x, z, frame (impact or -1), state, ...}
local strikes={}             -- silo targets: {site, left}
local silo=nil
local bomber=nil
local bombOrdered=false
local siloLoaded=-1
local lastFire=-1
local strikesPlanned=false
local done=false
local wx,wz,ex,ez
local thorDef=UnitDefNames[cfg.thor or "armthor"]
local probeDef=UnitDefNames[cfg.probe or "armfus"]
local mexDef=UnitDefNames["armmex"]
local function echo(s) Spring.Echo("[RestoreTest] "..s) end
local function give(name,team,x,z)
    queue[#queue+1]="give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z)
end
local function lavaLevel()
    local l=Spring.GetGameRulesParam("lavaLevel")
    if l==nil or l<-9e4 then return nil end
    return l
end
local function thorBlocked(x,z,y)
    if not thorDef then return false end
    local ok,res=pcall(Spring.TestMoveOrder,thorDef.id,x,y,z,0,0,0,true,false,true)
    if ok and res~=nil then return not res end
    -- no TestMoveOrder here: the movedef's slope limit (1 - cos)
    local _,ny=Spring.GetGroundNormal(x,z)
    return (1-ny)>(1-math.cos(math.rad(33)))
end
local function buildable(def,x,z)
    if not def then return "-" end
    local ok,res=pcall(Spring.TestBuildOrder,def.id,x,Spring.GetGroundHeight(x,z),z,0)
    if not ok then return "-" end
    return (res and res>0) and "yes" or "no"
end
-- damage at a site on a 16-elmo grid in r: the largest |ground - original|,
-- points off by 12+, points under fixable lava, points a Thor cannot take
local function measure(x,z,r)
    local depth,count,lava,thor=0,0,0,0
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
                if thorBlocked(px,pz,g) then thor=thor+1 end
            end
        end
    end
    return depth,count,lava,thor
end
local function structureNear(x,z,r)
    for _,u in ipairs(Spring.GetUnitsInCylinder(x,z,r,0) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(u)]
        if d and not d.canMove then return d.name end
    end
    return nil
end
local function addSite(name,x,z)
    local s={name=name,x=x,z=z,frame=-1,state="waiting"}
    local depth,count,lava,thor=measure(x,z,cfg.radius)
    s.baseThor=thor; s.baseLava=lava
    s.buildBefore=buildable(probeDef,x,z)
    sites[#sites+1]=s
    echo(string.format("%s site (%.0f,%.0f) %.0f from the AI start, before: thor_blocked=%d lava=%d %s_buildable=%s orig_h=%.0f lava_level=%s",
        name,x,z,math.sqrt((x-wx)^2+(z-wz)^2),thor,lava,cfg.probe or "armfus",s.buildBefore,
        Spring.GetGroundOrigHeight(x,z),tostring(lavaLevel())))
    return s
end
local function pickBombSpot()
    -- the nearest metal spot 400-1400 from the AI's start with none of its
    -- units within 350 (the blast must not take the commander with it)
    -- the game's spot finder (mex_* game rules are not set on every map)
    local list={}
    local finder=WG.resource_spot_finder
    if finder and finder.metalSpotsList then
        for _,p in ipairs(finder.metalSpotsList) do list[#list+1]={p.x,p.z} end
    else
        for i=1,(Spring.GetGameRulesParam("mex_count") or 0) do
            list[#list+1]={Spring.GetGameRulesParam("mex_x"..i),Spring.GetGameRulesParam("mex_z"..i)}
        end
    end
    -- by the bomb minute the AI has often spread over every spot that close:
    -- then 300-2000 with none of its units within 200
    for _,t in ipairs({{400,1400,350},{300,2000,200}}) do
        local best,bestD=nil,math.huge
        for _,p in ipairs(list) do
            local x,z=p[1],p[2]
            if x and z then
                local d=math.sqrt((x-wx)^2+(z-wz)^2)
                if d>=t[1] and d<=t[2] and d<bestD and #(Spring.GetUnitsInCylinder(x,z,t[3],0) or {})==0
                    and not structureNear(x,z,60) then
                    best,bestD={x=x,z=z},d
                end
            end
        end
        if best then return best,#list end
    end
    return nil,#list
end
local function lanePoint(t,side)
    local dx,dz=ex-wx,ez-wz
    local len=math.sqrt(dx*dx+dz*dz)
    return wx+dx*t-dz/len*side,wz+dz*t+dx/len*side
end
local function pickLavaSpot()
    -- low ground near the lane: original height lava+8 .. lava+lavaBand, so a
    -- nuke crater dips below the lava; nearest to cfg.pathAt along the lane
    local ll=lavaLevel()
    if not ll then return nil end
    local best,bestScore=nil,math.huge
    for t=0.2,0.8,0.02 do
        for side=-800,800,100 do
            local x,z=lanePoint(t,side)
            if x>200 and z>200 and x<Game.mapSizeX-200 and z<Game.mapSizeZ-200 then
                local o=Spring.GetGroundOrigHeight(x,z)
                if o>=ll+8 and o<=ll+(cfg.lavaBand or 30) and Spring.GetGroundHeight(x,z)>=ll+8 then
                    local score=math.abs(t-cfg.pathAt)*4000+math.abs(side)
                    if score<bestScore then best,bestScore={x=x,z=z},score end
                end
            end
        end
    end
    return best
end
local function pickPathSpot()
    -- a lane point a Thor can cross before the strike (the lane's straight
    -- line may run over a ridge): fewest blocked points on a coarse grid,
    -- then nearest to cfg.pathAt and the lane's middle
    local best,bestScore=nil,math.huge
    for t=cfg.pathAt-0.15,cfg.pathAt+0.15,0.03 do
        for side=-600,600,150 do
            local x,z=lanePoint(t,side)
            if x>200 and z>200 and x<Game.mapSizeX-200 and z<Game.mapSizeZ-200 then
                local blocked=0
                for dz=-cfg.radius,cfg.radius,50 do
                    for dx=-cfg.radius,cfg.radius,50 do
                        if thorBlocked(x+dx,z+dz,Spring.GetGroundHeight(x+dx,z+dz)) then blocked=blocked+1 end
                    end
                end
                local score=blocked*10000+math.abs(t-cfg.pathAt)*4000+math.abs(side)
                if score<bestScore then best,bestScore={x=x,z=z},score end
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
        echo(string.format("config case=%s units=%s ai_start=(%.0f,%.0f) enemy_start=(%.0f,%.0f) lava=%s thor=%s probe=%s",
            cfg.case,cfg.units,wx,wz,ex,ez,tostring(lavaLevel()),tostring(thorDef and thorDef.name),tostring(probeDef and probeDef.name)))
        local dx=(ex>wx) and 250 or -250
        for i,name in ipairs(cfg.give or {}) do
            give(name,0,wx+dx,wz+(i-1)*60)
            echo("gave the AI "..name)
        end
    end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end

    -- the bomb: a commander self-destructs on a metal spot the AI will want
    if cases.bomb and f==cfg.bombFrame then
        local s,spots=pickBombSpot()
        if s then
            local site=addSite("bomb",s.x,s.z)
            site.mexBefore=buildable(mexDef,s.x,s.z)
            give(cfg.bomb,1,s.x,s.z)
        else
            echo("no free metal spot for the bomb (spots="..spots..")")
        end
    end
    if bomber and not bombOrdered then
        Spring.GiveOrderToUnit(bomber,CMD.SELFD,{},0)
        bombOrdered=true
        echo("bomb self-destruct ordered id="..bomber)
    end
    -- the silo: far away at the enemy start, stocked by the dev helper
    if (cases.nuke or cases.path or cases.lava) and f==cfg.nukeFrame then
        give("armsilo",1,ex,ez)
    end
    if silo and not strikesPlanned and f>=cfg.nukeFrame+60 then
        strikesPlanned=true
        if cases.nuke then
            local dx,dz=ex-wx,ez-wz
            local len=math.sqrt(dx*dx+dz*dz)
            strikes[#strikes+1]={site=addSite("nuke",wx+dx/len*cfg.nukeOffset,wz+dz/len*cfg.nukeOffset),left=1}
        end
        if cases.path then
            local s=pickPathSpot() or {}
            if not s.x then s.x,s.z=lanePoint(cfg.pathAt,0) end
            strikes[#strikes+1]={site=addSite("path",s.x,s.z),left=cfg.pathNukes}
        end
        if cases.lava then
            local s=pickLavaSpot()
            if s then
                strikes[#strikes+1]={site=addSite("lava",s.x,s.z),left=1}
            else
                echo("no low ground near the lane for the lava case (lava="..tostring(lavaLevel())..")")
            end
        end
    end
    -- one missile at a time: stock, then fire at the first target with any left
    if silo and #strikes>0 and f>=lastFire+cfg.nukeGap then
        local st=nil
        for _,s in ipairs(strikes) do if s.left>0 then st=s; break end end
        if st then
            if (Spring.GetUnitStockpile(silo) or 0)<1 then
                if f>=siloLoaded+90 then
                    Spring.SelectUnitArray({silo})
                    Spring.SendLuaRulesMsg("$dev$:loadmissiles")
                    siloLoaded=f
                end
            else
                local y=Spring.GetGroundHeight(st.site.x,st.site.z)
                local ok=Spring.GiveOrderToUnit(silo,CMD.ATTACK,{st.site.x,y,st.site.z},0)
                st.left=st.left-1
                lastFire=f
                echo(string.format("nuke at %s accepted=%s (%d left)",st.site.name,tostring(ok),st.left))
            end
        end
    end

    -- observe every site once a second
    if f%30==0 then
        for _,s in ipairs(sites) do
            local depth,count,lava,thor=measure(s.x,s.z,cfg.radius)
            local thorOver=thor-s.baseThor
            if s.state=="waiting" and count>=4 then
                s.state="damaged"; s.frame=f; s.maxDepth=depth; s.maxCount=count; s.maxLava=lava; s.maxThor=thorOver
                echo(string.format("%s damaged frame=%d depth=%.0f points=%d lava=%d thor_blocked=+%d",s.name,f,depth,count,lava,thorOver))
            elseif s.state=="damaged" then
                -- a later missile on the same point counts from its own impact
                s.maxDepth=math.max(s.maxDepth,depth); s.maxCount=math.max(s.maxCount,count)
                s.maxLava=math.max(s.maxLava,lava); s.maxThor=math.max(s.maxThor,thorOver)
                if s.buildDamaged==nil and f>=s.frame+60 then
                    s.buildDamaged=buildable(probeDef,s.x,s.z)
                    if s.mexBefore then s.mexDamaged=buildable(mexDef,s.x,s.z) end
                    echo(string.format("%s after the strike: %s_buildable=%s mex_buildable=%s",s.name,cfg.probe or "armfus",s.buildDamaged,tostring(s.mexDamaged or "-")))
                end
                if s.maxThor>0 and thorOver<=0 and not s.passFrame then
                    s.passFrame=f
                    echo(string.format("%s passable for a Thor again frame=%d seconds=%.0f",s.name,f,(f-s.frame)/30))
                end
                if s.maxLava>0 and lava==0 and not s.lavaFrame then
                    s.lavaFrame=f
                    echo(string.format("%s crater lava gone frame=%d seconds=%.0f",s.name,f,(f-s.frame)/30))
                end
                if count==0 and lava==0 then
                    s.state="restored"; s.restoredFrame=f
                    s.buildAfter=buildable(probeDef,s.x,s.z)
                    if s.mexBefore then s.mexAfter=buildable(mexDef,s.x,s.z) end
                    echo(string.format("%s restored frame=%d seconds=%.0f maxDepth=%.0f maxPoints=%d maxLava=%d maxThorBlocked=+%d %s_buildable=%s mex_buildable=%s",
                        s.name,f,(f-s.frame)/30,s.maxDepth,s.maxCount,s.maxLava,s.maxThor,cfg.probe or "armfus",s.buildAfter,tostring(s.mexAfter or "-")))
                elseif f%300==0 then
                    echo(string.format("%s still damaged frame=%d depth=%.0f points=%d lava=%d thor_blocked=+%d",s.name,f,depth,count,lava,thorOver))
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
    if not done and (#sites>0 or f>=cfg.endFrame) then
        local settled=#sites>0
        if silo and not strikesPlanned then settled=false end
        if (cases.nuke or cases.path or cases.lava) and not strikesPlanned then settled=false end
        for _,st in ipairs(strikes) do if st.left>0 then settled=false end end
        for _,s in ipairs(sites) do
            if s.state~="restored" or (s.name=="bomb" and not s.built) then settled=false end
        end
        if settled or f>=cfg.endFrame then
            done=true
            local parts={}
            for _,s in ipairs(sites) do
                parts[#parts+1]=string.format("%s=%s seconds=%s maxDepth=%.0f lava=%d lava_gone=%s thor_blocked=+%d thor_pass=%s build=%s/%s/%s built=%s",
                    s.name,s.state,
                    s.restoredFrame and string.format("%.0f",(s.restoredFrame-s.frame)/30) or "-",
                    s.maxDepth or 0,s.maxLava or 0,
                    s.lavaFrame and string.format("%.0f",(s.lavaFrame-s.frame)/30) or "-",
                    s.maxThor or 0,
                    s.passFrame and string.format("%.0f",(s.passFrame-s.frame)/30) or "-",
                    s.buildBefore or "-",s.buildDamaged or "-",s.buildAfter or "-",
                    tostring(s.built or "-"))
            end
            echo("RESULT case="..cfg.case.." units="..cfg.units.." "..table.concat(parts," | "))
        end
    end
end

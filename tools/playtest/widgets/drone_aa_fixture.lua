-- Drone AA fixture (owner 2026-11-04, test only).
-- The host plays its own ally team; its commander self-destructs and it gets a
-- finished Legion Hive (leghive) plus one gun porc by cheat give, with an
-- energy plant far away so the Hive can restock drones. The AI (team 0) gets a
-- lab, a solar, a mex and a T1 constructor at a known spot about 850 from the
-- Hive, so the drones strike them. Logs: the AI's light AA towers (created,
-- finished, position, distance to the porc, who builds them), AI builders that
-- walk into the porc's reach, drone and Hive deaths with killers, and a RESULT
-- line at the end.
function widget:GetInfo()
    return {name="Drone AA fixture",desc="Placed Hive vs the AI's structures",layer=123,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/drone_aa.lua")
local A=0
local queue={}
local myTeam
local frameNow=0
local finished=false
local aa={}          -- unitID -> {def,x,z,created,done,builder}
local aaDefs={armrl=true,corrl=true,legrl=true,armcir=true,corerad=true,leglupara=true,armferret=true,cormadsam=true,legrhapsis=true}
local deaths={}
local hostUnits={}   -- unitID -> def (hive, porc, drones)
local inReach={}     -- builder unitID -> true while inside the porc's reach
local firstHit
local drones={born=0,dead=0}

local function echo(s) Spring.Echo("[DroneAAFix] "..s) end
local function cmd(s) queue[#queue+1]=s end
local function give(name,team,x,z)
    cmd("give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z))
end
local function dist(x1,z1,x2,z2) return math.sqrt((x1-x2)^2+(z1-z2)^2) end
local function defName(u) local d=UnitDefs[Spring.GetUnitDefID(u) or -1]; return d and d.name or "?" end

function widget:Initialize()
    local _,_,_,team=Spring.GetPlayerInfo(Spring.GetMyPlayerID(),false)
    myTeam=team
    echo(string.format("host team=%s side=%s hive=(%d,%d) porc=%s (%d,%d) range %d site=(%d,%d)",tostring(myTeam),cfg.side,cfg.hx,cfg.hz,cfg.porc,cfg.px,cfg.pz,cfg.porcRange,cfg.sx,cfg.sz))
end

function widget:UnitCreated(u,ud,team)
    if team~=myTeam then return end
    local d=UnitDefs[ud]
    if not d then return end
    hostUnits[u]=d.name
    if d.name=="legdrone" then drones.born=drones.born+1 return end
    local x,_,z=Spring.GetUnitPosition(u)
    echo(string.format("host unit id=%d def=%s pos=(%.0f,%.0f)",u,d.name,x or -1,z or -1))
end

function widget:UnitDamaged(u,ud,team,damage,para,wd,pid,attacker,attackerDef)
    if team~=A or firstHit then return end
    local ad=attackerDef and UnitDefs[attackerDef]
    if ad and ad.name=="legdrone" then
        firstHit=frameNow
        echo(string.format("first drone hit frame=%d on id=%d def=%s",frameNow,u,UnitDefs[ud] and UnitDefs[ud].name or "?"))
    end
end

function widget:UnitDestroyed(u,ud,team,attacker,attackerDef)
    local by=attackerDef and UnitDefs[attackerDef] and UnitDefs[attackerDef].name or "-"
    local name=UnitDefs[ud] and UnitDefs[ud].name or "?"
    if team==myTeam then
        if name=="legdrone" then drones.dead=drones.dead+1; drones[by]=(drones[by] or 0)+1 return end
        echo(string.format("host death frame=%d id=%d def=%s by=%s",frameNow,u,name,by))
    elseif team==A then
        if aa[u] then aa[u].dead=frameNow end
        local x,_,z=Spring.GetUnitPosition(u)
        echo(string.format("ai death frame=%d id=%d def=%s pos=(%.0f,%.0f) by=%s",frameNow,u,name,x or -1,z or -1,by))
    end
end

local function scan(f)
    for _,u in ipairs(Spring.GetTeamUnits(A) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(u) or -1]
        if d then
            if aaDefs[d.name] then
                local t=aa[u]
                local _,_,_,_,bp=Spring.GetUnitHealth(u)
                if not t then
                    local x,_,z=Spring.GetUnitPosition(u)
                    t={def=d.name,x=x,z=z,created=f}
                    aa[u]=t
                    echo(string.format("AA created frame=%d id=%d def=%s pos=(%.0f,%.0f) to_porc=%.0f to_site=%.0f to_hive=%.0f",f,u,d.name,x,z,
                        dist(x,z,cfg.px,cfg.pz),dist(x,z,cfg.sx,cfg.sz),dist(x,z,cfg.hx,cfg.hz)))
                end
                if not t.done and bp and bp>=1 then
                    t.done=f
                    echo(string.format("AA finished frame=%d id=%d def=%s builder=%s",f,u,t.def,t.builder or "?"))
                end
            end
            if d.isBuilder and d.canMove then
                local b=Spring.GetUnitIsBuilding(u)
                if b and aa[b] and not aa[b].builder then
                    aa[b].builder=string.format("%s %d",d.name,u)
                    echo(string.format("AA builder frame=%d aa=%d by %s %d",f,b,d.name,u))
                end
                local x,_,z=Spring.GetUnitPosition(u)
                local inside=x and dist(x,z,cfg.px,cfg.pz)<cfg.porcRange+40
                if inside and not inReach[u] then echo(string.format("builder IN porc reach frame=%d %s %d at (%.0f,%.0f) dist=%.0f",f,d.name,u,x,z,dist(x,z,cfg.px,cfg.pz))) end
                inReach[u]=inside or nil
            end
        end
    end
end

local function result()
    local n,done,alive=0,0,0
    local rows={}
    for u,t in pairs(aa) do
        n=n+1
        if t.done then done=done+1 end
        if not t.dead then alive=alive+1 end
        rows[#rows+1]=string.format("%s@(%.0f,%.0f) porc=%.0f created=%d done=%s by=%s dead=%s",t.def,t.x,t.z,dist(t.x,t.z,cfg.px,cfg.pz),t.created,tostring(t.done),t.builder or "?",tostring(t.dead))
    end
    local kills={}
    for k,v in pairs(drones) do if k~="born" and k~="dead" then kills[#kills+1]=k.."="..v end end
    echo(string.format("RESULT firstHit=%s aa=%d finished=%d alive=%d drones born=%d dead=%d killers={%s}",tostring(firstHit),n,done,alive,drones.born,drones.dead,table.concat(kills,",")))
    for _,r in ipairs(rows) do echo("RESULT aa "..r) end
end

local function gameFrame(f)
    frameNow=f
    if f==30 then cmd("cheat 1") end
    if f==50 then
        Spring.SelectUnitArray(Spring.GetTeamUnits(myTeam) or {})
        cmd("selfd")
        local _,_,_,_,_,ally=Spring.GetTeamInfo(myTeam,false)
        cmd("globallos "..ally)
    end
    if f==60 and cfg.aiLos then
        local _,_,_,_,_,aiAlly=Spring.GetTeamInfo(A,false)
        cmd("globallos "..aiAlly); echo("global LOS on for AI ally "..tostring(aiAlly))
    end
    if f==(cfg.aiAt or 240) then
        for _,e in ipairs(cfg.ai) do give(e[1],A,cfg.sx+e[2],cfg.sz+e[3]) end
        echo(string.format("AI structures at (%d,%d): %d",cfg.sx,cfg.sz,#cfg.ai))
    end
    if f==(cfg.hiveAt or 450) then
        for _,h in ipairs(cfg.hives or {{cfg.hx,cfg.hz}}) do give("leghive",myTeam,h[1],h[2]) end
        give(cfg.porc,myTeam,cfg.px,cfg.pz)
        for _,e in ipairs(cfg.power or {}) do give(e[1],myTeam,e[2],e[3]) end
        echo(string.format("hives %d, first at (%d,%d), %s at (%d,%d)",#(cfg.hives or {1}),cfg.hx,cfg.hz,cfg.porc,cfg.px,cfg.pz))
    end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if f%15==0 and f>(cfg.aiAt or 240) then scan(f) end
    if f%1800==0 then echo(string.format("minute=%d drones born=%d dead=%d aa=%d",f/1800,drones.born,drones.dead,(function() local c=0 for _ in pairs(aa) do c=c+1 end return c end)())) end
    if not finished and f>=cfg.timeoutMin*1800 then finished=true; result(); echo("DONE timeout") end
end

local errors=0
function widget:GameFrame(f)
    local ok,err=pcall(gameFrame,f)
    if not ok then
        errors=errors+1
        if errors<=20 then echo("ERROR frame="..f.." "..tostring(err)) end
    end
end

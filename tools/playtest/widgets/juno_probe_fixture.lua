-- Juno probing-shot fixture (owner 2026-11-03, test only).
-- The host plays its own ally team; its commander self-destructs and it gets a
-- porc cluster under a Veil jammer by cheat give. The AI (team 0) has global
-- LOS only while the porc is placed, so the cluster stays as ghost images inside
-- the radar tower it is given; the Veil comes after LOS goes off (never seen),
-- so the images are jammed with no known jammer. Mode "juno": the AI
-- gets a Juno (probing shot). Mode "group": the AI gets income (AFUS + T2
-- converters) and forward porc near the cluster (commander-group probe Juno).
-- Logs Juno shots at the cluster, cluster deaths and a RESULT line.
function widget:GetInfo()
    return {name="Juno probe fixture",desc="Jammed ghost porc vs a Juno",layer=123,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/juno_probe.lua")
local A=0
local queue={}
local myTeam
local frameNow=0
local tracked={}
local aiAlly
local nextPlace=300
local placing
local generation=0

local function echo(s) Spring.Echo("[JunoProbe] "..s) end
local function cmd(s) queue[#queue+1]=s end
local function give(name,team,x,z)
    cmd("give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z))
end
local function giveAll(rows,team,ox,oz) for _,e in ipairs(rows) do give(e[1],team,ox+e[2],oz+e[3]) end end

function widget:Initialize()
    local _,_,_,team=Spring.GetPlayerInfo(Spring.GetMyPlayerID(),false)
    myTeam=team
    local _,_,_,_,_,ally=Spring.GetTeamInfo(A,false)
    aiAlly=ally
    echo(string.format("host team=%s ai ally=%s mode=%s",tostring(myTeam),tostring(aiAlly),cfg.mode))
end

function widget:UnitCreated(u,ud,team)
    if team~=myTeam then return end
    local d=UnitDefs[ud]
    if not d or d.canMove then return end
    local x,_,z=Spring.GetUnitPosition(u)
    tracked[u]={def=d.name,x=x,z=z}
    echo(string.format("unit id=%d def=%s pos=(%.0f,%.0f) jam=%.0f",u,d.name,x,z,d.radarDistanceJam or 0))
end

function widget:UnitDamaged(u,ud,team,damage,para,wd,pid,attacker,attackerDef)
    if not tracked[u] then return end
    -- protect: the porc is healed to full on every hit (BAR dev sethealth, cheats on), so the
    -- cluster outlives the raiders until a probe pulse; the pulse deletes the Veil regardless
    if cfg.protect and tracked[u].def~=cfg.jammer then Spring.SendLuaRulesMsg(string.format("$dev$:sethealth %d:100",u)) end
    if not para then return end
    echo(string.format("emp frame=%d id=%d def=%s damage=%.0f",frameNow,u,tracked[u].def,damage))
end

function widget:UnitDestroyed(u,ud,team,attacker,attackerDef)
    local t=tracked[u]
    if not t then return end
    t.dead=frameNow
    t.by=attackerDef and UnitDefs[attackerDef] and UnitDefs[attackerDef].name or "-"
    echo(string.format("death frame=%d id=%d def=%s by=%s",frameNow,u,t.def,t.by))
end

local function result()
    local alive,dead=0,0
    for _,t in pairs(tracked) do if t.dead then dead=dead+1 else alive=alive+1 end end
    local n=0
    for _,u in ipairs(Spring.GetTeamUnits(A) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(u)]
        if d and (d.name=="armjuno" or d.name=="corjuno") then n=n+1 end
    end
    echo(string.format("RESULT mode=%s clusterAlive=%d clusterDead=%d aiJunos=%d",cfg.mode,alive,dead,n))
end

function widget:GameFrame(f)
    frameNow=f
    if f==30 then cmd("cheat 1") end
    if f==50 then
        Spring.SelectUnitArray(Spring.GetTeamUnits(myTeam) or {})
        cmd("selfd")
        local _,_,_,_,_,ally=Spring.GetTeamInfo(myTeam,false)
        cmd("globallos "..ally)
    end
    -- Each placement: global LOS on, the porc given (seen, so it stays as ghost images), LOS off,
    -- then the Veil given unseen, so the AI never learns of the jammer. A new placement follows
    -- recycleSec after the whole cluster is dead.
    if f==nextPlace then
        placing=f; generation=generation+1
        cmd("globallos "..aiAlly)
        for _,e in ipairs(cfg.cluster) do if e[1]~=cfg.jammer then give(e[1],myTeam,cfg.cx+e[2],cfg.cz+e[3]) end end
        echo(string.format("placement %d: LOS on, porc at (%d,%d)",generation,cfg.cx,cfg.cz))
    end
    if placing and f==placing+90 then cmd("globallos "..aiAlly); echo("placement "..generation..": LOS off") end
    if placing and f==placing+150 then
        for _,e in ipairs(cfg.cluster) do if e[1]==cfg.jammer then give(e[1],myTeam,cfg.cx+e[2],cfg.cz+e[3]) end end
        echo("placement "..generation..": jammer given unseen")
        placing=nil; nextPlace=-1
    end
    if f==360 then
        giveAll(cfg.ours,A,0,0)
        echo(string.format("ai units: %d (mode %s)",#cfg.ours,cfg.mode))
    end
    if nextPlace<0 and not placing and f%30==0 then
        local alive=0
        for _,t in pairs(tracked) do if not t.dead then alive=alive+1 end end
        if alive==0 then nextPlace=f+cfg.recycleSec*30; echo("cluster dead; next placement at frame "..nextPlace) end
    end
    if f>0 and f%1800==0 then result() end
    if f==cfg.timeoutMin*1800-30 then result() end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
end

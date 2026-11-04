-- Artillery snipe fixture (owner 2026-11-03, test only).
-- The host plays its own ally team (team 1, not a spectator); its commander
-- self-destructs and it gets a porc cluster around a Persecutor (cortoast) by
-- cheat give. The AI (team 0) gets long-range rocket artillery (Thanatos,
-- Arbiter, Boreas, Negotiator, Ambassador) some way off. Mode "seen": the AI's
-- ally team has global LOS the whole game. Mode "ghost": global LOS only from
-- just before the cluster is placed until losOffSec later, so the AI keeps
-- ghost images. Logs every death on both sides (with the killer's def),
-- damage on the Persecutor and a RESULT line at the end.
function widget:GetInfo()
    return {name="Arty snipe fixture",desc="Artillery vs a Persecutor porc cluster",layer=123,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/arty_snipe.lua")
local KEY=(cfg.porc[1] and cfg.porc[1][1]) or "cortoast"   -- the target: the Persecutor, or the kill-test structure
local A=0
local queue={}
local myTeam
local frameNow=0
local tracked={}    -- unitID -> {def,team,x,z}
local deaths={}     -- list of strings
local finished=false
local seenProj
local aiAlly

local function echo(s) Spring.Echo("[ArtySnipe] "..s) end
local function cmd(s) queue[#queue+1]=s end
local function give(name,team,x,z)
    cmd("give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z))
end

function widget:Initialize()
    local _,_,_,team=Spring.GetPlayerInfo(Spring.GetMyPlayerID(),false)
    myTeam=team
    local _,_,_,_,_,ally=Spring.GetTeamInfo(A,false)
    aiAlly=ally
    echo(string.format("host team=%s ai ally=%s mode=%s",tostring(myTeam),tostring(aiAlly),cfg.mode))
end

function widget:UnitCreated(u,ud,team)
    if team~=myTeam and team~=A then return end
    local d=UnitDefs[ud]
    if not d then return end
    local x,_,z=Spring.GetUnitPosition(u)
    if team==A and not cfg.artyDefs[d.name] then return end
    if team==myTeam and d.canMove and not (cfg.extraDefs or {})[d.name] then return end
    tracked[u]={def=d.name,team=team,x=x,z=z}
    local dmg=team==myTeam and (cfg.damage or {})[d.name]
    if dmg then   -- pre-damaged (BAR dev helper, cheats on); in ghost mode then seen once and turned into a ghost
        Spring.SendLuaRulesMsg(string.format("$dev$:sethealth %d:%.3f",u,dmg))
        echo(string.format("sethealth id=%d def=%s to %.1f%%",u,d.name,dmg))
    end
    echo(string.format("unit id=%d team=%d def=%s pos=(%.0f,%.0f) range=%.0f",u,team,d.name,x,z,d.maxWeaponRange or -1))
end

function widget:UnitDamaged(u,ud,team,damage,para,wd,pid,attacker,attackerDef)
    local t=tracked[u]
    if not t or t.team~=myTeam then return end
    if t.def~="cortoast" and t.def~=KEY and not (cfg.damage or {})[t.def] then return end
    if cfg.protect and t.def==KEY and not t.selfd then
        Spring.SendLuaRulesMsg(string.format("$dev$:sethealth %d:%.3f",u,100))   -- only the self-destruct may kill it
    end
    local hp,maxhp=Spring.GetUnitHealth(u)
    local armored=Spring.GetUnitArmored(u)
    echo(string.format("dmg frame=%d id=%d def=%s damage=%.0f hpNow=%.0f maxhp=%.0f armored=%s attacker=%s attackerId=%s",frameNow,u,t.def,damage,hp or -1,maxhp or -1,
        tostring(armored),attackerDef and UnitDefs[attackerDef] and UnitDefs[attackerDef].name or "-",tostring(attacker)))
end

function widget:UnitDestroyed(u,ud,team,attacker,attackerDef)
    local t=tracked[u]
    if not t then return end
    t.dead=frameNow
    local by=attackerDef and UnitDefs[attackerDef] and UnitDefs[attackerDef].name or "-"
    t.by=by
    local x,_,z=Spring.GetUnitPosition(u)
    echo(string.format("death frame=%d team=%d id=%d def=%s pos=(%.0f,%.0f) by=%s",frameNow,team,u,t.def,x or -1,z or -1,by))
end

local function result()
    local porcDead,porcAlive,artyDead,artyAlive,persecutor={}, {}, {}, {}, "absent"
    for u,t in pairs(tracked) do
        if t.team==myTeam then
            if t.def==KEY then persecutor=t.dead and ("dead frame="..t.dead.." by="..t.by) or "alive" end
            if t.dead then porcDead[#porcDead+1]=t.def.."<"..t.by else porcAlive[#porcAlive+1]=t.def end
        else
            if t.dead then artyDead[#artyDead+1]=t.def.."<"..t.by else artyAlive[#artyAlive+1]=t.def end
        end
    end
    echo(string.format("RESULT mode=%s persecutor=%s porcDead={%s} porcAlive={%s} artyDead={%s} artyAlive=%d",
        cfg.mode,persecutor,table.concat(porcDead,","),table.concat(porcAlive,","),table.concat(artyDead,","),#artyAlive))
end

local function gameFrame(f)
    frameNow=f
    if f==30 then cmd("cheat 1") end
    if f==50 then
        Spring.SelectUnitArray(Spring.GetTeamUnits(myTeam) or {})
        cmd("selfd")
        -- the host (observer) sees the AI's artillery, so its deaths and killers are logged
        local _,_,_,_,_,ally=Spring.GetTeamInfo(myTeam,false)
        cmd("globallos "..ally)
    end
    if f==(cfg.losOnAt or 60) then cmd("globallos "..aiAlly); echo("global LOS on for ally "..aiAlly) end
    if cfg.extraMove and f==(cfg.extraAt or cfg.placeAt or 300)+30 then   -- a mobile radar dot passing through range
        for u,t in pairs(tracked) do
            if t.team==myTeam and (cfg.extraDefs or {})[t.def] then Spring.GiveOrderToUnit(u,CMD.MOVE,{cfg.extraMove[1],0,cfg.extraMove[2]},0) end
        end
        echo(string.format("extra host units move to (%d,%d)",cfg.extraMove[1],cfg.extraMove[2]))
    end
    if f==(cfg.placeAt or 300) then
        for _,e in ipairs(cfg.porc) do give(e[1],myTeam,cfg.cx+e[2],cfg.cz+e[3]) end
        echo(string.format("porc cluster at (%d,%d): %d units",cfg.cx,cfg.cz,#cfg.porc))
    end
    if f==(cfg.extraAt or cfg.placeAt or 300) then
        for _,e in ipairs(cfg.extra or {}) do give(e[1],myTeam,e[2],e[3]) end
        if cfg.extra and #cfg.extra>0 then echo(string.format("extra host units: %d",#cfg.extra)) end
    end
    if f==(cfg.artyAt or 360) then
        for _,e in ipairs(cfg.arty) do give(e[1],A,cfg.ax+e[2],cfg.az+e[3]) end
        if cfg.aiRadar and not cfg.radarAt then give("armrad",A,cfg.aiRadar[1],cfg.aiRadar[2]); echo(string.format("AI radar tower at (%d,%d)",cfg.aiRadar[1],cfg.aiRadar[2])) end
        for _,e in ipairs(cfg.aiExtra or {}) do give(e[1],A,e[2],e[3]) end
        if cfg.aiExtra and #cfg.aiExtra>0 then echo(string.format("AI extra units: %d",#cfg.aiExtra)) end
        echo(string.format("artillery at (%d,%d): %d units",cfg.ax,cfg.az,#cfg.arty))
    end
    -- UnitCreated does not reach this widget for the AI's units: pick them up once they exist
    if f==(cfg.artyAt or 360)+20 then
        for _,u in ipairs(Spring.GetAllUnits() or {}) do
            if not tracked[u] and Spring.GetUnitTeam(u)==A then widget:UnitCreated(u,Spring.GetUnitDefID(u),A) end
        end
    end
    if f==(cfg.placeAt or 300)+60 then
        for u,t in pairs(tracked) do
            if (cfg.damage or {})[t.def] then
                local hp,maxhp=Spring.GetUnitHealth(u)
                echo(string.format("health id=%d def=%s hp=%s maxhp=%s",u,t.def,tostring(hp and math.floor(hp)),tostring(maxhp and math.floor(maxhp))))
            end
        end
    end
    if cfg.killAt and f==cfg.killAt then   -- the target dies out of the AI's sight: its ghost stays until the spot is seen
        local sel={}
        for u,t in pairs(tracked) do if t.team==myTeam and t.def==KEY and not t.dead then sel[#sel+1]=u; t.selfd=true end end
        Spring.SelectUnitArray(sel)
        cmd("selfd")
        -- headless has no selection, so selfd alone does nothing there: the BAR dev
        -- helper destroys it (attacker = itself, not the AI's ally team)
        for _,u in ipairs(sel) do Spring.SendLuaRulesMsg(string.format("$dev$:destroyunits %d",u)) end
        echo(string.format("self-destruct %s x%d",KEY,#sel))
    end
    if cfg.revealAt and f==cfg.revealAt then give("armeyes",A,cfg.cx+350,cfg.cz); echo(string.format("AI camera at (%d,%d): the spot is seen",cfg.cx+350,cfg.cz)) end
    if cfg.losAgainAt and f==cfg.losAgainAt then cmd("globallos "..aiAlly); echo("global LOS on again for ally "..aiAlly) end
    if cfg.losOffAt and f==cfg.losOffAt then cmd("globallos "..aiAlly); echo("global LOS off for ally "..aiAlly) end
    if cfg.holdFire and f==(cfg.placeAt or 300)+10 then
        for u,t in pairs(tracked) do if t.team==myTeam then Spring.GiveOrderToUnit(u,CMD.FIRE_STATE,{0},0) end end
        echo("host porc set to hold fire")
    end
    if cfg.aiRadar and cfg.radarAt and f==cfg.radarAt then give("armrad",A,cfg.aiRadar[1],cfg.aiRadar[2]); echo(string.format("AI radar tower at (%d,%d)",cfg.aiRadar[1],cfg.aiRadar[2])) end
    if cfg.radarOffAt and f==cfg.radarOffAt then   -- the target goes dark again
        local n=0
        for _,u in ipairs(Spring.GetTeamUnitsByDefs(A,UnitDefNames.armrad.id) or {}) do Spring.SendLuaRulesMsg(string.format("$dev$:destroyunits %d",u)); n=n+1 end
        echo(string.format("AI radar towers destroyed: %d",n))
    end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    -- every new projectile of the AI's tracked artillery (ghost-gone test: no shots after the spot is seen empty)
    if cfg.killAt then
        seenProj=seenProj or {}
        for _,pid in ipairs(Spring.GetProjectilesInRectangle(0,0,Game.mapSizeX,Game.mapSizeZ,false,false) or {}) do
            if not seenProj[pid] then
                seenProj[pid]=true
                local o=Spring.GetProjectileOwnerID(pid)
                local t=o and tracked[o]
                if t and t.team==A then echo(string.format("shot frame=%d owner=%d def=%s",f,o,t.def)) end
            end
        end
    end
    if cfg.killAt and f%150==0 then   -- lock test: the artillery must not walk forward while locked
        for u,t in pairs(tracked) do
            if t.team==A and not t.dead then
                local x,_,z=Spring.GetUnitPosition(u)
                if x then echo(string.format("pos frame=%d id=%d def=%s at=(%.0f,%.0f) dist=%.0f",f,u,t.def,x,z,math.sqrt((x-cfg.cx)^2+(z-cfg.cz)^2))) end
            end
        end
    end
    if f%1800==0 then
        local alive=0
        for u,t in pairs(tracked) do if t.team==A and not t.dead then alive=alive+1 end end
        echo(string.format("minute=%d artyAlive=%d",f/1800,alive))
    end
    if not finished then
        local p
        for u,t in pairs(tracked) do if t.def==KEY then p=t end end
        local done=(p and p.dead and f>=p.dead+cfg.afterKill*30) or f>=cfg.timeoutMin*1800
        if done then finished=true; result(); echo("DONE "..((p and p.dead) and "persecutor dead" or "timeout")) end
    end
end

local errors=0
function widget:GameFrame(f)
    local ok,err=pcall(gameFrame,f)
    if not ok then
        errors=errors+1
        if errors<=20 then echo("ERROR frame="..f.." "..tostring(err)) end
    end
end

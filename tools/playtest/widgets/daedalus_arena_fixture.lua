-- Daedalus idle arena (owner 2026-11-21, test only): gantry_march_fixture + host mobiles
-- on hold position near the gantry, dragon's teeth, Annihilators ~1750 out, and per-unit
-- move-order / first-move / first-shot logging. Lines [GantryMarch] as the original.
-- Original header:
-- Gantry march fixture (owner 2026-11-16, test only).
-- Catapults, Daedalus and Myrmidons idled near the gantry for seconds to many
-- minutes before going to the front. The host plays its own ally team (not a
-- spectator); its commander self-destructs and it gets, by cheat give, a porc
-- line across the map's diagonal and an expensive base behind it (more than 16
-- structures that outrank the porc in the ranged controller's objective list).
-- The AI (team 0) gets the three T3 ranged units at its "gantry".
-- Modes: live  - the AI has global LOS all game (identified base behind porc);
--        ghost - global LOS only for a while before the units arrive (ghosts);
--        blind - the AI never sees the host before its units walk there.
-- Measured from the host's view (independent of the AI log):
--   front  = first frame a unit is within its max weapon range + 300 of a live host porc
--   engage = first projectile of the unit (Myrmidon: or of a drone within 1500 of it)
-- One TIMING line per unit at the end, and a RESULT line.
function widget:GetInfo()
    return {name="Daedalus arena fixture",desc="T3 ranged units from gantry to front",layer=123,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/gantry_march.lua")
local moves={}  -- unitID -> {n=moves, first=frame}
local A=0
local queue={}
local myTeam
local aiAlly
local frameNow=0
local tracked={}   -- unitID -> {def,given,front,engage,range,dead,how}
local porc={}      -- host porc unitIDs
local seenProj={}
local done=false

local function echo(s) Spring.Echo("[GantryMarch] "..s) end
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

local function pickUp()
    for _,u in ipairs(Spring.GetAllUnits() or {}) do
        local team=Spring.GetUnitTeam(u)
        local d=UnitDefs[Spring.GetUnitDefID(u)]
        if d then
            if team==A and cfg.unitDefs[d.name] and not tracked[u] then
                tracked[u]={def=d.name,given=frameNow,range=d.maxWeaponRange or 0}
                local x,_,z=Spring.GetUnitPosition(u)
                echo(string.format("unit id=%d def=%s pos=(%.0f,%.0f) range=%.0f",u,d.name,x,z,d.maxWeaponRange or -1))
            elseif team==myTeam and cfg.porcDefs[d.name] and not porc[u] then
                porc[u]=true
            end
        end
    end
end

function widget:UnitDestroyed(u,ud,team,attacker,attackerDef)
    local by=attackerDef and UnitDefs[attackerDef] and UnitDefs[attackerDef].name or "-"
    if tracked[u] then
        tracked[u].dead=frameNow
        echo(string.format("death frame=%d id=%d def=%s by=%s",frameNow,u,tracked[u].def,by))
    elseif porc[u] then
        porc[u]=nil
        echo(string.format("porc death frame=%d id=%d def=%s by=%s",frameNow,u,UnitDefs[ud] and UnitDefs[ud].name or "?",by))
    end
end

function widget:UnitCommand(u,ud,team,cmdID,params)
    if not tracked[u] then return end
    local m=moves[u] or {n=0}; moves[u]=m
    if cmdID==CMD.MOVE then
        m.n=m.n+1
        if not m.first then m.first=frameNow
            local x,_,z=Spring.GetUnitPosition(u)
            echo(string.format("first move frame=%d id=%d after=%.1f to=%.0f,%.0f from=%.0f,%.0f",frameNow,u,(frameNow-tracked[u].given)/30,params[1] or -1,params[3] or -1,x or -1,z or -1))
        end
    end
end
local function secs(a,b) if a and b then return string.format("%.1f",(b-a)/30) end return "never" end

local function result()
    local n,front,engage,fsum,esum,fcount,ecount=0,0,0,0,0,0,0
    for u,t in pairs(tracked) do
        n=n+1
        local m=moves[u] or {n=0}
        echo(string.format("TIMING id=%d def=%s given=%d toFirstMove=%s toFront=%s frontToEngage=%s toEngage=%s how=%s moves=%d dead=%s",
            u,t.def,t.given,secs(t.given,m.first),secs(t.given,t.front),secs(t.front,t.engage),secs(t.given,t.engage),t.how or "-",m.n,tostring(t.dead or "no")))
        if t.front then fsum=fsum+(t.front-t.given); fcount=fcount+1 end
        if t.engage and t.front then esum=esum+(t.engage-t.front); ecount=ecount+1 end
    end
    local alive=0 for _ in pairs(porc) do alive=alive+1 end
    echo(string.format("RESULT mode=%s units=%d reachedFront=%d avgToFront=%s engaged=%d avgFrontToEngage=%s porcAlive=%d",
        cfg.mode,n,fcount,fcount>0 and string.format("%.1f",fsum/fcount/30) or "never",ecount,
        ecount>0 and string.format("%.1f",esum/ecount/30) or "never",alive))
    echo("DONE")
end

local function measure(f)
    -- front: within max weapon range + 300 of a live host porc
    for u,t in pairs(tracked) do
        if not t.dead and not t.front then
            local x,_,z=Spring.GetUnitPosition(u)
            if x then
                local r=t.range+300
                for p in pairs(porc) do
                    local px,_,pz=Spring.GetUnitPosition(p)
                    if px and (px-x)^2+(pz-z)^2<=r*r then
                        t.front=f
                        echo(string.format("front frame=%d id=%d def=%s after=%s porc=%d dist=%.0f",f,u,t.def,secs(t.given,f),p,math.sqrt((px-x)^2+(pz-z)^2)))
                        break
                    end
                end
            end
        end
    end
    -- engage: new projectiles of the tracked units or of their drones
    for _,pid in ipairs(Spring.GetProjectilesInRectangle(0,0,Game.mapSizeX,Game.mapSizeZ,false,false) or {}) do
        if not seenProj[pid] then
            seenProj[pid]=true
            local o=Spring.GetProjectileOwnerID(pid)
            if o and Spring.GetUnitTeam(o)==A then
                local t=tracked[o]
                local how="shot"
                if not t then
                    local od=UnitDefs[Spring.GetUnitDefID(o) or -1]
                    if od and od.name:find("drone") then
                        local ox,_,oz=Spring.GetUnitPosition(o)
                        local best,bd
                        for u,tt in pairs(tracked) do
                            if tt.def=="legeallterrainmech" and not tt.dead then
                                local x,_,z=Spring.GetUnitPosition(u)
                                local d2=x and ox and ((x-ox)^2+(z-oz)^2)
                                if d2 and d2<1500*1500 and (not bd or d2<bd) then best,bd=tt,d2 end
                            end
                        end
                        t=best; how="drone"
                    end
                end
                if t and not t.engage then
                    t.engage=f; t.how=how
                    echo(string.format("engage frame=%d def=%s how=%s after=%s sinceFront=%s",f,t.def,how,secs(t.given,f),secs(t.front,f)))
                end
            end
        end
    end
    if f%900==0 then
        for u,t in pairs(tracked) do
            if not t.dead then
                local x,_,z=Spring.GetUnitPosition(u)
                if x then echo(string.format("pos frame=%d id=%d def=%s at=(%.0f,%.0f)",f,u,t.def,x,z)) end
            end
        end
    end
end

function widget:GameFrame(f)
    frameNow=f
    if f==30 then cmd("cheat 1") end
    if f==50 then
        Spring.SelectUnitArray(Spring.GetTeamUnits(myTeam) or {})
        cmd("selfd")
        for _,u in ipairs(Spring.GetTeamUnits(myTeam) or {}) do Spring.SendLuaRulesMsg(string.format("$dev$:destroyunits %d",u)) end
        local _,_,_,_,_,ally=Spring.GetTeamInfo(myTeam,false)
        cmd("globallos "..ally)   -- the host sees the AI's units (measurement only)
    end
    if f==cfg.placeAt then
        for _,e in ipairs(cfg.porc) do give(e[1],myTeam,e[2],e[3]) end
        for _,e in ipairs(cfg.base) do give(e[1],myTeam,e[2],e[3]) end
        for _,e in ipairs(cfg.mobiles or {}) do give(e[1],myTeam,e[2],e[3]) end
        echo(string.format("host porc %d, base %d",#cfg.porc,#cfg.base))
    end
    if cfg.losOnAt and f==cfg.losOnAt then cmd("globallos "..aiAlly); echo("global LOS on for ally "..aiAlly) end
    if cfg.losOffAt and f==cfg.losOffAt then cmd("globallos "..aiAlly); echo("global LOS off for ally "..aiAlly) end
    if f==cfg.unitsAt then
        for _,e in ipairs(cfg.units) do give(e[1],A,e[2],e[3]) end
        echo(string.format("AI units at the gantry: %d",#cfg.units))
    end
    if f==cfg.placeAt+20 or f==cfg.unitsAt+20 then pickUp() end
    if f==cfg.placeAt+40 then
        -- host mobiles stay put (hold position, return fire only) so the AI sees still targets
        local n=0
        for _,u in ipairs(Spring.GetTeamUnits(myTeam) or {}) do
            local d=UnitDefs[Spring.GetUnitDefID(u)]
            if d and d.canMove and not d.isImmobile then
                Spring.GiveOrderToUnit(u,CMD.MOVE_STATE,{0},0); Spring.GiveOrderToUnit(u,CMD.FIRE_STATE,{1},0); n=n+1
                -- short patrol loop (rez bots reclaim, Peewees mill about): a moving radar dot
                local x,y,z=Spring.GetUnitPosition(u)
                Spring.GiveOrderToUnit(u,CMD.PATROL,{x+90,y,z-90},0)
            end
        end
        echo("host mobiles on hold position: "..n)
    end
    if f>cfg.unitsAt+20 and f%5==0 then measure(f) end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if not done and f>=cfg.unitsAt+cfg.watchSec*30 then
        done=true
        result()
    end
end

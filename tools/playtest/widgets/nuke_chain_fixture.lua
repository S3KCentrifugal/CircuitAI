-- Nuke chain-kill fixture (owner 2026-11-02, branch nuke-chain-kill, test only).
-- The host plays its own ally team (team 1, not a spectator) and owns the
-- target structures, placed with cheat give at exact coordinates. The AI
-- (team 0) gets a corsilo plus enough economy to stock it, and full LOS of the
-- map (globallos for ally 0), so its own target choice (mode "layout") or a
-- debug pos strike (mode "calib") sends the missile.
-- Logs every nuke launch/impact, every damage event on host units (weapon,
-- amount), every host death, a health snapshot 1 s after impact and a RESULT
-- line with the metal actually killed within 20 s.
function widget:GetInfo()
    return {name="Nuke chain fixture",desc="Places structure layouts and scores nuke kills",layer=123,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/nuke_chain.lua")
local A=0
local SILO={armsilo=true,corsilo=true,legsilo=true}
local queue={}
local myTeam
local frameNow=0
local tracked={}    -- unitID -> {def,x,y,z,metal,hp,shot}
local proj={}       -- projectile id -> {x,y,z,vx,vy,vz,tx,tz}
local impacts={}    -- list of {f,x,y,z,tx,tz,shot}
local shots={}      -- calib schedule
local shotIdx=0
local shotState="idle"   -- idle | armed | flying | after
local launches=0
local finished=false
local placedFrame=nil
local snapDone={}

local function echo(s) Spring.Echo("[NukeChain] "..s) end
local function cmd(s) queue[#queue+1]=s end
local function give(name,team,x,z)
    cmd("give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z))
end
local function send(msg)
    local ok=Spring.SendSkirmishAIMessage(A,msg)
    echo(string.format("send frame=%d ok=%s msg=%s",frameNow,tostring(ok),msg))
end

-- layouts: {def, dx, dz} around (cx, cz)
local LAYOUTS={
    A={{"corafus",-160,-80},{"corafus",0,-80},{"corafus",160,-80},{"corafus",-160,80},{"corafus",0,80},{"corafus",160,80}},
    B={{"armafus",-100,-100},{"armafus",100,-100},{"armafus",-100,100},{"armafus",100,100},
       {"armfus",0,-260},{"armfus",0,260},{"armfus",-260,0},{"armfus",260,0}},
    -- chain_sim.py's mixed block, shifted so its middle is at (cx, cz)
    C={{"corafus",-80,-80},{"corafus",80,-80},{"corfus",-80,80},{"corfus",80,80},{"corageo",240,0},{"corgeo",-240,0}},
    D={{"legafus",-80,-80},{"legageo",80,-80},{"legfus",-80,80},{"legfus",80,80}},
    E={{"corafus",-500,0},{"corafus",0,0},{"corafus",500,0}},
    -- decoy: the block A plus a lone corafus 1500 away
    G={{"corafus",-160,-80},{"corafus",0,-80},{"corafus",160,-80},{"corafus",-160,80},{"corafus",0,80},{"corafus",160,80},
       {"corafus",1500,0}},
    -- chain carry: 3x3 corafus 300 apart (a centre hit leaves the corners to the chain)
    H={{"corafus",-300,-300},{"corafus",0,-300},{"corafus",300,-300},{"corafus",-300,0},{"corafus",0,0},{"corafus",300,0},
       {"corafus",-300,300},{"corafus",0,300},{"corafus",300,300}},
    -- chain carry: 5 corafus in a line 450 apart (one chain step reaches the neighbours, not beyond)
    I={{"corafus",-900,0},{"corafus",-450,0},{"corafus",0,0},{"corafus",450,0},{"corafus",900,0}},
    -- other big death blasts: nuke silos and the tactical nuke (2650/R240), Legion adv
    -- storage (2650/R240), T2 converters (1220/R160), an EMP mex (paralyzer, no damage)
    J={{"armsilo",0,0},{"corsilo",260,0},{"cortron",-240,0},{"legadvestore",0,260},{"armamex",0,-240},
       {"cormmkr",-130,-130},{"cormmkr",130,-130},{"cormmkr",-130,130},{"cormmkr",130,130}},
    -- a lolcannon (33500 HP, the nuke alone cannot kill it) ringed by 4 AFUS: only the chain can
    K={{"corbuzz",0,0},{"corafus",-230,0},{"corafus",230,0},{"corafus",0,-230},{"corafus",0,230}},
    -- the same lolcannon with 2 fusions: it must not count
    L={{"corbuzz",0,0},{"corfus",-200,0},{"corfus",200,0}},
}

local later={}      -- {frame, command}: delayed gives
local function placeEco()
    local ax,az=cfg.aiStart[1],cfg.aiStart[2]
    local n=cfg.silos or 1
    -- calibration: several silos given cfg.siloStaggerSec apart, so their stock comes one by one
    for i=0,n-1 do
        local x,z=ax+700+(i%2)*200,az+900+math.floor(i/2)*200
        later[#later+1]={60+i*(cfg.siloStaggerSec or 0)*30,"give 1 corsilo "..A.." @"..x..","..math.floor(Spring.GetGroundHeight(x,z))..","..z}
    end
    for i=0,1+n do give("corafus",A,ax+1100+math.floor(i/4)*200,az+200+(i%4)*300) end
    for i=0,5*n do give("cormoho",A,ax+1600+math.floor(i/8)*160,az+(i%8)*160) end
    for i=0,3*n do give("cormmkr",A,ax+2600+math.floor(i/8)*120,az+(i%8)*120) end
    echo(string.format("supplied AI team %d: %d corsilo (%ds apart), %d corafus, %d cormoho near (%d,%d)",A,n,cfg.siloStaggerSec or 0,2+n,1+5*n,ax,az))
end

local pendingHealth={}   -- {def,x,z,pct}: set by BAR's dev helpers (cheats on) once the unit exists
local function placeLayout()
    if cfg.units then   -- an explicit list {def, x, z, health percent} (antinuke scenarios)
        for _,e in ipairs(cfg.units) do
            give(e[1],myTeam,e[2],e[3])
            if e[4] and e[4]<100 then pendingHealth[#pendingHealth+1]={e[1],e[2],e[3],e[4]} end
        end
        echo(string.format("layout %s: %d units (explicit list)",cfg.layout,#cfg.units))
        return
    end
    local L=LAYOUTS[cfg.layout]
    for _,e in ipairs(L) do give(e[1],myTeam,cfg.cx+e[2],cfg.cz+e[3]) end
    echo(string.format("layout %s at (%d,%d): %d units",cfg.layout,cfg.cx,cfg.cz,#L))
end

local function placeCalib()
    for i,s in ipairs(cfg.shots) do
        -- shot i is armed when silo i is due to hold a missile (stock time ~190 s after its give)
        shots[i]={x=s.x,z=s.z,i=i,probes=s.probes,armAt=60+(i-1)*(cfg.siloStaggerSec or 0)*30+(cfg.stockSec or 170)*30}
    end
end

local function placeProbes(s)
    local n=#s.probes
    for k,p in ipairs(s.probes) do
        local a=p[3] and math.rad(p[3]) or 2*math.pi*(k-1)/n   -- optional third field: the probe's angle in degrees
        give(p[1],myTeam,s.x+p[2]*math.cos(a),s.z+p[2]*math.sin(a))
    end
    echo(string.format("calib shot %d at (%d,%d): %d probes placed frame=%d",s.i,s.x,s.z,n,frameNow))
end

function widget:Initialize()
    local _,_,_,team=Spring.GetPlayerInfo(Spring.GetMyPlayerID(),false)
    myTeam=team
    echo(string.format("host team=%s mode=%s layout=%s",tostring(myTeam),cfg.mode,tostring(cfg.layout)))
end

local function volText(u)
    local sx,sy,sz,ox,oy,oz,vt,tt,ax=Spring.GetUnitCollisionVolumeData(u)
    return string.format("vol=%s,%s,%s type=%s axis=%s off=%s,%s,%s",tostring(sx),tostring(sy),tostring(sz),tostring(vt),tostring(ax),tostring(ox),tostring(oy),tostring(oz))
end

function widget:UnitCreated(u,ud,team)
    if team~=myTeam then return end
    local d=UnitDefs[ud]
    if not d or d.canMove then return end
    local x,y,z=Spring.GetUnitPosition(u)
    local hp,maxhp=Spring.GetUnitHealth(u)
    tracked[u]={def=d.name,x=x,y=y,z=z,metal=d.metalCost,hp=maxhp}
    for i=#pendingHealth,1,-1 do
        local h=pendingHealth[i]
        if h[1]==d.name and math.abs(h[2]-x)<16 and math.abs(h[3]-z)<16 then
            Spring.SendLuaRulesMsg(string.format("$dev$:sethealth %d:%.3f",u,h[4]))
            echo(string.format("sethealth id=%d def=%s to %.1f%%",u,d.name,h[4]))
            table.remove(pendingHealth,i)
        end
    end
    echo(string.format("unit id=%d def=%s pos=(%.0f,%.0f,%.0f) hp=%.0f metal=%.0f radius=%.1f height=%.1f xsize=%s zsize=%s %s",
        u,d.name,x,y,z,maxhp or -1,d.metalCost,d.radius or -1,d.height or -1,tostring(d.xsize),tostring(d.zsize),volText(u)))
end

function widget:UnitDamaged(u,ud,team,damage,para,wd,pid,attacker,attackerDef,attackerTeam)
    if not tracked[u] then return end
    local hp=Spring.GetUnitHealth(u)
    local w=wd and WeaponDefs[wd]
    echo(string.format("dmg frame=%d id=%d def=%s damage=%.0f weapon=%s(%s) hpNow=%.0f attacker=%s",
        frameNow,u,UnitDefs[ud].name,damage,w and w.name or "?",tostring(wd),hp or -1,attackerDef and UnitDefs[attackerDef] and UnitDefs[attackerDef].name or "-"))
end

function widget:UnitDestroyed(u,ud,team,attacker,attackerDef)
    local t=tracked[u]
    if not t then return end
    t.dead=frameNow
    echo(string.format("death frame=%d id=%d def=%s pos=(%.0f,%.0f) metal=%.0f by=%s",
        frameNow,u,t.def,t.x,t.z,t.metal,attackerDef and UnitDefs[attackerDef] and UnitDefs[attackerDef].name or "-"))
end

local function snapshot(imp)
    for u,t in pairs(tracked) do
        local d=math.sqrt((t.x-imp.x)^2+(t.z-imp.z)^2)
        if d<2000 then
            local hp=(not t.dead) and Spring.GetUnitHealth(u) or nil
            echo(string.format("snap frame=%d shot=%d id=%d def=%s dist=%.0f hp=%s maxhp=%.0f dead=%s",
                frameNow,imp.shot,u,t.def,d,hp and string.format("%.0f",hp) or "dead",t.hp,tostring(t.dead)))
        end
    end
end

local function result(imp)
    local killed,n,list=0,0,{}
    for u,t in pairs(tracked) do
        if t.dead and t.dead>=imp.f-30 and t.dead<=imp.f+600 and math.sqrt((t.x-imp.x)^2+(t.z-imp.z)^2)<2500 then
            killed=killed+t.metal; n=n+1; list[#list+1]=t.def
        end
    end
    echo(string.format("RESULT shot=%d impact=(%.0f,%.0f) aim=(%s,%s) killedMetal=%.0f killed=%d {%s}",
        imp.shot,imp.x,imp.z,tostring(imp.tx),tostring(imp.tz),killed,n,table.concat(list,",")))
end

local function nextShot()
    shotIdx=shotIdx+1
    local s=shots[shotIdx]
    if not s then finished=true; echo("DONE all shots"); return end
    shotState="wait"
end

local function armShot(f)
    local s=shots[shotIdx]
    if shotState=="wait" and s and f>=s.armAt then placeProbes(s); shotState="placing"; s.placed=f end
    if shotState=="placing" and s and f>=s.placed+40 then
        shotState="armed"
        send(string.format("barb|debug|%d|nuke|pos|%d|%d",A,s.x,s.z))
    end
end

local function gameFrame(f)
    frameNow=f
    if f==30 then cmd("cheat 1") end
    if f==40 then cmd("globallos 0") end
    if f==50 then
        local _,_,_,_,_,ally=Spring.GetTeamInfo(myTeam,false)
        cmd("globallos "..ally)
        -- the host's commander: not a target (widget orders are disallowed; the selfd action is not)
        Spring.SelectUnitArray(Spring.GetTeamUnits(myTeam) or {})
        cmd("selfd")
    end
    if f==60 then placeEco() end
    if f==(cfg.placeAt or 400) then   -- placeAt: just before the silo stocks, so raiders have no time to reach the targets
        if cfg.mode=="calib" then placeCalib() else placeLayout() end
        placedFrame=f
    end
    for i=#later,1,-1 do if f>=later[i][1] then cmd(later[i][2]); table.remove(later,i) end end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if cfg.mode=="calib" and placedFrame and f==placedFrame+1 then nextShot() end
    if cfg.mode=="calib" then armShot(f) end
    -- follow silo missiles
    local live={}
    for _,p in ipairs(Spring.GetProjectilesInRectangle(0,0,Game.mapSizeX,Game.mapSizeZ,false,false) or {}) do
        local o=Spring.GetProjectileOwnerID(p)
        local od=o and UnitDefs[Spring.GetUnitDefID(o) or -1]
        if od and SILO[od.name] and Spring.GetUnitTeam(o)==A then
            live[p]=true
            local x,y,z=Spring.GetProjectilePosition(p)
            local vx,vy,vz=Spring.GetProjectileVelocity(p)
            local m=proj[p]
            if not m then
                m={}
                local tt,tgt=Spring.GetProjectileTarget(p)
                if type(tgt)=="table" then m.tx,m.tz=tgt[1],tgt[3]
                elseif tgt then local tx,_,tz=Spring.GetUnitPosition(tgt); m.tx,m.tz=tx,tz end
                m.debug=(cfg.mode=="calib" and shotState=="armed")
                proj[p]=m
                launches=launches+1
                echo(string.format("launch frame=%d silo=%d aim=(%s,%s)",f,o,tostring(m.tx and math.floor(m.tx)),tostring(m.tz and math.floor(m.tz))))
                if cfg.mode=="calib" and shotState=="armed" then
                    send(string.format("barb|debug|%d|nuke|off",A)); shotState="flying"
                end
            end
            m.x,m.y,m.z,m.vx,m.vy,m.vz=x,y,z,vx,vy,vz
        end
    end
    for p,m in pairs(proj) do
        if not live[p] then
            proj[p]=nil
            -- extrapolate the last sample to the ground
            local gy=Spring.GetGroundHeight(m.x,m.z)
            local ix,iz=m.x,m.z
            if m.vy and m.vy<0 then local t=(m.y-gy)/(-m.vy); ix=m.x+m.vx*t; iz=m.z+m.vz*t end
            local imp={f=f,x=ix,y=Spring.GetGroundHeight(ix,iz),z=iz,tx=m.tx and math.floor(m.tx),tz=m.tz and math.floor(m.tz),shot=(cfg.mode=="calib") and (m.debug and shotIdx or 0) or launches,debug=m.debug}
            impacts[#impacts+1]=imp
            echo(string.format("impact frame=%d at=(%.1f,%.1f,%.1f) last=(%.0f,%.0f,%.0f) aim=(%s,%s) shot=%d",f,ix,imp.y,iz,m.x,m.y,m.z,tostring(imp.tx),tostring(imp.tz),imp.shot))
        end
    end
    for _,imp in ipairs(impacts) do
        if f==imp.f+30 then snapshot(imp) end
        if f==imp.f+600 then
            snapshot(imp); result(imp)
            if cfg.mode=="calib" then if imp.debug then nextShot() end
            elseif not finished then finished=true; echo("DONE layout "..cfg.layout) end
        end
    end
    if f%1800==0 then
        local st={}
        for _,u in ipairs(Spring.GetTeamUnits(A) or {}) do
            local d=UnitDefs[Spring.GetUnitDefID(u)]
            if d and SILO[d.name] then st[#st+1]=tostring((Spring.GetUnitStockpile(u))) end
        end
        echo(string.format("minute=%d launches=%d silo stock=%s shot=%d state=%s",f/1800,launches,table.concat(st,","),shotIdx,shotState))
    end
    if not finished and f>=(cfg.timeoutMin or 20)*1800 then finished=true; echo("DONE timeout") end
end

local errors=0
function widget:GameFrame(f)
    local ok,err=pcall(gameFrame,f)
    if not ok then
        errors=errors+1
        if errors<=20 then echo("ERROR frame="..f.." "..tostring(err)) end
    end
end

-- Debug strike fixture (owner 2026-10-31, branch debug-widget-test). The host
-- plays team 2 (its own ally team, a real player, not a spectator) and sends
-- the team link widget's debug commands to the striker AI (team 0) the way the
-- widget does (Spring.SendSkirmishAIMessage). Team 1 is the eco AI.
-- The fixture only supplies what the run cannot wait for, each logged as
-- "supplied": a silo or cannon the AI has not built by the cutoff minute, and
-- the host's base (placed in the cannon's reach once a cannon stands). Then it
-- runs the strikes in order and follows every silo and cannon projectile to
-- its end, logging its aim (engine projectile target) and where it ended.
-- The host sees the whole map (globallos for its own ally team) so it can follow
-- the shots; the AIs' sight is untouched unless a player strike finds nothing
-- scouted for StrikeScoutWait seconds (then globallos for the striker, logged).
function widget:GetInfo()
    return {name="Debug strike fixture",desc="Sends debug strikes to the striker AI and scores where they land",layer=122,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/debug_strike.lua")
local A,B=0,1
local SILO={armsilo=true,corsilo=true,legsilo=true}
local LOL={armvulc=true,corbuzz=true,legstarfall=true}
local NUKE_R,LOL_R=640,cfg.lolRadius or 150      -- scoring radii: nuke blast (aoe 1280), cannon splash + spread
local queue={}
local me,myTeam
local silos,cannons={}, {}
local proj={}        -- id -> {w="nuke"|"lol", owner, x,y,z, tx,tz, tu, tteam, strike, f0}
local strikes={}     -- the schedule, see below
local cur=0          -- index of the running strike
local stage="wait"   -- wait | run | after | done
local stageFrame=0
local placedSilo,placedLol,placedBase=false,false,false
local baseX,baseZ
local losGiven=false
local doneSeen=false
local frameNow=0

local function echo(s) Spring.Echo("[DebugTest] "..s) end
local function cmd(s) queue[#queue+1]=s end
local function give(name,team,x,z)
    cmd("give 1 "..name.." "..team.." @"..math.floor(x)..","..math.floor(Spring.GetGroundHeight(x,z))..","..math.floor(z))
end
local function send(msg)
    local ok=Spring.SendSkirmishAIMessage(A,msg)
    echo(string.format("send frame=%d ok=%s msg=%s",frameNow,tostring(ok),msg))
end
local function dist(x1,z1,x2,z2) return math.sqrt((x1-x2)^2+(z1-z2)^2) end
local function built(u)
    local _,_,_,_,bp=Spring.GetUnitHealth(u); return bp and bp>=1
end
local function count(set) local n=0 for u in pairs(set) do if Spring.ValidUnitID(u) and not Spring.GetUnitIsDead(u) and built(u) then n=n+1 end end return n end
local function firstOf(set) for u in pairs(set) do if Spring.ValidUnitID(u) and not Spring.GetUnitIsDead(u) and built(u) then return u end end end

function widget:Initialize()
    me=Spring.GetMyPlayerID()
    local name,active,spec,team,ally=Spring.GetPlayerInfo(me,false)
    myTeam=team
    echo(string.format("host player id=%d name=%s spectator=%s team=%s allyteam=%s",me,tostring(name),tostring(spec),tostring(team),tostring(ally)))
end

-- one strike: weapon, mode, the message tail, how it ends
local function schedule()
    local bx,bz=cfg.startB[1],cfg.startB[2]
    local c=firstOf(cannons)
    local cx,_,cz=Spring.GetUnitPosition(c)
    -- the lol position: the eco base if a cannon reaches it, else 4000 toward it
    local d=dist(cx,cz,bx,bz)
    local lx,lz=bx,bz
    if d>cfg.lolRange-400 then lx=cx+(bx-cx)*4000/d; lz=cz+(bz-cz)*4000/d end
    local ex=bx+(cfg.nukeOffsetX or 0); local ez=bz+(cfg.nukeOffsetZ or 0)
    strikes={
        {name="nuke-pos",w="nuke",tail=string.format("nuke|pos|%d|%d",ex,ez),x=ex,z=ez,launches=cfg.nukeLaunches,maxSec=cfg.nukePosSec,after=60},
        {name="lol-pos",w="lol",tail=string.format("lol|pos|%d|%d",lx,lz),x=lx,z=lz,sec=cfg.lolSec,after=40},
        {name="nuke-player",w="nuke",tail="nuke|player|"..me,team=myTeam,untilDone=true,maxSec=cfg.nukePlayerSec,after=60},
        {name="lol-player",w="lol",tail="lol|player|"..me,team=myTeam,sec=cfg.lolSec,after=40},
        {name="nuke-team",w="nuke",tail="nuke|team|"..B,team=B,launches=2,maxSec=cfg.nukePosSec,after=60},
        {name="lol-team",w="lol",tail="lol|team|"..B,team=B,sec=cfg.lolSec,after=40},
    }
    for i,s in ipairs(strikes) do s.i=i; s.shots=0; s.inR=0; s.onTeam=0; s.aimTeam=0; s.ended=0; s.kills=0; s.afterShots=0; s.afterInR=0; s.in300=0; s.in600=0; s.endOther=0; s.carry=0; s.blastTarget=0; s.blastOther=0; s.otherKills=0 end
    echo(string.format("schedule cannon=%d at (%.0f,%.0f) eco start (%.0f,%.0f) cannon->eco %.0f lol aim (%.0f,%.0f) nuke aim (%.0f,%.0f)",c,cx,cz,bx,bz,d,lx,lz,ex,ez))
end

local function giveBase()
    -- five groups 700 apart (one nuke cannot take them all): fusions,
    -- an advanced fusion, converters, mexes and a lab
    for g,o in ipairs({{0,0},{700,0},{-700,0},{0,700},{0,-700}}) do
        local x,z=baseX+o[1],baseZ+o[2]
        for i=0,1 do give("armfus",myTeam,x-120+i*240,z-150) end
        if g==1 then give("armafus",myTeam,x,z+250) end
        for i=0,2 do give("armmakr",myTeam,x-120+i*120,z+120) end
        give("armmex",myTeam,x+250,z+250)
        if g==2 then give("armlab",myTeam,x,z+380) end
    end
end

local function hostStructures()
    local n=0
    for _,u in ipairs(Spring.GetTeamUnits(myTeam) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(u)]
        if d and not d.canMove then n=n+1 end
    end
    return n
end

local function placeBase(c)
    -- the host's base: in the cannon's reach (4300 out), as far from the eco
    -- start as that allows, on land
    local cx,_,cz=Spring.GetUnitPosition(c)
    local bx,bz=cfg.startB[1],cfg.startB[2]
    local ax,az=cfg.startA[1],cfg.startA[2]
    local best,bd=nil,-1
    for i=0,71 do
        local a=2*math.pi*i/72
        local x,z=cx+4300*math.cos(a),cz+4300*math.sin(a)
        if x>300 and z>300 and x<Game.mapSizeX-300 and z<Game.mapSizeZ-300 and Spring.GetGroundHeight(x,z)>5 then
            local s=math.min(dist(x,z,bx,bz),dist(x,z,ax,az)*1.5)
            if s>bd then best,bd={x,z},s end
        end
    end
    if not best then echo("no land for the host base"); return end
    baseX,baseZ=best[1],best[2]
    giveBase()
    placedBase=true
    echo(string.format("supplied host base (team %d) at (%.0f,%.0f): 5 groups 700 apart, 10 armfus, 1 armafus, 15 armmakr, 5 armmex, 1 armlab; from eco start %.0f, from cannon %.0f",
        myTeam,baseX,baseZ,dist(baseX,baseZ,bx,bz),dist(baseX,baseZ,cx,cz)))
end

local function supplyMissing(f)
    local ax,az=cfg.startA[1],cfg.startA[2]
    local bx,bz=cfg.startB[1],cfg.startB[2]
    local d=dist(ax,az,bx,bz)
    if not placedSilo and count(silos)==0 and f>=cfg.siloCutoffMin*1800 then
        give("armsilo",A,ax+(bx-ax)*600/d+200,az+(bz-az)*600/d); placedSilo=true
        echo(string.format("supplied armsilo to team %d at minute %.1f (the AI had built none)",A,f/1800))
    end
    if not placedLol and count(cannons)==0 and f>=cfg.lolCutoffMin*1800 then
        local r=cfg.lolRange-1200
        give("armvulc",A,bx+(ax-bx)*r/d,bz+(az-bz)*r/d); placedLol=true
        echo(string.format("supplied armvulc to team %d at minute %.1f, %d from the eco start (the AI had built none)",A,f/1800,r))
    end
end

local function strikeOn(s) return s and stage=="run" end

local function launchStrike(f)
    local s=strikes[cur]
    stage="run"; stageFrame=f; doneSeen=false; s.f0=f; s.first=nil
    if s.team then echo(string.format("strike %d %s target team %d", cur, s.name, s.team)) end
    send("barb|debug|"..A.."|"..s.tail)
end

local function begin(i,f)
    cur=i
    local s=strikes[i]
    -- a strike on the host needs a host base: the earlier strikes may have
    -- levelled it; put it back and give the striker the settle time to see it
    if s.team==myTeam and baseX and hostStructures()<20 then
        giveBase(); stage="prep"; stageFrame=f
        echo(string.format("supplied host base again for %s (host had %d structures); settle %ds",s.name,hostStructures(),cfg.resupplySettleSec or 20))
        return
    end
    launchStrike(f)
end

local function finish(f,why)
    local s=strikes[cur]
    send("barb|debug|"..A.."|"..s.w.."|off")
    s.offFrame=f; s.why=why
    stage="after"; stageFrame=f
end

local function report(s)
    local seconds=((s.offFrame or frameNow)-s.f0)/30
    echo(string.format("RESULT %s shots=%d ended=%d inRadius=%d aimOnTargetTeam=%d endOnTargetTeam=%d targetKills=%d firstShotSec=%s strikeSec=%.0f why=%s afterOffShots=%d afterOffNearTarget=%d in300=%d in600=%d endOtherTeam=%d carryover=%d blastOnTarget=%d blastOnOtherEnemy=%d otherKills=%d",
        s.name,s.shots,s.ended,s.inR,s.aimTeam,s.onTeam,s.kills,
        s.first and string.format("%.1f",(s.first-s.f0)/30) or "none",seconds,tostring(s.why),s.afterShots,s.afterInR,s.in300,s.in600,s.endOther,s.carry,s.blastTarget,s.blastOther,s.otherKills))
end

function widget:RecvSkirmishAIMessage(team,data)
    if type(data)=="string" and string.find(data,"debug",1,true) then
        echo(string.format("ai state team=%d frame=%d %s",team,frameNow,data))
        local s=strikes[cur]
        -- "barb|debug|<team>|<ally>|<nuke state>|<lol state>": the nuke state ends as "done ..."
        if s and s.untilDone and stage=="run" and string.find(data,"|done ",1,true) then doneSeen=true end
    end
end

function widget:UnitDestroyed(u,ud,team,attacker,attackerDef,attackerTeam)
    if silos[u] or cannons[u] then silos[u]=nil; silos[-u]=nil; cannons[u]=nil; cannons[-u]=nil end
    local d=attackerDef and UnitDefs[attackerDef]
    local s=strikes[cur]
    if d and (SILO[d.name] or LOL[d.name]) then
        echo(string.format("kill frame=%d victim=%s team=%d by=%s strike=%s",frameNow,UnitDefs[ud].name,team,d.name,s and s.name or "-"))
        if s and stage=="run" and s.team and ((s.w=="nuke")==(SILO[d.name]==true)) then
            if team==s.team then s.kills=s.kills+1 elseif team~=A then s.otherKills=s.otherKills+1 end
        end
    end
end

local function nearestTeam(x,z,r)
    local best,bd=nil,r*r
    for _,u in ipairs(Spring.GetUnitsInCylinder(x,z,r) or {}) do
        local ux,_,uz=Spring.GetUnitPosition(u)
        local dd=(ux-x)^2+(uz-z)^2
        if dd<=bd then best,bd=Spring.GetUnitTeam(u),dd end
    end
    return best
end

local function gameFrame(f)
    frameNow=f
    if f==30 then cmd("cheat 1") end
    if f==45 then
        local _,_,_,_,_,ally=Spring.GetTeamInfo(myTeam,false)
        cmd("globallos "..ally)
        echo("host ally team "..ally.." sees the map (the AIs' sight untouched)")
    end
    if #queue>0 then Spring.SendCommands(table.remove(queue,1)) end
    if f%30==0 then
        for _,u in ipairs(Spring.GetTeamUnits(A) or {}) do
            local d=UnitDefs[Spring.GetUnitDefID(u)]
            if d and SILO[d.name] and not silos[u] then silos[u]=true; echo(string.format("striker %s %d started frame=%d",d.name,u,f)) end
            if d and LOL[d.name] and not cannons[u] then cannons[u]=true; echo(string.format("striker %s %d started frame=%d",d.name,u,f)) end
        end
        for set,label in pairs({[silos]="silo",[cannons]="cannon"}) do
            local fresh={}
            for u in pairs(set) do
                if u>0 and Spring.ValidUnitID(u) and built(u) and not set[-u] then fresh[#fresh+1]=u end
            end
            for _,u in ipairs(fresh) do set[-u]=true; echo(string.format("striker %s %d complete frame=%d minute=%.1f",label,u,f,f/1800)) end
        end
        supplyMissing(f)
    end
    if f%1800==0 then
        local st={}
        for u in pairs(silos) do if u>0 and Spring.ValidUnitID(u) then st[#st+1]=tostring(Spring.GetUnitStockpile(u) or -1) end end
        local eco={}
        for _,u in ipairs(Spring.GetTeamUnits(B) or {}) do
            local n=UnitDefs[Spring.GetUnitDefID(u)].name
            if n:find("fus") or n:find("mmkr") or n:find("makr") or n:find("geo") then eco[n]=(eco[n] or 0)+1 end
        end
        local e={} for n,k in pairs(eco) do e[#e+1]=n.."="..k end
        echo(string.format("minute=%d silos=%d stock=%s cannons=%d eco={%s} stage=%s strike=%d",f/1800,count(silos),table.concat(st,","),count(cannons),table.concat(e,","),stage,cur))
    end
    -- the host base, once a cannon stands
    if not placedBase and count(cannons)>0 then placeBase(firstOf(cannons)) end
    -- the schedule: starts when a cannon stands and a silo holds a missile
    if stage=="wait" and placedBase and f%30==0 and f>(cfg.baseSettleSec or 90)*30 then
        local s=firstOf(silos)
        if s and (not strikes[1]) then   -- an enemy silo's stock is hidden from a playing host: start once it stands
            -- give the scouts the settle time after the host base appears
            if not cfg._baseFrame then cfg._baseFrame=f end
            if f-cfg._baseFrame>=(cfg.baseSettleSec or 90)*30 then schedule(); begin(1,f) end
        end
    end
    local s=strikes[cur]
    if stage=="prep" and s and (f-stageFrame)/30>=(cfg.resupplySettleSec or 20) then launchStrike(f) end
    if stage=="run" and s then
        local el=(f-s.f0)/30
        local nukeFlying=false
        for _,m in pairs(proj) do if m.w=="nuke" then nukeFlying=true end end
        if s.untilDone and doneSeen then finish(f,"done (AI)")
        elseif s.untilDone and s.lastShot and not nukeFlying and (f-s.lastShot)/30>=150 then finish(f,"quiet")
        elseif s.launches and s.shots>=s.launches and not nukeFlying then finish(f,"launches")
        elseif s.sec and el>=s.sec then finish(f,"time")
        elseif s.maxSec and el>=s.maxSec then finish(f,"timeout")
        end
        if s.team and not losGiven and el>=cfg.strikeScoutWait and s.shots==0 then
            cmd("globallos 0"); losGiven=true
            echo(string.format("strike %s: no shot after %ds, the striker's ally team now sees the map",s.name,cfg.strikeScoutWait))
        end
    elseif stage=="after" and s and (f-stageFrame)/30>=s.after then
        report(s)
        if cur<#strikes then begin(cur+1,f) else stage="done"; echo("DONE all strikes") end
    end
    -- follow every silo and cannon projectile
    local live={}
    for _,p in ipairs(Spring.GetProjectilesInRectangle(0,0,Game.mapSizeX,Game.mapSizeZ,false,false) or {}) do
        local o=Spring.GetProjectileOwnerID(p)
        -- the owner's def and team now, not only the remembered id: ids are
        -- reused, and a dead cannon's id fired another team's turret shots
        local w=nil
        if o and (silos[o] or cannons[o]) and Spring.GetUnitTeam(o)==A then
            local od=UnitDefs[Spring.GetUnitDefID(o) or -1]
            w=od and (SILO[od.name] and "nuke" or LOL[od.name] and "lol") or nil
        end
        if w then
            live[p]=true
            local x,y,z=Spring.GetProjectilePosition(p)
            local m=proj[p]
            if not m then
                m={w=w,owner=o,f0=f,strike=(s and s.w==w and (stage=="run" or stage=="after")) and cur or 0,phase=stage}
                local tt,tgt=Spring.GetProjectileTarget(p)
                if tt==string.byte('u') and tgt then
                    m.tu=tgt; m.tteam=Spring.GetUnitTeam(tgt)
                    local tx,_,tz=Spring.GetUnitPosition(tgt); m.tx,m.tz=tx,tz
                elseif type(tgt)=="table" then m.tx,m.tz=tgt[1],tgt[3]; m.tteam=nearestTeam(tgt[1],tgt[3],120) end
                proj[p]=m
                local st=strikes[m.strike]
                if st then
                    if m.phase=="run" then
                        st.shots=st.shots+1; st.first=st.first or f; st.lastShot=f
                        if st.team and m.tteam==st.team then st.aimTeam=st.aimTeam+1 end
                    else st.afterShots=st.afterShots+1 end
                end
                if w=="nuke" then
                    -- who stands inside the blast at the aim when it launches
                    local by={}
                    if m.tx then for _,u in ipairs(Spring.GetUnitsInCylinder(m.tx,m.tz,NUKE_R) or {}) do local t=Spring.GetUnitTeam(u); by[t]=(by[t] or 0)+1 end end
                    local txt={} for t,n in pairs(by) do txt[#txt+1]="t"..t.."="..n end
                    if st and m.phase=="run" and st.team then
                        if (by[st.team] or 0)>0 then st.blastTarget=st.blastTarget+1 end
                        for t,n in pairs(by) do if t~=st.team and t~=A and n>0 then st.blastOther=st.blastOther+1; break end end
                    end
                    echo(string.format("launch frame=%d silo=%d strike=%s phase=%s aim=(%s,%s) aimTeam=%s blast={%s}",f,o,st and st.name or "-",m.phase,tostring(m.tx and math.floor(m.tx)),tostring(m.tz and math.floor(m.tz)),tostring(m.tteam),table.concat(txt,",")))
                end
            end
            m.x,m.y,m.z=x,y,z
        end
    end
    for p,m in pairs(proj) do
        if not live[p] then
            proj[p]=nil
            local st=strikes[m.strike]
            local h=m.y-Spring.GetGroundHeight(m.x,m.z)
            local endTeam=nearestTeam(m.x,m.z,m.w=="nuke" and NUKE_R or LOL_R)
            local dT=st and st.x and dist(m.x,m.z,st.x,st.z)
            local r=(m.w=="nuke") and NUKE_R or LOL_R
            if st then
                if m.phase=="run" then
                    st.ended=st.ended+1
                    if dT and dT<=r then st.inR=st.inR+1 end
                    if dT and dT<=300 then st.in300=st.in300+1 end
                    if dT and dT<=600 then st.in600=st.in600+1 end
                    if st.team and endTeam and endTeam~=st.team then st.endOther=st.endOther+1 end
                    if st.team and endTeam==st.team then st.onTeam=st.onTeam+1 end
                elseif dT and dT<=r then st.afterInR=st.afterInR+1 end
            end
            if m.w=="nuke" or (f%30==0) or (st and st.ended<=3) then
                echo(string.format("end %s frame=%d strike=%s phase=%s at=(%.0f,%.0f) height=%.0f fromTarget=%s nearestTeam=%s aim=(%s,%s)",
                    m.w,f,st and st.name or "-",m.phase,m.x,m.z,h,dT and string.format("%.0f",dT) or "-",tostring(endTeam),
                    tostring(m.tx and math.floor(m.tx)),tostring(m.tz and math.floor(m.tz))))
            end
        end
    end
    if f%900==0 and s and stage=="run" then
        echo(string.format("progress %s frame=%d shots=%d ended=%d inRadius=%d aimOnTeam=%d endOnTeam=%d kills=%d",s.name,f,s.shots,s.ended,s.inR,s.aimTeam,s.onTeam,s.kills))
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

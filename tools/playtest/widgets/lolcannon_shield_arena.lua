-- Lolcannon vs shields arena (owner 2026-11-20). The host plays its own team
-- (ally 2) and owns the cannons; team 0 (NullAI, ally 0) owns the targets and
-- the shields. Five lanes run one trial each per round: a target (advanced
-- fusion or fusion) and N shields laid out round it, charged to full, then the
-- lane's cannon is ordered to attack the target (hold fire otherwise) until it
-- dies or the timeout. Every shell is followed to its end: absorbed by a
-- shield (the sphere it ended on) or on the ground (its offset from the target
-- along the line of fire and across it). After a death the features at the
-- target are logged (the wreck). Between rounds every unit of a lane and every
-- wreck is removed. Config: LuaUI/Config/lolshield_arena.lua (the runner).
function widget:GetInfo()
    return {name="Lolcannon shield arena",desc="Times lolcannon kills through shields",layer=123,enabled=true}
end

local cfg=VFS.Include("LuaUI/Config/lolshield_arena.lua")
local function log(s) Spring.Echo("[LolShield] "..s) end
local myTeam
local frameNow=0
local queue={}            -- console commands, a few per frame
local function cmd(s) queue[#queue+1]=s end
local function give(name,team,x,z)
    cmd(string.format("give 1 %s %d @%d,%d,%d",name,team,math.floor(x),math.floor(Spring.GetGroundHeight(x,z)),math.floor(z)))
end

local LANES={}
local TRIALS=cfg.trials   -- {n=, layout=, seed=}
local nextTrial=1
local round=0
local stage="boot"        -- boot | spawn | charge | fire | after | clean | done
local stageFrame=0
local pending={}          -- def name -> list of {lane, role, x, z}
local shieldWeapon={}     -- unitDefID -> weapon number of its shield
local SHIELD_R=550
local gravity             -- elmos / s^2
local mainWeapon          -- the cannon's shell (the Starfall's charger weapon fires its own)

local function dist2(ax,az,bx,bz) return (ax-bx)^2+(az-bz)^2 end
local function rnd(seed)  -- small LCG per trial so layouts repeat by seed
    local s=seed
    return function() s=(s*1103515245+12345)%2147483648; return s/2147483648 end
end

-- shields laid out in the target's frame: u away from the cannon, v across
local function layout(t,rng)
    local out={}
    local n=t.n
    if n<=0 then return out end
    if t.layout=="ring" then
        local phase=rng()*2*math.pi
        local r=cfg.ringRadius or 260
        for i=1,n do local a=phase+(i-1)*2*math.pi/n; out[#out+1]={math.cos(a)*r,math.sin(a)*r} end
    elseif t.layout=="random" then
        local tries=0
        while #out<n and tries<5000 do
            tries=tries+1
            local a=rng()*2*math.pi
            local r=130+rng()*((cfg.randomMax or 440)-130)
            local u,v=math.cos(a)*r,math.sin(a)*r
            local ok=true
            for _,p in ipairs(out) do if dist2(u,v,p[1],p[2])<100*100 then ok=false break end end
            if ok then out[#out+1]={u,v} end
        end
    elseif t.layout=="front" then
        -- half round the target, half in front of it (towards the cannon), on the line of fire
        local ring=math.ceil(n/2)
        local phase=rng()*2*math.pi
        for i=1,ring do local a=phase+(i-1)*2*math.pi/ring; out[#out+1]={math.cos(a)*260,math.sin(a)*260} end
        for i=1,n-ring do out[#out+1]={-(620+(i-1)*120), (rng()-0.5)*240} end
    end
    return out
end

local function laneCount() return #LANES end

function widget:Initialize()
    myTeam=Spring.GetMyTeamID()
    gravity=Game.gravity
    for udid,ud in pairs(UnitDefs) do
        for i,w in ipairs(ud.weapons or {}) do
            local wd=WeaponDefs[w.weaponDef]
            if wd and (wd.shieldPower or 0)>0 then shieldWeapon[udid]=i break end
        end
    end
    mainWeapon=UnitDefNames[cfg.cannon].weapons[1].weaponDef
    for i,z in ipairs(cfg.laneZ) do
        LANES[i]={i=i,cx=cfg.cannonX,cz=z,tx=cfg.cannonX+cfg.range,tz=z,cannon=nil,target=nil,shields={},trial=nil,proj={},res=nil}
    end
    log(string.format("loaded cannon=%s target=%s shield=%s lanes=%d trials=%d range=%d gravity=%.2f myTeam=%d",
        cfg.cannon,cfg.target,cfg.shield,#LANES,#TRIALS,cfg.range,gravity,myTeam))
end

local function expect(name,lane,role,x,z)
    pending[name]=pending[name] or {}
    table.insert(pending[name],{lane=lane,role=role,x=x,z=z})
end

local claimed={}
local function claim(id,udid)
    if claimed[id] then return end
    local ud=UnitDefs[udid]; if not ud then return end
    local list=pending[ud.name]; if not list then return end
    local x,_,z=Spring.GetUnitPosition(id)
    local best,bi=1e18,nil
    for i,p in ipairs(list) do local d=dist2(x,z,p.x,p.z) if d<best then best,bi=d,i end end
    if not bi or best>200*200 then return end
    local p=table.remove(list,bi)
    claimed[id]=true
    local L=LANES[p.lane]
    if p.role=="cannon" then
        L.cannon=id
        Spring.GiveOrderToUnit(id,CMD.FIRE_STATE,{cfg.fireState or 0},0)
    elseif p.role=="target" then L.target=id
    elseif p.role=="shield" then L.shields[#L.shields+1]=id end
end
function widget:UnitCreated(id,udid,team) claim(id,udid) end
-- enemy units raise no UnitCreated for a widget: look for them at their spots
local function pollPending()
    for name,list in pairs(pending) do
        for i=#list,1,-1 do
            local p=list[i]
            if p then
                for _,id in ipairs(Spring.GetUnitsInCylinder(p.x,p.z,60) or {}) do
                    local udid=Spring.GetUnitDefID(id)
                    if udid and UnitDefs[udid].name==name and not claimed[id] then claim(id,udid) break end
                end
            end
        end
    end
end

-- the shield sphere: the shield weapon's emit point (as the game's shield gadget reads it)
local function shieldCenter(id)
    local udid=Spring.GetUnitDefID(id)
    local w=udid and shieldWeapon[udid]
    if w then
        local x,y,z=Spring.GetUnitWeaponVectors(id,w)
        if x then return x,y,z end
    end
    local x,y,z=Spring.GetUnitPosition(id)
    return x,y,z
end

-- The planned AI model: the cannon's low (Ragnarok, Calamity) or high
-- (Starfall) ballistic arc from the muzzle to the target's middle, sampled every
-- 16 elmos; every live shield sphere it enters counts.
local function arcCount(L)
    local _,_,_,tx,ty,tz=Spring.GetUnitPosition(L.target,true)
    if not tx then return -1,0,0 end
    local mx,my,mz=L.cx,Spring.GetGroundHeight(L.cx,L.cz)+(cfg.muzzle or 120),L.cz
    local dx,dz=tx-mx,tz-mz
    local d=math.sqrt(dx*dx+dz*dz)
    local h=ty-my
    local v=cfg.speed
    local g=gravity
    -- tan(theta) = (v^2 -+ sqrt(v^4 - g(g d^2 + 2 h v^2))) / (g d)
    local disc=v^4-g*(g*d*d+2*h*v*v)
    if disc<0 then return -1,0 end
    local root=math.sqrt(disc)
    local tanT=(cfg.high and (v*v+root) or (v*v-root))/(g*d)
    local th=math.atan(tanT)
    local vx,vy=v*math.cos(th),v*math.sin(th)
    local centers={}
    for _,s in ipairs(L.shields) do
        if Spring.ValidUnitID(s) and not Spring.GetUnitIsDead(s) then local x,y,z=shieldCenter(s) centers[#centers+1]={x,y,z} end
    end
    local inside={}
    local steps=math.max(2,math.floor(d/16))
    local cover=0
    for i=0,steps do
        local s=d*i/steps
        local t=s/vx
        local px,pz=mx+dx*s/d,mz+dz*s/d
        local py=my+vy*t-0.5*g*t*t
        for k,c in ipairs(centers) do
            if not inside[k] and (px-c[1])^2+(py-c[2])^2+(pz-c[3])^2<SHIELD_R*SHIELD_R then inside[k]=true end
        end
    end
    local n=0 for _ in pairs(inside) do n=n+1 end
    for _,c in ipairs(centers) do if (tx-c[1])^2+(ty-c[2])^2+(tz-c[3])^2<SHIELD_R*SHIELD_R then cover=cover+1 end end
    return n,cover,math.deg(th)
end

local function startRound()
    round=round+1
    pending={}
    local any=false
    for _,L in ipairs(LANES) do
        L.trial=nil; L.target=nil; L.shields={}; L.proj={}; L.res=nil
        if nextTrial<=#TRIALS then
            local t=TRIALS[nextTrial]; nextTrial=nextTrial+1
            L.trial=t; any=true
            local rng=rnd(t.seed)
            -- the line of fire: u = from the cannon to the target
            local ux,uz=(L.tx-L.cx)/cfg.range,(L.tz-L.cz)/cfg.range
            local vx,vz=-uz,ux
            expect(cfg.target,L.i,"target",L.tx,L.tz)
            give(cfg.target,0,L.tx,L.tz)
            for _,p in ipairs(layout(t,rng)) do
                local x,z=L.tx+ux*p[1]+vx*p[2],L.tz+uz*p[1]+vz*p[2]
                expect(cfg.shield,L.i,"shield",x,z)
                give(cfg.shield,0,x,z)
            end
        end
    end
    if not any then stage="done"; log("DONE all trials rounds="..(round-1)); return end
    stage="spawn"; stageFrame=frameNow
end

local function shieldPower(id)
    local udid=Spring.GetUnitDefID(id)
    local w=udid and shieldWeapon[udid]
    local _,p=Spring.GetUnitShieldState(id,w)
    -- the game's shield gadget keeps the real on/off in a rules param (index 531313)
    local rp=Spring.GetUnitRulesParam(id,531313)
    local on
    if rp~=nil then on=(rp~=0) else on=(p or 0)>1 end
    return p or 0, on
end

local function allCharged()
    for _,L in ipairs(LANES) do
        if L.trial then
            if not L.target then return false end
            if #L.shields<L.trial.n then return false end
            for _,s in ipairs(L.shields) do
                local p=shieldPower(s)
                if p<(cfg.chargeTo or 6100) then return false end
            end
        end
    end
    return true
end

local function fire()
    for _,L in ipairs(LANES) do
        if L.trial and L.target and L.cannon then
            local n,cover,theta=arcCount(L)
            local sx,sy,sz=nil,nil,nil
            if L.shields[1] then
                local cx,cy,cz=shieldCenter(L.shields[1])
                local ux,uy,uz=Spring.GetUnitPosition(L.shields[1])
                sy=cy-uy
            end
            local _,_,_,_,_=Spring.GetUnitHealth(L.target)
            L.res={fired=0,absorbed=0,ground=0,start=frameNow,first=nil,dead=nil,along={},side={},hits=0,breaks=0,model=n,cover=cover,theta=theta or 0,
                   shieldOn={},byShield={}}
            for _,s in ipairs(L.shields) do local _,on=shieldPower(s) L.res.shieldOn[s]=on end
            Spring.GiveOrderToUnit(L.cannon,CMD.ATTACK,{L.target},0)
            log(string.format("FIRE round=%d lane=%d n=%d layout=%s seed=%d arc_shields=%d cover_shields=%d arc_deg=%.1f shield_emit_dy=%s",
                round,L.i,L.trial.n,L.trial.layout,L.trial.seed,n,cover,theta or -1,sy and string.format("%.1f",sy) or "-"))
        end
    end
    stage="fire"; stageFrame=frameNow
end

-- the shells of each lane's cannon
local function trackProjectiles()
    for _,L in ipairs(LANES) do
        local R=L.res
        if R and L.cannon and not R.closed then
            local x1,z1=math.min(L.cx,L.tx)-1500,L.cz-1500
            local x2,z2=math.max(L.cx,L.tx)+1500,L.cz+1500
            local seen={}
            for _,p in ipairs(Spring.GetProjectilesInRectangle(x1,z1,x2,z2,false,false) or {}) do
                if Spring.GetProjectileOwnerID(p)==L.cannon and Spring.GetProjectileDefID(p)==mainWeapon then
                    seen[p]=true
                    local px,py,pz=Spring.GetProjectilePosition(p)
                    local rec=L.proj[p]
                    if not rec then
                        rec={f0=frameNow}; L.proj[p]=rec
                        R.fired=R.fired+1
                        R.first=R.first or frameNow
                        R.lastShot=frameNow
                    end
                    rec.x,rec.y,rec.z=px,py,pz
                end
            end
            for p,rec in pairs(L.proj) do
                if not seen[p] and not rec.done then
                    rec.done=true
                    -- ended on a shield? the sphere whose surface it is nearest
                    local bestS,bestD=nil,1e9
                    for _,s in ipairs(L.shields) do
                        if Spring.ValidUnitID(s) then
                            local cx,cy,cz=shieldCenter(s)
                            local d=math.abs(math.sqrt((rec.x-cx)^2+(rec.y-cy)^2+(rec.z-cz)^2)-SHIELD_R)
                            if d<bestD then bestD,bestS=d,s end
                        end
                    end
                    local gy=Spring.GetGroundHeight(rec.x,rec.z)
                    if bestS and bestD<60 and rec.y>gy+25 then
                        R.absorbed=R.absorbed+1
                        R.byShield[bestS]=(R.byShield[bestS] or 0)+1
                    else
                        R.ground=R.ground+1
                        local ux,uz=(L.tx-L.cx)/cfg.range,(L.tz-L.cz)/cfg.range
                        local dx,dz=rec.x-L.tx,rec.z-L.tz
                        local a,s=dx*ux+dz*uz,-dx*uz+dz*ux
                        R.along[#R.along+1]=a; R.side[#R.side+1]=s
                        if math.sqrt(a*a+s*s)<(cfg.hitRadius or 150) then R.hits=R.hits+1 end
                    end
                end
            end
            -- shield breaks (on -> off)
            for _,s in ipairs(L.shields) do
                if Spring.ValidUnitID(s) then
                    local _,on=shieldPower(s)
                    if R.shieldOn[s] and not on then R.breaks=R.breaks+1 end
                    R.shieldOn[s]=on
                end
            end
        end
    end
end

local function stats(t)
    local n=#t; if n==0 then return 0,0 end
    local m=0 for _,v in ipairs(t) do m=m+v end m=m/n
    local s=0 for _,v in ipairs(t) do s=s+(v-m)^2 end
    return m,math.sqrt(s/n)
end

local function finish(L,dead)
    local R=L.res
    if not R or R.closed then return end
    R.closed=true
    local fps=30
    local tKill=dead and R.first and (dead-R.first)/fps or -1
    local ma,sa=stats(R.along)
    local ms,ss=stats(R.side)
    local front,behind,side=0,0,0
    for i,a in ipairs(R.along) do
        local s=R.side[i]
        if math.sqrt(a*a+s*s)>=(cfg.hitRadius or 150) then
            if math.abs(s)>math.abs(a) then side=side+1 elseif a<0 then front=front+1 else behind=behind+1 end
        end
    end
    local hp,maxhp=0,1
    if not dead and L.target and Spring.ValidUnitID(L.target) then hp,maxhp=Spring.GetUnitHealth(L.target) end
    hp,maxhp=hp or 0,(maxhp and maxhp>0) and maxhp or 1
    local maxAbs=0
    for _,c in pairs(R.byShield) do maxAbs=math.max(maxAbs,c) end
    log(string.format("RESULT cannon=%s target=%s n=%d layout=%s seed=%d dead=%d t_kill=%.1f fired=%d absorbed=%d ground=%d hits=%d miss_front=%d miss_behind=%d miss_side=%d along_mean=%.0f along_sd=%.0f side_mean=%.0f side_sd=%.0f breaks=%d arc_shields=%d cover_shields=%d arc_deg=%.1f hp_left=%.2f max_on_one_shield=%d reorders=%d shields_placed=%d",
        cfg.cannon,cfg.target,L.trial.n,L.trial.layout,L.trial.seed,dead and 1 or 0,tKill,R.fired,R.absorbed,R.ground,R.hits,front,behind,side,ma,sa,ms,ss,R.breaks,R.model,R.cover,R.theta,
        dead and 0 or (hp/(maxhp or 1)),maxAbs,R.reorders or 0,#L.shields))
    if L.cannon then Spring.GiveOrderToUnit(L.cannon,CMD.STOP,{},0) end
    L.deadAt=dead
end

function widget:UnitDestroyed(id,udid,team)
    for _,L in ipairs(LANES) do
        if L.target==id and L.res and not L.res.closed and stage=="fire" then
            L.wreckAt={L.tx,L.tz,frameNow+60}
            -- the target's own position for the wreck check
            finish(L,frameNow)
        end
    end
end

local function features(L)
    local out={}
    for _,f in ipairs(Spring.GetFeaturesInCylinder(L.tx,L.tz,220) or {}) do
        local fd=FeatureDefs[Spring.GetFeatureDefID(f)]
        local x,_,z=Spring.GetFeaturePosition(f)
        local m=0
        local rm=Spring.GetFeatureResources(f)
        out[#out+1]=string.format("%s@%.0f/m%.0f",fd and fd.name or "?",math.sqrt(dist2(x,z,L.tx,L.tz)),rm or 0)
    end
    return table.concat(out,",")
end

local function clean()
    for _,L in ipairs(LANES) do
        local ids={}
        if L.target and Spring.ValidUnitID(L.target) then ids[#ids+1]=L.target end
        for _,s in ipairs(L.shields) do if Spring.ValidUnitID(s) then ids[#ids+1]=s end end
        if #ids>0 then Spring.SendLuaRulesMsg("$dev$:removeunits "..table.concat(ids," ")) end
    end
end

local function frameStep(f)
    for i=1,math.min(#queue,8) do Spring.SendCommands(table.remove(queue,1)) end
    -- energy: 5 cannons fire up to ~128,000 E/s (a Starfall volley is 360,000); atm is a cheat top-up
    if stage~="boot" or f>=60 then for i=1,(cfg.atmPerFrame or 6) do Spring.SendCommands("atm") end end
    if stage=="boot" then
        if f==30 then
            Spring.SendCommands("cheat 1")
            Spring.SendCommands("globallos")
        elseif f==60 then
            for _,L in ipairs(LANES) do expect(cfg.cannon,L.i,"cannon",L.cx,L.cz) give(cfg.cannon,myTeam,L.cx,L.cz) end
            -- energy: our own (a Starfall volley costs 360,000) and team 0's (shield regen)
            for i=0,9 do give("armafus",myTeam,300+(i%5)*150,300+math.floor(i/5)*150) end
            for i=0,9 do give("armuwadves",myTeam,1200+(i%5)*110,300+math.floor(i/5)*110) end
            for i=0,4 do give("armafus",0,cfg.mapSize-300-(i%5)*150,cfg.mapSize-300) end
            for i=0,3 do give("armuwadves",0,cfg.mapSize-300-(i%4)*110,cfg.mapSize-500) end
        elseif f>=600 then
            local ok=true
            for _,L in ipairs(LANES) do if not L.cannon then ok=false end end
            if ok then
                local _,_,_,e,es=Spring.GetTeamResources(myTeam,"energy")
                log(string.format("cannons ready energy=%.0f/%.0f frame=%d",select(1,Spring.GetTeamResources(myTeam,"energy")),select(2,Spring.GetTeamResources(myTeam,"energy")),f))
                startRound()
            elseif f>1200 then log("ERROR cannons missing"); stage="done" end
        end
    elseif stage=="spawn" or stage=="charge" then
        if f%15==0 then pollPending() end
        if f-stageFrame>30*(cfg.chargeMax or 70) or (f-stageFrame>30*5 and allCharged()) then
            if not allCharged() then log("WARN not all shields charged round="..round) end
            fire()
        end
    elseif stage=="fire" then
        trackProjectiles()
        for _,L in ipairs(LANES) do
            if L.res and not L.res.closed and L.target and (not Spring.ValidUnitID(L.target) or Spring.GetUnitIsDead(L.target)) then
                finish(L,f)
            elseif L.res and not L.res.closed and L.cannon and f%300==0 and f-(L.res.lastShot or L.res.start)>300 then
                -- no shell for 10 s: the order again (a few trials never fired on the first one)
                Spring.GiveOrderToUnit(L.cannon,CMD.ATTACK,{L.target},0)
                L.res.reorders=(L.res.reorders or 0)+1
                if L.res.reorders<=2 then
                    local hp,mhp,para=Spring.GetUnitHealth(L.cannon)
                    local cmds=Spring.GetUnitCommands(L.cannon,3) or {}
                    local c1=cmds[1] and cmds[1].id or -1
                    local angleGood,loaded,reloadFrame=Spring.GetUnitWeaponState(L.cannon,1,"angleGood"),Spring.GetUnitWeaponState(L.cannon,1,"reloadFrame"),0
                    local tt,_,tid=Spring.GetUnitWeaponTarget(L.cannon,1)
                    local cx,cy,cz=Spring.GetUnitPosition(L.cannon)
                    local tx,ty,tz=Spring.GetUnitPosition(L.target)
                    local ok=Spring.GetUnitWeaponTestTarget and Spring.GetUnitWeaponTestTarget(L.cannon,1,L.target)
                    local inRange=Spring.GetUnitWeaponTestRange and Spring.GetUnitWeaponTestRange(L.cannon,1,L.target)
                    local blocked=Spring.GetUnitWeaponHaveFreeLineOfFire and Spring.GetUnitWeaponHaveFreeLineOfFire(L.cannon,1,L.target)
                    log(string.format("STALL lane=%d hp=%.0f/%.0f para=%s cmd=%s angleGood=%s reload=%s wtarget=%s/%s testTarget=%s testRange=%s freeLOF=%s cannon=(%.0f,%.0f,%.0f) target=(%.0f,%.0f,%.0f) frame=%d",
                        L.i,hp or -1,mhp or -1,tostring(para),tostring(c1),tostring(angleGood),tostring(loaded),tostring(tt),tostring(tid),tostring(ok),tostring(inRange),tostring(blocked),cx or 0,cy or 0,cz or 0,tx or 0,ty or 0,tz or 0,f))
                end
            end
        end
        local open=false
        for _,L in ipairs(LANES) do
            if L.res and not L.res.closed then
                if f-stageFrame>30*cfg.timeout then finish(L,nil) else open=true end
            end
        end
        if f%(30*30)==0 then
            local e,es=Spring.GetTeamResources(myTeam,"energy")
            log(string.format("energy=%.0f/%.0f frame=%d",e or -1,es or -1,f))
        end
        if not open then stage="after"; stageFrame=f end
    elseif stage=="after" then
        trackProjectiles()
        if f-stageFrame==60 then
            for _,L in ipairs(LANES) do
                if L.trial then log(string.format("WRECK round=%d lane=%d target=%s dead=%d features=%s",round,L.i,cfg.target,L.deadAt and 1 or 0,features(L))) end
            end
            clean()
        elseif f-stageFrame==120 then
            Spring.SendLuaRulesMsg("$dev$:clearwrecks")
        elseif f-stageFrame>=180 then
            startRound()
        end
    end
end

function widget:GameFrame(f)
    frameNow=f
    local ok,err=pcall(frameStep,f)
    if not ok and f%30==0 then log("ERROR in frame "..f..": "..tostring(err)) end
end

-- AIR bombers: finished fusions/AFUS before unfinished ones (owner 2026-11-23).
-- Team 0 (SMRTBARb AIR, builders and factories held) gets supplied Phoenix
-- waves. The NullAI target team gets, per stage, nearest the AIR base an
-- UNFINISHED advanced fusion (a NullAI T2 constructor starts it under god mode
-- and keeps stalling on it), further out a finished fusion and furthest a
-- FINISHED advanced fusion. Fixed: the wave's first pick is the finished AFUS
-- (then the finished fusion); old: the nearer unfinished AFUS.
-- Logs every target, its build progress each minute and each death.
function widget:GetInfo()
    return {name="AIR unfinished fusion fixture",desc="Bomber pick: finished vs unfinished fusions",layer=119,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/air_unfinished.lua")
local T=cfg.team
local function log(s) Spring.Echo("[AirUnfinished] "..s) end
local queue={}
local function dry(x,z)
    for r=0,1200,64 do for dx=-r,r,64 do for dz=-r,r,64 do
        local px,pz=x+dx,z+dz
        if Spring.GetGroundHeight(px,pz)>5 then return px,pz end
    end end end
    return x,z
end
local function give(name,team,x,z,n)
    x,z=dry(x,z)
    queue[#queue+1]=string.format("give %d %s %d @%d,%d,%d",n or 1,name,team,math.floor(x),math.floor(Spring.GetGroundHeight(x,z)),math.floor(z))
end
local stage=0
local frames={}   -- stage -> {x,z} where the unfinished AFUS goes
local cons={}     -- constructor id -> stage
local watched={}
local function defName(d) return d and UnitDefs[d] and UnitDefs[d].name or "?" end
local function supply(s)
    local ox=(s-1)*900
    give("armpnix",0,2600,11200,20); give("armhawk",0,2400,11200,12)
    local ux,uz=dry(3300+ox,8300)
    frames[s]={ux,uz}
    give("armacv",T,ux-150,uz+150,1)
    give("armfus",T,3900+ox,7300,1)
    give("armafus",T,4600+ox,6300,1)
    log("stage="..s.." supplied pnix=20 hawk=12 unfinished_afus=("..math.floor(ux)..","..math.floor(uz)..") fus afus")
end
function widget:UnitCreated(id,def,team)
    if team~=T then return end
    local n=defName(def)
    local x,_,z=Spring.GetUnitPosition(id)
    if n=="armacv" then cons[id]=stage end
    if n=="armafus" or n=="armfus" then
        local _,_,_,_,bp=Spring.GetUnitHealth(id)
        watched[id]={name=n,stage=stage}
        log(string.format("target unit=%d def=%s x=%.0f z=%.0f progress=%.3f stage=%d",id,n,x,z,bp or -1,stage))
    end
end
function widget:UnitDestroyed(id,def,team,attackerID,attackerDefID)
    local w=watched[id]
    if w then
        local _,_,_,_,bp=Spring.GetUnitHealth(id)
        log(string.format("died unit=%d def=%s stage=%d frame=%d by=%s",id,w.name,w.stage,Spring.GetGameFrame(),defName(attackerDefID)))
        watched[id]=nil
    end
end
local ordered={}
function widget:GameFrame(f)
    if f==150 then
        Spring.SendCommands({"cheat 1","globallos","godmode 3"})
        give("armafus",0,2000,12500,2)
        log("loaded team="..T.."; god mode, global LOS, supplied units")
    end
    if f==450 then stage=1; supply(1) end
    if f==cfg.stage2 then stage=2; supply(2) end
    if #queue>0 and f%10==0 then Spring.SendCommands(table.remove(queue,1)) end
    -- the constructor starts the AFUS frame once, then keeps (stalled) building it
    if f%30==0 then
        for id,s in pairs(cons) do
            if Spring.ValidUnitID(id) and not ordered[id] and frames[s] then
                local x,z=frames[s][1],frames[s][2]
                Spring.GiveOrderToUnit(id,-UnitDefNames.armafus.id,{x,Spring.GetGroundHeight(x,z),z,0},0)
                ordered[id]=true
                log("constructor="..id.." ordered unfinished armafus stage="..s)
            end
        end
    end
    if f%900==0 then
        for id,w in pairs(watched) do
            local _,_,_,_,bp=Spring.GetUnitHealth(id)
            log(string.format("progress unit=%d def=%s %.3f",id,w.name,bp or -1))
        end
    end
end

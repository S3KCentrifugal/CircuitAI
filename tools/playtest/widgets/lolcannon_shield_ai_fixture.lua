-- Lolcannon shields, the AI's side (owner 2026-11-20). Team 0 (SMRTBARb TECH,
-- builders held) is given a finished cannon and the energy to fire it; team 1
-- (NullAI) gets four target groups in range, shown to team 0 by cameras:
--   G1 an advanced fusion inside 8 shields (ring 260): downranked (8 >= ShieldMax 7)
--   G2 an advanced fusion inside 3 shields: fired at, the area's dwell by 3 shields
--   G3 an advanced fusion with 8 shields on its far side (350 out) and three
--      fusions on its near side (230 out, outside every sphere): the chain test
--   G4 a fusion inside 2 shields
-- At GHOST_MIN the cameras go (the rest is ghost images). The observer logs
-- every real death and the wrecks it leaves.
function widget:GetInfo()
    return {name="Lolcannon shield AI fixture",desc="SMRTBARb lolcannon against shielded targets",layer=124,enabled=true}
end
local cfg=VFS.Include("LuaUI/Config/lolshield_ai.lua")
local function log(s) Spring.Echo("[ShieldAI] "..s) end
local function give(name,team,x,z) Spring.SendCommands(string.format("give 1 %s %d @%d,%d,%d",name,team,math.floor(x),math.floor(Spring.GetGroundHeight(x,z)),math.floor(z))) end
local done={}
local function once(k,at,f) if done[k] or f<at then return false end done[k]=true return true end
local GX=cfg.gunX+cfg.range
local groups={{z=2800},{z=5400},{z=8000},{z=10600}}
local watched={}
local cams={}

local function spawnGroups()
    local A,F=cfg.afus,cfg.fus
    -- u: away from the gun (+x)
    local g=groups[1]; give(A,1,GX,g.z)
    for i=0,7 do local a=i*math.pi/4; give(cfg.shield,1,GX+math.cos(a)*260,g.z+math.sin(a)*260) end
    g=groups[2]; give(A,1,GX,g.z)
    for i=0,2 do local a=i*2*math.pi/3+0.3; give(cfg.shield,1,GX+math.cos(a)*260,g.z+math.sin(a)*260) end
    g=groups[3]; give(A,1,GX,g.z)
    for i=0,7 do local a=math.rad(-70+i*20); give(cfg.shield,1,GX+math.cos(a)*350,g.z+math.sin(a)*350) end
    for _,s in ipairs({{-230,0},{-200,-150},{-200,150}}) do give(F,1,GX+s[1],g.z+s[2]) end
    g=groups[4]; give(F,1,GX,g.z)
    for i=0,1 do local a=i*math.pi+1.0; give(cfg.shield,1,GX+math.cos(a)*240,g.z+math.sin(a)*240) end
end

function widget:Initialize() log("loaded gun="..cfg.gun.." range="..cfg.range) end

local function scan()
    for _,id in ipairs(Spring.GetTeamUnits(1) or {}) do
        if not watched[id] then
            local d=UnitDefs[Spring.GetUnitDefID(id)]
            local x,_,z=Spring.GetUnitPosition(id)
            watched[id]={name=d.name,x=x,z=z}
            log(string.format("target unit=%d def=%s x=%.0f z=%.0f",id,d.name,x,z))
        end
    end
    for _,id in ipairs(Spring.GetTeamUnits(0) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(id)]
        if d.name=="armeyes" then cams[id]=true end
    end
end

function widget:UnitDestroyed(id)
    local w=watched[id]
    if w then
        w.dead=Spring.GetGameFrame()
        log(string.format("died unit=%d def=%s frame=%d",id,w.name,w.dead))
    end
end

function widget:GameFrame(f)
    if f==30 then Spring.SendCommands("cheat 1") Spring.SendCommands("specfullview 1") end
    -- team 0 (ally 0) sees the whole map until GHOST_MIN, then only remembered images
    if f==45 then Spring.SendCommands("globallos 0") log("global LOS on for ally 0") end
    if once("spawn",60,f) then spawnGroups() log("groups given") end
    if f>=90 and f<900 and f%30==0 then scan() end
    if once("gun",300,f) then
        give(cfg.gun,0,cfg.gunX,cfg.gunZ)
        for i=0,9 do give("armafus",0,300+(i%5)*150,300+math.floor(i/5)*150) end
        for i=0,9 do give("armuwadves",0,1200+(i%5)*110,300+math.floor(i/5)*110) end
        log("gun and power given")
    end
    if f>=60 and f%30==0 then
        for _,w in pairs(watched) do
            if w.dead and not w.wreck and f-w.dead>=60 then
                local out={}
                for _,fid in ipairs(Spring.GetFeaturesInCylinder(w.x,w.z,120) or {}) do
                    local fd=FeatureDefs[Spring.GetFeatureDefID(fid)]
                    out[#out+1]=fd and fd.name or "?"
                end
                w.wreck=true
                log(string.format("wreck def=%s at=(%.0f,%.0f) features=%s",w.name,w.x,w.z,table.concat(out,",")))
            end
        end
    end
    if once("ghost",cfg.ghostMin*60*30,f) then
        Spring.SendCommands("globallos 0")
        log("global LOS off for ally 0: ghost images from here frame="..f)
    end
    if f%(60*30)==0 then
        local alive={}
        for id,w in pairs(watched) do if not w.dead then alive[w.name]=(alive[w.name] or 0)+1 end end
        local s="" for k,v in pairs(alive) do s=s..k.."="..v.." " end
        log("minute "..(f/1800).." alive: "..s)
    end
end

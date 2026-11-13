-- Likely-killed lolcannon targets (owner 2026-11-12), headless fixture.
-- Team 0 (SMRTBARb TECH, builders held) is given a finished Ragnarok; team 1
-- (inert SMRTBARb TECH) is given two advanced fusions, a fusion beside the
-- first and an LLT, all in range and out of team 0's radar.
-- Perimeter cameras of team 0 show them for a few seconds, then are destroyed,
-- so the cannon fires at last-seen images. The observer (full view) logs each
-- target's real death; the AI's TIER lines say when it marked it likely killed.
-- At the end cameras show every spot again (a live marked target is "seen again").
function widget:GetInfo()
    return {name="Lolcannon blast-kill fixture", desc="Ghost AFUS killed in fog: likely-killed mark",
        author="CircuitAI", layer=10, enabled=true}
end
local function log(s) Spring.Echo("[BlastKillTest] "..s) end
local done={}
local function once(key,at,f) if done[key] or f<at then return false end done[key]=true; return true end
local function give(name,team,x,z) Spring.SendCommands(string.format("give 1 %s %d @%d,%d,%d",name,team,x,Spring.GetGroundHeight(x,z),z)) end
local watched={}   -- unit id -> name
local where={}     -- unit id -> {x, z}
local cams={}
-- A (killed by the fixture, no attacker: the AI is not told), its neighbours, B (live, shelled), D (live)
-- placed from the two start positions (any deformable map with starts 6,600+ apart):
-- the gun 600 from team 0's start towards team 1's, A 5,200 further, the rest round A
local spots={}
local roleOf={}
local gunX,gunZ
-- the runner writes the two AI spots here (Spring.GetTeamStartPosition(1) is nil on some maps)
local START0, START1 = nil, nil   -- {x, z}
local function layout()
    local x0,_,z0=Spring.GetTeamStartPosition(0)
    local x1,_,z1=Spring.GetTeamStartPosition(1)
    if START0 then x0,z0=START0[1],START0[2] end
    if START1 then x1,z1=START1[1],START1[2] end
    local dx,dz=x1-x0,z1-z0
    local len=math.sqrt(dx*dx+dz*dz)
    dx,dz=dx/len,dz/len
    local px,pz=-dz,dx   -- across
    gunX,gunZ=math.floor(x0+dx*600),math.floor(z0+dz*600)
    local ax,az=gunX+dx*5200,gunZ+dz*5200
    local function at(name,tag,along,across) spots[#spots+1]={name,math.floor(ax+dx*along+px*across),math.floor(az+dz*along+pz*across),tag} end
    at("armafus","A",0,0)
    at("armfus","Afus",0,330)
    at("armllt","Allt",0,-200)
    at("armafus","B",0,1600)
    at("armllt","D",-300,-900)
    log(string.format("layout start0=(%.0f,%.0f) start1=(%.0f,%.0f) gun=(%d,%d) A=(%d,%d) apart=%.0f",x0,z0,x1,z1,gunX,gunZ,spots[1][2],spots[1][3],len))
end
function widget:Initialize()
    Spring.SendCommands("cheat")
    Spring.SendCommands("specfullview")
    log("loaded")
end
function widget:UnitCreated(id,def,team)
    local n=UnitDefs[def].name
    if team==1 and (n=="armafus" or n=="armfus" or n=="armllt") and not watched[id] and not where[id] then
        watched[id]=n
        local x,_,z=Spring.GetUnitPosition(id)
        log(string.format("target unit=%d def=%s x=%.0f z=%.0f frame=%d",id,n,x,z,Spring.GetGameFrame()))
    elseif team==0 and n=="armeyes" then
        cams[#cams+1]=id
    elseif team==0 and n=="armvulc" then
        log(string.format("gun unit=%d frame=%d",id,Spring.GetGameFrame()))
    end
end
-- the observer sees team 1 only while team 0 does: its units are read once, while the cameras stand
local function poll(f)
    for _,id in ipairs(Spring.GetTeamUnits(1) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(id) or -1]
        if d and (d.name=="armafus" or d.name=="armfus" or d.name=="armllt") and not watched[id] and not where[id] then
            watched[id]=d.name
            local x,_,z=Spring.GetUnitPosition(id)
            where[id]={x,z}
            for _,s in ipairs(spots) do if math.abs(s[2]-x)<20 and math.abs(s[3]-z)<20 then roleOf[s[4]]=id; log(string.format("target %s unit=%d def=%s x=%.0f z=%.0f",s[4],id,d.name,x,z)) end end
            
        end
    end

end
-- ground probe (the observer reads the synced ground everywhere): 8 points on a ring
local function ring(tag,x,z,r,f)
    local s={}
    for i=0,7 do local a=i*math.pi/4; s[#s+1]=string.format("%.1f",Spring.GetGroundHeight(x+math.cos(a)*r,z+math.sin(a)*r)) end
    log(string.format("GROUND %s r=%d frame=%d centre=%.1f ring=%s",tag,r,f,Spring.GetGroundHeight(x,z),table.concat(s,",")))
end
local function camerasAt(list)
    for _,s in ipairs(list) do give("armeyes",0,s[2]-220,s[3]) end
end
local function dropCameras()
    for _,id in ipairs(cams) do Spring.SendLuaRulesMsg("$dev$:destroyunits "..id) end
    log("cameras destroyed="..#cams.." frame="..Spring.GetGameFrame())
    cams={}
end
function widget:GameFrame(f)
    if f>=90 and f<450 and f%15==0 then poll(f) end
    if (f==505 or f==540 or f==900) and spots[1] then ring("A",spots[1][2],spots[1][3],192,f); ring("Afus",spots[2][2],spots[2][3],75,f); ring("Allt-at",spots[3][2],spots[3][3],40,f) end
    if f%600==0 and f>=600 and f<=6000 and spots[4] then ring("B",spots[4][2],spots[4][3],192,f); ring("Bnear",spots[4][2],spots[4][3],100,f) end
    if once("targets",60,f) then
        layout()
        for _,s in ipairs(spots) do give(s[1],1,s[2],s[3]) end
        camerasAt(spots)
        log("targets and cameras given")
    end
    -- the gun stands while the targets are seen (its task reads their ground), but has no energy yet
    if once("gun",100,f) then give("armvulc",0,gunX,gunZ); log("gun given") end
    if once("dark",450,f) then dropCameras() end
    if once("killA",510,f) then
        if roleOf.A then Spring.SendLuaRulesMsg("$dev$:destroyunits "..roleOf.A); log("destroyed A unit="..roleOf.A.." frame="..f)
        else log("ERROR no unit A") end
    end
    if once("power",600,f) then
        -- a Ragnarok shot costs 15,000 energy: four advanced fusions and two hardened storages behind it
        for i=1,4 do give("armafus",0,1000+i*240,5200) end
        give("armuwadves",0,1000,5600); give("armuwadves",0,1300,5600)
        log("power given")
    end
    if once("lookagain",20*60*30,f) then camerasAt(spots); log("cameras again") end
    if once("dark2",21*60*30,f) then dropCameras() end

end

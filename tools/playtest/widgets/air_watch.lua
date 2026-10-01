function widget:GetInfo()
    return {name="AIR economy and attack observer",desc="Read-only factory, economy and attack measurements",author="CircuitAI",layer=110,enabled=true}
end
local tag="[AirWatch] "
local plants, finished, losses={}, {}, {}
local sample, stalledM, stalledE=0,0,0
local previousDamage, damageHook
local windGroups={}
local nanoProjects={}
local stockReady={}
local function echo(s) Spring.Echo(tag..s) end
local function airPlant(name)
    return name=="armap" or name=="corap" or name=="legap" or name=="armaap" or name=="coraap" or name=="legaap"
end
local function advancedPlant(name)
    return name=="armaap" or name=="coraap" or name=="legaap"
end
local function checkExpansion(newID)
    local bays={}
    for _,id in ipairs(Spring.GetTeamUnits(0)) do
        local d=UnitDefs[Spring.GetUnitDefID(id)]
        if id~=newID and airPlant(d.name) then
            local x,_,z=Spring.GetUnitPosition(id)
            local _,_,_,_,progress=Spring.GetUnitHealth(id)
            bays[#bays+1]={id=id,x=x,z=z,advanced=advancedPlant(d.name),finished=progress and progress>=1,count=0}
        end
    end
    for _,id in ipairs(Spring.GetTeamUnits(0)) do
        local d=UnitDefs[Spring.GetUnitDefID(id)]
        if d.name=="armnanotc" or d.name=="cornanotc" or d.name=="legnanotc" then
            local _,_,_,_,progress=Spring.GetUnitHealth(id)
            if progress and progress>=1 then
                local x,_,z=Spring.GetUnitPosition(id)
                local best,dist=nil,d.buildDistance*d.buildDistance
                for _,b in ipairs(bays) do
                    local sq=(x-b.x)^2+(z-b.z)^2
                    if sq<dist then best,dist=b,sq end
                end
                if best then best.count=best.count+1 end
            end
        end
    end
    local count,unfinished,minimum=0,0,20
    for _,b in ipairs(bays) do
        if b.advanced then
            count=count+1; minimum=math.min(minimum,b.count)
            if not b.finished then unfinished=unfinished+1 end
        end
    end
    echo("t2-lab-start existing="..count.." minimum="..minimum.." unfinished="..unfinished)
    if count>0 and (unfinished>0 or minimum<20) then
        Spring.Echo("[INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab")
    end
end
local function windCreated(id,d)
    local x,_,z=Spring.GetUnitPosition(id)
    local w,h=d.xsize*8,d.zsize*8
    local facing=Spring.GetUnitBuildFacing(id)
    local function vector(a,b)
        if facing==1 then return b,-a elseif facing==2 then return -a,-b elseif facing==3 then return -b,a end
        return a,b
    end
    local function contains(c,px,pz)
        for _,p in ipairs(c.slots) do if math.abs(p.x-px)<1 and math.abs(p.z-pz)<1 then return true end end
        return false
    end
    local function resolve(g)
        g.slots=g.candidates[1].slots
        for _,p in ipairs(g.slots) do
            for _,member in ipairs(g.members) do
                if math.abs(p.x-member.x)<1 and math.abs(p.z-member.z)<1 then p.id=member.id end
            end
        end
        if #g.candidates==1 and not g.resolved then
            local c=g.candidates[1]
            g.x,g.z,g.resolved=c.x,c.z,true
            for _,other in ipairs(windGroups) do
                if other~=g and other.resolved and math.sqrt((g.x-other.x)^2+(g.z-other.z)^2)<g.radius+other.radius+143 then
                    Spring.Echo("[INVARIANT] INV-078 AIR observer: independently resolved wind clusters overlap their gap")
                end
            end
        end
    end
    for i,g in ipairs(windGroups) do
        for s,p in ipairs(g.members) do
            if math.abs(p.x-x)<1 and math.abs(p.z-z)<1 then
                if p.id and not Spring.ValidUnitID(p.id) then echo("wind-reused cluster="..i.." slot="..s) end
                p.id=id; resolve(g); return
            end
        end
        local candidates={}
        for _,c in ipairs(g.candidates) do if contains(c,x,z) then candidates[#candidates+1]=c end end
        if #candidates>0 then
            g.candidates=candidates
            g.members[#g.members+1]={x=x,z=z,id=id}
            resolve(g); return
        end
    end
    local radius=math.sqrt((3*w)^2+(2*h)^2)/2
    local g={radius=radius,candidates={},members={{x=x,z=z,id=id}}}
    -- Parallel builders can create any of the six slots first. Keep all six
    -- possible origins until subsequent engine frames disambiguate the grid.
    for firstRow=0,1 do for firstCol=0,2 do
        local dx,dz=vector(firstCol*w,firstRow*h)
        local ox,oz=x-dx,z-dz
        local cx,cz=vector(w,h/2)
        local c={x=ox+cx,z=oz+cz,slots={}}
        for row=0,1 do for col=0,2 do
            local px,pz=vector(col*w,row*h)
            c.slots[#c.slots+1]={x=ox+px,z=oz+pz}
        end end
        g.candidates[#g.candidates+1]=c
    end end
    windGroups[#windGroups+1]=g; resolve(g)
    echo("wind-cluster-start cluster="..#windGroups.." first="..x..","..z.." stride="..w.."/"..h)
end
function widget:Initialize() echo("loaded; read-only observer team=0") end
function widget:UnitCreated(id,def,team,builder)
    if team~=0 then return end
    local name=UnitDefs[def].name
    if builder and (name=="armamd" or name=="corfmd" or name=="legabm") then
        local x,_,z=Spring.GetUnitPosition(id)
        local hx,_,hz=Spring.GetTeamStartPosition(0)
        local coverage=0
        for _,weapon in ipairs(UnitDefs[def].weapons) do
            coverage=math.max(coverage,WeaponDefs[weapon.weaponDef].coverageRange or 0)
        end
        local own=math.sqrt((x-hx)^2+(z-hz)^2)+800<=coverage
        local neighborDistance=math.huge
        local neighborCovered=false
        for _,teamID in ipairs(Spring.GetTeamList()) do
            if teamID~=0 and Spring.AreTeamsAllied(0,teamID) and #Spring.GetTeamUnits(teamID)>0 then
                local ax,_,az=Spring.GetTeamStartPosition(teamID)
                local sq=(ax-hx)^2+(az-hz)^2
                if sq<neighborDistance then
                    neighborDistance=sq
                    neighborCovered=math.sqrt((x-ax)^2+(z-az)^2)+800<=coverage
                end
            end
        end
        echo("anti-nuke-coverage loaded="..coverage.." own="..tostring(own).." neighbor="..tostring(neighborCovered))
        if not own then Spring.Echo("[INVARIANT] INV-094 AIR observer: anti-nuke leaves own core uncovered") end
    end
    if builder and UnitDefs[def].isImmobile and #UnitDefs[def].weapons>0 then
        local x,_,z=Spring.GetUnitPosition(id)
        local hx,_,hz=Spring.GetTeamStartPosition(0)
        local distance=math.sqrt((x-hx)^2+(z-hz)^2)
        echo("static-defence def="..name.." homeDistance="..math.floor(distance))
        if distance>1500 then Spring.Echo("[INVARIANT] INV-091 AIR observer: static weapon outside home defense radius") end
    end
    if advancedPlant(name) and builder then checkExpansion(id) end
    if name=="armwin" or name=="corwin" or name=="legwin" then windCreated(id,UnitDefs[def]); return end
    if name~="armfus" and name~="corfus" and name~="legfus" and name~="armafus" and name~="corafus" and name~="legafus" then return end
    -- Engine-created fixture units have no builder. BAR forwards builderID;
    -- only an actual construction frame can establish an AI admission error.
    if not builder then echo("reactor-spawn def="..name.."; no builder"); return end
    local basic,unfinished=0,0
    for _,mex in ipairs(Spring.GetTeamUnits(0)) do
        local d=UnitDefs[Spring.GetUnitDefID(mex)]
        if d.extractsMetal and d.extractsMetal>0 then
            local upgraded=UnitDefNames[d.name:sub(1,3).."moho"]
            local rate=upgraded and UnitDefs[upgraded.id].extractsMetal or math.huge
            local _,_,_,_,progress=Spring.GetUnitHealth(mex)
            if d.extractsMetal<rate then basic=basic+1
            elseif progress and progress<1 then unfinished=unfinished+1 end
        end
    end
    echo("reactor-start def="..name.." basicMexes="..basic.." unfinishedMexes="..unfinished)
    if basic+unfinished>0 then Spring.Echo("[INVARIANT] INV-077 AIR observer: reactor frame before all owned mexes upgraded") end
end
function widget:UnitFinished(id,def,team)
    if team~=0 then return end
    local d=UnitDefs[def]; finished[d.name]=(finished[d.name] or 0)+1
    if d.isImmobile or d.canFly then echo("finished id="..id.." def="..d.name.." total="..finished[d.name]) end
end
function widget:UnitDestroyed(id,def,team)
    if team~=0 then return end
    local d=UnitDefs[def]; losses[d.name]=(losses[d.name] or 0)+1
    echo("lost id="..id.." def="..d.name.." total="..losses[d.name]); plants[id]=nil
end
local function damageEvent(id,def,team,damage,paralyzer,weapon,projectile,attacker,attackerDef,attackerTeam)
    if attackerTeam~=0 or not attackerDef or not UnitDefs[attackerDef].canFly or paralyzer then return end
    if Spring.AreTeamsAllied(team,attackerTeam) then return end
    if damage>=20 then
        echo("damage attacker="..attacker.." def="..UnitDefs[attackerDef].name.." victim="..id.." amount="..math.floor(damage))
        if WG.AirFixtureRaids and WG.AirFixtureRaids[id] then
            echo("raid-hit def="..UnitDefs[attackerDef].name.." victim="..id.." amount="..math.floor(damage))
        end
    end
end
function widget:Shutdown()
    local env=getfenv(0)
    if damageHook and rawget(env,"UnitDamaged")==damageHook then
        rawset(env,"UnitDamaged",previousDamage); Script.UpdateCallIn("UnitDamaged")
    end
end
function widget:GameFrame(f)
    -- BAR's widget dispatcher drops attacker arguments. Observe the full engine
    -- call-in and forward unchanged, as in the existing flank observer.
    if damageHook and rawget(getfenv(0),"UnitDamaged")~=damageHook then
        echo("damage coverage gap; restoring observer at frame="..f)
        damageHook=nil
    end
    if f>=150 and not damageHook then
        local env=getfenv(0)
        previousDamage=rawget(env,"UnitDamaged")
        local prior=previousDamage
        damageHook=function(...) damageEvent(...); if prior then return prior(...) end end
        rawset(env,"UnitDamaged",damageHook); Script.UpdateCallIn("UnitDamaged")
        echo("damage observer installed")
    end
    if f%15~=0 then return end
    local m,ms,mp,mi=Spring.GetTeamResources(0,"metal")
    local e,es,ep,ei=Spring.GetTeamResources(0,"energy")
    if not m then return end
    sample=sample+0.5
    if m<1 then stalledM=stalledM+0.5 end
    if e<1 then stalledE=stalledE+0.5 end
    for _,id in ipairs(Spring.GetTeamUnits(0)) do
        local d=UnitDefs[Spring.GetUnitDefID(id)]
        local _,_,_,_,progress=Spring.GetUnitHealth(id)
        if progress and progress>=1 and d.isFactory and (d.name=="armap" or d.name=="corap" or d.name=="legap" or d.name=="armaap" or d.name=="coraap" or d.name=="legaap") then
            local p=plants[id]
            if not p then p={last=nil,active=0,idle=0,change=f,started=false}; plants[id]=p end
            local building=Spring.GetUnitIsBuilding(id)
            if building then p.active=p.active+0.5 else p.idle=p.idle+0.5 end
            if building~=p.last then
                if building then
                    -- Direct frame-to-frame replacement has an unobserved gap below 0.5s.
                    -- Never mislabel the previous unit's build duration as a factory gap.
                    local gap=p.last and "<0.50" or string.format("%.2f",(f-p.change)/30)
                    echo("frame plant="..id.." unit="..building.." "..(p.started and "warmIdle=" or "coldIdle=")..gap.." E="..math.floor(e).." M="..math.floor(m))
                    p.started=true
                end
                p.change=f; p.last=building
            end
        end
    end
    if f%300==0 then
        local t1,t2,nano,bp,remote,working=0,0,0,0,0,0
        local hx,_,hz=Spring.GetTeamStartPosition(0)
        for _,id in ipairs(Spring.GetTeamUnits(0)) do
            local d=UnitDefs[Spring.GetUnitDefID(id)]
            local _,_,_,_,progress=Spring.GetUnitHealth(id)
            if progress and progress>=1 then
                if d.name=="armca" or d.name=="corca" or d.name=="legca" then t1=t1+1; bp=bp+(d.buildSpeed or 0) end
                if d.name=="armaca" or d.name=="coraca" or d.name=="legaca" then t2=t2+1; bp=bp+(d.buildSpeed or 0) end
                if d.canFly and d.isBuilder and not d.isFactory then
                    local x,_,z=Spring.GetUnitPosition(id)
                    if (x-hx)^2+(z-hz)^2>2400^2 then remote=remote+1 end
                    if Spring.GetUnitIsBuilding(id) then working=working+1 end
                end
                if d.name=="armamd" or d.name=="corfmd" or d.name=="legabm" then
                    local stock=Spring.GetUnitStockpile(id)
                    if stock and stock>0 and not stockReady[id] then
                        stockReady[id]=true
                        echo("anti-nuke-ready def="..d.name.." stock="..stock)
                    end
                end
                if d.name=="armnanotc" or d.name=="cornanotc" or d.name=="legnanotc" then
                    nano=nano+1
                    local target=Spring.GetUnitIsBuilding(id)
                    local targetDef=target and Spring.GetUnitDefID(target)
                    if targetDef and UnitDefs[targetDef].isImmobile then
                        local _,_,_,_,built=Spring.GetUnitHealth(target)
                        local key=id..":"..target
                        if built and built<1 and not nanoProjects[key] then
                            nanoProjects[key]=true
                            echo("nano-construction id="..id.." target="..target.." def="..UnitDefs[targetDef].name)
                        end
                    end
                end
            end
        end
        local full=0
        for _,g in ipairs(windGroups) do
            local n=0
            for _,p in ipairs(g.slots) do
                if p.id and Spring.ValidUnitID(p.id) then
                    local _,_,_,_,progress=Spring.GetUnitHealth(p.id)
                    if progress and progress>=1 then n=n+1 end
                end
            end
            if n==6 then full=full+1 end
        end
        echo("construction t1="..t1.." t2="..t2.." mobileBP="..bp.." nanos="..nano.." fullWindClusters="..full.." remote="..remote.." working="..working)
        local count=0; for _ in pairs(plants) do count=count+1 end
        echo(string.format("eco t=%.1f M=%.1f/%.0f +%.1f pull=%.1f E=%.1f/%.0f +%.1f pull=%.1f stallSeconds=%.1f/%.1f plants=%d",f/30,m,ms,mi,mp,e,es,ei,ep,stalledM,stalledE,count))
    end
end

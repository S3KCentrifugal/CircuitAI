function widget:GetInfo()
    return {name="AIR economy and attack observer",desc="Read-only factory, economy and attack measurements",author="CircuitAI",layer=110,enabled=true}
end
local tag="[AirWatch] "
local plants, finished, losses={}, {}, {}
local sample, stalledM, stalledE=0,0,0
local previousDamage, damageHook
local function echo(s) Spring.Echo(tag..s) end
function widget:Initialize() echo("loaded; read-only observer team=0") end
function widget:UnitCreated(id,def,team)
    if team~=0 then return end
    local name=UnitDefs[def].name
    if name~="armfus" and name~="corfus" and name~="legfus" and name~="armafus" and name~="corafus" and name~="legafus" then return end
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
    if damage>=20 then echo("damage attacker="..attacker.." def="..UnitDefs[attackerDef].name.." victim="..id.." amount="..math.floor(damage)) end
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
        local count=0; for _ in pairs(plants) do count=count+1 end
        echo(string.format("eco t=%.1f M=%.1f/%.0f +%.1f pull=%.1f E=%.1f/%.0f +%.1f pull=%.1f stallSeconds=%.1f/%.1f plants=%d",f/30,m,ms,mi,mp,e,es,ei,ep,stalledM,stalledE,count))
    end
end

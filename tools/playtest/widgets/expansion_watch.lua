function widget:GetInfo()
    return {name="Expansion and mex observer",desc="Read-only mex-first and fortification evidence",author="CircuitAI",layer=115,enabled=true}
end
local first={}
local function log(s) Spring.Echo("[ExpansionWatch] "..s) end
local function mexes(team)
    local basic,advanced,pending=0,0,0
    for _,u in ipairs(Spring.GetTeamUnits(team)) do
        local d=UnitDefs[Spring.GetUnitDefID(u)]
        if d.extractsMetal and d.extractsMetal>0 then
            local m=UnitDefNames[d.name:sub(1,3).."moho"]
            local _,_,_,_,done=Spring.GetUnitHealth(u)
            if m and d.extractsMetal<UnitDefs[m.id].extractsMetal then basic=basic+1
            elseif done and done<1 then pending=pending+1 else advanced=advanced+1 end
        end
    end
    return basic,advanced,pending
end
function widget:UnitCreated(id,def,team,builder)
    local n=UnitDefs[def].name
    if team==0 and builder and (n=="armaap" or n=="coraap" or n=="legaap") then
        local b,a,p=mexes(team)
        log("air-lab-frame basic="..b.." upgraded="..a.." pending="..p)
        if b>0 or p>0 then Spring.Echo("[INVARIANT] INV-083 observer: AIR T2 plant before mex upgrades") end
    end
end
function widget:UnitFinished(id,def,team)
    local d=UnitDefs[def]
    local x,_,z=Spring.GetUnitPosition(id)
    if not first[team] and d.extractsMetal and d.extractsMetal>0 then
        first[team]={x=x,z=z}; log("first-mex team="..team.." x="..x.." z="..z)
    end
    if d.name:find("drag") or d.name:find("fort") then log("wall-finished team="..team.." def="..d.name.." x="..x.." z="..z) end
end
function widget:UnitGiven(id,def,newTeam,oldTeam)
    local d=UnitDefs[def]
    if not d.isBuilder or d.isBuilding or not first[newTeam] then return end
    local x,_,z=Spring.GetUnitPosition(id)
    local p=first[newTeam]
    log("constructor-gift team="..newTeam.." def="..d.name.." mex-distance="..math.floor(math.sqrt((x-p.x)^2+(z-p.z)^2)))
end
function widget:GameFrame(f)
    if f%900~=0 then return end
    local b,a,p=mexes(0)
    local conv=0
    for _,u in ipairs(Spring.GetTeamUnits(0)) do
        local n=UnitDefs[Spring.GetUnitDefID(u)].name
        if n=="armmakr" or n=="cormakr" or n=="legeconv" then conv=conv+1 end
    end
    log("air basic="..b.." upgraded="..a.." pending="..p.." t1-converters="..conv)
end

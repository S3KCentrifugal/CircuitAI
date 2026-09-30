-- Read-only observer. No game orders, resources, vision or AI policy changes.
function widget:GetInfo()
    return {name="BARb scorecard metrics", desc="Versioned scorecard telemetry", author="CircuitAI", layer=109, enabled=true}
end
local config = VFS.Include("LuaUI/Config/scorecard_run.lua")
local tracked, totals, finished = {}, {}, {}
local specialists = {armsptk=true, cortermite=true, legsrail=true}
local outcome = false
local function quote(s)
    return '"'..tostring(s):gsub('\\','\\\\'):gsub('"','\\"'):gsub('\n','\\n'):gsub('\r','\\r'):gsub('\t','\\t')..'"'
end
local function emit(kind, fields)
    fields.frame=Spring.GetGameFrame()
    local keys, parts={},{}
    for k in pairs(fields) do keys[#keys+1]=k end
    table.sort(keys)
    for _,k in ipairs(keys) do
        local v=fields[k]
        parts[#parts+1]=quote(k)..":"..((type(v)=="number" or type(v)=="boolean") and tostring(v) or quote(v))
    end
    Spring.Echo("[Scorecard] "..kind.." {"..table.concat(parts,",").."}")
end
local function combat(ud)
    return ud.canMove and not ud.isBuilder and ud.weapons and #ud.weapons>0
end
function widget:Initialize()
    for _,team in ipairs(config.teams) do
        tracked[team]=true
        totals[team]={combatCompleted=0, combatMetalCompleted=0, allTerrainCompleted=0, combatKilledMetal=0, combatLostMetal=0}
    end
    emit("init",{schema=1,map=Game.mapName,mapChecksum=Game.mapChecksum or "unknown",gameChecksum=Game.modChecksum or "unknown"})
end
function widget:UnitCreated(id) finished[id]=nil end
function widget:UnitFinished(id,def,team)
    if not tracked[team] or finished[id] then return end
    finished[id]=true
    local ud=UnitDefs[def]
    if combat(ud) then
        local t=totals[team]
        t.combatCompleted=t.combatCompleted+1
        t.combatMetalCompleted=t.combatMetalCompleted+(ud.metalCost or 0)
        if specialists[ud.name] then t.allTerrainCompleted=t.allTerrainCompleted+1 end
        emit("combat",{team=team,unit=id,name=ud.name,metal=ud.metalCost or 0,
            tier=tonumber((ud.customParams or {}).techlevel) or 1,specialist=specialists[ud.name] or false})
    elseif ud.isFactory then
        emit("factory",{team=team,unit=id,name=ud.name})
    end
end
function widget:UnitDestroyed(id,def,team,attacker,attackerDef,attackerTeam)
    local ud=UnitDefs[def]
    -- Confirm hostile attribution. Reclaim/self-destruction is not an enemy kill.
    if attackerTeam and not Spring.AreTeamsAllied(team,attackerTeam) and combat(ud) then
        if tracked[attackerTeam] then totals[attackerTeam].combatKilledMetal=totals[attackerTeam].combatKilledMetal+(ud.metalCost or 0) end
        if tracked[team] then totals[team].combatLostMetal=totals[team].combatLostMetal+(ud.metalCost or 0) end
    end
    finished[id]=nil
end
local function sample(team)
    local _,_,dead,_,_,ally=Spring.GetTeamInfo(team,false)
    local n=Spring.GetTeamStatsHistory(team) or 0
    local history=n>0 and Spring.GetTeamStatsHistory(team,n) or nil
    local s=history and history[1] or {}
    local fields={team=team,ally=ally,dead=dead or false}
    for _,key in ipairs({"metalUsed","metalProduced","metalExcess","metalReceived","metalSent",
        "energyUsed","energyProduced","energyExcess","energyReceived","damageDealt","damageReceived",
        "unitsProduced","unitsDied","unitsKilled"}) do
        if s[key]~=nil then fields[key]=s[key] end
    end
    local metal,storage,pull,income,expense=Spring.GetTeamResources(team,"metal")
    fields.metal=metal or 0; fields.metalStorage=storage or 0
    fields.metalIncome=income or 0; fields.metalExpense=expense or 0
    local army,armyMetal,factories,idle=0,0,0,0
    for _,id in ipairs(Spring.GetTeamUnits(team) or {}) do
        local def=Spring.GetUnitDefID(id)
        local ud=def and UnitDefs[def]
        local _,_,_,_,bp=Spring.GetUnitHealth(id)
        if ud and bp and bp>=1 then
            if combat(ud) then army=army+1; armyMetal=armyMetal+(ud.metalCost or 0) end
            if ud.isFactory then factories=factories+1; if not Spring.GetUnitIsBuilding(id) then idle=idle+1 end end
        end
    end
    fields.army=army; fields.armyMetal=armyMetal
    fields.factories=factories; fields.idleFactories=idle
    for k,v in pairs(totals[team]) do fields[k]=v end
    emit("sample",fields)
end
function widget:GameFrame(f)
    if outcome or f==0 or f%900~=0 then return end
    for _,team in ipairs(config.teams) do sample(team) end
end
function widget:GameOver(winners)
    if outcome then return end
    outcome=true
    for _,team in ipairs(config.teams) do sample(team) end
    emit("outcome",{source="engine_GameOver",winners=table.concat(winners or {},",")})
end

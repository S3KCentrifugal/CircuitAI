function widget:GetInfo()
    return {name="Strategic targeting fixture",desc="Controlled Juno and silo targets; injected stock",author="CircuitAI",layer=114,enabled=true}
end
local queue,done,stock,fixture={}, {}, {}, {}
local enemy,ally
local function echo(s) Spring.Echo("[StrategicFixture] "..s) end
local function once(key,at,f) if done[key] or f<at then return false end done[key]=true; return true end
local function give(name,team,x,z)
    queue[#queue+1]="give "..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
local function destroy(id) Spring.SendLuaRulesMsg("$dev$:destroyunits "..id) end
function widget:UnitCreated(id,def,team)
    local n=UnitDefs[def].name
    if Spring.GetGameFrame()>=600 and (n=="armjuno" or n=="corjuno" or n=="armsilo" or n=="corsilo") then
        fixture[id]=n
        local radius=WeaponDefs[UnitDefs[def].weapons[1].weaponDef].damageAreaOfEffect
        echo("weapon="..n.." id="..id.." team="..team.." radius="..tostring(radius))
    end
end
function widget:GameFrame(f)
    if once("cheat",300,f) then
        Spring.SendCommands("cheat 1")
        for _,team in ipairs(Spring.GetTeamList()) do
            if team~=0 and team~=Spring.GetGaiaTeamID() and #Spring.GetTeamUnits(team)>0 then
                if Spring.AreTeamsAllied(0,team) then ally=ally or team else enemy=enemy or team end
            end
        end
        echo("scenario="..scenario.." ally="..tostring(ally).." enemy="..tostring(enemy))
    end
    if once("weapons",600,f) then
        if not enemy or (scenario=="juno" and not ally) then echo("INVALID missing teams"); return end
        local x,_,z=Spring.GetTeamStartPosition(0)
        give(scenario=="juno" and "armjuno" or "armsilo",0,x+200,z-200)
        if scenario=="juno" then
            local ax,_,az=Spring.GetTeamStartPosition(ally)
            give("corjuno",ally,ax+200,az+200)
        else give("corsilo",0,x+500,z-200) end
        -- Keep the enemy alive with an expensive mobile; it must never justify a nuke.
        give("armbanth",enemy,10000,4000)
    end
    if once("isolate",750,f) then
        -- Remove autonomous builders/targets after the injected weapons exist.
        for _,team in ipairs(Spring.GetTeamList()) do
            for _,id in ipairs(Spring.GetTeamUnits(team)) do
                local n=UnitDefs[Spring.GetUnitDefID(id)].name
                if not fixture[id] and n~="armbanth" and not n:find("com") then destroy(id) end
            end
        end
        Spring.SendCommands("globallos")
        echo("mobile-only targets; no structures")
    end
    if once("sensors",900,f) and scenario=="juno" then
        give("armveil",enemy,10500,1800)
        give("armjamt",enemy,10500,5100)
        give("armarad",enemy,7200,1800)
        give("armrad",enemy,7200,5100)
        echo("sensors: advanced jammer=10500,1800 basic jammer=10500,5100 advanced radar=7200,1800 radar=7200,5100")
    end
    if once("stock",1800,f) then Spring.SendLuaRulesMsg("$dev$:loadmissiles") end
    if once("fog",5400,f) and scenario=="juno" then
        for _,id in ipairs(Spring.GetTeamUnits(enemy)) do
            local n=UnitDefs[Spring.GetUnitDefID(id)].name
            if n~="armbanth" and not n:find("com") then destroy(id) end
        end
        Spring.SendCommands("globallos")
        give("armrad",0,6000,7000)
        give("armeyes",0,6500,6000)
        echo("fog phase: global LOS off; local vision only")
    end
    if scenario=="nuclear" and f>=5400 and f%90==0 then
        local found=false
        for _,id in ipairs(Spring.GetTeamUnits(enemy)) do if UnitDefs[Spring.GetUnitDefID(id)].name=="armafus" then found=true; break end end
        if not found then give("armafus",enemy,10500,1800); echo("building target supplied at 10500,1800") end
    end
    if f%15==0 then
        for id,n in pairs(fixture) do
            if Spring.ValidUnitID(id) then
                local current=Spring.GetUnitStockpile(id)
                if current and stock[id] and current<stock[id] then echo("stock-drop unit="..id.." def="..n.." frame="..f.." remaining="..current) end
                stock[id]=current
            end
        end
    end
    if #queue>0 then Spring.SendCommands(queue); queue={} end
end

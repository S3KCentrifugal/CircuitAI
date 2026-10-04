function widget:GetInfo()
    return {name="Arquebus range regression",desc="Supplied railguns must engage before crossing their targets",author="CircuitAI",layer=112,enabled=true}
end
local states={}
local function give(name,team,x,z)
    Spring.SendCommands("give "..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z)
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    if f==600 then
        for team=0,1 do
            local x,_,z=Spring.GetTeamStartPosition(team)
            local sign=z>Game.mapSizeZ/2 and -1 or 1
            states[team]={x=x,z=z,sign=sign,minDistance=99999,minHP=99999,damage=0}
            give("armrad",team,x+200,z)
            give("armfus",team,x+300,z)
            give("legsrail",team,x,z+sign*100)
            give("corhlt",1-team,x,z+sign*1300)
        end
    end
    if f==900 then
        for team,s in pairs(states) do
            for _,id in ipairs(Spring.GetTeamUnits(team)) do
                if Spring.GetUnitDefID(id)==UnitDefNames.legsrail.id then s.unit=id end
            end
            for _,id in ipairs(Spring.GetUnitsInCylinder(s.x,s.z+s.sign*1300,100)) do
                if Spring.GetUnitDefID(id)==UnitDefNames.corhlt.id then s.enemy=id; s.enemyHP=Spring.GetUnitHealth(id) end
            end
        end
    end
    if f>=930 and f%30==0 then
        for team,s in pairs(states) do
            local x,y,z
            if s.unit then x,y,z=Spring.GetUnitPosition(s.unit) end
            local hp=s.unit and Spring.GetUnitHealth(s.unit)
            if hp and x then
                s.minHP=math.min(s.minHP,hp)
                local ex,ey,ez
                if s.enemy then ex,ey,ez=Spring.GetUnitPosition(s.enemy) end
                if ex then
                    local d=math.sqrt((x-ex)^2+(z-ez)^2)
                    s.minDistance=math.min(s.minDistance,d)
                    local ehp=Spring.GetUnitHealth(s.enemy)
                    if ehp and s.enemyHP then s.damage=math.max(s.damage,s.enemyHP-ehp) end
                elseif s.enemy and not s.killed then
                    s.killed=true
                    Spring.Echo("[Arquebus] target down team="..team.." min-distance="..math.floor(s.minDistance).." hp="..math.floor(hp))
                end
                if s.killed and (z-s.z)*s.sign>1700 and not s.passed then
                    s.passed=true
                    local ok=s.minDistance>600 and s.minHP>2100
                    Spring.Echo("[Arquebus] "..(ok and "PASS" or "FAIL").." team="..team.." kept range, killed target, resumed lane; min-distance="..math.floor(s.minDistance).." min-hp="..math.floor(s.minHP))
                end
            elseif s.unit and not s.dead then
                s.dead=true;Spring.Echo("[Arquebus] FAIL railgun died team="..team)
            end
        end
    end
end

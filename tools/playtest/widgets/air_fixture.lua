-- Loaded by prepare_air_check.py with a local scenario. Not an autonomous-game benchmark.
function widget:GetInfo()
    return {name="AIR controlled fixture",desc="Explicit late economy, loss, transport and role switch fixtures",author="CircuitAI",layer=113,enabled=true}
end
local queue={}
local done={}
local function once(key,frame,now)
    if done[key] or now<frame then return false end
    done[key]=true; return true
end
local function give(name,team,x,z,count)
    queue[#queue+1]="give "..(count and (count.." ") or "")..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
function widget:Initialize() Spring.Echo("[AirFixture] scenario="..scenario.."; injected resources/units are not natural economy evidence") end
function widget:GameFrame(f)
    if once("cheat",300,f) then Spring.SendCommands("cheat 1") end
    if scenario=="screen" then
        for i,at in ipairs({600,3600,7200}) do
            if once("screen"..i,at,f) then
                local x,_,z=Spring.GetTeamStartPosition(0)
                give(i==2 and "armhawk" or "armfig",0,x,z,({4,16,20})[i])
                Spring.Echo("[AirFixture] screen stage="..i.."; supplied fighters, defensive quota=60")
            end
        end
        if once("screenloss",10800,f) then
            local keep=0
            for _,id in ipairs(Spring.GetTeamUnits(0)) do
                local name=UnitDefs[Spring.GetUnitDefID(id)].name
                if name=="armfig" or name=="armhawk" then
                    keep=keep+1
                    if keep>4 then Spring.SendLuaRulesMsg("$dev$:destroyunits "..id) end
                end
            end
            Spring.Echo("[AirFixture] screen loss requested; keep four fighters")
        end
    end
    if scenario=="windloss" and once("windloss",9000,f) then
        for _,id in ipairs(Spring.GetTeamUnits(0)) do
            local name=UnitDefs[Spring.GetUnitDefID(id)].name
            if name=="armwin" or name=="corwin" or name=="legwin" then
                Spring.SendLuaRulesMsg("$dev$:destroyunits "..id)
                Spring.Echo("[AirFixture] requested wind destruction id="..id)
                break
            end
        end
    end
    if scenario=="constructor" and once("constructor",10800,f) then
        local x,y,z=Spring.GetTeamStartPosition(0)
        give("armaca",0,x+160,z,1)
        Spring.Echo("[AirFixture] gifted one T2 constructor at 6 minutes; no economy injections")
    end
    if (scenario=="capacity" or scenario=="loss") and once("gifts",600,f) then
        local side="arm"
        for _,id in ipairs(Spring.GetTeamUnits(0)) do
            local name=UnitDefs[Spring.GetUnitDefID(id)].name
            if name:sub(1,3)=="cor" then side="cor" elseif name:sub(1,3)=="leg" then side="leg" end
        end
        local x,y,z=Spring.GetTeamStartPosition(0)
        give(side.."aca",0,x+200,z,2)
        give(side.."afus",0,x+1400,z-1400,36)
        give(side=="leg" and "legadveconv" or side.."mmkr",0,x+1400,z-700,80)
        give(side.."estor",0,x+650,z-200,8)
        give(side.."mstor",0,x+550,z-200,8)
        Spring.Echo("[AirFixture] gifted sustainable late economy and two T2 constructors")
    end
    if #queue>0 and f%30==0 then Spring.SendCommands(table.remove(queue,1)) end
    if scenario=="attack" and once("sortie",600,f) then
        local x,y,z=Spring.GetTeamStartPosition(0)
        give("armpnix",0,x,z,24)
        give("armhawk",0,x+180,z,30)
        local ex,ey,ez=Spring.GetTeamStartPosition(1)
        give("armfus",1,ex,ez,3)
        Spring.Echo("[AirFixture] gifted bomber sortie and enemy ground targets; no economy injections")
    end
    if scenario=="loss" and once("loss",18000,f) then
        local killed=0
        for _,id in ipairs(Spring.GetTeamUnits(0)) do
            local d=UnitDefs[Spring.GetUnitDefID(id)]
            if d.name:find("nanotc") and killed<4 then Spring.SendLuaRulesMsg("$dev$:destroyunits "..id); killed=killed+1 end
        end
        Spring.Echo("[AirFixture] requested destruction of "..killed.." construction turrets; require UnitDestroyed evidence")
    end
    if scenario=="switch" and once("tech",5400,f) then Spring.SendSkirmishAIMessage(0,"barb|setrole|0|TECH") end
    if scenario=="switch" and once("air",10800,f) then Spring.SendSkirmishAIMessage(0,"barb|setrole|0|AIR") end
    if scenario=="switch" and once("front",16200,f) then Spring.SendSkirmishAIMessage(0,"barb|setrole|0|FRONT") end
end

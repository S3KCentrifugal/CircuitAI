function widget:GetInfo()
    return {name="AIR income fixture",desc="Explicit low-income, metal-bank and sustained-income phases",author="CircuitAI",layer=121,enabled=true}
end
local queue={}
local side="cor"
local function give(name,x,z,count)
    queue[#queue+1]="give "..tostring(count or 1).." "..name.." 0 @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
function widget:Initialize()
    Spring.Echo("[IncomeFixture] controlled economy; injected assets and bank are not natural-game evidence")
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    if f==900 then
        local x,_,z=Spring.GetTeamStartPosition(0)
        give(side.."fus",x+1500,z-1000,4)
        give(side.."makr",x+1500,z-500,20)
        give(side.."mstor",x+900,z-200,4)
        give(side.."estor",x+1100,z-200,4)
        Spring.Echo("[IncomeFixture] phase low income: 20 basic converters and four fusions")
    end
    if f==10800 then Spring.SendCommands("team 0") end
    if f==10830 then Spring.SendCommands("atm 4000"); Spring.Echo("[IncomeFixture] phase bank: supplied 4000 metal/energy") end
    if f==10860 then Spring.SendCommands("spectator") end
    if f==21600 then
        local x,_,z=Spring.GetTeamStartPosition(0)
        give(side.."fus",x+1700,z-1000,8)
        give(side.."mmkr",x+1700,z-500,8)
        Spring.Echo("[IncomeFixture] phase sustained income: supplied eight advanced converters and eight fusions")
    end
    if #queue>0 and f%30==0 then Spring.SendCommands(table.remove(queue,1)) end
end
function widget:UnitCreated(id,def,team,builder)
    if team~=0 or not builder then return end
    local name=UnitDefs[def].name
    if name=="coraap" then
        local bank,_,_,income=Spring.GetTeamResources(0,"metal")
        Spring.Echo("[IncomeFixture] actual lab frame bank="..math.floor(bank).." income="..math.floor(income))
    end
end
function widget:UnitFinished(id,def,team)
    if team~=0 then return end
    local name=UnitDefs[def].name
    if name=="corbw" or name=="corshad" or name=="corveng" or name=="corca" or name=="coraap" then
        Spring.Echo("[IncomeFixture] finished "..name.." frame="..Spring.GetGameFrame())
    end
end

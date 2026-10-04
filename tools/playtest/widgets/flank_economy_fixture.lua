-- Isolated test fixture: supplies economy only, never factories or combat units.
function widget:GetInfo()
    return {name="Flank economy fixture",desc="Reach the income gate for a focused regression",author="CircuitAI",layer=111,enabled=true}
end
local pending,placed={},{}
local function enqueue(team,name,count,x,z)
    local def=UnitDefNames[name]
    if not def then return end
    for r=0,1200,96 do
        for dx=-r,r,96 do for dz=-r,r,96 do
            if math.abs(dx)==r or math.abs(dz)==r then
                local px,pz=x+dx,z+dz
                local y=Spring.GetGroundHeight(px,pz)
                local free=px>128 and pz>128 and px<Game.mapSizeX-128 and pz<Game.mapSizeZ-128 and y>=0
                for _,p in ipairs(placed) do if (px-p[1])^2+(pz-p[2])^2<192^2 then free=false end end
                if free and Spring.TestBuildOrder(def.id,px,y,pz,0)>0 then
                    pending[#pending+1]="give "..name.." "..team.." @"..px..","..y..","..pz
                    placed[#placed+1]={px,pz}; count=count-1
                    if count==0 then return end
                end
            end
        end end
    end
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    if f==10800 then
        for _,team in ipairs({0,1}) do
            local x,_,z=Spring.GetTeamStartPosition(team)
            local side=x<Game.mapSizeX/2 and 1 or -1
            enqueue(team,"armafus",6,x+side*2000,z+600)
            enqueue(team,"armmmkr",24,x+side*2200,z+600)
        end
        Spring.Echo("[FlankFixture] injecting economy only: "..#pending.." buildings")
    end
    if f>10800 and f%15==0 and #pending>0 then Spring.SendCommands(table.remove(pending,1)) end
end

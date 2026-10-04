function widget:GetInfo()
    return {name="Fortification controlled fixture",desc="Supply TECH assets to exercise protection and expansion",author="CircuitAI",layer=116,enabled=true}
end
local queue={}
local function give(n,t,x,z,count)
    queue[#queue+1]="give "..(count and (count.." ") or "")..n.." "..t.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    if f==1200 then
        local x,_,z=Spring.GetTeamStartPosition(1)
        local gx,gz=x,z
        local found=false
        for r=1800,3600,200 do
            if found then break end
            for k=0,15 do
                local a=k*math.pi/8
                local px,pz=x+math.cos(a)*r,z+math.sin(a)*r
                local good=px>220 and pz>220 and px<Game.mapSizeX-220 and pz<Game.mapSizeZ-220
                    and (px-x)*(Game.mapSizeX/2-x)+(pz-z)*(Game.mapSizeZ/2-z)>0
                -- D-154: only forward assets are supposed to acquire walls.
                for _,t in ipairs(Spring.GetTeamList()) do
                    if t~=Spring.GetGaiaTeamID() and Spring.AreTeamsAllied(1,t) then
                        local sx,_,sz=Spring.GetTeamStartPosition(t)
                        if sx and sx>=0 and sz>=0 and (px-sx)^2+(pz-sz)^2<1840^2 then good=false end
                    end
                end
                for j=0,7 do
                    local b=j*math.pi/4
                    if Spring.GetGroundHeight(px+math.cos(b)*200,pz+math.sin(b)*200)<5 then good=false end
                end
                if good then gx,gz=px,pz;found=true;break end
            end
        end
        if not found then Spring.Echo("[FortFixture] FAIL no forward site"); return end
        give("armgeo",1,gx,gz)
        give("armmoho",1,gx+320,gz)
        give("armack",1,gx-120,gz,2)
        Spring.Echo("[FortFixture] land assets at "..gx..","..gz.." ground="..Spring.GetGroundHeight(gx,gz))
        give("armack",1,x+500,z-100,3)
        give("armca",1,x+500,z-150,4)
        give("armaca",1,gx-100,gz-150,3)
        give("armfus",1,480,7000,3)
        give("armmmkr",1,480,6600,8)
        give("armuwadves",1,480,6200,1)
        Spring.Echo("[FortFixture] injected owned geo/mex, constructors and remote economy; not natural timing evidence")
    end
    if #queue>0 and f%30==0 then Spring.SendCommands(table.remove(queue,1)) end
end

function widget:UnitFinished(id,def,team)
    if team~=1 or not (UnitDefs[def].name:find("drag") or UnitDefs[def].name:find("fort")) then return end
    local x,_,z=Spring.GetUnitPosition(id)
    for _,u in ipairs(Spring.GetTeamUnits(1)) do
        local d=UnitDefs[Spring.GetUnitDefID(u)]
        if d.name:find("geo") or d.name=="armmoho" then
            local ax,_,az=Spring.GetUnitPosition(u)
            if (x-ax)^2+(z-az)^2<640^2 then
                Spring.Echo("[FortFixture] finished wall near "..d.name.." "..u)
            end
        end
    end
end

function widget:GetInfo()
    return {name="Wall base exclusion fixture", desc="Rear assets stay open; forward assets receive walls", author="CircuitAI", layer=116, enabled=true}
end
local queue, assets = {}, {}
local radius, violations, forwardWalls = 1200, 0, 0
local walls = {armdrag=true, armfort=true, armfdrag=true, cordrag=true, corfort=true, corfdrag=true, legdrag=true, legforti=true, legfdrag=true}
local function give(n,t,x,z,count)
    queue[#queue+1]="give "..(count and (count.." ") or "")..n.." "..t.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
local function outsideBases(x,z,team,padding)
    for _,t in ipairs(Spring.GetTeamList()) do
        if t ~= Spring.GetGaiaTeamID() and Spring.AreTeamsAllied(team,t) then
            local sx,_,sz=Spring.GetTeamStartPosition(t)
            if sx and sx>=0 and sz>=0 and (x-sx)^2+(z-sz)^2 <= (radius+padding)^2 then return false end
        end
    end
    return true
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    if f==1200 then
        local x,_,z=Spring.GetTeamStartPosition(1)
        give("armgeo",1,x+240,z+160)
        give("armmoho",1,x+400,z+160)
        Spring.Echo("[WallFixture] rear assets supplied inside TECH base")
        -- Also own an asset in AIR's base, outside TECH's own exclusion.
        local ax,_,az=Spring.GetTeamStartPosition(0)
        give("armmoho",1,ax+240,az+160)
        Spring.Echo("[WallFixture] allied-base asset supplied inside AIR base")
        local found=false
        for r=1800,3600,200 do
            if found then break end
            for k=0,31 do
                local a=k*math.pi/16
                local px,pz=x+math.cos(a)*r,z+math.sin(a)*r
                local good=px>500 and pz>500 and px<Game.mapSizeX-500 and pz<Game.mapSizeZ-500
                    and outsideBases(px,pz,1,640)
                    and (px-x)*(Game.mapSizeX/2-x)+(pz-z)*(Game.mapSizeZ/2-z)>0
                for j=0,7 do
                    local b=j*math.pi/4
                    if Spring.GetGroundHeight(px+math.cos(b)*320,pz+math.sin(b)*320)<5 then good=false end
                end
                if good then
                    give("armgeo",1,px,pz)
                    give("armmoho",1,px+240,pz)
                    give("armack",1,px-120,pz,3)
                    give("armaca",1,px-120,pz-120,3)
                    assets={{px,pz},{px+240,pz}}
                    Spring.Echo("[WallFixture] forward assets supplied at "..px..","..pz)
                    found=true
                    break
                end
            end
        end
        if not found then Spring.Echo("[WallFixture] FAIL no forward site") end
        give("armfus",1,480,7000,3)
        give("armmmkr",1,480,6600,8)
        give("armuwadves",1,480,6200)
        Spring.Echo("[WallFixture] injected economy; not natural timing evidence")
    end
    if #queue>0 and f%30==0 then Spring.SendCommands(table.remove(queue,1)) end
    if f==14*1800 then
        Spring.Echo("[WallFixture] audit violations="..violations.." forwardWalls="..forwardWalls)
        if violations==0 and forwardWalls>0 then Spring.Echo("[WallFixture] PASS rear bases open and forward walls completed") end
    end
end
function widget:UnitCreated(id,def,team)
    if (team~=0 and team~=1) or not walls[UnitDefs[def].name] then return end
    local x,_,z=Spring.GetUnitPosition(id)
    -- The largest standard wall has a 32-elmo footprint. Conservative envelope.
    if not outsideBases(x,z,team,24) then
        violations=violations+1
        Spring.Echo("[WallFixture] FAIL wall inside allied base "..UnitDefs[def].name.." "..x..","..z)
    end
end
function widget:UnitFinished(id,def,team)
    if team~=1 or not walls[UnitDefs[def].name] then return end
    local x,_,z=Spring.GetUnitPosition(id)
    if outsideBases(x,z,team,24) then
        for _,p in ipairs(assets) do
            if (x-p[1])^2+(z-p[2])^2<640^2 then
                forwardWalls=forwardWalls+1
                if forwardWalls==1 then Spring.Echo("[WallFixture] finished forward resource wall") end
                break
            end
        end
    end
end

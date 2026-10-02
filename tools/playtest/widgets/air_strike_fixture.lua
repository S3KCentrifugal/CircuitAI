function widget:GetInfo()
    return {name="AIR strike stages fixture",desc="Rendered supplied-fleet combat measurements",author="CircuitAI",layer=118,enabled=true}
end
local config=VFS.Include("LuaUI/Config/air_strike_fixture.lua")
local prefix=config.side=="cortex" and "cor" or config.side=="legion" and "leg" or "arm"
local bombers={arm="armpnix",cor="corhurc",leg="legphoenix"}
local fighters={arm="armhawk",cor="corvamp",leg="legvenator"}
local tracked, seen, queue={}, {}, {}
local shots, restore={},nil
local stage=0
local function echo(s) Spring.Echo("[AirStrike] "..s) end
local function dry(x,z)
    for r=0,1200,64 do for dx=-r,r,64 do for dz=-r,r,64 do
        local px,pz=x+dx,z+dz
        if Spring.GetGroundHeight(px,pz)>5 then return px,pz end
    end end end
    return x,z
end
local function give(name,team,x,z,n)
    x,z=dry(x,z)
    queue[#queue+1]="give "..(n or 1).." "..name.." "..team.." @"..x..","..Spring.GetGroundHeight(x,z)..","..z
end
local function photograph(key,x,z,height)
    if shots[key] then return end
    shots[key]=true
    Spring.SendCommands({"setmaxspeed 0.25","setminspeed 0.25","setmaxspeed 0.25"})
    Spring.SetCameraState({name="ta",px=x,py=Spring.GetGroundHeight(x,z),pz=z,height=height,angle=0.8},0)
    restore={at=Spring.GetGameFrame()+10,key=key,finish=Spring.GetGameFrame()+20}
    echo("camera="..key.." x="..math.floor(x).." z="..math.floor(z))
end
function widget:Initialize()
    WG.AirStrikeDamage=function(victim,damage,attacker,attackerDef)
        local vd=Spring.GetUnitDefID(victim)
        if vd and UnitDefs[vd].canFly and damage>=1 then
            echo("air-damage stage="..stage.." def="..UnitDefs[attackerDef].name.." amount="..math.floor(damage))
            local ax,_,az=Spring.GetUnitPosition(attacker)
            if ax and not restore then Spring.SelectUnitArray({attacker});photograph("stage"..stage.."-intercept",ax,az,1200) end
        end
        if not tracked[attacker] or damage<1 then return end
        echo("stage-damage stage="..stage.." def="..UnitDefs[attackerDef].name.." amount="..math.floor(damage).." victim="..victim)
        local x,_,z=Spring.GetUnitPosition(victim)
        if x and not restore then Spring.SelectUnitArray({attacker});photograph("stage"..stage.."-impact",x,z,1500) end
    end
end
function widget:Shutdown() WG.AirStrikeDamage=nil end
function widget:UnitCreated(id,def,team)
    local d=UnitDefs[def]
    if team==0 and (d.name=="armthund" or d.name=="corshad" or d.name=="legmos" or d.name==bombers[prefix]) then tracked[id]={def=d.name,stage=stage} end
end
function widget:UnitDestroyed(id,def,team)
    if tracked[id] then echo("loss id="..id.." def="..tracked[id].def.." stage="..tracked[id].stage);tracked[id]=nil end
    if team==1 and not UnitDefs[def].isBuilder then echo("target-destroyed id="..id.." def="..UnitDefs[def].name.." stage="..stage) end
end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands({"cheat 1","globallos"});echo("loaded; supplied units and global LOS; not a natural economy benchmark") end
    if f==1800 then
        stage=1
        give(prefix=="cor" and "corveng" or prefix.."fig",0,2400,11200,20)
        give(prefix=="leg" and "legmos" or prefix=="cor" and "corshad" or "armthund",0,2600,11200,6)
        give("armsolar",1,3300,8200,8);give("armwin",1,3500,8300,12)
        give("corshad",1,2700,10800,2);give("corveng",1,3000,10700,2)
        echo("stage=1 early raid")
    end
    if f==7200 then
        stage=2
        give(bombers[prefix],0,2600,11200,16);give(fighters[prefix],0,2400,11200,30)
        give("armfus",1,3700,7000,1);give("armflak",1,3900,7000,1)
        give("corhurc",1,2800,10800,2);give("corvamp",1,3000,10700,3)
        echo("stage=2 mid strike with flak")
    end
    if f==14400 then
        stage=3
        give(bombers[prefix],0,2600,11200,48);give(fighters[prefix],0,2400,11200,50)
        give("armafus",1,4300,6500,2);give("armflak",1,4500,6600,3)
        give("corhurc",1,2800,10800,6);give("corvamp",1,3000,10700,8)
        echo("stage=3 late strike with flak")
    end
    if #queue>0 and f%15==0 then Spring.SendCommands(table.remove(queue,1)) end
    if restore then
        if f>=restore.at and not restore.shot then Spring.SendCommands("screenshot png");restore.shot=true;echo("screenshot="..restore.key) end
        if f>=restore.finish then Spring.SendCommands({"setmaxspeed 5","setminspeed 5","setmaxspeed 5"});restore=nil end
    end
    if f%30~=0 then return end
    local n,x,z=0,0,0
    local lead,lx,lz=nil,nil,nil
    for id,data in pairs(tracked) do
        if Spring.ValidUnitID(id) then
            local px,_,pz=Spring.GetUnitPosition(id)
            if px then n=n+1;x=x+px;z=z+pz
                if data.stage==stage and (not lz or pz<lz) then lead,lx,lz=id,px,pz end
                if pz<10000 and not seen[id] then seen[id]=true;echo("outbound id="..id.." def="..data.def.." stage="..data.stage) end
            end
        end
    end
    if n>0 then
        x,z=x/n,z/n
        if lead and not restore and lz<10000 then Spring.SelectUnitArray({lead});photograph("stage"..stage.."-outbound",lx,lz,1800) end
        if lead and not restore and lz<8000 then Spring.SelectUnitArray({lead});photograph("stage"..stage.."-target",lx,lz,1800) end
        if f%300==0 then echo("fleet stage="..stage.." count="..n.." centre="..math.floor(x)..","..math.floor(z)) end
    end
end

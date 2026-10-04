function widget:GetInfo()
    return {name="AIR opening and screen observer",desc="Read-only production, commander and patrol evidence",author="CircuitAI",layer=114,enabled=true}
end
local made, commandMemo={},{}
local factory, scout, third, firstFighter
local thirdFrame, firstFighterFrame, transportBetween, idleSince
local scoutId, scoutStart, scoutAway
local commander, previous, walked, guarded= nil,nil,0,0
local function log(s) Spring.Echo("[AirOpening] "..s) end
local function invariant(s) Spring.Echo("[INVARIANT] INV-079 AIR observer: "..s) end
local function cons(n) return n=="armca" or n=="corca" or n=="legca" end
local function fighter(n) return n=="armfig" or n=="corveng" or n=="legfig" or n=="armhawk" or n=="corvamp" or n=="legvenator" end
function widget:UnitDestroyed(id)
    made[id]=nil; commandMemo[id]=nil
    -- Recovery after the last plant dies is a new opening, not a commander
    -- abandoning an existing factory. Keep first-opening timing separately.
    if id==factory then factory=nil; idleSince=nil end
    if id==commander then commander=nil; previous=nil end
end
function widget:UnitCreated(id,def,team,builder)
    if team~=0 then return end
    made[id]=builder
    local n=UnitDefs[def].name
    if not factory and (n=="armap" or n=="corap" or n=="legap") then
        factory=id; log("factory-frame id="..id.." builder="..tostring(builder))
    end
    if thirdFrame and builder==factory then
        if n=="armatlas" or n=="corvalk" or n=="legatrans" then transportBetween=true end
        if fighter(n) and not firstFighterFrame then
            firstFighterFrame=Spring.GetGameFrame()
            local delay=(firstFighterFrame-thirdFrame)/30
            log(string.format("first-fighter-frame delay=%.2f transport=%s",delay,tostring(transportBetween or false)))
            if delay>5 and not transportBetween then Spring.Echo("[INVARIANT] INV-082 AIR observer: initial fighter frame delayed "..delay.." seconds after crew") end
        end
    end
end
function widget:UnitFinished(id,def,team)
    if team~=0 then return end
    local n=UnitDefs[def].name
    local openingDrone=n=="legfig" and not scout
    if n=="armpeep" or n=="corfink" or openingDrone then
        scout=true; scoutId=id
        local x,_,z=Spring.GetUnitPosition(id); scoutStart={x,z}
        log("scout-finished def="..n)
    end
    if cons(n) and made[id] and not scout then invariant("constructor finished before initial scout") end
    if cons(n) and not third then
        local count=0
        for _,u in ipairs(Spring.GetTeamUnits(0)) do
            local d=UnitDefs[Spring.GetUnitDefID(u)]
            local _,_,_,_,p=Spring.GetUnitHealth(u)
            if cons(d.name) and p and p>=1 then count=count+1 end
        end
        log("constructor-finished live="..count.." id="..id)
        if count>=3 then third=true; thirdFrame=Spring.GetGameFrame(); log(string.format("crew-ready t=%.1f commanderWalk=%.1f guardSeconds=%.1f",Spring.GetGameFrame()/30,walked,guarded)) end
    end
    if fighter(n) and not openingDrone and made[id] and not firstFighter then
        firstFighter=true; log("first-fighter def="..n)
        if not third then invariant("fighter finished before three completed constructors") end
    end
end
function widget:GameFrame(f)
    if f%15~=0 then return end
    if scoutId and not scoutAway then
        local x,_,z=Spring.GetUnitPosition(scoutId)
        if x and scoutStart and (x-scoutStart[1])^2+(z-scoutStart[2])^2>500^2 then
            scoutAway=true; log("scout-away id="..scoutId.." distance>500")
        end
    end
    local patrol, fighters, minX, maxX, minZ, maxZ=0,0,math.huge,0,math.huge,0
    local spreadX,spreadZ,farX,farZ=math.huge,math.huge,0,0
    for _,id in ipairs(Spring.GetTeamUnits(0)) do
        local d=UnitDefs[Spring.GetUnitDefID(id)]
        if not factory and (d.name=="armap" or d.name=="corap" or d.name=="legap"
            or d.name=="armaap" or d.name=="coraap" or d.name=="legaap") then factory=id end
        if d.customParams and d.customParams.iscommander then commander=id end
        if fighter(d.name) then
            local _,_,_,_,p=Spring.GetUnitHealth(id)
            if p and p>=1 then
                fighters=fighters+1
                local hasPatrol=false
                for _,c in ipairs(Spring.GetUnitCommands(id,8) or {}) do
                    if c.id==CMD.PATROL then
                        hasPatrol=true
                        local x,z=c.params[1],c.params[3]
                        if x and z then
                            minX=math.min(minX,x); maxX=math.max(maxX,x); minZ=math.min(minZ,z); maxZ=math.max(maxZ,z)
                            if x<0 or z<0 or x>=Game.mapSizeX or z>=Game.mapSizeZ then Spring.Echo("[INVARIANT] INV-080 AIR observer: patrol outside map") end
                        end
                    end
                end
                if hasPatrol then
                    patrol=patrol+1
                    local x,_,z=Spring.GetUnitPosition(id)
                    if x then spreadX=math.min(spreadX,x); spreadZ=math.min(spreadZ,z); farX=math.max(farX,x); farZ=math.max(farZ,z) end
                end
            end
        end
    end
    -- Observe the existing order before the first factory too. A gifted T2
    -- builder can frame a factory while the commander is already finishing
    -- an opening mex; first seeing that old order is not a new mex command.
    if commander and not factory then
        local c=(Spring.GetUnitCommands(commander,1) or {})[1]
        if c then commandMemo[commander]=c.id..":"..tostring(c.params[1]) end
    end
    if factory and commander then
        local x,_,z=Spring.GetUnitPosition(commander)
        if x then
            if previous and not third then walked=walked+math.sqrt((x-previous[1])^2+(z-previous[2])^2) end
            previous={x,z}
            local c=(Spring.GetUnitCommands(commander,1) or {})[1]
            if c then
                local producing=Spring.GetUnitIsBuilding(factory)
                local _,_,_,_,factoryProgress=Spring.GetUnitHealth(factory)
                for _,q in ipairs(Spring.GetFactoryCommands(factory,8) or {}) do
                    if q.id<0 then producing=true end
                end
                -- Finishing the replacement factory itself is useful work;
                -- it cannot yet have an aircraft production target or queue.
                local guarding=(c.id==CMD.GUARD or c.id==CMD.REPAIR) and c.params[1]==factory
                if third and factoryProgress and factoryProgress>=1 and not producing and guarding then
                    idleSince=idleSince or f
                    if f-idleSince>300 then
                        Spring.Echo("[INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds")
                    end
                else idleSince=nil end
                if third and not producing and f%300==0 and (c.id<0 or c.id==CMD.REPAIR) and c.params[1]~=factory then
                    log("idle-factory-economy command="..c.id.." target="..tostring(c.params[1]))
                end
                if c.id==CMD.GUARD and not third then guarded=guarded+0.5 end
                local key=c.id..":"..tostring(c.params[1])
                if commandMemo[commander]~=key then
                    commandMemo[commander]=key
                    log("commander-command id="..c.id.." target="..tostring(c.params[1]).." crewReady="..tostring(third or false))
                    local build=c.id<0 and UnitDefs[-c.id]
                    if build and build.extractsMetal and build.extractsMetal>0 then invariant("commander ordered mex after factory frame") end
                    if build and build.windGenerator and build.windGenerator>0 then
                        local px,pz=c.params[1],c.params[3]
                        local cd=UnitDefs[Spring.GetUnitDefID(commander)]
                        if px and pz then log(string.format("commander-wind-distance=%.1f reach=%.1f",math.sqrt((px-x)^2+(pz-z)^2),cd.buildDistance or 0)) end
                    end
                end
            else idleSince=nil end
        end
    end
    if f%300==0 and fighters>0 then
        log("screen fighters="..fighters.." patrol="..patrol.." bounds="..minX..","..minZ..":"..maxX..","..maxZ
            .." positions="..spreadX..","..spreadZ..":"..farX..","..farZ)
    end
end

-- Supplied +100 regression: supply constructors/resources, then only observe
-- the AI's cannon and cover. Never give construction orders to those builders.
function widget:GetInfo()
    return {name="Lolcannon cover regression", desc="Observe one cannon and five completed cover structures",
        author="CircuitAI", layer=10, enabled=true}
end
local supplied=false
local seen={}
local names={armvulc=true,armgate=true,armanni=true,armflak=true}
local passed=false
local function log(s) Spring.Echo("[CannonCoverTest] "..s) end
function widget:Initialize()
    Spring.SendCommands("cheat")
    Spring.SendCommands("specfullview")
    log("loaded")
end
function widget:GameFrame(f)
    if f==30 and not supplied then
        supplied=true
        for i=0,55 do Spring.SendCommands(string.format("give 1 armaca 0 @%d,0,%d",5100+(i%8)*32,4300+math.floor(i/8)*32)) end
        for i=1,4 do Spring.SendCommands(string.format("give 1 armafus 0 @%d,0,5200",1000+i*240)) end
        Spring.SendCommands("give 1 armuwadves 0 @1000,0,5500")
        log("supplied constructors=56 afus=4")
    end
    -- The economy fixture supplies resources; real builder commands and build
    -- progress still belong to the AI. Team handicap is independently in script.txt.
    if f%30==0 then Spring.SendCommands("atm") end
    if f%30~=0 then return end
    local totals={armvulc=0,armgate=0,armanni=0,armflak=0}
    local guns=0
    local gx,gz
    for _,u in ipairs(Spring.GetTeamUnits(0) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(u) or -1]
        if d and names[d.name] then
            local x,_,z=Spring.GetUnitPosition(u)
            local _,_,_,_,p=Spring.GetUnitHealth(u)
            if d.name=="armvulc" then guns=guns+1;gx=x;gz=z end
            if p and p>=1 then totals[d.name]=totals[d.name]+1 end
            if not seen[u] or (p and p>=1 and seen[u]~="finished") then
                seen[u]=(p and p>=1) and "finished" or "frame"
                log(string.format("unit=%d def=%s state=%s frame=%d x=%.0f z=%.0f",u,d.name,seen[u],f,x,z))
            end
        end
    end
    if guns>1 then log("ERROR duplicate_cannons="..guns) end
    if not passed and totals.armvulc==1 and guns==1 and totals.armgate>=2 and totals.armanni>=2 and totals.armflak>=1 then
        local nearby={armgate=0,armanni=0,armflak=0}
        for _,u in ipairs(Spring.GetTeamUnits(0) or {}) do
            local d=UnitDefs[Spring.GetUnitDefID(u) or -1]
            if d and nearby[d.name] then
                local x,_,z=Spring.GetUnitPosition(u)
                local _,_,_,_,p=Spring.GetUnitHealth(u)
                if p and p>=1 and (x-gx)^2+(z-gz)^2<=900^2 then nearby[d.name]=nearby[d.name]+1 end
            end
        end
        if nearby.armgate>=2 and nearby.armanni>=2 and nearby.armflak>=1 then
            passed=true
            log("PASS cannon=1 shields=2 heavy=2 flak=1 completed_near_actual_cannon")
        end
    end
end

function widget:GetInfo()
    return {name="Lab porc regression",layer=10,enabled=true}
end
local killed=false
local loss=__LOSS__
local primary
local observed=false
function widget:Initialize()
    Spring.SendCommands("cheat")
    Spring.SendCommands("specfullview")
    Spring.Echo("[LabPorcWatch] loaded")
end
function widget:GameFrame(f)
    if f==30 then
        Spring.SendCommands("give 1 coravp 0 @5000,0,4000")
        for i=0,2 do Spring.SendCommands("give 1 coracv 0 @"..(4710+i*40)..",0,4200") end
        Spring.SendCommands("give 2 corafus 0 @2000,0,5000")
    end
    if f%30~=0 then return end
    Spring.SendCommands("atm")
    local constructors={}
    local guns=0
    local unfinished=false
    for _,id in ipairs(Spring.GetTeamUnits(0) or {}) do
        local d=UnitDefs[Spring.GetUnitDefID(id) or -1]
        if d and d.name=="coracv" then constructors[#constructors+1]=id end
        if d and d.name=="corvipe" then
            guns=guns+1
            local _,_,_,_,p=Spring.GetUnitHealth(id)
            if p and p>0 and p<0.8 then unfinished=true end
            if p and p>=1 and not observed then
                observed=true
                Spring.Echo("[LabPorcWatch] original Scorpion completed id="..id)
            end
        end
    end
    if guns>1 then Spring.Echo("[LabPorcWatch] ERROR duplicate Scorpion") end
    table.sort(constructors)
    if not primary and #constructors==3 then primary=constructors[1] end
    if loss and not killed and primary and f>=450 and unfinished then
        Spring.SelectUnitArray({primary},false)
        Spring.SendCommands("destroy")
        Spring.SelectUnitArray({},false)
        killed=true
        Spring.Echo("[LabPorcWatch] destroyed builder="..primary)
    end
end

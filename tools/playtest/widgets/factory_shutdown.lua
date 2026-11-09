-- KI-736: exercise the real Leave Battle path with an unstarted factory order.
function widget:GetInfo()
    return {name="Factory shutdown regression", layer=115, enabled=true}
end
local requested=false
function widget:GameFrame(frame)
    if requested or frame<600 or frame%5~=0 then return end
    for _,team in ipairs(Spring.GetTeamList()) do
        for _,id in ipairs(Spring.GetTeamUnits(team)) do
            local cmd=Spring.GetUnitCurrentCommand(id)
            local def=cmd and cmd<0 and UnitDefs[-cmd]
            -- TECH's disposable T1 bot lab is corridor-exempt. Vehicle plants
            -- exercise a real corridor claim rather than that exempt opening.
            local vehicle=def and (def.name=="armvp" or def.name=="corvp" or def.name=="legvp")
            if vehicle and not Spring.GetUnitIsBuilding(id) then
                requested=true
                Spring.Echo(string.format("[FactoryShutdown] pending team=%d builder=%d factory=%s frame=%d",team,id,def.name,frame))
                Spring.SendCommands("reloadforce")
                return
            end
        end
    end
    if frame>=3600 then
        requested=true
        Spring.Echo("[INVARIANT] FactoryShutdown: no pending factory observed")
        Spring.SendCommands("quitforce")
    end
end

function widget:GetInfo() return {name="Workforce fixed population",layer=128,enabled=true} end
function widget:GameFrame(f)
    if f==300 then Spring.SendCommands("cheat 1") end
    if f==900 then
        for team=0,1 do
            local x,_,z=Spring.GetTeamStartPosition(team)
            local name=team==0 and "armap" or "corap"
            Spring.SendCommands("give 1 "..name.." "..team.." @"..(x+500)..",0,"..z)
        end
    end
    local n= f==3600 and 100 or f==9000 and 400 or f==14400 and 500
    if n then
        local x,_,z=Spring.GetTeamStartPosition(0)
        Spring.SendCommands("give "..n.." armca 0 @"..x..",0,"..z)
    end
    if f>0 and f%1800==0 then
        local workers=0
        for _,id in ipairs(Spring.GetTeamUnits(0)) do
            if UnitDefs[Spring.GetUnitDefID(id)].name=="armca" then workers=workers+1 end
        end
        Spring.Echo("[WorkforceScale] frame="..f.." constructors="..workers)
    end
end

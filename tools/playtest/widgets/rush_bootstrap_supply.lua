function widget:GetInfo() return {name="Rush bootstrap supplied regression",layer=126,enabled=true} end
function widget:GameFrame(f)
    if f==90 then Spring.SendCommands("cheat 1") end
    if f==150 then Spring.SendSkirmishAIMessage(0,"bootstrap-init") end
    if f==240 then
        for i=1,3 do
            local x,z=10000+i*32,1928
            Spring.SendCommands("give 1 corca 0 @"..x..","..Spring.GetGroundHeight(x,z)..","..z)
        end
    end
end
function widget:AddConsoleLine(line)
    local id=line:match("%[BootstrapTest%] kill worker=(%d+)")
    if id then
        Spring.SelectUnitArray({tonumber(id)},false)
        Spring.SendCommands("destroy")
        Spring.SelectUnitArray({},false)
    end
end

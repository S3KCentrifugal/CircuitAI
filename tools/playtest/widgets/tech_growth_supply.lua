function widget:GetInfo()
    return {name="TECH growth air handover fixture",layer=126,enabled=true}
end
function widget:GameFrame(frame)
    if frame==20*60*30-60 then Spring.SendCommands("cheat 1") end
    if frame~=20*60*30 then return end
    local x,y,z=Spring.GetTeamStartPosition(0)
    x=math.floor(x); z=math.floor(z)
    Spring.Echo("[GrowthTest] supply coordinates "..x..","..z)
    for _,name in ipairs({"armaca","armaca","armca"}) do
        Spring.SendCommands("give 1 "..name.." 0 @"..x..","..Spring.GetGroundHeight(x,z)..","..z)
        x=x+64
    end
    Spring.Echo("[GrowthTest] supplied air replacements at 20 minutes")
end

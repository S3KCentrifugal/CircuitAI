function widget:GetInfo()
    return {name="Theatres multiplayer checks",desc="Per-player lane origins",author="CircuitAI",layer=110,enabled=true}
end
local stage=0
function widget:GameFrame(f)
    local ui=WG.barblink; if not ui then return end
    if stage==0 and f>=900 then ui.SetTheatres("all"); stage=1 end
    if stage==1 and f>=1050 then
        local count=0
        for _,id in ipairs(Spring.GetTeamList()) do
            local s=ui.TheatreSnapshot(id)
            if s then
                count=count+1
                local x,_,z=Spring.GetTeamStartPosition(id)
                local p=s.airOrigin
                local ok=s.visible and p and (p[1]-x)^2+(p[2]-z)^2<128^2
                Spring.Echo("[TheatresMulti] " .. (ok and "PASS " or "FAIL ") .. "player " .. id .. " own lane origin")
            end
        end
        Spring.Echo("[TheatresMulti] " .. (count==4 and "PASS" or "FAIL") .. " four player surveys")
        ui.SetTheatres(nil); stage=2
    end
end

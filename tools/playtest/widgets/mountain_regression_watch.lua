function widget:GetInfo()
    return {name="Mountain regression",desc="Read-only income gate evidence",author="CircuitAI",layer=110,enabled=true}
end
local seen={}
function widget:GameFrame(f)
    if f%300~=0 then return end
    for _,team in ipairs({0,1}) do
        local _,_,_,income=Spring.GetTeamResources(team,"metal")
        if income and income>=200 and not seen[team] then
            seen[team]=true
            Spring.Echo("[MountainTest] income gate team="..team.." income="..income)
        end
    end
end

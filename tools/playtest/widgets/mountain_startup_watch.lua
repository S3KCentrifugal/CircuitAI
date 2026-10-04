function widget:GetInfo()
    return {name="Mountain startup probe",desc="Request a survey after both TECH instances initialize",author="CircuitAI",layer=110,enabled=true}
end
function widget:GameFrame(f)
    if f==180 or f==360 then
        for _,team in ipairs({0,1}) do Spring.SendSkirmishAIMessage(team,"barb|theatres|"..team.."|refresh") end
    end
end

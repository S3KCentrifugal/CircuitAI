-- Controlled resource transfer, never a natural-economy benchmark.
function widget:GetInfo()
    return {name="AIR allied donation fixture",desc="Transfer supplied allied metal to AIR between minutes six and sixteen",author="CircuitAI",layer=123,enabled=true}
end
local pending,peak=nil,0
function widget:GameFrame(f)
    if pending then
        local _,_,_,_,_,_,_,received=Spring.GetTeamResources(0,"metal")
        peak=math.max(peak,received or 0)
        if f>=pending+60 then
            Spring.Echo(string.format("[AirDonation] confirmation frame=%d receivedPeak=%.1f",f,peak))
            pending=nil;peak=0
        end
    end
    if f==10500 then Spring.SendCommands("cheat 1") end
    if f==10530 then Spring.SendCommands("team 1") end
    if f<10800 or f>28800 then return end
    if f%600==0 and Spring.GetMyTeamID()==1 then Spring.SendCommands("atm 1000") end
    if f%600==30 then
        if Spring.GetMyTeamID()~=1 or not Spring.AreTeamsAllied(0,1) then
            Spring.Echo("[AirDonation] ERROR fixture donor is not allied team 1");return
        end
        local bank=Spring.GetTeamResources(1,"metal")
        local amount=math.min(1000,bank)
        Spring.ShareResources(0,"metal",amount)
        pending=f;peak=0
        Spring.Echo(string.format("[AirDonation] frame=%d donor=1 recipient=0 requested=%.1f",f,amount))
    end
end

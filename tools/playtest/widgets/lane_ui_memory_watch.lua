function widget:GetInfo()
    return {name='Lane UI memory regression', desc='All-player lanes and player-row clicks', author='CircuitAI', layer=110, enabled=true, handler=true}
end
local elapsed, draws, started, lastSample, clicks, peakKB = 0,0,false,0,0,0
local function click(ui,id)
    local r=ui.ButtonRect(id)
    if not r then return false end
    local x,y=(r[1]+r[3])/2,(r[2]+r[4])/2
    ui.MousePress(x,y,1); ui.MouseRelease(x,y,1)
    return true
end
-- --hidden renders normal screens only twice a minute. DrawGenesis still
-- provides an actual GL context every update, so exercise the real callin
-- there without opening a window over the owner's game.
function widget:DrawGenesis()
    if not started then return end
    local link=widgetHandler:FindWidget('BARb team link')
    if not link then return end
    local before=collectgarbage('count')
    link:DrawScreen()
    peakKB=math.max(peakKB,collectgarbage('count')-before)
    draws=draws+1
end
function widget:Update(dt)
    local ui=WG.barblink
    if not ui or Spring.GetGameFrame()<330 then return end
    if not started then
        started=true; ui.SetOpen(true)
        ui.TheatreOptions({x=8,y=1000,live=true,context=true,routes=true})
        ui.SetTheatres('all')
        Spring.SendCommands('pause 1')
        Spring.Echo('[LaneUIMemory] started')
    end
    elapsed=elapsed+dt
    if elapsed-lastSample>=2 then
        lastSample=elapsed
        if click(ui,'row'..(clicks%5)) then clicks=clicks+1 end
        Spring.Echo(string.format('[LaneUIMemory] seconds=%.1f draws=%d clicks=%d memoryKB=%.0f peakDrawKB=%.1f',elapsed,draws,clicks,collectgarbage('count'),peakKB))
        if collectgarbage('count')>700000 then
            Spring.Echo('[LaneUIMemory] FAIL memory safety cutoff'); Spring.SendCommands('quitforce')
        end
    end
    if elapsed>90 then
        Spring.Echo('[LaneUIMemory] '..(draws>300 and clicks>=20 and 'PASS' or 'FAIL')..' all-player row-click stress')
        Spring.SendCommands('quitforce')
    end
end

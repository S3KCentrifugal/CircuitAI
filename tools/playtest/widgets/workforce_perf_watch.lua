function widget:GetInfo() return {name="Workforce performance observer",layer=127,enabled=true} end
local previous,lastFrame,lastTime,samples=nil,0,nil,{}
local totals={}
function widget:Initialize()
    -- Ordinary engine scopes are disabled until profiling is enabled. The
    -- second argument hides the profiler overlay; this affects this test only.
    Spring.SendCommands("debug 1 0")
end
function widget:GameFrame(f)
    -- Engine's AI scope includes ALL AIs and callbacks, not just AIR's census.
    local total=Spring.GetProfilerTimeRecord("AI",false)
    if f==300 and total<=0 then Spring.Echo("[WorkforcePerf] ERROR AI timer unavailable") end
    if previous and total>=previous and f>lastFrame then
        local elapsed=(total-previous)/(f-lastFrame)
        samples[#samples+1]=elapsed;totals[#totals+1]=elapsed
    end
    previous=total;lastFrame=f
    if f>0 and f%1800==0 then
        table.sort(samples)
        local n=#samples
        local sum=0
        for i=1,n do sum=sum+samples[i] end
        local now=Spring.GetTimer()
        local wall=lastTime and Spring.DiffTimers(now,lastTime) or 0
        lastTime=now
        if n>0 then Spring.Echo(string.format("[WorkforcePerf] frame=%d samples=%d ai_all_p50_ms=%.6f ai_all_p95_ms=%.6f ai_all_max_ms=%.6f sim_speed=%.3f ai_all_p99_ms=%.6f ai_all_mean_ms=%.6f",
            f,n,samples[math.max(1,math.ceil(n*.5))],samples[math.max(1,math.ceil(n*.95))],samples[n],wall>0 and 60/wall or 0,
            samples[math.max(1,math.ceil(n*.99))],sum/n)) end
        samples={}
    end
    if f>0 and f%18000==0 and #totals>0 then
        -- Sorting is outside the measured engine AI scope, once per ten minutes.
        table.sort(totals)
        local n=#totals
        Spring.Echo(string.format("[WorkforcePerfTotal] frame=%d samples=%d ai_all_p50_ms=%.6f ai_all_p95_ms=%.6f ai_all_max_ms=%.6f",
            f,n,totals[math.max(1,math.ceil(n*.5))],totals[math.max(1,math.ceil(n*.95))],totals[n]))
    end
end

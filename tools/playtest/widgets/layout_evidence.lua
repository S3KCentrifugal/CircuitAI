function widget:GetInfo()
    return { name = "Layout evidence", desc = "Show team blueprints for rendered layout checks",
        author = "CircuitAI", layer = 0, enabled = true }
end

function widget:GameFrame(frame)
    if frame < 900 then return end
    Spring.SendCommands("luaui barblayout team")
    Spring.Echo("[LayoutEvidence] requested team blueprints")
    widgetHandler:RemoveWidget(self)
end

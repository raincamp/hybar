local _, _hyb = ...

-- slash cmds
SLASH_HYB_CONFIG1 = "/hellyeahbar"
SLASH_HYB_CONFIG2 = "/hybar"
SLASH_HYB_CONFIG3 = "/hyb"
SlashCmdList["HYB_CONFIG"] = function()
    local configFrame = _hyb.frames and _hyb.frames.config
    if configFrame then
        if configFrame:IsVisible() then
            configFrame:Hide()
        else
            configFrame:Show()
        end
    else
        print("Error: hybar config frame not initialized")
    end
end

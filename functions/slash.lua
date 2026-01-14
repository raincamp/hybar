local _, _hyb = ...

-- slash cmds
SLASH_HYB_CONFIG1 = "/hellyeahbar"
SLASH_HYB_CONFIG2 = "/hybar"
SLASH_HYB_CONFIG3 = "/hyb"
SlashCmdList["HYB_CONFIG"] = function(msg)
    local cmd = strlower(strtrim(msg or ""))

    if cmd == "reset" then
        -- Reset all settings to defaults
        if _hyb.conf and _hyb.conf.ResetAllSettings then
            _hyb.conf.ResetAllSettings()
        end
    elseif cmd == "" then
        -- Toggle config panel
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
    else
        -- Unknown command, show help (will be implemented in #56)
        local configFrame = _hyb.frames and _hyb.frames.config
        if configFrame then
            if configFrame:IsVisible() then
                configFrame:Hide()
            else
                configFrame:Show()
            end
        end
    end
end

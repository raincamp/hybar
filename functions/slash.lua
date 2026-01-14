local _, _hyb = ...
local L = _hyb.locales
local util = _hyb.util

-- Helper to format yes/no
local function YesNo(val)
    return val and L["CMD_YES"] or L["CMD_NO"]
end

-- Print status of all settings
local function PrintStatus()
    util.SystemMsg(L["CMD_STATUS_HEADER"])
    util.SystemMsg(string.format(L["CMD_STATUS_ENABLED"], YesNo(_hybar_user.enabled)))
    util.SystemMsg(string.format(L["CMD_STATUS_LOCKED"], YesNo(_hybar_user.locked)))
    util.SystemMsg(string.format(L["CMD_STATUS_TRANSPARENCY"], math.floor(_hybar_user.transparency * 100)))
    util.SystemMsg(string.format(L["CMD_STATUS_SCALE"], math.floor(_hybar_user.scale * 100)))
    util.SystemMsg(string.format(L["CMD_STATUS_SOUND"], YesNo(_hybar_user.soundEnabled)))
    util.SystemMsg(string.format(L["CMD_STATUS_HIGH_CONTRAST"], YesNo(_hybar_user.highContrast)))
    util.SystemMsg(string.format(L["CMD_STATUS_POSITION"], _hybar_user.point,
        math.floor(_hybar_user.x_offset), math.floor(_hybar_user.y_offset)))
    util.SystemMsg(L["VERSION"])
end

-- Print help message with available commands
local function PrintHelp()
    util.SystemMsg(L["CMD_HELP_HEADER"])
    util.SystemMsg(L["CMD_HELP_CONFIG"])
    util.SystemMsg(L["CMD_HELP_RESET"])
    util.SystemMsg(L["CMD_HELP_STATUS"])
    util.SystemMsg(L["CMD_HELP_HELP"])
end

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
    elseif cmd == "status" then
        -- Display current settings
        PrintStatus()
    elseif cmd == "help" then
        -- Display available commands
        PrintHelp()
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
        -- Unknown command, show help
        util.SystemMsg(L["CMD_UNKNOWN"])
        PrintHelp()
    end
end

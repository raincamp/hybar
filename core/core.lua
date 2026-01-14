local _, _hyb = ...
local L, util, bar, conf, animations = _hyb.locales, _hyb.util, _hyb.bar, _hyb.conf, _hyb.animations

local load_message = { L["WELCOME_LINE_2"], L["WELCOME_LINE_3"] }

local coreFrame = util.Frame("Frame", "CORE_FRAME", UIParent)
coreFrame:RegisterEvent("ADDON_LOADED")


local function OnEvent(_, _, addOnName)
    if addOnName == "hybar" then
        -- Unregister event after loading (performance)
        coreFrame:UnregisterEvent("ADDON_LOADED")

        -- Initialize user settings
        conf.SetUser()
        local user = _hybar_user

        -- Get bar frame reference with validation
        local barFrame = _hyb.frames and _hyb.frames.bar
        if not barFrame then
            util.SystemMsg("Error: hybar frame not initialized")
            return
        end

        -- Position the bar based on user settings
        barFrame:ClearAllPoints()
        barFrame:SetPoint(user.point, UIParent, user.rel_point, user.x_offset, user.y_offset)

        -- Show/hide with fade animation based on user settings
        if user.enabled then
            if animations and animations.FadeIn then
                animations.FadeIn(barFrame)
            else
                barFrame:Show()
            end
        else
            if animations and animations.FadeOut then
                animations.FadeOut(barFrame)
            else
                barFrame:Hide()
            end
        end

        -- Show unlock indicator if bar is unlocked
        if not user.locked and bar then
            bar.ShowUnlockIndicator()
        end

        -- Display welcome message if enabled
        if user.welcomeMsg then
            util.SystemMsgEm()
            for _, line in ipairs(load_message) do
                util.SystemMsg(line)
            end
        end
    end
end


coreFrame:SetScript("OnEvent", OnEvent)
-- Test workflow validation

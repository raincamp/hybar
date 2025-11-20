local _, _hyb = ...


local function SetupConf()
    local conf = {}

    local defaults = {
        enabled = true,
        locked = false,
        welcomeMsg = true,
        point = "CENTER",
        rel_point = "CENTER",
        x_offset = 0,
        y_offset = -200,
    }

    function conf.SetUser()
        _hybar_user = _hybar_user or {}
        local user = _hybar_user

        -- Set defaults for missing values and validate types
        for k, v in pairs(defaults) do
            if user[k] == nil then
                user[k] = v
            elseif type(user[k]) ~= type(v) then
                -- Type mismatch, reset to default (corrupted saved variable)
                user[k] = v
            end
        end

        -- Validate anchor points are valid strings
        local validPoints = {
            CENTER = true,
            TOP = true,
            BOTTOM = true,
            LEFT = true,
            RIGHT = true,
            TOPLEFT = true,
            TOPRIGHT = true,
            BOTTOMLEFT = true,
            BOTTOMRIGHT = true
        }
        if not validPoints[user.point] then
            user.point = defaults.point
        end
        if not validPoints[user.rel_point] then
            user.rel_point = defaults.rel_point
        end

        _hybar_user = user

        -- Update checkbox states with validation
        local cbEnabled = _G["HYBAR_CHECKBUTTON_ENABLED"]
        if cbEnabled then
            cbEnabled:SetChecked(_hybar_user.enabled)
        end

        local cbLocked = _G["HYBAR_CHECKBUTTON_LOCKED"]
        if cbLocked then
            cbLocked:SetChecked(_hybar_user.locked)
        end

        local cbWelcome = _G["HYBAR_CHECKBUTTON_WELCOME_MSG"]
        if cbWelcome then
            cbWelcome:SetChecked(_hybar_user.welcomeMsg)
        end
    end

    function conf:EnabledCheckBoxOnClick()
        _hybar_user.enabled = self:GetChecked()
        local barFrame = _hyb.frames and _hyb.frames.bar
        if barFrame then
            if _hybar_user.enabled then
                barFrame:Show()
            else
                barFrame:Hide()
            end
        end
    end

    function conf:LockedCheckBoxOnClick()
        _hybar_user.locked = self:GetChecked()
    end

    function conf:WelcomeCheckBoxOnClick()
        _hybar_user.welcomeMsg = self:GetChecked()
    end

    return conf
end

if not _hyb.conf then
    _hyb.conf = SetupConf()
end

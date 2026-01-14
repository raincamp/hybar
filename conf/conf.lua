local _, _hyb = ...
local L, util = _hyb.locales, _hyb.util


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
		-- Phase 2 settings
		transparency = 1.0,
		scale = 1.0,
		soundEnabled = true,
		highContrast = false,
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

		-- Validate Phase 2 numeric settings
		if type(user.transparency) == "number" then
			if user.transparency < 0 or user.transparency > 1 then
				user.transparency = defaults.transparency
			end
		end

		if type(user.scale) == "number" then
			if user.scale < 0.5 or user.scale > 2.0 then
				user.scale = defaults.scale
			end
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

		-- Update transparency slider
		local transparencySlider = _G["HYBAR_SLIDER_TRANSPARENCY"]
		if transparencySlider then
			transparencySlider:SetValue(_hybar_user.transparency)
		end

		-- Update scale slider
		local scaleSlider = _G["HYBAR_SLIDER_SCALE"]
		if scaleSlider then
			scaleSlider:SetValue(_hybar_user.scale)
		end
	end

	function conf:EnabledCheckBoxOnClick()
		_hybar_user.enabled = self:GetChecked()
		local barFrame = _hyb.frames and _hyb.frames.bar
		local animations = _hyb.animations
		if barFrame and animations then
			if _hybar_user.enabled then
				animations.FadeIn(barFrame)
			else
				animations.FadeOut(barFrame)
			end
		end
	end

	function conf:LockedCheckBoxOnClick()
		_hybar_user.locked = self:GetChecked()
		local bar = _hyb.bar
		if bar then
			if _hybar_user.locked then
				bar.HideUnlockIndicator()
			else
				bar.ShowUnlockIndicator()
			end
		end
	end

	function conf:WelcomeCheckBoxOnClick()
		_hybar_user.welcomeMsg = self:GetChecked()
	end

	function conf:TransparencySliderOnValueChanged(value)
		_hybar_user.transparency = value
		local barFrame = _hyb.frames and _hyb.frames.bar
		if barFrame then
			barFrame:SetAlpha(value)
		end
	end

	function conf:ScaleSliderOnValueChanged(value)
		_hybar_user.scale = value
		local barFrame = _hyb.frames and _hyb.frames.bar
		if barFrame then
			barFrame:SetScale(value)
		end
	end

	function conf:ResetPositionButtonOnClick()
		-- Reset position to defaults
		_hybar_user.point = defaults.point
		_hybar_user.rel_point = defaults.rel_point
		_hybar_user.x_offset = defaults.x_offset
		_hybar_user.y_offset = defaults.y_offset

		-- Apply position immediately to bar frame
		local barFrame = _hyb.frames and _hyb.frames.bar
		if barFrame then
			barFrame:ClearAllPoints()
			barFrame:SetPoint(_hybar_user.point, UIParent, _hybar_user.rel_point, _hybar_user.x_offset,
				_hybar_user.y_offset)
		end

		-- Show confirmation message
		util.SystemMsg(L["RESET_POSITION_CONFIRM"])
	end

	return conf
end

if not _hyb.conf then
	_hyb.conf = SetupConf()
end

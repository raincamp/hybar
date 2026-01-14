local _, _hyb = ...
local L, util = _hyb.locales, _hyb.util


local function SetupConf()
	local conf = {}

	-- Combat lockdown check helper
	local function InCombatCheck()
		if InCombatLockdown() then
			util.SystemMsg(L["ERROR_COMBAT"])
			return true
		end
		return false
	end

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

		local cbSound = _G["HYBAR_CHECKBUTTON_SOUND_ENABLED"]
		if cbSound then
			cbSound:SetChecked(_hybar_user.soundEnabled)
		end

		local cbHighContrast = _G["HYBAR_CHECKBUTTON_HIGH_CONTRAST"]
		if cbHighContrast then
			cbHighContrast:SetChecked(_hybar_user.highContrast)
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

		-- Update position text (deferred to allow config frame to initialize)
		C_Timer.After(0.1, function()
			if _hyb.UpdatePositionText then
				_hyb.UpdatePositionText()
			end
		end)
	end

	-- Helper to flash a control on settings change
	local function FlashControl(control)
		local animations = _hyb.animations
		if animations and animations.Flash then
			animations.Flash(control, { 0, 1, 0.5 }, 0.3) -- Teal flash
		end
	end

	function conf:EnabledCheckBoxOnClick()
		-- Combat check - revert checkbox if in combat
		if InCombatCheck() then
			self:SetChecked(_hybar_user.enabled)
			return
		end
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
		FlashControl(self)
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
		FlashControl(self)
	end

	function conf:WelcomeCheckBoxOnClick()
		_hybar_user.welcomeMsg = self:GetChecked()
		FlashControl(self)
	end

	function conf:SoundEnabledCheckBoxOnClick()
		_hybar_user.soundEnabled = self:GetChecked()
		FlashControl(self)
	end

	function conf:HighContrastCheckBoxOnClick()
		_hybar_user.highContrast = self:GetChecked()
		local bar = _hyb.bar
		if bar and bar.ApplyHighContrast then
			bar.ApplyHighContrast(_hybar_user.highContrast)
		end
		FlashControl(self)
	end

	function conf:TransparencySliderOnValueChanged(value)
		_hybar_user.transparency = value
		local barFrame = _hyb.frames and _hyb.frames.bar
		if barFrame then
			barFrame:SetAlpha(value)
		end
		-- Only flash on mouse release, not every value change
		if not self._isDragging then
			FlashControl(self)
		end
	end

	function conf:ScaleSliderOnValueChanged(value)
		_hybar_user.scale = value
		local barFrame = _hyb.frames and _hyb.frames.bar
		if barFrame then
			barFrame:SetScale(value)
		end
		-- Only flash on mouse release, not every value change
		if not self._isDragging then
			FlashControl(self)
		end
	end

	function conf:ResetPositionButtonOnClick()
		-- Combat check
		if InCombatCheck() then return end
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

		-- Update position text in config panel
		if _hyb.UpdatePositionText then
			_hyb.UpdatePositionText()
		end

		FlashControl(self)
	end

	function conf.ResetAllSettings()
		-- Combat check
		if InCombatCheck() then return end
		-- Reset all settings to defaults
		for k, v in pairs(defaults) do
			_hybar_user[k] = v
		end

		-- Apply visual changes immediately
		local barFrame = _hyb.frames and _hyb.frames.bar
		if barFrame then
			-- Position
			barFrame:ClearAllPoints()
			barFrame:SetPoint(_hybar_user.point, UIParent, _hybar_user.rel_point, _hybar_user.x_offset, _hybar_user.y_offset)
			-- Transparency
			barFrame:SetAlpha(_hybar_user.transparency)
			-- Scale
			barFrame:SetScale(_hybar_user.scale)
			-- Visibility
			if _hybar_user.enabled then
				barFrame:Show()
			else
				barFrame:Hide()
			end
		end

		-- Apply high contrast
		local bar = _hyb.bar
		if bar and bar.ApplyHighContrast then
			bar.ApplyHighContrast(_hybar_user.highContrast)
		end

		-- Show/hide unlock indicator
		if bar then
			if _hybar_user.locked then
				bar.HideUnlockIndicator()
			else
				bar.ShowUnlockIndicator()
			end
		end

		-- Update UI controls
		conf.SetUser()

		-- Show confirmation
		util.SystemMsg(L["CMD_RESET_CONFIRM"])
	end

	return conf
end

if not _hyb.conf then
	_hyb.conf = SetupConf()
end

local _, _hyb       = ...
local L, conf, util = _hyb.locales, _hyb.conf, _hyb.util

-- Initialize frames namespace if not already done
_hyb.frames         = _hyb.frames or {}

local padding       = 16

-- HYBAR_CONFIG_FRAME
local f             = util.Frame("Frame", "CONFIG_FRAME", UIParent)

f:SetPoint("CENTER")
f:SetSize(350, 420)
f:SetMovable(true)
f:EnableMouse(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", function(self) self:StartMoving() end)
f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
f:SetClampedToScreen(true)

table.insert(UISpecialFrames, "HYBAR_CONFIG_FRAME")

-- background
local fbg = f:CreateTexture(nil, "BACKGROUND")

fbg:SetAllPoints()
fbg:SetColorTexture(0, 0, 0, 0.8)


-- HYBAR_CONFIG_PANEL
local panel = CreateFrame("Frame", L["ns"] .. "CONFIG_PANEL", f)

panel:SetPoint("TOPLEFT", f, "TOPLEFT", padding, -padding)
panel:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -padding, padding)


-- title text
local titleText = util.Text(panel, "|cFF00FFFF" .. L["hybar"] .. "|r", "SystemFont_Huge1")

titleText:SetPoint("TOP", panel)

local footerText = util.Text(panel, "|cFF00FFFF" .. L["VERSION"] .. "|r" .. " | " .. L["GITHUB_URL"], "SystemFont_Tiny")
footerText:SetPoint("BOTTOM", panel)

-- hr
local hr = panel:CreateLine()
hr:SetThickness(0.5)
hr:SetColorTexture(1, 1, 1, 0.5)
hr:SetStartPoint("TOPLEFT", panel, 0, -padding * 4 - 2)
hr:SetEndPoint("TOPRIGHT", panel, 0, -padding * 4 - 2)

-- options frame
local optionsFrame = util.Frame("Frame", "OPTIONS_FRAME", f)

optionsFrame:SetPoint("TOPLEFT", f, "TOPLEFT", padding, -padding * 4)
optionsFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -padding, padding)


-- ============================================================================
-- SECTION: BEHAVIOR
-- ============================================================================

local behaviorHeader = util.Text(optionsFrame, L["SECTION_BEHAVIOR"], "SystemFont_Med1")
behaviorHeader:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 0, 0)
behaviorHeader:SetTextColor(0, 1, 1) -- Cyan

-- Color hierarchy for checkbox labels
-- Critical (Gold): Enable - most important, controls bar visibility
-- Medium (White): Lock, Sound - important settings
-- Low (Gray): Welcome Message - convenience feature

-- enabled (Critical - Gold)
local cbEnabled = util.Checkbox(optionsFrame, "ENABLED", 0, -padding - 6, L["USER_ENABLED"])
local cbEnabledText = _G[cbEnabled:GetName() .. "Text"]
if cbEnabledText then cbEnabledText:SetTextColor(1, 0.82, 0) end -- Gold

cbEnabled.tooltip = L["USER_ENABLED_TOOLTIP"]
cbEnabled:SetScript("OnClick", conf.EnabledCheckBoxOnClick)
cbEnabled:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
	GameTooltip:Show()
end)
cbEnabled:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- locked (Medium - White, default)
local cbLocked = util.Checkbox(optionsFrame, "LOCKED", 0, -padding * 3 - 6, L["USER_LOCKED"])

cbLocked.tooltip = L["USER_LOCKED_TOOLTIP"]
cbLocked:SetScript("OnClick", conf.LockedCheckBoxOnClick)
cbLocked:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
	GameTooltip:Show()
end)
cbLocked:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- welcomeMsg (Low - Gray)
local cbWelcome = util.Checkbox(optionsFrame, "WELCOME_MSG", 0, -padding * 5 - 6, L["USER_WELCOME_MSG"])
local cbWelcomeText = _G[cbWelcome:GetName() .. "Text"]
if cbWelcomeText then cbWelcomeText:SetTextColor(0.7, 0.7, 0.7) end -- Gray

cbWelcome.tooltip = L["USER_WELCOME_MSG_TOOLTIP"]
cbWelcome:SetScript("OnClick", conf.WelcomeCheckBoxOnClick)
cbWelcome:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
	GameTooltip:Show()
end)
cbWelcome:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- sound enabled (Medium - White, default)
local cbSound = util.Checkbox(optionsFrame, "SOUND_ENABLED", 0, -padding * 7 - 6, L["USER_SOUND_ENABLED"])

cbSound.tooltip = L["USER_SOUND_ENABLED_TOOLTIP"]
cbSound:SetScript("OnClick", conf.SoundEnabledCheckBoxOnClick)
cbSound:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
	GameTooltip:Show()
end)
cbSound:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)


-- ============================================================================
-- SECTION: APPEARANCE
-- ============================================================================

local appearanceHeader = util.Text(optionsFrame, L["SECTION_APPEARANCE"], "SystemFont_Med1")
appearanceHeader:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 0, -padding * 9 - 6)
appearanceHeader:SetTextColor(0, 1, 1) -- Cyan

-- transparency slider
local transparencySlider = util.Slider(optionsFrame, "TRANSPARENCY", 0, -padding * 11, 200, 0, 1, 0.01,
	L["USER_TRANSPARENCY"])

transparencySlider.tooltip = L["USER_TRANSPARENCY_TOOLTIP"]
transparencySlider:SetScript("OnValueChanged", conf.TransparencySliderOnValueChanged)
transparencySlider:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
	GameTooltip:Show()
end)
transparencySlider:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- scale slider
local scaleSlider = util.Slider(optionsFrame, "SCALE", 0, -padding * 14, 200, 0.5, 2.0, 0.05, L["USER_SCALE"])

scaleSlider.tooltip = L["USER_SCALE_TOOLTIP"]
scaleSlider:SetScript("OnValueChanged", conf.ScaleSliderOnValueChanged)
scaleSlider:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
	GameTooltip:Show()
end)
scaleSlider:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- high contrast (Medium - White, default)
local cbHighContrast = util.Checkbox(optionsFrame, "HIGH_CONTRAST", 0, -padding * 16 - 6, L["USER_HIGH_CONTRAST"])

cbHighContrast.tooltip = L["USER_HIGH_CONTRAST_TOOLTIP"]
cbHighContrast:SetScript("OnClick", conf.HighContrastCheckBoxOnClick)
cbHighContrast:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
	GameTooltip:Show()
end)
cbHighContrast:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)


-- ============================================================================
-- SECTION: POSITION
-- ============================================================================

local positionHeader = util.Text(optionsFrame, L["SECTION_POSITION"], "SystemFont_Med1")
positionHeader:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 0, -padding * 18 - 6)
positionHeader:SetTextColor(0, 1, 1) -- Cyan

-- position preview text
local positionLabel = util.Text(optionsFrame, L["POSITION_LABEL"], "SystemFont_Small")
positionLabel:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 0, -padding * 20)

local positionText = util.Text(optionsFrame, "", "SystemFont_Small")
positionText:SetPoint("LEFT", positionLabel, "RIGHT", 4, 0)
positionText:SetTextColor(0.7, 0.7, 0.7)

-- Function to update position display
local function UpdatePositionText()
	if _hybar_user then
		local pos = string.format("%s (%d, %d)",
			_hybar_user.point or "CENTER",
			_hybar_user.x_offset or 0,
			_hybar_user.y_offset or 0)
		positionText:SetText(pos)
	end
end

-- Store update function in namespace for bar.lua to call
_hyb.UpdatePositionText = UpdatePositionText

-- reset position button
local resetPosButton = util.Button(optionsFrame, "RESET_POSITION", 0, -padding * 21 - 6, 150, 22,
	L["RESET_POSITION_BUTTON"])

resetPosButton.tooltip = L["RESET_POSITION_BUTTON_TOOLTIP"]
resetPosButton:SetScript("OnClick", conf.ResetPositionButtonOnClick)
resetPosButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltip, 1, 1, 1, 1, true)
	GameTooltip:Show()
end)
resetPosButton:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

-- Store config frame reference in namespace
_hyb.frames.config = f

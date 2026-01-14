local _, _hyb = ...
local L, util, conf = _hyb.locales, _hyb.util, _hyb.conf

-- Initialize bar module and frames namespace
local bar = _hyb.bar or {}
_hyb.frames = _hyb.frames or {}

local BUTTON_SIZE = 32
local PADDING = 2
local NUM_BUTTONS = 2
local BUTTON_SPACING = 2.2

local f = util.Frame("Frame", "BAR_FRAME", UIParent)

local fbg = f:CreateTexture("BACKGROUND")

fbg:SetAllPoints(true)
fbg:SetColorTexture(0, 0, 0, 0.8)

-- Store buttons for future access
local buttons = {}

for i = 1, NUM_BUTTONS do
	-- Create secure action button (no ActionButtonTemplate to avoid taint)
	local button = CreateFrame("Button", "$parentButton" .. i, f, "SecureActionButtonTemplate")

	-- Enable mouse interaction on the button
	button:EnableMouse(true)
	button:RegisterForClicks("AnyUp")

	-- Create icon texture manually instead of relying on template
	local icon = button:CreateTexture(nil, "BACKGROUND")
	icon:SetAllPoints(button)
	icon:SetTexture(L["icon" .. tostring(i)])
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.icon = icon

	button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
	button:SetPoint("LEFT", f, "LEFT", PADDING + ((i - 1) * (BUTTON_SIZE + BUTTON_SPACING)), 0)

	-- Set secure attributes for macro execution
	button:SetAttribute("type", "macro")
	button:SetAttribute("macrotext", L["tooltip" .. tostring(i)] .. " " .. L["hyb" .. tostring(i)])

	-- Add tooltips directly to the button
	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:SetText(L["tooltip" .. tostring(i)], 1, 1, 1)
		local fontName, fontHeight, fontFlags = GameTooltipTextLeft1:GetFont()
		GameTooltipTextLeft1:SetFont(fontName, 12, fontFlags)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	-- Create highlight texture manually
	local highlight = button:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetAllPoints(button)
	highlight:SetColorTexture(1, 1, 1, 0.3)

	-- Create glow border for enhanced hover effect
	local glow = button:CreateTexture(nil, "OVERLAY")
	glow:SetPoint("TOPLEFT", button, "TOPLEFT", -2, 2)
	glow:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
	glow:SetColorTexture(0, 1, 1, 0)
	glow:SetBlendMode("ADD")
	button.glow = glow

	-- Store original OnEnter/OnLeave and wrap with hover effects
	local originalOnEnter = button:GetScript("OnEnter")
	local originalOnLeave = button:GetScript("OnLeave")

	button:SetScript("OnEnter", function(self)
		-- Show glow effect
		self.glow:SetColorTexture(0, 1, 1, 0.4)
		-- Call original tooltip handler
		if originalOnEnter then originalOnEnter(self) end
	end)

	button:SetScript("OnLeave", function(self)
		-- Hide glow effect
		self.glow:SetColorTexture(0, 1, 1, 0)
		-- Call original tooltip handler
		if originalOnLeave then originalOnLeave(self) end
	end)

	-- Create press flash texture for click feedback
	local flash = button:CreateTexture(nil, "OVERLAY")
	flash:SetAllPoints(button)
	flash:SetColorTexture(1, 1, 1, 0)
	flash:SetBlendMode("ADD")
	button.flash = flash

	-- Create animation for press feedback
	local flashAnim = flash:CreateAnimationGroup()
	local fadeIn = flashAnim:CreateAnimation("Alpha")
	fadeIn:SetFromAlpha(0)
	fadeIn:SetToAlpha(0.6)
	fadeIn:SetDuration(0.05)
	fadeIn:SetOrder(1)
	local fadeOut = flashAnim:CreateAnimation("Alpha")
	fadeOut:SetFromAlpha(0.6)
	fadeOut:SetToAlpha(0)
	fadeOut:SetDuration(0.15)
	fadeOut:SetOrder(2)
	button.flashAnim = flashAnim

	-- Play sound and flash on button press (PostClick fires after secure action)
	button:SetScript("PostClick", function(self)
		util.PlayButtonSound()
		self.flashAnim:Stop()
		self.flashAnim:Play()
	end)

	buttons[i] = button
end

-- Store button references in namespace
bar.buttons = buttons


local OnFrameDragStart = function()
	if not _hybar_user.locked then
		f:StartMoving()
	end
end


local OnFrameDragStop = function()
	f:StopMovingOrSizing()
	local point, _, rel_point, x_offset, y_offset = f:GetPoint()

	if x_offset < 20 and x_offset > -20 then
		x_offset = 0
	end

	_hybar_user.point = point
	_hybar_user.rel_point = rel_point
	_hybar_user.x_offset = _hyb.util.SimpleRound(x_offset, 1)
	_hybar_user.y_offset = _hyb.util.SimpleRound(y_offset, 1)
end


-- Resize the frame to fit the new button sizes
local totalWidth = (BUTTON_SIZE * NUM_BUTTONS) + (BUTTON_SPACING * (NUM_BUTTONS - 1)) + (PADDING * 2)
local totalHeight = BUTTON_SIZE + (PADDING * 2)

f:SetSize(totalWidth, totalHeight)

f:SetMovable(true)
f:EnableMouse(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", OnFrameDragStart)
f:SetScript("OnDragStop", OnFrameDragStop)
f:SetClampedToScreen(true)

-- Apply initial Phase 2 settings from saved variables
if _hybar_user then
	if _hybar_user.transparency then
		f:SetAlpha(_hybar_user.transparency)
	end
	if _hybar_user.scale then
		f:SetScale(_hybar_user.scale)
	end
end

-- Create unlock indicator border (glowing border when unlocked)
local unlockBorder = CreateFrame("Frame", nil, f, "BackdropTemplate")
unlockBorder:SetPoint("TOPLEFT", f, "TOPLEFT", -3, 3)
unlockBorder:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 3, -3)
unlockBorder:SetBackdrop({
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 12,
})
unlockBorder:SetBackdropBorderColor(1, 0.82, 0, 0.9) -- Gold color
unlockBorder:SetFrameLevel(f:GetFrameLevel() + 1)
unlockBorder:Hide()

-- Pulse animation for unlock border
local unlockPulse = unlockBorder:CreateAnimationGroup()
unlockPulse:SetLooping("BOUNCE")
local pulseAlpha = unlockPulse:CreateAnimation("Alpha")
pulseAlpha:SetFromAlpha(0.5)
pulseAlpha:SetToAlpha(1)
pulseAlpha:SetDuration(0.8)
pulseAlpha:SetSmoothing("IN_OUT")

---Show the unlock indicator border with pulse animation
function bar.ShowUnlockIndicator()
	unlockBorder:Show()
	unlockPulse:Play()
end

---Hide the unlock indicator border
function bar.HideUnlockIndicator()
	unlockPulse:Stop()
	unlockBorder:Hide()
end

-- Store frame references in namespace for easy access
_hyb.frames.bar = f
_hyb.frames.unlockBorder = unlockBorder
_hyb.bar = bar

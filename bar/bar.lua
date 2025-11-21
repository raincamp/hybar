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

-- Store frame references in namespace for easy access
_hyb.frames.bar = f
_hyb.bar = bar

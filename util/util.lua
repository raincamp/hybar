local _hybName, _hyb = ...
local L = _hyb.locales

if _hyb.util then return end

-- Local references for performance
local floor = math.floor

local util = {}

util.SystemMsg = function(msg)
	_G["DEFAULT_CHAT_FRAME"]:AddMessage("|cFF00FFFF" .. msg .. "|r")
end

util.SystemMsgEm = function()
	_G["DEFAULT_CHAT_FRAME"]:AddMessage("|cFF00FFFF" .. L["hybar"])
end


util.SimpleRound = function(num, step)
	return floor(num / step) * step
end


util.Text = function(parent, text, font)
	local text_obj = parent:CreateFontString(nil, "ARTWORK", font)
	text_obj:SetText(text)

	return text_obj
end


util.Frame = function(type, name, parent, template)
	return CreateFrame(type, L["ns"] .. name, parent, template)
end


util.Checkbox = function(parent, id, x, y, val)
	local cb = CreateFrame("CheckButton", L["ns"] .. "CHECKBUTTON_" .. id, parent, "ChatConfigCheckButtonTemplate")
	local textName = cb:GetName() .. "Text"
	local textObject = _G[textName]

	textObject:SetText(val)
	cb:SetPoint("TOPLEFT", x, y)

	return cb
end


util.Slider = function(parent, id, x, y, width, minVal, maxVal, step, label)
	local slider = CreateFrame("Slider", L["ns"] .. "SLIDER_" .. id, parent, "OptionsSliderTemplate")

	slider:SetPoint("TOPLEFT", x, y)
	slider:SetWidth(width or 200)
	slider:SetMinMaxValues(minVal, maxVal)
	slider:SetValueStep(step)
	slider:SetObeyStepOnDrag(true)

	-- Set label text
	local labelText = _G[slider:GetName() .. "Text"]
	if labelText then
		labelText:SetText(label or "")
	end

	-- Set min/max labels
	local lowText = _G[slider:GetName() .. "Low"]
	local highText = _G[slider:GetName() .. "High"]
	if lowText then
		lowText:SetText("")
	end
	if highText then
		highText:SetText("")
	end

	return slider
end


util.Button = function(parent, id, x, y, width, height, text)
	local button = CreateFrame("Button", L["ns"] .. "BUTTON_" .. id, parent, "UIPanelButtonTemplate")

	button:SetPoint("TOPLEFT", x, y)
	button:SetWidth(width or 100)
	button:SetHeight(height or 22)
	button:SetText(text or "")

	return button
end


util.PlayButtonSound = function()
	if _hybar_user and _hybar_user.soundEnabled then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	end
end

_hyb.util = util

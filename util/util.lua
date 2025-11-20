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

_hyb.util = util

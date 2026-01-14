local _, _hyb = ...

_hyb.locales = {}

local L = _hyb.locales

L["ns"] = "HYBAR_"
L["VERSION"] = "v1.1.0-alpha"

L["hybar"] = "卄乇ㄥㄥ　ㄚ乇卂卄　乃卂尺"
L["hyb1"] = "卄乇ㄥㄥ　ㄚ乇卂卄　乃尺ㄖㄒ卄乇尺"
L["hyb2"] = "卄乇ㄥㄥ　ㄚ乇卂卄　乃尺ㄖㄒ卄乇尺"

L["icon1"] = "Interface\\Icons\\ability_warrior_rallyingcry"
L["icon2"] = "Interface\\Icons\\inv_misc_head_dragon_green"

L["tooltip1"] = "/y"
L["tooltip2"] = "/g"

L["Settings"] = "hybar settings"
L["USER_ENABLED"] = "Enable"
L["USER_ENABLED_TOOLTIP"] = "Uncheck to hide the bar"
L["USER_LOCKED"] = "Lock"
L["USER_LOCKED_TOOLTIP"] = "Check to lock the bar"
L["USER_WELCOME_MSG"] = "Show Welcome Message"
L["USER_WELCOME_MSG_TOOLTIP"] = "Uncheck to disable the welcome message"
L["Bar Height"] = "Bar Height"
L["X Offset"] = "X Offset"
L["Y Offset"] = "Y Offset"

L["WELCOME_LINE_2"] = " " .. "|cFFFFFFFF/hyb|r to configure"
L["WELCOME_LINE_3"] = " " .. L["VERSION"] .. " | " .. "https://github.com/raincamp/hybar"

L["GITHUB_URL"] = "https://github.com/raincamp/hybar"
L["CONF_FRAME_FOOTER"] = L["VERSION"] .. " | " .. L["GITHUB_URL"]

-- Phase 2: Transparency Slider
L["USER_TRANSPARENCY"] = "Transparency"
L["USER_TRANSPARENCY_TOOLTIP"] = "Adjust bar transparency (0% = invisible, 100% = opaque)"

-- Phase 2: Scale Slider
L["USER_SCALE"] = "Scale"
L["USER_SCALE_TOOLTIP"] = "Adjust bar size (50% to 200%)"

-- Phase 2: Sound Checkbox
L["USER_SOUND_ENABLED"] = "Sound Feedback"
L["USER_SOUND_ENABLED_TOOLTIP"] = "Play sound effects when clicking buttons"

-- Phase 2: High Contrast Checkbox
L["USER_HIGH_CONTRAST"] = "High Contrast Mode"
L["USER_HIGH_CONTRAST_TOOLTIP"] = "Increase visual contrast for better visibility"

-- Phase 2: Section Headers
L["SECTION_BEHAVIOR"] = "Behavior"
L["SECTION_APPEARANCE"] = "Appearance"
L["SECTION_POSITION"] = "Position"

-- Phase 2: Position Preview
L["POSITION_LABEL"] = "Current:"

-- Phase 2: Reset Position Button
L["RESET_POSITION_BUTTON"] = "Reset Position"
L["RESET_POSITION_BUTTON_TOOLTIP"] = "Reset bar to default position (center of screen)"
L["RESET_POSITION_CONFIRM"] = "Bar position reset to default"

-- Phase 2: Slider Labels and Values
L["SLIDER_VALUE_PERCENT"] = "%d%%"
L["TRANSPARENCY_MIN"] = "0%"
L["TRANSPARENCY_MAX"] = "100%"
L["SCALE_MIN"] = "50%"
L["SCALE_MAX"] = "200%"

-- Phase 2: Command Responses
L["CMD_RESET_CONFIRM"] = "All settings reset to defaults"
L["CMD_STATUS_HEADER"] = "hybar Status:"
L["CMD_STATUS_ENABLED"] = "Enabled: %s"
L["CMD_STATUS_LOCKED"] = "Locked: %s"
L["CMD_STATUS_TRANSPARENCY"] = "Transparency: %d%%"
L["CMD_STATUS_SCALE"] = "Scale: %d%%"
L["CMD_STATUS_SOUND"] = "Sound: %s"
L["CMD_STATUS_HIGH_CONTRAST"] = "High Contrast: %s"
L["CMD_STATUS_POSITION"] = "Position: %s (%d, %d)"
L["CMD_YES"] = "Yes"
L["CMD_NO"] = "No"
L["CMD_HELP_HEADER"] = "hybar Commands:"
L["CMD_HELP_CONFIG"] = "/hybar - Open configuration panel"
L["CMD_HELP_RESET"] = "/hybar reset - Reset all settings to defaults"
L["CMD_HELP_STATUS"] = "/hybar status - Display current settings"
L["CMD_HELP_HELP"] = "/hybar help - Show this help message"
L["CMD_UNKNOWN"] = "Unknown command. Type '/hybar help' for available commands."

-- Phase 2: Error Messages
L["ERROR_COMBAT"] = "Cannot change settings while in combat"
L["ERROR_INVALID_VALUE"] = "Invalid value. Must be between %d and %d"

-- Phase 2: Confirmation Messages
L["SETTINGS_CHANGED"] = "Settings updated"
L["TRANSPARENCY_CHANGED"] = "Transparency set to %d%%"
L["SCALE_CHANGED"] = "Scale set to %d%%"

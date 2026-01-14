-- Luacheck configuration for hybar WoW addon
-- https://luacheck.readthedocs.io/

std = "lua51"

-- Silence unused argument warnings (common in WoW event handlers)
unused_args = false

-- Silence unused variable warnings (common in WoW addons)
unused = false

-- Allow long lines (WoW addons often have long strings)
max_line_length = false

-- Global variables defined by WoW and addon
globals = {
    -- Addon namespace
    "_hyb",

    -- Addon SavedVariables (defined in .toc)
    "_hybar_user",

    -- Slash command handlers
    "SLASH_HYBAR1",
    "SLASH_HYBAR2",
    "SLASH_HYBAR3",
    "SLASH_HYB_CONFIG1",
    "SLASH_HYB_CONFIG2",
    "SLASH_HYB_CONFIG3",
    "SlashCmdList",
}

read_globals = {
    -- WoW API - Frames
    "CreateFrame",
    "UIParent",
    "BackdropTemplateMixin",

    -- WoW API - Fonts
    "GameFontNormal",
    "GameFontNormalSmall",
    "GameFontHighlight",
    "GameFontHighlightSmall",

    -- WoW API - Tooltips
    "GameTooltip",
    "GameTooltipTextLeft1",

    -- WoW API - Sound
    "PlaySound",
    "SOUNDKIT",

    -- WoW API - Chat
    "DEFAULT_CHAT_FRAME",

    -- WoW API - Colors
    "HIGHLIGHT_FONT_COLOR",
    "NORMAL_FONT_COLOR",

    -- WoW API - Timers
    "C_Timer",

    -- WoW API - Misc
    "GetAddOnMetadata",
    "InCombatLockdown",
    "IsShiftKeyDown",
    "ReloadUI",
    "UISpecialFrames",

    -- Lua standard globals
    "string",
    "table",
    "math",
    "pairs",
    "ipairs",
    "type",
    "tostring",
    "tonumber",
    "print",
    "unpack",
    "select",
    "wipe",
    "format",
    "strsplit",
    "strlower",
    "strupper",
    "strtrim",
    "strlen",
    "strfind",
    "strsub",
    "gsub",
    "gmatch",
    "tinsert",
    "tremove",
    "tContains",
    "CopyTable",
    "date",
    "time",
    "debugstack",
    "geterrorhandler",
    "seterrorhandler",
}

-- Exclude files
exclude_files = {
    "definitions.lua",  -- LuaLS type annotations only
    ".luacheckrc",
}

-- Per-file configuration
files = {
    ["locales/*.lua"] = {
        -- Localization files define many strings
        max_line_length = 200,
    },
}

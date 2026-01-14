-- Luacheck configuration for hybar WoW addon
-- https://luacheck.readthedocs.io/

std = "lua51"

-- Silence unused argument warnings (common in WoW event handlers)
unused_args = false

-- Allow long lines (WoW addons often have long strings)
max_line_length = false

-- Global variables defined by WoW
globals = {
    -- Addon namespace
    "_hyb",

    -- Slash command handlers
    "SLASH_HYBAR1",
    "SLASH_HYBAR2",
    "SLASH_HYBAR3",
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

    -- WoW API - Sound
    "PlaySound",
    "SOUNDKIT",

    -- WoW API - Chat
    "DEFAULT_CHAT_FRAME",

    -- WoW API - Colors
    "HIGHLIGHT_FONT_COLOR",
    "NORMAL_FONT_COLOR",

    -- WoW API - Misc
    "GetAddOnMetadata",
    "InCombatLockdown",
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

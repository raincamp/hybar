# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**hybar** is a World of Warcraft Classic Era addon (Interface 11501) written in Lua. It provides a dedicated 2-button action bar for quick "hell yeah brother" communication in guild chat and yell channels.

**Key Details:**
- Author: hyb-devs
- Version: 1.0.2-alpha
- Repository: https://github.com/hyb-devs/hybar
- Curse Project ID: 980904

## Development Workflow

### Testing Changes

Since this is a WoW addon (not a Node.js/build-tool project):

1. Edit `.lua` files directly
2. In-game, type `/reload` to reload the UI
3. Test using slash commands: `/hellyeahbar`, `/hybar`, or `/hyb`

### No Build System

There are no npm scripts, build tools, or test runners. WoW loads Lua files directly from the addon directory.

### Packaging

- `pkgmeta.yaml` defines packaging configuration for CurseForge/WoWInterface
- File loading order is defined in `hybar.toc` (critical - see below)

## Code Architecture

### Namespace Pattern

All modules share a single namespace table:

```lua
local _, _hyb = ...
_hyb.locales = {}
_hyb.util = {}
_hyb.conf = {}
_hyb.bar = {}
```

### File Loading Order

**Critical:** Files must be loaded in dependency order (defined in `hybar.toc`):

1. `locales/hybar-enUS.lua` - Localization strings (must load first)
2. `definitions.lua` - LuaLS type annotations
3. `util/util.lua` - Shared utility functions
4. `conf/conf.lua` - Configuration data management
5. `conf/frame_conf.lua` - Configuration UI frame
6. `bar/bar.lua` - Action bar creation
7. `core/core.lua` - Event handlers & initialization
8. `functions/slash.lua` - Slash command registration

**When adding new files:** Update `hybar.toc` with the correct loading position based on dependencies.

### Module Breakdown

#### `locales/hybar-enUS.lua`
- All UI strings and constants
- Namespace prefix: `"HYBAR_"`
- Icons, tooltips, version strings
- **Always add new strings here, not hardcoded in code**

#### `util/util.lua`
- `SystemMsg()` - Print colored messages to chat
- `SimpleRound()` - Round numbers to nearest step
- `Text()` - Create font strings with consistent styling
- `Frame()` - Create frames with `"HYBAR_"` prefix
- `Checkbox()` - Create checkboxes with standard styling

#### `conf/conf.lua`
- Manages saved variables (`_hybar_user`)
- Default settings: `enabled`, `locked`, `welcomeMsg`, position data
- Checkbox event handlers
- **This is where configuration logic lives, not in the UI file**

#### `bar/bar.lua`
- Creates the 2-button action bar using `SecureActionButtonTemplate`
- Button 1: Rally Cry icon → `/y` (yell) macro
- Button 2: Green Dragon icon → `/g` (guild) macro
- Handles drag & drop positioning
- Saves position to `_hybar_user.point`, `rel_point`, `x_offset`, `y_offset`
- Button size: 32px with 2.2px spacing

#### `core/core.lua`
- Registers `ADDON_LOADED` event
- Loads user settings on startup
- Shows/hides bar based on `_hybar_user.enabled`
- Displays welcome message if `_hybar_user.welcomeMsg` is true

#### `conf/frame_conf.lua`
- 300x230px configuration panel
- Three checkboxes: Enable, Lock, Welcome Message
- Registered with `UISpecialFrames` (ESC key closes it)

#### `functions/slash.lua`
- Registers 3 slash command aliases
- Toggles config panel visibility

### Saved Variables

`_hybar_user` persists across sessions:

```lua
{
    enabled = true,        -- Bar visibility
    locked = false,        -- Movement lock
    welcomeMsg = true,     -- Show welcome message on login
    point = "CENTER",      -- Anchor point
    rel_point = "CENTER",  -- Relative anchor point
    x_offset = 0,          -- X position offset
    y_offset = -200,       -- Y position offset
}
```

## WoW API Patterns Used

### SecureActionButtonTemplate

The action bar uses WoW's secure template system for macro execution:

```lua
local button = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
button:SetAttribute("type", "macro")
button:SetAttribute("macrotext", "/y hell yeah brother")
```

**Important:** Secure templates have restrictions - cannot modify attributes in combat, must use secure handlers for combat-time behavior changes.

### Event Registration

Standard WoW event pattern:

```lua
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    -- Handle event
end)
```

### Frame Creation

All frames use the utility function with consistent naming:

```lua
_hyb.util.Frame("MyFrame", UIParent)  -- Creates "HYBAR_MyFrame"
```

### Positioning and Anchoring

Frames use WoW's anchor point system:

```lua
frame:SetPoint(point, UIParent, rel_point, x_offset, y_offset)
```

## Type Definitions

The addon includes LuaLS annotations in `definitions.lua` for IDE support. When adding new structures, update type definitions there.

## Common Patterns

### Adding a New Configuration Option

1. Add default value to `conf/conf.lua` → `_hyb.conf:OnDefault()`
2. Add checkbox to `conf/frame_conf.lua`
3. Add handler in `conf/conf.lua` → checkbox event handlers
4. Add localized string to `locales/hybar-enUS.lua`
5. Use the setting in relevant module (e.g., `bar/bar.lua`, `core/core.lua`)

### Adding a New Button to the Bar

1. Create button in `bar/bar.lua` using `CreateFrame("Button", ..., "SecureActionButtonTemplate")`
2. Set attributes: `type`, `macrotext`
3. Set texture from `locales/hybar-enUS.lua` icon paths
4. Position relative to existing buttons (32px + 2.2px spacing)
5. Add tooltip text to `locales/hybar-enUS.lua`

### Adding a New Slash Command

In `functions/slash.lua`, register with `SLASH_COMMANDNAME` pattern:

```lua
SLASH_MYCOMMAND1 = "/mycommand"
SlashCmdList["MYCOMMAND"] = function(msg)
    -- Handle command
end
```

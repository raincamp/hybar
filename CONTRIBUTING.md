# Contributing to hybar

Thank you for your interest in contributing to **hybar**! We welcome contributions from the community, whether it's reporting bugs, suggesting features, improving documentation, or submitting code changes.

This guide will help you get started with contributing to this World of Warcraft Classic Era addon project.

---

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

---

## How to Contribute

### Reporting Bugs

If you encounter a bug, please help us fix it by providing detailed information:

1. **Check existing issues** to see if the bug has already been reported
2. **Open a new issue** using the Bug Report template
3. **Include the following information:**
   - **WoW Version**: Classic Era version number (e.g., 1.15.1)
   - **Addon Version**: hybar version (found in `/hybar` config panel or .toc file)
   - **Other Addons**: List other addons you have installed (conflicts can occur)
   - **Steps to Reproduce**: Clear, numbered steps to recreate the bug
   - **Expected Behavior**: What should happen
   - **Actual Behavior**: What actually happens
   - **Error Messages**: Lua errors (enable with `/console scriptErrors 1` in-game)
   - **Screenshots**: Visual evidence if applicable

**Tip:** To capture Lua errors in WoW Classic Era, type `/console scriptErrors 1` in chat, then `/reload`. This will display error popups when they occur.

---

### Suggesting Features

We love hearing new ideas! Before suggesting a feature:

1. **Check existing issues** to see if it's already been suggested
2. **Consider WoW API limitations** - some features may not be possible due to Blizzard's addon API restrictions
3. **Open a new issue** using the Feature Request template
4. **Describe:**
   - The problem you're trying to solve
   - Your proposed solution
   - Alternative approaches you've considered
   - Any WoW API limitations that might affect implementation

---

### Contributing Code

We welcome pull requests! Here's how to contribute code changes:

#### 1. Development Setup

**Prerequisites:**
- World of Warcraft Classic Era installed
- A text editor or IDE (VS Code, IntelliJ IDEA, etc.)
- Git installed
- Basic knowledge of Lua programming

**Setup Steps:**

1. **Fork the repository** on GitHub
2. **Clone your fork** to your local machine:
   ```bash
   git clone https://github.com/YOUR_USERNAME/hybar.git
   ```
3. **Create a symbolic link** from your WoW addons folder to your local repository:
   - **Windows**: 
     ```cmd
     mklink /D "C:\Program Files (x86)\World of Warcraft\_classic_era_\Interface\AddOns\hybar" "C:\path\to\your\hybar"
     ```
   - **macOS/Linux**:
     ```bash
     ln -s /path/to/your/hybar "/Applications/World of Warcraft/_classic_era_/Interface/AddOns/hybar"
     ```

#### 2. Development Workflow

**Important:** This is a WoW addon project, not a Node.js/build-tool project. There are no npm scripts, build tools, or automated test runners.

**Making Changes:**

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```
2. **Edit `.lua` files** directly in your text editor
3. **Test in-game:**
   - Launch WoW Classic Era
   - Type `/reload` to reload the UI
   - Test your changes using `/hybar`, `/hellyeahbar`, or `/hyb`
4. **Iterate** - edit code, `/reload`, test, repeat

**No Build System:**
- WoW loads Lua files directly from the addon directory
- Changes take effect immediately after `/reload`
- No compilation or build step required

#### 3. Code Style Guidelines

**Lua Conventions:**
- **Indentation**: Use tabs (4-space equivalent)
- **Namespace**: All modules share the `_hyb` namespace table
- **Naming**: Use camelCase for functions, snake_case for variables
- **Comments**: Document complex logic and WoW API usage

**Namespace Pattern:**
```lua
local _, _hyb = ...

-- Add to existing namespace modules
_hyb.util.MyFunction = function()
    -- Your code
end
```

**Localization:**
- All UI strings must go in `locales/hybar-enUS.lua`
- Use namespace prefix `"HYBAR_"` for all string keys
- Never hardcode strings in code files

**Example:**
```lua
-- In locales/hybar-enUS.lua
_hyb.locales["HYBAR_MY_STRING"] = "Hello World"

-- In your code
local text = _hyb.locales["HYBAR_MY_STRING"]
```

#### 4. File Loading Order

**Critical:** Files must be loaded in dependency order, defined in `hybar.toc`.

**Current order:**
1. `locales/hybar-enUS.lua` - Localization (must load first)
2. `definitions.lua` - LuaLS type annotations
3. `util/util.lua` - Utility functions
4. `conf/conf.lua` - Configuration data management
5. `conf/frame_conf.lua` - Configuration UI frame
6. `bar/bar.lua` - Action bar creation
7. `core/core.lua` - Event handlers & initialization
8. `functions/slash.lua` - Slash command registration

**When adding new files:** Update `hybar.toc` with the correct loading position based on dependencies.

#### 5. Testing Procedures

**Manual Testing Checklist:**
- [ ] `/reload` loads the addon without errors
- [ ] Slash commands work: `/hybar`, `/hellyeahbar`, `/hyb`
- [ ] Configuration panel opens and displays correctly
- [ ] All checkboxes function properly
- [ ] Action bar buttons execute correct macros
- [ ] Dragging works when unlocked
- [ ] Position persists after `/reload`
- [ ] Settings persist after logout/login
- [ ] No Lua errors (enable with `/console scriptErrors 1`)

**Test Different Scenarios:**
- Fresh character (first load)
- Existing character (saved settings)
- Enable/disable the addon
- Lock/unlock position
- Different screen resolutions

#### 6. Pull Request Process

**Before Submitting:**
1. Test your changes thoroughly in-game
2. Update `CHANGELOG.md` if your changes are user-facing
3. Update version in `hybar.toc` if appropriate (discuss with maintainers)
4. Ensure all new UI strings are in `locales/hybar-enUS.lua`

**Submitting a PR:**

1. **Commit your changes** with clear, descriptive messages:
   ```bash
   git add .
   git commit -m "feat: add new feature description"
   ```
2. **Push to your fork:**
   ```bash
   git push origin feature/your-feature-name
   ```
3. **Open a Pull Request** on GitHub
4. **Fill out the PR template** with:
   - Description of changes
   - Related issue numbers
   - Testing checklist
   - WoW version tested
   - Screenshots/GIFs if UI changes

**Commit Message Format:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `perf:` - Performance improvements
- `test:` - Testing updates
- `chore:` - Maintenance tasks

**PR Review Process:**
- Maintainers will review your PR
- You may be asked to make changes
- Once approved, your PR will be merged
- Your contribution will be included in the next release

---

## First-Time Contributors

Welcome! We're excited to have you contribute to hybar.

**Good First Issues:**
- Look for issues labeled `good first issue`
- These are beginner-friendly tasks that don't require deep knowledge of the codebase
- Don't hesitate to ask questions in the issue comments

**Learning Resources:**
- [WoW API Documentation](https://warcraft.wiki.gg/wiki/World_of_Warcraft_API)
- [Lua 5.1 Reference Manual](https://www.lua.org/manual/5.1/)
- [Programming in Lua](https://www.lua.org/pil/contents.html)

**Tips:**
- Start small - fix a typo, improve documentation, or tackle a small bug
- Read existing code to understand patterns and conventions
- Test thoroughly in-game before submitting
- Ask questions if you're stuck - we're here to help!

---

## Questions?

If you have questions about contributing:

- **Open a GitHub Discussion** for general questions
- **Comment on an issue** if you need clarification
- **Email us** at hyb.devs@gmail.com

---

Thank you for contributing to hybar and supporting the WoW Classic Era community!

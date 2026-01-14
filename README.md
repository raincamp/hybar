# hybar

![Version](https://img.shields.io/badge/version-1.2.0--alpha-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![WoW](https://img.shields.io/badge/wow-TBC%20Classic%20Anniversary%202.5.5-orange)
![Interface](https://img.shields.io/badge/interface-20505-yellow)
[![CurseForge](https://img.shields.io/badge/CurseForge-980904-orange)](https://www.curseforge.com/wow/addons/hybar)
![Issues](https://img.shields.io/github/issues/raincamp/hybar)
![Pull Requests](https://img.shields.io/github/issues-pr/raincamp/hybar)
![Last Commit](https://img.shields.io/github/last-commit/raincamp/hybar)

**A dedicated 2-button action bar for "hell yeah brother" guild chat and yell communication in WoW Burning Crusade Classic Anniversary Edition.**

---

## Features

- **2-Button Action Bar**: Quick access to guild chat and yell macros
- **Draggable Interface**: Position the bar anywhere on your screen
- **Configurable Settings**: Enable/disable, lock position, toggle welcome message
- **Lightweight**: Minimal performance impact
- **TBC Classic Anniversary**: Built specifically for Burning Crusade Classic Anniversary Edition (Interface 20505)

---

## Installation

### Via CurseForge (Recommended)

1. Visit the [hybar CurseForge page](https://www.curseforge.com/wow/addons/hybar)
2. Download using the CurseForge client or manually download the latest version
3. The addon will be automatically installed to your WoW addons folder

### Manual Installation

1. Download the latest release from the [Releases page](https://github.com/raincamp/hybar/releases)
2. Extract the `hybar` folder to your WoW addons directory:
   - **Windows**: `C:\Program Files (x86)\World of Warcraft\_anniversary_\Interface\AddOns\`
   - **macOS**: `/Applications/World of Warcraft/_anniversary_/Interface/AddOns/`
3. Restart WoW or type `/reload` if already in-game

---

## Usage

### Slash Commands

Open the configuration panel with any of these commands:

- `/hellyeahbar`
- `/hybar`
- `/hyb`

### Action Bar Buttons

- **Button 1** (Rally Cry icon): Sends "hell yeah brother" to `/y` (yell chat)
- **Button 2** (Green Dragon icon): Sends "hell yeah brother" to `/g` (guild chat)

### Moving the Bar

1. Open the config panel with `/hybar`
2. Uncheck "Lock Position"
3. Drag the action bar to your desired location
4. Check "Lock Position" to prevent accidental movement

---

## Configuration

The configuration panel provides the following options:

- **Enable**: Show/hide the action bar
- **Lock Position**: Prevent the bar from being moved
- **Welcome Message**: Display a welcome message when logging in

All settings are saved per character and persist across sessions.

---

## Development

Interested in contributing? Check out our [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:

- Reporting bugs
- Suggesting features
- Submitting code changes
- Development setup and testing procedures
- Code style guidelines

### Project Structure

```
hybar/
├── locales/          # Localization strings
├── util/             # Utility functions
├── conf/             # Configuration logic and UI
├── bar/              # Action bar implementation
├── core/             # Event handlers and initialization
├── functions/        # Slash commands
└── hybar.toc         # Addon metadata and file loading order
```

---

## Support & Community

- **Issues**: [Report bugs or request features](https://github.com/raincamp/hybar/issues)
- **CurseForge**: [hybar on CurseForge](https://www.curseforge.com/wow/addons/hybar)
- **Email**: cam@raincamp.ai

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## Acknowledgments

- Built for the World of Warcraft TBC Classic Anniversary community
- Special thanks to all contributors and users who provide feedback
- Inspired by the need for quick "hell yeah brother" communication

---

**Made with ❤️ for the WoW TBC Classic Anniversary community**

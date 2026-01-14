# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.0-alpha] - 2026-01-14

### Added
- **Appearance Settings**
  - Transparency slider (0-100%)
  - Scale slider (50-200%)
  - High-contrast mode for enhanced visibility
- **Behavior Settings**
  - Sound feedback toggle for button clicks
- **Position Management**
  - Reset position button
  - Position preview display showing current anchor and coordinates
- **Visual Feedback**
  - Fade animations on bar show/hide
  - Unlock indicator with glowing golden border
  - Button hover and press effects
  - Visual confirmation flashes on control changes
  - Color-coded checkboxes (gold/white/gray priority)
- **Configuration Panel Improvements**
  - Enlarged panel (350x420px)
  - Section headers (Behavior, Appearance, Position)
  - Reorganized layout with logical groupings
  - Tooltips for all configuration controls
  - Keyboard navigation (Tab, Enter/Space, Arrow keys)
  - Focus indicator for keyboard navigation
- **Slash Commands**
  - `/hybar reset` - Reset all settings to defaults
  - `/hybar status` - Display current settings
  - `/hybar help` - Show available commands
  - Unknown command fallback shows help
- **Error Handling**
  - Combat lockdown protection with user feedback
  - Actionable error messages

### Changed
- Configuration panel resized from default to 350x420px
- Improved saved variable validation with type checking
- Enhanced slider behavior with drag tracking

### Technical
- Added animations module (`util/animations.lua`)
- Modular combat check helper in conf.lua
- Keyboard input handling with proper propagation

## [1.0.2-alpha] - 2024-03-13

### Added
- Initial public alpha release
- 2-button action bar for quick communication
  - Button 1: Rally Cry icon → `/y hell yeah brother` (yell)
  - Button 2: Green Dragon icon → `/g hell yeah brother` (guild chat)
- Configuration panel with settings:
  - Enable/disable bar visibility
  - Lock/unlock bar position
  - Welcome message toggle
- Draggable bar with position persistence
- Slash commands: `/hybar`, `/hellyeahbar`, `/hyb`
- Saved variables for persistent settings across sessions
- MIT License
- Project documentation (CLAUDE.md)

### Technical
- Namespace pattern for all modules (`_hyb.*`)
- Secure action button implementation
- Modular architecture (locales, util, conf, bar, core, functions)
- TOC file with proper load order dependencies

## [1.0.1-alpha] - 2024-03-05

### Added
- Initial development release
- Basic addon structure and framework

[Unreleased]: https://github.com/raincamp/hybar/compare/v1.1.0-alpha...HEAD
[1.1.0-alpha]: https://github.com/raincamp/hybar/compare/v1.0.2-alpha...v1.1.0-alpha
[1.0.2-alpha]: https://github.com/raincamp/hybar/compare/v1.0.1-alpha...v1.0.2-alpha
[1.0.1-alpha]: https://github.com/raincamp/hybar/releases/tag/v1.0.1-alpha

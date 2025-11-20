# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- EditorConfig file for consistent code formatting
- Git attributes file for consistent line endings
- Security policy (SECURITY.md) with vulnerability disclosure procedures
- Issue templates for bug reports and feature requests
- Pull request template with comprehensive contribution checklist
- Enhanced pkgmeta.yaml ignore list to exclude development files from releases

### Changed
- Improved .gitignore with additional Lua and editor temporary file patterns

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

[Unreleased]: https://github.com/hyb-devs/hybar/compare/v1.0.2-alpha...HEAD
[1.0.2-alpha]: https://github.com/hyb-devs/hybar/compare/v1.0.1-alpha...v1.0.2-alpha
[1.0.1-alpha]: https://github.com/hyb-devs/hybar/releases/tag/v1.0.1-alpha

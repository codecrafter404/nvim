# Changelog

All notable changes to this Neovim configuration will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- Comprehensive plugin version pinning for all plugins
- Documentation for updating plugins (`doc/updating.md`)
- Plugin versions reference guide (`doc/plugin-versions.md`)
- Lockfile tracking for consistent plugin versions across installations
- Performance optimizations in lazy.nvim configuration

### Changed
- Updated all plugins to latest stable versions (as of 2024-02)
- Removed `lazy-lock.json` from `.gitignore` to track plugin versions
- Updated README with link to plugin management documentation

### Updated Plugins
#### Core Plugins
- telescope.nvim → v0.1.8
- plenary.nvim → v0.1.4
- nvim-treesitter → v0.9.3

#### LSP & Completion
- nvim-lspconfig → v1.3.0
- mason.nvim → v1.10.0
- mason-lspconfig.nvim → v1.31.0
- mason-tool-installer.nvim → v1.1.0
- fidget.nvim → v1.4.5
- blink.cmp → v0.10.3
- LuaSnip → v2.3.0
- crates.nvim → v0.5.3

#### UI Plugins
- which-key.nvim → v3.14.0
- mini.nvim → v0.14.0
- tokyonight.nvim → v4.10.0 (was: commit b0e7c73)
- neo-tree.nvim → v3.27
- nui.nvim → v0.3.0
- indent-blankline.nvim → v3.8.8

#### Development Tools
- conform.nvim → v8.3.0
- nvim-lint → v0.4.0
- gitsigns.nvim → v0.9.0
- Comment.nvim → v0.8.0
- nvim-autopairs → v0.6.0
- nvim-ts-autotag → v0.11.0

#### Utilities
- todo-comments.nvim → v1.3.2

### Technical Details
- All plugins now use either semantic version tags or specific commit hashes
- lazy.nvim configured to use `lazy-lock.json` for version locking
- Added performance optimizations with `reset_packpath` and `rtp.reset`

## Previous Versions

### Before Version Pinning
- Plugins were using latest versions without explicit pinning
- No version tracking or lockfile
- Potential for breaking changes on updates

---

## How to Use This Changelog

- **Added**: New features or files
- **Changed**: Changes to existing functionality
- **Updated**: Version updates for dependencies/plugins
- **Deprecated**: Features that will be removed in future versions
- **Removed**: Features that have been removed
- **Fixed**: Bug fixes
- **Security**: Security vulnerability fixes

# Updating Neovim Plugins

This document explains how to manage and update the plugins in this Neovim configuration.

## Overview

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. All plugins are pinned to specific versions (tags or commits) to ensure stability and prevent unexpected breakages.

## Plugin Version Tracking

### Lockfile

The `lazy-lock.json` file in the root of the configuration directory contains the exact commit hashes of all installed plugins. This file is tracked in version control to ensure consistent installations across different machines.

**Important**: Do not manually edit `lazy-lock.json`. It is automatically managed by lazy.nvim.

### Version Pinning in Plugin Specifications

Each plugin in the `lua/custom/plugins/` and `lua/kickstart/plugins/` directories is pinned using one of these methods:

- **tag**: Points to a specific release tag (e.g., `tag = 'v1.0.0'`)
- **commit**: Points to a specific commit hash (e.g., `commit = 'abc123d'`)
- **version**: Uses semantic versioning patterns (e.g., `version = '*'` for latest, `version = '~1.0'` for 1.x versions)

## Checking for Updates

### Using lazy.nvim UI

1. Open Neovim
2. Run `:Lazy`
3. Press `C` to check for updates
4. The UI will show which plugins have updates available

### Manual Check

You can check individual plugin repositories for new releases:

```bash
# Example: Check telescope.nvim releases
# Visit: https://github.com/nvim-telescope/telescope.nvim/releases
```

## Updating Plugins

### Step 1: Review Available Updates

Before updating, always:

1. Check the changelog/release notes of the plugin
2. Look for breaking changes
3. Verify compatibility with your Neovim version (>= 0.10.0 recommended)

### Step 2: Update Plugin Specification

Navigate to the plugin file and update the version pin:

```lua
-- Before
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  -- ...
}

-- After (updating to 0.1.9)
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.9',
  -- ...
}
```

### Step 3: Install the Update

1. Save the file
2. Open Neovim
3. Run `:Lazy sync` to update all plugins
   - Or `:Lazy update <plugin-name>` for a specific plugin
4. Restart Neovim

### Step 4: Update the Lockfile

After updating plugins:

1. The `lazy-lock.json` file will be automatically updated
2. Commit this file to version control:
   ```bash
   git add lazy-lock.json
   git commit -m "Update plugins: <list of updated plugins>"
   ```

### Step 5: Test the Configuration

After updating:

1. Test basic functionality (file opening, searching, etc.)
2. Run `:checkhealth` to identify any issues
3. Test language-specific features if you updated LSP or treesitter
4. Check for any error messages during startup

## Updating Multiple Plugins

When updating multiple plugins:

```bash
# 1. Update plugin specifications in the Lua files
# 2. Open Neovim and sync all
:Lazy sync

# 3. Review any errors
:Lazy log

# 4. Commit changes
git add lua/custom/plugins/ lua/kickstart/plugins/ lazy-lock.json
git commit -m "Update multiple plugins: telescope, treesitter, lsp"
```

## Troubleshooting Updates

### Plugin Fails to Load

1. Check `:Lazy` for error messages
2. Run `:Lazy log` to see detailed logs
3. Verify the tag/commit exists in the plugin repository
4. Rollback to the previous version if needed

### Breaking Changes

If an update introduces breaking changes:

1. Read the plugin's migration guide
2. Update your configuration accordingly
3. Common areas affected:
   - Configuration options (renamed or removed)
   - API changes (function signatures)
   - Dependencies (may need updates)

### Rollback a Plugin

To rollback to a previous version:

1. Change the tag/commit in the plugin specification
2. Run `:Lazy sync`
3. Optionally restore `lazy-lock.json` from git history:
   ```bash
   git checkout HEAD~1 lazy-lock.json
   ```

## Best Practices

### Before Major Updates

1. **Backup your configuration**:
   ```bash
   cp -r ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Create a git branch**:
   ```bash
   git checkout -b plugin-updates-$(date +%Y%m%d)
   ```

3. **Update incrementally**: Update a few plugins at a time instead of all at once

### Regular Maintenance

- Review updates **monthly** or **quarterly**
- Keep Neovim itself updated to the latest stable version
- Subscribe to release notifications for critical plugins

### Testing New Versions

For major updates, consider:

1. Creating a test branch
2. Using `NVIM_APPNAME` to test in isolation:
   ```bash
   NVIM_APPNAME=nvim-test nvim
   ```

## Common Plugins Update Schedule

- **LSP/Mason**: Update every 1-2 months (frequent improvements)
- **Treesitter**: Update every 1-2 months (new language support)
- **Telescope**: Update every 2-3 months (stable, fewer breaking changes)
- **UI Plugins**: Update as needed when new features are desired
- **Colorschemes**: Update rarely unless bugs are fixed

## Getting Help

If you encounter issues:

1. Check `:checkhealth`
2. Review `:Lazy log` for detailed error messages
3. Check the plugin's GitHub issues
4. Consult the plugin's documentation
5. Roll back to the last working version

## Plugin List

Current plugins in this configuration:

### Core Functionality
- **lazy.nvim**: Plugin manager
- **telescope.nvim**: Fuzzy finder
- **nvim-treesitter**: Syntax highlighting
- **nvim-lspconfig**: LSP configuration
- **mason.nvim**: LSP/tool installer

### Completion & Snippets
- **nvim-cmp**: Completion engine
- **LuaSnip**: Snippet engine
- **blink.cmp**: Modern completion (alternative)

### UI Enhancements
- **which-key.nvim**: Keybinding hints
- **mini.nvim**: Multiple mini modules
- **tokyonight.nvim**: Colorscheme
- **neo-tree.nvim**: File explorer
- **indent-blankline.nvim**: Indentation guides

### Development Tools
- **conform.nvim**: Formatting
- **nvim-lint**: Linting
- **gitsigns.nvim**: Git integration
- **Comment.nvim**: Commenting
- **nvim-autopairs**: Auto-closing pairs

### Language-Specific
- **crates.nvim**: Rust crate management
- **nvim-cmp-lsp-rs**: Rust completion enhancements
- **nvim-ts-autotag**: HTML/XML auto-closing tags

### Utilities
- **vim-sleuth**: Auto-detect indentation
- **todo-comments.nvim**: Highlight TODOs
- **clipboard-image.nvim**: Paste images

## Version History

Track major plugin updates in your commit messages:

```bash
# Good commit message examples:
git commit -m "Update telescope.nvim to v0.1.9 - Adds new picker features"
git commit -m "Update mason.nvim to v1.10.0 - Improves LSP installation"
git commit -m "Pin all plugins to stable versions for consistency"
```

---

**Last Updated**: 2024-02-02
**Neovim Version**: >= 0.10.0
**Plugin Manager**: lazy.nvim (stable branch)

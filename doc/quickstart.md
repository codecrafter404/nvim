# Quick Start Guide

This guide will help you get started with this Neovim configuration after installation.

## First Time Setup

### 1. Install Dependencies

Ensure you have the following installed:
- Neovim >= 0.10.0
- Git
- A C compiler (gcc/clang)
- `make`
- `ripgrep` (for telescope grep)
- A Nerd Font (optional, but recommended)

### 2. Clone the Configuration

```bash
# Backup existing config if you have one
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repository
git clone https://github.com/codecrafter404/nvim.git ~/.config/nvim
```

### 3. First Launch

```bash
nvim
```

On the first launch:
1. Lazy.nvim will automatically bootstrap itself
2. All plugins will be installed automatically
3. Wait for the installation to complete (you'll see a progress window)
4. Once complete, press `q` to close the Lazy window
5. Restart Neovim

### 4. Generate Lockfile

The first time you run Neovim with this configuration:
1. All plugins will be installed at the pinned versions
2. A `lazy-lock.json` file will be automatically generated
3. This lockfile ensures consistent plugin versions

### 5. Verify Installation

Run health checks to ensure everything is working:
```vim
:checkhealth
```

Check plugin status:
```vim
:Lazy
```

## Key Bindings

The leader key is `<Space>`.

### Essential Keybindings

#### File Navigation
- `<Space>sf` - Search files
- `<Space>sg` - Live grep (search in files)
- `<Space>sr` - Resume last search
- `<Space><Space>` - Find buffers
- `\\` - Toggle file tree (Neo-tree)

#### LSP (Language Server)
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Show hover documentation
- `<Space>ca` - Code actions
- `<Space>rn` - Rename symbol
- `[d` / `]d` - Previous/next diagnostic

#### Code Editing
- `<Space>f` - Format buffer
- `gcc` - Toggle line comment
- `gc` (visual mode) - Toggle comment for selection

#### Window Management
- `<C-h/j/k/l>` - Navigate between windows (if uncommented in init.lua)

#### Search
- `<Space>sh` - Search help
- `<Space>sk` - Search keymaps
- `<Space>sd` - Search diagnostics
- `<Esc>` - Clear search highlight

## Plugin Management

### Check for Updates
```vim
:Lazy
" Press 'C' to check for updates
```

### Update Plugins
```vim
:Lazy sync
```

### View Plugin Details
```vim
:Lazy
" Use 'Enter' on a plugin to see details
" Use 'l' to view plugin logs
```

For more details on updating plugins, see [doc/updating.md](updating.md).

## Language Server Setup

### Installing Language Servers

This configuration uses Mason to manage language servers:

```vim
:Mason
```

Common language servers:
- **Lua**: `lua_ls` (auto-installed)
- **Rust**: `rust_analyzer`
- **JavaScript/TypeScript**: `ts_ls`
- **Python**: `pyright`
- **Go**: `gopls`

Language servers configured in `lua/custom/plugins/nvim-lspconfig.lua` will be automatically installed.

### Adding a New Language Server

1. Open `:Mason`
2. Search for your language server (press `/`)
3. Install it (press `i`)
4. Add configuration in `lua/custom/plugins/nvim-lspconfig.lua`:

```lua
servers = {
  -- ... existing servers ...
  your_server = {
    -- server-specific settings
  },
}
```

## Treesitter Setup

Treesitter provides syntax highlighting and code understanding.

### Install Language Parsers

```vim
:TSInstall <language>
" Example: :TSInstall python
```

### Check Installed Parsers

```vim
:TSInstallInfo
```

Languages configured in `ensure_installed` (in `nvim-treesitter.lua`) are installed automatically.

## Customization

### Adding Your Own Plugins

Create a new file in `lua/custom/plugins/`:

```lua
-- lua/custom/plugins/my-plugin.lua
return {
  'author/plugin-name',
  tag = 'v1.0.0',  -- Always pin the version!
  config = function()
    require('plugin-name').setup{}
  end,
}
```

### Modifying Keybindings

Edit `init.lua` or create a new file in `lua/custom/`:

```lua
vim.keymap.set('n', '<leader>mp', '<cmd>MyCommand<CR>', { desc = '[M]y [P]lugin' })
```

### Changing Colorscheme

The current colorscheme is Tokyo Night. To change:

1. Edit `lua/custom/plugins/tokyonight.lua`
2. Replace with your preferred colorscheme plugin
3. Run `:Lazy sync`

## Troubleshooting

### Plugins Won't Install
```vim
:Lazy restore
:Lazy sync
```

### LSP Not Working
```vim
:LspInfo
:Mason
:checkhealth lsp
```

### Treesitter Issues
```vim
:TSUpdate
:checkhealth nvim-treesitter
```

### General Issues
```vim
:checkhealth
:Lazy log  " View plugin logs
```

### Reset Everything

If things break completely:
```bash
# Backup your config
cp -r ~/.config/nvim ~/.config/nvim.broken

# Remove plugin data
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Restart Neovim
nvim
```

## Learning Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- Run `:Tutor` in Neovim for a basic tutorial
- Run `:help` to explore Neovim's built-in help

## Next Steps

1. ✅ Install the configuration
2. ✅ Learn the basic keybindings
3. 📝 Customize the configuration to your needs
4. 🎨 Try different colorschemes
5. 🔧 Install language servers for your languages
6. 📚 Read [doc/updating.md](updating.md) to learn about plugin management
7. 🚀 Start coding!

## Getting Help

- Check `:checkhealth` for diagnostic information
- Review plugin documentation with `:help <plugin-name>`
- Check GitHub issues for known problems
- Read [doc/updating.md](updating.md) for plugin-specific help

---

**Enjoy your Neovim experience! 🚀**

# nixvim-final

A standalone [NixVim](https://github.com/nix-community/nixvim) configuration — Neovim fully configured and reproducible via Nix, no plugin managers or runtime installations needed.

---

## Prerequisites

- **Nix** with flakes enabled. If you don't have Nix yet, install it via the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer) (recommended — handles flakes out of the box):
  ```bash
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```
  If you already have Nix but not flakes, add the following to `/etc/nix/nix.conf`:
  ```
  experimental-features = nix-command flakes
  ```

---

## Installation

### 1. Uninstall Homebrew Neovim (if present)

Having a Homebrew `nvim` on your `PATH` will shadow the Nix-managed one. Remove it first:

```bash
brew uninstall neovim
```

Verify no leftover shim exists:

```bash
which nvim   # should print nothing, or only a nix-profile path after step 2
```

### 2. Install into your Nix profile

From inside the repo directory, run:

```bash
nix profile install .
```

This builds the configuration and adds `nvim` to `~/.nix-profile/bin`, which is on your `PATH` by default.

Verify:

```bash
nvim --version
```

### 3. A Nerd Font is required

The configuration uses Nerd Font icons throughout (status line, diagnostics, devicons). Install one and set it as your terminal font — [JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads) is a solid choice.

---

## Updating

### Update all flake inputs (nixpkgs, nixvim, …)

```bash
nix flake update
```

### Apply the updated configuration to your profile

```bash
nix profile upgrade '.*'
```

Or, if you know the exact profile index (check with `nix profile list`):

```bash
nix profile upgrade 0
```

### Rebuild without updating inputs

If you only changed `config.nix` and want to re-install without bumping any dependencies:

```bash
nix profile remove nvim   # remove by name, or use the index from `nix profile list`
nix profile install .
```

---

## Project Structure

```
nixvim-final/
├── flake.nix          # Flake entry point — defines inputs and exposes the nvim package
├── flake.lock         # Locked input revisions (commit this for reproducibility)
├── config.nix         # All Neovim configuration lives here
└── snippets/
    ├── dart.snippets       # Snipmate-format snippets for Dart
    └── markdown.snippets   # Snipmate-format snippets for Markdown
```

All configuration is in **`config.nix`**. The file is organised into clearly labelled sections:

| Section | What it controls |
|---|---|
| `extraFiles` | Snippet files copied into the Neovim config directory |
| `globals` / `opts` | Leader key, editor options (line numbers, clipboard, …) |
| `diagnostic` | Diagnostic display (virtual text, signs, float border) |
| `keymaps` | All custom key bindings |
| `autoGroups` / `autoCmd` | Autocommands (yank highlight, LSP ref highlight) |
| `colorschemes` | Theme (Tokyo Night – night style) |
| `plugins` | Every plugin: LSP, completion, Telescope, Treesitter, UI, … |
| `extraPlugins` | Plugins not yet in nixvim's module set (built via `buildVimPlugin`) |
| `extraConfigLua` | Raw Lua that runs after plugin setup |

---

## Adding a New LSP

NixVim manages LSP servers declaratively. All servers live inside the `plugins.lsp.servers` block in `config.nix`.

### Step 1 — check if nixvim supports the server

Browse the [nixvim LSP options](https://nix-community.github.io/nixvim/plugins/lsp/servers/) or search the nixvim source for the server name. Most servers from `nvim-lspconfig` are available.

### Step 2 — enable it in `config.nix`

```nix
plugins.lsp.servers = {
  # existing servers …
  lua_ls.enable = true;

  # add your new server here, e.g. PHP:
  phpactor.enable = true;

  # or with extra settings:
  tinymist = {
    enable = true;
    settings.exportPdf = "onSave";
  };
};
```

Several servers are already present but commented out near the bottom of the `servers` block (`phpactor`, `graphql`, `tinymist`, `lemminx`) — uncomment them to activate.

### Step 3 — rebuild

```bash
nix profile remove nvim
nix profile install .
```

The server binary is fetched and pinned by Nix — no separate `mason` or `npm install` needed.

---

## Adding a New Plugin

### Plugins available in the nixvim module set

Most popular plugins have first-class NixVim modules. Add them inside the `plugins` block:

```nix
plugins = {
  # existing plugins …
  neogit.enable = true;
};
```

Check available modules at [nix-community.github.io/nixvim](https://nix-community.github.io/nixvim/).

### Plugins not in the nixvim module set

Use `extraPlugins` with `buildVimPlugin`:

```nix
extraPlugins = [
  (pkgs.vimUtils.buildVimPlugin {
    name = "my-plugin";
    src = pkgs.fetchFromGitHub {
      owner  = "author";
      repo   = "repo-name";
      rev    = "main";          # or a specific commit / tag
      hash   = pkgs.lib.fakeHash;  # replace after the first failed build
    };
  })
];
```

On the first `nix build` attempt the hash will be wrong — Nix will print the correct `got:` hash in the error output. Paste it in, then rebuild.

Any Lua setup for the plugin goes in `extraConfigLua`:

```nix
extraConfigLua = ''
  require("my-plugin").setup({})
'';
```

---

## Adding Snippets

Snippets use **snipmate format** and are loaded by LuaSnip.

1. Create a file at `snippets/<filetype>.snippets` (e.g. `snippets/go.snippets`).
2. Register it in the `extraFiles` block at the top of `config.nix`:
   ```nix
   extraFiles = {
     "snippets/dart.snippets".source     = ./snippets/dart.snippets;
     "snippets/markdown.snippets".source = ./snippets/markdown.snippets;
     "snippets/go.snippets".source       = ./snippets/go.snippets;  # ← add this
   };
   ```
3. Rebuild (`nix profile remove nvim && nix profile install .`).

Snippet syntax reference: [honza/vim-snippets](https://github.com/honza/vim-snippets) (snipmate format).

---

## Key Bindings Reference

`<leader>` is **Space**.

### Navigation & Search (Telescope)

| Key | Action |
|---|---|
| `<leader><leader>` | Open buffers |
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>s/` | Grep in open files |
| `<leader>sh` | Help tags |
| `<leader>sk` | Keymaps |
| `<leader>sd` | Diagnostics |
| `<leader>sr` | Resume last picker |
| `<leader>s.` | Recent files |
| `<leader>sn` | Search Neovim config files |
| `<leader>/` | Fuzzy search in current buffer |

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |

### Diagnostics

| Key | Action |
|---|---|
| `<leader>e` | Show diagnostic float |
| `<leader>q` | Send diagnostics to quickfix |

### Editing

| Key | Action |
|---|---|
| `<leader>f` | Format buffer (conform / LSP fallback) |
| `<leader>ii` | Paste image from clipboard |
| `<leader>if` | Insert link to most recent PDF in `Attachements/PDF/` |
| `<leader>id` | Insert date link |

### SOPS (secret files)

| Key | Action |
|---|---|
| `<leader>td` | Decrypt current file in place |
| `<leader>te` | Encrypt current file in place |

---

## Troubleshooting

**`nvim` not found after install**
Make sure `~/.nix-profile/bin` is on your `PATH`. Add to your shell rc:
```bash
export PATH="$HOME/.nix-profile/bin:$PATH"
```

**Icons look like boxes / question marks**
A Nerd Font is not set in your terminal. Install one and configure your terminal emulator to use it.

**Hash mismatch when adding an `extraPlugin`**
Run `nix build` once — Nix will print the correct hash in the error. Copy the `got:` value into the `hash` field.

**Slow first start after rebuild**
Treesitter has `auto_install = true`, so parsers for open filetypes are compiled on first use. This is a one-time cost per language.

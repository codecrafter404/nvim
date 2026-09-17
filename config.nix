{ pkgs, ... }:
{
  # ── Snippets (snipmate format, loaded via LuaSnip) ──
  extraFiles = {
    "snippets/dart.snippets".source = ./snippets/dart.snippets;
    "snippets/markdown.snippets".source = ./snippets/markdown.snippets;
  };

  # ───────────────────────────── Options ─────────────────────────────
  globals = {
    mapleader = " ";
    maplocalleader = " ";
    have_nerd_font = true;
  };

  opts = {
    number = true;
    mouse = "a";
    showmode = false;
    clipboard = "unnamedplus";
    breakindent = true;
    undofile = true;
    ignorecase = true;
    smartcase = true;
    signcolumn = "yes";
    updatetime = 250;
    timeoutlen = 300;
    splitright = true;
    splitbelow = true;
    inccommand = "split";
    cursorline = true;
    scrolloff = 10;
    hlsearch = true;
  };

  # ───────────────────────────── Diagnostics ─────────────────────────
  diagnostic = {
    settings = {
      severity_sort = true;
      float = {
        border = "rounded";
        source = "if_many";
      };
      underline.severity = "ERROR";
      virtual_text = {
        source = "if_many";
        spacing = 2;
      };
      signs.text = {
        "ERROR" = "󰅚 ";
        "WARN" = "󰀪 ";
        "INFO" = "󰋽 ";
        "HINT" = "󰌶 ";
      };
    };
  };

  # ───────────────────────────── Keymaps ─────────────────────────────
  keymaps = [
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Exit terminal mode";
    }

    # Diagnostics
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "vim.diagnostic.open_float";
      options.desc = "Show diagnostic [E]rrors";
    }
    {
      mode = "n";
      key = "<leader>q";
      action.__raw = "vim.diagnostic.setloclist";
      options.desc = "Diagnostic [Q]uickfix";
    }

    # SOPS
    {
      mode = "n";
      key = "<leader>td";
      action = "<cmd>! sops -d -i %:p<CR>";
      options.desc = "SOPS [D]ecrypt";
    }
    {
      mode = "n";
      key = "<leader>te";
      action = "<cmd>! sops -e -i %:p<CR>";
      options.desc = "SOPS [E]ncrypt";
    }

    # Insert helpers
    {
      mode = "n";
      key = "<leader>if";
      action.__raw = ''
        function()
          local base = vim.fs.joinpath(vim.env.PWD, "/Attachements/PDF")
          local ok, files = pcall(vim.fs.dir, base)
          if not ok then print("No Attachements/PDF directory"); return end

          local biggest, biggest_name = 0, ""
          for name, _ in files do
            local stat = vim.loop.fs_stat(vim.fs.joinpath(base, name))
            if stat and stat.mtime.sec > biggest then
              biggest = stat.mtime.sec
              biggest_name = name
            end
          end
          if biggest == 0 then print("No file to insert found"); return end

          local file = vim.fs.joinpath(base, biggest_name)
          file = file:sub(vim.env.PWD:len() + 1)
          InsertUnderCursor("[" .. biggest_name .. "](" .. file:gsub(" ", "%%20") .. ")")
        end
      '';
      options.desc = "Link last modified PDF";
    }
    {
      mode = "n";
      key = "<leader>id";
      action.__raw = ''
        function()
          InsertUnderCursor("[" .. vim.fn.strftime("%d/%m/%y %H:%M") .. "]()")
        end
      '';
      options.desc = "Insert date link";
    }

    # Clipboard image paste
    {
      mode = "n";
      key = "<leader>ii";
      action = "<cmd>PasteImg<CR>";
      options.desc = "[I]nsert [I]mage from clipboard";
    }

    # Conform format
    {
      mode = "";
      key = "<leader>f";
      action.__raw = ''function() require("conform").format({ async = true, lsp_fallback = true }) end'';
      options.desc = "[F]ormat buffer";
    }

    # Disable arrows
    {
      mode = "n";
      key = "<left>";
      action = "<cmd>echo 'Use h'<CR>";
    }
    {
      mode = "n";
      key = "<right>";
      action = "<cmd>echo 'Use l'<CR>";
    }
    {
      mode = "n";
      key = "<up>";
      action = "<cmd>echo 'Use k'<CR>";
    }
    {
      mode = "n";
      key = "<down>";
      action = "<cmd>echo 'Use j'<CR>";
    }

    # Telescope extras (fuzzy search in buffer, grep open files, search nvim config)
    {
      mode = "n";
      key = "<leader>/";
      action.__raw = ''
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(
            require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
          )
        end
      '';
      options.desc = "Fuzzy search in buffer";
    }
    {
      mode = "n";
      key = "<leader>s/";
      action.__raw = ''
        function()
          require("telescope.builtin").live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
        end
      '';
      options.desc = "Grep in open files";
    }
    {
      mode = "n";
      key = "<leader>sn";
      action.__raw = ''
        function()
          require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
        end
      '';
      options.desc = "Search Neovim files";
    }
  ];

  # ───────────────────────────── Autocommands ────────────────────────
  autoGroups = {
    "yank-highlight" = {
      clear = true;
    };
    "kickstart-lsp-highlight" = {
      clear = false;
    };
  };

  autoCmd = [
    {
      event = [ "TextYankPost" ];
      group = "yank-highlight";
      callback.__raw = "function() vim.highlight.on_yank() end";
    }
  ];

  # ───────────────────────────── Colorscheme ─────────────────────────
  colorschemes.tokyonight = {
    enable = true;
    settings.style = "night";
  };

  # ───────────────────────────── Plugins ─────────────────────────────
  plugins = {

    # ── Completion (blink-cmp + luasnip for snippets) ──
    blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "default";
        appearance.nerd_font_variant = "mono";
        sources.default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
        signature.enabled = true;
        snippets.preset = "luasnip";
      };
    };

    luasnip = {
      enable = true;
      fromSnipmate = [ { } ];
    };

    # ── LSP ──
    lsp = {
      enable = true;
      inlayHints = true;

      servers = {
        lua_ls = {
          enable = true;
          settings.Lua = {
            completion.callSnippet = "Replace";
            diagnostics.globals = [ "vim" ];
          };
        };
        ts_ls.enable = true;
        nil_ls.enable = true;
        svelte.enable = true;
        cssls.enable = true;
        tailwindcss.enable = true;
        jsonls.enable = true;
        gopls.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        marksman.enable = true;

        # ── Uncomment as needed ──
        yamlls.enable = true;
        # phpactor.enable  = true;
        # graphql.enable   = true;
        # tinymist.enable  = true;
        # lemminx.enable   = true;
      };

      keymaps = {
        lspBuf = {
          "gd" = {
            action = "definition";
            desc = "Goto Definition";
          };
          "gr" = {
            action = "references";
            desc = "Goto References";
          };
          "gI" = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          "gD" = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          "K" = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>rn" = {
            action = "rename";
            desc = "Rename";
          };
          "<leader>ca" = {
            action = "code_action";
            desc = "Code Action";
          };
        };
        extra = [
          {
            mode = "n";
            key = "<leader>ds";
            action.__raw = "require('telescope.builtin').lsp_document_symbols";
            options.desc = "Document Symbols";
          }
          {
            mode = "n";
            key = "<leader>ws";
            action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
            options.desc = "Workspace Symbols";
          }
          {
            mode = "n";
            key = "<leader>D";
            action.__raw = "require('telescope.builtin').lsp_type_definitions";
            options.desc = "Type Definition";
          }
          {
            mode = "n";
            key = "<leader>th";
            action.__raw = "function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end";
            options.desc = "Toggle Inlay Hints";
          }
        ];
      };
    };

    fidget.enable = true;
    lazydev.enable = true;

    # ── Telescope ──
    telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };
      keymaps = {
        "<leader>sf" = {
          action = "find_files";
          options.desc = "Find Files";
        };
        "<leader>sg" = {
          action = "live_grep";
          options.desc = "Grep";
        };
        "<leader>sh" = {
          action = "help_tags";
          options.desc = "Help";
        };
        "<leader>sk" = {
          action = "keymaps";
          options.desc = "Keymaps";
        };
        "<leader>sd" = {
          action = "diagnostics";
          options.desc = "Diagnostics";
        };
        "<leader>sr" = {
          action = "resume";
          options.desc = "Resume";
        };
        "<leader>s." = {
          action = "oldfiles";
          options.desc = "Recent Files";
        };
        "<leader>ss" = {
          action = "builtin";
          options.desc = "Telescope Builtins";
        };
        "<leader>sw" = {
          action = "grep_string";
          options.desc = "Grep Word";
        };
        "<leader><leader>" = {
          action = "buffers";
          options.desc = "Buffers";
        };
      };
    };

    # ── Treesitter ──
    treesitter = {
      enable = true;
      settings = {
        auto_install = true;
        highlight.enable = true;
        indent.enable = true;
      };
    };
    ts-autotag.enable = true;

    # ── Formatting ──
    conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = false;
        format_on_save = {
          __raw = ''
            function(bufnr)
              local ignore = { c = true, cpp = true }
              return { timeout_ms = 500, lsp_fallback = not ignore[vim.bo[bufnr].filetype] }
            end
          '';
        };
        formatters_by_ft = {
          lua = [ "stylua" ];
          rust = [ "rustfmt" ];
        };
      };
    };

    # ── UI ──
    which-key.enable = true;
    gitsigns.enable = true;
    indent-blankline.enable = true;
    todo-comments = {
      enable = true;
      settings.signs = false;
    };
    web-devicons.enable = true;

    mini = {
      enable = true;
      modules = {
        ai = {
          n_lines = 500;
        };
        surround = { };
        statusline = {
          use_icons = true;
        };
      };
    };

    nvim-autopairs.enable = true;
  };

  # ── Extra plugins not in nixvim's module set ──
  extraPlugins = [
    # clipboard-image.nvim for <leader>ii paste
    (pkgs.vimUtils.buildVimPlugin {
      name = "clipboard-image-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "codecrafter404";
        repo = "clipboard-image.nvim";
        rev = "main";
        # First build: run `nix build 2>&1 | grep 'got:'` and paste the hash here
        hash = "sha256-4grne/LEBHoJNHtM3xb+mtu5Abr6Lj1nft0ccowZASU=";
      };
    })
  ];

  # ── Extra Lua (InsertUnderCursor helper, clipboard-image, LSP highlight refs) ──
  extraConfigLuaPre = ''
    function InsertUnderCursor(text)
      local pos = vim.api.nvim_win_get_cursor(0)
      local line = vim.fn.getline(pos[1])
      line = line:sub(1, pos[2] + 1) .. text .. line:sub(pos[2] + 1)
      vim.fn.setline(pos[1], line)
    end
  '';

  extraConfigLua = ''
    -- clipboard-image
    local ok, ci = pcall(require, "clipboard-image")
    if ok then ci.setup({}) end

    -- mini.statusline cursor format
    require("mini.statusline").section_location = function() return "%2l:%-2v" end

    -- LSP: highlight references under cursor + clear on move
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-highlight-refs", { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client or not client.server_capabilities.documentHighlightProvider then return end

        local hl = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf, group = hl, callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf, group = hl, callback = vim.lsp.buf.clear_references,
        })
        vim.api.nvim_create_autocmd("LspDetach", {
          group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
          callback = function(e) vim.lsp.buf.clear_references(); vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = e.buf }) end,
        })
      end,
    })
  '';
}

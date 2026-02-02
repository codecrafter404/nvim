vim.opt.exrc = true

function InsertUnderCursor(text)
  local pos = vim.api.nvim_win_get_cursor(0)

  local line = vim.fn.getline(pos[1])
  line = line:sub(1, pos[2] + 1) .. text .. line:sub(pos[2] + 1)
  vim.fn.setline(pos[1], line)
end

vim.cmd 'language en_US'

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set the node neovim cli path or else the healthcheck crashes (is frozen)
-- if vim.fn.has 'win32' == 1 then
--   vim.g.node_host_prog = 'C:\\Program Files\\nodejs\\node_modules\\neovim\\bin\\cli.js'
-- end

-- disable the pearl provider
vim.g.loaded_perl_provider = 0

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Default terminal
if vim.fn.has 'win64' == 1 then
  vim.opt.shell = 'pwsh'
  vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
  vim.opt.shellxquote = ''
end

-- all line  end character
vim.opt.fileformats = 'unix,dos,mac'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>td', '<cmd>! sops -d -i %:p<CR>', { desc = '[T]oggle [D]ecrypted sops file (current buffer)' })
vim.keymap.set('n', '<leader>te', '<cmd>! sops -e -i %:p<CR>', { desc = '[T]oggle [E]ecrypted sops file (current buffer)' })

-- Insert
vim.keymap.set('n', '<leader>if', function()
  local base = vim.fs.joinpath(vim.env.PWD, '/Attachements/PDF')
  local files = vim.fs.dir(base)

  local biggest = 0
  local biggest_name = ''

  for name, _ in files do
    local last_mod = vim.loop.fs_stat(vim.fs.joinpath(base, name)).mtime.sec
    if last_mod > biggest then
      biggest = last_mod
      biggest_name = name
    end
  end

  if biggest == 0 then
    print 'No file to insert found'
    return
  end

  local file = vim.fs.joinpath(base, biggest_name)
  file = file:sub(vim.env.PWD:len() + 1, file:len())
  local nec = file:gsub(' ', '%%20')

  InsertUnderCursor('[' .. biggest_name .. '](' .. nec .. ')')
end, { desc = 'Link the last modified file' })
vim.keymap.set('n', '<leader>id', function()
  InsertUnderCursor('[' .. vim.fn.strftime '%d/%m/%y %H:%M' .. ']()')
end, { desc = 'Insert a date Link' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- removes the comment line automatic comment line breaking
vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Remove the comment line breaking after n columns',
  callback = function()
    vim.opt.formatoptions:remove 'c'
  end,
})

require 'config.lazy'

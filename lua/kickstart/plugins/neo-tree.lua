-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  tag = 'v3.27',
  dependencies = {
    { 'nvim-lua/plenary.nvim', tag = 'v0.1.4' },
    { 'nvim-tree/nvim-web-devicons', tag = 'v0.100' }, -- not strictly required, but recommended
    { 'MunifTanjim/nui.nvim', tag = '0.3.0' },
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}

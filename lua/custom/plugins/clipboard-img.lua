return {
  'codecrafter404/clipboard-image.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'markdown' },
  config = function()
    require('clipboard-image').setup {}
    vim.keymap.set('n', '<leader>ii', '<cmd>:PasteImg<CR>', { desc = '[I]nsert [I]mage from clipboard' })
  end,
}

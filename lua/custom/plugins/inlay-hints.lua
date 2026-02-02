return {
  'MysticalDevil/inlay-hints.nvim',
  tag = 'v0.0.6',
  event = 'LspAttach',
  dependencies = { { 'neovim/nvim-lspconfig', tag = 'v2.5.0' } },
  config = function()
    require('inlay-hints').setup()
  end,
}

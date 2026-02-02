return {
  'MysticalDevil/inlay-hints.nvim',
  commit = '00f925e',
  event = 'LspAttach',
  dependencies = { { 'neovim/nvim-lspconfig', tag = 'v1.3.0' } },
  config = function()
    require('inlay-hints').setup()
  end,
}

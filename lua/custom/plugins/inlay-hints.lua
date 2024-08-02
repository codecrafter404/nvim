return {
  'MysticalDevil/inlay-hints.nvim',
  commit = '1d5bd49a43f8423bc56f5c95ebe8fe3f3b96ed58',
  event = 'LspAttach',
  dependencies = { 'neovim/nvim-lspconfig' },
  config = function()
    require('inlay-hints').setup()
  end,
}

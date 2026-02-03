---@type LazyPluginSpec
return {
  'MysticalDevil/inlay-hints.nvim',
  event = 'LspAttach',
  dependencies = { { 'neovim/nvim-lspconfig' } },
  ---Configure inlay-hints plugin
  ---@return nil
  config = function()
    require('inlay-hints').setup()
  end,
}

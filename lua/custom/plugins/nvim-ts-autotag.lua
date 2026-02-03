---@type LazyPluginSpec
return {
  'windwp/nvim-ts-autotag',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'svelte', 'html', 'xml', 'markdown' },

  ---Configure nvim-ts-autotag for auto-closing and renaming HTML tags
  ---@return nil
  config = function()
    require('nvim-ts-autotag').setup {
      opts = {
        enable_close = true,
        enable_close_on_slash = true,
      },
    }
  end,
}

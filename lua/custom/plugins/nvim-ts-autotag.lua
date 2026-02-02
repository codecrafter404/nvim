return {
  'windwp/nvim-ts-autotag',
  tag = 'v0.11.0',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'svelte', 'html', 'xml', 'markdown' },

  config = function()
    require('nvim-ts-autotag').setup {
      opts = {
        enable_close = true,
        enable_close_on_slash = true,
      },
    }
  end,
}

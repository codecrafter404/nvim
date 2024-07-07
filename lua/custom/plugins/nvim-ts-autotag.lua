return {
  'windwp/nvim-ts-autotag',
  commit = '323a3e16ed603e2e17b26b1c836d1e86c279f726',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'svelte', 'html' },

  opts = {
    enable_close = true,
    enable_close_on_slash = true,
  },
}

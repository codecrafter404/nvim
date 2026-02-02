-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  tag = 'v0.6.0',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { { 'hrsh7th/nvim-cmp', commit = 'ae644fe' } },
  opts = {},
  config = function()
    local opts = {
      ignored_next_char = [=[[%w%%%'%[%"%.%`]]=],
    }
    require('nvim-autopairs').setup(opts)
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}

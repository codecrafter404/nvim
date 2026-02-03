-- autopairs
-- https://github.com/windwp/nvim-autopairs

---@type LazyPluginSpec
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { { 'hrsh7th/nvim-cmp' } },
  opts = {},
  ---Configure nvim-autopairs with cmp integration
  ---@return nil
  config = function()
    ---@type table Autopairs configuration options
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

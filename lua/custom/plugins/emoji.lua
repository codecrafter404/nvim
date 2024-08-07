return {
  'allaman/emoji.nvim',
  commit = '009e6b247e40aea29bce52cec6a667cceaff1a6b',
  -- ft = 'markdown', -- adjust to your needs
  dependencies = {
    -- optional for nvim-cmp integration
    'hrsh7th/nvim-cmp',
    -- optional for telescope integration
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    -- default is false
    enable_cmp_integration = true,
    -- optional if your plugin installation directory
    -- is not vim.fn.stdpath("data") .. "/lazy/
  },
  config = function(_, opts)
    require('emoji').setup(opts)
    -- optional for telescope integration
    require('telescope').load_extension 'emoji'
  end,
}

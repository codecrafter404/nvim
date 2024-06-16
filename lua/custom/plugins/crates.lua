return {
  'saecki/crates.nvim',
  -- event = { 'BufRead Cargo.toml' },
  config = function()
    -- require('cmp').setup.buffer { sources = { { name = 'crates' } } }
    require('crates').setup {
      lsp = {
        enabled = true,
        completion = true,
        actions = true,
        hover = true,
      },
    }
  end,
}

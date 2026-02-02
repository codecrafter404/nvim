return {
  'Saecki/crates.nvim',
  tag = 'v0.5.3',
  event = { 'BufRead Cargo.toml' },
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

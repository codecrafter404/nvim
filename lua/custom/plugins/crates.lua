return {
  'Saecki/crates.nvim',
  commit = 'd1be10c1fcf4adb1eed2f2f510176db035efc68d',
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

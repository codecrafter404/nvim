return {
  'dfendr/clipboard-image.nvim',
  config = function()
    require('clipboard-image').setup {
      default = {
        img_dir = function()
          return 'img'
        end,
      },
    }
  end,
}

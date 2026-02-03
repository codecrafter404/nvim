-- this doesn't work as it only gets the path of the current file not the current buffer file
-- local function get_image_target_dir()
--   local pathseperator = '/'
--   if vim.fn.has 'win32' == 1 then
--     pathseperator = '\\'
--   end
--   local current_file_path = vim.fn.expand '%:p:h' -- Get full path of the current file
--   local cwd = vim.fn.getcwd() .. pathseperator .. 'Content'
--   local res = current_file_path:sub(string.len(cwd) + 2)
--   return 'Attachements' .. pathseperator .. res
-- end

---@module "lazy"
---@type LazyPluginSpec
return {
  'codecrafter404/clipboard-image.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'markdown' },
  ---Configure clipboard-image plugin
  ---@return nil
  config = function()
    require('clipboard-image').setup {
      -- default = {
      --   img_dir = get_image_target_dir(),
      --   img_dir_txt = get_image_target_dir(),
      -- },
    }
    vim.keymap.set('n', '<leader>ii', '<cmd>:PasteImg<CR>', { desc = '[I]nsert [I]mage from clipboard' })
  end,
}

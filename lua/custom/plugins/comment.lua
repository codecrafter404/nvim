---@module "lazy"
---@type LazyPluginSpec[]
return {
  { 'numToStr/Comment.nvim', event = { 'BufReadPre', 'BufNewFile' }, opts = {} },
}

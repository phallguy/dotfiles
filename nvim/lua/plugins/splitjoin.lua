vim.g.splitjoin_ruby_curly_braces = 0
vim.g.splitjoin_ruby_hanging_args = 0
vim.g.splitjoin_ruby_trailing_comma = 1
vim.g.splitjoin_normalize_whitespace = 1
vim.g.splitjoin_align = 1
vim.g.splitjoin_ruby_options_as_arguments = 1
vim.g.splitjoin_trailing_comma = 1

return {
  {
  	"AndrewRadev/splitjoin.vim",
  },
  -- {
  --   'Wansmer/treesj',
  --   keys = { '<space>m', 'gJ', 'gS' },
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  --   config = function()
  --     require('treesj').setup({ --[[ your config ]] })
  --   end,
  -- }
}

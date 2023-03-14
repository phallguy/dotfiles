return {
  { 'mg979/vim-visual-multi' },  -- Multi cursors
  { 'junegunn/vim-easy-align' }, -- Multi-line bock alignment
  { 'tpope/vim-surround' },      -- change surrounding tags/quotes/parens
  {
    'reedes/vim-pencil',
    config = function()
      vim.g["pencil#wrapModeDefault"] = 'soft'
    end
  },
  { 'AndrewRadev/splitjoin.vim' },
  { 'mbbill/undotree' },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      vim.opt.termguicolors = true   -- True color support
      require 'colorizer'.setup({
        '*',
      }, {
        css = true
      })
    end
  },
  { 'KabbAmine/vCoolor.vim' },
}

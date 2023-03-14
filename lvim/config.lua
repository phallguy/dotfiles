require('plenary.reload').reload_module('user', true)

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  -- General
  { 'embear/vim-localvimrc' }, -- import .vimrc from CWD when launching
  { 'tpope/vim-vinegar' },     -- netwr support
  { 'tpope/vim-fugitive' },    -- Git magic
  { 'tpope/vim-rhubarb' },     -- Even more git magic
  { 'pwntester/octo.nvim' },   -- Github magic
  { 'sindrets/diffview.nvim' },

  -- editing
  { 'mg979/vim-visual-multi' },
  { 'junegunn/vim-easy-align' }, -- Multi-line bock alignment
  { 'tpope/vim-surround' },      -- change surrounding tags/quotes/parens
  { 'reedes/vim-pencil' },
  { 'AndrewRadev/splitjoin.vim' },
  { 'mbbill/undotree' },
  { 'kevinhwang91/nvim-bqf' },
  { 'norcalli/nvim-colorizer.lua' },
  { 'KabbAmine/vCoolor.vim' },

  -- treesitter
  { 'JoosepAlviste/nvim-ts-context-commentstring' }, -- Change comment string based on embedded lang (eg ERB)
  { 'nvim-treesitter/nvim-treesitter-context' },     -- Show function/scope in windowbar
  { 'windwp/nvim-ts-autotag' },                      -- Auto close/rename html like tags

  -- Telescope / completion
  { 'nvim-telescope/telescope-live-grep-args.nvim' }, -- refine live grep
  { 'glepnir/lspsaga.nvim' },

  -- Color schemes
  {
    -- https://github.com/marko-cerovac/material.nvim
    "marko-cerovac/material.nvim",
    config = function()
      local colors = require 'material.colors'

      require('material').setup({
        contrast = {
          cursor_line = true,
          floating_windows = true,
          sidebars = true,
          terminal = true,
        },
        styles = {
          functions = { bold = true },
        },
        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          -- "dap",
          -- "dashboard",
          "gitsigns",
          -- "hop",
          "indent-blankline",
          "lspsaga",
          -- "mini",
          -- "neogit",
          -- "neorg",
          "nvim-cmp",
          -- "nvim-navic",
          -- "nvim-tree",
          "nvim-web-devicons",
          -- "sneak",
          "telescope",
          -- "trouble",
          "which-key",
        },
        custom_colors = function(c)
          -- c.git.added = "#596B3D"
        end,
        custom_highlights = {
          IndentBlanklineChar = { fg = colors.editor.line_numbers },
          IndentBlanklineContextChar = { fg = "#63698a" },
        },
        lualine_style = "stealth",
      })
    end
  },

  -- General testing

  { 'janko/vim-test' },
  { 'tpope/vim-dispatch' }, -- Async test runner to quick fix

  -- All languages
  { 'sheerun/vim-polyglot' },
  { 'smjonas/inc-rename.nvim' },

  -- Rails
  { 'tpope/vim-rails' },

  -- Typescript
  { "jose-elias-alvarez/typescript.nvim" } -- Extra typescript love
}


-- lvim.builtin.indentlines.options.show_trailing_blankline_indent = true


vim.g.material_style = "palenight"
lvim.colorscheme = "material"

lvim.builtin.autopairs.active = false
lvim.builtin.nvimtree.active = false

lvim.builtin.bufferline.active = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.illuminate.active = false
lvim.builtin.project.active = false
lvim.builtin.alpha.active = false

lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.diagnostics.document_higlight = true
-- lvim.format_on_save = true
--

-- lvim.log.level = "debug"
-- lvim.lsp.null_ls.setup.debug = true
lvim.lsp.automatic_servers_installation = false

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tailwindcss" })

-- Support per-project .vimrc commands
vim.g["localvimrc_name"] = { '.lvimrc', '.vimrc' }
vim.g["localvimrc_sandbox"] = 0
vim.g["localvimrc_persistent"] = 2

require 'colorizer'.setup({
  '*',
}, {
  css = true
})

lvim.builtin.cmp.active = true
lvim.builtin.cmp.completion.keyword_length = 1
lvim.builtin.cmp.experimental.ghost_text = true
lvim.builtin.cmp.view = { native = true }

require "user.options"
require "user.telescope"
require "user.treesitter"
require "user.lualine"
require "user.editing"
require "user.debugging"
require "user.testing"
require "user.html"
require "user.ruby"
require "user.git"
require "user.saga"

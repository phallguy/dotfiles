  return {
    -- https://github.com/marko-cerovac/material.nvim
    "marko-cerovac/material.nvim",
    config = function()
      vim.g.material_style = "palenight"
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
        custom_highlights = {
          IndentBlanklineChar = { fg = colors.editor.line_numbers },
          IndentBlanklineContextChar = { fg = "#63698a" },
        },
        lualine_style = "stealth",
      })

      vim.cmd.colorscheme "material"
    end,
  }

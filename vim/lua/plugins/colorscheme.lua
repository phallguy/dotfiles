  return {
    -- https://github.com/marko-cerovac/material.nvim
    "marko-cerovac/material.nvim",
    config = function()
      vim.g.material_style = "palenight"
      local colors = require 'material.colors'

      colors.git.added = "#2f3742"
      colors.git.deleted = "#333042"
      colors.git.modified = "#2b3348"

      require('material').setup({
        contrast = {
          cursor_line = true,
          floating_windows = true,
          sidebars = true,
          non_current_windows = false,
        },
        styles = {
          functions = { bold = true },
          types = { bold = true },
          comments = { italic = true },
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
          DiffAdd = { bg = colors.git.added },
          DiffDelete = { bg = colors.git.deleted },
          DiffChange = { bg = colors.git.modified },
          DiffviewDiffAddAsDelete = { bg = colors.git.deleted },
          DiffText = { bg = "#52533b" },

          SagaNormal = { bg = colors.editor.bg_alt },

          Hlargs = { fg = colors.main.darkorange },
          HlargsNamedParams = { fg = colors.main.darkorange },
        },
        lualine_style = "stealth",
      })

      vim.cmd.colorscheme "material"
    end,
    dependencies = {
      "glepnir/lspsaga.nvim"
    }
  }

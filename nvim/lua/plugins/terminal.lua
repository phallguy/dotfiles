if vim.g.vscode then
  return {}
end

return {
  {
    -- https://github.com/akinsho/toggleterm.nvi
    "akinsho/toggleterm.nvim",
    lazy = true,
    config = function()
      local colors = require("rose-pine.palette")

      require("toggleterm").setup({
        -- shading_factor = -15,
        shell = "zsh -il",
        shade_terminals = false,
        highlights = {
          Normal = { guibg = colors.surface },
          NormalFloat = { guibg = colors.surface },
          FloatBorder = { guibg = colors.surface, guifg = colors.highlight_med },
        },
      })
    end,
    cmd = {
      "TermOpen",
      "TermToggle",
    }
  },
}

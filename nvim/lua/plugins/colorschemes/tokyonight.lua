return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,
  config = function ()
    require("tokyonight").setup({})

		-- vim.cmd.colorscheme("tokyonight")
  end
}

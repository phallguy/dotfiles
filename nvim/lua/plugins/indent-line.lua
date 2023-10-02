if vim.g.vscode then
	return {}
end

return {
  -- Add indentation guides even on blank lines
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  -- See `:help ibl.setup`
  opts = {
    scope = {
      show_start = false,
      show_end = false,
    }
  },
}

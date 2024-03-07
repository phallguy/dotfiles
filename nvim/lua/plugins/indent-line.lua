if vim.g.vscode then
	return {}
end

return {
  -- Add indentation guides even on blank lines
  "lukas-reineke/indent-blankline.nvim",
  event = "BufEnter",
  main = "ibl",
  -- See `:help ibl.setup`
  opts = {
    indent = { char = "│" },
    scope = {
      show_start = false,
      show_end = false,
    }
  },
}

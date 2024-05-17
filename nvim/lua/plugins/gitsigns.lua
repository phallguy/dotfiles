if vim.g.vscode then
  return {}
end

return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  opts = {
    numhl = false,
    word_diff = false,
    linehl = false,
  },
}

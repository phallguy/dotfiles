if vim.g.vscode then
  return {}
end

return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  opts = {
    numhl = false,
    word_diff = false,
    linehl = false,
    -- signs = {
    --   add = {
    --     hl = "GitSignsAdd",
    --     numhl = "GitSignsAddNr",
    --     linehl = "GitSignsAddLn",
    --   },
    --   change = {
    --     hl = "GitSignsChange",
    --     numhl = "GitSignsChangeNr",
    --     linehl = "GitSignsChangeLn",
    --   },
    --   delete = {
    --     hl = "GitSignsDelete",
    --     numhl = "GitSignsDeleteNr",
    --     linehl = "GitSignsDeleteLn",
    --   },
    --   topdelete = {
    --     hl = "GitSignsDelete",
    --     numhl = "GitSignsDeleteNr",
    --     linehl = "GitSignsDeleteLn",
    --   },
    --   changedelete = {
    --     hl = "GitSignsChange",
    --     numhl = "GitSignsChangeNr",
    --     linehl = "GitSignsChangeLn",
    --   },
    --   untracked = {
    --     text = "│",
    --     hl = "GitSignsUntracked",
    --   },
    -- },
  },
}

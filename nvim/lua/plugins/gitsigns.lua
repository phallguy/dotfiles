if vim.g.vscode then
  return {}
end

return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  event = { "BufEnter" },
  opts = {
    numhl = false,
    word_diff = false,
    linehl = false,
    on_attach = function(bufnr)
      -- Next/prev diff hunk
      if not vim.g.vscode then
        local gs = require("gitsigns")
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, { expr = true, desc = "Next diff hunk", buffer = bufnr })

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, { expr = true, desc = "Prev diff hunk", buffer = bufnr })
      end
    end
  },
}

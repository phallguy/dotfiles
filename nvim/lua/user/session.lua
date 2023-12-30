if vim.g.vscode then
  return
end

vim.cmd([[
augroup TrailingWhitespace
  autocmd!

  " Remove trailing whitespace on save
  function! s:RemoveTrailingWhitespaces()
  "Save last cursor position
  let l = line(".")
  let c = col(".")

  %s/\s\+$//ge

  call cursor(l,c)
  endfunction

  au BufWritePre * :call <SID>RemoveTrailingWhitespaces()
augroup END
]])

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    local ft = vim.bo.filetype
    if mark[1] > 0 and mark[1] <= lcount and ft ~= 'gitcommit' then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Auto save on blur
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = augroup("autosave"),
  command = "silent! update",
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "git",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
    "fugitiveblame",
    "DiffviewFileHistory",
  },
  callback = function(event)
    -- Can't unlist, messes with fugutive G! commands
    -- vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 0
    vim.cmd("PencilSoft")
  end,
})

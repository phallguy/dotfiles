lvim.builtin.which_key.mappings["l"] = {
  a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
  u = { "<cmd>Lspsaga lsp_finder<CR>", "Find" },
  d = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition" },
  g = { "<cmd>Lspsaga goto_definition<CR>", "Peek definition" },
  f = { "<cmd>lua require('lvim.lsp.utils').format()<CR>", "Format" },
  j = {
    "<cmd>Lspsaga diagnostic_jump_next<CR>",
    "Next Diagnostic",
  },
  k = {
    "<cmd>Lspsaga diagnostic_jump_prev<CR>",
    "Prev Diagnostic",
  },
  l = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line diagnostics" },
  c = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Cursor diagnostics" },
  q = { "<cmd>lua vim.diagnostic.setqflist()<CR>", "Quickfix" },
  r = {
    s = { ":IncRename ", "Rename symbol" },
    f = {
      "<CMD>TypescriptRenameFile<CR>", "Rename file (TS)",
    }
  },
  o = { "<CMD>Lspsaga outline<CR>", "Outline" },
  s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
  i = { "<CMD>TypescriptOrganizeImports<CR>", "Organize imports" },
  t = {
    name = "Typescript",
    a = { "<CMD>TypescriptAddMissingImports<CR>", "Add missing imports" },
    u = { "<CMD>TypescriptRemoveUnused<CR>", "Remove unused" },
    f = { "<CMD>TypescriptFixAll<CR>", "Fix all" },
  }
}

lvim.lsp.buffer_mappings.normal_mode["K"] = { "<CMD>Lspsaga hover_doc<CR>", "Show help" }
lvim.lsp.buffer_mappings.normal_mode["gd"] = { "<CMD>Lspsaga goto_definition<CR>", "Definition" }
lvim.lsp.buffer_mappings.normal_mode["gu"] = { "<CMD>Lspsaga lsp_finder<CR>", "Definition" }

require("inc_rename").setup()

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  return
end

-- configure typescript server with plugin
typescript.setup({
  server = {
    capabilities = cmp_nvim_lsp.capabilities,
  },
})

require("lspsaga").setup({
  symbol_in_winbar = {
    enable = false
  },
  definition = {
    edit = "<CR>",
  },
  outline = {
    auto_close = true,
    keys = {
      jump = "<CR>"
    }
  }
})

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
  b = { "<cmd>Telescope diagnostics<CR>", "Buffer diagnostics" },
  q = { "<cmd>lua vim.diagnostic.setqflist()<CR>", "Buffer quickfix" },
  r = {
    s = { ":IncRename ", "Rename symbol" },
    f = {
      "<CMD>TypescriptRenameFile<CR>", "Rename file (TS)",
    }
  },
  o = { "<CMD>Lspsaga outline<CR>", "Outline" },
  s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },
  t = {
    name = "Typescript",
    a = { "<CMD>TypescriptAddMissingImports<CR>", "Add missing imports" },
    u = { "<CMD>TypescriptRemoveUnused<CR>", "Remove unused" },
    f = { "<CMD>TypescriptFixAll<CR>", "Fix all" },
    i = { "<CMD>TypescriptOrganizeImports<CR>", "Organize imports" },
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
  request_timeout = 30000,
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
  },
  diagnostic = {
    -- don't show in-flight analysis in upper right
    on_insert = false,
    show_virt_line = false,
    -- border_follow = false,
  },
  finder = {
    request_timeout = 10000,
  },
  -- lightbulb = {
  --   show_virt_line = false
  -- },
  beacon = {
    frequency = 3
  }
})

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "codespell",
    filetypes = { "typescript", "typescriptreact", "json", "javascript", "python", "ruby", "eruby" },
  },
  {
    command = "eslint"
  }
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettierd" },
}


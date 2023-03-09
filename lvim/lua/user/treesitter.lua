lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.ensure_installed = {
  -- needed for help docs
  "markdown", "markdown_inline"
}

lvim.builtin.treesitter.matchup = {
  enable = true,
  disable = {}
}

lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.rainbow.enable = false

lvim.builtin.treesitter.indent = {
  enable = true
}

lvim.builtin.treesitter.playground.enable = true

lvim.builtin.treesitter.incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = "+",
    node_incremental = "+",
    node_decremental = "_",
  },
}

-- custom text objects
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-select
lvim.builtin.treesitter.textobjects.select = {
  enable = true,
  lookahead = true,
  keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@comment.outer",
  },
}

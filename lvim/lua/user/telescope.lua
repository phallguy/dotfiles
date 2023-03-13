lvim.keys.normal_mode[","] = ":Telescope buffers<CR>"
lvim.keys.normal_mode["<C-p>"] = ":Telescope git_files<CR>"

lvim.builtin.which_key.mappings["/"] = { ":Telescope current_buffer_fuzzy_find<CR>", "Find in buffer" }

lvim.builtin.which_key.mappings["a"] = {
  name = "Search",
  g = { ":Telescope live_grep_args<CR>", "Live grep" },
  f = { ":Telescope git_files<CR>", "Find files" },
  a = { ":Telescope find_files<CR>", "Find all files" },
  r = { ":Telescope resume<CR>", "Resume search" },
  e = { ":Telescope registers<CR>", "Registers" },
}

lvim.builtin.telescope.defaults.initial_mode = "insert"
lvim.builtin.telescope.defaults.border = true
lvim.builtin.telescope.defaults.path_display = { "truncate" }

lvim.builtin.telescope.defaults.theme = "ivy"

lvim.builtin.telescope.pickers.buffers = {
  theme = "dropdown",
  previewer = false,
  initial_mode = "insert",
  sort_lastused = true,
}

lvim.builtin.telescope.pickers.git_files = {
  theme = "dropdown",
  previewer = false,
  initial_mode = "insert",
  hidden = false,
  sort_lastused = true,
}

lvim.builtin.telescope.pickers.find_files = {
  theme = "ivy",
  previewer = true,
  initial_mode = "insert",
  hidden = false,
  sort_lastused = true,
}

lvim.builtin.telescope.pickers.current_buffer_fuzzy_find = {
  theme = "ivy",
  previewer = true,
  initial_mode = "insert",
  hidden = false,
  sort_lastused = true,
}


lvim.builtin.telescope.defaults.layout_config = {
  bottom_pane = {
    height = 25,
    preview_cutoff = 120,
    prompt_position = "top"
  },
  center = {
    height = 0.4,
    preview_cutoff = 40,
    prompt_position = "top",
    width = 0.85,
    anchor = "S"
  },
  cursor = {
    height = 0.9,
    preview_cutoff = 40,
    width = 0.9
  },
  horizontal = {
    height = 0.9,
    preview_cutoff = 120,
    prompt_position = "bottom",
    width = 0.9
  },
  vertical = {
    height = 0.9,
    preview_cutoff = 40,
    prompt_position = "bottom",
    width = 0.9
  }
}

vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'
vim.g.netrw_banner = false
vim.g.netrw_liststyle = 0


local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["?"] = actions.which_key,
  },
  n = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["?"] = actions.which_key,
  }
}

require("telescope").load_extension("live_grep_args")
local lga_actions = require("telescope-live-grep-args.actions")

lvim.builtin.telescope.extensions.live_grep_args = {
  auto_quoting = true, -- enable/disable auto-quoting
  -- define mappings, e.g.
  mappings = {
    -- extend mappings
    i = {
          ["<CS-f>"] = lga_actions.quote_prompt(),
          ["<C-f>"] = lga_actions.quote_prompt({ postfix = " --iglob **//**" }),
    },
  },
}

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "live_grep_args")
end
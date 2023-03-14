-- https://github.com/nvim-telescope/telescope.nvim
return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local _, actions = pcall(require, "telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")

      vim.keymap.set("n", ",", require('telescope.builtin').buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<C-p>", require('telescope.builtin').find_files, { desc = "Find files" })
      vim.keymap.set("n", "<CS-P>", require('telescope.builtin').oldfiles, { desc = "Recent files" })

      vim.keymap.set("n", "<leader>/", require('telescope.builtin').current_buffer_fuzzy_find, { desc = "Find in buffer" })

      vim.keymap.set("n", "<leader>ag", require("telescope").extensions.live_grep_args.live_grep_args,  { desc = "Live grep" })
      vim.keymap.set("n", "<leader>af", require('telescope.builtin').find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>ar", require('telescope.builtin').resume, { desc = "Resume search" })
      vim.keymap.set("n", "<leader>ae", require('telescope.builtin').registers, { desc = "Registers" })

      require('telescope').setup {
        defaults = {
          initial_mode = "insert",
          path_display = { "truncate" },
          theme = "ivy",
          mappings = {
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
          },
        },

        pickers = {
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "insert",
            sort_lastused = true,
          },
          find_files = {
            theme = "ivy",
            previewer = false,
            sort_lastused = true,
          },
          oldfiles = {
            theme = "ivy",
            previewer = false,
            sort_lastused = true,
          },
          current_buffer_fuzzy_find = {
            theme = "ivy",
            initial_mode = "insert",
            sort_lastused = true,
          }
        },
        extensions = {
          live_grep_args = {
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
        }
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'live_grep_args')
    end
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { 'nvim-telescope/telescope-live-grep-args.nvim' }, -- refine live grep
}

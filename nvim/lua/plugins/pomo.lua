return {
	"epwalsh/pomo.nvim",
	version = "*", -- Recommended, use latest release instead of latest commit
	lazy = true,
	cmd = { "TimerStart", "TimerRepeat" },
	dependencies = {
		-- Optional, but highly recommended if you want to use the "Default" timer
		-- "rcarriga/nvim-notify",
	},
	opts = function()
		pcall(require("telescope").load_extension, "pomodori")
		require("pomo").setup({
			notifiers = {
				-- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
				{
					name = "Default",
					opts = {
						sticky = false,
					},
				},
			},
		})
	end,
}

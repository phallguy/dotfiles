return {
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup()
		end,
		cmd = {
		  "ChatGPT",
		  "ChatGPTActAs",
		  "ChatGPTEditWithInstructions",
		  "ChatGPTRun",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim"
		}
	}
}

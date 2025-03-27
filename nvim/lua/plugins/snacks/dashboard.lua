return {
	config = {

		enabled = false,
		width = 120,
		sections = {
			{
				gap = 1,
				padding = 2,
				{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
				{
					icon = "󰒲 ",
					key = "l",
					desc = "Lazy",
					action = ":Lazy",
					enabled = package.loaded.lazy ~= nil,
				},
				{ icon = " ", key = "N", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
			-- {
			-- 	{
			-- 		icon = " ",
			-- 		title = "Recent Files",
			-- 		section = "recent_files",
			-- 		cwd = true,
			-- 		limit = 10,
			-- 		indent = 0,
			-- 		padding = { 2, 1 },
			-- 	},
			-- },
			{
				pane = 1,
				icon = " ",
				desc = "Browse Repo",
				padding = 1,
				key = "b",
				action = function()
					Snacks.gitbrowse()
				end,
			},
			function()
				local in_git = Snacks.git.get_root() ~= nil
				local cmds = {
					{
						title = "Notifications",
						cmd = "gh notify -s -n5",
						action = function()
							vim.ui.open("https://github.com/notifications")
						end,
						key = "n",
						icon = " ",
						height = 5,
						enabled = true,
					},
					{
						icon = " ",
						title = "Open PRs",
						cmd = "gh pr list -L 3",
						key = "p",
						action = function()
							vim.fn.jobstart("gh pr list --web", { detach = true })
						end,
						height = 7,
					},
					{
						icon = " ",
						title = "Git Status",
						cmd = "git --no-pager diff --stat -B -M -C",
						height = 10,
					},
				}
				return vim.tbl_map(function(cmd)
					return vim.tbl_extend("force", {
						pane = 1,
						section = "terminal",
						enabled = in_git,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					}, cmd)
				end, cmds)
			end,
			{ section = "startup" },
		},
	},
}

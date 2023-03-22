-- https://wezfurlong.org/wezterm/config/files/
local wezterm = require("wezterm")
local font_family = "JetBrainsMonoNL Nerd Font Mono"

return {
	-- Appearance ===
	--
	-- Fonts
	font = wezterm.font(font_family, {
		weight = "Light",
	}),
	font_size = 14.5,
	line_height = 0.89,
	cell_width = 0.89,
	freetype_load_target = "Light",
	freetype_render_target = "Light",
	font_rules = {
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font(font_family, {
				weight = "Regular",
			}),
		},
	},
	-- colors
	color_scheme = "rose-pine-moon",
	-- color_scheme = "Material Palenight (base16)",
	window_frame = {
		font = wezterm.font_with_fallback({
			-- <built-in>, BuiltIn
			{ family = "Roboto", weight = "Medium" },

			-- /Users/paulalexander/Library/Fonts/JetBrains Mono NL Light Nerd Font Complete Mono.ttf, CoreText
			{ family = "JetBrainsMonoNL Nerd Font Mono", weight = "Light" },

			-- /Users/paulalexander/Library/Fonts/JetBrainsMono-Regular.ttf, CoreText
			"JetBrains Mono",

			-- <built-in>, BuiltIn
			-- Assumed to have Emoji Presentation
			-- Pixel sizes: [128]
			"Noto Color Emoji",

			-- <built-in>, BuiltIn
			"Symbols Nerd Font Mono",
		}),
		font_size = 12,
		active_titlebar_bg = "#2a273f",

	},
	colors = {
		tab_bar = {
			background = "#232136",
			inactive_tab_edge = "#3e8fb0",
			active_tab = {
				fg_color = "#3e8fb0",
        bg_color = "#232136",
			},
			inactive_tab = {
				fg_color = "#6e6a86",
        bg_color = "#2a273f",
			},
		},
	},
	window_padding = {
		top = 0,
		left = 10,
		right = 10,
		bottom = 0,
	},
	window_decorations = "RESIZE",
	command_palette_bg_color = "#202331",
	command_palette_fg_color = "#A6ACCD",
	initial_cols = 150,
	initial_rows = 40,
	-- Tabs
	use_fancy_tab_bar = true,
	-- show_tabs_in_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_style = {},
	enable_tab_bar = true,
	tab_max_width = 16,
	hide_tab_bar_if_only_one_tab = true,
	--
	scrollback_lines = 3000,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	keys = {
		{
			key = "p",
			mods = "CTRL | SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "P",
			mods = "CTRL | SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "n",
			mods = "CTRL | SHIFT",
			action = wezterm.action.ActivateCommandPalette,
		},
	},
}

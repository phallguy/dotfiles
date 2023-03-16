-- https://wezfurlong.org/wezterm/config/files/
local wezterm = require("wezterm")

return {
	-- Appearance ===
	font = wezterm.font(
		"JetBrainsMonoNL Nerd Font Mono",
		{
			weight = "Light",
		}
	),
	font_size = 14,
	line_height = 0.89,
	cell_width = 0.89,
	freetype_load_target = "Light",
	freetype_render_target = "Light",
	color_scheme = "Material Palenight (base16)",
	colors = {
		tab_bar = {
			background = "#202331",
			active_tab = {
				bg_color = "#292D3E",
				fg_color = "#414863",
			},
			inactive_tab = {
				bg_color = "#202331",
				fg_color = "#444267",
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
	use_fancy_tab_bar = false,
	-- show_tabs_in_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_style = {},
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
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
		}
	}
}

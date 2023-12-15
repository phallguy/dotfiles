-- https://wezfurlong.org/wezterm/config/files/
local wezterm = require("wezterm")
local font_family = "JetBrainsMonoNL Nerd Font Mono"

return {
	-- https://wezfurlong.org/wezterm/config/lua/config/term.html?h=terminfo
	-- term = "wezterm",
	-- Appearance ===
	--
	-- Fonts
	font = wezterm.font(font_family, { weight = "Thin" }),
	-- font = wezterm.font(font_family, { weight="Medium" }),
	font_size = 15,
	line_height = 0.95,
	cell_width = 0.90,
	freetype_load_target = "HorizontalLcd",
	freetype_render_target = "HorizontalLcd",
	-- colors
	color_scheme = "rose-pine-moon",
	window_frame = {
		font = wezterm.font_with_fallback({
			-- <built-in>, BuiltIn
			{ family = "Roboto",                         weight = "Medium" },

			-- /Users/paulalexander/Library/Fonts/JetBrains Mono NL Light Nerd Font Complete Mono.ttf, CoreText
			{ family = "JetBrainsMonoNL Nerd Font Mono", weight = "Thin" },

			-- /Users/paulalexander/Library/Fonts/JetBrainsMono-Regular.ttf, CoreText
			"JetBrains Mono",

			-- <built-in>, BuiltIn
			-- Assumed to have Emoji Presentation
			-- Pixel sizes: [128]
			"Noto Color Emoji",

			-- <built-in>, BuiltIn
			"Symbols Nerd Font Mono",
		}),
		font_size = 14,
		active_titlebar_bg = "#2a273f",
	},
	colors = {
		selection_bg = "#22385f",
		cursor_bg = "#c4a7e7",
		-- cursor_bg = "#ebbcba",
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
		left = 0,
		right = 0,
		bottom = 0,
	},
	webgpu_power_preference = "HighPerformance",
	window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW",
	-- window_decorations = "RESIZE",
	command_palette_bg_color = "#202331",
	macos_window_background_blur = 15,
	window_background_opacity = 0.90,
	-- window_background_gradient = {
	-- 	orientation = "Vertical",
	-- 	colors = {
	-- 		'#232136',
	-- 		'#42384D',
	-- 		'#232136',
	-- 	}
	-- },
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
	scrollback_lines = 10000,
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
			key = "F",
			mods = "CTRL | SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}

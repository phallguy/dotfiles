-- https://wezfurlong.org/wezterm/config/files/
local wezterm = require("wezterm")

local hyperlinks = wezterm.default_hyperlink_rules()

return {
	-- https://wezfurlong.org/wezterm/config/lua/config/term.html?h=terminfo
	term = "wezterm",
	front_end = "WebGpu",
	max_fps = 250,
	prefer_egl = false,
	-- Appearance ===
	--
	-- Fonts
	font = wezterm.font_with_fallback({
		{
			family = "CommitMonoPhallguy",
			-- family = "JetBrains Mono",
			harfbuzz_features = {
				-- "calt=0",
				-- "clig=0",
				-- "liga=0",
			},
			-- <=>
		},
		{
			-- family = "JetBrainsMono Nerd Font Mono",
			family = "CommitMono Nerd Font Mono",
			scale = 1,
		},
	}),
	font_rules = {
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font_with_fallback({
				{
					family = "CommitMonoPhallguy",
					weight = "Bold",
					italic = true,
				},
				{
					family = "CommitMono Nerd Font Mono",
				},
			}),
		},

		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font_with_fallback({
				{
					family = "CommitMonoPhallguy",
					weight = "Bold",
				},
				{
					family = "CommitMono Nerd Font Mono",
				},
			}),
		},
	},
	-- font = wezterm.font(font_family, { weight="Medium" }),
	font_size = 15,
	-- line_height = 1.125,
	-- cell_width = 0.90,
	-- freetype_load_flags = "DEFAULT",
	-- freetype_load_target = "Light",
	-- freetype_render_target = "HorizontalLcd",
	allow_square_glyphs_to_overflow_width = "Never",
	-- font_antialias = "Subpixel",
	-- colors
	color_scheme = "rose-pine-moon",
	-- color_scheme = "matrix",
	window_frame = {
		font = wezterm.font_with_fallback({
			-- <built-in>, BuiltIn
			{ family = "Roboto", weight = "Medium" },

			-- /Users/paulalexander/Library/Fonts/JetBrains Mono NL Light Nerd Font Complete Mono.ttf, CoreText
			{ family = "CommitMono Nerd Font Mono" },

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
		selection_bg = "#f040ed",
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
		left = 4,
		right = 2,
		bottom = 0,
	},
	webgpu_power_preference = "HighPerformance",
	window_decorations = "RESIZE",
	command_palette_bg_color = "#202331",
	macos_window_background_blur = 35,
	-- window_background_opacity = 0.95,
	-- window_background_gradient = {
	-- 	orientation = "Vertical",
	-- 	colors = {
	-- 		"#232136",
	-- 	},
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
		{
			key = "b",
			mods = "CTRL | SHIFT",
			action = wezterm.action.PaneSelect,
		},
	},
	hyperlink_rules = hyperlinks,
	-- Allow CMD key in neovim
	enable_kitty_keyboard = true,
	enable_csi_u_key_encoding = true,
}

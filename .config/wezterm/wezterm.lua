local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "TokyoNight"
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.font_size = 13.0
config.use_cap_height_to_scale_fallback_fonts = true
config.font = wezterm.font_with_fallback({
	-- {
	-- 	family = "JetBrains Mono",
	-- 	weight = "Medium",
	-- 	italic = false,
	-- 	harfbuzz_features = {
	-- 		"zero",
	-- 		-- "ss01",
	-- 		"ss02",
	-- 		"cv03",
	-- 		"cv04",
	-- 		"cv14",
	-- 		"cv16",
	-- 		"cv99",
	-- 	},
	-- },
	{
		family = "Monaspace Krypton",
		-- family = "Monaspace Neon",
		weight = "Medium",
		italic = false,
		harfbuzz_features = {
			"ss01",
			"ss02",
			"ss03",
			"ss04",
			"ss05",
			"ss06",
			"ss07",
			"ss08",
		},
	},
	-- {
	-- 	family = "Fira Code",
	-- 	weight = "Medium",
	-- 	italic = false,
	-- 	harfbuzz_features = {
	-- 		"zero",
	-- 		"ss01",
	-- 		"ss02",
	-- 		"ss03",
	-- 		"ss04",
	-- 		"ss05",
	-- 		"ss07",
	-- 		"ss08",
	-- 		"cv30",
	-- 		"cv31",
	-- 		"cv25",
	-- 		"cv26",
	-- 		"cv32",
	-- 		"onum",
	-- 	},
	-- },
	{
		family = "Symbols Nerd Font",
		weight = "Regular",
		italic = false,
	},
})
config.window_background_opacity = 0.9
config.macos_window_background_blur = 40
config.window_frame = {
	font = wezterm.font({ family = "Roboto", weight = "Medium" }),
	font_size = 13.0,
}
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
config.use_dead_keys = true
config.audible_bell = "Disabled"
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "C", mods = "CTRL", action = act.CopyTo("Clipboard") },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "Backspace", mods = "CTRL|SHIFT", action = act.ResetFontSize },
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}
config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

return config

local wezterm = require("wezterm")
local act = wezterm.action

return {
	color_scheme = "Everblush",
	freetype_load_target = "Light",
	freetype_render_target = "HorizontalLcd",
	font_size = 12.5,
	font = wezterm.font_with_fallback({
		{
			family = "JetBrainsMono Nerd Font Mono",
			weight = "Medium",
			italic = false,
			harfbuzz_features = {
				"zero",
				-- "ss01",
				"ss02",
				"cv03",
				"cv04",
				"cv14",
				"cv16",
				"cv99",
			},
		},
		-- {
		-- 	family = "Fira Code",
		-- 	weight = "DemiBold",
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
	}),
	window_background_opacity = 0.9,
	window_frame = {
		font = wezterm.font({ family = "Roboto", weight = "Medium" }),
		font_size = 11.6,
	},
	window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 0,
	},
	use_dead_keys = true,
	audible_bell = "Disabled",
	leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
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
	},
	key_tables = {
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
	},
}

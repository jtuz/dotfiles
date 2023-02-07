local wezterm = require("wezterm")

return {
	color_scheme = "Everblush",
	font_size = 10.2,
	font = wezterm.font_with_fallback({
		{
			family = "Fira Code",
			weight = "Medium",
			italic = false,
			harfbuzz_features = {
				"zero",
				"ss01",
				"ss02",
				"ss03",
				"ss04",
				"ss05",
				"ss07",
				"ss08",
				"cv30",
				"cv31",
				"cv25",
				"cv26",
				"cv32",
				"onum",
			},
		},
		"JetBrains Mono Medium Nerd Font Complete",
	}),
	window_background_opacity = 0.9,
	window_frame = {
		font = wezterm.font({ family = "Roboto", weight = "Medium" }),
		font_size = 10,
	},
	window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 0,
	},
	use_dead_keys = true,
	audible_bell = "Disabled",
	dpi = 100,
	leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{ key = "C", mods = "CTRL", action = wezterm.action.CopyTo("Clipboard") },
		{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
		{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{ key = "Backspace", mods = "CTRL|SHIFT", action = wezterm.action.ResetFontSize },
		{
			key = "|",
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
	},
}

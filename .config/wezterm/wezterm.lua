local wezterm = require "wezterm"
local act = wezterm.action

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.max_fps = 120
config.prefer_egl = true

config.enable_tab_bar = true
config.show_tabs_in_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.enable_scroll_bar = false
config.window_decorations = "RESIZE" -- remove native window border
-- config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.color_scheme = "TokyoNight"
-- config.color_scheme = "Gruvbox dark, hard (base16)"
-- config.color_scheme = "Elementary"
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.7,
}
config.colors = {
  tab_bar = {
    background = "#16161e",
    active_tab = {
      fg_color = "#1a1b26",
      bg_color = "#9ece6a",
      intensity = "Bold",
    },
    inactive_tab = {
    	fg_color = "#545c7e",
    	bg_color = "#1f2336"
    }
  },
  split = "#b8bb26",
}
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.font_size = 13.7
-- config.line_height = 1.2
config.use_cap_height_to_scale_fallback_fonts = true
config.font = wezterm.font_with_fallback {
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
  -- {
  -- 	family = "Monaspace Krypton",
  -- 	-- family = "Monaspace Neon",
  -- 	weight = "Medium",
  -- 	italic = false,
  -- 	harfbuzz_features = {
  -- 		"ss01",
  -- 		"ss02",
  -- 		"ss03",
  -- 		"ss04",
  -- 		"ss05",
  -- 		"ss06",
  -- 		"ss07",
  -- 		"ss08",
  -- 	},
  -- },
  -- {
  --   family = "Fira Code",
  --   weight = "Medium",
  --   italic = false,
  --   harfbuzz_features = {
  --     "zero",
  --     "ss01",
  --     "ss02",
  --     "ss03",
  --     "ss04",
  --     "ss05",
  --     "ss07",
  --     "ss08",
  --     "cv30",
  --     "cv31",
  --     "cv25",
  --     "cv26",
  --     "cv32",
  --     "onum",
  --   },
  -- },
  {
    family = "Cascadia Code",
    weight = "Medium",
    italic = false,
    harfbuzz_features = {
      "cv04",
      "ss01",
      "ss02",
      "ss04",
      "ss05",
      "ss07",
      "cv13",
      "cv25",
      "cv28",
      "cv30",
      "cv31",
      "cv32",
    }
  },
  {
    family = "Symbols Nerd Font",
    weight = "Regular",
    italic = false,
  },
}
config.window_background_opacity = 0.9
config.macos_window_background_blur = 40
config.window_frame = {
  font = wezterm.font { family = "Roboto", weight = "Medium" },
  font_size = 13.0,
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.use_dead_keys = true
config.audible_bell = "Disabled"
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  { key = "C", mods = "CTRL", action = act.CopyTo "Clipboard" },
  { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
  { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
  { key = "Backspace", mods = "CTRL|SHIFT", action = act.ResetFontSize },
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable {
      name = "resize_pane",
      one_shot = false,
    },
  },
  {
    key = "|",
    -- US Keyboard
    -- mods = "LEADER|SHIFT",
    -- Macos M3 spanish keyboard
    -- mods = "LEADER",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "t",
    mods = "LEADER",
    action = act.ShowTabNavigator,
  },
  {
    key = 'e',
    mods = "LEADER",
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(
        function(window, _, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      ),
    },
  },
  {
    key = "p",
    mods = "CMD",
    action = wezterm.action.PaneSelect
  }
}
config.key_tables = {
  resize_pane = {
    { key = "LeftArrow", action = act.AdjustPaneSize { "Left", 1 } },
    { key = "h", action = act.AdjustPaneSize { "Left", 1 } },

    { key = "RightArrow", action = act.AdjustPaneSize { "Right", 1 } },
    { key = "l", action = act.AdjustPaneSize { "Right", 1 } },

    { key = "UpArrow", action = act.AdjustPaneSize { "Up", 1 } },
    { key = "k", action = act.AdjustPaneSize { "Up", 1 } },

    { key = "DownArrow", action = act.AdjustPaneSize { "Down", 1 } },
    { key = "j", action = act.AdjustPaneSize { "Down", 1 } },

    -- Cancel the mode by pressing escape
    { key = "Escape", action = "PopKeyTable" },
  },
}
config.window_background_gradient = {
  -- Can be "Vertical" or "Horizontal".  Specifies the direction
  -- in which the color gradient varies.  The default is "Horizontal",
  -- with the gradient going from left-to-right.
  -- Linear and Radial gradients are also supported; see the other
  -- examples below
  -- orientation = "Vertical",
  -- orientation = { Linear = { angle = -45.0 } },
  orientation = {
    Radial = {
      cx = 0.8,
      cy = 0.8,
      radius = 1.2,
    }
  },

  -- Specifies the set of colors that are interpolated in the gradient.
  -- Accepts CSS style color specs, from named colors, through rgb
  -- strings and more
  colors = require("gradient_themes").dark_blue,

  -- Instead of specifying `colors`, you can use one of a number of
  -- predefined, preset gradients.
  -- A list of presets is shown in a section below.
  -- preset = "Warm",

  -- Specifies the interpolation style to be used.
  -- "Linear", "Basis" and "CatmullRom" as supported.
  -- The default is "Linear".
  -- interpolation = 'Linear',

  -- How the colors are blended in the gradient.
  -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
  -- The default is "Rgb".
  -- blend = 'Rgb',

  -- To avoid vertical color banding for horizontal gradients, the
  -- gradient position is randomly shifted by up to the `noise` value
  -- for each pixel.
  -- Smaller values, or 0, will make bands more prominent.
  -- The default value is 64 which gives decent looking results
  -- on a retina macbook pro display.
  -- noise = 64,

  -- By default, the gradient smoothly transitions between the colors.
  -- You can adjust the sharpness by specifying the segment_size and
  -- segment_smoothness parameters.
  -- segment_size configures how many segments are present.
  -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
  -- 1.0 is a soft edge.

  -- segment_size = 11,
  -- segment_smoothness = 0.0,
}
wezterm.on("update-right-status", function (window, _)
    local prefix = ""

    if window:leader_is_active() then
    -- prefix = " " .. utf8.char(0x1f30a) -- ocean wave
      prefix = "  "
    end

    -- if window:active_tab():tab_id() ~= 0 then
    --     ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
    -- end -- arrow color based on if tab is first pane

    window:set_left_status(wezterm.format {
        { Background = { Color = "#16161e" } },
	{ Foreground = { Color = "#9ece6a" } },
        { Text = prefix },
        -- ARROW_FOREGROUND,
        -- { Text = SOLID_LEFT_ARROW }
    })
end)

return config

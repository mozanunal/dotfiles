-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- visual arrangements
config.color_scheme = "Catppuccin Macchiato"
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 15.0
config.audible_bell = "Disabled"
return config

local wezterm = require("wezterm")
local config = wezterm.config_builder()

--- config.color_scheme = "rose-pine-moon"
-- config.color_scheme = 'AdventureTime'
config.color_scheme = "Tokyo Night"

config.window_decorations = "RESIZE"

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 14
config.window_background_opacity = 0.96

config.inactive_pane_hsb = {
	saturation = 0.85,
	brightness = 0.9,
}

config.keys = {
	{ key = "h", mods = "CMD", action = wezterm.action.SendString("\x01") }, -- for ctrl+a
	{ key = "l", mods = "CMD", action = wezterm.action.SendString("\x05") }, -- for ctrl+e
	{ key = "d", mods = "CMD", action = wezterm.action.SendString("\x15") }, -- for ctrl+u
	{ key = "h", mods = "ALT", action = wezterm.action.SendString("\x1bb") }, -- for esc+b

	-- split panes
	{ key = "l", mods = "ALT", action = wezterm.action.SendString("\x1bf") },
	{ key = ";", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "'", mods = "CMD", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- pane navs
	{ key = "h", mods = "CMD|ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CMD|ALT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CMD|ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CMD|ALT", action = wezterm.action.ActivatePaneDirection("Down") },
}

return config

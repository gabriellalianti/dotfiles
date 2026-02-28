local wezterm = require("wezterm")
local config = wezterm.config_builder()

local target = wezterm.target_triple
local hostname = wezterm.hostname()
if target:find("windows") then
	-- WSL
	config.default_prog = { "wsl.exe", "~" }
	config.font_size = 10
elseif target:find("apple") then
	-- macOS
	-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
	config.font = wezterm.font("JetBrainsMono Nerd Font")

	config.font_size = 14
	config.window_decorations = "RESIZE"
end

--- config.color_scheme = "rose-pine-moon"
-- config.color_scheme = 'AdventureTime'
config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Gruber (base16)"
-- config.color_scheme = "Gruvbox Material (Gogh)"
-- config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = "Guezwhoz"

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
	{ key = "h", mods = "CMD|ALT|CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CMD|ALT|CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CMD|ALT|CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CMD|ALT|CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
}

return config

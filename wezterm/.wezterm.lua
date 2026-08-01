local wezterm = require("wezterm")
local config = wezterm.config_builder()

local target = wezterm.target_triple
if target:find("windows") then
	config.default_prog = { "wsl.exe", "~" }
	config.font_size = 10
elseif target:find("apple") then
	config.font = wezterm.font("JetBrainsMono Nerd Font")

	config.font_size = 14
	config.window_decorations = "RESIZE"
end

-- config.color_scheme = "rose-pine-moon"
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = "Gruber (base16)"
-- config.color_scheme = "Gruvbox Material (Gogh)"
-- config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = "Guezwhoz"
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Catppuccin Frappe"
config.color_scheme = "Catppuccin Macchiato"

config.window_background_opacity = 0.96
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false

config.inactive_pane_hsb = {
	saturation = 0.85,
	brightness = 0.9,
}

config.keys = {
	-- split panes
	{ key = ";", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "'", mods = "CMD", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- pane navs
	{ key = "h", mods = "CMD|ALT|CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CMD|ALT|CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CMD|ALT|CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CMD|ALT|CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
}

config.window_padding = {
	left = 16,
	right = 6,
	top = 16,
	bottom = 0,
}

return config

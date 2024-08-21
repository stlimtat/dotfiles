local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.check_for_updates = false
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
config.color_scheme = "Gruvbox Material (Gogh)"
config.color_scheme_dirs = { "$HOME/.config/wezterm/colors" }
-- Enable the scrollbar.
-- It will occupy the right window padding space.
-- If right padding is set to 0 then it will be increased
-- to a single cell width
config.enable_scroll_bar = true
-- Do not hold on exit by default.
-- Because the default 'CloseOnCleanExit' can be annoying when exiting with
-- Ctrl-D and the last command exited with non-zero: the shell will exit
-- with non-zero and the terminal would hang until the window is closed manually.
config.exit_behavior = "Close" -- NOTE: this is now the default, remove?
config.exit_behavior_messaging = "None"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0
-- Enable various OpenType features
-- See https://docs.microsoft.com/en-us/typography/opentype/spec/featurelist
config.harfbuzz_features = {
	"zero", -- Use a slashed zero '0' (instead of dotted)
	"kern", -- (default) kerning (todo check what is really is)
	"liga", -- (default) ligatures
	"clig", -- (default) contextual ligatures
}
-- https://wezfurlong.org/wezterm/hyperlinks.html
config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.keys = {
	-- Clears only the scrollback and leaves the viewport intact.
	-- You won't see a difference in what is on screen, you just won't
	-- be able to scroll back until you've output more stuff on screen.
	-- This is the default behavior.
	-- { key = 'K', mods = 'CTRL|SHIFT', action = act.ClearScrollback('ScrollbackOnly') },
	-- Clears the scrollback and viewport leaving the prompt line the new first line.
	-- { key = 'K', mods = 'CTRL|SHIFT', action = act.ClearScrollback('ScrollbackAndViewport') },
	-- Clears the scrollback and viewport, and then sends CTRL-L to ask the
	-- shell to redraw its prompt
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = act.Multiple({
			act.ClearScrollback("ScrollbackAndViewport"),
			act.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
	{ key = "|", mods = "ALT|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "ALT|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "ALT|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "_", mods = "ALT|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
}
config.native_macos_fullscreen_mode = true
config.quit_when_all_windows_are_closed = true
-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 3500
-- Make sure word selection stops on most punctuations.
--
-- Note that dot (.) & slash (/) are allowed though for
-- easy selection of (partial) paths.
config.selection_word_boundary = " \t\n{}[]()\"'`,;:@│*"
config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
}
config.ssh_domains = {
	{
		name = "deploy",
		remote_address = "deploy",
		username = "slim",
	},
	{
		name = "omv.stlim",
		remote_address = "192.168.25.100",
		username = "st_lim",
	},
}
config.use_fancy_tab_bar = true
config.window_close_confirmation = "NeverPrompt"

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	pane:split({ direction = "Bottom" })
	pane:split({ direction = "Right" })
	window:gui_window():maximize()
end)

return config

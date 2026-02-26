local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local config = {}
local src_dir = wezterm.home_dir .. "/go/src/github.com/stlimtat"
if wezterm.config_builder then
	config = wezterm.config_builder()
end
config.audible_bell = "Disabled"
config.automatically_reload_config = true
config.check_for_updates = false
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
config.color_scheme = "Gruvbox Material (Gogh)"
config.color_scheme_dirs = { "$HOME/.config/wezterm/colors" }
config.default_cwd = src_dir
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
config.font = wezterm.font_with_fallback({
	"MesloLGS Nerd Font Mono",
	"JetBrains Mono",
})
config.font_size = 16.0
-- Enable various OpenType features
-- See https://docs.microsoft.com/en-us/typography/opentype/spec/featurelist
config.harfbuzz_features = {
	"zero", -- Use a slashed zero '0' (instead of dotted)
	"kern", -- (default) kerning (todo check what is really is)
	"liga", -- (default) ligatures
	"clig", -- (default) contextual ligatures
}
config.hide_tab_bar_if_only_one_tab = true
-- https://wezfurlong.org/wezterm/hyperlinks.html
-- config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = "\\b\\w+://\\S+[)/a-zA-Z0-9-]+",
		format = "$0",
	},
	-- make username/pr/xxx paths clickable
	-- {
	-- 	regex = "(assweet/pr/){1}([-\\w\\d\\.]+)",
	-- 	format = "https://github.com/abnormal-security/source/tree/$0",
	-- },
	-- implicit mailto link
	-- {
	--   regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
	--   format = 'mailto:$0',
	-- },
	-- make username/project paths clickable. this implies paths like the following are for github.
	-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
	-- as long as a full url hyperlink regex exists above this it should not match a full url to
	-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
	-- {
	-- 	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
	-- 	format = "https://www.github.com/$1/$3",
	-- },
	-- make task numbers clickable
	-- the first matched regex group is captured in $1.
}
config.keys = {
	-- activate pane selection mode with the default alphabet (labels are "a", "s", "d", "f" and so on)
	{ key = "8", mods = "CTRL", action = act.PaneSelect },
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
config.macos_window_background_blur = 10
config.native_macos_fullscreen_mode = true
config.pane_focus_follows_mouse = true
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
		name = "omv.stlim",
		remote_address = "192.168.25.100",
		username = "st_lim",
	},
}
config.use_dead_keys = false
config.use_fancy_tab_bar = true
config.use_ime = false
config.window_background_opacity = 0.8
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

local function wait(time)
	local duration = os.time() + time
	while os.time() < duration do
	end
end

wezterm.on("gui-startup", function(cmd)
	-- allow `wezterm start -- something` to affect what we spawn
	-- in our initial window
	local args = {}
	if cmd then
		args = cmd.args
	end

	local tab, pane, window = mux.spawn_window(cmd or {
		cwd = src_dir,
	})
	window:gui_window():maximize()
	wait(5)
	local bottom_pane = pane:split({
		cwd = src_dir,
		direction = "Bottom",
	})
	pane:activate()
end)

return config

local wezterm = require 'wezterm'
local act = wezterm.action
return {
  automatically_reload_config = false,
  check_for_updates = false,
  -- Do not hold on exit by default.
  -- Because the default 'CloseOnCleanExit' can be annoying when exiting with
  -- Ctrl-D and the last command exited with non-zero: the shell will exit
  -- with non-zero and the terminal would hang until the window is closed manually.
  exit_behavior = "Close", -- NOTE: this is now the default, remove?
  font = wezterm.font('JetBrains Mono'),
  font_size = 12.0,
  -- Enable various OpenType features
  -- See https://docs.microsoft.com/en-us/typography/opentype/spec/featurelist
  harfbuzz_features = {
    "zero", -- Use a slashed zero '0' (instead of dotted)
    "kern", -- (default) kerning (todo check what is really is)
    "liga", -- (default) ligatures
    "clig", -- (default) contextual ligatures
  },
  -- https://wezfurlong.org/wezterm/hyperlinks.html
  hyperlink_rules = {
    -- Linkify things that look like URLs and the host has a TLD name.
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },

    -- linkify email addresses
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    -- {
    --   regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
    --   format = 'mailto:$0',
    -- },

    -- file:// URI
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    -- {
    --   regex = [[\bfile://\S*\b]],
    --   format = '$0',
    -- },

    -- Linkify things that look like URLs with numeric addresses as hosts.
    -- E.g. http://127.0.0.1:8000 for a local development server,
    -- or http://192.168.1.1 for the web interface of many routers.
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = '$0',
    },

    -- Make task numbers clickable
    -- The first matched regex group is captured in $1.
    -- {
    --   regex = [[\b[tT](\d+)\b]],
    --   format = 'https://example.com/tasks/?t=$1',
    -- },

    -- Make username/project paths clickable. This implies paths like the following are for GitHub.
    -- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
    -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
    -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
    -- {
    --   regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
    --   format = 'https://www.github.com/$1/$3',
    -- },
  },
  keys = {
    -- Clears only the scrollback and leaves the viewport intact.
    -- You won't see a difference in what is on screen, you just won't
    -- be able to scroll back until you've output more stuff on screen.
    -- This is the default behavior.
    -- { key = 'K', mods = 'CTRL|SHIFT',  action = act.ClearScrollback 'ScrollbackOnly', },
    { key = 'K', mods = 'SUPER|SHIFT', action = act.ClearScrollback 'ScrollbackOnly', },
    -- Clears the scrollback and viewport leaving the prompt line the new first line.
    -- { key = 'K', mods = 'CTRL|SHIFT',  action = act.ClearScrollback 'ScrollbackAndViewport', },
    { key = 'K', mods = 'SUPER|SHIFT', action = act.ClearScrollback 'ScrollbackAndViewport', },
    -- Clears the scrollback and viewport, and then sends CTRL-L to ask the
    -- shell to redraw its prompt
    -- { key = 'K', mods = 'CTRL|SHIFT',  action = act.Multiple { act.ClearScrollback 'ScrollbackAndViewport', act.SendKey { key = 'L', mods = 'CTRL' }, }, },
    { key = 'K', mods = 'SUPER|SHIFT', action = act.Multiple { act.ClearScrollback 'ScrollbackAndViewport', act.SendKey { key = 'L', mods = 'CTRL' }, }, },
    { key = '"', mods = 'ALT|SHIFT',   action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = "'", mods = 'ALT|SHIFT',   action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = '%', mods = 'ALT|SHIFT',   action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '5', mods = 'ALT|SHIFT',   action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'X', mods = 'SUPER|SHIFT', action = act.ActivateCopyMode },
    { key = 'x', mods = 'SUPER|SHIFT', action = act.ActivateCopyMode },
  },
  -- How many lines of scrollback you want to retain per tab
  scrollback_lines = 3500,
  -- Enable the scrollbar.
  -- It will occupy the right window padding space.
  -- If right padding is set to 0 then it will be increased
  -- to a single cell width
  enable_scroll_bar = true,
  -- Make sure word selection stops on most punctuations.
  --
  -- Note that dot (.) & slash (/) are allowed though for
  -- easy selection of (partial) paths.
  selection_word_boundary = " \t\n{}[]()\"'`,;:@│*",
  window_close_confirmation = "NeverPrompt",
}

-- Additional Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 1
    end,
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = true; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
      }
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require("indent_blankline").setup {
        char = "│",
        -- let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
        filetype_exclude = { "dashboard", "markdown" },
        buftype_exclude = { "terminal", "nofile" },
        use_treesitter = true,
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
  },
  { 'rebelot/kanagawa.nvim' },
  { 'kdheepak/lazygit.nvim' },
  {
    'wfxr/minimap.vim',
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    requires = {
      -- you'll need at least one of these
      -- {'nvim-telescope/telescope.nvim'},
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require('neoclip').setup()
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,
        show_cursorline = true,
      }
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
      require("bqf").setup({})
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  { 'stlimtat/nvim-dap-python' },
  {
    'rcarriga/nvim-dap-ui',
    requires = { "mfussenegger/nvim-dap" },
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "pwntester/octo.nvim",
    event = "BufRead",
    requires = {
      'kyazdani42/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require("octo").setup({})
    end,
  },
  { 'anuvyklack/pretty-fold.nvim' },
  { 'rose-pine/neovim' },
  {
    'simrat39/symbols-outline.nvim',
    cmd = "SymbolsOutline",
  },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-telescope/telescope-frecency.nvim' },
  { 'nvim-telescope/telescope-packer.nvim' },
  {
    'nvim-telescope/telescope-project.nvim',
    event = "BufWinEnter",
    setup = function()
      vim.cmd [[packadd telescope.nvim]]
    end,
  },
  { 'nvim-telescope/telescope-smart-history.nvim' },
  { "tiagovla/tokyodark.nvim", },
  { 'folke/tokyonight.nvim' },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "rhysd/vim-grammarous" },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  { "prettier/vim-prettier" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
}

-- general
lvim.colorscheme = "tokyonight"
lvim.format_on_save = true
lvim.leader = "space"
lvim.log.level = "warn"
-- override a default keymapping
lvim.keys.normal_mode = {
  ["<C-q>"] = ":q<cr>", -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
  ["<C-s>"] = ":w<cr>",

  -- Resize with arrows
  ["<C-Up>"] = ":resize -2<cr>",
  ["<C-Down>"] = ":resize +2<cr>",
  ["<C-Left>"] = ":vertical resize -2<cr>",
  ["<C-Right>"] = ":vertical resize +2<cr>",
  -- Switch Tabs
  ["<M-Left>"] = ":tabp<cr>",
  ["<M-Right>"] = ":tabn<cr>",
}
lvim.use_icons = true

-- https://www.xudongz.com/blog/2017/vim-colemak/
vim.cmd([[
  nmap <C-f> :Ag<Space>
  nmap [q :cprevious <cr>
  nmap ]q :cnext <cr>
]])
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_style = "night"
-- unmap a default keymapping
vim.keymap.del("n", "<C-Up>")
vim.o.guifont = "JetbrainsMono Nerd Font Mono:14;FiraCode Nerd Font:14"
vim.o.sessionoptions = "curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
vim.opt.cmdheight = 1
vim.opt.relativenumber = true

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.cmp.completion.keyword_length = 3
lvim.builtin.dap.active = true
lvim.builtin.notify.active = true
lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.open_on_setup = true
lvim.builtin.nvimtree.setup.renderer.group_empty = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.sort_by = "case_sensitive"
lvim.builtin.nvimtree.setup.view.adaptive_size = true
lvim.builtin.nvimtree.setup.view.centralize_selection = true
lvim.builtin.nvimtree.setup.view.number = true
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 50
lvim.builtin.project.detection_methods = { "pattern", "lsp" }
lvim.builtin.project.patterns = {
  ".git", "package.json"
}
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "file-browser")
  pcall(telescope.load_extension, "frecency")
  -- pcall(telescope.load_extension, "fzf-native")
  pcall(telescope.load_extension, "neoclip")
  pcall(telescope.load_extension, "packer")
  pcall(telescope.load_extension, "project")
  pcall(telescope.load_extension, "smart-history")
end
lvim.builtin.terminal.active = true
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.highlight.additional_vim_regex_highlighting = true
lvim.builtin.treesitter.indent.enable = true
-- lvim.builtin.which_key.mappings["*"] = { "<cmd>Telescope grep_string<cr>", "Search string under cursor" }
lvim.builtin.which_key.mappings["b"] = {
  name = "+Buffers",
  c = { "<cmd>b#|bd#<cr>", "Close Buffer" },
  f = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in current buffer" },
  n = { "<cmd>bn<cr>", "Next Buffer" },
  N = { "<cmd>bN<cr>", "Previous Buffer" },
  o = { "<cmd>%bd|e#|bd#<cr>", "Current Buffer Only" },
  s = { "<cmd>Buffers<cr>", "Search Buffers" },
}
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>",
  "Test current Method (python)" }
lvim.builtin.which_key.mappings["dv"] = { "<cmd>lua require('dapui').toggle()<cr>", "DAP UI" }
lvim.builtin.which_key.mappings["dz"] = { "<cmd>lua require('dap-python').test_class()<cr>",
  "Test current class (python)" }
-- lvim.builtin.which_key.mappings["o"] = { "<cmd>GBrowse!<cr>", "Git Browse!" }
lvim.builtin.which_key.mappings["O"] = {
  name = "+Github (Octo)",
  c = {
    name = "+Comments",
    a = { "<cmd>Octo comment add<cr>", "Add comment to current context" },
  },
  i = {
    name = "+Issues",
    b = { "<cmd>Octo issue browser<cr>", "Open current issue in browser" },
    c = { "<cmd>Octo issue create<cr>", "Create new issue in current repo" },
    -- e = { "<cmd>Octo issue edit<Space>", "Edit issue <specify number>" },
    r = { "<cmd>Octo issue reload<cr>", "Reload current issue" },
    -- s = { "<cmd>Octo issue search<Space>", "Search issue in current repo" },
    x = { "<cmd>Octo issue close<cr>", "Close current issue" },
  },
  p = {
    name = "+Pull Requests",
    b = { "<cmd>Octo pr browser<cr>", "Open PR in browser" },
    c = { "<cmd>Octo pr create<cr>", "Create PR" },
    s = { "<cmd>Octo pr checks<cr>", "PR checks status" },
  },
  r = {
    name = "+Reviews",
    a = { "<cmd>Octo review start<cr>", "Start a new review" },
    c = { "<cmd>Octo review comments<cr>", "View pending review comments" },
    s = { "<cmd>Octo review submit<cr>", "Submit the review" },
  },
  m = { "<cmd>Octo search is:pr is:open author:assweet<cr>", "Search for my PRs" },
  t = {
    name = "+Threads",
    a = { "<cmd>Octo thread resolve<cr>", "Mark a review thread as resolved" },
  },
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Diagnostics",
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  t = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}
lvim.builtin.which_key.mappings["w"] = { "<cmd>:wa!<cr>", "Save all" }
lvim.builtin.which_key.mappings["z"] = {
  "<cmd>call fzf#vim#ag(expand('<cword>'), fzf#vim#with_preview())<cr>",
  "Search under cursor"
}

-- generic LSP settings
lvim.lsp.automatic_servers_installation = false
lvim.lsp.installer.setup.ensure_installed = {
  "sumeko_lua",
  "jsonls",
}

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "gofmt", filetypes = { "go" } },
  { command = "isort", filetypes = { "python" } },
  {
    command = "prettier",
    extra_args = { "--print-with", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "pylint", filetypes = { "python" } },
  { command = "flake8", filetypes = { "python" } },
  {
    command = "shellcheck",
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    filetypes = { "javascript", "python" },
  },
}


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
local status_ok, user_dap = pcall(require, "user.dap")
if not status_ok then
  return
end
user_dap.setup()
local user_dapui
status_ok, user_dapui = pcall(require, "user.dapui")
if not status_ok then
  return
end
user_dapui.setup()

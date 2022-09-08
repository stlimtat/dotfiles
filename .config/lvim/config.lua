-- Additional Plugins
lvim.plugins = {
  { 'skywind3000/asyncrun.vim' },
  { 'skywind3000/asynctasks.vim' },
  { "lunarvim/colorschemes" },
  { 'tpope/vim-dadbod' },
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
      vim.g.gitblame_date_format = "%c"
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    event = "BufRead",
    config = function()
      require("gitlinker").setup {
        opts = {
          -- remote = 'github', -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = require("gitlinker.actions").open_in_browser,
          -- print the url after performing the action
          print_url = false,
          -- mapping to call url generation
          mappings = "<leader>gy",
        },
      }
    end,
    requires = "nvim-lua/plenary.nvim",
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
    "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".on_attach()
    end,
  },
  {
    'wfxr/minimap.vim',
    run = "cargo install --locked code-minimap",
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    config = function()
      vim.cmd([[
        let g:minimap_auto_start = 1
        let g:minimap_auto_start_win_enter = 1
        let g:minimap_enable_highlight_colorgroup = 1
        let g:minimap_width = 20
        highlight minimapCursor ctermbg=59 ctermfg=228 guibg=#5F5F5F guifg=#FFFF87
        highlight minimapDiffLine ctermbg=59 ctermfg=228 guibg=#5F5F5F guifg=#FFFF87
        highlight minimapRange ctermbg=242 ctermfg=228 guibg=#4F4F4F guifg=#FFFF87
        ]])
    end,
  },
  -- {
  --   "nvim-neotest/neotest",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "antoinemadec/FixCursorHold.nvim"
  --   },
  -- },
  -- { 'nvim-neotest/neotest-go' },
  -- { 'nvim-neotest/neotest-python' },
  -- { 'nvim-neotest/neotest-vim-test' },
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
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
        },
        func_map = {
          vsplit = "",
          ptogglemode = "z,",
          stoggleup = "",
        },
        filter = {
          fzf = {
            action_for = { ["ctrl-s"] = "split" },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
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
  -- {
  --   'theHamsta/nvim-dap-virtual-text',
  --   config = function()
  --     require("nvim-dap-virtual-text").setup()
  --   end,
  --   requires = { "mfussenegger/nvim-dap" },
  -- },
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require("hlslens").setup({
        auto_enable = true,
        calm_down = true,
        enable_incsearch = false,
      })
    end
  },
  {
    "AckslD/nvim-neoclip.lua",
    requires = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('neoclip').setup()
    end,
  },
  { "ishan9299/nvim-solarized-lua" },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  { "p00f/nvim-ts-rainbow" },
  {
    "pwntester/octo.nvim",
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
  },
  -- { "lunarvim/onedarker.nvim" },
  {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require('refactoring').setup({
        prompt_func_return_type = {
          go = true,
          python = true,

          c = false,
          cpp = false,
          cxx = false,
          h = false,
          hpp = false,
          java = false,
        },
        prompt_func_param_type = {
          go = true,
          python = true,

          c = false,
          cpp = false,
          cxx = false,
          h = false,
          hpp = false,
          java = false,
        },
        printf_statements = {},
        print_var_statements = {},
      })
    end,
  },
  { 'rose-pine/neovim' },
  {
    'simrat39/symbols-outline.nvim',
    cmd = "SymbolsOutline",
    config = function()
      require('symbols-outline').setup()
    end
  },
  { 'kelly-lin/telescope-ag' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'nvim-telescope/telescope-frecency.nvim' },
  { 'nvim-telescope/telescope-live-grep-args.nvim' },
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
  { 'kristijanhusak/vim-dadbod-completion' },
  { 'kristijanhusak/vim-dadbod-ui' },
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
  { "rhysd/vim-grammarous" },
  { 'mtdl9/vim-log-highlighting' },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  -- { "prettier/vim-prettier" },
  -- { "tpope/vim-rhubarb" },
  -- { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  -- { 'vim-test/vim-test' },
  {
    "s1n7ax/nvim-window-picker",
    tag = "1.*",
    config = function()
      require("window-picker").setup({
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal" },
          },
        },
        other_win_hl_color = "#e35e4f",
      })
    end,
  },
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.cmp.completion.keyword_length = 2
lvim.builtin.dap.active = false
lvim.builtin.notify.active = true
lvim.builtin.nvimtree.setup.disable_netrw = false
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
  pcall(telescope.load_extension, "ag")
  pcall(telescope.load_extension, "file-browser")
  pcall(telescope.load_extension, "frecency")
  pcall(telescope.load_extension, "live-grep-args")
  pcall(telescope.load_extension, "neoclip")
  pcall(telescope.load_extension, "packer")
  pcall(telescope.load_extension, "project")
  pcall(telescope.load_extension, "refactoring")
  pcall(telescope.load_extension, "smart-history")
end
lvim.builtin.terminal.active = true
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "css",
  "javascript",
  "json",
  "go",
  "lua",
  "python",
  "typescript",
  "tsx",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell", "pyright" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.highlight.additional_vim_regex_highlighting = true
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.indent.enable = false
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.textobjects.select.enable = true
lvim.builtin.treesitter.textobjects.swap.enable = true
lvim.builtin.treesitter.textsubjects.enable = true
lvim.builtin.treesitter.textsubjects.keymaps["."] = "textsubjects-smart"
lvim.builtin.treesitter.textsubjects.keymaps[";"] = "textsubjects-big"
-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>",
  "Test current Method (python)" }
lvim.builtin.which_key.mappings["dv"] = { "<cmd>lua require('dapui').toggle()<cr>", "DAP UI" }
lvim.builtin.which_key.mappings["dz"] = { "<cmd>lua require('dap-python').test_class()<cr>",
  "Test current class (python)" }
lvim.builtin.which_key.mappings["O"] = {
  name = "+Github (Octo)",
  m = { "<cmd>Octo search is:pr is:open author:assweet<cr>", "Search for my PRs" },
}
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["sw"] = { "<cmd>Telescope grep_string<cr>", "Search string under cursor" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
lvim.builtin.which_key.mappings["z"] = {
  "<cmd>call fzf#vim#ag(expand('<cword>'), fzf#vim#with_preview())<cr>",
  "Search under cursor"
}
lvim.colorscheme = "tokyonight"
lvim.format_on_save = true
-- keymappings [view all the defaults by pressing <leader>Lk]
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- override a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
lvim.leader = "space"
lvim.line_wrap_cursor_movement = true
lvim.lint_on_save = true
lvim.log.level = "warn"
-- generic LSP settings
---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.installer.setup.ensure_installed = {
  "sumeko_lua",
  "jsonls",
}
lvim.use_icons = true

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
vim.api.nvim_create_autocmd({ "BufAdd", "BufNewFile", "BufRead" }, {
  command = "tab sball",
  nested = true,
  pattern = "*",
})
vim.cmd([[
  nmap <C-f> :Ag<Space>
  nmap [q :cprevious <cr>
  nmap ]q :cnext <cr>
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal tabstop=2
]])
vim.g["test#python#runner"] = 'pytest'
vim.g.solarized_italics = 1
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_style = "night"
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "99999"
vim.opt.expandtab = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldlevel = 999
vim.opt.foldmethod = 'expr'
vim.opt.guifont = "JetbrainsMono Nerd Font Mono:14;FiraCode Nerd Font:14"
vim.opt.relativenumber = true
vim.opt.sessionoptions = "curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
-- require("lvim.lsp.manager").setup("pyright", {
--   settings = {
--     pyright = {
--       disableLanguageServices = false,
--       disableOrganizeImports = false,
--     },
--     python = {
--       analysis = {
--         autoImportCompletions = true,
--         autoSearchPaths = true,
--         diagnosticMode = "workspace",
--         exclude = {
--           "**/__pycache__",
--         },
--         extraPaths = {
--           os.getenv("PYENV_VIRTUAL_ENV") .. "/lib/python3.8/site-packages",
--           os.getenv('HOME') .. '/source/src/py',
--           os.getenv('HOME') .. '/source/src/pytests',
--           os.getenv('HOME') .. '/source/src/pytests/abnormal/test',
--         },
--         useLibraryCodeForTypes = true,
--       },
--     },
--   },
-- })
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
local user_lualine
status_ok, user_lualine = pcall(require, "user.lualine")
if not status_ok then
  return
end
user_lualine.config()
-- local user_null_ls
-- status_ok, user_null_ls = pcall(require, "user.null_ls")
-- if not status_ok then
--   return
-- end
-- user_null_ls.config()

-- octo
require("octo").setup({
  mappings = {}
})
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.markdown.filetype_to_parsername = "octo"

-- example mappings you can place in some other place
-- An awesome method to jump to windows
local picker = require('window-picker')

vim.keymap.set("n", ",w", function()
  local picked_window_id = picker.pick_window({
    include_current_win = true
  }) or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- Swap two windows using the awesome window picker
local function swap_windows()
  local window = picker.pick_window({
    include_current_win = false
  })
  local target_buffer = vim.fn.winbufnr(window)
  -- Set the target window to contain current buffer
  vim.api.nvim_win_set_buf(window, 0)
  -- Set current window to contain target buffer
  vim.api.nvim_win_set_buf(0, target_buffer)
end

vim.keymap.set('n', ',W', swap_windows, { desc = 'Swap windows' })

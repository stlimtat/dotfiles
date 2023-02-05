-- Additional Plugins
lvim.plugins = {
  -- { "skywind3000/asyncrun.vim" },
  -- { "skywind3000/asynctasks.vim" },
  { "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  { "hrsh7th/cmp-cmdline" },
  { "lunarvim/colorschemes" },
  { "sindrets/diffview.nvim",
    event = "BufRead",
  },
  -- { "junegunn/fzf" },
  -- { "junegunn/fzf.vim" },
  -- { "f-person/git-blame.nvim",
  --   event = "BufRead",
  --   config = function()
  --     vim.cmd "highlight default link gitblame SpecialComment"
  --     vim.g.gitblame_enabled = 1
  --     vim.g.gitblame_date_format = "%c"
  --   end,
  -- },
  { "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup({
        default_mappings = true, -- disable buffer local mapping created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = 'DiffText',
          current = 'DiffAdd',
        }
      })
    end,
    tag = "*",
  },
  { "ruifm/gitlinker.nvim",
    event = "BufRead",
    config = function()
      require("gitlinker").setup {
        opts = {
          -- remote = "github", -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = function(url)
            require("gitlinker.actions").copy_to_clipboard(url)
            -- require("gitlinker.actions").open_in_browser(url)
          end,
          -- print the url after performing the action
          print_url = true,
          -- mapping to call url generation
          mappings = "<leader>gy",
        },
      }
    end,
    requires = { { "nvim-lua/plenary.nvim" } },
  },
  -- { "brneor/gitui.nvim" },
  { "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = true; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
      }
    end
  },
  { "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
    -- cmd = { "HopChar1", "HopChar2", "HopLine", "HopPattern", "HopWord" },
  },
  { "rebelot/kanagawa.nvim" },
  { "kdheepak/lazygit.nvim" },
  { "ahmedkhalf/lsp-rooter.nvim",
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
    end,
  },
  { "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".on_attach()
    end,
  },
  -- { "nvim-neotest/neotest",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "antoinemadec/FixCursorHold.nvim",
  --   },
  -- },
  -- { "nvim-neotest/neotest-go" },
  -- { "nvim-neotest/neotest-python" },
  -- { "nvim-neotest/neotest-vim-test" },
  { "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true,
        show_cursorline = true,
      }
    end,
  },
  { "kevinhwang91/nvim-bqf",
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
  { "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "css", "scss", "html", "javascript"
      }, {
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
  { "stlimtat/nvim-dap-python" },
  -- { "rcarriga/nvim-dap-ui",
  --   requires = { { "mfussenegger/nvim-dap" } },
  -- },
  { "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
    requires = { { "mfussenegger/nvim-dap" } },
  },
  { "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup({
        auto_enable = true,
        calm_down = true,
        enable_incsearch = false,
      })
    end
  },
  { "AckslD/nvim-neoclip.lua",
    requires = { { "nvim-telescope/telescope.nvim" } },
    config = function()
      require("neoclip").setup()
    end,
  },
  ["ishan9299/nvim-solarized-lua"] = { disable = true },
  { "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  { "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the "default" entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            "class",
            "function",
            "method",
          },
        },
      }
    end
  },
  { "p00f/nvim-ts-rainbow" },
  { "s1n7ax/nvim-window-picker",
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
  { "pwntester/octo.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "kyazdani42/nvim-web-devicons" },
    },
  },
  -- { "lunarvim/onedarker.nvim" },
  { "ThePrimeagen/refactoring.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("refactoring").setup({
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
  { "simrat39/symbols-outline.nvim",
    -- cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup()
    end
  },
  { "ziontee113/syntax-tree-surfer" },
  { "kelly-lin/telescope-ag",
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  { "nvim-telescope/telescope-file-browser.nvim",
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  { "nvim-telescope/telescope-frecency.nvim",
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  { "nvim-telescope/telescope-hop.nvim",
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  { "nvim-telescope/telescope-live-grep-args.nvim",
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  { "nvim-telescope/telescope-packer.nvim",
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  { "nvim-telescope/telescope-smart-history.nvim",
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  { "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-completion" },
  { "kristijanhusak/vim-dadbod-ui" },
  -- { "tpope/vim-fugitive",
  --   cmd = {
  --     "G",
  --     "Git",
  --     "Gdiffsplit",
  --     "Gread",
  --     "Gwrite",
  --     "Ggrep",
  --     "GMove",
  --     "GDelete",
  --     "GBrowse",
  --     "GRemove",
  --     "GRename",
  --     "Glgrep",
  --     "Gedit"
  --   },
  --   ft = { "fugitive" }
  -- },
  { "rhysd/vim-grammarous" },
  { "mtdl9/vim-log-highlighting" },
  { "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  -- { "prettier/vim-prettier" },
  -- { "tpope/vim-rhubarb" },
  -- { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  -- { "vim-test/vim-test" },
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.bufferline.options.numbers = 'buffer_id'
lvim.builtin.cmp.completion.keyword_length = 2
lvim.builtin.dap.active = true
lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.indentlines.options = {
  buftype_exclude = { "terminal", "nofile" },
  char = "▏",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
  filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "markdown",
    "Trouble",
    "text",
  },
  show_first_indent_level = true,
  show_trailing_blankline_indent = false,
  space_char_blankline = " ",
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = true,
}
-- lvim.builtin.lualine.options.theme = "powerline_dark"
lvim.builtin.luasnip.sources.friendly_snippets = true
-- lvim.builtin.notify.active = true
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
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "%.cache",
  "%.class",
  "%.dll",
  "%.docx",
  "%.dylib",
  "%.exe",
  "%.ico",
  "%.ipynb",
  "%.jar",
  "%.jpg",
  "%.jpeg",
  "%.lock",
  "%.met",
  "%.pdb",
  "%.pdf",
  "%.png",
  "%.sqlite3",
  "%.svg",
  "%.otf",
  "%.ttf",
  "%.webp",
  "__pycache__/",
  "__pycache__/*",
  ".dart_tool/",
  ".git/",
  ".github/",
  ".gradle/",
  ".idea/",
  ".settings/",
  ".vale/",
  ".vscode/",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "node_modules/*",
  "smalljre_*/*",
  "target/",
  "vendor/*",
}
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
  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "hop")
  pcall(telescope.load_extension, "lazygit")
  pcall(telescope.load_extension, "live-grep-args")
  pcall(telescope.load_extension, "neoclip")
  pcall(telescope.load_extension, "octo")
  pcall(telescope.load_extension, "packer")
  pcall(telescope.load_extension, "project")
  pcall(telescope.load_extension, "refactoring")
  pcall(telescope.load_extension, "smart-history")
end
lvim.builtin.terminal.active = true
lvim.builtin.theme.options.dim_inactive = true
lvim.builtin.theme.options.style = "storm"
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
lvim.builtin.treesitter.ignore_install = { "haskell" }
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
-- which_key -- insert_mode
-- lvim.builtin.which_key.imappings["<C-d>"] = {
--   d = { "<c-r>=strftime('%F %T%z')<cr>", "d/m/Y H:M:S z" },
--   f = { "<c-r>=strftime('%B %d, %Y')<cr>", "B d, Y" },
--   F = { "<c-r>=strftime('%T')<cr>", "H:M:S" },
--   n = { "<c-r>=strftime('%F')<cr>", "d-m-Y" },
--   x = { "<c-r>=strftime('%d/%m/%y')<cr>", "d/m/y" },
--   X = { "<c-r>=strftime('%H:%M')<cr>", "H:M" },
-- }
-- which_key -- normal_mode
lvim.builtin.which_key.mappings["dB"] = { "<cmd>lua require('dap').clear_breakpoints()<cr>",
  "Clear Breakpoints" }
lvim.builtin.which_key.mappings["dQ"] = { "<cmd>lua require('dap').terminate()<cr>",
  "Terminate" }
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dv"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle Debugger UI" }
lvim.builtin.which_key.mappings["dz"] = { "<cmd>lua require('dap-python').test_class()<cr>",
  "Test current class (python)" }
lvim.builtin.which_key.mappings["gh"] = {
  name = "+gitHub",
  ["<cr>"] = { "<cmd>Octo search is:pr is:open author:assweet<cr>", "PRs: assweet open" },
  c = { "<cmd>Octo search is:pr is:closed author:assweet<cr>", "PRs: assweet closed" },
}
lvim.builtin.which_key.mappings["h"] = {
  name = "Hop",
  c = { "<cmd>HopChar1<cr>", "Character" },
  C = { "<cmd>HopChar2<cr>", "2 Characters" },
  l = { "<cmd>HopLine<cr>", "Line" },
  p = { "<cmd>HopPattern<cr>", "Pattern" },
  s = { "<cmd>STSSelectMasterNode<cr>", "Surf" },
  S = { "<cmd>STSSelectCurrentNode<cr>", "Surf Node" },
  w = { "<cmd>HopWord<cr>", "Word" },
}
lvim.builtin.which_key.mappings["j"] = { "<cmd>BufferLinePick <cr>", "Jump to Buffer" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings["sw"] = { "<cmd>Telescope grep_string<cr>", "Search string under cursor" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
  f = { "<cmd>TroubleToggle lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "QuickFix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "LocationList" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
-- which_key - visual_mode
lvim.builtin.which_key.vmappings["h"] = {
  name = "Hop",
  c = { "<cmd>HopChar1<cr>", "Character" },
  C = { "<cmd>HopChar2<cr>", "2 Characters" },
  l = { "<cmd>HopLine<cr>", "Line" },
  p = { "<cmd>HopPattern<cr>", "Pattern" },
  w = { "<cmd>HopWord<cr>", "Word" },
}
lvim.builtin.which_key.vmappings["sf"] = { "<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>",
  "Refactoring" }
-- which_key - g keys
-- local which_key = require("which-key")
-- wk_opts = {
--   mode = "n", -- NORMAL mode
--   prefix = nil,
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
-- }
-- which_key.register({
--   g = {
--     t = {
--       name = "Treesitter",
--       v = {
--         function() require("syntax-tree-surfer").targeted_jump { "variable_declaration" } end,
--         "Go to Variables",
--       },
--       f = {
--         function() require("syntax-tree-surfer").targeted_jump { "function" } end,
--         "Go to Functions",
--       },
--       i = {
--         function()
--           require("syntax-tree-surfer").targeted_jump {
--             "if_statement",
--             "else_clause",
--             "else_statement",
--             "elseif_statement",
--           }
--         end,
--         "Go to If Statements",
--       },
--       r = {
--         function() require("syntax-tree-surfer").targeted_jump { "for_statement" } end,
--         "Go to If Statements",
--       },
--       w = {
--         function() require("syntax-tree-surfer").targeted_jump { "white_statement" } end,
--         "Go to While Statements",
--       },
--       s = {
--         function() require("syntax-tree-surfer").targeted_jump { "switch_statement" } end,
--         "Go to Switch Statements",
--       },
--       t = {
--         function()
--           require("syntax-tree-surfer").targeted_jump {
--             "function",
--             "if_statement",
--             "else_clause",
--             "else_statement",
--             "elseif_statement",
--             "for_statement",
--             "while_statement",
--             "switch_statement",
--           }
--         end,
--         "Go to Statement",
--       },
--     },
--   },
-- }, wk_opts)
lvim.colorscheme = "tokyonight"
lvim.format_on_save = true
-- keymappings [view all the defaults by pressing <leader>Lk]
-- keymapping - navigation
lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<cr>"
-- keymapping - easy splits
lvim.keys.normal_mode["\\"] = ":split<cr>"
lvim.keys.normal_mode["|"] = ":vsplit<cr>"
-- keymapping - Treesitter Surfer
lvim.keys.normal_mode["<C-down>"] = ":STSSwapDownNormal<cr>" -- Swap next tree-sitter object
lvim.keys.normal_mode["<C-right>"] = ":STSSwapDownNormal<cr>" -- Swap next tree-sitter object
lvim.keys.normal_mode["<C-up>"] = ":STSSwapUpNormal<cr>" -- Swap previous tree-sitter object
lvim.keys.normal_mode["<C-left>"] = ":STSSwapUpNormal<cr>" -- Swap previous tree-sitter object
-- keymapping - Git Conflict
lvim.keys.normal_mode["Cc"] = "<Plug>(git-conflict-ours)" -- Take Current
lvim.keys.normal_mode["Ci"] = "<Plug>(git-conflict-theirs)" -- Take Incoming
lvim.keys.normal_mode["Cb"] = "<Plug>(git-conflict-both)" -- Take Both
lvim.keys.normal_mode["C0"] = "<Plug>(git-conflict-none)" -- Take None
lvim.keys.normal_mode["Cr"] = ":GitConflictRefresh<cr>" -- Refresh Conflicts
lvim.keys.normal_mode["Cl"] = ":GitConflictListQf<cr>" -- List Conflicts
lvim.keys.normal_mode["]C"] = "<Plug>(git-conflict-next-conflict)" -- Next conflict
lvim.keys.normal_mode["[C"] = "<Plug>(git-conflict-prev-conflict)" -- Previous conflict
-- keymapping - visual_block_mode - Treesitter Surfer
lvim.keys.visual_block_mode["J"] = ":STSSelectNextSiblingNode<cr>" -- Surf next treesitter object
lvim.keys.visual_block_mode["K"] = ":STSSelectPrevSiblingNode<cr>" -- Surf previous tree-sitter object
lvim.keys.visual_block_mode["H"] = ":STSSelectParentNode<cr>" -- Surf parent tree-sitter object
lvim.keys.visual_block_mode["L"] = ":STSSelectChildNode<cr>" -- Surf child tree-sitter object
lvim.keys.visual_block_mode["<c-j>"] = ":STSSwapNextVisual<cr>" -- Surf next tree-sitter object
lvim.keys.visual_block_mode["<c-l>"] = ":STSSwapNextVisual<cr>" -- Surf next tree-sitter object
lvim.keys.visual_block_mode["<c-k>"] = ":STSSwapPrevVisual<cr>" -- Surf previous tree-sitter object
lvim.keys.visual_block_mode["<c-h>"] = ":STSSwapPrevVisual<cr>" -- Surf previous tree-sitter object
-- end - keymapping
lvim.leader = "space"
lvim.line_wrap_cursor_movement = true
lvim.lint_on_save = true
lvim.log.level = "warn"
-- generic LSP settings
---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.installer.setup.ensure_installed = {
  "jsonls",
  "sumneko_lua",
}
lvim.use_icons = true

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  command = "setlocal wrap shiftwidth=2 softtabstop=2 tabstop=2",
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.py" },
  command = "setlocal wrap shiftwidth=2 softtabstop=2 tabstop=2",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
-- vim.api.nvim_create_autocmd({ "BufAdd", "BufNewFile", "BufRead" }, {
--   command = "tab sball",
--   nested = true,
--   pattern = "*",
-- })
vim.api.nvim_create_autocmd('User', {
  pattern = 'GitConflictDetected',
  callback = function()
    vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
    vim.keymap.set('n', 'cww', function()
      engage.conflict_buster()
      create_buffer_local_mappings()
    end)
  end
})
vim.cmd([[
  let g:indent_blankline_char_list = ["|", "¦", "┆", "┊"]
  nmap <C-f> :Ag<Space>
  nmap [q :cprevious <cr>
  nmap ]q :cnext <cr>
]])
local colors = require("tokyonight.colors").setup()
vim.cmd("highlight ColorColumn guibg=" .. colors.magenta .. " gui=nocombine")
vim.cmd("highlight WinSeparator guibg=" .. colors.blue .. " gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent1 guifg=" .. colors.red .. " gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent2 guifg=" .. colors.orange .. " gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent3 guifg=" .. colors.yellow .. " gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent4 guifg=" .. colors.green .. " gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent5 guifg=" .. colors.blue .. " gui=nocombine")
vim.cmd("highlight IndentBlanklineIndent6 guifg=" .. colors.magenta .. " gui=nocombine")
vim.g["test#python#runner"] = 'pytest'
vim.g.solarized_italics = 1
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_style = "storm"
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "80"
vim.opt.conceallevel = 2
vim.opt.expandtab = true
vim.opt.foldenable = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = 'expr'
vim.opt.guifont = "JetbrainsMono Nerd Font Mono:14;FiraCode Nerd Font:14"
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" }
vim.opt.relativenumber = true
vim.opt.sessionoptions = "curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = false
vim.opt.wrap = true
require("lvim.lsp.manager").setup("pyright", {
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        exclude = {
          "**/__pycache__",
        },
        extraPaths = {
          os.getenv("VENV") .. "/lib/python3.8/site-packages",
          os.getenv('SOURCE') .. '/src/py',
          os.getenv('SOURCE') .. '/src/pytests',
          os.getenv('SOURCE') .. '/src/pytests/abnormal/test',
        },
        useLibraryCodeForTypes = true,
      },
    },
  },
})
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- {
  --   command = "black",
  --   args = { "--stdin-filename", "$FILENAME", "--verbose", "%:p" },
  --   filetypes = { "python" },
  -- },
  {
    command = "isort",
    args = { "--stdout", "--filename", "$FILENAME", "-" },
    filetypes = { "python" }
  },
  {
    command = "prettier",
    args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8" },
  {
    command = "pylint",
    args = {
      "--rcfile",
      os.getenv("SOURCE") .. "/.pylintrc",
      "--init-hook",
      "import sys;" ..
          "sys.path.append(\"" .. os.getenv("VENV") .. "/lib/python3.8/site-packages\");" ..
          "sys.path.append(\"" .. os.getenv("SOURCE") .. "/src/py\");" ..
          "sys.path.append(\"" .. os.getenv("SOURCE") .. "/src/pytests\");" ..
          "sys.path.append(\"" .. os.getenv("SOURCE") .. "/src/pytests/abnormal/test\");",
    },
    filetypes = { "python" },
  },
  {
    command = "shellcheck",
    args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    filetypes = { "javascript", "python" },
  },
}
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    command = "proselint"
  },
}
local status_ok, user_dap = pcall(require, "user.dap")
if not status_ok then return end
user_dap.setup()
status_ok, user_dapui = pcall(require, "user.dapui")
if not status_ok then return end
user_dapui.setup()
status_ok, user_lualine = pcall(require, "user.lualine")
if not status_ok then return end
user_lualine.config()
-- local user_null_ls
-- status_ok, user_null_ls = pcall(require, "user.null_ls")
-- if not status_ok then return end
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

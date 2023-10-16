-- Additional Plugins
return {
  ["skywind3000/asyncrun.vim"] = {},
  ["skywind3000/asynctasks.vim"] = {},
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  -- ["hrsh7th/cmp-cmdline"] = {
  --   requires = { { "hrsh7th/nvim-cmp" } },
  -- },
  ["lunarvim/colorschemes"] = {},
  ["sindrets/diffview.nvim"] = {
    event = "BufRead",
  },
  ["junegunn/fzf"] = {},
  ["junegunn/fzf.vim"] = {},
  -- ["f-person/git-blame.nvim"] = {
  --   event = "BufRead",
  --   config = function()
  --     vim.cmd "highlight default link gitblame SpecialComment"
  --     vim.g.gitblame_enabled = 1
  --     vim.g.gitblame_date_format = "%c"
  --   end,
  -- },
  ["akinsho/git-conflict.nvim"] = {
    config = function()
      require("git-conflict").setup({
        default_mappings = true, -- disable buffer local mapping created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = "DiffText",
          current = "DiffAdd",
        },
      })
    end,
    tag = "*",
  },
  ["ruifm/gitlinker.nvim"] = {
    event = "BufRead",
    config = function()
      require("gitlinker").setup({
        opts = {
          -- remote = "github", -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = function(url)
            require("gitlinker.actions").copy_to_clipboard(url)
            require("gitlinker.actions").open_in_browser(url)
          end,
          -- print the url after performing the action
          print_url = true,
          -- mapping to call url generation
          mappings = "<leader>gy",
        },
      })
    end,
    requires = { { "nvim-lua/plenary.nvim" } },
  },
  -- ["rmagatti/goto-preview"] = {
  --   config = function()
  --     require("goto-preview").setup {
  --       width = 120; -- Width of the floating window
  --       height = 25; -- Height of the floating window
  --       default_mappings = true; -- Bind default mappings
  --       debug = false; -- Print debug information
  --       opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
  --       post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
  --     }
  --   end
  -- },
  ["phaazon/hop.nvim"] = {
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
    -- cmd = { "HopChar1", "HopChar2", "HopLine", "HopPattern", "HopWord" },
  },
  ["rebelot/kanagawa.nvim"] = {},
  ["kdheepak/lazygit.nvim"] = {},
  ["ahmedkhalf/lsp-rooter.nvim"] = {
    event = "BufRead",
    config = function()
      require("lsp-rooter").setup()
    end,
  },
  ["ray-x/lsp_signature.nvim"] = {
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end,
  },
  ["folke/lua-dev.nvim"] = {},
  ["nvim-lualine/lualine.nvim"] = {
    config = function()
      require("lualine").setup()
    end,
    requires = { { "kyazdani42/nvim-web-devicons" } },
  },
  ["nacro90/numb.nvim"] = {
    event = "BufRead",
    config = function()
      require("numb").setup({
        show_numbers = true,
        show_cursorline = true,
      })
    end,
  },
  ["kevinhwang91/nvim-bqf"] = {
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
  ["mfussenegger/nvim-dap"] = {},
  ["stlimtat/nvim-dap-python"] = {},
  ["rcarriga/nvim-dap-ui"] = {
    requires = { { "mfussenegger/nvim-dap" } },
  },
  ["theHamsta/nvim-dap-virtual-text"] = {
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
    requires = { { "mfussenegger/nvim-dap" } },
  },
  ["kevinhwang91/nvim-hlslens"] = {
    config = function()
      require("hlslens").setup({
        auto_enable = true,
        calm_down = true,
        enable_incsearch = false,
      })
    end,
  },
  ["SmiteshP/nvim-navic"] = {
    config = function()
      require("user.breadcrumbs").setup()
    end,
    requires = { { "neovim/nvim-lspconfig" } },
  },
  ["AckslD/nvim-neoclip.lua"] = {
    requires = { { "nvim-telescope/telescope.nvim" } },
    config = function()
      require("neoclip").setup()
    end,
  },
  ["ishan9299/nvim-solarized-lua"] = { disable = true },
  ["windwp/nvim-spectre"] = {
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  ["p00f/nvim-ts-rainbow"] = {},
  ["s1n7ax/nvim-window-picker"] = {
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
  ["pwntester/octo.nvim"] = {
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "kyazdani42/nvim-web-devicons" },
    },
  },
  -- ["lunarvim/onedarker.nvim"] = {},
  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },
        show_hidden = false,
        silent_chdir = true,
        ignore_lsp = {},
        datapath = vim.call("stdpath", "cache"),
      })
    end,
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  ["ThePrimeagen/refactoring.nvim"] = {
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
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
  ["simrat39/symbols-outline.nvim"] = {
    cmd = "SymbolsOutline",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  ["ziontee113/syntax-tree-surfer"] = {},
  ["kelly-lin/telescope-ag"] = {
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  ["nvim-telescope/telescope-file-browser.nvim"] = {
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  ["nvim-telescope/telescope-frecency.nvim"] = {
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  ["nvim-telescope/telescope-hop.nvim"] = {
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  ["nvim-telescope/telescope-live-grep-args.nvim"] = {
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  ["nvim-telescope/telescope-packer.nvim"] = {
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  ["nvim-telescope/telescope-smart-history.nvim"] = {
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  ["folke/tokyonight.nvim"] = {},
  ["folke/trouble.nvim"] = {
    cmd = "TroubleToggle",
  },
  ["tpope/vim-dadbod"] = {},
  ["kristijanhusak/vim-dadbod-completion"] = {},
  ["kristijanhusak/vim-dadbod-ui"] = {},
  ["rhysd/vim-grammarous"] = {},
  ["mtdl9/vim-log-highlighting"] = {},
  ["andymass/vim-matchup"] = {
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
}

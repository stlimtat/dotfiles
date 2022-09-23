return {
  n = {
    ["<leader>"] = {
      ["C"] = { "<cmd>bdelete<cr>", "Close Buffer" },
      ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
      ["H"] = { "<cmd>set hlsearch!<cr>", "Toggle Highlight" },
      ["."] = { "<cmd>cd %:p:h<cr>", "Set CWD" },
       b = {
          name = "Buffers",
          b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
          D = {
            "<cmd>BufferLineSortByDirectory<cr>",
            "Sort by directory",
          },
          e = {
            "<cmd>BufferLinePickClose<cr>",
            "Pick which buffer to close",
          },
          f = { "<cmd>Telescope buffers<cr>", "Find" },
          j = { "<cmd>BufferLinePick<cr>", "Jump" },
          h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
          l = {
            "<cmd>BufferLineCloseRight<cr>",
            "Close all to the right",
          },
          L = {
            "<cmd>BufferLineSortByExtension<cr>",
            "Sort by language",
          },
          n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
          -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
        },
        d = {
          name = "Debugger",
          b = { function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
          B = { function() require("dap").clear_breakpoints() end, "Clear Breakpoints" },
          c = { function() require("dap").continue() end, "Continue" },
          c = { function() require('dap-python').test_class() end, "Test Class" },
          i = { function() require("dap").step_into() end, "Step Into" },
          l = { function() require("dapui").float_element "breakpoints" end, "List Breakpoints" },
          m = { function() require('dap-python').test_method() end, "Test Method" },
          o = { function() require("dap").step_over() end, "Step Over" },
          q = { function() require("dap").close() end, "Close Session" },
          Q = { function() require("dap").terminate() end, "Terminate" },
          r = { function() require("dap").repl.toggle() end, "REPL" },
          s = { function() require("dapui").float_element "scopes" end, "Scopes" },
          t = { function() require("dapui").float_element "stacks" end, "Threads" },
          u = { function() require("dapui").toggle() end, "Toggle Debugger UI" },
          w = { function() require("dapui").float_element "watches" end, "Watches" },
          x = { function() require("dap.ui.widgets").hover() end, "Inspect" },
        },
        g = {
          name = "Git",
          b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
          c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
          C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)",
          },
          d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Git Diff",
          },
          h = {
            name = "+gitHub",
            ["<cr>"] = { "<cmd>Octo search is:pr is:open author:assweet<cr>", "PRs: assweet open" },
            c = { "<cmd>Octo search is:pr is:closed author:assweet<cr>", "PRs: assweet closed" },
          },
          j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
          k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
          l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
          p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
          r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
          R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
          s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
          u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
          },
          o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        },
        h = {
          name = "Hop",
          c = { "<cmd>HopChar1<cr>", "Character" },
          C = { "<cmd>HopChar2<cr>", "2 Characters" },
          l = { "<cmd>HopLine<cr>", "Line" },
          p = { "<cmd>HopPattern<cr>", "Pattern" },
          s = { "<cmd>STSSelectMasterNode<cr>", "Surf" },
          S = { "<cmd>STSSelectCurrentNode<cr>", "Surf Node" },
          w = { "<cmd>HopWord<cr>", "Word" },
        },
        s = {
          name = "Telescope",
          ["?"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
          ["'"] = { "<cmd>Telescope marks<cr>", "Marks" },
          c = { "<cmd>Telescope colorscheme<cr>", "Themes" },
          C = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
          e = { "<cmd>Telescope file_browser<cr>", "Explorer" },
          f = { "<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>", "Refactoring" },
          g = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
          h = { "<cmd>Telescope oldfiles<cr>", "History" },
          k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
          m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
          n = { "<cmd>Telescope notify<cr>", "Notifications" },
          p = { "<cmd>Telescope project<cr>", "Projects" },
          r = { "<cmd>Telescope registers<cr>", "Registers" },
          s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
          S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
          },
          t = { "<cmd>Telescope live_grep<cr>", "Text" },
          w = { "<cmd>Telescope grep_string<cr>", "Search string under cursor" },
        },
      },
    ["<C-d>"] = {
      name = "Date",
      d = { "<c-r>=strftime('%F %T%z')<cr>", "d/m/Y H:M:S z" },
      f = { "<c-r>=strftime('%B %d, %Y')<cr>", "B d, Y" },
      F = { "<c-r>=strftime('%T')<cr>", "H:M:S" },
      n = { "<c-r>=strftime('%F')<cr>", "d-m-Y" },
      x = { "<c-r>=strftime('%d/%m/%y')<cr>", "d/m/y" },
      X = { "<c-r>=strftime('%H:%M')<cr>", "H:M" },
    },
    ["]"] = {
      f = "Next function start",
      x = "Next class start",
      F = "Next function end",
      X = "Next class end",
    },
    ["["] = {
      f = "Previous function start",
      x = "Previous class start",
      F = "Previous function end",
      X = "Previous class end",
    },
    g = {
      t = {
        name = "Treesitter",
        v = {
          function() require("syntax-tree-surfer").targeted_jump { "variable_declaration" } end,
          "Go to Variables",
        },
        f = {
          function() require("syntax-tree-surfer").targeted_jump { "function" } end,
          "Go to Functions",
        },
        i = {
          function()
            require("syntax-tree-surfer").targeted_jump {
              "if_statement",
              "else_clause",
              "else_statement",
              "elseif_statement",
            }
          end,
          "Go to If Statements",
        },
        r = {
          function() require("syntax-tree-surfer").targeted_jump { "for_statement" } end,
          "Go to If Statements",
        },
        w = {
          function() require("syntax-tree-surfer").targeted_jump { "white_statement" } end,
          "Go to While Statements",
        },
        s = {
          function() require("syntax-tree-surfer").targeted_jump { "switch_statement" } end,
          "Go to Switch Statements",
        },
        t = {
          function()
            require("syntax-tree-surfer").targeted_jump {
              "function",
              "if_statement",
              "else_clause",
              "else_statement",
              "elseif_statement",
              "for_statement",
              "while_statement",
              "switch_statement",
            }
          end,
          "Go to Statement",
        },
      },
    },
  },
  i = {
    ["<c-d>"] = {
      n = { "<c-r>=strftime('%Y-%m-%d')<cr>", "Y-m-d" },
      x = { "<c-r>=strftime('%m/%d/%y')<cr>", "m/d/y" },
      f = { "<c-r>=strftime('%B %d, %Y')<cr>", "B d, Y" },
      X = { "<c-r>=strftime('%H:%M')<cr>", "H:M" },
      F = { "<c-r>=strftime('%H:%M:%S')<cr>", "H:M:S" },
      d = { "<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", "Y/m/d H:M:S -" },
    },
  },
  v = {
    ["<leader>"] = {
      d = {
        name = "Debugger",
        e = { function() require("dapui").eval() end, "Evaluate Line" },
      },
      h = {
        name = "Hop",
        c = { "<cmd>HopChar1<cr>", "Character" },
        C = { "<cmd>HopChar2<cr>", "2 Characters" },
        l = { "<cmd>HopLine<cr>", "Line" },
        p = { "<cmd>HopPattern<cr>", "Pattern" },
        w = { "<cmd>HopWord<cr>", "Word" },
      },
    },
  },
}

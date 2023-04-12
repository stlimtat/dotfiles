return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.cmd([[
        highlight IndentBlanklineIndent1 guifg=#F7768E gui=nocombine
        highlight IndentBlanklineIndent2 guifg=#E0AF68 gui=nocombine
        highlight IndentBlanklineIndent3 guifg=#9ECE6A gui=nocombine
        highlight IndentBlanklineIndent4 guifg=#7DCFFF gui=nocombine
        highlight IndentBlanklineIndent5 guifg=#7AA2F7 gui=nocombine
        highlight IndentBlanklineIndent6 guifg=#BB9AF7 gui=nocombine
      ]])
      require("indent_blankline").setup({
        buftype_exclude = { "terminal", "nofile" },
        char = "│",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
        -- let g:indent_blankline_char_list = ["|", "¦", "┆", "┊"]
        filetype_exclude = {
          "alpha",
          "dashboard",
          "help",
          "lazy",
          "markdown",
          "neo-tree",
          "neogitstatus",
          "NvimTree",
          "packer",
          "startify",
          "text",
          "Trouble",
        },
        show_current_context = true,
        show_current_context_start = true,
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
      })
    end,
  },
}

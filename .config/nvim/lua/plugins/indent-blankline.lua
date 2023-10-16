return {
  "lukas-reineke/indent-blankline.nvim",
  event = "LazyFile",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "alpha",
        "dashboard",
        "help",
        "lazy",
        "lazyterm",
        "markdown",
        "mason",
        "neo-tree",
        "neogitstatus",
        "notify",
        "NvimTree",
        "packer",
        "startify",
        "text",
        "toggleterm",
        "Trouble",
      },
    },
  },
  main = "ibl",
}

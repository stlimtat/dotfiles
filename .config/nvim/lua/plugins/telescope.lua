-- Additional Plugins
return {
  { "kelly-lin/telescope-ag", lazy = true, requires = { { "nvim-telescope/telescope.nvim" } } },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true, requires = { { "nvim-telescope/telescope.nvim" } } },
  { "nvim-telescope/telescope-frecency.nvim", lazy = true, requires = { { "nvim-telescope/telescope.nvim" } } },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
    requires = { { "nvim-telescope/telescope.nvim" } },
  },
  { "nvim-telescope/telescope-hop.nvim", lazy = true, requires = { { "nvim-telescope/telescope.nvim" } } },
  { "nvim-telescope/telescope-live-grep-args.nvim", lazy = true, requires = { { "nvim-telescope/telescope.nvim" } } },
  { "nvim-telescope/telescope-packer.nvim", lazy = true, requires = { { "nvim-telescope/telescope.nvim" } } },
  { "nvim-telescope/telescope-smart-history.nvim", lazy = true, requires = { { "nvim-telescope/telescope.nvim" } } },
}

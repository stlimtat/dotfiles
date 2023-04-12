-- Additional Plugins
return {
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
    -- cmd = { "HopChar1", "HopChar2", "HopLine", "HopPattern", "HopWord" },
  },
}

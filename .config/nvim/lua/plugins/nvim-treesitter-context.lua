return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "LazyFile",
  enabled = true,
  opts = { mode = "cursor" },
  keys = {
    {
      "<leader>ut",
      function()
        local Util = require("lazyvim.util")
        local tsc = require("treesitter-context")
        tsc.toggle()
        if Util.inject.get_upvalue(tsc.toggle, "enabled") then
          Util.info("Enabled Treesitter Context", { title = "Option" })
        else
          Util.warn("Disabled Treesitter Context", { title = "Option" })
        end
      end,
      desc = "Toggle Treesitter Context",
    },
  },
}

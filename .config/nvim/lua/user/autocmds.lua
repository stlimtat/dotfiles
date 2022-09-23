-- https://github.com/LunarVim/LunarVim/blob/main/lua/lvim/core/autocmds.lua#L145
vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format buffer on save",
  group = "lsp_format_on_save",
  pattern = "*",
  callback = function()
    require("user.lsp").format({
      timeout_ms = 1000, 
      filter = require("user.lsp").format_filter
    })
  end, 
})


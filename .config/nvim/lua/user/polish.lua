return function() 
  require "user.lsp"
  require "user.autocmds"
  require("user.bufferline").setup()
  require "user.plugins.dap"
  local colors = require("tokyonight.colors").setup()
  vim.cmd("highlight ColorColumn guibg=" .. colors.red .. " gui=nocombine")
  vim.cmd("highlight WinSeparator guibg=" .. colors.blue .. " gui=nocombine")
end

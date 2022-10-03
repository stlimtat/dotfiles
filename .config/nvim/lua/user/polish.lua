return function() 
  require "user.lsp"
  require "user.autocmds"
  require("user.bufferline").setup()
  local colors = require("tokyonight.colors").setup()
  vim.cmd("highlight ColorColumn guibg=" .. colors.red .. " gui=nocombine")
  vim.cmd("highlight WinSeparator guibg=" .. colors.blue .. " gui=nocombine")
end

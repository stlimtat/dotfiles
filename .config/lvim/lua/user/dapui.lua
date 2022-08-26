local M = {}

M.setup = function()
  local status_ok, dapui = pcall(require, "dapui")
  if not status_ok then
    return
  end

  -- DAP UI helpers - https://github.com/rcarriga/nvim-dap-ui#usage
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
  dapui.setup({
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          { id = "scopes", size = 0.25 },
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40,
        position = "left",
      },
      {
        elements = { "repl", },
        size = 0.25,
        position = "bottom",
      },
    },
  });
end

return M

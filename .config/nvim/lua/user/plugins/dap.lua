local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Neovim attach",
    host = function()
      -- local value = vim.fn.input "Host [127.0.0.1]: "
      -- if value ~= "" then
      --   return value
      -- end
      return "127.0.0.1"
    end,
    port = function()
      local val = tonumber(vim.fn.input "Port: ")
      assert(val, "Please provide a port number")
      return val
    end,
  },
}

dap.adapters.go = function(callback, _)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("dlv exited with code", code)
    end
  end)
  assert(handle, "Error running dlv: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(function()
    callback { type = "server", host = "127.0.0.1", port = port }
  end, 100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- works with go.mod packages and sub packages
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}
-- stlimtat custom dap.lua
local dap_python = require("dap-python")
dap_python.setup(os.getenv("PYENV_VIRTUAL_ENV") .. "/bin/python", {
  console = "internalConsole",
  test_runner_config = {
    cwd = vim.env.SOURCE .. "/src/pytests"
  }
});
dap_python.test_runner = 'pytest';
local current_wd = vim.env.SOURCE .. "/src/pytests"
table.insert(dap.configurations.python, 1, {
  type = "python",
  request = "launch",
  name = "Launch abnormal test (airflow)",
  console = "internalConsole",
  cwd = current_wd,
  env = vim.fn.environ(),
  module = "pytest",
  args = function()
    local current_file, source_path = vim.fn.expand("%:p"), os.getenv("SOURCE")
    local result = current_file:gsub(current_wd .. "/", "")
    print("result = " .. result)
    vim.fn.input("args = " .. result, "tester")
    return { "--ds=test_airflow_django_settings", "--nomigrations", result }
  end,
  -- pythonPath = os.getenv("PYENV_VIRTUAL_ENV") .. "/bin/python",
});
table.insert(dap.configurations.python, 2, {
  type = "python",
  request = "launch",
  name = "Launch abnormal test",
  console = "internalConsole",
  cwd = current_wd,
  env = vim.fn.environ(),
  module = "pytest",
  args = function()
    local current_file, source_path = vim.fn.expand("%:p"), os.getenv("SOURCE")
    local result = current_file:gsub(current_wd .. "/", "")
    print("result = " .. result)
    vim.fn.input("args = " .. result, "tester")
    return { result }
  end,
  -- pythonPath = os.getenv("PYENV_VIRTUAL_ENV") .. "/bin/python",
});

-- Additional Plugins
return {
  { "nvim-neotest/neotest-go" },
  { "nvim-neotest/neotest-jest" },
  { "nvim-neotest/neotest-python" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        "neotest-go",
        "neotest-jest",
        ["neotest-python"] = {
          dap = { justMyCode = false },
          args = {
            "--no-migrations",
          },
          runner = "pytest",
          python = "/Users/st_lim/dev/venv/bin/python",
        },
      },
    },
  },
}

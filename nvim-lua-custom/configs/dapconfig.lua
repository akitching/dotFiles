local dap = require "dap"

-- local path = require 'path'

dap.adapters.coreclr = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg",
    -- command = path.concat { vim.fn.stdpath "data", "mason", "packagges", "netcoredbg", "netcoredbg", "netcoredbg" },
  -- command = '~/nvim-data/mason/packages/netcoredbg/netcoredbg/netcoredbg',
    -- command = '/path/to/dotnet/netcoredbg/netcoredbg',
    args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
-- dap.configurations.js-debug-adapter = {

-- }

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable ={
    command = "js-debug-adapter"
  }
}

for _, language in ipairs { "typescript", "javascript" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node"
    },
  }
end

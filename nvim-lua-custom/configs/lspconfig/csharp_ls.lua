local config = require("plugins.configs.lspconfig")
local lspconfig = require("lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

lspconfig["csharp_ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities
})



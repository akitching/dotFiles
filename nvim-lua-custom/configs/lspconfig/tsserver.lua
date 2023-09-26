local config = require("plugins.configs.lspconfig")
local lspconfig = require("lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

-- TypeScript / JavaScript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      -- Prevent pointless suggestions
      disableSuggestions = true
    }
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize imports",
    }
  }
}

local lspconfig = require("lspconfig")

local config = require("plugins.configs.lspconfig")

local on_attach = function(client)
  client.resolved_capabilities.document_formatting = true
  client.resolved_capabilities.document_range_formatting = true
end
-- local on_attach = config.on_attach
local capabilities = config.capabilities

lspconfig.terraformls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    -- cmd = {"terraform-ls", "serve"},
    -- root_dir = util.root_pattern(".terraform", ".git"),
}

-- Auto format on save
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- require("lspconfig.tsserver")
require("custom.configs.lspconfig.tsserver")
require("custom.configs.lspconfig.csharp_ls")
require("custom.configs.lspconfig.terraformls")

local pid = vim.fn.getpid()
-- local util = require 'util'
vim.lsp.set_log_level(("debug"))

local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")

require("mason-lspconfig").setup()

--require("mason-lspconfig").setup_handlers {
--  -- The first entry (without a key) will be the default handler
--  -- and will be called for each installed server that doesn't have
--  -- a dedicated handler.
--  function(server_name)  -- default handler (optional)
--    require("lspconfig")[server_name].setup {}
--  end,
--  -- Next, you can provide a dedicated handler for specific servers.
--  -- For example, a handler override for the `rust_analyzer`:
--  -- ["rust_analyzer"] = function ()
--  -- require("rust-tools").setup {}
--  -- end
----  ["yamlls"] = function()
----    require('lspconfig').yamlls.setup {
----      -- ... -- other configuration for setup {}
----      settings = {
----        yaml = {
----          -- ... -- other settings. note this overrides the lspconfig defaults.
----          schemas = {
----            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
----          },
----        },
----      }
----    }
----  end
--}

-- lspconfig.csharp_ls.setup{}
-- lspconfig.denols.setup{}
--lspconfig.terraformls.setup {}
--    -- on_attach = on_attach,
--    -- capabilities = capabilities,
--    -- cmd = {"terraform-ls", "serve"},
--    -- root_dir = util.root_pattern(".terraform", ".git"),
---- }
--vim.api.nvim_create_autocmd({"BufWritePre"}, {
--  pattern = {"*.tf", "*.tfvars"},
--  callback = function()
--    vim.lsp.buf.format()
--  end,
--})

--local function organize_imports()
--  local params = {
--    command = "_typescript.organizeImports",
--    arguments = { vim.api.nvim_buf_get_name(0) },
--  }
--  vim.lsp.buf.execute_command(params)
--end
--
---- TypeScript / JavaScript
--lspconfig.tsserver.setup {
--  on_attach = on_attach,
--  capabilities = capabilities,
--  init_options = {
--    preferences = {
--      -- Prevent pointless suggestions
--      disableSuggestions = true
--    }
--  },
--  commands = {
--    OrganizeImports = {
--      organize_imports,
--      description = "Organize imports",
--    }
--  }
--}

-- SQL
lspconfig.sqlls.setup {}

local omnisharp_capabilities = require('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())
local omnisharp_on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

lspconfig.omnisharp.setup {
  -- cmd = {
    -- "c:/Users/akitchin/AppData/Local/nvim-data/mason/bin/omnisharp.cmd", "--languageserver", "--hostPID", tostring(pid)
  -- },
  on_attach = omnisharp_on_attach,
  capabilities = omnisharp_capabilities
}

require('lspconfig').yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<space>de', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

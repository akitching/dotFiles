local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "single",
      },
      ensure_installed = {
        -- LSP
        "csharp-language-server",
        "omnisharp",
        "terraform-ls",
        "tflint",
        "dockerfile-language-server",
        "docker-compose-language-service",
        -- "deno",
        "typescript-language-server",
        "eslint-lsp",
        "cmake-language-server",
        "bash-language-server",
        "awk-language-server",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "sqlls",
        "yaml-language-server",
        "actionlint",
        "lua-language-server",
        -- DAP
        "netcoredbg",
        "js-debug-adapter",
        --
        "prettier",
        "ThePrimeagen/git-worktree.nvim"
      }
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        -- "csharp-language-server",
        -- "omnisharp",
        -- "terraform-ls",
        -- "tflint",
        -- "dockerfile-language-server",
        -- "docker-compose-language-service",
        -- "deno",
        -- "typescript-language-server",
        -- "eslint-lsp",
        -- "cmake-language-server",
        -- "bash-language-server",
        -- "awk-language-server",
        -- "css-lsp",
        -- "html-lsp",
        -- "json-lsp",
        -- "sqlls",
        -- "yaml-language-server",
        "yamlls",
        -- "actionlint",
        -- "lua-language-server",
        -- DAP
        -- "netcoredbg",
        -- "js-debug-adapter"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end
  },
--{
--  "mfussenegger/nvim-lint",
--  event = "VeryLazy",
--  config = function()
--    require "custom.configs.lint"
--  end
--},
--{
--  "mhartington/formatter.nvim",
--  event = "VeryLazy",
--  opts = function()
--    return require "custom.configs.formatter"
--  end
--},
  {
    "lewis6991/gitsigns.nvim",
    lazy = false
    -- ft = { "*", "all" }
  },
   {
     "NeogitOrg/neogit",
     dependencies = {
       "nvim-lua/plenary.nvim",         -- required
       "nvim-telescope/telescope.nvim", -- optional
       "sindrets/diffview.nvim",        -- optional
     },
     -- config = function()
       -- require("neogit").setup()
     -- end,
    config = true,
    -- lazy = false
   },
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require('git-worktree').setup()
      require('telescope').load_extension('git_worktree')
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end,
    config = function()
      -- require "plugins.configs.dapconfig"
      require "custom.configs.dapconfig"
      require("core.utils").load_mappings("dap")
    end,
    -- dependencies = {
      -- "rcarriga/nvim-dap-ui",
      -- "theHamsta/nvim-dap-virtual-text",
      -- "nvim-telescope/telescope-dap.nvim"
    -- }
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup()
    end
  },
  {
    -- Syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "xml",
        "c_sharp",
        "yaml",

        -- IaC
        "terraform",

        "dockerfile",

        -- git
        "gitcommit",
        "gitignore",
        "gitattributes",
        "git_rebase",
        "git_config",
      }
    }
  }
}
return plugins

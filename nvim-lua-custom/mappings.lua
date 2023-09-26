local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>qq"] = { "<cmd> quitall <CR>", "Quit all" },
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Run or continue the debugger"
    },
--  ["<leader>dus"] = {
--    function ()
--      local widgets = require('dap.ui.widgets');
--      local sidebar = widgets.sidebar(widgets.scopes);
--      sidebar.open();
--    end,
--    "Open debugging sidebar"
--  }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgr"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.telescope = {
  n = {
      -- find
    ["<leader>ss"] = { "<cmd> Telescope grep_string <cr>", "Search under your cursor" },
    ["<leader>sr"] = { "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", "Switch between worktrees"},
    ["<leader>sR"] = { "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", "Create worktree"},
  },
}
 return M

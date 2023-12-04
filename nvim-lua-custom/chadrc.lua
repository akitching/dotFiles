---@type ChadrcConfig 
 local M = {}

 M.ui = {
  theme = 'gruvbox',
  telescope = { scope = "bordered" },

  statusline = {
    theme = "default",
    -- theme = "vscode",
    -- theme = "vscode_colored",
    -- theme = "minimal",
  }
}
 -- M.ui = {theme = 'gruvbox'}

 M.plugins = 'custom.plugins'
 M.mappings = require 'custom.mappings'

 return M

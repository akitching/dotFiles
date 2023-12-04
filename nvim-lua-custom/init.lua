local opt = vim.opt
local g = vim.g

vim.g.dap_virtual_text = true
vim.opt.colorcolumn = "80"
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}
--vim.api.nvim_set_keymap('n', '<F12>', "<cmd>set paste!<CR>")
vim.cmd([[
  "set pastetoggle=<F12>            " when in insert mode, press <F2> to go to

  " Since I never use the ; key anyway, this is a real optimization for almost
  " all Vim commands, since we don't have to press that annoying Shift key that
  " slows the commands down
  nnoremap ; :

  " Avoid accidental hits of <F1> while aiming for <Esc>
  map! <F1> <Esc>

  " Easy window navigation
  "map <C-h> <C-w>h
  "map <C-j> <C-w>j
  "map <C-k> <C-w>k
  "map <C-l> <C-w>l
  " nnoremap <leader>w <C-w>v<C-w>l

  map <S-Up> <C-w>k
  map <S-Down> <C-w>j
  map <S-Left> <C-w>h
  map <S-Right> <C-w>l

  inoremap <silent> <S-Insert> <C-R>+

  autocmd! BufRead,BufNewFile *.j2 call jinja#AdjustFiletype()
]])

--local autocmd = vim.api.nvim_create_autocmd

-- autocmd("FileType", {
  -- pattern = "cs",
  -- callback = function()
    -- opt.shiftwidth = 4
    -- opt.tabstop = 4
    -- opt.softtabstop = 4
  -- end,
-- })

-- Override filetype to prevent errors
vim.filetype.add({
  extension = {
    tfvars = "terraform"
  }
})
vim.filetype.add({
  extension = {
    hcl = "terraform"
  }
})

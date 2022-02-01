if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end

vim.g.gruvbox_contrast_dark = 'soft'
vim.g.gruvbox_contrast_light = 'soft'
vim.g.gruvbox_italic = 1
vim.g.gruvbox_bold = 1
vim.g.gruvbox_underline = 1
vim.g.gruvbox_undercurl = 1
vim.g.gruvbox_italicize_comments = 1
vim.g.gruvbox_improved_warnings =1
vim.g.gruvbox_improved_strings = 0
vim.g.gruvbox_invert_selection=0

local term_profile = os.getenv("TERM_PROFILE")

if term_profile == "Night" then
    vim.opt.background='dark'
else
    vim.opt.background='light'
end

vim.cmd 'colorscheme gruvbox'

if (vim.opt.background == 'dark') then
  vim.cmd 'hi Visual guibg=#98971a guifg=#ebdbb2'
else
  vim.cmd 'hi Visual guibg=#98971a guifg=#3c3836'
end


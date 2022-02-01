local m = require "utils"
local map = m.map
local nmap = m.nmap
local imap = m.imap
local noremap = m.noremap
local create_augroup = m.create_augroup

-------------------------------------------------------------------------------------------------------------------------------------
-----                                                   Neovim configuration                                                    -----
-------------------------------------------------------------------------------------------------------------------------------------
-- options
vim.opt.history = 50                            -- keep 50 lines of command line history
vim.opt.hidden = true                           -- if hidden is not set, TextEdit might fail
vim.opt.cmdheight = 2                           -- Better display for messages
vim.opt.updatetime = 300                        -- Smaller updatetime for CursorHold & CursorHoldI
vim.opt.shortmess = 'c'                         -- don't give |ins-completion-menu| messages.
vim.opt.signcolumn = 'yes'                      -- always show signcolumns
vim.opt.completeopt = {'menuone', 'longest'}
vim.opt.previewheight = 5
vim.opt.wildignore:append {'*.*~'}
vim.opt.listchars = {trail = '~', tab = '··'}
vim.opt.list = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldnestmax = 5
vim.opt.foldlevelstart = 20
vim.opt.spell = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.splitright = true                       -- Set preview window to appear on the right
vim.opt.splitbelow = true                       -- Set preview window to appear at bottom
vim.opt.showmode = false                        -- Don't display mode in command line (lightline already shows it)
vim.opt.redrawtime = 10000
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.so = 999
vim.opt.diffopt:append 'vertical'               -- set vertical diff split

-- global
vim.g.mapleader = ' '

map('Q', 'gq', {}) -- Don't use Ex mode, use Q for formatting
--
-- CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
imap('<C-U>', '<C-G>u<C-U>', noremap)

map(';', ':', {})
nmap('<SPACE>', '', noremap)
--
-- autoclose tags
imap('(', '()<Left>', noremap)
imap('{', '{}<Left>', noremap)
imap('[', '[]<Left>', noremap)
imap('`', '``<Left>', noremap)
imap('<>', '<><Left>', noremap)
imap('""', '""<Left>', noremap)
imap('\'', '\'\'<Left>', noremap)

-- buffer
nmap('<Leader>B', ':enew<CR>', noremap) -- create new buffer
nmap('<Leader>bq', ':bp <bar> bd! #<CR>', noremap) -- close current buffer
nmap('<Leader>bn', ':bnext<CR>', noremap) -- switch to next open buffer
nmap('<Leader>bp', ':bprevious<CR>', noremap) -- switch to previous open buffer
nmap('<Leader><Leader>', '<C-^>', noremap) -- cycle between last two open buffers
nmap('<silent> <C-l>', ':nohl<CR><C-l>', noremap) -- <Ctrl-l> redraws the screen and removes any search highlighting.
nmap('<C-]>', ':vertical resize -5<CR>', noremap) -- Ctrl-]
nmap('<C-\\>', ':vertical resize +5<CR>', noremap) -- Ctrl-[

create_augroup({
    { 'FileType', 'text', 'setlocal', 'textwidth=78' }, -- For all text files set 'textwidth' to 78 characters.

    -- When editing a file, always jump to the last known cursor position.
    -- Don't do it when the position is invalid or when inside an event handler
    -- (happens when dropping a file on gvim).
    { 'BufReadPost', '*', 'call setpos(".", getpos("\'\\""))' }
}, 'vimrcEx')

-------------------------------------------------------------------------------------------------------------------------------------
-----                                                    Plugin Installation                                                    -----
-------------------------------------------------------------------------------------------------------------------------------------
require "plugins.install"

-------------------------------------------------------------------------------------------------------------------------------------
-----                                                    Theme                                                                  -----
-------------------------------------------------------------------------------------------------------------------------------------
require "theme"

-------------------------------------------------------------------------------------------------------------------------------------
-----                                                     LSP                                                                   -----
-------------------------------------------------------------------------------------------------------------------------------------
require "lsp"

-------------------------------------------------------------------------------------------------------------------------------------
-----                                                    Plugin Configuration                                                   -----
-------------------------------------------------------------------------------------------------------------------------------------
require "plugins.configurations"

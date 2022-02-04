local m = require "utils"
local nmap = m.nmap
local noremap = m.noremap
local silent = m.silent
local noremap_silent = m.noremap_silent

-----                                                      Fern                                                                 -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<C-n>', ':Fern . -drawer -width=35 -toggle -reveal=%<CR><C-w>=', noremap_silent)   -- Toggle Fern on/off
-----                                                    Telescope                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<C-p>', '<cmd>Telescope find_files<CR>', noremap_silent)
nmap('<C-f>', '<cmd>Telescope live_grep<CR>', noremap_silent)
nmap('<C-b>', '<cmd>Telescope buffers<CR>', noremap_silent)
nmap('<C-g>', '<cmd>Telescope git_files<CR>', noremap_silent)
nmap('<Leader>c', '<cmd>Telescope git_commits<CR>', noremap_silent)
nmap('<Leader>bc', '<cmd>Telescope git_bcommits<CR>', noremap_silent)
nmap('<Leader>ch', '<cmd>Telescope git_branches<CR>', noremap)

-- LSP mappings
nmap('<Leader>i', '<cmd>Telescope lsp_implementations<CR>', noremap_silent)
nmap('<Leader>ca', '<cmd>Telescope lsp_code_actions<CR>', noremap_silent)
nmap('<Leader>d', '<cmd>Telescope lsp_definitions<CR>', noremap_silent)
nmap('<Leader>pd', '<cmd>Telescope lsp_type_definitions<CR>', noremap_silent)

-----                                                    VIM-DELVE                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>b', ':DlvToggleBreakpoint<CR>', silent)
-----                                                    Vim-Fugitive                                                           -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>gb', ':Git blame<CR>', {})   -- git blame
nmap('<Leader>gd', ':Gdiffsplit<CR>', {})  -- git diff
nmap('<Leader>gm', ':Gdiffsplit!<CR>', {}) -- git diff for merge (3 tabs)
nmap('<Leader>gf', ':diffget //2<CR>', {}) -- git merge select left
nmap('<Leader>gh', ':diffget //3<CR>', {}) -- git merge select right

-----                                                   Git-Messenger                                                           -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>m', '<Plug>(git-messenger)', {})
nmap('<Leader>mc', '<Plug>(git-messenger-close)', {})
nmap('<Leader>j', '<Plug>(git-messenger-scroll-down-half)', {})
nmap('<Leader>k', '<Plug>(git-messenger-scroll-up-half)', {})

-----                                                Symbols-Outline                                                            -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>tt', ':SymbolsOutline<CR>', {})

-----                                                    Trouble                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>dd', '<cmd>TroubleToggle workspace_diagnostics<CR>', noremap_silent)
nmap('<Leader>r', '<cmd>TroubleToggle lsp_references<CR>', noremap_silent)

-----                                                    Lazygit                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>gs', '<cmd>LazyGit<CR>', noremap_silent)

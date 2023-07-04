local m = require 'utils'
local nmap = m.nmap
local noremap = m.noremap
local silent = m.silent
local noremap_silent = m.noremap_silent

-----                                                      Fern                                                                 -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<C-n>', ':Fern . -drawer -width=35 -toggle -reveal=%<CR><C-w>=', noremap_silent) -- Toggle Fern on/off
-----                                                    Telescope                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<C-p>', '<cmd>Telescope find_files<CR>', noremap_silent)
nmap('<C-f>', '<cmd>Telescope live_grep<CR>', noremap_silent)
nmap('<C-b>', '<cmd>Telescope buffers<CR>', noremap_silent)
nmap('<C-g>', '<cmd>Telescope git_files<CR>', noremap_silent)
nmap('<Leader>c', '<cmd>Telescope git_commits<CR>', noremap_silent)
nmap('<Leader>bc', '<cmd>Telescope git_bcommits<CR>', noremap_silent)
nmap('<Leader>ch', '<cmd>Telescope git_branches<CR>', noremap)


-----                                                    VIM-DELVE                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>b', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>', silent)
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

-----                                                   LSP_Saga                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>tt', ':Lspsaga outline<CR>', {})

-----                                                    Lazygit                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
function _Lazygit_toggle()
    require 'plugins/settings'.lazygit_toggle()
end

nmap('<Leader>gs', '<cmd>lua _Lazygit_toggle()<CR>', noremap_silent)

-----                                               TODO-comments                                                               -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>td', ':TodoTelescope<CR>', noremap_silent)

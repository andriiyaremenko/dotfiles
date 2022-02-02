local m = require "utils"
local nmap = m.nmap
local noremap = m.noremap
local silent = m.silent
local noremap_silent = m.noremap_silent
local create_augroup = m.create_augroup
--
-----                                                      Fern                                                                 -----
-------------------------------------------------------------------------------------------------------------------------------------
-- Disable netrw.
vim.g.loaded_netrw  = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- I could not find any other way to make it work
vim.api.nvim_exec([[
function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

let g:fern#disable_default_mappings = 1
let g:fern#disable_drawer_auto_quit = 1
let g:fern#renderer#default#leading = "│"
let g:fern#renderer#default#root_symbol = "┬ "
let g:fern#renderer#default#leaf_symbol = "├─ "
let g:fern#renderer#default#collapsed_symbol = "├─ "
let g:fern#renderer#default#expanded_symbol = "├┬ "
let g:fern#mark_symbol = '✓'

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> K <Plug>(fern-action-mark:toggle)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END
]], false)

nmap('<C-n>', ':Fern . -drawer -width=35 -toggle -reveal=%<CR><C-w>=', noremap_silent)   -- Toggle Fern on/off

-- automatically update fern on entering
create_augroup({
    { 'BufEnter', '<buffer>', 'silent', 'execute', '"normal <Plug>(fern-action-reload)"' }
}, 'FernTypeGroup')

-----                                                 Fern Git Status                                                           -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.g.fern_git_status = { disable_ignored = 1 }

-----                                                    Telescope                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------

require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.65 }
      -- other layout configuration here
    },
    -- other defaults configuration here
  },
  -- other configuration values here
})

nmap('<C-p>', '<cmd>Telescope find_files<CR>', noremap_silent)
nmap('<C-f>', '<cmd>Telescope live_grep<CR>', noremap_silent)
nmap('<C-b>', '<cmd>Telescope buffers<CR>', noremap_silent)
nmap('<C-g>', '<cmd>Telescope git_files<CR>', noremap_silent)
nmap('<Leader>c', '<cmd>Telescope git_commits<CR>', noremap_silent)
nmap('<Leader>bc', '<cmd>Telescope git_bcommits<CR>', noremap_silent)
nmap('<Leader>ch', '<cmd>Telescope git_branches<CR>', noremap)

-- LSP mappings
nmap('<Leader>ca', '<cmd>Telescope lsp_code_actions<CR>', noremap_silent)
nmap('<Leader>d', '<cmd>Telescope lsp_definitions<CR>', noremap_silent)
nmap('<Leader>i', '<cmd>Telescope lsp_implementations<CR>', noremap_silent)
nmap('<Leader>pd', '<cmd>Telescope lsp_type_definitions<CR>', noremap_silent)
nmap('<Leader>r', '<cmd>Telescope lsp_references<CR>', noremap_silent)
nmap('<Leader>dd', '<cmd>Telescope diagnostics<CR>', noremap_silent)

-----                                                    LuaLine                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '╲', right = '╱'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp'}}},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-----                                                   Tree-Sitter                                                             -----
-------------------------------------------------------------------------------------------------------------------------------------
local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = "maintained", -- Only use parsers that are maintained
  highlight = { -- enable highlighting
    enable = true,
  },
  indent = {
    enable = true, -- default is disabled anyways
  }
}
-----                                                    Spelunker                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
-- 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
-- depends on the setting of CursorHold `set updatetime=1000`.
vim.g.spelunker_check_type = 2

-----                                                    VIM-DELVE                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>b', ':DlvToggleBreakpoint<CR>', silent)
vim.g.delve_breakpoint_sign = "◉"
vim.g.delve_breakpoint_sign_highlight = "ALEErrorSign"
vim.g.delve_new_command = 'enew'
vim.g.delve_enable_syntax_highlighting = 1

-----                                                    Vim-Fugitive                                                           -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>gb', ':Git blame<CR>', {})      -- git blame
nmap('<Leader>gs', ':G<CR>', {})           -- git status
nmap('<Leader>gd', ':Gdiffsplit<CR>', {})  -- git diff
nmap('<Leader>gc', ':Git commit<CR>', {})     -- git commit
nmap('<Leader>gp', ':Git push<CR>', {})    -- git push
nmap('<Leader>gm', ':Gdiffsplit!<CR>', {}) -- git diff for merge (3 tabs)
nmap('<Leader>gf', ':diffget //2<CR>', {}) -- git merge select left
nmap('<Leader>gh', ':diffget //3<CR>', {}) -- git merge select right

-----                                                   Git-Messenger                                                           -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.g.git_messenger_no_default_mappings = true
vim.g.git_messenger_into_popup_after_show = true
vim.g.git_messenger_close_on_cursor_moved = true
nmap('<Leader>m', '<Plug>(git-messenger)', {})
nmap('<Leader>mc', '<Plug>(git-messenger-close)', {})
nmap('<Leader>j', '<Plug>(git-messenger-scroll-down-half)', {})
nmap('<Leader>k', '<Plug>(git-messenger-scroll-up-half)', {})

-----                                                Symbols-Outline                                                            -----
-------------------------------------------------------------------------------------------------------------------------------------
nmap('<Leader>tt', ':SymbolsOutline<CR>', {})
vim.g.symbols_outline = {
  width = 50,
  auto_preview = false,
  highlight_hovered_item = false,
  keymaps = {
    close = { "<Leader>tt" },
  }
}

-----                                                      go                                                                   -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.cmd 'au BufRead,BufNewFile *.go set filetype=go'
vim.cmd 'au BufRead,BufNewFile *.tmpl set filetype=gotexttmpl'
vim.cmd 'au BufRead,BufNewFile *.html.tmpl set filetype=gohtmltmpl'
vim.cmd 'au BufRead,BufNewFile go.mod set filetype=gomod'
vim.cmd 'au BufRead,BufNewFile go.sum set filetype=gosum'

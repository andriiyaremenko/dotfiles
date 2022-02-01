-- local map functions and options
local cmd = vim.cmd
local keymap = vim.api.nvim_set_keymap

local map = function(key, mapped_to, opts) keymap('', key, mapped_to, opts) end
local nmap = function(key, mapped_to, opts) keymap('n', key, mapped_to, opts) end
local imap = function(key, mapped_to, opts) keymap ('i', key, mapped_to, opts) end

local noremap = { noremap = true }
local silent = { silent = true }
local noremap_silent = { noremap = true, silent = true }

-- We will create a few autogroup, this function will help to avoid
-- always writing cmd('augroup' .. group) etc..
local create_augroup = function(autocmds, name)
  cmd ('augroup ' .. name)
  cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  cmd('augroup END')
end

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
vim.opt.foldmethod = 'indent'
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

if vim.fn.empty(vim.fn.glob('~/.local/share/nvim/site/autoload/plug.vim')) > 0 then
    execute(
      'silent sh -c '
      .. '\'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs'
      .. 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\'')
    cmd('autocmd VimEnter  * PlugInstall -' .. '-sync | source $MYVIMRC')
end

-- Automatically install missing plugins on startup
vim.api.nvim_exec([[
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
]], false)

-- vim-plug setup (https://github.com/junegunn/vim-plug)
-- Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'simrat39/symbols-outline.nvim'

-- appearance
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
Plug 'Yggdroot/indentLine'

-- spell check
Plug 'kamykn/spelunker.vim'

-- git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'

-- Language syntax highlight
Plug 'sheerun/vim-polyglot'

-- typescript
Plug 'ianks/vim-tsx'

-- lsp client
Plug 'neovim/nvim-lspconfig'

-- tree-sitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- preview / floating window
Plug 'kamykn/popup-menu.nvim'
Plug 'ncm2/float-preview.nvim'


-- js / html / css
Plug 'pangloss/vim-javascript'
Plug 'Quramy/vim-js-pretty-template'
Plug 'othree/html5.vim'

-- snippets
Plug 'SirVer/ultisnips'

-- Go
Plug 'sebdah/vim-delve'

-- Elixir/Phoenix
Plug 'elixir-editors/vim-elixir'

-- code screenshot
Plug 'segeljakt/vim-silicon'

-- Scroll
Plug 'psliwka/vim-smoothie'

vim.call('plug#end')

-------------------------------------------------------------------------------------------------------------------------------------
-----                                                    Plugin Configuration                                                   -----
-------------------------------------------------------------------------------------------------------------------------------------

-----                                                    Theme                                                                  -----
-------------------------------------------------------------------------------------------------------------------------------------

if vim.fn.has('termguicolors') then
  --let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  --let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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

-----                                                    LSP                                                                    -----
-------------------------------------------------------------------------------------------------------------------------------------
local nvim_lsp = require('lspconfig')

nvim_lsp.elixirls.setup{
  cmd = { '~/.lsp/elixir-ls/release/language_server.sh' };
}
nvim_lsp.angularls.setup{}
nvim_lsp.fsautocomplete.setup{}
nvim_lsp.gopls.setup{}
nvim_lsp.dockerls.setup{}
nvim_lsp.vimls.setup{}
nvim_lsp.bashls.setup{}
nvim_lsp.tsserver.setup{}
nvim_lsp.csharp_ls.setup{}
nvim_lsp.solargraph.setup{}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<Leader>kd','<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<Leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'angularls',
  'fsautocomplete',
  'gopls',
  'dockerls',
  'vimls',
  'bashls',
  'tsserver',
  'csharp_ls',
  'solargraph',
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local border = {
  {"╭", highlight},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}
-- To override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local signs = { Error = "✘ ", Warn = "⚡", Hint = " ", Info = "𝙞 " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
nmap('<Leader>gb', ':Gblame<CR>', {})      -- git blame
nmap('<Leader>gs', ':G<CR>', {})           -- git status
nmap('<Leader>gd', ':Gdiffsplit<CR>', {})  -- git diff
nmap('<Leader>gc', ':Gcommit<CR>', {})     -- git commit
nmap('<Leader>gp', ':Git push<CR>', {})    -- git push
nmap('<Leader>gm', ':Gdiffsplit!<CR>', {}) -- git diff for merge (3 tabs)
nmap('<Leader>gf', ':diffget //2<CR>', {}) -- git merge select left
nmap('<Leader>gh', ':diffget //3<CR>', {}) -- git merge select right

-----                                                   Git-Messenger                                                           -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.g.git_messenger_no_default_mappings = 'v:true'
vim.g.git_messenger_into_popup_after_show = 'v:true'
vim.g.git_messenger_close_on_cursor_moved = 'v:false'
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


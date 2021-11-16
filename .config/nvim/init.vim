set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hidden " if hidden is not set, TextEdit might fail
set cmdheight=2 " Better display for messages
set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns
set laststatus=2
set completeopt=menuone,noinsert
set previewheight=5
set wildignore+=*.*~

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Line numbers
:set number relativenumber

" Center screen around cursor
:set so=999

" My own settings:
syntax on " Switch syntax highlighting on, when the terminal has colors
set hlsearch " Also switch on highlighting the last used search pattern.
set listchars=trail:~,tab:··
set list
set cursorline
set encoding=utf-8
set fileencoding=utf-8
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab smarttab
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=20
set nospell
set ignorecase
set smartcase
set showmatch
set splitright " Set preview window to appear on the right
set splitbelow " Set preview window to appear at bottom
set noshowmode " Don't display mode in command line (lightline already shows it)
set autoread " Automatically re-read file if a change was detected outside of vim
set redrawtime=10000
map ; :
nnoremap <SPACE> <Nop>
let g:mapleader=' ' " Remap leader key to space
" autoclose tags
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap <> <><Left>
inoremap "" ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>
" elixir mappings
inoremap fn- fn ->  end<Left><Left><Left><Left>
inoremap def<Space> def  do<CR>end<Esc>k<Right>a
inoremap defp<Space> defp  do<CR>end<Esc>k<Right><Right>a
inoremap defmo defmodule  do<CR>end<Esc>k<Right><Right><Right><Right><Right><Right><Right>a
inoremap do<Enter> do<CR>end<Esc>O
inoremap @typet<Space> @type t :: %__MODULE__{}<Left><Enter><Esc>O
inoremap @typet( @type t() :: %__MODULE__{}<Left><Enter><Esc>O
inoremap defd defdelegate (), to:<Left><Left><Left><Left><Left><Left><Left>
" create new buffer
nnoremap <Leader>B :enew<CR>
" close current buffer
nnoremap <Leader>bq :bp <bar> bd! #<CR>
" switch to next open buffer
nnoremap <Leader>bn :bnext<CR>
" switch to previous open buffer
nnoremap <Leader>bp :bprevious<CR>
" cycle between last two open buffers
nnoremap <Leader><Leader> <C-^>
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Ctrl-Space
nnoremap <C-@> :vertical resize +5<CR>
nnoremap <C-\> :vertical resize -5<CR>

" ================================================================================================================================= "
" ===                                                    Plugin Installation                                                    === "
" ================================================================================================================================= "

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug setup (https://github.com/junegunn/vim-plug)
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')
" ctgas
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'

" appearance
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lualine/lualine.nvim'
Plug 'Yggdroot/indentLine'

" spell check
Plug 'kamykn/spelunker.vim'

" git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'

" Language syntax highlight
Plug 'sheerun/vim-polyglot'

" typescript
Plug 'ianks/vim-tsx'

" lsp client
Plug 'neovim/nvim-lspconfig'

" preview / floating window
Plug 'ncm2/float-preview.nvim'


" js / html / css
Plug 'pangloss/vim-javascript'
Plug 'Quramy/vim-js-pretty-template'
Plug 'othree/html5.vim'

" snippets
Plug 'SirVer/ultisnips'

" Go
Plug 'sebdah/vim-delve'

" Elixir/Phoenix
Plug 'elixir-editors/vim-elixir'

" code screenshot
Plug 'segeljakt/vim-silicon'

" Scroll
Plug 'psliwka/vim-smoothie'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" ================================================================================================================================= "
" ===                                                    Plugin Configuration                                                   === "
" ================================================================================================================================= "

" ===                                                  Telescope                                                                === "
" --------------------------------------------------------------------------------------------------------------------------------- "

lua << EOF
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
EOF

nnoremap <silent> <C-p> <cmd>Telescope find_files<CR>
nnoremap <silent> <C-f> <cmd>Telescope live_grep<CR>
nnoremap <silent> <C-b> <cmd>Telescope buffers<CR>
nnoremap <silent> <C-g> <cmd>Telescope git_files<CR>
nnoremap <silent> <Leader>c <cmd>Telescope git_commits<CR>
nnoremap <silent> <Leader>bc <cmd>Telescope git_bcommits<CR>
nnoremap <Leader>ch <cmd>Telescope git_branches<CR>

" LSP mappings
nnoremap <silent> <Leader>ca <cmd>Telescope lsp_code_actions<CR>
nnoremap <silent> <Leader>d <cmd>Telescope lsp_definitions<CR>
nnoremap <silent> <Leader>i <cmd>Telescope lsp_implementations<CR>
nnoremap <silent> <Leader>pd <cmd>Telescope lsp_type_definitions<CR>
nnoremap <silent> <Leader>r <cmd>Telescope lsp_references<CR>
nnoremap <silent> <Leader>dd <cmd>Telescope lsp_workspace_diagnostics<CR>

" ===                                                 FZF Checkout                                                              === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:fzf_branch_actions = {
      \ 'track': {'keymap': 'ctrl-t'},
      \ 'merge': {'keymap': 'ctrl-m'},
      \}

" ===                                                    Theme                                                                  === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" support italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

if (has('termguicolors'))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_italic = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_italicize_comments = 1
let g:gruvbox_improved_warnings =1
let g:gruvbox_improved_strings = 0
let g:gruvbox_invert_selection=0

let term_profile = $TERM_PROFILE

if term_profile == "Night"
    set background=dark
else
    set background=light
endif

colorscheme gruvbox

if (&background == 'dark')
  hi Visual guibg=#98971a guifg=#ebdbb2
else
  hi Visual guibg=#98971a guifg=#3c3836
endif

" ===                                                    LuaLine                                                                === "
" --------------------------------------------------------------------------------------------------------------------------------- "
lua << END
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
END

" ===                                                      Fern                                                                 === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" Disable netrw.
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
augroup END

function! s:hijack_directory() abort
  let path = expand('%:p')
  if !isdirectory(path)
    return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
endfunction

let g:fern#disable_default_mappings = 1
let g:fern#disable_drawer_auto_quit = 1
let g:fern#renderer#default#leading = "│"
let g:fern#renderer#default#root_symbol = "┬ "
let g:fern#renderer#default#leaf_symbol = "├─ "
let g:fern#renderer#default#collapsed_symbol = "├─ "
let g:fern#renderer#default#expanded_symbol = "├┬ "
let g:fern#mark_symbol = '✓'
"
" Toggle Fern on/off
noremap <silent> <C-n> :Fern . -drawer -width=35 -toggle -reveal=%<CR><C-w>=

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

" automatically update fern on entering
augroup FernTypeGroup
    autocmd! * <buffer>
    autocmd BufEnter <buffer> silent execute "normal \<Plug>(fern-action-reload)"
augroup END

" ===                                                 Fern Git Status                                                           === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:fern_git_status#disable_ignored = 1

" ===                                                    Vim-Fugitive                                                           === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" git blame
nmap <Leader>gb :Gblame<CR>
" git status
nmap <Leader>gs :G<CR>
" git diff
nmap <Leader>gd :Gdiffsplit<CR>
" git commit
nmap <Leader>gc :Gcommit<CR>
" git push
nmap <Leader>gp :Git push<CR>
" set vertical diff split
set diffopt+=vertical
" git diff for merge (3 tabs)
nmap <Leader>gm :Gdiffsplit!<CR>
" git merge select left
nmap <Leader>gf :diffget //2<CR>
" git merge select right
nmap <Leader>gh :diffget //3<CR>

" ===                                                   Git-Messenger                                                           === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:git_messenger_no_default_mappings = v:true
let g:git_messenger_into_popup_after_show = v:true
let g:git_messenger_close_on_cursor_moved = v:false
nmap <Leader>m <Plug>(git-messenger)
nmap <Leader>mc <Plug>(git-messenger-close)
nmap <Leader>j <Plug>(git-messenger-scroll-down-half)
nmap <Leader>k <Plug>(git-messenger-scroll-up-half)

" ===                                                  Gutentags                                                                === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ 'build',
      \ 'dist',
      \ 'bin',
      \ 'node_modules',
      \ 'cache',
      \ 'compiled',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" ===                                                    Tagbar                                                                 === "
" --------------------------------------------------------------------------------------------------------------------------------- "
nmap <Leader>tt :TagbarToggle<CR>

" Go
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Elixir
let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'p:protocols',
        \ 'm:modules',
        \ 'e:exceptions',
        \ 'y:types',
        \ 'd:delegates',
        \ 'f:functions',
        \ 'c:callbacks',
        \ 'a:macros',
        \ 't:tests',
        \ 'i:implementations',
        \ 'o:operators',
        \ 'r:records'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'p' : 'protocol',
        \ 'm' : 'module'
    \ },
    \ 'scope2kind' : {
        \ 'protocol' : 'p',
        \ 'module' : 'm'
    \ },
    \ 'sort' : 0
\ }

" Typescript
let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\}

" ===                                                      go                                                                   === "
" --------------------------------------------------------------------------------------------------------------------------------- "
au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.tmpl set filetype=gotexttmpl
au BufRead,BufNewFile *.html.tmpl set filetype=gohtmltmpl
au BufRead,BufNewFile go.mod set filetype=gomod
au BufRead,BufNewFile go.sum set filetype=gosum

" ===                                                    LSP                                                                    === "
" --------------------------------------------------------------------------------------------------------------------------------- "
lua << EOF
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
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
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
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
EOF

" ===                                                  FLOAT-PREVIEW                                                            === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:float_preview#docked = 0

" ===                                                    VIM-DELVE                                                              === "
" --------------------------------------------------------------------------------------------------------------------------------- "
nmap <silent> <Leader>b :DlvToggleBreakpoint<CR>
let g:delve_breakpoint_sign = "◉"
let g:delve_breakpoint_sign_highlight = "ALEErrorSign"
let g:delve_new_command = 'enew'
let g:delve_enable_syntax_highlighting = 1

" ===                                                    Spelunker                                                              === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
" depends on the setting of CursorHold `set updatetime=1000`.
let g:spelunker_check_type = 2

" ===                                                    ESLint                                                                 === "
" --------------------------------------------------------------------------------------------------------------------------------- "
nmap <silent> <Leader>El :execute '!eslint -c .eslintrc.js --fix ' . '"' . bufname('%') . '"'<CR>

" ===                                                    Silicon                                                                === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:silicon = {
      \   'theme': 'Nord',
      \   'font': 'Hack',
      \   'background': '#AAAAFF',
      \   'shadow-color': '#555555',
      \   'line-pad': 2,
      \   'pad-horiz': 80,
      \   'pad-vert': 100,
      \   'shadow-blur-radius': 0,
      \   'shadow-offset-x': 0,
      \   'shadow-offset-y': 0,
      \   'line-number': v:true,
      \   'round-corner': v:true,
      \   'window-controls': v:true,
      \ }

set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch

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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" My own settings:
set number
set listchars=trail:~,tab:>-
set list
set cursorline
set encoding=utf-8
set fileencoding=utf-8
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab smarttab
set foldmethod=syntax
set foldnestmax=5
set foldlevelstart=20
set spell spelllang=en_us
set ignorecase
set smartcase
set showmatch
map ; :

" vim-plug setup (https://github.com/junegunn/vim-plug)
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale' "turn on after https://github.com/fsharp/vim-fsharp/pull/82 completed
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-dispatch'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'heavenshell/vim-jsdoc'
" typescript
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" scss
Plug 'cakebaker/scss-syntax.vim'

Plug 'Quramy/vim-js-pretty-template'
"Plug 'fsharp/vim-fsharp', {
"      \ 'for': 'fsharp',
"      \ 'do':  'make fsautocomplete',
"      \}
Plug 'Yggdroot/indentLine'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mhinz/vim-signify'
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
Plug 'SirVer/ultisnips'

" Elixir/Phoenix
Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'

" deoplete
"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
" Initialize plugin system
call plug#end()

" deoplete
"let g:deoplete#enable_at_startup = 1

" ctrlp configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_root_markers = ['project.json', '\w+\.fsproj$', '\w+\.csproj$', '\w+\.sln$']
nnoremap <leader>. :CtrlPTag<cr>

" vinegar configuration
set wildignore+=*.*~
" vim-javascript configuration
let g:javascript_plugin_jsdoc = 1

" ale configuration
let g:ale_completion_enabled = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" Gruvbox color-scheme
:set bg=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
"
" airline setup
set laststatus=2

filetype plugin on

set completeopt=longest,menuone,preview
set previewheight=5

" fsharp settings
"let g:syntastic_fsharp_checkers=['syntax']
"let g:fsharp_helptext_comments = 1
"let g:fsharp_completion_helptext = 1

" typescript
let g:tsuquyomi_disable_quickfix = 1
let g:ale_linters = {
\   'typescript': ['tsserver'],
\}
"let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:tsuquyomi_shortest_import_path = 1
let g:tsuquyomi_single_quote_import= 1
nnoremap <silent> ,<space> :TsuImport<CR>
autocmd FileType typescript setlocal completeopt+=menu,preview

" Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

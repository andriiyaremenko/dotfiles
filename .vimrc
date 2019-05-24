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
set t_Co=256
map ; :

" vim-plug setup (https://github.com/junegunn/vim-plug)
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-dispatch'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'heavenshell/vim-jsdoc'

" git
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'

" typescript
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" autocompletion coc
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tslint-plugin', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-angular', {'do': 'yarn install'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile'}

" scss
" Plug 'cakebaker/scss-syntax.vim'

Plug 'Quramy/vim-js-pretty-template'
Plug 'Yggdroot/indentLine'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mhinz/vim-signify'
Plug 'othree/html5.vim'
Plug 'SirVer/ultisnips'

" Elixir/Phoenix
Plug 'elixir-editors/vim-elixir'
call plug#end()

" ctrlp configuration
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_root_markers=['project.json', '\w+\.fsproj$', '\w+\.csproj$', '\w+\.sln$']
nnoremap <Leader>. :CtrlPTag<cr>

" vinegar configuration
set wildignore+=*.*~
" vim-javascript configuration
" let g:javascript_plugin_jsdoc=1

" Gruvbox color-scheme
:set bg=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_termcolors=16
"
" airline setup
set laststatus=2

filetype plugin on

set completeopt=longest,menuone,preview
set previewheight=5

" Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" neoclide settings
let g:airline_section_error='%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning='%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" gitgutter
let g:gitgutter_sign_added='+'
let g:gitgutter_sign_modified='>'
let g:gitgutter_sign_removed='-'
let g:gitgutter_sign_removed_first_line='^'
let g:gitgutter_sign_modified_removed='<'
let g:gitgutter_override_sign_column_highlight=1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
" git next
nmap <Leader>gn <Plug>GitGutterNextHunk
" git previous
nmap <Leader>gp <Plug>GitGutterPrevHunk
" git add (chunk)
nmap <Leader>ga <Plug>GitGutterStageHunk
" git undo (chunk)
nmap <Leader>gu <Plug>GitGutterUndoHunk

" vimagit
" git status
nnoremap <Leader>gs :Magit<CR>
" git push
nnoremap <Leader>gP :! git push<CR>

" vim-fugitive
" git blame
nnoremap <Leader>gb :Gblame<CR>

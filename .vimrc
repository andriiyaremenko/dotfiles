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
set completeopt=longest,menuone,preview
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
syntax on " Switch syntax highlighting on, when the terminal has colors
set hlsearch " Also switch on highlighting the last used search pattern.
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
set bg=dark
set splitbelow " Set preview window to appear at bottom
set noshowmode " Don't dispay mode in command line (airilne already shows it)
set autoread " Automatically re-read file if a change was detected outside of vim
set redrawtime=10000
"set termguicolors
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
nnoremap <Leader><Leader> <c-^>

" ================================================================================================================================= "
" ===                                                    Plugin Installation                                                    === "
" ================================================================================================================================= "

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug setup (https://github.com/junegunn/vim-plug)
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
" ctgas
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

" git
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Language syntax highlight
Plug 'sheerun/vim-polyglot'

" typescript
Plug 'ianks/vim-tsx'

" lsp client
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'

Plug 'Quramy/vim-js-pretty-template'
Plug 'Yggdroot/indentLine'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mhinz/vim-signify'
Plug 'othree/html5.vim'
Plug 'SirVer/ultisnips'

" Elixir/Phoenix
Plug 'elixir-editors/vim-elixir'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" ================================================================================================================================= "
" ===                                                    Plugin Configuration                                                   === "
" ================================================================================================================================= "

" ===                                                    CtrlP                                                                  === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_root_markers=['project.json', 'mix.exs', '.gitignore']
nnoremap <Leader>. :CtrlPTag<CR>

" ===                                                    Theme                                                                  === "
" --------------------------------------------------------------------------------------------------------------------------------- "
colorscheme nord

" ===                                                    Airline                                                                === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1
"
" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter='unique_tail'
"
" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout=[['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

let g:airline#extensions#ale#enabled = 1

" ===                                                    Rainbow Parentheses                                                    === "
" --------------------------------------------------------------------------------------------------------------------------------- "
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ===                                                    NERDTree                                                               === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" Show hidden files/directories
let g:NERDTreeShowHidden=1
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI=1
" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore=['^\.DS_Store$', '^\.elixir_ls$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']
" Toggle NERDTree on/off
map <C-n> :NERDTreeToggle<CR>
" Opens current file location in NERDTree
nmap <leader>f :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ===                                                    GitGutter                                                              === "
" --------------------------------------------------------------------------------------------------------------------------------- "
let g:gitgutter_sign_added='+'
let g:gitgutter_sign_modified='>'
let g:gitgutter_sign_removed='-'
let g:gitgutter_sign_removed_first_line='^'
let g:gitgutter_sign_modified_removed='<'
let g:gitgutter_override_sign_column_highlight=1
" git next
nmap <Leader>gn <Plug>(GitGutterNextHunk)
" git previous
nmap <Leader>gp <Plug>(GitGutterPrevHunk)
" git add (chunk)
nmap <Leader>ga <Plug>(GitGutterStageHunk)
" git undo (chunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)

" ===                                                    ViMagit                                                                === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" git status
nnoremap <Leader>gs :Magit<CR>
" git push
nnoremap <Leader>gP :! git push<CR>

" ===                                                    Vim-Fugitive                                                           === "
" --------------------------------------------------------------------------------------------------------------------------------- "
" git blame
nnoremap <Leader>gb :Gblame<CR>

" ===                                                    Tagbar                                                                 === "
" --------------------------------------------------------------------------------------------------------------------------------- "
nmap <Leader>tt :TagbarToggle<CR>
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

" ===                                                    LSP                                                                    === "
" --------------------------------------------------------------------------------------------------------------------------------- "
augroup elixir_lsp
  au!
  au User lsp_setup call lsp#register_server({
    \ 'name': 'elixir-ls',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, '~/.vim/language-servers/elixir-ls/release/language_server.sh']},
    \ 'whitelist': ['elixir', 'eelixir'],
    \ })
augroup END
augroup fsharp_lsp
  au!
  au User lsp_setup call lsp#register_server({
    \ 'name': 'FSAC',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'dotnet ~/.vim/language-servers/FsAutoComplete/bin/release_netcore/fsautocomplete.dll']},
    \ 'whitelist': ['fsharp'],
    \ })
augroup END

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_signs_error = {'text': '✘'}
let g:lsp_signs_warning = {'text': '⚠'} " icons require GUI
let g:lsp_signs_hint = {'text': '!'} " icons require GUI
let g:lsp_highlights_enabled = 0
let g:lsp_textprop_enabled = 0
let g:lsp_highlight_references_enabled = 1
highlight link LspErrorText ALEErrorSign
highlight link LspWarningText ALEWarningSign
highlight link LspErrorLine ALEErrorSign
highlight link LspWarningLine ALEWarningSign

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
nmap <silent> <Leader>e <Plug>(lsp-next-error)
nmap <silent> <Leader>w <Plug>(lsp-next-warning)
nmap <silent> <Leader>D <Plug>(lsp-declaration)
nmap <silent> <Leader>d <Plug>(lsp-definition)
nmap <silent> <Leader>i <Plug>(lsp-implementation)
nmap <silent> <Leader>r <Plug>(lsp-references)
nmap <silent> <Leader>dd <Plug>(lsp-document-diagnostics)
" Use K to show documentation in preview window
nmap <silent> <Leader>K <Plug>(lsp-hover)
nmap <Leader>kd <Plug>(lsp-document-format)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

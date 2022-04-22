-----                                                    Automation                                                             -----
-------------------------------------------------------------------------------------------------------------------------------------

if vim.fn.empty(vim.fn.glob('~/.local/share/nvim/site/autoload/plug.vim')) > 0 then
    vim.execute(
        'silent sh -c '
        .. '\'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs'
        .. 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim\'')
    vim.cmd('autocmd VimEnter  * PlugInstall -' .. '-sync | source $MYVIMRC')
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

-----                                                   Installation                                                            -----
-------------------------------------------------------------------------------------------------------------------------------------

vim.call('plug#begin', '~/.config/nvim/plugged')

-- navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'simrat39/symbols-outline.nvim'

-- appearance
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'Yggdroot/indentLine'
Plug 'folke/lsp-colors.nvim'
Plug 'norcalli/nvim-colorizer.lua'

-- spell check
Plug 'kamykn/spelunker.vim'

-- git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'

-- typescript
Plug 'ianks/vim-tsx'

-- lsp client
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'folke/trouble.nvim'
Plug 'ray-x/lsp_signature.nvim'

-- tree-sitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- preview / floating window
Plug 'kamykn/popup-menu.nvim'

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

-- Terminal
Plug 'akinsho/toggleterm.nvim'

vim.call('plug#end')
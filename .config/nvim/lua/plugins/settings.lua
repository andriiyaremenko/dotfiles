local m = require "utils"
local create_augroup = m.create_augroup

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

-- automatically update fern on entering
create_augroup({
    { 'BufEnter', '<buffer>', 'silent', 'execute', '"normal <Plug>(fern-action-reload)"' }
}, 'FernTypeGroup')

-----                                                 Fern Git Status                                                           -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.g.fern_git_status = { disable_ignored = 1 }

-----                                                    Trouble                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
require("trouble").setup {
    icons = false,
    use_diagnostic_signs = true
}

-----                                                    Telescope                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
local trouble = require("trouble.providers.telescope")

require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.65 }
      -- other layout configuration here
    },
    mappings = {
      i = { ["<Leader>t"] = trouble.open_with_trouble },
      n = { ["<Leader>t"] = trouble.open_with_trouble },
    },
  },
  -- other configuration values here
})

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
    additional_vim_regex_highlighting = true
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
vim.g.delve_breakpoint_sign = "◉"
vim.g.delve_breakpoint_sign_highlight = "ALEErrorSign"
vim.g.delve_new_command = 'enew'
vim.g.delve_enable_syntax_highlighting = 1


-----                                                   Git-Messenger                                                           -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.g.git_messenger_no_default_mappings = true
vim.g.git_messenger_into_popup_after_show = true
vim.g.git_messenger_close_on_cursor_moved = true

-----                                                Symbols-Outline                                                            -----
-------------------------------------------------------------------------------------------------------------------------------------
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

-----                                                  Colorizer                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
require'colorizer'.setup({ '*' },
    {
        mode = 'foreground'; -- Set the display mode. Available modes: foreground, background
        RRGGBBAA = false;
    }
)

-----                                                  Toggleterm                                                               -----
-------------------------------------------------------------------------------------------------------------------------------------

require 'toggleterm'.setup{
    open_mapping = [[<C-c>]],
    direction = 'float',  -- options: 'vertical' | 'horizontal' | 'window' | 'float'
    float_opts = {
        border = 'curved' -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    }
}

local m                        = require 'utils'
local create_augroup           = m.create_augroup
local M                        = {}

local palette                  = require 'nightfox.palette'.load "nordfox"

-----                                                      Fern                                                                 -----
-------------------------------------------------------------------------------------------------------------------------------------
-- Disable netrw.
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
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
let g:fern#renderer#default#leading = '│'
let g:fern#renderer#default#root_symbol = '┬ '
let g:fern#renderer#default#leaf_symbol = '├─ '
let g:fern#renderer#default#collapsed_symbol = '├─ '
let g:fern#renderer#default#expanded_symbol = '├┬ '
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
  nmap <buffer> h <Plug>(fern-action-hidden:toggle)
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

-----                                                    Telescope                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
require 'telescope'.setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = {
            vertical = { height = 0.99, width = 0.85 }
            -- other layout configuration here
        },
    },
    -- other configuration values here
})

-----                                                    LuaLine                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
require 'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '╱', right = '╲' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'fern' },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {
            {
                'mode',
            }
        },
        lualine_b = { 'filename' },
        lualine_c = {
            'location',
            'progress',
            {
                'diagnostics',
                sources = { 'nvim_lsp' },
                sections = { 'error', 'warn' },
                symbols = { error = '✘ ', warn = '⚡' },
            }
        },
        lualine_z = { 'encoding', 'filetype' },
        lualine_y = {
            {
                'diff',
                colored = true, -- Displays a colored diff status if set to true
                symbols = { added = '+', modified = '±', removed = '-' }
            }
        },
        lualine_x = { 'branch' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

-----                                                    LSP-Lines                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
require 'lsp_lines'.setup()

-----                                                   Tree-Sitter                                                             -----
-------------------------------------------------------------------------------------------------------------------------------------
local configs = require 'nvim-treesitter.configs'
configs.setup {
    ensure_installed = {
        'markdown', 'markdown_inline',                                                            -- requierd by Lpsaga
        'go', 'gomod', 'gowork', 'comment', 'sql', 'json',                                        -- every day use
        'cmake', 'dockerfile', 'make', 'regex', 'toml', 'yaml', 'nix',                            -- configs
        'lua', 'bash', 'vim',                                                                     -- vim, dot files
        'c_sharp', 'ruby', 'solidity',                                                            -- i know this
        'elixir', 'erlang', 'heex', 'eex',                                                        -- i know this
        'http', 'javascript', 'json', 'jsdoc', 'html', 'css', 'scss', 'tsx', 'typescript', 'vue', -- i know this
        'c', 'cpp', 'rust', 'java', 'kotlin', 'php', 'python',
        'scala',                                                                                  -- don't know but might encounter
        'hcl',                                                                                    -- terraform
    },
    highlight = {
        -- enable highlighting
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
vim.g.spelunker_check_type = 1
vim.g.spelunker_highlight_type = 1
vim.g.enable_spelunker_vim_on_readonly = 0
vim.g.spelunker_disable_uri_checking = 1
vim.g.spelunker_disable_email_checking = 1
vim.g.spelunker_disable_acronym_checking = 1

-----                                                   Git-Messenger                                                           -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.g.git_messenger_no_default_mappings = true
vim.g.git_messenger_into_popup_after_show = true
vim.g.git_messenger_close_on_cursor_moved = true
vim.g.git_messenger_floating_win_opts = { border = 'single' }
vim.g.git_messenger_popup_content_margins = false


-----                                                      Go                                                                   -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.cmd 'au BufRead,BufNewFile *.go set filetype=go'
vim.cmd 'au BufRead,BufNewFile *.tmpl set filetype=gotexttmpl'
vim.cmd 'au BufRead,BufNewFile *.html.tmpl set filetype=gohtmltmpl'
vim.cmd 'au BufRead,BufNewFile go.mod set filetype=gomod'
vim.cmd 'au BufRead,BufNewFile go.sum set filetype=gosum'

-----                                                  Colorizer                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
require 'colorizer'.setup({ '*' },
    {
        mode = 'foreground', -- Set the display mode. Available modes: foreground, background
        RRGGBBAA = false,
    }
)

-----                                                  Toggleterm                                                               -----
-------------------------------------------------------------------------------------------------------------------------------------

require 'toggleterm'.setup {
    open_mapping = [[<C-c>]],
    direction = 'float',  -- options: 'vertical' | 'horizontal' | 'window' | 'float'
    float_opts = {
        border = 'curved' -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    }
}

local Terminal = require 'toggleterm.terminal'.Terminal
local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })

M.lazygit_toggle = function()
    lazygit:toggle()
end

-----                                                   LSP_Saga                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------

-- use default config
require 'lspsaga'.setup({
    ui = {
        code_action = "",
        -- same as nvim-lightbulb but async
        border = "rounded",
        winblend = 10,
    },
    lightbulb = {
        enable_in_insert = false,
        sign = false,
    },
    symbol_in_winbar = {
        enable = true,
    },
    outline = {
        auto_preview = false,
        keys = {
            jump = "o",
            expand_collapse = "t",
            quit = "q",
        },
    },
    diagnostic = {
        on_insert = false,
        show_virt_line = false,
        show_code_action = false,
        show_source = false,
    },
    code_action = {
        extend_gitsigns = true,
    },
    implement = {
        enable = true,
        sign = false,
    },
})

vim.cmd(string.format('hi SagaWinbarSep guibg=NONE guifg=%s', palette.blue.base))

-----                                                LSP_Signature                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
require "lsp_signature".setup {
    hint_prefix = "💡",
    floating_window = false,
}

-----                                              symbol-usage.nvim                                                            -----
-------------------------------------------------------------------------------------------------------------------------------------
local SymbolKind = vim.lsp.protocol.SymbolKind
local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

vim.api.nvim_set_hl(0, 'SymbolUsageRef', { bg = h('Normal').bg, fg = palette.green.dim, bold = false, italic = true })
vim.api.nvim_set_hl(0, 'SymbolUsageRefRound', { fg = h('Normal').bg })

vim.api.nvim_set_hl(0, 'SymbolUsageDef', { bg = h('Normal').bg, fg = palette.blue.dim, bold = false, italic = true })
vim.api.nvim_set_hl(0, 'SymbolUsageDefRound', { fg = h('Normal').bg })

vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { bg = h('Normal').bg, fg = palette.orange.dim, bold = false, italic = true })
vim.api.nvim_set_hl(0, 'SymbolUsageImplRound', { fg = h('Normal').bg })

local function text_format(symbol)
    local res = {}

    -- Indicator that shows if there are any other symbols in the same line
    local stacked_functions_content = symbol.stacked_count > 0
        and ("+%s"):format(symbol.stacked_count)
        or ''

    if symbol.implementation then
        if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
        end
        table.insert(res, { tostring(symbol.implementation) .. ' imps', 'SymbolUsageImpl' })
    end

    if symbol.definition then
        if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
        end
        table.insert(res, { tostring(symbol.definition) .. ' defs', 'SymbolUsageDef' })
    end

    if symbol.references then
        if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
        end
        local usage = symbol.references <= 1 and 'usage' or 'usages'
        local num = symbol.references == 0 and 'no' or symbol.references
        table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageRef' })
    end

    if stacked_functions_content ~= '' then
        if #res > 0 then
            table.insert(res, { ' ', 'NonText' })
        end
        table.insert(res, { ' ' .. tostring(stacked_functions_content), 'SymbolUsageImpl' })
    end

    return res
end

require "symbol-usage".setup {
    kinds = {
        SymbolKind.Function,
        SymbolKind.Method,
        SymbolKind.Interface,
        SymbolKind.Struct,
        SymbolKind.Constant,
        SymbolKind.Variable,
        SymbolKind.Class,
    },
    implementation = { enabled = false },
    text_format = text_format,
}

-----                                                gitsigns.nvim                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.g.signify_sign_change = '±'

vim.cmd(string.format('hi GitSignsAdd guibg=NONE guifg=%s', palette.green.base))
vim.cmd(string.format('hi GitSignsChange guibg=NONE guifg=%s', palette.yellow.base))
vim.cmd(string.format('hi GitSignsDelete guibg=NONE guifg=%s', palette.red.base))
vim.cmd(string.format('hi GitSignsTopdelete guibg=NONE guifg=%s', palette.red.base))
vim.cmd(string.format('hi GitSignsChangedelete guibg=NONE guifg=%s', palette.orange.base))
vim.cmd(string.format('hi GitSignsUntracked guibg=NONE guifg=%s', palette.black.dim))

require "gitsigns".setup {
    signs                        = {
        add          = { text = '+' },
        change       = { text = '±' },
        delete       = { text = '-' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    current_line_blame           = true,
    current_line_blame_formatter = '<author> • <author_time:%R> • <summary>',
}

-----                                                 Illuminate                                                                -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.cmd(string.format('hi IlluminatedWordText guibg=%s guifg=NONE', palette.black.bright))
vim.cmd(string.format('hi IlluminatedWordRead guibg=%s guifg=NONE', palette.black.bright))
vim.cmd(string.format('hi IlluminatedWordWrite guibg=%s guifg=NONE', palette.black.bright))

require 'illuminate'.configure {}

-----                                                NVIM-Surround                                                              -----
-------------------------------------------------------------------------------------------------------------------------------------
require 'nvim-surround'.setup {}

-----                                                 NVIM-notify                                                               -----
-------------------------------------------------------------------------------------------------------------------------------------
vim.notify = require 'notify'

-----                                               Dressing.nvim                                                               -----
-------------------------------------------------------------------------------------------------------------------------------------
require 'dressing'.setup {}

-----                                               TODO-comments                                                               -----
-------------------------------------------------------------------------------------------------------------------------------------
require 'todo-comments'.setup {}

-----                                                   Mason                                                                   -----
-------------------------------------------------------------------------------------------------------------------------------------
require "mason".setup()
require "mason-lspconfig".setup {
    ensure_installed = {
        'gopls',
        'golangci_lint_ls',
        'grammarly',
        'lua_ls',
        'tsserver',
        'bashls',
        'cmake',
        'dockerls',
        'terraformls',
        'tflint',
        'cssls',
        'html',
        'jsonls',
        'sqlls',
    }
}

-----                                                  go.nvim                                                                  -----
-------------------------------------------------------------------------------------------------------------------------------------
require 'go'.setup {
    icons = { breakpoint = '◉', currentpos = '' }
}

return M

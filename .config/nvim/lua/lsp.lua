local m = require 'utils'

-----                                                    LSP                                                                    -----
-------------------------------------------------------------------------------------------------------------------------------------
-- To override globally
local signs = { Error = '✘ ', Warn = '⚡', Hint = '💡', Info = '𝙞 ' }

for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = false
})

-----                                                 NVIM-LSPConfig                                                            -----
-------------------------------------------------------------------------------------------------------------------------------------

local lspconfig = require('lspconfig')
lspconfig.gopls.setup {
    settings = {
        gopls = {
            gofumpt = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            semanticTokens = true,
        },
    },
}
lspconfig.golangci_lint_ls.setup {}
lspconfig.grammarly.setup {}
lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', 'use' }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}
lspconfig.solargraph.setup {}
lspconfig.tsserver.setup {}
lspconfig.bashls.setup {}
lspconfig.cmake.setup {}
lspconfig.dockerls.setup {}
lspconfig.terraformls.setup {}
lspconfig.cssls.setup {}
lspconfig.html.setup {}
lspconfig.jsonls.setup {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Enable completion triggered by <c-x><c-o>
        local opts = { noremap = true, silent = true, buffer = ev.buf }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', '<Leader>D', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', '<Leader>kd', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('n', '<Leader>K', '<cmd>Lspsaga hover_doc<CR>', opts)
        vim.keymap.set('n', '<Leader>R', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<Leader>e', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<Leader>i', '<cmd>Telescope lsp_implementations<CR>', opts)
        vim.keymap.set('n', '<Leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
        vim.keymap.set('n', '<Leader>d', '<cmd>Telescope lsp_definitions<CR>', opts)
        vim.keymap.set('n', '<Leader>pd', '<cmd>Lspsaga peek_definition<CR>', opts)
        vim.keymap.set('n', '<Leader>r', '<cmd>Telescope lsp_references<CR>', opts)
        vim.keymap.set('n', '<Leader>dd', '<cmd>Telescope diagnostics<CR>', opts)

        -- Format on save
        m.create_augroup({ { 'BufWritePre', '*', 'lua vim.lsp.buf.format { async = true }' } }, 'LSPFormatOnSave')
    end,
})

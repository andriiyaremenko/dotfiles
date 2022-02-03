local m = require "utils"

-----                                                    LSP                                                                    -----
-------------------------------------------------------------------------------------------------------------------------------------
-- To override globally
local signs = { Error = "✘ ", Warn = "⚡", Hint = " ", Info = "𝙞 " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '❰'
    }
})
-----                                                  LSP-Installer                                                            -----
-------------------------------------------------------------------------------------------------------------------------------------
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local servers = {
  "gopls",
  "golangci_lint_ls",
  "grammarly",
  "sumneko_lua",
  "solargraph",
  "tsserver",
  "bashls",
  "cmake",
  "dockerls",
  "terraformls",
  "cssls",
  "html",
  "jsonls",
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
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

  -- Format on save
  m.create_augroup({ { 'BufWritePost', '*', 'lua vim.lsp.buf.formatting()' } }, 'LSPFormatOnSave')
end

-- Loop through the servers listed above.
for _, server_name in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available then
        server:on_ready(function ()
            -- When this particular server is ready (i.e. when installation is finished or the server is already installed),
            -- this function will be invoked. Make sure not to use the "catch-all" lsp_installer.on_server_ready()
            -- function to set up servers, to avoid doing setting up a server twice.
            local opts = {
              on_attach = on_attach,
              flags = {
                debounce_text_changes = 150,
              }
            }

            if server.name == "sumneko_lua" then
              opts = {
                on_attach = on_attach,
                flags = {
                  debounce_text_changes = 150,
                },
                settings = {
                  Lua = {
                    diagnostics = {
                      globals = { 'vim', 'use' }
                    },
                    workspace = {
                      -- Make the server aware of Neovim runtime files
                      library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
                    }
                  }
                }
              }
            end
            server:setup(opts)
        end)
        if not server:is_installed() then
            -- Queue the server to be installed.
            server:install()
        end
    end
end

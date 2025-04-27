local M = {}
-- map functions and options
M.keymap = vim.api.nvim_set_keymap

M.map = function(key, mapped_to, opts) M.keymap('', key, mapped_to, opts) end
M.nmap = function(key, mapped_to, opts) M.keymap('n', key, mapped_to, opts) end
M.imap = function(key, mapped_to, opts) M.keymap('i', key, mapped_to, opts) end

M.noremap = { noremap = true }
M.silent = { silent = true }
M.noremap_silent = { noremap = true, silent = true }

-- We will create a few autogroup, this function will help to avoid
-- always writing cmd('augroup' .. group) etc..
M.create_augroup = function(autocmds, name)
    vim.cmd('augroup ' .. name)
    vim.cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    vim.cmd('augroup END')
end

return M

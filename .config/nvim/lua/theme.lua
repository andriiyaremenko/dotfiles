if vim.fn.has('termguicolors') then
    vim.opt.termguicolors = true
end

local nightfox = require 'nightfox'

nightfox.setup({
    options = {
        styles = { -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            keywords = "bold",
            strings = "italic",
            types = "bold",
            conditionals = "bold",
        },
        modules = {
            lsp_saga = false,
        }
    },
    specs = {
        nordfox = {
            syntax = {
                bracket = "orange.bright", -- Brackets and Punctuation
                --builtin0 = "pink.bright", -- Builtin variable
                --builtin1 = "green.bright", -- Builtin type
                --builtin2 = "red.bright", -- Builtin const
                --field = "green.base",
                ident = "yellow.base", -- Identifiers
                regex = "yellow.bright",
                -- statement
                conditional = "green.base",
                --const = "red.base", --Constants, imports and booleans
                --func = "green.base",
                keyword = "red.base",
                number = "green.dim",
                operator = "orange.bright",
                string = "magenta.dim",
                type = "yellow.dim",
                --variable = "white.dim",
            },
        }
    },
})

local palette = require 'nightfox.palette'.load "nordfox"

vim.cmd(string.format('hi MyGreenText guibg=NONE guifg=%s', palette.green.base))
vim.cmd(string.format('hi MyYellowText guibg=NONE guifg=%s', palette.yellow.base))
vim.cmd(string.format('hi MyRedText guibg=NONE guifg=%s', palette.red.base))


vim.cmd 'colorscheme nordfox'

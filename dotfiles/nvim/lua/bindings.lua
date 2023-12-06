--[[  notes.

Refs:
 `vim.o`  behaves like `:set`
 `vim.go` behaves like `:setglobal`
 `vim.bo` behaves like `:setlocal` for buffer-local options
 `vim.wo` behaves like `:setlocal` for window-local options

`vim.api.nvim_set_keymap`  can be used for more fine grained control over
setting keymaps.
`vim.keymap.set`  makes things easier, by allowing a function in the `rhs`,
and always setting `noremap`. It is equivalent to:
 vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap=true})
ref. https://neovim.io/news/2022/04
ref. :h vim.keymap.set

--]]
vim.g.mapleader = ' '

local set = vim.keymap.set

set('n', '<leader>t',  ':sp | :term<CR>a')
set('t', '<C-w>',      '<C-\\><C-n><C-w>')

set('n', 'U', '<C-r>')
set('n', 'Y', 'y$')
set('i',  '<C-l>', '<C-x><C-l>')

set('n', '<leader>xa', ':wa | qa!<CR>')

set('n', '<leader>y', '"+y')
set('v', '<leader>y', '"+y')

set('n', '<leader>sp', ':set spell!<CR>')
set('n', '<leader>z', '1z=')

set('v', '<leader>col', '! column -L -t -s= -o=<CR>')

set('n', '-', '5<C-w><')
set('n', '+', '5<C-w>>')
set('n', '=', '<C-w>=')

set('n', '<C-e>', '3<C-e>')
set('n', '<C-y>', '3<C-y>')

set('n', '<leader>b', ':ls<CR>:b<Space>')
set('n', '<leader>n', ':bnext<CR>')

set('n', '[d', vim.diagnostic.goto_prev)
set('n', ']d', vim.diagnostic.goto_next)

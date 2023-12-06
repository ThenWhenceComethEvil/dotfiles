local opt_local = vim.opt_local
local api       = vim.api

opt_local.shiftwidth  = 2
opt_local.tabstop     = 2
opt_local.softtabstop = 2
opt_local.textwidth   = 80

vim.g.paredit_enable    = 1
vim.g.paredit_shortmaps = 0
-- I want to like these, but I use `J' and `O' pretty often. May just remap
-- things manually.

vim.keymap.set('n', '<leader>m', function ()
   local cmd = ':term chez --debug-on-exception --script ' .. vim.fn.expand('%:p')
   api.nvim_command(':w')
   api.nvim_command(':tabnew')
   api.nvim_command(':setlocal nonumber norelativenumber')
   api.nvim_command(cmd)
   api.nvim_buf_set_name(0, 'chez')
   api.nvim_command('')
   api.nvim_input('a')
end)

--                                   slimv
--------------------------------------------------------------------------------
vim.g.slimv_repl_split = 0
vim.g.slimv_ctags      = 'ctags -a *.scm'

--- Using contrib/swank-mit-scheme
--- For some reason slimv's swank server throws an exception on omnicomplete.
--- Also the debugger doesn't work here.
--[[
vim.g.slimv_unmap_tab = 1
vim.g.slimv_swank_cmd =
   ':tabnew | term mit-scheme --load ' ..
   '/home/aurelius/.local/share/nvim/site/pack/packer/opt/slimv/slime/contrib/swank-mit-scheme.scm'
--]]

-- Using built-in. Can determine command by setting the below...
--vim.g.scheme_builtin_swank = true
-- ...then running `:echo SLimvSwankCommand()`
-- Turns out this one won't enter the debugger, and sometimes doesn't print the
-- result of evaluated commands. Damn.
--[[
vim.g.slimv_swank_cmd  =
   ":tabnew | execute \"term mit-scheme --eval '(let loop () (start-swank) (loop))'\"" ..
   " | tabprevious | vs REPL"
--]]

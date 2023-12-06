vim.opt_local.shiftwidth  = 2
vim.opt_local.tabstop     = 2
vim.opt_local.softtabstop = 2
vim.opt_local.textwidth   = 80

-- Vertical split, REPL on the right
vim.g.slimv_repl_split = 4
vim.g.slimv_ctags      = 'ctags -a *.lisp'
vim.g.slimv_swank_cmd  =
   ':tabnew | term sbcl '                ..
      "--eval '(ql:quickload :swank)' "  ..
      "--eval '(swank:create-server :dont-close t)' "

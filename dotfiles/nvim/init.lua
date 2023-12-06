require('bindings')
require('options')

-- For some reason lazy.nvim throws a fucking fit if it's installed as a
-- regular plugin under site/pack/*/start/lazy.nvim, putting it with the rest
-- of lazy's plugins.

vim.opt.rtp:prepend(
   vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
)

require('lazy').setup('plugins', {
   root             = vim.fn.stdpath('data')   .. '/lazy/',
   lockfile         = vim.fn.stdpath('config') .. '/lazy-locks/lazy-lock.json',
   change_detection = {
      notify  = false,
   },
   ui = { border = 'double' },
   diff = { cmd = 'git' },
})

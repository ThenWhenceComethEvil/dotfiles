local opt = vim.opt
local g   = vim.g

vim.cmd.colorscheme('a')

-- Wondering if these should be set in colorscheme?
vim.cmd.set('t_Co=256')
opt.termguicolors  = true

opt.mouse          = nil
opt.fillchars      = 'fold:─,vert:│,diff:╲'
opt.backspace      = 'indent,eol,start'
opt.expandtab      = true
opt.shiftwidth     = 3
opt.tabstop        = 3
opt.softtabstop    = 3
opt.joinspaces     = false
opt.hlsearch       = false
opt.hidden         = true
opt.breakindent    = true
opt.scrolloff      = 3
opt.number         = true
opt.relativenumber = true
opt.undofile       = true
opt.ignorecase     = true
opt.smartcase      = true
opt.splitright     = true
opt.splitbelow     = false
opt.expandtab      = true
opt.shiftround     = true
opt.breakindent    = true
opt.breakindentopt = 'sbr'
opt.wildmenu       = true
opt.wildmode       = 'longest,full'
opt.wildoptions    = 'pum'
opt.spelllang      = 'en_us'
opt.cursorline     = true
opt.cursorlineopt  = 'number'
opt.virtualedit    = 'block'
opt.signcolumn     = 'no'
   -- this entirely disables the sign column. I
   -- currently hate it, though can see some use
   -- with LSPs or git integration.

g.netrw_keepdir  = 0
g.netrw_winsize  = -40

-- Highlight on yank. Iunno. Kinda good visual confirmation I guess.
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost',  {
   group    = 'YankHighlight',
   callback = function()
      vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '200' })
   end
})

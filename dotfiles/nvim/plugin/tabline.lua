--[[ ref.

Simple resource for understanding tablines.
https://github.com/seblj/nvim-tabline/blob/master/lua/tabline.lua

TODO:
   [ ] Split parts of path into dirname & basename, color differently

--]]

for group, hl in pairs({
   Tabline     = { fg = '#424242', bg = '#121212' },
   TablineFill = { bg = '#121212'                 },
   TablineSel  = { fg = '#c8ced5', bg = '#121212' },
}) do
   vim.api.nvim_set_hl(0, group, hl)
end

function Tabline ()
   local tl = ''

   for _,tab in ipairs(vim.fn.gettabinfo()) do
      local win_idx = vim.fn.tabpagewinnr(tab.tabnr)
      local win     = vim.fn.getwininfo(tab.windows[win_idx])[1]
      local buf     = vim.fn.getbufinfo(win.bufnr)[1]
      local name    = vim.fn.bufname(buf.bufnr)
      local active  = (tab.tabnr == vim.fn.tabpagenr())

      if name == '' then
         name = '[No Name]'
      end

      tl = table.concat({ tl,
         '%#Tabline', active and 'Sel#' or '#',
         '  ', tab.tabnr, '. ',
         name,
         '%( %M%)  %*',
      })
   end

   vim.cmd.redrawtabline()
   return tl
end

vim.opt.tabline = '%!v:lua.Tabline()'

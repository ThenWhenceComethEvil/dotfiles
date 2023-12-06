return {
   { 'mbbill/undotree',
      config = function (_, opts)
         vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle | UndotreeFocus<CR>')

         vim.cmd [[
            function g:Undotree_CustomMap()
               nmap <buffer> U <plug>UndotreeRedo
               nmap <buffer> < <plug>UndotreeNextSavedState
               nmap <buffer> > <plug>UndotreePreviousSavedState
            endfunc
         ]]

         vim.g.undotree_WindowLayout    = 2
         vim.g.undotree_SplitWidth      = 35
         vim.g.undotree_TreeVertShape   = '│'
         vim.g.undotree_DiffCommand     = 'diff'
         vim.g.undotree_HelpLine        = 0
         vim.g.undotree_ShortIndicators = 1
      end,
   }
}

return {
   { 'dcampos/nvim-snippy',
      opts = {
         enable_auto = true,
         mappings = {
            is = {
               ['<Tab>'] = 'expand_or_advance',
               ['<S-Tab>'] = 'previous',
            },
            nx = {
               ['<leader>x'] = 'cut_text',
            },
         }
      },
   }
}

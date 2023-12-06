return {
   { 'akinsho/toggleterm.nvim',
      keys = '<M-BS>',
      opts = {
         direction    = 'float',
         open_mapping = '<M-BS>',
         hide_numbers = true,
         float_opts   = {
            border = 'single',
            height = 40,
            width  = 120,
         },
         highlights = {
            NormalFloat = {
               guifg = '#a4aaaa',
               guibg = '#121212',
            },
            FloatBorder = {
               guifg = '#676b6b',
               guibg = '#121212',
            },
         }
      }
   }
}

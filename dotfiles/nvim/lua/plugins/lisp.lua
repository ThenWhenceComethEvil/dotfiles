return {
   { 'Olical/conjure',
      ft = { 'scheme' },
      config = function (_, opts)
         vim.g['conjure#log#hud#enabled'] = false

         vim.g['conjure#client#scheme#stdio#command']              = 'chez'
         vim.g['conjure#client#scheme#stdio#prompt_pattern']       = '> $?'
         vim.g['conjure#client#scheme#stdio#value_prefix_pattern'] = false

         -- Be more like slimv. I find the default options more verbose.
         vim.g['conjure#mapping#prefix']           = ','
         vim.g['conjure#mapping#eval_root_form']   = 'd'
         vim.g['conjure#mapping#eval_marked_form'] = 'm'
         vim.g['conjure#mapping#log_toggle']       = 't'
         vim.g['conjure#mapping#eval_buf']         = 'b'
         vim.g['conjure#mapping#eval_file']        = 'f'
         vim.g['conjure#mapping#eval_visual']      = 'r'

         -- colors.
         vim.g['conjure#eval#inline#highlight'] = 'Type'

         -- disable mappings.
         vim.g['conjure#mapping#doc_word'] = false  -- not supported
      end,
   },
   { 'kovisoft/slimv'   , ft = { 'lisp'   }},
   { 'kovisoft/paredit' , ft = { 'scheme' }},
}

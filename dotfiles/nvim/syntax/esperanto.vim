syn match  esperantoComment  "#.*$"             contains=@NoSpell
syn region esperantoEnglish  start='<' end='>'  contains=@NoSpell

hi link esperantoComment  Comment
hi link esperantoEnglish  _Gray

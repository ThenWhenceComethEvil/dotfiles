if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "hgcommit"

" The 50-character overflow is pretty much lifted from Tim Pope's gitcommit
" syntax.
syn match hgcommitFirstLine "\%^.*"               contains=@Spell   nextgroup=hgcommitComment   skipnl
syn match hgcommitSummary	 "^.*\%<51v."          contains=@Spell   contained containedin=hgcommitFirstLine nextgroup=hgcommitOverflow
syn match hgcommitOverflow	 ".*"                  contains=@Spell   contained 

syn match hgcommitComment   "^HG:.*$"             contains=@NoSpell
syn match hgcommitUser      "^HG: user: \zs.*$"   contains=@NoSpell contained containedin=hgcommitComment
syn match hgcommitBranch    "^HG: branch \zs.*$"  contains=@NoSpell contained containedin=hgcommitComment
syn match hgcommitAdded     "^HG: added \zs.*$"   contains=@NoSpell contained containedin=hgcommitComment
syn match hgcommitChanged   "^HG: changed \zs.*$" contains=@NoSpell contained containedin=hgcommitComment
syn match hgcommitRemoved   "^HG: removed \zs.*$" contains=@NoSpell contained containedin=hgcommitComment

hi def link hgcommitOverflow  ErrorMsg
hi def link hgcommitComment   Comment
hi def link hgcommitUser      String
hi def link hgcommitBranch    String
hi def link hgcommitAdded     TypeDef
hi def link hgcommitChanged   String
hi def link hgcommitRemoved   Type

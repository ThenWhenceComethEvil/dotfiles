" Vim syntax file
" Language:    .hgignore
" Maintainer:  gisphm <phmfk@hotmail.com>
" URL:         https://github.com/gisphm/vim-hgignore

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
    finish
endif
let b:current_syntax = 'hgignore'

setlocal commentstring=#%s

syn keyword	hgignoreTodo	contained TODO FIXME XXX
" Avoid matching "text#text", used in /etc/disktab and /etc/gettytab
syn match	hgignoreComment	"^#.*" contains=hgignoreTodo
syn match	hgignoreComment	"\s#.*"ms=s+1 contains=hgignoreTodo
syn region	hgignoreString	start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline
syn region	hgignoreDirectory	start=+"+ skip=/\v\\./ end="/" oneline

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link hgignoreComment	Comment
hi def link hgignoreTodo	Todo
hi def link hgignoreString	String
hi def link hgignoreDirectory	Include

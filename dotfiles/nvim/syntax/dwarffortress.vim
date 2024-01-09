" vim: nowrap
"
" SOURCE:
" https://github.com/kazimuth/dwarffortress.vim
" Then lightly customized by me.
"
" LICENSE:
" Copyright (c) 2017 James Gilles
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

if exists("b:current_syntax")
    finish
endif

" header should match filename
" don't bother to cope with name changes
syn match dfHeaderError contained '\v%^.*$'
exe 'syn match dfHeader contained ''\V\%^'.expand('%:t:r').'\$'''

" the whole file is a "comment" that contains other things
" note that this starts at the beginning and ends of lines, but does NOT have
" keepend, so contents can be longer than a single line
" this keeps the hilighting from breaking when earlier parts of the file are
" ignored
syn region dfDefaultComment start='\v^' end='\v$' contains=dfHeaderError,dfHeader,dfObjectToken,dfObjectDefToken,dfTokenGeneric

" all tokens match this
syn match dfTokenGeneric contained '\v\[[^\[\]]*\]' contains=@dfTokenSeps,dfTokenFront,dfNumber,dfChar,dfEnum,dfKwarg

syn match dfTokenStart '\v\[' contained
syn match dfTokenEnd '\v\]' contained
syn match dfTokenSep '\v:' contained
syn cluster dfTokenSeps contains=dfTokenStart,dfTokenEnd,dfTokenSep

" defines dfEnum, which is all special NAMES built-in to the game
" that don't start tokens (e.g. ALL)
" you have to compile this by hand, sorry
syn include syntax/dwarffortressenum.vim

" generic token handling
" first element of token
syn match dfTokenFront contained '\v\[[^\[\]:]*' contains=dfTokenName,@dfTokenSeps
" defines dfTokenName, which holds the [FIRST_WORD: of all tokens
" to update with new raws:
"   $ cd df_linux # or equivalent
"   $ grep -P '(?<=\[)[^\]\[\:]+' data/init/*.txt raw/graphics/*.txt raw/objects/*.txt -oh \
"       | sort | uniq | gsed ':a;N;$!ba;s/\n/ /g' | gfold -s | gsed 's/CONTAINS//g' \
"       | gsed 's/^/syn keyword dfTokenName contained /' \
"       > /path/to/dwarffortress.vim/syntax/dwarffortresstokens.vim
"
" (where gsed and gfold are the gnu versions of sed and fold)
syn include syntax/dwarffortresstokens.vim

syn match dfNumber '\v[0-9]+( |:|\])@=' contained
syn match dfChar  +\v'.'+ contained

" names often used as keyword-arguments [...:BY_CATEGORY:BEES] or whatever
syn keyword dfKwarg contained BY_CATEGORY BY_TYPE BY_TOKEN SEV PROB BP

" pull the object header from the current file
let s:object_type_regex = '\v\[\s*OBJECT\s*:\s*\zs\i+\ze\s*\]'
let [s:lnum, s:col] = searchpos(s:object_type_regex, 'n')

if s:lnum
    " we have a match!
    let s:object_type = matchstr(getline(s:lnum), s:object_type_regex)

    " higher priority than a generic token (since we're lower in this file)
    syn match dfObjectToken contained '\v\[\s*OBJECT\s*:\s*\i+\s*\]' contains=@dfTokenSeps,dfObjectType

    exe 'syn match dfObjectDefToken contained ''\v\[\s*'.s:object_type.'\s*:\s*\i+\s*\]'' contains=@dfTokenSeps,dfObjectType'

    if s:object_type ==? 'ITEM'
        syn keyword dfObjectType ITEM ITEM_AMMO ITEM_ARMOR ITEM_FOOD ITEM_GLOVES
        syn keyword dfObjectType ITEM_HELM ITEM_INSTRUMENT ITEM_PANTS ITEM_SHIELD
        syn keyword dfObjectType ITEM_SHOES ITEM_SIEGEAMMO ITEM_TOOL ITEM_TOY ITEM_TRAPCOMP
        syn keyword dfObjectType ITEM_WEAPON
    else
        exe 'syn keyword dfObjectType '.toupper(s:object_type)
    endif
endif

hi link dfDefaultComment   Comment
hi link dfHeader           Underlined
hi link dfObjectToken      Special
hi link dfObjectType       Structure
hi link dfObjectDefToken   Identifier
hi link dfTokenStart       Delimiter
hi link dfTokenEnd         Delimiter
hi link dfTokenSep         Delimiter
hi link dfKwarg            Statement
hi link dfTokenName        Statement
hi link dfTokenGeneric     Type
hi link dfEnum             Type
hi link dfNumber           Number
hi link dfChar             String

" unrecognized tokens are errors
hi link dfTokenFront    ErrorMsg
hi link dfHeaderError   Error

let b:current_syntax = "dwarffortress"

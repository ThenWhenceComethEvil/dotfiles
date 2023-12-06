" vim: ft=vim
"
" Originally written in Lua (disable/statusline.lua.disable), but was having
" some trouble in which the UI would periodically get sluggish. As if it was
" trying to run a stupid number of events on every update. Was super hard to
" diagnose when/why it was happening.
"
" Until such time as I need anything more fancy, this will serve nicely.
"
" GASP. Narrowed it down to a problem in the treesitter comment parser. It was
" having a really hard time with lua's --[[ ... ]] comments.

set noshowmode
set laststatus=2
set showcmdloc=statusline

function! Statusline_Current_Mode()
   return get({
      \ 'n'  : '%#Statusline_Mode_Normal# NORMAL ',
      \ 'i'  : '%#Statusline_Mode_Insert# INSERT ',
      \ 's'  : '%#Statusline_Mode_Select# SELECT ',
      \ 'r'  : '%#Statusline_Mode_Replace# REPLACE ',
      \ 'c'  : '%#Statusline_Mode_Command# COMMAND ',
      \ 't'  : '%#Statusline_Mode_Terminal# TERMINAL ',
      \ 'v'  : '%#Statusline_Mode_Visual# VISUAL ',
      \ '' : '%#Statusline_Mode_Visual# VISUAL ',
      \}, tolower(mode()), '')
endfunction


function! Statusline_Active ()
   " Mode (INSERT/NORMAL/...)
   setlocal statusline=%{%Statusline_Current_Mode()%}

   " Filename.
   setlocal statusline+=%#NOHL#
   setlocal statusline+=\ %f%(\ [%R%H]%)%(\ %M%)

   " showcmdloc
   setlocal statusline+=%=%(\ %S\ %)

   " Cursor line:column information.
   setlocal statusline+=%#Statusline_Cursor#
   setlocal statusline+=\ %4.l:%-3.c

   " filetype, file%
   setlocal statusline+=\ %#Statusline_Filetype#
   setlocal statusline+=\ %{&filetype}\ %3.p%%
endfunction


function! Statusline_Inactive ()
   setlocal statusline=\ %F%(\ [%R%H]%)%(\ %M%)
endfunction


augroup Statusline
   autocmd!
   autocmd WinLeave,BufLeave * call Statusline_Inactive()
   autocmd WinEnter,BufEnter * call Statusline_Active()
augroup END

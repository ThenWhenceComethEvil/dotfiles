#!/bin/bash
# shellcheck disable=SC2207

function __dot_deploy {
   local base
   base=$(realpath "$(which dot)")
   local database="${base%/*}/database"
   local curr="${COMP_WORDS[$COMP_CWORD]}"

   local -a opts=()
   while IFS=$'\t' read -r src _ ; do
      opts+=( "$src" )
   done < "$database"

   COMPREPLY=( $(compgen -W "${opts[*]}" -- "${curr}") )
}

function __dot {
   local curr="${COMP_WORDS[$COMP_CWORD]}"

   local -a cmds=(
      add
      deploy
      tree
      ls
      validate
      diff
      hg
   )

   if (( COMP_CWORD == 1 )) ; then
      COMPREPLY=( $(compgen -W "${cmds[*]}" -- "${curr}") )
      return
   fi

   case "${COMP_WORDS[1]}" in
      add)
         compopt -o default ;;

      deploy)
         __dot_deploy ;;
   esac

}

complete -F __dot dot

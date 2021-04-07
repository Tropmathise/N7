#!/bin/bash
 
function arbre {
   if [ $1 = "-d" ]; then
      local dir=${2:-.} espace=$3 f
      for f in "$dir"/*; do
         [ -e "$f" ] || continue
         if [ -d "$f" ]; then
            printf '%sDossier: %q\n' "$espace" "${f##*/}"
            arbre "-d" "$f" "${espace}    "
         fi
      done
   else 
      local dir=${1:-.} espace=$2 f
      for f in "$dir"/*; do
         [ -e "$f" ] || continue
         if [ -d "$f" ]; then
            printf '%sDossier: %q\n' "$espace" "${f##*/}"
            arbre "$f" "${espace}    "
         else
            printf '%sFichier: %q\n' "$espace" "${f##*/}"
         fi
      done
   fi
}

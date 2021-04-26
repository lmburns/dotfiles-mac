#!/bin/zsh

# desc: script to preview all scripts in mybin

setopt localoptions extendedglob

local -a fs files lines desc
fs=( $HOME/mybin/**/* )
# fs=( $(fd --full-path "$HOME/mybin" -tx) )

# fs=( "*~$HOME/mybin/*" )   # ungrouped commands

integer pass longest=0 longest2=0
local p file header="# desc: "

for (( pass = 1; pass <= 2; ++ pass )); do
  for p in "${fs[@]}"; do
    files=( $HOME/mybin/${~p}*(N) )
    # if (( pass == 2 )); then
    #   if (( ${#files[@]} )); then
    #     print -r -- ${(l:longest+longest2::-:):-}
    #   fi
    # fi
    for file in "${files[@]}"; do
      [[ -d "$file" ]] && continue
      lines=( ${(f)"$(<$file)"} )
      desc=( "${(M)lines[@]:#${header}*}" )
      desc[1]=${desc[1]#$header}
      file="${file:t}"
      [[ "$file" = (LICENSE|README.md) ]] && continue
      if (( pass == 1 )); then
        (( longest < ${#file} + 3 )) && longest=$(( ${#file} + 3 ))
        (( longest2 < ${#desc[1]} )) && longest2=$(( ${#desc[1]} ))
      else
        echo "${file}${(l:longest-${#file}:: :): }${desc[1]}"
      fi
    done
  done
  # if (( pass == 2 )); then
  #     print -r -- ${(l:longest+longest2::-:):-}
  # fi
done

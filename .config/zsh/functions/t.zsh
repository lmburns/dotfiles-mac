#!/usr/bin/env zsh

zparseopts -D -F -a opt 'f' '-fzf' 't' '-twf'

if [[ "${(M)opt[@]:#-(f|-fzf)}" == -(f|-fzf) ]]

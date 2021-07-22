# Desc: fzf rip undo

undo=$(rip -s | fzf --delimiter / --with-nth 7..)

[[ -n $undo ]] && rip -u "$undo" ||
  builtin print -Pr "%F{2}Nothing undone%f"

# vim: ft=zsh:et:sw=0:ts=2:sts=2:fdm=marker:fmr={{{,}}}:

# zshexpn -- zsh -o SOURCE_TRACE -lic ''
# sed -n l -- infocmp -L1 -- zle -L

builtin bindkey -v

# bindkey -M vicmd 'ys' add-surround
# bindkey '^I' expand-or-complete-prefix
# bindkey '^a' autosuggest-accept

autoload -Uz edit-command-line
zle -N edit-command-line

autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround

per-dir-fzf() {
  if [[ $_per_directory_history_is_global ]]; then
    per-directory-history-toggle-history; fzf-history-widget
  else
    fzf-history-widget
  fi
}

zle -N per-dir-fzf       # fzf history
zle -N fcq
# zle -N fcd-zle
# zle -N bow2
zle -N pw

if [[ $TMUX ]]; then
  zle -N t
  vbindkey 'M-t' t                       # alt-t
  zle -N wfxr::tmux-select-window
  vbindkey 'M-S-w' wfxr::tmux-select-window # alt-w
fi

# Available modes: all normal modes, str, @, -, + (see marlonrichert/zsh-edit)
typeset -gA keybindings; keybindings=(
  'Home'          beginning-of-line
  'End'           end-of-line
  'Delete'        delete-char
  'F1'            dotbare-fstat
  'F2'            db-faddf
  'F3'            _wbmux
  'Esc-e'         wfxr::fzf-file-edit-widget
  'M-r'           per-dir-fzf
  'M-p'           pw                    # fzf pueue
  'C-a'           autosuggest-execute
  'C-z'           fancy-ctrl-z
  'C-x r'         fz-history-widget
  'C-x C-f'       fz-find
  'C-x C-e'       edit-command-line-as-zsh
  'C-x C-x'       execute-command
  'C-x C-q'       cd-fzf-ghqlist-widget # cd ghq fzf
  'C-x C-b'       fcq                   # copyq fzf
  'mode=vicmd u'  undo
  'mode=vicmd U'  redo
  'mode=vicmd E'  backward-kill-line
  'mode=vicmd L'  end-of-line
  'mode=vicmd H'  beginning-of-line
  'mode=vicmd ?'  which-command
  'mode=vicmd c.' vi-change-whole-line
  'mode=vicmd ds' delete-surround
  'mode=vicmd cs' change-surround
  'mode=viins jk' vi-cmd-mode
  'mode=viins kj' vi-cmd-mode
  'mode=visual S' add-surround
  'mode=str M-u'  frd                   # cd interactively recent dir
  'mode=str M-t'  t                     # tmux wfxr
  'mode=@ C-o'    lc                    # lf change dir
  'mode=@ C-b'    bow2                  # surfraw open w3m
  'mode=@ M-;'    fcd                   # cd interactively
  'mode=@ M-,'    'zoxide query -i'
)

# 'M-c'     _call_navi
# 'M-n'     _navi_next_pos

vbindkey -A keybindings

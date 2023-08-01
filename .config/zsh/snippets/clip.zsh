function detect-clip() {
  emulate -L zsh
  # function ccopy()  { xsel -bi --trim < "${1:-/dev/stdin}"; }
  # function cpaste() { xsel -b; }
  function ccopy()  { pbcopy < "${1:-/dev/stdin}"; }
  function cpaste() { pbpaste; }
}

detect-clip || true

if (( $+commands[copyq] )); then
    # @desc: copyq zle (insert contents)
    function __fzf-copyq() {
      typeset -g REPLY
      REPLY=$(\
        copyq eval -- \
          "tab('&clipboard'); for(i=size(); i>0; --i) print(str(read(i-1)) + '\n');" \
          | rg -v '^\s*$' \
          | nl -w2 -s" " \
          | tac \
          | fzf --layout=reverse --multi --prompt='Copyq> ' --tiebreak=index \
          | perl -pe 's/\d+\s?//g && chomp if eof'
      )
    }

    function :fzf-copyq() {
        __fzf-copyq
        BUFFER="$BUFFER$REPLY"
        CURSOR="$#BUFFER"
        zle redisplay
    }
    zle -N :fzf-copyq
    Zkeymaps+=('mode=vicmd ;v' :fzf-copyq)

    # @desc: use copyq to view clipboard history (non-tmux)
    function fzf-copyq() {
        __fzf-copyq
        xsel -b --input --trim <<< $REPLY
        zle redisplay
    }
    zle -N fzf-copyq
    Zkeymaps+=('C-x C-g' fzf-copyq)
fi

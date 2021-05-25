# Tmux switch session
function wfxr::tmux-switch() {
    [[ ! $TMUX ]] && return 1 # Not in tmux session
    local preview curr choice &&
        preview='<<< {} awk "{print \$2}" | xargs tmux list-windows -t | sed "s/\[.*\]//g" | column -t | sed "s/  \(\S\)/ \1/g"' &&
        curr=$(tmux display-message -p "#S") &&
        choice=$(tmux ls -F "#{session_name}" | grep -v $curr | nl -w2 -s' ' \
            | fzf-tmux +s -e -1 -0 --height=14 --header="  * $curr" \
                              --bind 'alt-t:down' --cycle \
                              --preview="$preview" \
                              --preview-window=right:60%) &&
        tmux switch-client -t $(awk '{print $2}' <<<"$choice") 2>/dev/null
}
# Tmux attach session
function wfxr::tmux-attach() {
    [[ $TMUX ]] && return 1 # Already in tmux session
    local preview choice &&
        preview='<<< {} awk "{print \$2}" | xargs tmux list-windows -t | sed "s/\[.*\]//g" | column -t | sed "s/  \(\S\)/ \1/g"' &&
        choice=$(tmux ls -F "#{session_name}" | nl -w2 -s' ' \
            | fzf +s -e -1 -0 --height=14 \
                              --bind 'alt-t:down' --cycle \
                              --preview="$preview" \
                              --preview-window=right:60%) &&
        tmux attach-session -t $(awk '{print $2}' <<<"$choice") 2>/dev/null
}
# Tmux select window
function wfxr::tmux-select-window() {
    [[ ! $TMUX ]] && return 1
    local curr choice &&
        curr=$(tmux display-message -p "#W") &&
        choice=$(tmux list-windows -F "#I #W #F" | grep -v '*' | awk '{printf "%2d %s\n", $1, $2}' \
        | fzf-tmux +s -e -1 -0 --height=10 --header=" * $curr"\
                          --bind 'alt-w:down' --cycle) &&
        tmux select-window -t $(awk '{print $2}' <<<"$choice") 2>/dev/null
        zle redisplay 2>/dev/null || true
}
# Tmux attach or create target session
function t() {
    if [[ $# -eq 0 ]]; then
        if [[ $TMUX ]]; then
            wfxr::tmux-switch
        else
            if tmux list-sessions &>/dev/null; then
                wfxr::tmux-attach
            else
                tmux new-session -A -s "misc"
            fi
        fi
    else
        if [[ $TMUX ]]; then
            if ! tmux has-session -t "$1" 2>/dev/null; then
                tmux new-session -d -s "$1"
            fi
            tmux switch-client -t "$1"
        else
            tmux new-session -A -s "$1"
        fi
    fi
    zle redisplay 2>/dev/null || true
}
# https://issue.life/questions/37597191
bindkey -s '†' 't\n'

if [[ $TMUX ]]; then
    zle -N t
    bindkey '†' t                       # alt-t
    zle -N wfxr::tmux-select-window
    bindkey '∑' wfxr::tmux-select-window # alt-w
fi

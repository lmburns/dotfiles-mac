 # ______     ______     __  __     ______     ______
# /\___  \   /\  ___\   /\ \_\ \   /\  == \   /\  ___\
# \/_/  /__  \ \___  \  \ \  __ \  \ \  __<   \ \ \____
 #  /\_____\  \/\_____\  \ \_\ \_\  \ \_\ \_\  \ \_____\
 #  \/_____/   \/_____/   \/_/\/_/   \/_/ /_/   \/_____/

# MacOS: Speeed up ZSH `sudo rm -rf /private/var/log/asl/*.asl`

# === general settings === {{{
export LC_ALL="en_US.UTF-8"
export ZSH_DISABLE_COMPFIX=true
export HISTSIZE=10000000
export HISTFILE="$HOME/.cache/zsh/zsh_history"
export SAVEHIST=10000000
export HIST_STAMPS="yyyy-mm-dd"
export HISTORY_FILTER_EXCLUDE=("jrnl", "cd")
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH="$XDG_CONFIG_HOME/zsh/oh-my-zsh"
export ZINIT_HOME="$ZDOTDIR/zinit"
export GENCOMP_DIR="$ZDOTDIR/completions"

typeset -A ZINIT=(
    BIN_DIR         $ZDOTDIR/zinit/bin
    HOME_DIR        $ZDOTDIR/zinit
    COMPINIT_OPTS   -C
)

# compinit -u -d "${ZDOTDIR}/.zcompdump_${ZSH_VERSION}"
autoload -Uz zmv zcalc
alias zmv='noglob zmv -W'

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(osx)

[ -f "$ZSH/oh-my-zsh.sh" ] && source $ZSH/oh-my-zsh.sh
[ -f "$ZDOTDIR/zsh-aliases" ] && source "$ZDOTDIR/zsh-aliases"
# }}}

# === powerlevel10k === {{{
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ -f "$ZDOTDIR/.p10k.zsh" ] && source "$ZDOTDIR/.p10k.zsh"
# }}}

# === zinit === {{{
# http://zdharma.org/zinit/wiki/INTRODUCTION/
if [[ ! -f $ZINIT_HOME/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma/zinit "$ZINIT_HOME/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$ZINIT_HOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/autojump/autojump.plugin.zsh
zinit snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh
zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zinit snippet OMZ::plugins/zsh_reload/zsh_reload.plugin.zsh
zinit ice wait lucid; zinit load hlissner/zsh-autopair
zinit ice as "completion" zinit snippet OMZ::plugins/pass/_pass

zinit light-mode for \
    aloxaf/fzf-tab \
    zsh-users/zsh-syntax-highlighting \
    wfxr/forgit \
    michaelaquilina/zsh-history-filter \
    aloxaf/gencomp \
    kazhala/dotbare \
    andrewferrier/fzf-z \
    blockf \
        zsh-users/zsh-completions \
    src="etc/git-extras-completion.zsh" \
        tj/git-extras

# zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX" nocompile
# zinit light tj/git-extras

zinit ice silent wait"1"; zinit light supercrabtree/k

zinit wait lucid atload'_zsh_autosuggest_start' light-mode for \
    zsh-users/zsh-autosuggestions

compdef _dotbare_completion_git dotbare
autoload -Uz compinit && compinit
# zinit cdreplay -q
# }}}

# === zsh keybindings === {{{
bindkey '^a' autosuggest-accept
bindkey '^x' autosuggest-execute
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey -s '^o' 'lfcd\n'
bindkey -M vicmd '^h' run-help
bindkey -M vicmd '?' which-command

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd 'H' beginning-of-line; bindkey -M vicmd 'L' end-of-line

# === fzf tab completion ===
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
# }}}

# === fixes / sourcing === {{{
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# coommand-not-found
# HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
# [ -f "$HB_CNF_HANDLER" ] && source "$HB_CNF_HANDLER"

# fzf fix
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "$XDG_CONFIG_HOME/zsh/lficons" ] && source "$XDG_CONFIG_HOME/zsh/lficons"
[ -f "$XDG_CONFIG_HOME/broot/launcher/bash/br" ] && source "$XDG_CONFIG_HOME/broot/launcher/bash/br"
# }}}

# === $PATH additions {{{
# === mysql ===
export PATH=${PATH}:/usr/local/mysql/bin/

# === homebrew ===
export PATH="/usr/local/bin:$PATH"

# === mybin ===
export PATH="/usr/local/mybin:$PATH"
# }}}

# === conda initialize === {{{
__conda_setup="$('/Users/lucasburns/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lucasburns/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lucasburns/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lucasburns/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# }}}

# === functions === {{{
# prevent failed commands from being added to history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
# fzf search for file and open in vim
vf() { fzf | xargs -r -I % $EDITOR % ; }
# rsync from local pc to server
rsyncto() { rsync -uvrP $1 root@burnsac.xyz:$2 ; }
rsyncfrom() { rsync -uvrP root@burnsac.xyz:$1 $2 ; }
# open fzf in a directory and open file in vim
fzfd() { find $1 | fzf | xargs -r -I % $EDITOR % ; }
# fzf pdfs and open with zathura
fzfz() { fd -a -e "pdf" . $1 | fzf | (nohup xargs -I{} zathura "{}" >/dev/null) }
# shred and delete file
sshred() { find $1 -type f -exec shred -v -n 1 -z -u  {} \; }
# start asciinema recording
asciir() { asciinema rec $1; }
# grep processes with color
pss() { ps aux | rg --color always -i $1 | rg -v rg }
# grep processes with headers
psgrep() { ps up $(pgrep -f $@) 2>&-; }
# menubar notifier
mbn() { (nohup mn $1 >/dev/null &) }
# create py file to sync with ipynb
jupyt() { jupytext --set-formats ipynb,py $1 }
# howdoi
h() { howdoi $@ -c -n 5; }
hless() { howdoi $@ -c | less --raw-control-chars --quit-if-one-screen --no-init; }
pdf() { pdftotext -nopgbrk $1 - }
# us up pipe with any file
upp() { cat $1 | up }
# crypto
ratesx() { curl rate.sx/$1 }
# directory size information
gstatt() { gstat $1 || stat $1; echo ; du -sh $1 ; echo ; file -I -b -p $1 }
# backup files
bak() { /usr/local/bin/gcp --force --suffix=.bak $1 $1 }
# link file from mybin to $PATH
lnbin() { ln -siv $HOME/mybin/$1 /usr/local/mybin }
# broot fuzzy jump
dcd() { br --only-folders --cmd "$1;:cd" }
btree() { br -c :pt "$@" }


# use lf to switch directories
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
# }}}

#===== variables ===== {{{
eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"
eval "$(fakedata --completion zsh)"

# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER="nvim -c 'set ft=man' -"
export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
export BROWSER='open -a LibreWolf'
export RTV_BROWSER="w3m"
export EDITOR='nvim'

export VIMRC="$XDG_CONFIG_HOME/nvim/init.vim"
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/notmuch-config"
export TASKRC="$XDG_CONFIG_HOME/task/taskrc"
export TASKDATA="$XDG_CONFIG_HOME/task"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
# export CARGO_HOME="$XDG_DATA_HOME/cargo"
export R_HISTFILE="$XDG_CONFIG_HOME/r/Rhistory"
export R_PROFILE_USER="$XDG_CONFIG_HOME/r/Rprofile"
export LESSHISTFILE="-"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PASSWORD_STORE_ENABLE_EXTENSIONS='true'
export GETOPT="/usr/local/opt/gnu-getopt/bin/getopt"
export HOMEBREW_NO_ANALYTICS=1
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export FZFZ_RECENT_DIRS_TOOL='autojump'

export FZF_DEFAULT_OPTS="
    --reverse --height 50% --border --ansi --info=inline --multi
    --preview-window=:hidden
    --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
    --bind '?:toggle-preview'
    --bind 'ctrl-a:select-all'
    --bind 'ctrl-b:execute(bat --paging=always -f {+})'
    --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
    --bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
    --bind 'ctrl-v:execute(code {+})'
    "
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FORGIT_FZF_DEFAULT_OPTS="--exact --cycle --border --ansi --reverse
    --height 70% --info=inline --multi"
export NAVI_FZF_OVERRIDES="--height=70%"

alias db='dotbare'
bindkey -s '©' "dotbare fedit"^j        # alt g
bindkey -s '˙' "dotbare fadd"^j         # alt a
bindkey -s 'ß' "dotbare fstat"^j        # alt s
export DOTBARE_DIR="$XDG_DATA_HOME/dotfiles"
export DOTBARE_TREE="$HOME"
export DOTBARE_BACKUP="$XDG_DATA_HOME/dotbare-b"
# export DOTBARE_FZF_DEFAULT_OPTS="--layout=reverse --height 40% --border --ansi"

# GO
export GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"

# NNN
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:treeview;v:imgview;j:autojump;e:gpge;d:gpgd;m:mimelist;b:nbak;s:organize'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
# set --export NNN_FIFO "/tmp/nnn.fifo"

# OpenVPN
export PATH="/usr/local/Cellar/openvpn/2.5.0/sbin:$PATH"

# GPG
export GPG_TTY=$TTY
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent"
export PINENTRY_USER_DATA="USE_CURSES=1"

# Adding Anaconda Python to beginning of $PATH
export PATH="$HOME/opt/anaconda3/bin:$PATH"

# overriding macOS default ruby
# export PATH="/usr/local/opt/ruby/bin:$PATH"
# export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

export GEM_HOME="$XDG_DATA_HOME/gem"
export PATH="$HOME/.rbenv/version/3.0.0/bin:$PATH"
eval "$(rbenv init -)"

# Dragon - drag and drop
export PATH="$HOME/.local/bin:$PATH"
# }}}

killall limelight &> /dev/null
(limelight &> /dev/null &)

source /Users/lucasburns/.config/broot/launcher/bash/br

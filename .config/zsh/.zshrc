 # ______     ______     __  __     ______     ______
# /\___  \   /\  ___\   /\ \_\ \   /\  == \   /\  ___\
# \/_/  /__  \ \___  \  \ \  __ \  \ \  __<   \ \ \____
 #  /\_____\  \/\_____\  \ \_\ \_\  \ \_\ \_\  \ \_____\
 #  \/_____/   \/_____/   \/_/\/_/   \/_/ /_/   \/_____/

# MacOS: Speeed up ZSH `sudo rm -rf /private/var/log/asl/*.asl`

# History
export LC_ALL="en_US.UTF-8"
export ZSH_DISABLE_COMPFIX=true
export HISTSIZE=10000000
export HISTFILE="$HOME/.cache/zsh/history/.zsh_history"
export SAVEHIST=10000000
export HIST_STAMPS="yyyy-mm-dd"
export HISTORY_IGNORE='(jrnl *| jrnl *)'
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
# unsetopt share_history

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Path to oh-my-zsh installation.
export ZSH="$XDG_CONFIG_HOME/zsh/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git
		zsh-autosuggestions
		autojump
		pass
    dotbare
    forgit
    vi-mode)

# zsh-vi-mode

source $ZSH/oh-my-zsh.sh
source $ZDOTDIR/zsh-aliases
 zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# --- ZSH Menu ---
# zstyle ':completion:*' menu select
# zmodload zsh/complist
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^a' autosuggest-accept
bindkey '^x' autosuggest-execute

bindkey 'ESC-h' run-help
bindkey 'ESC-H' run-help
bindkey 'ESC-?' which-command
bindkey '^S' history-incremental-search-backward
bindkey '^R' history-incremental-search-forward

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# --- fzf tab completion ---
source ~/.config/zsh/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.zsh
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# p10k
[ ! -f ${XDG_CONFIG_HOME}/zsh/.p10k.zsh ] || source ${XDG_CONFIG_HOME}/zsh/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# source ~/.bash_profile

# FZF keybindings fix
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# AutoJump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# MySQL
export PATH=${PATH}:/usr/local/mysql/bin/

# Homebrew
export PATH="/usr/local/bin:$PATH"

# mybin
export PATH="/usr/local/mybin:$PATH"

# >>> conda initialize >>>
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
# <<< conda initialize <<<

eval "$(zoxide init zsh)"
eval $(thefuck --alias)

# export MANPAGER="nvim -c 'set ft=man' -"
# export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BROWSER='open -a LibreWolf'
export RTV_BROWSER="w3m"
export EDITOR='nvim'

#----- FUNCTIONS -----#
# fzf search for file and open in vim
vf() { fzf | xargs -r -I % $EDITOR % ; }
# rsync from local pc to server
rsyncto() { rsync -uvrP $1 root@burnsac.xyz:$2 ; }
rsyncfrom() { rsync -uvrP root@burnsac.xyz:$1 $2 ; }
# open fzf in a directory and open file in vim
fzfd() { find $1 | fzf | xargs -r -I % $EDITOR % ; }
# fzf pdfs and open with zathura
fzfp() { fd -a -e "pdf" . $1 | fzf | (nohup xargs -I{} zathura "{}" >/dev/null) }
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
# alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
h() { howdoi $@ -c -n 5; }
# alias hless='function hdi(){ howdoi $* -c | less --raw-control-chars --quit-if-one-screen --no-init; }; hdi'
hless() { howdoi $@ -c | less --raw-control-chars --quit-if-one-screen --no-init; }


# Use lf to change directory
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}


#----- VARIABLES -----#
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

export FZF_DEFAULT_OPTS="--layout=reverse --height 50% --border --ansi"
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export NAVI_FZF_OVERRIDES="--height=70%"

alias db='dotbare'
export DOTBARE_DIR="$XDG_DATA_HOME/cfg"
export DOTBARE_TREE="$HOME"
export DOTBARE_BACKUP="$XDG_DATA_HOME/dotbare"
export DOTBARE_FZF_DEFAULT_OPTS="--layout=reverse --height 40% --border --ansi"

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

# Homebrew ruby over system
# export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
# Dragon - drag and drop
export PATH="$HOME/.local/bin:$PATH"

# Syntax Highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f "$XDG_CONFIG_HOME/zsh/lficons" ] && source "$XDG_CONFIG_HOME/zsh/lficons"
[ -f "$XDG_CONFIG_HOME/broot/launcher/bash/br" ] && source "$XDG_CONFIG_HOME/broot/launcher/bash/br"

# killall limelight &> /dev/null
# limelight &> /dev/null &

[ -f ~/opt/forgit/forgit.plugin.zsh ] && source ~/opt/forgit/forgit.plugin.zsh

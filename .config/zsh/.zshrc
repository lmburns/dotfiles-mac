 # ______     ______     __  __     ______     ______
# /\___  \   /\  ___\   /\ \_\ \   /\  == \   /\  ___\
# \/_/  /__  \ \___  \  \ \  __ \  \ \  __<   \ \ \____
 #  /\_____\  \/\_____\  \ \_\ \_\  \ \_\ \_\  \ \_____\
 #  \/_____/   \/_____/   \/_/\/_/   \/_/ /_/   \/_____/

# MacOS: Speeed up ZSH `sudo rm -rf /private/var/log/asl/*.asl`

# History
export ZSH_DISABLE_COMPFIX=true
export HISTSIZE=10000000
export HISTFILE="$HOME/.cache/zsh/history/.zsh_history"
export SAVEHIST=10000000
export HIST_STAMPS="yyyy-mm-dd"
export HISTORY_IGNORE='(jrnl *| jrnl *)'
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt appendhistory
setopt sharehistory
setopt incappendhistory
# unsetopt share_history

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Path to your oh-my-zsh installation.
export ZSH="$XDG_CONFIG_HOME/zsh/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

plugins=(git
		zsh-autosuggestions
		autojump
		pass
    dotbare)

source $ZSH/oh-my-zsh.sh

# ZSH Menu
# zstyle ':completion:*' menu select
# zmodload zsh/complist
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^a' autosuggest-accept
bindkey '^x' autosuggest-execute

# fzf tab completion
source ~/.config/zsh/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.zsh
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# p10k
[ ! -f ${XDG_CONFIG_HOME}/zsh/.p10k.zsh ] || source ${XDG_CONFIG_HOME}/zsh/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/.bash_profile

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

# Aliases
# alias sudo='doas'
alias cp='cp -iv'
alias rm='rm -iv'
alias rr='rm -rf'
alias mv='mv -iv'
alias mkd='mkdir -pv'
alias ..='cd ..'
alias l='exa'
alias ll='exa -FlahH'
alias ls='exa -Flh'
alias his='history | grep'
alias ka='killall'
alias yt='youtube-dl --add-metadata -i'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias sha='shasum -a 256'
alias his='history | grep'
alias pipup="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U --user"
alias gls='gls -Flha --color --group-directories-first'
alias nzsh="nvim $ZDOTDIR/.zshrc"
alias ninit='nvim ~/.config/nvim/init.vim'

alias sme='mbsync burnsac@me.com'
alias mwme='mw -y burnsac@me.com'
alias sgm='mbsync burnsppl@gmail.com'
alias mwgm='mw -y burnsppl@gmail.com'
alias smail='mw -y burnsac@me.com && mw -y burnsppl@gmail.com && mw -y lucas@lucasburns.xyz'

alias projects='cd ~/JupyterNotebook/projects'
alias nvimd='cd /usr/local/share/nvim/runtime'
alias unx='cd ~/Desktop/unix/mac'
alias scripts='cd ~/Desktop/unix/mac/scripts'

alias wget='wget --hsts-file ~/.config/wget/.wget-hsts'
alias tsm='transmission-remote'
alias tsmd='transmission-daemon'
alias nnn='nnn -Caxe'
alias lsn='nnn -deH'
alias dmenu='open -a dmenu-mac'
alias getip='ipconfig getifaddr en0 &&  curl ipecho.net/plain; echo'
alias cpumem="ps -A -o %cpu,%mem | awk '{ cpu += \$1; mem += \$2} END {print \"CPU: \"  cpu,\"MEM: \"  mem}'"
alias qbt='qbt torrent'
alias pyn='openpyn'
alias oconn='openpyn us -t 10'
alias essh='eval $(ssh-add)'

# RSync / a=rlptgoD
alias rsynca='rsync -PruLtcv --delete-after --exclude ".DS_Store" --exclude ".ipynb_checkpoints"'
alias rsyncjn='rsync -PruLtcv --exclude ".DS_Store" --exclude "projects"  ~/JupyterNotebook /Volumes/SSD/manual'
alias rsyncpr='rsync -PruLtcv --exclude ".DS_Store" --exclude ".ipynb_checkpoints" ~/JupyterNotebook/projects /Volumes/SSD/manual'
alias rsyncde='rsync -PruLtcv --exclude ".DS_Store" --exclude "HOME" --exclude "unix" ~/Desktop /Volumes/SSD/manual'
alias rsyncux='rsync -PrugoptczL --exclude ".DS_Store" ~/Desktop/unix /Volumes/SSD/manual'
alias rsyncho='rsync -PruLtcv --exclude ".DS_Store" ~/Desktop/HOME /Volumes/SSD/manual'

alias rsyncsrv='rsync -Prugoptczl --delete-after --exclude "/dev/*" --exclude "/proc/*" --exclude "/sys/*" --exclude "/tmp/*" --exclude "/run/*" --exclude "/mnt/*" --exclude "/media/*" --exclude "swapfile" --exclude "lost+found" root@lucasburns.xyz:/ /Volumes/SSD/server'
alias wwwpull='rsync -Prugoptczl --delete-after root@lucasburns.xyz:/var/www ~/server'
alias wwwpush='rsync -Prugoptczl --delete-after --exclude ".DS_Store" ~/server /Volumes/SSD'
alias sudorysnc='sudo rsync -PrugptvENtzl --delete-after --include ".*" --exclude ".DS_Store" --exclude ".ipynb_checkpoints" --exclude "/Volumes/*" / /Volumes/SSD/void'

alias zath='zathura'
# export PAGER="less"
# Colorize man pages with `bat`
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER="nvim -c 'set ft=man' -"
# export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
alias etch='sudo /Applications/balenaEtcher.app/Contents/MacOS/balenaEtcher'
alias pacman='pacaptr'
alias p='pacaptr'
alias fd='fd -Hi'
alias spt='speedtest | rg "(Download:|Upload:)"'

# Github
alias config='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles-private --work-tree=$HOME'
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
alias gua='git remote | xargs -L1 git push --all'
alias grm='ssh git@lucasburns.xyz -- grm'
alias nbconvert='jupyter nbconvert --to python'
alias g='git'
alias magit='nvim -c MagitOnly'
alias ngc='nvim .git/config'

alias pass='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'
alias thumb='thumbsup --input ./img --output ./gallery --title "images" --theme cards && rsync -av gallery root@lucasburns.xyz:/var/www/lambda'
alias hangups='hangups -c ~/.config/hangups/hangups.conf'
alias newsboat='newsboat -C ~/.config/newsboat/newsboat.config'
alias ticker='ticker --config ~/.config/ticker/ticker.yaml'
alias notifyDone='tput bel; terminal-notifier -title "Terminal" -message "Done with task! Exit status: $?"' -activate com.googlecode.iterm2
alias taskt='taskwarrior-tui'

export BROWSER='open -a LibreWolf'
export RTV_BROWSER="w3m"
export EDITOR='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'
alias jrnl=' jrnl'
# alias pandoc='pandoc --highlight-style zenburn'

# OpenVPN
export PATH="/usr/local/Cellar/openvpn/2.5.0/sbin:$PATH"

# SSH
# eval $(ssh-add)
# eval `ssh-agent`
# ssh-add ~/.ssh/id_rsa


#----- FUNCTIONS -----#
vf() { fzf | xargs -r -I % $EDITOR % ; }
dwc() { ls $1 | wc -l ; }
rsyncweb() { rsync -uvrP $1 root@lucasburns.xyz:$2 ; }
fzfd() { find $1 | fzf | xargs -r -I % $EDITOR % ; }
fzfp() {fd -a -e "pdf" . $1 | fzf | (nohup xargs -I{} zathura "{}" >/dev/null)}
targz() { tar -zcvf $1.tar.gz $1; rm -r $1; }
untargz() { tar -zxvf $1; rm -r $1; }
sshred() { find $1 -type f -exec shred -v -n 1 -z -u  {} \; }
asciir() { asciinema rec $1; }
pss() { ps aux | rg --color always -i $1 | rg -v rg }
psgrep() { ps up $(pgrep -f $@) 2>&-; }
mbn() { (nohup mn $1 >/dev/null &) }

# Use fzf and zathura to open PDFs
pz () {
    local zathura
    open=zathura
    ag -U -g ".pdf$" \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | gtr " " "|");
            echo -e {1}"\n"{2} | ggrep -E "^|$v" -i --color=always;
        ' \
    | gcut -z -f 1 -d $'\t' | gtr -d '\n' | gxargs -r --null $open > /dev/null 2> /dev/null
}

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

eval "$(zoxide init zsh)"

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
# export OPENSSL_INCLUDE_DIR=`brew --prefix openssl`/include
# export OPENSSL_LIB_DIR=`brew --prefix openssl`/lib
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PASSWORD_STORE_ENABLE_EXTENSIONS='true'

export FZF_DEFAULT_OPTS="--layout=reverse --height 40% --border"
export FZF_DEFAULT_COMMAND='rg --files --hidden'

alias db='dotbare'
export DOTBARE_DIR="$XDG_DATA_HOME/cfg"
export DOTBARE_TREE="$HOME"
export DOTBARE_BACKUP="$XDG_DATA_HOME/dotbare"
export DOTBARE_FZF_DEFAULT_OPTS="--layout=reverse --height 40% --border"

# NNN
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:treeview;v:imgview;j:autojump;e:gpge;d:gpgd;m:mimelist;b:nbak;s:organize'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
# set --export NNN_FIFO "/tmp/nnn.fifo"

# GPG
export GPG_TTY=$TTY
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent"
export PINENTRY_USER_DATA="USE_CURSES=1"

# Adding Anaconda Python to beginning of $PATH
export PATH="/Users/lucasburns/opt/anaconda3/bin:$PATH"

# Homebrew ruby over system
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
# Dragon - drag and drop
export PATH="$HOME/.local/bin:$PATH"

# Syntax Highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f "$XDG_CONFIG_HOME/zsh/lficons" ] && source "$XDG_CONFIG_HOME/zsh/lficons"
[ -f "$XDG_CONFIG_HOME/broot/launcher/bash/br" ] && source "$XDG_CONFIG_HOME/broot/launcher/bash/br"

# killall limelight &> /dev/null
# limelight &> /dev/null &

# export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export GETOPT="/usr/local/opt/gnu-getopt/bin/getopt"

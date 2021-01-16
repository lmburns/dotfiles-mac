#          _
#  _______| |__  _ __ ___
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__
# /___|___/_| |_|_|  \___|

# MacOS: Speeed up ZSH `sudo rm -rf /private/var/log/asl/*.asl`

# History
export HISTSIZE=10000000
export HISTFILE="$HOME/.cache/zsh/history/.zsh_history"
export SAVEHIST=10000000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt appendhistory
setopt sharehistory
setopt incappendhistory

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
		dotbare
        vi-mode)

source $ZSH/oh-my-zsh.sh

# ZSH Menu
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history


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
alias cp='cp -iv'
alias rm='rm -iv'
alias rr='rm -rf'
alias mv='mv -iv'
alias mkd='mkdir -pv'
alias ..='cd ..'
alias ll='exa -FlahH'
alias ls='exa -Flh'
alias hs='history | grep'
alias ka='killall'
alias yt='youtube-dl --add-metadata -i'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias sha='shasum -a 256'
alias pipup="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U --user"
alias gls='gls -Flha --color --group-directories-first'
alias nzsh="nvim $ZDOTDIR/.zshrc"
alias ninit='nvim ~/.config/nvim/init.vim'

alias sme='mbsync burnsac@me.com'
alias mwme='mw -y burnsac@me.com'
alias sgm='mbsync burnsppl@gmail.com'
alias mwgm='mw -y burnsppl@gmail.com'
alias smail='mbsync burnsac@me.com && mbsync burnsppl@gmail.com && mbsync lucas@lucasburns.xyz'

alias projects='cd ~/JupyterNotebook/projects'
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

# RSync
alias rsynca='rsync -PruLtcv --exclude ".DS_Store" --exclude ".ipynb_checkpoints"'
alias rsyncjn='rsync -PruLtcv --exclude ".DS_Store" --exclude "projects"  ~/JupyterNotebook /Volumes/SSD/manual'
alias rsyncpr='rsync -PruLtcv --exclude ".DS_Store" --exclude ".ipynb_checkpoints" ~/JupyterNotebook/projects /Volumes/SSD/manual'
alias rsyncde='rsync -PruLtcv --exclude ".DS_Store" --exclude "HOME" --exclude "unix" ~/Desktop /Volumes/SSD/manual'
alias rsyncux='rsync -PrugoptczL --exclude ".DS_Store" ~/Desktop/unix /Volumes/SSD/manual'
alias rsyncho='rsync -PruLtcv --exclude ".DS_Store" ~/Desktop/HOME /Volumes/SSD/manual'

alias rsyncsrv='rsync -Prugoptczl --delete-after --exclude "/dev/*" --exclude "/proc/*" --exclude "/sys/*" --exclude "/tmp/*" --exclude "/run/*" --exclude "/mnt/*" --exclude "/media/*" --exclude "swapfile" --exclude "lost+found" root@lucasburns.xyz:/ /Volumes/SSD/server'
alias www='rsync -Prugoptczl --delete-after root@lucasburns.xyz:/var/www ~/Desktop/unix/www/www-md'
alias rsyncwww='rsync -Prugoptczl --delete-after --exclude ".DS_Store" ~/Desktop/unix/www /Volumes/SSD'
alias rsyncweb='rsync -uvrP --delete-after'

alias z='zathura'
alias less='vimpager'
alias etch='sudo /Applications/balenaEtcher.app/Contents/MacOS/balenaEtcher'
alias pacman='pacaptr'
alias p='pacaptr'
alias fd='fd -Hi'

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

export EDITOR='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'
# alias pandoc='pandoc --highlight-style zenburn'

# OpenVPN
export PATH="/usr/local/Cellar/openvpn/2.5.0/sbin:$PATH"

# SSH
# eval $(ssh-add)
# eval `ssh-agent`
# ssh-add ~/.ssh/id_rsa


#----- FUNCTIONS -----#
vf() {fzf | xargs -r -I % $EDITOR % ;}
targz() { tar -zcvf $1.tar.gz $1; rm -r $1; }
untargz() { tar -zxvf $1; rm -r $1; }
sshred() { find $1 -type f -exec shred -v -n 1 -z -u  {} \; }


#----- VARIABLES -----#
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/notmuch-config"
export TASKRC="$XDG_CONFIG_HOME/task/taskrc"
export TASKDATA="$XDG_CONFIG_HOME/task"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export R_HISTFILE="$XDG_CONFIG_HOME/r/Rhistory"
export R_PROFILE_USER="$XDG_CONFIG_HOME/r/Rprofile"
export LESSHISTFILE="-"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PASSWORD_STORE_ENABLE_EXTENSIONS='true'

export FZF_DEFAULT_OPTS="--layout=reverse --height 40% --border"

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
export GPG_TTY=$(tty)
# export PINENTRY_USER_DATA="USE_CURSES=1"

# Adding Anaconda Python to beginning of $PATH
export PATH="/Users/lucasburns/opt/anaconda3/bin:$PATH"

# Syntax Highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

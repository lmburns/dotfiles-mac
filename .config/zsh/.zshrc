#          _
#  _______| |__  _ __ ___
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__
# /___|___/_| |_|_|  \___|

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

# MySQL
export PATH=${PATH}:/usr/local/mysql/bin/

# Path to your oh-my-zsh installation.
export ZSH="$XDG_CONFIG_HOME/zsh/.oh-my-zsh"

# Syntax Highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

plugins=(git
		zsh-autosuggestions
		autojump
		pass
		dotbare)

source $ZSH/oh-my-zsh.sh

# p10k
[ ! -f ${XDG_CONFIG_HOME}/zsh/.p10k.zsh ] || source ${XDG_CONFIG_HOME}/zsh/.p10k.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/.bash_profile

# fzf keybindings fix
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# AutoJump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


# Setting PATH for Python 3.7
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

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

alias gls='gls -Flha --color --group-directories-first'
alias nzsh="nvim $ZDOTDIR/.zshrc"
alias ninit='nvim ~/.config/nvim/init.vim'
alias rclonescripts='cd ~/Desktop/unix/mac/scripts/rclone_scripts'

alias sme='mbsync burnsac@me.com'
alias mwme='mw -y burnsac@me.com'
alias sgm='mbsync burnsppl@gmail.com'
alias mwgm='mw -y burnsppl@gmail.com'
alias smail='mbsync burnsac@me.com && mbsync burnsppl@gmail.com && mbsync lucas@lucasburns.xyz'

alias projects='cd ~/JupyterNotebook/projects'
alias unx='cd ~/Desktop/unix/mac'
alias wget='wget --hsts-file ~/.config/wget/.wget-hsts'
alias tsm='transmission-remote'
alias tsmd='transmission-daemon'
alias nnn='nnn -Caxe'
# alias gutxt='gbk-upload-text.sh'
# alias guprj='gbk-upload-projects.sh'
alias lsn='nnn -deH'
alias dmenu='open -a dmenu-mac'
alias getip='ipconfig getifaddr en0 &&  curl ipecho.net/plain; echo'
# dig +short myip.opendns.com @resolver1.opendns.com
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

alias www='rsync -Prugoptczl --delete-after root@lucasburns.xyz:/var/www ~/Desktop/unix/www/www-md'

alias pass='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'

alias z='zathura'

# NNN
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:treeview;v:imgview;j:autojump;e:gpge;d:gpgd;m:mimelist;b:nbak;s:organize'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
# set --export NNN_FIFO "/tmp/nnn.fifo"

export EDITOR='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
# alias pandoc='pandoc --highlight-style zenburn'

# OpenVPN
export PATH="/usr/local/Cellar/openvpn/2.5.0/sbin:$PATH"

# SSH
# eval $(ssh-add)
# eval `ssh-agent`
# ssh-add ~/.ssh/id_rsa



#----- FUNCTIONS -----#
# FZF=
vf() {fzf | xargs -r -I % $EDITOR % ;}
nfiles() {N="$(ls $1 | wc -l)"; echo "$N files in $1"}

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

# GPG
export GPG_TTY=$(tty)
# export PINENTRY_USER_DATA="USE_CURSES=1"

# Adding Anaconda Python to beginning of $PATH
export PATH="/Users/lucasburns/opt/anaconda3/bin:$PATH"


#  ______     ______     __  __     ______     ______
# /\___  \   /\  ___\   /\ \_\ \   /\  == \   /\  ___\
# \/_/  /__  \ \___  \  \ \  __ \  \ \  __<   \ \ \____
#   /\_____\  \/\_____\  \ \_\ \_\  \ \_\ \_\  \ \_____\
#   \/_____/   \/_____/   \/_/\/_/   \/_/ /_/   \/_____/

# MacOS: Speeed up ZSH `sudo rm -rf /private/var/log/asl/*.asl`

# === general settings === {{{
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export LC_ALL="en_US.UTF-8"
export ZSH_DISABLE_COMPFIX=true
export HISTSIZE=10000000
export HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
export SAVEHIST=10000000
export HIST_STAMPS="yyyy-mm-dd"
export HISTORY_FILTER_EXCLUDE=("jrnl", "cd")
export PROMPT_EOL_MARK=''
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt append_history
setopt share_history
setopt inc_append_history
setopt extended_history
setopt auto_menu
setopt complete_in_word
setopt always_to_end
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt long_list_jobs
setopt interactivecomments
unsetopt menu_complete
unsetopt flowcontrol
unsetopt case_glob

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZINIT_HOME="$ZDOTDIR/zinit"
export GENCOMP_DIR="$ZDOTDIR/completions"
fpath+=( ${ZDOTDIR}/{functions,completions} )

zpt() { zinit ice wait"${1}" lucid               "${@:2}"; } # Turbo
zpi() { zinit ice lucid                            "${@}"; } # Regular Ice
zp()  { [ -z $2 ] && zinit light $@ || zinit $@; }          # zinit

typeset -A ZINIT=(
    BIN_DIR         $ZDOTDIR/zinit/bin
    HOME_DIR        $ZDOTDIR/zinit
    COMPINIT_OPTS   -C
)

# compinit -u -d "${ZDOTDIR}/.zcompdump_${ZSH_VERSION}"
zmodload zsh/zprof
autoload -Uz $ZDOTDIR/functions/*(:t)
autoload +X zman
autoload -Uz zmv zcalc zargs
alias zmv='noglob zmv -W'

[ -f "$ZDOTDIR/zsh-aliases" ] && source "$ZDOTDIR/zsh-aliases"
# }}}

# === zinit === {{{
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

# zinit snippet OMZ::lib/misc.zsh
# zinit snippet OMZ::lib/key-bindings.zsh
# zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
# depth=1 jeffreytse/zsh-vi-mode
# as"completion" OMZ::plugins/pass/_pass
# OMZ::lib/clipboard.zsh

zinit wait lucid for \
  OMZ::lib/completion.zsh \
  OMZ::lib/history.zsh \
  OMZ::plugins/git/git.plugin.zsh \
  OMZ::plugins/iterm2/iterm2.plugin.zsh \
  OMZ::plugins/osx/osx.plugin.zsh \
  OMZ::plugins/autojump/autojump.plugin.zsh \
  OMZ::plugins/zsh_reload/zsh_reload.plugin.zsh

zinit is-snippet for \
  $ZDOTDIR/csnippets/*.zsh \
  OMZ::plugins/vi-mode/vi-mode.plugin.zsh

zinit wait'1' lucid light-mode for \
    hlissner/zsh-autopair \
    aloxaf/gencomp \
    wfxr/forgit \
    tarrasch/zsh-bd \
    skywind3000/z.lua

zinit light-mode for \
    aloxaf/fzf-tab \
    zsh-users/zsh-syntax-highlighting \
    michaelaquilina/zsh-history-filter \
    michaelaquilina/zsh-you-should-use \
    kazhala/dotbare \
    ael-code/zsh-colored-man-pages \
    andrewferrier/fzf-z \
    blockf \
      zsh-users/zsh-completions \
    src="etc/git-extras-completion.zsh" \
      tj/git-extras

zinit ice depth=1; zinit light romkatv/powerlevel10k
source $ZDOTDIR/.p10k.zsh

zinit ice lucid ver'master' wait'0b' as'completion' has'git-extras' blockf
zinit wait lucid atload'_zsh_autosuggest_start' light-mode for \
    zsh-users/zsh-autosuggestions

# compdef _dotbare_completion_git dotbare
autoload -Uz compinit && compinit
# autoload -U +X bashcompinit && bashcompinit
# zinit cdreplay -q
# }}}

# === powerlevel10k === {{{
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}

# === zsh keybindings === {{{
bindkey '^a' autosuggest-accept
bindkey '^x' autosuggest-execute
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'
bindkey -s '^o' 'lc\n'
bindkey -M vicmd '^h' run-help
bindkey -M vicmd '?' which-command

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd '^e' edit-command-line;  bindkey -M viins '^e' edit-command-line
bindkey -M viins 'jk' vi-cmd-mode;        bindkey -M viins 'kj' vi-cmd-mode
bindkey -M vicmd 'H' beginning-of-line;   bindkey -M vicmd 'L' end-of-line

# fixes macOS consumption of ^O command
stty discard undef <$TTY >$TTY

# === fzf tab completion ===
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
# }}}

# === fixes / sourcing === {{{
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# fzf fix
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$ZDOTDIR/lficons" ] && source "$ZDOTDIR/lficons"
[ -f "$XDG_CONFIG_HOME/broot/launcher/bash/br" ] && source "$XDG_CONFIG_HOME/broot/launcher/bash/br"
# }}}

# === homebrew, custom bins === {{{
path=("$HOME/.local/bin" "/usr/local/mybin"
      "/usr/local/bin" "/usr/local/sbin"
      "${path[@]}"
)
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
# rsync from local pc to server
rst() { rsync -uvrP $1 root@burnsac.xyz:$2 ; }
rsf() { rsync -uvrP root@burnsac.xyz:$1 $2 ; }
# shred and delete file
sshred() { shred -v -n 1 -z -u  $1;  }
# create py file to sync with ipynb
jupyt() { jupytext --set-formats ipynb,py $1 }
# howdoi
h() { howdoi $@ -c -n 5; }
hless() { howdoi $@ -c | less --raw-control-chars --quit-if-one-screen --no-init; }
# use up pipe with any file
upp() { cat $1 | up }
# crypto
ratesx() { curl rate.sx/$1 }
# copy directory
pbcopydir() { pwd | tr -d "\r\n" | pbcopy; }
# backup files
bak() { /usr/local/bin/gcp -r --force --suffix=.bak $1 $1.bak }
rbak() { /usr/local/bin/gcp -r --force $1.bak $1 }
# link unlink file from mybin to $PATH
lnbin() { ln -siv $HOME/mybin/$1 /usr/local/mybin; }
unlbin() { rm -v /usr/local/mybin/$1; }
# latex documenation serch (as best I can)
latexh() { zathura -f "$@" "$HOME/projects/latex/docs/latex2e.pdf" }
# get help on builtin commands
zm() { man zshbuiltins | less -p "^       $1 "; }
unalias run-help && autoload run-help && alias help=run-help
HELPDIR='/usr/local/share/zsh/help'
# man zshcontrib | zshall | zshle
# cd into directory
take() { mkdir -p $@ && cd ${@:$#} }
# fzf recent directories
rdir() { cd "$(dirs -lp | fzf)" }
w2md() { wget -qO - "$1" | iconv -t utf-8 | html2text -b 0; }
# md5 of a directory
md5dir() { fd . -tf -x md5sum {} | cut -d' ' -f1 | sort | md5sum | cut -d' ' -f1; }
_fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1"; }
_fzf_compgen_dir() { fd --exclude ".git" --follow --hidden --type d . "$1"; }

# use lf to switch directories
lc() {
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
eval "$(zoxide init zsh --cmd x)"
eval "$(keychain --agents ssh -q --inherit any --eval id_rsa git burnsac && \
        keychain --agents gpg -q --eval 0xC011CBEF6628B679)"
eval "$(thefuck --alias)"
# eval "$(fakedata --completion zsh)"

# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER="nvim -c 'set ft=man' -"
# export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
export BROWSER='/Applications/LibreWolf.app/Contents/MacOS/firefox-bin'
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
export PASSWORD_STORE_EXTENSIONS_DIR="$(brew --prefix)/lib/password-store/extensions"
export GETOPT="/usr/local/opt/gnu-getopt/bin/getopt"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_BAT=1
export HOMEBREW_BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/config"
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export FZFZ_RECENT_DIRS_TOOL='autojump'

# ❱❯❮
export FZF_DEFAULT_OPTS="
  --prompt '❱❱ '
  --marker='+'
  --color=fg:#b16286,fg+:#d3869b,hl:#458588,hl+:#689d6a
  --color=info:#b8bb26,pointer:#fabd2f,marker:#fe8019,spinner:#b8bb26
  --color=header:#cc241d,gutter:-1,prompt:#fb4934
  --reverse --height 50% --border --ansi --info=inline --multi
  --preview-window=:hidden
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --bind '?:toggle-preview'
  --bind 'ctrl-a:select-all'
  --bind 'ctrl-b:execute(bat --paging=always -f {+})'
  --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
  --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
  --bind 'ctrl-v:execute(code {+})'
"

# pointer='|>'
# --color=dark
# --color=fg:#d5c4a1,fg+:#ebdbb2,hl:#458588,hl+:#b16286
# --color=fg:250,fg+:15,hl:203,hl+:203
# --color=info:100,pointer:15,marker:220,spinner:11,header:-1,gutter:-1,prompt:15
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_DEFAULT_COMMAND='fd --no-ignore --hidden --follow --exclude ".git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d ."
export FORGIT_FZF_DEFAULT_OPTS="--exact --cycle --border --ansi --reverse
    --height 70% --info=inline --multi"
export NAVI_FZF_OVERRIDES="--height=70%"

alias db='dotbare'
export DOTBARE_DIR="$XDG_DATA_HOME/dotfiles"
export DOTBARE_TREE="$HOME"
export DOTBARE_BACKUP="$XDG_DATA_HOME/dotbare-b"
export DOTBARE_FZF_DEFAULT_OPTS="
  --prompt '❱❱ '
  --marker='+'
  --color=header:#cc241d,gutter:-1,prompt:#fb4934
  --header='A:select-all, B:pager, Y:copy, E:nvim'
  --reverse --height 50% --border --ansi --info=inline --multi
  --preview-window=nohidden
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --bind 'ctrl-a:select-all'
  --bind 'ctrl-b:execute(bat --paging=always -f {+})'
  --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
  --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
"

# NNN
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:treeview;v:imgview;j:autojump;e:gpge;d:gpgd;m:mimelist;b:nbak;s:organize'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'

# add GNU coreutils to path with no 'g' prefix, openvpn
path=(/usr/local/opt/coreutils/libexec/gnubin
      /usr/local/opt/gnu-sed/libexec/gnubin
      /usr/local/opt/util-linux/bin
      /usr/local/opt/findutils/libexec/gnubin
      /usr/local/Cellar/openvpn/2.5.0/sbin ${path[@]}
)

d="$XDG_CONFIG_HOME/dircolors/gruv.dircolors"; test -r $d && eval "$(dircolors $d)"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"

# GPG
export GPG_TTY=$TTY
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent"
export PINENTRY_USER_DATA="USE_CURSES=1"

# ruby, go, python, mysql
export GOPATH=$(go env GOPATH)
export GEM_HOME="${XDG_DATA_HOME}/gem"
path=($HOME/.rbenv/version/3.0.0/bin
      $XDG_DATA_HOME/gem/bin
      $HOME/opt/anaconda3/bin
      /usr/local/mysql/bin/
      $GOPATH/bin ${path[@]}
)
eval "$(rbenv init -)"

# texdoc pdfviewer
export PDFVIEWER='zathura'

# perlbrew
source "${HOME}/perl5/perlbrew/etc/bashrc"
# rakubrew
eval "$(/usr/local/mybin/rakubrew init Zsh)"

# xdg-utils
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

# fontpreview
# export FONTPREVIEW_BG_COLOR="#000000"
# export FONTPREVIEW_FG_COLOR="#ffffff"

# dbus
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
# }}}

# killall limelight &> /dev/null; limelight &> /dev/null &
# pueue clean && pueue status | rg -Fq 'limelight' || chronic pueue add limelight
ts -C && ts -l | rg -Fq 'limelight' || chronic ts limelight

export PATH
typeset -U path fpath manpath

# export PATH="/usr/bin:$PATH"

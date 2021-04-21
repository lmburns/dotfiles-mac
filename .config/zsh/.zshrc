# === general settings === {{{
export LC_ALL="en_US.UTF-8"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_BIN_HOME="$HOME/bin"

typeset -g HISTSIZE=10000000 HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history" SAVEHIST=10000000
export HIST_STAMPS="yyyy-mm-dd"
export HISTORY_FILTER_EXCLUDE=("jrnl")
# export ZSH_DISABLE_COMPFIX=true
export PROMPT_EOL_MARK=''
export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

setopt hist_ignore_space    append_history      hist_ignore_all_dups
setopt share_history        inc_append_history  extended_history
setopt auto_menu            complete_in_word    always_to_end
setopt autocd               auto_pushd          pushd_ignore_dups
setopt pushdminus           long_list_jobs      interactive_comments
setopt glob_dots            extended_glob       menu_complete
setopt no_flow_control      case_glob           notify

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZINIT_HOME="$ZDOTDIR/zinit"
export GENCOMP_DIR="${0:h}/completions"
export GENCOMPL_FPATH="${0:h}/completions"
# taken from: NICHOLAS85/dotfiles
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"
pchf="${0:h}/patches"

stty discard undef <$TTY >$TTY    # fix consumption of ^O command

fpath+=( ${ZDOTDIR}/{functions,completions} )
autoload -Uz $ZDOTDIR/functions/*(:t)

typeset -A ZINIT=(
    BIN_DIR         $ZDOTDIR/zinit/bin
    HOME_DIR        $ZDOTDIR/zinit
    ZCOMPDUMP_PATH  $ZDOTDIR/.zcompdump
    COMPINIT_OPTS   -C
)

# compinit -u -d "${ZDOTDIR}/.zcompdump_${ZSH_VERSION}"
zmodload zsh/zprof
autoload +X zman
autoload -Uz zmv zcalc zargs
alias zmv='noglob zmv -W'
unalias run-help && autoload run-help && alias help=run-help
HELPDIR='/usr/local/share/zsh/help'

[ -f "$ZDOTDIR/zsh-aliases" ] && source "$ZDOTDIR/zsh-aliases"
# }}}

# === zinit === {{{
zt(){ zinit depth'3' lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }

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

zt light-mode for \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node \
  zinit-zsh/z-a-submods \
  NICHOLAS85/z-a-linkbin

# zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
# depth=1 jeffreytse/zsh-vi-mode
# zinit wait'0b' light-mode for compile'h*' zdharma/history-search-multi-word
# seletskiy/zsh-fuzzy-search-and-edit \

zt '' light-mode for \
  OMZ::plugins/git/git.plugin.zsh \
  OMZ::plugins/iterm2/iterm2.plugin.zsh

zt light-mode for \
    MichaelAquilina/zsh-you-should-use \
    MichaelAquilina/zsh-history-filter \
  svn \
    OMZ::plugins/osx \
  trigger-load'!bd' svn \
    tarrasch/zsh-bd \
  trigger-load'!j' svn \
    OMZ::plugins/autojump \
  trigger-load'!x' svn \
    OMZ::plugins/extract \
  trigger-load'!src' svn \
    OMZ::plugins/zsh_reload \
  trigger-load'!man' svn \
    ael-code/zsh-colored-man-pages \
  src="etc/git-extras-completion.zsh" \
    tj/git-extras \
  submods'RobSis/zsh-completion-generator -> lib/zsh-completion-generator;
  nevesnunes/sh-manpage-completions -> lib/sh-manpage-completions' \
  atload' gcomp(){gencomp "${@}" && zinit creinstall -q ${ZINIT[SNIPPETS_DIR]}/config 1>/dev/null}' \
     Aloxaf/gencomp

zt 0a light-mode for \
    OMZ::lib/history.zsh \
  atload'zstyle ":completion:*" special-dirs false' \
    OMZ::lib/completion.zsh \
  as'completion' atpull'zinit cclear' blockf \
    zsh-users/zsh-completions \
  ver'develop' atload'_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \
  as'completion' nocompile mv'*.zsh -> _git' \
    felipec/git-completion

zt 0b light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay;" \
    zdharma/fast-syntax-highlighting \
  atload'ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)' \
    hlissner/zsh-autopair \
  blockf compile'lib/*f*~*.zwc' \
    Aloxaf/fzf-tab \
  atload'bindkey -M viins -r "^n"; bindkey -M vicmd -r "^n";
  bindkey -M viins "^n" fzfz-dir-widget; bindkey -M vicmd "^n" fzfz-dir-widget' \
  patch"${pchf}/%PLUGIN%.patch" reset \
    andrewferrier/fzf-z \
  atload'bindkey -M viins "^u" dotbare-fstat; bindkey -M viins "^d" dotbare-fedit' \
    kazhala/dotbare \
 atinit"forgit_ignore='fgi'" \
    wfxr/forgit

zt 0c light-mode binary for \
  lbin atclone="rm -f ^(rgg|rgv)" \
    lilydjwg/search-and-view

zt 0c light-mode null for \
  id-as'Cleanup' nocd atinit'unset -f zt; _zsh_autosuggest_bind_widgets' \
    zdharma/null

zt light-mode is-snippet for \
  $ZDOTDIR/csnippets/*.zsh \
  OMZ::plugins/vi-mode

zinit ice depth=1; zinit light romkatv/powerlevel10k
source $ZDOTDIR/.p10k.zsh

# compdef _dotbare_completion_git dotbare
autoload -Uz compinit # && compinit
_comp_files=(${ZDOTDIR}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
    compinit -i -C
else
    compinit -i
fi
unset _comp_files

# }}}

# === powerlevel10k === {{{
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}

# === zsh keybindings === {{{
# sed -n l -- infocmp -L1 -- zle -L
# bindkey -M vicmd 'ys' add-surround

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n';   bindkey -s '^o' 'lc\n'
bindkey -M vicmd '?' which-command;             bindkey -M visual S add-surround
autoload edit-command-line;                     zle -N edit-command-line
autoload -Uz surround;                          zle -N delete-surround surround
zle -N add-surround surround;                   zle -N change-surround surround
bindkey -M vicmd 'cs' change-surround;          bindkey -M vicmd 'ds' delete-surround
bindkey '^a' autosuggest-accept;                bindkey '^x' autosuggest-execute
bindkey -M vicmd '^e' edit-command-line;        bindkey -M viins '^e' edit-command-line
bindkey -M viins 'jk' vi-cmd-mode;              bindkey -M viins 'kj' vi-cmd-mode
bindkey -M vicmd 'H' beginning-of-line;         bindkey -M vicmd 'L' end-of-line
# }}}

# === completion === {{{
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps -p $word -o comm="" -w -w'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ':fzf-tab:complete:nvim:*' fzf-preview \
  'r=$realpath; ([[ -f $r ]] && bat --style=numbers --color=always $r) \
  || ([[ -d $r ]] && tree -C $r | less) || (echo $r 2> /dev/null | head -200)'
zstyle ':fzf-tab:complete:nvim:argument-rest' fzf-flags '--preview-window=nohidden,right:65%:wrap'
zstyle ':fzf-tab:complete:(exa|cd):*' popup-pad 30 0
zstyle ':fzf-tab:complete:(exa|cd):*' fzf-flags '--preview-window=nohidden,right:65%:wrap'
zstyle ':fzf-tab:complete:(exa|cd):*' fzf-preview '[[ -d $realpath ]] && exa -T --color=always $realpath'
zstyle ':fzf-tab:complete:(cp|rm|mv|bat):argument-rest' fzf-preview 'r=$realpath; bat --color=always -- $r || exa --color=always -- $r'
zstyle ':fzf-tab:*' fzf-bindings 'enter:accept,backward-eof:abort'   # enter as accept, abort deleting empty
zstyle ':fzf-tab:*' print-query ctrl-c        # use input as result when ctrl-c
zstyle ':fzf-tab:*' accept-line space         # accept selected entry on space
zstyle ':fzf-tab:*' prefix ''                 # no dot prefix
zstyle ':fzf-tab:*' switch-group ',' '.'      # switch between header groups
# zstyle ':fzf-tab:*' single-group color header # single header is shown
zstyle ':fzf-tab:*' fzf-pad 4                 # increased because of fzf border
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache true
zstyle ':completion:*' verbose yes
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' completer _complete _match _list _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle ':completion:*:manuals' separate-sections true
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
# }}}

# === fixes / sourcing === {{{
test -e "${HOME}/.iterm2_shell_integration.zsh" && \
  source "${HOME}/.iterm2_shell_integration.zsh"

# fzf fix
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$ZDOTDIR/lficons" ] && source "$ZDOTDIR/lficons"
# [ -f "$XDG_CONFIG_HOME/broot/launcher/bash/br" ] && source "$XDG_CONFIG_HOME/broot/launcher/bash/br"
# }}}

# === homebrew, custom bins === {{{
path=(
  $HOME/.local/bin
  $XDG_BIN_HOME
  /usr/local/bin
  /usr/local/sbin
  ${path[@]}
)
# }}}

# === conda initialize === {{{
_conda_initialize() {
  if [ -n "${CONDA_EXE}" ]; then
    $CONDA_EXE config --set auto_activate_base false
    __conda_setup="$($CONDA_EXE 'shell.zsh' 'hook' 2>/dev/null)"
    [ $? -eq 0 ] && eval "$__conda_setup"
  fi
  unset __conda_setup
}

conda() {
  unfunction conda
  _conda_initialize
  conda "$@"
}
# }}}

# === functions === {{{
# howdoi
# h() { howdoi $@ -c -n 5; }
# hless() { howdoi $@ -c | less --raw-control-chars --quit-if-one-screen --no-init; }
# prevent failed commands from being added to history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
# rsync from local pc to server
rst() { rsync -uvrP $1 root@burnsac.xyz:$2 ; }
rsf() { rsync -uvrP root@burnsac.xyz:$1 $2 ; }
# shred and delete file
sshred() { shred -v -n 1 -z -u  $1;  }
# create py file to sync with ipynb
jupyt() { jupytext --set-formats ipynb,py $1 }
# use up pipe with any file
upp() { cat $1 | up }
# crypto
ratesx() { curl rate.sx/$1 }
# copy directory
pbcd() { pwd | tr -d "\r\n" | pbcopy; }
# create file from clipboard
pbpf() { pbpaste > "$1"; }
pbcf() { pbcopy < "${1:-/dev/stdin}"; }
# backup files
bak() { /usr/local/bin/gcp -r --force --suffix=.bak $1 $1.bak }
rbak() { /usr/local/bin/gcp -r --force $1.bak $1 }
# link unlink file from mybin to $PATH
lnbin() { ln -siv $HOME/mybin/$1 $XDG_BIN_HOME; }
unlbin() { rm -v /$XDG_BIN_HOME/$1; }
# latex documenation serch (as best I can)
latexh() { zathura -f "$@" "$HOME/projects/latex/docs/latex2e.pdf" }
# get help on builtin commands
zm() { man zshbuiltins | less -p "^       $1 "; }
# cd into directory
take() { mkdir -p $@ && cd ${@:$#} }
# fzf recent directories
frd() { cd "$(dirs -lp | fzf)" }
# html to markdown
w2md() { wget -qO - "$1" | iconv -t utf-8 | html2text -b 0; }
# sha of a directory
sha256dir() { fd . -tf -x sha256sum {} | cut -d' ' -f1 | sort | sha256sum | cut -d' ' -f1; }
allcmds() { print -l ${commands[@]} | awk -F'/' '{print $NF}' | fzf; }
rmsym() { find -L . -name . -o -type d -prune -o -type l -exec rm {} +; }
ypwd() { pwd -P | pbcopy; }

frg() { rg -F "$@"; }

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

_zsh_autosuggest_strategy_dir_history(){ # Avoid Zinit picking this up as a completion
    emulate -L zsh
    if $_per_directory_history_is_global && [[ -r "$_per_directory_history_path" ]]; then
        setopt EXTENDED_GLOB
        local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}"
        local pattern="$prefix*"
        if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]; then
        pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"
        fi
        [[ "${dir_history[(r)$pattern]}" != "$prefix" ]] && \
        typeset -g suggestion="${dir_history[(r)$pattern]}"
    fi
}

_zsh_autosuggest_strategy_custom_history () {
        emulate -L zsh
        setopt EXTENDED_GLOB
        local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}"
        local pattern="$prefix*"
        if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]
        then
                pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"
        fi
        [[ "${history[(r)$pattern]}" != "$prefix" ]] && \
        typeset -g suggestion="${history[(r)$pattern]}"
}

# }}}

#===== variables ===== {{{
eval "$(zoxide init zsh --cmd y)"
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
export KEYTIMEOUT=15

export VIMRC="$XDG_CONFIG_HOME/nvim/init.vim"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/notmuch-config"
export TASKRC="$XDG_CONFIG_HOME/task/taskrc"
export TASKDATA="$XDG_CONFIG_HOME/task"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH=$(go env GOPATH)
export GEM_HOME="$XDG_DATA_HOME/gem"
export R_USER="$XDG_CONFIG_HOME/r/R"
export R_ENVIRON_USER="$XDG_CONFIG_HOME/r/Renviron"
export R_MAKE_VARS_USER="$XDG_CONFIG_HOME/r/Makevars"
export R_HISTFILE="$XDG_CONFIG_HOME/r/Rhistory"
export R_PROFILE_USER="$XDG_CONFIG_HOME/r/Rprofile"
export R_LIBS_USER="$HOME/Library/R"
export LESSHISTFILE="-"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export PASSWORD_STORE_ENABLE_EXTENSIONS='true'
export PASSWORD_STORE_EXTENSIONS_DIR="$(brew --prefix)/lib/password-store/extensions"
export GETOPT="/usr/local/opt/gnu-getopt/bin/getopt"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_BAT=1
export HOMEBREW_BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/config"
export GPG_TTY=$TTY
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent"
export PINENTRY_USER_DATA="USE_CURSES=1"

export PDFVIEWER='zathura' # texdoc pdfviewer
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"  # xdg-utils
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"  # vimtex

export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export FZFZ_RECENT_DIRS_TOOL='autojump'
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)" # Do not consider 100 character entries
export ZSH_AUTOSUGGEST_COMPLETION_IGNORE="[[:space:]]*"   # Ignore leading whitespace
export ZSH_AUTOSUGGEST_STRATEGY=(dir_history custom_history completion)
export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:treeview;v:imgview;j:autojump;e:gpge;d:gpgd;m:mimelist;b:nbak;s:organize'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'

# }}}

# === fzf === {{{
# ❱❯❮ --border
export FZF_DEFAULT_OPTS="
  --prompt '❱❱ '
  --marker='+'
  --color=fg:#cbccc6,fg+:#707a8c,hl:#707a8c,hl+:#ffcc66
  --color=info:#73d0ff,pointer:#cbccc6,marker:#73d0ff,spinner:#73d0ff
  --color=header:#d4bfff,gutter:-1,prompt:#707a8c,dark
  --reverse --height 60% --ansi --info=inline --multi
  --preview-window=:hidden,right:65%:wrap,border-left
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always)) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --bind '?:toggle-preview'
  --bind 'ctrl-a:select-all'
  --bind 'ctrl-b:execute(bat --paging=always -f {+})'
  --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
  --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
  --bind 'ctrl-v:execute(code {+})'
  --bind='ctrl-k:preview-up'
  --bind='ctrl-j:preview-down'
"

export SKIM_DEFAULT_OPTIONS="
  --prompt '❱❱ '
  --color=fg:#b16286,fg+:#d3869b,hl:#458588,hl+:#689d6a
  --color=pointer:#fabd2f,marker:#fe8019,spinner:#b8bb26
  --color=header:#cc241d,prompt:#fb4934
  --reverse --height 70% --border --ansi --multi
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --bind '?:toggle-preview'
  --bind 'ctrl-a:select-all'
  --bind 'ctrl-b:execute(bat --paging=always -f {+})'
  --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
  --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
  --bind 'ctrl-v:execute(code {+})'
"
export SKIM_DEFAULT_COMMAND='fd --no-ignore --hidden --follow --exclude ".git"'

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
  --header='A:select-all, B:pager, Y:copy, E:nvim'
  --reverse --height 50% --border --ansi --info=inline --multi
  --preview-window=nohidden
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --bind 'ctrl-a:select-all'
  --bind 'ctrl-b:execute(bat --paging=always -f {+})'
  --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
  --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
"
# }}}


# === paths (GNU) === {{{
path=(
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/gnu-sed/libexec/gnubin
  /usr/local/opt/grep/libexec/gnubin
  /usr/local/opt/gnu-tar/libexec/gnubin
  /usr/local/opt/gawk/libexec/gnubin
  /usr/local/opt/util-linux/bin
  /usr/local/opt/findutils/libexec/gnubin
  /usr/local/opt/openvpn/sbin
  ${path[@]}
)

manpath=(
  /usr/local/opt/gnu-sed/libexec/gnuman
  /usr/local/opt/grep/libexec/gnuman
  /usr/local/opt/gnu-getopt/share/man
  /usr/local/opt/gnu-tar/libexec/gnuman
  /usr/local/opt/gawk/libexec/gnuman
  /usr/local/opt/findutils/libexec/gnuman
  ${manpath[@]}
)

typeset -gxU infopath INFOPATH
infopath=(
  /usr/local/info
  /usr/local/share/info
  ${infopath[@]}
)

# ruby, go, python, mysql
path=(
  $HOME/.rbenv/version/3.0.0/bin
  $CARGO_HOME/bin
  $XDG_DATA_HOME/gem/bin
  $HOME/opt/anaconda3/bin
  $GOPATH/bin
  /usr/local/mysql/bin/
  ${path[@]}
)

# ruby
eval "$(rbenv init - --no-rehash)"
# perlbrew
source "$HOME/perl5/perlbrew/etc/bashrc"
# rakubrew
# eval "$(/usr/local/mybin/rakubrew init Zsh)"
# }}}

# keep limelight / dircolors alive {{{
# killall limelight &> /dev/null; limelight &> /dev/null &
# pueue clean && pueue status | rg -Fq 'limelight' || chronic pueue add limelight
ts -C && ts -l | rg -Fq 'limelight' || chronic ts limelight

d="$XDG_CONFIG_HOME/dircolors/gruv.dircolors"; test -r $d && eval "$(dircolors $d)"
# }}}


export PATH
typeset -U path fpath manpath infopath

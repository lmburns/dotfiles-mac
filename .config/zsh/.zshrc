# === general settings === {{{
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

umask 022

typeset -g HISTSIZE=10000000
typeset -g HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
typeset -g SAVEHIST=10000000
typeset -g HIST_STAMPS="yyyy-mm-dd"
typeset -g HISTORY_FILTER_EXCLUDE=("jrnl", "youtube-dl", "you-get")
typeset -g TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
typeset -g PROMPT_EOL_MARK=''
# export ZSH_DISABLE_COMPFIX=true

setopt hist_ignore_space    append_history      hist_ignore_all_dups
setopt share_history        inc_append_history  extended_history
setopt auto_menu            complete_in_word    always_to_end
setopt autocd               auto_pushd          pushd_ignore_dups
setopt pushdminus           long_list_jobs      interactive_comments
setopt glob_dots            extended_glob       menu_complete
setopt no_flow_control      case_glob           notify

typeset -gx ZINIT_HOME="$ZDOTDIR/zinit"
typeset -gx GENCOMP_DIR="$ZDOTDIR/completions"
typeset -gx GENCOMPL_FPATH="$ZDOTDIR/completions"
pchf="${0:h}/patches"
thmf="${0:h}/themes"

fpath+=( ${ZDOTDIR}/{functions,completions} )
autoload -Uz $ZDOTDIR/functions/*(:t)

typeset -A ZINIT=(
    HOME_DIR        $ZDOTDIR/zinit
    BIN_DIR         $ZDOTDIR/zinit/bin
    PLUGINS_DIR     $ZDOTDIR/zinit/plugins
    SNIPPETS_DIR    $ZDOTDIR/zinit/snippets
    COMPLETIONS_DIR $ZDOTDIR/zinit/completions
    ZCOMPDUMP_PATH  $ZDOTDIR/.zcompdump
    COMPINIT_OPTS   -C
)

# module_path+=("$ZINIT[BIN_DIR]/zmodules/Src"); zmodload zdharma/zplugin &>/dev/null
# }}}

# === zinit === {{{
zt(){ zinit lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }

[[ ! -f $ZINIT_HOME/bin/zinit.zsh ]] && {
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma/zinit "$ZINIT_HOME/bin"
}

source "$ZINIT_HOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zt light-mode for \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node \
  zinit-zsh/z-a-submods \
  NICHOLAS85/z-a-linkbin \
  atinit'Z_A_USECOMP=1' \
    NICHOLAS85/z-a-eval

# zinit-zsh/z-a-unscope

# zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
# depth=1 jeffreytse/zsh-vi-mode
# zinit wait'0b' light-mode for compile'h*' zdharma/history-search-multi-word
# seletskiy/zsh-fuzzy-search-and-edit
# trackbinds bindmap'\e[1\;6D -> ^[[1;2H; \e[1\;6C -> ^[[1;2F' michaelxmcbride/zsh-dircycle
# zt 2 for zdharma/declare-zsh zdharma/zflai blockf zdharma/zui zinit-zsh/zinit-console
# trigger-load'!crasis' zdharma/zinit-crasis \

# zt atload"!source $ZDOTDIR/.p10k.zsh" lucid nocd for \
#   romkatv/powerlevel10k

# taken from: NICHOLAS85 github
(){
  [[ -f "${thmf}/${1}-pre.zsh" || -f "${thmf}/${1}-post.zsh" ]] && {
    zt light-mode for \
          romkatv/powerlevel10k \
      id-as"${1}-theme" \
      atinit"[[ -f ${thmf}/${1}-pre.zsh ]] && source ${thmf}/${1}-pre.zsh" \
      atload"[[ -f ${thmf}/${1}-post.zsh ]] && source ${thmf}/${1}-post.zsh" \
          zdharma/null
  } || print -P "%F{220}Theme \"${1}\" not found%f"
} "${MYPROMPT=p10k}"

zt 0c light-mode for \
  is-snippet trigger-load'!x' blockf svn \
    OMZ::plugins/extract \
  atload'unalias ofd && alias ofd="open $PWD"' mv"_security -> $ZINIT[COMPLETIONS_DIR]/_security" svn \
    OMZ::plugins/osx \
  pick'bd.zsh' \
    tarrasch/zsh-bd \
  trigger-load'!man' \
    ael-code/zsh-colored-man-pages

zt light-mode for \
    MichaelAquilina/zsh-history-filter \
    MichaelAquilina/zsh-you-should-use \
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
  atload'ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)' \
    hlissner/zsh-autopair \
  blockf compile'lib/*f*~*.zwc' \
    Aloxaf/fzf-tab \
  atload'bindkey -M viins -r "^n"; bindkey -M vicmd -r "^n";
  bindkey -M viins "^n" fzfz-dir-widget; bindkey -M vicmd "^n" fzfz-dir-widget' \
  patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' \
    andrewferrier/fzf-z \
  atinit"forgit_ignore='fgi'" \
      wfxr/forgit \
  atload'add-zsh-hook chpwd @chwpd_dir-history-var;
  add-zsh-hook zshaddhistory @append_dir-history-var; @chwpd_dir-history-var' \
  patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' \
    kadaan/per-directory-history \
  atload'export FZF_MARKS_FILE="${ZPFX}/share/fzf-marks/marks"' \
    urbainvaes/fzf-marks \
    kazhala/dump-cli \
  atinit'zicompinit_fast; zicdreplay' atload'FAST_HIGHLIGHT[chroma-man]=' \
  atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
  compile'.*fast*~*.zwc' nocompletions atpull'%atclone' \
  patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' \
    zdharma/fast-syntax-highlighting

zt 0c light-mode binary for \
  lbin atclone="rm -f ^(rgg|rgv)" \
    lilydjwg/search-and-view \
  lbin'!' patch"${pchf}/%PLUGIN%.patch" reset \
  atload'bindkey -M viins "^u" dotbare-fstat; bindkey -M viins "^d" dotbare-fedit' \
    kazhala/dotbare

zt light-mode is-snippet for \
  $ZDOTDIR/csnippets/*.zsh \
  OMZ::plugins/git \
  OMZ::plugins/iterm2 \
  OMZ::plugins/vi-mode

# ??
zt 0c light-mode null for \
  id-as'Cleanup' nocd atinit'unset -f zt; _zsh_autosuggest_bind_widgets' \
    zdharma/null

# compdef _dotbare_completion_git dotbare
autoload -Uz compinit
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
stty intr '^C'
stty susp '^Z'
stty stop undef
stty discard undef <$TTY >$TTY
zmodload zsh/zprof
autoload +X zman
autoload -Uz zmv zcalc zargs
alias zmv='noglob zmv -W'
unalias run-help && autoload run-help && alias help=run-help
HELPDIR='/usr/local/share/zsh/help'
# zshexpn

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

# === homebrew, custom bins === {{{
path=(
  $HOME/.local/bin
  $XDG_BIN_HOME
  /usr/local/bin
  /usr/local/sbin
  ${path[@]}
)
# }}}

# === sourcing === {{{
# atload'x="$XDG_CONFIG_HOME/broot/launcher/bash/br"; [ -f "$x" ] && source "$x"'

zt light-mode as'null' for \
  atload'x="$HOME/.fzf.zsh"; [ -f "$x" ] && source "$x"' \
    zdharma/null \
  atload'x="$ZDOTDIR/zsh-aliases"; [ -f "$x" ] && source "$x"' \
    zdharma/null \
  atload'x="$ZDOTDIR/lficons"; [ -f "$x" ]  && source "$x"' \
    zdharma/null \
  atload'x="/usr/local/etc/profile.d/autojump.sh"; [ -f "$x" ] && source "$x"' \
    zdharma/null \
  atload'x="$HOME/.iterm2_shell_integration.zsh"; test -e "$x" && source "$x"' \
    zdharma/null \
  atinit'export PERLBREW_ROOT="${XDG_DATA_HOME}/perl5/perlbrew";
  export PERLBREW_HOME="${XDG_DATA_HOME}/perl5/perlbrew-h";
  export PERL_CPANM_HOME="${XDG_DATA_HOME}/perl5/cpanm"' \
  atload'x="$PERLBREW_ROOT/etc/bashrc"; test -e "$x" && source "$x"' \
    zdharma/null
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
perldoc() { command perldoc -n less "$@" | gman -l -; }
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
# remove broken symlinks
rmsym() { find -L . -name . -o -type d -prune -o -type l -exec rm {} +; }
# fixed string rg
frg() { rg -F "$@"; }
time-zsh() { shell=${1-$SHELL}; for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done; }
profile-zsh() { ZSHRC_PROFILE=1 zsh -i -c zprof; }

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
zt 0c light-mode for \
  id-as'ruby_env' has'rbenv' eval'rbenv init - --no-rehash' \
    zdharma/null \
  id-as'thefuck_alias' has'thefuck' eval'thefuck --alias' run-atpull \
    zdharma/null \
  id-as'zoxide_init' has'zoxide' eval'zoxide init --no-aliases zsh'\
  atload'alias z=__zoxide_z c=__zoxide_zi' run-atpull \
    zdharma/null \
  id-as'keychain_init' has'keychain' eval'keychain --agents ssh -q --inherit any --eval id_rsa git burnsac && keychain --agents gpg -q --eval 0xC011CBEF6628B679' \
    zdharma/null \
  id-as'dircolors' has'gdircolors' eval"gdircolors $ZDOTDIR/gruv.dircolors" \
    zdharma/null \
  atload"ts -C && ts -l | rg -Fq 'limelight' || chronic ts limelight" \
    zdharma/null \

# eval "$(/usr/local/mybin/rakubrew init Zsh)"
# eval "$(fakedata --completion zsh)"

# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER="nvim -c 'set ft=man' -"
# export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
export KEYTIMEOUT=15

export PASSWORD_STORE_ENABLE_EXTENSIONS='true'
export PASSWORD_STORE_EXTENSIONS_DIR="$(brew --prefix)/lib/password-store/extensions"

export PDFVIEWER='zathura' # texdoc pdfviewer
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"  # xdg-utils
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"  # vimtex

export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"
export FZFZ_RECENT_DIRS_TOOL='autojump'
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)" # Do not consider 100 character entries
export ZSH_AUTOSUGGEST_COMPLETION_IGNORE="[[:space:]]*"   # Ignore leading whitespace
export ZSH_AUTOSUGGEST_STRATEGY=(dir_history custom_history completion)
export PER_DIRECTORY_HISTORY_BASE="${ZPFX}/share/per-directory-history"
export DUMP_DIR="${ZPFX}/share/dump/trash"
export DUMP_LOG="${ZPFX}/share/dump/log"

# }}}

# === fzf === {{{
# ❱❯❮ --border ,border-left
export FZF_DEFAULT_OPTS="
  --prompt '❱❱ '
  --marker='+'
  --cycle
  --color=fg:#cbccc6,fg+:#707a8c,hl:#707a8c,hl+:#ffcc66
  --color=info:#73d0ff,pointer:#cbccc6,marker:#73d0ff,spinner:#73d0ff
  --color=header:#d4bfff,gutter:-1,prompt:#707a8c,dark
  --reverse --height 60% --ansi --info=inline --multi --border
  --preview-window=:hidden,right:65%:wrap
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
  /usr/local/opt/gnu-sed/share/man
  /usr/local/opt/grep/share/man
  /usr/local/opt/gnu-getopt/share/man
  /usr/local/opt/gnu-tar/share/man
  /usr/local/opt/gawk/share/man
  /usr/local/opt/findutils/share/man
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
# }}}

# keep limelight / dircolors alive {{{
# killall limelight &> /dev/null; limelight &> /dev/null &
# pueue clean && pueue status | rg -Fq 'limelight' || chronic pueue add limelight
# }}}

export PATH
typeset -U path fpath manpath infopath

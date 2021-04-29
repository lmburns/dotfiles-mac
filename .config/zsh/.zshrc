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

typeset -gx ZINIT_HOME="${0:h}/zinit"
typeset -gx GENCOMP_DIR="${0:h}/completions"
typeset -gx GENCOMPL_FPATH="${0:h}/completions"
local pchf="${0:h}/patches"
local thmf="${0:h}/themes"

typeset -A ZINIT=(
    HOME_DIR        $ZDOTDIR/zinit
    BIN_DIR         $ZDOTDIR/zinit/bin
    PLUGINS_DIR     $ZDOTDIR/zinit/plugins
    SNIPPETS_DIR    $ZDOTDIR/zinit/snippets
    COMPLETIONS_DIR $ZDOTDIR/zinit/completions
    ZCOMPDUMP_PATH  $ZDOTDIR/.zcompdump-${HOST/.*/}-${ZSH_VERSION}
    COMPINIT_OPTS   -C
)

fpath+=( ${0:h}/{functions,completions} )
autoload -Uz ${0:h}/functions/*(:t)
module_path+=("$ZINIT[BIN_DIR]/zmodules/Src"); zmodload zdharma/zplugin &>/dev/null
# }}}

# === zinit === {{{
zt(){ zinit lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }

[[ ! -f $ZINIT[BIN_DIR]/zinit.zsh ]] && {
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma/zinit "$ZINIT[BIN_DIR]"
}

source "$ZINIT[BIN_DIR]/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zt light-mode for \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-submods \
  NICHOLAS85/z-a-linkman \
  NICHOLAS85/z-a-linkbin \
  atinit'Z_A_USECOMP=1' \
    NICHOLAS85/z-a-eval

# zinit-zsh/z-a-unscope - /z-a-bin-gem-node - /z-a-as-monitor - /z-a-rust

# command-not-found -- jeffreytse/zsh-vi-mode
# zdharma/declare-zsh zdharma/zflai blockf zdharma/zui zinit-zsh/zinit-console
# trigger-load'!crasis' zdharma/zinit-crasis \

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

[[ $MYPROMPT != dolphin ]] && add-zsh-hook chpwd chpwd_ls

zt 0c light-mode for \
  is-snippet trigger-load'!x' blockf svn \
    OMZ::plugins/extract \
  trigger-load'!man' \
    ael-code/zsh-colored-man-pages \
  trigger-load'!updatelocal' blockf compile'f*/*~*.zwc' \
    NICHOLAS85/updatelocal \
  trigger-load'!gcomp' blockf \
  atclone'command rm -rf lib/*;git ls-files -z lib/ |xargs -0 git update-index --skip-worktree' \
  submods'RobSis/zsh-completion-generator -> lib/zsh-completion-generator;
  nevesnunes/sh-manpage-completions -> lib/sh-manpage-completions' \
  atload'gcomp(){gencomp "${@}" && zinit creinstall -q ${ZINIT[SNIPPETS_DIR]}/config 1>/dev/null}' \
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
    felipec/git-completion \
  pick'zsh-history-filter.plugin.zsh' \
    MichaelAquilina/zsh-history-filter \
  pick'you-should-use.plugin.zsh' \
    MichaelAquilina/zsh-you-should-use

zt 0b light-mode for \
  atload'ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)' \
    hlissner/zsh-autopair \
  blockf compile'lib/*f*~*.zwc' \
    Aloxaf/fzf-tab \
  atload'bindkey -M viins -r "^n"; bindkey -M vicmd -r "^n";
  bindkey -M viins "^n" fzfz-dir-widget; bindkey -M vicmd "^n" fzfz-dir-widget' \
  patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' \
    andrewferrier/fzf-z \
  autoload'#manydots-magic' \
    knu/zsh-manydots-magic \
  patch"${pchf}/%PLUGIN%.patch" blockf nocompletions compile'functions/*~*.zwc' \
    marlonrichert/zsh-edit \
  atinit"forgit_ignore='fgi'" \
      wfxr/forgit \
  atload'add-zsh-hook chpwd @chwpd_dir-history-var;
  add-zsh-hook zshaddhistory @append_dir-history-var; @chwpd_dir-history-var' \
  patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' \
    kadaan/per-directory-history \
  atload'export FZF_MARKS_FILE="${ZPFX}/share/fzf-marks/marks"' \
    urbainvaes/fzf-marks \
  pick'async.zsh' \
    mafredri/zsh-async \
  patch"${pchf}/%PLUGIN%.patch" atload'bindkey "^p" fuzzy-search-and-edit' \
    seletskiy/zsh-fuzzy-search-and-edit \
  atinit'zicompinit_fast; zicdreplay' atload'unset "FAST_HIGHLIGHT[chroma-man]"' \
  atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
  compile'.*fast*~*.zwc' nocompletions atpull'%atclone' \
  patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' \
    zdharma/fast-syntax-highlighting

zt 0c light-mode binary for \
  lbin'rgg;rgv' atclone='rm -f ^(rgg|rgv); command cp -f --remove-destination $(readlink rgv) rgv' \
    lilydjwg/search-and-view \
  lbin'!' patch"${pchf}/%PLUGIN%.patch" reset \
  atload'bindkey -M viins "^u" db-fstat; bindkey -M viins "^f" db-faddf' \
  atinit'_w_db_fstat() { dotbare fstat; }; zle -N db-fstat _w_db_fstat;
  _w_db_faddf() { dotbare fadd -f; }; zle -N db-faddf _w_db_faddf' \
    kazhala/dotbare \
  lbin patch"${pchf}/%PLUGIN%.patch" reset \
    kazhala/dump-cli \
  lbin'!**/*grep;**/*man;**/*diff' \
  atclone'(){local f;cd -q src;for f (*.sh){mv ${f} ${f:r}};}' \
    eth-p/bat-extras \
  lbin'cht.sh -> cht' id-as'cht.sh' \
    https://cht.sh/:cht.sh \
  lbin"$ZPFX/bin/git-*" atclone'rm -f **/*ignore' src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
    tj/git-extras \
  lbin atload'alias gi="git-ignore"'\
    laggardkernel/git-ignore \
  lbin"$ZPFX/bin/blackbox_*" make"copy-install PREFIX=$ZPFX" \
    StackExchange/blackbox

zt 0c light-mode binary lbin lman from'gh-r' for \
  atclone'mv -f **/*.zsh _bat' atpull'%atclone' \
    @sharkdp/bat \
    @sharkdp/hyperfine \
    @sharkdp/fd \
  atclone'mv -f **/**.zsh _exa' atpull'%atclone' \
    ogham/exa

# BurntSushi/ripgrep \
local graw="https://raw.githubusercontent.com/"

zt 0c light-mode null for \
  lbin from'gh-r' \
  dl"${graw}junegunn/fzf/master/man/man1/fzf.1" lman \
    junegunn/fzf \
  multisrc'shell/{completion,key-bindings}.zsh' id-as'fzf_comp' pick'/dev/null' \
    junegunn/fzf \
  lbin from'gh-r' bpick'*darwin*' dl"${graw}gokcehan/lf/master/lf.1" lman \
  atinit'bindkey -s "^o" "lc\n"' \
  atload'lc() { local __="$(mktemp)" && lf -last-dir-path="$__" "$@";
  d="${"$(<$__)"}" && chronic rm -f "$__" && [ -d "$d" ] && cd "$d"; }' \
    gokcehan/lf \
  lbin from'gh-r' \
    ericchiang/pup \
  lbin'antidot* -> antidot' from'gh-r' atclone'./**/antidot* update 1>/dev/null' atpull'%atclone' \
    doron-cohen/antidot \
  lbin'xurls* -> xurls' from'gh-r' bpick'*darwin_amd64' \
    @mvdan/xurls

zt light-mode is-snippet for \
  $ZDOTDIR/csnippets/*.zsh \
  OMZ::plugins/git \
  OMZ::plugins/iterm2 \
  atload'unalias ofd && alias ofd="open $PWD"' mv"_security -> $ZINIT[COMPLETIONS_DIR]/_security" svn \
    OMZ::plugins/osx \
  OMZ::plugins/vi-mode

# zinit pack"bgn-binary" for fzf

zicompinit_fast; zicdreplay
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
typeset -g HELPDIR='/usr/local/share/zsh/help'
# zshexpn -- zsh -o SOURCE_TRACE -lic ''
# bindkey -c = to command / -u = unused / -n = lookup

bindkey -M vicmd '?' which-command;             bindkey -M visual S add-surround
autoload edit-command-line;                     zle -N edit-command-line
autoload -Uz surround;                          zle -N delete-surround surround
zle -N add-surround surround;                   zle -N change-surround surround
bindkey -M vicmd 'cs' change-surround;          bindkey -M vicmd 'ds' delete-surround
bindkey '^a' autosuggest-accept;                bindkey '^x' autosuggest-execute
bindkey -M vicmd 'vv' edit-command-line
bindkey -M viins 'jk' vi-cmd-mode;              bindkey -M viins 'kj' vi-cmd-mode
bindkey -M vicmd 'H' beginning-of-line;         bindkey -M vicmd 'L' end-of-line
bindkey -M vicmd 'E' backward-kill-line;        bindkey -M viins '^b' backward-delete-word
bindkey -M vicmd 'U' redo;                      bindkey -M vicmd 'u' undo;
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
zstyle ':fzf-tab:complete:(exa|cd):*' fzf-preview '[[ -d $realpath ]] && exa -T --color=always $(readlink -f $realpath)'
zstyle ':fzf-tab:complete:(cp|rm|mv|bat):argument-rest' fzf-preview 'r=$(readlink -f $realpath); bat --color=always -- $r || exa --color=always -- $r'
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

# === sourcing === {{{
# atload'x="$XDG_CONFIG_HOME/broot/launcher/bash/br"; [ -f "$x" ] && source "$x"'
# atload'x="$HOME/.fzf.zsh"; [ -f "$x" ] && source "$x"'

zt light-mode null for \
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
  unset -f conda
  _conda_initialize
  conda "$@"
}
# }}}

# === functions === {{{
# howdoi
# h() { howdoi $@ -c -n 5; }
# hless() { howdoi $@ -c | less --raw-control-chars --quit-if-one-screen --no-init; }
# prevent failed commands from being added to history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1; }
# rsync from local pc to server
rst() { rsync -uvrP $1 root@burnsac.xyz:$2 ; }
rsf() { rsync -uvrP root@burnsac.xyz:$1 $2 ; }
# shred and delete file
sshred() { shred -v -n 1 -z -u  $1;  }
# create py file to sync with ipynb
jupyt() { jupytext --set-formats ipynb,py $1; }
# use up pipe with any file
upp() { cat $1 | up; }
# crypto
ratesx() { curl rate.sx/$1; }
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
# latex documentation serch (as best I can)
latexh() { zathura -f "$@" "$HOME/projects/latex/docs/latex2e.pdf" }
perldoc() { command perldoc -n less "$@" | gman -l -; }
# get help on builtin commands
zm() { man zshbuiltins | less -p "^       $1 "; }
zs() { man zshexpn | less -p "^       $1 "; }
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

time-zsh() { shell=${1-$SHELL}; for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done; }
profile-zsh() { ZSHRC_PROFILE=1 zsh -i -c zprof; }

_fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1"; }
_fzf_compgen_dir() { fd --exclude ".git" --follow --hidden --type d . "$1"; }

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
zt 0c light-mode null for \
  id-as'ruby_env' has'rbenv' nocd eval'rbenv init - --no-rehash' \
    zdharma/null \
  id-as'thefuck_alias' has'thefuck' nocd eval'thefuck --alias' run-atpull \
    zdharma/null \
  id-as'zoxide_init' has'zoxide' nocd eval'zoxide init --no-aliases zsh'\
  atload'alias z=__zoxide_z c=__zoxide_zi' run-atpull \
  atinit'bindkey -s "^k" "c\n"' \
    zdharma/null \
  id-as'keychain_init' has'keychain' run-atpull nocd \
  eval'keychain --agents ssh -q --inherit any --eval id_rsa git burnsac \
  && keychain --agents gpg -q --eval 0xC011CBEF6628B679' \
    zdharma/null \
  id-as'dircolors' has'gdircolors' nocd eval"gdircolors $ZDOTDIR/gruv.dircolors" \
    zdharma/null \
  id-as'limelight-alive' nocd atinit"ts -C && ts -l | rg -Fq 'limelight' || chronic ts limelight" \
    zdharma/null \
  id-as'Cleanup' nocd atinit'unset -f zt; _zsh_autosuggest_bind_widgets' \
    zdharma/null

# eval "$(/usr/local/mybin/rakubrew init Zsh)"
# eval "$(fakedata --completion zsh)"

# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER="nvim -c 'set ft=man' -"
# export MANPAGER="sh -c 'sed -e s/.\\\\x08//g | bat -l man -p'"
typeset -g KEYTIMEOUT=15
typeset -g WORDCHARS=' *?_-.~\'

typeset -gx PASSWORD_STORE_ENABLE_EXTENSIONS='true'
typeset -gx PASSWORD_STORE_EXTENSIONS_DIR="$(brew --prefix)/lib/password-store/extensions"

typeset -gx PDFVIEWER='zathura' # texdoc pdfviewer
typeset -gx XML_CATALOG_FILES="/usr/local/etc/xml/catalog"  # xdg-utils
typeset -gx DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"  # vimtex

typeset -gx RGV_EDITOR='nvim $file +$line'
typeset -gx _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"
typeset -gx FZFZ_RECENT_DIRS_TOOL='autojump'
typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=1
typeset -g ZSH_AUTOSUGGEST_MANUAL_REBIND=1
typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
typeset -g ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)" # Do not consider 100 character entries
typeset -g ZSH_AUTOSUGGEST_COMPLETION_IGNORE="[[:space:]]*"   # Ignore leading whitespace
typeset -g ZSH_AUTOSUGGEST_STRATEGY=(dir_history custom_history completion)
typeset -g PER_DIRECTORY_HISTORY_BASE="${ZPFX}/share/per-directory-history"
typeset -g UPDATELOCAL_GITDIR="${HOME}/opt"
typeset -g DUMP_DIR="${ZPFX}/share/dump/trash"
typeset -g DUMP_LOG="${ZPFX}/share/dump/log"

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

# export FZF_DEFAULT_COMMAND='fd --no-ignore --hidden --follow --exclude ".git"'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
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
  $HOME/.local/bin
  $XDG_BIN_HOME
  /usr/local/bin
  /usr/local/sbin
  ${path[@]}
)

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

path=( "${ZPFX}/bin" "${path[@]}" )          # add to beginning
path=( "${path[@]:#}" )                      # remove empties
# fpath=( "${0:h}/completions" "${fpath[@]}" ) # add to beginning
typeset -gxU path fpath manpath infopath     # clean duplicates / export

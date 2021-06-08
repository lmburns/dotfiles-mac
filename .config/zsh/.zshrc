############################################################################
#    Author: Lucas Burns                                                   #
#     Email: burnsac@me.com                                                #
#      Home: https://github.com/lmburns                                    #
############################################################################

# === general settings === {{{
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

umask 022

typeset -g HISTSIZE=10000000
typeset -g HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
typeset -g SAVEHIST=8000000
typeset -g HIST_STAMPS="yyyy-mm-dd"
typeset -g HISTORY_FILTER_EXCLUDE=("jrnl", "youtube-dl", "you-get")
typeset -g HISTORY_IGNORE="(jrnl|youtube-dl|you-get)"
typeset -g TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
typeset -g PROMPT_EOL_MARK=''

# typeset -g ZSH_DISABLE_COMPFIX=true

setopt hist_ignore_space    append_history      hist_ignore_all_dups
setopt share_history        inc_append_history  extended_history
setopt auto_menu            complete_in_word    always_to_end
setopt autocd               auto_pushd          pushd_ignore_dups
setopt pushdminus           long_list_jobs      interactive_comments
setopt glob_dots            extended_glob       menu_complete
setopt no_flow_control      case_glob           notify
setopt pushd_silent         no_beep             multios

typeset -gx ZINIT_HOME="${0:h}/zinit"
typeset -gx GENCOMP_DIR="${0:h}/completions"
typeset -gx GENCOMPL_FPATH="${0:h}/completions"
local pchf="${0:h}/patches"
local thmf="${0:h}/themes"

typeset -A ZINIT=(
    HOME_DIR        ${0:h}/zinit
    BIN_DIR         ${0:h}/zinit/bin
    PLUGINS_DIR     ${0:h}/zinit/plugins
    SNIPPETS_DIR    ${0:h}/zinit/snippets
    COMPLETIONS_DIR ${0:h}/zinit/completions
    ZCOMPDUMP_PATH  ${0:h}/.zcompdump-${HOST/.*/}-${ZSH_VERSION}
    COMPINIT_OPTS   -C
)

fpath=( ${0:h}/{functions,completions} "${fpath[@]}")
autoload -Uz $fpath[1]/*(:t)
module_path+=( "$ZINIT[BIN_DIR]/zmodules/Src" ); zmodload zdharma/zplugin &>/dev/null

if ! [[ $MYPROMPT = dolphin ]]; then
  autoload -Uz chpwd_recent_dirs add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-file "${TMPDIR}/chpwd-recent-dirs"
  dirstack=($(awk -F"'" '{print $2}' ${$(zstyle -L ':chpwd:*' recent-dirs-file)[4]} 2>/dev/null))
  [[ ${PWD} = ${HOME}  || ${PWD} = "." ]] && (){
    local dir
    for dir ($dirstack){
      [[ -d "${dir}" ]] && { cd -q "${dir}"; break }
    }
  } 2>/dev/null
fi
# }}}

# === zinit === {{{
# zt(){ zinit lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }
zt(){ zinit depth'3' lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }
grman() {
  local graw="https://raw.githubusercontent.com";
  @zinit-substitute; print -r "${graw}/%USER%/%PLUGIN%/master/${@:1}%PLUGIN%.1";
}

[[ ! -f $ZINIT[BIN_DIR]/zinit.zsh ]] && {
  command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
  command git clone https://github.com/zdharma/zinit "$ZINIT[BIN_DIR]"
}

source "$ZINIT[BIN_DIR]/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# === annex, prompt === {{{
zt light-mode for \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-submods \
  NICHOLAS85/z-a-linkman \
  NICHOLAS85/z-a-linkbin \
  atinit'Z_A_USECOMP=1' \
  NICHOLAS85/z-a-eval

# zinit-zsh/z-a-rust
# zinit-zsh/z-a-as-monitor

(){
  [[ -f "${thmf}/${1}-pre.zsh" || -f "${thmf}/${1}-post.zsh" ]] && {
    zt light-mode for \
        romkatv/powerlevel10k \
      id-as"${1}-theme" \
      atinit"[[ -f ${thmf}/${1}-pre.zsh ]] && source ${thmf}/${1}-pre.zsh" \
      atload"[[ -f ${thmf}/${1}-post.zsh ]] && source ${thmf}/${1}-post.zsh" \
        zdharma/null
  } || print -P "%F{4}Theme \"${1}\" not found%f"
} "${MYPROMPT=p10k}"

[[ $MYPROMPT != dolphin ]] && add-zsh-hook chpwd chpwd_ls
# }}} === annex, prompt ===

# === trigger-load block ==={{{
# unsure why only works with number
zt 0a light-mode for \
  is-snippet trigger-load'!x' blockf svn \
    OMZ::plugins/extract \
  trigger-load'!bd' pick'bd.zsh' \
    tarrasch/zsh-bd \
  trigger-load'!man' \
    ael-code/zsh-colored-man-pages \
  patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' \
  trigger-load'!updatelocal' blockf compile'f*/*~*.zwc' \
    NICHOLAS85/updatelocal \
  trigger-load'!ga;!grh;!grb;!glo;!gd;!gcf;!gclean;!gss;!gcp;!gcb' \
    wfxr/forgit \
  trigger-load'!zhooks' \
    agkozak/zhooks \
  trigger-load'!gcomp' blockf \
  atclone'command rm -rf lib/*;git ls-files -z lib/ |xargs -0 git update-index --skip-worktree' \
  submods'RobSis/zsh-completion-generator -> lib/zsh-completion-generator;
  nevesnunes/sh-manpage-completions -> lib/sh-manpage-completions' \
  atload'gcomp(){gencomp "${@}" && zinit creinstall -q "${GENCOMP_DIR}" 1>/dev/null}' \
     Aloxaf/gencomp
# }}} === trigger-load block ===

# OMZP::sudo/sudo.plugin.zsh

# === wait'0a' block === {{{
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
    MichaelAquilina/zsh-you-should-use \
  lbin'!' patch"${pchf}/%PLUGIN%.patch" reset \
  atload'bindkey "$terminfo[kf1]" dotbare-fstat;
  bindkey "$terminfo[kf2]" db-faddf' \
  atinit'_w_db_faddf() { dotbare fadd -f; }; zle -N db-faddf _w_db_faddf' \
    kazhala/dotbare \
  lbin'!' atload'export BMUX_DIR="$XDG_CONFIG_HOME/bmux";
  bindkey "${terminfo[kf3]}" _wbmux' \
  atinit'_wbmux() { bmux }; zle -N _wbmux' \
    kazhala/bmux \
  lbin'!hist' blockf nocompletions compile'functions/*~*.zwc' \
    marlonrichert/zsh-hist \
    anatolykopyl/doas-zsh-plugin \
  pick'timewarrior.plugin.zsh' \
     svenXY/timewarrior
  # pick'zsh-pipx.plugin.zsh' \
  #   thuandt/zsh-pipx
# }}} === wait'0a' block ===

# zdharma/zflai
# FIX: why doesn't work with zsh-edit ? bindkey -c maybe
# trackbinds bindmap'!"∂" -> _dirstack; "^[-" -> "ß"; "^[=" -> "ƒ"' \

#  === wait'0b' - patched === {{{
zt 0b light-mode patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' for \
  atload'ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)' \
    hlissner/zsh-autopair \
  trackbinds bindmap'^G -> ^N' \
    andrewferrier/fzf-z \
  blockf nocompletions compile'functions/*~*.zwc' \
    marlonrichert/zsh-edit \
  trackbinds bindmap'\e[1\;6D -> ^[[1\;6D; \e[1\;6C -> ^[[1\;6C' \
    michaelxmcbride/zsh-dircycle \
  atload'add-zsh-hook chpwd @chwpd_dir-history-var;
  add-zsh-hook zshaddhistory @append_dir-history-var; @chwpd_dir-history-var' \
    kadaan/per-directory-history \
  atinit'zicompinit_fast; zicdreplay;' atload'unset "FAST_HIGHLIGHT[chroma-man]"' \
  atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
  compile'.*fast*~*.zwc' nocompletions atpull'%atclone' \
    zdharma/fast-syntax-highlighting
#  }}} === wait'0b' - patched ===

#  === wait'0b' === {{{
zt 0b light-mode for \
  blockf compile'lib/*f*~*.zwc' \
    Aloxaf/fzf-tab \
  autoload'#manydots-magic' \
    knu/zsh-manydots-magic \
  pick'async.zsh' \
    mafredri/zsh-async \
  patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' \
  atload'bindkey "^p" fuzzy-search-and-edit' \
    seletskiy/zsh-fuzzy-search-and-edit \
  pick'formarks.plugin.zsh' \
  atload'export PATHMARKS_FILE="${ZPFX}/share/fzf-marks/marks"' \
  atinit'export FZF_MARKS_JUMP="^k"' \
    wfxr/formarks \
  compile'h*' trackbinds bindmap'^R -> ^F' \
  atload'
  zstyle ":history-search-multi-word" highlight-color "fg=cyan,bold";
  zstyle ":history-search-multi-word" page-size "16"' \
    zdharma/history-search-multi-word \
  atload'
  zstyle ":notify:*" command-complete-timeout 3
  zstyle ":notify:*" error-title "Command failed (in #{time_elapsed} seconds)"
  zstyle ":notify:*" success-title "Command finished (in #{time_elapsed} seconds)"' \
    marzocchi/zsh-notify \
  pick'autoenv.zsh' nocompletions \
  atload'AUTOENV_AUTH_FILE="${ZPFX}/share/autoenv/autoenv_auth"' \
    Tarrasch/zsh-autoenv
#  }}} === wait'0b' ===

# lbin'cmds/*' atinit'zstyle ":plugin:zconvey" greeting "none"' \
#     zdharma/zconvey \
# zstyle ":notify:*" notifier plg-zsh-notify
# zstyle ":plugin:zconvey" greeting "none"

#  === wait'0c' - programs - sourced === {{{
zt 0c light-mode binary for \
  lbin'rgg;rgv' atclone='rm -f ^(rgg|rgv); command cp -f --remove-destination $(readlink rgv) rgv' \
    lilydjwg/search-and-view \
  lbin patch"${pchf}/%PLUGIN%.patch" reset \
    kazhala/dump-cli \
  lbin'!**/*grep;**/*man;**/*diff' \
  atclone'(){local f;builtin cd -q src;for f (*.sh){mv ${f} ${f:r}};}' \
  atload'alias bdiff="batdiff" bm="batman" bgrep="env -u RIPGREP_CONFIG_PATH batgrep"' \
    eth-p/bat-extras \
  lbin'cht.sh -> cht' id-as'cht.sh' \
    https://cht.sh/:cht.sh \
  lbin"$ZPFX/bin/git-*" atclone'rm -f **/*ignore' \
  src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
    tj/git-extras \
  lbin atload'alias gi="git-ignore"'\
    laggardkernel/git-ignore \
  lbin"$ZPFX/bin/blackbox_*" make"copy-install PREFIX=$ZPFX" \
    StackExchange/blackbox \
  lbin'(f*~*.zsh)' pick'*.zsh' \
  atinit'alias fs="fstat"' \
    lmburns/fzfgit \
  patch"${pchf}/%PLUGIN%.patch" reset \
  lbin'!src/pt*(*)' \
  atclone'(){local f;builtin cd -q src;for f (*.sh){mv ${f} ${f:r:l}};}' \
  atclone"command mv -f config $ZPFX/share/ptSh/config" \
  atload'alias ppwd="ptpwd" mkd="ptmkdir -pv" touch="pttouch"' \
    jszczerbinsky/ptSh \
  lbin from'gh-r' bpick atload'alias tt="taskwarrior-tui"' \
    kdheepak/taskwarrior-tui
#  }}} === wait'0c' - programs - sourced ===

#  === wait'0c' - programs + man === {{{
zt 0c light-mode binary lbin lman from'gh-r' for \
  atclone'mv -f **/*.zsh _bat' atpull'%atclone' \
    @sharkdp/bat \
    @sharkdp/hyperfine \
    @sharkdp/fd \
  atclone'mv -f **/**.zsh _exa' atpull'%atclone' \
    ogham/exa \
  atclone'mv -f **/**.zsh _dog' atpull'%atclone' \
    ogham/dog \
  atclone'./just --completions zsh > _just' atpull'%atclone' \
    casey/just \
  atclone'./wutag/wutag print-completions zsh > _wutag' atpull'%atclone' \
    wojciechkepka/wutag \
  lbin'**/gh' atclone'./**/gh completion --shell zsh > _gh' atpull'%atclone' \
    cli/cli \
  lbin'rclone/rclone' bpick'*osx-amd64*' mv'rclone* -> rclone' \
  atclone'./rclone/rclone genautocomplete zsh _rclone' \
  atpull'%atclone' \
    rclone/rclone
#  }}} === wait'0c' - programs + man ===

#  === wait'0c' - programs === {{{
zt 0c light-mode null for \
  lbin from'gh-r' dl"$(grman man/man1/)" lman \
    junegunn/fzf \
  multisrc'shell/{completion,key-bindings}.zsh' id-as'fzf_comp' pick'/dev/null' \
  atload"bindkey -r '\ec'; bindkey 'ç' fzf-cd-widget" \
    junegunn/fzf \
  lbin from'gh-r' bpick'*darwin*' dl"$(grman)" lman \
  atinit'bindkey -s "^o" "lc\n"' \
  atload'lc() { local __="$(mktemp)" && lf -last-dir-path="$__" "$@";
  d="${"$(<$__)"}" && chronic rm -f "$__" && [ -d "$d" ] && cd "$d"; }' \
    gokcehan/lf \
  lbin'antidot* -> antidot' from'gh-r' atclone'./**/antidot* update 1>/dev/null' atpull'%atclone' \
    doron-cohen/antidot \
  lbin'xurls* -> xurls' from'gh-r' bpick'*darwin_amd64' \
    @mvdan/xurls \
  lbin'bin/*' dl"$(grman man/)" lman \
    mklement0/perli \
  lbin'q -> dq' from'gh-r' \
    natesales/q \
  lbin'a*.pl -> arranger' \
  atclone'mkdir -p $XDG_CONFIG_HOME/arranger; cp *.conf $XDG_CONFIG_HOME/arranger' \
    anhsirk0/file-arranger \
  lbin'lax' atclone'cargo install --path .' \
    Property404/lax \
  lbin'desed' atclone'cargo install --path .' dl"$(grman)" lman \
    SoptikHa2/desed \
  lbin'f2' from'gh-r' \
    ayoisaiah/f2 \
  lbin"!**/nvim" from'gh-r' lman bpick'*macos*' \
    neovim/neovim \
  lbin from'gh-r' bpick'*darwin_amd64*' \
  atload"source $ZPFX/share/pet/pet_atload.zsh " \
    knqyf263/pet \
  lbin atclone'make build' \
    @motemen/gore \
  lbin from'gh-r' bpick'*darwin_amd64*' \
    traefik/yaegi \
  lbin from'gh-r' ver'nightly' \
    ClementTsang/bottom \
  lbin from'gh-r' bpick'*darwin*' \
    ms-jpq/sad \
  lbin from'gh-r' \
    ducaale/xh \
  lbin from'gh-r' \
    itchyny/mmv \
  lbin atclone'./autogen.sh && ./configure --enable-unicode && make install' \
    KoffeinFlummi/htop-vim \
  lbin'* -> git-xargs' from'gh-r' bpick'*darwin_amd64*' \
    gruntwork-io/git-xargs \
  lbin'* -> sd' from'gh-r' bpick'*darwin' \
    chmln/sd \
  lbin has'recode' \
    Bugswriter/tuxi \
  lbin'!target/release/viu' atclone'cargo install --path .' \
  atpull'%atclone' has'cargo' \
    atanunq/viu \
  lbin from'gh-r' bpick'*darwin*' blockf \
    x-motemen/ghq \
  atclone'mkdir -p $XDG_CONFIG_HOME/tmux/plugins/tpm;
  ln -sf $PWD/tmux-plugins---tpm $XDG_CONFIG_HOME/tmux/plugins/tpm' \
  atpull'%atclone' \
    tmux-plugins/tpm \
  lbin'target/release/hoard' atclone'cargo build --release' \
  atpull'%atclone' \
    Shadow53/hoard \
  lbin from'gh-r' bpick'*macos.tar.gz' \
  atinit'export XPLR_BOOKMARK_FILE="$XDG_CONFIG_HOME/xplr/bookmarks"' \
    sayanarijit/xplr \
  lbin'* -> ruplacer' from'gh-r' bpick'*osx*' \
  atinit'alias rup="ruplacer"' \
    dmerejkowsky/ruplacer \
  lbin'* -> renamer' from'gh-r' bpick'*macos*' \
    adriangoransson/renamer \
  lbin'target/release/fclones' atclone'cargo build --release'  \
  atpull'%atclone' \
    pkolaczk/fclones \
  lbin'target/release/tldr' atclone'cargo build --release' \
  atclone"mv -f zsh_* _tldr" \
    dbrgn/tealdeer \
  lbin from'gh-r' \
    koalaman/shellcheck \
  lbin'shfmt* -> shfmt' from'gh-r' bpick'*darwin_amd64' \
    @mvdan/sh \
  lbin'sops* -> sops' from'gh-r' bpick'*darwin' \
    mozilla/sops \
  lbin'q-* -> q' from'gh-r' bpick'*Darwin' \
    harelba/q \
  lbin from'gh-r' bpick'*darwin*' \
    wagoodman/dive \
  lbin lman make"YANKCMD=pbcopy PREFIX=$ZPFX install" \
    mptre/yank

# orhun/gpg-tui
# @dalance/procs
# nivekuil/rip == cosmos72/gomacro == gruntwork-io

#  }}} === wait'0c' - programs ===

#  === snippet block === {{{
zt light-mode is-snippet for \
  $ZDOTDIR/csnippets/*.zsh \
  OMZ::plugins/iterm2 \
  atload'unalias ofd && alias ofd="open $(pwd)"' \
  mv"_security -> $ZINIT[COMPLETIONS_DIR]/_security" svn \
    OMZ::plugins/osx
#  }}} === snippet block ===
# }}} == zinit closing ===

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
# ztodo
autoload -Uz zmv zcalc zargs zed
alias zmv='noglob zmv -W'
unalias run-help && autoload run-help && alias help=run-help
typeset -g HELPDIR='/usr/local/share/zsh/help'
# zshexpn -- zsh -o SOURCE_TRACE -lic ''
# bindkey -c = to command / -u = unused / -n = lookup / -U multiple

# bindkey '^I' expand-or-complete-prefix
bindkey -M vicmd '?' which-command;             bindkey -M visual S add-surround
autoload -Uz edit-command-line;                 zle -N edit-command-line
autoload -Uz surround;                          zle -N delete-surround surround
zle -N add-surround surround;                   zle -N change-surround surround
bindkey -M vicmd 'cs' change-surround;          bindkey -M vicmd 'ds' delete-surround
# bindkey '^a' autosuggest-accept
bindkey '^a' autosuggest-execute;
bindkey -M vicmd 'VV' edit-command-line;        bindkey -s "µ" "frd\n"
bindkey -M viins 'jk' vi-cmd-mode;              bindkey -M viins 'kj' vi-cmd-mode
bindkey -M vicmd 'H' beginning-of-line;         bindkey -M vicmd 'L' end-of-line
bindkey -M vicmd 'E' backward-kill-line;        bindkey -M viins '^b' backward-delete-word
bindkey -M vicmd 'U' redo;                      bindkey -M vicmd 'u' undo;
bindkey -s '^B' 'obmark\n';
# }}}

# zt 1c light-mode null for \
#   atinit'bindkey -c "$terminfo[kf1]" "frd"' zdharma/null

# === completion === {{{
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps -p $word -o comm="" -w -w'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ':fzf-tab:complete:nvim:*' fzf-preview \
  'r=$realpath; ([[ -f $r ]] && bat --style=numbers --color=always $r) \
  || ([[ -d $r ]] && tree -C $r | less) || (echo $r 2> /dev/null | head -200)'
zstyle ':fzf-tab:complete:nvim:argument-rest' fzf-flags '--preview-window=nohidden,right:65%:wrap'
zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-preview "git --git-dir=$UPDATELOCAL_GITDIR/\${word}/.git log --color --date=short --pretty=format:'%Cgreen%cd %h %Creset%s %Cred%d%Creset ||%b' ..FETCH_HEAD 2>/dev/null"
zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-flags '--preview-window=down:5:wrap'
zstyle ':fzf-tab:complete:(exa|cd):*' popup-pad 30 0
zstyle ':fzf-tab:complete:(exa|cd|cd_):*' fzf-flags '--preview-window=nohidden,right:65%:wrap'
zstyle ':fzf-tab:complete:(exa|cd|cd_):*' fzf-preview '[[ -d $realpath ]] && exa -T --color=always $(readlink -f $realpath)'
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
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
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

# === functions === {{{
# howdoi
# h() { howdoi $@ -c -n 5; }
# hless() { howdoi $@ -c | less --raw-control-chars --quit-if-one-screen --no-init; }
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
pbcpd() { builtin pwd | tr -d "\r\n" | pbcopy; }
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
# cd into directory
take() { mkdir -p $@ && cd ${@:$#} }
# html to markdown
w2md() { wget -qO - "$1" | iconv -t utf-8 | html2text -b 0; }
# sha of a directory
sha256dir() { fd . -tf -x sha256sum {} | cut -d' ' -f1 | sort | sha256sum | cut -d' ' -f1; }
allcmds() { print -l ${commands[@]} | awk -F'/' '{print $NF}' | fzf; }
# remove broken symlinks
rmsym() { command rm -- *(-@D); }
rmsymr() { command rm -- **/*(-@D); }
# add -x to apply changes -- f2 -f ' '
rmspace() { f2 -f '\s' -r '_' -RF $@ }
rmdouble() { f2 -f '(\w+) \((\d+)\).(\w+)' -r '$2-$1.$3' $@ }
# monitor core dumps
moncore() { fswatch --event-flags /cores/ | xargs -I{} terminal-notifier -message {} -title 'coredump'; }

e() { lax -f nvim "@${1}"; }
macfeh() { open -b "drabweb.macfeh" "$@"; }
time-zsh() { shell=${1-$SHELL}; for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done; }
profile-zsh() { ZSHRC_PROFILE=1 zsh -i -c zprof | bat; }
pj() { perl -MCpanel::JSON::XS -0777 -E '$ip=decode_json <>;'"$@" ; }
jqy() { yq r -j "$1" | jq "$2" | yq - r; }
whic() { (alias; declare -f) | /usr/local/bin/gwhich --tty-only --read-alias --read-functions --show-tilde --show-dot $@; }
jpeg() { jpegoptim -S "${2:-1000}" "$1"; jhead -purejpg "$1" && du -sh "$1"; }
pngo() { optipng -o"${2:-3}" "$1"; exiftool -all= "$1" && du -sh "$1"; }
png() { pngquant --speed "${2:-4}" "$1"; exiftool -all= "$1" && du -sh "$1"; }
osxnotify() { osascript -e 'display notification "'"$*"'"'; }
taskdate() { date -d "+${*}" "+%FT%R"; }

xd() {
  pth="$(xplr)"
  if [[ "$pth" != "$PWD" ]]; then
    if [[ -d "$pth" ]]; then
      cd "$pth"
    elif [[ -f "$pth" ]]; then
      cd "$(dirname "$pth")"
    fi
  fi
}
# }}}

# === helper functions === {{{
# prevent failed commands from being added to history
zshaddhistory() {
  emulate -L zsh
  whence ${${(z)1}[1]} >| /dev/null || return 1
  [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}

_zsh_autosuggest_strategy_dir_history(){ # avoid zinit picking this up as a completion
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

per-dir-fzf() {
  if [[ $_per_directory_history_is_global ]]; then
    per-directory-history-toggle-history; fzf-history-widget
  else
    fzf-history-widget
  fi
}
zle -N per-dir-fzf
bindkey '®' per-dir-fzf;     # alt+r

zle -N cqc    # clipboard
bindkey '^X^b' cqc
# }}}

#===== completions ===== {{{
  zt 0c light-mode as'completion' for \
    id-as'poetry_comp' atclone='poetry completions zsh > _poetry' \
    atpull'%atclone' has'poetry' \
      zdharma/null \
    id-as'rust_comp' atclone'rustup completions zsh > _rustup' \
    atclone'rustup completions zsh cargo > _cargo' \
    atpull='%atclone' has'rustup' \
      zdharma/null \
    id-as'pueue_comp' atclone'pueue completions zsh "${GENCOMP_DIR}"' \
    atpull'%atclone' has'pueue' \
      zdharma/null
# }}} ===== completions =====

#===== variables ===== {{{
# Ω = alt-z
zt 0c light-mode null for \
  id-as'ruby_env' has'rbenv' nocd eval'rbenv init - --no-rehash' \
    zdharma/null \
  id-as'thefuck_alias' has'thefuck' nocd eval'thefuck --alias' run-atpull \
    zdharma/null \
  id-as'zoxide_init' has'zoxide' nocd eval'zoxide init --no-aliases zsh' \
  atload'alias o=__zoxide_z c=__zoxide_zi' atinit'bindkey -s "ø" "c\n"' run-atpull \
    zdharma/null \
  id-as'keychain_init' has'keychain' run-atpull nocd \
  eval'keychain --agents ssh -q --inherit any --eval id_rsa git burnsac \
  && keychain --agents gpg -q --eval 0xC011CBEF6628B679' \
    zdharma/null \
  id-as'dircolors' has'gdircolors' nocd eval"gdircolors ${0:h}/gruv.dircolors" \
    zdharma/null \
  id-as'antidot_conf' has'antidot' nocd eval'antidot init' \
    zdharma/null \
  id-as'pyenv_init' has'pyenv' nocd eval'pyenv init - zsh' \
    zdharma/null \
  id-as'pipx_comp' has'pipx' nocd eval'register-python-argcomplete pipx' \
    zdharma/null \
  id-as'Cleanup' nocd atinit'unset -f zt grman; _zsh_autosuggest_bind_widgets' \
    zdharma/null

# FIX: pipx comp doesn't work -- timew as well (bashcompinit)
# id-as'pip_comp' has'pip' nocd eval'pip completion --zsh' zdharma/null
# eval "$(/usr/local/mybin/rakubrew init Zsh)"
# eval "$(fakedata --completion zsh)"

typeset -gx PDFVIEWER='zathura' # texdoc pdfviewer
typeset -gx XML_CATALOG_FILES="/usr/local/etc/xml/catalog"  # xdg-utils
typeset -gx DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"  # vimtex

typeset -gx _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"
typeset -gx _ZO_ECHO=1
typeset -gx FZFZ_RECENT_DIRS_TOOL='autojump'
typeset -gx ZSH_AUTOSUGGEST_USE_ASYNC=1
typeset -gx ZSH_AUTOSUGGEST_MANUAL_REBIND=1
typeset -gx ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
typeset -gx ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)" # no 100+ char
typeset -gx ZSH_AUTOSUGGEST_COMPLETION_IGNORE="[[:space:]]*" # no lead space
typeset -gx ZSH_AUTOSUGGEST_STRATEGY=(dir_history custom_history completion)
typeset -g PER_DIRECTORY_HISTORY_BASE="${ZPFX}/share/per-directory-history"
typeset -gx UPDATELOCAL_GITDIR="${HOME}/opt"
typeset -g DUMP_DIR="${ZPFX}/share/dump/trash"
typeset -g DUMP_LOG="${ZPFX}/share/dump/log"
typeset -gx BREW_PREFIX="$(brew --prefix)"
typeset -gx CDHISTSIZE=75 CDHISTTILDE=TRUE CDHISTCOMMAND=jd
typeset -gx FZFGIT_BACKUP="${XDG_DATA_HOME}/gitback"
typeset -gx FZFGIT_DEFAULT_OPTS="--preview-window=':nohidden,right:65%:wrap'"
typeset -gx NQDIR="$TMPDIR/nq"

typeset -g KEYTIMEOUT=15

typeset -gx PASSWORD_STORE_ENABLE_EXTENSIONS='true'
typeset -gx PASSWORD_STORE_EXTENSIONS_DIR="${BREW_PREFIX}/lib/password-store/extensions"
# }}}

# --color=fg:-1,bg:-1,hl:#ffaf5f,fg+:-1,bg+:-1,hl+:#ffaf5f
# --color=prompt:#5fff87,marker:#ff87d7,spinner:#ff87d7
# --color=fg:#cbccc6,fg+:#707a8c,hl:#707a8c,hl+:#ffcc66
# --color=info:#73d0ff,pointer:#cbccc6,marker:#73d0ff,spinner:#73d0ff

# === fzf === {{{
# ❱❯❮ --border ,border-left
(( ${+commands[fd]} )) && {
  _fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1"; }
  _fzf_compgen_dir() { fd --exclude ".git" --follow --hidden --type d . "$1"; }
}

FZF_COLORS="
--color=fg:-1,bg:-1,hl:#ffaf5f,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=prompt:#5fff87,marker:#ff87d7,spinner:#ff87d7
"
SKIM_COLORS="
--color=fg:#b16286,fg+:#d3869b,hl:#458588,hl+:#689d6a
--color=pointer:#fabd2f,marker:#fe8019,spinner:#b8bb26
--color=header:#cc241d,prompt:#fb4934
"
FZF_FILE_PREVIEW="([[ -f {} ]] && (bat --style=numbers --color=always {}))"
FZF_DIR_PREVIEW="([[ -d {} ]] && (exa -T {} | less))"
FZF_BIN_PREVIEW="([[ \$(file --mime {}) =~ binary ]] && (echo {} is a binary file))"

export FZF_DEFAULT_OPTS="
--prompt '❱ '
--pointer '➤'
--marker '┃'
--cycle
$FZF_COLORS
--reverse --height 80% --ansi --info=inline --multi --border
--preview-window=':hidden,right:60%'
--preview \"($FZF_BIN_PREVIEW || $FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200\"
--bind='?:toggle-preview'
--bind='ctrl-a:select-all,ctrl-r:toggle-all'
--bind='ctrl-b:execute(bat --paging=always -f {+})'
--bind='ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind='ctrl-e:execute(echo {+} | xargs -o nvim)'
--bind='ctrl-v:execute(code {+})'
--bind='ctrl-k:preview-up,ctrl-j:preview-down'
--bind='ctrl-u:half-page-up,ctrl-d:half-page-down'
--bind change:top
"
export SKIM_DEFAULT_OPTIONS="
--prompt '❱❱ '
$SKIM_COLORS
--reverse --height 70% --border --ansi --multi
--preview \"($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200\"
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-b:execute(bat --paging=always -f {+})'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
--bind 'ctrl-v:execute(code {+})'
"
export FZF_ALT_E_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_E_OPTS="
--preview \"($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200\"
--bind 'alt-e:execute($EDITOR {} >/dev/tty </dev/tty)'
--preview-window default:right:60%
"
export FZF_CTRL_R_OPTS="
--preview 'echo {}'
--preview-window 'down:2:wrap'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--header 'Press CTRL-Y to copy command into clipboard'
--exact
--expect=ctrl-x
"
export SKIM_DEFAULT_COMMAND='fd --no-ignore --hidden --follow --exclude ".git"'
# export FZF_DEFAULT_COMMAND='fd --no-ignore --hidden --follow --exclude ".git"'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="cat $HOME/.cd_history"
# export FZF_ALT_C_COMMAND="fd -t d ."
export FORGIT_FZF_DEFAULT_OPTS="--preview-window='right:60%:nohidden'"
export NAVI_FZF_OVERRIDES="--height=70%"

alias db='dotbare'
export DOTBARE_DIR="$XDG_DATA_HOME/dotfiles"
export DOTBARE_TREE="$HOME"
export DOTBARE_BACKUP="$XDG_DATA_HOME/dotbare-b"
export DOTBARE_FZF_DEFAULT_OPTS="
$FZF_DEFAULT_OPTS
--header='A:select-all, B:pager, Y:copy, E:nvim'
--preview-window=:nohidden
--preview \"($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200\"
--bind 'ctrl-a:select-all'
--bind 'ctrl-b:execute(bat --paging=always -f {+})'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
"
# }}}

# === paths (GNU) === {{{
[[ -z ${path[(re)$HOME/.local/bin]} ]] && path=( "$HOME/.local/bin" "${path[@]}" )
[[ -z ${path[(re)/usr/local/bin]} ]] && path=( "/usr/local/bin" "${path[@]}" )
[[ -z ${path[(re)/usr/local/sbin]} ]] && path=( "/usr/local/sbin" "${path[@]}" )

path=(
  /usr/local/opt/coreutils/libexec/gnubin(N-/)
  /usr/local/opt/gnu-sed/libexec/gnubin(N-/)
  /usr/local/opt/gnu-getopt/bin(N-/)
  /usr/local/opt/grep/libexec/gnubin(N-/)
  /usr/local/opt/gnu-tar/libexec/gnubin(N-/)
  /usr/local/opt/gawk/libexec/gnubin(N-/)
  /usr/local/opt/findutils/libexec/gnubin(N-/)
  /usr/local/opt/ed/libexec/gnubin(N-/)
  /usr/local/opt/file-formula/bin(N-/)
  /usr/local/opt/util-linux/bin(N-/)
  /usr/local/opt/flex/bin(N-/)
  /usr/local/opt/libressl/bin(N-/)
  /usr/local/opt/unzip/bin(N-/)
  /usr/local/opt/openvpn/sbin(N-/)
  ${path[@]}
)

# $HOME/opt/anaconda3/man
manpath=(
  /usr/local/opt/gnu-sed/share/man(N-/)
  /usr/local/opt/grep/share/man(N-/)
  /usr/local/opt/gnu-getopt/share/man(N-/)
  /usr/local/opt/gnu-tar/share/man(N-/)
  /usr/local/opt/gawk/share/man(N-/)
  /usr/local/opt/findutils/share/man(N-/)
  /usr/local/opt/gnu-which/share/man(N-/)
  /usr/local/opt/file-formula/share/man(N-/)
  /usr/local/opt/util-linux/share/man(N-/)
  /usr/local/opt/gnu-getopt/share/man(N-/)
  ${manpath[@]}
)

typeset -gxU infopath INFOPATH
infopath=(
  /usr/local/info
  /usr/local/share/info
  ${infopath[@]}
)

# typeset -gxU cdpath CDPATH
# cdpath=(
#   $HOME
#   $HOME/projects
#   $HOME/projects/github
#   $XDG_CONFIG_HOME
# )

# ruby, go, python, mysql
# $HOME/opt/anaconda3/bin
path=(
  $HOME/.rbenv/version/3.0.0/bin(N-/)
  $PYENV_ROOT/shims(N-/)
  $PYENV_ROOT/bin(N-/)
  $CARGO_HOME/bin(N-/)
  $XDG_DATA_HOME/gem/bin(N-/)
  $GOPATH/bin(N-/)
  /usr/local/mysql/bin(N-/)
  $HOME/.poetry/bin(N-/)
  ${path[@]}(N-/)
)

# llvm
# export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"
# flex
export LDFLAGS="-L/usr/local/opt/flex/lib"
export CPPFLAGS="-I/usr/local/opt/flex/include"
# bison
export PATH="/usr/local/opt/bison/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/bison/lib"
# libressl
export LDFLAGS="-L/usr/local/opt/libressl/lib"
export CPPFLAGS="-I/usr/local/opt/libressl/include"
export PKG_CONFIG_PATH="/usr/local/opt/libressl/lib/pkgconfig"
# }}}

# === sourcing === {{{
# atload'x="$XDG_CONFIG_HOME/broot/launcher/bash/br"; [ -f "$x" ] && source "$x"'
# atload'x="$HOME/.fzf.zsh"; [ -f "$x" ] && source "$x"'

zt light-mode null id-as for \
  multisrc="$ZDOTDIR/{zsh-aliases,lficons,git-xargs-token}" \
    zdharma/null \
  atload'local x="$HOME/.iterm2_shell_integration.zsh"; [ -f "$x" ] && source "$x"' \
    zdharma/null \
  atinit'
  export PERLBREW_ROOT="${XDG_DATA_HOME}/perl5/perlbrew";
  export PERLBREW_HOME="${XDG_DATA_HOME}/perl5/perlbrew-h";
  export PERL_CPANM_HOME="${XDG_DATA_HOME}/perl5/cpanm"' \
  atload'local x="$PERLBREW_ROOT/etc/bashrc"; [ -f "$x" ] && source "$x"' \
    zdharma/null \
  atload'export FAST_WORK_DIR=XDG;
  fast-theme XDG:mod-default.ini &>/dev/null' \
    zdharma/null \
  atload'chronic pueue clean && pueue status | rg -Fq "limelight" || chronic pueue add limelight' \
    zdharma/null \
  atload'local x="$XDG_CONFIG_HOME/cdhist/cdhist.rc"; [ -f "$x" ] && source "$x"' \
    zdharma/null

# atload"source $XDG_DATA_HOME/fonts/i_all.sh" zdharma/null
# nocd atinit"TS_SOCKET=/tmp/ts1 ts -C && ts -l | rg -Fq 'limelight' || chronic ts limelight"

# recache keychain if older than GPG cache time or first login
# FIX: || $(tty) =~ ttys00
[[ -f "$ZINIT[PLUGINS_DIR]/keychain_init"/eval*~*.zwc(#qN.ms+45000) ]] && {
  zinit recache keychain_init
  print -P "%F{12}===> Keychain recached <===%f"
}
# }}}

local fdir="${BREW_PREFIX}/share/zsh/site-functions"
[[ -z ${fpath[(re)$fdir]} && -d "$fdir" ]] && fpath=( "${fpath[@]}" "${fdir}" )

[[ -z ${path[(re)$XDG_BIN_HOME]} && -d "$XDG_BIN_HOME" ]] && path=( "$XDG_BIN_HOME" "${path[@]}")
[[ -z ${path[(re)/$ZPFX/bin]} ]] && path=( "${ZPFX}/bin" "${path[@]}" )

path=( "${path[@]:#}" )                            # remove empties
typeset -gxU path fpath manpath infopath cdpth     # clean duplicates / export

# vim: set sw=0 ts=2 sts=2 et ft=zsh fdm=marker fmr={{{,}}}:

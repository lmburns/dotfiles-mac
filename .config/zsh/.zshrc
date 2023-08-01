############################################################################
#    Author: Lucas Burns                                                   #
#     Email: burnsac@me.com                                                #
#      Home: https://github.com/lmburns                                    #
############################################################################

# === general settings === [[[
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

umask 022
# limit coredumpsize 0

typeset -gaxU path fpath manpath infopath cdpath mailpath
typeset -fuz zkbd
typeset -ga mylogs
typeset -F4 SECONDS=0
function zflai-msg()    { mylogs+=( "$1" ); }
function zflai-assert() { mylogs+=( "$4"${${${1:#$2}:+FAIL}:-OK}": $3" ); }
function zflai-print()  {
  print -rl -- ${(%)mylogs//(#b)(\[*\]): (*)/"%F{1}$match[1]%f: $match[2]"};
}

# Write zprof to $mylogs
function zflai-zprof() {
  local -a arr; arr=( ${(@f)"$(zprof)"} )
  for idx ({3..7}) {
    zflai-msg "[zprof]: ${arr[$idx]##*)[[:space:]]##}"
  }
}

zflai-msg "[path]: ${${(pj:\n\t:)path}}"

typeset -g DIRSTACKSIZE=20
typeset -ga histignore=(youtube-dl you-get yt-dlp history exit)
# typeset -g SAVEHIST=10_000_000
typeset -g SAVEHIST=$(( 10 ** 7 ))  # 10_000_000
typeset -g HISTSIZE=$(( 1.2 * SAVEHIST ))
typeset -g HISTFILE="${XDG_CACHE_HOME}/zsh/zsh_history"
typeset -g HIST_STAMPS="yyyy-mm-dd"
typeset -g LISTMAX=50                         # Size of asking history
typeset -g ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;)' # Don't eat space with | with tabs
typeset -g ZLE_SPACE_SUFFIX_CHARS=$'&|'
typeset -g MAILCHECK=0                 # Don't check for mail
typeset -g KEYTIMEOUT=25               # Key action time
typeset -g FCEDIT=$EDITOR              # History editor
typeset -g READNULLCMD=$PAGER          # Read contents of file with <file
typeset -g TMPPREFIX="${TMPDIR%/}/zsh" # Temporary file prefix for zsh
typeset -g PROMPT_EOL_MARK="%F{14}⏎%f" # Show non-newline ending
# setopt no_prompt_cr                    # Can turn off above

watch=( notme )
PERIOD=3600
function periodic() { builtin rehash; }

# Various highlights for CLI
typeset -ga zle_highlight=(
  # region:fg="#a89983",bg="#4c96a8"
  # paste:standout
  region:standout
  special:standout
  suffix:bold
  isearch:underline
  paste:none
)

[[ "$UID" = 0 ]] && { unset HISTFILE && SAVEHIST=0 }

() {
  # local i; i=${(@j::):-%\({1..36}"e,$( echoti cuf 2 ),)"}
  # typeset -g PS4=$'%(?,,\t\t-> %F{9}%?%f\n)'
  # PS4+=$'%2<< %{\e[2m%}%e%22<<             %F{10}%N%<<%f %3<<  %I%<<%b %(1_,%F{11}%_%f ,)'

  declare -g SPROMPT="Correct '%F{17}%B%R%f%b' to '%F{20}%B%r%f%b'? [%F{18}%Bnyae%f%b] : "  # Spelling correction prompt
  declare -g PS2="%F{1}%B>%f%b "  # Secondary prompt
  declare -g RPS2="%F{14}%i:%_%f" # Right-hand side of secondary prompt

  autoload -Uz colors; colors
  local red=$fg_bold[red] blue=$fg[blue] rst=$reset_color
  declare -g TIMEFMT=(
    "$red%J$rst"$'\n'
    "User: $blue%U$rst"$'\t'"System: $blue%S$rst  Total: $blue%*Es$rst"$'\n'
    "CPU:  $blue%P$rst"$'\t'"Mem:    $blue%M MB$rst"
  )
}

setopt no_global_rcs          # startup files in /etc/ won't be ran

setopt hist_ignore_space      # don't add if starts with space
setopt hist_reduce_blanks     # remove superfluous blanks from each command
setopt hist_ignore_all_dups   # replace duplicate commands in history file
setopt hist_expire_dups_first # if the internal history needs to be trimmed, trim oldest
setopt hist_ignore_dups       # do not enter command lines into the history list if they are duplicates
setopt hist_fcntl_lock        # use fcntl to lock hist file
setopt hist_subst_pattern     # allow :s/:& to use patterns instead of strings
setopt extended_history       # add beginning time, and duration to history
setopt append_history         # all zsh sessions append to history, not replace
setopt share_history          # imports commands and appends, can't be used with inc_append_history
setopt no_hist_no_functions   # don't remove function defs from history
# setopt inc_append_history # append to history file immediately, not when shell exits

setopt auto_cd             # if command name is a dir, cd to it
setopt auto_pushd          # cd pushes old dir onto dirstack
setopt pushd_ignore_dups   # don't push dupes onto dirstack
setopt pushd_minus         # inverse meaning of '-' and '+'
setopt pushd_silent        # don't print dirstack after 'pushd' / 'popd'
setopt cd_silent           # don't print dirstack after 'cd'
setopt cdable_vars         # if item isn't a dir, try to expand as if it started with '~'
# setopt chase_dots          # if path segment has '..' within it, resolve it if it's a symlink

# setopt case_match        # when using =~ make expression sensitive to case
setopt rematch_pcre      # when using =~ use PCRE regex
setopt case_paths        # nocaseglob + casepaths treats only path components containing glob chars as insensitive
setopt no_case_glob      # case insensitive globbing
setopt extended_glob     # extension of glob patterns
setopt glob_complete     # generate glob matches as completions
setopt glob_dots         # do not require leading '.' for dotfiles
setopt glob_star_short   # ** == **/*      *** == ***/*
setopt numeric_glob_sort # sort globs numerically
# setopt magicequalsubst   # # ~ substitution and tab completion after a = (for --x=filename args)
# setopt glob_assign       # expand globs on RHS of assignment
# setopt glob_subst        # results from param exp are eligible for filename generation

# setopt recexact         # if a word matches exactly, accept it even if ambiguous
setopt complete_in_word # allow completions in middle of word
setopt always_to_end    # cursor moves to end of word if completion is executed
setopt auto_menu        # automatically use menu completion (non-fzf-tab)
setopt menu_complete    # insert first match from menu if ambiguous (non-fzf-tab)
setopt list_types       # show type of file with indicator at end
setopt list_packed      # completions don't have to be equally spaced
# setopt no_always_to_end

# setopt hash_cmds     # save location of command preventing path search
setopt hash_dirs     # when command is completed hash it and all in the dir
setopt hash_list_all # when a completion is attempted, hash it first
setopt correct      # try to correct mistakes

setopt prompt_subst         # allow substitution in prompt (p10k?)
setopt rc_quotes            # allow '' inside '' to indicate a single '
setopt no_rm_star_silent    # do not query the user before executing `rm *' or `rm path/*'
setopt interactive_comments # allow comments in history
setopt unset                # don't error out when unset parameters are used
setopt long_list_jobs       # list jobs in long format by default
setopt notify               # report status of jobs immediately
setopt short_loops          # allow short forms of for, repeat, select, if, function
# setopt ksh_option_print    # print all options
# setopt brace_ccl           # expand in braces, which would not otherwise, into a sorted list

setopt c_bases              # 0xFF instead of 16#FF
setopt c_precedences        # use precendence of operators found in C
setopt octal_zeroes         # 077 instead of 8#77
setopt multios              # perform multiple implicit tees and cats with redirection

setopt no_flow_control # don't output flow control chars (^S/^Q)
setopt no_hup          # don't send HUP to jobs when shell exits
setopt no_nomatch      # don't print an error if pattern doesn't match
setopt no_beep         # don't beep on error
setopt no_mail_warning # don't print mail warning

local null="zdharma-continuum/null"
declare -gx ABSD=${${(M)OSTYPE:#*(darwin|bsd)*}:+1}
declare -gx ZINIT_HOME="${0:h}/zinit"
declare -gx GENCOMP_DIR="${0:h}/completions"
declare -gx GENCOMPL_FPATH="${0:h}/completions"
declare -gxA Plugs
declare -gxA Zkeymaps=()
declare -gxA Zinfo=(
    patchd  ${0:h}/patches
    themed  ${0:h}/themes
    plugd   ${0:h}/plugins
)
declare -gA ZINIT=(
    HOME_DIR        ${0:h}/zinit
    BIN_DIR         ${0:h}/zinit/bin
    PLUGINS_DIR     ${0:h}/zinit/plugins
    SNIPPETS_DIR    ${0:h}/zinit/snippets
    COMPLETIONS_DIR ${0:h}/zinit/completions
    ZCOMPDUMP_PATH  ${0:h}/.zcompdump-${HOST/.*/}-${ZSH_VERSION}
    COMPINIT_OPTS   -C
)

alias ziu='zi update'
alias zid='zi delete'

zmodload -i zsh/complist
zmodload -F zsh/parameter +p:dirstack
autoload -Uz chpwd_recent_dirs add-zsh-hook cdr zstyle+
add-zsh-hook chpwd chpwd_recent_dirs
add-zsh-hook -Uz zsh_directory_name zsh_directory_name_cdr # cd ~[1]

zstyle+ ':chpwd:*' recent-dirs-default true \
      + ''         recent-dirs-max     20 \
      + ''         recent-dirs-file    "${ZDOTDIR}/chpwd-recent-dirs" \
      + ''         recent-dirs-prune   'pattern:/tmp(|/*)'
# + ''         recent-dirs-file    "${ZDOTDIR}/chpwd-recent-dirs-${TTY##*/}" "${ZDOTDIR}/chpwd-recent-dirs" + \
# + ''         recent-dirs-file    "${ZDOTDIR}/chpwd-recent-dirs-${TTY##*/}" \

zstyle ':completion:*' recent-dirs-insert  both

# Can be called across sessions to update the dirstack without sourcing
# This should be fixed to update across sessions without ever needing to be called
function set-dirstack() {
  [[ -v dirstack ]] || typeset -ga dirstack
  dirstack=(
    ${(u)^${(@fQ)$(<${$(zstyle -L ':chpwd:*' recent-dirs-file)[4]} 2>/dev/null)}[@]:#(\.|$PWD|${TMPDIR:A}/*)}(N-/)
  )
}
set-dirstack

local dir=${(%):-%~}  # ${(D)PWD}
[[ $dir = ('~'|/)* ]] && () {
  # if (( ! $#dirstack && (DIRSTACKSIZE || ! $+DIRSTACKSIZE) )); then
    local d stack=()
    foreach d ($dirstack) {
      {
        if [[ ($#stack -ne 0 || $d != $dir) ]]; then
          d=${~d}
          if [[ -d ${d::=${(g:ceo:)d}} ]]; then
            stack+=($d)
            (( $+DIRSTACKSIZE && $#stack >= DIRSTACKSIZE - 1 )) && break
          fi
        fi
      } always {
        let TRY_BLOCK_ERROR=0
      }
    } 2>/dev/null
    dirstack=($stack)
  # fi
}
alias c=cdr

fpath=( ${0:h}/{functions{/hooks,/lib,/utils,/wrap,/widgets,/zonly},completions} "${fpath[@]}")
autoload -Uz $^fpath[1,7]/*(:t)

# ]]]

# === zinit === [[[
# ========================== zinit-functions ========================== [[[
# Shorten zinit command
zt()       { zinit depth'3' lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }
# Zinit wait if command is already installed
has()      { print -lr -- ${(j: && :):-"[[ ! -v commands[${^@}] ]]"}; }
# Print command to be executed by zinit
mv_clean() { print -lr -- "command mv -f tar*/rel*/${1:-%PLUGIN%} . && cargo clean"; }

# Shorten URL with `dl` annex
grman() {
  local graw="https://raw.githubusercontent.com"; local -A opts
  zparseopts -D -E -A opts -- r: e:
  print -r "${graw}/%USER%/%PLUGIN%/master/${@:1}${opts[-r]:-%PLUGIN%}.${opts[-e]:-1}";
}

# Show the URL <owner/repo>
id_as() {
  print -rl -- ${${(S)${(M)${(@f)"$(cargo show $1)"}:#repository: *}/repository: https:\/\/*\//}//(#m)*/<$MATCH>}
}
# ]]] ========================== zinit-functions ==========================

{
  [[ ! -f $ZINIT[BIN_DIR]/zinit.zsh ]] && {
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdarma-continuum/zinit "$ZINIT[BIN_DIR]"
  }
} always {
  builtin source "$ZINIT[BIN_DIR]/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
}

local zstart=$EPOCHREALTIME

# Unsure if all of this defer here does anything with turbo
zt light-mode for \
  atinit'
  function defer() {
    { [[ -v functions[zsh-defer] ]] && zsh-defer -a "$@"; } || return 0;
  }' \
      romkatv/zsh-defer

# Completions do not work properly if they are placed after the fzf-tab block
# If turbo mode is not used, it doesn't matter where
zt 0b light-mode null id-as for \
  src"$ZDOTDIR/zsh.d/completions.zsh" \
    zdharma-continuum/null

# === annex, prompt === [[[
zt light-mode for \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-submods \
  zdharma-continuum/zinit-annex-bin-gem-node \
  NICHOLAS85/z-a-linkman \
  NICHOLAS85/z-a-linkbin \
    atinit'Z_A_USECOMP=1' \
  NICHOLAS85/z-a-eval \
  lmburns/z-a-check

# zdharma-continuum/zinit-annex-rust
# zdharma-continuum/zinit-annex-as-monitor
# zdharma-continuum/zinit-annex-readurl

(){
  [[ -f "${Zinfo[themed]}/${1}-pre.zsh" || -f "${Zinfo[themed]}/${1}-post.zsh" ]] && {
    zt light-mode for \
        romkatv/powerlevel10k \
      id-as"${1}-theme" \
      atinit"[[ -f ${Zinfo[themed]}/${1}-pre.zsh ]] && source ${Zinfo[themed]}/${1}-pre.zsh" \
      atload"[[ -f ${Zinfo[themed]}/${1}-post.zsh ]] && source ${Zinfo[themed]}/${1}-post.zsh" \
      atload'alias ntheme="$EDITOR ${Zinfo[themed]}/${MYPROMPT}-post.zsh"' \
        zdharma-continuum/null
  } || {
    [[ -f "${Zinfo[themed]}/${1}.toml" ]] && {
      export STARSHIP_CONFIG="${Zinfo[themed]}/${MYPROMPT}.toml"
      export STARSHIP_CACHE="${XDG_CACHE_HOME}/${MYPROMPT}"
      eval "$(starship init zsh)"
      zt 0a light-mode for \
        lbin atclone'cargo br --features=notify-rust' atpull'%atclone' atclone"$(mv_clean)" \
        atclone'./starship completions zsh > _starship' atload'alias ntheme="$EDITOR $STARSHIP_CONFIG"' \
        starship/starship
    }
  } || print -P "%F{4}Theme ${1} not found%f"
} "${MYPROMPT=p10k}"

add-zsh-hook chpwd @chpwd_ls
# ]]] === annex, prompt ===

# === trigger-load block ===[[[
# unsure why only works with number
zt 0a light-mode for \
  is-snippet trigger-load'!x' blockf svn \
    OMZ::plugins/extract \
  trigger-load'!man' \
    ael-code/zsh-colored-man-pages \
  trigger-load'!zhooks' \
    agkozak/zhooks \
  trigger-load'!ugit' \
    Bhupesh-V/ugit \
  trigger-load'!ga;!grh;!grb;!glo;!gd;!gcf;!gco;!gclean;!gss;!gcp;!gcb' \
    wfxr/forgit \
  trigger-load'!hist' blockf nocompletions compile'f*/*~*.zwc' \
    marlonrichert/zsh-hist

# trigger-load'!ftag' blockf compile'f*/ftag~*.zwc' \
#   lmburns/ftag
#
# atinit'forgit_ignore="/dev/null"' \

zt 0a light-mode for \
  trigger-load'!gcomp' blockf \
  atclone'command rm -rf lib/*;git ls-files -z lib/ |xargs -0 git update-index --skip-worktree' \
  submods'RobSis/zsh-completion-generator -> lib/zsh-completion-generator;
  nevesnunes/sh-manpage-completions -> lib/sh-manpage-completions' \
  atload'gcomp(){gencomp "${@}" && zinit creinstall -q "${GENCOMP_DIR}" 1>/dev/null}' \
    Aloxaf/gencomp

# ]]] === trigger-load block ===

# === wait'0a' block === [[[
zt 0a light-mode for \
    OMZ::lib/completion.zsh \
  as'completion' atpull'zinit cclear' blockf \
    zsh-users/zsh-completions \
  ver'develop' atload'_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \
  as'completion' nocompile mv'*.zsh -> _git' \
    felipec/git-completion \
  pick'you-should-use.plugin.zsh' \
    MichaelAquilina/zsh-you-should-use \
  lbin'!' patch"${Zinfo[patchd]}/%PLUGIN%.patch" reset nocompletions \
  atinit'_w_db_faddf() { dotbare fadd -f; }; zle -N db-faddf _w_db_faddf' \
  pick'dotbare.plugin.zsh' \
    kazhala/dotbare \
  pick'timewarrior.plugin.zsh' \
    svenXY/timewarrior \
  pick'async.zsh' \
    mafredri/zsh-async \
  patch"${Zinfo[patchd]}/%PLUGIN%.patch" reset nocompile'!' blockf \
    psprint/zsh-navigation-tools \
    zdharma-continuum/zflai \
  patch"${Zinfo[patchd]}/%PLUGIN%.patch" reset nocompile'!' \
  atinit'alias wzman="ZMAN_BROWSER=w3m zman"' \
  atinit'alias zmand="info zsh "' \
    mattmc3/zman \
    anatolykopyl/doas-zsh-plugin
# ]]] === wait'0a' block ===

#  === wait'0b' - patched === [[[
zt 0b light-mode patch"${Zinfo[patchd]}/%PLUGIN%.patch" reset nocompile'!' for \
  blockf atclone'cd -q functions;renamer --verbose "^\.=@" .*' \
  compile'functions/*~*.zwc' \
    marlonrichert/zsh-edit \
  atload'ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)' \
    hlissner/zsh-autopair \
  trackbinds bindmap'\e[1\;6D -> ^[[1\;6D; \e[1\;6C -> ^[[1\;6C' \
    michaelxmcbride/zsh-dircycle \
  trackbinds bindmap'^H -> ^X^T' \
  atload'add-zsh-hook chpwd @chpwd_dir-history-var;
  add-zsh-hook zshaddhistory @append_dir-history-var; @chpwd_dir-history-var now' \
    kadaan/per-directory-history \
  atinit'zicompinit_fast; zicdreplay;' atload'unset "FAST_HIGHLIGHT[chroma-man]"' \
  atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
  compile'.*fast*~*.zwc' nocompletions atpull'%atclone' \
    zdharma-continuum/fast-syntax-highlighting \
  atload'vbindkey "Up" history-substring-search-up;
         vbindkey "Down" history-substring-search-down' \
    zsh-users/zsh-history-substring-search \
  trackbinds bindmap"^R -> ^W" \
    m42e/zsh-histdb-fzf
#  ]]] === wait'0b' - patched ===

#  === wait'0b' === [[[
zt 0b light-mode for \
  blockf compile'lib/*f*~*.zwc' \
    Aloxaf/fzf-tab \
  autoload'#manydots-magic' \
    knu/zsh-manydots-magic \
    RobSis/zsh-reentry-hook \
  compile'h*' trackbinds bindmap'^R -> ^F' \
  atload'
  zstyle ":history-search-multi-word" highlight-color "fg=cyan,bold";
  zstyle ":history-search-multi-word" page-size "16"' \
    zdharma-continuum/history-search-multi-word \
  wait'[[ $TERM != "alacritty" && -n "$DISPLAY" ]]' \
  atload'
  zstyle ":notify:*" command-complete-timeout 3
  zstyle ":notify:*" error-title "Command failed (in #{time_elapsed} seconds)"
  zstyle ":notify:*" success-title "Command finished (in #{time_elapsed} seconds)"' \
    marzocchi/zsh-notify \
  pick'*plugin*' blockf nocompletions compile'*.zsh~*.zwc' \
  src"histdb-interactive.zsh" atload'HISTDB_FILE="${ZDOTDIR}/.zsh-history.db"' \
  atinit'bindkey "\Ce" _histdb-isearch' \
    larkery/zsh-histdb \
  pick'autoenv.zsh' nocompletions \
  atload'AUTOENV_AUTH_FILE="${ZPFX}/share/autoenv/autoenv_auth"' \
    Tarrasch/zsh-autoenv \
  blockf \
    zdharma-continuum/zui \
    zdharma-continuum/zbrowse

# lbin'!bin/*' \
#   bigH/git-fuzzy
# TODO: Delete git fuzzy after done using it for testing

#  ]]] === wait'0b' ===

#  === wait'0c' - programs - sourced === [[[
zt 0c light-mode binary for \
  lbin'!**/*grep;**/*man;**/*diff' has'bat' atpull'%atclone' \
  atclone'(){local f;builtin cd -q src;for f (*.sh){mv ${f} ${f:r}};}' \
  atload'alias bdiff="batdiff" bm="batman" bgrep="env -u RIPGREP_CONFIG_PATH batgrep"' \
    eth-p/bat-extras \
  lbin'cht.sh -> cht' id-as'cht.sh' \
    https://cht.sh/:cht.sh \
  lbin"$ZPFX/bin/git-*" atclone'rm -f **/*ignore' \
  src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" \
    tj/git-extras \
  lbin atload'alias giti="git-ignore"'\
    laggardkernel/git-ignore \
  lbin'f*~*.zsh' pick'*.zsh' atinit'alias fs="fstat"' \
    lmburns/fzfgit \
  patch"${Zinfo[patchd]}/%PLUGIN%.patch" reset \
  lbin'!src/pt*(*)' \
  atclone'(){local f;builtin cd -q src;for f (*.sh){mv ${f} ${f:r:l}};}' \
  atclone"command mv -f config $ZPFX/share/ptSh/config" \
  atload'alias mkd="ptmkdir -pv"' \
    jszczerbinsky/ptSh \
  lbin atclone"mkdir -p $XDG_CONFIG_HOME/ytfzf; cp **/conf.sh $XDG_CONFIG_HOME/ytfzf" \
    pystardust/ytfzf \
  wait"$(has surfraw)" lbin from'gl' atclone'./prebuild; ./configure --prefix="$ZPFX"; make' \
  make"install"  atpull'%atclone' atload'alias srg="sr google"' \
    surfraw/Surfraw \
  wait"$(has xsel)" lbin atclone'./autogen.sh; ./configure --prefix="$ZPFX"; make' \
  make"install" atpull'%atclone' lman \
    kfish/xsel \
  wait"$(has w3m)" lbin atclone'./configure --prefix="$ZPFX"; make' \
  make"install" atpull'%atclone' lman \
    tats/w3m \
  lbin atclone'./autogen.sh && ./configure --enable-unicode --prefix="$ZPFX"' \
  make'install' atpull'%atclone' lman \
    KoffeinFlummi/htop-vim \
  wait"$(has tmux)" lbin bpick'*.tar.gz*' patch"${Zinfo[patchd]}/%PLUGIN%.patch" lman \
  atclone'./autogen.sh && ./configure --prefix=$ZPFX' make"install PREFIX=$ZPFX" atpull'%atclone' \
    tmux/tmux \
  atclone'local d="$XDG_CONFIG_HOME/tmux/plugins";
  [[ ! -d "$d" ]] && mkdir -p "$d"; ln -sf %DIR% "$d/tpm"' \
  atpull'%atclone' \
    tmux-plugins/tpm \
  lbin lman \
    sdushantha/tmpmail \
  lbin'*/tag' make'tag' lman wait'[[ $OSTYPE = darwin* ]]' \
    jdberry/tag \
  lbin wait'[[ $OSTYPE = darwin* ]]' \
    ttscoff/vitag \
  lbin bpick'*.tar.gz' atclone'autoconf; ./configure --prefix="$ZPFX"; make' \
  make'install' lman wait'[[ $OSTYPE = darwin* ]]' \
    moretension/duti \
  lbin'**/rga;**/rga-*' from'gh-r' mv'rip* -> rga' bpick'*64-apple*' \
    phiresky/ripgrep-all \
  lbin from'gh-r' bpick'*64-apple*' atinit'export NAVI_FZF_OVERRIDES="--height=70%"' \
    denisidoro/navi \
  lbin atload'alias palette::full="ansi --color-codes" palette::codes="ansi --color-table"' \
    fidian/ansi \
  lbin atclone"./build.zsh" mv"*.*completion -> _zunit" atpull"%atclone" \
    molovo/zunit \
  lbin mv"*.*completion -> _revolver" \
    molovo/revolver \
  lbin'**/fzf-panes.tmux; **/fzfp' \
    kevinhwang91/fzf-tmux-script
#  ]]] === wait'0c' - programs - sourced ===

#  === wait'0c' - programs + man === [[[
zt 0c light-mode binary lbin lman from'gh-r' for \
  atclone'mv -f **/*.zsh _bat' atpull'%atclone' \
    @sharkdp/bat \
    @sharkdp/hyperfine \
    @sharkdp/fd \
    @sharkdp/diskus \
    @sharkdp/pastel \
  atclone'mv rip*/* .' bpick'*64-apple*' \
    BurntSushi/ripgrep \
  atclone'mv -f **/**.zsh _exa' atpull'%atclone' \
    ogham/exa \
  atclone'mv -f **/**.zsh _dog' atpull'%atclone' \
    ogham/dog \
  atclone'./just --completions zsh > _just' atpull'%atclone' \
    casey/just \
  atclone'./imdl --completions zsh > _imdl' atpull'%atclone' \
    casey/intermodal \
  lbin'rclone/rclone' bpick'*osx-amd64*' mv'rclone* -> rclone' \
  atclone'./rclone/rclone genautocomplete zsh _rclone' atpull'%atclone' \
    rclone/rclone \
  lbin'*/*/aria2c' bpick'*win.tar*' \
    aria2/aria2 \
  lman'*/**.1' atinit'export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"' \
    ajeetdsouza/zoxide

# lbin'**/hub' extract'!' atclone'mv -f **/**.zsh* _hub' atpull'%atclone' \
#   @github/hub \
#  ]]] === wait'0c' - programs + man ===

#  === wait'0c' - programs === [[[
zt 0c light-mode null for \
  lbin from'gh-r' dl"$(grman man/man1/ -r sk)" lman \
    lotabout/skim \
  multisrc'shell/{completion,key-bindings}.zsh' id-as'skim_comp' pick'/dev/null' \
    lotabout/skim \
  id-as'sk-tmux' lbin \
  atclone"xh --download https://raw.githubusercontent.com/lotabout/skim/master/bin/sk-tmux -o sk-tmux" \
    zdharma-continuum/null \
  lbin from'gh-r' dl"$(grman man/man1/)" lman \
    junegunn/fzf \
  multisrc'shell/{completion,key-bindings}.zsh' id-as'fzf_comp' pick'/dev/null' \
  atload"bindkey -r '\ec'; bindkey '^[c' fzf-cd-widget" \
    junegunn/fzf \
  lbin'antidot* -> antidot' from'gh-r' atclone'./**/antidot* update 1>/dev/null' \
  atpull'%atclone' \
    doron-cohen/antidot \
  lbin'xurls* -> xurls' from'gh-r' bpick'*darwin_amd64' \
    @mvdan/xurls \
  lbin'q -> dq' from'gh-r' \
    natesales/q \
  lbin'a*.pl -> arranger' \
  atclone'mkdir -p $XDG_CONFIG_HOME/arranger; cp *.conf $XDG_CONFIG_HOME/arranger' \
    anhsirk0/file-arranger \
  lbin'*/*/lax' atclone'cargo install --path .' atpull'%atclone'  \
    Property404/lax \
  lbin'*/*/desed' atclone'cargo install --path .' dl"$(grman)" lman \
    SoptikHa2/desed \
  lbin'f2' from'gh-r' \
    ayoisaiah/f2 \
  lbin patch"${Zinfo[patchd]}/%PLUGIN%.patch" reset atclone'cargo br' \
  atclone"$(mv_clean)" atpull'%atclone' has'cargo' \
    crockeo/taskn \
  lbin atclone'make build' \
    @motemen/gore \
  lbin from'gh-r' bpick'*darwin_amd64*' \
    traefik/yaegi \
  lbin'bin/*' dl"$(grman man/)" lman \
    mklement0/perli \
  lbin from'gh-r' \
    koalaman/shellcheck \
  lbin'shfmt* -> shfmt' from'gh-r' bpick'*darwin_amd64' \
    @mvdan/sh \
  lbin'q-* -> q' from'gh-r' bpick'*Darwin' \
    harelba/q \
  lbin lman make"YANKCMD=pbcopy PREFIX=$ZPFX install" \
    mptre/yank \
  lbin'uni* -> uni' from'gh-r' bpick'*n-amd64*' \
    arp242/uni \
  lbin'dad;diana' atinit'export DIANA_DOWNLOAD_DIR="$HOME/Downloads/Aria"' \
    baskerville/diana \
  lbin has'recode' \
    Bugswriter/tuxi \
  lbin'jq-* -> jq' from'gh-r' dl"$(grman -e '1.prebuilt')" lman \
  atclone'mv jq.1* jq.1' \
    stedolan/jq \
  lbin from'gh-r' mv'yq_* -> yq' atclone'./yq shell-completion zsh > _yq' \
  atpull'%atclone' \
    mikefarah/yq \
  lbin'das* -> dasel' from'gh-r' \
    TomWright/dasel \
  lbin'yj* -> yj' from'gh-r' \
    sclevine/yj \
  lbin'b**/r**/crex' atclone'chmod +x build.sh; ./build.sh -r;' \
    octobanana/crex \
  lbin from'gh-r' \
    pemistahl/grex \
  id-as'bisqwit/regex-opt' lbin atclone'xh --download https://bisqwit.iki.fi/src/arch/regex-opt-1.2.4.tar.gz' \
  atclone'ziextract --move --auto regex-*.tar.gz' make'all' \
    zdharma-continuum/null \
  lbin from'gh-r' \
    muesli/duf \
  lbin patch"${Zinfo[patchd]}/%PLUGIN%.patch" make"PREFIX=$ZPFX install" reset \
  atpull'%atclone' atdelete"PREFIX=$ZPFX make uninstall"  \
    zdharma/zshelldoc \
  lbin from'gh-r' bpick'*darwin_amd64*' \
  atload"source $ZPFX/share/pet/pet_atload.zsh" \
    knqyf263/pet

  # lbin"!**/nvim" from'gh-r' lman bpick'*macos*' \
  #   neovim/neovim \
# yq isn't picking up completions

# == rust [[[
zt 0c light-mode null for \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
    miserlou/loop \
  lbin'ff* -> ffsend' from'gh-r' \
    timvisee/ffsend \
  lbin from'gh-r' wait'[[ $OSTYPE = darwin* ]]'  \
    rami3l/pacaptr \
  lbin patch"${Zinfo[patchd]}/%PLUGIN%.patch" reset atclone'cargo br' \
  atclone"$(mv_clean)" \
    XAMPPRocky/tokei \
  lbin atclone'cargo build --release' \
  atclone"command mv -f tar*/rel*/%PLUGIN% . && cargo clean" \
  atpull'%atclone' has'cargo' \
    atanunq/viu \
  lbin from'gh-r' bpick'*darwin*' \
    ms-jpq/sad \
  lbin from'gh-r' \
    ducaale/xh \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
    pkolaczk/fclones \
  lbin from'gh-r' \
    itchyny/mmv \
  lbin atclone"./atuin gen-completions --shell zsh --out-dir $GENCOMP_DIR" \
  eval"atuin init zsh | sed 's/bindkey .*\^\[.*$//g'" \
  atload'alias clean-atuin="kill -9 $(lsof -c atuin -t)"' atpull'%atclone' \
    ellie/atuin \
  lbin'* -> sd' from'gh-r' bpick'*darwin' \
    chmln/sd \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
  atpull'%atclone' \
    lmburns/hoard \
  lbin'* -> ruplacer' from'gh-r' bpick'*osx*' atinit'alias rup="ruplacer"' \
    dmerejkowsky/ruplacer \
  lbin patch"${Zinfo[patchd]}/%PLUGIN%.patch" reset atclone'cargo br' \
  atclone"$(mv_clean rgr)" lman \
    acheronfail/repgrep \
  lbin'* -> renamer' from'gh-r' bpick'*macos*' \
    adriangoransson/renamer \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean tldr)" \
  atclone"mv -f zsh_* _tldr" \
    dbrgn/tealdeer \
  lbin'pueued-* -> pueued' lbin'pueue-* -> pueue' from'gh-r' \
  bpick'*ue-mac*' bpick'*ued-mac*' \
    Nukesor/pueue \
  lbin from'gh-r' bpick'*mac*' \
    @dalance/procs \
  lbin atclone"cargo br" atpull'%atclone' atclone"$(mv_clean)" \
    imsnif/bandwhich \
  lbin atclone"cargo br" atpull'%atclone' atclone"$(mv_clean)" \
    theryangeary/choose \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean dua)" \
    Byron/dua-cli \
  lbin atclone'cargo br' atpull'%atclone' \
  atclone"$(mv_clean lolcate)" atload'alias le=lolcate' \
    lmburns/lolcate-rs \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
  atload'export FW_CONFIG_DIR="$XDG_CONFIG_HOME/fw"; alias wo="workon"' \
    brocode/fw \
  lbin from'gh-r' \
    WindSoilder/hors \
  lbin from'gh-r' \
    samtay/so \
  lbin'* -> podcast' from'gh-r' bpick'*-osx' atclone'podcast completion > _podcast' \
    njaremko/podcast \
  lbin from'gh-r' \
    rcoh/angle-grinder \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean hm)" \
    hlmtre/homemaker \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
    rdmitr/inventorize \
  has'%PLUGIN%' lbin patch"${Zinfo[patchd]}/%PLUGIN%.patch" reset atclone'cargo br' \
  atclone"$(mv_clean)" atpull'%atclone' \
    magiclen/xcompress \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
  atclone"./rip completions --shell zsh > _rip" \
    lmburns/rip \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
  eval'sauce --shell zsh shell init' \
    dancardin/sauce \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean petname)" \
    allenap/rust-petname \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
    neosmart/rewrite \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
  atclone"./rualdi completions shell zsh > _rualdi" \
  atload'alias ru="rualdi"' eval'rualdi init zsh --cmd k' \
    lmburns/rualdi \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
  atload'alias orgr="organize-rt"' \
    lmburns/organize-rt \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
  atload'alias touch="feel"' \
    lmburns/feel \
  lbin'parallel -> par' atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
    lmburns/parallel \
  lbin atclone'cargo br --features=backend-gpgme' atpull'%atclone' \
  atclone"$(mv_clean)" atclone'./prs internal completions zsh' \
    lmburns/prs \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean tidy-viewer)" \
  atload"alias tv='tidy-viewer'" \
    alexhallam/tv \
  lbin from'gh-r' \
    evansmurithi/cloak \
  lbin from'gh-r' \
    lotabout/rargs \
  lbin'* -> hck' from'gh-r' bpick'*os-*64' \
    sstadick/hck \
  lbin lman from'gh-r' \
    greymd/teip \
  lbin from'gh-r' \
    BurntSushi/xsv

# === rust extensions === [[[
zt 0c light-mode null lbin \
  atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" for \
    fornwall/rust-script \
    reitermarkus/cargo-eval \
    fanzeyi/cargo-play \
    iamsauravsharma/cargo-trim \
    andrewradev/cargo-local \
    celeo/cargo-nav \
    g-k/cargo-show \
    mre/cargo-inspect \
    sminez/roc \
    MordechaiHadad/bob

# razrfalcon/cargo-bloat \
# matthiaskrgr/cargo-cache \

# has'!cargo-deps' lbin from'gh-r' \
#   est31/cargo-udeps \
# lbin'tar*/rel*/cargo-{rm,add,upgrade}' \
# atclone'cargo br' atpull'%atclone' \
#   killercup/cargo-edit \
# lbin from'gh-r' \
#   cargo-generate/cargo-generate \
# lbin'{cargo-make,makers}' atclone'cargo br' atpull'%atclone' \
# atclone"command mv -f tar*/rel*/{cargo-make,makers} . && cargo clean" \
# atload'export CARGO_MAKE_HOME="$XDG_CONFIG_HOME/cargo-make"' \
# atload'alias ncmake="$EDITOR $CARGO_MAKE_HOME/Makefile.toml"' \
# atload'alias cm="makers --makefile $CARGO_MAKE_HOME/Makefile.toml"' \
#   sagiegurari/cargo-make \

zt 0c light-mode null for \
  lbin'* -> cargo-temp' from'gh-r' \
    yozhgoor/cargo-temp \
  lbin'tar*/rel*/evcxr' atclone'cargo br' atpull'%atclone' \
    google/evcxr \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean unused-features)" \
    TimonPost/cargo-unused-features \
  lbin'rusty-man' atclone'command git clone https://git.sr.ht/~ireas/rusty-man' \
  atclone'command mv -vf rusty-man/* . && rm -rf rusty-man' \
  atclone'cargo br && cargo doc' atpull'%atclone' id-as'sr-ht/rusty-man' \
  atclone"command mv -f tar*/rel*/rusty-man ." \
  atinit'alias rman="rusty-man" rmand="handlr open https://git.sr.ht/~ireas/rusty-man"' \
    zdharma-continuum/null

# Canop/bacon
# ]]] == rust extensions
# ]]] == rust

# === tui specific block === [[[
zt 0c light-mode null for \
  lbin from'gh-r' bpick'*darwin*' \
    wagoodman/dive \
  lbin atclone'cargo br' atpull'%atclone' atclone"$(mv_clean)" \
    orhun/gpg-tui \
  lbin from'gh-r' ver'nightly' \
    ClementTsang/bottom \
  lbin from'gh-r' bpick'*n_x86*' \
    charmbracelet/glow \
  lbin dl"$(grman)" lman \
  atclone'CGO_ENABLED=0 go build -ldflags="-s -w" .' atpull'%atclone' \
    gokcehan/lf \
  lbin from'gh-r' bpick'*macos.tar.gz' \
  atinit'export XPLR_BOOKMARK_FILE="$XDG_CONFIG_HOME/xplr/bookmarks"' \
    sayanarijit/xplr \
  lbin from'gh-r' atload'alias ld="lazydocker"' \
    jesseduffield/lazydocker \
  lbin from'gh-r' atload'alias lnpm="lazynpm"' \
    jesseduffield/lazynpm
# ]]] === tui specifi block ===

# === git specific block === [[[
zt 0c light-mode null for \
  lbin from'gh-r' bpick'*darwin_amd64*' \
    isacikgoz/gitbatch \
  lbin from'gh-r' bpick'*n_x86*' atload'alias lg="lazygit"' \
    jesseduffield/lazygit \
  lbin from'gh-r' bpick'*darwin*' blockf atload'export GHQ_ROOT="$HOME/ghq"' \
    x-motemen/ghq \
  lbin from'gh-r' bpick'*darwin*' \
    Songmu/ghg \
  lbin atclone'./autogen.sh; ./configure --prefix="$ZPFX"; mv -f **/**.zsh _tig' \
  make'install' atpull'%atclone' mv"_tig -> $ZINIT[COMPLETIONS_DIR]" \
    jonas/tig \
  lbin'**/delta' from'gh-r' patch"${Zinfo[patchd]}/%PLUGIN%.patch" \
    dandavison/delta \
  lbin from'gh-r' \
    extrawurst/gitui \
  lbin from'gh-r' lman \
    rhysd/git-brws \
  lbin'tar*/rel*/mgit' atclone'cargo br' atpull'%atclone' \
    koozz/mgit
# ]]] === git specific block ===

# tshepang/mrh
# cosmos72/gomacro
# gruntwork-io/git-xargs

#  ]]] === wait'0c' - programs ===

#  === snippet block === [[[
zt light-mode is-snippet for \
    OMZ::plugins/iterm2 \
  atload"unalias ofd" \
  mv"_security -> $ZINIT[COMPLETIONS_DIR]/_security" svn \
    OMZ::plugins/osx

zt light-mode nocompile is-snippet for $ZDOTDIR/plugins/*.zsh
zt light-mode is-snippet for $ZDOTDIR/snippets/*.zsh
zt light-mode is-snippet for $ZDOTDIR/snippets/bundled/*.(z|)sh
zt light-mode is-snippet for $ZDOTDIR/snippets/zle/*.zsh
#  ]]] === snippet block ===
# ]]] == zinit closing ===

# === powerlevel10k === [[[
[[ $MYPROMPT == p10k ]] && {
  () {
    local f; f="${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
    [[ -r "$f" ]] && builtin source "$f"
  }
}
# ]]]

# === zsh keybindings === [[[
stty intr '^C'
stty susp '^Z'
stty stop undef
stty discard undef <$TTY >$TTY
# Load when they are needed
zmodload zsh/zprof             # ztodo
zmodload zsh/attr              # extended attributes
zmodload -mF zsh/files b:zf_\* # zf_ln zf_rm etc
autoload -Uz zmv zcalc zargs zed relative zrecompile
alias fned="zed -f"
alias zmv='noglob zmv -v'  zcp='noglob zmv -Cv' zmvn='noglob zmv -W'
alias zln='noglob zmv -Lv' zlns='noglob zmv -o "-s" -Lv'

# autoload -Uz sticky-note regexp-replace

typeset -g HELPDIR='/usr/local/share/zsh/help'
[[ -v aliases[run-help] ]] && unalias run-help
autoload +X -Uz run-help
autoload -Uz $^fpath/run-help-^*.zwc(N:t)

# zmodload -F zsh/parameter p:functions_source
# autoload -Uz $functions_source[run-help]-*~*.zwc
# ]]]

# === helper functions === [[[
# Shorten command length
add-zsh-hook zshaddhistory max_history_len
function max_history_len() {
  if (( $#1 > 240 )) {
    return 2
  }

  return 0
}

# Function that is ran on each command
function zshaddhistory() {
  emulate -L zsh
  local -r line=${1%%$'\n'}
  local -r cmd=${line%% *}
  (( ! $+histignore[(r)${cmd}] ))
}

# Based on directory history
function _zsh_autosuggest_strategy_dir_history() {
  emulate -L zsh -o extended_glob
  if $_per_directory_history_is_global && [[ -r "$_per_directory_history_path" ]]; then
    local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}"
    local pattern="$prefix*"
    if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]; then
      pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"
    fi
    [[ "${dir_history[(r)$pattern]}" != "$prefix" ]] && \
      typeset -g suggestion="${dir_history[(r)$pattern]}"
  fi
}

# Same as above, but not directory specific
function _zsh_autosuggest_strategy_custom_history() {
  emulate -L zsh -o extended_glob
  local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}"
  local pattern="$prefix*"
  if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]; then
    pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"
  fi
  [[ "${history[(r)$pattern]}" != "$prefix" ]] && \
    typeset -g suggestion="${history[(r)$pattern]}"
}

# Histdb is good, though, the above allows for toggling on and off

# Return the latest used command in the current directory
# Else, find most recent command
function _zsh_autosuggest_strategy_histdb_top_here() {
    (( $+functions[_histdb_query] )) || return
#   local query="
# SELECT commands.argv
# FROM   history
#   LEFT JOIN commands
#     ON history.command_id = commands.rowid
#   LEFT JOIN places
#     ON history.place_id = places.rowid
# WHERE places.dir LIKE '$(sql_escape $PWD)%'
#     AND commands.argv LIKE '$(sql_escape $1)%'
# GROUP BY commands.argv
# ORDER BY count(*) desc
# LIMIT    1
# "

  local query="
SELECT commands.argv
FROM   history
  LEFT JOIN commands
    ON history.command_id = commands.rowid
  LEFT JOIN places
    ON history.place_id = places.rowid
WHERE    commands.argv LIKE '$(sql_escape $1)%'
-- GROUP BY commands.argv, places.dir
ORDER BY places.dir != '$(sql_escape $PWD)',
  history.start_time DESC
LIMIT 1
"

  typeset -g suggestion=$(_histdb_query "$query")
}
# ]]]

# === paths (GNU) === [[[
(( ABSD )) && {
  typeset -gx BREW_PREFIX="$(/usr/local/bin/brew --prefix)"
  typeset -gx DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET" # vimtex
}

[[ -z ${path[(re)$HOME/.local/bin]} ]] && path=( "$HOME/.local/bin" "${path[@]}" )
[[ -z ${path[(re)/usr/local/sbin]} ]]  && path=( "/usr/local/sbin"  "${path[@]}" )

# cdpath=( $HOME/{projects,}/github $XDG_CONFIG_HOME )
# hash -d git=$HOME/projects/github
# hash -d pro=$HOME/projects
# hash -d opt=$HOME/opt
hash -d icloud=$HOME/Library/Mobile\ Documents/com~apple~CloudDocs
hash -d zsh=$ZDOTDIR
hash -d ghq=$HOME/ghq
hash -d TMPDIR=${TMPDIR:A}
hash -d config=$XDG_CONFIG_HOME

# HOMEBREW_PREFIX is not reliable when sourced (brew shellenv)
path=(
  ${BREW_PREFIX}/bin
  ${BREW_PREFIX}/opt/{coreutils,gnu-sed,grep,gnu-tar}/libexec/gnubin
  ${BREW_PREFIX}/opt/{gawk,findutils,ed}/libexec/gnubin
  ${BREW_PREFIX}/opt/{gnu-getopt,file-formula,util-linux}/bin
  ${BREW_PREFIX}/opt/{flex,libressl,unzip}/bin
  ${BREW_PREFIX}/opt/openvpn/sbin
  ${BREW_PREFIX}/opt/llvm/bin
  ${BREW_PREFIX}/texlive/2021/bin
  ${BREW_PREFIX}/mysql/bin(N-/)
  "${path[@]}"
)

manpath=(
  ${BREW_PREFIX}/opt/{grep,gawk,gnu-tar,gnu-getopt}/share/man
  ${BREW_PREFIX}/opt/{gnu-sed,findutils,gnu-which,file-formula}/share/man
  ${BREW_PREFIX}/opt/{gnu-getopt,task-spooler,util-linux}/share/man
  "${manpath[@]}"
)

infopath=( ${BREW_PREFIX}/{share,}/info "${infopath[@]}" )

path=(
  $HOME/.ghg/bin
  $HOME/.rbenv/version/3.0.0/bin(N-/)
  $PYENV_ROOT/{shims,bin}
  $CARGO_HOME/bin(N-/)
  $XDG_DATA_HOME/gem/bin(N-/)
  $XDG_DATA_HOME/bob/nvim-bin(N-/)
  $GOPATH/bin(N-/)
  $HOME/.poetry/bin(N-/)
  "${path[@]}"
)

typeset -gx TERMINFO_DIRS="$TERMINFO_DIRS:$XDG_DATA_HOME/terminfo"

### llvm
# export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"
### flex
export LDFLAGS="-L/usr/local/opt/flex/lib"
export CPPFLAGS="-I/usr/local/opt/flex/include"
### bison
export PATH="/usr/local/opt/bison/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/bison/lib"
### libressl
# export PATH="/usr/local/opt/libressl/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/libressl/lib"
# export CPPFLAGS="-I/usr/local/opt/libressl/include"
# export PKG_CONFIG_PATH="/usr/local/opt/libressl/lib/pkgconfig"

export PATH="/usr/local/opt/openssl@3.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@3.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@3.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@3.1/lib/pkgconfig"
# ]]]

#===== completions ===== [[[
  zt 0c light-mode as'completion' for \
    id-as'poetry_comp' atclone='poetry completions zsh > _poetry' \
    atpull'%atclone' has'poetry' \
      zdharma-continuum/null \
    id-as'rust_comp' atclone'rustup completions zsh > _rustup' \
    atclone'rustup completions zsh cargo > _cargo' \
    atpull='%atclone' has'rustup' \
      zdharma-continuum/null \
    id-as'pueue_comp' atclone'pueue completions zsh "${GENCOMP_DIR}"' \
    atpull'%atclone' has'pueue' \
      zdharma-continuum/null

# id-as'brew_setup' has'brew' nocd eval'brew shellenv' \
# ]]] ===== completions =====

#===== variables ===== [[[
zt 0c light-mode run-atpull for \
  id-as'pipx_comp' has'pipx' nocd eval"register-python-argcomplete pipx" \
  atload'zicdreplay -q' \
    zdharma-continuum/null \
  id-as'antidot_conf' has'antidot' nocd eval'antidot init' \
    zdharma-continuum/null \
  id-as'pipenv_comp' has'pipenv' nocd eval'pipenv --completion' \
    zdharma-continuum/null \
  id-as'navi_comp' has'navi' nocd eval'navi widget zsh' \
    zdharma-continuum/null \
  id-as'ruby_env' has'rbenv' nocd eval'rbenv init - --no-rehash' \
    zdharma-continuum/null \
  id-as'zoxide_init' has'zoxide' nocd eval'zoxide init --no-aliases zsh' \
  atload'alias o=__zoxide_z z=__zoxide_zi' \
    zdharma-continuum/null \
  id-as'fw-init' has'fw' nocd eval'fw print-zsh-setup -f' \
    zdharma-continuum/null \
  id-as'keychain_init' has'keychain' nocd \
  eval'keychain --agents ssh -q --inherit any --eval id_rsa git burnsac \
  && keychain --agents gpg -q --eval 0xC011CBEF6628B679' \
    zdharma-continuum/null

  # id-as'pyenv_init' has'pyenv' nocd eval'pyenv init - zsh' \
  #   zdharma-continuum/null \

zt 0c light-mode for \
  id-as'Cleanup' nocd atinit'unset -f zt grman mv_clean has id_as; _zsh_autosuggest_bind_widgets' \
    zdharma-continuum/null

zflai-msg "[zshrc]: Zinit block took ${(M)$(( (EPOCHREALTIME - zstart) * 1000 ))#*.?} ms"

# LS_COLORS defined before zstyle
typeset -gx LS_COLORS="$(vivid -d $ZDOTDIR/zsh.d/vivid/filetypes.yml generate $ZDOTDIR/zsh.d/vivid/kimbie.yml)"
typeset -gx {ZLS_COLORS,TREE_COLORS}="$LS_COLORS"
typeset -gx JQ_COLORS="1;30:0;39:1;36:1;39:0;35:1;32:1;32:1"

typeset -gx GPG_TTY=$TTY
typeset -gx PDFVIEWER='zathura'                                                   # texdoc pdfviewer
typeset -gx XML_CATALOG_FILES="/usr/local/etc/xml/catalog"                        # xdg-utils|asciidoc
typeset -gx FORGIT_LOG_FORMAT="%C(red)%C(bold)%h%C(reset) %Cblue%an%Creset: %s%Creset%C(yellow)%d%Creset %Cgreen(%cr)%Creset"
typeset -gx RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library/
#
typeset -gx ZSH_AUTOSUGGEST_USE_ASYNC=set
typeset -gx ZSH_AUTOSUGGEST_MANUAL_REBIND=set
typeset -gx ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
typeset -gx ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)" # no 100+ char
typeset -gx ZSH_AUTOSUGGEST_COMPLETION_IGNORE="[[:space:]]*" # no lead space
typeset -gx ZSH_AUTOSUGGEST_STRATEGY=(histdb_top_here dir_history custom_history match_prev_cmd completion)
typeset -gx HISTORY_SUBSTRING_SEARCH_FUZZY=set
typeset -gx HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=set
typeset -gx AUTOPAIR_CTRL_BKSPC_WIDGET=".backward-kill-word"
typeset -ga chwpd_dir_history_funcs=( "_dircycle_update_cycled" ".zinit-cd" )
typeset -g PER_DIRECTORY_HISTORY_BASE="${ZPFX}/share/per-directory-history"
typeset -gx NQDIR="$TMPDIR/nq" FNQ_DIR="$HOME/tmp/fnq"
typeset -gx FZFGIT_BACKUP="${XDG_DATA_HOME}/gitback"
typeset -gx FZFGIT_DEFAULT_OPTS="--preview-window=':nohidden,right:65%:wrap'"

typeset -gx PASSWORD_STORE_ENABLE_EXTENSIONS='true'
typeset -gx PASSWORD_STORE_EXTENSIONS_DIR="${BREW_PREFIX}/lib/password-store/extensions"
# ]]]

# === fzf === [[[
# ❱❯❮ --border ,border-left

FZF_COLORS="
--color=fg:-1,fg+:-1,hl:#458588,hl+:#689d6a,bg+:-1
--color=pointer:#fabd2f,marker:#fe8019,spinner:#b8bb26
--color=header:#fb4934,prompt:#b16286
"

typeset -a SKIM_COLORS=(
  "fg:-1" "fg+:-1" "hl:#458588" "hl+:#689d6a" "bg+:-1" "marker:#fe8019"
  "spinner:#b8bb26" "header:#cc241d" "prompt:#fb4934"
)

# matched_bg        Background of highlighted substrings
# current_match_bg  Background of highlighted substrings (current line)
# query             Text of Query (the texts after the prompt)
# query_bg          Background of Query

FZF_FILE_PREVIEW="([[ -f {} ]] && (bat --style=numbers --color=always {}))"
FZF_DIR_PREVIEW="([[ -d {} ]] && (exa -T {} | less))"
FZF_BIN_PREVIEW="([[ \$(file --mime-type -b {}) =~ binary ]] && (echo {} is a binary file))"

export FZF_FILE_PREVIEW FZF_DIR_PREVIEW FZF_BIN_PREVIEW

export FZF_DEFAULT_OPTS="
--prompt '❱ '
--pointer '➤'
--marker '┃'
--cycle
$FZF_COLORS
--reverse
--height=80%
--ansi
--info=inline
--multi
--border
--preview-window=':hidden,right:60%'
--preview \"($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200\"
--bind='?:toggle-preview'
--bind='ctrl-a:select-all,ctrl-r:toggle-all'
--bind='ctrl-b:execute(bat --paging=always -f {+})'
--bind='ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind='alt-e:execute($EDITOR {} >/dev/tty </dev/tty)'
--bind='ctrl-v:execute(code {+})'
--bind='ctrl-s:toggle-sort'
--bind='alt-p:preview-up,alt-n:preview-down'
--bind='ctrl-k:preview-up,ctrl-j:preview-down'
--bind='ctrl-u:half-page-up,ctrl-d:half-page-down'
--bind=change:top"

SKIM_DEFAULT_OPTIONS="
--prompt '❱ '
--cmd-prompt 'c❱ '
--cycle
--reverse --height 80% --ansi --inline-info --multi --border
--preview-window=':hidden,right:60%'
--preview \"($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200\"
--bind='?:toggle-preview,alt-w:toggle-preview-wrap'
--bind='alt-a:select-all,ctrl-r:toggle-all'
--bind='ctrl-b:execute(bat --paging=always -f {+})'
--bind=\"ctrl-y:execute-silent(ruby -e 'puts ARGV' {+} | xsel --trim -b)+abort\"
--bind='alt-e:execute($EDITOR {} >/dev/tty </dev/tty)'
--bind='ctrl-s:toggle-sort'
--bind='alt-p:preview-up,alt-n:preview-down'
--bind='ctrl-k:preview-up,ctrl-j:preview-down'
--bind='ctrl-u:half-page-up,ctrl-d:half-page-down'"
# SKIM_DEFAULT_OPTIONS=${(F)${(M)${(@f)FZF_DEFAULT_OPTS}/(#m)*info*/${${(@s. .)MATCH}:#--info*}}:#--(bind=change:top|pointer*|marker*|color*)}
# SKIM_DEFAULT_OPTIONS+=$'\n'"--cmd-prompt=➤"
# SKIM_DEFAULT_OPTIONS+=$'\n'"--bind='ctrl-p:preview-up,ctrl-n:preview-down'"
SKIM_DEFAULT_OPTIONS+=$'\n'"--color=${(j:,:)SKIM_COLORS}"
export SKIM_DEFAULT_OPTIONS

export FZF_ALT_E_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_E_OPTS="
--preview \"($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200\"
--bind='alt-e:execute($EDITOR {} >/dev/tty </dev/tty)'
--preview-window default:right:60%"
export FZF_CTRL_R_OPTS="
--preview 'echo {}'
--preview-window 'down:2:wrap'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--header 'Press CTRL-Y to copy command into clipboard'
--exact
--expect=ctrl-x"
export SKIM_DEFAULT_COMMAND='fd --no-ignore --hidden --follow --exclude ".git"'
export FZF_DEFAULT_COMMAND="(git ls-tree -r --name-only HEAD | lscolors ||
         rg --files --no-ignore --hidden -g '!{.git,node_modules,target}/*') 2> /dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export SKIM_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_TRIGGER='**'
(( ${+commands[fd]} )) && {
  _fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1"; }
  _fzf_compgen_dir() { fd --exclude ".git" --follow --hidden --type d . "$1"; }
  _fzf_comprun() {
    local command=$1
    shift

    case "$command" in
      cd)           fzf "$@" --preview 'exa -TL 3 --color=always {} | head -200' ;;
      export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
      ssh)          fzf "$@" --preview 'dig {}' ;;
      *)            fzf "$@" ;;
    esac
  }
}

export FZF_ALT_C_COMMAND="fd --no-ignore --hidden --follow --strip-cwd-prefix --exclude '.git' --type d -d 1 | lscolors"
export SKIM_ALT_C_COMMAND="$FZF_ALT_C_COMMAND"
export FZF_ALT_C_OPTS="
--preview \"($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200\"
--bind='alt-e:execute($EDITOR {} >/dev/tty </dev/tty)'
--preview-window default:right:60%"
export FORGIT_FZF_DEFAULT_OPTS="--preview-window='right:60%:nohidden' --bind='ctrl-e:execute(echo {2} | xargs -o nvim)'"
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS --preview \"(exa -T {2} | less) 2>/dev/null | head -200\""

alias db='dotbare'
export DOTBARE_DIR="${XDG_DATA_HOME}/dotfiles"
export DOTBARE_TREE="$HOME"
export DOTBARE_BACKUP="${XDG_DATA_HOME}/dotbare-b"
export DOTBARE_FZF_DEFAULT_OPTS="
$FZF_DEFAULT_OPTS
--header='A:select-all, B:pager, Y:copy, E:nvim'
--preview-window=:nohidden
--preview \"($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200\"
--bind 'ctrl-a:select-all'
--bind 'ctrl-b:execute(bat --paging=always -f {+})'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"

alias dbh='\
  DOTBARE_DIR="${XDG_DATA_HOME}/dotfiles-private" \
  DOTBARE_BACKUP="${XDG_DATA_HOME}/dotbare-b" \
  dotbare'
# ]]]

# == sourcing === [[[
# atload'x="$XDG_CONFIG_HOME/broot/launcher/bash/br"; [ -f "$x" ] && source "$x"'

# atload'local x="$HOME/.iterm2_shell_integration.zsh"; [ -f "$x" ] && source "$x"' \
#   zdharma-continuum/null \

# multisrc="$ZDOTDIR/zsh.d/{aliases,keybindings,lf,functions,tmux,git-token}.zsh" \
zt 0b light-mode null id-as for \
  multisrc="$ZDOTDIR/zsh.d/{aliases,keybindings,lf,functions,git-token}.zsh" \
    zdharma-continuum/null \
  atinit'
  export PERLBREW_ROOT="${XDG_DATA_HOME}/perl5/perlbrew";
  export PERLBREW_HOME="${XDG_DATA_HOME}/perl5/perlbrew-h";
  export PERL_CPANM_HOME="${XDG_DATA_HOME}/perl5/cpanm"' \
  atload'local x="$PERLBREW_ROOT/etc/bashrc"; [ -f "$x" ] && source "$x"' \
    zdharma-continuum/null \
  atload'export FAST_WORK_DIR=XDG;
  fast-theme XDG:kimbox.ini &>/dev/null' \
    zdharma-continuum/null \
  nocd null atload'source "${XDG_DATA_HOME}/cargo/env"' \
    zdharma-continuum/null

# zt 0c light-mode null id-as for \
#   atload'
#   ( [[ -S $XDG_DATA_HOME/pueue/pueue_lucasburns.socket ]] || \
#     pueued -dc "$XDG_CONFIG_HOME/pueue/pueue.yml" ) && {
#     ( chronic pueue clean && pueue status | rg -Fq limelight ) || chronic pueue add limelight
#   }' \
#     zdharma-continuum/null

# nocd atinit"TS_SOCKET=/tmp/ts1 ts -C && ts -l | rg -Fq 'limelight' || TS_SOCKET=/tmp/ts1 ts limelight >/dev/null" \
# nocd atinit"TS_SOCKET=/tmp/ts1 ts -C && ts -l | rg -Fq 'limelight' || chronic ts limelight"
# atload'local x="${XDG_DATA_HOME}/cargo/env"; [ -f "$x" ] && source "$x"'\
# atload"source $XDG_DATA_HOME/fonts/i_all.sh" zdharma-continuum/null

# recache keychain if older than GPG cache time or first login
# local first=${${${(M)${(%):-%l}:#*01}:+1}:-0}
[[ -f "$ZINIT[PLUGINS_DIR]/keychain_init"/eval*~*.zwc(#qN.ms+45000) ]] && {
  zinit recache keychain_init
  print -Pr "%F{13}===========================%f"
  print -Pr "%F{12}===> %BKeychain recached%b <===%f"
  print -Pr "%F{13}===========================%f"
  zle && zle reset-prompt
}
# ]]]

(( ABSD )) && {
  local fdir="${BREW_PREFIX}/share/zsh/site-functions"
  [[ -z ${fpath[(re)$fdir]} && -d "$fdir" ]] && fpath=( "${fpath[@]}" "${fdir}" )
}

[[ -z ${path[(re)$XDG_BIN_HOME]} && -d "$XDG_BIN_HOME" ]] && path=( "$XDG_BIN_HOME" "${path[@]}")

path=( "${ZPFX}/bin" "${path[@]}" )                # add back to be beginning
path=( "${path[@]:#}" )                            # remove empties
path=( "${(u)path[@]}" )                           # remove duplicates; goenv adds twice?

{
  [[ $(defaults read -g InitialKeyRepeat) -ne 14 ]] && krp -d 18
  [[ $(defaults read -g KeyRepeat)        -ne 2  ]] && krp -r 2
} >/dev/null

# default value is 2 (30ms ?), each tick = 15ms
# defaults write NSGlobalDomain KeyRepeat -int 2
# default value is 15 (225ms), each tick = 15ms
# defaults write NSGlobalDomain InitialKeyRepeat -int 18

zflai-msg "[zshrc] File took ${(M)$(( SECONDS * 1000 ))#*.?} ms"

# vim: set sw=0 ts=2 sts=2 et ft=zsh fdm=marker fmr=[[[,]]]:

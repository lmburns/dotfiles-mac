############################################################################
#    Author: Lucas Burns                                                   #
#     Email: burnsac@me.com                                                #
#      Home: https://github.com/lmburns                                    #
############################################################################

# === general settings === [[[
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

umask 022

typeset -gaxU path fpath manpath infopath cdpath
typeset -fuz zkbd

typeset -ga mylogs
typeset -F4 SECONDS=0
zflai-msg() { mylogs+=( "$1" ); }
zflai-assert() { mylogs+=( "$4"${${${1:#$2}:+FAIL}:-OK}": $3" ); }

zflai-msg "[path] $path"

typeset -g HISTSIZE=10000000
typeset -g HISTFILE="$XDG_CACHE_HOME/zsh/zsh_history"
typeset -g SAVEHIST=8000000
typeset -g HIST_STAMPS="yyyy-mm-dd"
typeset -ga HISTORY_FILTER_EXCLUDE=("jrnl", "youtube-dl", "you-get")
typeset -g HISTORY_IGNORE="(jrnl|youtube-dl|you-get)"
typeset -g TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
typeset -g PROMPT_EOL_MARK=''
# typeset -g ZSH_DISABLE_COMPFIX=true

setopt hist_ignore_space    append_history      hist_ignore_all_dups  no_hist_no_functions
setopt share_history        inc_append_history  extended_history      cdable_vars
setopt auto_menu            complete_in_word    always_to_end         no_mail_warning
setopt autocd               auto_pushd          pushd_ignore_dups     rc_quotes
setopt pushdminus           pushd_silent        interactive_comments  hash_cmds
setopt glob_dots            extended_glob       menu_complete         hash_list_all
setopt no_flow_control      no_case_glob        notify                hist_fcntl_lock
setopt long_list_jobs       no_beep             multios               numeric_glob_sort
setopt prompt_subst

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
  # zstyle ':completion:*' recent-dirs-insert fallback
  # zstyle ':chpwd:*' recent-dirs-file "${TMPDIR}/chpwd-recent-dirs"
  zmodload -F zsh/parameter p:dirstack
  autoload -Uz chpwd_recent_dirs add-zsh-hook cdr
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-file "${ZDOTDIR}/chpwd-recent-dirs"
  dirstack=( ${(u)^${(@fQ)$(<${$(zstyle -L ':chpwd:*' recent-dirs-file)[4]} 2>/dev/null)}[@]:#(\.|$PWD|${TMPDIR:A}/*)}(N-/) )
  [[ ${PWD} = ${HOME} || ${PWD} = "." ]] && (){
    local dir
    for dir ($dirstack){
      [[ -d "${dir}" ]] && { cd -q "${dir}"; break }
    }
  } 2>/dev/null
fi
alias cr=cdr
# ]]]

# === zinit === [[[
# zt(){ zinit lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }
zt(){ zinit depth'3' lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }
grman() {
  local graw="https://raw.githubusercontent.com"; local -A opts
  zparseopts -D -E -A opts -- r: e: ; @zinit-substitute
  print -r "${graw}/%USER%/%PLUGIN%/master/${@:1}${opts[-r]:-%PLUGIN%}.${opts[-e]:-1}";
}

[[ ! -f $ZINIT[BIN_DIR]/zinit.zsh ]] && {
  command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
  command git clone https://github.com/zdharma/zinit "$ZINIT[BIN_DIR]"
}

source "$ZINIT[BIN_DIR]/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# === annex, prompt === [[[
zt light-mode for \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-submods \
  NICHOLAS85/z-a-linkman \
  NICHOLAS85/z-a-linkbin \
  atinit'Z_A_USECOMP=1' \
  NICHOLAS85/z-a-eval

# zinit-zsh/z-a-rust
# zinit-zsh/z-a-as-monitor
# zinit-zsh/z-a-readurl

(){
  [[ -f "${thmf}/${1}-pre.zsh" || -f "${thmf}/${1}-post.zsh" ]] && {
    zt light-mode for \
        romkatv/powerlevel10k \
      id-as"${1}-theme" \
      atinit"[[ -f ${thmf}/${1}-pre.zsh ]] && source ${thmf}/${1}-pre.zsh" \
      atload"[[ -f ${thmf}/${1}-post.zsh ]] && source ${thmf}/${1}-post.zsh" \
        zdharma/null
  } || print -P "%F{4}Theme ${1} not found%f"
} "${MYPROMPT=p10k}"

[[ $MYPROMPT != dolphin ]] && add-zsh-hook chpwd chpwd_ls
# ]]] === annex, prompt ===

# === trigger-load block ===[[[
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
  trigger-load'!zhooks' \
    agkozak/zhooks \
  trigger-load'!ugit' \
    Bhupesh-V/ugit \
  trigger-load'!ga;!grh;!grb;!glo;!gd;!gcf;!gco;!gclean;!gss;!gcp;!gcb' \
    wfxr/forgit \
  trigger-load'!gcomp' blockf \
  atclone'command rm -rf lib/*;git ls-files -z lib/ |xargs -0 git update-index --skip-worktree' \
  submods'RobSis/zsh-completion-generator -> lib/zsh-completion-generator;
  nevesnunes/sh-manpage-completions -> lib/sh-manpage-completions' \
  atload'gcomp(){gencomp "${@}" && zinit creinstall -q "${GENCOMP_DIR}" 1>/dev/null}' \
    Aloxaf/gencomp \
  trigger-load'!hist' blockf nocompletions compile'f*/*~*.zwc' \
    marlonrichert/zsh-hist

  # trigger-load'!ftag' blockf compile'f*/ftag~*.zwc' \
  #   lmburns/ftag

# ]]] === trigger-load block ===

# OMZP::sudo/sudo.plugin.zsh

# === wait'0a' block === [[[
zt 0a light-mode for \
  atload'zstyle ":completion:*" special-dirs false' \
    OMZ::lib/completion.zsh \
  as'completion' atpull'zinit cclear' blockf \
    zsh-users/zsh-completions \
  ver'develop' atload'_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \
  as'completion' nocompile mv'*.zsh -> _git' \
    felipec/git-completion \
  pick'you-should-use.plugin.zsh' \
    MichaelAquilina/zsh-you-should-use \
  lbin'!' patch"${pchf}/%PLUGIN%.patch" reset \
  atinit'_w_db_faddf() { dotbare fadd -f; }; zle -N db-faddf _w_db_faddf' \
  pick'dotbare.plugin.zsh' \
    kazhala/dotbare \
  lbin'!' atload'export BMUX_DIR="$XDG_CONFIG_HOME/bmux"' \
  atinit'_wbmux() { bmux }; zle -N _wbmux' \
    kazhala/bmux \
    anatolykopyl/doas-zsh-plugin \
  pick'timewarrior.plugin.zsh' \
    svenXY/timewarrior \
    zdharma/zflai \
  pick'async.zsh' \
    mafredri/zsh-async \
  patch"${pchf}/%PLUGIN%.patch" reset nocompile'!' blockf \
    psprint/zsh-navigation-tools

# ]]] === wait'0a' block ===

#  === wait'0b' - patched === [[[
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
  add-zsh-hook zshaddhistory @append_dir-history-var; @chwpd_dir-history-var now' \
    kadaan/per-directory-history \
  atinit'zicompinit_fast; zicdreplay;' atload'unset "FAST_HIGHLIGHT[chroma-man]"' \
  atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
  compile'.*fast*~*.zwc' nocompletions atpull'%atclone' \
    zdharma/fast-syntax-highlighting \
  atload'vbindkey "Up" history-substring-search-up; vbindkey "Down" history-substring-search-down' \
    zsh-users/zsh-history-substring-search
#  ]]] === wait'0b' - patched ===

#  === wait'0b' === [[[
zt 0b light-mode for \
  blockf compile'lib/*f*~*.zwc' \
    Aloxaf/fzf-tab \
  autoload'#manydots-magic' \
    knu/zsh-manydots-magic \
  pick'formarks.plugin.zsh' \
  atload'export PATHMARKS_FILE="${ZPFX}/share/fzf-marks/marks"' \
  atinit'export FZF_MARKS_JUMP="^[."' \
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
    Tarrasch/zsh-autoenv \
  lbin'!bin/*' \
    bigH/git-fuzzy \
    zdharma/zui \
    zdharma/zbrowse
#  ]]] === wait'0b' ===

#  === wait'0c' - programs - sourced === [[[
zt 0c light-mode binary for \
  lbin patch"${pchf}/%PLUGIN%.patch" reset \
    kazhala/dump-cli \
  lbin'!**/*grep;**/*man;**/*diff' has'bat' \
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
  lbin'(f*~*.zsh)' pick'*.zsh' atinit'alias fs="fstat"' \
    lmburns/fzfgit \
  patch"${pchf}/%PLUGIN%.patch" reset \
  lbin'!src/pt*(*)' \
  atclone'(){local f;builtin cd -q src;for f (*.sh){mv ${f} ${f:r:l}};}' \
  atclone"command mv -f config $ZPFX/share/ptSh/config" \
  atload'alias ppwd="ptpwd" mkd="ptmkdir -pv" touch="pttouch"' \
    jszczerbinsky/ptSh \
  lbin atclone"mkdir -p $XDG_CONFIG_HOME/ytfzf; cp **/conf.sh $XDG_CONFIG_HOME/ytfzf" \
    pystardust/ytfzf \
  lbin from'gl' atclone'./prebuild; ./configure --prefix="$ZPFX"; make' \
  make"install"  atpull'%atclone' \
    surfraw/Surfraw \
  lbin atclone'./autogen.sh; ./configure --prefix="$ZPFX"; make' \
  make"install"  atpull'%atclone' lman \
    kfish/xsel \
  lbin atclone'./configure --prefix="$ZPFX"; make' \
  make"install" atpull'%atclone' lman \
    tats/w3m \
  lbin atclone'./autogen.sh && ./configure --enable-unicode --prefix="$ZPFX"' \
  make'install' atpull'%atclone' lman \
    KoffeinFlummi/htop-vim \
  lbin bpick'*.tar.gz*' atclone'./autogen.sh && ./configure --prefix=$ZPFX' \
  make"install PREFIX=$ZPFX" atpull'%atclone' lman \
    tmux/tmux \
  atclone'local d="$XDG_CONFIG_HOME/tmux/plugins";
  [[ ! -d "$d" ]] && mkdir -p "$d"; ln -sf %DIR% "$d/tpm"' \
  atpull'%atclone' \
    tmux-plugins/tpm \
  lbin lman \
    sdushantha/tmpmail \
  lbin'!nb;!*/bookmark;!*/notes' \
    xwmx/nb \
  lbin'*/tag' make'tag' lman \
    jdberry/tag \
  lbin \
    ttscoff/vitag \
  lbin bpick'*.tar.gz' atclone'autoconf; ./configure --prefix="$ZPFX"; make' \
  make'install' lman \
    moretension/duti \
  lbin'**/rga;**/rga-*' from'gh-r' mv'rip* -> rga' bpick'*64-apple*' \
    phiresky/ripgrep-all \
  lbin from'gh-r' bpick'*64-apple*' \
  atinit'export NAVI_FZF_OVERRIDES="--height=70%"' \
    denisidoro/navi \
  lbin \
    fidian/ansi \
  lbin atclone"./build.zsh" mv"*.*completion -> _zunit" atpull"%atclone" \
    molovo/zunit

# lbin"cmds/*" atload"
# zstyle ':plugin:zconvey' greeting 'none'
# zstyle ':notify:*' command-complete-timeout 3
# zstyle ':notify:*' notifier plg-zsh-notify" \
#   zdharma/zconvey

# lbin mv'*.*completion -> _revolver' atpull'%atclone' \
#   psprint/revolver \

#  ]]] === wait'0c' - programs - sourced ===

# atclone'INSTALL_DIR="$ZPFX" ./install.sh' atpull'%atclone' \
#   rgcr/m-cli
# atdelete'm --uninstall' \

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
  atclone'./wutag/wutag print-completions zsh > _wutag' atpull'%atclone' \
    wojciechkepka/wutag \
  lbin'**/gh' atclone'./**/gh completion --shell zsh > _gh' atpull'%atclone' \
    cli/cli \
  lbin'rclone/rclone' bpick'*osx-amd64*' mv'rclone* -> rclone' \
  atclone'./rclone/rclone genautocomplete zsh _rclone' \
  atpull'%atclone' \
    rclone/rclone \
  lbin'*/*/aria2c' bpick'*win.tar*' \
    aria2/aria2 \
  lman'*/**.1' atinit'export _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"' \
    ajeetdsouza/zoxide
#  ]]] === wait'0c' - programs + man ===

#  === wait'0c' - programs === [[[
zt 0c light-mode null for \
  lbin from'gh-r' dl"$(grman man/man1/ -r sk)" lman \
    lotabout/skim \
  multisrc'shell/{completion,key-bindings}.zsh' id-as'skim_comp' pick'/dev/null' \
    lotabout/skim \
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
  lbin'*/*/lax' atclone'cargo install --path .' \
    Property404/lax \
  lbin'*/*/desed' atclone'cargo install --path .' dl"$(grman)" lman \
    SoptikHa2/desed \
  lbin'f2' from'gh-r' \
    ayoisaiah/f2 \
  lbin'!*/*/taskn' atclone'cargo build --release ' \
    crockeo/taskn \
  lbin"!**/nvim" from'gh-r' lman bpick'*macos*' \
    neovim/neovim \
  lbin from'gh-r' bpick'*darwin_amd64*' \
  atload"source $ZPFX/share/pet/pet_atload.zsh " \
    knqyf263/pet \
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
  lbin'sops* -> sops' from'gh-r' bpick'*darwin' \
    mozilla/sops \
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
  lbin from'gh-r' bpick'*win-x86*' \
    orf/gping \
  lbin'jq-* -> jq' from'gh-r' dl"$(grman -e '1.prebuilt')" lman \
    stedolan/jq \
  lbin'yq_* -> yq' from'gh-r' atclone'yq shell-completion zsh > _yq' \
  atpull'%atclone' \
    mikefarah/yq \
  lbin'ff* -> ffsend' from'gh-r' \
    timvisee/ffsend \
  lbin'b**/r**/crex' atclone'./build.sh -r' \
    octobanana/crex \
  lbin from'gh-r' wait'[[ $OSTYPE = darwin* ]]'  \
    rami3l/pacaptr \
  lbin patch"${pchf}/%PLUGIN%.patch" make"PREFIX=$ZPFX install" reset \
  atpull'%atclone' atdelete"PREFIX=$ZPFX make uninstall"  \
    zdharma/zshelldoc

# Can't get to work
# zt 0c light-mode null for \
#   extract'regex-opt-1.2.4.tar.gz' \
#   atclone'cd r*/r*/; make all' \
#     https://bisqwit.iki.fi/src/arch/regex-opt-1.2.4.tar.gz

# == rust [[[
zt 0c light-mode null for \
  lbin from'gh-r' \
    muesli/duf \
  lbin from'gh-r' \
    pemistahl/grex \
  lbin'**/**/tokei' patch"${pchf}/%PLUGIN%.patch" reset \
  atclone'cargo build --release --all-features' \
    XAMPPRocky/tokei \
  lbin'**/**/viu' atclone'cargo install --path .' \
  atpull'%atclone' has'cargo' \
    atanunq/viu \
  lbin from'gh-r' bpick'*darwin*' \
    ms-jpq/sad \
  lbin from'gh-r' \
    ducaale/xh \
  lbin from'gh-r' \
    itchyny/mmv \
  lbin'* -> sd' from'gh-r' bpick'*darwin' \
    chmln/sd \
  lbin'**/**/hoard' atclone'cargo build --release' \
  atpull'%atclone' \
    Shadow53/hoard \
  lbin'* -> ruplacer' from'gh-r' bpick'*osx*' \
  atinit'alias rup="ruplacer"' \
    dmerejkowsky/ruplacer \
  lbin'* -> renamer' from'gh-r' bpick'*macos*' \
    adriangoransson/renamer \
  lbin'**/**/fclones' atclone'cargo build --release'  \
  atpull'%atclone' \
    pkolaczk/fclones \
  lbin'target/release/tldr' atclone'cargo build --release' \
  atclone"mv -f zsh_* _tldr" \
    dbrgn/tealdeer \
  lbin'pueued-* -> pueued' lbin'pueue-* -> pueue' from'gh-r' \
  bpick'*ue-mac*' bpick'*ued-mac*' \
    Nukesor/pueue \
  lbin from'gh-r' bpick'*mac*' \
    @dalance/procs \
  lbin'tar*/rel*/bandwhich' atclone"cargo install --path ." \
    imsnif/bandwhich \
  lbin'tar*/rel*/choose' atclone"cargo build --release" \
    theryangeary/choose \
  lbin'* -> hck' from'gh-r' bpick'*os-*64' \
    sstadick/hck \
  lbin from'gh-r' \
    BurntSushi/xsv \
  lbin from'gh-r' \
    Byron/dua-cli
# ]]] == rust

# === tui specifi block === [[[
zt 0c light-mode null for \
  lbin from'gh-r' bpick'*darwin*' \
    wagoodman/dive \
  lbin'*/*/gpg-tui' atclone'cargo build --release' atpull'%atclone' \
    orhun/gpg-tui \
  lbin from'gh-r' bpick'*n_x86*' \
    charmbracelet/glow \
  lbin from'gh-r' ver'nightly' \
    ClementTsang/bottom \
  lbin from'gh-r' bpick'*darwin*' dl"$(grman)" lman \
  atload'lc() { local __="$(mktemp)" && lf -last-dir-path="$__" "$@";
  d="${"$(<$__)"}" && chronic rm -f "$__" && [ -d "$d" ] && cd "$d"; }' \
    gokcehan/lf \
  lbin from'gh-r' bpick'*macos.tar.gz' \
  atinit'export XPLR_BOOKMARK_FILE="$XDG_CONFIG_HOME/xplr/bookmarks"' \
    sayanarijit/xplr \
  lbin from'gh-r' atload'alias tt="taskwarrior-tui"' \
    kdheepak/taskwarrior-tui \
  lbin from'gh-r' atload'alias ld="lazydocker"' \
    jesseduffield/lazydocker
# ]]] === tui specifi block ===

# === git specific block === [[[
zt 0c light-mode null for \
  lbin from'gh-r' bpick'*darwin_amd64*' \
    isacikgoz/gitbatch \
  lbin from'gh-r' bpick'*n_x86*' atload'alias lg="lazygit"' \
    jesseduffield/lazygit \
  lbin from'gh-r' bpick'*darwin*' blockf \
  atload'export GHQ_ROOT="$HOME/ghq"' \
    x-motemen/ghq \
  lbin from'gh-r' bpick'*darwin*' \
    Songmu/ghg \
  lbin from'gh-r' \
    human37/gee \
  lbin atclone'./autogen.sh; ./configure --prefix="$ZPFX"; mv -f **/**.zsh _tig' \
  make'install' atpull'%atclone' \
    jonas/tig \
  lbin'*/delta;git-dsf' from'gh-r' patch"${pchf}/%PLUGIN%.patch" \
    dandavison/delta \
  lbin from'gh-r' \
    extrawurst/gitui
# ]]] === git specific block ===

# cosmos72/gomacro == gruntwork-io/git-xargs

#  ]]] === wait'0c' - programs ===

#  === snippet block === [[[
zt light-mode is-snippet for \
  atload'zle -N RG; bindkey "^P" RG' \
    $ZDOTDIR/csnippets/*.zsh \
    OMZ::plugins/iterm2 \
  atload"unalias ofd" \
  mv"_security -> $ZINIT[COMPLETIONS_DIR]/_security" svn \
    OMZ::plugins/osx
#  ]]] === snippet block ===
# ]]] == zinit closing ===


# === powerlevel10k === [[[
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# ]]]

# === zsh keybindings === [[[
stty intr '^C'
stty susp '^Z'
stty stop undef
stty discard undef <$TTY >$TTY
zmodload zsh/zprof  # ztodo
autoload -Uz zmv zcalc zargs zed relative
alias fned="zed -f"
alias zmv='noglob zmv -v' zcp='noglob zmv -Cv' zln='noglob zmv -Lv' zmvn='noglob zmv -W'
alias run-help > /dev/null && unalias run-help
autoload +X -Uz run-help
zmodload -F zsh/parameter p:functions_source
autoload -Uz $functions_source[run-help]-*~*.zwc

typeset -g HELPDIR='/usr/local/share/zsh/help'
# ]]]


# === completion === [[[

# $desc, $word, $group, $realpath
zstyle ':fzf-tab:complete:figlet:option-f-1' fzf-preview 'figlet -f $word Hello world'
zstyle ':fzf-tab:complete:figlet:option-f-1' fzf-flags '--preview-window=nohidden,right:65%:wrap'
zstyle ':fzf-tab:complete:kill:*'                  popup-pad 0 3
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
    '[[ $group == "[process ID]" ]] && ps -p $word -o comm="" -w -w'

zstyle ':fzf-tab:complete:nvim:argument-rest' fzf-flags '--preview-window=nohidden,right:65%:wrap'
zstyle ':fzf-tab:complete:nvim:argument-rest' fzf-bindings \
    'alt-e:execute-silent({_FTB_INIT_}nvim "$realpath" < /dev/tty > /dev/tty)'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview \
    'r=$realpath; ([[ -f $r ]] && bat --style=numbers --color=always $r) \
    || ([[ -d $r ]] && tree -C $r | less) || (echo $r 2> /dev/null | head -200)'

zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-flags '--preview-window=down:5:wrap'
zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-preview \
    "git --git-dir=$UPDATELOCAL_GITDIR/\${word}/.git log --color \
    --date=short --pretty=format:'%Cgreen%cd %h %Creset%s %Cred%d%Creset ||%b' ..FETCH_HEAD 2>/dev/null"

# zstyle ':fzf-tab:complete:cdr:*' fzf-preview 'exa -TL 3 --color=always ${${~${${(@s: → :)desc}[2]}}}'
zstyle ':fzf-tab:complete:cdr:*'                fzf-preview 'exa -TL 3 --color=always ${~desc}'
zstyle ':fzf-tab:complete:(exa|cd):*'           popup-pad 30 0
zstyle ':fzf-tab:complete:(exa|cd|cdr|cd_):*'   fzf-flags '--preview-window=nohidden,right:45%:wrap'
zstyle ':fzf-tab:complete:(exa|cd|cd_):*'       fzf-preview '[[ -d $realpath ]] && exa -T --color=always $(readlink -f $realpath)'
zstyle ':fzf-tab:complete:(cp|rm|mv|bat):argument-rest' fzf-preview 'r=$(readlink -f $realpath); bat --color=always -- $r || exa --color=always -- $r'
zstyle ':fzf-tab:*' fzf-bindings \
  'enter:accept,backward-eof:abort,ctrl-a:toggle-all,alt-shift-down:preview-down,alt-shift-up:preview-up' \
  'alt-e:execute-silent({_FTB_INIT_}nvim "$realpath" < /dev/tty > /dev/tty)' # c-j, c-k in tmux not working

# zstyle ':completion:*' completer _complete _expand _match _oldlist _list _ignored _correct _approximate
zstyle ':completion:*' completer _complete _match _list _prefix _ignored _correct _approximate _oldlist
zstyle ':fzf-tab:*' print-query ctrl-c        # use input as result when ctrl-c
zstyle ':fzf-tab:*' accept-line space         # accept selected entry on space
zstyle ':fzf-tab:*' prefix ''                 # no dot prefix
zstyle ':fzf-tab:*' switch-group ',' '.'      # switch between header groups
zstyle ':fzf-tab:*' single-group color header # single header is shown
zstyle ':fzf-tab:*' fzf-pad 4                 # increased because of fzf border
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}      # activate color-completion(!)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' muttrc "$XDG_CONFIG_HOME/mutt/muttrc"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' verbose yes                            # provide verbose completion information
zstyle ':completion:*' accept-exact '*(N)'
# 'm:{a-z\-}={A-Z\_}' 'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' 'r:|?=** m:{a-z\-}={A-Z\_}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-separator '→'
zstyle ':completion:*' group-name ''                          # group results by category
zstyle ':completion:*:manuals'   separate-sections true
zstyle ':completion:*:matches'   group 'yes'                            # separate matches into groups
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:match:*'   original only
zstyle ':completion:*:messages'  format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings'  format ' %F{1}-- no matches found --%f'  # set format for warnings
zstyle ':completion:*:default'   list-prompt '%S%M matches%s'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:options'   description yes                   # describe options in full
zstyle ':completion:*:cd:*'      tag-order local-directories path-directories
zstyle ':completion:*:cd:*'      group-order local-directories path-directories
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:exa'       file-sort modification
zstyle ':completion:*:exa'       sort false
zstyle ':completion:*:sudo:*'    command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin # set sudo path
zstyle ':completion:*:sudo::'    environ PATH="$PATH"  # use same path as sudo
zstyle ':completion::complete:*' gain-privileges 1     # enabling autocompletion of privileged envs
zstyle ':completion:*:*:*:*:corrections'   format '%F{5}!- %d (errors: %e) -!%f'
zstyle ':completion::(^approximate*):*:functions'   ignored-patterns '_*' # ignore for cmds not in path
zstyle ':completion:*:*:zcompile:*'                 ignored-patterns '(*~|*.zwc)'
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # no backup files
zstyle ':completion:*:*:-subscript-:*'              tag-order indexes parameters # index before parameters in subscripts
zstyle ':completion:*:*:-redirect-,2>,*:*'          file-patterns '*.log'               # offer log files as completion for error redireciton
zstyle -e ':completion:*:approximate:*'             max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
# zstyle ':completion:*' rehash true
zstyle ':completion:*:(ssh|scp|rsync):*'            tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*'                group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*'                        group-order users hosts-domain hosts-host users hosts-ipaddr

zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host'   ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# zstyle -e ':completion:*:(ssh|scp|sftp|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

local -a _ssh_hosts _etc_hosts hosts
[[ -r $HOME/.ssh/known_hosts ]] && _ssh_hosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*} ) || _ssh_hosts=()
[[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

hosts=( $(hostname) "$_ssh_hosts[@]" "$_etc_hosts[@]" localhost )
zstyle ':completion:*:hosts' hosts $hosts

# ADD: completion patterns for others
# zstyle ':completion:*:*:ogg123:*'  file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
# zstyle ':completion:*:*:mocp:*'    file-patterns '*.(wav|asdf):ogg\ files *(-/):directories'
# ]]]

# === functions === [[[
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
askpass() { osascript -e 'do shell script "'"$*"'" with administrator privileges' }
td() { date -d "+${*}" "+%FT%R"; }
ofd() { open $PWD; }
double-accept() { deploy-code "BUFFER[-1]=''"; }
zle -N double-accept

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

zinit-palette() {
  for k ( "${(@kon)ZINIT[(I)col-*]}" ); do
    local i=$ZINIT[$k]
    print "$reset_color${(r:14:: :):-$k:} $i###########"
  done
}

# ]]]

# === helper functions === [[[
# prevent failed commands from being added to history
zshaddhistory() {
  emulate -L zsh
  # whence ${${(z)1}[1]} >| /dev/null || return 1 # doesn't add setting arrays
  [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}

_zsh_autosuggest_strategy_dir_history(){ # avoid zinit picking this up as a completion
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

_zsh_autosuggest_strategy_custom_history () {
  emulate -L zsh -o extended_glob
  local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}"
  local pattern="$prefix*"
  if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]; then
    pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"
  fi
  [[ "${history[(r)$pattern]}" != "$prefix" ]] && \
    typeset -g suggestion="${history[(r)$pattern]}"
}
# ]]]

#===== completions ===== [[[
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
# ]]] ===== completions =====

#===== variables ===== [[[
zt 0c light-mode run-atpull for \
  id-as'brew_setup' has'brew' nocd eval'brew shellenv' \
    zdharma/null \
  id-as'pipx_comp' has'pipx' nocd nocompile eval"register-python-argcomplete pipx" \
  atload'zicdreplay -q' \
    zdharma/null \
  id-as'antidot_conf' has'antidot' nocd eval'antidot init' \
    zdharma/null \
  id-as'pyenv_init' has'pyenv' nocd eval'${${:-=pyenv}:A} init - zsh' \
    zdharma/null \
  id-as'pipenv_comp' has'pipenv' nocd eval'pipenv --completion' \
    zdharma/null \
  id-as'navi_comp' has'navi' nocd eval'navi widget zsh' \
    zdharma/null \
  id-as'ruby_env' has'rbenv' nocd eval'rbenv init - --no-rehash' \
    zdharma/null \
  id-as'thefuck_alias' has'thefuck' nocd eval'thefuck --alias' \
    zdharma/null \
  id-as'zoxide_init' has'zoxide' nocd eval'zoxide init --no-aliases zsh' \
  atload'alias o=__zoxide_z z=__zoxide_zi' \
    zdharma/null \
  id-as'keychain_init' has'keychain' nocd \
  eval'keychain --agents ssh -q --inherit any --eval id_rsa git burnsac \
  && keychain --agents gpg -q --eval 0xC011CBEF6628B679' \
    zdharma/null \
  id-as'dircolors' has'gdircolors' nocd eval"gdircolors ${0:h}/gruv.dircolors" \
    zdharma/null \
  id-as'Cleanup' nocd atinit'unset -f zt grman; _zsh_autosuggest_bind_widgets' \
    zdharma/null

# FIX: only one zicdreplay
# id-as'pip_comp' has'pip' nocd eval'pip completion --zsh' zdharma/null
# eval "$(/usr/local/mybin/rakubrew init Zsh)"
# eval "$(fakedata --completion zsh)"

typeset -gx PDFVIEWER='zathura'                                                   # texdoc pdfviewer
typeset -gx XML_CATALOG_FILES="/usr/local/etc/xml/catalog"                        # xdg-utils|asciidoc
typeset -gx DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET" # vimtex
#
# typeset -gx _ZO_ECHO=1
typeset -gx FZFZ_RECENT_DIRS_TOOL='autojump'
typeset -gx ZSH_AUTOSUGGEST_USE_ASYNC=set
typeset -gx ZSH_AUTOSUGGEST_MANUAL_REBIND=set
typeset -gx ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
typeset -gx ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c100,)" # no 100+ char
typeset -gx ZSH_AUTOSUGGEST_COMPLETION_IGNORE="[[:space:]]*" # no lead space
typeset -gx ZSH_AUTOSUGGEST_STRATEGY=(dir_history custom_history completion)
# typeset -gx WORDCHARS=' *?_-.~\'
typeset -g WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
typeset -gx HISTORY_SUBSTRING_SEARCH_FUZZY=set
typeset -gx HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=set
typeset -gx AUTOPAIR_CTRL_BKSPC_WIDGET=".backward-kill-word"
typeset -ga chwpd_dir_history_funcs=( "_dircycle_update_cycled" ".zinit-cd" )
typeset -g PER_DIRECTORY_HISTORY_BASE="${ZPFX}/share/per-directory-history"
typeset -gx UPDATELOCAL_GITDIR="${HOME}/opt"
typeset -g DUMP_DIR="${ZPFX}/share/dump/trash"
typeset -g DUMP_LOG="${ZPFX}/share/dump/log"
typeset -gx CDHISTSIZE=25 CDHISTTILDE=TRUE CDHISTCOMMAND=jd
alias c=jd
typeset -gx FZFGIT_BACKUP="${XDG_DATA_HOME}/gitback"
typeset -gx FZFGIT_DEFAULT_OPTS="--preview-window=':nohidden,right:65%:wrap'"
typeset -gx NQDIR="$TMPDIR/nq"
typeset -gx BREW_PREFIX="$(/usr/local/bin/brew --prefix)"

typeset -g KEYTIMEOUT=15

typeset -gx PASSWORD_STORE_ENABLE_EXTENSIONS='true'
typeset -gx PASSWORD_STORE_EXTENSIONS_DIR="${HOMEBREW_PREFIX}/lib/password-store/extensions"
# ]]]

# === fzf === [[[
# ❱❯❮ --border ,border-left
(( ${+commands[fd]} )) && {
  _fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1"; }
  _fzf_compgen_dir() { fd --exclude ".git" --follow --hidden --type d . "$1"; }
}

# FZF_COLORS="
# --color=fg:-1,bg:-1,hl:#458588,fg+:-1,bg+:-1,hl+:#689d6a
# --color=prompt:#fabd2f,marker:#fe8019,spinner:#b8bb26
# "

FZF_COLORS="
--color=fg:-1,fg+:-1,hl:#458588,hl+:#689d6a,bg+:-1
--color=pointer:#fabd2f,marker:#fe8019,spinner:#b8bb26
--color=header:#fb4934,prompt:#b16286
"
SKIM_COLORS="
--color=fg:#b16286,fg+:#d3869b,hl:#458588,hl+:#689d6a
--color=pointer:#fabd2f,marker:#fe8019,spinner:#b8bb26
--color=header:#cc241d,prompt:#fb4934
"
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
--reverse --height 80% --ansi --info=inline --multi --border
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
--bind=change:top
"
export SKIM_DEFAULT_OPTIONS=${(F)${(M)${(@f)FZF_DEFAULT_OPTS}/(#m)*info*/${${(@s. .)MATCH}:#--info*}}:#--(bind change:top|pointer*|marker*)}

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
--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'
"
# ]]]

# === paths (GNU) === [[[
[[ -z ${path[(re)$HOME/.local/bin]} ]] && path=( "$HOME/.local/bin" "${path[@]}" )
[[ -z ${path[(re)/usr/local/sbin]} ]]  && path=( "/usr/local/sbin"  "${path[@]}" )

# HOMEBREW_PREFIX is not reliable when sourced (brew shellenv)
path=(
  ${BREW_PREFIX}/opt/{coreutils,gnu-sed,grep,gnu-tar}/libexec/gnubin
  ${BREW_PREFIX}/opt/{gawk,findutils,ed}/libexec/gnubin
  ${BREW_PREFIX}/opt/{gnu-getopt,file-formula,util-linux}/bin
  ${BREW_PREFIX}/opt/{flex,libressl,unzip}/bin
  ${BREW_PREFIX}/opt/openvpn/sbin
  ${BREW_PREFIX}/texlive/2021/bin
  ${HOME}/.ghg/bin
  "${path[@]}"
)

manpath=(
  ${BREW_PREFIX}/opt/{grep,gawk,gnu-tar,gnu-getopt}/share/man
  ${BREW_PREFIX}/opt/{gnu-sed,findutils,gnu-which,file-formula}/share/man
  ${BREW_PREFIX}/opt/{gnu-getopt,task-spooler,util-linux}/share/man
  "${manpath[@]}"
)

infopath=( ${BREW_PREFIX}/{share,}/info "${infopath[@]}" )

cdpath=( $HOME/{projects,}/github $XDG_CONFIG_HOME )

hash -d git=$HOME/projects/github
hash -d pro=$HOME/projects
hash -d opt=$HOME/opt
hash -d ghq=$HOME/ghq
hash -d TMPDIR=${TMPDIR:A}

path=(
  $HOME/.rbenv/version/3.0.0/bin(N-/)
  $PYENV_ROOT/{shims,bin}
  $CARGO_HOME/bin(N-/)
  $XDG_DATA_HOME/gem/bin(N-/)
  $GOPATH/bin(N-/)
  $HOMEBREW_PREFIX/mysql/bin(N-/)
  $HOME/.poetry/bin(N-/)
  "${path[@]}"
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
# ]]]

# == sourcing === [[[
# atload'x="$XDG_CONFIG_HOME/broot/launcher/bash/br"; [ -f "$x" ] && source "$x"'

zt 0b light-mode null id-as for \
  multisrc="$ZDOTDIR/zsh.d/{aliases,keybindings,lficons,git-token}.zsh" \
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
  atload'
  ( [[ -S $XDG_DATA_HOME/pueue/pueue_lucasburns.socket ]] || \
    pueued -dc "$XDG_CONFIG_HOME/pueue/pueue.yml" ) && {
    ( chronic pueue clean && pueue status | rg -Fq limelight ) || chronic pueue add limelight
  }' \
    zdharma/null \
  atload'local x="$XDG_CONFIG_HOME/cdhist/cdhist.rc"; [ -f "$x" ] && source "$x"' \
    zdharma/null

# nocd atinit"TS_SOCKET=/tmp/ts1 ts -C && ts -l | rg -Fq 'limelight' || TS_SOCKET=/tmp/ts1 ts limelight >/dev/null" \
# nocd atinit"TS_SOCKET=/tmp/ts1 ts -C && ts -l | rg -Fq 'limelight' || chronic ts limelight"
# atload'local x="${XDG_DATA_HOME}/cargo/env"; [ -f "$x" ] && source "$x"'\
# atload"source $XDG_DATA_HOME/fonts/i_all.sh" zdharma/null

# pl ${(kv)userdirs}
# recache keychain if older than GPG cache time or first login
# local first=${${${(M)${(%):-%l}:#*01}:+1}:-0}
[[ -f "$ZINIT[PLUGINS_DIR]/keychain_init"/eval*~*.zwc(#qN.ms+45000) ]] && {
  zinit recache keychain_init
  print -P "%F{12}===> Keychain recached <===%f"
}
# ]]]

local fdir="${HOMEBREW_PREFIX}/share/zsh/site-functions"
[[ -z ${fpath[(re)$fdir]} && -d "$fdir" ]] && fpath=( "${fpath[@]}" "${fdir}" )
[[ -z ${path[(re)$XDG_BIN_HOME]} && -d "$XDG_BIN_HOME" ]] && path=( "$XDG_BIN_HOME" "${path[@]}")

path=( "${ZPFX}/bin" "${path[@]}" )                # add back to be beginning
path=( "${path[@]:#}" )                            # remove empties

ZINIT+=(
  col-pname   $'\e[1;4m\e[38;5;004m' col-uname   $'\e[1;4m\e[38;5;013m' col-keyword $'\e[14m'
  col-note    $'\e[38;5;007m'        col-error   $'\e[1m\e[38;5;001m'   col-p       $'\e[38;5;81m'
  col-info    $'\e[38;5;82m'         col-info2   $'\e[38;5;011m'      col-profile $'\e[38;5;007m'
  col-uninst  $'\e[38;5;010m'        col-info3   $'\e[1m\e[38;5;011m' col-slight  $'\e[38;5;230m'
  col-failure $'\e[38;5;001m'        col-happy   $'\e[1m\e[38;5;82m'  col-annex   $'\e[38;5;002m'
  col-id-as   $'\e[4;38;5;011m'      col-version $'\e[3;38;5;87m'
  col-pre     $'\e[38;5;135m'        col-msg   $'\e[0m'        col-msg2  $'\e[38;5;009m'
  col-obj     $'\e[38;5;012m'        col-obj2  $'\e[38;5;010m' col-file  $'\e[3;38;5;117m'
  col-dir     $'\e[3;38;5;002m'      col-func $'\e[38;5;219m'
  col-url     $'\e[38;5;75m'         col-meta  $'\e[38;5;57m'  col-meta2 $'\e[38;5;147m'
  col-data    $'\e[38;5;010m'         col-data2 $'\e[38;5;010m' col-hi    $'\e[1m\e[38;5;010m'
  col-var     $'\e[38;5;81m'         col-glob  $'\e[38;5;011m' col-ehi   $'\e[1m\e[38;5;210m'
  col-cmd     $'\e[38;5;002m'         col-ice   $'\e[38;5;39m'  col-nl    $'\n'
  col-txt     $'\e[38;5;010m'        col-num  $'\e[3;38;5;155m' col-term  $'\e[38;5;185m'
  col-warn    $'\e[38;5;009m'        col-apo $'\e[1;38;5;220m' col-ok    $'\e[38;5;220m'
  col-faint   $'\e[38;5;238m'        col-opt   $'\e[38;5;219m' col-lhi   $'\e[38;5;81m'
  col-tab     $' \t '                col-msg3  $'\e[38;5;238m' col-b-lhi $'\e[1m\e[38;5;75m'
  col-bar     $'\e[38;5;82m'         col-th-bar $'\e[38;5;82m'
  col-rst     $'\e[0m'               col-b     $'\e[1m'        col-nb     $'\e[22m'
  col-u       $'\e[4m'               col-it    $'\e[3m'        col-st     $'\e[9m'
  col-nu      $'\e[24m'              col-nit   $'\e[23m'       col-nst    $'\e[29m'
  col-bspc    $'\b'                  col-b-warn $'\e[1;38;5;009m' col-u-warn $'\e[4;38;5;009m'
  col-mdsh    $'\e[1;38;5;220m'"${${${(M)LANG:#*UTF-8*}:+–}:--}"$'\e[0m'
  col-mmdsh   $'\e[1;38;5;220m'"${${${(M)LANG:#*UTF-8*}:+――}:--}"$'\e[0m'
  col-↔       ${${${(M)LANG:#*UTF-8*}:+$'\e[38;5;82m↔\e[0m'}:-$'\e[38;5;82m«-»\e[0m'}
  col-…       "${${${(M)LANG:#*UTF-8*}:+…}:-...}"  col-ndsh  "${${${(M)LANG:#*UTF-8*}:+–}:-}"
  col--…      "${${${(M)LANG:#*UTF-8*}:+⋯⋯}:-···}" col-lr    "${${${(M)LANG:#*UTF-8*}:+↔}:-"«-»"}"
)

zflai-msg "[zshrc] File took ${(M)$(( SECONDS * 1000 ))#*.?} ms"

typeset -aU path

# vim: set sw=0 ts=2 sts=2 et ft=zsh fdm=marker fmr=[[[,]]]:

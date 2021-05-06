skip_global_compinit=1
# setopt no_global_rcs

# if [[ -x '/usr/libexec/path_helper' ]]; then
#   source <(/usr/libexec/path_helper -s)
# fi

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_BIN_HOME="$HOME/bin"

export BROWSER='/Applications/LibreWolf.app/Contents/MacOS/librewolf-bin'
export RTV_BROWSER="w3m"
export EDITOR='nvim'

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

export VIMRC="${XDG_CONFIG_HOME}/nvim/init.vim"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch/notmuch-config"
export TASKRC="${XDG_CONFIG_HOME}/task/taskrc"
export TASKDATA="${XDG_CONFIG_HOME}/task"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/ripgreprc"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export TIGRC_USER="${XDG_CONFIG_HOME}/tig/tigrc"
export CONDARC="${XDG_CONFIG_HOME}/conda/condarc"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export GOPATH="${HOME}/go"
export GEM_HOME="${XDG_DATA_HOME}/ruby/gems"
export GEM_SPEC_CACHE="${XDG_DATA_HOME}/ruby/specs"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
export IPYTHONDIR="${XDG_CACHE_HOME}/ipython"
export R_USER="${XDG_CONFIG_HOME}/r/R"
export R_ENVIRON_USER="${XDG_CONFIG_HOME}/r/Renviron"
export R_MAKE_VARS_USER="${XDG_CONFIG_HOME}/r/Makevars"
export R_HISTFILE="${XDG_CONFIG_HOME}/r/Rhistory"
export R_PROFILE_USER="${XDG_CONFIG_HOME}/r/Rprofile"
# export R_LIBS_USER="$HOME/Library/R"
export LESSHISTFILE="-"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"

export GETOPT="/usr/local/opt/gnu-getopt/bin/getopt"
export DO_NOT_TRACK=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_BAT=1
export HOMEBREW_BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/config"
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export GPG_TTY=$TTY
export GPG_AGENT_INFO="${GNUPGHOME}/S.gpg-agent"
export PINENTRY_USER_DATA="USE_CURSES=1"

export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:treeview;v:imgview;j:autojump;e:gpge;d:gpgd;m:mimelist;b:nbak;s:organize'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'

export GRIPHOME="${XDG_CONFIG_HOME}/grip"

source "${XDG_DATA_HOME}/cargo/env"


# vim:ft=zsh:et

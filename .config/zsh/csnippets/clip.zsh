
function detect-clip() {
  emulate -L zsh
  function ccopy() { pbcopy < "${1:-/dev/stdin}"; }
  function cpaste() { pbpaste; }
}

detect-clip || true

# vim:ft=zsh:

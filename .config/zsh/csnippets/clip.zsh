
function detect-clip() {
  emulate -L zsh
  function clipcopy() { pbcopy < "${1:-/dev/stdin}"; }
  function clippaste() { pbpaste; }
}

detect-clip || true

# vim:ft=zsh:

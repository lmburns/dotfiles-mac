#!/bin/sh

caps_stat="$(/opt/X11/bin/xset q | grep 'Caps' | awk '{print $4}')"

# ┓ ┗ ❯ ❮

if [ "$caps_stat" = "off" ]; then
  echo "⟦⏼⟧ | color=#889b4a size=14"
else
  echo "⟦⏻⟧ | color=#7e5053 size=14"
fi

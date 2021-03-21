#!/bin/bash

export PATH=/usr/local/bin:$PATH

# <bitbar.title>Disk Usage</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Lucas Burns</bitbar.author>
# <bitbar.author.github>lmburns</bitbar.author.github>
# <bitbar.desc>Disk usage</bitbar.desc>
# <bitbar.about>Disk usage</bitbar.about>

# === one way =============================================================
# duf --hide special --output mountpoint,used,size \
#   | awk -F'│' '{print $4,$3}' \
#   | sed -n '7p' \
#   |  sed 's/^ //g; s/ $//g' \
#   | tr -s ' ' \
#   | tr ' ' '/'

# === another way =========================================================
# total="$(df "/Volumes" | awk '{print $2}' | sed -n '2p')"
# used="$(df "/Volumes" | awk '{print $3}' | sed -n '2p')"

# total_mb="$(($(echo "$total") / 1024 / 1024))"
# used_mb="$(($(echo "$used") / 1000 / 1024))"

# echo "${used_mb} / ${total_mb}"

# === another way =========================================================
[ -x "$(command -v diskutil)" ] || { echo 'Error: not on macOS' >&2; exit 1; }
[ -x "$(command -v df)" ] || { echo 'Error: not on macOS' >&2; exit 1; }

disk="$(df /Volumes/ | awk '{print $1}' | sed -n '2p')"

total="$(diskutil info "${disk}" | rg 'Container Total Space' | awk '{print $4}')"
free="$(diskutil info "${disk}" | rg 'Container Free Space' | awk '{print $4}')"

echo "⟦ $(bc <<< "$total - $free")/$total⟧ | color=#f14a68 size=11"

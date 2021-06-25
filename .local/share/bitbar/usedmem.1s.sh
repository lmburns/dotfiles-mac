#!/usr/bin/env bash

# <bitbar.title>Memory Usage</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Lucas Burns</bitbar.author>
# <bitbar.author.github>lmburns</bitbar.author.github>
# <bitbar.desc>Memory usage</bitbar.desc>
# <bitbar.about>Memory usage</bitbar.about>

mem_total="$(($(/usr/sbin/sysctl -n hw.memsize) / 1024 / 1024))"
mem_wired="$(/usr/bin/vm_stat | awk '/ wired/ { print $4 }')"
mem_active="$(/usr/bin/vm_stat | awk '/ active/ { printf $3 }')"
mem_compressed="$(/usr/bin/vm_stat | awk '/ occupied/ { printf $5 }')"
mem_compressed="${mem_compressed:-0}"
mem_used="$(((${mem_wired//.} + ${mem_active//.} + ${mem_compressed//.}) * 4 / 1024))"

# memory="${mem_used}${mem_label:-MiB} / ${mem_total}${mem_label:-MiB} ${mem_perc:+(${mem_perc}%)}"

memory="${mem_used} / ${mem_total}"

printf "⟦﫭 $memory⟧ | color=#f79a32 size=11"

# fclones --
{:data-section="shell"}
{:data-date="May 28, 2021"}
{:data-extra="Um Pages"}

## SYNOPSIS
Fast file finder

## EXAMPLES

`fclones .`
: all

`fclones . --unique`
: unique

`fclones . --rf-under 3`
: replicated under 3

`fclones . --rf-over 3`
: replicated over 3

`fclones . --depth 1`
: current dir


### FILTERING

`fclones . -s 100M`
: at least 100M

`fclones . --names '*.jpg' '*.png'`
: name or pattern

`find . -name '*.c' | fclones --stdin --depth 0`
: piping

`fclones . -L --paths '/home/**'`
: follow symlink

`fclones / --exclude '/dev/**' '/proc/**'`
: exclude

`fclones . --names '*.jpg' --caseless --transform 'exiv2 -d a $IN' --in-place`
: strip exif before matching duplicate jpg

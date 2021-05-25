# fselect --
{:data-section="shell"}
{:data-date="March 25, 2021"}
{:data-extra="Um Pages"}

## SYNOPSIS
SQL query for files

## OPTIONS

`fselect size, path from /home/user where name = '*.cfg' or name = '*.tmp'`
: temp or config full path and size

`fselect "name from /home/user/tmp where size > 0"`
: same

`fselect name from /home/user/tmp where size gt 0`
: same

`fselect "name from /tmp where (name = *.tmp and size = 0) or (name = *.cfg and size > 1000000)"`
: complex query

`fselect "MIN(size), MAX(size), AVG(size), SUM(size), COUNT(*) from /home/user/Downloads"`
: aggregate funcs

`fselect "LOWER(name), UPPER(name), LENGTH(name), YEAR(modified) from /home/user/Downloads"`
: formatting funcs

`fselect "MIN(YEAR(modified)) from /home/user"`
: year of oldest file

`fselect name from /home/user where path =~ '.*Rust.*'`
: rust regex

`fselect "name from . where path !=~ '^\./config'"`
: negate regex

`fselect "path from /home/user where name like '%report-2018-__-__???'"`
: classic LIKE

`fselect "path from /home/user where name === 'some_*_weird_*_name'"`
: exact match operator to search w/ regex disabled

`fselect path from /home/user where created = 2017-05-01`

`fselect path from /home/user where modified = today`

`fselect path from /home/user where accessed = yesterday`

`fselect "path from /home/user where modified = 'apr 1'"`

`fselect "path from /home/user where modified = 'last fri'"`
: find files by date

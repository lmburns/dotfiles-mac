# zsh --
{:data-section="shell"}
{:data-date="April 30, 2021"}
{:data-extra="Um Pages"}

## GLOBBING QUALIFIERS

### WEBSITE

https://zsh.fyi/expansion

## EXTENDED PATTERNS

### EXTENDED_GLOB

|-------------|--------------------------------------------|
| `^pat`      | Anything that doesn’t match *pat*          |
| `pat1^pat2` | Match pat1 then anything other than *pat2* |
| `pat1~pat2` | Anything matching *pat1* but not *pat2*    |
| `X#`        | Zero or more occurrences of element *X*    |
| `X##`       | One or more occurrences of element *X*     |

### KSH_GLOB

|----------|---------------------------------|
| `@(pat)` | Group patterns                  |
| `*(pat)` | Zero or more occurrences of pat |
| `+(pat)` | One or more occurrences of pat  |
| `?(pat)` | Zero or one occurrences of pat  |
| `!(pat)` | Anything but the pattern pat    |

### GLOBBING FLAGS - EXTENDED_GLOB

|------------|----------------------------------------------|
| `(#i)`     | Match case insensitively                     |
| `(#l)`     | Lower case matches upper case                |
| `(#I)`     | Match case sensitively                       |
| `(#b)`     | Parentheses set :`match`, `mbegin`, `mend`    |
| `(#B)`     | Parentheses no longer set arrays             |
| `(#m)`     | Match in `MATCH`, `MBEGIN`, `MEND`           |
| `(#M)`     | Don’t use `MATCH` etc.                       |
| `(#anum)`  | Match with num approximations                |
| `(#s)`     | Match only at start of test string           |
| `(#e)`     | Match only at end of test string             |
| `(#qexpr)` | `expr` is a a set of glob qualifiers (below) |

### GLOB QUALIFIERS - PARENTEHSIS AFTER FILE NAME PATTERN

|--------|-------------------------------------------|
| `/`    | Directory                                 |
| `F`    | Non­empty directory; for empty us *(/^F)* |
| `.`    | Plain file                                |
| `@`    | Symbolic link                             |
| `=`    | Socket                                    |
| `p`    | Name pipe *(FIFO)*                        |
| `*`    | Executable plain file                     |
| `%`    | Special file                              |
| `%b`   | Block special file                        |
| `%c`   | Character special file                    |
| `r`    | Readable by owner (N.B. not current user) |
| `w`    | Writeable by owner                        |
| `x`    | Executable by owner                       |
| `A`    | Readable by members of file’s group       |
| `I`    | Writeable by members of file’s group      |
| `E`    | Executable by members of file’s group     |
| `R`    | World readable                            |
| `W`    | World writeable                           |
| `X`    | World executablesSetuid                   |
| `(-@)` | Only broken symlinks                      |
| `D`    | Match hidden files                        |

### GLOBBING QUALIFIERS
`(.)`
: regular files only

`(/)`
: directories

`(*)`
: executable files

`(.x)`
: exeutable by owner

`(@)`
: symlinks

`(=)`
: sockets

`(p)`
: named pipes

`(%)`
: device files

`(%b)`
: block files

`(%c)`
: character files

`ls **/*(.:g-w:)`
: don't have write permissions to group in curr dir & sub

`ls -l **/*(u:tomcat:)`
: files of user tomcat

`ls -l **/*(.G)`
: files that have primary groupy

`ls **/*(.aM-1)`
: accessed last month

## ==============================================================

## SUBSCRIPT FLAGS

|-------------|-------------------------------------------------------------------------------------|
| `e`         | plain string match instead; `${array[(re)*]}` = array element literal '*'           |
| `w`         | if is a scalar, flag makes subscrip work per-word basis instead of chars            |
| `s:string:` | define string separates words (for use with the `w` flag)                           |
| `p`         | recognize same esc seq as print builtin string arg of a subsequent `s` flag         |
| `f`         | if param subscripted = scalar, makes subscript per-line basis instead of characters |
| `r`         | exp taken as patt & result is 1st matching array element, substring or word         |
| Note:       | this is like giving a number: `$foo[(r)??,3]` & `$foo[(r)??,(r)f*]` work            |
| `R`         | Like `r`, but gives the last match                                                  |
| `i`         | Like `r`, but gives the index of the match instead; no 2nd arg                      |
| `I`         | Like `i`, but gives the index of the last match.                                    |
| `n:expr:`   | If combined with `r`/`R`/`i`/`I`, makes return the n'th or n'th last match          |
| `b:expr:`   | Combined w `r/R/i/I` begin at `nth`/`-nth` element; no associative array            |
| `k`         | Associative array = keys interp as vals; no left-hand side assignment; return match |
| `K`         | Same as `k` but return all keys matching                                            |

## ==============================================================

## EXPANSION

### WORD DESIGNATORS

A word designator indicates which word or words of a given command line are to be included in a history reference. A `:` usually separates the event specification from the word designator. It may be omitted only if the word designator begins with a `^`, `$`, `*`, `-` or `%`. Word designators include:

|-------|-------------------------------------------------------|
| `0`   | The first input word (command).                       |
| `n`   | The nth argument.                                     |
| `^`   | The first argument. That is, 1.                       |
| `$`   | The last argument.                                    |
| `%`   | The word matched by (the most recent) ?str search.    |
| `x-y` | A range of words; x defaults to 0.                    |
| `*`   | All the arguments, or a null value if there are none. |
| `x*`  | Abbreviates `x-$`.                                    |
| `x-`  | Like `x*` but omitting word `$`.                        |

## ==============================================================

### MODIFIERS ON ARGS (CAN OMIT WORD SELECTOR)

|------------------|------------------------------------------------------------|
| `!!:1:h [digit]` | Trailing path component removed                            |
| `!!:1:t`         | Only trailing path component left                          |
| `!!:1:r`         | File extension .ext removed                                |
| `!!:1:e`         | Only extension ext left                                    |
| `!!:1:p`         | Print result but don’t execute                             |
| `!!:1:q`         | Quote from further substitution                            |
| `!!:1:Q`         | Strip one level of quotes                                  |
| `!!:1:x`         | Quote and also break at whitespace                         |
| `!!:1:l`         | Convert to all lower case                                  |
| `!!:1:u`         | Convert to all upper case                                  |
| `!!:1:s/s1/s2/`  | Replace string s1 bys2                                     |
| `!!:1:gs/s2/s2/` | Same but global                                            |
| `!!:1:&`         | Use same s1 and s2 on new targe                            |
| `!!:1:a`         | Turn filename to absolute path                             |
| `!!:1:A`         | Turn filename to absolute path, then pass to `realpath`    |
| `!!:1:c`         | Resolve commnd name to absolute path checking `$PATH`      |
| `!!:1:P`         | Filename abs path; no `.` or `..`; refer same dir as input |

### MODIFIERS - ONLY PARAMETER EXPANSIO

|-----------|-------------------------------------------------------------|
| `f`       | no colon; repeat modifier until word doesn't change anymore |
| `F:expr:` | like `f`; though repeat `n` times                           |
| `w`       | make immediately following modifer work on each word        |
| `W:sep:`  | like `w`; but words separated by `sep`                      |

### MODIFIERS ON VAR/GLOBQUALIFIERS

Most modifiers work on variables (e.g `${var:h}`) or in globqualifiers (e.g. `*(:h)`), the following only work there:

|------------------|---------------------------------------|
| `${var:fm}`      | Repeat modifier m till stops changing |
| `${var:F:N:m}`   | Same but no more than N times         |
| `${var:wm}`      | Apply modifer m to words of string    |
| `${var:W:sep:m}` | Same but words are separated by sep   |

## ==============================================================

### PARAMETER (VARIABLE) EXPANSION
Basic forms: str will also be expanded; most forms work onwords of array separately:

|-----------------|------------------------------------------------|
| `${var}`        | Substitute contents of `var`, no splitting     |
| `${+var}`       | 1 if var is set, else 0                        |
| `${var:-str}`   | `$var` if non­null, else str                   |
| `${var-str}`    | `$var` if set (even if null) else str          |
| `${var:=str}`   | `$var` if non­null, else str and set var to it |
| `${var::=str}`  | Same but always use `str`                      |
| `${var:?str}`   | `$var` if non­null else error, abort           |
| `${var:+str}`   | str if `$var` is non­null                      |
| `${var#pat}`    | min match of pat removed from head             |
| `${var##pat}`   | max match of pat removed from head             |
| `${var%pat}`    | min match of pat removed from tail             |
| `${var%%pat}`   | max match of pat removed from tail             |
| `${var:#pat}`   | `$var` unless pat matches, then empty          |
| `${var/p/r}`    | One occurrence of p replaced by `r`            |
| `${var//p/r}`   | All occurrences of `p` replaced by `r`         |
| `${#var}`       | Length of var in words (array) or bytes        |
| `${^var}`       | Expand elements like brace expansion           |
| `${=var}`       | Split words of result like lesser shells       |
| `${~var}`       | Allow globbing, file expansion on result       |
| `${${var%p}#q}` | Apply `%p` then `#q` to `$var`                 |

## ==============================================================

### PARAMETER FLAGS IN PARENTEHSIS (IMMEDIATELY AFTER LEFT BRACE)

+ Delimeters  shown as `:str:` may be any pair of chars or matchedparenthses `(str)`, `{str}`, `[str]`, `<str>`.
+ Opening brace directly followed by parenthesis, string up until closing parenthesis = flags
+ `%q%q%q` == `%%qqq`

|----------------|--------------------------------------------------------------|
| `%`            | Expand *%*s in result as in prompts                          |
| `@`            | Array expand even in double quotes; *"${(@)path[1,2]}"*      |
| `A`            | Create array parameter with *${...=...}*                     |
| `a`            | Array index order, so `Oa` is reversed                       |
| `c`            | Count characters for *${#var}*                               |
| `C`            | Capitalize result                                            |
| `e`            | Do parameter, comand, arith expansion *${(e)$(<./file.txt)}* |
| `f`            | Split result to array on newlines                            |
| `F`            | Join arrays with newlines between elements                   |
| `i`            | *oi* or *Oi* sort case independently                         |
| `k`            | For associative array, result is keys                        |
| `L`            | Lower case result                                            |
| `n`            | *on* or *On* sort numerically                                |
| `o`            | Sort into ascending order                                    |
| `O`            | Sort into descending order                                   |
| `P`            | Interpret result as parameter name, get value                |
| `q`            | Quote result with backslashes                                |
| `qq`           | Quote result with single quotes                              |
| `qqq`          | Quote result with double quotes                              |
| `qqqq`         | Quote result with *$'...'*                                   |
| `Q`            | Strip quotes from result                                     |
| `t`            | Output type of variable (see below)                          |
| `u`            | Unique: remove duplicates after first                        |
| `U`            | Upper case result                                            |
| `v`            | Include value in result; may have *(kv)*                     |
| `V`            | Visible representation of special chars                      |
| `w`            | Count words with *${#var}*                                   |
| `W`            | Same but empty words count                                   |
| `X`            | Report parsing errors (normally ignored)                     |
| `z`            | Split to words using shell grammar                           |
| `p`            | Following forms recognize print *\­escpae*                   |
| `j:str:`       | Join words together with *str*                               |
| `sj:str:`      | Join words with *str* between                                |
| `l:x:`         | Pad with spaces on left to width *x*                         |
| `l:x::s1:`     | Same but pad with repeated *s1*                              |
| `l:x::s1::s2:` | Same but *s2* used once before any *s1s*                     |
| `r:x::s1::s2:` | Pad on right, otherwise same as *l* forms                    |
| `s:str:`       | Split to array on occurrences of str                         |
| `S`            | With patterns, search substrings                             |
| `I:exp:`       | With patterns, match expth occurrence                        |
| `B`            | With patterns, include match beginning                       |
| `E`            | With patterns, include match end                             |
| `M`            | With patterns, include matched portion                       |
| `N`            | With patterns, include length of match                       |
| `R`            | With patterns, include unmatched part (rest)                 |

## ==============================================================

### ORDER OF RULES

1. Nested substitution: from inside out
2. Subscripts: `${arr[3]}` extract word;
	+ `${str[2]}`extract character;
	+ `${arr[2,4]}`, `${str[4,8]}` extract range;
	+ `-1` is last word/char, `-2` previous etc.
3. `${(P)var}` replaces name with value
4. ` ̈$array ̈` joins array, may use `(j:str:)`
5. Nested subscript e.g. `${${var[2,4]}[1]}`
6. `#,` `%,` / etc. modifications
7. Join if not joined and `(j:str:)`, `(F)`
8. Split if `(s)`, `(z)`, `(z)`, =
9. Split if `SH_WORD_SPLIT`
10. Apply `(u)`
11. Apply `(o)`, `(O)`
12. Apply `(e)`
13. Apply `(l.str.)`, `(r.str.)`
14. If single word needed for context, join with `$IFS[1]`

## ==============================================================

## TESTS AND NUMERIC EXPRESSION

|------|---------------------------------------------------------|
| `-a` | True if file exists                                     |
| `-b` | True if file is block special                           |
| `-c` | True if file is character special                       |
| `-d` | True if fileis directory                                |
| `-e` | True if file exists                                     |
| `-f` | True if fileis a regular file (not special or directory |
| `-g` | True if filehas setgid bit set (mode includes 02000)    |
| `-h` | True if fileis symbolic link                            |
| `-k` | True if filehas sticky bit set (mode includes 02000)    |
| `-p` | True if fileis named pipe (FIFO)                        |
| `-r` | True if fileis readable by current process              |
| `-s` | True if filehas non­zero size                           |
| `-u` | True if filehas setuid bit set (mode includes 04000)    |
| `-w` | True if fileis writeable by current process             |
| `-x` | True if fileexecutable by current process               |
| `-L` | True if fileis symbolic link                            |
| `-O` | True if fileowned by effective UID of currentprocess    |
| `-G` | True if filehas effective GID of current process        |
| `-S` | True if fileis a socket (special communication file)    |
| `-N` | True if filehas access time no newer than mod time      |

|------|----------------------------------------------|
| `-n` | True if str has non­zero length              |
| `-o` | True if option str is set                    |
| `-t` | True if str (number) is open file descriptor |
| `-z` | True if str has zero length                  |

|-------|------------------------------------------------------|
| `-nt` | True if file a is newer than file b                  |
| `-ot` | True if file a is older than file b                  |
| `-ef` | True if a and b refer to same file (i.e. are linked) |
| `=`   | True if string a matches pattern b                   |
| `==`  | Same but more modern (and still not often used)      |
| `!=`  | True if string a does not match pattern b            |
| `<`   | True if string a sorts before string b               |
| `>`   | True if string a sorts after string b                |
| `-eq` | True if numerical expressions a and b are equal      |
| `-ne` | True if numerical expressions a and b are not equal  |
| `-lt` | True if *a < b* numerically                              |
| `-gt` | True if *a > b* numerically                              |
| `-le` | True if *a≤b* numerically                              |
| `-ge` | True if *a≥b* numerically                              |

### EVENT DESIGNATORS

|------------|-------------------------------------------------------------------------|
| `!`        | Start a history expansion, except follow by  blank, newline, ‘=’ or ‘(’ |
| `!!`       | Refer to the previous command                                           |
| `!n`       | Refer to command-line n.                                                |
| `!-n`      | Refer to the current command-line minus n.                              |
| `!str`     | Refer to the most recent command starting with str.                     |
| `!?str[?]` | Refer to the most recent command containing str                         |
| `!#`       | Refer to the current command line typed in so far                       |
| `!{...}`   | Insulate a history reference from adjacent characters                   |

## USING ARRAY FLAGS

### (P) FLAG

+ *(P)* = further expand variable

`for parameter in XDG_{DATA,CONFIG,CACHE}_HOME; {`
: `print "${parameter} -> ${(P)parameter}" }`
: use of *(P)* flag

### (S) FLAG

+ *(S)* = specify pattern to match substrings

`string='one/two/three/two/one'`
: `print ${(S)string#two}`
: use of *(S)* flag; returns *one//three/two/one*

### (M) FLAG

+ *(M)* = matching flag

`string='one/two/three/two/one'`
: `print ${(MS)string#/t*o/}`
: use of *(M)* flag = *(M)* atching *(S)* ubstring; */two/three/two*

+ *(w)* = index string by word index (start at 1)

`var='You can even get the word that comes last'`
: `print ${var[(w)-1]}`
: use of *(w)* flag = return *last*

## ==============================================================

### CHECK IF VALUE IS IN ARRAY

`if (( ${array[(I)asdf]} )); then`
: checks if *asdf* is in array

`${${(k)map}[(I)foo]}`
: does key exist

`array=(foo bar baz foo)``
: `value=foo`
: `search=("$value")`
: `(){print -r $# occurrence${2+s} of $value in array} "${(@)array:*search}"``
: how many times value found in array `${A:*B}` (elements in *A* also in *B*)

## ==============================================================

### BRACE EXPANSION

`print 'woah' {,}`
: woah woah

`print 'woah' {,,}`
: woah woah woah

`print {01..10}`
: 01 .. 10

`print {a..z..3}`
: a d g j m p s v y

## ==============================================================

### TERNARY OPERATOR

`(( a > b ? yes : no ))`
: has to be used in arith

`[[ 1 -eq 1 ]] && asdf || print "Not true"`
: third statement exec if error in second statement

`[[ 1 == 1 ]] && { asdf ;:; } || print "Not true"`
: workaround for above

## ==============================================================

### READ

`read -rs 'secret?Password:'`
: save results in *secret*

`text=$(<file.txt); lines=(${text// /\\ })`
: read each line into array

`text=$(<&0)`
: fast form read */dev/stdin*

`read -u 0 -d '' text`
: slow form read */dev/stdin*

### DISOWN

`disown %1`
: explicit

`%1&|`
: short syntax

## ==============================================================

## INDEX SLICING

`print ${val:0:3}`
: *first 3* numbers

`print ${val:5} # 56789`
: every number *after 5*

`print ${val:(-3)}`
: *last 3* numbers

`print ${val:2:(-3)}`
: everything but *first 2* and *last 3*

`print ${val:(-6):2}`
: print 2 numbers startng from *6th to last*

`print ${TWILIO_ACCOUNT_SID[-9,$]}`
: *last 9* of scalar type var

## ==============================================================

### SUBSTRING MATCHING

`string='one/two/three/four/five'`
: `print ${string#*/} # two/three/four/five`
: `print ${string##*/} # five`
: `print ${string%/*} # one/two/three/four`
: `print ${string%%/*} # one`
: *%%* = end of string; *##* = begin of string

## ==============================================================

### LENGTH OF A STRING

`checksum=${(s< >)$(shasum -a 256 file.txt)[1]}`
`print ${(N)checksum##*}`
: print length of string

## ==============================================================

### SPLITTING STRINGS

`var='Sentence one. Sentence two.'`
`print ${var[(w)4]}`
: returns *two.*

## ==============================================================

### GLOBAL SUBSTITUTION

`attitude="it is what it is"`
`print ${attitude:s/is/be}`
: use of *s/a/a*

`print ${attitude:gs/is/be}`
: global = use of *gs/a/a*

## ==============================================================

## REMOVING ELEMENT FROM ARRAY

`${array[3]}=()`
: remove index without leaving blank

`array[${array[(i)charlie]}]=()`
: removing it

`excluded=(${array:|filter})`
: newer: remove from array any element contained in filter

`included=(${array:*filter})`
: remove from array any element *not* contained in array filter

`output=(${array:#*w*})`
: remove from array any element that matches pattern

`output=(${(M)array:#*w*})`
: remove from array any element that doesn't match pattern

`print -- ${(M)${(@)${(f)${"$(whois ${ip})"}}}:#CIDR*}`
: remove any line from whos that doesn't start with 'CIDR'

### PRINT ARRAYS

`print ${(k)example:#foo*}`
: print all keys in AA that don't start with foo

`print ${(Mk)example:#foo*}`
: print all keys in AA that do start with foo

`print ${(v)example:#foo*}`
: print all values in AA that don't start with foo

`print ${(Mv)example:#foo*}`
: print all values in AA that do start with foo

`typeset -p1 my_pairs`
: pretty print key=value of AA

## ==============================================================

## GLOBBING QUALIFIERS

`print ./*(:a)`
: *(:a)* = return each glob abs path

`print ./*(:P)`
: *(:P)* = return each glob abs path, resolve symlinks

`print ~/Desktop/example(:A)`
: *(:A)* = return each glob abs path, try resolve sym, fall back abs file if sym not exist

`print ./*(:e)`
: *(:e)* = string all but extension

`print ./*(:r)`
: *(:r)* = string extension suffix

`print "${val} => ${val:t}"`
: *(:t)* = string all leading dir from filepath

`print "${val} => ${val:h}"`
: *(:h)* = string all trailing dir from filepath

`filename=${${(%):-%N}:A}`
: print absolute path of file currently being sourced

`filepath=${${(%):-%N}:A:h}`
: print abs path of dir containing file being sourced

## ==============================================================

## GLOBBING SPECIFIC FILETYPES

`print ./*(.); print ./**/*(.)`
: all plain files

`print ./*(^/); print ./**/*(^/)`
: anything but directories

`print ./*(/^F)`
: only empty directories

`print ./*(/OL:q)`
: all dir decending size, escaped

`print ./*(.DoL[-1])`
: *(L)* = sort by len, ascending order, pick last element

`print ./*(.DOL[1])`
: *(O)* = sort descending order, pick last element

`print ./*(.Lm-2)`
: select files larger 2MB in dir

`print ./*(.om[1])`
: most recent file in

| 'M' | for Months                       |
| 'w' | for weeks                        |
| 'h' | for hours                        |
| 'm' | for minutes                      |
| 's' | for seconds                      |
| '-' | modified less than *#* hours ago |
| '+' | modified more than *#* hours ago |

`print -l ./*(.mh-1)`
: example of above

`open ./path/to/dir/*(.c-2)`
: created in last 2 days

`folders=( /usr(/N) /bin(/N) /asdf(/N) )`
: *(N)* enable null glob; *(/)* only match an existing directory

`print -l ./*(e#'[[ ! -e $REPLY/tmp ]]'#)`
: *#* = delim b/w expansion and string

## ==============================================================

## CHECKING IF COMMAND EXISTS

`if [[ =brew ]]; then`
: *equals expansion* = check path for executable

`if (( ${+commands[brew]} )); then`
: *parameter expansion* = notice parenthesis

## ==============================================================

## COUNT THE NUMBER OF WORDS

`print ${#string} # => 13`
: *sentence="Hello world"*

`print ${(w)#string} # => 2`
: *sentence="Hello world"* - `(w)`

## ==============================================================

## READING WORDS

`words=($(<words.txt))`
: read words into array

`print ${(u)words[@]}`
: *(u)* = print unique words

`for word in ${(u)words}; do`
: `count+=("$(grep -c ${word} <<< "${(F)words}") ${word}")`
: `done`
: add "<#> <word>" to the array

## ==============================================================

## FILE DESCRIPTORS

`<&-`
: Close the standard input.

`1>&-`
: Close the standard output.

`2>&-`
: Close the standard error.

`<&p`
: Move the input from the coprocess to stdin

`>&p`
: Move the output from the coprocess to output

`2>&1`
: Redirect standard error to standard output

`1>&2`
: Redirect standard output to standard error

`&> file.txt`
: Redirect both standard output and standard error to file.txt

`exec 3> ~/three.txt`
: custom FD

## ==============================================================

## TYPESET

### FLAGS TO STATE VARIABLE TYPE

`-F [ name[=value] ... ]`
: declare variable name as floating point (decimal notation)

`-E [ name[=value] ... ]`
: declare variable name as floating point (scientific notation)

`-i [ name[=value] ... ]`
: declare variable name as an integer

`-a [ name[=value] ... ]`
: declare variable name as an array

`-A [ name[=value] ... ]`
: declare variable name as an associative array

### FLAGS TO STATE VARIABLE PROPERTIES

`typeset -r [ name[=value] ... ]`
: mark variable name as read-only

`typeset -x [ name[=value] ... ]`
: mark variable name as exported

`typeset -g [ name[=value] ... ]`
: mark variable name as global

`typeset -U [ name[=value] ... ]`
: convert array-type variable name such that it always contains unique-elements only

### FLAGS TO MODIFY COMMAND OUTPUT

`typeset -l [ name[=value] ... ]`
: print value of name in lower-case whenever expanded

`typeset -u [ name[=value] ... ]`
: print value of name in upper-case whenever expanded

`typeset -H [ name[=value] ... ]`
: suppress output for typeset name if variable name has already been assigned a value

`typeset -p [ name[=value] ... ]: print name in the form of a typeset command with an assignment, regardless of other flags and options. Note`
: the −H flag will still be respected; no value will be shown for these parameters.

`typeset -p1 [ name[=value] ... ]`
: print name in the form of a typeset command with an assignment, regardless of other flags and options.

### MATCHING A CERTAIN TYPE

`typeset +`
: All variables with their types

`typeset -E +`
: All variables that are floating point

`typeset USER`
: View the assignment of a variable

`typeset +m 'foo*'`
: print all env vars who match apttern

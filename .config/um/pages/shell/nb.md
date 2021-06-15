# nb --
{:data-section="shell"}
{:data-date="June 07, 2021"}
{:data-extra="Um Pages"}

## SYNOPSIS
Notebook / note taking

## EXAMPLES AND USAGE

## NB ADD

`$ nb a`
: *alias*

`$ nb +`
: *alias*

`$ nb create`
: *alias*

`$ nb new`
: *alias*

`$ nb add`
: create a new note in your text editor

`$ nb add example.md`
: create a new note with the filename "example.md"

`$ nb add "This is a note."`
: create a new note containing "This is a note."

`$ echo "Note content." | nb add`
: create a new note with piped content

`$ nb add --title "Secret Document" --encrypt`
: create a new password-protected, encrypted note titled "Secret Document"

`$ nb example:add "This is a note."`
: create a new note in the notebook named "example"

`$ nb add sample/`
: create a new note in the folder named "sample"

`$ nb add "This is a note."`
: add note with content

`$ nb add --content "Note content."`
: add note with content

`$ nb add example.md`
: add note file

`$ pbpaste | nb add`
: create note with *pbpaste*

`$ nb add --filename "example.md" -t "Example Title" -c "Example content."`
: add with options

`$ nb add "Example content." --title "Tagged Example" --tags tag1,tag2`
: add with options

`$ nb add example.org`
: open a new *Org* file in the editor

`$ nb add --type rst`
: open a new *reStructuredText* file in the editor

`$ nb add .js`
: open a new *JavaScript* file in the editor

`$ nb .. -e`
: encryption with pgp

### SAVE CODE SNIPPETS

`$ pb | nb add .js`
: save the clipboard contents as a JavaScript file in the current notebook

`$ pb | nb a rust: .rs`
: save the clipboard contents as a Rust file in the "rust" notebook
: using the shortcut alias `nb a`

`$ pb | nb + snippets: example.hs`
: save the clipboard contents as a Haskell file named "example.hs" in the
: "snippets" notebook using the shortcut alias `nb +`

### OPTIONS

`--title`,`-t`
: title

`--content`,`-c`
: content

`--tags`
: tags

## ===================================================x

## LISTING AND FILTERING

* Pass an id, filename, or title to view the listing for that note
* No exact match, use "string"
* Can use *regex*

`$ nb list`
: list all files

`$ nb ls`
: *alias* for *nb notebooks* and *nb list*

`$ nb browse`
: browse notes

`$ nb ls example ideas`
: act as *or*

`$ nb ls 3 --excerpt`
: view excerpts of note

`$ nb ls 3 -e 8`
: view excerpts of note

### OPTIONS

`--excerpt`,`-e`
: view excerpts of note

`--reverse`,`-r`
: reverse listing

`--sort`,`-s`
: sort listing

`--limit`,`-l`
: limit number of items in listing

`--all`,`-a`
: show all listing

## ===================================================x

## EDITING

`$ nb edit`
: edit item

`$ nb browse edit`
: edit in browser

`$ nb e`
: *alias*

`$ nb edit 3`
: edit note by *id*

`$ nb edit example.md`
: edit note by *filename*

`$ nb edit "A Document Title"`
: edit note by *title*

`$ nb edit example:12`
: edit note 12 in the notebook named "example"

`$ nb example:12 edit`
: edit note 12 in the notebook named "example", alternative

`$ nb example:edit 12`
: edit note 12 in the notebook named "example", alternative

`$ echo "Content to append." | nb edit 1`
: append to note

`$ nb edit 1 --content "Content to append."`
: same as above

### OPTIONS

`--content`,`-c`
: content to be appended

`--overwrite`
: overwrite file

`--prepend`
: prepend to file

`--edit`
: open in editor before saving

## ===================================================x

## VIEWING

`$ nb show // nb s`
: show with syntax highlighting

`$ nb browse`
: browse files

`$ nb open`
: open file

`$ nb peek`
: peek at file

`$ nb show 3`
: show note by 8id8

`$ nb show example.md`
: show note by *filename*

`$ nb show "A Document Title"`
: show note by *title*

`$ nb 3 show`
: show note by *id*, alternative

`$ nb show example:12`
: show note 12 in the notebook named "example"

`$ nb example:12 show`
: show note 12 in the notebook named "example", alternative

`$ nb example:show 12`
: show note 12 in the notebook named "example", alternative

`$ nb show 123 --print`
: print to stdout

### OPTIONS

`--print`,`-p`
: stdout

`--no-color`
: don't syntax highlight

`--render`,`-r`
: render *html* and open in browser

## ===================================================x

## DELETING

`$ nb delete`
: delete files

`$ nb browse delete`
: browse delete files

`$ nb delete 3`
: delete item by id

`$ nb delete example.md`
: delete item by filename

`$ nb delete "A Document Title"`
: delete item by title

`$ nb 3 delete`
: delete item by id, alternative

`$ nb delete example:12`
: delete item 12 in the notebook named "example"

`$ nb example:12 delete`
: delete item 12 in the notebook named "example", alternative

`$ nb example:delete 12`
: delete item 12 in the notebook named "example", alternative

`$ nb delete example/345`
: delete item 345 in the folder named "example"

`$ nb delete 89 56 21`
: delete items with the ids 89, 56, and 21

## ===================================================x

## FOLDERS

`$ nb add example/`
: add a new note in the *folder* named "example"

`$ nb add example/demo/`
: add a new note in the *folder* named "demo" in "example"

`$ nb add sample --type folder`
: create a new folder named "sample"

`$ nb add example/demo --type folder`
: create a folder named "example" containing a folder named "demo"

`$ nb list`
: list with *ids*

`$ nb list 1/`
: list with *ids*

`$ nb list 1/2/`
: list with *ids*

## ===================================================x

## SEARCH

`$ nb search "#tag1" "#tag2"`
: search for tagged items

## ===================================================x

## SETTINGS

`$ nb set editor`
: set editor

`$ nb set default_extension`
: set default ext

`$ nb set limit <number>`
: set number of items to show in *ls*

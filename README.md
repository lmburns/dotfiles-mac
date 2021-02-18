dotfiles
========

## [Karabiner](.config/karabiner/karabiner.json)

- Karabiner is a very useful utility on MacOS that allows for global keybindings.
- The keybindings that are there mimic Vim's functionality when holding caps lock.
- When <kbd>⇪ Caps lock</kbd> is held down it is mapped to:
  - <kbd>⌃ Control</kbd> + <kbd>⌥ Option</kbd> + <kbd>⌘ Command</kbd> + <kbd>⇧ Shift</kbd>
- When <kbd>⇪ Caps lock</kbd> is pressed it is mapped to <kbd>⎋ Escape</kbd>
- To get <kbd>⇪ Caps lock</kbd> you need to press left <kbd>⇧ Shift</kbd> then right <kbd>⇧ Shift</kbd>
- While holding <kbd>⇪ Caps lock</kbd>, pressing the following keys will do these actions:

| Key           | Action                           |
| :-----        | :-----                           |
| <kbd>j</kbd>  | down                             |
| <kbd>k</kbd>  | up                               |
| <kbd>h</kbd>  | left                             |
| <kbd>l</kbd>  | right                            |
| <kbd>0</kbd>  | beginning of line                |
| <kbd>4</kbd>  | end of line (close enough to $)  |
| <kbd>gg</kbd> | beginning of document            |
| <kbd>G</kbd>  | end of document                  |
| <kbd>b</kbd>  | move backwards a word            |
| <kbd>w</kbd>  | move forward a word              |
| <kbd>u</kbd>  | highlight all words to the left  |
| <kbd>i</kbd>  | highlight one word to the left   |
| <kbd>o</kbd>  | highlight one word the right     |
| <kbd>p</kbd>  | highlight all words to the right |
| <kbd>yy</kbd> | copy                             |

## Neovim Mappings

**Leader** will be represented as `<L->` (which is `<Space>`)

### Mappings

| Mapping         | Action                                  | Mode  |
| :-----------    | :------------                           | :---- |
| <F1>            | run file as `./`                        |       |
| <F3>            | turn on/off relative line numbers       |       |
| <F4>            | compile markdown using pandoc           |       |
| <F9>            | get syntnax name / attributes of hover  | n     |
| <F10>           | spellcheck                              |       |
| gkk             | move to previous blank line             | n     |
| gjj             | move to next blank line                 | n     |
| H               | move to first character on line         | nv    |
| L               | move to last character on line          | nv    |
| <C-S>           | save file                               | nvi   |
| S               | replace all                             | n     |
| <L-Q>           | replace single quotes with double       | n     |
| <Tab> / <S-Tab> | indent / de-indent                      | nvi   |
| d               | delete line not to clipboard            | nv    |
| Y               | yank line without newline               | n     |
| x               | cut not to clipboard                    | n     |
| E               | delete line, keeping cursor on line     | n     |
| gV              | reselect text that has just been pasted | n     |
| vv              | select first char to last char on line  | n     |
| q: / Q:         | quit                                    | n     |
| Q               | play macro recording                    | nv    |
| qq / q          | start / stop macro                      | n     |
| <L-nt>          | create new tab using FZF                | n     |
| <L-to>          | leave open only current tab             | n     |
| <L-tc>          | close current tab                       | n     |
| <L-tn>          | next tab                                | n     |
| <L-tp>          | previous tab                            | n     |
| <C-j>           | move down window                        | ni    |
| <C-k>           | move up window                          | ni    |
| <C-h>           | move left window                        | n     |
| <C-l>           | move right window                       | n     |
| j / k           | move through wrapped lines              | n     |
| <L-sc>          | run `shellcheck`                        | n     |
| <L-vw>          | navigate to vimwiki index               | n     |
| <L-ee>          | coc explorer                            | n     |
| <L-nn>          | nerdtree toggle                         | n     |
| <C-k>           | fuzzy complete word                     | i     |
| <C-f>           | fuzzy complete line                     | i     |
| <L-f>           | fuzzy :Files                            | n     |
| <L-gf>          | fuzzy :GFiles                           | n     |
| <L-L>           | fuzzy :Locate                           | n     |
| <C-f>           | fuzzy using ripgrep                     | n     |
| <L-a>           | fuzzy :Buffers                          | n     |
| <L-A>           | fuzzy :Windows                          | n     |
| <L-;>           | fuzzy :BLines  (buffer's lines)         | n     |
| <L-hc>          | fuzzy :History: (command history)       | n     |
| <L-hf>          | fuzzy :History  (file history)          | n     |
| <L-mm>          | fuzzy :Maps (view mappings)             | n     |
| f               | easymotion - forward char               | n     |
| s               | easymotion - vim-sneak                  | n     |
| jk              | <ESC>                                   | iv    |
| <L-ut>          | view undotree                           | n     |
| <L-ma>          | open vim magit (git diffs)              | n     |
| ) (             | next / prev gitgutter hunk              | n     |
| gm              | :LivedownToggle (preview html)          | n     |
| <L-br>          | open bracey (view live html)            | n     |
| <L-r>           | reload bracey window                    | n     |
| <L-st>          | open startify                           | n     |
| <C-t>           | open native terminal                    | ni    |
| <L-lf>          | open lf file manager in floatterm       | n     |
| <L-rf>          | open ipython split view neoterm         | n     |
| <L-rr>          | clear neoterm screen                    | n     |
| <L-rt>          | toggle neoterm on and off               | n     |
| <L-I>           | jump between markdown headers           | n     |
| <L-nv>          | edit $MYVIMRC                           | n     |
| <L-mcs>         | open mkdx cheatsheet                    | n     |

### Functions
| Function      | Action                                       |
| :------------ | :----------                                  |
| SQ            | SyntaxQuery - get syntax attributes of hover |
| IndentSize    | set file specific indents                    |
| Format        | format current buffer                        |
| Fold          | fold current buffer                          |
| OR            | organize imports current buffer              |
| Conf          | fuzzy find ~/.config                         |
| Dots          | dotbare (dotfile manager) edit files         |

==========================================================
## Scripts
### `jupview`

Meant to be used with terminal file managers (`lf`, `nnn`, `ranger`, `vifm`) without any parameters given. For example:

```sh
#!/bin/bash

handle_other() {
  case "${1}" in
    *.ipynb) jupview "${1}";;
  esac
}
```

This will show a preview of the .ipynb file in the terminal.

#### Usage

```sh
Options:
    -P, --pager             View .ipynb file with a pager instead of stdout
    -I, --no-input          Clear input cells of .ipynb file
    -p, --no-prompt         Clear input / output prompts
    -O, --clear-output      Clear output cells of .ipynb file
    -t, --theme             Change syntax highlighting theme (gruvbox default)
```
==========================================================
### manp

View manpages in `zathura`.

**Usage**: `manp ls`

==========================================================
### macho & macho-pdf

Search manpages using fuzzy finder.

`macho-pdf` will open the file in zathura.

**Usage**: macho

==========================================================
### pzz

Search directory with `fzf` for pdfs to open in `zathura`.

**Usage**: As simple as calling the command `pzz` in a directory with pdfs.

==========================================================
### cps

Whenever you track your dotfiles with a git bare repo you are unable to use `xargs` to push changes to all remotes.

This is setup to work with something like:
```sh
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
```

The remote names can be changed.

**Usage**: `cps`

==========================================================
### lockscreen

Capture a screenshot of current screen, lock computer, modify the image a little and set it as the wallpaper.

**Usage**: `lockscreen`

==========================================================
### osx-cmds

A list of commands to setup your Mac. It is a script, but I would recommend reading through the file and copying and pasting individual ones that you would want to use.

==========================================================
### grm, index-gen, & post-receive

`grm` is a git repo manager that I modified to fit my needs. It can create repos, list repos, recompile repos for `stagit`. See `grm -h` for help with all the commands.

`post-receive` is a post-receive git hook that is ran after pushing a commit.

`index-gen` is used in combination with `grm` to generate an index.html file for my website.

==========================================================
### rf

Search directory for files using `rg` (ripgrep). This command is very similar to `fd`.

**Usage**: `rf <term>`

==========================================================
### rglf

Used in conjunction with `lf` to search a directory with `rg` and return the resuls in a `dialog` box.

**Usage**: set a mapping in lfrc file

==========================================================
### tordone & transadd

Taken from [Luke Smith](https://github.com/LukeSmithxyz/voidrice) and modified for macOS.

`transadd` will add a torrent to `transmission-remote`.

`tordone` is a script used in `transmission`'s settings to run when a torrent is finished.

==========================================================
### webpull

Download a websites files to a local space.

**Usage**: `webpull <url>`

==========================================================
### wim

Open a script in `$EDITOR`

**Usage**: `wim <script_name>`

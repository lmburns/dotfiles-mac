dotfiles
========

These are some of my dotfiles.

[Karabiner](.config/karabiner/karabiner.json)
---------
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

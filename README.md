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

<details>
<summary>**Main Karabiner Mappings**</summary>

| Key           | Action                                                    |
| :-----        | :-----                                                    |
| <kbd>j</kbd>  | down                                                      |
| <kbd>k</kbd>  | up                                                        |
| <kbd>h</kbd>  | left                                                      |
| <kbd>l</kbd>  | right                                                     |
| <kbd>0</kbd>  | beginning of line                                         |
| <kbd>4</kbd>  | end of line (close enough to $)                           |
| <kbd>gg</kbd> | beginning of document                                     |
| <kbd>G</kbd>  | end of document                                           |
| <kbd>b</kbd>  | move backwards a word                                     |
| <kbd>w</kbd>  | move forward a word                                       |
| <kbd>u</kbd>  | highlight all words to the left                           |
| <kbd>i</kbd>  | highlight one word to the left                            |
| <kbd>o</kbd>  | highlight one word the right                              |
| <kbd>p</kbd>  | highlight all words to the right                          |
| <kbd>yy</kbd> | copy                                                      |
| <kbd>J</kbd>  | <kbd>⌥ Option</kbd> + <kbd>⌃ Control</kbd> + <kbd>←</kbd> |
| <kbd>K</kbd>  | <kbd>⌥ Option</kbd> + <kbd>⌃ Control</kbd> + <kbd>→</kbd> |

</details>

<details>
<summary>**Other Karabiner Mappings**</summary>

| Other mappings                 | Action              |
|--------------------------------|---------------------|
| <kbd>Cmd</kbd> + <kbd>qq</kbd> | quit app            |
| <kbd>Cmd</kbd> + <kbd>ww</kbd> | close window of app |

</details>

The <kbd>⌥ Option</kbd> + <kbd>⌃ Control</kbd> + <kbd>Arrow</kbd> mappings are significant if you have this sequence mapped to changing tabs in iTerm.  I just find this a little easier to do instead of moving my fingers off of the home row.

----

## [skhd](.config/skhd/skhdrc) Keybindings

<kbd>Hyper</kbd> = <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Cmd</kbd> + <kbd>Shift</kbd>

| Keys                                                             | Action        |
|------------------------------------------------------------------|---------------|
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Cmd</kbd> + <kbd>r</kbd> | Restart yabai |
| <kbd>Hyper</kbd> + <kbd>Backspace</kbd>                          | Close window  |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>g</kbd>                | Toggle gaps   |

| Swapping                                       |            |
|------------------------------------------------|------------|
| <kbd>Hyper</kbd> + <kbd>=</kbd>                | Swap south |
| <kbd>Hyper</kbd> + <kbd>-</kbd>                | Swap north |
| <kbd>Hyper</kbd> + <kbd>[</kbd>                | Swap west  |
| <kbd>Hyper</kbd> + <kbd>]</kbd>                | Swap east  |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> <kbd>h</kbd> | Swap west  |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> <kbd>j</kbd> | Swap south |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> <kbd>k</kbd> | Swap north |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> <kbd>l</kbd> | Swap east  |

| Focusing                        |              |
|---------------------------------|--------------|
| <kbd>Alt</kbd> + <kbd>h</kbd>   | Focus west   |
| <kbd>Alt</kbd> + <kbd>j</kbd>   | Focus south  |
| <kbd>Alt</kbd> + <kbd>k</kbd>   | Focus north  |
| <kbd>Alt</kbd> + <kbd>l</kbd>   | Focus east   |
| <kbd>Hyper</kbd> + <kbd>a</kbd> | Focus recent |

| Resizing                                          |                  |
|---------------------------------------------------|------------------|
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>h</kbd> | Resize -20 left  |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>h</kbd> | Resize -20 right |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>j</kbd> | Resize 20 bottom |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>j</kbd> | Resize 20 top    |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>k</kbd> | Resize -20 right |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>k</kbd> | Resize -20 right |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>l</kbd> | Resize 20 right  |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>l</kbd> | Resize 20 right  |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>0</kbd> | Equalize         |

| Floating                                             |                            |
|------------------------------------------------------|----------------------------|
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>Space</kbd> | Toggle float               |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>c</kbd>     | Float & Center             |
| <kbd>Hyper</kbd> + <kbd>e</kbd>                      | Resize floating window     |
| <kbd>Hyper</kbd> + <kbd>1</kbd>                      | Float & keep same position |

| Moving Window                                    |                   |
|--------------------------------------------------|-------------------|
| <kbd>Hyper</kbd> + <kbd>f</kbd>                  | Fullscreen        |
| <kbd>Hyper</kbd> + <kbd>r</kbd>                  | Rotate 90 degrees |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>x</kbd> | Mirror x-axis     |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>y</kbd> | Mirror y-axis     |

| Stacks                              |                                        |
|-------------------------------------|----------------------------------------|
| <kbd>Hyper</kbd> + <kbd>s</kbd>     | Toggle stack                           |
| <kbd>Hyper</kbd> + <kbd>m</kbd>     | Go to next window (in or out of stack) |
| <kbd>Hyper</kbd> + <kbd>n</kbd>     | Go to prev window (in or out of stack) |
| <kbd>Hyper</kbd> + <kbd>Space</kbd> | Toggle focus on stack                  |

----

## [Neovim Mappings](.config/nvim/init.vim)

**Leader**: `<Space>`

### Mappings

| Mapping                               | Action                                  | Mode  |
| :-----------                          | :------------                           | :---- |
| <kbd>F1</kbd>                         | run file as `./`                        | n     |
| <kbd>F2</kbd>                         | turn on/off wrapping                    | n     |
| <kbd>F3</kbd>                         | turn on/off relative line numbers       | n     |
| <kbd>F4</kbd>                         | compile markdown using pandoc           |       |
| <kbd>F9</kbd>                         | get syntax name / attributes of hover   | n     |
| <kbd>F10</kbd>                        | spellcheck                              |       |
| <kbd>gkk</kbd>                        | move to previous blank line             | n     |
| <kbd>gjj</kbd>                        | move to next blank line                 | n     |
| <kbd>H</kbd>                          | move to first character on line         | nv    |
| <kbd>L</kbd>                          | move to last character on line          | nv    |
| <kbd>ctrl</kbd> + <kbd>s</kbd>        | save file                               | nvi   |
| <kbd>S</kbd>                          | replace all                             | n     |
| <kbd>Leader</kbd> + <kbd>Q</kbd>      | replace single quotes with double       | n     |
| <kbd>⇥ Tab</kbd>                      | indent                                  | nvi   |
| <kbd>⇧ Shift</kbd> + <kbd>⇥ Tab</kbd> | de-indent                               | nvi   |
| <kbd>d</kbd>                          | delete line not to clipboard            | nv    |
| <kbd>Y</kbd>                          | yank line without newline               | n     |
| <kbd>x</kbd>                          | cut not to clipboard                    | n     |
| <kbd>E</kbd>                          | delete line, keeping cursor on line     | n     |
| <kbd>gV</kbd>                         | reselect text that has just been pasted | n     |
| <kbd>vv</kbd>                         | select first char to last char on line  | n     |
| <kbd>Leader</kbd> + <kbd>sa</kbd>     | add space after character               | n     |
| <kbd>q:</kbd> / <kbd>Q:</kbd>         | quit                                    | n     |
| <kbd>Q</kbd>                          | play macro recording                    | nv    |
| <kbd>qq</kbd> / <kbd>q</kbd>          | start / stop macro                      | n     |
| <kbd>Leader</kbd> + <kbd>nt</kbd>     | create new tab using FZF                | n     |
| <kbd>Leader</kbd> + <kbd>to</kbd>     | leave open only current tab             | n     |
| <kbd>Leader</kbd> + <kbd>tc</kbd>     | close current tab                       | n     |
| <kbd>Leaader</kbd> + <kbd>tn</kbd>    | next tab                                | n     |
| <kbd>Leader</kbd> + <kbd>tp</kbd>     | previous tab                            | n     |
| <kbd>ctrl</kbd> + <kbd>j</kbd>        | move down window                        | ni    |
| <kbd>ctrl</kbd> + <kbd>k</kbd>        | move up window                          | ni    |
| <kbd>ctrl</kbd> + <kbd>h</kbd>        | move left window                        | n     |
| <kbd>ctrl</kbd> + <kbd>l</kbd>        | move right window                       | n     |
| <kbd>j</kbd> / <kbd>k</kbd>           | move through wrapped lines              | n     |
| <kbd>J</kbd>  / <kbd>K</kbd>          | move selected text through text         | v     |
| <kbd>Leader</kbd> + <kbd>sc</kbd>     | run `shellcheck`                        | n     |
| <kbd>Leader</kbd> + <kbd>vw</kbd>     | navigate to vimwiki index               | n     |
| <kbd>Leader</kbd> + <kbd>ee</kbd>     | coc explorer                            | n     |
| <kbd>Leader</kbd> + <kbd>nn</kbd>     | nerdtree toggle                         | n     |
| <kbd>ctrl</kbd> + <kbd>k</kbd>        | fuzzy complete word                     | i     |
| <kbd>ctrl</kbd> + <kbd>f</kbd>        | fuzzy complete line                     | i     |
| <kbd>Leader</kbd> + <kbd>f</kbd>      | fuzzy `:Files`                          | n     |
| <kbd>Leader</kbd> + <kbd>gf</kbd>     | fuzzy `:GFiles`                         | n     |
| <kbd>Leader</kbd> + <kbd>L</kbd>      | fuzzy `:Locate`                         | n     |
| <kbd>ctrl</kbd> + <kbd>f</kbd>        | fuzzy using `rg` (ripgrep)              | n     |
| <kbd>Leader</kbd> + <kbd>a</kbd>      | fuzzy `:Buffers`                        | n     |
| <kbd>Leader</kbd> + <kbd>A</kbd>      | fuzzy `:Windows`                        | n     |
| <kbd>Leader</kbd> + <kbd>;</kbd>      | fuzzy `:BLines`  (buffer's lines)       | n     |
| <kbd>Leader</kbd> + <kbd>hc</kbd>     | fuzzy `:History:` (command history)     | n     |
| <kbd>Leader</kbd> + <kbd>hf</kbd>     | fuzzy `:History`  (file history)        | n     |
| <kbd>Leader</kbd> + <kbd>mm</kbd>     | fuzzy `:Maps` (view mappings)           | n     |
| <kbd>f</kbd>                          | easymotion - forward char               | n     |
| <kbd>s</kbd>                          | easymotion - vim-sneak                  | n     |
| <kbd>Leader</kbd> + <kbd>G</kbd>      | Goyo - on & off                         | n     |
| <kbd>jk</kbd> / <kbd>kj</kbd>         | <kbd>ESC</kbd>                          | iv    |
| <kbd>Leader</kbd> + <kbd>ut</kbd>     | view undotree                           | n     |
| <kbd>Leader</kbd> + <kbd>ma</kbd>     | open vim magit (git diffs)              | n     |
| <kbd>)</kbd> / <kbd>(</kbd>           | next / prev gitgutter hunk              | n     |
| <kbd>gm</kbd>                         | `:LivedownToggle` (preview html)        | n     |
| <kbd>Leader</kbd> + <kbd>br</kbd>     | open bracey (view live html)            | n     |
| <kbd>Leader</kbd> + <kbd>r</kbd>      | reload bracey window                    | n     |
| <kbd>Leader</kbd> + <kbd>st</kbd>     | open startify                           | n     |
| <kbd>ctrl</kbd> + <kbd>t</kbd>        | open native terminal                    | ni    |
| <kbd>Leader</kbd> + <kbd>lf</kbd>     | open `lf` file manager in floatterm     | n     |
| <kbd>Leader</kbd> + <kbd>rf</kbd>     | open `ipython` split view neoterm       | n     |
| <kbd>Leader</kbd> + <kbd>rf</kbd>     | clear neoterm screen                    | n     |
| <kbd>Leader</kbd> + <kbd>rt</kbd>     | toggle neoterm on and off               | n     |
| <kbd>Leader</kbd> + <kbd>ro</kbd>     | reset neoterm size                      | n     |
| <kbd>Leader</kbd> + <kbd>I</kbd>      | jump between markdown headers           | n     |
| <kbd>Leader</kbd> + <kbd>nv</kbd>     | edit `$MYVIMRC`                         | n     |
| <kbd>Leader</kbd> + <kbd>mcs</kbd>    | open mkdx cheatsheet                    | n     |
| <kbd>Leader</kbd> + <kbd>o</kbd>      | wrap word in `(["'` etc.              | n     |
| <kbd>Leader</kbd> + <kbd>ci</kbd>     | change ` to `*`                         | n     |

### Functions
| Function      | Action                                       |
| :------------ | :----------                                  |
| `SQ`          | `SyntaxQuery` - get syntax attributes of hover |
| `IndentSize`  | set file specific indents                    |
| `Format`      | format current buffer                        |
| `Fold`        | fold current buffer                          |
| `OR`          | organize imports current buffer              |
| `Conf`        | fuzzy find `~/.config`                       |
| `Dots`        | `dotbare` (dotfile manager) edit files       |
| `EE`          | create dir like `mkdir -p`                   |
| `RipgrepFZF`  | `:RG` with preview                           |
| `PlugHelp`    | `fzf` all docs for plugins                   |

==========================================================
## [Scripts](mybin)
### `jupview`

Meant to be used with terminal file managers (`lf`, `nnn`, `ranger`, `vifm`) without any parameters given. For example:

```sh
#!/bin/sh

handle_other() {
  case "${1}" in
    *.ipynb) jupview "${1}";;
  esac
}
```

This will show a preview of the .ipynb file in the terminal.

![jupview preview](https://burnsac.xyz/gallery/media/large/jupview-preview.png)

#### Usage

```sh
Options:
    -P, --pager             View .ipynb file with a pager instead of stdout
    -I, --no-input          Clear input cells of .ipynb file
    -p, --no-prompt         Clear input / output prompts
    -O, --clear-output      Clear output cells of .ipynb file
    -t, --theme             Change syntax highlighting theme (gruvbox default)
```

================================================
## `chgmac`

Change MAC address randomly or interactively. Can specify interface as well.

#### Usage

```sh
Options:
    -r, --restore           Restore to system default MAC
    -m, --manual            Manually enter the MAC address in dialog box
                               Optionally enter <MAC> on CLI without invoking dialog
                              Type '-m x' (anything not a MAC) to be prompted for randomized addresses
    -i, --interface         Select the interface with FZF (default en0)
                               Optionally enter <interface> on CLI without invoking FZF
    -v, --version           Show version information
    -h, --help              Print this help message and exit
```

================================================
### `flist`
fzf view of script directory with descriptions

================================================
### `rmcrap`

Deletes `.DS_Store` files and `__MACOSX` directories recursively.

#### Usage

```sh
Options:
    -s, --show     Show tree diagram of what rmcrap is removing
    -c, --count    Show count of .DS_Store and __MACOSX removed
```

================================================
### `manp`

View manpages in `zathura`.

**Usage**: `manp ls`

================================================
### `macho` & `macho-pdf`

Search manpages using fuzzy finder.

`macho-pdf` will open the file in zathura.

**Usage**: `macho`

================================================
### `fzf_pdf`

Search directory with `fzf` for pdfs to open in `zathura`.

**Usage**: As simple as calling the command `pzz` in a directory with pdfs.

================================================
### `cps`

Whenever you track your dotfiles with a git bare repo you are unable to use `xargs` to push changes to all remotes.

This is setup to work with something like:
```sh
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
```

The remote names can be changed.

**Usage**: `cps`

================================================
### `lockscreen`

Capture a screenshot of current screen, lock computer, modify the image a little and set it as the wallpaper.

**Usage**: `lockscreen`

================================================
### `mkscript`

Create a script and place it in the specified directory.
One can uncomment the `zenity` dialog section to use it over regular `dialog`.

================================================
### `nv`

Search recent files opened in `nvim` in `fzf`, and when hitting enter on the file it opens it in `nvim`.

================================================
### `osx-cmds`

A list of commands to setup your Mac. It is a script, but I would recommend reading through the file and copying and pasting individual ones that you would want to use.

================================================
### `grm`, `index-gen`, & `post-receive`

`grm` is a git repo manager that I modified to fit my needs. It can create repos, list repos, recompile repos for `stagit`. See `grm -h` for help with all the commands.

For use on home machine:
```sh
alias grm='ssh git@host_name -- grm'
```

`post-receive` is a post-receive git hook that is ran after pushing a commit.

`index-gen` is used in combination with `grm` to generate an index.html file for my website.

================================================
### `rf`

Search directory for files using `rg` (ripgrep). This command is very similar to `fd`.

**Usage**: `rf <term>`

================================================
### `rglf`

Used in conjunction with `lf` to search a directory with `rg` and return the resuls in a `dialog` box.

**Usage**: set a mapping in lfrc file, or set a cmd like such:

```sh
cmd rglf $dialog --title "Search" --msgbox "$(rg --color=never ${1})" 40 80
```

================================================
### `santa-rules`

Blacklist or remove applications/rules with `santa-ctl`

================================================
### `tordone` & `transadd`

Taken from [Luke Smith](https://github.com/LukeSmithxyz/voidrice) and modified for macOS.

`transadd` will add a torrent to `transmission-remote`.

`tordone` is a script used in `transmission`'s settings to run when a torrent is finished.

================================================
### `update_block`

A script that updates block lists for `dnsmasq`, prints out the date the block list was updated, sets the DNS servers to `127.0.0.1` and `::1`, and then checks my website for DNSSEC validation by printing the flags needed for verification.

================================================
### `webpull`

Download a websites files to a local space.

**Usage**: `webpull <url>`

================================================
### `wim`

Open a script in `$EDITOR`

**Usage**: `wim <script_name>`

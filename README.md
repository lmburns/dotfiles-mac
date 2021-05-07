<h1 align="center">dotfiles</h1>

## Contents
+ [Colorscheme](#terminal-colors)
    + [iTerm Colorscheme](#iterm-color)
    + [Neovim Colorscheme](#neovim-color)
+ [Karabiner](#karabiner)
+ [skhd](#skhd)
+ [Neovim](#neovim)
    + [Neovim Keybindings](#neovim-keybindings)
    + [Neovim Functions](#neovim-functions)
+ [ZSH Functions](#zsh-functions)
+ [Scripts](#scripts)
    + [All Scripts](#all-scripts)
    + [More Complex Scripts](#complex-scripts)

There are several more configuration file than the ones listed in contents. These are the ones that have been configured the most.
---

## <a name="terminal-colors"></a>Colorschemes

### <a name="iterm-color"></a>iTerm Color
+ The actual colors may not match the displayed colors
+ The `iterm` theme file can be found [here](.config/iterm-colors/kimbie-dark.json)

#### Displayed Colors

| {back,fore}ground                                               | Red                                                             | Green                                                           | Yellow                                                          | Blue                                                            | Magenta                                                         | Cyan                                                            |
| --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- |
| #221a02                                                         | #f79a32                                                         | #088649                                                         | #f79a32                                                         | #733e8b                                                         | #7e5053                                                         | #088649                                                         |
| ![#221a02](https://via.placeholder.com/80/221a02/000000?text=+) | ![#f79a32](https://via.placeholder.com/80/f79a32/000000?text=+) | ![#088649](https://via.placeholder.com/80/088649/000000?text=+) | ![#f79a32](https://via.placeholder.com/80/f79a32/000000?text=+) | ![#733e8b](https://via.placeholder.com/80/733e8b/000000?text=+) | ![#7e5053](https://via.placeholder.com/80/7e5053/000000?text=+) | ![#088649](https://via.placeholder.com/80/088649/000000?text=+) |
| #c2a383                                                         | #f14a68                                                         | #a3b95a                                                         | #f79a32                                                         | #dc3958                                                         | #fe8019                                                         | #4c96a8                                                         |
| ![#c2a383](https://via.placeholder.com/80/c2a383/000000?text=+) | ![#f14a68](https://via.placeholder.com/80/f14a68/000000?text=+) | ![#a3b95a](https://via.placeholder.com/80/a3b95a/000000?text=+) | ![#f79a32](https://via.placeholder.com/80/f79a32/000000?text=+) | ![#dc3958](https://via.placeholder.com/80/dc3958/000000?text=+) | ![#fe8019](https://via.placeholder.com/80/fe8019/000000?text=+) | ![#4c96a8](https://via.placeholder.com/80/4c96a8/000000?text=+) |


### <a name="neovim-color"></a>Neovim Color

+ Theme: [kimbox](https://github.com/lmburns/kimbox)
+ Install with
```sh
Plug 'lmburns/kimbox'
colorscheme kimbox
```

#### Displayed Colors

| #39260E                                                         | #291804                                                         | #EF1D55                                                         | #DC3958                                                         | #FF5813                                                         | #FF9500                                                         | #819C3B                                                         |
| --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- |
| ![#39260E](https://via.placeholder.com/80/39260E/000000?text=+) | ![#291804](https://via.placeholder.com/80/291804/000000?text=+) | ![#EF1D55](https://via.placeholder.com/80/EF1D55/000000?text=+) | ![#DC3958](https://via.placeholder.com/80/DC3958/000000?text=+) | ![#FF5813](https://via.placeholder.com/80/FF5813/000000?text=+) | ![#FF9500](https://via.placeholder.com/80/FF9500/000000?text=+) | ![#819C3B](https://via.placeholder.com/80/819C3B/000000?text=+) |
| #7EB2B1                                                         | #4C96A8                                                         | #98676A                                                         | #A06469                                                         | #7F5D38                                                         | #A89984                                                         | #D9AE80                                                         |
| ![#7EB2B1](https://via.placeholder.com/80/7EB2B1/000000?text=+) | ![#4C96A8](https://via.placeholder.com/80/4C96A8/000000?text=+) | ![#98676A](https://via.placeholder.com/80/98676A/000000?text=+) | ![#A06469](https://via.placeholder.com/80/A06469/000000?text=+) | ![#7F5D38](https://via.placeholder.com/80/7F5D38/000000?text=+) | ![#A89984](https://via.placeholder.com/80/A89984/000000?text=+) | ![#D9AE80](https://via.placeholder.com/80/D9AE80/000000?text=+) |

---

## <a name="karabiner"></a>Karabiner

+ [karabiner](.config/karabiner/karabiner.json) configuration file

- Karabiner is a very useful utility on MacOS that allows for global keybindings.
- The keybindings that are there mimic Vim's functionality when holding caps lock.
- When <kbd>⇪ Caps lock</kbd> is held down it is mapped to:
  - <kbd>⌃ Control</kbd> + <kbd>⌥ Option</kbd> + <kbd>⌘ Command</kbd> + <kbd>⇧ Shift</kbd>
- When <kbd>⇪ Caps lock</kbd> is pressed it is mapped to <kbd>⎋ Escape</kbd>
- To get <kbd>⇪ Caps lock</kbd> you need to press left <kbd>⇧ Shift</kbd> then right <kbd>⇧ Shift</kbd>
- While holding <kbd>⇪ Caps lock</kbd>, pressing the following keys will do these actions:

<details>
<summary><b>Main Karabiner Mappings</b></summary>

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
<summary><b>Other Karabiner Mappings</b></summary>

| Other mappings                 | Action              |
|--------------------------------|---------------------|
| <kbd>Cmd</kbd> + <kbd>qq</kbd> | quit app            |
| <kbd>Cmd</kbd> + <kbd>ww</kbd> | close window of app |

</details>

The <kbd>⌥ Option</kbd> + <kbd>⌃ Control</kbd> + <kbd>Arrow</kbd> mappings are significant if you have this sequence mapped to changing tabs in iTerm.  I just find this a little easier to do instead of moving my fingers off of the home row.

----

## <a name="skhd"></a>skhd

+ [skhdrc](.config/skhd/skhdrc)
+ <kbd>Hyper</kbd> = <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Cmd</kbd> + <kbd>Shift</kbd>

<details>
<summary><b>Overall keybindings</b></summary>

| Keys                                                             | Action        |
|------------------------------------------------------------------|---------------|
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Cmd</kbd> + <kbd>r</kbd> | Restart yabai |
| <kbd>Hyper</kbd> + <kbd>Backspace</kbd>                          | Close window  |
| <kbd>L-Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>g</kbd>                | Toggle gaps   |

</details>

<details>
<summary><b>Swapping windows keybindings</b></summary>

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

</details>

<details>
<summary><b>Focusing windows keybindings</b></summary>

| Focusing                        |              |
|---------------------------------|--------------|
| <kbd>Alt</kbd> + <kbd>h</kbd>   | Focus west   |
| <kbd>Alt</kbd> + <kbd>j</kbd>   | Focus south  |
| <kbd>Alt</kbd> + <kbd>k</kbd>   | Focus north  |
| <kbd>Alt</kbd> + <kbd>l</kbd>   | Focus east   |
| <kbd>Hyper</kbd> + <kbd>a</kbd> | Focus recent |

</details>

<details>
<summary><b>Resizing windows keybindings</b></summary>

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

</details>

<details>
<summary><b>Floating windows keybindings</b></summary>

| Floating                                             |                            |
|------------------------------------------------------|----------------------------|
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>Space</kbd> | Toggle float               |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>c</kbd>     | Float & Center             |
| <kbd>Hyper</kbd> + <kbd>e</kbd>                      | Resize floating window     |
| <kbd>Hyper</kbd> + <kbd>1</kbd>                      | Float & keep same position |

</details>

<details>
<summary><b>Moving windows keybindings</b></summary>

| Moving Window                                    |                   |
|--------------------------------------------------|-------------------|
| <kbd>Hyper</kbd> + <kbd>f</kbd>                  | Fullscreen        |
| <kbd>Hyper</kbd> + <kbd>r</kbd>                  | Rotate 90 degrees |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>x</kbd> | Mirror x-axis     |
| <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>y</kbd> | Mirror y-axis     |

</details>

<details>
<summary><b>Window stacks keybindings</b></summary>

| Stacks                              |                                        |
|-------------------------------------|----------------------------------------|
| <kbd>Hyper</kbd> + <kbd>s</kbd>     | Toggle stack                           |
| <kbd>Hyper</kbd> + <kbd>m</kbd>     | Go to next window (in or out of stack) |
| <kbd>Hyper</kbd> + <kbd>n</kbd>     | Go to prev window (in or out of stack) |
| <kbd>Hyper</kbd> + <kbd>Space</kbd> | Toggle focus on stack                  |

</details>

----

## <a name="neovim"></a>Neovim

+ [init.vim](.config/nvim/init.vim)
+ **Leader**: `<Space>`

#### <a name="neovim-keybindings"></a>Neovim Keybindings

<details>
<summary><b>Keybindings</b></summary>

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
| <kbd>Leader</kbd> + <kbd>sr</kbd>     | replace what's under cursor             | n     |
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
| <kbd>Leader</kbd> + <kbd>ma</kbd>     | open vim magit (`git diff`s)              | n     |
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

</details>

#### <a name="neovim-functions"></a>Neovim Functions

<details>
<summary><b>Functions</b></summary>

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

</details>

---

### <a name="zsh-functions"></a>ZSH Functions

+ List of all `zsh` [functions](.config/zsh/functions) and their purpose
+ [`zshrc`](.config/zsh/.zshrc)
+ [`zshenv`](.zshev)
+ [`zsh-aliases`](.config/zsh/zsh-aliases)

```sh
 $ pflist                                                 【  ~/.conf/zs/functions】─╯
======================================================================================
@append_dir-history-var    helper function for per-dir-hist
@chwpd_dir-history-var     helper function for per-dir-hist
bcp                        delete (one or multiple) selected application(s)
bip                        brew install package fzf
bup                        update (one or multiple) selected application(s)
ccheat                     cheatsheet of cheat and tldr
cdown                      countdown timer
cfile                      copy contents of file to clipboard
chpwd_ls                   func ran on every cd
exchange                   swap files
fbd                        cd to selected parent directory
fcd                        change directories with fzf
fe                         open the selected file with the default editor
fenv                       search environment vars with fzf
ff                         mage commands to run
fgl                        figlet font selector
fif                        using ripgrep combined with preview
fjj                        autojump fzf
fjrnl                      search JRNL headlines
fkill                      interactively kill process with fzf
fpdf                       search directory for pdf and open in zathura
frd                        fzf recent directories
from-where                 tells from-where a zsh completion is coming from
fsearch                    search fonts on system
gkey                       print keyboard shortcuts to application (iteractive option)
gnubin_off                 removes gnubins from $PATH
gnubin_on                  adds gnubins to PATH
gsha                       show sha of branch
hgrep                      grep history
hist_stat                  zsh history stats
iso2dmg                    Converts file  (iso) to .dmg
listening                  listen on port entered
listports                  list open ports
lowercasecurdir            lowercase every file in current dir
manfind                    find location of manpage
mp3                        use youtube-dl to get audio
osx-ls-download-history    list download history
palette                    display colors
pblist                     lists mybin funcs with their embedded descriptions
pflist                     lists ZDOTDIR/functions/* with their embedded descriptions
printc                     escape code for colors
prompt_my_per_dir_status   helper function for per-dir-hist
rmhist                     remove a line from history
tab                        open new terminal tab in current dir
tms                        select selected tmux session
um                         wrapper to colorize um man pages
vf                         fuzzy open with vim from anywhere
vii                        open file interactively with twf
whichcomp                  tell which completion a command is using
whim                       edit script from path
zdr                        fzf-extras cd to parent directory
zicompinit_fast            faster & more efficient compinit
zman                       Searches zshall with special keyword () matching
zmanf                      Searches zshall with special keyword () matching
zsh-help                   easier way to access zsh manual - taken from ZSH
ztes                       Searches zshall with special keyword () matching
======================================================================================
```

---

## <a name="scripts"></a>[Scripts](mybin)

+ [All Scripts](#all-scripts)
+ [More Complex Scripts](#complex-scripts)

+ Can be found [here](mybin/)

### <a name="all-scripts"></a>All Scripts

```sh
 $ pblist                                                                              【  ~/mybin】─╯
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
backup_calcurse      bash      backup calcurse reminders
backup_crontab       sh        backup crontab
backup_pkgs          bash      backup packages from brew, cargo, gem, go, npm, pip
backup_task          sh        backup task folder
brew-pkg-size        bash      brew packages and their sizes
brew-why             bash      list all installed apps & dependencies
btc-price            bash      send email to myself of current bitcoin price
bunch_fzf            bash      bunch of
checkdns             bash      check dnsmas, stubby, and dns servers
clean-my-mac         bash      clean macos cache
compiler             sh        compiles various kinds of documents
cps                  zsh       when using a git alias for tracking dotfiles, send to multiple remotes
cryptocheck          sh        check crypocurrency prices
cryptonotify         zsh       send a notification of cryptocurrency prices
downl                sh        uses dragon to download files
fast-pp              bash      fast-p pdf finder source code
flist                bash      fzf view of script directory with descriptions
free                 python    get free memory like debian's 'free'
frm                  bash      fuzzy remove files (trash-put)
ftr                  zsh       fzf trash-restore
fzf_pdf              bash      search directory for pdfs, open with zathura
gclp                 bash      git clone from clipboard
glsha                bash      copy a git commits shasum
grm                  sh        git repo manager for self-hosted git servers
gstatd               sh        directory size information
guprj                bash      upload projects to google drive
gutxt                bash      upload text files to google drive
guwww                bash      upload server to google drive
harden               sh        harden a link (convert it to a singly linked file)
html5check.py        python3   check html5 syntax
image-mag-gen        sh        search for font files and add to imagemagick
index-gen            bash      generate template for my website when creating new repo
jupsync              sh        sync jupyter notebook and python file
killport             sh        kills all processes running on the specified port
launchd-creator      bash      generate launch daemon/agent
lctl                 bash      a launchctl wrapper
lf-chdir             bash      change directories with lf file manager
lf-select            sh        reads file names from stdin and selects them in lf
lf-updater-script    sh        update lf file manager
linkhandler          sh        handle urls and do some action
lockscreen           bash      lockscreen, change wallpaper
macho                sh        fzf man pages macOS
macho-pdf            sh        fzf man pages macOS - view in zathura
mailboxes_sync       sh        count mail with mutt
manp                 bash      view manpage in zathura
manp1                bash      output manpage and view in zathura
mbsync-hook          sh        mbsync hook
mbsync-pre-post      sh        mbsync pre-post hooks
mksc                 bash      generate a script in script directory
my-pinentry          bash      choose pinentry depending on PINENTRY_USER_DATA
newsb-notifier       sh        notifications for newsboat
not-touch-hd         sh        use something without it touching harddrive
notmuch-tagging.sh   bash      tag notmuch mail
nv                   bash      open most recently viewed files in nvim with fzf
open-mutt            bash      open neomutt in new iterm window
opout                sh        open output of file for vim
osx-cmds             bash      general rules for macos
passcomp.zsh         zsh       adds call to _pass-vera completion from _pass completion
perlii               perl
pfctl-rules          sh        manipulate pfctl firewall
port-scan            bash      performs port scan using nmap
post-receive         sh        generic git post-receive hook
ppkill               sh        interactive process killer
pretty_csv           bash      create a pretty csv
proxstat             bash      see if dnsmasq stuby privoxy are on
pzz                  bash      search directory for pdf and open in zathura
qndl                 sh        queue up tasks for urls
rclg                 sh        general rclone copier
remind               bash      add reminders from command line
rf                   sh        search directory for files using ripgrep (obsolte, used fd)
rga-fzf              bash      ripgrep preview matches with fzf
rgf                  bash      interactively search files with rg (with reload)
rgfa                 bash      interactively search for files (preview on size)
rglf                 bash      ripgrep search directory for lf file manager
rgn                  bash      interactively search files with rg (with reload) no preview
rmcrap               bash      deletes .DS_Store and __MACOSX directories
rotdir               sh        rotate image order with sxiv
rssadd               sh        add rss feed to newsboat
santa-rules          bash      whitelist/blacklist apps with santactl
santa-uninstall      bash      uninstall santa-ctl
shortcuts            sh        update all shortcuts when one file is updated
small_funcs          bash      list of all kinds of small functions to work on
srv-bkp              bash      backup server
srv-up               bash      backup server
synctask             bash      sync tasks from taskwarrior to Reminders.app
take                 zsh       create directory and cd into it
todos                sh        grep for vim comments
tomb                 bash      tomb but for macOS
tordone              bash      notifier of finished torrent
torque               bash      torque - minimal tui for transmission-daemon
transadd             bash      add torrent to transmission
trns                 zsh       transission wrapper
update_block         bash      update block lists
updb                 bash      updatedb for bash, macOS is sh which it is not
webpull              sh        make a local archive of an entire website
wim                  sh        open script in editor
yabai-codesign       bash      codesign yabai
ymld                 bash      parse a yaml file
zm                   zsh       search zshall more efficiently
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
```

### <a name="complex-scripts"></a>More Complex Scripts

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

---

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

---

### `rmcrap`

Deletes `.DS_Store` files and `__MACOSX` directories recursively.

#### Usage

```sh
Options:
    -s, --show     Show tree diagram of what rmcrap is removing
    -c, --count    Show count of .DS_Store and __MACOSX removed
```
---

### `cps`

Whenever you track your dotfiles with a git bare repo you are unable to use `xargs` to push changes to all remotes.

This is setup to work with something like:
```sh
alias c='/usr/bin/git --git-dir=$XDG_DATA_HOME/dotfiles --work-tree=$HOME'
```

The remote names can be changed.

**Usage**: `cps`

---

### `grm`, `index-gen`, & `post-receive`

`grm` is a git repo manager that I modified to fit my needs. It can create repos, list repos, recompile repos for `stagit`. See `grm -h` for help with all the commands.

For use on home machine:
```sh
alias grm='ssh git@host_name -- grm'
```

`post-receive` is a post-receive git hook that is ran after pushing a commit.

`index-gen` is used in combination with `grm` to generate an index.html file for my website.

---

### `update_block`

A script that updates block lists for `dnsmasq`, prints out the date the block list was updated, sets the DNS servers to `127.0.0.1` and `::1`, and then checks my website for DNSSEC validation by printing the flags needed for verification.

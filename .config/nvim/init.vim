"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|

call plug#begin("~/.vim/plugged")
  " Plugin Section
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vimwiki/vimwiki'
Plug 'zhou13/vim-easyescape'

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Coding plugin
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'jupyter-vim/jupyter-vim'
Plug 'PeterRincker/vim-searchlight'

" Show match number for incsearch
Plug 'itchyny/vim-highlighturl'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

" Statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'

" Html
" Plug 'mattn/emmet-vim'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-commentary'
Plug 'kevinoid/vim-jsonc'
Plug 'alvan/vim-closetag'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
Plug 'ap/vim-css-color'

"R
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
" Plug 'gaalcaras/ncm-R'

Plug 'jreybert/vimagit'

call plug#end()"Config Section

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" General Mappings

" Resetting cutting, instead use v/V x
let g:mapleader = "."
nnoremap d "_d
vnoremap d "_d
nnoremap Y y$

set nocompatible
set title
set encoding=utf-8
set clipboard+=unnamedplus
set tabstop=4
set shiftwidth=4
set ignorecase " smartcase " Ignore case but become case sensitive when uppercase
set number relativenumber " Show line number and relative line number

set cursorline " Show current line where cursor is
set mouse=a  " Enable mouse in several mode // acn
" set mousemodel=popup  " Set the behaviour of mouse

set undofile " Persistent undo
" set noswapfile
set backupdir=~/.vim/backups

" set foldmethod=marker
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme kimbie-black

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Enable autocompletion:
	" set wildmode=longest,list,full
	" set wildmenu

" Automatically deletes all tralling whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Open corresponding .pdf/.html or preview
	nmap <leader>p :w <Bar> !open %<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Compile rmarkdown
	autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
	autocmd Filetype rmd map <F6> :RMarkdown pdf latex_engine="xelatex", toc=TRUE<CR>

" Compile markdown
	autocmd FileType markdown nnoremap <buffer> <F4> !pandoc % --pdf-engine=xelatex -o %:r.pdf
	autocmd FileType md nnoremap <buffer> <F4> !pandoc % --pdf-engine=xelatex -o %:r.pdf


" Compile document, be it groff/LaTeX/markdown/etc.
	" map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Pandoc
     let g:pandoc#filetypes#handled = ["pandoc", "markdown"]

	command! -nargs=* RunSilent
		  \ | execute ':silent !'.'<args>'
		  \ | execute ':redraw!'
	nmap <Leader>pc :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
	nmap <Leader>pp :RunSilent open -a Preview /tmp/vim-pandoc-out.pdf<CR>


" Inserts a space above or below
nnoremap <silent> [<space>  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>

" Tabs & Navigation
map <leader>nt :tabnew<cr> 		" To create a new tab.
map <leader>to :tabonly<cr>     " To close all other tabs (show only the current tab).
map <leader>tc :tabclose<cr>    " To close the current tab.
map <leader>tm :tabmove<cr>     " To move the current tab to next position.
map <leader>tn :tabn<cr>        " To swtich to next tab.
map <leader>tp :tabp<cr>        " To switch to previous tab.

" Buffers
map <leader>bp :bprev<CR>
map <leader>bn :bnext<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let maplocalleader = ',' " For NVim-R

" Coc Coding
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" For json
autocmd FileType json syntax match Comment +\/\/.\+$+
" For coc-pairs
" autocmd FileType html let b:coc_pairs_disabled = ['`']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTREE
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
" nnoremap <silent> <C-b> :NERDTreeToggle<CR>
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

" junegunn - File Searching
" nnoremap <C-p> :FZF<CR>
map ; :Files<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" EasyEscape
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>
" Fix paste bug triggered by the above inoremaps
set t_BE=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Completion behaviour
" set completeopt+=noinsert  " Auto select the first completion entry
" set completeopt+=menuone  " Show menu even if there is only one item
" set completeopt-=preview  " Disable the preview window
" set pumheight=10  " Maximum number of items to show in popup menu

" Insert mode key word completion setting
" set complete+=kspell complete-=w complete-=b complete-=u complete-=t
set spelllang=en_us,cjk  " Spell languages
set spellsuggest+=10  " The number of suggestions shown in the screen for z=
nnoremap <silent> <F10> :set spell!<cr>
inoremap <silent> <F10> <C-O>:set spell!<cr>
" Ctrl+x followed by s = toggles it
" [s = previous spell error, ]s = next spell error
" zg = add word to spell list // z= correct error

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Running Python
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" imap <C-x> <Esc>:w<CR>:!clear;python %<CR>
" noremap <C-x> :w !python %<CR>
" inoremap <C-x> <ESC>:w !python %<CR>
let g:python_host_prog = '/Users/lucasburns/opt/anaconda3/bin/python'

" JupyterVim
if has('nvim')
    let g:python3_host_prog = '/Users/lucasburns/opt/anaconda3/bin/python'
else
    set pyxversion=3

    " OSX
    set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.6/Python
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-Livedown
nmap gm :LivedownToggle<CR>
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0
" should the browser window pop-up upon previewing
let g:livedown_open = 1
" the port on which Livedown server will run
let g:livedown_port = 1337
" the browser to use, can also be firefox, chrome or other, depending on your executable
let g:livedown_browser = "firefox"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NVim-R
" Autostart
autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif

" Run ;RStop // :RKill to quit

let R_assign_map = ';'
let r_syntax_folding = 1
let r_indent_op_pattern = '\(+\|-\|\*\|/\|=\|\~\|%\)$'
let R_rconsole_height = 10

" Press the space bar to send lines and selection to R console
" vmap <Space> <Plug>RDSendSelection
" nmap <Space> <Plug>RDSendLine

autocmd FileType r inoremap <buffer> > <Esc>:normal! a %>%<CR>a
autocmd FileType rnoweb inoremap <buffer> > <Esc>:normal! a %>%<CR>a
autocmd FileType rmd inoremap <buffer> > <Esc>:normal! a %>%<CR>

" let Rout_more_colors = 1
if has('gui_running') || &termguicolors
  let rout_color_input    = 'guifg=#9e9e9e'
  let rout_color_normal   = 'guifg=#f79a32'
  let rout_color_number   = 'guifg=#889b4a'
  let rout_color_integer  = 'guifg=#a3b95a'
  let rout_color_float    = 'guifg=#98676a'
  let rout_color_complex  = 'guifg=#fcaf00'
  let rout_color_negnum   = 'guifg=#d7afff'
  let rout_color_negfloat = 'guifg=#d6afff'
  let rout_color_date     = 'guifg=#4c96a8'
  let rout_color_true     = 'guifg=#088649'
  let rout_color_false    = 'guifg=#ff5d5e'
  let rout_color_inf      = 'guifg=#f06431'
  let rout_color_constant = 'guifg=#5fafcf'
  let rout_color_string   = 'guifg=#502166'
  let rout_color_error    = 'guifg=#ffffff guibg=#dc3958'
  let rout_color_warn     = 'guifg=#f14a68'
  let rout_color_index    = 'guifg=#d3af86'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Bracey
nmap <leader>br :Bracey<CR>
nmap <leader>r :BraceyReload<CR>



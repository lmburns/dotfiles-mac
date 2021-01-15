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

" Themes
Plug 'sainnhe/gruvbox-material'
" Plug 'hardcoreplayers/gruvbox9'
" Plug 'morhetz/gruvbox'

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Coding plugin
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
Plug 'jupyter-vim/jupyter-vim'

" Show match number for incsearch
Plug 'itchyny/vim-highlighturl'
Plug 'PeterRincker/vim-searchlight'

" Statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'

" Html
Plug 'shime/vim-livedown'
Plug 'tpope/vim-commentary'
Plug 'kevinoid/vim-jsonc'
Plug 'alvan/vim-closetag'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
Plug 'ap/vim-css-color'

"R
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

Plug 'jreybert/vimagit'
" Checkout vim notes

call plug#end()"Config Section

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" General Mappings
let g:mapleader = "."

" <F3> = turn on/off relative line numbers
" <F4> = compile markdown file using pandoc
" <F5> = compile rmarkdown based on `output`
" <F6> = compile rmarkdown (only pdf) using `RMarkdown`
" <F9> = compile python
" <F10> = spell check


" Make deleting line not go to clipbard
	nnoremap d "_d
	vnoremap d "_d
" Yank line without newline character
	nnoremap Y y$
" Make cut not go to clipboard
	nnoremap x "_dl

" set path+=**
set nocompatible
set title
set noswapfile
set encoding=utf-8
set clipboard+=unnamedplus
set tabstop=4 shiftwidth=4 expandtab
set ignorecase " smartcase " Ignore case // be sensitive when uppercase
set number " Show line number and relative line number
	nnoremap <silent><F3> :set relativenumber!<CR>

set scrolloff=2 " Cusor is 2 lines from bottom of page
set cursorline " Show current line where cursor is
set mouse=a  " Enable mouse in several mode // acn
" set mousemodel=popup  " Set the behaviour of mouse

set undofile " Persistent undo

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>
" Replace quotes on the line
    nmap <leader>Q :s/'/"/g<CR>

if (has("termguicolors"))
 set termguicolors
endif

syntax enable
" colorscheme kimbie-black
colorscheme gruvbox-material


" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Enable autocompletion:
	set wildmode=longest,list,full
	set wildmenu

" Automatically deletes all tralling whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e           " End of lines
    autocmd BufWritePre * %s#\($\n\s*\)\+\%$##e  " End of file


" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Open corresponding .pdf/.html or preview
	nmap <leader>p :w <Bar> !open %<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Compile rmarkdown
" NOTE: `,kp` compiles RMarkdown to PDF using NVim-R
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
    nmap <Leader>rc :!Rscript -e "rmarkdown::render('<c-r>%', output_file='render.pdf', output_dir='/tmp')"<CR>
	nmap <Leader>rp :RunSilent open -a Preview /tmp/render.pdf<CR>


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

" SyntaxQuery: Display the syntax stack at current cursor position
function! s:syntax_query() abort
  for id in synstack(line("."), col("."))
    execute 'hi' synIDattr(id, "name")
  endfor
endfunction
command! SQ call s:syntax_query()

" autocmd Syntax * syntax keyword INFO contained NOTE
" autocmd Syntax * syntax keyword INFO containedin=.*Comment
" autocmd Syntax * syntax keyword InfoMarker INFO containedin=.*Comment,vimLineComment,vimCommentTitle,rComment,rCommentTodo | highlight def link InfoMarker TODO
autocmd Syntax * syntax keyword INFO containedin=.*Comment,vimLineComment,vimCommentTitle,vimTodo,rComment,rTodoParen,rCommentTodo,pythonTodo,pythonComment
" autocmd Syntax * syntax keyword infocomm INFO containedin=.*Comment | highlight def link infocomm TODO
" autocmd Syntax * syntax keyword myTodo INFO NOTES containedin=ALL | highlight def link myTodo TODO
" autocmd Syntax * syntax keyword TodoMarker TODO containedin=.*Comment,vimCommentTitle,cCommentL

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
set completeopt+=menuone  " Show menu even if there is only one item
set completeopt-=preview  " Disable the preview window
set pumheight=10  " Maximum number of items to show in popup menu

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
" :g/^\s*#\sIn/d = delete nbconvert 'In[0]' lines
" :g/^$/,/./-j = delete multiple blank lines
let g:pymode_options_max_line_length=120
let g:syntastic_python_pylint_post_args="--max-line-length=120"


autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" imap <C-x> <Esc>:w<CR>:!clear;python %<CR>
" noremap <C-x> :w !python %<CR>
" inoremap <C-x> <ESC>:w !python %<CR>
" let g:python_host_prog = '/Users/lucasburns/opt/anaconda3/bin/python3'

if has('nvim')
    let g:python3_host_prog = '/Users/lucasburns/opt/anaconda3/bin/python3'
else
    set pyxversion=3
    set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.8/Python
endif

" JupyterVim
let g:pymode_lint_ignore = "E501,W"
" let g:vim_virtualenv_path = '/Users/lucasburns/opt/anaconda3'
" if exists('g:vim_virtualenv_path')
"     pythonx import os; import vim
"     pythonx activate_this = os.path.join(vim.eval('g:vim_virtualenv_path'), 'bin/activate_this.py')
"     pythonx with open(activate_this) as f: exec(f.read(), {'__file__': activate_this})
" endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox_material'

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

" Open shortcuts
nmap <Leader>rs :vs ~/JupyterNotebook/projects/RStudio/nvim-r.md<CR>


" Run ;RStop // :RKill to quit
let R_assign_map = ';'
let r_syntax_folding = 1
let r_indent_op_pattern = '\(+\|-\|\*\|/\|=\|\~\|%\)$'
let R_rconsole_height = 10
let R_csv_app = 'terminal:vd'

nmap <silent> <LocalLeader>t :call RAction("tail")<CR>
nmap <silent> <LocalLeader>H :call RAction("head")<CR>

" Press the space bar to send lines and selection to R console
" vmap <Space> <Plug>RDSendSelection
" nmap <Space> <Plug>RDSendLine

autocmd FileType r inoremap <buffer> > <Esc>:normal! a %>%<CR>a
autocmd FileType rnoweb inoremap <buffer> > <Esc>:normal! a %>%<CR>a
autocmd FileType rmd inoremap <buffer> > <Esc>:normal! a %>%<CR>

" Made iTerm2 send ✠ when pressing Shift+Enter
nnoremap <silent> ✠ :call SendLineToR("stay")<CR><Esc><Home><Down>
inoremap <silent> ✠ <Esc>:call SendLineToR("stay")<CR><Esc>A
vnoremap <silent> ✠ :call SendSelectionToR("silent", "stay")<CR><Esc><Esc>

let Rout_more_colors = 1
" let rout_follow_colorscheme = 1
" Kimbie
" if has('gui_running') || &termguicolors
"   let rout_color_input    = 'guifg=#9e9e9e'
"   let rout_color_normal   = 'guifg=#f79a32'
"   let rout_color_number   = 'guifg=#889b4a'
"   let rout_color_integer  = 'guifg=#a3b95a'
"   let rout_color_float    = 'guifg=#98676a'
"   let rout_color_complex  = 'guifg=#fcaf00'
"   let rout_color_negnum   = 'guifg=#d7afff'
"   let rout_color_negfloat = 'guifg=#d6afff'
"   let rout_color_date     = 'guifg=#4c96a8'
"   let rout_color_true     = 'guifg=#088649'
"   let rout_color_false    = 'guifg=#ff5d5e'
"   let rout_color_inf      = 'guifg=#f06431'
"   let rout_color_constant = 'guifg=#5fafcf'
"   let rout_color_string   = 'guifg=#502166'
"   let rout_color_error    = 'guifg=#ffffff guibg=#dc3958'
"   let rout_color_warn     = 'guifg=#f14a68'
"   let rout_color_index    = 'guifg=#d3af86'
" endif

" Gruvbox
if has('gui_running') || &termguicolors
  let rout_color_input    = 'guifg=#e2cca9'
  let rout_color_normal   = 'guifg=#d4be98'
  let rout_color_number   = 'guifg=#80aa9e'
  let rout_color_integer  = 'guifg=#8bba7f'
  let rout_color_float    = 'guifg=#d3869b'
  let rout_color_complex  = 'guifg=#e9b143'
  let rout_color_negnum   = 'guifg=#f28534'
  let rout_color_negfloat = 'guifg=#e78a4e'
  let rout_color_date     = 'guifg=#ea6962'
  let rout_color_true     = 'guifg=#b0b846'
  let rout_color_false    = 'guifg=#f2594b'
  let rout_color_inf      = 'guifg=#f28534'
  let rout_color_constant = 'guifg=#7daea3'
  let rout_color_string   = 'guifg=#266b79'
  let rout_color_error    = 'guifg=#d4be98 guibg=#d3869b'
  let rout_color_warn     = 'guifg=#fb4934'
  let rout_color_index    = 'guifg=#d3af86'
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Bracey
nmap <leader>br :Bracey<CR>
nmap <leader>r :BraceyReload<CR>

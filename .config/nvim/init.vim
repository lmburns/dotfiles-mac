"============================================================================
"    Author: Lucas Burns                                                   
"     Email: burnsac@me.com                                                
"      Home: https://github.com/lmburns                                    
"============================================================================
" vim: ft=vim:et:sts=2:sw=0:fdm=marker:fmr={{{,}}}:

" === Plugins === {{{
  set ttyfast
  set nocompatible

  call plug#begin("~/.vim/plugged")
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdtree'
  " Plug 'vifm/vifm.vim'
  Plug 'ptzz/lf.vim'
  " Plug 'junegunn/vim-journal'
  " Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/goyo.vim'
  Plug 'lervag/vimtex'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'plasticboy/vim-markdown'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'vimwiki/vimwiki'
  Plug 'SidOfc/mkdx'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  " Plug 'vim-pandoc/vim-rmarkdown'

  " Plug 'itchyny/lightline.vim'
  " Plug 'josa42/vim-lightline-coc'
  Plug 'zhou13/vim-easyescape'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-endwise'
  Plug 'itchyny/vim-highlighturl'
  Plug 'PeterRincker/vim-searchlight'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mhinz/vim-startify'
  Plug 'easymotion/vim-easymotion'

  Plug 'kassio/neoterm'
  Plug 'voldikss/vim-floaterm'

  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'jreybert/vimagit'
  Plug 'mbbill/undotree'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'antoinemadec/coc-fzf'
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
  Plug 'jpalardy/vim-slime', { 'for': 'python' }
  Plug 'vim-perl/vim-perl', { 'for': 'perl' }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'fatih/vim-go', { 'for': 'go' }
  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/nerdcommenter'
  " Plug 'tpope/vim-commentary'

  " HTML/CSS
  Plug 'shime/vim-livedown'
  Plug 'alvan/vim-closetag'
  " Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
  Plug 'ap/vim-css-color'
  Plug 'yggdroot/indentline'
  Plug 'folke/todo-comments.nvim'

  " Themes
  " Plug 'Rigellute/rigel'
  " Plug 'AlessandroYorba/Alduin'
  " Plug 'lifepillar/vim-gruvbox8'
  " Plug 'morhetz/gruvbox'
  Plug 'franbach/miramare'
  Plug 'ackyshake/Spacegray.vim'
  Plug 'gavinok/spaceway.vim'
  Plug 'bluz71/vim-nightfly-guicolors'
  Plug 'savq/melange'
  Plug 'ajmwagar/vim-deus'
  Plug 'lmburns/kimbox'
  Plug '1612492/github.vim'
  Plug 'nanotech/jellybeans.vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'sainnhe/gruvbox-material'
  Plug 'sainnhe/edge'
  Plug 'sainnhe/sonokai'
  Plug 'sainnhe/everforest'
  Plug 'joshdick/onedark.vim'
  Plug 'embark-theme/vim', { 'as': 'embark' }
  Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  Plug 'ghifarit53/daycula-vim' , {'branch' : 'main'}
  Plug 'ghifarit53/tokyonight-vim'
  Plug 'srcery-colors/srcery-vim'
  Plug 'wadackel/vim-dogrun'
  Plug 'glepnir/oceanic-material'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'KeitaNakamura/neodark.vim'
  Plug 'tyrannicaltoucan/vim-deep-space'

  Plug 'wfxr/minimap.vim'
  call plug#end()
" }}}  === Plugins ===

" =====================================================================
" =====================================================================

" Function Keys: {{{
  " <F1> = run shell script
  " <F2> = toggle wrap on and off
  " <F3> = turn on/off relative line numbers
  " <F4> = compile markdown file using pandoc
  " <F5> = compile rmarkdown based on `output`
  " <F6> = compile rmarkdown (only pdf) using `RMarkdown`
  " <F10> = spell check

  " g; / g, = previous/next insertion
  " ysiw' = add quotes around word
  " S' = in visual mode add quotes around
  " ds' = delete quotes

  " viwU = change to upper case
" }}} Function Keys

" === Theme Settings === {{{
  let mapleader = ' '
  let maplocalleader = ','

  let g:gruvbox_material_palette = 'mix'
  let g:gruvbox_material_background = 'hard'
  " let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_enable_bold = 1
  let g:gruvbox_material_current_word = 'grey background'
  let g:gruvbox_material_visual = 'grey background'

  " let g:kimbox_background = 'deep'
  " let g:kimbox_background = 'medium' " brown
  " let g:kimbox_background = 'darker' " dark dark purple
  " let g:kimbox_background = 'ocean' " dark purple
  let g:kimbox_allow_bold = 1

  let g:oceanic_material_background = "deep"
  " let g:oceanic_material_background = "ocean"
  let g:oceanic_material_allow_bold = 1

  let g:everforest_background = 'hard'
  let g:everforest_enable_italic = 1

  let g:material_theme_style = 'ocean-community'
  " let g:material_theme_style = 'darker-community'
  let g:material_terminal_italics = 1

  let g:spacegray_use_italics = 1

  let g:gruvbox_contrast_dark = 'medium'
  let g:sonokai_style = 'shusia'
  let g:edge_style = 'aura'

  set t_Co=256
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors

  set guifont=JetBrains\ Mono\ Bold\ Nerd\ Font\ Complete:h14
  " set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  " set guicursor=a:blinkon100
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
      \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
      \,sm:block-blinkwait175-blinkoff150-blinkon175

  syntax enable
  " colorscheme spaceduck
  " colorscheme kimbox
  " colorscheme material
  " colorscheme everforest
  colorscheme oceanic_material
  " colorscheme gruvbox-material
  " colorscheme jellybeans
  " colorscheme iceberg
  " colorscheme deus
  " colorscheme miramare
  " colorscheme nightfly
  " colorscheme melange
  " colorscheme onedark
  " colorscheme neodark
  " colorscheme deep-space
  " colorscheme spaceway    " needs work
  " colorscheme alduin      " needs work
  " colorscheme spacegray
  " edge sonokai tokyonight daycula srcery dogrun palenight

" }}} === Theme Settings ===

" === General Settings === {{{
  " UndoHistory: store undo history in a file. even after closing and reopening vim
  if has('persistent_undo')
    let target_path = expand('~/.config/vim-persisted-undo/')

    if !isdirectory(target_path)
      call system('mkdir -p ' . target_path)
    endif

    let &undodir = target_path
    set undofile
  endif

  if &modifiable
    set fileencoding=utf-8       " utf-8 files
    set fileformat=unix          " use unix line endings
    set fileformats=unix,dos     " try unix line endings before dos, use unix
  endif

  set background=dark
  set path+=**
  " set history=1000
  set lazyredraw
  set belloff=all                           " turn off bell
  set title
  set noshowmode                            " hide file, it's in airline
  set noshowcmd
  set noswapfile                            " no swap files
  set list lcs=tab:‣\ ,trail:•,nbsp:␣       " customize invisibles ‣\ »·
  set fillchars+=msgsep:\ ,vert:\│          " customize message separator
  set incsearch                             " incremential search highligh
  set encoding=utf-8
  set pumheight=10                          " number of items in popup menu
  set pumblend=10                           " transparent popup_menu
  set winblend=10                           " transparent floating window
  set hidden
  set nobackup
  set nowritebackup
  set magic
  set clipboard+=unnamedplus                " use system clipboard
  set splitbelow splitright                 " split screen below and right
  set tabstop=2 shiftwidth=0
  set expandtab softtabstop=2 smartindent
  set ignorecase smartcase
  set number
  set nostartofline
  set linebreak
  set wrap
  set whichwrap+=<,>,h,l
  set showmatch
  set matchtime=2
  set cmdheight=2
  set shortmess+=c
  set nofoldenable
  set foldmethod=marker
  set conceallevel=2
  set concealcursor-=n                    " cancel conceal on cursor line
  set scrolloff=5                         " cusor 5 lines from bottom of page
  set cursorline                          " show line where cursor is
  set mouse=a                             " enable mouse all modes
  set wildmode=full                       " autocompletion
  set wildmenu                            " autocompletion
  set wildignore+=.git,.DS_Store,node_modules
  set diffopt=vertical
  set synmaxcol=1000                      " do not highlight long lines
  set signcolumn=yes
  set timeoutlen=350                      " keycode delay
  set updatetime=100
  set confirm                             " confirm when editing readonly
  set noerrorbells
  set belloff=all
  filetype plugin indent on

  nnoremap <silent><F3> :set relativenumber!<CR>
  nnoremap <silent><F2> :set nowrap!<CR>

  " autocmd CursorHold * update
  " disable highlighting once leaving search
  " autocmd CmdlineEnter /,\? :set hlsearch
  " autocmd CmdlineLeave /,\? :set nohlsearch
" }}} === General Settings ===

" === General Mappings === {{{
  nnoremap q: <Nop>
  nnoremap q/ <Nop>
  nnoremap q? <Nop>
  nnoremap <Up> <Nop>
  nnoremap <Down> <Nop>
  nnoremap <Left> <Nop>
  nnoremap <Right> <Nop>

  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Qall qall

  noremap Q gq

  " replace command history with quit
  nmap Q: :q<Cr>
  command! -bang -nargs=* Q q

  " use qq to record, q to stop, Q to play a macro
  " nnoremap Q @q
  vnoremap Q :normal @q

  " easier navigation in normal / visual / operator pending mode
  noremap gkk   {
  noremap gjj   }
  noremap H     g^
  xnoremap H    g^
  noremap L     g_
  xnoremap L    g_

  " quit
  " noremap <C-c> :q<cr>
  " save write
  noremap <C-s> :update<cr>
  " save & quit
  " noremap <C-x> :x<cr>

  " save with root
  cnoremap W!! w !sudo tee % >/dev/null<cr>
  " cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

  " Replace all is aliased to S.
  nnoremap S :%s//g<Left><Left>
  " Replace under cursor
  nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/
  " Replace quotes on the line
  nnoremap <Leader>Q :s/'/"/g<CR>:nohlsearch<CR>
  " convert python 2 print to python3
  nnoremap <Leader>3 :%s/^\(\s*print\)\s\+\(.*\)/\1(\2)<CR>

  " use tab and shift tab to indent and de-indent code
  nnoremap <Tab>   >>
  nnoremap <S-Tab> <<
  vnoremap <Tab>   >><Esc>gv
  vnoremap <S-Tab> <<<Esc>gv
  inoremap <S-Tab> <C-d>

  " use `u` to undo, use `U` to redo, mind = blown
  nnoremap U <C-r>

  " make deleting line not go to clipbard
  nnoremap d "_d
  vnoremap d "_d
  " yank line without newline character
  nnoremap Y y$
  " make cut not go to clipboard
  nnoremap x "_x
  " delete line without newline character
  nnoremap E ^"_D
  " reselect the text that has just been pasted
  noremap gV `[v`]
  " select characters of line (no new line)
  nnoremap vv ^vg_
  " make visual yanks pace the cursor back where started
  vnoremap y ygv<Esc>
  " insert a space after current character
  " nnoremap <Leader>sa a<Space><ESC>h

  " inserts a line above or below
  nnoremap <expr> oo printf('m`%so<ESC>``', v:count1)
  nnoremap <expr> OO printf('m`%sO<ESC>``', v:count1)

  " move through folded lines
  nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
  nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

  " move selected text up down
  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  " move between windows
  map <C-j> <C-W>j
  imap <C-j> <C-W>j
  map <C-k> <C-W>k
  imap <C-k> <C-W>k
  map <C-h> <C-W>h
  map <C-l> <C-W>l

  " Using <SPACE> to fold or unfold
  nnoremap <silent> ff @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
  " nnoremap <silent> <SPACE><CR> zi
  nnoremap <silent><expr> fl &foldlevel ? 'zM' :'zR'

  " buffer switching
  nnoremap gt :bnext<CR>
  nnoremap gT :bprevious<CR>
  " new buffer
  nnoremap <leader>bn :enew<cr>
  " close buffer
  nnoremap <leader>bq :bp <bar> bd! #<cr>
  " close all buffers
  nnoremap <leader>bQ :bufdo bd! #<cr>
  " list buffers
  nnoremap <silent> <space>b :<C-u>Buffers<cr>

  " resize windows
  nnoremap + :vertical resize +5<CR>
  nnoremap - :vertical resize -5<CR>
  nnoremap s+ :resize +5<CR>
  nnoremap s- :resize -5<CR>

  " perform dot commands over visual blocks
  vnoremap . :normal .<CR>
  " goyo plugin makes text more readable when writing prose:
  map <Leader>G :Goyo \| set linebreak<CR>

  " set filetypes
  autocmd BufRead,BufNewFile calcurse-note*,~/.local/share/calcurse/notes/* set filetype=markdown
  autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
  autocmd BufRead,BufNewFile *.tex set filetype=tex
  autocmd FileType nroff setlocal wrap textwidth=85 colorcolumn=+1

  " for github - change tabs
  nnoremap <Leader>nt :setlocal noexpandtab<CR>
  xnoremap <Leader>re :retab!<CR>
  " close quickfix
  nnoremap <Leader>qc :cclose<CR>
  " toggle scrollbar

  " Enable Goyo by default for mutt writing
  " autocmd BufRead,BufNewFile neomutt-void* let g:goyo_width=80
  " autocmd BufRead,BufNewFile neomutt-void* :Goyo | set bg=light
  " autocmd BufRead,BufNewFile neomutt-void* map ZZ :Goyo\|x!<CR>
  " autocmd BufRead,BufNewFile neomutt-void* map ZQ :Goyo\|q!<CR>

  " automatically deletes all tralling whitespace on save.
  autocmd BufWritePre * %s/\s\+$//e            " End of lines
  autocmd BufWritePre * %s#\($\n\s*\)\+\%$##e  " End of file
  " :%s/<1b>\[[0-9;]*m//g                       " replace ANSI color codes

  " disables automatic commenting on newline
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " shellcheck
  nnoremap <Leader>sc :!shellcheck -x %<CR>
  nnoremap <F1> :!./%<CR>

  " open corresponding .pdf/.html or preview
  nmap <Leader>p :w <Bar> !open %<CR>

  autocmd BufWritePost bm-files,bm-dirs !shortcuts
  " noremap <Leader>ur :w<Home>silent <End> !urlview<CR>
  " }}} === General Mappings ===

  " === docs === {{{
  autocmd BufReadPre *.docx silent set ro
  autocmd BufEnter *.docx silent set modifiable
  autocmd BufEnter *.docx silent  %!pandoc --columns=78 -f docx -t markdown "%"
  autocmd BufWritePost *.docx :!pandoc -f markdown -t docx % > tmp.docx

  " autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout

  let g:zipPlugin_ext = '*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.xlam,*.xlsx,*.xlsm,*.xlsb,*.xltx,*.xltm,*.xlam,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'

  " autocmd BufReadPost *.odt :%!odt2txt %

  " autocmd BufReadPost *.odt silent %!pandoc "%" -tmarkdown -o /dev/stdout
  " autocmd BufWritePost *.odt :%!pandoc -f markdown "%" -o "%:r".odt

    autocmd BufReadPre *.odt silent set ro
    autocmd BufEnter *.odt silent  %!pandoc --columns=78 -f odt -t markdown "%"

  " insert template to blog post
  autocmd FileType markdown noremap <Leader>tg itags:<Space>macOS<CR>title:<CR>author:<Space>Lucas<Space>Burns<CR>date:<Space><C-r>=strftime('%F')<CR><CR>aside:<CR><CR>#

  " check html syntax
  nmap <Leader>h5 :!html5check %<CR>

  let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
  let g:pandoc#after#modules#enabled = ['vim-table-mode']
  let g:pandoc#syntax#codeblocks#embeds#langs=['c', 'python', 'sh', 'html', 'css']
  let g:pandoc#formatting#mode = 'h'
  let g:pandoc#modules#disabled = ['folding','formatting']
  let g:pandoc#syntax#conceal#cchar_overrides = {'codelang': ' '}

  " NOTE: `,kp` compiles RMarkdown to PDF using NVim-R
  autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
  autocmd FileType markdown nnoremap <buffer> <F4> !pandoc % --pdf-engine=xelatex -o %:r.pdf

  nmap <Leader>cp :w! <bar> !compiler %<CR>
  nmap <Leader>pr :!opout <c-r>%<CR><CR>
  autocmd VimLeave *.tex !texclear %
" }}} === General Mappings ===

  " === Syntax === {{{
  map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

  ":verbose hi <name>
  " SyntaxQuery: Display the syntax stack at current cursor position
  function! s:syntax_query() abort
    for id in synstack(line("."), col("."))
      execute 'hi' synIDattr(id, "name")
    endfor
  endfunction
  command! SQ call s:syntax_query()
  nnoremap <Leader>sll :syn list
  nnoremap <Leader>slo :verbose hi

  " custom syntax groups
  augroup ccommtitle
    autocmd!
    autocmd Syntax * syn match
      \ cmTitle /\v(#|--)\s*\u\w*(\s+\u\w*)*:/
      \ contained containedin=.*Comment,vimCommentTitle
    autocmd Syntax * syn match myTodo
      \ /\v(#|--|")\s(FIXME|FIX|DISCOVER|NOTE|NOTES|INFO|OPTIMIZE|XXX|EXPLAIN|TODO|CHECK|HACK|BUG|BUGS):/
      \ contained containedin=.*Comment.*,vimCommentTitle
    " perlLabel
    autocmd Syntax * syn keyword cmTitle contained=Comment
    autocmd Syntax * syn keyword myTodo contained=Comment
  augroup END
  hi def link cmLineComment Comment
  hi def link cmTitle vimCommentTitle
  hi def link myTodo Todo
" }}} === Syntax ===

" TODO:
" COMMENT: title

" === Other === {{{
  augroup jump_last_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
  augroup END

" E: create file with subdirectories if needed
  function s:MKDir(...)
    if !a:0
      \|| stridx('`+', a:1[0])!=-1
      \|| a:1=~#'\v\\@<![ *?[%#]'
      \|| isdirectory(a:1)
      \|| filereadable(a:1)
      \|| isdirectory(fnamemodify(a:1, ':p:h'))
      return
    endif
    return mkdir(fnamemodify(a:1, ':p:h'), 'p')
  endfunction

  command -bang -bar -nargs=? -complete=file EE :call s:MKDir(<f-args>) | e<bang> <args>
  command! -nargs=* T botright sp | resize 20 | term <args>
  command! -nargs=* VT vsp | term <args>
  " alt-1
  noremap  ¡ :T<cr>A

  " automatically reload buffer if changed outside current buffer
  augroup auto_read
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
      \ if mode() == 'n' && getcmdwintype() == '' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg
      \ | echo "File changed on disk. Buffer reloaded!" | echohl None
  augroup END

  " IndentSize: Change indent size depending on file type {{{
  function! <SID>IndentSize(amount)
    exe "setlocal expandtab"
       \ . " ts="  . a:amount
       \ . " sts=" . a:amount
  endfunction
  " }}} IndentSize

  " DiffSaved: Show diff since last save {{{
  function! s:DiffSaved()
    let filetype=&filetype
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe 'setl bt=nofile bh=wipe nobl noswf ro ft=' . filetype
  endfunction
  command! DS call s:DiffSaved()
  " }}} DiffSaved

  " ExecuteBuffer: execute current buffer === {{{ "
  function! s:execute_buffer()
    if !empty(expand('%'))
        write
        call system('chmod +x '.expand('%'))
        silent e
        vsplit | terminal ./%
    else
        echohl WarningMsg
        echo 'Save the file first'
        echohl None
    endif
  endfunction
  command! RUN :call s:execute_buffer()
  augroup ExecuteBuffer
      au!
      au FileType sh,bash,zsh,python,ruby nnoremap <Leader>ru :RUN<cr>
      au FileType sh,bash,zsh,python,ruby nnoremap <Leader>lru
        \ :FloatermNew --autoclose=0 ./%<cr>
  augroup END
  " }}} ExecuteBuffer

  " filetype specific indents
  autocmd FileType markdown,python,json,javascript call <SID>IndentSize(4)
  autocmd BufRead,BufNewFile *.htm,*.html call <SID>IndentSize(2)
  autocmd FileType r call <SID>IndentSize(2)
"}}} === Other ===

  " === Vim Wiki === {{{
  let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
  let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
  let g:vimwiki_table_mappings = 0

  " hi VimwikiHeader1 guifg=#cc241d gui=bold
  " hi VimwikiHeader2 guifg=#fe8019 gui=bold
  " hi VimwikiHeader3 guifg=#689d6a gui=bold
  " hi VimwikiHeader4 guifg=#b8ba25 gui=bold
  " hi VimwikiHeader5 guifg=#b16286 gui=bold
  " hi VimwikiHeader6 guifg=#458588 gui=bold

  hi VimwikiBold    guifg=#a25bc4 gui=bold
  hi VimwikiCode    guifg=#d3869b
  hi VimwikiItalic  guifg=#83a598 gui=italic

  hi VimwikiHeader1 guifg=#F14A68 gui=bold
  hi VimwikiHeader2 guifg=#F06431 gui=bold
  hi VimwikiHeader3 guifg=#689d6a gui=bold
  hi VimwikiHeader4 guifg=#819C3B gui=bold
  hi VimwikiHeader5 guifg=#98676A gui=bold
  hi VimwikiHeader6 guifg=#458588 gui=bold

  " hi MatchParen guifg=#088649
  " hi vimOperParen guifg=#088649
  " hi vimSep guifg=#088649
  " hi Delimiter guifg=#088649
  " hi Operator guifg=#088649

  map <Leader>vw :VimwikiIndex<CR>

  " bold shortcut for markdown
  autocmd FileType markdown inoremap ** ****<Left><Left>
  " <C-x> select pop up menu (vimwiki uses <enter> in to go to another page)
  autocmd FileType markdown inoremap <expr> <C-x> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"}}} === Vim Wiki ===

" === COC === {{{
  let g:python3_host_prog = '/Users/lucasburns/opt/anaconda3/bin/python3'
  let g:syntastic_python_pylint_post_args="--max-line-length=120"
  set pyxversion=3

  " prettier command for coc
  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  noremap <C-x><C-l> :CocFzfList<cr>
  nnoremap <silent> <Leader>y  :<C-u>CocList yank<cr>
  let g:coc_fzf_opts = ['--no-border', '--layout=reverse-list']
  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-diagnostic',
    \ 'coc-pairs',
    \ 'coc-yank',
    \ 'coc-prettier',
    \ 'coc-tabnine',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-python',
    \ 'coc-explorer',
    \ 'coc-vimtex',
    \ 'coc-go',
    \ 'coc-r-lsp',
    \ 'coc-vimlsp',
    \ 'coc-sh',
    \ 'coc-sql',
    \ 'coc-perl',
    \ 'coc-xml',
    \ 'coc-fzf-preview',
    \ 'coc-syntax',
    \ 'coc-git',
    \ 'coc-go',
    \ 'coc-rust-analyzer',
    \ ]

  let g:coc_explorer_global_presets = {
      \ 'config': {
      \   'root-uri': '~/.config',
      \   },
      \ 'projects': {
      \   'root-uri': '~/projects',
      \   },
      \ 'github': {
      \   'root-uri': '~/projects/github',
      \   },
      \ 'opt': {
      \   'root-uri': '~/opt',
      \   },
      \ }

  nmap <silent> <Leader>ee :CocCommand explorer<CR>
  nmap <silent> <Leader>ec :CocCommand explorer --preset config<CR>
  nmap <silent> <Leader>ep :CocCommand explorer --preset projects<CR>
  nmap <silent> <Leader>eg :CocCommand explorer --preset github<CR>
  nmap <silent> <Leader>eo :CocCommand explorer --preset opt<CR>
  nmap <silent> <Leader>ex :CocCommand explorer
  nmap <silent> <Leader>el :CocList explPresets<CR>

  function! ToggleCocExplorer() abort
    execute 'CocCommand explorer --toggle --sources file+ --width=30 ' . getcwd()
  endfunction
  nnoremap <silent> <C-\> :call ToggleCocExplorer()<CR>

  " use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " goto code navigation
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " remap for rename current word
  nmap <Leader>rn <Plug>(coc-rename)

  xmap <Leader>fm <Plug>(coc-format-selected)
  nmap <Leader>fm <Plug>(coc-format-selected)

  xmap <leader>w  <Plug>(coc-codeaction-selected)
  nmap <leader>w  <Plug>(coc-codeaction-selected)

  " remap for do codeAction of current line
  nmap <leader>wc  <Plug>(coc-codeaction)
  " fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " create mappings for function text object
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " coc-snippets
  " imap <C-j> <Plug>(coc-snippets-expand-jump)

  " use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')
  " use `:Fold` to fold current buffer
  command! -nargs=? Fold :call CocAction('fold', <f-args>)
  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

    let g:endwise_no_mappings = v:true
    inoremap <expr> <Plug>CustomCocCR "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

  " use K to show documentation in preview window.
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  " inoremap <silent><expr> <TAB>
  "     \ pumvisible() ? "\<C-n>" :
  "     \ <SID>check_back_space() ? "\<TAB>" :
  "     \ coc#refresh()
  " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " function! s:check_back_space() abort
  "   let col = col('.') - 1
  "   return !col || getline('.')[col - 1]  =~# '\s'
  " endfunction

  " Make <CR> auto-select the first completion item
  " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
  "                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Make <tab> auto-select the first completion item
  inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<tab>"

  " Use <c-space> to trigger completion
  inoremap <silent><expr> <C-m> coc#refresh()

  " position. Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

  " for json
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " coc-pairs
  augroup CocPairs
    autocmd!
    autocmd FileType markdown let b:coc_pairs_disabled = ['`', "'"]
    autocmd FileType vim,vifm let b:coc_pairs_disabled = ['"']
    autocmd FileType * let b:coc_pairs_disabled = ['<']
  augroup end
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
" }}} === COC ===

" vim-go {{{
" run and view go output in floating or split window
  function! s:run_go(...)
    if filereadable(expand("%:r"))
      call delete(expand("%:r"))
    endif
    write
    let arg = get(a:, 1, 0)
    if arg == "split"
      execute 'FloatermNew --autoclose=0 --wintype=vsplit --width=0.5 '
        \ . ' go build ./% && ./%:r'
    elseif arg == "float"
      execute 'FloatermNew --autoclose=0 go build ./% && ./%:r'
    endif
  endfunction
  command! GORUNS :call s:run_go("split")
  command! GORUN :call s:run_go("float")
  augroup GoRunCust
    autocmd!
    autocmd FileType go nnoremap <Leader>rv :GORUNS<CR>
    autocmd FileType go nnoremap <Leader>ru :GORUN<CR>
  augroup END
  " au FileType go nmap <Leader>rp <Plug>(go-run)
  " au FileType go nmap <Leader>rv <Plug>(go-run-vertical)

  function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
  endfunction

  augroup go_env
    autocmd!
    " Note: Do not change the order!
    " Note: Do not comment lines inplace
    " nmap <buffer> <Leader>K <Plug>(go-doc)|
    " let g:go_doc_popup_window = 1
    let g:go_rename_command = 'gopls'
    autocmd FileType go
      \ setl nolist|
      \ nmap <buffer> <Leader>b<CR> :call <SID>build_go_files()<CR>|
      \ nmap <buffer> <Leader>r<CR> <Plug>(go-run)|
      \ nmap <buffer> <Leader>rr    :GoRun %<CR>|
      \ nmap <buffer> <Leader>t<CR> <Plug>(go-test)|
      \ nmap <buffer> <Leader>c<CR> <Plug>(go-coverage-toggle)|
      \ nmap <buffer> <Leader>gae <Plug>(go-alternate-edit)|
      \ nmap <buffer> <Leader>i <Plug>(go-info)|
      \ nmap <buffer> <Leader>sm :GoSameIdsToggle<CR>|
      \ nmap <buffer> <c-a-j> :cnext<CR>|
      \ nmap <buffer> <c-a-k> :cprevious<CR>|
      \ nmap <buffer> <Leader>f :GoDeclsDir<cr>|
      \ let g:go_fmt_command = "goimports"|
      \ let g:go_list_type = "quickfix"|
      \ let g:go_highlight_types = 1|
      \ let g:go_highlight_fields = 1|
      \ let g:go_highlight_functions = 1|
      \ let g:go_highlight_methods = 1|
      \ let g:go_highlight_operators = 1|
      \ let g:go_highlight_build_constraints = 1|
      \ let g:go_highlight_generate_tags = 1|
      \ let g:go_gocode_propose_builtins = 1|
      \ let g:go_gocode_unimported_packages = 1|
      \ let g:go_doc_keywordprg_enabled = 0|
      \ let g:go_fmt_fail_silently = 1|
      \ command! -bang A call go#alternate#Switch(<bang>0, 'edit')|
      \ command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')|
      \ command! -bang AS call go#alternate#Switch(<bang>0, 'split')|
      "\ let g:go_auto_type_info = 1|
      "\ let g:go_updatetime = 100|
      "\ let g:go_auto_sameids = 1|
      "\ let g:go_play_open_browser = 1|
  augroup END
" }}} vim-go

" vim-rust {{{
augroup rust_env
    autocmd!
    autocmd FileType rust
      \ nmap     <silent> <c-]>         <Plug>(coc-definition)|
      \ nmap     <buffer> <Leader>r<CR> :VT cargo run   -q<CR>|
      \ nmap     <buffer> <Leader>t<CR> :RustTest<CR>|
      \ nmap     <buffer> <Leader>b<CR> :VT cargo build -q<CR>|
      \ nmap     <buffer> <Leader>r<CR> :VT cargo play  %<CR>|
      \ nnoremap <buffer> <c-a-l>       :RustFmt<cr>
augroup END
" }}} vim-rust

" === NERDTREE === {{{
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeIgnore = []
  let g:NERDTreeStatusline = ''
  let g:NERDTreeHijackNetrw = 0
  let g:NERDTreeDirArrowExpandable = '❱'
  let g:NERDTreeDirArrowCollapsible = '❰'

  let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'

  let NERDTreeMapActivateNode = 'l'         " default o
  let NERDTreeMapOpenInTab = 't'            " default t
  let NERDTreeMapOpenSplit = 'gs'           " default i
  let NERDTreeMapOpenVSplit = 'gv'          " default s
  let NERDTreeMapOpenExpl = 'e'             " default e
  let NERDTreeMapUpdir = 'h'                " default u
  let NERDTreeMapUpdirKeepOpen = 'H'        " default U
  let NERDTreeMapToggleHidden = '.'         " default I

  " automaticaly close nvim if NERDTree is only thing left open
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " toggle
  map <Leader>nn :NERDTreeToggle<CR>
  map <Leader>nb :NERDTreeFromBookmark
  map <Leader>nf :NERDTreeFind<CR>
" }}}  === NERDTREE ===

  " === FZF & Ripgrep === {{{
  command! -bang Colors
    \ call fzf#vim#colors(g:fzf_vim_opts, <bang>0)
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>,
    \ fzf#vim#with_preview(g:fzf_vim_opts, 'right:60%:default'), <bang>0)
  command! -bang Buffers
    \ call fzf#vim#buffers(
    \ fzf#vim#with_preview(g:fzf_vim_opts, 'right:60%:default'), <bang>0)
  command! -bang -complete=dir -nargs=? LS
    \ call fzf#run(fzf#wrap({'source': 'ls', 'dir': <q-args>}, <bang>0))
  command! -bang Conf
    \ call fzf#vim#files('~/.config', <bang>0)
  command! -bang Proj
    \ call fzf#vim#files('~/projects', fzf#vim#with_preview(), <bang>0)

  " command! -bang -nargs=* Rg
  "   \ call fzf#vim#grep(
  "   \   'rg --column --line-number --no-heading '
  "     \ . '--color=always --smart-case -- '.shellescape(<q-args>), 1,
  "   \   fzf#vim#with_preview(g:fzf_vim_opts, 'right:60%:default'), <bang>0)

    " prevent from searching for file names as well
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
      \ 'rg --column --line-number --hidden --smart-case '
        \ . '--no-heading --color=always '
        \ . shellescape(<q-args>),
        \ 1,
        \ {'options':  '--delimiter : --nth 4..'},
        \ 0)

  " RG with preview
  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading '
      \ . '--color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options':
      \ ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1,
      \ fzf#vim#with_preview(spec, 'right:60%:default'), a:fullscreen)
  endfunction

  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

  " dotbare (dotfile manager) - edit file
  command! Dots call fzf#run(fzf#wrap({
  \ 'source': 'dotbare ls-files --full-name --directory "${DOTBARE_TREE}" '
    \ . '| awk -v home="${DOTBARE_TREE}/" "{print home \$0}"',
  \ 'sink': 'e',
  \ 'options': [ '--multi', '--preview', 'cat {}' ]
  \ }))

  function! s:plug_help_sink(line)
    let dir = g:plugs[a:line].dir
    for pat in ['doc/*.txt', 'README.md']
      let match = get(split(globpath(dir, pat), "\n"), 0, '')
      if len(match)
        execute 'tabedit' match
        return
      endif
    endfor
    tabnew
    execute 'Explore' dir
  endfunction

  command! PlugHelp call fzf#run(fzf#wrap({
    \ 'source': sort(keys(g:plugs)),
    \ 'sink':   function('s:plug_help_sink')}))

  " Line completion (same as :Bline)
  " imap <C-a> <C-x><C-l>
  imap <C-x><C-z> <Plug>(fzf-complete-line)
  inoremap <expr> <C-x><c-d> fzf#vim#complete('cat /usr/share/dict/words')

    " word completion popup
  inoremap <expr> <C-x><C-w> fzf#vim#complete#word({
    \ 'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

  " word completion window
  inoremap <expr> <C-x><C-a> fzf#vim#complete({
    \ 'source':  'cat /usr/share/dict/words',
    \ 'options': '--multi --reverse --margin 15%,0',
    \ 'left':    20})

  " clipboard manager -- unsure why a direct mapping doesn't work
  inoremap <expr> <C-x><C-b> fzf#vim#complete({
    \ 'source': 'copyq eval -- "for(i=size(); i>0; --i) print(str(read(i-1)) + \"\n\");"',
    \ 'options': '--no-border',
    \ 'reducer': { line -> substitute(line[0], '^ *[0-9]\+ ', '', '') },
    \ 'window': 'call FloatingFZF()'})

  function! s:create_float(hl, opts)
    let buf = nvim_create_buf(v:false, v:true)
    let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:'.a:hl)
    call setwinvar(win, '&colorcolumn', '')
    return buf
  endfunction

  function! FloatingFZF()
    " Size and position
    let width = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.6)
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)

    " Border
    let top = '┏━' . repeat('─', width - 4) . '━┓'
    let mid = '│'  . repeat(' ', width - 2) .  '│'
    let bot = '┗━' . repeat('─', width - 4) . '━┛'
    let border = [top] + repeat([mid], height - 2) + [bot]

    " Draw frame
    let s:frame = s:create_float('Comment', {'row': row, 'col': col, 'width': width, 'height': height})
    call nvim_buf_set_lines(s:frame, 0, -1, v:true, border)

    " Draw viewport
    call s:create_float('Normal', {'row': row + 1, 'col': col + 2, 'width': width - 4, 'height': height - 2})
    augroup fzf_floating
        au!
        au BufWipeout <buffer> execute 'bwipeout' s:frame
    augroup END
  endfunction

  " :Commands -- :GFiles? -- :Commits
  " change directory to buffers dir
  nnoremap <Leader>cd :lcd %:p:h<CR>
  nnoremap <Leader>L :Locate .<CR>
  nnoremap <Leader>rg :RG<CR>
  nnoremap <C-f> :Rg<CR>
  nnoremap <silent> <Leader>a :Buffers<CR>
  nnoremap <silent> <Leader>A :Windows<CR>
  nnoremap <silent> <Leader>; :BLines<CR>
  nnoremap <silent> <Leader>F :Files<CR>
  nnoremap <silent> <Leader>gf :GFiles<CR>
  " command history
  nnoremap <silent> <Leader>hc :History:<CR>
  " file history
  nnoremap <silent> <Leader>hf :History<CR>
  " search history
  nnoremap <silent> <Leader>hs :History/<CR>
  nnoremap <silent> <Leader>cs :Colors<CR>
  nnoremap <silent> <Leader>si :Snippets<CR>
  nnoremap <silent> <Leader>ls :LS<CR>
  nnoremap <silent> <Leader>ht :Helptags<CR>
  nnoremap <silent> <Leader>cm :Commands<CR>
  nnoremap <silent> <Leader>mp :Maps<CR>

  nmap <C-l>m <plug>(fzf-maps-n)
  xmap <C-l>m <plug>(fzf-maps-x)
  imap <C-l>m <plug>(fzf-maps-i)
  omap <C-l>m <plug>(fzf-maps-o)

  " hide status and ruler for fzf
  au FileType fzf
    \ set laststatus& laststatus=0 |
    \ au BufLeave <buffer> set laststatus&

  " let $SKIM_DEFAULT_COMMAND = "git ls-tree -r --name-only HEAD || rg --files
  " let g:rg_command = 'rg --vimgrep --hidden'
  let g:rg_highlight = 'true'
  let g:rg_format = '%f:%l:%c:%m,%f:%l:%m'
  " let g:fzf_preview_window = ''
  let g:fzf_history_dir = '~/.local/share/fzf-history'
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
  " let g:fzf_layout         = { 'down': '~40%' }
  let g:fzf_vim_opts = {'options': ['--no-border']} "
  let g:fzf_buffers_jump = 1
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit',
    \ 'ctrl-m': 'edit',
    \}
" }}} === FZF & Ripgrep ===

" === VimFugitive === {{{
nnoremap <Leader>gs :G<CR>3j
nnoremap <Leader>gq :G<CR>:q<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gh :diffget //2<CR>
nnoremap <Leader>gl :diffget //3<CR>
nnoremap <Leader>gp :Git push<CR>
" }}} === VimFugitive ===

" === EasyMotion === {{{
  " move forward characters
  " map f <Plug>(easymotion-bd-f)
  " nmap f <Plug>(easymotion-overwin-f)
  " move forward line vim-sneak
  nmap s <Plug>(easymotion-overwin-f2)
  map <Leader><Leader>. <Plug>(easymotion-repeat)

  map <Leader><Leader>l <Plug>(easymotion-lineforward)
  map <Leader><Leader>j <Plug>(easymotion-j)
  map <Leader><Leader>k <Plug>(easymotion-k)
  map <Leader><Leader>h <Plug>(easymotion-linebackward)

  map <Leader>/ <Plug>(easymotion-bd-w)
  nmap <Leader>/ <Plug>(easymotion-overwin-w)
  map  <Leader><Leader>/ <Plug>(easymotion-sn)
  omap <Leader><Leader>/ <Plug>(easymotion-tn)

  let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
"}}} === EasyMotion ===

" === EasyEscape === {{{
  imap jk <ESC>
  imap kj <ESC>

  let g:easyescape_chars = { "j": 1, "k": 1 }
  let g:easyescape_timeout = 100
  cnoremap jk <ESC>
  cnoremap kj <ESC>
  " inoremap JK <ESC>
  " inoremap KJ <ESC>
  " tnoremap jk <C-\><C-n>
  " tnoremap kj <C-\><C-n>

  " Fix paste bug triggered by the above inoremaps
  set t_BE=
" }}} === EasyEscape ===

" === Spell Check === {{{
  set completeopt+=menuone,preview
  set complete+=kspell complete-=w complete-=b complete-=u complete-=t
  set spelllang=en_us
  set spellsuggest+=10
  set spellfile=~/.config/nvim/spell/en.utf-8.add
  " nnoremap <silent> <F10> :set spell!<cr>
  " inoremap <silent> <F10> <C-O>:set spell!<cr>
  noremap <Leader>ss :setlocal spell!<CR>
  noremap <Leader>sn ]s
  noremap <Leader>sp [s
  noremap <Leader>sa zg
  noremap <Leader>s? z=
  augroup spell
    autocmd!
    autocmd FileType text,markdown,gitcommit setlocal spell
    autocmd BufRead,BufNewFile neomutt-void* setlocal spell
  augroup END
" }}} === Spell Check ===

" === Airline === {{{
  set laststatus=2
  let g:airline_powerline_fonts = 1
  let g:airline_section_b = ' %{strftime("%I:%M")}'
  " let g:airline_section_z = '☰ %3l/%L:%3v'
  let g:airline_skip_empty_sections=1
  let g:airline_highlighting_cache = 1
  let g:airline_detect_spell=0
  " let g:airline_section_warning = ''
  " let g:airline_section_error = ''
  let g:airline#extensions#tabline#enabled = 2
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#tab_nr_type = 0
  let g:airline#extensions#tabline#show_tab_type = 0 " shows buffer etc
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

  let g:airline_extensions = ['branch', 'tabline', 'fzf']
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
  let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
  " let g:airline#extensions#tabline#show_tabs = 0
  " let g:airline#extensions#hunks#enabled = 0
  let g:airline_theme='srcery'
  " let g:airline_theme='gruvbox_material'
  " let g:airline_theme='everforest'
  " let g:airline_theme='oceanic_material'
  let g:gruvbox_material_statusline_style='mix'
" }}} === Airline ===

" === UndoTree === {{{
  nnoremap <Leader>ut :UndotreeToggle<CR>

  let g:undotree_RelativeTimestamp = 1
  let g:undotree_ShortIndicators = 1
  let g:undotree_HelpLine = 0
  let g:undotree_WindowLayout = 2
"}}} === UndoTree ===

" === Vimagit === {{{
  noremap  <Leader>ma :MagitO<Cr>
" }}} === Vimagit ===

" === gitgutter === {{{
  nmap ) <Plug>(GitGutterNextHunk)
  nmap ( <Plug>(GitGutterPrevHunk)
  let g:gitgutter_enabled = 1
  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_linenrs = 1
"}}} === gitgutter ===

" === vim surround === {{{
  nmap <Leader>ci cs`*
  nmap <Leader>o ysiw
  nmap mlw yss`
"}}} === vim surround ===

" === Vim-Livedown === {{{
  nmap gm :LivedownToggle<CR>
  " should markdown preview get shown automatically upon opening markdown buffer
  let g:livedown_autorun = 0
  " should the browser window pop-up upon previewing
  let g:livedown_open = 1
  " the port on which Livedown server will run
  let g:livedown_port = 1337
  " the browser to use, can also be firefox, chrome or other, depending on your executable
  let g:livedown_browser = "firefox"
" }}} === Vim-Livedown ===

" === Bracey === {{{
  nmap <Leader>br :Bracey<CR>
  nmap <Leader>bR :BraceyReload<CR>
" }}} === Bracey ===

" === Startify === {{{
  " Don't change to directory when selecting a file
  let g:webdevicons_enable_startify = 1
  let g:startify_files_number = 5
  let g:startify_change_to_dir = 0
  let g:startify_custom_header = [ ]
  let g:startify_relative_path = 1
  let g:startify_use_env = 1
  let g:startify_update_oldfiles = 1

  function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

" same as above, but show untracked files, honouring .gitignore
  function! s:gitTracked()
    let files = systemlist('git --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
  endfunction

  function! s:explore()
    sleep 350m
    call execute('CocCommand explorer')
  endfunction

  function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
  endfunction

  "   \  { 'type':  function('s:explore'), 'header':    ['coc']},

  " Custom startup list, only show MRU from current directory/project
  let g:startify_lists = [
  \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
  \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
  \  { 'type': 'commands',  'header': [ 'Commands' ]       },
  \  { 'type': 'files',     'header': ['MRU'] },
  \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
  \  { 'type':  function('s:gitModified'),  'header': ['git modified']},
  \  { 'type':  function('s:gitTracked'), 'header': ['git untracked']}
  \ ]

  let g:startify_commands = [
  \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
  \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
  \   { 'uc': [ 'Update CoC Plugins', ':CocUpdate' ] },
  \   { 'vd': [ 'Make Wiki Entry', ':VimwikiMakeDiaryNote' ] },
  \   { 'ce': [ 'Start CocExplorer', ':CocCommand explorer' ]}
  \ ]

  let g:startify_bookmarks = [
      \ { 'co': '~/.config/nvim/init.vim' },
      \ { 'gc': '~/.config/git/config' },
      \ { 'lc': '~/.config/lf/lfrc' },
      \ { 'zs': '~/.config/zsh/zshrc' },
      \ { 'za': '~/.config/zsh/zsh-aliases' },
      \ { 'vi': '~/vimwiki/index.md' },
      \ { 'vib': '~/vimwiki/scripting/index.md'}
  \ ]

  nmap <Leader>st :Startify<cr>
  " autoload startify
  " autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Startify | endif
" }}} === Startify ===

" === NVim-R === {{{
  " Autostart
  autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
  autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif

  " Open shortcuts
  nmap <Leader>rs :vs ~/projects/r/rstudio/nvim-r.md<CR>

  " Run ;RStop // :RKill to quit
  let R_auto_start = 1                                   " Autostart R when opening .R
  let R_assign_map = ';'                                 " Convert ';' into ' <-
  let r_syntax_folding = 1
  let r_indent_op_pattern = '\(+\|-\|\*\|/\|=\|\~\|%\)$' " Indent automatically
  let R_rconsole_height = 10                             " Console height
  let R_csv_app = 'terminal:vd'                          " Use visidata to view dataframes
  let R_nvimpager = 'tab'                                " Use Vim to see R documentation
  let R_open_example = 1                                 " Use Vim to display R examples
  let g:Rout_prompt_str = '$ '                           " Start of R command prompt
  let g:Rout_continue_str = '... '                       " Symbol for R string continuation
  " let R_specialplot = 1                                  " nvim.plot() instead of plot()
  let R_commented_lines = 0                              " Don't send commented lines to term
  let R_openpdf = 1                                      " Automatically open PDFs
  let R_pdfviewer = "zathura"                            " PDF viewer
  let R_close_term = 1                                   " Close terminal when closing vim
  let R_objbr_place = 'RIGHT'                            " Location of object browser
  " let R_external_term = 1                                " OSX use R.app graphical
  " let R_applescript = 1                                  " OSX use R.app graphical

  nmap <silent> <LocalLeader>t :call RAction("tail")<CR>
  nmap <silent> <LocalLeader>H :call RAction("head")<CR>

  " Press the space bar to send lines and selection to R console
  " vmap <Space> <Plug>RDSendSelection
  " nmap <Space> <Plug>RDSendLine

  autocmd FileType r inoremap <buffer> > <Esc>:normal! a %>%<CR>a
  autocmd FileType rnoweb inoremap <buffer> > <Esc>:normal! a %>%<CR>a
  autocmd FileType rmd inoremap <buffer> > <Esc>:normal! a %>%<CR>

  " Made iTerm2 send ✠ when pressing Shift+Enter
  autocmd FileType r nnoremap <silent> ✠ :call SendLineToR("stay")<CR><Esc><Home><Down>
  autocmd FileType r inoremap <silent> ✠ <Esc>:call SendLineToR("stay")<CR><Esc>A
  autocmd FileType r vnoremap <silent> ✠ :call SendSelectionToR("silent", "stay")<CR><Esc><Esc>

  let Rout_more_colors = 1                                " Make terminal output more colorful
  let r_indent_align_args = 0
  " let rout_follow_colorscheme = 1

" === Kimbie === {{{
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
" }}} === Kimbie ===
" }}} === NVim-R ===

" === Defualt Terminal === {{{
  let g:term_buf = 0
  let g:term_win = 0
  function! TermToggle(height)
      if win_gotoid(g:term_win)
          hide
      else
          botright new
          exec "resize " . a:height
          try
              exec "buffer " . g:term_buf
          catch
              call termopen("bash", {"detach": 0})
              let g:term_buf = bufnr("")
              set nonumber
              set norelativenumber
              set signcolumn=no
          endtry
          startinsert!
          let g:term_win = win_getid()
      endif
  endfunction

  " Toggle terminal on/off (neovim)
  nnoremap <C-t> :call TermToggle(12)<CR>
  inoremap <C-t> <Esc>:call TermToggle(12)<CR>
  tnoremap <C-t> <C-\><C-n>:call TermToggle(12)<CR>

  " Terminal go back to normal mode
  tnoremap <Esc> <C-\><C-n>
  tnoremap :q! <C-\><C-n>:q!<CR>
" }}} === Defualt Terminal ===

" === lf === {{{
  let g:lf_map_keys = 0
  nnoremap <Leader>lf :Lf<CR>
  let g:lf_replace_netrw = 1
" }}} === lf ===

" === Floaterm === {{{
  autocmd FileType floaterm,coc-explorer :MinimapToggle
  nnoremap <Leader>slf :FloatermNew --height=0.6 --wintype=split lf<CR>
  nnoremap <Leader>flf :FloatermNew --height=0.9 --width=0.9 lf<CR>
  command! LG FloatermNew --width=0.8 --height=0.8 lazygit
  let g:floaterm_wintype = 'float'
  let g:floaterm_height=0.8
  let g:floaterm_width=0.8
" }}}  === Floaterm ===

" === Neoterm === {{{
  let g:neoterm_default_mod='belowright' " open terminal in bottom split
  let g:neoterm_size=14                  " terminal split size
  let g:neoterm_autoscroll=1             " scroll to the bottom
  nnoremap <Leader>rf :T ipython --no-autoindent --colors=Linux --matplotlib<CR>
  nnoremap <Leader>rr :Tclear<CR>
  nnoremap <Leader>rt :Ttoggle<CR>
  nnoremap <Leader>ro :Ttoggle<CR> :Ttoggle<CR>
  au FileType python,perl nnoremap <silent> ✠ TREPLSendLine<CR><Esc><Home><Down>
  au FileType python,perl inoremap <silent> ✠ <Esc>:TREPLSendLine<CR><Esc>A
  au FileType python,perl xnoremap <silent> ✠ :TREPLSendSelection<CR><Esc><Esc>
"}}} === Neoterm ===

" === Vim-Slime === {{{
  let g:slime_target = "neovim"
  autocmd FileType python,perl xmap <buffer> ,l <Plug>SlimeRegionSend
  autocmd FileType python,perl nmap <buffer> ,l <Plug>SlimeLineSend
  autocmd FileType perl nmap <buffer> ,l <Plug>SlimeLineSend
  autocmd FileType python,perl nmap <buffer> ,p <Plug>SlimeParagraphSend
" }}} === Vim-Slime ===

" === Vim-LSP === {{{
  let g:markdown_fenced_languages = [
        \ 'vim',
        \ 'help'
        \]
"}}} === Vim-LSP ===

" === Vim Commentary === {{{
  " autocmd FileType hjson setlocal commentstring=#\ %s
"}}} === Vim Commentary ===

" === Mkdx === {{{
  let g:polygot_disabled = ['markdown']
  let g:mkdx#settings     = {
        \ 'restore_visual': 1,
        \ 'gf_on_steroids': 1,
        \ 'highlight': { 'enable':   1 },
        \ 'enter':     { 'shift':    1 },
        \ 'map':       { 'prefix': 'm', 'enable': 1 },
        \ 'links':     { 'external': { 'enable': 1 } },
        \ 'checkbox':  {'toggles': [' ', 'x', '-'] },
        \ 'tokens':    { 'strike': '~~',
        \                'list': '*' },
        \ 'fold':      { 'enable':   1,
        \                'components': ['toc', 'fence'] },
        \ 'toc': {
        \    'text': 'Table of Contents',
        \    'update_on_write': 1,
        \    'details': { 'nesting_level': 0 }
        \ }
        \ }

  function! <SID>MkdxGoToHeader(header)
    call cursor(str2nr(get(matchlist(a:header, ' *\([0-9]\+\)'), 1, '')), 1)
  endfunction

  function! <SID>MkdxFormatHeader(key, val)
    let text = get(a:val, 'text', '')
    let lnum = get(a:val, 'lnum', '')

    if (empty(text) || empty(lnum)) | return text | endif
    return repeat(' ', 4 - strlen(lnum)) . lnum . ': ' . text
  endfunction

  function! <SID>MkdxFzfQuickfixHeaders()
    let headers = filter(
          \ map(mkdx#QuickfixHeaders(0),function('<SID>MkdxFormatHeader')),
          \ 'v:val != ""'
          \ )

    call fzf#run(fzf#wrap({
          \ 'source': headers,
          \ 'sink': function('<SID>MkdxGoToHeader')
          \ }))
  endfunction

  augroup markdown
    autocmd!
    " Include dash in 'word'
    autocmd FileType markdown setlocal iskeyword+=-
  augroup END

  if (!$VIM_DEV)
    " when not developing mkdx, use fancier <leader>I which uses fzf
    " instead of qf to jump to headers in markdown documents.
    nnoremap <silent> <Leader>I :call <SID>MkdxFzfQuickfixHeaders()<Cr>
  endif

  nnoremap <Leader>mcs :vs ~/vimwiki/dotfiles/mkdx.md<CR>
  nnoremap <Leader>mdm :menu Plugin.mkdx<CR>
  nnoremap <Leader>ev :e $VIMRC<CR>
  nnoremap <Leader>sv :so $VIMRC<CR>
" }}} === Mkdx ===

" === Hack to make CocExplorer hijack Netwr === {{{
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
"     \ execute 'CocCommand explorer' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" }}} === CocExplorer hack ===

" === vim-table-mode === {{{
  let g:table_mode_map_prefix = '<Leader>t'
  let g:table_mode_realign_map = '<Leader>tr'
  let g:table_mode_delete_row_map = '<Leader>tdd'
  let g:table_mode_delete_column_map = '<Leader>tdc'
  let g:table_mode_insert_column_after_map = '<Leader>tic'
  let g:table_mode_echo_cell_map = '<Leader>t?'
  let g:table_mode_sort_map = '<Leader>ts'
  let g:table_mode_tableize_map = '<Leader>tt'
  let g:table_mode_tableize_d_map = '<Leader>T'           " visual mode

  " <Leader>tt    =

  let g:table_mode_tableize_auto_border = 1
  " let g:table_mode_corner_corner='+'
  " let g:table_mode_header_fillchar='='
  let g:table_mode_corner='|'
  let g:table_mode_fillchar = '-'
  let g:table_mode_separator = '|'
" }}} === vim-table-mode ===

" === vifm === {{{
  " let g:vifm_replace_netrw = 1
  " let g:vifm_replace_netrw_cmd = "Vifm"
  " let g:vifm_embed_term = 1
  " let g:vifm_embed_split = 1

  " let g:vifm_exec_args =
" }}} === vifm ===

" === vimtex === {{{
  let g:vimtex_view_method = 'zathura'
  let g:tex_flavor='latex'
  " let g:vimtex_compiler_latexmk = {
  "       \ 'executable' : 'latexmk',
  "       \ 'options' : [
  "       \   '-xelatex',
  "       \   '-file-line-error',
  "       \   '-synctex=1',
  "       \   '-interaction=nonstopmode',
  "       \ ],
  "       \}
  augroup vimrc
    autocmd!
    autocmd InsertEnter *.tex set conceallevel=0
    autocmd InsertLeave *.tex set conceallevel=2
    autocmd BufEnter *.tex set concealcursor-=n
  augroup END
  "}}} === vimtex ===

" === UltiSnips === {{{
let g:UltiSnipsExpandTrigger='<Leader><tab>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'
let g:UltiSnipsListSnippets="<C-u>"
let g:UltiSnipsEditSplit='horizontal'
" autocmd Filetype snippet set shiftwidth=4
" }}} ==== UltiSnips ===

" === NERDComment === {{{
let NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
" vim registers <C-/> as <C-_>
nnoremap <C-_> :call NERDComment(0, "toggle")<CR>j
vnoremap <C-_> :call NERDComment(0, "toggle")<CR>'>j
" copy & comment
nnoremap <Leader>cc yyP<c-_>
vnoremap <Leader>cc yPgp<c-_>
map gc :call NERDComment(0, "toggle")<CR>
nmap gcc :call NERDComment(0, "toggle")<CR>
map gcy :call NERDComment(0, "yank")<CR>
nmap <Leader>gcy :call NERDComment(0, "yank")<CR>
" }}} === NERDComment ===

" === Easy Align === {{{
let g:easy_align_delimiters = {
  \ '>': { 'pattern': '>>\|=>\|>' },
  \ '\': { 'pattern': '\\' },
  \ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
  \ ']': {
  \     'pattern':       '\]\zs',
  \     'left_margin':   0,
  \     'right_margin':  1,
  \     'stick_to_left': 0
  \   },
  \ ')': {
  \     'pattern':       ')\zs',
  \     'left_margin':   0,
  \     'right_margin':  1,
  \     'stick_to_left': 0
  \   },
  \ 'f': {
  \     'pattern': ' \(\S\+(\)\@=',
  \     'left_margin': 0,
  \     'right_margin': 0
  \   },
  \ 'd': {
  \     'pattern': ' \ze\S\+\s*[;=]',
  \     'left_margin': 0,
  \     'right_margin': 0
  \   }
  \ }
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
xmap <Leader>ga <Plug>(LiveEasyAlign)
" }}} === Easy Align ===

source ~/.config/nvim/indentline.vim

" === minimap === {{{
nnoremap <Leader>mm :MinimapToggle<CR>
let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
let g:minimap_highlight_range = 1
let g:minimap_block_filetypes = ['fugitive', 'nerdtree', 'tagbar', 'coc-explorer']
let g:minimap_close_filetypes = ['startify', 'netrw', 'vim-plug']
" }}}

" === todo-comments-vim === {{{
lua << EOF
  require("todo-comments").setup {
  signs = true,
  keywords = {
    FIX = {
      icon = " ",
      color = "#ea6962",
      alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" },
    },
    TODO = { icon = " ", color = "#d16d9e" },
    HACK = { icon = " ", color = "#d8a657" },
    WARN = { icon = " ", color = "#EC5f67", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "#a7c777", "PERFORMANCE", "OPTIMIZE", "FUNCTION" } },
    NOTE = { icon = " ", color = "#62b3b2", alt = { "INFO", "NOTES", "SUBSECTION" } },
    CHECK = { icon = "", color = "#e78a4e", alt = { "EXPLAIN", "DISCOVER", "SECTION" } },
  },
  highlight = {
    before = "",
    keyword = "bg", -- wide
    after = "fg",
  },
}
EOF
" }}} === todo-comments-vim ===

"=== make background transparent === {{{
  " highlight Normal guibg=none ctermbg=NONE
  highlight NonText guibg=none
  highlight LineNr guibg=none
  highlight SignColumn guibg=none
  highlight TrailingWhitespace ctermfg=0 guifg=Black ctermbg=8 guibg=#41535B
  highlight EndOfBuffer guibg=NONE ctermbg=NONE guifg=Black ctermfg=0
" }}} === transparent ===

" Todo: 'pattern' is deprectaed. Please refer to the documentation and use 'highlight.pattern' and 'search.pattern' instead.

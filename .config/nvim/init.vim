"  __   __     ______     ______     __   __   __     __    __
" /\ "-.\ \   /\  ___\   /\  __ \   /\ \ / /  /\ \   /\ "-./  \
" \ \ \-.  \  \ \  __\   \ \ \/\ \  \ \ \'/   \ \ \  \ \ \-./\ \
"  \ \_\\"\_\  \ \_____\  \ \_____\  \ \__|    \ \_\  \ \_\ \ \_\
"   \/_/ \/_/   \/_____/   \/_____/   \/_/      \/_/   \/_/  \/_/

" 
" Plugins {{{
  set ttyfast
  set nocompatible

  call plug#begin("~/.vim/plugged")
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'plasticboy/vim-markdown'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'vimwiki/vimwiki'
  Plug 'SidOfc/mkdx'
  Plug 'junegunn/goyo.vim'
  Plug 'vifm/vifm.vim'
  " Plug 'vim-pandoc/vim-rmarkdown'

  Plug 'zhou13/vim-easyescape'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'itchyny/vim-highlighturl'
  Plug 'PeterRincker/vim-searchlight'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mhinz/vim-startify'
  Plug 'easymotion/vim-easymotion'

  Plug 'kassio/neoterm'
  Plug 'voldikss/vim-floaterm'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'mattn/vim-gist'
  Plug 'jreybert/vimagit'
  Plug 'mbbill/undotree'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'jpalardy/vim-slime', { 'for': 'python' }
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
  Plug 'sheerun/vim-polyglot'                     " More syntax highlighting

  " HTML/CSS
  Plug 'shime/vim-livedown'
  Plug 'tpope/vim-commentary'
  Plug 'alvan/vim-closetag'
  Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
  Plug 'ap/vim-css-color'
  Plug 'yggdroot/indentline'

  " Themes
  Plug 'burnsac5040/kimbox'
  Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
  Plug 'sainnhe/gruvbox-material'
  Plug 'sainnhe/edge'
  Plug 'sainnhe/sonokai'
  Plug 'sainnhe/forest-night'
  Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'embark-theme/vim', { 'as': 'embark' }
  Plug 'ghifarit53/daycula-vim' , {'branch' : 'main'}
  Plug 'ghifarit53/tokyonight-vim'
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  Plug 'srcery-colors/srcery-vim'
  Plug 'wadackel/vim-dogrun'
  Plug 'glepnir/oceanic-material'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'KeitaNakamura/neodark.vim'
  Plug 'tyrannicaltoucan/vim-deep-space'

  call plug#end()
" }}}

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

  " :!tac = reverse line order
  " viwU = change to upper case
" }}}

" === Theme Settings === {{{
  let mapleader = ' '
  let maplocalleader = ','                      " For NVim-R

  let g:gruvbox_material_palette = 'original'
  " let g:gruvbox_material_background = 'hard'
  let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_enable_bold = 1
  let g:kimbox_background = 'medium'
  let g:kimbox_allow_bold = 1
  " let g:oceanic_material_background = "deep"
  let g:oceanic_material_background = "ocean"
  let g:oceanic_material_allow_bold = 1
  let g:gruvbox_contrast_dark = 'medium'
  let g:sonokai_style = 'shusia'
  let g:edge_style = 'aura'
  let g:material_theme_style = 'ocean-community'
" }}}

" === General 'set'tings === {{{
  " UndoHistory: store undo history in a file. even after closing and reopening vim
  if has('persistent_undo')
    let target_path = expand('~/.config/vim-persisted-undo/')

    if !isdirectory(target_path)
      call system('mkdir -p ' . target_path)
    endif

    let &undodir = target_path
    set undofile
  endif

  set t_Co=256
  set termguicolors                " enable termguicolors for better highlighting
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  syntax enable
  " colorscheme spaceduck
  " colorscheme kimbox
  " colorscheme oceanic_material
  colorscheme gruvbox-material
  " colorscheme edge
  " colorscheme sonokai
  " colorscheme forest-night
  " colorscheme onedark
  " colorscheme embark
  " colorscheme daycula
  " colorscheme tokyonight
  " colorscheme material
  " colorscheme srcery
  " colorscheme dogrun
  " colorscheme neodark
  " colorscheme palenight
  set background=dark
  set path+=**
  set lazyredraw
  set belloff=all                     " turn off bell
  set title
  set noshowmode                      " hide file, it's in airline
  set noshowcmd
  set noswapfile                      " no swap files
  set list lcs=tab:‣\ ,trail:•,nbsp:␣ " customize invisibles
  set fillchars+=msgsep:\ ,vert:\│    " customize message separator in neovim
  set incsearch                       " incremential search highligh
    nnoremap <silent><F7> :set nohlsearch!<CR>
  set encoding=utf-8
  set magic
  set clipboard+=unnamedplus          " use system clipboard
  set splitbelow splitright           " split screen below and right
  set tabstop=2 shiftwidth=0
  set expandtab softtabstop=2 smartindent
  set ignorecase smartcase
  set number
    nnoremap <silent><F3> :set relativenumber!<CR>

  set wrap
    nnoremap <silent><F2> :set nowrap!<CR>
  set nofoldenable
  set foldmethod=marker
  set scrolloff=5                      " cusor 5 lines from bottom of page
  set cursorline                       " show line where cursor is
  set mouse=a                          " enable mouse all modes
  set wildmode=longest,list:full       " Autocompletion
  set wildmenu                         " Autocompletion
  set wildignore+=.git,.DS_Store,node_modules
  " set nowrap                            " do not wrap text at `textwidth`
  set synmaxcol=1000                    " do not highlight long lines
  " set timeoutlen=250                    " keycode delay
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  set confirm                           " confirm when editing readonly
  filetype plugin indent on
" }}}

" === General Mappings === {{{
  " easier navigation in normal / visual / operator pending mode
  noremap gkk     {
  noremap gjj     }
  noremap H     g^
  xnoremap H    g^
  noremap L     g_
  xnoremap L    g_

  " save using <C-s> in every mode
  " when in operator-pending or insert, takes you to normal mode
  nnoremap <C-s> :write<Cr>
  vnoremap <C-s> <C-c>:write<Cr>
  inoremap <C-s> <Esc>:write<Cr>
  onoremap <C-s> <Esc>:write<Cr>

  " Replace all is aliased to S.
  nnoremap S :%s//g<Left><Left>
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
  " insert a space after current character
  nnoremap <Leader>sa a<Space><ESC>h

  " replace command history with quit
  nmap q: :q<Cr>
  nmap Q: :q<Cr>
  command! -bang -nargs=* Q q

  " use qq to record, q to stop, Q to play a macro
  nnoremap Q @q
  vnoremap Q :normal @q

  " inserts a line above or below
  nnoremap <expr> oo printf('m`%so<ESC>``', v:count1)
  nnoremap <expr> OO printf('m`%sO<ESC>``', v:count1)

  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall

  " smart way to move between windows
  map <C-j> <C-W>j
  imap <C-j> <C-W>j
  map <C-k> <C-W>k
  imap <C-k> <C-W>k
  map <C-h> <C-W>h
  map <C-l> <C-W>l

  " move through folded lines
  nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
  nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

  " perform dot commands over visual blocks
	vnoremap . :normal .<CR>
  " goyo plugin makes text more readable when writing prose:
	map <Leader>G :Goyo \| set linebreak<CR>

  " set filetypes
  autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
  autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
  autocmd BufRead,BufNewFile *.tex set filetype=tex

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
  autocmd FileType * setlocal formatoptions-=cro

  " shellcheck
  nnoremap <Leader>sc :!shellcheck -x %<CR>
  nnoremap <F1> :!./%<CR>

  " open corresponding .pdf/.html or preview
  nmap <Leader>p :w <Bar> !open %<CR>

  autocmd BufWritePost bm-files,bm-dirs !shortcuts
  " noremap <Leader>ur :w<Home>silent <End> !urlview<CR>

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
  " }}}

  " Compile rmarkdown / markdown
  " NOTE: `,kp` compiles RMarkdown to PDF using NVim-R
  autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
  autocmd FileType markdown nnoremap <buffer> <F4> !pandoc % --pdf-engine=xelatex -o %:r.pdf

  " insert template to blog post
  autocmd FileType markdown noremap <Leader>r itags:<Space>macOS<CR>title:<CR>author:<Space>Lucas<Space>Burns<CR>date:<Space><C-r>=strftime('%F')<CR><CR>aside:<CR><CR>#

  " check html syntax
  nmap <Leader>h5 :!html5check %<CR>
" }}}

" === Pandoc === {{{
   let g:pandoc#filetypes#handled = ["pandoc", "markdown"]

  command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'

  nmap <Leader>pc :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
  nmap <Leader>pp :RunSilent open -a Preview /tmp/vim-pandoc-out.pdf<CR>
  nmap <Leader>rc :!Rscript -e "rmarkdown::render('<c-r>%', output_file='render.pdf', output_dir='/tmp')"<CR>
  nmap <Leader>rp :RunSilent open -a Preview /tmp/render.pdf<CR>

  nmap <Leader>c :w! \| !compiler "<c-r>%<CR>"
" }}}

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

  " Custom syntax groups
  augroup vimTodo
    au!
    au Syntax * syn match myTodo /\v<(FIXME|NOTE|NOTES|INFO|OPTIMIZE|XXX):/
          \ containedin=.*Comment,vimCommentTitle
  augroup END
  hi def link myTodo Todo

  " Have vimCommentTitle for python (#) and sql (--)
  augroup ccommtitle
    au!
    au Syntax * syn match cmTitle /\(#\|--\)\s*\%([sS]:\|\h\w*\(#\|--\)\)\=\u\w*\(\s\+\u\w*\)*:/
        \ containedin=vimCommentTitle
  augroup END
  hi def link cmTitle vimCommentTitle
" }}}

" === Other Functions === {{{
" E: create file with subdirectories if needed
  function s:MKDir(...)
      if         !a:0
             \|| stridx('`+', a:1[0])!=-1
             \|| a:1=~#'\v\\@<![ *?[%#]'
             \|| isdirectory(a:1)
             \|| filereadable(a:1)
             \|| isdirectory(fnamemodify(a:1, ':p:h'))
          return
      endif
      return mkdir(fnamemodify(a:1, ':p:h'), 'p')
  endfunction
  command -bang -bar -nargs=? -complete=file E :call s:MKDir(<f-args>) | e<bang> <args>

  " Automatically reload buffer if changed outside current buffer
  augroup auto_read
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
          \ if mode() == 'n' && getcmdwintype() == '' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg
          \ | echo "File changed on disk. Buffer reloaded!" | echohl None
  augroup END

  " IndentSize: Change indent size depending on file type
  function! <SID>IndentSize(amount)
      exe "setlocal expandtab"
         \ . " ts="  . a:amount
         \ . " sts=" . a:amount
  endfunction

  " FileType specific indents
  autocmd FileType markdown,python,json,javascript call <SID>IndentSize(4)
  autocmd BufRead,BufNewFile *.htm,*.html call <SID>IndentSize(2)
  autocmd FileType r call <SID>IndentSize(2)
"}}}

" =====================================================================
" =====================================================================

  " === Vim Wiki === {{{
  let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
  let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
  let g:vimwiki_table_mappings = 0

  hi VimwikiHeader1 guifg=#448488 gui=bold
  hi VimwikiHeader2 guifg=#d3859a gui=bold
  hi VimwikiHeader3 guifg=#8ec07b gui=bold
  hi VimwikiHeader4 guifg=#fabc2e gui=bold
  hi VimwikiHeader5 guifg=#b8ba25 gui=bold
  hi VimwikiHeader6 guifg=#fb4833 gui=bold
  hi VimwikiBold    guifg=#a25bc4 gui=bold

  map <Leader>vw :VimwikiIndex<CR>

  " Toggle [ ] todo list items
  autocmd FileType markdown nmap <Leader><Leader>m <Plug>VimwikiToggleListItem
  " Bold shortcut for markdown
  autocmd FileType markdown inoremap ** ****<Left><Left>
  " <C-x> select pop up menu (vimwiki uses <enter> in to go to another page)
  autocmd FileType markdown inoremap <expr> <C-x> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"}}}

" =====================================================================
" =====================================================================

" === COC === {{{
  let g:python3_host_prog = '/Users/lucasburns/opt/anaconda3/bin/python3'
  let g:syntastic_python_pylint_post_args="--max-line-length=120"
  set pyxversion=3

  set hidden
  set nobackup
  set nowritebackup
  set cmdheight=2
  set updatetime=300
  set shortmess+=c
  set signcolumn=yes

  " prettier command for coc
  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  let g:coc_global_extensions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-prettier',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-json',
    \ 'coc-pyright',
    \ 'coc-python',
    \ 'coc-explorer',
    \ 'coc-vimtex',
    \ 'coc-r-lsp',
    \ 'coc-vimlsp',
    \ 'coc-sh',
    \ 'coc-tsserver',
    \ 'coc-git',
    \ 'coc-sql'
    \ ]

  let g:coc_global_extensions += ['https://github.com/andys8/vscode-jest-snippets']

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
  nmap <silent> <Leader> ex :CocCommand explorer
  nmap <silent> <Leader>el :CocList explPresets

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Remap for rename current word
  nmap <Leader>rn <Plug>(coc-rename)

  xmap <Leader>fm <Plug>(coc-format-selected)
  nmap <Leader>fm <Plug>(coc-format-selected)

  xmap <leader>w  <Plug>(coc-codeaction-selected)
  nmap <leader>w  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>wc  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Create mappings for function text object, requires document symbols feature of languageserver.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use <c-space> to trigger completion
  inoremap <silent><expr> <c-c> coc#refresh()

  " position. Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

  " For json
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " For coc-pairs
  autocmd FileType * let b:coc_pairs_disabled = ['<']
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

" }}}

" =====================================================================
" =====================================================================

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

  " Automaticaly close nvim if NERDTree is only thing left open
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " toggle
  map <Leader>nn :NERDTreeToggle<CR>
  map <Leader>nb :NERDTreeFromBookmark
  map <Leader>nf :NERDTreeFind<CR>
" }}}

  " === FZF & Ripgrep === {{{
  " :History/ -- :Maps -- :Commands -- :GFiles -- :GFiles?
  " let g:rg_command = 'rg --vimgrep --hidden'
  let g:rg_highlight = 'true'
  let g:rg_format = '%f:%l:%c:%m,%f:%l:%m'

  command! -bang Conf call fzf#vim#files('~/.config', <bang>0)
  " command! -bang Proj call fzf#vim#files('~/projects', fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
  command! -bang Proj call fzf#vim#files('~/projects', fzf#vim#with_preview(), <bang>0)

  " word completion popup
  inoremap <expr> <c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

  " word completion window
  inoremap <expr> <c-a> fzf#vim#complete({
    \ 'source':  'cat /usr/share/dict/words',
    \ 'options': '--multi --reverse --margin 15%,0',
    \ 'left':    20})

  " prevent from searching for file names as well
  command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
        \ 'rg --column --line-number --hidden --smart-case '
          \ . '--no-heading --color=always '
          \ . shellescape(<q-args>),
          \ 1,
          \ {'options':  '--delimiter : --nth 4..'},
          \ 0)

  " dotbare (dotfile manager) - edit file
  command! Dots call fzf#run(fzf#wrap({
  \ 'source': 'dotbare ls-files --full-name --directory "${DOTBARE_TREE}" | awk -v home="${DOTBARE_TREE}/" "{print home \$0}"',
  \ 'sink': 'e',
  \ 'options': [ '--multi', '--preview', 'cat {}' ]
  \ }))


  " Line completion (same as :Bline)
  imap <C-a> <C-x><C-l>
  imap <C-f> <Plug>(fzf-complete-line)

  nnoremap <silent> <Leader>F :Files<CR>
  nnoremap <silent> <Leader>gf :GFiles<CR>
  nnoremap <Leader>L :Locate .<CR>
  nnoremap <C-f> :Rg<CR>

  nnoremap <silent> <Leader>a :Buffers<CR>
  nnoremap <silent> <Leader>A :Windows<CR>
  " Lines in current buffer
  nnoremap <silent> <Leader>; :BLines<CR>
  " Command history
  nnoremap <silent> <Leader>hc :History:<CR>
  " File history
  nnoremap <silent> <Leader>hf :History<CR>
  " Mappings
  nnoremap <silent> <Leader>mm :Maps<CR>

  " let g:fzf_preview_window = ''
  let g:fzf_layout         = { 'down': '~40%' }
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'
    \}
" }}}

" =====================================================================
" =====================================================================

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
"}}}

" === EasyEscape === {{{
  let g:easyescape_chars = { "j": 1, "k": 1 }
  let g:easyescape_timeout = 100
  cnoremap jk <ESC>
  cnoremap kj <ESC>
  " tnoremap jk <C-\><C-n>
  " tnoremap kj <C-\><C-n>

  " Fix paste bug triggered by the above inoremaps
  set t_BE=
" }}}

" =====================================================================
" =====================================================================

" === Spell check === {{{
  " set completeopt+=noinsert  " Auto select the first completion entry
  set completeopt+=menuone,preview  " Show menu even if there is only one item
  " set completeopt-=preview  " Disable the preview window
  set pumheight=10  " Maximum number of items to show in popup menu

  " Insert mode key word completion setting
  set complete+=kspell complete-=w complete-=b complete-=u complete-=t
  set spelllang=en_us,cjk  " Spell languages
  set spellsuggest+=10  " The number of suggestions shown in the screen for z=
  nnoremap <silent> <F10> :set spell!<cr>
  inoremap <silent> <F10> <C-O>:set spell!<cr>
  " Ctrl+x followed by s = toggles it
  " [s = previous spell error, ]s = next spell error
  " zg = add word to spell list // z= correct error
" }}}

" =====================================================================
" =====================================================================

" === Airline === {{{
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 2
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#tab_nr_type = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline_skip_empty_sections=1
  let g:airline_highlighting_cache = 1

  " let g:airline#extensions#tabline#show_tabs = 0
  " let g:airline#extensions#hunks#enabled = 0
  set laststatus=2
  let g:airline_theme='srcery'
" }}}

" === UndoTree ==={{{
  nnoremap <Leader>ut :UndotreeToggle<CR>

  let g:undotree_RelativeTimestamp = 1
  let g:undotree_ShortIndicators = 1
  let g:undotree_HelpLine = 0
  let g:undotree_WindowLayout = 2
"}}}

" === Vimagit === {{{
  noremap  <Leader>ma :MagitO<Cr>
" }}}

" === Vim Gist === {{{
  let g:gist_clip_command = 'pbcopy'
"}}}

" === gitgutter === {{{
  nmap ) <Plug>(GitGutterNextHunk)
  nmap ( <Plug>(GitGutterPrevHunk)
  let g:gitgutter_enabled = 1
  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_linenrs = 1
"}}}

" === vim surround === {{{
  nmap <Leader>o ysiw
"}}}

" =====================================================================
" =====================================================================

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
" }}}

" === Bracey === {{{
  nmap <Leader>br :Bracey<CR>
  nmap <Leader>bR :BraceyReload<CR>
" }}}

" =====================================================================
" =====================================================================

" === Startify === {{{
  " Don't change to directory when selecting a file
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


  " Custom startup list, only show MRU from current directory/project
  let g:startify_lists = [
  \  { 'type': 'files',     'header': ['MRU'] },
  \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
  \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
  \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
  \  { 'type': 'commands',  'header': [ 'Commands' ]       },
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
      \ { 'c': '~/.config/nvim/init.vim' },
      \ { 'g': '~/.gitconfig' },
      \ { 'zs': '~/.config/zsh/zshrc' },
      \ { 'za': '~/.config/zsh/zsh-aliases' },
      \ { 'vi': '~/vimwiki/index.md' },
      \ { 'vib': '~/vimwiki/scripting/index.md'}
  \ ]

  nmap <leader>st :Startify<cr>
  " autoload startify
  " autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Startify | endif
" }}}

" =====================================================================
" =====================================================================

" === NVim-R === {{{
  " Autostart
  autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
  autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif

  " Open shortcuts
  nmap <Leader>rs :vs ~/projects/RStudio/nvim-r.md<CR>

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
" }}}

" =====================================================================
" =====================================================================

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
  " }}}

" === Floaterm === {{{
  nnoremap <Leader>lf :FloatermNew --wintype=split lf<CR>
" }}}

" === Neoterm === {{{
  let g:neoterm_default_mod='belowright' " open terminal in bottom split
  let g:neoterm_size=14                  " terminal split size
  let g:neoterm_autoscroll=1             " scroll to the bottom
  nnoremap <Leader>rf :T ipython --no-autoindent<CR>
  nnoremap <Leader>rr :Tclear<CR>
  nnoremap <Leader>rt :Ttoggle<CR>
  nnoremap <Leader>ro :Ttoggle<CR> :Ttoggle<CR>
  autocmd FileType python nnoremap <silent> ✠ :TREPLSendLine<CR><Esc><Home><Down>
  autocmd FileType python inoremap <silent> ✠ <Esc>:TREPLSendLine<CR><Esc>A
  autocmd FileType python xnoremap <silent> ✠ :TREPLSendSelection<CR><Esc><Esc>
"}}}

" === Vim-Slime === {{{
  let g:slime_target = "neovim"
  autocmd FileType python xmap <buffer> ,l <Plug>SlimeRegionSend
  autocmd FileType python nmap <buffer> ,l <Plug>SlimeLineSend
  autocmd FileType python nmap <buffer> ,p <Plug>SlimeParagraphSend
" }}}

" === Vim-lsp === {{{
  let g:markdown_fenced_languages = [
        \ 'vim',
        \ 'help'
        \]
"}}}

" === Vim Commentary === {{{
  autocmd FileType hjson setlocal commentstring=#\ %s
"}}}

" === Mkdx === {{{
  let g:mkdx#settings     = {
        \ 'restore_visual': 1,
        \ 'gf_on_steroids': 1,
        \ 'highlight': { 'enable':   1 },
        \ 'enter':     { 'shift':    1 },
        \ 'map':       { 'prefix': 'm', 'enable': 1 },
        \ 'links':     { 'external': { 'enable': 1 } },
        \ 'fold':      { 'enable':   1,
        \                'components': ['toc', 'fence'] },
        \ 'toc': {
        \    'text': 'Table of Contents',
        \    'update_on_write': 1,
        \    'details': { 'nesting_level': 0 }
        \ }
        \ }

  let g:polygot_disabled = ['markdown']

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

  if (!$VIM_DEV)
    " when not developing mkdx, use fancier <leader>I which uses fzf
    " instead of qf to jump to headers in markdown documents.
    nnoremap <silent> <Leader>I :call <SID>MkdxFzfQuickfixHeaders()<Cr>
  endif

  nnoremap <Leader>mcs :vs ~/vimwiki/dotfiles/mkdx.md<CR>
  nnoremap <Leader>nv :e $VIMRC<CR>
" }}}

" === Hack to make CocExplorer hijack Netwr === {{{
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
"     \ execute 'CocCommand explorer' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" }}}

" == vim-table-mode === {{{
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


  function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
  endfunction

  inoreabbrev <expr> <bar><bar>
            \ <SID>isAtStartOfLine('\|\|') ?
            \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
  inoreabbrev <expr> __
            \ <SID>isAtStartOfLine('__') ?
            \ '<c-o>:silent! TableModeDisable<cr>' : '__'
 " }}}

 " === vifm === {{{
let g:vifm_replace_netrw = 1
let g:vifm_replace_netrw_cmd = "Vifm"
"let g:vifm_embed_term = 1
"let g:vifm_embed_split = 1

"let g:vifm_exec_args =
" }}}

" === vim indentline === {{{
"let g:indentLine_showFirstIndentLevel = 1
"let g:indentLine_fileType = ['javascript', 'c']
let g:indentLine_fileTypeExclude = ["vimwiki", "coc-explorer", "help", "undotree", "diff"]
let g:indentLine_bufTypeExclude = ["help", "terminal"]
"let g:indentLine_bufNameExclude = []
let g:indentLine_indentLevel = 10

" Conceal settings
let g:indentLine_setConceal = 1
let g:indentLine_concealcursor = "incv"
let g:indentLine_conceallevel = 2

let g:indentLine_char = '|'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Leading Space
"let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = "•"

" Use Theme Colors
let g:indentLine_setColors = 1

" 16 Color
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)

" 256
let g:indentLine_color_term = 239

" True Color
let g:indentLine_color_gui = '#616161'

" Background (256, True)
"let g:indentLine_bgcolor_term = 202
"let g:indentLine_bgcolor_gui = '#FF5F00'
" }}}

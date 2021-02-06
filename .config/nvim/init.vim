"  __   __     ______     ______     __   __   __     __    __
" /\ "-.\ \   /\  ___\   /\  __ \   /\ \ / /  /\ \   /\ "-./  \
" \ \ \-.  \  \ \  __\   \ \ \/\ \  \ \ \'/   \ \ \  \ \ \-./\ \
"  \ \_\\"\_\  \ \_____\  \ \_____\  \ \__|    \ \_\  \ \_\ \ \_\
"   \/_/ \/_/   \/_____/   \/_____/   \/_/      \/_/   \/_/  \/_/

" Plugins {{{
  set ttyfast
  set nocompatible

  call plug#begin("~/.vim/plugged")
  " Vim-instant markdown
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'plasticboy/vim-markdown'
  Plug 'vimwiki/vimwiki'
  " Plug 'vim-pandoc/vim-rmarkdown'

  Plug 'zhou13/vim-easyescape'
  Plug 'tpope/vim-surround'
  Plug 'itchyny/vim-highlighturl'
  Plug 'PeterRincker/vim-searchlight'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mhinz/vim-startify'
  Plug 'justinmk/vim-sneak'
  " Plug 'easymotion/vim-easymotion'

  Plug 'kassio/neoterm'
  Plug 'voldikss/vim-floaterm'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'jreybert/vimagit'
  Plug 'mbbill/undotree'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'jpalardy/vim-slime', { 'for': 'python' }
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
  Plug 'sheerun/vim-polyglot'                     " More syntax highlighting
  " Plug 'kevinoid/vim-jsonc'

  " Plug 'autozimu/LanguageClient-neovim', {
  "   \ 'branch': 'next',
  "   \ 'do': 'bash install.sh',
  "   \ }

  " HTML/CSS
  Plug 'shime/vim-livedown'
  Plug 'tpope/vim-commentary'
  Plug 'alvan/vim-closetag'
  Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
  Plug 'ap/vim-css-color'

  " Themes
  Plug 'sainnhe/gruvbox-material'
  Plug 'sainnhe/edge'
  Plug 'sainnhe/sonokai'
  Plug 'sainnhe/forest-night'
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
  " <F3> = turn on/off relative line numbers
  " <F4> = compile markdown file using pandoc
  " <F5> = compile rmarkdown based on `output`
  " <F6> = compile rmarkdown (only pdf) using `RMarkdown`
  " <F9> = compile python
  " <F10> = spell check

  " g; = previous insertion
  " ysiw' = add quotes around word
  " S' = in visual mode add quotes around
  " ds' = delete quotes
" }}}


" General Mappings: {{{
  let mapleader = ' '
  let maplocalleader = ','                      " For NVim-R
  let g:gruvbox_material_palette = 'original'
  let g:gruvbox_material_background = 'hard'
  let g:gruvbox_material_enable_bold = 1
  let g:sonokai_style = 'shusia'
  let g:edge_style = 'aura'
  let g:material_theme_style = 'ocean-community'

  " UndoHistory: store undo history in a file. even after closing and reopening vim
  if has('persistent_undo')
    let target_path = expand('~/.config/vim-persisted-undo/')

    if !isdirectory(target_path)
      call system('mkdir -p ' . target_path)
    endif

    let &undodir = target_path
    set undofile
  endif

  set termguicolors                " enable termguicolors for better highlighting
  set fillchars+=msgsep:\ ,vert:\│ " customize message separator in neovim
  set t_Co=256

  syntax enable
  " colorscheme kimbie
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
  " colorscheme oceanic_material
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
  set incsearch                       " incremential search highligh
    nnoremap <silent><F7> :set nohlsearch!<CR>
  set encoding=utf-8                  " utf-8 encoding
  set clipboard+=unnamedplus          " use system clipboard
  set splitbelow splitright           " split screen below and right
  set tabstop=2 shiftwidth=2 expandtab softtabstop=2
  set ignorecase smartcase
  set number
    nnoremap <silent><F3> :set relativenumber!<CR>

  set foldmethod=marker
  set foldcolumn=1
  set nofoldenable
  set laststatus=0
  set scrolloff=5                      " cusor 5 lines from bottom of page
  set cursorline                       " show line where cursor is
  set mouse=a                          " enable mouse all modes
  set wildmode=longest,list,full       " Autocompletion
  set wildmenu                         " Autocompletion
  set wildignore+=.git,.DS_Store,node_modules
  " set nowrap                            " do not wrap text at `textwidth`
  set synmaxcol=1000                    " do not highlight long lines
  " set timeoutlen=250                    " keycode delay
  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  filetype plugin indent on

  " easier navigation in normal / visual / operator pending mode
  noremap K     {
  noremap J     }
  noremap H     ^
  noremap L     $

  " save using <C-s> in every mode
  " when in operator-pending or insert, takes you to normal mode
  nnoremap <C-s> :write<Cr>
  vnoremap <C-s> <C-c>:write<Cr>
  inoremap <C-s> <Esc>:write<Cr>
  onoremap <C-s> <Esc>:write<Cr>

  " Replace all is aliased to S.
  " Replace quotes on the line
  nnoremap S :%s//g<Left><Left>
  nmap <Leader>Q :s/'/"/g<CR>:nohlsearch<CR>

  " use tab and shift tab to indent and de-indent code
  nnoremap <Tab>   >>
  nnoremap <S-Tab> <<
  vnoremap <Tab>   >><Esc>gv
  vnoremap <S-Tab> <<<Esc>gv
  inoremap <S-Tab> <C-d>

  " use `u` to undo, use `U` to redo, mind = blown
  nnoremap U <C-r>

  " Make deleting line not go to clipbard
  nnoremap d "_d
  vnoremap d "_d
  " Yank line without newline character
  nnoremap Y y$
  " Make cut not go to clipboard
  nnoremap x "_x
  " Delete line without newline character
  nnoremap E ^"_D

  " Annoying when I hit 'q:' and it starts recording
  nmap q: :q<Cr>
  nmap Q: :q<Cr>
  command! -bang -nargs=* Q q

  " Ensure files are read as what I want:
  let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
  map <Leader>v :VimwikiIndex
  let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

  autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
  autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
  autocmd BufRead,BufNewFile *.tex set filetype=tex

  " Automatically deletes all tralling whitespace on save.
  autocmd BufWritePre * %s/\s\+$//e            " End of lines
  autocmd BufWritePre * %s#\($\n\s*\)\+\%$##e  " End of file

  " Disables automatic commenting on newline
  autocmd FileType * setlocal formatoptions-=cro

  " Shellcheck
  nnoremap <Leader>sc :!shellcheck %<CR>

" Open corresponding .pdf/.html or preview
  nmap <Leader>p :w <Bar> !open %<CR>

  " Compile rmarkdown / markdown
  " NOTE: `,kp` compiles RMarkdown to PDF using NVim-R
  autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
  autocmd Filetype rmd map <F6> :RMarkdown pdf latex_engine="xelatex", toc=TRUE<CR>
  autocmd FileType markdown nnoremap <buffer> <F4> !pandoc % --pdf-engine=xelatex -o %:r.pdf

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
  map <Leader>nt :tabnew<cr>      " To create a new tab.
  map <Leader>to :tabonly<cr>     " To close all other tabs (show only the current tab).
  map <Leader>tc :tabclose<cr>    " To close the current tab.
  map <Leader>tm :tabmove<cr>     " To move the current tab to next position.
  map <Leader>tn :tabn<cr>        " To swtich to next tab.
  map <Leader>tp :tabp<cr>        " To switch to previous tab.

  " Smart way to move between windows
  map <C-j> <C-W>j
  map <C-k> <C-W>k
  map <C-h> <C-W>h
  map <C-l> <C-W>l

  ":verbose hi <name>
  " SyntaxQuery: Display the syntax stack at current cursor position
  function! s:syntax_query() abort
    for id in synstack(line("."), col("."))
      execute 'hi' synIDattr(id, "name")
    endfor
  endfunction
  command! SQ call s:syntax_query()

  " IndentSize: Change indent size depending on file type
  function! <SID>IndentSize(amount)
      exe "setlocal expandtab"
         \ . " ts="  . a:amount
         \ . " sts=" . a:amount
  endfunction

  " FileType specific indents
  autocmd FileType markdown,python,json call <SID>IndentSize(2)
  autocmd FileType r,R setlocal sw=2 softtabstop=2 expandtab

  " Custom syntax groups
  augroup vimTodo
    au!
    au Syntax * syn match myTodo /\v<(FIXME|NOTE|NOTES|INFO|OPTIMIZE|XXX):/
          \ containedin=.*Comment,vimCommentTitle
  augroup END
  hi def link myTodo Todo

  " Have vimCommentTitle equivalency in Python
  augroup ccommtitle
    au!
    au Syntax * syn match cmTitle /#\s*\%([sS]:\|\h\w*#\)\=\u\w*\(\s\+\u\w*\)*:/
        \ containedin=vimCommentTitle
  augroup END
  hi def link cmTitle vimCommentTitle
" }}}

" =====================================================================
" =====================================================================

" Coc Coding {{{
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
    \ 'coc-git'
    \ ]

    let g:coc_global_extensions += ['https://github.com/andys8/vscode-jest-snippets']
  let g:python3_host_prog = '/Users/lucasburns/opt/anaconda3/bin/python3'
  set pyxversion=3


  noremap <silent> <Leader>e :CocCommand explorer<CR>

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Remap for rename current word
  nmap <rn> <Plug>(coc-rename)

  xmap <Leader>f <Plug>(coc-format-selected)
  nmap <Leader>f <Plug>(coc-format-selected)

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
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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

  " Use <c-space> to trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()

  " position. Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

  " For json
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " For coc-pairs
  autocmd FileType html let b:coc_pairs_disabled = ['html']
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

" }}}

" =====================================================================
" =====================================================================

" NERDTREE {{{
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeIgnore = []
  let g:NERDTreeStatusline = ''
  " Automaticaly close nvim if NERDTree is only thing left open
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  " Toggle
  " nnoremap <silent> <C-b> :NERDTreeToggle<CR>
  map <Leader>nn :NERDTreeToggle<cr>
  map <Leader>nb :NERDTreeFromBookmark
  map <Leader>nf :NERDTreeFind<cr>
  " }}}

  " --- FZF & Ripgrep --- {{{
  " :History/ -- :Maps -- :Commands -- :Locate -- :GFiles -- :GFiles?
  let g:rg_command = 'rg --vimgrep --hidden'
  let g:rg_highlight = 'true'
  let g:rg_format = '%f:%l:%c:%m,%f:%l:%m'

  nnoremap <silent> <Leader><space> :Files<CR>
  nnoremap <silent> <Leader>a :Buffers<CR>
  nnoremap <silent> <Leader>A :Windows<CR>
  nnoremap <silent> <Leader>; :BLines<CR>
  nnoremap <silent> <Leader>H :History:<CR>
  nnoremap <C-f> :Rg<CR>

  let g:fzf_preview_window = ''
  let g:fzf_layout         = { 'down': '~20%' }
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \}
" }}}

" =====================================================================
" =====================================================================

" --- EasyEscape --- {{{
  let g:easyescape_chars = { "j": 1, "k": 1 }
  let g:easyescape_timeout = 100
  cnoremap jk <ESC>
  cnoremap kj <ESC>

  " Fix paste bug triggered by the above inoremaps
  set t_BE=
" }}}

" =====================================================================
" =====================================================================

" --- Spell check --- {{{
  " set completeopt+=noinsert  " Auto select the first completion entry
  set completeopt+=menuone,preview  " Show menu even if there is only one item
  " set completeopt-=preview  " Disable the preview window
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
" }}}

" =====================================================================
" =====================================================================

" --- Airline --- {{{
  let g:airline_powerline_fonts = 1
  let g:airline_theme='srcery'
" }}}

" --- startify --- {{{
  let g:startify_bookmarks = ['~/.config', '~/JupyterNotebook/projects']
" }}}

" --- UndoTree ---{{{
  nnoremap <A-t> :UndotreeToggle<CR>

  let g:undotree_RelativeTimestamp = 1
  let g:undotree_ShortIndicators = 1
  let g:undotree_HelpLine = 0
  let g:undotree_WindowLayout = 2
"}}}

" --- Vimagit --- {{{
  noremap  <Leader>m :MagitO<Cr>
" }}}

" -- gitgutter -- {{{
  nmap ) <Plug>(GitGutterNextHunk)
  nmap ( <Plug>(GitGutterPrevHunk)
  let g:gitgutter_enabled = 1
  let g:gitgutter_map_keys = 0
  let g:gitgutter_highlight_linenrs = 1
"}}}

" =====================================================================
" =====================================================================

" --- Vim-Livedown --- {{{
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

" --- Bracey --- {{{
  nmap <Leadder>br :Bracey<CR>
  nmap <Leadder>r :BraceyReload<CR>
" }}}

" =====================================================================
" =====================================================================

" --- NVim-R --- {{{
  " Load the cheatshet of Nvim-R
   command! -bang CheatSheet call fzf#vim#files('~/JupyterNotebook/projects/rstudio/cheatsheet', <bang>0)
   " Still trying to figure this out
   nmap <Leader>cs :CheatSheet<CR>
   " nmap <Leader>sc !(nohup xargs -I{%} zathura "{%}" >/dev/null)

" Autostart
  autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
  autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif

  " Open shortcuts
  nmap <Leader>rs :vs ~/JupyterNotebook/projects/RStudio/nvim-r.md<CR>

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

" Gruvbox {{{
" if has('gui_running') || &termguicolors
"   let rout_color_input    = 'guifg=#e2cca9'
"   let rout_color_normal   = 'guifg=#d4be98'
"   let rout_color_number   = 'guifg=#80aa9e'
"   let rout_color_integer  = 'guifg=#8bba7f'
"   let rout_color_float    = 'guifg=#d3869b'
"   let rout_color_complex  = 'guifg=#e9b143'
"   let rout_color_negnum   = 'guifg=#f28534'
"   let rout_color_negfloat = 'guifg=#e78a4e'
"   let rout_color_date     = 'guifg=#ea6962'
"   let rout_color_true     = 'guifg=#b0b846'
"   let rout_color_false    = 'guifg=#f2594b'
"   let rout_color_inf      = 'guifg=#f28534'
"   let rout_color_constant = 'guifg=#7daea3'
"   let rout_color_string   = 'guifg=#266b79'
"   let rout_color_error    = 'guifg=#d4be98 guibg=#d3869b'
"   let rout_color_warn     = 'guifg=#fb4934'
"   let rout_color_index    = 'guifg=#d3af86'
" endif
" }}}

" =====================================================================
" =====================================================================

" --- Defualt Terminal --- {{{
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

" --- Floaterm --- {{{
  nnoremap <C-l> :FloatermNew --wintype=split lf<CR>
" }}}

" --- Neoterm --- {{{
  let g:neoterm_default_mod='belowright' " open terminal in bottom split
  let g:neoterm_size=14                  " terminal split size
  let g:neoterm_autoscroll=1             " scroll to the bottom
  nnoremap <Leader>rf :T ipython --no-autoindent<CR>
  nnoremap <Leader>rr :Tclear<CR>
  autocmd FileType python nnoremap <silent> ✠ :TREPLSendLine<CR><Esc><Home><Down>
  autocmd FileType python inoremap <silent> ✠ <Esc>:TREPLSendLine<CR><Esc>A
  autocmd FileType python xnoremap <silent> ✠ :TREPLSendSelection<CR><Esc><Esc>
"}}}

" --- Vim-Slime ---
  let g:slime_target = "neovim"
  autocmd FileType python xmap <buffer> ,l <Plug>SlimeRegionSend
  autocmd FileType python nmap <buffer> ,l <Plug>SlimeLineSend
  autocmd FileType python nmap <buffer> ,p <Plug>SlimeParagraphSend
" }}}

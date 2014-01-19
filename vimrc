" FULL VIM
set nocompatible

" PATHOGEN
filetype off
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()
filetype plugin indent on

" MAP <Leader>
noremap , \
let mapleader = ","

" CONFIGURATION MAPPING
set autoread                        " set to auto read when a file is changed from the outside
set showcmd                         " show typed commands
set expandtab                     " use tabs, not spaces
set shiftwidth=2                    " set tab width
set tabstop=2                       " a tab is four spaces
set softtabstop=2
"set noexpandtab                     " use tabs, not spaces
"set shiftwidth=4                    " set tab width
"set tabstop=4                       " a tab is four spaces
"set softtabstop=4
set smarttab                        " align space-tabs
set autoindent                      " set automatic code indentation

set wildmenu                        " turn on WiLd menu
set wildmode=list:longest,list:full " activate TAB auto-completion for file paths
set wildignore+=*.o,.git,.svn,node_modules

set backspace=indent,eol,start      " set backspace config, backspace as normal
set nomodeline                      " security
set encoding=utf8                   " default encoding for all files

set hlsearch                        " highlight search terms
set incsearch                       " go to search results as typing
set smartcase                       " but case-sensitive if expression contains a capital letter.

set ttyfast                         " improves redrawing for newer computers
set fileformats=unix,mac,dos

set nobackup                        " prevent backups of files
set noswapfile                      " no need for swap files
set directory=~/.vim/.swp,/tmp      " swap directory, just in case
set hidden                          " hide buffers without closing them
set viminfo='1000,<0,@0,/0          " don't remember things that can compromise data
set cryptmethod=blowfish            " zip encryption sucks, use blowfish

set linebreak                       " this will not break whole words while wrap is enabled
set nolist                          " when line break is enabled, don't break on words
set showbreak=…                     " show when line has been broken
set cursorline                      " highlight current line
set list listchars=tab:\ \ ,trail:· " like to know when trailing characters exist

set visualbell                      " no beeping
set noerrorbells                    " no beeping
set nowrap                          " no default line wrapping
set cpoptions+=$                    " changed end with $ while typing
set nu                              " turn on line numbering
set virtualedit=onemore             " alter virtual edit mode
set pastetoggle=<F3>                " set pastetoggle shortcut

syntax enable                       " enable syntax highlighting

" VIM 7.3 FEATURES

if v:version >= 703
  set undofile
  set undodir=$HOME/.vim/.undo
  set colorcolumn=81                " try to keep lines <= 80 characters
endif

" COLOR SCHEME
set t_Co=256
set background=dark
colorscheme delek
set list listchars=tab:\⁚\ ,trail:· " draw tab lines automatically
if has("gui_running")
  "set list listchars=tab:\⁚\ ,trail:· " draw tab lines automatically
  colorscheme ir_black
  set showtabline=2                 " prevent full screen display issues
  set guifont=Droid\ Sans\ Mono\ 11,Liberation\ Mono\ 11,Monospace\ 10
endif

"" ADDITIONAL GUI SETTINGS
if has("gui_running")
  set guioptions-=T
  set columns=130 lines=45
  set guioptions-=T
  " crazy hack to get gvim to remove all scrollbars
  set guioptions+=LlRrb
  set guioptions-=LlRrb
endif

" FOLDING
set foldenable                    " enable folding
set foldlevel=99
" for quick folding all top level functions
:nmap <F6> :g/\v^}$/;norm zf%<CR>
" jump to end of line and fold
:nmap <F5> $zf%

" ADDITIONAL KEY MAPPINGS
" swap implementations of ` and ' jump to prefer row and column jumping
nnoremap ' `
nnoremap ` '
" quick leave insert mode using <C-Space>
noremap  <C-Space> <ESC>
noremap  <Nul> <ESC>
inoremap <C-Space> <ESC>
inoremap <Nul> <ESC>
vnoremap <C-Space> <ESC>
vnoremap <Nul> <ESC>
" fast saving
nnoremap <Leader>s :up<cr>
" prevent accidental striking of F1 key
map <F1> <ESC>
imap <F1> <ESC>
" clear highlight
nnoremap <Leader><Space> :noh<CR>
" map Y to match C and D behavior
nnoremap Y y$
" fast window switching
map <Leader>, <C-W>w
" cycle between buffers
map <Leader>. :bn<cr>
" change directory to current buffer
map <Leader>cd :cd %:p:h<cr>
" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv
" pull word under cursor into lhs of a substitute (for quick search and replace)
nmap <Leader>R :%s#\<<C-r>=expand("<cword>")<CR>\>#
" strip all trailing whitespace in the current file
nnoremap <Leader>W :%s/\s\+$//e<cr>:let @/=''<CR>

" shift screen buffer up, down and side to side
nnoremap <C-J> 3<C-E>
nnoremap <C-K> 3<C-Y>
nnoremap <C-L> 3zl
nnoremap <C-H> 3zh

" easier movement when text lines wrap
nnoremap k gk
nnoremap j gj

" execute shortcuts for specific filetypes
command! Node !node %
nnoremap <Leader>ej :up<CR>:Node<CR>
command! CPP !clang++ % -o %:r
nnoremap <Leader>bc :up<CR>:CPP<CR>
command! ExecCPP !./%:r
nnoremap <Leader>ec :ExecCPP<CR>
" macros for debugging in commonly used languages
noremap <Leader>dj oi/* debug:start */i/* debug:stop */kA
noremap <Leader>db oi# debug:start #i# debug:stop #kA
noremap <Leader>dh oi<!-- debug:start -->i<!-- debug:stop -->kA

"" ADDITIONAL AUTOCOMMANDS

" saving when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! up
" open in last edit place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif


"" ABBREVIATIONS
source $HOME/.vim/autocorrect.vim

"" PLUGIN SETTINGS

" Indent Guide
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" WMGraphviz
let g:WMGraphviz_output="png"
let g:WMGraphviz_viewer="ristretto"

" Unimpaired
" bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" FuzzyFinder
nnoremap <Leader>f :FufFile<CR>
nnoremap <Leader>b :FufBuffer<CR>
nnoremap <Leader>r :FufRenewCache<CR>

" Highligh all matching words under cursor
au CursorMoved * silent! exe printf('match VisualNOS /\<%s\>/', expand('<cword>'))

"" LANGUAGE SPECIFIC

" JavaScript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.gyp set ft=sh

" HTML
au FileType html,xhtml set formatoptions+=tl
au FileType html,xhtml set smartindent

" Markdown
"au FileType markdown set expandtab

"" STATUS LINE
set laststatus=2 " always hide the statusline
set statusline=%f%m%r%h%w\ [TYPE=%Y][LEN=%L][ROW=%04l,COL=%04v][%P]%=[FF=%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k


" Path options
"autocmd BufRead,BufNewFile /var/projects/node/* set et ts=2 sw=2
"autocmd BufRead,BufNewFile /var/projects/node-trevnorris/* set et ts=2 sw=2
"autocmd BufRead,BufNewFile /var/projects/node-timer/* set et ts=2 sw=2
"autocmd BufRead,BufNewFile /var/projects/v8/* set et ts=2 sw=2
"autocmd BufRead,BufNewFile /var/projects/smbuffer/* set et ts=2 sw=2

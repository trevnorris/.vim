" FULL VIM
set nocompatible

" PATHOGEN
filetype off
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()
filetype plugin indent on

" MAP LEADER
noremap , \
let mapleader = ","

" CONFIGURATION MAPPING
set scrolloff=3						" show 3 lines of context around the cursor
set autoread						" set to auto read when a file is changed from the outside
set showcmd							" show typed commands

set wildmenu						" turn on WiLd menu
set wildmode=list:longest,list:full " activate TAB auto-completion for file paths
set wildignore+=*.o,.git,.svn,node_modules

set ruler							" always show current position
set backspace=indent,eol,start		" set backspace config, backspace as normal
set nomodeline						" security
set encoding=utf8

set hlsearch						" highlight search things
set incsearch						" go to search results as typing
set smartcase						" but case-sensitive if expression contains a capital letter.
set ignorecase						" ignore case when searching
set gdefault						" assume global when searching or substituting
set magic							" set magic on, for regular expressions
set showmatch						" show matching brackets when text indicator is over them

set ttyfast							" improves redrawing for newer computers
set fileformats=unix,mac,dos

set nobackup						" prevent backups of files, since using versioning mostly and undofile
set nowritebackup
set noswapfile
set directory=~/.vim/.swp,/tmp		" swap directory
set shiftwidth=4					" set tab width
set softtabstop=4
set tabstop=4
set smarttab
set autoindent						" set automatic code indentation
set hidden

set linebreak						" this will not break whole words while wrap is enabled
set showbreak=…
set cursorline						" highlight current line
set list listchars=tab:\ \ ,trail:· " show · for trailing space, \ \ for trailing tab

set nowrap							" no line wrapping
set cpoptions+=$					" changed end with $ while typing
set nu								" turn on line numbering
set virtualedit=onemore				" alter virtual edit mode
set pastetoggle=<F3>				" set pastetoggle shortcut

syntax enable						" enable syntax highlighting

" VIM 7.3 FEATURES

if v:version >= 703
	set undofile
	set undodir=$HOME/.vim/.undo
	"set colorcolumn=115			" show a right margin column
endif

" COLOR SCHEME
set t_Co=256
set background=dark
colorscheme xoria256
if has("gui_running")
	colorscheme xoria256
endif

" FOLDING
set foldenable						" enable folding
set foldmethod=marker				" detect triple-{ style fold markers
set foldlevel=99

" ADDITIONAL KEY MAPPINGS
" fast saving
nmap <leader>w :up<cr>
" prevent accidental striking of F1 key
map <F1> <ESC>
imap <F1> <ESC>
" clear highlight
nnoremap <leader><space> :noh<cr>
" map Y to match C and D behavior
nnoremap Y y$
" yank entire file (global yank)
nmap gy ggVGy
" fast window switching
map <leader>, <C-W>w
" cycle between buffers
map <leader>. :b#<cr>
" change directory to current buffer
map <leader>cd :cd %:p:h<cr>
" swap implementations of ` and ' jump to prefer row and column jumping
nnoremap ' `
nnoremap ` '
" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv
" pull word under cursor into lhs of a substitute (for quick search and replace)
nmap <leader>r :%s#\<<C-r>=expand("<cword>")<CR>\>#
" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//e<cr>:let @/=''<CR>
" insert path of current file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
" fast editing of the .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>
" allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null

" create different delete key that maps to black hole
nnoremap <C-X> "_d
vnoremap <C-X> "_d
" easily create new tabs
nnoremap <C-T> :tabnew<CR>
" shift screen buffer up, down and side to side
nnoremap <C-J> 3<C-E>
nnoremap <C-K> 3<C-Y>
nnoremap <C-L> 3zl
nnoremap <C-H> 3zh
" easier movement between tabs
nnoremap <C-N> :tabnext<CR>
nnoremap <C-P> :tabprevious<CR>
nnoremap <C-E> :NERDTree<CR>
" set commands for different file types
command Node !node %
nnoremap <Leader>ej :w<CR>:Node<Return>
command Php5 !php5 %
nnoremap <Leader>ep :w<CR>:Php5<Return>
" macros for common entries
noremap <Leader>dj oi/* debug:start */i/* debug:stop */kA
noremap <Leader>dp oi/* debug:start */i/* debug:stop */kA

"" ADDITIONAL AUTOCOMMANDS

" saving when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! up
" open in last edit place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"" ADDITIONAL GUI SETTINGS

if has("gui_running")
	set guioptions-=T
	set guioptions-=m
	set linespace=6
	set columns=170 lines=30
	set guioptions-=T

	" crazy hack to get gvim to remove all scrollbars
	set guioptions+=LlRrb
	set guioptions-=LlRrb

	if has("mac")
	    set guifont=DejaVu\ Sans\ Mono\:h14
	else
	    set guifont=UbuntuBeta\ Mono\ 11
	endif
endif

"" ABBREVIATIONS
source $HOME/.vim/autocorrect.vim

"" PLUGIN SETTINGS

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let g:NERDChristmasTree=1
let g:NERDTreeDirArrows=1
"let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1

" Super Tab
" let g:SuperTabDefaultCompletionType = "context"

" Unimpaired
" bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Command-T
let g:CommandTMaxHeight=20

" Ack
set grepprg=ack
nnoremap <leader>a :Ack<space>
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" CoffeeScript
let coffee_compile_on_save = 1

"" LANGUAGE SPECIFIC

" CSS
au FileType css set tabstop=2 shiftwidth=2

" HTML
au FileType html,xhtml set formatoptions+=tl
au FileType html,xhtml set foldmethod=indent smartindent
au FileType html,xhtml set tabstop=3 shiftwidth=3

" Ruby
au FileType ruby setlocal ts=2 sts=2 sw=2 foldmethod=syntax

" Python
au FileType python set noexpandtab

" JavaScript
au FileType javascript setlocal ts=4 sts=4 sw=4
au BufRead,BufNewFile *.json set ft=json

"" STATUS LINE

set laststatus=2 " always hide the statusline
set statusline=%F%m%r%h%w\ [TYPE=%Y][LEN=%L][ROW=%04l,COL=%04v][%P]%=[ASCII=\%03.3b][HEX=\%02.2B][FORMAT=%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k
set laststatus=2  " always show status line

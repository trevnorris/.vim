" FULL VIM
set nocompatible

" PATHOGEN
filetype off
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()
filetype plugin indent on

" MAP Leader
noremap , \
let mapleader = ","

" CONFIGURATION MAPPING
set autoread						" set to auto read when a file is changed from the outside
set showcmd							" show typed commands
set noexpandtab						" use tabs, not spaces

set wildmenu						" turn on WiLd menu
set wildmode=list:longest,list:full	" activate TAB auto-completion for file paths
set wildignore+=*.o,.git,.svn,node_modules

set backspace=indent,eol,start		" set backspace config, backspace as normal
set nomodeline						" security
set encoding=utf8

set hlsearch						" highlight search terms
set incsearch						" go to search results as typing
set ignorecase						" ignore case when searching
set smartcase						" but case-sensitive if expression contains a capital letter.
set magic							" set magic on, for regular expressions

set ttyfast							" improves redrawing for newer computers
set fileformats=unix,mac,dos

set nobackup						" prevent backups of files, since using versioning mostly and undofile
set nowritebackup
set noswapfile
set directory=~/.vim/.swp,/tmp		" swap directory
set shiftwidth=4					" set tab width
set softtabstop=4
set tabstop=4						" a tab is four spaces
set smarttab
set autoindent						" set automatic code indentation
set hidden							" hide buffers without closing them

set linebreak						" this will not break whole words while wrap is enabled
set showbreak=…
set cursorline						" highlight current line
set list listchars=tab:\ \ ,trail:·

set visualbell						" no beeping
set noerrorbells					" no beeping
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
	set colorcolumn=115				" show a right margin column
endif

" COLOR SCHEME
set t_Co=256
set background=dark
colorscheme delek
if has("gui_running")
	set list listchars=tab:\⁚\ ,trail:·
	colorscheme ir_black
	set showtabline=2				" prevent full screen display issues
	set guifont=Droid\ Sans\ Mono\ 11,Liberation\ Mono\ 11,Monospace\ 10
endif

" FOLDING
set foldenable						" enable folding
"set foldmethod=marker				" detect triple-{ style fold markers
set foldlevel=99

" ADDITIONAL KEY MAPPINGS
" fast saving
nmap <Leader>w :up<cr>
" prevent accidental striking of F1 key
map <F1> <ESC>
imap <F1> <ESC>
" clear highlight
nnoremap <Leader><space> :noh<cr>
" map Y to match C and D behavior
nnoremap Y y$
" fast window switching
map <Leader>, <C-W>w
" cycle between buffers
map <Leader>. :bn<cr>
" change directory to current buffer
map <Leader>cd :cd %:p:h<cr>
" swap implementations of ` and ' jump to prefer row and column jumping
nnoremap ' `
nnoremap ` '
" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv
" pull word under cursor into lhs of a substitute (for quick search and replace)
nmap <Leader>r :%s#\<<C-r>=expand("<cword>")<CR>\>#
" strip all trailing whitespace in the current file
nnoremap <Leader>W :%s/\s\+$//e<cr>:let @/=''<CR>
" insert path of current file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
" fast editing of the .vimrc
nmap <silent> <Leader>ev :e $MYVIMRC<cr>
nmap <silent> <Leader>sv :so $MYVIMRC<cr>

" create different delete key that maps to black hole
nnoremap <C-X> "_d
vnoremap <C-X> "_d
" easily create new tabs
nnoremap <C-T> :tabnew<CR>
" easier movement between tabs
nnoremap <C-N> :tabnext<CR>
nnoremap <C-P> :tabprevious<CR>
nnoremap <C-E> :NERDTree<CR>
" shift screen buffer up, down and side to side
nnoremap <C-J> 3<C-E>
nnoremap <C-K> 3<C-Y>
nnoremap <C-L> 3zl
nnoremap <C-H> 3zh
" open file under cursor
map gf :edit <cfile><CR>

" execute shortcuts for specific filetypes
command Node !node %
nnoremap <Leader>ej :up<CR>:Node<CR>
command Php5 !php5 %
nnoremap <Leader>ep :up<CR>:Php5<CR>
" macros for common entries
noremap <Leader>dj oi/* debug:start */i/* debug:stop */kA
noremap <Leader>db oi# debug:start #i# debug:stop #kA
noremap <Leader>dh oi<!-- debug:start -->i<!-- debug:stop -->kA

"" ADDITIONAL AUTOCOMMANDS

" saving when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! up
" open in last edit place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"" ADDITIONAL GUI SETTINGS

if has("gui_running")
	set guioptions-=T
	set columns=130 lines=45
	set guioptions-=T

	" crazy hack to get gvim to remove all scrollbars
	set guioptions+=LlRrb
	set guioptions-=LlRrb
endif

"" ABBREVIATIONS
source $HOME/.vim/autocorrect.vim

"" PLUGIN SETTINGS

" Indent Guide
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" NERDTree
nmap <Leader>n :NERDTreeToggle<CR>
let g:NERDChristmasTree=1
let g:NERDTreeDirArrows=1
let g:NERDTreeShowHidden=1

" WMGraphviz
let g:WMGraphviz_output="png"
let g:WMGraphviz_viewer="eog"

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

" Ack
set grepprg=ack
nnoremap <Leader>a :Ack<space>
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Highligh all matching words under cursor
au CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

"" LANGUAGE SPECIFIC

" Ruby
au FileType ruby,eruby set ts=2 sts=2 sw=2 foldmethod=syntax

" JavaScript
au FileType javascript set ts=4 sts=4 sw=4
au BufRead,BufNewFile *.json set ft=json

" CSS
au FileType css set tabstop=2 shiftwidth=2

" HTML
au FileType html,xhtml set formatoptions+=tl
au FileType html,xhtml set foldmethod=indent smartindent
au FileType html,xhtml set tabstop=3 shiftwidth=3

" Markdown
"au FileType markdown set expandtab

"" STATUS LINE
set laststatus=2 " always hide the statusline
set statusline=%F%m%r%h%w\ [TYPE=%Y][LEN=%L][ROW=%04l,COL=%04v][%P]%=[ASCII=\%03.3b][HEX=\%02.2B][FORMAT=%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k

" FULL VIM
set nocompatible

" VUNDLE
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-unimpaired'
Plugin 'trevnorris/vim-javascript-syntax'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'vim-scripts/L9'
Plugin 'VundleVim/Vundle.vim'
Plugin 'yssl/QFEnter'

" Have used, but not currently using
"Plugin 'guileen/vim-node'
"Plugin 'jceb/vim-orgmode'
"Plugin 'marijnh/tern_for_vim'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'ternjs/tern_for_vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'w0rp/ale'
"Plugin 'walm/jshint.vim'
"Plugin 'wannesm/wmgraphviz.vim'
"Plugin 'wavded/vim-stylus'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" MAP <Leader>
" NOTE: if there is delay in a key combo use :verbose noremap <leader>(key) to
" see what's bound to it, and make sure it's the only mapping to that key.
noremap , \
let mapleader = ","

" CONFIGURATION MAPPING
set autoread                        " set to auto read when a file is changed from the outside
set showcmd                         " show typed commands
set expandtab                       " use spaces, not tabs
set shiftwidth=2                    " set tab width
set tabstop=2                       " a tab is two spaces
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
set cryptmethod=blowfish2           " zip encryption sucks, use blowfish

set linebreak                       " this will not break whole words while wrap is enabled
set nolist                          " when line break is enabled, don't break on words
set showbreak=…                     " show when line has been broken
set cursorline                      " highlight current line
set list listchars=tab:\ \ ,trail:· " like to know when trailing characters exist

set visualbell                      " no beeping
set noerrorbells                    " no beeping
set nowrap                          " no default line wrapping
set cpoptions+=$                    " changed end with $ while typing
"set nu                              " turn on line numbering
set virtualedit=onemore             " alter virtual edit mode
set pastetoggle=<F3>                " set pastetoggle shortcut
set tags=./tags;,tags;              " better tags file search order

set scrolloff=3                     " force lines on top and bottom

"set textwidth=80                    " Always force wrap code at 80 characters

"set timeoutlen=750 ttimeoutlen=0   " set better timeouts

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
colorscheme distinguished
set list listchars=tab:\⁚\ ,trail:· " draw tab lines automatically
if has("gui_running")
  "set list listchars=tab:\⁚\ ,trail:· " draw tab lines automatically
  colorscheme ir_black
  set showtabline=2                 " prevent full screen display issues
  set guifont=DejaVu\ Sans\ Mono\ Book\ 7,Liberation\ Mono\ 11,Monospace\ 10
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
":nmap <F6> :g/\v^}$/;norm zf%<CR>
" jump to end of line and fold
":nmap <F5> $zf%

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
nnoremap <Leader>s :up<CR>
inoremap <F2> <C-o>:w<cr>
" prevent accidental striking of F1 key
map <F1> <ESC>
imap <F1> <ESC>
" clear highlight
nnoremap <Leader><Space> :noh<CR>
" map Y to match C and D behavior
nnoremap Y y$
" fast window switching
nnoremap <Leader>/ <C-W>w
nnoremap <Leader>. <C-W>W
" cycle between buffers
nnoremap <Leader>, :bn<CR>
nnoremap <Leader>m :bp<CR>
" change directory to current buffer
nnoremap <Leader>cdd :cd %:p:h<CR>:pwd<CR>
" change directory to git project root
nnoremap <Leader>cdr :silent exec ':cd '.system('git rev-parse --show-cdup')<CR>:pwd<CR>
" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv
" pull word under cursor into lhs of a substitute (for quick search and replace)
nmap <Leader>R :%s#\<<C-r>=expand("<cword>")<CR>\>#
" strip all trailing whitespace in the current file
nnoremap <Leader>W :%s/\s\+$//e<CR>:let @/=''<CR>
" insert new line below current line from insert mode and start typing
imap <C-]> <ESC>o
" Quick jump to quickfix window
nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cl :ccl<CR>

" shift screen buffer up, down and side to side
nnoremap <C-J> 3<C-E>
nnoremap <C-K> 3<C-Y>
nnoremap <C-L> 3zl
nnoremap <C-H> 3zh

" easier movement when text lines wrap
nnoremap k gk
nnoremap j gj

" remove everything between and including debug:start/debug:stop
nnoremap <Leader>D :silent g/^\/\* debug:start \*\//;/^\/\* debug:stop \*\//d<CR>:noh<CR>
" macros for debugging in commonly used languages
noremap <Leader>dj oi/* debug:start */i/* debug:stop */kA
noremap <Leader>db oi# debug:start #i# debug:stop #kA
noremap <Leader>dh oi<!-- debug:start -->i<!-- debug:stop -->kA
" macro for starting new JS files
noremap <Leader>js i'use strict';const print = process._rawDebug;O

"" ADDITIONAL AUTOCOMMANDS

" saving when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! up
" open in last edit place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"" quick save mksession in git repos
command! -complete=file -nargs=1 Remove :echo 'Remove: '.'<f-args>'.' '.(delete(<f-args>) == 0 ? 'SUCCEEDED' : 'FAILED')
noremap <Leader>kd :Remove .git/mksession.vim<CR>
noremap <Leader>ks :mksession .git/mksession.vim<CR>
noremap <Leader>kl :source .git/mksession.vim<CR>:so $MYVIMRC<CR>

"" PLUGIN SETTINGS

" Indent Guide
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" FuzzyFinder
nnoremap <Leader>zf :FufFile<CR>
nnoremap <Leader>zb :FufBuffer<CR>
nnoremap <Leader>zt :FufTag<CR>
nnoremap <Leader>zr :FufRenewCache<CR>

" Highligh all matching words under cursor
au CursorMoved * silent! exe 'match VisualNOS /'.escape(expand('<cword>'), '.*').'/'

"" LANGUAGE SPECIFIC

" JavaScript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.gyp set ft=sh
au BufRead,BufNewFile *.gypi set ft=sh

" HTML
au FileType html,xhtml set formatoptions+=tl
au FileType html,xhtml set smartindent

" ale
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
"let g:ale_lint_on_save = 0
"nnoremap <leader>al :ALELint<CR>
"nnoremap <leader>ar :ALEReset<CR>

" STATUS LINE
set laststatus=2 " always hide the statusline
set statusline=%f%m%r%h%w\ [TYPE=%Y][LEN=%L][ROW=%04l,COL=%04v][%P]%=[FF=%{&ff}]%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k

nnoremap <Leader>au :AABu<CR>
nnoremap <Leader>ad :AABd<CR>

command! AABu execute ":normal!" AwesomeBlockBoundry(-1)."G"
command! AABd execute ":normal!" AwesomeBlockBoundry(1)."G"

function! AwesomeBlockBoundry(direction)
  let drctn = a:direction
  let next_line = line('.')
  let original_indent = indent(next_line)

  while ((next_line >= 1) && (next_line <= line('$')))
    let next_line = next_line + drctn
    if (indent(next_line) < original_indent) &&
        \ (match(getline(next_line), "^\\s*$") == -1) ||
        \ (match(getline(next_line), "^\S") == 0)
      break
    endif
  endwhile
  return next_line
endfunction

" Search all buffers for matches
nnoremap <Leader>xb :Bufreg 
command! -nargs=1 Bufreg call BufReg(<f-args>)
function! BufReg(reg)
  let buf=bufnr('%')
  cexpr []
  silent! bufdo exe 'vimgrepadd /'.a:reg.'/j '.expand('%:p')
  exec 'b' buf
  botright cwindow
endfunction

" Search current director for matches
nnoremap <Leader>xd :Dirreg 
command! -nargs=1 Dirreg call DirReg(<f-args>)
function! DirReg(reg)
  let buf=bufnr('%')
  silent! execute 'vimgrep /'.a:reg.'/j '.expand('%:p:h').'/*'
  exec 'b' buf
  botright cwindow
endfunction

" Search current directory and all subdirectories for matches
nnoremap <Leader>xr :Recreg 
command! -nargs=1 Recreg call RecReg(<f-args>)
function! RecReg(reg)
  let buf=bufnr('%')
  silent! execute 'vimgrep /'.a:reg.'/j '.getcwd().'/**/*'
  exec 'b' buf
  botright cwindow
endfunction

" Search for word under cursor in current buffers
nnoremap <Leader>xwb :call WordReg(expand("<cword>"))<CR>
function! WordReg(reg)
  let buf=bufnr('%')
  cexpr []
  silent! bufdo exe 'vimgrepadd /\<'.a:reg.'\>/j '.expand('%:p')
  exec 'b' buf
  botright cwindow
endfunction

" Search for word under cursor in current directory
nnoremap <Leader>xwb :call WordReg(expand("<cword>"))<CR>
function! WordReg(reg)
  let buf=bufnr('%')
  cexpr []
  silent! bufdo exe 'vimgrepadd /\<'.a:reg.'\>/j '.expand('%:p:h').'/*'
  exec 'b' buf
  botright cwindow
endfunction


" Used to autofix syntax highlighting after doing :bufdo e!
" but should be able to restore highlighting with :syntax on
" Enable syntax highlighting when buffers are displayed in a window through
" :argdo and :bufdo, which disable the Syntax autocmd event to speed up
" processing.

augroup EnableSyntaxHighlighting
    " Filetype processing does happen, so we can detect a buffer initially
    " loaded during :argdo / :bufdo through a set filetype, but missing
    " b:current_syntax. Also don't do this when the user explicitly turned off
    " syntax highlighting via :syntax off.
    " The following autocmd is triggered twice:
    " 1. During the :...do iteration, where it is inactive, because
    " 'eventignore' includes "Syntax". This speeds up the iteration itself.
    " 2. After the iteration, when the user re-enters a buffer / window that was
    " loaded during the iteration. Here is becomes active and enables syntax
    " highlighting. Since that is done buffer after buffer, the delay doesn't
    " matter so much.
    " Note: When the :...do command itself edits the window (e.g. :argdo
    " tabedit), the BufWinEnter event won't fire and enable the syntax when the
    " window is re-visited. We need to hook into WinEnter, too. Note that for
    " :argdo split, each window only gets syntax highlighting as it is entered.
    " Alternatively, we could directly activate the normally effectless :syntax
    " enable through :set eventignore-=Syntax, but that would also cause the
    " slowdown during the iteration Vim wants to avoid.
    " Note: Must allow nesting of autocmds so that the :syntax enable triggers
    " the ColorScheme event. Otherwise, some highlighting groups may not be
    " restored properly.

    autocmd! BufWinEnter,WinEnter * nested if exists('syntax_on') && ! exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') == -1 | silent syntax enable | endif

    " The above does not handle reloading via :bufdo edit!, because the
    " b:current_syntax variable is not cleared by that. During the :bufdo,
    " 'eventignore' contains "Syntax", so this can be used to detect this
    " situation when the file is re-read into the buffer. Due to the
    " 'eventignore', an immediate :syntax enable is ignored, but by clearing
    " b:current_syntax, the above handler will do this when the reloaded buffer
    " is displayed in a window again.

    autocmd! BufRead * if exists('syntax_on') && exists('b:current_syntax') && ! empty(&l:filetype) && index(split(&eventignore, ','), 'Syntax') != -1 | unlet! b:current_syntax | endif
augroup END

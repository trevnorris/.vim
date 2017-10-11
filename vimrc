" FULL VIM
set nocompatible

" PATHOGEN
filetype off
silent! call pathogen#helptags()
silent! call pathogen#infect()
filetype plugin indent on

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
map <Leader>, <C-W>w
" cycle between buffers
map <Leader>. :bn<CR>
map <Leader>m :bp<CR>
" change directory to current buffer
map <Leader>cd :cd %:p:h<CR>
" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv
" pull word under cursor into lhs of a substitute (for quick search and replace)
nmap <Leader>R :%s#\<<C-r>=expand("<cword>")<CR>\>#
" strip all trailing whitespace in the current file
nnoremap <Leader>W :%s/\s\+$//e<CR>:let @/=''<CR>
" remove everything between and including debug:start/debug:stop
nnoremap <Leader>D :silent g/^\/\* debug:start \*\//;/^\/\* debug:stop \*\//d<CR>:noh<CR>

" Generate ctags file in root of git repo from current directory
nnoremap <Leader>ct :!ctags -f $(git rev-parse --show-cdup)/tags -R .<CR><CR>

" shift screen buffer up, down and side to side
nnoremap <C-J> 3<C-E>
nnoremap <C-K> 3<C-Y>
nnoremap <C-L> 3zl
nnoremap <C-H> 3zh

" easier movement when text lines wrap
nnoremap k gk
nnoremap j gj

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


"" ABBREVIATIONS
source $HOME/.vim/autocorrect.vim

"" PLUGIN SETTINGS

" Indent Guide
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" WMGraphviz
let g:WMGraphviz_output="png"
let g:WMGraphviz_viewer="ristretto"

" FuzzyFinder
nnoremap <Leader>f :FufFile<CR>
nnoremap <Leader>b :FufBuffer<CR>
nnoremap <Leader>t :FufTag<CR>
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

" highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/


" Path options
"autocmd BufRead,BufNewFile /var/projects/node/* set et ts=2 sw=2
"autocmd BufRead,BufNewFile /var/projects/node-trevnorris/* set et ts=2 sw=2
"autocmd BufRead,BufNewFile /var/projects/node-timer/* set et ts=2 sw=2
"autocmd BufRead,BufNewFile /var/projects/v8/* set et ts=2 sw=2
"autocmd BufRead,BufNewFile /var/projects/smbuffer/* set et ts=2 sw=2

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

nnoremap <Leader>xb :Bufreg 
command! -nargs=1 Bufreg call BufReg(<f-args>)
function! BufReg(reg)
  cexpr []
  bufdo silent execute 'vimgrepadd /'.a:reg.'/j '.expand('%:p')
  botright cwindow
endfunction

nnoremap <Leader>xd :Dirreg 
command! -nargs=1 Dirreg call DirReg(<f-args>)
function! DirReg(reg)
  silent execute 'vimgrep /'.a:reg.'/j '.expand('%:p:h').'/*'
  botright cwindow
endfunction

nnoremap <Leader>xr :Recreg 
command! -nargs=1 Recreg call RecReg(<f-args>)
function! RecReg(reg)
  silent execute 'vimgrep /'.a:reg.'/j '.getcwd().'/**/*'
  botright cwindow
endfunction

nnoremap <Leader>xw :call WordReg(expand("<cword>"))<CR>
function! WordReg(reg)
  silent execute 'vimgrep /\<'.a:reg.'\>/j '.getcwd().'/**/*'
  botright cwindow
endfunction

nnoremap <Leader>xc :Custreg 
command! -nargs=1 Custreg call CustReg(<f-args>)
function! CustReg(reg)
  cexpr []
  bufdo silent execute 'vimgrepadd '.a:reg
  botright cwindow
endfunction


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

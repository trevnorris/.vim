" FULL VIM
set nocompatible

" PATHOGEN
filetype off
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()
filetype plugin indent on

" MAP LEADER
let mapleader = ","

" CONFIGURATION MAPPING
set showmode                        " display the mode you're in
set history=500                     " sets how many lines of history VIM has to remember
set undolevels=500
set scrolloff=3                     " show 3 lines of context around the cursor
set autoread                        " set to auto read when a file is changed from the outside
set visualbell                      " Use visual bell
set mousehide                       " hide mouse cursor when typing
set mouse=a                         " allow for full mouse support
set autowrite
set number                          " show line numbers
set showcmd                         " show typed commands
set virtualedit=all                 " allow cursor to freely roam anywhere

set wildmenu                        " turn on WiLd menu
set wildmode=list:longest,list:full " activate TAB auto-completion for file paths
set wildignore+=*.o,.git

set ruler                           " always show current position
set backspace=indent,eol,start      " set backspace config, backspace as normal
set nomodeline                      " security
set encoding=utf8

set hlsearch                        " highlight search things
set incsearch                       " go to search results as typing
set smartcase                       " but case-sensitive if expression contains a capital letter.
set ignorecase                      " ignore case when searching
set gdefault                        " assume global when searching or substituting
set magic                           " set magic on, for regular expressions
set showmatch                       " show matching brackets when text indicator is over them

set lazyredraw                      " don't redraw screen during macros
set ttyfast                         " improves redrawing for newer computers
set fileformats=unix,mac,dos
set spelllang=en,es                 " set spell check language

set nobackup                        " prevent backups of files, since using versioning mostly and undofile
set nowritebackup
set noswapfile
set directory=~/.vim/.swp,/tmp      " swap directory
if v:version >= 703
    set undofile
    set undodir=$HOME/.vim/.undo
    set colorcolumn=115 " show a right margin column
endif
set shiftwidth=4                    " set tab width
set softtabstop=4
set tabstop=4
set smarttab
set expandtab
set autoindent                      " set automatic code indentation

set wrap                            " wrap lines
set linebreak                       " this will not break whole words while wrap is enabled
set showbreak=…

" COLOR SCHEME
set t_Co=256
colorscheme jellybeans
if has("gui_running")
    colorscheme jellybeans
endif

" FOLDING
set foldenable                                                           " enable folding
set foldcolumn=2                                                         " add a fold column
set foldmethod=marker                                                    " detect triple-{ style fold markers

set list listchars=tab:\ \ ,trail:· " show · for trailing space, \ \ for trailing tab
set tags+=../tags,../../tags,../../../tags,../../../../tags " look for all the tags files in the recurrent directories

set cursorline " highlight current line
syntax enable " enable syntax highlighting

" ADDITIONAL KEY MAPPINGS

" fast commands
map ; :
" fast saving
nmap <leader>w :up<cr>
" fast escaping
imap jj <ESC>
" fast quiting
imap <leader>q :q<cr>
" prevent accidental striking of F1 key
map <F1> <ESC>
" clear highlight
nnoremap <leader><space> :noh<cr>
" display hidden non printable characters
nmap <leader>l :set list!<CR>
" re hardwrap text
nnoremap <leader>q gqip
" space to toggle folds
nnoremap <space> za
" map Y to match C and D behavior
nmap Y y$
" yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P
" yank entire file (global yank)
nmap gy ggVGy
" ignore lines when going up or down
nnoremap j gj
nnoremap k gk
" move around matching bracket pairs
nnoremap <tab> %
vnoremap <tab> %
" auto complete {} indent and position the cursor in the middle line
inoremap {<CR>  {<CR>}<Esc>O
inoremap (<CR>  (<CR>)<Esc>O
inoremap [<CR>  [<CR>]<Esc>O
" fast window switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>, <C-W>w
" cycle between buffers
map <right> :bn<cr>
map <left> :bp<cr>
map <leader>b :b#<cr>
" change directory to current buffer
map <leader>cd :cd %:p:h<cr>
" swap implementations of ` and ' jump to prefer row and column jumping
nnoremap ' `
nnoremap ` '
" move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`j
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv
" pull word under cursor into lhs of a substitute (for quick search and replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#
" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//e<cr>:let @/=''<CR>
" turn on spell checking
map <leader>spell :setlocal spell!<cr>
" insert path of current file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" fast editing of the .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>
" allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null

"" ADDITIONAL AUTOCOMMANDS

" saving when focus lost (after tabbing away or switching buffers)
au FocusLost,BufLeave,WinLeave,TabLeave * silent! up
" open in last edit place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"" ADDITIONAL GUI SETTINGS

if has("gui_running")
    set guioptions-=T
    set linespace=6
    set columns=170 lines=30
    set guioptions-=T

    " crazy hack to get gvim to remove all scrollbars
    set guioptions+=LlRrb
    set guioptions-=LlRrb

    if has("mac")
        set guifont=DejaVu\ Sans\ Mono\:h14
    else
        set guifont=Liberation\ Mono\ 10
    endif
endif

"" ABBREVIATIONS

" insert date
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
" environment
iab #! #!/bin/sh
" lorem ipsum text
iab lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
iab llorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
" common abbrev., mispellings
source $HOME/.vim/autocorrect.vim

"" PLUGIN SETTINGS

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
" store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/.tmp/NERDTreeBookmarks")
" show hidden files, too
let NERDTreeShowHidden=1
" highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1
" use a single click to fold/unfold directories and a double click to open files
let NERDTreeMouseMode=2
" don't display these kinds of files
let NERDTreeIgnore=[ '^\.git$' ]

" Command-T
let g:CommandTMaxHeight=20

" Ack
set grepprg=ack
nnoremap <leader>a :Ack<space>
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" CoffeeScript
let coffee_compile_on_save = 1

" Syntastic
nmap <Leader>lint :Errors<CR><C-W>j
let g:syntastic_quiet_warnings=1

" JSlint
if has("gui_running")
    let g:JSLintHighlightErrorLine = 0 " kinda annoying
else
    let g:JSLintHighlightErrorLine = 0
endif

" VimOrganizer
let g:org_todo_setup='TODO | DONE'
let g:org_tag_setup='{@home(h) @work(w) @tennisclub(t)} \n {easy(e) hard(d)} \n {computer(c) phone(p)}'

au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufRead,BufNewFile *.org            call org#SetOrgFileType()
au BufRead *.org :PreLoadTags
au BufWrite *.org :PreWriteTags
au BufWritePost *.org :PostWriteTags
au BufRead,BufNewFile *.org            color org_dark

" Taglist
nmap <leader>l :TlistClose<CR>:TlistToggle<CR>
nmap <leader>L :TlistClose<CR>
let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
let Tlist_WinWidth=40               " set the width
let Tlist_Inc_Winwidth=1            " increase window by 1 when growing
let Tlist_Display_Prototype=1
let Tlist_Display_Tag_Scope=0
let Tlist_Use_Right_Window=1

"" LANGUAGE SPECIFIC

" CSS
au FileType css set expandtab tabstop=2 shiftwidth=2
au FileType css nnoremap <leader>sort ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" HTML
" allow for long lines
au FileType html,xhtml set formatoptions+=tl
" folding
au FileType html,xhtml set foldmethod=indent smartindent
au FileType html,xhtml set expandtab tabstop=3 shiftwidth=3
au FileType xhtml,xml so $HOME/.vim/ftplugin/html_autoclosetag.vim

" Load the current buffer in Default Web Browser or Firefox
au Filetype html,xhtml nmap <leader>pv : call PreviewInBrowser()<CR>
func! PreviewInBrowser()
    if has("mac")
        exec "!open %"
    else
        exec "!xdg-open %"
    endif
endfunc

" LESS
au BufNewFile,BufRead *.less set ft=less

" Ruby
au FileType ruby setlocal ts=2 sts=2 sw=2 noexpandtab foldmethod=syntax

" Python
au FileType python set noexpandtab

" JavaScript
au FileType javascript setlocal ts=4 sts=4 sw=4
au BufRead,BufNewFile *.json set ft=json

"" STATUS LINE

set laststatus=2 " always hide the statusline
set statusline= " clear the statusline for when vimrc is reloaded
set statusline+=%-2.2n\  " buffer number
set statusline+=%f\  " tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h "help file flag
set statusline+=%y\  "filetype
set statusline+=%r "read only flag
set statusline+=%m  "modified flag

" display the filesize
set statusline+=[%{FileSize()}]
set statusline+=\ 
" display current git branch
set statusline+=%{fugitive#statusline()}
set statusline+=\ 
" display a warning with Syntastic, of validation errors and syntax checkers
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set statusline+=%=  "left/right separator

set statusline+=%c, " cursor column
set statusline+=%l/%L " cursor line/total lines
set statusline+=\ %P\  " percent through file
set laststatus=2  " always show status line

function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes . " Bytes"
    else
        return (bytes / 1024) . "kB"
    endif
endfunction

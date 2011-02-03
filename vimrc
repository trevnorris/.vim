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
set showmode                                   " display the mode you're in
set history=500                                " sets how many lines of history VIM has to remember
set undolevels=500
set scrolloff=3                                " show 3 lines of context around the cursor
set autoread                                   " set to auto read when a file is changed from the outside
set visualbell                                 " Use visual bell
set mousehide                                  " hide mouse cursor when typing
set mouse=a                                    " allow for full mouse support
set autowriteall                               " write all buffers when switching
set number                                     " show line numbers
set showcmd                                    " show typed commands

set wildmenu                                   " turn on WiLd menu
set wildmode=list:longest,list:full            " activate TAB auto-completion for file paths
set wildignore+=*.o,.git

set ruler                                      " always show current position
set cmdheight=1                                " the commandbar height
set backspace=indent,eol,start                 " set backspace config, backspace as normal
set whichwrap+=<,>,h
set nomodeline "security
set title                                      " set the terminal title
set termencoding=utf8
set encoding=utf8

set hlsearch                                   " highlight search things
set incsearch                                  " go to search results as typing
set smartcase                                  " but case-sensitive if expression contains a capital letter.
set ignorecase                                 " ignore case when searching
set gdefault "assume global when searching or substituting
set magic                                      " set magic on, for regular expressions
set showmatch                                  " show matching brackets when text indicator is over them

set mat=2                                      " how many tenths of a second to blink
set lazyredraw                                 " don't redraw screen during macros
set ttyfast                                    " improves redrawing for newer computers
set fileformats=unix,mac,dos
set spelllang=en,es                            " set spell check language

set nobackup                                   " prevent backups of files, since using versioning mostly and undofile
set nowritebackup
set noswapfile
set directory=~/.vim/.swp,/tmp " swap directory
if v:version >= 703
    " undo - set up persistent undo
    set undofile
    set undodir=$HOME/.vim/.undo
endif

set shiftwidth=4 " set tab width
set softtabstop=4
set tabstop=4
set smarttab
set expandtab
set autoindent " set automatic code indentation
set copyindent

set wrap " wrap lines
set linebreak " this will not break whole words while wrap is enabled
set showbreak=…

" COLOR SCHEME
set term=xterm-256color " allow for more color
if &t_Co >= 256 || has("gui_running")
    colorscheme molokai
endif

" FOLDING
set foldenable " enable folding
set foldcolumn=2 " add a fold column
set foldmethod=marker " detect triple-{ style fold markers
set foldlevelstart=0 " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart(' ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

set viminfo='20,\"80
set list listchars=tab:\ \ ,trail:· " show · for trailing space, \ \ for trailing tab
set tags+=../tags,../../tags,../../../tags,../../../../tags " look for all the tags files in the recurrent directories

set shell=/bin/zsh " set internal shell
set cursorline " highlight current line
set colorcolumn=115 " show a right margin column
set background=dark

syntax enable " enable syntax highlighting

" ADDITIONAL KEY MAPPINGS

" tame the quickfix window (open/close using ,f)
nmap <silent> <leader>f :QFix<CR>

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

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
" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#
" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//e<cr>:let @/=''<CR>
" turn on spell checking
map <leader>spell :setlocal spell!<cr>

" fast editing of the .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>
" allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null

"" ADDITIONAL AUTOCOMMANDS

" saving when focus lost (after tabbing away or switching buffers)
au FocusLost * :up
" open in last edit place
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

"" CONFLICT MARKERS

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
nmap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<cr>

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

" YankRing
let g:yankring_history_dir = '$HOME/.vim/.tmp'
nmap <leader>r :YRShow<CR>

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
" store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")
" show hidden files, too
let NERDTreeShowHidden=1
" quit on opening files from the tree
let NERDTreeQuitOnOpen=1
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

" Gundo
nnoremap <leader>gun :GundoToggle<CR>

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
"let Tlist_Process_File_Always=1     " process files in the background, even when the TagList window isn't open
"let Tlist_Show_One_File=1           " only show tags from the current buffer, not all open buffers
let Tlist_WinWidth=40               " set the width
let Tlist_Inc_Winwidth=1            " increase window by 1 when growing
let Tlist_Display_Prototype=1
let Tlist_Display_Tag_Scope=0
let Tlist_Use_Right_Window=1

"" LANGUAGE SPECIFIC

" CSS
au FileType css set smartindent foldmethod=indent
au FileType css set expandtab tabstop=2 shiftwidth=2
" sort css properties
au FileType css nnoremap <leader>sort ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
if has("mac")
    map <leader>pik :PickHEX<CR>
else
    map <leader>pik <Esc>:ColorPicker<Cr>a
    vmap <leader>pik <Del><Esc>h:ColorPicker<Cr>a
endif

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
au FileType python set nocindent
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
au FileType python set noexpandtab

" Markdown
" convert markdown to html
au FileType markdown nmap <leader>html :%!markdown 2>/dev/null<CR>
" preview markdown
au Filetype markdown nmap <leader>pv : call MarkdownPreview()<CR>
func! MarkdownPreview()
    exec "w"
    if has("mac")
        exec "!markdown % > /tmp/previewmkd.html && open /tmp/previewmkd.html"
    else
        exec "!markdown % > /tmp/previewmkd.html && firefox /tmp/previewmkd.html"
    endif
endfunc

" JavaScript
au FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
au BufRead,BufNewFile *.json set ft=json
au filetype javascript setlocal foldmethod=marker foldmarker={,}


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
set statusline+=%m\  "modified flag

" display the filesize
set statusline+=[%{FileSize()}]\

" display current git branch
set statusline+=%{fugitive#statusline()}\

set statusline+=%{StatuslineTrailingSpaceWarning()}

" display a warning with Syntastic, of validation errors and syntax checkers
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=  "left/right separator

" display the name of the function or variable generated by ctags
set statusline+=[%{Tlist_Get_Tagname_By_Line()}]\

set statusline+=%{StatuslineCurrentHighlight()}\ \  " current highlight
set statusline+=%c, " cursor column
set statusline+=%l/%L " cursor line/total lines
set statusline+=\ %P\  " percent through file
set laststatus=2  " always show status line

" if we have a BOM, always honour that rather than trying to guess.
if &fileencodings !~? "ucs-bom"
    set fileencodings^=ucs-bom
endif
" always check for UTF-8 when trying to determine encodings.
if &fileencodings !~? "utf-8"
    let g:added_fenc_utf8 = 1
    set fileencodings+=utf-8
endif
" make sure we have a sane fallback for encoding detection
if &fileencodings !~? "default"
    set fileencodings+=default
endif

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

function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

" return a warning for "long lines" where "long" is either &textwidth or 80 (if
" no &textwidth is set)
"
" return '' if no long lines
" return '[#x,my,$z] if long lines are found, were x is the number of long
" lines, y is the median length of the long lines and z is the length of the
" longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

" return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

" find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

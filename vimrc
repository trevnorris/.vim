set nocompatible " use full Vim

" PATHOGEN
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

" COLOR SCHEME
colorscheme jellybeans
if has("gui_running")
    colorscheme jellyx
endif

" CONFIGURATION MAPPING

set showmode " display the mode you're in
set history=500 " sets how many lines of history VIM has to remember
set scrolloff=3 " show 3 lines of context around the cursor
set autoread " set to auto read when a file is changed from the outside
set visualbell " Use visual bell
set autochdir " automatically use the current file's directory as the working directory
set foldenable " enable code folding
set mousehide " hide mouse cursor when typing
set mouse=a " allow for full mouse support
set autowriteall " write all buffers when switching
set undolevels=999
set number " show line numbers
set showcmd " show typed commands

set wildmenu " turn on WiLd menu
set wildmode=list:longest,list:full " activate TAB auto-completion for file paths
set wildignore+=*.o,.git

set ruler " always show current position
set cmdheight=1 " the commandbar height
set backspace=indent,eol,start " set backspace config, backspace as normal
set whichwrap+=<,>,h
set title " set the terminal title
set ignorecase " ignore case when searching
set encoding=utf8
set smartcase " but case-sensitive if expression contains a capital letter.
set hlsearch " highlight search things
set incsearch " go to search results as typing
set magic "set magic on, for regular expressions
set showmatch " show matching brackets when text indicator is over them
set mat=2 " how many tenths of a second to blink
set lazyredraw " don't redraw screen during macros
set ttyfast " improves redrawing for newer computers
set fileformats=unix,mac,dos
set spelllang=en,es " set spell check language

set nobackup " prevent backups of files, since using versioning mostly
set nowritebackup
set noswapfile
set directory=~/.vim/swapfiles,/var/tmp,/tmp,. " swap directory

if v:version >= 703
    " undo - set up persistent undo
    set undofile
    set undodir=$HOME/.vim/undodir
endif

set shiftwidth=4 " set tab width
set softtabstop=4
set tabstop=4
set smarttab
set expandtab

set autoindent " set automatic code indentation
set cindent
set smartindent

set linebreak " this will not break whole words while wrap is enabled
set wrap " wrap lines
set formatprg=par
set foldcolumn=2 " fold column width
set showbreak=…

set viminfo='1000,f1,:1000,/1000
set list listchars=tab:\ \ ,trail:· " show · for trailing space, \ \ for trailing tab
set tags+=../tags,../../tags,../../../tags,../../../../tags " look for all the tags files in the recurrent directories

set shell=/bin/zsh " set internal shell
set cursorline " highlight current line
set colorcolumn=115 " show a right margin column
set term=xterm-256color " allow for more color
set t_Co=256
set background=dark

filetype plugin indent on " enable file plugin
syntax enable " enable syntax highlighting

let mapleader = ","
let g:mapleader = ","

"" ADDITIONAL KEY MAPPINGS

" fast saving
nmap <leader>w :up<cr>
" fast escaping
imap jj <ESC>
" fast editing of the .vimrc
map <leader>ev :e $MYVIMRC<cr>
" clear highlight
nnoremap <leader><space> :noh<cr>
" display hidden non printable characters
nmap <leader>l :set list!<CR>
" re hardwrap text
nnoremap <leader>q gqip
" map Y to match C and D
nmap Y y$
" yank entire file (global yank)
nmap gy ggVGy
" allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null
" ignore lines when going up or down
nnoremap j gj
nnoremap k gk
" move around matching bracket pairs
nnoremap <tab> %
vnoremap <tab> %
" set tabwidth on fly
map <leader>t2 :setlocal shiftwidth=2<cr>
map <leader>t4 :setlocal shiftwidth=4<cr>
map <leader>t8 :setlocal shiftwidth=4<cr>
" auto complete {} indent and position the cursor in the middle line
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()
inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []
" fast window switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>, <C-W>w
" close all the buffers
map <leader>ba :1,300 bd!<cr>
" cycle between buffers
map <right> :bn<cr>
map <left> :bp<cr>
map <leader>b :b#<cr>
" change directory to current buffer
map <leader>cd :cd %:p:h<cr>
" move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv
" strip all trailing whitespace in the current file
nnoremap <leader>nw :%s/\s\+$//e<cr>:let @/=''<CR>
" turn on spell checking
map <leader>spl :setlocal spell!<cr>
" spell checking shortcuts
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"" ADDITIONAL AUTOCOMMANDS

" when vimrc is edited, reload it
autocmd bufwritepost .vimrc source $MYVIMRC
" saving when focus lost (after tabbing away or switching buffers)
au FocusLost * :up
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

"" PLUGIN SETTINGS

" NERDTree
let NERDTreeIgnore=['\~$'] " ignore files ending in ~
map <leader>n :NERDTreeToggle<cr>
" autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
" disable netrw's autocmd, since we're ALWAYS using NERDTree
runtime plugin/netRwPlugin.vim
augroup FileExplorer
  au!
augroup END
let g:NERDTreeHijackNetrw = 0
" if the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  if isdirectory(a:directory)
    call ChangeDirectory(a:directory)
  endif
endfunction
" NERDTree utility function
function s:UpdateNERDTree(stay)
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      NERDTree
      if !a:stay
        wincmd p
      end
    endif
  endif
endfunction
" utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction
function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif
  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . a:dir
  let stay = exists("a:1") ? a:1 : 1
  call s:UpdateNERDTree(stay)
endfunction

function Touch(file)
  execute "!touch " . a:file
  call s:UpdateNERDTree(1)
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . a:file
  endif
endfunction

function Edit(file)
  if exists("b:NERDTreeRoot")
    wincmd p
  endif

  execute "e " . a:file

ruby << RUBY
  destination = File.expand_path(VIM.evaluate(%{system("dirname " . a:file)}))
  pwd         = File.expand_path(Dir.pwd)
  home        = pwd == File.expand_path("~")

  if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
    VIM.command(%{call ChangeDirectory(system("dirname " . a:file), 0)})
  end
RUBY
endfunction

" define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")
call s:DefineCommand("e", "Edit")

" Command-T
let g:CommandTMaxHeight=20

" Ack
set grepprg=ack
nnoremap <leader>a :Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" CoffeeScript
let coffee_compile_on_save = 1

" Syntastic
nmap <Leader>lint :Errors<CR><C-W>j
"let g:syntastic_enable_signs=1
"let g:syntastic_quiet_warnings=1

" JSlint
if has("gui_running")
    let g:JSLintHighlightErrorLine = 1
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
let Tlist_Close_On_Select = 1 " close taglist window once we selected something
let Tlist_Exit_OnlyWindow = 1 " if taglist window is the only window left, exit vim
let Tlist_Show_Menu = 1 " show Tags menu in gvim
let Tlist_Show_One_File = 1 " show tags of only one file
let Tlist_GainFocus_On_ToggleOpen = 1 " automatically switch to taglist window
let Tlist_Highlight_Tag_On_BufEnter = 1 " highlight current tag in taglist window
let Tlist_Process_File_Always = 1 " taglist window on the right
let Tlist_Display_Prototype = 1 " display full prototype instead of just function name
nnoremap <F5> :TlistToggle<CR>
nnoremap <F6> :TlistShowPrototype<CR>

"" LANGUAGE SPECIFIC

" CSS
au FileType css set smartindent foldmethod=indent
au FileType css set noexpandtab tabstop=2 shiftwidth=2
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
au FileType html,xhtml set noexpandtab tabstop=3 shiftwidth=3
au BufWritePost,FileWritePost *.html call JavaScriptLint()
au FileType html,xhtml,xml so ~/.vim/ftplugin/html_autoclosetag.vim
" Expand compressed HTML with Tidy
map <leader>td :%!tidy -q -config ~/.vim/tidy.conf --tidy-mark 0 2>/dev/null<CR><ESC>gg=G
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
au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent
au BufRead,BufNewFile *.json set ft=json

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

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

" display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

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

autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

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

" return '[&et]' if &et is set wrong
" return '[mixed-indenting]' if spaces and tabs are used to indent
" return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
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

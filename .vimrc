"
" Personal preference .vimrc file
" Maintained by Vincent Driessen <vincent@datafox.nl>
"
" My personally preferred version of vim is the one with the "big" feature
" set, in addition to the following configure options:
"
"     ./configure --with-features=BIG
"                 --enable-pythoninterp --enable-rubyinterp
"                 --enable-enablemultibyte --enable-gui=no --with-x --enable-cscope
"                 --with-compiledby="Vincent Driessen <vincent@datafox.nl>"
"                 --prefix=/usr
"
" To start vim without using this .vimrc file, use:
"     vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
"

" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

" Configure plug.vim
let vimautoloaddir='~/.vim/autoload'

call plug#begin()

" This is taking care of the plugins
Plug 'junegunn/vim-plug'

Plug 'preservim/nerdtree'

" Automatically detect indentation
Plug 'tpope/vim-sleuth'

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

Plug 'vim-scripts/YankRing.vim'

Plug 'vim-scripts/Gundo'

Plug 'sjbach/lusty'

Plug 'rstacruz/sparkup', {'rtp': 'vim/'}

Plug 'OmniSharp/omnisharp-vim'

Plug 'kien/rainbow_parentheses.vim'

Plug 'mechatroner/rainbow_csv'

Plug 'airblade/vim-gitgutter'

Plug 'WolfgangMehner/vim-plugins', {'trp': 'plugin'}

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" Shift + F1-F4 are detected incorrectly, Shift + F5 onwards detect correctly.
" Shift + F10 is unavailable due to X or Gnome context menu mapping. Override
" may be possible, but no need to investigate at present.
" Manually set Shifted F keys to ensure proper operation.
set <S-F1>=O1;2P
set <S-F2>=O1;2Q
set <S-F3>=O1;2R
set <S-F4>=O1;2S

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
""filetype off                    " force reloading *after* pathogen loaded
""call pathogen#helptags()
""call pathogen#runtime_append_all_bundles()
""filetype plugin indent on       " enable detection, plugins and indenting in one step
""filetype plugin on

" Change the mapleader from \ to ,
let mapleader=","

" Editing behaviour {{{
set showmode                    " always show what mode we're currently editing in
"set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
"set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
let &listchars='tab:▸\ ,trail:·,nbsp:·,extends:#'

set nolist                      " don't show invisible characters by default,
                                " but it is enabled for some file types (see later)
set pastetoggle=<F12>            " when in insert mode, press <F12> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
"set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
"nnoremap / /\v
"vnoremap / /\v

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" }}}

" Folding rules {{{
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=0            " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()
" }}}

" Editor layout {{{
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set cmdheight=2                 " use a status bar that is 2 rows high

let g:airline_detect_modified=1
let g:airline_powerline_fonts=1
"let g:airline_enable_branch=1
let g:airline#extensions#branch#enabled=1
" }}}

function! WordCount()
  let s:old_status = v:statusmsg
  let position = getpos(".")
  exe ":silent normal g\<c-g>"
  let stat = v:statusmsg
  let s:word_count = 0
  if stat != '--No lines in buffer--'
    let s:word_count = str2nr(split(v:statusmsg)[11])
    let v:statusmsg = s:old_status
  end
  call setpos('.', position)
  return s:word_count
endfunction

function! WC()
  if &modified || !exists("b:wordcount")
    let l:old_status = v:statusmsg
    execute "silent normal g\<c-g>"
    let b:wordcount = str2nr(split(v:statusmsg)[11])
    let v:statusmsg = l:old_status
    return b:wordcount
  else
    return b:wordcount
  endif
endfunction

" Vim behaviour {{{
set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
set directory=~/.vim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
"set visualbell                  " don't beep
"set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set nomodeline                  " disable mode lines (security measure)
"set ttyfast                     " always use a fast terminal
set cursorline                  " underline the current line, for quick orientation

" Replicate Firefox tab key commands
map <C-S-]> gt
map <C-S-[> gT
map <C-tab> gt
map <C-S-tab> gT
map <C-0> :tablast<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Tame the quickfix window (open/close using ,f)
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
" }}}

set t_Co=256
" Highlighting {{{
if &t_Co >= 256 || has("gui_running")
"   colorscheme molokai
   colorscheme desert
endif

if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors
endif
" }}}

" Shortcut mappings {{{
" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, since we don't have to press that annoying Shift key that
" slows the commands down
nnoremap ; :

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>

" <F4> closes current buffer - Shift <F4> closes buffer regardless of whether
" changes have been saved
nmap <F4> :bd<CR>
nmap <S-F4> :bd!<CR>

" Quickly close the current window
nnoremap <leader>q :q<CR>

" Use Q for formatting the current paragraph (or visual selection)
vmap Q gq
nmap Q gqap

" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Shortcut to make
nmap mk :make<CR>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Use the damn hjkl keys
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
noremap <up> gk
noremap <down> gj

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

map <S-Up> <C-w>k
map <S-Down> <C-w>j
map <S-Left> <C-w>h
map <S-Right> <C-w>l

" Cycle through windows
map <S-Tab> <C-w>w

map <C-w>, <C-w><
map <C-w>. <C-w>>

" Complete whole filenames/lines with a quicker shortcut key in insert mode
imap <C-f> <C-x><C-f>
imap <C-l> <C-x><C-l>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" Quick yanking to the end of the line
nmap Y y$

" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P

" YankRing stuff
let g:yankring_history_dir = '$HOME/.vim/.tmp'
nmap <leader>r :YRShow<CR>

" Edit the vimrc file
nmap <leader>ev :tabedit $MYVIMRC<CR>

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>
inoremap jk <Esc>

" Quick alignment of text
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Scratch
nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Folding
nnoremap <Space> za
vnoremap <Space> za

" Add fold between currently selected brace and it's matching pair.
nnoremap { zfa{
nnoremap } zfa{

" Strip all trailing whitespace from a file, using ,w
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Run Ack fast (mind the trailing space here, wouldya?)
nnoremap <leader>a :Ack 

" Creating folds for tags in HTML
"nnoremap <leader>ft Vatzf

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" Gundo.vim
nnoremap <F5> :GundoToggle<CR>

" Spell Check
:autocmd FileType tex noremap <F6> :w<CR> :!/usr/bin/hunspell -l -t -i utf-8 %<CR>
:highlight SpellBad term=reverse ctermbg=17 gui=undercurl guisp=Red ctermfg=015
" Compile LaTeX file
:autocmd FileType tex noremap <F8> :w<CR> :!make<CR>
":autocmd FileType tex noremap <F8> :w<CR> :!/usr/bin/pdflatex --shell-escape %<CR>
":autocmd FileType tex noremap <F7> :w<CR> :!/usr/bin/pdflatex --shell-escape %<CR>
:autocmd FileType tex noremap <F7> :w<CR> :!/cygdrive/c/texlive/2020/bin/win32/pdflatex --shell-escape %<CR>

:autocmd FileType java nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
:autocmd FileType java nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
:autocmd FileType java nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>

:autocmd FileType lua noremap <F7> :w<CR> :!love ./<CR>
" }}}

" NERDTree settings {{{
" Put focus to the NERD Tree with F3 (tricked by quickly closing it and
" immediately showing it again, since there is no :NERDTreeFocus command)
nmap <leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nmap <leader>N :NERDTreeClose<CR>

nmap <F2> :NERDTreeClose<CR>:NERDTreeToggle<CR>
nmap <S-F2> :NERDTreeClose<CR>

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree
let NERDTreeQuitOnOpen=1

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to open
" files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$' ]

" }}}

" Managing buffers with LustyJuggler {{{
map ,b :LustyJuggler<CR>
map <F3> :LustyJuggler<CR>
" }}}

" TagList settings {{{
nmap <leader>l :TlistClose<CR>:TlistToggle<CR>
nmap <leader>L :TlistClose<CR>

" quit Vim when the TagList window is the last open window
let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
"let Tlist_Process_File_Always=1     " process files in the background, even when the TagList window isn't open
"let Tlist_Show_One_File=1           " only show tags from the current buffer, not all open buffers
let Tlist_WinWidth=40               " set the width
let Tlist_Inc_Winwidth=1            " increase window by 1 when growing

" shorten the time it takes to highlight the current tag (default is 4 secs)
" note that this setting influences Vim's behaviour when saving swap files,
" but we have already turned off swap files (earlier)
"set updatetime=1000

" the default ctags in /usr/bin on the Mac is GNU ctags, so change it to the
" exuberant ctags version in /usr/local/bin
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" show function/method prototypes in the list
let Tlist_Display_Prototype=1

" don't show scope info
let Tlist_Display_Tag_Scope=0

" show TagList window on the right
let Tlist_Use_Right_Window=1

" }}}

" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nmap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")
    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end "}}}

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}

    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        autocmd BufNewFile,BufRead *.html,*.htm call s:DetectHTMLVariant()

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
        autocmd filetype html,htmldjango let b:closetag_html_style=1
        autocmd filetype html,xhtml,xml source ~/.vim/scripts/closetag.vim

        " Enable Sparkup for lightning-fast HTML editing
        "source ~/.vim/bundle/sparkup/vim/ftplugin/html/sparkup.vim
        let g:sparkupExecuteMapping = '<leader>e'
"        map <leader>e g:sparkupExecuteMapping<CR> :<ESC>
    augroup end " }}}

    augroup php_files "{{{
        au!
        au BufRead *.php set ft=php.html
        au BufNewFile *.php set ft=php.html
        au BufRead *.ctp set ft=php.html
        au BufNewFile *.ctp set ft=php.html

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
"        autocmd filetype html,htmldjango let b:closetag_html_style=1
        autocmd filetype html,xhtml,xml,php source ~/.vim/scripts/closetag.vim

        " Enable Sparkup for lightning-fast HTML editing
        "source ~/.vim/bundle/sparkup/vim/ftplugin/html/sparkup.vim
        let g:sparkupExecuteMapping = '<leader>e'

    augroup end " }}}

    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd filetype python setlocal textwidth=80
        autocmd filetype python match ErrorMsg '\%>80v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python map <buffer> <F8> :w<CR>:!python3 %<CR>
        autocmd filetype python imap <buffer> <F8> <Esc>:w<CR>:!python3 %<CR>
        autocmd filetype python map <buffer> <S-F8> :w<CR>:!ipython3 %<CR>
        autocmd filetype python imap <buffer> <S-F8> <Esc>:w<CR>:!ipython3 %<CR>

        " Run a quick static syntax check every time we save a Python file
"        autocmd BufWritePost *.py call Pyflakes()
    augroup end " }}}

    augroup ruby_files "{{{
        au!

        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
        "autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup textile_files "{{{
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment

        autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    augroup end "}}}

    augroup tex_files "{{{
        au!
        au BufRead *.tex set ft=tex
        au BufNewFile *.tex set ft=tex
        au BufRead *.cls set ft=tex
        au BufNewFile *.cls set ft=tex
        autocmd filetype tex setlocal spell

    augroup end "}}}

    augroup java "{{{
        au!
    augroup end "}}}

    augroup cs "{{{
        "let g:Omnisharp_start_server = 0
        "autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
        "autocmd FileType cs BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
        " automatic syntax check on events (TextChanged requires Vim 7.4)
        autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

        autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
        autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
        autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
        autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
        autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
        "finds members in the current buffer
        autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
        " cursor can be anywhere on the line containing an issue
        autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
        autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
        autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
        autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
        "navigate up by method/property/field
        autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
        "navigate down by method/property/field
        autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

        " Contextual code actions (requires CtrlP or unite.vim)
        nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
        " Run code actions with text selected in visual mode to extract method
        vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>
    augroup end "}}}
endif
" }}}

" Skeleton processing {{{

if has("autocmd")

    if !exists('*LoadTemplate')
    function LoadTemplate(file)
        " Add skeleton fillings for Python (normal and unittest) files
        if a:file =~ 'test_.*\.py$'
            execute "0r ~/.vim/skeleton/test_template.py"
        elseif a:file =~ '.*\.py$'
            execute "0r ~/.vim/skeleton/template.py"
        endif
    endfunction
    endif

    autocmd BufNewFile * call LoadTemplate(@%)

endif " has("autocmd")

" }}}

" Restore cursor position upon reopening files {{{
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }}}

" Common abbreviations / misspellings {{{
"source ~/.vim/autocorrect.vim
" }}}

" Extra vi-compatibility {{{
" set extra vi-compatible options
"set cpoptions+=$     " when changing a line, don't redisplay, but put a '$' at
                     " the end during the change
set formatoptions-=o " don't start new lines w/ comment leader on pressing 'o'
au filetype vim set formatoptions-=o
                     " somehow, during vim filetype detection, this gets set
                     " for vim files, so explicitly unset it again
" }}}

" Extra user or machine specific settings {{{
" Insert a newline after each specified string (or before if use '!').
" If no arguments, use previous search.
command! -bang -nargs=* -range LineBreakAt <line1>,<line2>call LineBreakAt('<bang>', <f-args>)
function! LineBreakAt(bang, ...) range
  let save_search = @/
  if empty(a:bang)
    let before = ''
    let after = '\ze.'
    let repl = '&\r'
  else
    let before = '.\zs'
    let after = ''
    let repl = '\r&'
  endif
  let pat_list = map(deepcopy(a:000), "escape(v:val, '/\\.*$^~[')")
  let find = empty(pat_list) ? @/ : join(pat_list, '\|')
  let find = before . '\%(' . find . '\)' . after
  " Example: 10,20s/\%(arg1\|arg2\|arg3\)\ze./&\r/ge
  execute a:firstline . ',' . a:lastline . 's/'. find . '/' . repl . '/ge'
  let @/ = save_search
endfunction
"source ~/.vim/user.vim
" }}}

" Creating underline/overline headings for markup languages
" Inspired by http://sphinx.pocoo.org/rest.html#sections
nnoremap <leader>1 yyPVr#jyypVr#
nnoremap <leader>2 yyPVr*jyypVr*
nnoremap <leader>3 yypVr=
nnoremap <leader>4 yypVr-
nnoremap <leader>5 yypVr^
nnoremap <leader>6 yypVr"

iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

if has("gui_running")
    set guifont=Inconsolata:h14
    "colorscheme baycomb
    "colorscheme mustang
"    colorscheme molokai
    colorscheme desert

    " Remove toolbar, left scrollbar and right scrollbar
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R

    " Screen recording mode
    function! ScreenRecordMode()
        set columns=86
        set guifont=Droid\ Sans\ Mono:h14
        set cmdheight=1
"        colorscheme molokai_deep
        colorscheme desert
    endfunction
    command! -bang -nargs=0 ScreenRecordMode call ScreenRecordMode()
endif

" Rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>
nmap <F9> :RainbowParenthesesToggle<CR>

if exists("g:btm_rainbow_color") && g:btm_rainbow_color
    call rainbow_parentheses#LoadSquare ()
    call rainbow_parentheses#LoadRound ()
    call rainbow_parentheses#LoadBraces ()
    call rainbow_parentheses#Activate ()
endif

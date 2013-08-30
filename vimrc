" vim:fdm=marker
" ---------------------------------------
" Jesus Pardillo's Vim Configuration File
" ---------------------------------------
" Cheat sheet {{{
" <Esc>K: man page for current word
" Tabbing ----------------------------------------------------------------
" (INSERT) <Ctrl>+o: go to normal mode for one command, then return to Insert
"                    mode
" gi : open insert mode in last insert point
" `[ : put cursor in the exact ping of last change
" vim -p <file>* : open files in tabs
"
" commands has auto completion by pressing <Tab>
" <C>-v : block visual mode
" v : char visual mode
" V : line visual mode
" I<char><ESC> : insert <char> at the beginning of the line(s), useful for
"                comments
" :abbreviate abbr sentence : subs abbr by sentence while your write
" :e <file> : edit a file
" :tabe <file> : edit a file in a tab
" :tabs : list tabs
" :tn or :tabn : go to next tab
" :tp or :tabp : go to previous tab
" :tabdo COMMAND : do a command on all tabs, e.g., replace a string
" :buffers : list buffers
" :b<n> : go to a buffer
" :bn or :bnext : go to next buffer
" :bp or :bprevious : go to previous buffer
" :bd[<n>] : delete a buffer
" :gf : go to the filename under the cursor
" * # : search forward/backward for the word under the cursor
" h l k j : go left/right/up a line/down a line
" 0 ^ $ : go to the start of line/first character of line/end of line
"
" "[a-z](yy|p) : yank/paste a-z register 
" :reg : list registers
" [1-9]p : paste the n-last yank
"
" (INSERT) <Ctrl>-N <Ctrl>-P : try to complete the current word with the first
"                              match (searching fwd or bwd) in the current file.
" . : repeat the last change
" % : jump to a matching opening or closing parenthesis, square bracket or curly
"     brace
" == : indent the current line
" ]p : paste indent
" =vG : indent from the cursor to the last line
" =v} : indent from the cursor to the end of the current block
" (VISUAL, <Shift-V>) = : indent lines
" u : undo a change
" <Ctrl>-R : redo an undone change
" U : return the current line to its original state
" g- g+ : go between text-states
" :earlier 1m : go to a text state 1 minute earlier
"
" /<pattern> ?<pattern> : search forward / backward
" q[a-z] : start recording a macro
" (Normal) q : stops recording a macro
" @[a-z] : replay a recorded macro
" <Ctrl>-X O : complete the current word
" (Vim 7.3) :X : encrypt a buffer, when reopen, the password will be requested
"
" <C-Left_MouseClick> : go to definition
" <C-Right_MouseClick> : jump back from definition (stacked)
"
" Explore **/*.xyz : explore files matching the pattern to open one
" Find *.xyz : similar command
" args **/*.[ch] : open files matching the pattern
" r!<command> : read output from a shell command
" }}}
" General {{{
set nocompatible " stops crying when no vi-compatible feature is called

set backspace=indent,eol,start " make backspace a more flexible
set backup " make backup files
set backupdir=~/.vim/backup,~/.backup,~/backup      " where to put backup files
set directory=~/.vim/tmp,~/.tmp,~/tmp,/var/tmp,/tmp " where to place swap files in

set hidden " buffers can be changed without saving

set mouse=a " use mouse everywhere

set wildmenu " turn on command line completion wild style
set wildignore=*.o,*.a,*.bak,*.o.d,*/target/*,*.orig
set wildmode=list:longest " turn on wild mode huge list

set whichwrap+=<,>,[,]
set nowrap " do not wrap line

filetype plugin on " enable file type detection, plus loading of file type plug-ins

" Vim 7.3: persistent undo (:help new-persistent-undo
"set undodir=~/.vim/undodir
"set undofile
"set undolevels = 1000  " maximum number of changes that can be undone
"set undoreload = 10000 " maximum number lines to save for undo on a buffer reload

autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

set hidden " allow edited buffers that aren't visible in a window somewhere

"set shortmess=atI " remove "Press ENTER or type command to continue" prompt
set shortmess=aOstT " shotens messages to avoid 'press a key' prompt

set visualbell " stop emitting an obnoxious noise!

set history=1000 " remember the last ... commands

runtime macros/matchit.vim " % switch between opening & closing bracketsj

set title " set the title in console

set scrolloff=2 " scrolling ... lines near borders

let mapleader = ","
nore . :
   " save your muscles by just typing '.' instead of ':' (for commands)

" set noexrc " don't use local version of .(g)vimrc, .exrc
" set autochdir " always switch to the current file directory
set clipboard+=unnamed " share windows clipboard
let g:clipbrdDefaultReg = '+' " clipboard for linux
set fileformats=unix,dos,mac " support all three, in this order

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
      \ if expand("<afile>:p:h") !=? $TEMP |
      \   if line("'\"") > 1 && line("'\"") <= line("$") |
      \     let JumpCursorOnEdit_foo = line("'\"") |
      \     let b:doopenfold = 1 |
      \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
      \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
      \        let b:doopenfold = 2 |
      \     endif |
      \     exe JumpCursorOnEdit_foo |
      \   endif |
      \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
      \ if exists("b:doopenfold") |
      \   exe "normal zv" |
      \   if(b:doopenfold > 1) |
      \       exe  "+".1 |
      \   endif |
      \   unlet b:doopenfold |
      \ endif
augroup END

set nowrapscan " incremental search stops at the end of the file

setlocal autoread " check automatically if the file has changed externally
" }}}
" Syntax {{{
syntax on
if v:version >= 600
   filetype on
   filetype indent on
else
   filetype on
endif

if has('gui_running')
  colorscheme wombat " jellybeans
else
  colorscheme jellybeans
endif

" set textwidth=80 " break lines? too much enforcing
set expandtab
set smarttab
set tabstop=3     " real tabs should be ..., and they will show with set list on
set shiftwidth=3  " auto-indent amount when using cindent, >>, << and stuff like that
set softtabstop=3 " when hitting tab or backspace, how many spaces should a tab be
set autoindent
set modeline " TODO required?

set background=dark " we plan to use a dark background

" highlight ugly tabs!
" TODO FIXME this do not work! :P
syntax match TODO /\t/
hi TODO gui=underline guifg=blue ctermbg=blue
syntax match TODO /\s\+$/ " trailing whitespaces
" autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespaces
set listchars=tab:>-,trail:· " catch trailing whitespaces
set list " show tabs

set report=0 " tell us when anything is changed via :...

set nospell
"set spelllang=es
set spellsuggest=25

"if $COLORTERM == 'gnome-terminal'
"	set t_Co=256 | colorscheme jellybeans
"endif

set foldmethod=syntax " folds are done by syntax, other values: indent
set foldlevel=20      " high enough
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview
" }}} Syntax
" {{{ Key Bindings
imap jj <Esc>

" maps for searching
map <space> /
map <c-space> ?

" maps for quickfix
map <leader>n :cn<cr>
map <leader>p :cp<cr>
map <leader>c :botright cw 10<cr>

"inoremap <Up>    <NOP>
"inoremap <Down>  <NOP>
"inoremap <Left>  <NOP>
"inoremap <Right> <NOP>
"noremap  <Up>    <NOP>
"noremap  <Down>  <NOP>
"noremap  <Left>  <NOP>
"noremap  <Right> <NOP>

" cycling windows (<ESC><C-W>w cycles in the opposite direction)
nnoremap <silent> <leader>w <C-W>w 
vnoremap <silent> <leader>w <C-W>w

"nmap <F3> :FindFile<CR>
nnoremap <silent> <leader>e :CtrlP<CR>
nnoremap <silent> <leader>r :CtrlPMRU<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nmap <silent> <leader>s :set nolist!<CR>

" I don't use tabs... yet!
"map <C-right> <Esc>:tabn<CR>
"map <C-left> <Esc>:tabp<CR>

" figure out whether you want to place a word there or an actual tabs
function! Mosh_Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
endfunction
inoremap <Tab> <C-R>=Mosh_Tab_Or_Complete()<CR>

" NERD Tree
nmap <silent> <leader>t :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0 " due to terminal issues with encoding arrows

" open/close the taglistwindow
map    <F12> :TlistToggle<CR>
" Tagbar
nmap <C-F12> :TagbarToggle<CR>

" build tags of your own project with Ctrl-F12
if filereadable($PROJECT . '/tags')
   map <F11> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q -f $PROJECT . '/tags' $PROJECT<CR>:!ctags -R --sort=yes --java-kinds=+cfimp -f $PROJECT . '/tags' $PROJECT<CR>
else
   map <F11> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>:!ctags -R --sort=yes --java-kinds=+cfimp .<CR>
endif

set pastetoggle=<F2> " toggle between paste mode (auto-indent off) and no-paste mode.

" toggle current folding
nnoremap <Space> za
vnoremap <Space> za
" }}}
" {{{ Interface
set showcmd " show the <leader> key appear in the bottom right hand corner
set showmatch " show matching brackets
set showmode

set number       " line numbers left margin
set cursorline   " highlight current line
set ruler        " show cursor position (status bar)

function! InsertStatuslineColor(mode)
   if a:mode == 'i'
   hi statusline guibg=Green ctermfg=Black guifg=Black ctermbg=Green
   elseif a:mode == 'r'
   hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
   else
   hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
   endif
   endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15

" status line
set laststatus=2
" TODO colorize statusline
hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#dd3333 guibg=#222222
hi User3 guifg=#ff66ff guibg=#222222
hi User4 guifg=#a0ee40 guibg=#222222
hi User5 guifg=#eeee40 guibg=#222222
"set statusline=
"set statusline +=%1*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
"set statusline +=%4*\ %<%F%*            "full path
"set statusline +=%2*%m%*                "modified flag
"set statusline +=%1*%=%5l%*             "current line
"set statusline +=%2*/%L%*               "total lines
"set statusline +=%1*%4c\ %*             "column number
"set statusline +=%2*0x%04B\ %*          "character under cursor

set statusline=%n%{v:register}\ %<%f%m%r\ \[%{&ff}:%{&fenc}:%Y]%=%c%V,%l\/%L\ 0x%04B\ %P
" TODO change color according mode
" }}}
" {{{ Searching 
set ignorecase " ignore case when you search
set infercase " case inferred by default
set incsearch  " show results while you type
set smartcase  " TODO Document it
set hlsearch   " highlight search matches
" }}}

for f in split(glob('~/.vim/plugin/settings/*.vim'), '\n')
   exe 'source' f
endfor

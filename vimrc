execute pathogen#infect()

set shiftwidth=2    " Use indents of 2 spaces
set tabstop=2       " An indentation every four columns
set softtabstop=2   " Let backspace delete indent
set expandtab       " Convert tab to spaces
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O" command).
set ruler           " Show the line and column number of the cursor position, separated by a comma.
set mouse=a         " Enable the use of the mouse.
set incsearch       " While typing a search command, show immediately where the so far typed pattern matches.
set number          " Show line numbers.
set noerrorbells    " Shut up the beep
set vb              " Visual flash bell bell
set nocompatible    " Disable compatibility with vi
set laststatus=2    " Display the status line always
set statusline=%<\ %t\ %m%r%y%w%{fugitive#statusline()}%=Col:\ \%c\ Lin:\ \%l\/\%L\
set shell=/bin/bash " Used shell for executed commands
set hlsearch        " To highlight all search matches
set nowrap          " Don't wrap lines

:set t_Co=256       " For certain color-limited terminals
filetype on               " Turn on filetype detection
filetype plugin indent on " Turn on indentation
syntax on                 " Turn on syntax on

colorscheme darkblue " My favourite schemecolor

let mapleader=","   " Sets the leader key

set list listchars=tab:..,trail:☠ " Display extra whitespace

" Utilities
cab uniq %s/^\(.*\)\(\n\1\)\+$/\1/

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t
set wildmenu
set wildignore+=.git,.svn
set wildignore+=*.o,*.obj,*.jpg,*.png,*.gif,*.log,*.gz,*.bin,*.gem,*.rbc,*.class
set wildignore+=*.min.js,**/node_modules/**,**/images/**
set wildignore+=**/assets/**/original/**,**/assets/**/thumb/**,**/assets/**/small/**
set wildignore+=tmp,public,vendor/bundle/*,vendor/cache/*,test/fixtures/*,vendor/gems/*,spec/cov,a/*

" Delete without saving it to the registry. (Uses black hole registry)
noremap  x "_x
vnoremap  x "_x

" Keep visual mode after indenting
vmap < <gv
vmap > >gv

" Disable arrow keys
map <up>    <nop>
map <down>  <nop>
map <left>  <nop>
map <right> <nop>

" Set swap and backup directories outside your working directory
" the double slash path at the end allows you to avoid collisions
" opening files with the same name in different directories
set backupdir=~/.vim/tmpdir//,.
set directory=~/.vim/tmpdir//,.

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$', '\.git']
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>

" Command-T configuration
let g:CommandTMaxHeight=20
" nnoremap <silent> <Leader>t :CommandT<CR>
" nnoremap <silent> <Leader>b :CommandTBuffer<CR>

"" Opens a tab edit command with the path of the currently edited file filled in
"" Normal mode: <Leader>t
"map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
"
"" Inserts the path of the currently edited file into a command
"" Command mode: Ctrl+P
"cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
"
"" Hitting F5 will clean out all trailing whitespace or tabs
"nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

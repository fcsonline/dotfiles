call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'christophermca/meta5'
Plug 'plasticboy/vim-markdown'
Plug 'digitaltoad/vim-pug'
Plug 'diepm/vim-rest-console'
Plug 'neomake/neomake'
Plug 'janko-m/vim-test'
Plug 'wincent/ferret'
Plug 'junegunn/goyo.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

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

scriptencoding utf-8
set encoding=utf-8

colorscheme meta5 " My favourite schemecolor

let mapleader=" "   " Sets the leader key

set list listchars=tab:..,trail:☠ " Display extra whitespace

" Paste mode toggler
set pastetoggle=<leader>p

" Undo file
set undofile
set undodir=~/.vim/undodir/

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

" Remove the highlighted search after two esc
nnoremap <esc><esc> :noh<return><esc>

" Keep visual mode after indenting
vmap < <gv
vmap > >gv

" Disable arrow keys
map <up>    <nop>
map <down>  <nop>
map <left>  <nop>
map <right> <nop>

" Disable markdown folding
let g:vim_markdown_folding_disabled = 1

" Set swap and backup directories outside your working directory
" the double slash path at the end allows you to avoid collisions
" opening files with the same name in different directories
set backupdir=~/.vim/tmpdir//,.
set directory=~/.vim/tmpdir//,.

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$', '\.git']
map <leader>n :NERDTreeToggle<CR>
map <leader>m :NERDTreeFind<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" Neomake
autocmd! BufReadPost,BufWritePost * Neomake

let g:neomake_ruby_enabled_makers = ['rubocop', 'reek']
let g:neomake_ruby_rubocop_maker = { 'exe': 'bundle', 'args': ['exec', 'rubocop', '--format', 'emacs'] }
let g:neomake_ruby_reek_maker = { 'exe': 'bundle', 'args': ['exec', 'reek'] }
let g:neomake_javascript_enabled_makers = ['eslint']

" FZF
let g:fzf_command_prefix = 'FZF'
let g:fzf_commits_log_options = '--pretty=oneline'

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

nnoremap <leader><space> :FZFFiles<cr>
nnoremap <leader>b :FZFBuffers<cr>

" Sequences
nmap <leader>s :for i in range(1,10) \| put ='192.168.0.'.i \| endfor

" Goyo mode toggler
map <leader>z :Goyo<CR>

" Tell vim to remember certain things when we exit
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Typo aliases
:command WQ wq
:command Wa wa
:command Wq wq
:command W w
:command Q q

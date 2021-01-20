call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'        " File navigator
Plug 'bling/vim-airline'          " Vim fancy status line
Plug 'tpope/vim-surround'         " Surround, wrap or replace code with chars
Plug 'tpope/vim-fugitive'         " Git in vim
" INCOMPATIBLE WITH DELIMATE Plug 'tpope/vim-endwise'          " Complete blocks do/end
Plug 'tpope/vim-commentary'       " Toggle comments
Plug 'tpope/vim-dispatch'         " Asynchronous build and test dispatcher
Plug 'ervandew/supertab'          " Perform all your vim insert mode completions with Tab
Plug 'NLKNguyen/papercolor-theme' " Best colorscheme
Plug 'diepm/vim-rest-console'     " REST console
Plug 'vim-test/vim-test'          " Run test file from vim
Plug 'wincent/ferret'             " Enhanced multi-file search for Vim
Plug 'junegunn/goyo.vim'          " Focus mode for writing
Plug 'Raimondi/delimitMate'       " Auto close special chars {}, [], ()
Plug 'alvan/vim-closetag'         " Auto close xml, html tags
Plug 'thinca/vim-localrc'         " Local vimrc config
Plug 'w0rp/ale'                   " Linter & Async engine for code analysis
Plug 'mattn/emmet-vim'            " Expansions
Plug 'AndrewRadev/switch.vim'     " Switch / Toggle words

Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_disable_startup_warning = 1

let g:polyglot_disabled = [
      \'typescript'
      \'jsx',
      \]

Plug 'sheerun/vim-polyglot'       " Syntax support

Plug 'SirVer/ultisnips'           " Ultimate solution for snippets
Plug 'ap/vim-css-color'           " Colorize hexadecimal colors
Plug 'wellle/targets.vim'         " Modify faster (){}[] contents
Plug 'AndrewRadev/splitjoin.vim'  " Better Split/Join lines
Plug 'rhysd/vim-grammarous'       " Spell and grammar checks
Plug 'mogelbrod/vim-jsonpath'     " Navigating JSON document
Plug 'wellle/targets.vim'         " Add more text objects
Plug 'rodjek/vim-puppet'          " Puppet syntax support

Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim' " Syntax & Typescript support
Plug 'peitalin/vim-jsx-typescript' "Syntax & Typescript support

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy file finder
Plug 'junegunn/fzf.vim'

call plug#end()

" Identation
set tabstop=2      " number of visual spaces per TAB.
set shiftwidth=2   " number of spaces to use for each step of (auto)indent.
set softtabstop=2  " number of spaces in tab when editing.
set shiftround     " round indent to multiple of 'shiftwidth'
set expandtab      " tabs are spaces
set smarttab
set autoindent
set copyindent
set smartindent

set ruler           " Show the line and column number of the cursor position, separated by a comma.
set mouse=a         " Enable the use of the mouse.
set incsearch       " While typing a search command, show immediately where the so far typed pattern matches.
set number          " Show line numbers.
set noerrorbells    " Shut up the beep
set nocompatible    " Disable compatibility with vi
set vb              " Visual flash bell bell
set laststatus=2    " Display the status line always
set statusline=%<\ %t\ %m%r%y%w%{fugitive#statusline()}%=Col:\ \%c\ Lin:\ \%l\/\%L\
set shell=/bin/bash " Used shell for executed commands
set hlsearch        " To highlight all search matches
set nowrap          " Don't wrap lines
set backspace=indent,eol,start " Backspace options

set t_Co=256       " For certain color-limited terminals
filetype on               " Turn on filetype detection
filetype plugin indent on " Turn on indentation
syntax on                 " Turn on syntax on

scriptencoding utf-8
set encoding=utf-8

" My favourite schemecolor
set background=dark
colorscheme PaperColor

autocmd BufWritePre * %s/\s\+$//e " Remove trailing spaces

let test#strategy = "dispatch"
let test#ruby#rspec#executable = 'SKIP_PULL=true /srv/app/bin/container-run bundle exec spring rspec %'

let mapleader=" "   " Sets the leader key

let g:move_key_modifier = 'C' " Move plugin

let delimitMate_matchpairs = "(:),[:],{:}" " Autoclose just some chars

let g:closetag_filenames = '*.html,*.xhtml,*.phtml' " These are the file extensions where this plugin is enabled.
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

set switchbuf=vsplit " Split new buffer in quickfix

set list listchars=tab:..,trail:☠ " Display extra whitespace

" Undo file
set undofile
set undodir=~/.vim/undodir/

" Utilities
cab uniq %s/^\(.*\)\(\n\1\)\+$/\1/

" Decrease vim command timeout
set ttimeout
set ttimeoutlen=100

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

" Move between panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <C-n> <C-W>w

" Natural split
set splitbelow
set splitright

" Disable markdown folding
let g:vim_markdown_folding_disabled = 1

" Set swap and backup directories outside your working directory
" the double slash path at the end allows you to avoid collisions
" opening files with the same name in different directories
set backupdir=~/.vim/tmpdir//,.
set directory=~/.vim/tmpdir//,.
set backupcopy=yes

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$', '\.git$']
map <leader>n :NERDTreeToggle<CR>
map <leader>m :NERDTreeFind<CR>

" Paste mode toggler
map <leader>p :set invpaste paste?<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" ALE - Asynchronous Linting Engine
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1

let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'

let g:ale_linters = {
      \ 'ruby': ['rubocop', 'sorbet'],
      \ 'typescript': ['eslint', 'tsserver'],
      \ 'javascript': ['eslint'],
      \ 'rust': ['cargo']
      \}

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'ruby': ['rubocop', 'sorbet'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'rust': ['rustfmt'],
      \}

let g:ale_ruby_rubocop_executable = './bin/container-rubocop'
let g:ale_ruby_sorbet_executable = './bin/container-sorbet'
let g:ale_javascript_eslint_executable = './bin/container-javascript'

nnoremap <silent><leader>lf :ALEFix<CR>
nnoremap <silent><leader>ld :ALEDetail<CR>

" FZF
let g:fzf_command_prefix = 'FZF'
let g:fzf_commits_log_options = '--pretty=oneline'
let g:fzf_buffers_jump = 1 " Disable jump to the existing window if possible

let $FZF_DEFAULT_COMMAND = 'rg --files -g "!tmp" -g "!vendor"'

nnoremap <leader><space> :FZFFiles<cr>
nnoremap <leader>b :FZFBuffers<cr>
nnoremap <leader>c :FZFCommits<cr>
nnoremap <leader>u :FZFSnippets<cr>
nnoremap <leader>a :FZFRg<space>
nnoremap <leader>o :only<cr>
nnoremap <leader>s :Switch<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Sequences
nmap <leader>r :for i in range(1,10) \| put ='192.168.0.'.i \| endfor

" Goyo mode toggler
map <leader>z :Goyo<CR>

" Tell vim to remember certain things when we exit
set viminfo='10,\"100,:20,%,n~/.viminfo

" Restores the cursor in last position
:au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

" Ultisnips
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/ultisnips']
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical" " If you want :UltiSnipsEdit to split your window.

let delimitMate_expand_cr=1

" Utility command for JSON searches
command JsonSearch execute "call jsonpath#goto()"

" Add spell check to git commits
augroup git_commits
  autocmd!
  autocmd FileType gitcommit setlocal spell spelllang=en_us
augroup END

" Markdown configuration
augroup markdown
  autocmd!
  autocmd FileType markdown setlocal textwidth=79
  autocmd FileType markdown setlocal spell spelllang=en_us
  autocmd FileType markdown setlocal noshiftround
augroup END

" Ruby configuration
augroup ruby
  autocmd!

  autocmd FileType ruby nnoremap <leader>t :TestNearest<cr>
  autocmd FileType ruby nnoremap <leader>f :TestFile<cr>
  autocmd FileType ruby nnoremap <leader>r :Dispatch bundle exec rubocop --safe-auto-correct %<cr>
augroup END

" Rust configuration
augroup rust
  autocmd!

  autocmd FileType rust nnoremap <leader>t :TestNearest<cr>
  autocmd FileType rust nnoremap <leader>f :TestFile<cr>
  autocmd FileType rust setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType rust :call UltiSnips#AddFiletypes('rust')
augroup END

" Typescript configuration
augroup typescript
  autocmd!

  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
  autocmd FileType typescript.tsx :call UltiSnips#AddFiletypes('javascript')
  autocmd FileType typescript :call UltiSnips#AddFiletypes('javascript')
augroup END

" Typo aliases
:command WQ wq
:command Wa wa
:command Wq wq
:command W w
:command Q q

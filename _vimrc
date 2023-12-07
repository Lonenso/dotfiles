" vim: set foldmethod=marker foldlevel=0 nomodeline:
" .vimrc of Peter {{{
let s:darwin = has('mac')
let s:windows = has('win32') || has('win64')
let mapleader      = ' '
" }}}

" VIM-PLUG BLOCK {{{
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !python install.py --clangd-completer
  endif
endfunction

silent! if plug#begin() 
if exists("$TMUX")
  Plug 'benmills/vimux'
endif
Plug 'bootleq/vim-cycle'
Plug 'bps/vim-textobj-python', {'for': 'python'}
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jceb/vim-textobj-uri'
Plug 'jiangmiao/auto-pairs'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'
Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim'] }
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-user'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-signify'
Plug 'sgur/vim-textobj-parameter'
Plug 'terryma/vim-expand-region'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'honza/vim-snippets'
call plug#end()
endif
" }}}

" BASIC SETTINGS {{{
silent! colorscheme dracula
set nocp
set backspace=indent,eol,start
set complete-=i
set smarttab
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
set laststatus=2
set ruler
set wildmenu
set scrolloff=1
set sidescroll=1
set sidescrolloff=2
set display+=lastline
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set formatoptions+=j
set autoread
set history=1000
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

set nu
set autoindent
set smartindent
set lazyredraw
set visualbell
set whichwrap=b,s
set hlsearch
set incsearch
set hidden
set ignorecase smartcase
set tabstop=4
set shiftwidth=4
set expandtab smarttab
set encoding=utf-8
" set virtualedit=block
set nojoinspaces
set diffopt=filler,vertical
set nocursorline

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

set modelines=2
set synmaxcol=1000
set tags=./tags;/
" }}}



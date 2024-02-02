" vim: set foldmethod=marker foldlevel=0 nomodeline:
" .vimrc of Peter {{{

" Vim 8 defaults
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

augroup vimrc
    autocmd!
augroup END

let s:darwin = has('mac')
let s:windows = has('win32') || has('win64')
let mapleader      = ' '
let maplocalleader = ','
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
Plug 'bootleq/vim-cycle', {'on': []}
Plug 'junegunn/seoul256.vim', {'on': []}
" textobj
Plug 'bps/vim-textobj-python', {'for': 'python'}
Plug 'jceb/vim-textobj-uri'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim'] }
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
" edit
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsEditSplit="vertical"
Plug 'terryma/vim-expand-region'
Plug 'jiangmiao/auto-pairs'
Plug 'tommcdo/vim-exchange'
Plug 'junegunn/vim-easy-align'
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
" syntax
Plug 'cdelledonne/vim-cmake'
Plug 'skywind3000/vim-flex-bison-syntax', { 'for': ['yacc', 'lex'] }
Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }
Plug 'pboettch/vim-cmake-syntax', { 'for': ['cmake'] }
Plug 'vim-python/python-syntax', {'for': ['python']}
Plug 'octol/vim-cpp-enhanced-highlight'
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
" linters
Plug 'w0rp/ale'
    nmap <silent> <leader>aj <Plug>(ale_next_wrap)
    nmap <silent> <leader>ak <Plug>(ale_previous_wrap)
    nmap <silent> <leader>ad <Plug>(ale_detail)
" completion
Plug 'ycm-core/youcompleteme', { 'do': function('BuildYCM') }
Plug 'universal-ctags/ctags' 
Plug 'ludovicchabant/vim-gutentags'
" navigation
Plug 'justinmk/vim-sneak'
    map f <Plug>Sneak_s
    map F <Plug>Sneak_S
Plug 'tpope/vim-unimpaired'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
    let g:vista#renderer#enable_icon = 0
    nnoremap <silent><leader>f :Vista finder<CR>
    nnoremap <silent><localleader>f :Vista!!<CR>
    nnoremap <silent><localleader>l :Vista focus<CR>
    let g:vista_close_on_fzf_select = 1
" colors
Plug 'dracula/vim', { 'as': 'dracula' }
" git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
    set updatetime=100
" Plug 'tpope/vim-rhubarb'
" git commit browser
Plug 'junegunn/gv.vim'
" directory
Plug 'justinmk/vim-dirvish'
" Unix helpers
Plug 'tpope/vim-eunuch'
Plug 'liuchengxu/vim-which-key', {'on': ['WhichKey', 'WhichKey!']}
" display function signature from completion in the command line 
Plug 'Shougo/echodoc.vim'
    set cmdheight=2
    let g:echodoc_enable_at_startup=1
Plug 'junegunn/vim-peekaboo'
if exists("$TMUX")
  Plug 'benmills/vimux'
endif
call plug#end()
endif
" }}}

" BASIC SETTINGS {{{
silent! colorscheme dracula
set complete-=i
set smarttab
set laststatus=2
set sidescroll=1
set sidescrolloff=2
set display+=lastline
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set formatoptions+=j
set autoread
set nobackup nowritebackup
set history=1000
set showmode
set nu
set rnu
set autoindent
set smartindent
set lazyredraw
set visualbell
set whichwrap=b,s,h,l
set hlsearch
set hidden
set ignorecase smartcase
set tabstop=4
set shiftwidth=4
set expandtab smarttab
set encoding=utf-8
set fileencoding=utf-8
set t_Co=256
syntax enable
set re=0
set nojoinspaces
set diffopt=filler,vertical
set clipboard^=unnamed,unnamedplus
set nowrap
set matchpairs+=<:>
set nofixeol
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
call mkdir($HOME . "/.vim/swap", "p", 0700)
call mkdir($HOME . "/.vim/backup", "p", 0700)
set shortmess-=S

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    
    return l:counts.total == 0 ? 'OK' : printf('%dW %dE', all_non_errors, all_errors)
endfunction

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let ale = '[%{LinterStatus()}]'
  let ctags = "%{gutentags#statusline()}"
  let ff =  '[%{&ff}]'
  let enc = "[%{strlen(&fenc)?&fenc:&enc}]"
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %F %<'.mod.ro.ft.fug.sep.ale.ctags.ff.enc.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

set modelines=2
set synmaxcol=1000
set tags=./tags;/
set splitbelow
set splitright
" }}}

" MAPPINGS {{{
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
imap jk <Esc>

" move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-j> :m .-2<CR>==
" emacs style motion
cnoremap <C-A> <HOME>
cnoremap <C-E> <END>
" location of crime scene
nnoremap <localleader>cf :let @+=expand("%") . ':' . line(".")<CR>
nnoremap <localleader>ct :let @+=expand("%:t") . ':' . line(".")<CR>
" edit vimrc and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

if !exists("*ReloadConfigs")
    function ReloadConfigs()
        :source $MYVIMRC
        if has("gui_running")
            :source $MYGVIMRC
        endif
    endfunction
endif
nnoremap <leader>sv :call ReloadConfigs()<CR>

" Center screen on next/prev selection
nnoremap n nzz
nnoremap N Nzz
" Last and next jump should center too
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz
" Center screen on paragraph jump
nnoremap } }zz
nnoremap { {zz
" clang-format
" if has('python')
"     map <leader>cf :pyf
"     imap <leader> <C-O>:pyf
" elseif has('python3')
"     map <leader>cf :py3f
"     imap <leader> <C-O>:py3f
" endif

" switch tab
noremap <silent><tab>m :tabnew<cr>
noremap <silent><tab>e :tabclose<cr>
noremap <silent><tab>n :tabn<cr>
noremap <silent><tab>p :tabp<cr>
noremap <silent><leader>t :tabnew<cr>
noremap <silent><leader>g :tabclose<cr>
noremap <silent><leader>1 :tabn 1<cr>
noremap <silent><leader>2 :tabn 2<cr>
noremap <silent><leader>3 :tabn 3<cr>
noremap <silent><leader>4 :tabn 4<cr>
noremap <silent><leader>5 :tabn 5<cr>
noremap <silent><leader>6 :tabn 6<cr>
noremap <silent><leader>7 :tabn 7<cr>
noremap <silent><leader>8 :tabn 8<cr>
noremap <silent><leader>9 :tabn 9<cr>
noremap <silent><leader>0 :tabn 10<cr>
noremap <silent><s-tab> :tabnext<CR>
inoremap <silent><s-tab> <ESC>:tabnext<CR>

if has('gui_running')
	noremap <silent><c-tab> :tabprev<CR>
	inoremap <silent><c-tab> <ESC>:tabprev<CR>
	noremap <silent><m-1> :tabn 1<cr>
	noremap <silent><m-2> :tabn 2<cr>
	noremap <silent><m-3> :tabn 3<cr>
	noremap <silent><m-4> :tabn 4<cr>
	noremap <silent><m-5> :tabn 5<cr>
	noremap <silent><m-6> :tabn 6<cr>
	noremap <silent><m-7> :tabn 7<cr>
	noremap <silent><m-8> :tabn 8<cr>
	noremap <silent><m-9> :tabn 9<cr>
	noremap <silent><m-0> :tabn 10<cr>
	inoremap <silent><m-1> <ESC>:tabn 1<cr>
	inoremap <silent><m-2> <ESC>:tabn 2<cr>
	inoremap <silent><m-3> <ESC>:tabn 3<cr>
	inoremap <silent><m-4> <ESC>:tabn 4<cr>
	inoremap <silent><m-5> <ESC>:tabn 5<cr>
	inoremap <silent><m-6> <ESC>:tabn 6<cr>
	inoremap <silent><m-7> <ESC>:tabn 7<cr>
	inoremap <silent><m-8> <ESC>:tabn 8<cr>
	inoremap <silent><m-9> <ESC>:tabn 9<cr>
	inoremap <silent><m-0> <ESC>:tabn 10<cr>
	noremap <silent><m-up> :tabprev<cr>
	noremap <silent><m-down> :tabnext<cr>
	inoremap <silent><m-up> <ESC>:tabprev<cr>
	inoremap <silent><m-down> <ESC>:tabnext<cr>
endif
" }}}

" FZF {{{
nnoremap <silent><leader><leader> :Files<CR>
nnoremap <silent><leader><CR> :Buffers<CR>
nnoremap <silent><leader>C :Colors<CR>
nnoremap <silent><leader>l :Lines<CR>
nnoremap <silent><leader>m :History<CR>
nnoremap <leader>rg :Rg
nnoremap <silent><leader>` :Marks<CR>
" }}}

" YCM {{{
nnoremap <localleader>gd :YcmCompleter GetDoc<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gD :YcmCompleter GoToReferences<CR>
nnoremap <leader>gh :YcmCompleter GoToAlternateFile<CR>
nnoremap <silent> <localleader>h <Plug>(YCMToggleInlayHints)

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
set completeopt=menu,menuone
noremap <c-z> <NOP>
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python': ['re!\w{2}'],
			\ }
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
" }}}

" ALE {{{
let g:ale_linters_explicit = 1
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" let g:airline#extensions#ale#enabled = 1
let g:ale_c_cc_options = '-Wall -O2 -std=c99 -Wno-pragma-once-outside-header --config ~/default.cfg'
let g:ale_cpp_cc_options = '-Wall -O2 -std=c++17 -Wno-pragma-once-outside-header --config ~/default.cfg'
let g:ale_cpp_cc_header_exts = ['h', 'hh', 'hpp']
" }}}

" Ctags {{{
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" }}}

" FUNCTIONS & COMMANDS {{{
" CenterComment(text, fill_char)
" All arguments are optional
function! CenterComment(...)
    let text = get(a:000, 0, '')
    let fill = get(a:000, 1, '-')[0]
    let padding = get(a:000, 3, 1)
    let width = (get(a:000, 2, 80) - len(text) - len(printf(&cms, '')) - 4 * padding)
    let left = width / 2
    let right = width - left
    put=printf(&cms, repeat(' ', padding) . repeat(fill, left) . repeat(' ', padding) . text . repeat(' ', padding) . repeat(fill, right) . repeat(' ', padding))
endfunction
" }}}
autocmd FileType c,cpp,java setlocal commentstring=//\ %s
" PLUGIN {{{
runtime! macros/matchit.vim
" }}}

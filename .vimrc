set nu
set rnu
"syntax on
" since I installed airline, i don't need show mode now. 
set noshowmode
set showcmd
set mouse=a
set encoding=utf-8
set fileencoding=utf-8
set t_Co=256
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set smartindent
set cursorline
set linebreak
set laststatus=2
set splitbelow
set splitright
set ruler
set showtabline=2
set hlsearch
set incsearch
set backspace=2
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
set visualbell t_vb=
set autoread
set nobackup
set nowritebackup
set wildmenu
set wildmode=longest:list,full
set iskeyword+=-
set updatetime=100
set nowrap
set matchpairs+=<:>

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

call plug#begin('~/.vim/plugged')
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-surround'
    Plug 'dense-analysis/ale'
	Plug 'preservim/nerdtree'
    Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'vim-airline/vim-airline'
    Plug 'mhinz/vim-signify'
    Plug 'valloric/youcompleteme', { 'do' : function('BuildYCM')}
    Plug 'skanehira/preview-uml.vim'
    Plug 'jremmen/vim-ripgrep'
call plug#end()
"ale setting 
"let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \   'zsh': ['shell'],
  \   'go': ['gofmt', 'golint'],
  \   'c': ['gcc', 'cppcheck'],
  \   'cpp': ['gcc', 'cppcheck'],
  \   'text': [],
  \}
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
"ale setting done

" vim.cpp setting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
" vim.cpp setting end 
"
"" ycm setting 
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone


let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" ycm setting end
" plantuml-preview
"let g:preview_uml_url='http://localhost:9090'
"ripgrep setting
let g:rg_highlight = 1
"ripgrep setting end

" mapping 
inoremap jj <Esc>
nmap <C-p> :FZF<CR>
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j 
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
imap <Left> <Nop>
imap <Right> <Nop>
imap <Up> <Nop>
imap <Down> <Nop>
nmap <C-e> :NERDTreeToggle<CR>
" Fzf
nnoremap <leader><leader> :Files<CR>
nnoremap <leader>rg :Rg
" Command
command -nargs=1 Count :%s/<args>//gn

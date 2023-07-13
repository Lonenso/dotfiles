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
" set tabstop=4
set shiftwidth=4
set softtabstop=4
" set textwidth=80
set colorcolumn=+1
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
set showmatch
set hlsearch
set incsearch
set backspace=2
set nojoinspaces
set list listchars=tab:»·,trail:·,nbsp:·
set modelines=0
" set autowrite
set hidden
set so=1
set display+=lastline
set sidescroll=10
set whichwrap+=h,l
set ttimeout
set ttimeoutlen=100

if has("unix")
    if has("mac")
      set clipboard+=unnamed "OSX
    else
      set clipboard=unnamedplus "Linux
    endif
endif
set visualbell t_vb=
set autoread
set nobackup
set nowritebackup
set wildmenu
set wildmode=longest:list,full
set updatetime=100
set nowrap
set matchpairs+=<:>
set nofixendofline

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
call plug#begin()
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
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-unimpaired'
    Plug 'ziglang/zig.vim'
    Plug 'tpope/vim-commentary'
    Plug 'majutsushi/tagbar'
    Plug 'universal-ctags/ctags'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'godlygeek/tabular'
    Plug 'preservim/vim-markdown'
    Plug 'kopischke/vim-fetch'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-speeddating'
    Plug 'justinmk/vim-sneak'
    Plug 'mhinz/vim-startify'
    Plug 'darfink/vim-plist'
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

" Copy matches of the last search to a register (default is the clipboard).
" Accepts a range (default is whole file).
" 'CopyMatches'   copy matches to clipboard (each match has \n added).
" 'CopyMatches x' copy matches to register x (clears register first).
" 'CopyMatches X' append matches to register x.
" We skip empty hits to ensure patterns using '\ze' don't loop forever.
command! -range=% -register CopyMatches call s:CopyMatches(<line1>, <line2>, '<reg>')
function! s:CopyMatches(line1, line2, reg)
  let hits = []
  for line in range(a:line1, a:line2)
    let txt = getline(line)
    let idx = match(txt, @/)
    while idx >= 0
      let end = matchend(txt, @/, idx)
      if end > idx
	call add(hits, strpart(txt, idx, end-idx))
      else
	let end += 1
      endif
      if @/[0] == '^'
        break  " to avoid false hits
      endif
      let idx = match(txt, @/, end)
    endwhile
  endfor
  if len(hits) > 0
    let reg = empty(a:reg) ? '+' : a:reg
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
  else
    echo 'No hits'
  endif
endfunction

" mapping 
let mapleader = " "
inoremap jj <Esc>
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
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
" fugitive
" Fzf
nnoremap <c-p>            :Files<CR>
nnoremap <leader>C        :Colors<CR>
nnoremap <leader><CR>     :Buffers<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>m        :History<CR>
nnoremap <leader>r        :Rg
nnoremap <leader>cm       :CopyMatches<CR>
nnoremap <Leader>jf       :%!jq . <CR>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))
" nmap <c-k> :m-2<CR>  
" nmap <c-j> :m+1<CR>
nmap <c-s> :TagbarToggle<CR>
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
" nmap <c-a> :NERDTreeFind<CR>
" ycm 
nnoremap <leader>gd       :YcmCompleter GoToDeclaration<CR>
" :nnoremap - Non-recursive map
" <silent> - Do not echo anything when the mapping is pressed
" J - Key to map
" :let p=getpos('.') - Store cursor position
" <bar> - Command separator (| for maps, see :help map_bar)
" join - The ex command for normal's J
" <bar> - ...
" call setpos('.', p) - Restore cursor position
" <cr> - Run the commands
:nnoremap <silent> J :let p=getpos('.')<bar>join<bar>call setpos('.', p)<cr>

" Command
command -nargs=1 Count :%s/<args>//gn

" expand
nmap <leader>cs :let @+=expand("%") . ':' . line(".")<CR>
" clangd
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
" Change swp and backup files location
" macosx needs to use TMPDIR not TEMPDIR
let g:vim_markdown_folding_disabled = 1
if has("unix")
    if has("mac")
        set backupdir=$TMPDIR//
        set directory=$TMPDIR//
    endif
endif
" set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

if &diff
    syntax off
    colorscheme evening
endif
" Always use vertical diffs
set diffopt+=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" filetype
au BufRead,BufNewFile DEPS,.gclient set filetype=python

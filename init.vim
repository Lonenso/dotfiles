" vim: set foldmethod=marker foldlevel=0 nomodeline:
" .vimrc of Peter {{{

augroup vimrc
    autocmd!
augroup END

let s:darwin = has('mac')
let s:windows = has('win32') || has('win64')
let mapleader      = ' '
let maplocalleader = ','
" }}}

" VIM-PLUG BLOCK {{{
silent! if plug#begin() 
" disabled plugin
" vim-cycle won't work if speeddating is installed
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
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'terryma/vim-expand-region'
Plug 'jiangmiao/auto-pairs'
Plug 'tommcdo/vim-exchange'
Plug 'junegunn/vim-easy-align'
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
" syntax
Plug 'skywind3000/vim-flex-bison-syntax', { 'for': ['yacc', 'lex'] }
" completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" navigation
Plug 'justinmk/vim-sneak'
    map f <Plug>Sneak_s
    map F <Plug>Sneak_S
    let g:sneak#s_next=1
    let g:sneak#use_ic_scs=1
Plug 'mbbill/undotree'
    nnoremap <F5> :UndotreeToggle<CR>
Plug 'tpope/vim-unimpaired'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_vim = {}
let g:fzf_vim.preview_window = []
" colors
Plug 'Mofiqul/dracula.nvim'
Plug 'nvim-lualine/lualine.nvim'
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
Plug 'junegunn/vim-peekaboo'
call plug#end()
endif
lua << EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end

    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['cmake'].setup {
    capabilities = capabilities,
    root_files = {'CMakeLists.txt'}
  }
  require('lualine').setup {
      options = {
          theme = 'dracula-nvim'
      }
  }
EOF
" }}}

" BASIC SETTINGS {{{
silent! colorscheme dracula
set smarttab
set formatoptions+=j
set nobackup nowritebackup
set showmode
set nu
set rnu
set smartindent
set lazyredraw
set whichwrap=b,s,h,l
set hlsearch
set hidden
set ignorecase smartcase
set tabstop=4
set shiftwidth=4
set expandtab smarttab
syntax enable
set re=0
set diffopt=filler,vertical
set clipboard^=unnamed,unnamedplus
set nowrap
set matchpairs+=<:>
set nofixeol
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
call mkdir($HOME . "/.vim/swap", "p", 0700)
call mkdir($HOME . "/.vim/backup", "p", 0700)
set linebreak

set modelines=2
set synmaxcol=1000
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
" location of crime scene
nnoremap <localleader>cf :let @+=expand("%") . ':' . line(".")<CR>
nnoremap <localleader>ct :let @+=expand("%:t") . ':' . line(".")<CR>

" Center screen on next/prev selection
nnoremap n nzz
nnoremap N Nzz
" Last and next jump should center too
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz
" Center screen on paragraph jump
nnoremap } }zz
nnoremap { {zz
nnoremap Y y$
" clang-format
" if has('python')
"     map <leader>cf :pyf
"     imap <leader> <C-O>:pyf
" elseif has('python3')
"     map <leader>cf :py3f
"     imap <leader> <C-O>:py3f
" endif

" switch tab

" if has('gui_running')
" 	noremap <silent><c-tab> :tabprev<CR>
" 	inoremap <silent><c-tab> <ESC>:tabprev<CR>
" 	noremap <silent><m-1> :tabn 1<cr>
" 	noremap <silent><m-2> :tabn 2<cr>
" 	noremap <silent><m-3> :tabn 3<cr>
" 	noremap <silent><m-4> :tabn 4<cr>
" 	noremap <silent><m-5> :tabn 5<cr>
" 	noremap <silent><m-6> :tabn 6<cr>
" 	noremap <silent><m-7> :tabn 7<cr>
" 	noremap <silent><m-8> :tabn 8<cr>
" 	noremap <silent><m-9> :tabn 9<cr>
" 	noremap <silent><m-0> :tabn 10<cr>
" 	inoremap <silent><m-1> <ESC>:tabn 1<cr>
" 	inoremap <silent><m-2> <ESC>:tabn 2<cr>
" 	inoremap <silent><m-3> <ESC>:tabn 3<cr>
" 	inoremap <silent><m-4> <ESC>:tabn 4<cr>
" 	inoremap <silent><m-5> <ESC>:tabn 5<cr>
" 	inoremap <silent><m-6> <ESC>:tabn 6<cr>
" 	inoremap <silent><m-7> <ESC>:tabn 7<cr>
" 	inoremap <silent><m-8> <ESC>:tabn 8<cr>
" 	inoremap <silent><m-9> <ESC>:tabn 9<cr>
" 	inoremap <silent><m-0> <ESC>:tabn 10<cr>
" 	noremap <silent><m-up> :tabprev<cr>
" 	noremap <silent><m-down> :tabnext<cr>
" 	inoremap <silent><m-up> <ESC>:tabprev<cr>
" 	inoremap <silent><m-down> <ESC>:tabnext<cr>
" else
"     noremap <silent><tab>m :tabnew<cr>
"     noremap <silent><tab>e :tabclose<cr>
"     noremap <silent><tab>n :tabn<cr>
"     noremap <silent><tab>p :tabp<cr>
"     noremap <silent><leader>t :tabnew<cr>
"     noremap <silent><leader>g :tabclose<cr>
"     noremap <silent><leader>1 :tabn 1<cr>
"     noremap <silent><leader>2 :tabn 2<cr>
"     noremap <silent><leader>3 :tabn 3<cr>
"     noremap <silent><leader>4 :tabn 4<cr>
"     noremap <silent><leader>5 :tabn 5<cr>
"     noremap <silent><leader>6 :tabn 6<cr>
"     noremap <silent><leader>7 :tabn 7<cr>
"     noremap <silent><leader>8 :tabn 8<cr>
"     noremap <silent><leader>9 :tabn 9<cr>
"     noremap <silent><leader>0 :tabn 10<cr>
"     noremap <silent><s-tab> :tabnext<CR>
"     inoremap <silent><s-tab> <ESC>:tabnext<CR>
" endif
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

" ALE {{{
" let g:ale_linters_explicit = 1
" let g:ale_echo_delay = 20
" let g:ale_lint_delay = 500
" let g:ale_linters = {'cpp':['cc', 'cppcheck']}
" let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1
" " let g:airline#extensions#ale#enabled = 1
" let g:ale_c_cc_options = '-Wall -O2 -std=c99 -Wno-pragma-once-outside-header --config ~/default.cfg'
" let g:ale_cpp_cc_options = '-Wall -O2 -std=c++17 -Wno-pragma-once-outside-header --config ~/default.cfg'
" let g:ale_cpp_cc_header_exts = ['h', 'hh', 'hpp']
" }}}

" Ctags {{{
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" let g:gutentags_ctags_tagfile = '.tags'
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags
" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
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


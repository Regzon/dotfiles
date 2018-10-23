set number
set linebreak
set showbreak=+++
set showmatch
 
" Search settings
set hlsearch
set smartcase
set ignorecase
set incsearch

" Plug package manager
call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'
Plug 'w0rp/ale'
" Plug 'hdima/python-syntax', { 'as': 'base-python-syntax' }
" Plug 'kh3phr3n/python-syntax'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
call plug#end()

" Python highlight
let python_highlight_all=1

" Theme setup
set tgc
syntax on
color dracula

" Enable folding (hiding class/method realisation)
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1

" Fast fold setup
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook=1
let g:fastfold_fold_command_suffixes=["x","X","a","A","o","O","c","C"]
let g:fastfold_fold_movement_commands=["]z","[z","zj","zk"]
let g:python_fold=1

" Pymode configuration
let g:pymode = 1
let g:pymode_trim_whitespaces = 1
let g:pymode_python = 'python3'
let g:pymode_options_max_line_length = 79
let g:pymode_options_colorcolumn = 1
let g:pymode_indent = 1
let g:pymode_motion = 1
let g:pymode_virtualenv = 1
let g:pymode_lint = 0
let g:pymode_rope = 1
let g:pymode_rope_show_doc_bind = '<C-c>d'
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_rope_goto_definition_bind = '<C-c>g'
let g:pymode_rope_goto_definition_cmd = 'new'
let g:pymode_rope_rename_bind = '<C-c>rr'
let g:pymode_syntax = 1
let g:pymode_syntax_slow_sync = 1
let g:pymode_syntax_all = 1

autocmd CompleteDone * pclose

" Ale configuration
set completeopt+=noinsert
" let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'python': ['flake8', 'pyls', 'pycodestyle']
\}

" Tmux resize configuration
let g:tmux_resizer_no_mappings = 1

nnoremap <silent> <M-Left> :TmuxResizeLeft<cr>
nnoremap <silent> <M-Down> :TmuxResizeDown<cr>
nnoremap <silent> <M-Up> :TmuxResizeUp<cr>
nnoremap <silent> <M-Right> :TmuxResizeRight<cr>

" Set mapleader
let mapleader = ","
map <Leader><Space> :let @/=''<CR> " Clear search
map <Leader>t :NERDTreeToggle<CR> " Toggle NERD Tree

" Folding key bindings
nnoremap <Leader>d za

" Enable indents
filetype indent on

" Common indents
set autoindent
set smartindent
set smarttab
set expandtab
set softtabstop=4
set shiftwidth=4
set tabstop=4

" File type indents
au FileType yml,yaml set shiftwidth=2 |
            \ set softtabstop=2 |
            \ set tabstop=2

au FileType python set shiftwidth=4 |
            \ set softtabstop=4 |
            \ set tabstop=4

au FileType html,htmldjango,json set shiftwidth=2 |
            \ set softtabstop=2 |
            \ set tabstop=2

highlight ExtraWhitespace cterm=underline guifg=LightBlue
au BufRead,InsertEnter *.py,*.c,*.h match ExtraWhitespace /\s\+$/
 
" Miscellaneous
set ruler
set undolevels=1000
set backspace=indent,eol,start
set scrolloff=5

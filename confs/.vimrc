call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sickill/vim-monokai'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
call plug#end()


set number                      " Show line numbers
set noswapfile
set nocompatible
set linebreak                   " Break lines at word (requires Wrap lines)
set showbreak=+++               " Wrap-broken line prefix
set textwidth=100               " Line wrap (number of cols)
set showmatch                   " Highlight matching brace
set visualbell                  " Use visual bell (no beeping)
set cursorline                  " Line highlight

set hlsearch                    " Highlight all search results
set smartcase                   " Enable smart-case search
set ignorecase                  " Always case-insensitive
set incsearch                   " Searches for strings incrementally

set autoindent                  " Auto-indent new lines
set expandtab                   " Use spaces instead of tabs
set shiftwidth=4                " Number of auto-indent spaces
set smartindent                 " Enable smart-indent
set smarttab                    " Enable smart-tabs
set softtabstop=4               " Number of spaces per Tab
set ruler                       " Show row and column ruler information
set undolevels=1000             " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour

let g:netrw_banner=0            " disable annoying banner
let g:netrw_winsize=80
let g:netrw_browse_split=4      " open in prior window
let g:netrw_altv=1              " open splits to the right
let g:netrw_liststyle=3         " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

set path+=**
set wildmenu
set wildmode=longest:full,full
set laststatus=2
set guifont=Monaco:h12          " Use Monaco as default font
colorscheme monokai
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-g> :Rg<Cr>

"" Vundle config

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/vundle-plugins')

Plugin 'VundleVim/Vundle.vim'
"Plugin 'fatih/vim-go'
Plugin 'LnL7/vim-nix'
Plugin 'zyedidia/literate.vim'

call vundle#end()

"" End Vundle config

syntax enable
filetype indent plugin on      " load filetype specific config

set backspace=indent,eol,start

set background=dark

set clipboard=unnamed   " y/p copy to system clipboard

set tabstop=4		    " number of visual spaces/tab
set shiftwidth=4        " number of spaces for autoindent
set softtabstop=4	    " number of spaces/tab when editing
set expandtab 		    " tabs -> spaces
set autoindent
autocmd FileType make setlocal noexpandtab

set showmatch           " show matching ()[]{}

set wildmenu            " visual autocomplete for menu
set lazyredraw          " redraw only when we need to

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set scrolloff=5         " scroll with search

set textwidth=80

" clear search
nnoremap <space> :nohlsearch<CR>

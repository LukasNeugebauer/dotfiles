"general appearance
set nu
set showmatch
set splitbelow
set splitright
let python_highlight_all=1
syntax on


"prevent encoding problems
set encoding=utf-8

"Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'eigenfoo/stan-vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

"keyboard remappings

" switch between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"set up folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za


"filetype specific things

"make everything in python file compatible with PEP8
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |


"mark bad whitespace. Extremely good for python
highlight BadWhitespace ctermbg=red guibg=darkred
au Bufread,BufNewFile *.py,*.pyw,*.c,*.h,*.stan match BadWhitespace /\s\+$/

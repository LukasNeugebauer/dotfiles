"general appearance
set nu
set showmatch
set noswapfile
set splitbelow
set splitright
set expandtab
set tabstop=4
set shiftwidth=4
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
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on

"keyboard remappings

" switch between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" enable copy/paste in and out of vim
" visual mode
    " copy, i.e. yank into special buffer
vnoremap <C-c> "+y
    " cut, same except delete selection in vim
vnoremap <C-x> "+x
    " paste -> change selection, exit insert mode, paste special buffer
vnoremap <C-v> c<ESC>"+P
"normal mode, no copy, because what would you copy
    " paste after to mimic expected behavior
nnoremap <C-V> "+gP

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
	\ set textwidth=100 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |

"mark bad whitespace. Extremely good for python
highlight BadWhitespace ctermbg=red guibg=darkred
au Bufread,BufNewFile *.py,*.pyw,*.c,*.h,*.stan match BadWhitespace /\s\+$/

" automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

"configuration file for vim/neovim
"Lukas Neugebauer

"define leader key to be alt
"not much used as of yet, but will do in the future
let mapleader = ","

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

"fix weird syntax highlighting problems in html/js files
autocmd BufEnter * syntax sync fromstart

" manage plugins using Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    "package manager
    Plugin 'gmarik/Vundle.vim'
    "appearance
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'powerline/powerline'
    Plugin 'morhetz/gruvbox'
    Plugin 'sainnhe/gruvbox-material'
    Plugin 'fcpg/vim-fahrenheit'
    Plugin 'frazrepo/vim-rainbow'
    "general vim stuff, folding, indentation, etc.
    Plugin 'tmhedberg/SimpylFold'
    Plugin 'scrooloose/nerdtree'
    Plugin 'tpope/vim-commentary'
    "catch-all programming packages for syntax checking, highlighting,
    "indentation, etc.
    Plugin 'sheerun/vim-polyglot'
    Plugin 'vim-syntastic/syntastic'
    Plugin 'tabnine/YouCompleteMe'
    "latex specific
    Plugin 'xuhdev/vim-latex-live-preview'
    "stan specific
    Plugin 'eigenfoo/stan-vim'
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
    " I used y instead of v to keep ctrl+v for visual block mode, y is
    " consistent with yanking
vnoremap <C-y> c<ESC>"+P
"normal mode, no copy, because what would you copy
    " paste after to mimic expected behavior
nnoremap <C-y> "+gP

"set up folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
vnoremap <space> za

"fix mouse issue in alacritty
"this fix seems to be an issue in neovim, so only for vim
set mouse=a
if !has('nvim')
    set ttymouse=sgr
endif

"mark bad whitespace in red
highlight BadWhitespace ctermbg=red guibg=darkred
au Bufread,BufNewFile *m,*.py,*.pyw,*.c,*.h,*.stan match BadWhitespace /\s\+$/

" automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

"colorscheme, is depending on vundle, so needs to be after that
let g:gruvbox_transparent_background = 0
let g:gruvbox_termcolors = 1
let g:gruvbox_contrast_dark="medium"
colo gruvbox
set bg=dark

"some python specific things
"make everything in python file compatible with PEP8
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=88 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |
    \ set cc=88
"relaxing the max line length in python code checking using flake8
"88 corresponds to the value used by black, 10% more than 80
"for some reason syntastic seems to ignore the flake8 config file?
let g:syntastic_python_checker = ["flake8"]
let g:syntastic_python_flake8_args = "--max-line-length=88"

"similar things for STAN, except that the suggested width is 2 for tabs
au BufNewFile,BufRead *.stan
	\ set tabstop=2 |
	\ set softtabstop=2 |
	\ set shiftwidth=2 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |

"configure youcompleteme plugin
let g:ycm_autoclose_preview_after_completion = 1

"some shortcuts for NERDTree
nnoremap <C-n> :NERDTree<CR>
nnoremap <leader>n :NERDTreeFocus<CR>

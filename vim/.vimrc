" Configuration file for vim/neovim
" Is structure into the following parts
"   1. Plugins: Load plugins using Vundle and configure them
"   2. General configuration: Settings that are filetype independent
"   3. Keyboard remappings: define some shortcuts
"   4. Filetype specific settings: Deal with the peculiarities of python, stan
"       and matlab
"Lukas Neugebauer


"===============================================================================
" 1. PLUGINS
"===============================================================================

" load plugins

filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    "package manager
    Plugin 'gmarik/Vundle.vim'
    "appearance
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'morhetz/gruvbox'
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
    "checking out snippets
    Plugin 'SirVer/ultisnips'
    "latex specific
    Plugin 'xuhdev/vim-latex-live-preview'
    "stan specific
    Plugin 'eigenfoo/stan-vim'
    "undistracted writing
    Plugin 'junegunn/goyo.vim'
    Plugin 'junegunn/limelight.vim'
call vundle#end()
filetype plugin indent on
syntax on


" and configure them

"settings for goyo and limelight
let g:goyo_width=120
let g:limelight_default_coefficient=0.6
let g:limelight_conceal_ctermfg='LightGray'
"configure youcompleteme plugin
let g:ycm_autoclose_preview_after_completion = 1
"configure vim-latex-live-preview
let g:livepreview_cursorhold_recompile = 0
let g:livepreview_use_biber = 1
"ignore output of pdflatex in nerdtree
set wildignore+=*.aux,*.bcf,*.log,*.lof,*.lot,*.run.xml,*.toc,*.bbl,*.blg
let NERDTreeRespectWildIgnore=1
" activate color matching for opening and closing parantheses
let g:rainbow_active=1
" configure colorscheme
let g:gruvbox_transparent_background = 0
let g:gruvbox_termcolors = 1
let g:gruvbox_contrast_dark="medium"
" define version controlled path for ultisnips
let g:UltiSnipsSnippetDirectories=["~/.config/vim/snippets"]
" open vertical split to edit snippet file
let g:UltiSnipsEditSplit="vertical"

"===============================================================================
" 2. GENERAL CONFIGURATION
"===============================================================================

set nu
set showmatch
set noswapfile
set splitbelow
set splitright
set expandtab
set tabstop=4
set shiftwidth=4
set encoding=utf-8
let python_highlight_all=1
"define languages for spell checking
"define leader key to be comma
let mapleader = ","
"set up folding
set foldmethod=indent
set foldlevel=99
" define colorscheme
colo gruvbox
set bg=dark

"fix weird syntax highlighting problems in html/js files
autocmd BufEnter * syntax sync fromstart

"fix mouse issue in alacritty
"this fix seems to be an issue in neovim, so only for vim
set mouse=a
if !has('nvim')
    set ttymouse=sgr
endif

" automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" set up spell checks
set spelllang=en
highlight BadSpell ctermbg=red guibg=red ctermfg=white guifg=white

" open NERDTree on startup
autocmd VimEnter * NERDTree | wincmd p

"===============================================================================
" 3. KEYBOARD REMAPPINGS
"===============================================================================

" Fix weird highlighting stuff with keymap
nnoremap <leader>s :syntax sync fromstart<CR>

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
    " I used y instead of v to keep ctrl+v for visual block mode, p
    " consistent with pasting in vim
vnoremap <C-p> c<ESC>"+P
"normal mode, no copy, because what would you copy
    " paste after to mimic expected behavior
nnoremap <C-p> "+gP

" use space to open and close folds
nnoremap <space> za
vnoremap <space> za

"toggle writing mode
nnoremap <leader>wm :Goyo<CR> :Limelight!!<CR> :set linebreak<CR>

"some shortcuts for NERDTree
nnoremap <C-n> :NERDTree<CR>
nnoremap <leader>n :NERDTreeFocus<CR>

"remappings for spell check
"remap looking for bad words, always ignore rare words
"enable spell checking with F6
nnoremap <F6> :set spell!<CR>
"using leader for this as alt is weird
"forward seach
nnoremap <leader>f ]S
"backwords search
nnoremap <leader>b [S
"append to whitelist
nnoremap <leader>a zg
"show suggesteions
nnoremap <leader>p z=

" these are technically configurations, but since they define keys, I'll put
" them here
" define trigger for UltiSnips, tab is used by youcompleteme
" alt key is weird, here's a workaround
let g:UltiSnipsExpandTrigger="<C-s>"
" these are the defaults, but I put them here as a reminder
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" get rid of annoying highlights in normal mode
nnoremap <Backspace> :nohl<CR>

"===============================================================================
" 4. FILETYPE SPECIFIC SETTINGS
"===============================================================================

" Python
" make everything in python file compatible with PEP8
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

" STAN
au BufNewFile,BufRead *.stan
	\ set tabstop=2 |
	\ set softtabstop=2 |
	\ set shiftwidth=2 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix

" Latex
" hard wrapping lines
" enable spell checking automatically
au BufNewFile,BufRead *.tex
    \ set textwidth=100 |
    \ set linebreak |
    \ set cc=100 |
    \ set spell!

" MATLAB/Octave
"set cc to 90 characters in matlab files
au BufNewFile,BufRead *.m set cc=90
"and fix comment sign, vim reads matlab as octave
autocmd Filetype octave setlocal commentstring=%\ %s

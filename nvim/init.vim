" Neovim configurations

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
call plug#begin()

    " nice status bar on the bottom
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " gruvbox theme
    Plug 'morhetz/gruvbox'

    " distinguish pairs or parentheses by color
    Plug 'frazrepo/vim-rainbow'

    " improved folding for python
    Plug 'tmhedberg/SimpylFold'

    " nvim-tree and requirements
	Plug 'nvim-tree/nvim-tree.lua'
    Plug 'nvim-tree/nvim-web-devicons'

    " automatically detects correct characters for comments
    Plug 'tpope/vim-commentary'

    " preview colors in terminal
    Plug 'ap/vim-css-color'

    " syntax highlighting for all kinds of languages
    Plug 'sheerun/vim-polyglot'

    " snippets in nvim
    Plug 'SirVer/ultisnips'

    " show live compiled pdf side to side for latex
    Plug 'xuhdev/vim-latex-live-preview'

    " smart folding for latex
    Plug 'matze/vim-tex-fold'

    " show file structure for latex and markdown
    Plug 'vim-voom/VOoM'

    " stan syntax highlighting
    Plug 'eigenfoo/stan-vim'

    " undistracted writing
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'

    " preview changes and searches
    Plug 'markonm/traces.vim'

    " save and restore sessions
    Plug 'xolox/vim-session'
    Plug 'xolox/vim-misc'

    " config for language servers
    Plug 'neovim/nvim-lspconfig'

    " better syntax highlighting and other stuff that I have no clue about tbh
    Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()


" and configure them
lua require'nvim-tree'.setup{}

"settings for goyo and limelight
let g:goyo_width=120
let g:limelight_default_coefficient=0.6
let g:limelight_conceal_ctermfg='LightGray'

"configure youcompleteme plugin
let g:ycm_autoclose_preview_after_completion = 1

"configure vim-latex-live-preview
let g:livepreview_cursorhold_recompile = 0
let g:livepreview_use_biber = 1

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
" only use lacheck, not chktex in latex, chktex sucks
let g:syntastic_tex_checkers = ['lacheck', 'proselint']
" let g:syntastic_tex_chktex_quiet_messages = {'regex': [
"             \ '\Vpossible unwanted space at',
"             \ 'Delete this space to maintain correct pagereferences']}
"relaxing the max line length in python code checking using flake8
"88 corresponds to the value used by black, 10% more than 80
let g:syntastic_python_checker = ["flake8"]
let g:syntastic_python_flake8_args = "--max-line-length=88"
" Settings for vim-session
" don't ask for autosave of sessions
let g:session_autosave = 'no'
" don't save buffers, options and help windows
set sessionoptions-=buffers
set sessionoptions-=options
set sessionoptions-=help
" autosave every 15 minutes
let g:session_autosave_interval = 15

" open voom tree structure on the right side
let g:voom_tree_placement = 'right'


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
highlight SpellBad ctermbg=red ctermfg=white
"guibg=red guifg=white

" open all .tex files as filetype "tex", not "plaintex"
let g:tex_flavor = "latex"

" always resize splits after window size changes
autocmd VimResized * wincmd =

lua require'lspconfig'.pyright.setup{}

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

" move between folded lines as if they were not folded
nnoremap j gj
nnoremap k gk

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
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFocus<CR>

"remappings for spell check
"enable spell checking with F6
nnoremap <F6> :set spell!<CR>

"forward seach
nnoremap <leader>f ]S
"backwords search
nnoremap <leader>b [S
"append to whitelist
nnoremap <leader>a zg
"show suggestions
nnoremap <leader>p z=

" these are technically configurations, but since they define keys, I'll put
" them here
" define trigger for UltiSnips, tab is used by youcompleteme (or copilot)
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
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix

" STAN
au BufNewFile,BufRead *.stan
	\ set tabstop=2 |
	\ set softtabstop=2 |
	\ set shiftwidth=2 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix

" yaml and json

" Latex
" hard wrapping lines
" enable spell checking automatically
" ignore acronyms
au BufNewFile,BufRead *.tex
    \ set wrap |
    \ set linebreak |
    \ set cc= |
    \ set spell! |
    \ Voom latex

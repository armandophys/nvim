
" Set vim to use number lines on startup
set number
syntax on
set ignorecase
set clipboard+=unnamedplus
set colorcolumn=80
"make escaping easier
:imap jk <Esc>


" enable Folding
set foldmethod=indent
set foldlevel=99
" enable folding with spacebar and f

nnoremap <leader>f za


call plug#begin()
Plug 'tpope/vim-sensible'


""" Python Specific plugins

" Improve Python Folding
Plug 'tmhedberg/SimpylFold'
" Make folding faster
Plug 'Konfekt/FastFold'
" Python indenting
Plug 'vim-scripts/indentpython.vim'

" Snippets enabled
Plug 'roxma/nvim-completion-manager'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"Syntax checker specific to neovim
Plug 'w0rp/ale'

" PEP 8 checker
Plug 'nvie/vim-flake8'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" vimtex
Plug 'lervag/vimtex'

" fugitive - git plugin
Plug 'tpope/vim-fugitive'

" vim-airline - nice tabline
Plug 'bling/vim-airline'

" multiple cursors like notepad++ and sublime
Plug 'terryma/vim-multiple-cursors'

" indent visual guides
Plug 'nathanaelkane/vim-indent-guides'

" surround selected text with whatever
Plug 'tpope/vim-surround'

" repeat non native commands
Plug 'tpope/vim-repeat'

" experimental matlab plugin, fork of popular fabriceguy's code
Plug 'andymass/vim-matlab'

" adds tmux navigator to use with matlab must add ctrl+hjkl commands to tmux config file
Plug 'christoomey/vim-tmux-navigator'

" adds tmux manager to vim
Plug 'ervandew/screen'

" adds codesection support for vim in matlab/tmux
Plug 'kinnala/VimLab'


" Search for files and tags
Plug 'kien/ctrlp.vim'

call plug#end()




""" Python Support
"python with virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" pretty up
let python_highlight_all=1



" set of instructions that improve vim a little by...
" Changing leader to space instead of :
" autocomplete info
" enabling mouse
" etc. (ill find out eventually... or not
"-----------Begin------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

" All of your Plugins must be added before the following line
filetype plugin indent on    " required

set autoindent
set ts=4
filetype on

syntax on
set ignorecase
set smartcase
set hlsearch
set modelines=0
set wildmenu
set wildmode=longest:full
set nu "line numbers

"for indenting
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
vmap <Tab> >gv
vmap <S-Tab> <gv
inoremap <S-Tab> <C-D>

set lbr "word wrap
set tw=500

set wrap "Wrap lines

" scrolling
inoremap <C-E> <C-X><C-E> "scrolling on insert
inoremap <C-Y> <C-X><C-Y>
set scrolloff=3 " keep three lines between the cursor and the edge of the screen

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " " " Leader is the space key
let g:mapleader = " "
"auto indent for brackets
inoremap {<CR> {<CR>}<Esc>O
" easier write
nmap <leader>w :w!<cr>
" easier quit
nmap <leader>q :q<cr>
" silence search highlighting
nnoremap <leader>sh :nohlsearch<Bar>:echo<CR>
"paste from outside buffer
nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>p <Esc>:set paste<CR>gv"+p:set nopaste<CR>
"copy to outside buffer
vnoremap <leader>y "+y
"select all
nnoremap <leader>a ggVG
"paste from 0 register
"Useful because `d` overwrites the <quote> register
nnoremap <leader>P "0p
vnoremap <leader>P "0p

"nnoremap <C-l> :tabnext<CR>
"nnoremap <C-h> :tabprevious<CR>

"nnoremap tj  :tabnext<CR>

"set mouse=a

" move in long lines
nnoremap k gk
nnoremap j gj

" vimslime
"let g:slime_target = "tmux"
"nmap <C-C><C-N> :set ft=haskell.script<CR><C-C><C-C>:set ft=haskell<CR>


" persistent undo
if !isdirectory($HOME."/.dotfiles/vim/undodir")
    call mkdir($HOME."/.dotfiles/vim/undodir", "p")
endif

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" markdown also starts with .md
autocmd BufNewFile,BufRead *.md set filetype=markdown

" fzf command
set rtp+=~/.fzf

nnoremap <leader>t :call fzf#run({ 'sink': 'tabe', 'options': '-m +c', 'dir': '.', 'source': 'find .' })<CR>

" ctags looks in the right directory
set tags=./.tags,.tags;$HOME
nnoremap <C-}> g<C-]>
nnoremap <C-[> <C-t>

" Run python when typing <leader>r
noremap <buffer> <leader>r :w<cr> :exec '!python' shellescape(@%, 1)<cr>

"ycm
"let g:ycm_global_ycm_extra_conf = '~/.dotfiles/vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf = 0 " Don't ask for confirmation about ycm_extra_conf
"
" From http://stackoverflow.com/questions/3105307/how-do-you-automatically-remove-the-preview-window-after-autocompletion-in-vim
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Red coloring at whitespace after end of line whitespace
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
" highlight EOLWS ctermbg=red guibg=red-demand loading


" set of instructions that improve vim a little by...
" Changing leader to space instead of :
" autocomplete info
" enabling mouse
" etc. (ill find out eventually... or not
"-----------Begin------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

" All of your Plugins must be added before the following line
filetype plugin indent on    " required

set autoindent
set ts=4
filetype on

syntax on
set ignorecase
set smartcase
set hlsearch
set modelines=0
set wildmenu
set wildmode=longest:full
set nu "line numbers

"for indenting
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
vmap <Tab> >gv
vmap <S-Tab> <gv
inoremap <S-Tab> <C-D>

set lbr "word wrap
set tw=500

set wrap "Wrap lines

" scrolling
inoremap <C-E> <C-X><C-E> "scrolling on insert
inoremap <C-Y> <C-X><C-Y>
set scrolloff=3 " keep three lines between the cursor and the edge of the screen

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " " " Leader is the space key
let g:mapleader = " "
"auto indent for brackets
inoremap {<CR> {<CR>}<Esc>O
" easier write
nmap <leader>w :w!<cr>
" easier quit
nmap <leader>q :q<cr>
" silence search highlighting
nnoremap <leader>sh :nohlsearch<Bar>:echo<CR>
"paste from outside buffer
nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>p <Esc>:set paste<CR>gv"+p:set nopaste<CR>
"copy to outside buffer
vnoremap <leader>y "+y
"select all
nnoremap <leader>a ggVG
"paste from 0 register
"Useful because `d` overwrites the <quote> register
nnoremap <leader>P "0p
vnoremap <leader>P "0p

"nnoremap <C-l> :tabnext<CR>
"nnoremap <C-h> :tabprevious<CR>

"nnoremap tj  :tabnext<CR>

"set mouse=a

" move in long lines
nnoremap k gk
nnoremap j gj

" vimslime
"let g:slime_target = "tmux"
"nmap <C-C><C-N> :set ft=haskell.script<CR><C-C><C-C>:set ft=haskell<CR>


" persistent undo
if !isdirectory($HOME."/.dotfiles/vim/undodir")
    call mkdir($HOME."/.dotfiles/vim/undodir", "p")
endif

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" markdown also starts with .md
autocmd BufNewFile,BufRead *.md set filetype=markdown

" fzf command
set rtp+=~/.fzf

nnoremap <leader>t :call fzf#run({ 'sink': 'tabe', 'options': '-m +c', 'dir': '.', 'source': 'find .' })<CR>

" ctags looks in the right directory
set tags=./.tags,.tags;$HOME
nnoremap <C-}> g<C-]>
nnoremap <C-[> <C-t>

" Run python when typing <leader>r
noremap <buffer> <leader>r :w<cr> :exec '!python' shellescape(@%, 1)<cr>

"ycm
"let g:ycm_global_ycm_extra_conf = '~/.dotfiles/vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf = 0 " Don't ask for confirmation about ycm_extra_conf
"
" From http://stackoverflow.com/questions/3105307/how-do-you-automatically-remove-the-preview-window-after-autocompletion-in-vim
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Red coloring at whitespace after end of line whitespace
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

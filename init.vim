
" Set vim to use number lines on startup
set number
syntax on
" case insensitive search
set ignorecase
set colorcolumn=80

call plug#begin()
Plug 'tpope/vim-sensible'

"Syntax checker specific to neovim
Plug 'w0rp/ale'

" fugitive - git plugin
Plug 'tpope/vim-fugitive'

" vim-airline - nice tabline
Plug 'bling/vim-airline'

" surround selected text with whatever
Plug 'tpope/vim-surround'

" adds tmux navigator to use with matlab must add ctrl+hjkl commands to tmux config file
Plug 'christoomey/vim-tmux-navigator'

" add an extension to use vim in my web browser.
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()



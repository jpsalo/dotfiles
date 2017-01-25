" Line numbers
set number


" Case insensitive on lower case, case sensitive on upper case
set ignorecase
set smartcase


" Ignores node_modules (in CtrlP)
set wildignore+=**/node_modules/**


" http://stackoverflow.com/a/1878984/7010222
set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=2    " Indents will have a width of 4

set softtabstop=2   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to space


" Python indent
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=79 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix |


" Plugin manager
" https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" Status/tabline
Plug 'vim-airline/vim-airline'

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" Function navigator for CtrlP
Plug 'tacahiroy/ctrlp-funky'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Syntax checker
Plug 'vim-syntastic/syntastic'

" Prefer local repo install of eslint over global install with syntastic
Plug 'mtscout6/syntastic-local-eslint.vim'

" Syntax and style checker for Python
Plug 'nvie/vim-flake8'

" Code completion (with JavaScript support)
" https://github.com/junegunn/vim-plug#post-update-hooks
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

" Toggle the display of the quickfix list and the location-list
Plug 'Valloric/ListToggle'

" Javascript indentation and syntax
Plug 'pangloss/vim-javascript'

" JSX syntax highlighting and indenting
Plug 'mxw/vim-jsx'

" TypeSript syntax
Plug 'leafgarland/typescript-vim'

" Color scheme
Plug 'morhetz/gruvbox'

" Auto-close brackets
Plug 'jiangmiao/auto-pairs'

call plug#end()


" Map the leader key to SPACE
let mapleader="\<SPACE>"


" Next or previous buffer in the buffer list
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>


" Switch to current directory
nnoremap <Leader>cd :cd %:p:h<CR>


" Run Python code
" http://stackoverflow.com/a/18948530/7010222b
" not working with <buffer> when using netrw
nnoremap <Leader>c :exec '!python' shellescape(@%, 1)<CR>


" GoTo
" https://github.com/Valloric/YouCompleteMe#ycmcompleter-subcommands
nnoremap <leader>jd :YcmCompleter GoTo<CR>


" Invoke CtrlP in find buffer
nnoremap <leader>bu :CtrlPBuffer<CR>


" Function navigator
nnoremap <Leader>fu :CtrlPFunky<CR>


" Key mappings for toggling locationlist and quickfix
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'


" Find dotfiles
let g:ctrlp_show_hidden = 1


" Tab line
let g:airline#extensions#tabline#enabled = 1

" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'


" Populate the location list
let g:syntastic_always_populate_loc_list = 1


" Python and JavaScript syntax checkers
" https://github.com/vim-syntastic/syntastic#faqcheckers
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['eslint']


" Enable JSX syntax highlighting and indenting for .js files (vim-jsx)
let g:jsx_ext_required = 0


" Enables syntax highlighting for Flow (vim-javascript)
let g:javascript_plugin_flow = 1


colorscheme gruvbox
set background=dark

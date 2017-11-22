" Enable mouse
set mouse=a


" Line numbers
set number


" Hide buffers instead of closing them
" Works good with buffer tags and tabline
set hidden


" Use more natural splitting
set splitbelow
set splitright


" Case insensitive on lower case, case sensitive on upper case
set ignorecase
set smartcase


" Ignores (in CtrlP)
set wildignore+=**/node_modules/**
set wildignore+=**/build/**
set wildignore+=**/.build/**


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


" Close quickfix and location-list when selecting file
" http://stackoverflow.com/a/21326968/7010222
" http://stackoverflow.com/a/10850835/7010222
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose <CR>:lclose<CR>


" Plugin manager
" https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')

" Close all buffers except current
Plug 'vim-scripts/BufOnly.vim'

" Git wrapper
Plug 'tpope/vim-fugitive'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" Status/tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tree explorer
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Syntax checker
Plug 'vim-syntastic/syntastic'

" Prefer local repo install of eslint over global install with syntastic
" Plug 'mtscout6/syntastic-local-eslint.vim'
" NOTE: There is a bug in 82da4209970523933d1dd3991644396352f9e1f7 where the
" directory is changed every time a new buffer is opened
Plug 'mtscout6/syntastic-local-eslint.vim', { 'commit': '7a78b2f2b9c38ca7db9c47ce8d74f854432c165f' }

" Syntax and style checker for Python
Plug 'nvie/vim-flake8'

" Code completion (with JavaScript support)
" https://github.com/junegunn/vim-plug#post-update-hooks
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

" Toggle the display of the quickfix list and the location-list
Plug 'Valloric/ListToggle'

" Javascript indentation and syntax
Plug 'pangloss/vim-javascript'

" JSX syntax highlighting and indenting
Plug 'mxw/vim-jsx'

" Flow completion and type error checking
Plug 'flowtype/vim-flow'

" TypeSript syntax
Plug 'leafgarland/typescript-vim'

" CoffeeScript
Plug 'kchmck/vim-coffee-script'

" Pug (Jade) syntax highlighting
Plug 'digitaltoad/vim-pug'

" Auto-close brackets
Plug 'jiangmiao/auto-pairs'

Plug 'ap/vim-css-color'

" Color scheme
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()


" Map the Leader key to SPACE
let mapleader="\<SPACE>"


" Next or previous buffer in the buffer list
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
autocmd FileType nerdtree nnoremap <buffer> <Tab> <NOP>
autocmd FileType nerdtree nnoremap <buffer> <S-Tab> <NOP>


" Exact search for visually selected text (without backslashes)
" http://vim.wikia.com/wiki/Search_for_visually_selected_text#Simple
vnoremap // y/\V<C-R>"<CR>


" Switch to current directory
nnoremap <Leader>cd :cd %:p:h<CR>


" Clear last search highlighting by hitting return
" https://stackoverflow.com/a/662914/7010222
noremap <CR> :noh<CR><CR>


" Run Python code
" http://stackoverflow.com/a/18948530/7010222b
" not working with <buffer> when using netrw
nnoremap <Leader>c :exec '!python' shellescape(@%, 1)<CR>


" GoTo, general and Flow
" https://github.com/Valloric/YouCompleteMe#ycmcompleter-subcommands
nnoremap <Leader>jd :YcmCompleter GoTo<CR>
nnoremap <Leader>fd :FlowJumpToDef<CR>


" Invoke CtrlP in find buffer
nnoremap <Leader>b :CtrlPBuffer<CR>


" Function navigator / jump to definiton
nnoremap <Leader>r :CtrlPBufTag<CR>


" Key mappings for toggling locationlist and quickfix
let g:lt_location_list_toggle_map = '<Leader>l'
let g:lt_quickfix_list_toggle_map = '<Leader>q'


" Toggle, reveal file in NERDTree
map <Leader>m :NERDTreeToggle<CR>
map <Leader>p :NERDTreeFind<CR>

" Activate main window if NERDTree is active before opening ctrlp
" http://vi.stackexchange.com/a/11300
function! CtrlPCommand()
  if exists("b:NERDTree")
    exec 'wincmd w'
  endif
  exec 'CtrlP'
endfunction
let g:ctrlp_cmd = 'call CtrlPCommand()'

" Delete buffer without losing the split window
" This is needed with NERDTree / netrw
" http://stackoverflow.com/a/4468491/7010222
nnoremap <Leader>w :bp\|bd #<CR>
autocmd FileType nerdtree nnoremap <buffer> <Leader>w <NOP>

" Automatically open the location/quickfix window after :make, :grep, :lvimgrep and friends if there are valid locations/errors
" http://stackoverflow.com/a/39010855/7010222
augroup myvimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END

" Map vimgrep command to avoid typing the file pattern
" http://stackoverflow.com/a/33286148/7010222
command! -nargs=1 Search vimgrep /<args>/j src/**/*.js
nnoremap <Leader>7 :Search<space>
" Search for current word in multiple files
" http://stackoverflow.com/a/1855875/7010222
map <Leader>fa :execute "noautocmd vimgrep /\\<" . expand("<cword>") . "\\>/j src/**/*." .  expand("%:e") <Bar> cw<CR>


" Absolute width of netrw window
let g:netrw_winsize = 25

" Do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3


" Improve syntax (for reference)
let g:ycm_seed_identifiers_with_syntax = 0

" Hide information about the current completion candidate
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_server_keep_logfiles = 1

" For reference
let g:ycm_server_python_interpreter = ''


" Find dotfiles
let g:ctrlp_show_hidden = 1

" Ignore spaces when searching CtrlP
" https://github.com/ctrlpvim/ctrlp.vim/issues/196#issuecomment-192541449
let g:ctrlp_abbrev = {
  \ 'gmode': 'i',
  \ 'abbrevs': [
    \ {
      \ 'pattern': ' ',
      \ 'expanded': '',
      \ 'mode': 'pfrz',
    \ },
    \ ]
  \ }

" More results with the default window size
let g:ctrlp_match_window = 'results:100'


" Tab line
let g:airline#extensions#tabline#enabled = 1

" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

" Uniquify buffers names with similar filename, suppressing common parts of paths
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Use straight statusline
let g:airline_left_sep = ''
let g:airline_right_sep = ''


" Populate the location list
let g:syntastic_always_populate_loc_list = 1


" Python and JavaScript (and Flow) syntax checkers
" https://github.com/vim-syntastic/syntastic#faqcheckers
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['eslint', 'flow']
" Not sure if this is needed
let g:syntastic_javascript_flow_exe = 'flow'


" Enable JSX syntax highlighting and indenting for .js files (vim-jsx)
let g:jsx_ext_required = 0


" Enables syntax highlighting for Flow (vim-javascript)
let g:javascript_plugin_flow = 1

" Do not open quickfix when no errors
let g:flow#autoclose = 1


" 256 colorspace for base16
" https://github.com/chriskempson/base16-shell#base16-vim-users
" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif

" colorscheme base16-github
"
syntax enable

" Change vim background and colorscheme based on iTerm profile
" https://stackoverflow.com/a/38883860/7010222
let iterm_profile = $ITERM_PROFILE
if iterm_profile == "dark"
    set background=dark
else
    set background=light
endif

colorscheme solarized

let g:airline_theme='solarized'


" Change cursor shape between insert and normal mode in iTerm2.app
" https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

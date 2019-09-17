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


" http://stackoverflow.com/a/1878984/7010222
set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=2    " Indents will have a width of 4

set softtabstop=2   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to space


" Close quickfix and location-list when selecting file
" http://stackoverflow.com/a/21326968/7010222
" http://stackoverflow.com/a/10850835/7010222
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose <CR>:lclose<CR>


" Plugin manager
" https://github.com/junegunn/vim-plug
" Automatic installation
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Automatically save changes to disk
Plug '907th/vim-auto-save'

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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" ack.vim
Plug 'mileszs/ack.vim'

" Toggle, display and navigate marks
Plug 'kshenoy/vim-signature'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Syntax checker
Plug 'w0rp/ale'

" Autocompletion library
Plug 'davidhalter/jedi-vim'

" Code completion
" https://github.com/Shougo/deoplete.nvim#install
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

Plug 'deoplete-plugins/deoplete-jedi'

" Toggle the display of the quickfix list and the location-list
Plug 'Valloric/ListToggle'

" Javascript indentation and syntax
Plug 'pangloss/vim-javascript'

" JSX syntax highlighting and indenting
Plug 'maxmellon/vim-jsx-pretty'

" Flow completion and type error checking
Plug 'flowtype/vim-flow'

" TypeSript syntax
Plug 'leafgarland/typescript-vim'

" CoffeeScript
Plug 'kchmck/vim-coffee-script'

" Pug (Jade) syntax highlighting
Plug 'digitaltoad/vim-pug'

" Auto-close brackets
Plug 'raimondi/delimitmate'

Plug 'ap/vim-css-color'

" Distraction-free writing
Plug 'junegunn/goyo.vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Color scheme
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'iCyMind/NeoSolarized'
Plug 'mhartington/oceanic-next'

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


" GoTo, Flow
nnoremap <Leader>fd :FlowJumpToDef<CR>

nmap <Leader>gn <Plug>(GitGutterNextHunk)
nmap <Leader>gp <Plug>(GitGutterPrevHunk)


" Key mappings for toggling locationlist and quickfix
let g:lt_location_list_toggle_map = '<Leader>l'
let g:lt_quickfix_list_toggle_map = '<Leader>q'


" Toggle, reveal file in NERDTree
map <Leader>m :NERDTreeToggle<CR>
map <Leader>p :NERDTreeFind<CR>


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

" Open the quickfix window instead of displaying grep results and prevent opening first matching file
" https://stackoverflow.com/a/23668278/7010222
" https://superuser.com/a/248739
" https://stackoverflow.com/a/5723927/7010222
command! -nargs=1 Search execute "silent grep! -iIr <args> src" | redraw! | cw
nnoremap <Leader>7 :Search<space>
" Search for current word in multiple files
" http://stackoverflow.com/a/1855875/7010222
map <Leader>fa :execute "noautocmd vimgrep /\\<" . expand("<cword>") . "\\>/j src/**/*." .  expand("%:e") <Bar> cw<CR>

" Find in current file
command! -nargs=1 Find execute "silent grep! -i <args> %" | redraw! | cw
nnoremap <Leader>ff :Find<space>


" Expand space carriage returns in delimitMate
" https://github.com/Raimondi/delimitMate/blob/master/doc/delimitMate.txt
let delimitMate_expand_space = 1
let delimitMate_expand_cr=1


" Disable jedi-vim's completions
let g:jedi#completions_enabled = 0


" Navigate through autocomplete suggestions and add them
" https://github.com/Shougo/deoplete.nvim/issues/246#issuecomment-344463696
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<C-l>"

" Select an option from popup menu with CR (Enter) without doing a return.
" When no entry selected, <CR> closes pum and inserts new line (default)
" Otherwise, use delimitMate <CR> expansion
" TODO: function
"
" https://github.com/Shougo/deoplete.nvim/issues/492#issuecomment-306751415
" https://github.com/Shougo/deoplete.nvim/issues/484#issuecomment-302987007
" https://github.com/Raimondi/delimitMate/issues/53#issuecomment-8765040
" https://github.com/Raimondi/delimitMate/blob/master/doc/delimitMate.txt
" https://github.com/vim/vim/issues/2004#issuecomment-324357529
imap <expr><CR> pumvisible() && !empty(v:completed_item) ? "\<C-y>" : "<Plug>delimitMateCR"


" Set tern bin in case there is many installations (such as local)
" https://github.com/carlitux/deoplete-ternjs#vim-configuration-example
" https://github.com/carlitux/deoplete-ternjs/pull/26#issue-83900767
function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:tern_path = StrTrim(system('PATH=$(npm bin):$PATH && which tern'))
if g:tern_path != 'tern not found'
  let g:deoplete#sources#ternjs#tern_bin = g:tern_path
endif


" Absolute width of netrw window
let g:netrw_winsize = 25

" Do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3


" Tab line
let g:airline#extensions#tabline#enabled = 1

" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

" Uniquify buffers names with similar filename, suppressing common parts of paths
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Use straight statusline
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Use straight tabs
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Hide git branch from statusline
" https://github.com/vim-airline/vim-airline/issues/605#issue-43567680
let g:airline#extensions#branch#enabled = 0

" Show ALE errors or warnings in statusline
let g:airline#extensions#ale#enabled = 1

" Powerline font symbols
" https://github.com/vim-airline/vim-airline/wiki/FAQ#the-powerline-font-symbols-are-not-showing-up
let g:airline_powerline_fonts=1


let g:ale_linters = {
\   'javascript': ['eslint', 'tsserver'],
\   'python': ['pycodestyle'],
\}

" After this is configured, :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'coffee': ['coffeelint'],
\   'python': ['autopep8'],
\}


" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
" let g:ale_fix_on_save = 1

" https://github.com/w0rp/ale#2iii-completion
" let g:ale_completion_enabled = 1


" Enables syntax highlighting for Flow (vim-javascript)
let g:javascript_plugin_flow = 1

" Do not open quickfix when no errors
let g:flow#autoclose = 1


" Enable syntax and keep color settings
" https://stackoverflow.com/questions/11272501/enable-vim-syntax-highlighting-by-default#comment40203854_11272512
syntax enable

" Use true color
" https://github.com/neovim/neovim/wiki/FAQ#how-can-i-use-true-color-in-the-terminal
" set termguicolors

" 256 colorspace for base16
" https://github.com/chriskempson/base16-shell#base16-vim-users
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Fix highlighting for spell checks in terminal
" Colors: https://github.com/chriskempson/base16/blob/master/styling.md
" Arguments: group, guifg, guibg, ctermfg, ctermbg, attr, guisp
" https://github.com/chriskempson/base16-vim/#customization
" https://github.com/chriskempson/base16-vim/issues/182#issue-336531173
"
" TODO: if has(termguicolors) set ... else

call Base16hi("SpellBad",   "", "", g:base16_cterm08, g:base16_cterm00, "", "")
call Base16hi("SpellCap",   "", "", g:base16_cterm0A, g:base16_cterm00, "", "")
call Base16hi("SpellLocal", "", "", g:base16_cterm0D, g:base16_cterm00, "", "")
call Base16hi("SpellRare",  "", "", g:base16_cterm0B, g:base16_cterm00, "", "")

" Contrast
" https://github.com/morhetz/gruvbox/wiki/Configuration#ggruvbox_contrast_light
" let g:gruvbox_contrast_light="medium"

let g:airline_theme = 'base16_vim'
" More monotonic look
let g:airline_base16_monotone = 1
" Improve the contrast for the inactive statusline
let g:airline_base16_improved_contrast = 1


" Invoke fzf in find buffer
nnoremap <Leader>b :Buffers<CR>


function! GFilesFallback(is_sub_project)
  " https://github.com/junegunn/fzf.vim/issues/233#issuecomment-257158595
  " Include untracked files
  " https://github.com/junegunn/fzf.vim/issues/129#issuecomment-256431038
  let is_git_repository = (system('git rev-parse --is-inside-work-tree'))
  if is_git_repository =~ 'true'
    if (a:is_sub_project == 1)
      call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --cached --others'}))
    else
      execute 'GFiles --exclude-standard --cached --others'
    endif
  else
    execute 'Files'
  endif
endfunction

function! Fuz(is_sub_project)
  if expand('%') =~ 'NERD_tree'
    execute "normal \<c-w>\<c-w>"
  endif
  call GFilesFallback(a:is_sub_project)
endfunction

" 1.  Don't open files in NERDtree from fzf
" 2.  Use :GFiles when in a git repo, otherwise use :Files
"     2.1. Optionally execute in current working directory if it is a sub
"     project
"
" https://github.com/junegunn/fzf.vim/issues/326#issuecomment-282936932
" https://github.com/junegunn/fzf.vim/issues/431#issuecomment-323862501
" https://github.com/junegunn/fzf.vim/issues/395#issuecomment-311566047
nnoremap <silent> <Leader><Leader> :call Fuz(0)<CR>
nnoremap <silent> <Leader>o :call Fuz(1)<CR>


" The Silver Searcher (ag) with ack
" https://github.com/ggreer/the_silver_searcher#vim
" https://github.com/mileszs/ack.vim#can-i-use-ag-the-silver-searcher-with-this
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" Disable folding
let g:vim_markdown_folding_disabled = 1


" Python virtualenv
" https://neovim.io/doc/user/provider.html#python-virtualenv
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

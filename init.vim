" GENERAL
"""""""""

" Map the Leader key to SPACE
let mapleader="\<SPACE>"

" Map ctrl-c to Esc to trigger InsertLeave
" https://github.com/neoclide/coc.nvim/issues/1197#issuecomment-534361825
inoremap <C-c> <Esc>

" Enable mouse
set mouse=a

" Enable syntax and keep color settings
" https://stackoverflow.com/questions/11272501/enable-vim-syntax-highlighting-by-default#comment40203854_11272512
syntax enable

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

" Ignore case on file and directory completion
set wildignorecase

" TAB and indent to 2 spaces
" http://stackoverflow.com/a/1878984/7010222
set tabstop=2       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.

set shiftwidth=2    " Indents will have a width of 2

set softtabstop=2   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to space

" Python virtualenv
" Set static interpreter (and pynvim package) for Neovim
" https://neovim.io/doc/user/provider.html#python-virtualenv
let g:python3_host_prog = '$WORKON_HOME/py3nvim/bin/python3'

" NOTE:
" g:node_host_prog is handled by neovim npm package (from `npm root -g`)
" g:coc_node_path picks that
" https://neovim.io/doc/user/provider.html#g:node_host_prog
" https://github.com/neoclide/coc.nvim/wiki/F.A.Q#environment-node-doesnt-meet-the-requirement

" PLUGINS
"""""""""

" https://github.com/junegunn/vim-plug
" Automatic installation
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Management of tags files
" NOTE: requires ctags
Plug 'ludovicchabant/vim-gutentags'

" IntelliSense. Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Automatically save changes to disk
Plug '907th/vim-auto-save'

" Close all buffers except current
Plug 'vim-scripts/BufOnly.vim'

" Git wrapper
Plug 'tpope/vim-fugitive'

" GitHub extension for fugitive.vim
Plug 'tpope/vim-rhubarb'

" GitLab extension for fugitive.vim
Plug 'shumphrey/fugitive-gitlab.vim'

" Stash extension for fugitive.vim
Plug 'mobiushorizons/fugitive-stash.vim'

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

" Toggle, display and navigate marks
Plug 'kshenoy/vim-signature'

" Git gutter
Plug 'airblade/vim-gitgutter'

" Toggle the display of the quickfix list and the location-list
Plug 'Valloric/ListToggle'

" Javascript indentation and syntax
Plug 'pangloss/vim-javascript'

" React (jsx, tsx) syntax highlighting and indenting
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Flow completion and type error checking
Plug 'flowtype/vim-flow'

" TypeSript syntax
Plug 'leafgarland/typescript-vim'

" CoffeeScript
Plug 'kchmck/vim-coffee-script'

" GraphQL
Plug 'jparise/vim-graphql'

" Pug (Jade) syntax highlighting
Plug 'digitaltoad/vim-pug'

" Auto-close brackets
Plug 'raimondi/delimitmate'

Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'

" Distraction-free writing
Plug 'junegunn/goyo.vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Color scheme
Plug 'chriskempson/base16-vim'

call plug#end()

" SETTINGS
""""""""""

" Exact search for visually selected text (without backslashes)
" http://vim.wikia.com/wiki/Search_for_visually_selected_text#Simple
vnoremap // y/\V<C-R>"<CR>

" Clear last search highlighting by hitting return
" https://stackoverflow.com/a/662914/7010222
noremap <CR> :noh<CR><CR>

" Switch to current directory
nnoremap <Leader>cd :cd %:p:h<CR>

" Expand space carriage returns in delimitMate
" https://github.com/Raimondi/delimitMate/blob/master/doc/delimitMate.txt
let delimitMate_expand_space = 1
let delimitMate_expand_cr=1

nmap <Leader>gn <Plug>(GitGutterNextHunk)
nmap <Leader>gp <Plug>(GitGutterPrevHunk)

" TODO: From environment variable (zshenv)?
let g:fugitive_gitlab_domains = ['https://gitlab.siilicloud.com']
let g:fugitive_stash_domains = ['http://buildtools.bisnode.com/stash/']

let g:gutentags_ctags_exclude = [
      \ '*-lock.json',
      \ 'build',
      \ 'dist',
      \ 'node_modules',
      \ 'xeno',
      \ ]

" Disable folding
let g:vim_markdown_folding_disabled = 1

" BUFFERS ("TABS")
""""""""""""""""""

" Next or previous buffer in the buffer list
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
autocmd FileType nerdtree nnoremap <buffer> <Tab> <NOP>
autocmd FileType nerdtree nnoremap <buffer> <S-Tab> <NOP>

" Delete buffer without losing the split window
" This is needed with NERDTree / netrw
" Compatible with `set hidden`
" http://stackoverflow.com/a/4468491/7010222
" https://stackoverflow.com/questions/4465095/vim-delete-buffer-without-losing-the-split-window/4468491#comment42185471_4468491
" https://vim.fandom.com/wiki/Easier_buffer_switching#Switching_to_the_previously_edited_buffer
" TODO: sometimes goes to ghost (previously active) buffer, such as, when closing last buffer
nnoremap <Leader>w :b#\|bd #<CR>
autocmd FileType nerdtree nnoremap <buffer> <Leader>w <NOP>

" LISTS
"""""""

" Key mappings for toggling locationlist and quickfix
let g:lt_location_list_toggle_map = '<Leader>l'
let g:lt_quickfix_list_toggle_map = '<Leader>q'

" Automatically open the location/quickfix window after :make, :grep, :lvimgrep and friends if there are valid locations/errors
" http://stackoverflow.com/a/39010855/7010222
augroup myvimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END

" Close quickfix and location-list when selecting file
" http://stackoverflow.com/a/21326968/7010222
" http://stackoverflow.com/a/10850835/7010222
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose <CR>:lclose<CR>

" TREE EXPLORER
"""""""""""""""

" Toggle, reveal file in NERDTree
map <Leader>m :NERDTreeToggle<CR>
map <Leader>p :NERDTreeFind<CR>

" Absolute width of netrw window
let g:netrw_winsize = 25

" Do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" STATUS/TABLINE
""""""""""""""""

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

" Show git branch from statusline
" https://github.com/vim-airline/vim-airline/issues/605#issue-43567680
let g:airline#extensions#branch#enabled = 1

" Disable git hunks
let g:airline#extensions#hunks#enabled = 0

" Powerline font symbols
" https://github.com/vim-airline/vim-airline/wiki/FAQ#the-powerline-font-symbols-are-not-showing-up
let g:airline_powerline_fonts=1

" Enable coc integration
let g:airline#extensions#coc#enabled = 1


" FUZZY FINDER
""""""""""""""

" Float
" https://github.com/junegunn/fzf/blob/master/README-VIM.md#starting-fzf-in-a-popup-window
" https://github.com/junegunn/fzf.vim/issues/821#issuecomment-581481211
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Reverse layout (with float)
" https://github.com/junegunn/fzf.vim/issues/317#issuecomment-281287381
let $FZF_DEFAULT_OPTS = '--reverse'

" Respecting .gitignore
" https://github.com/junegunn/fzf#respecting-gitignore
" https://github.com/junegunn/fzf.vim/issues/194#issuecomment-245031594
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" Don't open files in NERDtree from fzf
" https://github.com/junegunn/fzf.vim/issues/326#issuecomment-282936932
" https://github.com/junegunn/fzf/issues/453#issuecomment-166648024
" https://github.com/junegunn/fzf/issues/453#issuecomment-354634207
function! Fuz(command_str)
  if expand('%') =~ 'NERD_tree'
    execute "normal \<c-w>\<c-w>"
  endif
  execute a:command_str
endfunction

nnoremap <silent> <Leader><Leader> :call Fuz(':Files')<CR>
" Invoke fzf in find buffer
nnoremap <Leader>b :call Fuz(':Buffers')<CR>
" Ag
nnoremap <Leader>7 :call Fuz(':Ag')<CR>
" Tags
nnoremap <Leader>t :call Fuz(':Tags')<CR>

" Syntax highlighting in preview
" NOTE: Requires bat
" https://github.com/junegunn/fzf.vim/blob/master/README.md#example-customizing-files-command
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Global .ignore (local .ignore is enabled by default)
" Make :Ag not match file names, only the file content
"
" https://github.com/junegunn/fzf.vim/issues/346#issuecomment-288483704
" https://github.com/ggreer/the_silver_searcher/wiki/Advanced-Usage#ignore
" https://github.com/junegunn/fzf.vim/issues/582
" https://github.com/junegunn/fzf.vim/issues/475#issuecomment-339979974
command! -bang -nargs=* Ag call fzf#vim#ag(
  \ <q-args>,
  \ '--path-to-ignore ~/.ignore --hidden --ignore .git',
  \ {'options': '--delimiter : --nth 4..'},
  \ <bang>0)

" Only print the names of files containing matches, not the matching lines.
" An empty query will print all files that would be searched.
" TODO: NERDtree
command! -bang -nargs=* Matches call fzf#run(fzf#wrap(
  \ {'source': 'ag --files-with-matches '.shellescape(<q-args>)}
  \ ))

" Search for word under cursor
" TODO: NERDtree
" https://github.com/junegunn/fzf.vim/issues/50#issuecomment-161676378
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" INTELLISENSE
""""""""""""""

" Install extensions
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#install-extensions
" FIXME: newline
let g:coc_global_extensions = ['coc-json', 'coc-python', 'coc-angular', 'coc-eslint', 'coc-stylelintplus', 'coc-tsserver', 'coc-flow', 'coc-css', 'coc-prettier']

" Set dynamic interpreter for coc-python.
" Typically this will be active virtual environment's python interpreter
" https://github.com/neoclide/coc-python/issues/55#issuecomment-525352153
call coc#config('python', {
\  'pythonPath': split(execute('!which python'), '\n')[-1]
\})

" Resolve workspace folders from PYTHONPATH in .env file
" https://github.com/neoclide/coc.nvim/wiki/Using-workspaceFolders#resolve-workspace-folder
" https://github.com/neoclide/coc-python/issues/26#issuecomment-489805114
autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

" If no local eslint config is available, coc will use personal configuration
" file. This function resolves path to a nvm-npm directory where the plugins
" are installed.
" https://eslint.org/docs/developer-guide/nodejs-api#◆-new-eslint-options
" https://eslint.org/docs/user-guide/configuring#configuration-file-formats
" https://eslint.org/docs/user-guide/configuring#personal-configuration-file-deprecated
function! s:setup_global_eslint()
  " https://eslint.org/docs/user-guide/configuring#configuration-file-formats
  " FIXME: newline
  let configFiles = ['.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json', '.eslintrc']
  let hasLocalEslintConfig = 0

  for i in configFiles
    if !empty(findfile(i))
      let hasLocalEslintConfig = 1
      break
    endif
  endfor

  if hasLocalEslintConfig == 0
    " https://github.com/neoclide/coc.nvim/issues/1120#issue-486136450
    call coc#config("eslint.options.configFile", ($HOME . "/.eslintrc.js"))
    call coc#config("eslint.options.resolvePluginsRelativeTo", system('npm root -g'))
  endif
endfunction

:call s:setup_global_eslint()

" Show all diagnostics.
nnoremap <silent><nowait> <leader>e  :<C-u>CocList diagnostics<cr>

" Remap for rename current word
" https://github.com/neoclide/coc.nvim#example-vim-configuration
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo
nmap <silent> <leader>jd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <leader>fd :FlowJumpToDef<cr>

" Use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Setup `Prettier` command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Navigate through autocomplete suggestions and add them
" https://github.com/Shougo/deoplete.nvim/issues/246#issuecomment-344463696
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "\<C-l>"

" Skip delimitMate on pop-up menus
"
" Select an option from popup menu with CR (Enter) without doing a return.
" When no entry selected, <CR> closes pum (default)
" Otherwise, use delimitMate <CR> expansion
"
" https://github.com/Raimondi/delimitMate/blob/master/doc/delimitMate.txt
imap <expr> <CR> pumvisible()
                 \ ? "\<C-Y>"
                 \ : "<Plug>delimitMateCR"

" Colorful jsx config
let g:vim_jsx_pretty_colorful_config = 1 " default 0

" Enables syntax highlighting for Flow (vim-javascript)
let g:javascript_plugin_flow = 1

" Do not open quickfix when no errors
let g:flow#autoclose = 1

" UI
""""

" Use true color
" https://github.com/neovim/neovim/wiki/FAQ#how-can-i-use-true-color-in-the-terminal
" set termguicolors

" Fix highlighting for spell checks in terminal
" Colors: https://github.com/chriskempson/base16/blob/master/styling.md
" Arguments: group, guifg, guibg, ctermfg, ctermbg, attr, guisp
" https://github.com/chriskempson/base16-vim/#customization
" https://github.com/chriskempson/base16-vim/issues/182#issue-336531173
"
" TODO: if has(termguicolors) set ... else
function! s:base16_customize() abort
  call Base16hi("SpellBad",   "", "", g:base16_cterm08, g:base16_cterm00, "", "")
  call Base16hi("SpellCap",   "", "", g:base16_cterm0A, g:base16_cterm00, "", "")
  call Base16hi("SpellLocal", "", "", g:base16_cterm0D, g:base16_cterm00, "", "")
  call Base16hi("SpellRare",  "", "", g:base16_cterm0B, g:base16_cterm00, "", "")
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

" 256 colorspace for base16
" https://github.com/chriskempson/base16-shell#base16-vim-users
" https://github.com/base16-manager/base16-manager#notes
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

let g:airline_theme = 'base16_vim'
" More monotonic look
let g:airline_base16_monotone = 1
" Improve the contrast for the inactive statusline
let g:airline_base16_improved_contrast = 1

let g:goyo_width = 120

" On window resize, if goyo is active, do <c-w>= to resize the window
" https://github.com/junegunn/goyo.vim/issues/159#issuecomment-342417487
autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif

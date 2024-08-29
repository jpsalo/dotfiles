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
let g:python3_host_prog = '$NVIM_PYTHON_VIRTUALENV_PATH/bin/python3'

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
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Copilot
Plug 'github/copilot.vim'

" IntelliSense
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'

Plug 'williamboman/mason.nvim'

" Use release branch
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Management of tags files
" NOTE: requires ctags
Plug 'ludovicchabant/vim-gutentags'

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
" https://neovim.io/doc/user/editorconfig.html
" Plug 'editorconfig/editorconfig-vim'

" Status/tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tree explorer (neo-tree)
" https://www.reddit.com/r/neovim/comments/tuyzch/comment/i39x42i/?utm_source=share&utm_medium=web2x&context=3aaaaa
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v3.x' }

" buffer line (with tabpage integration)
" Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons) (NOTE: Already installed by neo-tree.nvim)
" Plug 'ryanoasis/vim-devicons' Icons without colours
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" Fuzzy finder
" Command from fzf documentation did not install fzf. Left here for reference
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" https://github.com/junegunn/fzf.vim/issues/1008
" Remember to source .zshrc
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Notification manager
Plug 'rcarriga/nvim-notify'

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
Plug 'tinted-theming/base16-vim'

" Indentation guides
Plug 'lukas-reineke/indent-blankline.nvim'

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

nnoremap <Leader>gn <Plug>(GitGutterNextHunk)
nnoremap <Leader>gp <Plug>(GitGutterPrevHunk)

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

" Next or previous buffer in the buffer list.
" BufferLineCycleNext and BufferLineCyclePrev commands will traverse the bufferline bufferlist in order
nnoremap <Tab> :BufferLineCycleNext<CR>
nnoremap <S-Tab> :BufferLineCyclePrev<CR>

" Delete buffer without losing the split window
" Compatible with `set hidden`
" http://stackoverflow.com/a/4468491/7010222
" https://stackoverflow.com/questions/4465095/vim-delete-buffer-without-losing-the-split-window/4468491#comment42185471_4468491
" https://vim.fandom.com/wiki/Easier_buffer_switching#Switching_to_the_previously_edited_buffer
" TODO: sometimes goes to ghost (previously active) buffer, such as, when closing last buffer
" nnoremap <Leader>w :b#\|bd #<CR>
nnoremap <Leader>w :bd<CR>

" set termguicolors
lua << EOF
  require("bufferline").setup{
    options = {
      -- Sidebar offsets
      -- https://github.com/akinsho/bufferline.nvim#sidebar-offsets
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true -- use a "true" to enable the default, or set your own character
        }
      }
    }
  }
EOF

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

" Toggle, reveal file in Neo-tree
" https://github.com/nvim-neo-tree/neo-tree.nvim#the-neotree-command
noremap <Leader>m :Neotree toggle left<CR>
noremap <Leader>n :Neotree toggle float<CR>
noremap <Leader>p :Neotree filesystem reveal left<CR>

lua << EOF
  require('neo-tree').setup({
    window = {
      -- Size of floating window
      -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/533#issuecomment-1287950467
      -- TODO: dimension variables
      popup = { -- settings that apply to float position only
        size = { height = "60%", width = "90%" },
        position = "50%", -- 50% means center it
      },
    },
  })
EOF

" Absolute width of netrw window
let g:netrw_winsize = 25

" Do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" STATUS/TABLINE
""""""""""""""""

" Tab line
" let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#enabled = 0

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
" let g:airline#extensions#coc#enabled = 1


" FUZZY FINDER
""""""""""""""

" Float
" https://github.com/junegunn/fzf/blob/master/README-VIM.md#starting-fzf-in-a-popup-window
" https://github.com/junegunn/fzf.vim/issues/821#issuecomment-581481211
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'border': 'none' } }

" Reverse layout (with float)
" https://github.com/junegunn/fzf.vim/issues/317#issuecomment-281287381
let $FZF_DEFAULT_OPTS = '--reverse'

" Respecting .gitignore
" https://github.com/junegunn/fzf#respecting-gitignore
" https://github.com/junegunn/fzf.vim/issues/194#issuecomment-245031594
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" Used to be: "Don't open files in NERDtree from fzf". Now it's a general function
" https://github.com/junegunn/fzf.vim/issues/326#issuecomment-282936932
" https://github.com/junegunn/fzf/issues/453#issuecomment-166648024
" https://github.com/junegunn/fzf/issues/453#issuecomment-354634207
function! Fuz(command_str)
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
command! -bang -nargs=* Matches call fzf#run(fzf#wrap(
  \ {'source': 'ag --files-with-matches '.shellescape(<q-args>)}
  \ ))

" i.e. Fag --ts heading, Fag --sass button
" https://github.com/junegunn/fzf.vim/issues/92
function! s:ag_with_opts(arg, bang)
  let tokens  = split(a:arg)
  let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  call fzf#vim#ag(query, ag_opts, {})
endfunction

autocmd VimEnter * command! -nargs=* -bang Fag call s:ag_with_opts(<q-args>, <bang>0)

" Search for word under cursor
" https://github.com/junegunn/fzf.vim/issues/50#issuecomment-161676378
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" INTELLISENSE
""""""""""""""

lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "vim", "vimdoc", "typescript", "html", "json", "python", "tsx" },
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,
    highlight = {
      enable = true,
    },
  }
EOF

lua << EOF
  require("mason").setup()
EOF

" Install extensions
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#install-extensions
" FIXME: newline
" let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-angular', 'coc-eslint', 'coc-stylelintplus', 'coc-tsserver', 'coc-flow', 'coc-css', 'coc-prettier']

" Resolve workspace folders from PYTHONPATH in .env file
" NOTE: Might not be needed anymore with venv and coc-pyright
" https://github.com/neoclide/coc.nvim/wiki/Using-workspaceFolders#resolve-workspace-folder
" https://github.com/neoclide/coc-python/issues/26#issuecomment-489805114
" autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

" If no local eslint config is available, coc will use personal configuration
" file. This function resolves path to a nvm-npm directory where the plugins
" are installed.
" https://eslint.org/docs/developer-guide/nodejs-api#◆-new-eslint-options
" https://eslint.org/docs/user-guide/configuring#configuration-file-formats
" https://eslint.org/docs/user-guide/configuring#personal-configuration-file-deprecated
" function! s:setup_global_eslint()
"   " https://eslint.org/docs/user-guide/configuring#configuration-file-formats
"   " FIXME: newline
"   let configFiles = ['.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json', '.eslintrc']
"   let hasLocalEslintConfig = 0
"
"   for i in configFiles
"     if !empty(findfile(i))
"       let hasLocalEslintConfig = 1
"       break
"     endif
"   endfor
"
"   if hasLocalEslintConfig == 0
"     " https://github.com/neoclide/coc.nvim/issues/1120#issue-486136450
"     call coc#config("eslint.options.configFile", ($HOME . "/.eslintrc.js"))
"     call coc#config("eslint.options.resolvePluginsRelativeTo", system('npm root -g'))
"   endif
" endfunction
"
" :call s:setup_global_eslint()

" Ensure coc-angular is loaded in templates
" https://github.com/iamcco/coc-angular/issues/56#issuecomment-1126947357
" https://github.com/neoclide/coc.nvim/issues/1183#issuecomment-842550700
" https://github.com/neoclide/coc.nvim/issues/132#issuecomment-433637296
" autocmd FileType html :call CocActionAsync('activeExtension', 'coc-angular')

" Show all diagnostics.
" nnoremap <silent><nowait> <leader>e  :<C-u>CocList diagnostics<cr>

" Remap for rename current word
" https://github.com/neoclide/coc.nvim#example-vim-configuration
" nnoremap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocActionAsync('doHover')
"   endif
" endfunction

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" GoTo
" nnoremap <silent> <leader>jd <Plug>(coc-definition)
" nnoremap <silent> gr <Plug>(coc-references)
nnoremap <leader>fd :FlowJumpToDef<cr>

" Use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Setup `Prettier` command
" command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Navigate through autocomplete suggestions and add them
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-and-s-tab-to-navigate-the-completion-list
" inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
" inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"
" https://github.com/Shougo/deoplete.nvim/issues/246#issuecomment-344463696
" inoremap <expr><C-j> pum#visible() ? "\<C-n>" : "\<Down>"
" inoremap <expr><C-k> pum#visible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <S-Tab> pumvisible() ? "<C-p>" :"<S-Tab>"
" inoremap <Down> <C-k>=pumvisible() ? "\<lt>C-N>" : "\<lt>Down>"<CR>

" cnoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
" cnoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"


" Use <cr> to confirm completion
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-cr-to-confirm-completion
" https://github.com/neoclide/coc-pairs/issues/83#issuecomment-1073263345
" inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Skip delimitMate on pop-up menus
"
" Select an option from popup menu with CR (Enter) without doing a return.
" When no entry selected, <CR> closes pum (default)
" Otherwise, use delimitMate <CR> expansion
"
" https://github.com/Raimondi/delimitMate/blob/master/doc/delimitMate.txt
" imap <expr> <CR> pumvisible()
"                  \ ? "\<C-Y>"
"                  \ : "<Plug>delimitMateCR"

" Colorful jsx config
let g:vim_jsx_pretty_colorful_config = 1 " default 0

" Enables syntax highlighting for Flow (vim-javascript)
let g:javascript_plugin_flow = 1

" Do not open quickfix when no errors
let g:flow#autoclose = 1

" Max line lenght highlight
" https://github.com/editorconfig/editorconfig-vim/blob/1d54632f7fcad38df8e428f349bc58b15af4b206/doc/editorconfig.txt#L125
let g:EditorConfig_max_line_indicator = "fillexceeding"

" UI
""""

" Global statusline
set laststatus=3

" Use true color
" https://github.com/neovim/neovim/wiki/FAQ#how-can-i-use-true-color-in-the-terminal
" set termguicolors

" Fix highlighting for spell checks in terminal
" Colors: https://github.com/chriskempson/base16/blob/master/styling.md
" Arguments: group, guifg, guibg, ctermfg, ctermbg, attr, guisp
" https://github.com/tinted-theming/base16-vim?tab=readme-ov-file#customization
" https://github.com/chriskempson/base16-vim/issues/182#issue-336531173
"
" TODO: if has(termguicolors) set ... else
function! s:base16_customize() abort
  call Base16hi("SpellBad",   "", "", g:base16_cterm08, g:base16_cterm00, "", "")
  call Base16hi("SpellCap",   "", "", g:base16_cterm0A, g:base16_cterm00, "", "")
  call Base16hi("SpellLocal", "", "", g:base16_cterm0D, g:base16_cterm00, "", "")
  call Base16hi("SpellRare",  "", "", g:base16_cterm0B, g:base16_cterm00, "", "")
endfunction

" See also: https://github.com/junegunn/goyo.vim#faq
augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

function! SetupTheme(theme_str)
  if (a:theme_str == 'base16')
    " 256 colorspace for base16
    let g:base16colorspace=256
    colorscheme base16-$BASE16_THEME
    let g:airline_theme = 'base16_vim'
    " More monotonic look
    let g:airline_base16_monotone = 1
    " Improve the contrast for the inactive statusline
    let g:airline_base16_improved_contrast = 1
    " Current selection highlight color in completion list. See also: https://github.com/neoclide/coc.nvim/discussions/3351#discussion-3555665
    " https://github.com/neoclide/coc.nvim/issues/3980
    " https://vi.stackexchange.com/q/9675
    " https://github.com/chriskempson/base16/blob/main/styling.md
    " execute 'highlight CocFloating ctermbg=' . g:base16_cterm08
    " execute 'highlight CocMenuSel ctermbg=' . g:base16_cterm02
    " hi link FzfFloat CocFloating
  endif
  " let g:fzf_colors = {
  " \ 'bg': ['bg', 'FzfFloat'],
  "     \ 'preview-bg': ['bg', 'Normal']}
endfunction

" https://github.com/tinted-theming/tinted-shell/blob/main/USAGE.md#base16-vim-users
if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
  call SetupTheme('base16')
endif

" Tmux & Vim
" https://github.com/tinted-theming/tinted-shell/blob/main/USAGE.md#tmux--vim
" NOTE/TODO: File needs to be sourced manually after theme is changed
if filereadable(expand("$HOME/.config/tinted-theming/set_theme.vim"))
  let base16colorspace=256
  " TODO: Add a keyboard shortcut to source this file
  source $HOME/.config/tinted-theming/set_theme.vim
endif

" TODO: max line length variable
let g:goyo_width = 120

" On window resize, if goyo is active, do <c-w>= to resize the window
" https://github.com/junegunn/goyo.vim/issues/159#issuecomment-342417487
autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif

" indent-blankline.nvim
lua << EOF
  require("ibl").setup()
EOF

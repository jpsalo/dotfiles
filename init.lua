--[[
BASE
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Map ctrl-c to Esc to trigger InsertLeave
-- https://github.com/neoclide/coc.nvim/issues/1197#issuecomment-534361825
vim.keymap.set('i', '<C-c>', '<Esc>')

vim.opt.tabstop = 2       -- The width of a TAB is set to 4.
                          -- Still it is a \t. It is just that
                          -- Vim will interpret it to be having
                          -- a width of 2.
vim.opt.shiftwidth = 2    -- Indents will have a width of 2
vim.opt.expandtab = true  -- Sets the number of columns for a TAB
vim.bo.softtabstop = 2    -- Expand TABs to space

-- Python virtualenv
-- Set static interpreter (and pynvim package) for Neovim
-- https://neovim.io/doc/user/provider.html#python-virtualenv
vim.g.python3_host_prog = '$NVIM_PYTHON_VIRTUALENV_PATH/bin/python3'

vim.cmd([[
" Hide buffers instead of closing them
" Works good with buffer tags and tabline
" set hidden

" Ignore case on file and directory completion
" set wildignorecase

" NOTE:
" g:node_host_prog is handled by neovim npm package (from `npm root -g`)
" https://neovim.io/doc/user/provider.html#g:node_host_prog
" https://github.com/neoclide/coc.nvim/wiki/F.A.Q#environment-node-doesnt-meet-the-requirement
]])

--[[
PLUGINS
--]]

vim.cmd([[
" https://github.com/junegunn/vim-plug
" Automatic installation
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]])

local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Copilot
Plug('github/copilot.vim')

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

-- LSP Zero & Mason
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('VonHeikemen/lsp-zero.nvim', {['branch'] = 'v4.x'})

-- Formatter
Plug('stevearc/conform.nvim')

-- Management of tags files
-- NOTE: requires ctags
Plug('ludovicchabant/vim-gutentags')

-- Automatically save changes to disk
Plug('907th/vim-auto-save')

-- Close all buffers except current
Plug('vim-scripts/BufOnly.vim')

-- Status/tabline
Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')

-- Tree explorer (neo-tree)
-- https://www.reddit.com/r/neovim/comments/tuyzch/comment/i39x42i/?utm_source=share&utm_medium=web2x&context=3aaaaa
Plug('nvim-lua/plenary.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('MunifTanjim/nui.nvim')
Plug('nvim-neo-tree/neo-tree.nvim', { ['branch'] = 'v3.x' })

-- buffer line (with tabpage integration)
--- Plug('nvim-tree/nvim-web-devicons' " Recommended (for coloured icons) (NOTE: Already installed by neo-tree.nvim)
-- Plug('ryanoasis/vim-devicons' Icons without colours
Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })

-- Fuzzy finder & live grep with args
-- Plug('nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x' })
Plug('nvim-telescope/telescope-live-grep-args.nvim')

-- Notification manager
Plug('rcarriga/nvim-notify')

-- Toggle, display and navigate marks
Plug('kshenoy/vim-signature')

-- Git gutter
Plug('airblade/vim-gitgutter')

-- Auto-close brackets
Plug('windwp/nvim-autopairs')

-- CSS colors
Plug('brenoprata10/nvim-highlight-colors')

-- Distraction-free writing
Plug('junegunn/goyo.vim')

-- Markdown
Plug('godlygeek/tabular')

-- Color scheme
Plug('tinted-theming/base16-vim')

-- Indentation guides
Plug('lukas-reineke/indent-blankline.nvim')

vim.call('plug#end')

--[[
SETTINGS
--]]

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<CR>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

local npairs = require'nvim-autopairs'
npairs.setup {}
local Rule = require'nvim-autopairs.rule'
local cond = require 'nvim-autopairs.conds'

-- Add spaces between parentheses
-- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  -- Rule for a pair with left-side ' ' and right side ' '
  Rule(' ', ' ')
    -- Pair will only occur if the conditional function returns true
    :with_pair(function(opts)
      -- We are checking if we are inserting a space in (), [], or {}
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1] .. brackets[1][2],
        brackets[2][1] .. brackets[2][2],
        brackets[3][1] .. brackets[3][2]
      }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    -- We only want to delete the pair of spaces when the cursor is as such: ( | )
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({
        brackets[1][1] .. '  ' .. brackets[1][2],
        brackets[2][1] .. '  ' .. brackets[2][2],
        brackets[3][1] .. '  ' .. brackets[3][2]
      }, context)
    end)
}
-- For each pair of brackets we will add another rule
for _, bracket in pairs(brackets) do
  npairs.add_rules {
    -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
      :with_pair(cond.none())
      :with_move(function(opts) return opts.char == bracket[2] end)
      :with_del(cond.none())
      :use_key(bracket[2])
      -- Removes the trailing whitespace that can occur without this
      :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
  }
end

vim.keymap.set('n', '<Leader>gn', '<Plug>(GitGutterNextHunk)', { noremap = true, silent = true, desc = 'Next git hunk' })
vim.keymap.set('n', '<Leader>gp', '<Plug>(GitGutterPrevHunk)', { noremap = true, silent = true, desc = 'Previous git hunk' })

vim.g.gutentags_ctags_exclude = { 'dist', '*-lock.json', 'build', 'dist', 'node_modules', 'xeno' }

vim.cmd([[

" Exact search for visually selected text (without backslashes)
" http://vim.wikia.com/wiki/Search_for_visually_selected_text#Simple
vnoremap // y/\V<C-R>"<CR>

" Switch to current directory
" nnoremap <Leader>cd :cd %:p:h<CR>
]])

--[[
BUFFERS
--]]

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

-- Next or previous buffer in the buffer list.
-- BufferLineCycleNext and BufferLineCyclePrev commands will traverse the bufferline bufferlist in order
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })

-- Delete buffer without losing the split window
-- Compatible with `set hidden`
-- http://stackoverflow.com/a/4468491/7010222
-- https://stackoverflow.com/questions/4465095/vim-delete-buffer-without-losing-the-split-window/4468491#comment42185471_4468491
-- https://vim.fandom.com/wiki/Easier_buffer_switching#Switching_to_the_previously_edited_buffer
-- TODO: sometimes goes to ghost (previously active) buffer, such as, when closing last buffer
vim.keymap.set('n', '<Leader>bd', ':bd<CR>', { noremap = true, silent = true, desc = 'Delete buffer without losing the split window' })

--[[
LISTS
--]]

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.cmd([[
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
]])

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

vim.cmd([[
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
]])

-- FUZZY FINDER

local telescope = require("telescope")
local actions = require("telescope.actions")
local lga_actions = require("telescope-live-grep-args.actions")
require("telescope").setup{
  defaults = {
    file_ignore_patterns = {
      "tags"
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = {
        i = {
          -- Quote prompt and add -t. Example: foo → "foo" -t
          ["<C-t>"] = lga_actions.quote_prompt({ postfix = ' -t' }),
          -- freeze the current list and start a fuzzy search in the frozen list
          ["<C-space>"] = actions.to_fuzzy_refine,
        },
      },
      }
  }
}
telescope.load_extension('live_grep_args')

local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions
vim.keymap.set('n', '<Leader><Leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', extensions.live_grep_args.live_grep_args, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>t', builtin.help_tags, {})

-- Print the paths with at least one match and suppress match contents.
-- Inspiration: https://github.com/nvim-telescope/telescope.nvim/issues/647#issuecomment-1536456802
-- NOTE: live_grep_args supports additional_args, but it doesn't work with --files-with-matches. See https://github.com/nvim-telescope/telescope-live-grep-args.nvim/issues/65#issuecomment-2093181733
vim.keymap.set('n', '<leader>7', function() builtin.live_grep({ additional_args = { '--files-with-matches' } }) end)

-- Live grep for the word under the cursor
local live_grep_args_shortcuts = require('telescope-live-grep-args.shortcuts')
vim.keymap.set('n', '<leader>gc', live_grep_args_shortcuts.grep_word_under_cursor)

-- INTELLISENSE

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "vim", "vimdoc", "markdown", "typescript", "angular", "html", "json", "python", "tsx" },
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
  highlight = {
    enable = true,
  },
}

-- LSP configuration
local lsp_zero = require('lsp-zero')

local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})

require('mason').setup({})
require('mason-lspconfig').setup({
  -- NOTE: Create a pyrightconfig.json file in the root of the project
  ensure_installed = {'vimls', 'lua_ls', 'marksman', 'html', 'cssls', 'jsonls', 'eslint', 'angularls', 'pyright', 'ruff'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        on_init = function(client)
          lsp_zero.nvim_lua_settings(client, {})
        end,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            },
          },
        },
      })
    end,

    -- Use Ruff exclusively for linting, formatting and organizing imports, and disable those capabilities in Pyright
    -- https://github.com/astral-sh/ruff-lsp?tab=readme-ov-file#example-neovim
    pyright = function()
      require('lspconfig').pyright.setup({
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { '*' },
            },
          },
        },
      })
    end,
  }
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete({}), { 'i', 'c' }),  -- open manually in insert mode
    ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
    ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
    ['<CR>'] = cmp.mapping.confirm({select = true}),  -- confirm without selecting the item
  }),
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = {
    format = require("nvim-highlight-colors").format
  }
})

local js_formatters = { "prettierd", "prettier", stop_after_first = true }
require("conform").setup({
  formatters_by_ft = {
    javascript = js_formatters,
    typescript = js_formatters,
    typescriptreact = js_formatters,
    python = { "ruff_fix", "ruff_format" },
  },
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

vim.cmd([[

" UI
""""
" set termguicolors

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
  endif
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
]])

-- indent-blankline.nvim
require("ibl").setup()

-- Set nvim-notify as default notify function and hide "No information available" messages from language servers.
-- https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-1297599534
local banned_messages = { "No information available" }
vim.notify = function(msg, ...)
  for _, banned in ipairs(banned_messages) do
    if msg == banned then
      return
    end
  end
  return require("notify")(msg, ...)
end

require('nvim-highlight-colors').setup({
  -- Render style
  -- @usage 'background'|'foreground'|'virtual'
  render = 'background',
})

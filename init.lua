-- Notation modeled from https://github.com/nvim-lua/kickstart.nvim

-- [[ Base ]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.tabstop = 2 -- The width of a TAB is set to 4.
-- Still it is a \t. It is just that
-- Vim will interpret it to be having
-- a width of 2.
vim.opt.shiftwidth = 2 -- Indents will have a width of 2
vim.opt.expandtab = true -- Sets the number of columns for a TAB
vim.bo.softtabstop = 2 -- Expand TABs to space

-- Decrease update time
vim.opt.updatetime = 500

-- Python virtualenv
-- Set static interpreter (and pynvim package) for Neovim
-- https://neovim.io/doc/user/provider.html#python-virtualenv
vim.g.python3_host_prog = "$NVIM_PYTHON_VIRTUALENV_PATH/bin/python3"

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

-- [[ Plugins ]]

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

local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- Copilot
Plug("zbirenbaum/copilot.lua")
Plug("zbirenbaum/copilot-cmp")

-- Treesitter
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

-- LSP & Mason
Plug("neovim/nvim-lspconfig")
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("WhoIsSethDaniel/mason-tool-installer.nvim")
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-nvim-lsp-signature-help")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")

-- Formatter
Plug("stevearc/conform.nvim")

-- Management of tags files
-- NOTE: requires ctags
Plug("ludovicchabant/vim-gutentags")

-- Automatically save changes to disk
Plug("907th/vim-auto-save")

-- Close all buffers except current
Plug("vim-scripts/BufOnly.vim")

-- Status/tabline
Plug("vim-airline/vim-airline")
Plug("vim-airline/vim-airline-themes")

-- Tree explorer (neo-tree)
-- https://www.reddit.com/r/neovim/comments/tuyzch/comment/i39x42i/?utm_source=share&utm_medium=web2x&context=3aaaaa
Plug("nvim-lua/plenary.nvim")
Plug("nvim-tree/nvim-web-devicons")
Plug("MunifTanjim/nui.nvim")
Plug("nvim-neo-tree/neo-tree.nvim", { ["branch"] = "v3.x" })

-- Bufferline (with tabpage integration)
Plug("nvim-tree/nvim-web-devicons") -- Recommended (for coloured icons)
-- Plug('ryanoasis/vim-devicons' Icons without colours
Plug("akinsho/bufferline.nvim", { ["tag"] = "*" })

-- Fuzzy finder & live grep with args
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "*" })
Plug("nvim-telescope/telescope-live-grep-args.nvim")

-- Notification manager
Plug("rcarriga/nvim-notify")

-- Toggle, display and navigate marks
Plug("kshenoy/vim-signature")

-- Git gutter
Plug("airblade/vim-gitgutter")

-- Auto-close brackets
Plug("windwp/nvim-autopairs")

-- tabout
Plug("abecodes/tabout.nvim")

-- CSS colors
Plug("brenoprata10/nvim-highlight-colors")

-- Distraction-free writing
Plug("junegunn/goyo.vim")

-- Markdown
Plug("godlygeek/tabular")

-- Color scheme
Plug("tinted-theming/tinted-vim")

-- Indentation guides
Plug("lukas-reineke/indent-blankline.nvim")

-- Obsidian
Plug("MeanderingProgrammer/render-markdown.nvim")
Plug("obsidian-nvim/obsidian.nvim", { ["tag"] = "*" })

vim.call("plug#end")

-- [[ Settings ]]

-- Map ctrl-c to Esc to trigger InsertLeave
-- https://github.com/neoclide/coc.nvim/issues/1197#issuecomment-534361825
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Clear highlights on search when pressing Enter in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<CR>", "<cmd>nohlsearch<CR>")

-- Visually select the word then double tap // to search what’s been selected
-- https://www.reddit.com/r/vim/comments/10k690h/comment/j5qz9j0/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- http://vim.wikia.com/wiki/Search_for_visually_selected_text#Simple
vim.keymap.set("v", "//", 'y/\\V<C-R>"<CR>')

-- Autopairs
local npairs = require("nvim-autopairs")
npairs.setup({})
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

-- Add spaces between parentheses
-- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses
local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
npairs.add_rules({
  -- Rule for a pair with left-side ' ' and right side ' '
  Rule(" ", " ")
    -- Pair will only occur if the conditional function returns true
    :with_pair(function(opts)
      -- We are checking if we are inserting a space in (), [], or {}
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1] .. brackets[1][2],
        brackets[2][1] .. brackets[2][2],
        brackets[3][1] .. brackets[3][2],
      }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    -- We only want to delete the pair of spaces when the cursor is as such: ( | )
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({
        brackets[1][1] .. "  " .. brackets[1][2],
        brackets[2][1] .. "  " .. brackets[2][2],
        brackets[3][1] .. "  " .. brackets[3][2],
      }, context)
    end),
})
-- For each pair of brackets we will add another rule
for _, bracket in pairs(brackets) do
  npairs.add_rules({
    -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
    Rule(bracket[1] .. " ", " " .. bracket[2])
      :with_pair(cond.none())
      :with_move(function(opts)
        return opts.char == bracket[2]
      end)
      :with_del(cond.none())
      :use_key(bracket[2])
      -- Removes the trailing whitespace that can occur without this
      :replace_map_cr(function(_)
        return "<C-c>2xi<CR><C-c>O"
      end),
  })
end

-- tabout
require("tabout").setup({})

vim.keymap.set(
  "n",
  "<Leader>gn",
  "<Plug>(GitGutterNextHunk)",
  { noremap = true, silent = true, desc = "Next git hunk" }
)
vim.keymap.set(
  "n",
  "<Leader>gp",
  "<Plug>(GitGutterPrevHunk)",
  { noremap = true, silent = true, desc = "Previous git hunk" }
)

vim.g.gutentags_ctags_exclude = { "dist", "*-lock.json", "build", "dist", "node_modules", "xeno" }

-- [[ Intellisense ]]

local treesitter = require("nvim-treesitter")

treesitter.install({
  -- NOTE: Commented out
  -- https://github.com/nvim-treesitter/nvim-treesitter/blob/d3218d988f72ed34414959c9ccd802d393432d6e/runtime/queries/angular/highlights.scm#L5
  -- https://github.com/nvim-treesitter/nvim-treesitter/pull/8312
  "angular",
  "astro",
  "bash",
  "css",
  "html",
  "json",
  -- lua install is stuck at [nvim-treesitter/install/lua]: Compiling parser
  -- "lua",
  "markdown",
  "markdown_inline",
  "python",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xresources",
  "yaml",
})

-- Enable treesitter highlighting
-- https://github.com/nvim-treesitter/nvim-treesitter/discussions/7927#discussioncomment-14479019
-- https://github.com/sharpchen/nix-config/blob/d357b8026930b9ec380e8cd480bbf983ed984cb0/dotfiles/nvim-config/lua/plugins/treesitter.lua#L55-L66
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
      vim.treesitter.start(args.buf)
    end
  end,
})

-- LSP configuration

-- Reserve a space in the gutter (note that vim-gitgutter will occupy the gutter)
vim.opt.signcolumn = "yes"

-- This is where you enable features that only work if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts) -- Use conform.nvim instead
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  end,
})

-- Show line diagnostics
-- NOTE: diagnostics are not exclusive to lsp servers so these can be global keybindings
-- https://lsp-zero.netlify.app/docs/guide/migrate-from-v1-branch.html#configure-diagnostics
vim.keymap.set("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>")

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup({})
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,

    bashls = function()
      require("lspconfig").bashls.setup({})
    end,

    lua_ls = function()
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
      -- https://lsp-zero.netlify.app/docs/guide/neovim-lua-ls.html#lua-config
      require("lspconfig").lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
              -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- https://github.com/nvim-lua/kickstart.nvim/issues/543#issuecomment-1859319206
              disable = { "missing-fields" },
            },
          },
        },
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
              return
            end
          end

          local nvim_settings = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              },
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
            },
          }
          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_settings)
        end,
      })
    end,

    -- Use Ruff exclusively for linting, formatting and organizing imports, and disable those capabilities in Pyright
    -- https://github.com/astral-sh/ruff-lsp?tab=readme-ov-file#example-neovim
    pyright = function()
      require("lspconfig").pyright.setup({
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              -- Ignore all files for analysis to exclusively use Ruff for linting
              ignore = { "*" },
            },
          },
        },
      })
    end,
  },
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "angularls",
    "astro",
    "bashls",
    "cssls",
    "eslint",
    "html",
    "jsonls",
    "lua_ls",
    "marksman",
    "prettier",
    "prettierd",
    "pyright", -- NOTE: Create a pyrightconfig.json file in the root of a project for pyright
    "ruff",
    "shellcheck",
    "stylua",
    "tailwindcss",
    "ts_ls",
    "vimls",
    "yamlfmt",
    "yamlls",
  },
  integrations = {
    ["mason-lspconfig"] = true,
  },
})

-- Copilot
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  copilot_no_tab_map = true, -- Disable tab mapping
})
require("copilot_cmp").setup({})

-- A completion plugin
local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "copilot", group_index = 2 }, -- De-prioritize copilot suggestions
    { name = "nvim_lsp", group_index = 1 },
    { name = "nvim_lsp_signature_help" },
    { name = "buffer" },
    { name = "path" },
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }), -- open manually in insert mode
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm without selecting the item
  }),
  preselect = "item",
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  formatting = {
    format = require("nvim-highlight-colors").format,
  },
})

-- https://github.com/hrsh7th/cmp-cmdline/issues/70#issuecomment-1927004734
local cmp_cmdline_select_prev_item = {
  c = function()
    if cmp.visible() then
      cmp.select_prev_item()
    else
      cmp.complete()
    end
  end,
}

local cmp_cmdline_select_next_item = {
  c = function()
    if cmp.visible() then
      cmp.select_next_item()
    else
      cmp.complete()
    end
  end,
}

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline({
    ["<C-k>"] = cmp_cmdline_select_prev_item,
    ["<C-j>"] = cmp_cmdline_select_next_item,
  }),
  sources = {
    { name = "buffer" },
  },
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline({
    ["<C-k>"] = cmp_cmdline_select_prev_item,
    ["<C-j>"] = cmp_cmdline_select_next_item,
  }),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})

local conform = require("conform")

-- Formatter plugin
local prettier_formatters = { "prettierd", "prettier", stop_after_first = true }
conform.setup({
  formatters_by_ft = {
    astro = prettier_formatters,
    css = { "prettier" }, --NOTE: prettierd does not seem to work
    javascript = prettier_formatters,
    json = prettier_formatters,
    lua = { "stylua" }, -- Basic settings are defined in ~/.editorconfig
    markdown = prettier_formatters,
    python = { "ruff_fix", "ruff_format" },
    sh = { "shellcheck" },
    tailwind = prettier_formatters,
    typescript = prettier_formatters,
    typescriptreact = prettier_formatters,
    yaml = { "yamlfmt" },
  },
  -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

-- Format on demand. NOTE: Visual mode does not work
-- https://github.com/stevearc/conform.nvim/issues/40#issuecomment-1719629250
vim.keymap.set({ "n", "x" }, "<F3>", function()
  conform.format({ async = true, lsp_fallback = true })
end)

-- [[ Fuzzy finder ]]

local telescope = require("telescope")
local actions = require("telescope.actions")
local lga_actions = require("telescope-live-grep-args.actions")
telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "tags",
    },
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
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
          ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t" }),
          -- freeze the current list and start a fuzzy search in the frozen list
          ["<C-Space>"] = actions.to_fuzzy_refine,
        },
      },
    },
  },
})
telescope.load_extension("live_grep_args")

local builtin = require("telescope.builtin")
local extensions = require("telescope").extensions
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

-- File pickers
vim.keymap.set("n", "<Leader><Leader>", builtin.find_files, {})
vim.keymap.set("n", "<Leader>fg", extensions.live_grep_args.live_grep_args, {})
-- Print the paths with at least one match and suppress match contents.
-- Inspiration: https://github.com/nvim-telescope/telescope.nvim/issues/647#issuecomment-1536456802
-- NOTE: live_grep_args supports additional_args, but it doesn't work with --files-with-matches. See https://github.com/nvim-telescope/telescope-live-grep-args.nvim/issues/65#issuecomment-2093181733
vim.keymap.set("n", "<Leader>7", function()
  builtin.live_grep({ additional_args = { "--files-with-matches" } })
end)
-- Live grep for the word under the cursor
vim.keymap.set("n", "<Leader>gc", live_grep_args_shortcuts.grep_word_under_cursor)

-- Vim pickers
vim.keymap.set("n", "<Leader>b", builtin.buffers, {})
vim.keymap.set("n", "<Leader>t", builtin.help_tags, {})
vim.keymap.set("n", "<Leader>c", builtin.command_history, {})
vim.keymap.set("n", "<Leader>h", builtin.search_history, {})

-- LSP pickers
vim.keymap.set("n", "<Leader>gd", builtin.lsp_definitions, {})
vim.keymap.set("n", "<Leader>gi", builtin.lsp_implementations, {})
vim.keymap.set("n", "<Leader>go", builtin.lsp_type_definitions, {})
vim.keymap.set("n", "<Leader>gr", builtin.lsp_references, {})

-- [[ UI and theme ]]

-- Use true color
-- https://github.com/neovim/neovim/wiki/FAQ#how-can-i-use-true-color-in-the-terminal
vim.opt.termguicolors = true

-- Statusline always and ONLY the last window
vim.opt.laststatus = 3

-- Configure smart line wrapping
-- https://www.reddit.com/r/neovim/comments/12lmvhw/comment/jg7gjm2/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.opt.wrap = true -- Wraps long lines instead of extending past the screen
vim.opt.linebreak = true -- Wraps at word boundaries for better readability
vim.opt.breakindent = true -- Maintains indentation on wrapped lines
vim.opt.breakindentopt = "list:-1" -- Uses the width of a match with 'formatlistpat' for indentation

-- The BASE16_THEME environment variable (from tinted-shell) will set to your current colorscheme
-- https://github.com/tinted-theming/tinted-shell/blob/main/USAGE.md#base16-vim-users
local function set_theme_from_env()
  local current_theme_name = os.getenv("BASE16_THEME")
  if current_theme_name and vim.g.colors_name ~= "base16-" .. current_theme_name then
    vim.cmd("colorscheme base16-" .. current_theme_name)
  end
end

-- Source the set_theme scripts to initialise the Vim theme. (Tmux may not handle environment variables correctly)
-- https://github.com/tinted-theming/tinted-shell/blob/main/USAGE.md#tmux--vim
local function set_theme_from_script()
  local set_theme_path = "$HOME/.config/tinted-theming/set_theme.lua"
  local is_set_theme_file_readable = vim.fn.filereadable(vim.fn.expand(set_theme_path)) == 1 and true or false
  if is_set_theme_file_readable then
    vim.cmd("source " .. set_theme_path)
  end
end

-- tinted-vim does not have base16_* variables anymore, so they are mapped manually from tinted_* variables for vim-airline
-- Commit where the variables were removed tinted-vim: https://github.com/tinted-theming/tinted-vim/commit/1366fdf52ba6e29d466e5ffad460d19aefef4c43
-- PR where the base16_gui* variables were added to tinted-vim:
-- https://github.com/tinted-theming/tinted-vim/pull/100 and https://github.com/tinted-theming/tinted-vim/pull/101
-- How they are used in vim-airline: https://github.com/vim-airline/vim-airline-themes/blob/master/autoload/airline/themes/base16_vim.vim
local function sync_tinted_to_base16_vars()
  local tinted_vars = vim.fn.getcompletion("g:tinted_cterm", "var")
  for _, var in ipairs(tinted_vars) do
    local name = var:gsub("g:", "") -- Remove g: prefix
    local new_name = name:gsub("^tinted_cterm", "base16_cterm")
    if vim.g[name] ~= nil then
      vim.g[new_name] = vim.g[name]
    end
  end
end

local function initialise_colorspace_vars()
  vim.g.base16colorspace = 256 -- For vim-airline-themes
  vim.g.base16_colorspace = 256 -- Legacy: https://github.com/tinted-theming/tinted-vim/commit/9d50944461665124a9b93e58450718ffb1ae6a11
  vim.g.tinted_colorspace = 256 -- Current
end

local function set_theme()
  initialise_colorspace_vars()
  set_theme_from_env() -- This "should" be enough but also set theme from script as a fallback
  set_theme_from_script()
  sync_tinted_to_base16_vars()
end

local function sync_theme()
  set_theme_from_script()
  sync_tinted_to_base16_vars()
  vim.cmd("AirlineRefresh")
end

vim.api.nvim_create_user_command("SyncTheme", sync_theme, {})

-- Remember to set the theme initially
set_theme()

-- Zen mode
vim.g.goyo_width = 120 -- TODO: max line length variable from ~/.editorconfig

-- On window resize, if goyo is active, do <c-w>= to resize the window
-- https://github.com/junegunn/goyo.vim/issues/159#issuecomment-342417487
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    if vim.fn.exists("#goyo") ~= 0 then
      vim.cmd("normal <c-w>=")
    end
  end,
})

-- Indent guides
require("ibl").setup()

-- Highlight colors
require("nvim-highlight-colors").setup({
  -- Render style
  -- @usage 'background'|'foreground'|'virtual'
  render = "background",
})

-- [[ Statusline ]]

-- Use bufferline instead of tabline
vim.g["airline#extensions#tabline#enabled"] = 0

-- Use straight statusline
vim.g.airline_left_sep = ""
vim.g.airline_right_sep = ""

-- Show git branch from statusline
-- https://github.com/vim-airline/vim-airline/issues/605#issue-43567680
vim.g["airline#extensions#branch#enabled"] = 1

-- Disable git hunks
vim.g["airline#extensions#hunks#enabled"] = 0

-- Powerline font symbols
-- https://github.com/vim-airline/vim-airline/wiki/FAQ#the-powerline-font-symbols-are-not-showing-up
vim.g.airline_powerline_fonts = 1

-- This will expect sync_tinted_to_base16_vars to be called after the tinted-vim theme is set
vim.g.airline_theme = "base16_vim"
-- More monotonic look
vim.g.airline_base16_monotone = 1
-- Improve the contrast for the inactive statusline
vim.g.airline_base16_improved_contrast = 1

-- [[ Buffers ]]

-- bufferline.nvim requires termguicolors and colorscheme to be set
local bufferline = require("bufferline")
bufferline.setup({
  options = {
    -- Sidebar offsets
    -- https://github.com/akinsho/bufferline.nvim#sidebar-offsets
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true, -- use a "true" to enable the default, or set your own character
      },
    },
  },
})

-- Next or previous buffer in the buffer list.
-- BufferLineCycleNext and BufferLineCyclePrev commands will traverse the bufferline bufferlist in order
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- Go to buffer in position
for i = 1, 9 do
  vim.keymap.set("n", "<Leader>" .. i, function()
    bufferline.go_to(i, true)
  end, { noremap = true, silent = true, desc = "Go to buffer in position " .. i })
end

-- Go to last visible buffer
vim.keymap.set("n", "<Leader>0", function()
  bufferline.go_to(-1, true)
end, { noremap = true, silent = true, desc = "Go to last visible buffer" })

-- Delete buffer without losing the split window
-- Compatible with `set hidden`
-- http://stackoverflow.com/a/4468491/7010222
-- https://stackoverflow.com/questions/4465095/vim-delete-buffer-without-losing-the-split-window/4468491#comment42185471_4468491
-- https://vim.fandom.com/wiki/Easier_buffer_switching#Switching_to_the_previously_edited_buffer
-- TODO: sometimes goes to ghost (previously active) buffer, such as, when closing last buffer
vim.keymap.set(
  "n",
  "<Leader>bd",
  ":bd<CR>",
  { noremap = true, silent = true, desc = "Delete buffer without losing the split window" }
)

-- [[ Lists ]]

-- Diagnostic keymaps
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Close quickfix menu after selecting choice
-- https://stackoverflow.com/a/75039844/7010222
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

-- [[ Tree explorer ]]

require("neo-tree").setup({
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

-- Toggle, reveal file in Neo-tree
vim.keymap.set("n", "<Leader>m", ":Neotree toggle left<CR>")
vim.keymap.set("n", "<Leader>n", ":Neotree toggle float<CR>")
vim.keymap.set("n", "<Leader>p", ":Neotree filesystem reveal left<CR>")

-- [[ Notifications ]]

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

-- Obsidian
require("obsidian").setup({
  -- legacy_commands will be removed in the next major release
  -- https://github.com/obsidian-nvim/obsidian.nvim/wiki/Commands
  legacy_commands = false,
  workspaces = {
    {
      name = "Work",
      path = "~/Documents/Wault",
    },
  },
  -- UI module will be removed in the future, and it is recommend to use dedicated markdown render plugins
  -- https://github.com/orgs/obsidian-nvim/discussions/491
  ui = {
    enable = false,
  },
})

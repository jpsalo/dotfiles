-- Notation modeled from https://github.com/nvim-lua/kickstart.nvim

-- [[ Base ]]

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
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

-- Required for opencode.nvim file reload events
vim.o.autoread = true

-- Scroll behavior
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.smoothscroll = true -- Scroll by screen line

-- Undo persistence
vim.opt.undofile = true -- Save undo history across sessions

-- Completion menu
vim.opt.pumheight = 10 -- Limit popup menu height

-- Better diff algorithm
vim.opt.diffopt:append("linematch:60")

-- Quality of life improvements
vim.opt.confirm = true -- Ask to save instead of failing
vim.opt.splitkeep = "screen" -- Keep text on screen when opening splits
vim.opt.jumpoptions = "view" -- Restore view when jumping

-- Reserve space in gutter for signs (git, diagnostics, etc.)
vim.opt.signcolumn = "yes"

-- Python virtualenv
-- Set static interpreter (and pynvim package) for Neovim
-- https://neovim.io/doc/user/provider.html#python-virtualenv
vim.g.python3_host_prog = "$NVIM_PYTHON_VIRTUALENV_PATH/bin/python3"

vim.cmd([[
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

-- Plugin collection
Plug("folke/snacks.nvim")

-- AI assistant
Plug("folke/snacks.nvim")
Plug("NickvanDyke/opencode.nvim")

-- Treesitter
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

-- LSP & Mason
Plug("neovim/nvim-lspconfig")
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("WhoIsSethDaniel/mason-tool-installer.nvim")

-- Completion plugin
Plug("saghen/blink.cmp", { ["tag"] = "v1.*" })
Plug("rafamadriz/friendly-snippets")

-- Formatter
Plug("stevearc/conform.nvim")

-- Management of tags files
-- NOTE: requires ctags
Plug("ludovicchabant/vim-gutentags")

-- Automatically save changes to disk
Plug("907th/vim-auto-save")

-- Status/tabline
Plug("nvim-lualine/lualine.nvim")

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
Plug("folke/zen-mode.nvim")

-- Markdown
Plug("godlygeek/tabular")

-- Color scheme
Plug("tinted-theming/tinted-nvim")

-- Indentation guides
Plug("lukas-reineke/indent-blankline.nvim")

-- Highlighting other uses of the word under the cursor
Plug("https://github.com/RRethy/vim-illuminate")

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

-- Plugin collection
require("snacks").setup({
  bigfile = { enabled = true }, -- Better handling of large files
  input = { enabled = true },
  -- bufdelete is available by default, no need to enable explicitly
})

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

-- [[ AI assistant ]]

---@type opencode.Opts
vim.g.opencode_opts = {
  provider = {
    enabled = "tmux",
    tmux = {
      split_direction = "h", -- horizontal split below
    },
  },
}

-- Keymaps
vim.keymap.set({ "n", "x" }, "<Leader>oa", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })

vim.keymap.set({ "n", "x" }, "<Leader>ox", function()
  require("opencode").select()
end, { desc = "Execute opencode action…" })

vim.keymap.set({ "n", "t" }, "<Leader>oc", function()
  require("opencode").toggle()
end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "<Leader>or", function()
  return require("opencode").operator("@this ")
end, { expr = true, desc = "Add range to opencode" })

vim.keymap.set("n", "<Leader>ol", function()
  return require("opencode").operator("@this ") .. "_"
end, { expr = true, desc = "Add line to opencode" })

vim.keymap.set("n", "<S-C-u>", function()
  require("opencode").command("session.half.page.up")
end, { desc = "opencode half page up" })

vim.keymap.set("n", "<S-C-d>", function()
  require("opencode").command("session.half.page.down")
end, { desc = "opencode half page down" })

-- [[ Intellisense ]]

local treesitter = require("nvim-treesitter")

treesitter.install({
  -- NOTE: Commented out
  -- https://github.com/nvim-treesitter/nvim-treesitter/blob/d3218d988f72ed34414959c9ccd802d393432d6e/runtime/queries/angular/highlights.scm#L5
  -- https://github.com/nvim-treesitter/nvim-treesitter/pull/8312
  "angular",
  "astro",
  "bash",
  "comment",
  "css",
  "html",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "scss",
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

local lsp_servers = {
  "angularls",
  "astro",
  "bashls",
  "cssls",
  "eslint",
  "home_assistant",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "pyright", -- NOTE: Create a pyrightconfig.json file in the root of a project for pyright
  "ruff",
  "tailwindcss",
  "ts_ls",
  "vimls",
  "yamlls",
}

local non_lsp_tools = {
  "prettier",
  "prettierd",
  "shellcheck",
  "stylua",
  "yamlfmt",
}

local all_mason_tools = vim.list_extend(vim.list_extend({}, lsp_servers), non_lsp_tools)

local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

require("mason").setup({})

-- This handles the name translation between lspconfig names (e.g., lua_ls) and Mason package names (e.g., lua-language-server)
require("mason-lspconfig").setup({
  automatic_enable = false,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
vim.lsp.config("lua_ls", {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        },
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

-- Use Ruff exclusively for linting, formatting and organizing imports, and disable those capabilities in Pyright
-- https://github.com/astral-sh/ruff-lsp?tab=readme-ov-file#example-neovim
vim.lsp.config("pyright", {
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

for _, server_name in ipairs(lsp_servers) do
  vim.lsp.config(server_name, {
    capabilities = lsp_capabilities,
  })
  vim.lsp.enable(server_name)
end

-- Automatically install LSP servers and non-LSP tools (formatters, linters, etc.)
require("mason-tool-installer").setup({
  ensure_installed = all_mason_tools,
})

-- A completion plugin

require("blink.cmp").setup({
  -- Keymap configuration
  keymap = {
    preset = "default", -- Uses C-y to accept
    -- Custom keybindings
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-s>"] = { "show_signature", "hide_signature", "fallback" }, -- Signature help toggle
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = false, -- Manual trigger
    },
    menu = {
      draw = {
        components = {
          -- nvim-highlight-colors integration for color preview in completion
          -- https://github.com/brenoprata10/nvim-highlight-colors?tab=readme-ov-file#blinkcmp-integration
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              -- If LSP source, check for color derived from documentation
              if ctx.item.source_name == "LSP" then
                local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                if color_item and color_item.abbr ~= "" then
                  icon = color_item.abbr
                end
              end
              return icon .. ctx.icon_gap
            end,
            highlight = function(ctx)
              local highlight = "BlinkCmpKind" .. ctx.kind
              -- If LSP source, check for color derived from documentation
              if ctx.item.source_name == "LSP" then
                local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                if color_item and color_item.abbr_hl_group then
                  highlight = color_item.abbr_hl_group
                end
              end
              return highlight
            end,
          },
        },
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  signature = {
    enabled = true,
  },
  -- Fuzzy matching with auto-download pre-built binaries
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      -- Add C-k/C-j navigation for cmdline mode
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
    },
    completion = {
      menu = {
        auto_show = false, -- Matches nvim default behavior
      },
    },
  },
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
    path_display = { "smart" }, -- Smart path shortening: shows filename only when unique, adds parent dir for duplicates
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
vim.keymap.set("n", "<Leader>ff", function()
  builtin.live_grep({ additional_args = { "--files-with-matches" } })
end)
vim.keymap.set(
  "n",
  "<Leader>gc",
  live_grep_args_shortcuts.grep_word_under_cursor,
  { desc = "Live grep for the word under the cursor" }
)

vim.keymap.set("n", "<Leader>q", builtin.diagnostics, { desc = "Diagnostics" })

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

-- Tinty sets the theme
require("tinted-colorscheme").setup(nil, {
  supports = {
    tinty = true,
    live_reload = true,
  },
  highlights = {
    telescope = true,
    telescope_borders = false,
    indentblankline = true,
    notify = true,
    illuminate = true,
    lsp_semantic = true,
  },
})

require("zen-mode").setup()

-- Indent guides
require("ibl").setup()

-- Highlight colors
require("nvim-highlight-colors").setup({
  -- Render style
  -- @usage 'background'|'foreground'|'virtual'
  render = "background",
})

-- [[ Statusline ]]

-- Lualine configuration
require("lualine").setup({
  options = {
    theme = "base16",
    -- Disabling separators
    component_separators = "",
    section_separators = "",
    globalstatus = true, -- Global statusline
  },
  sections = {
    lualine_x = {
      "lsp_status",
      -- Check current defaults here: https://github.com/nvim-lualine/lualine.nvim
      "encoding",
      "fileformat",
      "filetype",
    },
  },
})

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
-- Using Snacks.bufdelete for intelligent buffer deletion with safety prompts
-- Preserves window layout and prompts to save if buffer has unsaved changes
vim.keymap.set("n", "<Leader>bd", function()
  require("snacks").bufdelete()
end, { noremap = true, silent = true, desc = "Delete buffer (with safety prompts)" })

-- Force delete buffer without prompts (discard unsaved changes)
vim.keymap.set("n", "<Leader>bD", function()
  require("snacks").bufdelete({ force = true })
end, { noremap = true, silent = true, desc = "Force delete buffer (discard changes)" })

-- Delete all buffers except current
vim.keymap.set("n", "<Leader>bo", function()
  require("snacks").bufdelete.other()
end, { noremap = true, silent = true, desc = "Delete all buffers except current" })

-- Delete all buffers
vim.keymap.set("n", "<Leader>ba", function()
  require("snacks").bufdelete.all()
end, { noremap = true, silent = true, desc = "Delete all buffers" })

-- [[ Lists ]]

-- Close quickfix menu after selecting choice
-- https://stackoverflow.com/a/75039844/7010222
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

-- [[ Tree explorer ]]

require("neo-tree").setup({
  popup_border_style = "", -- "" to use 'winborder'
  default_component_configs = {
    -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
    file_size = {
      enabled = false,
    },
    type = {
      enabled = false,
    },
    last_modified = {
      enabled = false,
    },
    created = {
      enabled = false,
    },
    symlink_target = {
      enabled = false,
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
  completion = {
    -- Blink completion broken: https://github.com/obsidian-nvim/obsidian.nvim/issues/582
    blink = false,
  },
})

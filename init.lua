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
vim.o.winborder = "rounded"
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

-- Handle post-install hooks
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    -- Handle nvim-treesitter post-install
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  -- Dependencies (install these first)
  "https://github.com/nvim-lua/plenary.nvim", -- required by: gitsigns, obsidian
  "https://github.com/nvim-tree/nvim-web-devicons", -- required by: bufferline, lualine
  "https://github.com/rafamadriz/friendly-snippets", -- required by: blink.cmp

  -- Core functionality
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/folke/sidekick.nvim",
  "https://github.com/zbirenbaum/copilot.lua",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/mikavilpas/yazi.nvim",

  -- Language features
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

  -- Completion and snippets
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },

  -- Editing
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/907th/vim-auto-save",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/abecodes/tabout.nvim",

  -- UI Components
  "https://github.com/nvim-lualine/lualine.nvim",
  {
    src = "https://github.com/akinsho/bufferline.nvim",
    version = vim.version.range("*"),
  },

  -- Notifications and visual feedback
  "https://github.com/rcarriga/nvim-notify",
  "https://github.com/kshenoy/vim-signature",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/RRethy/vim-illuminate",
  "https://github.com/petertriho/nvim-scrollbar",

  -- Writing and notes
  "https://github.com/folke/zen-mode.nvim",
  "https://github.com/godlygeek/tabular",
  "https://github.com/tinted-theming/tinted-nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  {
    src = "https://github.com/obsidian-nvim/obsidian.nvim",
    version = vim.version.range("*"),
  },
})

-- Helper command for package updates
vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, { desc = "Update plugins via vim.pack" })

-- [[ Keymap Management ]]

local which_key = require("which-key")
which_key.setup({
  preset = "modern",
  delay = 200, -- Time in ms to show which-key popup
  icons = {
    mappings = true, -- Use icons from nvim-web-devicons
  },
})

-- Define keymap groups
which_key.add({
  { "<Leader>l", group = "LSP" },
  { "<Leader>lg", group = "LSP Goto" },
  { "<Leader>g", group = "Git" },
  { "<Leader>b", group = "Buffers" },
  { "<Leader>h", group = "Harpoon" },
  { "<Leader>a", group = "AI" },
  { "<Leader>t", group = "Explorer" },
  { "<Leader>s", group = "Search" },
})

-- [[ Settings ]]

-- Map ctrl-c to Esc to trigger InsertLeave
-- https://github.com/neoclide/coc.nvim/issues/1197#issuecomment-534361825
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape to normal mode" })

-- Clear highlights on search when pressing Enter in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<CR>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Visually select the word then double tap // to search what's been selected
-- https://www.reddit.com/r/vim/comments/10k690h/comment/j5qz9j0/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- http://vim.wikia.com/wiki/Search_for_visually_selected_text#Simple
vim.keymap.set("v", "//", 'y/\\V<C-R>"<CR>', { desc = "Search selected text" })

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
  bigfile = { enabled = true },
  input = { enabled = true },
  explorer = { enabled = true },
  picker = {
    enabled = true,
    sources = {
      harpoon = {
        finder = function()
          local files = {}
          local cwd = vim.loop.cwd()
          for idx, item in ipairs(require("harpoon"):list().items) do
            table.insert(files, {
              cwd = cwd,
              text = item.value,
              file = item.value,
              idx = idx,
            })
          end
          return files
        end,
        format = "text",
        preview = "file",
        confirm = "jump",
        win = {
          input = {
            keys = {
              -- ["dd"] = { "harpoon_delete", mode = { "n", "x" } },
              ["<C-d>"] = { "harpoon_delete", mode = { "i", "n", "x" } },
            },
          },
          list = {
            keys = {
              -- ["dd"] = { "harpoon_delete", mode = { "n", "x" } },
              ["<C-d>"] = { "harpoon_delete", mode = { "i", "n", "x" } },
            },
          },
        },
        actions = {
          harpoon_delete = function(picker, item)
            local to_remove = item or picker:selected()
            if not to_remove then
              return
            end
            require("harpoon"):list():remove({ value = to_remove.text })
            -- Normalize list: harpoon leaves nil holes after remove()
            local items = require("harpoon"):list().items
            local normalized = {}
            for _, v in pairs(items) do
              if v ~= nil then
                table.insert(normalized, v)
              end
            end
            require("harpoon"):list().items = normalized
            picker:find({ refresh = true })
          end,
        },
      },
    },
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "i", "n" } },
          ["<C-j>"] = { "list_down", mode = "i" },
          ["<C-k>"] = { "list_up", mode = "i" },
        },
      },
    },
  },
})

-- tabout
require("tabout").setup({})

-- Git signs
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Navigation
    map("n", "<Leader>gn", function()
      if vim.wo.diff then
        vim.cmd.normal({ "<Leader>gn", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Next git hunk" })

    map("n", "<Leader>gp", function()
      if vim.wo.diff then
        vim.cmd.normal({ "<Leader>gp", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Previous git hunk" })
  end,
})

-- Visual scrollbar with git integration
require("scrollbar").setup({
  excluded_filetypes = {
    "snacks_layout_box",
  },
  handlers = {
    cursor = false,
    gitsigns = true,
  },
})
require("scrollbar.handlers.gitsigns").setup()

-- [[ AI assistant ]]

require("sidekick").setup({
  nes = { enabled = true }, -- Enable Copilot NES
  cli = {
    mux = {
      backend = "tmux",
      enabled = true,
      create = "window",
    },
    win = {
      layout = "right",
    },
  },
  picker = "snacks",
})

-- Keymaps
vim.keymap.set({ "n", "x" }, "<Leader>at", function()
  require("sidekick.cli").send({ msg = "{this}" })
end, { desc = "Send this" })

vim.keymap.set({ "n", "x" }, "<Leader>av", function()
  require("sidekick.cli").send({ msg = "{selection}" })
end, { desc = "Send visual selection" })

vim.keymap.set("n", "<Leader>af", function()
  require("sidekick.cli").send({ msg = "{file}" })
end, { desc = "Send file" })

vim.keymap.set({ "n", "t" }, "<Leader>ac", function()
  require("sidekick.cli").toggle({ name = "opencode", focus = true })
end, { desc = "Toggle opencode" })

vim.keymap.set("n", "<Leader>ap", function()
  require("sidekick.cli").prompt()
end, { desc = "Select AI prompt" })

vim.keymap.set("n", "<Leader>as", function()
  require("sidekick.cli").select()
end, { desc = "Select AI tool" })

-- NES jump/apply:
--   Insert mode: <Tab> in blink.cmp's keymap pipeline (snippet → NES → fallback to Copilot)
--   Normal mode: <Leader>ay

vim.keymap.set("n", "<Leader>an", function()
  require("sidekick.nes").clear()
end, { desc = "NES: Clear suggestions" })

vim.keymap.set("n", "<Leader>ay", function()
  require("sidekick").nes_jump_or_apply()
end, { desc = "NES: Accept/apply suggestion" })

-- [[ GitHub Copilot ]]

require("copilot").setup({
  panel = {
    enabled = false, -- Disable panel feature (not used)
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<Tab>", -- Tab to accept in insert mode (part of blink.cmp Tab chain)
      next = "<C-j>", -- Ctrl+j for next
      prev = "<C-k>", -- Ctrl+k for previous
      dismiss = "<C-e>", -- Ctrl+e to dismiss
    },
  },
})

-- Hide copilot when blink.cmp menu is open
vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

-- [[ Intellisense ]]

local treesitter = require("nvim-treesitter")

treesitter.install({
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
  "zsh",
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
    -- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts) -- Use conform.nvim instead
    vim.keymap.set(
      "n",
      "<Leader>lr",
      "<cmd>lua vim.lsp.buf.rename()<CR>",
      vim.tbl_extend("force", opts, { desc = "Rename symbol" })
    )
    vim.keymap.set(
      "n",
      "<Leader>la",
      "<cmd>lua vim.lsp.buf.code_action()<CR>",
      vim.tbl_extend("force", opts, { desc = "Code action" })
    )
  end,
})

-- Show line diagnostics
-- NOTE: diagnostics are not exclusive to lsp servers so these can be global keybindings
-- https://lsp-zero.netlify.app/docs/guide/migrate-from-v1-branch.html#configure-diagnostics
vim.keymap.set("n", "<Leader>le", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Show line diagnostics" })

-- TODO: vimdoc_ls (https://github.com/neovim/nvim-lspconfig/pull/4347)
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
  "somesass_ls",
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
    -- Tab: snippet forward → NES jump/apply → fallback (copilot accept)
    -- Note: In normal mode, use <Leader>ay for NES (Tab is for buffer navigation)
    ["<Tab>"] = {
      "snippet_forward",
      function()
        return require("sidekick").nes_jump_or_apply()
      end,
      "fallback",
    },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = false, -- Manual trigger
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
      ["<CR>"] = { "accept", "fallback" },
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
    scss = prettier_formatters,
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
end, { desc = "Format buffer" })

-- [[ Fuzzy finder ]]

-- Find/Files group
vim.keymap.set("n", "<Leader><Leader>", function()
  Snacks.picker.files()
end, { desc = "Find files" })
vim.keymap.set("n", "<Leader>fg", function()
  Snacks.picker.grep()
end, { desc = "Live grep" })
vim.keymap.set("n", "<Leader>fc", function()
  Snacks.picker.grep_word()
end, { desc = "Grep word under cursor" })

-- LSP group
vim.keymap.set("n", "<Leader>ld", function()
  Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<Leader>lgd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "Go to definitions" })
vim.keymap.set("n", "<Leader>lgi", function()
  Snacks.picker.lsp_implementations()
end, { desc = "Go to implementations" })
vim.keymap.set("n", "<Leader>lgo", function()
  Snacks.picker.lsp_type_definitions()
end, { desc = "Go to type definitions" })
vim.keymap.set("n", "<Leader>lgr", function()
  Snacks.picker.lsp_references()
end, { desc = "Go to references" })

-- Buffer group
vim.keymap.set("n", "<Leader>bb", function()
  Snacks.picker.buffers()
end, { desc = "List buffers" })

-- Search group
vim.keymap.set("n", "<Leader>sc", function()
  Snacks.picker.command_history()
end, { desc = "Command history" })
vim.keymap.set("n", "<Leader>sh", function()
  Snacks.picker.search_history()
end, { desc = "Search history" })
vim.keymap.set("n", "<Leader>st", function()
  Snacks.picker.help()
end, { desc = "Help tags" })

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
require("tinted-nvim").setup({
  -- Compile schemes for faster startup
  compile = true,

  -- Use tinty's selector to automatically load themes
  selector = {
    enabled = true,
    mode = "file",
    -- Tinty writes current scheme name here
    path = "~/.local/share/tinted-theming/tinty/current_scheme",
    -- Auto-reload when tinty changes theme
    watch = true,
  },

  -- Plugin integrations
  highlights = {
    integrations = {
      notify = true,
      blink = true,
      lualine = true,
    },
  },
})

require("zen-mode").setup()

-- Indent guides
require("ibl").setup()

-- [[ Statusline ]]

-- Lualine configuration
require("lualine").setup({
  options = {
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

-- [[ Harpoon ]]

local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<Leader>ha", function()
  harpoon:list():add()
end, { desc = "Add to harpoon" })
vim.keymap.set("n", "<Leader>hh", function()
  Snacks.picker.pick("harpoon")
end, { desc = "Harpoon picker" })

vim.keymap.set("n", "<Leader>hp", function()
  harpoon:list():prev()
end, { desc = "Harpoon prev" })
vim.keymap.set("n", "<Leader>hn", function()
  harpoon:list():next()
end, { desc = "Harpoon next" })

-- [[ Buffers ]]

-- bufferline.nvim requires termguicolors and colorscheme to be set
local bufferline = require("bufferline")
bufferline.setup({
  options = {
    move_wraps_at_ends = true,
    offsets = {
      {
        filetype = "snacks_layout_box",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
  },
})

-- Next or previous buffer in the buffer list.
-- BufferLineCycleNext and BufferLineCyclePrev commands will traverse the bufferline bufferlist in order
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- Move buffer left or right in bufferline
vim.keymap.set(
  "n",
  "<Leader>bp",
  ":BufferLineMovePrev<CR>",
  { noremap = true, silent = true, desc = "Move buffer left" }
)
vim.keymap.set(
  "n",
  "<Leader>bn",
  ":BufferLineMoveNext<CR>",
  { noremap = true, silent = true, desc = "Move buffer right" }
)

-- Delete buffer without losing the split window
-- Using Snacks.bufdelete for intelligent buffer deletion with safety prompts
-- Preserves window layout and prompts to save if buffer has unsaved changes
vim.keymap.set("n", "<Leader>bd", function()
  require("snacks").bufdelete()
end, { noremap = true, silent = true, desc = "Delete buffer" })

-- Force delete buffer without prompts (discard unsaved changes)
vim.keymap.set("n", "<Leader>bD", function()
  require("snacks").bufdelete({ force = true })
end, { noremap = true, silent = true, desc = "Force delete buffer" })

-- Delete all buffers except current
vim.keymap.set("n", "<Leader>bo", function()
  require("snacks").bufdelete.other()
end, { noremap = true, silent = true, desc = "Delete other buffers" })

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

-- [[ Explorer ]]

vim.keymap.set("n", "<Leader>tt", function()
  Snacks.explorer()
end, { desc = "Toggle explorer" })
vim.keymap.set("n", "<Leader>tr", function()
  Snacks.explorer({ reveal = true })
end, { desc = "Reveal in explorer" })

require("yazi").setup({
  open_for_directories = false,
  floating_window_scaling_factor = 0.9,
  yazi_floating_window_border = "rounded",
})

vim.keymap.set("n", "<Leader>tf", "<cmd>Yazi<CR>", { desc = "Open yazi" })

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

require("render-markdown").setup({
  enabled = false,
})

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

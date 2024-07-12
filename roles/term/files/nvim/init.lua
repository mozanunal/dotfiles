-- variables
local SET_ICONS = true
local SET_CTERM = false

local cattpuccin_machiatto = {
  base00 = "#24273a",
  base01 = "#1e2030",
  base02 = "#363a4f",
  base03 = "#494d64",
  base04 = "#5b6078",
  base05 = "#cad3f5",
  base06 = "#f4dbd6",
  base07 = "#b7bdf8",
  base08 = "#ed8796",
  base09 = "#f5a97f",
  base0A = "#eed49f",
  base0B = "#a6da95",
  base0C = "#8bd5ca",
  base0D = "#8aadf4",
  base0E = "#c6a0f6",
  base0F = "#f0c6c6",
}

local cattpuccin_latte = {
  base00 = "#eff1f5",
  base01 = "#e6e9ef",
  base02 = "#ccd0da",
  base03 = "#bcc0cc",
  base04 = "#acb0be",
  base05 = "#4c4f69",
  base06 = "#dc8a78",
  base07 = "#7287fd",
  base08 = "#d20f39",
  base09 = "#fe640b",
  base0A = "#df8e1d",
  base0B = "#40a02b",
  base0C = "#179299",
  base0D = "#1e66f5",
  base0E = "#8839ef",
  base0F = "#dd7878",
}

vim.g.mapleader = " "
vim.g.maplocalleader = " "
local kmap = vim.keymap.set

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "echasnovski/mini.nvim" },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim",          config = true },
      { "williamboman/mason-lspconfig.nvim" },
      { "folke/neodev.nvim" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  { "GCBallesteros/jupytext.nvim", config = true, },
  { 'Vigemus/iron.nvim' },
  "jamessan/vim-gnupg",
  "SWiegandt/python-utils.nvim",
})

LuaSnip = require("luasnip")

-- Plugin Configs
require("mini.basics").setup({
  options = {
    extra_ui = true,
    win_borders = "single",
  },
  mappings = {
    windows = true,
  },
})

require("mini.files").setup()
require("neodev").setup()
require("mini.ai").setup()
if SET_ICONS then
  require("mini.icons").setup()
end
require("mini.bracketed").setup()
require("mini.completion").setup()
require("mini.comment").setup()
require("mini.cursorword").setup()
require("mini.diff").setup(
  {
    view = {
      style = 'sign',
      signs = { add = '+', change = '~', delete = '-' },

    }
  }
)
require("mini.indentscope").setup()
require("mini.misc").setup()
require("mini.move").setup()
require("mini.notify").setup()
require("mini.operators").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.statusline").setup({use_icons=SET_ICONS})
require("mini.surround").setup()
require("mini.tabline").setup({use_icons=SET_ICONS})
require("mini.trailspace").setup()
require("mini.extra").setup()
require("mini.fuzzy").setup()
require("mini.jump2d").setup({
  mappings = {
    start_jumping = "S",
  },
})

Dark = function()
  require("mini.base16").setup({
    palette = cattpuccin_machiatto,
    use_cterm = SET_CTERM
  })
end

Light = function()
  require("mini.base16").setup({
    palette = cattpuccin_latte,
    use_cterm = SET_CTERM
  })
end

Dark()

require("mini.jump").setup({
  delay = { highlight = 0, idle_stop = 0 },
})

require("mini.pick").setup({
  mappings = {
    choose_in_vsplit = "<C-CR>",
  },
  options = {
    use_cache = true,
  },
})

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    -- Built-in completion
    { mode = "i", keys = "<C-space>" },

    -- `g` key
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },

    -- Marks
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },

    -- Registers
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },

    -- Window commands
    { mode = "n", keys = "<C-w>" },

    -- `z` key
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
  },

  clues = {
    { mode = "n", keys = "<Leader>f", desc = "Find" },
    { mode = "n", keys = "<Leader>b", desc = "Buffer" },
    { mode = "n", keys = "<Leader>g", desc = "Git" },
    { mode = "n", keys = "<Leader>w", desc = "Workspace" },
    { mode = "n", keys = "<Leader>l", desc = "LSP" },
    { mode = "n", keys = "<Leader>t", desc = "Treesitter" },
    { mode = "n", keys = "<Leader>r", desc = "Repl" },
    { mode = "n", keys = "<Leader>s", desc = "Send to Repl" },
    miniclue.gen_clues.g(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = {
    delay = 50,
  },
})

vim.defer_fn(function()
  require("nvim-treesitter.configs").setup({
    modules = {},
    sync_install = true,
    auto_install = true,
    ignore_install = {},
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      "sql",
      "scala",
      "c",
      "cpp",
      "go",
      "lua",
      "python",
      "rust",
      "tsx",
      "javascript",
      "typescript",
      "vimdoc",
      "vim",
      "bash",
    },

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<M-space>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>ts"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>tS"] = "@parameter.inner",
        },
      },
    },
  })
end, 0)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    kmap("n", keys, func, { buffer = bufnr, desc = desc })
  end
  -- client.server_capabilities.semanticTokensProvider = nil

  nmap("<leader>lr", vim.lsp.buf.rename, "Rename")
  nmap("<leader>la", vim.lsp.buf.code_action, "Code Action")
  nmap("gd", vim.lsp.buf.definition, "Goto Definition")
  nmap("gr", function()
    MiniExtra.pickers.lsp({ scope = "references" })
  end, "Goto References")
  nmap("gI", vim.lsp.buf.implementation, "Goto Implementation")
  nmap("gt", vim.lsp.buf.type_definition, "Goto Type Definition")
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")
  nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
  nmap("<leader>lf", vim.lsp.buf.format, "Format")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List Workspace")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

local servers = {
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  texlab = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
local capabilities = vim.lsp.protocol.make_client_capabilities()
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    })
  end,
})

---- Keymaps
kmap({ "n", "v" }, "n", "nzzzv", { noremap = true })
kmap({ "n", "v" }, "N", "Nzzzv", { noremap = true })
kmap({ "n", "v" }, "<leader>_", ":split<CR>", { noremap = true, silent = true, desc = "Window Split" })
kmap({ "n", "v" }, "<leader>|", ":vsplit<CR>", { noremap = true, silent = true, desc = "Window VSplit" })
kmap({ "n", "v" }, "<leader>q", ":q<CR>", { noremap = true, desc = "Window Quit" })
kmap({ "n", "v" }, "<leader>bd", ":bd<CR>", { noremap = true, desc = "Buffer Delete" })
kmap({ "n", "v" }, "H", ":bp<CR>", { noremap = true, silent = true })
kmap({ "n", "v" }, "L", ":bn<CR>", { noremap = true, silent = true })
kmap("n", "<leader>tt", ":term<CR>", { desc = "Terminal" })
kmap("n", "<leader>t_", ":split | term<CR>", { desc = "Terminal Vsplit" })
kmap("n", "<leader>t|", ":vsplit | term<CR>", { desc = "Terminal Hsplit" })
kmap("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true })
kmap("n", "<leader>gd", MiniDiff.toggle_overlay, { desc = "Git Diff" })
kmap("n", "<leader>fl", MiniExtra.pickers.buf_lines, { noremap = true, silent = true, desc = "Find Lines" })
kmap("n", "<leader>ff", function()
  MiniPick.builtin.files({ tool = "git" })
end, { noremap = true, silent = true, desc = "Find File" })
kmap("n", "<leader><Space>", MiniPick.builtin.files, { noremap = true, silent = true, desc = "Find File" })
kmap("n", "<C-p>", MiniPick.builtin.files, { noremap = true, silent = true, desc = "Find File" })
kmap("n", "<leader>fs", function()
  MiniExtra.pickers.lsp({ scope = "document_symbol" })
end, { noremap = true, silent = true, desc = "Find Symbols" })
kmap("n", "<leader>e", MiniFiles.open, { noremap = true, silent = true, desc = "File Explorer" })
kmap("n", "<leader>fb", MiniPick.builtin.buffers, { noremap = true, silent = true, desc = "Find Buffer" })
kmap("n", "<leader>fg", MiniPick.builtin.grep_live, { noremap = true, silent = true, desc = "Find String" })
kmap("n", "<leader>fo", MiniExtra.pickers.options, { noremap = true, silent = true, desc = "Find Options" })
kmap("n", "<leader>fe", MiniExtra.pickers.explorer, { noremap = true, silent = true, desc = "Find Explorer" })
kmap("n", "<leader>/", MiniPick.builtin.grep_live, { noremap = true, silent = true, desc = "Find String" })
kmap("n", "<leader>fh", MiniPick.builtin.help, { noremap = true, silent = true, desc = "Find Help" })
kmap("n", "<leader>fk", MiniExtra.pickers.keymaps, { noremap = true, silent = true, desc = "Find Keymaps" })
kmap("n", "<leader>`", MiniPick.builtin.resume, { noremap = true, silent = true, desc = "Find Resume" })
kmap("n", "<leader>bd", "<CMD>bd<CR>", { noremap = true, silent = true, desc = "Close Buffer" })
kmap("n", "<leader>gg", "<CMD>terminal lazygit<CR>", { noremap = true, silent = true, desc = "Lazygit" })
kmap("n", "<leader>gp", "<CMD>terminal git pull<CR>", { noremap = true, silent = true, desc = "Git Push" })
kmap("n", "<leader>gP", "<CMD>terminal git push<CR>", { noremap = true, silent = true, desc = "Git Pull" })
kmap("n", "<leader>ga", "<CMD>terminal git add .<CR>", { noremap = true, silent = true, desc = "Git Add All" })
kmap("n", "<leader>gc", '<CMD>terminal git commit -m "Autocommit from nvim"<CR>',
  { noremap = true, silent = true, desc = "Git Autocommit" })
kmap("n", "<leader>fd", MiniExtra.pickers.diagnostic, { desc = "Find Diagnostic" })
kmap("n", "<leader>o", "<CMD>silent !open %<CR>", { noremap = true, silent = true, desc = "Open File" })
kmap("n", "<leader>td", Dark, { noremap = true, silent = true, desc = "Dark Theme" })
kmap("n", "<leader>tl", Light, { noremap = true, silent = true, desc = "Light Theme" })

local iron = require("iron.core")

iron.setup {
  config = {
    scratch_repl = true,
    repl_definition = {
      python = require("iron.fts.python").ipython,
    },
    repl_open_cmd = require('iron.view').split.vertical.botright(0.5),
  },
  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_paragraph = "<S-CR>",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true,
    bg = "#000000"
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
kmap('n', '<space>rs', '<cmd>IronRepl<cr>', { noremap = true, silent = true, desc = "Repl Open" })
kmap('n', '<space>rr', '<cmd>IronRestart<cr>', { noremap = true, silent = true, desc = "Repl Restart" })
kmap('n', '<space>rf', '<cmd>IronFocus<cr>', { noremap = true, silent = true, desc = "Repl Focus" })
kmap('n', '<space>rh', '<cmd>IronHide<cr>', { noremap = true, silent = true, desc = "Repl Hide" })

-- customized key mappings
K = {
  ["cr"] = vim.api.nvim_replace_termcodes("<CR>", true, true, true),
  ["ctrl-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
  ["ctrl-n"] = vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
  ["ctrl-p"] = vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
  ["ctrl-h"] = vim.api.nvim_replace_termcodes("<C-h>", true, true, true),
  ["ctrl-l"] = vim.api.nvim_replace_termcodes("<C-l>", true, true, true),
  ["tab"] = vim.api.nvim_replace_termcodes("<Tab>", true, true, true),
  ["s-tab"] = vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true),
}

F_tab_i = function()
  if vim.fn.pumvisible() ~= 0 then
    return K["ctrl-n"]
  else
    return K["tab"]
  end
end

F_stab_i = function()
  if vim.fn.pumvisible() ~= 0 then
    return K["ctrl-h"]
  else
    return K["s-tab"]
  end
end

F_cr_i = function()
  if vim.fn.pumvisible() ~= 0 then
    local item_selected = vim.fn.complete_info()["selected"] ~= -1
    return item_selected and K["ctrl-y"] or K["ctrl-y_cr"]
  else
    return MiniPairs.cr()
  end
end

Luasnip_go_right = function()
  if LuaSnip.expand_or_jumpable() then
    LuaSnip.expand_or_jump()
  end
end

Luasnip_go_left = function()
  if LuaSnip.jumpable() then
    LuaSnip.jump(-1)
  end
end

kmap("i", "<CR>", F_cr_i, { expr = true })
kmap("i", "<Tab>", F_tab_i, { noremap = true, expr = true })
kmap("i", "<S-Tab>", F_stab_i, { noremap = true, expr = true })
kmap("i", "<C-l>", [[<CMD>lua Luasnip_go_right()<CR>]], {})
kmap("s", "<C-l>", [[<CMD>lua Luasnip_go_right()<CR>]], {})
kmap("i", "<C-h>", [[<CMD>lua Luasnip_go_left()<CR>]], {})
kmap("s", "<C-h>", [[<CMD>lua Luasnip_go_left()<CR>]], {})

-- autocommands
vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.cmd("bdelete")
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.py" },
  callback = function()
    vim.api.nvim_buf_create_user_command(0, "OpenDataset", function()
      require("python-utils.python").get_class_module(function(symbol_path)
        local _, _, module, class = string.find(symbol_path, "(.*)%.(%w+)$")

        vim.cmd(string.format("silent !python -c 'from %s import %s; print(%s().target().path)' | xargs open", module,
          class, class))

        if vim.v.shell_error ~= 0 then
          vim.notify("Couldn't find dataset directory for " .. class, "ERROR")
        end
      end)
    end, {})
  end,
})

-- options
if SET_CTERM then
  vim.o.termguicolors = false
  vim.o.winblend = 0
else
  vim.o.termguicolors = true
end
vim.o.clipboard = "unnamedplus"
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.formatoptions = "tcqj" -- j1croql or tcqj
vim.o.laststatus = 3
vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'None' })

-- vim: ts=2 sts=2 sw=2 et

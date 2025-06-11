-- variables
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
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "EdenEast/nightfox.nvim" },
  { "echasnovski/mini.nvim" },
  { "neovim/nvim-lspconfig" },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
  { "jamessan/vim-gnupg" },
  { "SWiegandt/python-utils.nvim" },
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
      keymap = { preset = "enter" },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      cmdline = { enabled = false },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { "folke/snacks.nvim" },
  { "mozanunal/sllm.nvim" },
})

require("sllm").setup()
-- Plugin Configs
require("mini.ai").setup()
require("mini.bracketed").setup()
require("mini.comment").setup()
-- require("mini.completion").setup()
require("mini.cursorword").setup()
require("mini.extra").setup()
require("mini.fuzzy").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.indentscope").setup()
require("mini.misc").setup()
require("mini.move").setup()
require("mini.notify").setup()
require("mini.operators").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()
require("mini.visits").setup()

require("mini.basics").setup({
  options = {
    extra_ui = true,
    win_borders = "single",
  },
  mappings = {
    windows = true,
  },
})

require("mini.sessions").setup({ autoread = true, autowrite = true })

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

require("mini.files").setup({
  windows = {
    max_number = 10,
    preview = false,
    width_focus = 50,
    width_nofocus = 20,
    width_preview = 20,
  },
})

require("mini.diff").setup({
  view = {
    style = "sign",
    signs = {
      add = "▎",
      change = "▎",
      delete = "",
    },
  },
})

require("mini.jump2d").setup({
  mappings = {
    start_jumping = "S",
  },
})

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

local miniclue = require("mini.clue")
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

local file_picker = function()
  MiniPick.builtin.cli({ command = { "rg", "--files", "--hidden", "--glob=!.git/" } })
end

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
  })
end, 0)

---- Keymaps
local lmap = function(keys, func, desc)
  if desc then
    desc = "lsp: " .. desc
  end
  kmap("n", keys, func, { buffer = bufnr, desc = desc })
end
lmap("<leader>lr", vim.lsp.buf.rename, "Rename")
lmap("<leader>la", vim.lsp.buf.code_action, "Code Action")
lmap("gd", vim.lsp.buf.definition, "Goto Definition")
lmap("gr", function()
  MiniExtra.pickers.lsp({ scope = "references" })
end, "Goto References")
lmap("gI", vim.lsp.buf.implementation, "Goto Implementation")
lmap("gt", vim.lsp.buf.type_definition, "Goto Type Definition")
lmap("K", vim.lsp.buf.hover, "Hover Documentation")
lmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")
lmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
lmap("<leader>lf", vim.lsp.buf.format, "Format")
lmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace")
lmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace")
lmap("<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, "List Workspace")

kmap({ "n", "v" }, "n", "nzzzv", { noremap = true })
kmap({ "n", "v" }, "N", "Nzzzv", { noremap = true })
kmap({ "n", "v" }, "<leader>_", ":split<CR>", { noremap = true, silent = true, desc = "Window Split" })
kmap({ "n", "v" }, "<leader>|", ":vsplit<CR>", { noremap = true, silent = true, desc = "Window VSplit" })
kmap({ "n", "v" }, "<leader>q", ":q<CR>", { noremap = true, desc = "Window Quit" })
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
kmap("n", "<leader><Space>", file_picker, { noremap = true, silent = true, desc = "Find File" })
kmap("n", "<C-p>", file_picker, { noremap = true, silent = true, desc = "Find File" })
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
kmap("n", "<leader>fd", MiniExtra.pickers.diagnostic, { desc = "Find Diagnostic" })
kmap("n", "<leader>o", "<CMD>silent !open %<CR>", { noremap = true, silent = true, desc = "Open File" })

-- options
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.formatoptions = "tqj" -- j1croql or tcqj
vim.o.laststatus = 3
vim.o.exrc = true
vim.o.swapfile = false
vim.o.winborder = "single"

vim.diagnostic.config({
  virtual_text = false, -- completely off (will use virtual_lines instead)
  virtual_lines = { -- new handler
    only_current_line = true, -- show virtual lines only under cursor
  },
  severity_sort = true, -- most severe first
  signs = true,
  underline = true,
  update_in_insert = false,
})
vim.lsp.enable({ "lua_ls", "gopls", "pyright", "ruff", "rust_analyzer" })

vim.cmd.colorscheme("catppuccin-macchiato")
MiniMisc.setup_termbg_sync()
MiniMisc.setup_restore_cursor()
MiniMisc.setup_auto_root()

-- autocmds
-- Open a terminal automatically only on `nvim` or `nvim .`
local term_on_start = vim.api.nvim_create_augroup("OpenTerminalOnStart", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = term_on_start,
  callback = function()
    local argc = vim.fn.argc() -- number of file args
    if argc == 0 or (argc == 1 and vim.fn.argv(0) == ".") then
      vim.cmd("terminal")
      vim.cmd("setlocal nonumber norelativenumber")
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et

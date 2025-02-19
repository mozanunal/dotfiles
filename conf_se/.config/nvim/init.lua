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
  { "GCBallesteros/jupytext.nvim", config = true },
  { "jamessan/vim-gnupg" },
  { "SWiegandt/python-utils.nvim" },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },
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
      cmdline = { enabled = false, },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
})

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
require("mini.sessions").setup()
require("mini.splitjoin").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()
require("mini.visits").setup()
require("neodev").setup()

require("mini.basics").setup({
  options = {
    extra_ui = true,
    win_borders = "single",
  },
  mappings = {
    windows = true,
  },
})

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

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local lsp_map = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    kmap("n", keys, func, { buffer = bufnr, desc = desc })
  end
  require("blink.cmp").get_lsp_capabilities(client.server_capabilities)
  lsp_map("<leader>lr", vim.lsp.buf.rename, "Rename")
  lsp_map("<leader>la", vim.lsp.buf.code_action, "Code Action")
  lsp_map("gd", vim.lsp.buf.definition, "Goto Definition")
  lsp_map("gr", function()
    MiniExtra.pickers.lsp({ scope = "references" })
  end, "Goto References")
  lsp_map("gI", vim.lsp.buf.implementation, "Goto Implementation")
  lsp_map("gt", vim.lsp.buf.type_definition, "Goto Type Definition")
  lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
  lsp_map("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")
  lsp_map("gD", vim.lsp.buf.declaration, "Goto Declaration")
  lsp_map("<leader>lf", vim.lsp.buf.format, "Format")
  lsp_map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace")
  lsp_map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace")
  lsp_map("<leader>wl", function()
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
kmap("n", "<leader>gp", "<CMD>terminal git pull<CR>", { noremap = true, silent = true, desc = "Git Push" })
kmap("n", "<leader>gP", "<CMD>terminal git push<CR>", { noremap = true, silent = true, desc = "Git Pull" })
kmap("n", "<leader>ga", "<CMD>terminal git add .<CR>", { noremap = true, silent = true, desc = "Git Add All" })
kmap(
  "n",
  "<leader>gc",
  '<CMD>terminal git commit -m "Autocommit from nvim"<CR>',
  { noremap = true, silent = true, desc = "Git Autocommit" }
)
kmap("n", "<leader>fd", MiniExtra.pickers.diagnostic, { desc = "Find Diagnostic" })
kmap("n", "<leader>o", "<CMD>silent !open %<CR>", { noremap = true, silent = true, desc = "Open File" })
kmap("n", "<leader>td", function()
  vim.o.background = "dark"
end, { noremap = true, silent = true, desc = "Dark Theme" })
kmap("n", "<leader>tl", function()
  vim.o.background = "light"
end, { noremap = true, silent = true, desc = "Light Theme" })

-- options
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.formatoptions = "tcqj" -- j1croql or tcqj
vim.o.laststatus = 3
vim.o.exrc = true

local parse_b16 = function(str_in)
  local colors = {}
  for line in str_in:gmatch("[^\r\n]+") do
    local key, value = line:match('(%w+):%s+"(.-)"')
    if key and value then
      colors[key] = "#" .. value
    end
  end
  return colors
end

Set_b16_colors = function(str_in)
  require("mini.base16").setup({ palette = parse_b16(str_in) })
  vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None" })
end
vim.cmd([[colorscheme b16_catppuccin_macchiato]])
MiniMisc.setup_termbg_sync()
MiniMisc.setup_restore_cursor()
MiniMisc.setup_auto_root()
-- vim: ts=2 sts=2 sw=2 et

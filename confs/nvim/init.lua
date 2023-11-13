-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local kmap = vim.keymap.set

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  { 'echasnovski/mini.nvim' },
  { "catppuccin/nvim",         name = "catppuccin", priority = 1000 },
  { 'tpope/vim-sleuth' },
  { 'lewis6991/gitsigns.nvim', opts = {} },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',          config = true },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim',                opts = {} },
      { 'folke/neodev.nvim' },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },
}

---- Plugins Configs
require('mini.completion').setup({
  window = {
    info = { height = 25, width = 80, border = 'none' },
    signature = { height = 25, width = 80, border = 'none' },
  },
})
require('mini.basics').setup({
  options = {
    extra_ui = true,
    win_borders = 'double',
  },
  mappings = {
    windows = true,
  }
})

require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.comment').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.bracketed').setup()
require('mini.indentscope').setup()
require('mini.cursorword').setup()
require('mini.splitjoin').setup()
require('mini.move').setup()
local mini_files = require('mini.files')
mini_files.setup()

require('mini.fuzzy').setup()
local mini_pick = require('mini.pick')
mini_pick.setup({
  mappings = {
    choose_in_vsplit = '<C-CR>',
  },
  options = {
    use_cache = true
  },
})

local mini_extra = require('mini.extra')
mini_extra.setup()

require('mini.clue').setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    -- Built-in completion
    { mode = 'i', keys = '<C-space>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    { mode = 'n', keys = '<Leader>f', desc = 'Find' },
    { mode = 'n', keys = '<Leader>b', desc = 'Buffer' },
    { mode = 'n', keys = '<Leader>g', desc = 'Git' },
    { mode = 'n', keys = '<Leader>w', desc = 'Workspace' },
    { mode = 'n', keys = '<Leader>l', desc = 'LSP' },
    function() MiniClue.gen_clues.g() end,
    function() MiniClue.gen_clues.builtin_completion() end,
    function() MiniClue.gen_clues.marks() end,
    function() MiniClue.gen_clues.registers() end,
    function() MiniClue.gen_clues.windows() end,
    function() MiniClue.gen_clues.z() end,
  },
  window = {
    delay = 50
  }
})


-- [[ Configure Treesitter ]]
require('nvim-treesitter.configs').setup({
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua',
    'python', 'sql', 'scala',
    'html', 'css', 'markdown',
    'rust', 'tsx', 'typescript',
    'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  indent = { enable = true, disable = { 'python' } },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
})

require('neodev').setup()

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    kmap('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
  nmap('<leader>la', vim.lsp.buf.code_action, 'Code Action')
  nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
  nmap('gr', function() mini_extra.pickers.lsp({ scope = "references" }) end, 'Goto References')
  nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
  nmap('gt', vim.lsp.buf.type_definition, 'Goto Type Definition')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  nmap('<leader>lf', vim.lsp.buf.format, 'Format')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List Workspace')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  gopls = {},
  pyright = {},
  marksman = {},
  rust_analyzer = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

---- Options
vim.cmd.colorscheme "catppuccin-macchiato"
vim.o.swapfile = false          -- remove swapfile
vim.o.hlsearch = false          -- Set highlight on search
vim.wo.number = true            -- Make line numbers default
vim.wo.relativenumber = true    --
vim.o.mouse = 'a'               -- Enable mouse mode
vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.o.breakindent = true        -- Enable break indent
vim.o.undofile = true           -- Save undo history
vim.o.ignorecase = true         -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true          --
vim.wo.signcolumn = 'yes'       -- Keep signcolumn on by default
-- vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.o.termguicolors = true      -- NOTE: You should makebsure your terminal supports this
vim.o.autoindent = true         -- Auto-indent new lines
vim.o.expandtab = true          -- Use spaces instead of tabs
vim.o.shiftwidth = 4            -- Number of auto-indent spaces
vim.o.smartindent = true        -- Enable smart-indent
vim.o.smarttab = true           -- Enable smart-tabs
vim.o.softtabstop = 4           -- Number of spaces per Tab

---- Keymaps
-- keymap('t', '<Esc>', '<C-\\><C-n>')
kmap({ 'n', 'v' }, 'n', 'nzzzv', { noremap = true })
kmap({ 'n', 'v' }, 'N', 'Nzzzv', { noremap = true })
kmap({ 'n', 'v' }, '}', '}zz', { noremap = true })
kmap({ 'n', 'v' }, '{', '{zz', { noremap = true })
kmap({ 'n', 'v' }, '<leader>_', ':split<CR>', { noremap = true, desc = 'Window Split' })
kmap({ 'n', 'v' }, '<leader>|', ':vsplit<CR>', { noremap = true, desc = 'Window VSplit' })
kmap({ 'n', 'v' }, '<leader>q', ':q<CR>', { noremap = true, desc = 'Window Quit' })
kmap({ 'n', 'v' }, 'H', ':bp<CR>', { noremap = true })
kmap({ 'n', 'v' }, 'L', ':bn<CR>', { noremap = true })
kmap('n', '<leader>t', ":terminal<CR>i", { desc = 'Terminal' })
kmap('n', '<leader>gd', ":Gitsigns diffthis<CR>", { desc = 'Git Diff' })
kmap("n", "<leader>fl", mini_extra.pickers.buf_lines, { noremap = true, silent = true, desc = 'Find Lines' })
kmap("n", "<leader>ff", mini_pick.builtin.files, { noremap = true, silent = true, desc = 'Find File' })
kmap("n", "<leader><Space>", mini_pick.builtin.files, { noremap = true, silent = true, desc = 'Find File' })
kmap("n", "<leader>fs", function() mini_extra.pickers.lsp({ scope = 'document_symbol' }) end,
  { noremap = true, silent = true, desc = 'Find Symbols' })
kmap("n", "<leader>e", mini_files.open, { noremap = true, silent = true, desc = 'File Explorer' })
kmap("n", "<leader>fb", mini_pick.builtin.buffers, { noremap = true, silent = true, desc = 'Find Buffer' })
kmap("n", "<leader>fg", mini_pick.builtin.grep_live, { noremap = true, silent = true, desc = 'Find String' })
kmap("n", "<leader>/", mini_pick.builtin.grep_live, { noremap = true, silent = true, desc = 'Find String' })
kmap("n", "<leader>fh", mini_pick.builtin.help, { noremap = true, silent = true, desc = 'Find Help' })
kmap("n", "<leader>fk", mini_extra.pickers.keymaps, { noremap = true, silent = true, desc = 'Find Keymaps' })
kmap("n", "<leader>`", mini_pick.builtin.resume, { noremap = true, silent = true, desc = 'Find Resume' })
kmap("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true, silent = true, desc = 'Close Buffer' })
kmap("n", "<leader>gg", "<cmd>terminal lazygit<cr>", { noremap = true, silent = true, desc = 'Lazygit' })
kmap("n", "<leader>gp", "<cmd>terminal git pull<cr>", { noremap = true, silent = true, desc = 'Git Push' })
kmap("n", "<leader>gP", "<cmd>terminal git push<cr>", { noremap = true, silent = true, desc = 'Git Pull' })
kmap("n", "<leader>ga", "<cmd>terminal git add .<cr>", { noremap = true, silent = true, desc = 'Git Add All' })
kmap("n", "<leader>gc", '<cmd>terminal git commit -m "Autocommit from MVIM"<cr>',
  { noremap = true, silent = true, desc = 'Git Autocommit' })
kmap('n', '<leader>fd', mini_extra.pickers.diagnostic, { desc = "Find Diagnostic" })

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.cmd("bdelete")
  end
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

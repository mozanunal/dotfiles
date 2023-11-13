-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local keymap = vim.keymap.set

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
local USE_ICONS = true

-- mini
require('mini.completion').setup()
require('mini.basics').setup({
  options = {
    extra_ui = true,
    win_borders = 'double',
  },
  mappings = {
    windows = true,
  }
})

require('mini.statusline').setup {
  use_icons = USE_ICONS
}

require('mini.tabline').setup {
  show_icons = USE_ICONS
}

require('mini.comment').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.bracketed').setup()
require('mini.indentscope').setup()
require('mini.cursorword').setup()
require('mini.splitjoin').setup()
require('mini.move').setup()
require('mini.files').setup()

require('mini.fuzzy').setup()
require('mini.pick').setup({
  mappings = {
    choose_in_vsplit = '<C-CR>',
  },
  options = {
    use_cache = true
  },
  -- window = {
  --   config = win_config,
  -- }
})
local pickcmd = require('mini.pick').builtin.cli
require('mini.extra').setup()

-- local animate = require('mini.animate')
-- animate.setup {
--   scroll = {
--     -- Disable Scroll Animations, as the can interfer with mouse Scrolling
--     enable = false,
--   },
--   cursor = {
--     timing = animate.gen_timing.cubic({ duration = 50, unit = 'total' })
--   },
-- }

require('mini.base16').setup({
  palette = {
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
})

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
    { mode = 'n', keys = '<Leader>s', desc = 'Switch' },
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

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    keymap('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
  nmap('<leader>la', vim.lsp.buf.code_action, 'Code Action')

  nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspace List Folders')

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
require('neodev').setup()

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
vim.o.swapfile = false                 -- remove swapfile
vim.o.hlsearch = false                 -- Set highlight on search
vim.wo.number = true                   -- Make line numbers default
vim.wo.relativenumber = true           --
vim.o.mouse = 'a'                      -- Enable mouse mode
vim.o.clipboard = 'unnamedplus'        -- Sync clipboard between OS and Neovim.
vim.o.breakindent = true               -- Enable break indent
vim.o.undofile = true                  -- Save undo history
vim.o.ignorecase = true                -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true                 --
vim.wo.signcolumn = 'yes'              -- Keep signcolumn on by default
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.o.termguicolors = true             -- NOTE: You should makebsure your terminal supports this
vim.o.autoindent = true                -- Auto-indent new lines
vim.o.expandtab = true                 -- Use spaces instead of tabs
vim.o.shiftwidth = 4                   -- Number of auto-indent spaces
vim.o.smartindent = true               -- Enable smart-indent
vim.o.smarttab = true                  -- Enable smart-tabs
vim.o.softtabstop = 4                  -- Number of spaces per Tab

---- Keymaps
keymap('t', '<Esc>', '<C-\\><C-n>')
keymap({ 'n', 'v' }, 'n', 'nzzzv', { noremap = true })
keymap({ 'n', 'v' }, 'N', 'Nzzzv', { noremap = true })
keymap({ 'n', 'v' }, '}', '}zz', { noremap = true })
keymap({ 'n', 'v' }, '{', '{zz', { noremap = true })
keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
keymap('n', ']b', ":bn<CR>", { desc = '[B]uffer [N]ext' })
keymap('n', '[b', ":bp<CR>", { desc = '[B]uffer [P]rev' })
keymap('n', '<leader>t', ":terminal<CR>i", { desc = '[T]erminal' })
keymap('n', '<leader>gg', ":Git<CR>", { desc = '[G]it' })
keymap('n', '<leader>gd', ":Gitsigns diffthis<CR>", { desc = '[G]it [D]iff' })
keymap('n', '<leader>gp', ":Git push<CR>", { desc = '[G]it [P]ush' })
keymap('n', '<leader>e', ":Neotree focus toggle<CR>", { desc = 'Open [E]xplorer' })
keymap("n", "<leader>ff", "<cmd>lua MiniPick.builtin.files()<cr>", { noremap = true, silent = true, desc = 'Find File' })
keymap("n", "<leader><space>", "<cmd>lua MiniPick.builtin.files()<cr>",
  { noremap = true, silent = true, desc = 'Find File' })
keymap("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { noremap = true, silent = true, desc = 'File Explorer' })
keymap("n", "<leader>fb", "<cmd>lua MiniPick.builtin.buffers()<cr>",
  { noremap = true, silent = true, desc = 'Find Buffer' })
keymap("n", "<leader>fg", "<cmd>lua MiniPick.builtin.grep_live()<cr>",
  { noremap = true, silent = true, desc = 'Find String' })
keymap("n", "<leader>fh", "<cmd>lua MiniPick.builtin.help()<cr>", { noremap = true, silent = true, desc = 'Find Help' })
keymap("n", "<leader>ss", "<cmd>lua MiniSessions.select()<cr>",
  { noremap = true, silent = true, desc = 'Switch Session' })
keymap("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true, silent = true, desc = 'Close Buffer' })
keymap("n", "<leader>gg", "<cmd>terminal lazygit<cr>", { noremap = true, silent = true, desc = 'Lazygit' })
keymap("n", "<leader>gp", "<cmd>terminal git pull<cr>", { noremap = true, silent = true, desc = 'Git Push' })
keymap("n", "<leader>gP", "<cmd>terminal git push<cr>", { noremap = true, silent = true, desc = 'Git Pull' })
keymap("n", "<leader>ga", "<cmd>terminal git add .<cr>", { noremap = true, silent = true, desc = 'Git Add All' })
keymap("n", "<leader>gc", '<cmd>terminal git commit -m "Autocommit from MVIM"<cr>',
  { noremap = true, silent = true, desc = 'Git Autocommit' })

-- Telescope
-- local tb = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>?', tb.oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', tb.buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', tb.current_buffer_fuzzy_find, { desc = 'Search current buffer' })
-- vim.keymap.set('n', '<leader>gf', tb.git_files, { desc = 'Search [G]it [F]iles' })
-- vim.keymap.set('n', '<leader>sf', tb.find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', tb.help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', tb.grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', tb.live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>\'', tb.resume, { desc = '[S]earch [R]resume' })

-- Diagnostic Keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- vim.keymap.set('n', '<leader>sd', tb.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.cmd("bdelete")
  end
})


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
  { 'echasnovski/mini.nvim',   version = false },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-sleuth' },
  { 'folke/which-key.nvim',    opts = {} },
  { 'lewis6991/gitsigns.nvim', },
  { "catppuccin/nvim",         name = "catppuccin" },
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
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' },
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  },
}

---- Plugins Configs
local USE_ICONS = true

-- mini
require('mini.basics').setup {
  mappings = { windows = true }
}
require('mini.statusline').setup {
  use_icons = USE_ICONS
}
require('mini.tabline').setup {
  show_icons = USE_ICONS
}
require('mini.jump').setup()
require('mini.comment').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.bracketed').setup()
require('mini.indentscope').setup()
require('mini.cursorword').setup()
require('mini.splitjoin').setup()
require('mini.move').setup()

require('neo-tree').setup {
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    filtered_items = {
      visible = true, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = true,
    }
  },
  window = {
    position = "left",
    width = 30,
    mappings = {
      ["<space>"] = "none",
    },
  },
}

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- [[ Configure Treesitter ]]
require('nvim-treesitter.configs').setup {
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
}

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {
  require("luasnip.loaders.from_vscode").lazy_load()
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

---- Options
vim.cmd.colorscheme 'catppuccin-macchiato' --
vim.o.swapfile = false                     -- remove swapfile
vim.o.hlsearch = false                     -- Set highlight on search
vim.wo.number = true                       -- Make line numbers default
vim.wo.relativenumber = true               --
vim.o.mouse = 'a'                          -- Enable mouse mode
vim.o.clipboard = 'unnamedplus'            -- Sync clipboard between OS and Neovim.
vim.o.breakindent = true                   -- Enable break indent
vim.o.undofile = true                      -- Save undo history
vim.o.ignorecase = true                    -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true                     --
vim.wo.signcolumn = 'yes'                  -- Keep signcolumn on by default
vim.o.updatetime = 200                     -- Decrease update time
vim.o.timeout = true                       --
vim.o.timeoutlen = 200                     --
vim.o.completeopt = 'menuone,noselect'     -- Set completeopt to have a better completion experience
vim.o.termguicolors = true                 -- NOTE: You should makebsure your terminal supports this
vim.o.autoindent = true                    -- Auto-indent new lines
vim.o.expandtab = true                     -- Use spaces instead of tabs
vim.o.shiftwidth = 4                       -- Number of auto-indent spaces
vim.o.smartindent = true                   -- Enable smart-indent
vim.o.smarttab = true                      -- Enable smart-tabs
vim.o.softtabstop = 4                      -- Number of spaces per Tab

---- Keymaps
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set({ 'n', 'v' }, 'n', 'nzzzv', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'N', 'Nzzzv', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '}', '}zz', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '{', '{zz', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<leader>t', ":terminal<CR>i", { desc = '[T]erminal' })
vim.keymap.set('n', '<leader>gg', ":Git<CR>", { desc = '[G]it' })
vim.keymap.set('n', '<leader>gd', ":Gitsigns diffthis<CR>", { desc = '[G]it [D]iff' })
vim.keymap.set('n', '<leader>gp', ":Git push<CR>", { desc = '[G]it [P]ush' })
vim.keymap.set('n', ']b', ":bn<CR>", { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '[b', ":bp<CR>", { desc = '[B]uffer [P]rev' })
vim.keymap.set('n', '<leader>e', ":Neotree focus toggle<CR>", { desc = 'Open [E]xplorer' })

-- Telescope
local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader>?', tb.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', tb.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', tb.current_buffer_fuzzy_find, { desc = 'Search current buffer' })
vim.keymap.set('n', '<leader>gf', tb.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', tb.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', tb.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', tb.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', tb.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>\'', tb.resume, { desc = '[S]earch [R]resume' })

-- Diagnostic Keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set('n', '<leader>sd', tb.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach({})]])
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

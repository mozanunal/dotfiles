-- globals
vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

-- opts
vim.o.autoindent     = true                -- Use auto indent
vim.o.clipboard      = 'unnamedplus'
vim.o.cursorlineopt  = 'screenline,number' -- Show cursor line per screen line
vim.o.expandtab      = true                -- Convert tabs to spaces
vim.o.exrc           = true
vim.o.formatoptions  = 'rqnl1j'    -- Improve comment editing
vim.o.ignorecase     = true        -- Ignore case during search
vim.o.incsearch      = true        -- Show search matches while typing
vim.o.infercase      = true        -- Infer case in built-in completion
vim.o.laststatus     = 3
vim.o.mouse          = 'a'         -- Enable mouse
vim.o.mousescroll    = 'ver:1,hor:1' -- Customize mouse scroll
vim.o.shiftwidth     = 2           -- Use this number of spaces for indentation
vim.o.shiftwidth     = 2
vim.o.smartcase      = true        -- Respect case if search pattern has upper case
vim.o.smartindent    = true        -- Make indenting smart
vim.o.smoothscroll   = true
vim.o.spelloptions   = 'camel'     -- Treat camelCase word parts as separate words
vim.o.swapfile       = false
vim.o.switchbuf      = 'usetab'    -- Use already opened buffers when switching
vim.o.tabstop        = 2           -- Show tab as this number of spaces
vim.o.termguicolors  = true
vim.o.undofile       = true   -- Enable persistent undo
vim.o.virtualedit    = 'block' -- Allow going past end of line in blockwise mode
vim.o.winborder      = 'rounded'


vim.diagnostic.config({
  -- virtual_text = { current_line = true, virt_text_pos = 'right_align' },
  virtual_text = false,
  virtual_lines = { current_line = true },
  underline = true,
  signs = {
    priority = 20,
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.INFO] = '•',
      [vim.diagnostic.severity.HINT] = '»',
    },
  },
  severity_sort = { reverse = false },
})

vim.lsp.enable({
  'terraformls',
  'lua_ls',
  'gopls',
  'pyright',
  'ruff',
  'rust_analyzer',
  'html',
  -- 'denols',
  'zk',
  'metals',
  'tailwindcss',
  'ts_ls'
})

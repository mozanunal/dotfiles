-- [[ Setting options ]]
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

-- globals
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd.colorscheme('catppuccin')

-- opts
vim.o.termguicolors = true
vim.o.clipboard = 'unnamedplus'
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.formatoptions = 'j1croql'
vim.o.laststatus = 3
vim.o.exrc = true
vim.o.swapfile = false
vim.o.winborder = 'rounded'
vim.o.smoothscroll = true
vim.o.mousescroll = 'ver:1,hor:1'

MiniMisc.setup_termbg_sync()
MiniMisc.setup_restore_cursor()
MiniMisc.setup_auto_root()

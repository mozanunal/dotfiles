local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local win_config = function()
    height = math.floor(0.618 * vim.o.lines)
    width = math.floor(0.618 * vim.o.columns)
    return {
        anchor = 'NW', height = height, width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
        border = 'none',
    }
end

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

vim.g.mapleader = " "
vim.opt.listchars = { extends='.',precedes='|',nbsp='_', tab='└─┘' }
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.clipboard = "unnamed,unnamedplus"

keymap("n", "<leader>ff", "<cmd>lua MiniPick.builtin.files()<cr>", { noremap = true, silent = true , desc = 'Find File'})
keymap("n", "<leader>fm", "<cmd>lua MiniFiles.open()<cr>", { noremap = true, silent = true , desc = 'Find Manualy'})
keymap("n", "<leader>fb", "<cmd>lua MiniPick.builtin.buffers()<cr>", { noremap = true, silent = true , desc = 'Find Buffer'})
keymap("n", "<leader>fs", "<cmd>lua MiniPick.builtin.grep_live()<cr>", { noremap = true, silent = true , desc = 'Find String'})
keymap("n", "<leader>fh", "<cmd>lua MiniPick.builtin.help()<cr>", { noremap = true, silent = true , desc = 'Find Help'})

keymap("n", "<leader>ss", "<cmd>lua MiniSessions.select()<cr>", { noremap = true, silent = true , desc = 'Switch Session'})

keymap("n", "<leader>bd", "<cmd>bd<cr>", { noremap = true, silent = true , desc = 'Close Buffer'})

keymap("n", "<leader>gg", "<cmd>terminal lazygit<cr>", { noremap = true, silent = true , desc = 'Lazygit'})
keymap("n", "<leader>gp", "<cmd>terminal git pull<cr>", { noremap = true, silent = true , desc = 'Git Push'})
keymap("n", "<leader>gs", "<cmd>terminal git push<cr>", { noremap = true, silent = true , desc = 'Git Pull'})
keymap("n", "<leader>ga", "<cmd>terminal git add .<cr>", { noremap = true, silent = true , desc = 'Git Add All'})
keymap("n", "<leader>gc", '<cmd>terminal git commit -m "Autocommit from MVIM"<cr>', { noremap = true, silent = true , desc = 'Git Autocommit'})

vim.filetype.add({
  filename = {
    ['inventory'] = 'dosini',
  }
})

vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
       vim.cmd("bdelete")
    end
})

require("lazy").setup({
    {
      "echasnovski/mini.nvim",
      version = false,
      config = function()
        require('mini.statusline').setup({
            -- We don't use an icon plugin
            use_icons = false
        })
        local animate = require('mini.animate')
        animate.setup {
            scroll = {
                -- Disable Scroll Animations, as the can interfer with mouse Scrolling
                enable = false,
            },
            cursor = {
                timing = animate.gen_timing.cubic({ duration = 50, unit = 'total' })
            },
        }
        require('mini.basics').setup({
          options = {
              extra_ui = true,
              win_borders = 'double',
          },
          mappings = {
              windows = true,
          }
        })
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
        require('mini.comment').setup()
        require('mini.completion').setup()
        require('mini.trailspace').setup()
        require('mini.fuzzy').setup()
        require('mini.clue').setup({
            triggers = {
            -- Leader triggers
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>'},
            -- Built-in completion
            { mode = 'i', keys = '<C-x>' },

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
                function() MiniClue.gen_clues.g() end,
                function() MiniClue.gen_clues.builtin_completion() end,
                function() MiniClue.gen_clues.marks() end,
                function() MiniClue.gen_clues.registers() end,
                function() MiniClue.gen_clues.windows() end,
                function() MiniClue.gen_clues.z() end,
            },
            window = {
                delay = 100
            }
        })
        require('mini.files').setup()
        require('mini.move').setup()
        require('mini.indentscope').setup({
          draw = {
              animation = function(s, n) return 5 end,
          },
          symbol = "│"
        })
        require('mini.pairs').setup()
        require('mini.pick').setup({
            mappings = {
                choose_in_vsplit  = '<C-CR>',
            },
            options = {
                use_cache = true
            },
            window = {
                config = win_config,
            }
        })
        require('mini.sessions').setup({
            autowrite = true
        })
        require('mini.starter').setup({
            header = "███╗   ███╗██╗   ██╗██╗███╗   ███╗\n████╗ ████║██║   ██║██║████╗ ████║\n██╔████╔██║██║   ██║██║██╔████╔██║\n██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║\n██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║\n╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝\n                                  "
        })
        require('mini.surround').setup()
        require('mini.tabline').setup()
      end
    },
})

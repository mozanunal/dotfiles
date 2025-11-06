local deps = require('mini.deps')
local add = deps.add

add({ source = 'catppuccin/nvim', name = 'catppuccin' })
-- add({ source = 'EdenEast/nightfox.nvim' })
-- add({ source = 'sainnhe/everforest' })

-- Core plugins
add({ source = 'neovim/nvim-lspconfig' })
add({ source = 'nvim-mini/mini.nvim' }) -- full mini library
add({ source = 'jamessan/vim-gnupg' })

-- Completion & snippets
add({
  source = 'saghen/blink.cmp',
  -- pin to a release tag
  checkout = 'v1.7.0',
  -- declare related deps so they’re present before blink loads
  depends = { 'rafamadriz/friendly-snippets' },
})
add({ source = 'rafamadriz/friendly-snippets' })

-- Extras
add({ source = 'folke/lazydev.nvim' })
add({ source = 'folke/snacks.nvim' })
add({ source = 'mozanunal/sllm.nvim' })

-- Treesitter (+ textobjects) with TSUpdate after checkout
add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master', -- or use a tag/commit for reproducibility
  monitor = 'main', -- track updates without switching checkout
  hooks = { post_checkout = function() pcall(vim.cmd, 'TSUpdate') end },
})
add({ source = 'nvim-treesitter/nvim-treesitter-textobjects', checkout = 'master' })

require('sllm').setup({ default_model = 'openrouter/openai/gpt5' })

require('catppuccin').setup({
  flavour = 'auto', -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = 'latte',
    dark = 'macchiato',
  },
  transparent_background = false, -- disables setting the background color.
  float = {
    transparent = true, -- enable transparent floating windows
    solid = false, -- use solid styling for floating windows, see |winborder|
  },
  show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive window
    shade = 'dark',
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  auto_integrations = true,
  integrations = {
    treesitter = true,
    mini = {
      enabled = true,
      indentscope_color = '',
    },
  },
})
vim.cmd('color catppuccin')

require('blink.cmp').setup({
  keymap = { preset = 'enter' },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono',
  },
  cmdline = { enabled = false },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  signature = { enabled = true },
})

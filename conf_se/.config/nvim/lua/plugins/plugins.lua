return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
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
    end,
  },
  { 'EdenEast/nightfox.nvim' },
  { 'jamessan/vim-gnupg' },
  { 'SWiegandt/python-utils.nvim' },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'neovim/nvim-lspconfig' },
  {
    'mozanunal/sllm.nvim',
    config = function() require('sllm').setup({ default_model = 'openrouter/google/gemini-2.5-pro-preview' }) end,
  },
}

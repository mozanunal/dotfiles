return {}
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',

  opts = {
    auto_install = true,

    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'go',
      'html',
      'javascript',
      'jinja',
      'jinja_inline',
      'jsx',
      'lua',
      'python',
      'rust',
      'scala',
      'sql',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    },

    -- other features
    highlight = { enable = true },
    indent = { enable = true },
    sync_install = true,
  },

  config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
}

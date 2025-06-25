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
      'diff',
      'go',
      'gotmpl',
      'html',
      'javascript',
      'jinja',
      'jinja_inline',
      'latex',
      'lua',
      'mermaid',
      'nix',
      'python',
      'rust',
      'scala',
      'sql',
      'tera',
      'terraform',
      'typescript',
      'vim',
      'vimdoc',
      'vimdoc',
      'yaml',
    },

    -- other features
    highlight = { enable = true },
    indent = { enable = true },
    sync_install = true,
  },

  config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
}

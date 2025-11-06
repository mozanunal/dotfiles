local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

configs.setup({
  auto_install = true,
  sync_install = true,

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
    'yaml',
  },

  highlight = { enable = true },
  indent = { enable = true },
})

return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
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
  },
  opts_extend = { 'sources.default' },
}

vim.diagnostic.config({
  virtual_text = { current_line = true, virt_text_pos = "right_align" },
  virtual_lines = false,
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

vim.lsp.enable({ 'terraformls', 'lua_ls', 'gopls', 'pyright', 'ruff', 'rust_analyzer', 'html', 'deno' })
